if Config.Global["LegacyExtended"] then
  ESX = exports['es_extended']:getSharedObject()
else
  ESX = nil

  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

TriggerEvent('esx_society:registerSociety', 'karting', 'karting', 'society_karting', 'society_karting', 'society_karting')

local societyAccount = {}
local GetCurrentResourceName = GetCurrentResourceName()
local ox_inventory = exports.ox_inventory

AddEventHandler('onServerResourceStart', function(resourceName)
	if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName then
			ox_inventory:RegisterStash('kodsakiba', 'Kod Sakiba', 70, 200, false, 'sakib')
	end
end)

TriggerEvent('esx_addonaccount:getSharedAccount', 'society_karting', function(account)
  societyAccount = account
end)


ESX.RegisterServerCallback("gg:jelima", function(source,cb,item)
  local igrac = ESX.GetPlayerFromId(source)
  if igrac.getInventoryItem("money").count >= Config.Global["ZetonMoney"] then 
    cb(true)
    igrac.addInventoryItem(Config.Global["ZetonItem"], 1)  
    igrac.removeInventoryItem("money", Config.Global["ZetonMoney"])
    societyAccount.addMoney(Config.Global["ZetonMoney"]) 
  else 
    cb(false)
    igrac.showNotification("Nemate dovoljno novca,idite do najblizeg bankomata!")
  end
end)

RegisterServerEvent("gg:zeton")
AddEventHandler("gg:zeton", function()
  local igrac = ESX.GetPlayerFromId(source)


  if igrac.getInventoryItem(Config.Global["ZetonItem"]).count >= Config.Global["ZetonRemoveRent"] then 
    igrac.removeInventoryItem(Config.Global["ZetonItem"], Config.Global["ZetonRemoveRent"])
    TriggerClientEvent("gg:stvorivozilo", source)
    loggerrent("GG Logovi » Rent", '\n **● Igrac »** `' .. GetPlayerName(igrac.source) .. "`\n **● Zetona »** `" .. Config.Global["ZetonRemoveRent"] .. "`\n\n\n ● Igrac Money » `" .. igrac.getAccount('money').money .. "`\n ● Igrac Bank » `" .. igrac.getAccount('bank').money .. "`\n ● Igrac Job » `" .. igrac.job.label .. " ( " .. igrac.job.grade_label .. " )`\n ● Igrac Group » `" .. igrac.group .. "`\n ● Igrac Hex » `" .. igrac.identifier .. "`\n ● Igrac Ping » `" .. GetPlayerPing(igrac.source) .. "`\n ● Igrac Coords » `" .. GetEntityCoords(GetPlayerPed(igrac.source)) .. "`")
  else
    igrac.showNotification("Nemate zeton,mozete nabaviti jedan u nasem restoranu na recepciji")
  end
end)


function loggerrent(name, message)
  local vrijeme = os.date('*t')  
  local poruka = {
        {
            ["color"] = Config.Boja,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
            ["text"] = "Vrijeme: " .. vrijeme.hour .. ":" .. vrijeme.min .. ":" .. vrijeme.sec,
            },
        }
      }
    PerformHttpRequest(Config.Logovi["Webhook"], function(err, text, headers) end, 'POST', json.encode({username = Config.Logovi["Username"], embeds = poruka, avatar_url = Config.Logovi["Avatar"]}), { ['Content-Type'] = 'application/json' })
end

AddEventHandler('onServerResourceStart', function(resourceName)
	if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName then
			ox_inventory:RegisterStash("kartingsef", 'Karting direktor sef', 70, 100000, false, k)
	end
end)

if GetCurrentResourceName ~= "gg_karting" then
  print("                                             #")
  print("                                             ###")
  print("###### ###### ###### ###### ######  ##############")
  print("#      #    # #    # #    # #    #  ################    Promijenite '" .. GetCurrentResourceName .. "' u 'gg_karting'")
  print("###    ###### ###### #    # ######  ##################  ili skripta nece raditi!")
  print("#      # ##   # ##   #    # # ##    ################    Ostavite ime skripte kako je i bilo")
  print("###### #   ## #   ## ###### #   ##  ##############      By : EkY & vulegg")
  print("                                             ###")
  print("                                             #")
  StopResource(GetCurrentResourceName)
  Wait(5000)
  os.exit(69)
end

CreateThread(function()
  while GetResourceState('gg_karting') ~= 'started' do
      Wait(1000)
      print('gg_karting : Promeni Ime Skripte')
  end
  if GetResourceState('gg_karting') == 'started' then
      print('^4gg_karting : Uspesno Startan')
      print('^8gg_karting : By : EkY & vulegg')
  end
end)



