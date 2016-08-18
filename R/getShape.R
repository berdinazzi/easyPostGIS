getShape <- function(con, vecTable){
  shape <- rgdal::readOGR(dsn = con[[2]], vecTable)
  return(shape)
}
