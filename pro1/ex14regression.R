# 회귀식 적합도에 대한 가설 검정
# iris dataset
head(iris, 3)

cor(iris[, -5]) # 상관관계 나옴

cor(iris$Sepal.Length, iris$Sepal.Width) # -0.1175698 , 음의 상관관계가 약함 우하향
plot(iris$Sepal.Length, iris$Sepal.Width) # 산포도(시각화)

# Sepal.Length가 Sepal.Width에 영향을 주는가?
# 선형회귀분석 , ML 지도학습 지금까지
model1 <- lm(formula = Sepal.Width ~ Sepal.Length, data = iris)
summary(model1) # 모델의 p-value: 0.1519 > 0.05이므로 의미없는 모델
# 평가 : Sepal.Length가 Sepal.Width에 영향을 주지 않는다.
0.1175698 ** 2 # 상관계수 제곱하면 R-squared : 0.01382

cor(iris$Sepal.Length, iris$Petal.Length) #  0.8717538
plot(iris$Sepal.Length, iris$Petal.Length) # 산포도(시각화)

# Sepal.Length가 Petal.Length에 영향을 주는가?
# 선형회귀분석2
model2 <- lm(formula = Petal.Length ~ Sepal.Length, data = iris)
summary(model2) # 모델의 p-value: 2.2e-16 < 0.05이므로 의미있는 모델
# 평가 : Sepal.Length가 Petal.Length에 영향을 준다.
# R-squared: 0.76, 76%설명한다 정확하다고 하면 안되는데 분류에서 정확하다고 표현한다
0.8 ** 2
