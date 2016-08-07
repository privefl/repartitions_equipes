# repartitions_equipes
Application shiny pour répartir les matchs d'un tournoi où chaque équipe affronte toutes les autres (jusqu'à 12 équipes).

Comme je ne connais pas de solution déterministe à ce problème, j'ai programmé un algorithme aléatoire.

L'algorithme n'est pas optimisé et a un cout exponentiel. 
En pratique, c'est très rapide jusqu'à 10 équipes. Pour 11 et 12 équipes, cela peut mettre assez longtemps.

Pour lancer l'application dans R :
```r
shiny::runGitHub("privefl/repartitions_equipes")
```
