---@diagnostic disable: undefined-field, need-check-nil, param-type-mismatch

local function ObjectInFront(ped, coords)
	local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.5, 0.0)
	local car = CastRayPointToPoint(coords.x, coords.y, coords.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, ped, 0)
	local _, _, _, _, result = GetRaycastResult(car)
	return result
end

local function GetVehicleInDirection(playerPed, pCoords)
	local inDirection = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
	local rayHandle    = StartShapeTestRay(pCoords, inDirection, 10, playerPed, 0)
	local _, hit, _, _, entityHit = GetShapeTestResult(rayHandle)

	if hit == 1 and GetEntityType(entityHit) == 2 then
		return entityHit
	end

	return nil
end

local AnimsDicts = {
	"mp_car_bomb",
	"move_crawl",
	"amb@world_human_vehicle_mechanic@male@base"
}

local function loadAnim(table)
	local RequestAnimDict = RequestAnimDict
    local HasAnimDictLoaded = HasAnimDictLoaded

	for i = 1, #table do
		local animName = table[i]

		if not HasAnimDictLoaded(animName) then
			RequestAnimDict(animName)
			if coroutine.isyieldable() then
				while not HasAnimDictLoaded(animName) do Citizen.Wait(10) end
			end
		end
	end
end

local function startRepair(veh)
	loadAnim(AnimsDicts)
	TriggerServerEvent("nk-repair:removeItem", Shared.ItemUseToRepair, 1)

	local ped 			= PlayerPedId()
	local coords 		= GetEntityCoords(ped)
	local dict 			= "mp_car_bomb"
	local model 		= 'prop_carjack'
	local offset 		= GetOffsetFromEntityInWorldCoords(ped, 0.0, -2.0, 0.0)
	local heading 		= GetEntityHeading(ped)
	local vehpos 		= GetEntityCoords(veh)
	local vehicle 		= GetVehicleInDirection(ped, coords)

	if not HasModelLoaded(model) then RequestModel(model) if coroutine.isyieldable() then while not HasModelLoaded(model) do Citizen.Wait(10) end end end
	if not HasAnimDictLoaded(dict) then RequestAnimDict(dict) if coroutine.isyieldable() then while not HasAnimDictLoaded(dict) do Citizen.Wait(10) end end end

	FreezeEntityPosition(veh, true)

	local vehjack = CreateObject(joaat(model), 0, 0, 0, true, true, true)
	SetEntityCoords(vehjack, vehpos.x, vehpos.y, vehpos.z - 0.5, false, false, false, false)

	Shared.ProgressBar(9250, "Positioning the car jack")
	
	AttachEntityToEntity(vehjack, veh, 0, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
	Citizen.Wait(1250)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)

	dict = 'move_crawl'

	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.5, true, true, true)
	SetEntityCollision(veh, false, false)
	TaskPedSlideToCoord(ped, offset.x, offset.y, offset.z, heading, 1000)
	Citizen.Wait(1000)
	
	Shared.ProgressBar(11000, "Fixing the vehicle")
	TaskPlayAnimAdvanced(ped, dict, 'onback_bwd', coords.x, coords.y, coords.z, 0.0, 0.0, heading - 180, 1.0, 0.5, 3000, 1, 0.0, 1, 1)

	dict = 'amb@world_human_vehicle_mechanic@male@base'
	
	Citizen.Wait(3000)
	TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 5000, 1, 0, false, false, false)

	dict = 'move_crawl'

	Citizen.Wait(4000)
	SetVehicleFixed(vehicle)
	SetVehicleDeformationFixed(vehicle)
	SetVehicleUndriveable(vehicle, false)
	SetVehicleEngineOn(vehicle, true, true, false)
	Citizen.Wait(1000)

	local coords2 = GetEntityCoords(ped)

	TaskPlayAnimAdvanced(ped, dict, 'onback_fwd', coords2.x, coords2.y, coords2.z, 0.0, 0.0, heading - 180, 1.0, 0.5, 2000, 1, 0.0, 1, 1)
	Citizen.Wait(3000)

	dict = 'mp_car_bomb'
	Shared.ProgressBar(8250, "Lifting the car jack")

	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
	Citizen.Wait(1250)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)

	dict = 'move_crawl'

	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords.x, coords.y, coords.z, 0.0, 0.0, heading, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z, true, true, true)
	FreezeEntityPosition(veh, false)

	Citizen.Wait(100)
	DetachEntity(vehjack, true, false)
	SetEntityCollision(vehjack, false, false)
	DeleteEntity(vehjack)
	SetEntityCollision(veh, true, true)
end


RegisterNetEvent("nk-repair:StartRepair")
AddEventHandler("nk-repair:StartRepair", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local veh = ObjectInFront(playerPed, coords)

	if DoesEntityExist(veh) then
		if IsEntityAVehicle(veh) then
			startRepair(veh)
		end
	end
end)