return table.freeze({
	["Guide_01"] = {
		[1] = {
			Text = "Hello there! Welcome to the Dig Site. How can I assist you today?",
			Options = {
				[1] = {
					Text = "Who are you?",
					Next = 2,
				},
				[2] = {
					Text = "I know you already",
					Next = -1,
					Condition = "HasMetGuide",
				},
				[3] = {
					Text = "Give me some tips!",
					Next = 4,
				},
				[4] = {
					Text = "Nothing, just looking around.",
					Action = "PlayerDontCare",
					Next = 6,
				},
			},
		},

		[2] = {
			Text = "I'm the site guide!",
			Next = 3,
		},

		[3] = {
			Text = "I can provide information about the site and help you get started.",
			Action = "GuideHelp",
			Next = -1,
		},

		[4] = {
			Text = "Sure, here is a tip!",
			Next = 5,
		},

		[5] = {
			Text = "You can switch your tools from here!",
			Action = "OpenDiggingTools",
			Next = -1,
		},

		[6] = {
			Text = "Alright! Feel free to explore the site and talk to the other staff members if you have any questions.",
			Next = -1,
		},
	},

	["Guide_02"] = {
		[1] = {
			Text = "I have a quest for you",
			Next = 2,
		},

		[2] = {
			Text = "Can you find a Fossil?",
			Options = {
				[1] = {
					Text = "Okay, I will find it for you",
					Next = 3,
				},
				[2] = {
					Text = "No, i don't have time",
					Next = -1,
				},
			},
		},

		[3] = {
			Text = "Thanks!",
			Action = "StartQuest",
			Params = {
				QuestId = "Quest_Collect_Fossils_1",
			},
			Next = -1,
		},
	},

	-- Dialogue saat quest aktif (setelah player menerima quest)
	["Guide_03"] = {
		[1] = {
			Text = "Have you found a Fossil yet? Keep digging!",
			Options = {
				[1] = {
					Text = "I'm still looking.",
					Next = 2,
				},
				[2] = {
					Text = "Any tips?",
					Next = 3,
				},
			},
		},

		[2] = {
			Text = "Good luck! I'm sure you'll find one soon.",
			Next = -1,
		},

		[3] = {
			Text = "Try digging in the darker patches of sand. Fossils tend to hide there!",
			Next = -1,
		},
	},

	-- Dialogue saat quest sudah selesai (setelah player menyelesaikan quest)
	["Guide_04"] = {
		[1] = {
			Text = "I don't have anything for you right now.",
			Next = -1,
		},
	},
})
