view: user_playlists_2 {
  sql_table_name: pat_thesis.user_playlists_4 ;;

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
    html: https://productday.dev.looker.com/dashboards/381?Track%20Name=...Baby%20One%20More%20Time&filter_config=%7B%22Track%20Name%22:%5B%7B%22type%22:%22%3D%22,%22values%22:%5B%7B%22constant%22:%22...Baby%20One%20More%20Time%22%7D,%7B%7D%5D,%22id%22:33%7D%5D%7D ;;
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
    html: <img src={{value}} width="200" height="200"/> ;;
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


  dimension: track_name_artist_name {
    type: string
    sql: CONCAT(${track_name}, " by ", ${artist_name}) ;;
  }


#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }

  measure: count {
    type: count
    drill_fields: [track_name, track_popularity, artist_name, album_name]
  }
}
