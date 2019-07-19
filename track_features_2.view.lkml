view: track_features_2 {
sql_table_name: pat_thesis.track_features_2 ;;



#============================================= dimensions =============================================

  # dimension: artistPopularity {
  #   type: number
  #   sql: ${TABLE}.artistPopularity ;;
  # }

  dimension: duration_ms {
    type: number
    sql: ${TABLE}.duration_ms ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
    primary_key: yes
  }

  dimension: key {
    type: number
    sql: ${TABLE}.key ;;
  }

  dimension: hierarchy_test {
    type: number
    sql: ${TABLE}.key ;;
    html: {% if value == 0 %} "low"
          {% elsif value == 1 %} "medium"
          {% elsif value == 2 %} "high"
          {% endif %}
    ;;
  }

  dimension: key_letters {
    type: string
    sql: ${TABLE}.key_letters ;;
  }

  dimension: mode {
    type: number
    sql: ${TABLE}.mode ;;
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


  #==================================== metrics

  dimension: acousticness {
    type: number
    sql: ${TABLE}.acousticness ;;
    group_label: "Metrics"
  }

  dimension: danceability {
    type: number
    sql: ${TABLE}.danceability ;;
    group_label: "Metrics"
  }

  dimension: energy {
    type: number
    sql: CASE WHEN ${TABLE}.energy > 0.5 THEN 100
    ELSE 200 END;;
    group_label: "Metrics"
#     value_format: "0.#"
  }

  measure: division {
    type:  number
    sql: ${energy} / ${key} ;;
  }


  dimension: instrumentalness {
    type: number
    sql: ${TABLE}.instrumentalness ;;
    group_label: "Metrics"
  }

  dimension: liveness {
    type: number
    sql: ${TABLE}.liveness ;;
    group_label: "Metrics"
  }

  dimension: loudness {
    type: number
    sql: ${TABLE}.loudness ;;
    group_label: "Metrics"
  }

  dimension: speechiness {
    type: number
    sql: ${TABLE}.speechiness ;;
    group_label: "Metrics"
  }

  #==================================== links

  dimension: analysis_url {
    hidden: yes
    type: string
#     sql: ${TABLE}.analysis_url ;;
  }

  dimension: track_href {
    hidden: yes
    type: string
    sql: ${TABLE}.track_href ;;
  }

#============================================= measures =============================================

  measure: avg_track_popularity {
    type: average
    sql: ${trackPopularity} ;;
    value_format_name: decimal_2
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
    value_format: "0.#####"
  }

  measure: avg_instrumentalness {
    type: average
    sql: ${instrumentalness} ;;
  }

  measure: avg_speechiness {
    type: average
    sql: ${speechiness} ;;
  }

  measure: avg_track_duration {
    type: average
    sql: ${duration_ms} ;;
    value_format_name: decimal_2
  }


  measure: count {
    type: count
  }




}
