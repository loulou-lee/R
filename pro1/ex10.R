# 통계분석 : 어떤 데이터가 주어졌을 때 데이터 간의 관계를 파악하고, 이를 분석하는 것

# 기술통계 : 자료를 정리하고 요약 및 시각화를 하는 기초적인 총계
# 중심경향값 (평균, 중위수, 최빈수), 산포도(분산, 표준편차, 범위, 사분위수), 분포도(왜도, 첨도)
# 기초 통계량 계산 함수 약간 보기
mean(1:5)
var(1:5)
sd(1:5)
summary(1:10)

# 표준화, 정규화
# 표준화 : 평균과 표준편차를 사용하여
# 수식 : (요소값 - 평균) / 표준편차

# iris dataset로 작업
head(iris, 3)

df <- iris[, 1:4]
head(df, 3)
dim(df)
(iris$Sepal.Length - mean(iris$Sepal.Length)) / sd(iris$Sepal.Length)
df$Sepal.Length

# 방법2 : 내장 사용
scale(df$Sepal.Length)
scale(df)

# 방법3 : 함수작성 후 사용
func1 <- function(x){
  return((x - mean(x)) / sd(x))
}

func1(iris$Sepal.Length)

# 방법4 : 내장 함수 사용
apply(x=as.matrix(df$Sepal.Length), MARGIN = 2, FUN = "func1")
apply(x=df, MARGIN = 2, FUN = "func1") # 표준화

