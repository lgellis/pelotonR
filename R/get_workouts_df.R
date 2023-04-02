#' Get Workout Details in a DataFrame
#'
#' This function will gather all individual workouts for a specified user and return the results in a data frame.
#' If a user id is not passed into the function, it will return the current users workouts.
#' @param user_id Peloton user id.
#' @keywords Peloton, authenticated, workouts, DataFrame
#' @export
#' @examples
#' get_workouts_df()
get_workouts_df <- function(user_id) {

  # If user id is missing, select the current users id
  if (missing(user_id)) {
    request <- httr::GET("https://api.onepeloton.com/api/me")
    user_id <- jsonlite::fromJSON(rawToChar(request$content))$id
  }

  # Call the API to gather user ride totals
  call <- paste0("https://api.onepeloton.com/api/user/", user_id, "/workouts?page=0", "&joins=peloton.ride")
  request <- httr::GET(call)
  workout_df <- data.table::as.data.table(jsonlite::fromJSON(rawToChar(request$content))$data)

  # Error handling if the user_id does not return results
  if (nrow(workout_df) == 0) {
    stop("PelotonR: Cannot gather workout details for specified user_id")
  }

  # Gather the first page of ride data
  total_pages <- jsonlite::fromJSON(rawToChar(request$content))$page_count
  total_pages <- total_pages - 1

  # Iterate through the remaining pages and union the tables
  for (i in 1:total_pages) {
    call <- paste0("https://api.onepeloton.com/api/user/", user_id, "/workouts?page=", i, "&joins=peloton.ride")
    request <- httr::GET(call)
    add_data <- data.table::as.data.table(jsonlite::fromJSON(rawToChar(request$content))$data)
    workout_df <- rbind(workout_df, add_data, fill=TRUE)
  }

  # Perform some formatting
  workout_df$start_timestamp <- lubridate::as_datetime(workout_df$start_time)
  workout_df$start_date <- lubridate::as_date(workout_df$start_timestamp)
  workout_df$start_month <- lubridate::floor_date(workout_df$start_date, "month")
  return(workout_df)
}
