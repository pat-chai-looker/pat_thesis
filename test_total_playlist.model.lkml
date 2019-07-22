connection: "lookerdata_publicdata_standard_sql"

view: total_playlists {
  derived_table: {
    sql: SELECT count(*) as count
      FROM `lookerdata.pat_thesis.user_playlists_2`
       ;;
  }
  dimension: count {
    type: number
    sql: ${TABLE}.count ;;
    view_label: "Order Purchase Affinity"
    label: "Total Order Count"
  }
}

explore: total_playlists {}
