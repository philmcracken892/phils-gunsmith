Config = {}


Config.CraftingLocations = {
    {
        coords = vector3(-277.15, 779.10, 119.50), -- Valentine gunsmith
        radius = 2.0,
        name = "Valentine Crafting Station"
    },
    {
        coords = vector3(1326.75, -1321.45, 77.89), -- Saint Denis gunsmith
        radius = 2.0,
        name = "Saint Denis Crafting Station"
    },
    {
        coords = vector3(-179.22, 627.85, 114.09), -- Rhodes gunsmith
        radius = 2.0,
        name = "Rhodes Crafting Station"
    }
}

Config.RequireJob = false
Config.RequiredJob = "gunsmith"
Config.RepairTime = 10 -- Repair time in seconds
Config.RepairCostMultiplier = 0.5 -- Base cost multiplier for repairs

Config.WeaponRecipes = {
    -- Revolvers
    { weapon = "WEAPON_REVOLVER_CATTLEMAN", label = "Cattleman Revolver", materials = { { item = "iron_ore", amount = 5 }, { item = "wood", amount = 2 } }, craftTime = 10 },
    { weapon = "WEAPON_REVOLVER_DOUBLEACTION", label = "Double-Action Revolver", materials = { { item = "iron_ore", amount = 6 }, { item = "wood", amount = 2 } }, craftTime = 12 },
    { weapon = "WEAPON_REVOLVER_SCHOFIELD", label = "Schofield Revolver", materials = { { item = "iron_ore", amount = 7 }, { item = "wood", amount = 3 } }, craftTime = 14 },
    { weapon = "WEAPON_REVOLVER_NAVY", label = "Navy Revolver", materials = { { item = "iron_ore", amount = 8 }, { item = "wood", amount = 3 } }, craftTime = 15 },
    { weapon = "WEAPON_REVOLVER_LEMAT", label = "LeMat Revolver", materials = { { item = "iron_ore", amount = 9 }, { item = "wood", amount = 4 } }, craftTime = 16 },

    -- Pistols
    { weapon = "WEAPON_PISTOL_VOLCANIC", label = "Volcanic Pistol", materials = { { item = "iron_ore", amount = 5 }, { item = "wood", amount = 2 } }, craftTime = 10 },
    { weapon = "WEAPON_PISTOL_SEMIAUTO", label = "Semi-Auto Pistol", materials = { { item = "iron_ore", amount = 7 }, { item = "wood", amount = 3 } }, craftTime = 13 },
    { weapon = "WEAPON_PISTOL_MAUSER", label = "Mauser Pistol", materials = { { item = "iron_ore", amount = 8 }, { item = "wood", amount = 3 } }, craftTime = 14 },

    -- Rifles
    { weapon = "WEAPON_RIFLE_VARMINT", label = "Varmint Rifle", materials = { { item = "iron_ore", amount = 8 }, { item = "wood", amount = 4 } }, craftTime = 15 },
    { weapon = "WEAPON_RIFLE_SPRINGFIELD", label = "Springfield Rifle", materials = { { item = "iron_ore", amount = 10 }, { item = "wood", amount = 5 } }, craftTime = 18 },
    { weapon = "WEAPON_RIFLE_BOLTACTION", label = "Bolt Action Rifle", materials = { { item = "iron_ore", amount = 12 }, { item = "wood", amount = 6 } }, craftTime = 20 },
    { weapon = "WEAPON_RIFLE_ELEPHANT", label = "Elephant Rifle", materials = { { item = "iron_ore", amount = 15 }, { item = "wood", amount = 7 } }, craftTime = 25 },

    -- Repeaters
    { weapon = "WEAPON_REPEATER_CARBINE", label = "Carbine Repeater", materials = { { item = "iron_ore", amount = 7 }, { item = "wood", amount = 4 } }, craftTime = 14 },
    { weapon = "WEAPON_REPEATER_WINCHESTER", label = "Winchester Repeater", materials = { { item = "iron_ore", amount = 9 }, { item = "wood", amount = 5 } }, craftTime = 16 },
    { weapon = "WEAPON_REPEATER_HENRY", label = "Henry Repeater", materials = { { item = "iron_ore", amount = 10 }, { item = "wood", amount = 5 } }, craftTime = 17 },
    { weapon = "WEAPON_REPEATER_EVANS", label = "Evans Repeater", materials = { { item = "iron_ore", amount = 11 }, { item = "wood", amount = 6 } }, craftTime = 18 },

    -- Shotguns
    { weapon = "WEAPON_SHOTGUN_DOUBLEBARREL", label = "Double Barrel Shotgun", materials = { { item = "iron_ore", amount = 9 }, { item = "wood", amount = 4 } }, craftTime = 16 },
    { weapon = "WEAPON_SHOTGUN_SAWEDOFF", label = "Sawed-Off Shotgun", materials = { { item = "iron_ore", amount = 6 }, { item = "wood", amount = 3 } }, craftTime = 12 },
    { weapon = "WEAPON_SHOTGUN_SEMIAUTO", label = "Semi-Auto Shotgun", materials = { { item = "iron_ore", amount = 10 }, { item = "wood", amount = 5 } }, craftTime = 18 },
    { weapon = "WEAPON_SHOTGUN_PUMP", label = "Pump Shotgun", materials = { { item = "iron_ore", amount = 11 }, { item = "wood", amount = 5 } }, craftTime = 19 },

    -- Melee
    { weapon = "WEAPON_MELEE_KNIFE", label = "Knife", materials = { { item = "copper_ore", amount = 3 }, { item = "wood", amount = 1 } }, craftTime = 8 },
    

    -- Bow
    { weapon = "WEAPON_BOW", label = "Bow", materials = { { item = "wood", amount = 5 }, { item = "wool", amount = 2 } }, craftTime = 10 }
}

