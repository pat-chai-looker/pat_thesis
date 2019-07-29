
connection: "lookerdata_publicdata_standard_sql"
# include all views in this project
include: "*.view"

# include all dashboards in this project
# include: "*.dashboard"

explore: track_affinity {
  join: total_playlists {
    type: cross
    relationship: many_to_one
  }

  # join: user_playlists_2 {
  #   sql_on: ${track_affinity.product_a} = ${user_playlists_2.track_name} ;;
  #   fields: [user_playlists_2.album_art]
  # }
  # join: user_playlists_2 {
  #   sql_on: ${track_affinity.product_b} = ${user_playlists_2.track_name} ;;
  #   fields: [user_playlists_2.album_art]
  # }
}











#============================VIEWS

view: playlist_track {
  derived_table: {
    persist_for: "24 hours"
    sql: SELECT
        playlist_id --as order_id
      , track_id --as order_item_id
      , date_track_added
      --, oi.inventory_item_id as inventory_item_id
      , track_name --as product
      , album_art
      , preview_url
      FROM `lookerdata.pat_thesis.user_playlists_4`
      GROUP BY 1, 4, 3, 2, 5, 6
      ;;
  }
}

view: total_track_counts {
  derived_table: {
    persist_for: "24 hours"
    sql: SELECT
      track_name
      , concat(track_name, playlist_id) as concat_trackname_playlistid
      , count( concat(track_name, playlist_id)) as track_added_count
      FROM `lookerdata.pat_thesis.user_playlists_4`
      GROUP BY 1, 2
      ;;
  }
}

view: total_playlists {
  derived_table: {
    sql: SELECT count(*) as count
      FROM `lookerdata.pat_thesis.user_playlists_4`
      ;;
  }
  dimension: count {
    type: number
    sql: ${TABLE}.count ;;
    view_label: "Order Purchase Affinity"
    label: "Total Order Count"
  }
}

view: track_affinity {
  derived_table: {
    #    persist_for: 24 hours
    sql: SELECT product_a
      , product_b
      , product_a_album_art
      , product_b_album_art
      , preview_url
      , joint_order_count       -- number of times both items are purchased together
      , top1.track_added_count as product_a_order_count   -- total number of orders with product A in them
      , top2.track_added_count as product_b_order_count   -- total number of orders with product B in them
      FROM (
        SELECT op1.track_name as product_a
        , op2.track_name as product_b
        , op1.album_art as product_a_album_art
        , op2.album_art as product_b_album_art
        , op2.preview_url as preview_url
        , count(*) as joint_order_count
        FROM ${playlist_track.SQL_TABLE_NAME} as op1
        JOIN ${playlist_track.SQL_TABLE_NAME} op2
        ON op1.playlist_id = op2.playlist_id
        AND op1.track_id <> op2.track_id
        GROUP BY product_a, product_b, 3, 4, 5
      ) as prop
      JOIN ${total_track_counts.SQL_TABLE_NAME} as top1 ON prop.product_a = top1.track_name
      JOIN ${total_track_counts.SQL_TABLE_NAME} as top2 ON prop.product_b = top2.track_name
      ORDER BY product_a, joint_order_count DESC, product_b
      ;;
  }

#   filter: affinity_timeframe {
#     type: date
#   }
  dimension: album_art_a {
    type: string
    sql: ${TABLE}.product_a_album_art ;;
    html: <img src={{value}} width="160" height="160"/> ;;
  }

  dimension: album_art_b {
    type: string
    sql: ${TABLE}.product_b_album_art ;;
    html: <img src={{value}} width="160" height="160"/> ;;
  }

  dimension: preview_url {
    type: string
    sql: ${TABLE}.preview_url ;;
#     link: {
#       label: "Sample Track"
#       url: "{{value}}"
#     }
  }

  dimension: product_a {
    type: string
    sql: ${TABLE}.product_a ;;
  }

  dimension: product_b {
    type: string
    sql: ${TABLE}.product_b ;;
    html: <a href=${preview_url}> Sample </a> ;;
  }

  dimension: joint_order_count {
    description: "How many times item A and B were purchased in the same order"
    type: number
    sql: ${TABLE}.joint_order_count ;;
    value_format: "#"
  }

  dimension: product_a_order_count {
    description: "Total number of orders with product A in them, during specified timeframe"
    type: number
    sql: ${TABLE}.product_a_order_count ;;
    value_format: "#"
  }

  dimension: product_b_order_count {
    description: "Total number of orders with product B in them, during specified timeframe"
    type: number
    sql: ${TABLE}.product_b_order_count ;;
    value_format: "#"
  }

  #  Frequencies
  dimension: product_a_order_frequency {
    description: "How frequently orders include product A as a percent of total orders"
    type: number
    sql: 1.0*${product_a_order_count}/${total_playlists.count} ;;
    value_format: "#.00%"
  }

  dimension: product_b_order_frequency {
    description: "How frequently orders include product B as a percent of total orders"
    type: number
    sql: 1.0*${product_b_order_count}/${total_playlists.count} ;;
    value_format: "#.00%"
  }

  dimension: joint_order_frequency {
    description: "How frequently orders include both product A and B as a percent of total orders"
    type: number
    sql: 1.0*${joint_order_count}/${total_playlists.count} ;;
#     html: <font color="#000000 " size="16" weight="bold"> {{rendered_value}} </font> ;;
    value_format: "#.00%"
  }

  # Affinity Metrics

  dimension: add_on_frequency {
    description: "How many times both Products are purchased when Product A is purchased"
    type: number
    sql: 1.0*${joint_order_count}/${product_a_order_count} ;;
    value_format: "#.00%"
  }

  dimension: lift {
    description: "The likelihood that buying product A drove the purchase of product B"
    type: number
    sql: ${joint_order_frequency}/(${product_a_order_frequency} * ${product_b_order_frequency}) ;;
    value_format: "#,##0.#0"
  }

  ## Do not display unless users have a solid understanding of  statistics and probability models
  dimension: jaccard_similarity {
    description: "The probability both items would be purchased together, should be considered in relation to total order count, the highest score being 1"
    type: number
    sql: 1.0*${joint_order_count}/(${product_a_order_count} + ${product_b_order_count} - ${joint_order_count}) ;;
    value_format: "0.00"
  }

  # Aggregate Measures - ONLY TO BE USED WHEN FILTERING ON AN AGGREGATE DIMENSION (E.G. BRAND_A, CATEGORY_A)

  measure: aggregated_joint_order_count {
    description: "Only use when filtering on a rollup of product items, such as brand_a or category_a"
    type: sum
    sql: ${joint_order_count} ;;
  }
}
