con <- pgConnect("tempdbase")

dbListTables(con[[1]])
ogrListLayers(con[[2]])

dbListFields(con[[1]], 'ae_ac')
dbListFields(con[[1]], 'linhas')

checkGeom(con, 'ae_ac')
typeGeom(con, 'ae_ac')

sendShape(con,folder='data/', layer='pontos_AC_amostrados', pgLayer = 'pontos')
RPostgreSQL::dbRemoveTable(con[[1]], 'pontos_ac_amostrados')

newBuf <- pgBuffer(con, 'ae_ac', dist=50)
plot(newBuf)

shp <- getShape(con,'ae_ac')
plot(shp)

RPostgreSQL::dbSendQuery(con[[1]], "ALTER TABLE ae_ac DROP COLUMN area;")
tt <- dbAreaPG(con, 'ae_ac')

pgArea(con,'ae_ac')
z<-pgLength(con,'linhas')
pgPerimeter(con,'ae_ac')
checkGeom(con, 'linhas')
checkGeom(con, 'ae_ac')
typeGeom(con, 'linhas')

cent <- pgCentroid (con, 'linhas', geom = NULL, newTable = NULL)
