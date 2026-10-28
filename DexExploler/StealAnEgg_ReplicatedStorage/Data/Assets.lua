-- Script path: ReplicatedStorage.Data.Assets
-- Decompile time: 11.02 ms

local _id, v1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PersonalityCatalog = require(script.PersonalityCatalog)
local Rarity = require(ReplicatedStorage.Data.Rarity)
require(script.Types)

local function makeAnimation(a1) -- Line: 28 -- types: a1: string
    local Animation = Instance.new("Animation")
    local success = pcall(function() -- Line: 31 -- upvalues: Animation (val), a1 (val)
        Animation.AnimationId = a1
    end)
    if not success then
        warn((("Animation %* is not shared with this experience"):format(a1)))
    end
    return Animation
end

local freeze = table.freeze
local v2 = {
    DisplayName = "Assets",
    EarningRate = 1,
    IndexSpeedReward = 0,
    DropWeight = 1,
    VisualOdds = 1,
    ModelWeight = 80,
    BaseModelScale = 1,
    LimitedEggViewportScale = 1,
    LimitedEggViewportVerticalOffset = 0,
    Egg = table.freeze({DisplayName = "Assets", Icon = "rbxassetid://116524274262912", GrowthTime = 60, WeightKg = 80}),
}
local freeze_2 = table.freeze
local v3 = {}
local Animation = Instance.new("Animation")
local u29 = "rbxassetid://122342179426051"
local success = pcall(function() -- Line: 31 -- upvalues: Animation (val), u29 (val)
    Animation.AnimationId = u29
end)
if not success then
    warn("Animation rbxassetid://122342179426051 is not shared with this experience")
