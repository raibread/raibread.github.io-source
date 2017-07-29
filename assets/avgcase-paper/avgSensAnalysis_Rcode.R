## Companion R code for "Sensitivity Analysis for 
## matched pair analysis of binary data: 
## From worst case to average case analysis 
#
## Required packages: optmatch, doParallel
#
## Author: Raiden B. Hasegawa
#
## Date: 1/9/2017

#### Data from motivating example (See Section 1.3, Table 1)
D.1 <- c(158,164,119,135) # on phone in hazard window
D.0 <- c(23,21,20,43)     # on phone in control window
S   <- D.0 + D.1          # total number of discordant pairs

#### Section 1.4, Table 2 (Standard sensitivity analysis)
p_bar <- function(G) G/(1+G)

alp <- 0.05 # test level

# standard sensitivity analysis at 0.05 level
# for simply hypothesis test of no treatment effect
G.sens <- sapply(c(1:4),function(i) 
  uniroot(function(G) 1-pbinom(D.1[i],S[i], p_bar(G))-alp,c(0,10))$root)

#### Section 4.3, Table 4 (Attributable Effects One-sided intervals)

# Average case calibrated sensitivity parameter
G.pr   <- rep(2.1,4) #c(3,3,2,2)

# Lower bound on p_s
p.lower <- 0

# Test statistic adjusted for attributable effects
T_a0_G <- function(D.1,D.0,A.0,G) {
  S      <- D.1 + D.0
  p.A  <- (p_bar(G)*S-(A.0*p.lower))/(S-A.0)
  T.a0.G <- (D.1 - A.0 - (S-A.0)*p.A)/((S-A.0)*p.A*(1-p.A))^0.5
  return(T.a0.G)
}

p_val <- function(T) 1-pnorm(T)

alp <- 0.05       # confidence level
a <- rep(NA,4)    # lower bound of one-sided CI for attr. effects
G.wc <- rep(NA,4) # corresponding worst case calibrate bias

# Compute lower bound for one-sided confidence intervals in Table 5;
# Also compute corresponding worst case calibrated bias
for(i in 1:4){
  a[i] <- which(sapply(c(0:D.1[i]),function(A) p_val(T_a0_G(D.1[i],D.0[i],A,G.pr[i])))>alp)[1]-1
  tmp <- (p_bar(G.pr[i])*S[i]-a[i]*p.lower)/(S[i]-a[i])
  G.wc[i] <- tmp/(1-tmp)
}

#### Web Appendix A, Web Table 1 (Time Varying Propensity Quantiles)
library(optmatch)
library(doParallel)

expit <- function(u.diff,gam) exp(gam*u.diff)/(1+exp(gam*u.diff))

# construct distance matrix where distance between u_i and u_j
# defined as 1-expit(gam*(u_i-u_j))... note that "distances" aren't 
# truly distances since they are not symmetric but not an issue 
# in bipartite matching.
dist_mat <- function(u,S,gam) {
  dist.mat <- 1-sapply(c(1:S),function(s) expit(u[s]-u[(S+1):(2*S)],gam))
  rownames(dist.mat) <- c(1:S)
  colnames(dist.mat) <- c((S+1):(2*S))
  return(dist.mat)
}

# function to compute sup of average bias (p_bar) over
# all permutations of u given worst case bias exp(gam)
# (see RHS of eq (7) in section 4.5)

#### NOTE: To take sup over permutations of u in eq (7) we
# sort the 2S elements of the u vector and do a bipartite
# match of the smallest S to the largest S that maximizes
# the RHS of eq (7)
p_bar_worst <- function(u,S,gam) {
  match.tmp <- fullmatch(dist_mat(u,S,gam),min.controls = 1,max.controls = 1)
  match.ind <- as.numeric(substr(match.tmp,3,10))
  
  u.pairs <- matrix(rep(NA,(2*S)),ncol=2)
  u.pairs[match.ind[1:S],1] <- u[1:S]
  u.pairs[match.ind[(S+1):(2*S)],2] <- u[(S+1):(2*S)]
  u.diff <- u.pairs[,1]-u.pairs[,2]
  return(mean(expit(u.diff,gam)))
}

# number of Monte Carlo draws
n.sim <- 1000
# test level
alp <- 0.05

# This code is slow since for each draw we compute an optimal 
# bipartite matching for the U_{si}... So we run in parallel
cl <- makeCluster(4)
registerDoParallel(cl)

# Monte Carlo draws of lower bound on worst case calibrated bias
# corresponding to average case calibrated bias at which test is 
# just significant at 0.05 level
p.unif <- foreach(j=c(1:4), .packages = c("optmatch"), .combine = "cbind") %dopar% {
  p.tmp <- rep(NA,n.sim)
  for(i in c(1:n.sim)) {
    u <- sort(runif(2*S[j],0,1), decreasing = TRUE)
    p.tmp[i] <- uniroot(function(g) 1-pbinom(D.1[j],S[j],p_bar_worst(u,S[j],g))-alp,c(0,5))$root
  }
}
          
closeCluster(cl)

# compute the expected lower bound on worst case calibrated bias
# and the associated standard error
G.star.mean <- colMeans(exp(p.unif))
G.star.se <- apply(exp(p.unif),2,function(G) sd(G)/sqrt(n.sim))
          