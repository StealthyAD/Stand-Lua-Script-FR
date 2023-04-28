--[[
    French Version of Example Script.
    Site pour débuter (en anglais) https://github.com/Keramis/Lua_STANDAPI

    Deux sites nécessaires pour comprendre l'utilisation, vous avez aussi FiveM pour comprendre les Natives
    nativeDB = https://nativedb.dotindustries.dev/natives  
    Stand API = https://stand.gg/help/lua-api-documentation 
    FiveM = https://docs.fivem.net/natives/

    Essayer de comprendre, ceci est juste un début, vous comprenez, vous réussissez, n'ayez pas peur de votre échec, c'est comme réussir dans la vie.
    Si tu ne comprends pas, essaie quand même, abandonner c'est comme abandonner les mathématiques ou l'informatique, à l'échec.

    Peut importe le type de fichier Lua/Pluto, vous offrez différents moyens.
    Commençons par comment faire, maintenir son Lua Script constamment allumé, vous pouvez mettre m'importe ou, soit au début ou à la fin.
]]--

util.keep_running() -- Tu supprimes, le lua script s'arrête nettement sans problème.

--[[
    Imaginons dans un cas, vous voulez faire du n'importe quoi dans votre Lua Script et que vous aurez besoin d'exploiter, exploiter les natives vous servent d'indication et comment le paramétrer
    Attention: il faut vérifier que ça soit la dernière version.

    Des natives dans une liste interminable, vous pouvez les retrouver via "Lua Scripts/lib" et tout les noms commencent par "natives-"

    natives-1606100775
    natives-1627063482
    natives-1640181023
    natives-1651208000
    Et une liste interminable, vous comprenez, utiliser spécifiquement à vos besoins.
]]--

util.require_natives(1663599433) -- ou util.requires_natives("natives-1663599433") version longue, c'est la même chose comment vous l'écrivez

--[[
    Chose suivante, vous voulez afficher des boutons tels que "Soi", "Véhicule", "Fun", etc... mais vous ne savez pas comment faire, bah je vais vous expliquer.
    En premier temps, vous aurez besoin de ça: menu.my_root(), permet d'initialiser le menu principal, en gros vous allez afficher qqch dans le menu principal.
    Je vais vous donner quelques exemples

    Pour comprendre le fonctionnement à l'intérieur, menu... autre que ça, vous avez une liste dans le site de Stand.

    Exemple: menu.action(menu.my_root(), "Exemple", {}, function()end) -- décomposons en partie:
    menu.action(CommandRef, "Bouton Commande/Affiche le nom", {"commande"}, "Description", function() 
        -- Par exemple tu intègres le code à l'intérieur
    end)
]]--

menu.list(menu.my_root(), "Exemple", {}, "", function()end)

--[[
    Imaginons, t'en a marre que ton script ressemble à ça: 

    menu.action(menu.my_root(), "Affiche le message", {"affichermessage"}, "Description", function() 
        util.toast("Salut à tous.")
    end)

    Mais que t'aimerais que ça soit plus simplifié.
    Crée un "local" dont tu appeleras peut importe.
    Pour ma part je l'ai appelé caca
]]--

local caca = menu.my_root()

--[[
    Maintenant, c'est très simple, initialise caca dans "commandRef"
    Dans un second cas, tu veux que ca soit plus simplifié aussi?
]]--

menu.action(menu.my_root(), "Affiche le message", {"affichermessage"}, "Description", function() -- sans la variable "caca"
    util.toast("Salut à tous.")
end)

menu.action(caca, "Affiche le message", {"ouioui"}, "Description", function() -- la variable "caca" apparait
    util.toast("Test 2")
end)

-- Second cas:

caca:action("J'aime le caca", {"caca"}, "Description", function() -- la variable "caca" au début apparait : caca:action en remplaçant menu. / Suppression de commandRef, tu recrées commme ça: caca.action(caca, ""), cela ne marchera pas
    util.toast("Caca boudain.")
end)

--[[
    Tu veux créer une suite de catégorie comme dans Stand, exemple: Soi > Armes comme ça
    Alors c'est très facile.
    Tu créeas encore une variable mais tu créeas une liste.
    Exemples:
]]--

local cacalist = menu.list(caca, "Liste des Cacas") -- la variable "caca", on a repris à partir de : "local caca = menu.my_root()"

