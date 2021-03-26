#' Add school to the database
#'
#' This function adds schools to the database for use in conjunction with the WOW app at BEEF2021
#' @name get_school
#' @param username 
#' @param password 
#' @return nothing
#' @author Anita Chang \email{a.chang@@cqu.edu.au}
#' @import mongolite
#' @import keyring
#' @export


get_school <- function(username=NULL, password=NULL){

  if(is.null(username)||is.null(password)){
    username = keyring::key_list("DMMongoDB")[1,2]
    password =  keyring::key_get("DMMongoDB", username)
  }

    pass <- sprintf("mongodb://%s:%s@datamuster-shard-00-00-8mplm.mongodb.net:27017,datamuster-shard-00-01-8mplm.mongodb.net:27017,datamuster-shard-00-02-8mplm.mongodb.net:27017/test?ssl=true&replicaSet=DataMuster-shard-0&authSource=admin", username, password)
    db <- mongolite::mongo(collection = "Schools", db = "BEEF2021", url = pass, verbose = T)
    
    db$find()
}