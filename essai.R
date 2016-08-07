source("useful_functions.R")

choisir_matchs <- function(matchs_a_repartir, nb_matchs_par_jour, fin, exempt = NULL) {
  
  if (fin) { # c'est la derniere journee
    
    if (all(dim(matchs_a_repartir) == c(2, nb_matchs_par_jour))) {
      #print(matchs_a_repartir)      
      return(list(matchs_a_repartir, "fin"))
    } else {
      return(FALSE)
    }    
    
  } else { # ce n'est pas la derniere journee
    
    # on enleve les matchs de l'exempt de la journee
    if (is.null(exempt)) {
      matchs_a_considerer = matchs_a_repartir
    } else {
      matchs_a_considerer = retirer_matchs_exempt(matchs_a_repartir, exempt)
      if (!matchs_a_considerer) {
        return(FALSE)
      }
    }
    
    matchs_du_jour = matrix(0, 2, nb_matchs_par_jour)
    for (i in 1:(nb_matchs_par_jour-1)) {
      if (is.null(dim(matchs_a_considerer))) {
        #print("Erreur 11 ici !")
        return(FALSE)
      } else {      
        nb_mac = dim(matchs_a_considerer)[2]
        match = choisir_match_hasard(matchs_a_considerer, nb_mac)
        matchs_du_jour[,i] = match      
        matchs_a_considerer = retirer_equipes_match(matchs_a_considerer, match)   
        if (!matchs_a_considerer) {
          return(FALSE)
        }
      }      
    }
    #print(matchs_du_jour)
    nb_mac = dim(matchs_a_considerer)[2]
    if (length(matchs_a_considerer) == 2) {
      matchs_du_jour[,nb_matchs_par_jour] = matchs_a_considerer
    } else  {
      return(FALSE)
    } 
    #print(matchs_du_jour)
    
    return( list(matchs_du_jour, 
                 retirer_matchs_joues(matchs_a_repartir, matchs_du_jour, nb_matchs_par_jour) ) 
            )
    
  }  
  
}


matchs_par_jour <- function(nb_equipes) {
  N = nb_equipes
  if (N > 12) stop("Rzsultat trop long a obtenir pour plus de 12 equipes")
  nb_matchs_par_jour = floor(N/2)
  equipes = 1:N  
  matchs_a_repartir = combn(equipes, 2)
  #printf("Doivent s'affronter :\n")
  #print(matchs_a_repartir)
  odd = (N %% 2 == 1)
  
  if (odd) {
    solution_trouvee = FALSE
    while (!solution_trouvee) {
      mar = matchs_a_repartir
      fin = FALSE
      repartition = array(data = 0, dim = c(N, 2, nb_matchs_par_jour))
      for (exempt in 1:N) {
        #printf("Avancement : %d\n", exempt)
        if (exempt == N) {
          fin = TRUE
          #print("On est arrives jusqu'ici")
        }
        #readkey()
        res = choisir_matchs(mar, nb_matchs_par_jour, fin, exempt)
        
        if (identical(res, FALSE)) { # il y a eu une erreur
          break
        } else {
          #print(res)
          mar = res[[2]]
          repartition[exempt,,] = res[[1]]
          if (mar == "fin") {
            solution_trouvee = TRUE
          }            
        }
        
      }
    }  
    printSpecial(repartition, N)
    
  } else {
    solution_trouvee = FALSE
    while (!solution_trouvee) {
      mar = matchs_a_repartir
      fin = FALSE
      repartition = array(data = 0, dim = c(N-1, 2, nb_matchs_par_jour))
      for (exempt in 1:(N-1)) {
        #printf("Avancement : %d\n", exempt)
        if (exempt == (N-1)) {
          fin = TRUE
          #print("On est arrives jusqu'ici")
        }
        #readkey()
        res = choisir_matchs(mar, nb_matchs_par_jour, fin)
        
        if (identical(res, FALSE)) { # il y a eu une erreur
          break
        } else {
          #print(res)
          mar = res[[2]]
          repartition[exempt,,] = res[[1]]
          if (mar == "fin") {
            solution_trouvee = TRUE
          }            
        }
        
      }
    }  
    printSpecial(repartition, N-1)
  }  
}