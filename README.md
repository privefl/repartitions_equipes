# repartitions_equipes

### Description

Application [shiny](http://shiny.rstudio.com/) pour répartir les matchs d'un tournoi où chaque équipe doit affronter toutes les autres.

### Ancienne solution

Comme je n'avais pas trouvé de solution déterministe à ce problème, j'ai d'abord programmé un [algorithme probabiliste](https://fr.wikipedia.org/wiki/Algorithme_probabiliste). 
L'algorithme avait un cout exponentiel. 
En pratique, il était très rapide jusqu'à 10 équipes. Pour 11 et 12 équipes, cela pouvait prendre jusqu'à une heure.

### Nouvelle solution

J'ai trouvé une solution déterministe à ce problème! J'applique ensuite une permutation aléatoire sur les équipes et les journées de matchs pour rendre le résultat complètement aléatoire. La solution fait aussi en sorte que chaque équipe reçoive autant à domicile que les autres.

### Lancement de l'application

Pour lancer l'application dans R :
```r
shiny::runGitHub("privefl/repartitions_equipes")
```
