-- UNITDEF -- lozengineer --
--------------------------------------------------------------------------------

unitName = "lozengineer"

--------------------------------------------------------------------------------

buildCostMetal = 40
buildDistance = 250

buildpic = [[lozengineer.png]]

maxDamage = 500

lozt1buildlist = Shared.buildListLozt0

workertime = 1 -- Baseline because this gets multiplied in the tech based factory buildspeed gadget

humanName = [[Architect - Tech 0]]

footprintx = 2
footprintz = 2
movementclass = "WHEELEDTANK2"

objectName = [[lozengineer.s3o]]
script = [[lozengineer_lus.lua]]

areamexdef = [[lozmetalextractor]]
requiretech = [[tech0]]

explodeAs = [[smallexplosiongenericgreen]]

VFS.Include("units-configs-basedefs/basedefs/Loz Alliance - Faction 2/lozengineer_basedef.lua")

--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------
