library(RPostgreSQL)
library(rgdal)

dbConnectPG <- function(dbname,
                        host = 'localhost',
                        port = 5432,
                        user,
                        password) 
{ 
  # Funcao para guardar os dados a conexao a base de dados e
  # testar as ligacoes
  
  # Ligacao a postgres
  try(con <- dbConnect(dbDriver('PostgreSQL'),
                        dbname = dbname,
                        host = host,
                        port = port,
                        user = user,
                        password = password),
       silent = TRUE
  )
  
  # Verificar a conexao
  if (!exists('con')) 
    stop('Could not establish connection with the database. Review connection information.',
         call. = FALSE)
  
  # Ligacao a PostGis
  dns <- paste0('PG:', 
                ' dbname=', dbname, 
                ' host=', host, 
                ' port=', port, 
                ' user=', user, 
                ' password=', password)
  
  # Ligacao a postgres
  try(test <- ogrListLayers(dns),
      silent = TRUE
  )

  # Verificar a conexao
  if (!exists('test')) 
    stop('Could not establish connection with postGIS. PostGIS extension not installed.',
         call. = FALSE)
  
  list(con = con, dns = dns)
  
} # end function
