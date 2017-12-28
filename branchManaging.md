Pour créer une branche :
```
git branch <nomDeLaBranche>
```
Pour switch sur la nouvelle branche :
```
git checkout <leNomDeLaBranche>
```

La branche sera crée sur le repo (le site github) que quand vous aurez fait un push.

Maintenant que la branche est crée, et que vous etes dessus (et fait 2-3 modif parce que ca sert a ca) :
```
git add .
git commit -m "Un message vite-fait avec des explications sur ce que vous avez fait"
git push origin <leNomDelaBranche>
```
La normalement la branche est créée sur le sit github et tout le monde peut la voire.


Du coup vous continuez a taffer sur votre branche, en faisant régulierement des commits pour pouvoir revert si besoin

Quand la fonctionnalité de la branche est terminée : commit/push sur la branche, normal.
Ensuite il faut faire une PR (Pull Request). Pour ca, il faut aller dans la liste des branches sur github et il y a un bouton créer une pull request vers la branche master.

Clic dessus et apres c'est l'inconnu mdr

enfin nan il y a 2 choix :
1. La branche master n'a pas été modifiée depuis que vous avez créé votre branche dans ce cas la EZ PZ, on merge la PR et done.
2.  La branche master a été modifiée depuis que vous avez créé votre branche et la je sais pas comment ca se passe, parce qu'il faut rebase (je crois que c'est le mot) c'est a dire ajouter les changements de master a votre branche et enfin, merge votre branche sur master et la c'est bon, next branche, next fonctionnalité.
