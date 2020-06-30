#' Get Metadata Mapping For Peloton Categories
#'
#' This function returns a data frame of metadata available on Peloton for a particular category type.
#' @param type The type of metadata to pull. Available data types include: 'instructors', 'class_types', 'equipment', 'fitness_disciplines', device_type_display_names', 'content_focus_labels',
# 'difficulty_levels', 'locales'.
#' @keywords Peloton, metadata, DataFrame
#' @export
#' @examples
#' get_metadata_mapping_df("fitness_disciplines")
#' get_metadata_mapping_df("equipment")
get_metadata_mapping_df <- function(type) {

  # Some housekeeping
  `%>%` <- magrittr::`%>%`

  # Gather info via API
  request <- httr::GET("https://api.onepeloton.com/api/ride/metadata_mappings")

  # Select the metadata mapping type of interest.  Format the results
  metadata_df <- jsonlite::fromJSON(rawToChar(request$content))
  metadata_df <- data.table::as.data.table(metadata_df[type]) %>%
    tibble::add_column(meta_type = paste0(type))
  return(metadata_df)
}
