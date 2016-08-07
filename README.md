# repartitions_equipes
Application [shiny](http://shiny.rstudio.com/) pour répartir les matchs d'un tournoi où chaque équipe doit affronter toutes les autres (jusqu'à 12 équipes).

Comme je ne connais pas de solution déterministe à ce problème, j'ai programmé un [algorithme probabiliste](https://fr.wikipedia.org/wiki/Algorithme_probabiliste).

L'algorithme n'a pas été optimisé et a un cout exponentiel. 
En pratique, c'est très rapide jusqu'à 10 équipes. Pour 11 et 12 équipes, cela peut prendre jusqu'à une heure.

Pour lancer l'application dans R :
```r
shiny::runGitHub("privefl/repartitions_equipes")
```
