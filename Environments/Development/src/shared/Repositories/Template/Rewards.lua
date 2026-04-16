-- Game Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Helpers
local Helpers = ReplicatedStorage.Shared.Helpers
local FormatNumber = require(Helpers.Numbers.FormatNumber)

return {
	[1] = {
		Time = 60,

		Image = "Money2",

		Reward = "Currency",
		Currency = "Money2",

		Areas = {
			Area01 = { `x{FormatNumber(100)} MONEY2`, 100 },
			Area02 = { `x{FormatNumber(2000)} MONEY2`, 2000 },
			Area03 = { `x{FormatNumber(40000)} MONEY2`, 40000 },
			Area04 = { `x{FormatNumber(8000000)} MONEY2`, 8000000 },
			Area05 = { `x{FormatNumber(16000000)} MONEY2`, 16000000 },
		},

		Claimed = false,
	},

	[2] = {
		Time = 60 * 3,

		Image = "Wins",

		Reward = "Currency",
		Currency = "Wins",

		Areas = {
			Area01 = { `x{FormatNumber(5)} Wins`, 5 },
			Area02 = { `x{FormatNumber(50)} Wins`, 50 },
			Area03 = { `x{FormatNumber(650)} Wins`, 650 },
			Area04 = { `x{FormatNumber(8000)} Wins`, 8000 },
			Area05 = { `x{FormatNumber(100000)} Wins`, 100000 },
		},

		Claimed = false,
	},

	[3] = {
		Time = 60 * 5,

		Image = "Money2",

		Reward = "Currency",
		Currency = "Money2",

		Areas = {
			Area01 = { `x{FormatNumber(1000)} MONEY2`, 1000 },
			Area02 = { `x{FormatNumber(15000)} MONEY2`, 15000 },
			Area03 = { `x{FormatNumber(300000)} MONEY2`, 300000 },
			Area04 = { `x{FormatNumber(80000000)} MONEY2`, 80000000 },
			Area05 = { `x{FormatNumber(160000000)} MONEY2`, 160000000 },
		},

		Claimed = false,
	},

	[4] = {
		Time = 60 * 8,

		Image = "RandomEgg",

		Reward = "Egg",

		Areas = {
			Area01 = { "x1 Random Egg", "SpottedEgg" },
			Area02 = { "x1 Random Egg", "QuarryEgg" },
			Area03 = { "x1 Random Egg", "SnowEgg" },
			Area04 = { "x1 Random Egg", "StreetEgg" },
			Area05 = { "x1 Random Egg", "GreenEgg" },
		},

		Claimed = false,
	},

	[5] = {
		Time = 60 * 10,

		Image = "Wins",

		Reward = "Currency",
		Currency = "Wins",

		Areas = {
			Area01 = { `x{FormatNumber(10)} Wins`, 10 },
			Area02 = { `x{FormatNumber(100)} Wins`, 100 },
			Area03 = { `x{FormatNumber(1320)} Wins`, 1320 },
			Area04 = { `x{FormatNumber(16320)} Wins`, 16320 },
			Area05 = { `x{FormatNumber(225000)} Wins`, 225000 },
		},

		Claimed = false,
	},

	[6] = {
		Time = 60 * 15,

		Image = "Gasuo",

		Reward = "Pets",
		Amount = 1,

		Areas = {
			Area01 = { "x1 Gasuo", "Gasuo" },
			Area02 = { "x1 Gasuo", "Gasuo" },
			Area03 = { "x1 Gasuo", "Gasuo" },
			Area04 = { "x1 Gasuo", "Gasuo" },
			Area05 = { "x1 Gasuo", "Gasuo" },
		},

		Claimed = false,
	},

	[7] = {
		Time = 60 * 20,

		Image = "Peach",

		Reward = "Fruit",
		Amount = 1,

		Areas = {
			Area01 = { "x1 Peach", "3" },
			Area02 = { "x1 Peach", "3" },
			Area03 = { "x1 Peach", "3" },
			Area04 = { "x1 Peach", "3" },
			Area05 = { "x1 Peach", "3" },
		},

		Claimed = false,
	},

	[8] = {
		Time = 60 * 25,

		Image = "Money2",

		Reward = "Currency",
		Currency = "Money2",

		Areas = {
			Area01 = { `x{FormatNumber(5_000)} MONEY2`, 5_000 },
			Area02 = { `x{FormatNumber(100_000)} MONEY2`, 100_000 },
			Area03 = { `x{FormatNumber(2_000_000)} MONEY2`, 2_000_000 },
			Area04 = { `x{FormatNumber(40_000_000)} MONEY2`, 40_000_000 },
			Area05 = { `x{FormatNumber(800_000_000)} MONEY2`, 800_000_000 },
		},

		Claimed = false,
	},

	[9] = {
		Time = 60 * 30,

		Image = "Money2",

		Reward = "Currency",
		Currency = "Money2",

		Areas = {
			Area01 = { `x{FormatNumber(10000)} MONEY2`, 10000 },
			Area02 = { `x{FormatNumber(200000)} MONEY2`, 200000 },
			Area03 = { `x{FormatNumber(4000000)} MONEY2`, 4000000 },
			Area04 = { `x{FormatNumber(80000000)} MONEY2`, 80000000 },
			Area05 = { `x{FormatNumber(1600000000)} MONEY2`, 1600000000 },
		},

		Claimed = false,
	},

	[10] = {
		Time = 60 * 45,

		Image = "Blue Dragon",

		Reward = "Pets",
		Amount = 1,

		Areas = {
			Area01 = { "x1 Blue Dragon", "Blue Dragon" },
			Area02 = { "x1 Blue Dragon", "Blue Dragon" },
			Area03 = { "x1 Blue Dragon", "Blue Dragon" },
			Area04 = { "x1 Blue Dragon", "Blue Dragon" },
			Area05 = { "x1 Blue Dragon", "Blue Dragon" },
		},

		Claimed = false,
	},

	[11] = {
		Time = 60 * 60 * 1.5,

		Image = "Wins",

		Reward = "Currency",
		Currency = "Wins",

		Areas = {
			Area01 = { `x{FormatNumber(100)} Wins`, 100 },
			Area02 = { `x{FormatNumber(1000)} Wins`, 1000 },
			Area03 = { `x{FormatNumber(13200)} Wins`, 13200 },
			Area04 = { `x{FormatNumber(163200)} Wins`, 163200 },
			Area05 = { `x{FormatNumber(2250000)} Wins`, 2250000 },
		},

		Claimed = false,
	},

	[12] = {
		Time = 60 * 60 * 2,

		Image = "Norauto",

		Reward = "Pets",
		Amount = 1,

		Areas = {
			Area01 = { "x1 Norauto", "Norauto" },
			Area02 = { "x1 Norauto", "Norauto" },
			Area03 = { "x1 Norauto", "Norauto" },
			Area04 = { "x1 Norauto", "Norauto" },
			Area05 = { "x1 Norauto", "Norauto" },
		},

		Claimed = false,
	},
}
