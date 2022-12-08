if Config.Global["LegacyExtended"] then
    ESX = exports['es_extended']:getSharedObject()
else
    ESX = nil

    Citizen.CreateThread(function()
	    while ESX == nil do
	    	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	    	Citizen.Wait(0)
	    end
    end)
end

local tajmer = 300
local ox_inventory = exports.ox_inventory


Objects = {}

AddEventHandler("onResourceStop", function(res)
  if GetCurrentResourceName() == res then
    for i = 1, #Objects do
        DeleteObject(Objects[i])
    end
  end
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


CreateThread(function()
    for k, v in pairs(Config.SankerPeds) do

        RequestModel(GetHashKey(v.Hash))
        while not HasModelLoaded(GetHashKey(v.Hash)) do
            Wait(1)
        end

        PostaviPeda = CreatePed(4, v.Hash, v.Coords, v.Heading, false, true)
        TaskStartScenarioInPlace(PostaviPeda, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, false)
        FreezeEntityPosition(PostaviPeda, true) 
        SetEntityInvincible(PostaviPeda, true)
        SetBlockingOfNonTemporaryEvents(PostaviPeda, true)

    end

    for k, v in pairs(Config.Blip) do
        
        local blip = AddBlipForCoord(v.Coords)

        SetBlipSprite (blip, v.Sprite)
        SetBlipDisplay(blip, v.Display)
        SetBlipScale  (blip, v.Scale)
        SetBlipColour (blip, v.Colour)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(v.Name)
        EndTextCommandSetBlipName(blip)
    end

    for k, v in pairs(Config.SankerQtarget) do
        exports.qtarget:AddBoxZone("karting", v.Coords, v.Length, v.Width, {
            name       = "karting",
            heading    = v.Heading,
            debugPoly  = v.debugPoly,
            minZ       = v.MinZ,
            maxZ       = v.MaxZ,
        }, {
            options = {
                {
                    action = function()
                        kartingmeni()
                    end,
                    label = v.Label,
                },
            },
            distance = v.Distance
        })
    end

    for k, v in pairs(Config.RentPed) do

        RequestModel(GetHashKey(v.Hash))
        while not HasModelLoaded(GetHashKey(v.Hash)) do
           Wait(1)
        end
        PostaviPeda2 = CreatePed(4, v.Hash, v.Coords, v.Heading, false, true)
        TaskStartScenarioInPlace(PostaviPeda2, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, false)
        FreezeEntityPosition(PostaviPeda2, true) 
        SetEntityInvincible(PostaviPeda2, true)
        SetBlockingOfNonTemporaryEvents(PostaviPeda2, true)

    end

    for k, v in pairs(Config.RentQtarget) do
        exports.qtarget:AddBoxZone("uzimanjevozila", v.Coords, v.Length, v.Width, {
            name       = "uzimanjevozila",
            heading    = v.Heading,
            debugPoly  = v.debugPoly,
            minZ       = v.MinZ,
            maxZ       = v.MaxZ,
        }, {
            options = {
                {
                    action = function()
                        kartinserver()
                    end,
                    label = v.Label,
                },
            },
            distance = v.Distance
        })
    end

    if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Global["KartingJob"] then  
        for k, v in pairs(Config.Sef) do
            RequestModel(GetHashKey(v.Hash))
            while not HasModelLoaded(v.Hash) do Wait(100) end
          
            PostaviSef = CreateObject(v.Hash, v.Coords, false, true)
            SetEntityHeading(PostaviSef, v.Heading)
            FreezeEntityPosition(PostaviSef, true) 
            SetEntityInvincible(PostaviSef, true)
            PlaceObjectOnGroundProperly(PostaviSef)
            table.insert(Objects, PostaviSef)
            SetModelAsNoLongerNeeded(v.Hash)
        end

        for k, v in pairs(Config.JobBlip) do

            local blip2 = AddBlipForCoord(v.Coords)

            SetBlipSprite (blip2, v.Sprite)
            SetBlipDisplay(blip2, v.Display)
            SetBlipScale  (blip2, v.Scale)
            SetBlipColour (blip2, v.Colour)
            SetBlipAsShortRange(blip2, true)
    
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(v.Name)
            EndTextCommandSetBlipName(blip2)

        end

        for k, v in pairs(Config.SefQtarget) do
            exports.qtarget:AddBoxZone("sefkarting", v.Coords, v.Length, v.Width, {
                name       = "sefkarting",
                heading    = v.Heading,
                debugPoly  = v.debugPoly,
                minZ       = v.MinZ,
                maxZ       = v.MaxZ,
            }, {
                options = {
                    {
                        action = function()
                            kartingsef() 
                        end,
                        label = v.Label,
                        job   = Config.Global["KartingJob"]
                    },
                },
                distance = v.Distance
            })
        end
    end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		sleep = true
		for i=1, #Config.textovi, 1 do
			local distance = #(GetEntityCoords(ESX.PlayerData.ped) - Config.textovi[i].loc)
			if distance < 5.0 then
				sleep = false
				Draw3DText(Config.textovi[i].loc.x, Config.textovi[i].loc.y, Config.textovi[i].loc.z, Config.textovi[i].text)
			end
		end
		if sleep then Citizen.Wait(1500) end
	end
end)

function Draw3DText(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropShadow(0, 0, 0, 55)
		SetTextEdge(0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

function kartingmeni()
    lib.registerContext({
        id = 'karting',
        title = 'Karting Meni',
        options = {
            {
                title = 'Zeton',
                description = 'Cena = 20$',
                event = "gg:dajezeton",
                icon = 'fa-solid fa-cart-shopping',
            },
        }
    })
    lib.showContext('karting')
end

RegisterNetEvent("gg:dajezeton", function()
    ESX.TriggerServerCallback("gg:jelima", function() 
    end)  
end)


function kartinserver()
    TriggerServerEvent("gg:zeton")
end


RegisterNetEvent("gg:stvorivozilo", function() 
    for k, v in pairs(Config.RentSettings) do

        local ped = PlayerPedId()
        local igrackord = GetEntityCoords(ped)
        local kordinate = v.Coords
	
        if Config.Locales["MythicNotify"] then
            exports['mythic_notify']:DoHudText('inform', Config.Locales["vozilo"])
        elseif Config.Locales["okokNotify"] then
            exports['okokNotify']:Alert("GG Karting", Config.Locales["vozilo"], 5000, 'info')
        elseif Config.Locales["DefaultNotify"] then
            ESX.ShowNotification(Config.Locales["vozilo"])
        elseif Config.Locales["CustomNotify"] then
            ggNotification(Config.Locales["vozilo"])
        end

        ESX.Game.SpawnVehicle(v.SpawnKod, kordinate, v.Heading, function(vozilo)

		    TaskWarpPedIntoVehicle(ped, vozilo, -1)
		    SetVehicleNumberPlateText(vozilo, Config.Global["PlateName"])
            if Config.Locales["MythicNotify"] then
                exports['mythic_notify']:DoHudText('inform', Config.Locales["tajmer"] .. tajmer)
            elseif Config.Locales["okokNotify"] then
                exports['okokNotify']:Alert("GG Karting", Config.Locales["tajmer"] .. tajmer, 5000, 'info')
            elseif Config.Locales["DefaultNotify"] then
                ESX.ShowNotification(Config.Locales["tajmer"] .. tajmer)
            elseif Config.Locales["CustomNotify"] then
                ggNotification(Config.Locales["tajmer"] .. tajmer)
            end
		    Citizen.CreateThread(function () 
		    	local counter = tajmer
		    	
		    	while counter > 0 do 
                    if Config.Locales["MythicNotify"] then
                        exports['mythic_notify']:DoHudText('inform', Config.Locales["counter"].. counter)
                    elseif Config.Locales["okokNotify"] then
                        exports['okokNotify']:Alert("GG Karting", Config.Locales["counter"] .. counter .. ' sekundi', 5000, 'info')
                    elseif Config.Locales["DefaultNotify"] then
                        ESX.ShowNotification(Config.Locales["counter"] .. counter .. ' sekundi')
                    elseif Config.Locales["CustomNotify"] then
                        ggNotification(Config.Locales["counter"].. counter)
                    end
		    		counter = counter - 10
		    		Citizen.Wait(10000)
		    	end
		    	DeleteVehicle(vozilo)
		    	SetEntityCoords(ped, igrackord, false, false, false, false)
                if Config.Locales["MythicNotify"] then
                    exports['mythic_notify']:DoHudText('inform', Config.Locales["endrent"])
                elseif Config.Locales["okokNotify"] then
                    exports['okokNotify']:Alert("GG Karting", Config.Locales["endrent"], 5000, 'info')
                elseif Config.Locales["DefaultNotify"] then
                    ESX.ShowNotification(Config.Locales["endrent"])
                elseif Config.Locales["CustomNotify"] then
                    ggNotification(Config.Locales["endrent"])
                end
		    end)
            SetEntityCoords(ped, kordinate)
        end)
    end
end)

function ggNotification(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(m_text)
	DrawNotification(true, false)
end


for k, v in pairs(Config.BossQtarget) do
    exports.qtarget:AddBoxZone("kartingboss", v.Coords, v.Length, v.Width, {
        name       = "kartingboss",
        heading    = v.Heading,
        debugPoly  = v.debugPoly,
        minZ       = v.MinZ,
        maxZ       = v.MaxZ,
    }, {
        options = {
            {
                event = "direktorskeradnje4",
                label = v.Label,
                job = {[Config.Global["KartingJob"]] = 3}, -- samo boss
            },
        },
        distance = v.Distance
    })
end

function kartingsef()    
    if ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Global["KartingJob"] then  
        TriggerEvent('ox_inventory:openInventory', 'stash',  "kartingsef" )
    end  
end

print("gg_karting : Uspesno Pokrenut") -- f8 console
