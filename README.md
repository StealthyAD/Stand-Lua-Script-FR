# stand-ExampleScript
French version of Example Script which means it will make you how to begin Lua Script with minimum knowledge.

Version français pour bien commencer dans le domaine du Lua.
Vous êtes débutant mais vous ne savez pas où par commencer, bien joué.
Il ne faut pas s'inquiéter des termes compliqués ou bizarres, il faut savoir comprendre et à quoi peut-elle servir.
Les sites utiles pour comprendre les Lua & Natives.
- [nativeDB](https://nativedb.dotindustries.dev/natives)  
- [Stand API]( https://stand.gg/help/lua-api-documentation)
- [Docs FiveM](https://docs.fivem.net/natives/)

# Démarrage du script
Il est facile d'allumer le script, imaginons dans un cas, tu crées un lua script sans rien mettre, le lua script va nettement s'arrêter.
Alors utilise ceci si tu ne veux pas que le lua script se retrouve stoppé.
Vous pouvez placer soit au début du lua script ou à la fin selon vos préférences.

```
util.keep_running()
```

# Les natives
Imaginons dans un cas, vous voulez faire du n'importe quoi dans votre Lua Script et que vous aurez besoin d'exploiter, exploiter les natives vous servent d'indication et comment le paramétrer.
Attention: il faut vérifier que ça soit la dernière version.
Des natives dans une liste interminable, vous pouvez les retrouver via "Lua Scripts/lib" et tout les noms commencent par "natives-".

Ce sont des exemples de natives dans Stand.
```
natives-1606100775
natives-1627063482
```
Et une liste interminable, vous comprenez, utiliser spécifiquement à vos besoins.

Mais comment les intégrer? Selon vos besoins, vous allez besoin d'avoir de "util.require_natives"
```
util.require_natives(1663599433) 
```

Ou soit (version longue), cela revient à la même chose:

`
util.requires_natives("natives-1663599433")
`

# Les menus
Il existe différents types de menus dans le Lua Script de Stand.
> Le menu root est la partie la plus essentielle et obligatoire dans un Lua Script, dirais-je pourquoi? Elle permet d'initialiser la visualisation des menus affichés, imaginons vous voulez afficher la liste "Armes", "Troll", etc..., il est facile de le faire. Vous aurez besoin de: ```menu.my_root()```

Exemple concret:
```red
local root = menu.my_root()
```

> Le menu joueur est la partie la moins essentielle dans un Lua Script, dirais-je pourquoi? Elle est optionelle si dans vos besoins, vous n'avez pas besoin de la partie joueur si vous vous contentez à créer des projets externes tels que les Recovery, des luas scripts utilitaires ne mettant pas en relation avec les joueurs, il faut aborder comment l'utiliser. Vous aurez besoin de : ```menu.player_root()```. On reviendra de suite comment faire fonctionner la partie joueur

Exemple concret:
```
players.on_join(function(pid) -- "pid" cible spécifiquement le joueur.
    local playeroot = menu.player_root(pid)
end)
```

## Partie essentiels du Lua Script

### Les boutons actions (menu.action)

Vous voulez créer une catégorie type "action" en pressant un bouton, catégorie "liste" pour cliquer et trouver autre chose, "slider", etc..., elles peuvent vous servir.
> Commençons par initialiser une nouvelle variable dont on intégrera `menu.my_root()`.
```ruby
local mon_menu = menu.my_root()
```

> Maintenant, tu veux créer une catégorie "action" pour boutton
Pour comprendre, mon_menu désigle commandRef, par défaut, c'est: ```menu.my_root()```, entre crochet désigne le nom de la commande, t'en a déjà vu passer des noms de commandes dans le mod menu Stand tel que "bottomless", "fillammo"..., c'est le même principe, crée ta propre commande. La troisième argument entre guillemet désigne la description de l'action/liste, etc... pour savoir c'est quoi au juste.

Attention: Les commandes entre crochets ne doit pas contenir d'espaces, comme ça: ```{"crack test"}```

Premier exemple (sans la variable mon_menu intégré)
--------------------
```
menu.action(menu.my_root(), "Salut", {"salut1"}, "Description 1", function()
  util.toast("Salut, c'est mon premier Lua Script")
end)
```

Second exemple (avec la variable mon_menu intégré)
--------------------
```
local mon_menu = menu.my_root()

menu.action(mon_menu, "Salut", {"salut1"}, "Description 1", function()
  util.toast("Salut, c'est mon premier Lua Script")
end)
```

Dernier exemple (avec la variable mon_menu intégré)
--------------------
```
local mon_menu = menu.my_root()

mon_menu:action("Salut", {"salut1"}, "Description 1", function()
  util.toast("Salut, c'est mon premier Lua Script")
end)
```

### Le bouton liste (menu.list)

Vous comprendrez pourquoi les exemples sont différents, c'est selon votre choix comment vous voulez soit laisser le code par défaut, soit donner quelque chose d'esthétique, simpliste ou clean.

> Tu veux créer une liste qui permet de catégoriser certains types de fonctions/options, etc... ?
Même exemple, on utilisera ```menu.list(commandRef, "Nom", {"commande"}, "Description", function()end)``` pour faire fonctionner, on utilisera la variable qu'on a crée dont mon_menu. L'exemple à suivre, j'ai crée une autre variable dont elle va être en redirection de la catégorie qu'on souhaite voir par exemple Salut dans la catégorie. Elle s'applique à m'importe quel type de "menu.", peu importe.

Premier Exemple
--------------------
```
local mon_menu = menu.my_root()

local CategorieSuivant = menu.list(mon_menu, "Message Test") -- Vous n'avez pas besoin de rajouter d'autres éléments, ceci est optionelle.

menu.action(CategorieSuivant, "Salut", {"salut1"}, "Description 1", function() -- On a ajouté CategorieSuivant pour ça.
  util.toast("Salut, c'est mon premier Lua Script")
end)
```

Deuxième Exemple
--------------------
```
local mon_menu = menu.my_root()

local CategorieSuivant = menu.list(mon_menu, "Message Test") -- Vous n'avez pas besoin de rajouter d'autres éléments, ceci est optionelle.

CategorieSuivant:action("Salut", {"salut1"}, "Description 1", function() -- On a ajouté CategorieSuivant au début au détriment de "menu." pour ça.
  util.toast("Salut, c'est mon premier Lua Script")
end)
```

# Les boutons boucles finis (menu.toggle) / infinies (menu.toggle_loop)

> Passons à autre chose, les boucles, il existe deux types de boucles:
- les boucles finies, qui se finit direct comme le dit son nom avec: `menu.toggle(commandref, "nom", {"command"}, "description", function() end)`
- les boucles infinies, qui se finit jamais, repérable avec: `menu.toggle_loop(commandRef, "nom", {"cmd"}, "desc", function()end)`

Premier exemple (Boucle infini)
--------------------
```
local mon_menu = menu.my_root()

menu.toggle(mon_menu, "Vérifier si il y'a des chiottes", {"chiottetoggle"}, "description 1", function(toggle) -- Dans un cas précis, vous voulez "toggle", alors vous pouvez, nommer le peu importe, toggled, f, on, etc... Soyez créatif en tt cas.
    if toggle then 
        util.toast("Les chiottes sont présents à Los Santos")
    else -- vous donnez une autre condition si elle s'arrête, en gros, vous le désactiver, il affiche qqch
        util.toast("Arrêt des recherches de chiottes")
    end
end)
```
Second exemple (Boucle infini)
--------------------
```
local mon_menu = menu.my_root()

menu.toggle_loop(mon_menu, "Vérifier si il y'a des chiottes", {"chiottes"}, "description 1", function() -- Dans un cas précis, vous n'avez pas besoin de "toggle" comme dans l'autre, il est en boucle.
    util.toast("Les chiottes sont présents à Los Santos") -- affiche en permanence le message suivant.
end, function()
    util.toast("Arrêt des recherches de chiottes")
end)
```
