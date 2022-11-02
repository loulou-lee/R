# 정형 데이터(필드가 있다) 처리 : RDBMS와 연동
# RJDBC api를 사용
install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")
# Sys.setenv(JAVA_HOME="c:/Program Files/Java/jdk-11.0.5")
library(rJava)
library(DBI)
library(RJDBC)

# 원격 DB : MariaDb와 연동
drv <- JDBC(driverClass = "org.mariadb.jdbc.Driver",
            classPath ="c:/work/mariadb-java-client-2.6.2.jar") #이 파일 안에 driver이 있다.
conn <- dbConnect(drv = drv, "jdbc:mysql://127.0.0.1:3306/test", "root","123")
conn

dbListTables(conn) # 테이블 목록 보기

query <- "select * from jikwon"
employeeAll <- dbGetQuery(conn, query)
employeeAll
is(employeeAll)

employee <- dbGetQuery(conn, "select jikwon_pay as 연봉, date_format(now(),'%Y') - date_format(jikwon_ibsail,'%Y') as 근무년수 from jikwon")
employee
table(employee$근무년수) #입사년도별 건수
#-----------------------------
cor(employee$근무년수, employee$연봉)
cor(employee) # 상관계수 확인 0.9196725 양의 상관관계가 강함 우상향
model <- lm(formula = 연봉 ~ 근무년수, data = employee)
summary(model) # p-value: 6.943e-13 < 0.05 이므로 현재 모델은 유의하다 84.5%의 설명력을 가진다

#근무년수 입력받기
y_num <- readline('근무년수 입력:')
y_num <- as.numeric(y_num)

testData <- data.frame(근무년수=y_num)
testData
#predict(model1, newdata = data.frame(근무년수=y_num))
pre <- predict(model, testData) #model : 예측에 사용할 회귀분석 결과식
#newdata : 예측에 사용할 x값, 값을 지정하지 않을시 1~45 정수값에 대한 예측값을 출력한다.
#newdata에 사용할 x값을 지정할 때에는 주의 해야한다. data.frame의 colname을 회귀분석에서 사용한 설명변수 명과 동일하게 설정해야지 predict() command 사용시 오류가 발생하지 않는다.
head(pre)

plot(연봉~근무년수, data = employee)
abline(lm(연봉 ~ 근무년수, data=employee),col="669933",lwd=2)
        