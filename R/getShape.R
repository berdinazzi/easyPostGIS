getShape <- function(con, vecTable){
  shape <- readOGR(dsn = con[[2]], vecTable)
  return(shape)
}