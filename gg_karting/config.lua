Config = {}

Config.Global = {
    ["PlateName"] = "GG Karting",
    ["KartingJob"] = "karting",
    ["LegacyExtended"] = true, -- za definisanje esx-a
    ["ZetonItem"] = "zetony",
    ["ZetonMoney"] = 20,
    ["ZetonRemoveRent"] = 1,
}

Config.Logovi = {
    ["Webhook"] = "https://discord.com/api/webhooks/1048595421326483597/QOY8by1xbvqdISqUVGmyhFbtOIjb-HQK2a3hozfk7sDrB7fzVlphX1Ba3yvLjJlG1Tmn",
    ["Avatar"] = "",
    ["Username"] = "GG » Logovi",
}

Config.Locales = {
    ["MythicNotify"] = false,
    ["okokNotify"] = false,
    ["DefaultNotify"] = true,
    ["CustomNotify"] = false, -- vas notify | Dodaj export u ggNotification

    -- Locales

    ["vozilo"] = 'Sacekaj da se vozilo ucita',
    ["tajmer"] = 'Imate jos : ',
    ["counter"] = 'Renta se zavrsava za : ',
    ["endrent"] = 'Vasa renta je zavrsena',
}

function ggNotification(text)
    -- Export 

    -- E.G
    exports['ggNotify']:Alert("GG Karting", text, 5000, 'info')
end

Config.RentSettings = {
    setting1 = { 
        Coords     = vector3(1202.172, 336.3408, 81.990),
        Heading    = 151.68,
        SpawnKod   = "veto"
    }
}

Config.textovi = {
	{ loc = vector3(1276.35, -1710.09, 54.77), text = "Drzi ~b~ALT~s~ da pristupis Boss Meni-u"},
	{ loc = vector3(1269.82, -1709.82, 54.77), text = "Drzi ~b~ALT~s~ da pristupis Sef-u"},
}

Config.Blip = {
    blip = { 
        Coords    = vector3(1213.938, 334.2255, 81.990),
        Sprite    = 358,
        Display   = 4,
        Scale     = 1.0,
        Colour    = 64,
        Name      = 'Karting centar',
    }
}

Config.JobBlip = {
    blip2 = { 
        Coords    = vector3(1270.957, -1709.50, 54.771),
        Sprite    = 50,
        Display   = 4,
        Scale     = 1.0,
        Colour    = 2,
        Name      = 'Vasa kuca',
    }
}

Config.RentPed = {
    ped = { 
        Hash      = 'a_m_y_business_02',
        Coords    = vector3(1215.062, 335.1314, 80.990),
        Heading   = 147.89,
    }
}

Config.SankerPeds = {
    ped2 = { 
        Hash      = 'a_m_m_fatlatin_01',
        Coords    = vector3(1226.708, 327.8534, 80.990),
        Heading   = 154.5,
    }
}

Config.Sef = {
    sef = { 
        Hash      = `prop_ld_int_safe_01`,
        Coords    = vector3(1269.851, -1709.81, 54.771),
        Heading   = 293.39,
    }
}

Config.SankerQtarget = {
    sanker = { 
        Label     = "Pricajte sa sankerom",
        Coords    = vector3(1226.57, 327.6, 81.99),
        Length    = 0.9,
        Width     = 0.9,
        Heading   = 326,
        debugPoly = false,
        MinZ      = 78.79,
        MaxZ      = 82.79,
        Distance  = 3.5
    }   
}

Config.RentQtarget = {
    rent1 = { 
        Label     = "Rentajte karting",
        Coords    = vector3(1215.06, 334.95, 81.99),
        Length    = 0.7,
        Width     = 0.7,
        Heading   = 55,
        debugPoly = false,
        MinZ      = 78.79,
        MaxZ      = 82.79,
        Distance  = 3.5
    }
}

Config.SefQtarget = {
    sef = { 
        Label     = "Otvorite sef",
        Coords    = vector3(1269.82, -1709.82, 54.77),
        Length    = 0.7,
        Width     = 0.9,
        Heading   = 23,
        debugPoly = false,
        MinZ      = 50.97,
        MaxZ      = 54.97,
        Distance  = 3.5
    }
}

Config.BossQtarget = {
    boss = { 
        Label     = "Direktorske radnje",
        Coords    = vector3(1276.35, -1710.09, 54.77),
        Length    = 1.5,
        Width     = 0.9,
        Heading   = 25,
        debugPoly = false,
        MinZ      = 51.37,
        MaxZ      = 55.37,
        Distance  = 4.5
    }
}
