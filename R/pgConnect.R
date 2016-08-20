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
  # Funcao para guardar os dados a conexao a base de dados e
  # testar as ligacoes
  
  # Ligacao a postgres com user e password
  # try(connect <- RPostgreSQL::dbConnect(dbDriver('PostgreSQL'),
  #                       dbname = dbname,
  #                       host = host,
  #                       port = port,
  #                       user = user,
  #                       password = password),
  #      silent = TRUE
  # )
  
  #Ligacao a postgres so com nome da database para testes. Tenho de resolver isto depois
  try(connect <- RPostgreSQL::dbConnect(RPostgreSQL::PostgreSQL(),
                                        dbname = dbname,
                                        host = host,
                                        port = port),
      silent = TRUE
  )
  
  # Verificar a conexao
  if (!exists('connect')) 
    stop('Could not establish connection with the database.',
         call. = FALSE)
  
  # Ligacao a Post
 if(!is.null(port)) {port_aux <- ' port=' 
 } else {
   port_aux <- NULL
 }
  if(!is.null(user)) {user_aux <- ' user=' 
  } else {user_aux <- NULL
  }
  if(!is.null(password)) {
    password_aux <- ' password=' 
  } else {
    password_aux <- NULL
  }
  
 dns <-  paste0('PG:' 
         , ' dbname=', dbname 
         , port_aux, port
         , user_aux, user 
         , password_aux, password)
  
  # Ligacao a postgis
  try(test <- rgdal::ogrListLayers(dns),
      silent = TRUE
  )

  # Verificar a conexao
  if (!exists('test')) 
    stop('Could not establish connection with postGIS.',
         call. = FALSE)
  
 out <- list(con = connect, dns = dns)
 class(out) <- 'pgConnect'

 return(out)

} # end function

print.connectPG <- function(con){
  conAtributes <- strsplit(con[[2]], " ")[[1]][-1]  
  cat(conAtributes[1])
}