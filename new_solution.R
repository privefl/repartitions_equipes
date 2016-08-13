# fonction d'ecriture
printf <- function(...)cat(sprintf(...))

printMatches <- function(jour) {
  p <- length(jour) / 2
  for (i in 1:p) {
    printf("\tequipe %d contre equipe %d\n", jour[2*i - 1], jour[2*i])
  }
}

printSpecial <- function(repartition) {
  m <- ncol(repartition)
  for (j in 1:m) {
    printf("En jour %d s'affrontent :\n", j)
    printMatches(repartition[, j])
    printf("\n")    
  }
}


RepartImpair <- function(N) {
  # Nombre d'équipes jouant chaque jour
  n <- N - 1
  # Nombre de matchs par jour
  p <- n / 2
  # Nombre de jours de matchs
  m <- N
  
  res <- matrix(0, n, m)
  ind1 <- rev(seq(1, n, 2))
  ind2 <- seq(2, n, 2)
  for (i in 1:p) {
    k <- ind1[i]
    j <- ind2[i]
    
    # 1ere partie
    res[k, 1:j] <- seq(p - i + 1, by = 1, length.out = j)
    res[k + 1, 1:j] <- N - p + i
    
    # 2eme partie 
    res[k, (j + 1):m] <- seq(i + 1, by = 1, length.out = m - j)
    res[k + 1, (j + 1):m] <- i
  }
  
  res
}

RepartPair <- function(N) {
  # Get the result with N - 1
  res.impair <- RepartImpair(N - 1)
  
  n <- nrow(res.impair)
  m <- ncol(res.impair)
  
  j <- n / 2
  missing <- numeric(m)
  missing[seq(1, m, 2)] <- (j + 1):m
  missing[seq(2, m, 2)] <- 1:j
  
  rbind(res.impair, missing, N)
}

Repart <- function(N, to.print = TRUE) {
  if (N < 3) stop("N should be at least 3")
  if ((N %% 2) == 1) {
    res <- RepartImpair(N)
  } else {
    res <- RepartPair(N)
  }
  
  # swap half of the columns
  n <- nrow(res)
  m <- ncol(res)
  ind1 <- seq(1, n, 2)
  ind2 <- seq(2, m, 2)
  tmp <- res[ind1, ind2] 
  res[ind1, ind2] <- res[ind1 + 1, ind2] 
  res[ind1 + 1, ind2] <- tmp
  
  # ramdomly swap teams
  sample.N <- sample(N)
  res <- matrix(sample.N[res], n, m)
  
  # ramdomly swap days of matchs
  res <- res[, sample(m)]
  
  if (to.print) {
    printSpecial(res)
  } else {
    printf("Les colonnes representent les jours.\n")
    printf("Les lignes (par paires) representent les matchs joues.\n\n")
    print(res)
  }
}
