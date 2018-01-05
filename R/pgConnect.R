#' Connect to a postgreSQL database going through the appropriate authorization procedure
#' @export
#' @title Create a connection to a postgreSQL database
#' @name pgConnect
#' @param dbname name
#' @param host host
#' @param port port
#' @param user user
#' @param password password
#' @return An object of class 'pgConnect'. This object is used to direct commands to the database engine.
#' @author Bruno Silva

pgConnect <- function(dbname,
                      host = 'localhost',
                      port = '5432',
                      user = NULL,
                      password = NULL) 
{ 
  ## Testar a ligacao postgres
  args <- 
    list(drv = RPostgreSQL::PostgreSQL(), dbname = dbname, host = host, port = port, user = user, password = password) %>%
    .[unlist(lapply(., length) != 0)] # Eliminate NULL components from args list
  try(connect <- do.call(RPostgreSQL::dbConnect, args),
      silent = TRUE)
  # Verificar a validade da conexao postgres
  if (!exists('connect')) 
    stop('Could not establish connection with the database.',
         call. = FALSE)
  ## Testar a ligacao postgis
  if(is.null(user)) {
    dns <- sprintf("PG: dbname=%s host=%s port=%s", args$dbname, args$host, args$port)
  } else {
    dns <- sprintf("PG: dbname=%s host=%s port=%s user=%s password=%s", args$dbname, args$host, args$port, args$user, args$password)
  }
  try(test <- rgdal::ogrListLayers(dns),
      silent = TRUE)
  # Verificar a validade da conexao postgres
  if (!exists('test')) 
    stop('Could not establish connection with postGIS.',
         call. = FALSE)
  ## Function Output
  out <- list(con = connect, dns = dns)
  class(out) <- 'pgConnect'
  return(out)
} 

#' @export
print.pgConnect <- function(con){
  conAtributes <- strsplit(con[[2]], " ")[[1]][-1]
  for (i in seq(conAtributes))
    cat(conAtributes[i], '\n')
}