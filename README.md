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

### Parties essentiels du Lua Scripts

Vous voulez créer une catégorie type "action" en pressant un bouton, catégorie "liste" pour cliquer et trouver autre chose, "slider", etc..., elles peuvent vous servir.
> Commençons par initialiser une nouvelle variable dont on intégrera `menu.my_root()`.
```ruby
local mon_menu = menu.my_root()
```

> Maintenant, tu veux créer une catégorie "action" pour boutton
Pour comprendre, mon_menu désigle commandRef, par défaut, c'est: ```menu.my_root()```, entre crochet désigne le nom de la commande, t'en a déjà vu passer des noms de commandes dans le mod menu Stand tel que "bottomless", "fillammo"..., c'est le même principe, crée ta propre commande. La troisième argument entre guillemet désigne la description de l'action/liste, etc... pour savoir c'est quoi au juste.

Attention: Les commandes entre crochets ne doit pas contenir d'espaces, comme ça: ```{"crack test"}```
```
local mon_menu = menu.my_root()

menu.action(mon_menu, "Salut", {"salut1"}, "Description 1", function()
  util.toast("Salut, c'est mon premier Lua Script")
end)
```
