local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local DataService = Knit.GetService("DataService")

return table.freeze({
    [986474944] = {
        ["Name"] = "Gold Click",
        ["Purchased"] = function(self, userId: number)
        end
    }
})