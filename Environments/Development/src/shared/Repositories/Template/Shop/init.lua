local Gamepasses = require(script.Gamepasses)
local OP_Pets = require(script.OPPets)
local Wins = require(script.Wins)
local Boosts = require(script.Boosts)
local StarterPacks = require(script.StarterPacks)

return table.freeze({
    Starter_Bundle = {
        Price = 249
    },

    Shop_Egg = {
        Name = "Dominus Egg",
        Price_1 = 149,
        Price_3 = 359,
        Price_8 = 829
    },

    Gamepasses = table.clone(Gamepasses),
    OP_Pets = table.clone(OP_Pets),
    Wins = table.clone(Wins),
    Boosts = table.clone(Boosts),
    StarterPacks = table.clone(StarterPacks),
})