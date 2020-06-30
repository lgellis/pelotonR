#' Get Workout Stats Data Frame
#'
#' This function will gather the workout counts by category for the current authenticated user. 

#' @keywords peloton, authenticated, workout, stats, DataFrame
#' @export
#' @examples
#' get_my_workout_stats_df()
#'
get_my_workout_stats_df <- function() {
  
  #Gather stats info via API
  request  <- httr::GET("https://api.onepeloton.com/api/me")
  my_workout_stats_df <-  jsonlite::fromJSON(rawToChar(request$content))$workout_counts
  return(my_workout_stats_df)
}
