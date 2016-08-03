con <- dbConnectPG("tempdbase")

dbListTables(con[[1]])
ogrListLayers(con[[2]])

dbListFields(con[[1]], 'ae_ac')

checkGeom(con, 'ae_ac')

newBuf <- dbBufferPG(con, 'ae_ac', 50)
plot(newBuf)

shp <- getShape(con,'ae_ac')
plot(shp)

