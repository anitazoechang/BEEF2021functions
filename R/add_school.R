#' Add school to the database
#'
#' This function adds schools to the database for use in conjunction with the WOW app at BEEF2021
#' @name add_school
#' @param school the school's name
#' @param class the class
#' @param lat the latitude of the school
#' @param long the longitude of the school
#' @param weight a weight for the school
#' @param username 
#' @param password 
#' @return nothing
#' @author Anita Chang \email{a.chang@@cqu.edu.au}
#' @import mongolite
#' @import keyring
#' @export


add_school <- function(school, class = NULL, lat, long, weight, username=NULL, password=NULL){

  if(is.null(username)||is.null(password)){
    username = keyring::key_list("DMMongoDB")[1,2]
    password =  keyring::key_get("DMMongoDB", username)
  }

    pass <- sprintf("mongodb://%s:%s@datamuster-shard-00-00-8mplm.mongodb.net:27017,datamuster-shard-00-01-8mplm.mongodb.net:27017,datamuster-shard-00-02-8mplm.mongodb.net:27017/test?ssl=true&replicaSet=DataMuster-shard-0&authSource=admin", username, password)
    db <- mongolite::mongo(collection = "Schools", db = "BEEF2021", url = pass, verbose = T)

    if(is.null(class)){class = NA}
    data <- sprintf('{"school":"%s", "class":"%s", "latitude":%s, "longitude":%s, "weight":%s}',
                    school, class, lat, long, weight)
    
    db$insert(data)
}