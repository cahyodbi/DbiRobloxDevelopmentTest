return {
	--[[
		FORMAT PODIUM:

		1. Pilihan (salah satu boleh diletakkan):
		   [index] = { "FossilA", "FossilB" }

		2. Set Lengkap (semua slot harus terisi):
		   [index] = {
		       fossils = {
		           "Part A",                              -- slot 1: hanya satu varian
		           { "Part B", "Part B Rusted" },         -- slot 2: beberapa varian boleh
		       },
		   }
		   Tiap entry dalam fossils = satu SLOT.
		   Slot bisa diisi oleh nama apa pun yang ada di dalam array-nya.
	--]]

	[1] = {
		-- Set Lengkap T-Rex (semua slot harus terisi)
		[-1] = {
			fossils = {
				{ "Tyrannosaurus Rex Body"},
				{ "Tyrannosaurus Rex Skull"},
				{ "Tyrannosaurus Rex Left Leg"},
				{ "Tyrannosaurus Rex Right Leg"},
				{ "Tyrannosaurus Rex Tail"},
			},
		},
		[0] = {
			fossils = {
				{ "Apatosaurus Body" },
				{ "Apatosaurus Head" },
				{ "Apatosaurus Left Front Leg" },
				{ "Apatosaurus Right Front Leg" },
				{ "Apatosaurus Left Rear Leg" },
				{ "Apatosaurus Right Rear Leg" },
				{ "Apatosaurus Tail" },
			},
		},
		-- Pilihan: podium bisa diisi salah satu dari list (Randomized 22 Fossils)
		[1] = { "Pachycephalosaurus Skull" },
		[2] = { "Giant Grasshopper Fossil" },
		[3] = { "Titanis Leg Bone" },
		[4] = { "Branchinecta Fossil" },
		[5] = { "Megatherium Claw" },
		[6] = { "Mammoth Skull" },
		[7] = { "Ornithomimus Leg Bone" },
		[8] = { "Freshwater Crab Fossil" },
		[9] = { "Smilodon Saber Tooth" },
		[10] = { "Dire Wolf Skull" },
		[11] = { "Bison Antiquus Horn" },
		[12] = { "Ancient Termite Nest Fossil" },
		[13] = { "Ankylosaurus Tail Bone" },
		[14] = { "Tenontosaurus Rib Bone" },
		[15] = { "DIatryma Skull" },
		[16] = { "Pleistocene Horse Tooth" },
		[17] = { "Phorusrhacos Beak Fossil" },
		[18] = { "Glyptodon Armor Plate" },
		[19] = { "Struthiomimus Jaw Bone" },
		[20] = { "Varanus Priscus Vertebra" },
		[21] = { "Megarachne Fossil" },
		[22] = { "Argentavis Wing Bone" },
	},

	[2] = {
		[-1] = {
			fossils = {
				{ "Stegosaurus Body" },
				{ "Stegosaurus Skull" },
				{ "Stegosaurus Tail" },
				{ "Stegosaurus Front Left Leg" },
				{ "Stegosaurus Front Right" },
				{ "Stegosaurus Rear Left Leg" },
				{ "Stegosaurus Rear Right Leg" },
			},
		},
		[0] = {
			fossils = {
				{ "Triceratops Body" },
				{ "Triceratops Skull" },
				{ "Triceratops Tail" },
				{ "Triceratops Front Left Leg" },
				{ "Triceratops Front Right Leg" },
				{ "Triceratops Rear Left Leg" },
				{ "Triceratops Rear Right Leg" },
			},
		},
		[1] = { "TherizinosaurusClaw" },
		[2] = { "TitanoboaVertebrae" },
		[3] = { "Corythosaurus Crest Bone Textured" },
		[4] = { "Dilophosaurus Tooth Textured" },
		[5] = { "Early Primate Arm Bone Textured" },
		[6] = { "Gigantopithecus Jaw Bone Textured" },
		[7] = { "Oviraptor Skull Textured" },
		[8] = { "Deinonychus Claw Bone" },
		[9] = { "Giant Monitor Lizard Skull" },
		[10] = { "Microraptor Skull" },
		[11] = { "Psittacosaurus Skull" },
		[12] = { "Rhamphorhynchus Wing Bone" },
		[13] = { "ArchaeopteryxWingBone" },
		[14] = { "Confuciusornis Wing Bone" },
		[15] = { "Dryosaurus Rib Bone" },
		[16] = { "Hypsilophodon Leg Bone" },
		[17] = { "Jungle Scorpion" },
		[18] = { "AncientStickForest" },
		[19] = { "FreshwaterShrimp" },
		[20] = { "Gecarcinucidae" },
		[21] = { "GiantForestAnt" },
		[22] = { "Pulmonoscorpius" },
	},

	[3] = {
		[-1] = {
			fossils = {
				{ "Mosasaurus Body" },
				{ "Mosasaurus Skull" },
				{ "Mosasaurus Tail" },
				{ "Mosasaurus Front Left Leg" },
				{ "Mosasaurus Front Right Leg" },
				{ "Mosasaurus Rear Left Leg" },
				{ "Mosasaurus Rear Right Leg" },
			},
		},
		[0] = {
			fossils = {
				{ "Spinosaurus Body" },
				{ "Spinosaurus Skull" },
				{ "Spinosaurus Tail" },
				{ "Spinosaurus Front Left Leg" },
				{ "Spinosaurus Front Right Leg" },
				{ "Spinosaurus Rear Left Leg" },
				{ "Spinosaurus Rear Right Leg" },
			},
		},
		[1] = { "Deinosuchus Armor Plate" },
		[2] = { "Stupendemys Shell" },
		[3] = { "Basilosaurus Rib Bone" },
		[4] = { "Lurdusaurus Leg Bone" },
		[5] = { "Ouranosaurus Vertebra1" },
		[6] = { "Plesiosaur Neck Bone" },
		[7] = { "Sarcosuchus Tooth" },
		[8] = { "Belemnite Guard (Bullet Fossil)" },
		[9] = { "Early River Dolphin Vertebra" },
		[10] = { "IguanodonArmBone" },
		[11] = { "Mantellisaurus Arm Bone" },
		[12] = { "Onchopristis Rostrum Tooth" },
		[13] = { "AncientRiverCrabClaw" },
		[14] = { "IchthyornisSkull" },
		[15] = { "LungFishToothPlate" },
		[16] = { "SoftShellTurtleShell" },
		[17] = { "TiktaalikSkull" },
		[18] = { "FreshWaterMussel" },
		[19] = { "GarScale" },
		[20] = { "GiantWaterBug" },
		[21] = { "NymphDragonfly" },
		[22] = { "TriopsCancriformisFossil" },
	},
}
