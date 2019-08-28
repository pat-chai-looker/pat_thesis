view: user_playlists_2 {
  sql_table_name: pat_thesis.user_playlists_5 ;;

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
    link: {
      label: "Go to Dashboard"
      url: "https://productday.dev.looker.com/dashboards/349?Playlist%20Name={{value}}"
    }
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

  dimension: preview_url {
    type: string
    sql: ${TABLE}.preview_url ;;
    html: <a href="{{value}}">Sample Track</a> ;;
  }

  dimension: track_name {
    type: string
    sql: ${TABLE}.track_name ;;
    link: {
      label: "Listen on Spotify"
      url: "https://open.spotify.com/tracks/{{user_playlists_2.track_id}}"
      icon_url: "https://storage.cloud.google.com/lookerdata-thesis/pat_thesis/733573.svg"
    }
    link: {
      label: "Search in YouTube"
      url: "https://www.youtube.com/results?search_query={{user_playlists_2.track_name}}+{{user_playlists_2.artist_name}}"
      icon_url: "https://storage.cloud.google.com/lookerdata-thesis/pat_thesis/733590.svg"
    }
    link: {
      label: "Filter in Dashboard"
      url: "https://productday.dev.looker.com/dashboards/381?Track%20Name={{user_playlists_2.track_name}}&Artist%20Name={{user_playlists_2.artist_name}}"
#       icon_url: "https://storage.cloud.google.com/lookerdata-thesis/pat_thesis/733590.svg"
    }
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
    timeframes: [date, year, month, week]
    sql: ${TABLE}.date_track_added  ;;
    datatype: timestamp
  }

  dimension: week_end {
    type: date
    sql: ${date_track_added_week} ;;
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
    link: {
      label: "link label {{_filters['user_playlists_2.playlist_name']}}"
      url: "https://productday.dev.looker.com/explore/pat_thesis/user_playlists_2?fields={{_field._name}},user_playlists_2.artist_name&f[user_playlists_2.playlist_name]=&sorts=user_playlists_2.avg_track_popularity+desc&limit=500&query_timezone=America%2FLos_Angeles&vis=%7B%7D&filter_config=%7B%22{{_filters['user_playlists_2.playlist_name']}}%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%7D%5D%7D&origin=share-expanded"
    }
  }
}
