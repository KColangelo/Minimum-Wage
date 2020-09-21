require(readstata13)
setwd("C:\\Users\\ksc91\\OneDrive\\Minimum Wage\\SIPP")
data = read.dta13("bs_sample.dta")

data['prob'] = data$proportion/data$ncontrol
data$test=0
data$test[data$spell>=15]=1
data$test[data$spell>=30]=2
beta1=matrix(0,100,4)
beta2=matrix(0,100,4)
beta3=matrix(0,100,4)
for (i in 1:100){
boot = data[(sample(nrow(data), data$m[1], replace=TRUE, prob=data$prob)),]
boot['delta_mw']=1
sample = rbind(data,boot)
model = lm(I(log(spell)) ~ delta_mw*factor(test) + mw + factor(eeducate)
           +tage+factor(erace)+factor(yearb)+factor(monthb)
           +factor(state)+ unempb + ui_elig + factor(esex),data=sample)
r=as.matrix((as.numeric(gregexpr('delta_mw',rownames(summary(model)$coefficients)))+1)/11)
beta1[i,]=as.numeric(data.frame(subset(summary(model)$coefficients,r!=0))[1,])
beta2[i,]=as.numeric(data.frame(subset(summary(model)$coefficients,r!=0))[2,])
beta3[i,]=as.numeric(data.frame(subset(summary(model)$coefficients,r!=0))[3,])
}
beta_2 = beta1+beta2
beta_3 = beta1+beta3
hist(beta1[,1])
hist(beta_2[,1])
hist(beta_3[,1])