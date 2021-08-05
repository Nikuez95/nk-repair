ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('kitavanzato', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "mechanic" then 
	    TriggerClientEvent('nk-repair:client:triggerMenu', source)
    end
end)

RegisterServerEvent("nk-repair:removeitem")
AddEventHandler("nk-repair:removeitem", function(item, quantita)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem(item).count >= (quantita) then
        xPlayer.removeInventoryItem(item, quantita)
    else
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'You don\'t have enough: '..item.label)
    end
end)
