# 시각화 - 그래프 : 이산변수(막대, 점, 원형 ...), 연속변수(상자박스, 히스토그램, 산포도...)

stu <- read.csv("testdata/ex_studentlist.csv", fileEncoding = "utf-8")
head(stu, 3)
str(stu)
names(stu)

# 막대
barplot(stu$grade)
barplot(stu$grade, ylim = c(0, 5), col = rainbow(3), main = '세로막대')

barplot(stu$grade, ylim = c(0, 5), col = rainbow(3),
        xlab = '학년',ylab = '학생', main = '가로막대', horiz = T)

barplot(stu$grade, col = c(1,2,3,4,5))

par(mfrow=c(1,2))
# par(mfcol=c(1,2))
barplot(stu$grade,col = c(1,2,3))
barplot(stu$grade,col = c(1,2,3), horiz = T)
qplot

par(mfrow=c(1,1))
barplot(stu$grade,col = c(1,2,3), space = 2) #막대와 막대 사이 간격 space

# 점 차트
dotchart(stu$grade)
dotchart(stu$grade, color = 2:5, lcolor = 'black', pch = 1:3, cex = 1.5)

# 원 그래프
df <- na.omit(stu)
df
pie(df$age, labels = df$age, lty = 3)

# boxplot
min(stu$height)
max(stu$height)
boxplot(stu$height, range = 0) # range = 1
boxplot(stu$height, range = 1, notch = T)
abline(h=170, 11y=3, col='blue')

#hist
hist(stu$height, xlab = '키', breaks = 5, prob=T, col = 'yellow')
lines(density(stu$height))#곡선추가

#plot
plot(x=stu$height, y=stu$weight)

price <- runif(10, min=1, max=100)      # 균등분포를 따르는 난수 발생
plot(price)
par(mfrow=c(2,2))                       # 2행 2열 차트 그리기
plot(price, type="l")                   # 유형 : 실선
plot(price, type="o")                   # 유형 : 원형과 실선
plot(price, type="h")                   # 직선
plot(price, type="s")                   # 꺾은선


# 3차원 산점도 그래프 ---
par(mfrow=c(1,1))
install.packages("scatterplot3d")
library("scatterplot3d") 

# 붓꽃의 종류별 분류로 3차원 그래프 그리기
levels(iris$Species) 
iris
ir.setosa = iris[iris$Species=='setosa', ]
ir.virginica = iris[iris$Species=='virginica', ]
ir.versicolor = iris[iris$Species=='versicolor', ]

# 형식 : scatterplot3d( 밑변，우변칼럼명，좌변칼럼명，type) 
# 틀 생성
irdata <- scatterplot3d(iris$Petal.Length, iris$Sepal.Length, iris$Sepal.Width, type = 'n')

# 산점도 시각화
irdata$points3d(ir.setosa$Petal.Length, ir.setosa$Sepal.Length, 
                ir.setosa$Sepal.Width, bg='red', pch=21)

irdata$points3d(ir.virginica$Petal.Length, ir.virginica$Sepal.Length, 
                ir.virginica$Sepal.Width, bg='blue', pch=23)

irdata$points3d(ir.versicolor$Petal.Length, ir.versicolor$Sepal.Length, 
                ir.versicolor$Sepal.Width, bg='yellow', pch=25)

# plot() 함수 속성 : pch : 연결점 문자타입-> plotting characher-번호(1~30)

plot(price, type="o", pch=5)            # 빈 사각형
plot(price, type="o", pch=15)           # 채워진 마름모
plot(price, type="o", pch=20, col="blue")
plot(price, type="o", pch=20, col="orange", cex=1.5)

# 전통적인 plot의 기능을 확장한 패키지(라이브러리)
library(ggplot2)
head(mpg, 3)
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point()