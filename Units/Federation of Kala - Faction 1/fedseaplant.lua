--------------------------------------------------------------------------------

unitName = "fedseaplant"

--------------------------------------------------------------------------------

buildCostMetal = 300

humanName = [[Sea Factory]]

objectName = "sharedseaplant.s3o"
script = "sharedseaplant.cob"

tech = [[tech1]]

fedseaplantbuildlist = Shared.buildListFedSeaPlant

explodeAs = [[largebuildingexplosiongeneric]]

workerTime = 1 -- Baseline because this gets multiplied in the tech based factory buildspeed gadget

VFS.Include("units-configs-basedefs/configs/explosion_lighting_configs.lua")
VFS.Include("units-configs-basedefs/basedefs/Federation of Kala - Faction 1/fedseaplant_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]      = unitDef })

--------------------------------------------------------------------------------
