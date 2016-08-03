## Create a database
system(paste("createdb", "tempdbase"))

## Upload shapefile
writeOGR(readOGR('data/', "AE_AC"), 
         driver = "PostgreSQL",
         dsn = 'PG: dbname=tempdbase',
         layer = "AE_AC")
