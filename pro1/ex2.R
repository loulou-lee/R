# R에서 제공하는 자료구조(객체 타입) - Vector, Matrix, Array, List, Dataframe
# R은 스칼라 타입 없다. 가장 작은 단위가 1차원 배열인 Vector

# vector : 1차원 배열

year <- 2022
is.vector(year)

seq(1, 5)
seq(from=1, to=10, by=2)
seq(3, 7)
seq(7, 3)
seq(1, 10, length.out = 4)
seq(1:10)

rep(1:3, times=3)
rep(1:3, each=3)

v <- c(1, 5, 7, 10:20)
v

v2 <- c(1, 2.5, '3', T, F) # 정수 < 실수 < 문자열
v2

age <- c(23, 26, 32)
age
age[1]
age[2]
age[5] # NA 결측치
names(age) <- c('오공','팔계','오정')
age
age[3]
age['오정']
age <- c(age, 44)
age
age[10] <- 55
age
length(age)
age <- append(age, 66, after=5)
age
age <- NULL
age
length(age)
rm(age)
age

v1 <- c(13, -5, 15:20, 12, -2:3)
v1
# 인덱싱 / 슬라이싱
v1[1]
v1[-1] # 여집합 1번째만 뺀 나머지 나옴
v1[c(2,5)]
v1[c(2:5)]
v1[-c(2:5)]
length(v1)
nrow(v1) # 행렬에서 가능
NROW(v1)

v2 <-- v1 + 10
v2
v2 <- v1 %% 3
v2

a <- 1:5
a + 5
a - 5
a * 5
a / 5
sqrt(a)
sqrt(a)^2

a
b <- c(6:10) # == 6:10
b
a+b
a*b
a[6] <- 7
a
union(a, b) # 중복 X
c(a, b)
setdiff(a, b)
intersect(a, b) # 교집합

# Matrix : 2차원 배열(행렬)
a <- 1:8
dim(a) <- c(2, 4)
a
typeof(a) #"integer"
class(a) #"matrix" "array" 
mode(a) #"numeric"

m <- matrix(1:5)
m
dim(m) #차원확인 함수

# m <- matrix(c(1:9), nrow=3)
m <- matrix(c(1:9), nrow=3, byrow = T) # 행부터 채우는법
m
dim(m)

m <- matrix(1:10, 2)
m
m <- matrix(1:10, 3)
m
class(m)
m[1,]
m[1,1]
m[,3]
m[c(1,3),c(2:4)]
m[c(1,3),c(1, 2:4)]
m[-1,]

a <- matrix(c(1:9), nrow=3, ncol=3)
a
rownames(a) <- c('r1','r2','r3')
colnames(a) <- c('one','two','three')
a
nrow(a)
NROW(a)

dim(a)
length(a) # 개수

a <- matrix(c(1,2,3,4,5), 2, 2)
b <- matrix(5:8, 2, 2)
a
b

a + 10
a + b

a*b # 아다마르 곱

a %*% b # 행렬 곱만 가능
# 행렬 곱 : 도형의 면적, 부피 계산, 머신러닝의 차원축소,
# 딥러닝에서 입력자료와 가중치 연산 등을 할 때 사용
# a %+% b # X
a
diag(a) # 대각선 값
diag(2) #대각 제외한 값 0 단위행렬

a
t(a) # 행렬전환 (transpose : 전치)
solve(a)
solve(solve(a))
solve(a) %*% a # 역행렬을 곱하면 단위행렬이 나온다

x1 <- c(5, 40, 50:52)
x2 <- c(30, 5, 6:8)
x1
x2
mr <- rbind(x1, x2)
mr
mc <- cbind(x1, x2)
mc

# Array : 다차원 배열

d <- c(1:12)
arr1 <- array(d)
arr1
class(arr1)

arr2 <- array(c(1:12), dim=c(6, 2)) # 2차원
arr2

arr3 <- array(c(1:12), dim=c(3, 2, 2)) # 3행2열 두개 3차원
arr3

arr3[,,2]
arr3[,1,1] # 1면 1열
arr3[1,,1] # 1면 1행
arr3[1,1,1] # 1면 1행 1열

# 사칙연산 가능
# List : 서로 다른 타입의 데이터를 기억(키, 값)

num <- list(c(1:5), c(6:10), c("a", "b", "c"))
num
num[1]
typeof(num[1])
num[[1]]
typeof(num[[1]])
num[[1]][2]

number <- list(name='hong', age=22)
number
number$name
number$age

print('--------')
aa <- list()
tracemem(aa) # 주소 추적
