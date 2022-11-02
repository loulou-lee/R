# 단순/다중 선형회귀 모델 작성 후 정량적인 예측 결과 받아보기
head(mtcars)

# 연습1 - 단순선형회귀
# 임의의 마력수를 입력하면 연비를 예측하는 모델
# 변수는 mpg(연비), hp(마력수)
cor(mtcars$hp, mtcars$mpg) #  -0.7761684

par(mar=c(1,1,1,1))
plot(mpg ~ hp, data = mtcars, xlab='마력수', ylab='연비')

# 인과관계가 있다고 판단함
model1 <- lm(formula = mpg ~ hp, data = mtcars)
model1
# y_hat = -0.06823(기울기) * hp + 30.09886
summary(model1) # p-value: 1.788e-07 < 0.05 유의한 모델. R-squared:0.6024
abline(model1, col='red')

# 미지의 hp(마력수)에 대한 mpg(연비) 예측 : 수식 사용
new_hp <- 110
cat('예측값 : ', -0.06823 * new_hp + 30.09886)

new_hp <- 160
cat('예측값 : ', -0.06823 * new_hp + 30.09886)

new_hp <- 80
cat('예측값 : ', -0.06823 * new_hp + 30.09886)

# 미지의 hp(마력수)에 대한 mpg(연비) 예측 : 함수 사용
# 미지의 값을 직접 작성할 수 있으나 기존값을 수정하는 방법
mynew <- mtcars[c(1,2),]
mynew <- edit(mynew)
mynew
pred <- predict(model1, newdata = mynew)
pred
cat('예측값 : ', pred)

# 연습2 - 다중선형회귀
# 임의의 마력수와 차체무게를 입력하면 연비를 예측하는 모델
# 변수는 mpg(연비), wt(차체무게),  hp(마력수)
cor(mtcars$hp, mtcars$mpg) # -0.7761684
cor(mtcars$wt, mtcars$mpg) # -0.8676594

model2 <- lm(formula = mpg ~ hp + wt, data = mtcars)
model2
# y_hat = -0.03177 * hp + -3.87783 * wt + 37.22727
summary(model2) #


# 미지의 hp(마력수), wt에 대한 mpg(연비) 예측 : 수식 사용
new_hp <- 110; new_wt <- 2.6
cat('예측값 : ', -0.03177 * new_hp + -3.87783 * new_wt + 37.22727)

new_hp <- 160; new_wt <- 5.6
cat('예측값 : ', -0.03177 * new_hp + -3.87783 * new_wt + 37.22727)

new_hp <- 80; new_wt <- 1.6
cat('예측값 : ', -0.03177 * new_hp + -3.87783 * new_wt + 37.22727)

# 예측값 / 실제값 비교
pred2 <- predict(model2)
cat('예측값 : ', pred2[1:10])
cat('실제값 : ', mtcars$mpg[1:10])

# 미지의 hp(마력수), wt에 대한 mpg(연비) 예측 : 함수 사용
new_data <- data.frame(hp=110, wt=2.6)
predict(model2, newdata = new_data)

new_data <- data.frame(hp=66, wt=1.0)
predict(model2, newdata = new_data)