Config.AmmoTypes = {
    ['ammo_box_revolver']                    = 'ammo_box_revolver',
    ['ammo_box_revolver_express']            = 'ammo_box_revolver_express',
    ['ammo_box_revolver_explosive']          = 'ammo_box_revolver_explosive',
    ['ammo_box_revolver_velocity']           = 'ammo_box_revolver_velocity',
    ['ammo_box_revolver_splitpoint']         = 'ammo_box_revolver_splitpoint',
    ['ammo_box_pistol']                      = 'ammo_box_pistol',
    ['ammo_box_pistol_express']              = 'ammo_box_pistol_express',
    ['ammo_box_pistol_explosive']            = 'ammo_box_pistol_explosive',
    ['ammo_box_pistol_velocity']             = 'ammo_box_pistol_velocity',
    ['ammo_box_pistol_splitpoint']           = 'ammo_box_pistol_splitpoint',
    ['ammo_box_repeater']                    = 'ammo_box_repeater',
    ['ammo_box_repeater_express']            = 'ammo_box_repeater_express',
    ['ammo_box_repeater_explosive']          = 'ammo_box_repeater_explosive',
    ['ammo_box_repeater_velocity']           = 'ammo_box_repeater_velocity',
    ['ammo_box_repeater_splitpoint']         = 'ammo_box_repeater_splitpoint',
    ['ammo_box_rifle']                       = 'ammo_box_rifle',
    ['ammo_box_rifle_express']               = 'ammo_box_rifle_express',
    ['ammo_box_rifle_explosive']             = 'ammo_box_rifle_explosive',
    ['ammo_box_rifle_velocity']              = 'ammo_box_rifle_velocity',
    ['ammo_box_rifle_splitpoint']            = 'ammo_box_rifle_splitpoint',
    ['ammo_box_shotgun']                     = 'ammo_box_shotgun',
    ['ammo_box_shotgun_buckshot_incendiary'] = 'ammo_box_shotgun_buckshot_incendiary',
    ['ammo_box_shotgun_slug']                = 'ammo_box_shotgun_slug',
    ['ammo_box_shotgun_slug_explosive']      = 'ammo_box_shotgun_slug_explosive',
    ['ammo_box_rifle_elephant']              = 'ammo_box_rifle_elephant',
    ['ammo_box_varmint']                     = 'ammo_box_varmint',
    ['ammo_box_varmint_tranquilizer']        = 'ammo_box_varmint_tranquilizer',
    ['ammo_arrow']                           = 'ammo_arrow'
}


