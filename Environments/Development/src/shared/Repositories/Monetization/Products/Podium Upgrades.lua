local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)

return table.freeze({
	[3566455557] = { -- Replace with real ProductID for Level 2
		["Name"] = "Podium Upgrade Level 2",
		["BeforeCheck"] = function(self, userId)
			return { status = true, message = "" }
		end,
		["Purchased"] = function(self, userId)
			local PlacementService = Knit.GetService("PlacementService")
			if PlacementService then
				PlacementService:ProcessUpgrade(userId, 2)
			end
		end,
		["RestrictedRegionCanBuy"] = true,
	},
	[3566455804] = { -- Replace with real ProductID for Level 3
		["Name"] = "Podium Upgrade Level 3",
		["BeforeCheck"] = function(self, userId)
			return { status = true, message = "" }
		end,
		["Purchased"] = function(self, userId)
			local PlacementService = Knit.GetService("PlacementService")
			if PlacementService then
				PlacementService:ProcessUpgrade(userId, 3)
			end
		end,
		["RestrictedRegionCanBuy"] = true,
	},
	[3566455951] = { -- Replace with real ProductID for Level 4
		["Name"] = "Podium Upgrade Level 4",
		["BeforeCheck"] = function(self, userId)
			return { status = true, message = "" }
		end,
		["Purchased"] = function(self, userId)
			local PlacementService = Knit.GetService("PlacementService")
			if PlacementService then
				PlacementService:ProcessUpgrade(userId, 4)
			end
		end,
		["RestrictedRegionCanBuy"] = true,
	},
})
