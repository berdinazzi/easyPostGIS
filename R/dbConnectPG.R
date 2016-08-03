library(RPostgreSQL)
library(rgdal)

dbConnectPG <- function(dbname,
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
  try(connect <- RPostgreSQL::dbConnect(dbDriver('PostgreSQL'),
                                        dbname = dbname,
                                        host = host,
                                        port = port),
      silent = TRUE
  )
  
  # Verificar a conexao
  if (!exists('connect')) 
    stop('Could not establish connection with the database. Review connection information.',
         call. = FALSE)
  
  # Ligacao a Post
 if(!is.null(port)) {port_aux <- ' port=' } else {port_aux <- NULL}
  if(!is.null(user)) {user_aux <- ' user=' } else {user_aux <- NULL}
  if(!is.null(password)) {password_aux <- ' password=' } else {password_aux <- NULL}
  
 dns <-  paste0('PG:' 
         , ' dbname=', dbname 
         , port_aux, port
         , user_aux, user 
         , password_aux, password)
  
  # Ligacao a postgres
  try(test <- ogrListLayers(dns),
      silent = TRUE
  )

  # Verificar a conexao
  if (!exists('test')) 
    stop('Could not establish connection with postGIS. PostGIS extension probably not installed.',
         call. = FALSE)
  
 list(con = connect, dns = dns)

} # end function