# 정규화 : 최대값과 최소값을 사용하여 원래 데이터의 최소값을 0, 최대값을 1로 만드는 방법
# 수식 : (요소값 - 최소값) / (최대값 - 최소값)
func2 <- function(x){
  return((x - min(x) / (max(x) - min(x)))
}

func2(iris$Sepal.Length)
func2(1:10)
func2(c(5000:5100, 10))
func2(-10:-20)

# 변동계수(c.v) : 평균에 대한 표준편차의 비율. 표준편차를 산술평균으로 나눈 것
# 평균이 크게 다른 두 개 이상의 집단이 있을 때, 각 집단의 상대적 동질성을 감안한 산포도의 척도
# 변동계수 = 표준편차 / 평균

# 예) 3개의 샘플에 대해 2명의 관측자가 물 용량을 측정한 데이터가 있다.
tom <- c(54, 50, 52) # 물 : 리터 단위 측정
james <- c(54017, 49980, 52003) # 물 : 밀리리터 단위 측정
mean(tom)
mean(james)
sd(tom)
sd(james)

sd(tom) / mean(tom) # 리터 단위 측정한 변동계수
sd(james) / mean(james) # 밀리리터 단위 측정한 변동계수

-ex11cor.R-
  # 상관계수 : 변수들 간의 관련성을 분석, 공분산을 표준화한 값. -1 ~ 0 ~ 1 사이의 값으로 관계를 분석
  # 공분산 : 두 개 이상의 확률변수에 대한 관계를 보여주는 값. 힘의 방향은 알 수 있으나 크기는 제각각이다.
  plot(1:5, 2:6)
cov(1:5, 2:6) # 2.5이므로 우상향 패턴을 보임

plot(1:5, c(3,3,3,3,3))
cov(1:5, c(3,3,3,3,3)) # 0이므로 패턴을 보이지 않음

plot(1:5, 5:1)
cov(1:5, 5:1) # -2.5이므로 우하향 패턴을 보임
plot(1:5, c(5000, 4000, 3000, 2000, 1000))
cov(1:5, c(5000, 4000, 3000, 2000, 1000))
cor(1:5, 5:1)
cor(1:5, c(5000, 4000, 3000, 2000, 1000))

plot(1:5, c(5000, 3500, 2200, 1000, 1200))
cov(1:5, c(5000, 3500, 2200, 1000, 1200)) # 공분산
cor(1:5, c(5000, 4500, 3200, 1600, 700)) # 상관계수

# 프랜시스 골턴이 만든 csv 자료를 사용
hf <- read.csv("testdata/galton.csv", header = T)
head(hf, 3)
dim(hf)
str(hf)
summary(hf)

hf_man <- subset(hf, sex=='M')
hf_man
hf_man <- hf_man[c("father", "height")]
dim(hf_man)
head(hf_man, 3)

# 공분산
f_mean <- mean(hf_man$father)
s_mean <- mean(hf_man$height)
cov_sum <- sum((hf_man$father - f_means) * (hf_man$height - s_mean)) # 편차 곱의 합
cov_xy <- cov_sum / (nrow(hf_man) - 1)
cov_xy # 2.368441 양의 관계가 있다

# 공분산 : 함수
cov(hf_man$father, hf_man$height) # 2.368441

# 상관계수 : 수식
r_xy <- cov_xy / (sd(hf_man$father) * sd(hf_man$height)) # csv 회귀분석
r_xy # 0.3913174

# 상관계수 : 함수
cor(hf_man$father, hf_man$height) # 0.3913174

plot(height ~ father, data=hf_man)
abline(lm(height ~ father, data=hf_man), col='red', lwd=2)

# 상관계수 검정 : 상관계수의 통계적 유의성을 판단할 수 있다
cor.test(hf_man$father, hf_man$height, method = 'pearson')

#단일 선형회귀 분석
#다중 선형회귀 분석
#최소제곱법(최소자승법)-최적의 추세선을 구한다
#실제값과 예측값의 차이는 잔차이다. - 잔차가 최소인 점을 그으면 추세선이 나온다

# 머신러닝(ML)
# 선형회귀분석 : 두 변수간에 상관관계가 있고 인과관계가 있는 경우 모델 작성 가능
# 독립변수(x, 연속형), 종속변수(y, 연속형)
# 모델 수식 : y = wx + b
# 기울기(slope)와 절편(bias)은 최소제곱법 공식을 사용

# 부모의 IQ와 자식의 IQ 데이터를 사용해 선형회귀 분석
# 부모의 IQ와 자식의 IQ는 인과관계가 있다고 가정
x <- c(110, 120, 130, 140, 150)
y <- c(100, 105, 128, 115, 142)
cor(x, y) # 양의 상관관계가 매우 높음
plot(x, y)

x_dev <- x - mean(x) # 편차
y_dev <- y - mean(y)
dev_mul <- (x - mean(x)) * (y - mean(y))
square <- x_dev ** 2
df <- data.frame(x, y, x_dev, y_dev, dev_mul, square)
df

slope <- sum(df$dev_mul) / sum(df$square)
slope # 0.94
bias <- mean(df$y) - slope * mean(df$x)
bias
# 모델 수식 y = 0.94*x + -4.2
y_hat <- slope * 120 + bias
cat('예측값 : ', y_hat, ', 실제값:', 100)
# lm() : linear regression 각 점들과 선의 오차가 최소로 되도록 선을 긋는 것 (선형모델)
? lm
line_model <- lm(formula = y ~ x )
line_model
plot(x, y)
abline(line_model, col="blue")

new_x = 78.5 # 미지의 x에 대한 y값이 궁금
new_y_hat <- slope * new_x + bias
new_y_hat

predict(line_model, data.frame(x=c(78.5, 123.4, 167.1)))

# 단순선형회귀 모델 작성
head(women, 2)
summary(women)
cor(women$height, women$weight) # 0.9954948
plot(women$height, women$weight)

# 인과관계가 있다고 가정하고 회귀분석 모델 작성
mfit <- lm(formula = weight ~ height, data = women) #구조방정식 어려워서 설명안함
mfit
abline(mfit, col='red')

summary(mfit) # 모델 관련 요약 통계량 표시
# p-value 이 모델이 의미가 있는지 없는지 보여준다
# p-value: 1.091e-14 < 0.05 이므로 현재 모델은 유의하다. 인과관계가 있음이 증명
#37.85 * 37.85

#plot(mfit)