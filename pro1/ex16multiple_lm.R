# 다중회귀분석 : 독립변수가 복수

head(state.x77, 3)
colnames(state.x77)
dim(state.x77) # 50 by 8
str(state.x77) # 구조
cor(state.x77)

states <- as.data.frame(state.x77[,c('Murder', 'Population', 'Illiteracy', 'Income', 'Frost')])
head(states,3)
cor(states)

# 다중회귀모델
mfit <- lm(formula = Murder ~ Population+Illiteracy+Income+Frost, data=states) #독립변수를 + 로 묶을 수 있다
mfit
summary(mfit) # p-value: 9.133e-08 < 0.05 유의한 모델. Adjusted R-squared: 0.5285

# *** 선형회귀분석의 기존 가정 충족 조건 ***
# . 선형성 : 독립변수(feature)의 변화에 따라 종속변수도 일정 크기로 변화해야 한다.
# . 정규성 : 잔차항이 정규분포를 따라야 한다.
# . 독립성 : 독립변수의 값이 서로 관련되지 않아야 한다.
# . 등분산성 : 그룹간의 분산이 유사해야 한다. 독립변수의 모든 값에 대한 오차들의 분산은 일정해야 한다.
# . 다중공선성 : 다중회귀 분석 시 3 개 이상의 독립변수 간에 강한 상관관계가 있어서는 안된다.

# 모델을 시각화
par(mfrow=c(2, 2))
plot(mfit)

# 잔차항의 정규성 검정
shapiro.test(residuals(mfit)) # p-value = 0.6672 > 0.05 정규성 만족 #아웃라이어가 많으면 정규성 만족을 못한다 

# 독립성 검정 , 자기상관이 없어야(0~4범위 나옴 2근처값) 독립적이다 더빈-와트슨
install.packages("car")
library(car)
durbinWatsonTest(mfit)
# D-W Statistic:2.317 0 ~ 4의 범위이며 2근처의 값이 나와야 자기상관관계가 없다.

# 선형성 검정
boxTidwell(Murder ~ Population+Illiteracy, data = states)
# Population p-value:0.7468, Illiteracy p-value:0.5357 > 0.05 이므로 선형성 만족
# 만족하지 않으면

# 등분산성 검정
ncvTest(mfit) # p = 0.18632 > 0.05 등분산성 만족

# 다중공선성 검정
vif(mfit) # 각 값들이 10을 넘으면 다중공선성 문제 발생

# AIC 통계량 : 모델의 상대적 품질을 평가하는 척도. 효과적인 독립변수를 선택할 수 있다.
model1 <- lm(formula = Murder ~ ., data = states)
summary(model1)

model2 <- lm(formula = Murder ~ Population + Illiteracy, data = states)
summary(model2)

# AIC 통계량으로 두 모델의 성능 비교
AIC(model1, model2)
# df      AIC
# model1  6 241.6429
# model2  4 237.6565 AIC 값이 더 작으므로 우수한 모델

# stepwise regression : 단계적으로 모형을 검정하면서 AIC 값을 비교한 후 가장 적합한 회귀모형을 찾아준다.
# backward(후진소거법) : 모든 변수를 독립변수로 주고, 기여도가 낮은 것 부터 하나씩 제거
full_model <- lm(Murder ~ ., data=states) # AIC가 낮을수록 좋다
reduce_model <- step(full_model, direction = 'backward')
summary(reduce_model)

# forward(전진선택법) : 유익한 변수부터 하나씩 독립변수로 추가
min_model <- lm(Murder ~ 1, data=states)
fwd_model <- step(min_model, direction = 'forward', 
                  scope=(Murder ~ Population+Illiteracy+Income+Frost), trace=1)
summary(fwd_model)

# both(단계적 방법) :
full_model <- lm(Murder ~ ., data=states)
step_model <- step(full_model, direction = 'both')
summary(step_model)

# 회귀모델 체크 사항
# 모델이 통계적으로 유의한가? F통계량으로 만든 p-value
# 회귀계수가 유의미한가? p-value, 신뢰구간을 확인
# 설명력 확인
# 그래프를 통한 확인
# 선형회귀분석의 기존 가정 충족 조건을 만족하는가
# ...