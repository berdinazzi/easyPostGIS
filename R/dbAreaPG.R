dbAreaPG <- function(con, vecTable, geom = NULL, addColumn = FALSE){
      
    if (is.null(geom)) geom <- checkGeom(con, vecTable)
    
    if(length(geom) > 1) stop(paste0("Multiple geometries found. Please choose between: ", geom))
    

if (addColumn == TRUE)  { 
  query <- sprintf("ALTER TABLE %s ADD COLUMN area double precision;
               UPDATE %s SET area=ST_AREA(%s);", vecTable, vecTable, geom)
  RPostgreSQL::dbSendQuery(con[[1]], query)
  
  query <- sprintf("SELECT area FROM %s", vecTable)
  tableArea <- RPostgreSQL::dbGetQuery(con[[1]], query)

} else {
  query <- sprintf("SELECT ST_AREA(%s) FROM %s", geom, vecTable)
  tableArea <- RPostgreSQL::dbGetQuery(con[[1]], query)
}
   
    return(tableArea)
  }
