# fonction d'ecriture
printf <- function(...)cat(sprintf(...))

# retire les matchs de l'equipe exempte des matchs a considerer
retirer_matchs_exempt <- function(matchs_a_repartir, exempt) {
  if (is.null(dim(matchs_a_repartir))) { # ce n'est pas normal
    return(FALSE)
  } else {    
    indices_a_garder = which(apply(matchs_a_repartir == exempt, 2, sum) == 0)     
    if (isEmpty(indices_a_garder)) { # ce n'est pas normal
      return(FALSE)
    } else { # c'est le cas normal de preparation d'une journee
      return( matchs_a_repartir[,indices_a_garder] )
    }
  }  
}

# retire les matchs d'une journee a la liste des matchs a repartir
retirer_matchs_joues <- function(matchs_a_repartir, matchs_du_jour, nb_matchs_par_jour) {
  nb_mar = dim(matchs_a_repartir)[2]
  ind_a_retirer = integer(nb_matchs_par_jour)
  for (k in 1:nb_matchs_par_jour) {
    for (j in 1:nb_mar) {
      if (all(matchs_a_repartir[,j] == matchs_du_jour[,k])) {
        ind_a_retirer[k] = j
        break
      }
    }
  }  
  #print(ind_a_retirer)
  #stopifnot(length(ind_a_retirer) == nb_matchs_par_jour)
  
  return(matchs_a_repartir[,-ind_a_retirer])
}

# choisit un match au hasard parmi les matchs a considerer
choisir_match_hasard <- function(matchs_a_considerer, nb_matchs) {
  #print(nb_matchs)
  matchs_a_considerer[,sample(1:nb_matchs,1)]
}

# retire les equipes du match des matchs a considerer
retirer_equipes_match <- function(matchs_a_considerer, match) {
  equipe1 = match[1]
  equipe2 = match[2]
  
  matchs_a_considerer = retirer_matchs_exempt(matchs_a_considerer, equipe1)
  matchs_a_considerer = retirer_matchs_exempt(matchs_a_considerer, equipe2)
  
  return(matchs_a_considerer)
}

readkey <- function()
{
  cat ("Press [enter] to continue")
  line <- readline()
}

isEmpty <- function(x) {
  return( identical(x, numeric(0)) | identical(x, logical(0)) | identical(x, integer(0)) )
}

printMatches <- function(mat) {
  for (j in 1:ncol(mat)) {
    printf("\t equipe %d contre equipe %d\n", mat[1, j], mat[2, j])
  }
}

printSpecial <- function(repartition, N) {
  for (i in 1:N) {
    printf("En jour %d s'affrontent :\n", i)
    printMatches(repartition[i,,])
    printf("\n")    
  }
}