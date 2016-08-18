con <- dbConnectPG("tempdbase")

dbListTables(con[[1]])
ogrListLayers(con[[2]])

dbListFields(con[[1]], 'ae_ac')

checkGeom(con, 'ae_ac')

newBuf <- dbBufferPG(con, 'ae_ac', dist=50)
plot(newBuf)

shp <- getShape(con,'ae_ac')
plot(shp)

RPostgreSQL::dbSendQuery(con[[1]], "ALTER TABLE ae_ac DROP COLUMN area;")
tt <- dbAreaPG(con, 'ae_ac')

typeGeom(con, 'ae_ac')

