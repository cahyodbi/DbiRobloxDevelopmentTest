-- NpcDialogueMap: maps NpcId → priority list of dialogue entries.
-- Resolver iterates from highest index to lowest.
-- First entry whose Condition is met (or has no Condition) wins.
--
-- Condition format: { Type = "...", [extra params] }
-- Supported types: Quest_Completed, Quest_Started (has active quest), extensible for custom conditions (e.g. player stats, inventory, etc.)
return table.freeze({
	["Guide"] = {
		[1] = {
			-- Base/default dialogue, no condition needed (fallback)
			DialogueId = "Guide_01",
		},
		[2] = {
			-- Player has met the guide before (custom condition function)
			Condition = "HasGetTips",
			DialogueId = "Guide_02",
		},
		[3] = {
			-- Player has an active quest from this NPC
			Condition = { Type = "Quest_Started", QuestId = "Quest_Collect_Fossils_1" },
			DialogueId = "Guide_03",
		},
		[4] = {
			-- Player has completed the quest
			Condition = { Type = "Quest_Completed", QuestId = "Quest_Collect_Fossils_1" },
			DialogueId = "Guide_04",
		},
	},
	["MuseumNPC"] = {
		[1] = {
			-- Base/default dialogue, no condition needed (fallback)
			DialogueId = "MuseumNPC_01",
		},
		[2] = {
			-- Player has met the guide before (custom condition function)
			Condition = "HasGetTips",
			DialogueId = "MuseumNPC_02",
		},
		[3] = {
			-- Player has an active quest from this NPC
			Condition = { Type = "Quest_Started", QuestId = "Quest_Collect_Fossils_1" },
			DialogueId = "MuseumNPC_03",
		},
		[4] = {
			-- Player has completed the quest
			Condition = { Type = "Quest_Completed", QuestId = "Quest_Collect_Fossils_1" },
			DialogueId = "MuseumNPC_04",
		},
	},
})
