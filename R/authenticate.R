#' Authenticate with the Peloton API
#'
#' This function allows you to authenticate with the Peloton API to pull your details and workout stats.  
#' In this function you are able to pass in your `username` and `password`.  If you pass in no value, 
#' the system will prompt you for a user name and password.
#' @param username Your Peloton screen name.
#' @param password Your Peloton password.
#' @keywords peloton, authenticate
#' @export
#' @examples
#' authenticate()
#' authenticate("example user name", "example password")

authenticate <- function(username, password) {
  
  if(missing(username)){
    username <- getPass::getPass(msg="pelotonR: Please enter your Peloton user name")
  }
  if(missing(password)){
    password <- getPass::getPass(msg="pelotonR: Please enter your Peloton password")
  }
  
  body <- paste0("{\"username_or_email\":\"", username, "\",\"password\":\"", password, "\"}")
  request  <- httr::POST("https://api.onepeloton.com/auth/login", body=body)
  results <- jsonlite::prettify(rawToChar(request$content))
  return(results)
  
}