menu.action(cacalist, "J'aime le caca 2", {"caca21"}, "Description", function() -- la variable "cacalist" apparait dans le commandRef
    util.toast("Caca boudain.")
end)

cacalist:action("J'aime le caca", {"caca"}, "Description", function() -- la variable "cacalist" apparait au début
    util.toast("Caca boudain.")
end)

-- Ou
--> local cacalist = caca:list("Liste des Cacas") (c'est la même chose mais rapide)
-- Tu peux créer ainsi des suites à l'illimité sans problème, maintenant passons à autre chose.

--[[
    Passons à autre chose, les boucles, il existe deux types de boucles:
    - les boucles finies, qui se finit direct comme le dit son nom avec: menu.toggle(commandref, "nom", {"command"}, "description", function() end)
    - les boucles infinies, qui se finit jamais, repérable avec: menu.toggle_loop(commandRef, "nom", {"cmd"}, "desc", function()end)
]]--

-- Exemple 1

    menu.toggle(caca, "Vérifier si les cacas sont présents", {"cacatoggle"}, "description 1", function(toggle) -- Dans un cas précis, vous voulez "toggle", alors vous pouvez, nommer le peu importe, toggled, f, on, etc... Soyez créatif en tt cas.
        if toggle then 
            util.toast("Les cacas sont présents à Los Santos")
        else -- vous donnez une autre condition si elle s'arrête, en gros, vous le désactiver, il affiche qqch
            util.toast("Arrêt des recherches de cacas")
        end
    end)

-- Exemple 2

    menu.toggle_loop(caca, "Cacas constant", {"cacatoggleon"}, "description 1", function() -- Dans un cas précis, vous n'avez pas besoin de "toggle" comme dans l'autre, il est en boucle.
        util.toast("Les cacas sont présents à Los Santos") -- affiche en permanence le message suivant.
    end, function()
        util.toast("Arrêt des recherches de cacas")
    end)

--[[
    Dans un cas normal, vous avez le bazar dans votre lua script et les catégories sont bizarres, il est possible de re-catégoriser, en modifiant l'ordre comment vous le mettez, juste copier coller ou supprimer et
    remettre au bon endroit, c'est un puzzle simple

    Exemple concret, le premier affichera "Vérifier si les cacas sont présents" et en dessous: "Cacas Présents"
    menu.toggle(caca, "Vérifier si les cacas sont présents", {"cacatoggle"}, "description 1", function(toggle) -- Dans un cas précis, vous voulez "toggle", alors vous pouvez, nommer le peu importe, toggled, f, on, etc... Soyez créatif en tt cas.
        if toggle then 
            util.toast("Les cacas sont présents à Los Santos")
        else -- vous donnez une autre condition si elle s'arrête, en gros, vous le désactiver, il affiche qqch
            util.toast("Arrêt des recherches de cacas")
        end
    end)

    menu.toggle_loop(caca, "Cacas constant", {"cacatoggleon"}, "description 1", function() -- Dans un cas précis, vous n'avez pas besoin de "toggle" comme dans l'autre, il est en boucle.
        util.toast("Les cacas sont présents à Los Santos") -- affiche en permanence le message suivant.
    end, function()
        util.toast("Arrêt des recherches de cacas")
    end)

    Pour faciliter, ré-organiser comme le souhaitez, 

    Exemple concret, le premier affichera "Cacas Présents" et en dessous: "Vérifier si les cacas sont présents"

    menu.toggle_loop(caca, "Cacas constant", {"cacatoggleon"}, "description 1", function() -- Dans un cas précis, vous n'avez pas besoin de "toggle" comme dans l'autre, il est en boucle.
        util.toast("Les cacas sont présents à Los Santos") -- affiche en permanence le message suivant.
    end, function()
        util.toast("Arrêt des recherches de cacas")
    end)

    menu.toggle(caca, "Vérifier si les cacas sont présents", {"cacatoggle"}, "description 1", function(toggle) -- Dans un cas précis, vous voulez "toggle", alors vous pouvez, nommer le peu importe, toggled, f, on, etc... Soyez créatif en tt cas.
        if toggle then 
            util.toast("Les cacas sont présents à Los Santos")
        else -- vous donnez une autre condition si elle s'arrête, en gros, vous le désactiver, il affiche qqch
            util.toast("Arrêt des recherches de cacas")
        end
    end)

    Vous pouvez aussi séparer avec des colonnes, dites divider
]]

    menu.divider(caca, "Caca Division") -- pas besoin de rajouter plus.

--[[
    Passons à autre chose, les boucles, tu veux faire du n'importe quoi en mode online et que tu veux exploser tout le monde sans problème ou que t'aimerais bien que tu n'attaques pas tes amis, soit tes ennemies, soit toi-même
    Il existe une solution si tu veux créer cela.

    Dispose toi à te servir du site Stand.gg

    players.list(self, friends, strangers, crewmembers, organization) -- c'est comment on l'organise

    Imaginons, tu ne veux pas que toi, te fasse tuer ou être affecté, alors tu vas utiliser un booléan, cela consiste à dire vrai ou faux, en langage informatique, on utilisera true ou false

    Exemple 1: for _, pid in pairs(players.list(false, false, true, false, true)) -- j'ai remplis quelques conditions.
    Pourquoi intégrer for, c'est un exemple, for désigne ce que tu vas sélectionner, et c'est un exemple concret.

    Certain lua scripts disposent des "Exclusions", donc je pourrais t'en proposer de ma manière.
    J'ai décidé de créer une variable "ExclureSoi" et une fonction.
    Il est possible de créer aussi pour vous amis, membres organisations, crew ou étrangers
]]--

    local ExclureSoi = true -- vous laissez false, vous êtes épargné.
    local function toggleSelfCallback(toggle)
        ExclureSoi = not toggle
    end

    menu.toggle(caca, "Exclure Soi", {"toggleself"}, "Exclure des fonctionnalités touchant à soi-même", toggleSelfCallback) -- On a remplacé "function" par toggleSelfCallback pour une question de facilité.

    menu.toggle_loop(caca, "Exploser tout le monde avec du caca", {'autoexplodecaca'}, "", function() 
        for _, pid in pairs(players.list(ExclureSoi, false, true, false, true)) do -- ExclureSoi (-> Redirection si voulez vous-épargner), false -> amis, true -> étrangers dont les joueurs pas amis, false -> membres du crew, true -> membres de l'organisation
            local pos = players.get_position(pid) -- Nous avons pris exemple position du joueur par exemple.
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 1.0, 34, 1, true, false, 0.0, false)
            util.yield(50)
        end
        util.yield(500)
    end)

    -- Il existe plusieurs cas possibles, vous pouvez aussi ajouter une condition en utilisant if, vous lui donner des conditions pour qu'il répond bien à vous attentes.
    -- Imaginons, le mec est en godmode ou que le mec est à l'intérieur, vous donner ce type de condition, comme l'exemple:

    menu.toggle_loop(caca, "Exploseur Caca (Condition si n'est pas à l'intérieur ou godmode)", {'explodecaca'}, "", function()
        for _, pid in pairs(players.list(ExclureSoi, false, true, false, true)) do
            if not players.is_in_interior(pid) or players.is_godmode(pid) then -- vous pouvez aussi ajouter "else", c'est optionnel, ajouter "not" revient à exclure les personnes godmode/intérieur, ne pas ajouter "not" sélectionne les personnes même godmode ou autres
                local pos = players.get_position(pid) 
                FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 1.0, 34, 1, true, false, 0.0, false)
                util.yield(50)
            end
        end
        util.yield(500)
    end)

    menu.divider(caca, "Section Spawn/Ped")

