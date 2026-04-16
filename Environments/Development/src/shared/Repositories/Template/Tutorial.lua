local Economy = require(script.Parent.Economy)

return table.freeze({

	[1] = {
		Text = `Train your character's {Economy.Money2} ! MONEY_2/50`,
		Condition = function(money2, ...)
			return money2 >= 50
		end,
	},

	[2] = {
		Text = `Win against Avril !`,
		Condition = function(money2, fought)
			return money2 >= 50 and fought
		end,
	},
	[3] = {
		Text = `Auto Train Drums`,
		Condition = function(money2, fought, AutoTrainDrums)
			return money2 >= 50 and fought  and AutoTrainDrums
		end,
	},
	[4] = {
		Text = `Train Bass`,
		Condition = function(money2, fought, AutoTrainDrums, TrainBass)
			return money2 >= 50 and fought and AutoTrainDrums and TrainBass
		end,
	},

	[5] = {
		Text = "Hatch your first egg !",
		Condition = function(money2, fought, AutoTrainDrums, TrainBass, hatched)
			return money2 >= 50 and fought  and AutoTrainDrums and TrainBass and hatched
		end,
	},
})
