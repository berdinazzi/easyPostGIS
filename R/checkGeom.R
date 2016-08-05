checkGeom <- function(con, vecTable) {
  ##Funtion to check which table column(s) is geometric
  fields <- RPostgreSQL::dbListFields(con[[1]], vecTable)
  
  # Desabilitar erros e warnings
  options(show.error.messages = FALSE, warn = -1)
  
  data <- data.frame(fields = fields, geom = FALSE)
  
  for (i in seq(fields)) {
    query <-
      paste0(
        'SELECT ST_GeometryType(',
        fields[i],
        ') FROM ',
        vecTable
        )
    try(test <- RPostgreSQL::dbGetQuery(con[[1]], query))
    
    if (!is.null(test)) {
      data$geom[i] <- TRUE
      remove(test)
    }
  }
  
  # Voltar a introduzir erros e warnings
  options(show.error.messages = TRUE, warn = 0)
  
  name <- fields[which(data$geom == TRUE)]
  
  return(name)
  
}