--[[
    Passons à autre chose, tu veux faire spawn un véhicule ou un ped (entité) via à partir du lua script, très simple
]]--

    local function ApparitionModele(hash, msecs)
        util.request_model(hash, msecs)
    end

-- Exemple 1 pour faire apparaitre un Ped    

    menu.action(caca, "Faire apparaitre un Singe", {''}, 'Faites moi apparaitre un singe', function()
        local hash = util.joaat('a_c_chimp')
        ApparitionModele(hash, 2000)
        local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        entities.create_ped(1, hash, pos, 0)
        --PED.CREATE_PED(1, hash, pos.x, pos.y, pos.z, 0, true, true), c'est la même chose mais rapide
    end)

-- Même exemple mais pour un véhicule prédéfini

    menu.action(caca, "Faire apparaitre un véhicule", {''}, 'Faites moi apparaitre un véhicule', function()
        local hash = util.joaat('adder')
        ApparitionModele(hash, 2000)
        local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        entities.create_vehicle(hash, pos, 0)
        --VEHICLE.CREATE_VEHICLE(hash, pos.x, pos.y, pos.z, 0, true, true, false)
    end)

-- Vous n'aimez pas que votre véhicule spawn dans une position vous souhaitez

    menu.action(caca, "Faire apparaitre un véhicule un peu plus loin", {''}, 'Faites moi apparaitre un véhicule', function()
        local hash = util.joaat('adder')
        ApparitionModele(hash, 2000)
        local ped = players.user_ped()
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 5.0, 0.0) -- Vous n'aurez plus besoin d'utiliser vos propres coordonnées, 5.0 en Y coordonnée représente la distance
        entities.create_vehicle(hash, c, 0)
    end)

