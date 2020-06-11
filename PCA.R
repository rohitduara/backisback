attach(mont.temp)
plot(Day,Temperature)
library(splines)
linsplinreg=lm(Temperature~bs(Day,knots=c(210,400,560),degree=1))
summary(linsplinreg)

plot(Day,Temperature,col="gray")
lines(sort(Day),predict(linsplinreg)[order(Day)],col="red")

linsplinreg$fitted[200]
linsplinreg$fitted[300]
linsplinreg$fitted[400]
linsplinreg$fitted[500]




poly5=lm(Temperature~poly(Day,5))
summary(poly5)


####polynomials

ploy2splinreg=lm(Temperature~bs(Day,knots=c(210,400,560),degree=2))


ploy3splinreg=lm(Temperature~bs(Day,knots=c(210,400,560),degree=3))


ploy4splinreg=lm(Temperature~bs(Day,knots=c(210,400,560),degree=4))

plot(Day,Temperature,col="gray")
lines(sort(Day),predict(poly2splinreg)[order(Day)],col="red")


lines(sort(Day),predict(poly3splinreg)[order(Day)],col="blue")


lines(sort(Day),predict(poly4splinreg)[order(Day)],col="dark green")



quantiles(Day,c(.2,.4,.6,.8))
equalspline=lm(Temperature~bs(Day,knots=c(147.2,293.4,439.6,585.8),degree=3))
plot(Day,Temperature,col="gray")
lines(sort(Day),predict(equalspline)[order(Day)],col="dark green")

abline(v=147.2,lty=2)
abline(v=293.4,lty=2)
abline(v=439.6,lty=2)
abline(v=585.5,lty=2)


##smoothing function


smooth1=smooth.spline(Day,Temperature,spar=0.1)

smooth3=smooth.spline(Day,Temperature,spar=0.3)

smooth7=smooth.spline(Day,Temperature,spar=0.7)

plot(Day,Temperature,col="gray")
lines(smooth1, col="red")


lines(smooth3, col="blue")


lines(smooth7, col="dark green")



smooth1
smooth3
smooth7

smoothcv=smooth.spline(Day,Temperature,cv=TRUE)
smoothcv

###local regression

localreg_1=loess(Temperature~Day,span=0.1)
localreg_3=loess(Temperature~Day,span=0.3)
localreg_5=loess(Temperature~Day,span=0.5)



plot(Day,Temperature,col="gray")

lines(sort(Day),predict(localreg_1)[order(Day)],col="red")


lines(sort(Day),predict(localreg_3)[order(Day)],col="blue")


lines(sort(Day),predict(localreg_5)[order(Day)],col="dark green")




