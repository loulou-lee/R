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
37.85 * 37.85
3.45000 / 0.09114

# y = wx + b 3.45 * x + -87.51667
y_hat <- 3.45 * 58 + -87.51667
y_hat
y_hat <- predict()
y_hat