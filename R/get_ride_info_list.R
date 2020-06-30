#' Get Full Set of Ride Information In a List
#'
#' This function returns a list with all information related to a particular ride.
#' @param ride_id The id of the ride that you are pulling information for.
#' @keywords Peloton, ride, list
#' @export
#' @examples
#' get_ride_info_list('55214456a1984c5885a087021e3f67b7')

get_ride_info_list <- function(ride_id) {
  
  #Gather ride info via API
  request <- httr::GET(paste0("https://api.onepeloton.com/api/ride/", ride_id, "/details?stream_source=multichannel"))
  ride <-  jsonlite::fromJSON(rawToChar(request$content))$ride
  return(ride)
}
