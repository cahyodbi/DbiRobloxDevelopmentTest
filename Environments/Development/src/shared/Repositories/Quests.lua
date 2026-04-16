--[[
	Quest Requirements Format:
	Requirements is an optional list of conditions that must all pass before a player can accept the quest.

	Supported requirement types:
	- { Type = "CompleteQuest", QuestId = "Quest_Collect_Fossils_1" }
	- { Type = "ReachArea", Area = "Desert" }              (placeholder)
	- { Type = "MuseumFloor", Floor = 2 }                  (placeholder)
	- { Type = "MuseumIncome", Income = 5000 }             (placeholder)
]]

return table.freeze({
	["Quest_Collect_Fossils_1"] = {
		DisplayName = "Beginner Fossil Collector",
		Description = "Prove your worth by collecting fossils from the wild.",
		Requirements = {},
		Rewards = {
			Money1 = 1000,
			Exp = 100,
		},
		Objectives = {
			["Obj_Collect_Fossil"] = {
				Description = "Collect a Fossil.",
				Activity = "Collect",
				Tag = "Fossil",
				Target = 1,
			},
		},
	},

	["Quest_Collect_Fossils_2"] = {
		DisplayName = "Advanced Fossil Collector",
		Description = "Prove your worth by collecting fossils from the wild.",
		Requirements = {
			{ Type = "CompleteQuest", QuestId = "Quest_Collect_Fossils_1" },
		},
		Rewards = {
			Money1 = 10000,
			Exp = 1000,
		},
		Objectives = {
			["Obj_Collect_Fossil"] = {
				Description = "Collect 3 Fossils.",
				Activity = "Collect",
				Tag = "Fossil",
				Target = 3,
			},
			["Obj_Collect_Fossil2"] = {
				Description = "Collect 1 Branchinecta Fossils.",
				Activity = "Collect",
				Tag = "Branchinecta Fossil",
				Target = 1,
			},
		},
	},
})
