dbBufferPG <- function(con, vecTable, dist, newTable = FALSE) {
  geom <- checkGeom(con, vecTable)
  
  if (newTable == FALSE)  {
    query <-
      paste0(
        "SELECT ST_Buffer(",
        geom,
        ", ",
        dist,
        ", 'quad_segs=8'",
        ") INTO",
        " temptable",
        " FROM ",
        vecTable
      )
  } else {
    query <-
      paste0(
        "SELECT ST_Buffer(",
        geom,
        ", ",
        dist,
        ", 'quad_segs=8'",
        ") INTO ",
        newTable ,
        " FROM ",
        vecTable
      )
  }
  
  RPostgreSQL::dbSendQuery(con[[1]], query)
  
  # Eliminar a tabela se nao for para ficar na base de dados
  if (newTable == FALSE) {
    shape <- readOGR(dsn = con[[2]], 'temptable')
    RPostgreSQL::dbRemoveTable(con[[1]], 'temptable')
  } else {
    shape <- readOGR(dsn = con[[2]], newTable)
  }
  return(shape)
}
