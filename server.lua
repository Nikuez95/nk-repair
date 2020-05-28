local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('fixtool', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local Attrezzatura = xPlayer.getInventoryItem('fixtool')
	if Attrezzatura.count < 1 then
		TriggerClientEvent('esx:showNotification', source, 'Non hai una ~b~Cassetta degli Attrezzi~s~!')
	else
		TriggerClientEvent('nk_repair:MenuRipara', source)
	end
end)

RegisterServerEvent('nk_repair:RimuoviItem')
AddEventHandler('nk_repair:RimuoviItem', function(ped, coords, veh)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('fixtool', 1)
	TriggerClientEvent('nk_repair:MettiCrick', _source, ped, coords, veh)
end)
