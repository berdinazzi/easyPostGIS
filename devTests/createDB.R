## Create a database
dbName <- "tempdbase"
system(paste("createdb", dbName)) #create db
system(sprintf('psql -d %s -c "CREATE EXTENSION postgis;"', dbName)) # Enable postgis

## Upload shapefile
writeOGR(readOGR('data/', "AE_AC"), 
         driver = "PostgreSQL",
         dsn = 'PG: dbname=tempdbase',
         layer = "AE_AC")

writeOGR(readOGR('data/', "roads_500m_32629"), 
         driver = "PostgreSQL",
         dsn = 'PG: dbname=tempdbase',
         layer = "linhas")

## Upload entire folder of shapes

shps <- dir('~/DADOS/BRUNO/MyPackges/easyPostGIS/data', "*.shp")
shps <- sub(pattern='.shp', replacement="", shps)
for (shp in shps) {
  writeOGR(readOGR('.',layer=shp), 
           driver = "PostgreSQL",
           dsn = 'PG: dbname=tempdbase')
}