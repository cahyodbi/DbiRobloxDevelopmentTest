local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

return table.freeze({
	[3548363491] = { -- REPLACE THIS WITH YOUR DEVELOPER PRODUCT ID
		["Name"] = "Steal Item",
		["BeforeCheck"] = function(self, userId)
			return { status = true, message = "" }
		end,
		["Purchased"] = function(self, userId)
			local PlacementService = Knit.GetService("PlacementService")
			if PlacementService then
				PlacementService:ProcessSteal(userId)
			end
		end,
		["RestrictedRegionCanBuy"] = true,
	},
})
