# 회귀모델 평가
cars # 자동차의 속도와 제동거리
cor(cars) # 상관계수 확인
is(cars)

# 속도에 따른 제동거리 예측 모델

model <- lm(formula = dist ~ speed, data = cars)
summary(model) # 0.6511 65.1%의 설명력을 가진다.

coef(model) # 회귀계수

fitted(model)[1:4] # 모델이 예측한 값(dist)

residuals(model)[1:4] # 모델과 실제값과의 차이(residuals, 잔차)

cars[1:4,]
fitted(model)[1:4] + residuals(model)[1:4] # 예측값 + 잔차 = 실제값, 잔차 = 실제값 - 예측값

confint(model)

predict(model, newdata = data.frame(speed=10))
predict(model, newdata = data.frame(speed=c(10, 15, 20)))
predict(model, newdata = data.frame(speed=10), interval = 'confidence')

# 모델 간 평가
full_model <- lm(dist ~ speed, data = cars) # 완전모형
full_model

reduce_model <- lm(dist ~ 1, data = cars) # 축소모형
reduce_model

anova(reduce_model, full_model) # 두 모델을 비교  
# Pr(>F) = 1.49e-12 , p-value < 0.05 이므로 두 모델 간 유의한 차이가 있다.
# 다시 말하면 speed 변수가 유의미한 독립변수임을 알 수 있다.
