#' Get Full User Stats In a List
#'
#' This function will gather all stats for the current authenticated user and return the results in a list.
#' @keywords Peloton, authenticated, stats, list
#' @export
#' @examples
#' get_my_stats_list()
#'
get_my_stats_list <- function() {
  
  #Gather stats info via API
  request  <- httr::GET("https://api.onepeloton.com/api/me")
  my_personal_stats_df <-  jsonlite::fromJSON(rawToChar(request$content))
  return(my_personal_stats_df)
}
