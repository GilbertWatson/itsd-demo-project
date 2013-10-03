require(snowfall)

#make some fake data
sizex = 10000
x <- data.frame(one = sample(x = seq(1, 100, 1),size = sizex, replace = T),
                two = sample(x = seq(1, 100, 1),size = sizex, replace = T),
                three = sample(x = seq(1, 100, 1),size = sizex, replace = T),
                four = sample(x = seq(1, 100, 1),size = sizex, replace = T))

#make a function that does alot of sampling
sf <- function(x) {
  return((mean(x, na.rm = T)*mean(rnbinom(n=1000, #1000 random samples from negative binomial
                                          prob=runif(n=1,min=0,max=10)/10, #with a random p from a uniform
                                          size=300)))) #with 300 targets for success out of 1000
}

#one processor
one_p <- system.time(apply(X = x, 
                           MARGIN = 1, 
                           FUN = sf))

#32 processors
sfInit(parallel = T, cpus = 32, type = "MPI")
thirtytwo_p <- system.time(sfApply(x = x, 
                                   margin = 1, 
                                   fun = sf))
sfStop()

#print
cat(paste("With One Processor: ", one_p[3], "\nWith 32 Processors: ", thirtytwo_p[3],sep=""))

#this is a comment