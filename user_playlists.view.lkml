view: user_playlists {
  sql_table_name: pat_thesis.user_playlists ;;

  dimension: user_id {
    description: "owner of playlist"
    type: string
    sql: ${TABLE}.string_field_1 ;;
#     sql: ${TABLE}.user ;;
  }

  dimension: playlist_id {
    type: string
    sql: ${TABLE}.string_field_2 ;;
#     sql: ${TABLE}.playlist_id ;;
  }

  dimension: track_id {
    type: string
    sql: ${TABLE}.string_field_3 ;;
#     sql: ${TABLE}.track_id ;;
    primary_key: yes #unsure if this would cause some issues
  }

#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }

  measure: count {
    type: count
  }
}
