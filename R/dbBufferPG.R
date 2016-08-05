dbBufferPG <- function(con, vecTable, geom = NULL, dist, newTable = FALSE) {
  
  if (is.null(geom)) geom <- checkGeom(con, vecTable)
      
  if(length(geom) > 1) stop(paste0("Multiple geometries found. Please choose between: ", geom))
  
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