end
v3.Idle = Animation
v2.Animations = freeze_2(v3)
v2.Rarity = Rarity.Rarities.Common
v2.BaseModelColor = Color3.fromRGB(86, 160, 61)
v2.PossibleModelColors = table.freeze({
    table.freeze({Color3.fromRGB(86, 160, 61), 1}),
    table.freeze({Color3.fromRGB(96, 119, 82), 1}),
    table.freeze({Color3.fromRGB(90, 100, 105), 1}),
    table.freeze({Color3.fromRGB(93, 84, 67), 1}),
    (table.freeze({Color3.fromRGB(145, 122, 86), 1})),
})
local v4 = freeze(v2)
local Configs = script.Configs
local u923 = table.freeze({
    Whiskers = require(Configs.Whiskers),
    Jesterpop = require(Configs.Jesterpop),
    Candlefang = require(Configs.Candlefang),
    ["Spirit Knight"] = require(Configs["Spirit Knight"]),
    ["Graveyard Brute"] = require(Configs["Graveyard Brute"]),
    ["Voidseer Pumpkin"] = require(Configs["Voidseer Pumpkin"]),
    ["Hooded Gerbil"] = require(Configs["Hooded Gerbil"]),
    Toadstool = require(Configs.Toadstool),
    ["Patchwork Imp"] = require(Configs["Patchwork Imp"]),
    ["Haunted Scorpio"] = require(Configs["Haunted Scorpio"]),
    BloodBloom = require(Configs.BloodBloom),
    ["Ghost Reaper"] = require(Configs["Ghost Reaper"]),
    ["Mimic Chest"] = require(Configs["Mimic Chest"]),
    Crowshade = require(Configs.Crowshade),
    ["Hexed Pumpkin"] = require(Configs["Hexed Pumpkin"]),
    Werewolf = require(Configs.Werewolf),
    ["Abomination Kong"] = require(Configs["Abomination Kong"]),
    ["Shelltide Voyager"] = require(Configs["Shelltide Voyager"]),
    ["Halloween Glyptodon"] = require(Configs["Halloween Glyptodon"]),
    ["Zombified Halloween Glyptodon"] = require(Configs["Zombified Halloween Glyptodon"]),
    ["Halloween Terrorbird"] = require(Configs["Halloween Terrorbird"]),
    ["Zombified Halloween Terrorbird"] = require(Configs["Zombified Halloween Terrorbird"]),
    ["Halloween Megatherium"] = require(Configs["Halloween Megatherium"]),
    ["Zombified Halloween Megatherium"] = require(Configs["Zombified Halloween Megatherium"]),
    ["Halloween Dunkleosteus"] = require(Configs["Halloween Dunkleosteus"]),
    ["Zombified Halloween Dunkleosteus"] = require(Configs["Zombified Halloween Dunkleosteus"]),
    ["Halloween Gigantopithecus"] = require(Configs["Halloween Gigantopithecus"]),
    ["Zombified Halloween Gigantopithecus"] = require(Configs["Zombified Halloween Gigantopithecus"]),
    ["Halloween Sabertooth"] = require(Configs["Halloween Sabertooth"]),
    ["Zombified Halloween Sabertooth"] = require(Configs["Zombified Halloween Sabertooth"]),
    ["Candy Corn"] = require(Configs["Candy Corn"]),
    ["Hollow Bat"] = require(Configs["Hollow Bat"]),
    Scarecrow = require(Configs.Scarecrow),
    ["Pumpkin Golem"] = require(Configs["Pumpkin Golem"]),
    ["Soul Phantom"] = require(Configs["Soul Phantom"]),
    ["Ghost Fish"] = require(Configs["Ghost Fish"]),
    ["Banjo Firefly"] = require(Configs["Banjo Firefly"]),
    ["Spirit Panda"] = require(Configs["Spirit Panda"]),
    ["World Spirit"] = require(Configs["World Spirit"]),
    ["Prism Gecko"] = require(Configs["Prism Gecko"]),
    ["Enchanted Bluejay"] = require(Configs["Enchanted Bluejay"]),
    ["Royal Skywhale"] = require(Configs["Royal Skywhale"]),
    ["Cosmic Lion"] = require(Configs["Cosmic Lion"]),
    ["Spirit Hare"] = require(Configs["Spirit Hare"]),
    ["Cosmic Fox"] = require(Configs["Cosmic Fox"]),
    ["Cosmic Beetle Blue"] = require(Configs["Cosmic Beetle Blue"]),
    ["Nibbles #013"] = require(Configs["Nibbles #013"]),
    LimitedTimeExperimentPet = require(Configs.LimitedTimeExperimentPet),
    Hazardhog = require(Configs.Hazardhog),
    Ringlord = require(Configs.Ringlord),
    ["Ring Guard"] = require(Configs["Ring Guard"]),
    ["Alabaster Whale"] = require(Configs["Alabaster Whale"]),
    ["Alien Skeleton Boss"] = require(Configs["Alien Skeleton Boss"]),
    Ankylosaurus = require(Configs.Ankylosaurus),
    ["Archdemon Dragon"] = require(Configs["Archdemon Dragon"]),
    ["Ascended Vermilion Phoenix"] = require(Configs["Ascended Vermilion Phoenix"]),
    ["Ash Gecko"] = require(Configs["Ash Gecko"]),
    ["Baby Aurora Dragon"] = require(Configs["Baby Aurora Dragon"]),
    Balrog = require(Configs.Balrog),
    ["Bananita Dolphinita"] = require(Configs["Bananita Dolphinita"]),
    Basilisk = require(Configs.Basilisk),
    Bear = require(Configs.Bear),
    ["Belula Beluga"] = require(Configs["Belula Beluga"]),
    ["Bomboclat Crocolat"] = require(Configs["Bomboclat Crocolat"]),
    Bronto = require(Configs.Bronto),
    ["Brr Brr Patapim"] = require(Configs["Brr Brr Patapim"]),
    ["Burrowing Owl"] = require(Configs["Burrowing Owl"]),
    Camel = require(Configs.Camel),
    Catfish = require(Configs.Catfish),
    ["Cave Dragon"] = require(Configs["Cave Dragon"]),
    Centapede = require(Configs.Centapede),
    Cerberus = require(Configs.Cerberus),
    Chicken = require(Configs.Chicken),
    ["Chillin Chilli"] = require(Configs["Chillin Chilli"]),
    Chimpanzee = require(Configs.Chimpanzee),
    ["Colossal Mammoth"] = require(Configs["Colossal Mammoth"]),
    Crane = require(Configs.Crane),
    Crocodile = require(Configs.Crocodile),
    ["Cyclops Gorilla"] = require(Configs["Cyclops Gorilla"]),
    DeathstalkerScorpion = require(Configs.DeathstalkerScorpion),
    ["Demon Imp"] = require(Configs["Demon Imp"]),
    DesertLark = require(Configs.DesertLark),
    Dodo = require(Configs.Dodo),
    Dog = require(Configs.Dog),
    Dragon = require(Configs.Dragon),
    ["Dream Axolotl"] = require(Configs["Dream Axolotl"]),
    ["Drill Monster"] = require(Configs["Drill Monster"]),
    Duckling = require(Configs.Duckling),
    ["El Maja"] = require(Configs["El Maja"]),
    ["Ember Dragon"] = require(Configs["Ember Dragon"]),
    ["Eternal Lunar Dragon"] = require(Configs["Eternal Lunar Dragon"]),
    FennecFox = require(Configs.FennecFox),
    ["Finned Thresher"] = require(Configs["Finned Thresher"]),
    ["Flaming Bull"] = require(Configs["Flaming Bull"]),
    Frog = require(Configs.Frog),
    ["Galaxy Gecko"] = require(Configs["Galaxy Gecko"]),
    Gorilla = require(Configs.Gorilla),
    Hellhound = require(Configs.Hellhound),
    ["Ice Dragon"] = require(Configs["Ice Dragon"]),
    Irihorus = require(Configs.Irihorus),
    Jerboa = require(Configs.Jerboa),
    Kitsune = require(Configs.Kitsune),
    Koi = require(Configs.Koi),
    Kraken = require(Configs.Kraken),
    ["La Vacca Saturno Saturnita"] = require(Configs["La Vacca Saturno Saturnita"]),
    ["Lava Iguana"] = require(Configs["Lava Iguana"]),
    ["Lava frog"] = require(Configs["Lava frog"]),
    Mammoth = require(Configs.Mammoth),
    ["Mangolini Parrochini"] = require(Configs["Mangolini Parrochini"]),
    ["Mecha Scorpio"] = require(Configs["Mecha Scorpio"]),
    ["Mecha Froggo"] = require(Configs["Mecha Froggo"]),
    ["Mecha Crawler"] = require(Configs["Mecha Crawler"]),
    ["Mecha Crocodon"] = require(Configs["Mecha Crocodon"]),
    ["Mecha Krakenoid"] = require(Configs["Mecha Krakenoid"]),
    ["Mecha Dreadscale"] = require(Configs["Mecha Dreadscale"]),
    ["Mire Fox"] = require(Configs["Mire Fox"]),
    Scorpio = require(Configs.Scorpio),
    Froggo = require(Configs.Froggo),
    Crawler = require(Configs.Crawler),
    Crocodon = require(Configs.Crocodon),
    Krakenoid = require(Configs.Krakenoid),
    Dreadscale = require(Configs.Dreadscale),
    Mosasaurus = require(Configs.Mosasaurus),
    ["Oni Tiger"] = require(Configs["Oni Tiger"]),
    ["Orangutini Ananassini"] = require(Configs["Orangutini Ananassini"]),
    Orca = require(Configs.Orca),
    Parrotfish = require(Configs.Parrotfish),
    Penguin = require(Configs.Penguin),
    ["Polar Bear"] = require(Configs["Polar Bear"]),
    Pterodactyl = require(Configs.Pterodactyl),
    Raccoon = require(Configs.Raccoon),
    Rattlesnake = require(Configs.Rattlesnake),
    ["Red Panda"] = require(Configs["Red Panda"]),
    ["Sabertooth Tiger"] = require(Configs["Sabertooth Tiger"]),
    Salamander = require(Configs.Salamander),
    ["Sand Spider"] = require(Configs["Sand Spider"]),
    ScorchedDragon = require(Configs.ScorchedDragon),
    ["Shadow Dragon"] = require(Configs["Shadow Dragon"]),
    ["Snowy Owl"] = require(Configs["Snowy Owl"]),
    Spider = require(Configs.Spider),
    Stag = require(Configs.Stag),
    ["Strawberry Elephant"] = require(Configs["Strawberry Elephant"]),
    Swan = require(Configs.Swan),
    Swordfish = require(Configs.Swordfish),
    Tiger = require(Configs.Tiger),
    ["Tob Tobi Tob Tob"] = require(Configs["Tob Tobi Tob Tob"]),
    Toucan = require(Configs.Toucan),
    Tralaledon = require(Configs.Tralaledon),
    Triceratops = require(Configs.Triceratops),
    ["Trulimero Trulicina"] = require(Configs["Trulimero Trulicina"]),
    ["Tung Tung Sahur"] = require(Configs["Tung Tung Sahur"]),
    Turtle = require(Configs.Turtle),
    TyrannosaurusRex = require(Configs.TyrannosaurusRex),
    Unicorn = require(Configs.Unicorn),
    ["Void Dragon"] = require(Configs["Void Dragon"]),
    Walrus = require(Configs.Walrus),
    Warden = require(Configs.Warden),
    ["Whale Shark"] = require(Configs["Whale Shark"]),
    Yeti = require(Configs.Yeti),
    Crab = require(Configs.Crab),
    Rhino = require(Configs.Rhino),
    Mantis = require(Configs.Mantis),
    ["Kaiju Spider"] = require(Configs["Kaiju Spider"]),
    Shark = require(Configs.Shark),
    ["Blade Head"] = require(Configs["Blade Head"]),
    ["King Kong"] = require(Configs["King Kong"]),
    Godzilla = require(Configs.Godzilla),
    Wendigo = require(Configs.Wendigo),
    Shardwing = require(Configs.Shardwing),
    ["Shattered Drake"] = require(Configs["Shattered Drake"]),
    ["Shattered Colossus"] = require(Configs["Shattered Colossus"]),
    Ventinal = require(Configs.Ventinal),
    ["World Eater"] = require(Configs["World Eater"]),
    Mawbreaker = require(Configs.Mawbreaker),
    Dreadclaw = require(Configs.Dreadclaw),
    ["Void Serpent"] = require(Configs["Void Serpent"]),
    ArchAngel = require(Configs.ArchAngel),
    ["World Burner"] = require(Configs["World Burner"]),
    Pegasus = require(Configs.Pegasus),
    ["Skeleton Horse"] = require(Configs["Skeleton Horse"]),
    Aetheron = require(Configs.Aetheron),
    Equinox = require(Configs.Equinox),
    Dove = require(Configs.Dove),
    Lamb = require(Configs.Lamb),
    Moth = require(Configs.Moth),
    Peacock = require(Configs.Peacock),
    Jellyfish = require(Configs.Jellyfish),
    Centaur = require(Configs.Centaur),
    ["Flame Sprite"] = require(Configs["Flame Sprite"]),
    Toro = require(Configs.Toro),
    Imp = require(Configs.Imp),
    ["Demon Hound"] = require(Configs["Demon Hound"]),
    ["Dark Gargoyle"] = require(Configs["Dark Gargoyle"]),
    RazorFang = require(Configs.RazorFang),
    ["Toxic Rat"] = require(Configs["Toxic Rat"]),
    Radcoon = require(Configs.Radcoon),
    Toucax = require(Configs.Toucax),
    Nuceodille = require(Configs.Nuceodille),
    ["Wheel Hamster"] = require(Configs["Wheel Hamster"]),
    ["Stacked Turtle"] = require(Configs["Stacked Turtle"]),
    Frogfly = require(Configs.Frogfly),
    Spiderpig = require(Configs.Spiderpig),
    Sharkodile = require(Configs.Sharkodile),
    Octophant = require(Configs.Octophant),
    ["Mecha Scrambler"] = require(Configs["Mecha Scrambler"]),
    Dreadstinger = require(Configs.Dreadstinger),
    Rhinobear = require(Configs.Rhinobear),
    ["Eyeball Crab"] = require(Configs["Eyeball Crab"]),
    ["Three Headed Chicken"] = require(Configs["Three Headed Chicken"]),
    ["Nuclear Mantis"] = require(Configs["Nuclear Mantis"]),
    ["Void Angler"] = require(Configs["Void Angler"]),
    ["Rift Eye"] = require(Configs["Rift Eye"]),
    ["Shattered Ram"] = require(Configs["Shattered Ram"]),
    Shardling = require(Configs.Shardling),
    Voidmaw = require(Configs.Voidmaw),
    Riftwing = require(Configs.Riftwing),
    ["Abyss Overlord"] = require(Configs["Abyssal Overlord"]),
    ["Abyss Overlord OP"] = require(Configs["Abyssal Overlord OP"]),
    ["Manta Ray"] = require(Configs["Manta Ray"]),
    Spike = require(Configs.Spike),
    ["Riptide Octopus"] = require(Configs["Riptide Octopus"]),
    ["Electric Eel"] = require(Configs["Electric Eel"]),
    Megalodon = require(Configs.Megalodon),
    Cthulhu = require(Configs.Cthulhu),
    ["Depths Manta Ray"] = require(Configs["Depths Manta Ray"]),
    ["Depths Spike"] = require(Configs["Depths Spike"]),
    ["Depths Riptide Octopus"] = require(Configs["Depths Riptide Octopus"]),
    ["Depths Electric Eel"] = require(Configs["Depths Electric Eel"]),
    ["Depths Megalodon"] = require(Configs["Depths Megalodon"]),
    ["Depths Cthulhu"] = require(Configs["Depths Cthulhu"]),
    ["Terra Snapper"] = require(Configs["Terra Snapper"]),
    ["Depths Terra Snapper"] = require(Configs["Depths Terra Snapper"]),
    Glyptodon = require(Configs.Glyptodon),
    Terrorbird = require(Configs.Terrorbird),
    Megatherium = require(Configs.Megatherium),
    Dunkleosteus = require(Configs.Dunkleosteus),
    Gigantopithecus = require(Configs.Gigantopithecus),
    Sabertooth = require(Configs.Sabertooth),
    ["Skeletal Glyptodon"] = require(Configs["Skeletal Glyptodon"]),
    ["Skeletal Terrorbird"] = require(Configs["Skeletal Terrorbird"]),
    ["Skeletal Megatherium"] = require(Configs["Skeletal Megatherium"]),
    ["Skeletal Dunkleosteus"] = require(Configs["Skeletal Dunkleosteus"]),
    ["Skeletal Gigantopithecus"] = require(Configs["Skeletal Gigantopithecus"]),
    ["Skeletal Sabertooth"] = require(Configs["Skeletal Sabertooth"]),
    ["Citadel Snail"] = require(Configs["Citadel Snail"]),
    ["Toxic Crocodile"] = require(Configs["Toxic Crocodile"]),
    ["Mecha Chompa"] = require(Configs["Mecha Chompa"]),
    ["Pink Dragon Experiment"] = require(Configs["Pink Dragon Experiment"]),
    ["Eye Bat"] = require(Configs["Eye Bat"]),
    ["Uncoiled Armadillo"] = require(Configs["Uncoiled Armadillo"]),
    ["67"] = require(Configs["67"]),
    ["67 OP"] = require(Configs["67 OP"]),
    ["Toxic Hedgehog"] = require(Configs["Toxic Hedgehog"]),
    ["Toxic Hedgehog OP"] = require(Configs["Toxic Hedgehog OP"]),
    ["Amethyst Runebear"] = require(Configs["Amethyst Runebear"]),
    ["Amethyst Runebear OP"] = require(Configs["Amethyst Runebear OP"]),
    ["Engine Snail"] = require(Configs["Engine Snail"]),
    ["Race Lizard"] = require(Configs["Race Lizard"]),
    Ostrich = require(Configs.Ostrich),
    ["Ostrich OP"] = require(Configs["Ostrich OP"]),
    ["Race Cheetah"] = require(Configs["Race Cheetah"]),
    ["Race Bird"] = require(Configs["Race Bird"]),
    ["Race Seahorse"] = require(Configs["Race Seahorse"]),
    ["Coffin Skeleton"] = require(Configs["Coffin Skeleton"]),
    ["Big Moth"] = require(Configs["Big Moth"]),
    ["Ghost Bird"] = require(Configs["Ghost Bird"]),
    Cauldron = require(Configs.Cauldron),
    ["Midnight Mimic"] = require(Configs["Midnight Mimic"]),
    ["Midnight Mimic OP"] = require(Configs["Midnight Mimic OP"]),
    ["Bell Ghost"] = require(Configs["Bell Ghost"]),
    ["Cursed Fish"] = require(Configs["Cursed Fish"]),
    ["Pumpkin Brute"] = require(Configs["Pumpkin Brute"]),
    ["Pumpkin King"] = require(Configs["Pumpkin King"]),
})
u923 = (require((game:GetService("ReplicatedStorage")).Shared.Flags.BalanceConfig)).Bind("Game.Balance.Assets", u923, {
    EarningRate = true,
    IndexSpeedReward = true,
    DropWeight = true,
    VisualOdds = true,
    ModelWeight = true,
    LuckyBlockDropTable = true,
    LuckyBlockLevelRange = true,
    LuckyBlockOpenDuration = true,
    Egg = {GrowthTime = true, WeightKg = true},
}, true, function(a1) -- Line: 408 -- upvalues: u923 (ref)
    local v1
    local v2 = 0
    local v3 = nil
    local v4 = nil
    for i, j in a1, v3, v4 do
        if not u923[i].DontRoll and u923[i].Rarity._id ~= "Eternal" then
            v2 = v2 + (j.DropWeight or 0)
        end
        if j.Egg then
            v1 = false
            if 0 < j.Egg.GrowthTime then
                v1 = 0 < j.Egg.WeightKg
            end
            assert(v1)
        end
    end
    assert(v2 > 0)
end)
local v5 = {}
v3 = nil
local v6 = nil
for i, j in u923, v3, v6 do
    _id = j.Rarity._id
    v1 = v5[_id]
    if v1 == nil then
        v5[_id] = {}
    end
    v1[i] = j
end
for k, n in v5 do
    table.freeze(n)
end
return (table.freeze({
    Directory = u923,
    ByRarity = table.freeze(v5),
    Personalities = PersonalityCatalog,
    BaseConfig = v4,
    AssetNameExists = function(a1) -- Line: 452 -- upvalues: u923 (ref) -- types: a1: string
        if u923[a1] ~= nil then
            return true
        end
        return false, (("Asset name \"%*\" does not exist in the Assets directory."):format(a1))
    end,
}))