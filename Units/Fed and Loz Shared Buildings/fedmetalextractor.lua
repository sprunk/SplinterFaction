--------------------------------------------------------------------------------

unitName = [[fedmetalextractor]]

--------------------------------------------------------------------------------

ateranMexCost = Spring.GetModOptions().metalextractorcostateran or 50

metalMultiplier = 2

buildCostMetal = ateranMexCost
energyUse = 0

primaryCEG = "custom:fusionreactionnuclear-1color"

humanName = [[Metal Extractor - Tech 0]]

explodeAsSelfSAs = [[largeBuildingExplosionGenericBlue]]

objectName = [[metalextractort0.s3o]]
script = [[metalextractor_lus.lua]]

tech = [[tech0]]

noenergycost = false

skyhateceg = [[custom:skyhatelasert0]]

VFS.Include("units-configs-basedefs/basedefs/Fed and Loz Shared Buildings/metalextractor_basedef.lua")

unitDef.weaponDefs = weaponDefs
--------------------------------------------------------------------------------

return lowerkeys({ [unitName]    = unitDef })

--------------------------------------------------------------------------------