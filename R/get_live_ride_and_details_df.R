#' Get Live Rides and Details
#'
#' This function returns a data frame with all current live rides as well as the joined ride and instructor data for each ride.
#' @keywords Peloton, ride, live, details, instructors, DataFrame
#' @export
#' @examples
#' get_live_ride_and_details_df()


get_live_ride_and_details_df <- function() {

  #some setup
  "." <- NULL
  `%>%` <- magrittr::`%>%`

  #Get live rides via API
  request <- httr::GET("https://api.onepeloton.com/api/v3/ride/live")
  live_rides_df <-  data.table::as.data.table(jsonlite::fromJSON(rawToChar(request$content))$data)


  #remove duplicates based on start time
  live_rides_df <- live_rides_df[order(live_rides_df$ride_id, -abs(live_rides_df$start_time) ), ]
  live_rides_df <- live_rides_df[ !duplicated(live_rides_df$ride_id), ]
  nrow <-nrow(live_rides_df)
  options(stringsAsFactors=FALSE)

  #generate the ride info data frame
  n <-which(colnames(live_rides_df)=="ride_id")
  ride_info_df <- get_basic_ride_info_df(live_rides_df[1, n])

   for(i in 2:nrow) {
     add_data <- pelotonR::get_basic_ride_info_df(live_rides_df[i,n])
    ride_info_df <- dplyr::union_all(ride_info_df, add_data)
   }

   #join the ride info data frame
   live_ride_and_details <- dplyr::left_join(live_rides_df, ride_info_df,by = c("ride_id" = "id"))

   #generate and join the instructor data frame
   instructor_data <- pelotonR::get_instructors_df() %>%
   stats::setNames(paste0('instructor.', names(.)))
   live_ride_and_details <- dplyr::left_join(live_ride_and_details,instructor_data,by = c("instructor_id" = "instructor.id"))

  return(live_ride_and_details)

}
