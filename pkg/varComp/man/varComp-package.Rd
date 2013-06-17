\name{varComp-package}
\alias{varComp-package}
\docType{package}
\title{
Variance Component Models
}
\description{
This package includes functions for fitting and testing variance component models, i.e., linear mixed-effect models with linear variance-covariance structures. 
}
\details{
\tabular{ll}{
Package: \tab varComp\cr
Type: \tab Package\cr
Version: \tab 0.1-305\cr
Date: \tab 2013-06-17\cr
License: \tab GPL3\cr
}

\itemize{
	\item \code{\link{varComp}}: fitting variance component models.
	\item \code{\link{varComp.test}}: testing variance components. 
%	\item \code{\link{satterth}}: testing fixed-effect parameters by the Satterthwaite type method. 
%	\item \code{\link{KR}}: testing fixed-effect parameters by the Kenward-Roger method. 
}
}
\author{
Long Qu

Maintainer: Long Qu <longor@iastate.edu>
}
\references{
	Qu L, Guennel T, Marshall SL. (2013+) Linear Score Tests for Variance Components in Linear Mixed Models and Applications to Genetic Association Studies. \emph{Biometrics}, under revision. 
	
}
\keyword{ package }
\seealso{
 \code{\link[nlme]{lme}} 
}
\examples{
### Oxide/Semiconductor example
library(nlme)
data(Oxide)
lmef = lme(Thickness~Source, Oxide, ~1|Lot/Wafer)
vcf = varComp(Thickness~Source, Oxide, ~Lot/Wafer)
VarCorr(lmef)
coef(vcf, 'varComp') ## same values as above

### Genetics example	
trt=gl(2, 15)
set.seed(2340)
dat=data.frame(trt=trt, id=as.factor(1))
dat$SNP=matrix(sample(0:2, 120, replace=TRUE), 30)
dat$Y  = as.numeric(trt)+rnorm(30) + dat$SNP\%*\%rnorm(4)
(vcf0 = varComp(Y~trt, dat, ~ibs(SNP)))
(vcf00 = varComp(Y~trt, dat, varcov = list(`ibs(SNP)`=IBS(dat$SNP)))) ## same as above
(vcf1 = varComp(Y~trt, dat, ~ibs(SNP):trt)) ## two variance components
summary(vcf0)

varComp.test(vcf0, vcf1)
varComp.test(vcf1, null=1)
varComp.test(Y~trt, dat, random1=~ibs(SNP), random2=~trt:ibs(SNP))


}