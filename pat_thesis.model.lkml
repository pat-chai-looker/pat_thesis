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


explore: user_playlists {
  join: track_features {
    relationship: one_to_many
    sql_on: ${user_playlists.track_id} = ${track_features.id} ;;
  }
}

explore: track_features {}
