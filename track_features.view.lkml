view: track_features {
sql_table_name: pat_thesis.track_features ;;



#============================================= dimensions =============================================

  dimension: acousticness {
    type: number
    sql: ${TABLE}.acousticness ;;
  }

  dimension: analysis_url {
    type: string
#     sql: ${TABLE}.analysis_url ;;
  }

  dimension: artistPopularity {
    type: number
    sql: ${TABLE}.artistPopularity ;;
  }

  dimension: danceability {
    type: number
    sql: ${TABLE}.danceability ;;
  }

  dimension: duration_ms {
    type: number
    sql: ${TABLE}.duration_ms ;;
  }

  dimension: energy {
    type: number
    sql: ${TABLE}.energy ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: instrumentalness {
    type: number
    sql: ${TABLE}.instrumentalness ;;
  }

  dimension: key {
    type: number
    sql: ${TABLE}.key ;;
  }

  dimension: liveness {
    type: number
    sql: ${TABLE}.liveness ;;
  }

  dimension: loudness {
    type: number
    sql: ${TABLE}.loudness ;;
  }

  dimension: mode {
    type: number
    sql: ${TABLE}.mode ;;
  }

  dimension: speechiness {
    type: number
    sql: ${TABLE}.speechiness ;;
  }

  dimension: tempo {
    type: number
    sql: ${TABLE}.tempo ;;
  }

  dimension: time_signature {
    type: number
    sql: ${TABLE}.time_signature ;;
  }

  dimension: trackPopularity {
    type: number
    sql: ${TABLE}.trackPopularity ;;
  }

  dimension: track_href {
    type: string
    sql: ${TABLE}.track_href ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: uri {
    type: string
    sql: ${TABLE}.uri ;;
  }

  dimension: valence {
    type: number
    sql: ${TABLE}.valence ;;
  }


#============================================= measures =============================================

  measure: avg_track_popularity {
    type: average
    sql: ${trackPopularity} ;;
  }

  measure: avg_acousticness {
    type: average
    sql: ${acousticness} ;;
  }

  measure: avg_danceability {
    type: average
    sql: ${danceability} ;;
  }

  measure: avg_energy {
    type: average
    sql: ${energy} ;;
  }

  measure: avg_instrumentalness {
    type: average
    sql: ${instrumentalness} ;;
  }

  measure: avg_speechiness {
    type: average
    sql: ${speechiness} ;;
  }

  measure: count {
    type: count
  }




}
