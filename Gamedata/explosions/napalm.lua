return {
	["napalm"] = {
		useDefaultExplosions = false,
		fireball = {
			class      = [[CSimpleParticleSystem]],
			count      = 1,
			air        = true,
			ground     = true,
			water      = true,
			underwater = true,
			properties = {
				airdrag             = 0.97,
				colormap            = [[1 1 1 0.1   1 1 1 0.1   1 1 1 0.1   1 1 1 0.1   0 0 0 0   0 0 0 0]],
				directional         = false,
				emitrot             = 0,
				emitrotspread       = 0,
				emitvector          = [[0,1,0]],
				gravity             = [[0,0,0]],
				numparticles        = 1,
				particlelife        = 300,
				particlelifespread  = 50,
				particlesize        = 20,
				particlesizespread  = 50,
				particlespeed       = 1,
				particlespeedspread = 0,
				rotParams           = [[0, 0, 0]],
				animParams          = [[4,4,-10]], --[xTiles, yTiles, animLength in game frames]
				pos                 = [[0,0,0]],
				sizegrowth          = 0.25,
				sizemod             = 1,
				texture             = [[generated-flamesrising]],
				drawOrder           = 0,
				-- castshadow          = true,
			},
		},
	},

	["burnblacknapalm"] = {
		useDefaultExplosions = false,
		fireball = {
			class      = [[CSimpleParticleSystem]],
			count      = 1,
			air        = true,
			ground     = true,
			water      = true,
			underwater = true,
			properties = {
				airdrag             = 0.97,
				colormap            = [[1 1 1 0.1   0 0 0 0   0 0 0 0]],
				directional         = false,
				emitrot             = 0,
				emitrotspread       = 0,
				emitvector          = [[0,1,0]],
				gravity             = [[0,0.1,0]],
				numparticles        = 1,
				particlelife        = 60,
				particlelifespread  = 9,
				particlesize        = 20,
				particlesizespread  = 0,
				particlespeed       = 0,
				particlespeedspread = 0,
				rotParams           = [[0, 0, 0]],
				animParams          = [[4,4,-10]], --[xTiles, yTiles, animLength in game frames]
				pos                 = [[0,0,0]],
				sizegrowth          = 1,
				sizemod             = 1,
				texture             = [[generated-flamesrising]],
				drawOrder           = 0,
				-- castshadow          = true,
			},
		},
	},
}

