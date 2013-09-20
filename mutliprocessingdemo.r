require(snowfall)

#make some fake data
sizex = 200000
x <- data.frame(one = sample(x = seq(1, 100, 1),size = sizex, replace = T),
                two = sample(x = seq(1, 100, 1),size = sizex, replace = T),
                three = sample(x = seq(1, 100, 1),size = sizex, replace = T),
                four = sample(x = seq(1, 100, 1),size = sizex, replace = T))

#one processor
 one_p <- system.time(apply(X = x, MARGIN = 1, FUN = function(x) {return(mean(x, na.rm = T))}))

#32 processors
sfInit(parallel = T, cpus = 32, type = "MPI")
thirtytwo_p <- system.time(sfApply(x = x, margin = 1, fun= function(x) {return(mean(x, na.rm = T))}))
sfStop()