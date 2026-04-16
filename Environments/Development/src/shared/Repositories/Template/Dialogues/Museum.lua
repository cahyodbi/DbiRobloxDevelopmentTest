return table.freeze({
	["MuseumNPC_01"] = {
		[1] = {
			Text = "Hello there! I am the Museum Steward. How can I assist you today?",
			Options = {
				[1] = {
					Text = "Decoration Shop",
					Action = "OpenDecorationShop",
					Next = -1,
				},
				[2] = {
					Text = "Podium Shop",
					Action = "OpenPodiumShop",
					Next = -1,
				},
				[3] = {
					Text = "Nothing, just looking around.",
					Next = 2,
				},
			},
		},

		[2] = {
			Text = "Alright! Feel free to explore the museum and let me know if you need anything else.",
			Next = -1,
		},
	},

	["MuseumNPC_02"] = {
		[1] = {
			Text = "Welcome back! Ready to browse the catalogs?",
			Options = {
				[1] = {
					Text = "Decoration Shop",
					Action = "OpenDecorationShop",
					Next = -1,
				},
				[2] = {
					Text = "Podium Shop",
					Action = "OpenPodiumShop",
					Next = -1,
				},
			},
		},
	},

	-- Placeholder for quest-related dialogues if needed later
	["MuseumNPC_03"] = {
		[1] = {
			Text = "I don't have any tasks for you at the moment. Check the shops for new items!",
			Next = -1,
		},
	},

	["MuseumNPC_04"] = {
		[1] = {
			Text = "I don't have anything for you right now.",
			Next = -1,
		},
	},
})
