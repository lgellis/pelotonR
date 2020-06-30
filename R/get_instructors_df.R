#' Get Data Frame with Instructors
#'
#' This function returns a data frame with all instructor information.
#' @keywords Peloton, instructors, DataFrame
#' @export
#' @examples
#' get_instructors_df()
get_instructors_df <- function() {

  # Some housekeeping
  `%>%` <- magrittr::`%>%`

  # Get total pages
  request <- httr::GET("https://api.onepeloton.com/api/instructor")
  total_pages <- jsonlite::fromJSON(rawToChar(request$content))$page_count
  total_pages <- total_pages - 1

  # Get first page and table structure
  call <- paste0("https://api.onepeloton.com/api/instructor?page=0")
  request <- httr::GET(call)
  instructor_df <- data.table::as.data.table(jsonlite::fromJSON(rawToChar(request$content))$data)

  # Iterate through the remaining pages and union the tables
  for (i in 1:total_pages) {
    call <- paste0("https://api.onepeloton.com/api/instructor?page=", i)
    request <- httr::GET(call)
    add_data <- data.table::as.data.table(jsonlite::fromJSON(rawToChar(request$content))$data)
    instructor_df <- dplyr::union_all(instructor_df, add_data)
  }
  return(instructor_df)
}
