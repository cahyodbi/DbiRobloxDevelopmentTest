local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local DataService = Knit.GetService("DataService")

return table.freeze({
	[1661477243] = {
		["Name"] = "Teleport",
		["Purchased"] = function(self, userId: number)
			-- local DataCacheService = Knit.GetService("DataCacheService")
			-- local Template = DataCacheService:GetFile("Template")
			-- local data = DataService:GetData(Players:GetPlayerByUserId(userId))

			-- for k, _ in Template.Areas do
			--     table.insert(data.Areas.Unlocked, k)
			-- end

			-- self.Client.UpdateData:Fire(Players:GetPlayerByUserId(userId), data)
		end,
	},
})
