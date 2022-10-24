# 데이터 유형(종류)
# numeric(integer, double), character, logical, factor, closure

kbs <- 9 # 객체변수에 double type의 객체의 주소를 참조하도록 함 파이썬 처럼 
# kbs = 9 # 함수 안에서 사용 권장
# 9 -> kbs
object.size(kbs)
typeof(kbs) # 자료형
mode(kbs)   # 자료 유형 
class(kbs)  # 자료 구조
mbc <- as.integer(kbs) # double 을 integer
typeof(mbc)
is(mbc)
mbc <- 5L # integer 로 저장
typeof(mbc)

ss <- '홍길동'
is(ss)
ss[0]
ss[1]
print(ss) # 함수 내에서 출력하고자 할 때
# print(ss, kbs) 프린트는 한개밖에 출력을 못해서 cat을 써야한다
cat(ss)
cat(ss, kbs)

# logical
b <- TRUE
b <- T
is(b)

# 복소수
z <- 5.3-3i
z
Re(z)
Im(z)
is(z)

# Factor(요인형 변수)
kbs <- c('second', 'first', 'third', 'second')
kbs
is(kbs)
plot(kbs)

# 특수한 값 형태로 
# NULL : 데이터 값 없음(값 인식x), 
# NA:결측값 값 없음(값 인식o)
# NaN:수학적으로 정의되지 않은 값 (값 인식o)
length(NULL)
length(NA)
length(NAN)


mbc <- as.factor(kbs)
mbc
is(mbc)
plot(mbc)

cat(length(NULL), typeof(NULL))
cat(length(NA), typeof(NA))
cat(length(NaN), typeof(NaN))

sum(2, 3)
sum(2, 3, NULL) # NULL은 무시하고 연산
sum(2, 3, NA) # err #NA는 missing value 연산에 참여x
sum(2, 3, NAN) # err
Inf
0 / 0
Inf + Inf
Inf + -Inf #NAN
Inf - Inf #NAN

sbs <- 10
strOptions(sbs)

ls()
objects()
ls.str()

rm(b) # b제거
ls()
b # Error: object 'b' not found
rm(list=ls()) # 여러개 지우기
ls()
gc() #가비지 컬렉터

# package 사용 : 특정dataset + library의 묶음
available.packages()
dim(available.packages())
utils::installed.packages()
base::print(5)
#12시 36분 부터 수업
install.packages("plyr") # 패키지 설치하는법
library(plyr) # 로딩
help(plyr) # == ?plyr
ls("package:plyr") # plyr에 나오는 멤버들이 모두 나온다
remove.packages("plyr")

# dataset
data()
iris
head(iris)
tail(iris, 3)
hist(iris$Sepal.Length)

Nile # data
?mean # 구글링 mean in R
x <- c(0:10, 50)
xm <- mean(x)
c(xm, mean(x, trim = 0.10))



# <연습문제1> name, age, address 라는 변수에 적당한 데이터를 대입하시오.
# 
# 조건1) 변수의 특성에 맞게 값을 초기화하고 결과를 확인한다.
name <- '신기해'
age <- 33
address <- '강남구'
name
age
print(address)
cat('이름:',name, age, address)

# 조건2) 각 변수에 데이터 타입 보기 함수와 타입확인 함수 적용
# typeof(), is.***()
typeof(name)
typeof(age)
is.character(name)
is.numeric(age)
is.numeric(address)

# <연습문제2> R에서 제공하는 women dataset을 이용하여 아래의 조건을 처리하시오.
# <조건1> women dataset은 어떤 데이터의 모음인가?
head(women, 3)
str(women) #구조
? women

# <조건2> women dataset의 자료 유형과 자료구조는?
mode(women)
class(women)

