unitDef                    = {
	buildCostEnergy              = 0,
	buildCostMetal               = 1500,
	builder                      = false,
	buildTime                    = 5,
	buildpic					 = "lozpulverizer.png",
	canAttack                    = true,
	canGuard                     = true,
	canMove                      = true,
	canPatrol                    = true,
	canstop                      = "1",
	category                     = "GROUND",
	description                  = [[Anti-Air Support Tank]],
	energyMake                   = 0,
	energyStorage                = 0,
	energyUse                    = 0,
	explodeAs                    = explodeAs,
	footprintX                   = 4,
	footprintZ                   = 4,
	iconType                     = "antiair",
	idleAutoHeal                 = .5,
	idleTime                     = 2200,
	leaveTracks                  = false,
	maxDamage                    = 375,
	maxSlope                     = 26,
	maxVelocity                  = 1.7,
	maxReverseVelocity           = 1,
	maxWaterDepth                = 10,
	metalStorage                 = 0,
	movementClass                = "WHEELEDTANK4",
	name                         = humanName,
	noChaseCategory              = "VTOL",
	objectName                   = objectName,
	script			             = script,
	radarDistance                = 0,
	repairable		             = false,
	selfDestructAs               = explodeAs,
	side                         = "CORE",
	sightDistance                = 750,
	smoothAnim                   = true,
	stealth			             = true,
	seismicSignature             = 2,
	transportbyenemy             = false;
	unitname                     = unitName,
	upright                      = false,
	workerTime                   = 0,
	--------------
	-- Movement --
	--------------
	acceleration 				 = 2,
	brakeRate                    = 0.1,
	turninplace 				 = true,
	turninplacespeedlimit 		 = 10,
	turnInPlaceAngleLimit		 = 45,
	turnrate 				 	 = 400,
	--------------
	--------------
	sfxtypes                     = { 
		pieceExplosionGenerators = { 
			"deathceg3", 
			"deathceg4", 
		}, 

		explosiongenerators      = {
			"custom:gdhcannon",
			"custom:emptydirt",
			"custom:blacksmoke",
		},
	},
	sounds                       = {
		underattack              = "other/unitsunderattack1",
		ok                       = {
			"ack",
		},
		select                   = {
			"unitselect",
		},
	},
	weapons                      = {
		[1]                      = {
			def                  = "lasercannon",
			badTargetCategory     = "BUILDING",
			onlyTargetCategory    = "GROUND BUILDING AIR SHIP",
		},
		[2]                      = {
			def                  = "flakcannon",
			onlyTargetCategory    = "AIR",
		},
	},
	customParams                 = {
		unittype				 = "mobile",
		unitrole				 = "Anti-Air - Tech 2",
		canbetransported 		 = "true",
		needed_cover             = 3,
		death_sounds             = "generic",
		RequireTech              = tech,
		nofriendlyfire	         = "1",
		supply_cost              = 1,
		normaltex                = "unittextures/lego2skin_explorernormal.dds", 
		buckettex                = "unittextures/lego2skin_explorerbucket.dds",
		factionname	             = "Loz Alliance",
		corpse                   = "energycore",
	}
}

weaponDefs                 = {
	lasercannon                  = {
		predictboost	         = 0.3,
		avoidFeature             = false,
		avoidFriendly            = false,
		beamTime                 = 0.1,
		beamttl                  = 4,
		collideFeature           = false,
		collideFriendly          = false,
		coreThickness            = 0.3,
		duration                 = 0.1,
		energypershot            = 0,
		explosionGenerator       = "custom:genericshellexplosion-small",
		fallOffRate              = 1,
		fireStarter              = 50,
		interceptedByShieldType  = 4,
		impulsefactor		     = 0.1,

		largebeamlaser	         = true,
		laserflaresize 	         = 8,
		minintensity             = 1,
		name                     = "High Intensity Beam Laser",
		range                    = 750,
		reloadtime               = 0.2,
		WeaponType               = "BeamLaser",
		rgbColor                 = "0.1 0 0.3",
		rgbColor2                = "1 1 1",
		soundTrigger             = true,
		soundstart               = "weapons/aegis.wav",
		--	soundHit		     = "weapons/amphibmedtankshothit.wav",
		scrollspeed		         = 5,
		texture1                 = "lightning",
		texture2                 = "laserend",
		thickness                = 4,
		tolerance                = 3000,
		turret                   = true,
		weaponVelocity           = 1000,
		customparams              = {
			expl_light_color	= purple, -- As a string, RGB
			expl_light_radius	= smallExplosion, -- In Elmos
			expl_light_life		= smallExplosionTTL, -- In frames I.E. 30 frames = 1 second
			expl_light_opacity  = 0.25, -- Use this sparingly
		},
		damage                    = {
			default               = 6,
		},
	},

	flakcannon   	             = {
		predictboost	         = 0.3,
		AreaOfEffect             = 150,
		avoidFeature             = false,
		avoidFriendly            = false,
		collideFeature           = false,
		collideFriendly          = false,
		canAttackGround 		 = false,
		coreThickness            = 0.5,
		burnblow		         = true,
		burst					 = 5,
		burstrate				 = 0.1,
		--cegTag                   = "railgun",
		duration                 = 0.05,
		energypershot            = 0,
		explosionGenerator       = "custom:genericshellexplosion-medium",
		edgeEffectiveness		 = 1,
		fallOffRate              = 1,
		fireStarter              = 50,
		impulseFactor            = 0,
		minintensity             = "1",
		name                     = "Flak Cannon",
		range                    = 750,
		reloadtime               = 4,
		WeaponType               = "Cannon",
		rgbColor                 = "1 0.5 0",
		rgbColor2                = "1 1 1",
		soundTrigger             = false,
		soundstart               = "weapons/Assault Rifle Shot_05.wav",
		soundhit				 = "deathsounds/generic/Explosion Fireworks_01.wav",
		sprayangle				 = 500,
		size					 = 3,
		--texture1                 = "shot",
		--texture2                 = "empty",
		tolerance                = 7500,
		turret                   = true,
		weaponVelocity           = 3000,
		customparams             = {
			expl_light_color	= purple, -- As a string, RGB
			expl_light_radius	= smallExplosion, -- In Elmos
			expl_light_life		= smallExplosionTTL, -- In frames I.E. 30 frames = 1 second
			expl_light_opacity  = 0.25, -- Use this sparingly
		},
		damage                   = {
			default              = 30,
		},
	},
}
