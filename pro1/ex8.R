#데이터 전처리(data preprocessing )가 필요한 이유는 무엇일까. 
#우수한 예측 분석 결과는 잘 정돈된 데이터에서 출발한다. 
#즉, 정교한 예측 분석 모델을 얻기 위해서는 수집된 데이터에 누락된 부분이나, 오차, 또는 데이터 처리에 있어서 가공할 부분은 없는지를 살펴보아야 한다.
#데이터 전처리 종류?
#데이터 전처리의 종류에는 데이터 클리닝(cleaning),  데이터 통합(integration) , 
#데이터 변환(transformation), 데이터 축소(reduction), 데이터 이산화(discretization) 등이 존재한다. 
#데이터의 결측치 및 이상치를 확인하거나 제거하고 불일치되는 부분을 일관성 있는 데이터의 형태로 
#전환 하기도 하는 이 전 과정을 데이터의 전처리라고 일컫는다.

ds <- read.csv("testdata/dataset.csv", header = T)
dim(ds) #300 7
head(ds, 2)
View(ds)
table(ds$gender)
attributes(ds)
names(ds)
str(ds)
ds$gender
ds['gender']
ds[c('gender','job')]
ds[c(2, 3, 5)]

#결측치(NA, Missing value, Not Available)
summary(ds$price)
sum(ds$price)
sum(ds$price, na.rm = T)

price2 <- na.omit(ds$price)
sum(price2)
length(price2)

# ds$price[is.na(ds$price)] <- mean(ds$price) # NA를 평균으로 대체
ds$price[is.na(ds$price)] <- 0 # NA를 0으로 대체
summary(ds$price)

# 극단치(outlier) : 비정상으로 분포를 벗어난 값
gender <- ds$gender
gender
table(gender)
hist(gender)

# gender 변수(열, 칼럼, 차원) 정제
data <- subset(ds, ds$gender == 1 | ds$gender == 2) # 성별이 1,2인 경우만 반환
length(data$gender)
dim(data)
table(data$gender)

str(data)

#price 변수
ds$price
length(ds$price)
plot(ds$price)
boxplot(ds$price)
summary(ds$price) # -457 ~ 675 극단치를 얼마로 할까에 대한 판단 필요

data2 <- subset(ds, ds$price >= 2 & ds$price <= 8)
length(data2$price)
plot(data2$price)
hist(data2$price)

# 데이터 가공은 많은 작업이 있다