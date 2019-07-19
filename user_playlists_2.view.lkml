view: user_playlists_2 {
  sql_table_name: pat_thesis.user_playlists_2 ;;

  dimension: user_id {
    description: "owner of playlist"
    type: string
    sql: ${TABLE}.user_id ;;
  }

  dimension: user_name {
    type: string
    sql: ${TABLE}.user_name ;;
  }

  dimension: playlist_name {
    type: string
    sql: ${TABLE}.playlist_name ;;
  }

  dimension: playlist_image {
    type: string
    sql: ${TABLE}.playlist_image ;;
    html: <img src={{value}} width="250" height="250"/> ;;
  }

  dimension: playlist_id {
    type: string
    sql: ${TABLE}.playlist_id ;;
  }

  dimension: track_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.track_id ;;
  }

  dimension: track_name {
    type: string
    sql: ${TABLE}.track_name ;;
  }

  dimension: track_popularity {
    type: number
    sql: ${TABLE}.track_popularity ;;
  }

  dimension: artist_name {
    type: string
    sql: ${TABLE}.artist_name ;;
  }

  dimension: artist_popularity {
    type: number
    sql: ${TABLE}.artist_popularity ;;
  }

  dimension: album_name {
    type: string
    sql: ${TABLE}.album_name ;;
  }

  dimension: album_art {
    type: string
    sql: ${TABLE}.album_art ;;
    html: <img src={{value}} width="128" height="128"/> ;;
  }

  dimension_group: date_track_added {
    type: time
    timeframes: [date, year, month]
    sql: ${TABLE}.date_track_added  ;;
    datatype: timestamp
  }



#============================================= not from db =======


  dimension: artist_tiers {
    type: tier
    tiers: [25,50,75]
    style: integer
    sql: ${artist_popularity} ;;
  }


  measure: avg_track_popularity {
    type: average
    sql: ${track_popularity} ;;
    value_format_name: decimal_2
  }



  measure: single_viz_conditional {
    type: average
    sql: ${track_popularity} ;;
    value_format_name: decimal_2
    html:  {% if value < 50 %} <font color="darkgreen">{{ rendered_value }}</font>
          {% else %}
            <font color="darkred">{{ rendered_value }}</font>
          {% endif %} ;;
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
