connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"

# datagroup: pat_thesis_default_datagroup {
#   # sql_trigger: SELECT MAX(id) FROM etl_log;;
#   max_cache_age: "24 hour"
# }
#
# persist_with: pat_thesis_default_datagroup




#============================= EXPLORES =============================

# explore: the_whole_shabang {
#   from: user_playlists
#   join: track_features {
#     relationship: one_to_many
#     sql_on: ${the_whole_shabang.user_id} = ${track_features.id}  ;;
#   }
# }

# explore: explore_view_oldname {
#   from: view_newname

# }

explore: user_playlists_2 {
  join: track_features_2 {
    # type: FULL OUTER???
    relationship: one_to_many
    sql_on: ${user_playlists_2.track_id} = ${track_features_2.id} ;;
  }

  # conditionally_filter: {
  #   filters: {
  #     field: artist_name
  #     value: "1UP"
  #   }


#   join: track_features_3 {
#     sql: RIGHT JOIN pat_thesis.track_features_5 AS track_features_3
#     on ${user_playlists_2.track_id} = track_features_3.id ;;
#   }
}


# explore: fruits_logs {
#   join: fruit_consumer_1 {
#     relationship: one_to_many
#     sql_on: ${fruits_logs.id} = ${fruit_consumer.fruit_id} ;;
#   }
#   join: fruit_consumer_2 {
#     sql: RIGHT JOIN schemaname.tablename AS fruit_consumer_2
#       on ${fruits_logs.id} = fruit_consumer_2.fruit_id ;;
#   }
# }





view: fruit_consumer_2 {
  sql_table_name: pat_thesis.track_features_5 ;;
}

explore: track_features_2 {}
