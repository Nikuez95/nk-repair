---@diagnostic disable: need-check-nil, undefined-field

local ESX, QBCore = nil, nil
local isESX_Version, isQBCore_Version = false, false

if GetResourceState('es_extended') == 'started' then
	ESX = exports['es_extended']:getSharedObject()

    ESX.RegisterUsableItem(Shared.ItemUseToRepair, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)

        if Shared.IsWhitelisted then
            for k, v in pairs(Shared.WhitelistedJobs) do
                if xPlayer.job.name == v then
                    TriggerClientEvent('nk-repair:StartRepair', source)
                end
            end
        else
            TriggerClientEvent('nk-repair:StartRepair', source)
        end
    end)

    isESX_Version = true
elseif GetResourceState('qb-core') == 'started' then
	QBCore = exports['qb-core']:GetCoreObject()

    QBCore.Functions.CreateUseableItem(Shared.ItemUseToRepair, function(source)
        local Player = QBCore.Functions.GetPlayer(source)

        if Shared.IsWhitelisted then
            for k, v in pairs(Shared.WhitelistedJobs) do
                if Player.PlayerData.job.name == v then
                    TriggerClientEvent('nk-repair:StartRepair', source)
                end
            end
        else
            TriggerClientEvent('nk-repair:StartRepair', source)
        end
    end)

    isQBCore_Version = true
end


RegisterServerEvent("nk-repair:removeItem")
AddEventHandler("nk-repair:removeItem", function(item, qty)
    if not Shared.MustItemRemove then return end

    if isESX_Version then
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem(item, qty)
    elseif isQBCore_Version then
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.RemoveItem(item, qty)
    end
end)