Config.AmmoRecipes = {
    
    { ammo = "ammo_box_revolver", label = "Revolver Ammo", materials = { { item = "gunpowder", amount = 2 }, { item = "copper_ore", amount = 2 } }, craftTime = 5, quantity = 12 },
    { ammo = "ammo_box_pistol", label = "Pistol Ammo", materials = { { item = "gunpowder", amount = 2 }, { item = "copper_ore", amount = 2 } }, craftTime = 5, quantity = 12 },
    { ammo = "ammo_box_rifle", label = "Rifle Ammo", materials = { { item = "gunpowder", amount = 3 }, { item = "copper_ore", amount = 3 } }, craftTime = 6, quantity = 12 },
    { ammo = "ammo_box_repeater", label = "Repeater Ammo", materials = { { item = "gunpowder", amount = 3 }, { item = "copper_ore", amount = 3 } }, craftTime = 6, quantity = 12 },
    { ammo = "ammo_box_shotgun", label = "Shotgun Ammo", materials = { { item = "gunpowder", amount = 4 }, { item = "copper_ore", amount = 4 } }, craftTime = 7, quantity = 12 },
    { ammo = "ammo_arrow", label = "Arrows", materials = { { item = "wood", amount = 2 }, { item = "copper_ore", amount = 2 } }, craftTime = 4, quantity = 10 },
    { ammo = "ammo_box_rifle_elephant", label = "Elephant Rifle Ammo", materials = { { item = "gunpowder", amount = 5 }, { item = "copper_ore", amount = 5 } }, craftTime = 8, quantity = 10 },
    
   
    { ammo = "ammo_box_revolver_express", label = "Revolver Express Ammo", materials = { { item = "gunpowder", amount = 3 }, { item = "copper_ore", amount = 2 } }, craftTime = 6, quantity = 12 },
    { ammo = "ammo_box_revolver_explosive", label = "Revolver Explosive Ammo", materials = { { item = "gunpowder", amount = 5 }, { item = "copper_ore", amount = 3 }, { item = "dynamite", amount = 1 } }, craftTime = 8, quantity = 10 },
    { ammo = "ammo_box_revolver_velocity", label = "Revolver High Velocity Ammo", materials = { { item = "gunpowder", amount = 3 }, { item = "copper_ore", amount = 2 } }, craftTime = 6, quantity = 12 },
    { ammo = "ammo_box_revolver_splitpoint", label = "Revolver Split Point Ammo", materials = { { item = "gunpowder", amount = 3 }, { item = "copper_ore", amount = 3 } }, craftTime = 7, quantity = 12 },
    { ammo = "ammo_box_pistol_express", label = "Pistol Express Ammo", materials = { { item = "gunpowder", amount = 3 }, { item = "copper_ore", amount = 2 } }, craftTime = 6, quantity = 12 },
    { ammo = "ammo_box_pistol_explosive", label = "Pistol Explosive Ammo", materials = { { item = "gunpowder", amount = 5 }, { item = "copper_ore", amount = 3 }, { item = "dynamite", amount = 1 } }, craftTime = 8, quantity = 10 },
    { ammo = "ammo_box_pistol_velocity", label = "Pistol High Velocity Ammo", materials = { { item = "gunpowder", amount = 3 }, { item = "copper_ore", amount = 2 } }, craftTime = 6, quantity = 12 },
    { ammo = "ammo_box_pistol_splitpoint", label = "Pistol Split Point Ammo", materials = { { item = "gunpowder", amount = 3 }, { item = "copper_ore", amount = 3 } }, craftTime = 7, quantity = 12 },
    { ammo = "ammo_box_repeater_express", label = "Repeater Express Ammo", materials = { { item = "gunpowder", amount = 4 }, { item = "copper_ore", amount = 3 } }, craftTime = 7, quantity = 12 },
    { ammo = "ammo_box_repeater_explosive", label = "Repeater Explosive Ammo", materials = { { item = "gunpowder", amount = 6 }, { item = "copper_ore", amount = 4 }, { item = "dynamite", amount = 1 } }, craftTime = 9, quantity = 10 },
    { ammo = "ammo_box_repeater_velocity", label = "Repeater High Velocity Ammo", materials = { { item = "gunpowder", amount = 4 }, { item = "copper_ore", amount = 3 } }, craftTime = 7, quantity = 12 },
    { ammo = "ammo_box_repeater_splitpoint", label = "Repeater Split Point Ammo", materials = { { item = "gunpowder", amount = 4 }, { item = "copper_ore", amount = 4 } }, craftTime = 8, quantity = 12 },
    { ammo = "ammo_box_rifle_express", label = "Rifle Express Ammo", materials = { { item = "gunpowder", amount = 4 }, { item = "copper_ore", amount = 3 } }, craftTime = 7, quantity = 12 },
    { ammo = "ammo_box_rifle_explosive", label = "Rifle Explosive Ammo", materials = { { item = "gunpowder", amount = 6 }, { item = "copper_ore", amount = 4 }, { item = "dynamite", amount = 1 } }, craftTime = 9, quantity = 10 },
    { ammo = "ammo_box_rifle_velocity", label = "Rifle High Velocity Ammo", materials = { { item = "gunpowder", amount = 4 }, { item = "copper_ore", amount = 3 } }, craftTime = 7, quantity = 12 },
    { ammo = "ammo_box_rifle_splitpoint", label = "Rifle Split Point Ammo", materials = { { item = "gunpowder", amount = 4 }, { item = "copper_ore", amount = 4 } }, craftTime = 8, quantity = 12 },
    { ammo = "ammo_box_shotgun_buckshot_incendiary", label = "Shotgun Incendiary Buckshot", materials = { { item = "gunpowder", amount = 5 }, { item = "copper_ore", amount = 4 }, { item = "cloth", amount = 2 } }, craftTime = 8, quantity = 7 },
    { ammo = "ammo_box_shotgun_slug", label = "Shotgun Slug Ammo", materials = { { item = "gunpowder", amount = 4 }, { item = "copper_ore", amount = 5 } }, craftTime = 7, quantity = 12 },
    { ammo = "ammo_box_shotgun_slug_explosive", label = "Shotgun Explosive Slug", materials = { { item = "gunpowder", amount = 6 }, { item = "copper_ore", amount = 5 }, { item = "dynamite", amount = 1 } }, craftTime = 9, quantity = 10 },
    { ammo = "ammo_box_varmint", label = "Varmint Ammo", materials = { { item = "gunpowder", amount = 2 }, { item = "copper_ore", amount = 2 } }, craftTime = 5, quantity = 12 },
    { ammo = "ammo_box_varmint_tranquilizer", label = "Varmint Tranquilizer Ammo", materials = { { item = "gunpowder", amount = 3 }, { item = "copper_ore", amount = 2 }, { item = "herb", amount = 1 } }, craftTime = 6, quantity = 12 }
}