-- vous voulez que la commande permet de faire spawn des modèles de véhicules à partir d'une commande?
-- même débat, même condition mais en ajoutant:  menu.show_command_box_click_based(text, "comd ") -- texte ou arg ou m'importe

    menu.action(caca, "Apparaitre un véhicule modèle", {'fairespawn'}, 'Faites moi apparaitre un véhicule', function(couille)
        menu.show_command_box_click_based(couille, "fairespawn ")
    end, function(bite) -- Il faut que deux fonctions soit différents l'un l'autre. Exemple "couille" désigne le texte commande, "bite" ce que va exécuter après.
        local hash = util.joaat(bite)
        ApparitionModele(hash, 2000)
        local ped = players.user_ped()
        local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 5.0, 0.0) 
        entities.create_vehicle(hash, c, 0)
    end)

    -- Second condition mais modèle invalide. if STREAMING.IS_MODEL_A_VEHICLE(variable) then

    menu.action(caca, "Apparaitre un véhicule modèle (Condition)", {'fairespawn2'}, 'Faites moi apparaitre un véhicule', function(couille)
        menu.show_command_box_click_based(couille, "fairespawn2 ")
    end, function(bite) -- Il faut que deux fonctions soit différents l'un l'autre. Exemple "couille" désigne le texte commande, "bite" ce que va exécuter après.
        local hash = util.joaat(bite)
        if STREAMING.IS_MODEL_A_VEHICLE(hash) then -- On ajoute une nouvelle condition si le véhicule n'est pas reconnu.
            ApparitionModele(hash, 2000)
            local ped = players.user_ped()
            local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 5.0, 0.0) 
            entities.create_vehicle(hash, c, 0)
        else
            util.toast("Le véhicule que vous avez écrit: "..bite.." n'est pas reconnu.")
        end
    end)

    menu.divider(caca, "Autre")

    --[[

        Imaginons tu veux faire une plaque personnalisé mais tu veux mettre en relation plaque et "Apparaitre un véhicule modèle (Condition)", il est possible de le faire
        Pour comprendre, un slider, t'en a 4, la première case dont exemple 0, désigne la valeur minimale, ex 5: la valeur maximale, exemple 0: valeur par défaut ou peut importe, 1 désigne combien de cases tu vas aller, 1 par 1 ou 2 par 2
        Pour récupérer ce qu'on a choisis une plaque, on doit récupérer en utilisant "menu.get_value(commandRef)", dans notre cas on utiliseras menu.get_value(PlaqueCouleur). Applicable pour tout type de code.
        Exemple précis:

        PlaqueCouleur = menu.slider(caca, "Choisir la plaque couleur", {"plaquecouleur"}, "Choisir le type de plaque", 0, 5, 0, 1, function()end)

        menu.action(caca, "Apparaitre un véhicule modèle (Condition)", {'fairespawn2'}, 'Faites moi apparaitre un véhicule', function(couille)
            menu.show_command_box_click_based(couille, "fairespawn2 ")
        end, function(bite) 
            local hash = util.joaat(bite)
            if STREAMING.IS_MODEL_A_VEHICLE(hash) then -- On ajoute une nouvelle condition si le véhicule n'est pas reconnu.
                ApparitionModele(hash, 2000)
                local ped = players.user_ped()
                local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 5.0, 0.0) 
                vehiclemodel = entities.create_vehicle(hash, c, 0) -- On a ajouté "vehiclemodel" pour envoyer à la modification du véhicule
                VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehiclemodel, menu.get_value(PlaqueCouleur))
            else
                util.toast("Le véhicule que vous avez écrit: "..bite.." n'est pas reconnu.")
            end
        end)

    ]]--

    PlaqueCouleur = menu.slider(caca, "Choisir la plaque couleur", {"plaquecouleur"}, "Choisir le type de plaque", 0, 5, 0, 1, function()end)

    menu.action(caca, "Apparaitre un véhicule modèle (Condition)", {'fairespawn3'}, 'Faites moi apparaitre un véhicule', function(couille)
        menu.show_command_box_click_based(couille, "fairespawn3 ")
    end, function(bite) 
        local hash = util.joaat(bite)
        if STREAMING.IS_MODEL_A_VEHICLE(hash) then -- On ajoute une nouvelle condition si le véhicule n'est pas reconnu.
            ApparitionModele(hash, 2000)
            local ped = players.user_ped()
            local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 5.0, 0.0) 
            vehiclemodel = entities.create_vehicle(hash, c, 0) -- On a ajouté "vehiclemodel" pour envoyer à la modification du véhicule
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehiclemodel, menu.get_value(PlaqueCouleur))
        else
            util.toast("Le véhicule que vous avez écrit: "..bite.." n'est pas reconnu.")
        end
    end)

