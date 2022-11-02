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
conn <- dbConnect(drv = drv, "jdbc:mysql://127.0.0.1:3306/test", "root","123")
conn

dbListTables(conn)

# sangdata table로 crud 경험
query <- "select * from sangdata"
goodsAll <- dbGetQuery(conn, query)
goodsAll
is(goodsAll)
head(goodsAll, 3)
mean(goodsAll$su)
hist(goodsAll$su)
barplot(goodsAll$su, col=rainbow(10), names.arg = goodsAll$sang)

goods <- dbGetQuery(conn, "select * from sangdata where sang like '가죽%'")
goods

query <- "select code as 코드, sang as 품명 from sangdata order by code desc"
df <- dbGetQuery(conn, query)
str(df)

# 레코드 추가
iquery <- "insert into sangdata values(8,'핸드크림',34,5000)"
dbSendUpdate(conn, iquery)

df <- data.frame(code=9, sang='립밤', su=12, dan=2000)
df
dbSendUpdate(conn, "insert into sangdata values(?,?,?,?)", df$code, df$sang, df$su, df$dan)
dbGetQuery(conn, "select * from sangdata")

# 레코드 수정
uquery <- "update sangdata set sang='꽃' where code=9"
dbSendUpdate(conn, uquery)
dbGetQuery(conn, "select * from sangdata")

#레코드 삭제
dbSendUpdate(conn, "delete from sangdata where code=9")
dbGetQuery(conn, "select * from sangdata")

sangdf <- read.csv("sangpum.csv", header = T, fileEncoding = "utf-8")
sangdf

# 참고
paste("Hi", "Everybody") # "Hi Everybody"
paste0("Hi", "Everybody") # "HiEverybody"

install.packages("dplyr")
library(dplyr) # %>% 연산자를 사용하기 위함
# 여러 개의 행을 가진 data.frame의 자료를 DB에 추가하려면 함수 작성
func <- function(conn, table, df){
  batch <- apply(df, 1, FUN = function(x) paste0("'", trimws(x), "'", collapse=",")) %>%
                    paste0("(",.,")", collapse = ",\n")
  #print(batch)
  iquery <- paste("insert into", table, "values", batch)
  dbSendUpdate(conn, iquery)
}

# push data
func(conn, "sangdata", sangdf)

dbGetQuery(conn, "select * from sangdata")

dbDisconnect(conn)
