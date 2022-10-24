# 정형 데이터(필드가 있다) 처리 : RDBMS와 연동
# RJDBC api를 사용
install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")
# Sys.setenv(JAVA_HOME="c:/Program Files/Java/jdk-11.0.5")
library(rJava)
library(DBI)
library(RJDBC)

# 개인용 DB : Sqlite와 연동
install.packages("RSQLite")
library(RSQLite)
mtcars # 자동차 정보 dataset
dim(mtcars)

conn <- dbConnect(RSQLite::SQLite(), ':memory:')
conn
dbWriteTable(conn = conn, "mtcar", mtcars)
dbListTables(conn)
dbListFields(conn, "mtcar")
query <- "select * from mtcar"
resultAll <- dbGetQuery(conn, query)
resultAll
query <- "select mpg, cyl, carb, mpg+100 as good from mtcar where mpg >= 30"
resultPart <- dbGetQuery(conn, query)
resultPart

# 원격 DB : MariaDb와 연동
drv <- JDBC(driverClass = "org.mariadb.jdbc.Driver",
            classPath ="c:/work/mariadb-java-client-2.6.2.jar") #이 파일 안에 driver이 있다.
conn <- dbConnect(drv = drv, "jdbc:mysql://127.0.0.1:3306/test")
