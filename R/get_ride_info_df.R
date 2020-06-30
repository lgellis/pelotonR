#' Get DataFrame with a Subset of Ride Information
#'
#' This function returns a data frame with a subset of information related to a particular ride.
#' @param ride_id The id of the ride that you are pulling information for.
#' @keywords Peloton, ride, DataFrame
#' @export
#' @examples
#' get_basic_ride_info_df('55214456a1984c5885a087021e3f67b7')

get_basic_ride_info_df <- function(ride_id) {
  
  #Gather ride info via API
  request <- httr::GET(paste0("https://api.onepeloton.com/api/ride/", ride_id, "/details?stream_source=multichannel"))
  ride <-  jsonlite::fromJSON(rawToChar(request$content))$ride
  
  #Collect only the core ride information for our DataFrame
  ride_info_df <- data.frame(id = ride$id,
                             description= ride$description,
                             difficulty_estimate = ride$difficulty_estimate,
                             difficulty_rating_avg = ride$difficulty_rating_avg,
                             difficulty_rating_count = ride$difficulty_rating_count,
                             instructor_id = ride$instructor_id,
                             length = ride$length,
                             location = ride$location,
                             overall_rating_avg = ride$difficulty_estimate,
                             overall_rating_count = ride$overall_rating_count,
                             is_explicit = ride$is_explicit,
                             is_closed_caption_shown = ride$is_closed_caption_shown,
                             total_workouts = ride$total_workouts )
  return(ride_info_df)
}
