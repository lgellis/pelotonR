#' Get Current Peloton Live Rides
#'
#' This function returns a data frame with all of the current live rides.
#' @keywords Peloton, live, ride, DataFrame
#' @export
#' @examples
#' get_live_rides_df()

get_live_rides_df <- function() {

  #Gather info via API
  request <- httr::GET("https://api.onepeloton.com/api/v3/ride/live")
  live_rides_df <-  data.table::as.data.table(jsonlite::fromJSON(rawToChar(request$content))$data)
  return(live_rides_df)
}

