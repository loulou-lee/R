# 함수
# 내장함수
seq(0, 5, by = 1.5)

set.seed(123)
rnorm(10, mean = 0, sd = 1) # 정규분포를 따르는 난수
hist(rnorn(5000, mean = 0, sd = 1))

runif(10, min=0, max=100)
hist(runif(5000, min=0, max=100))

sample(0:10, 5)

vec <- 1:10
min(vec) #최소값
range(vec) #범위
mean(vec)
median(vec) #중앙값
var(vec)
sqrt(var(vec))
sd(vec)
sd(vec) / mean(vec)
quantile(vec)
sum(vec)
prod(vec)
#...

# 사용자 정의 함수
func1 <- function(arg){
  print(arg)
  return(arg + 10)
}
typeof(func1) # 원시 자료형 (R 에서의) Closure: 함수 Complex: 복소수
# class() : R 객체지향 관점에서의 자료형 # mode() : 원시 자료형 (S1 에서의)
# 참고 https://statools.tistory.com/16
func1(5)

test <- read.csv('testdata/')