--[[
    Maintenant passons à la chose cruciale que tout le monde veut dans son lua script.
    Catégorie Joueurs
]]

--[[
    Nous allons créer une catégorie pour mettre à l'intérieur ce qu'il y a de choses importants.
    Exemple:

        players.on_join(function(pid) -- vous pouvez nommer m'importe comment "pid" soit par playerPid, PlayerID, etc... Soyez créatifs.
            -- Intègre le code à l'intérieur
        end)

    Vous voulez intégrer une colonne ou appelé "divider", créer la même variable de root mais pour joueur. 
    Ne différenciez pas menu.my_root() qui désigne "Le" lua script du menu principal et menu.player_root() qui renvoie au menu ciblé par le joueur en question
    Vous pouvez créer comme ça:

        players.on_join(function(pid)
            menu.divider(menu.player_root(pid), "Mon Caca Script Tutoriel")
        end)

    Si cela ne s'affiche pas, pourquoi?
    Ajouter cette partie: 
    - players.dispatch_on_join()
    - players.on_leave(function()end)

    Ré-appliquer la même chose que auparavant, vous aimez que cela soit simplifié, même principe
    local cacaJoueurMenu = menu.player_root(pid) - pid est l'ID du joueur ciblé, pour savoir, vous avez peut être intégré (pid) dans players.on_join(function(pid)end) pour savoir
    Intégrer la variable à l'intérieur de "players.on_join", laisser à l'extérieur = mauvaise idée.

    Exemple donné:

        players.on_join(function(pid)
            local cacaJoueurMenu = menu.player_root(pid)
            menu.divider(cacaJoueurMenu, "Mon Caca Script Tutoriel") ou cacaJoueurMenu:divider("Mon Caca Script Tutoriel") [Simplifié]
        end)

    Maintenant, ce qu'on va faire, c'est de récupérer les infos du nom du joueur, alors là, c'est très simple.
    Tu utiliseras "players.get_name(pid)"
    Si tu veux que cela soit simplifié, même principe.

    Exemple donnée:

        players.on_join(function(pid)
            local cacaJoueurMenu = menu.player_root(pid)
            local cacaNomJoueur = players.get_name(pid)
            menu.divider(cacaJoueurMenu, "Mon Caca Script Tutoriel") ou cacaJoueurMenu:divider("Mon Caca Script Tutoriel") [Simplifié]
            menu.action(cacaJoueurMenu, "Afficher son nom", {""}, "", function()
                util.toast("Son nom est: "..cacaNomJoueur)
            end)
        end)

    Pourquoi ajouter des deux petits points? Car il faut la variable, si tu ne donnes pas quelque chose, tu sais que si t'ajoutes une virgule, Stand comprendras que tu as fait une bêtise donc à revoir le code.
]]--

-- Exemple concret comment fonctionne:

    players.on_join(function(pid)
        local cacaJoueurMenu = menu.player_root(pid)
        local cacaNomJoueur = players.get_name(pid)
        menu.divider(cacaJoueurMenu, "Mon Caca Script Tutoriel")
        menu.action(cacaJoueurMenu, "Afficher son nom", {""}, "", function()
            util.toast("Son nom est: "..cacaNomJoueur)
        end)
    end)

    players.dispatch_on_join()
    players.on_leave(function()end)