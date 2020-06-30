#' Get Workout and Instructor Details in a DataFrame
#'
#' This function will gather all individual workouts and all related instructor data for a user and 
#' return it in a data frame. If a user id is not passed into the function, it will return the current users workouts.
#' @param user_id Your Peloton user id.
#' @keywords Peloton, authenticated, workouts, instructors, DataFrame
#' @export
#' @examples
#' get_workouts_and_instructors_df()
#'

get_workouts_and_instructors_df<- function(user_id) {
  
  #If user id is missing, select the current users id
  if(missing(user_id)){
    request  <- httr::GET("https://api.onepeloton.com/api/me")
    user_id <-  jsonlite::fromJSON(rawToChar(request$content))$id
  }
  
  #Some variable housekeeping
  "." <- NULL
  instructor.id <- NULL
  workout.peloton.ride.instructor_id <- NULL
  `%>%` <- magrittr::`%>%`
  
  #Get workout data and format
  workouts_df <- get_workouts_df(user_id) %>% 
    stats::setNames(paste0('workout.', names(.))) %>% 
    dplyr::rename(instructor_id = workout.peloton.ride.instructor_id)
  
  #Get instructor data and format 
  instructors_df <- get_instructors_df() %>% 
    stats::setNames(paste0('instructor.', names(.))) %>% 
    dplyr::rename(instructor_id = instructor.id) 
  
  #Join workout and instructor data
  workouts_and_instructor_df <- dplyr::left_join(workouts_df,instructors_df,by="instructor_id")
  
  return(workouts_and_instructor_df)
}
