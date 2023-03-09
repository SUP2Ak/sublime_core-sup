
--- Clean
---@param vehicleId number
local function Clean(vehicleId)
    if not DoesEntityExist(vehicleId) then
        local debug <const> = debug.getinfo
        return sl.log.print(3, "Vehicle didnt exist (Function : ^5%s^7, From : [^5%s^7 : %s])", debug(1, "n").name, debug(2, "Sl").short_src, debug(2, "Sl").currentline)
    end

    SetVehicleDirtLevel(vehicleId, 0.0)
    WashDecalsFromVehicle(vehicleId, 1.0)
end

--- Delete
---@param vehicleId number
local function Delete(vehicleId)
    if not DoesEntityExist(vehicleId) then
        local debug <const> = debug.getinfo
        return sl.log.print(3, "Vehicle didnt exist (Function : ^5%s^7, From : [^5%s^7 : %s])", debug(1, "n").name, debug(2, "Sl").short_src, debug(2, "Sl").currentline)
    end

    SetEntityAsMissionEntity(vehicleId, 0, 1)
    DeleteVehicle(vehicleId)
end

--- GetFuelLevel
---@param vehicleId number
---@return number
local function GetFuelLevel(vehicleId)
    if not DoesEntityExist(vehicleId) then
        local debug <const> = debug.getinfo
        return sl.log.print(3, "Vehicle didnt exist (Function : ^5%s^7, From : [^5%s^7 : %s])", debug(1, "n").name, debug(2, "Sl").short_src, debug(2, "Sl").currentline)
    end

    return GetVehicleFuelLevel(vehicleId)
end

--- GetFuelTank
---@param vehicleId number
---@return number
local function GetFuelTank(vehicleId)
    if not DoesEntityExist(vehicleId) then
        local debug <const> = debug.getinfo
        return sl.log.print(3, "Vehicle didnt exist (Function : ^5%s^7, From : [^5%s^7 : %s])", debug(1, "n").name, debug(2, "Sl").short_src, debug(2, "Sl").currentline)
    end

    ---@type number
    local fuel <const> = GetVehicleHandlingFloat(vehicleId, "CHandlingData", "fPetrolTankVolume")
    return fuel
end

--- ModelName
---@param vehicleId number
---@return string
local function ModelName(vehicleId)
    if not DoesEntityExist(vehicleId) then
        local debug <const> = debug.getinfo
        return sl.log.print(3, "Vehicle didnt exist (Function : ^5%s^7, From : [^5%s^7 : %s])", debug(1, "n").name, debug(2, "Sl").short_src, debug(2, "Sl").currentline)
    end

    ---@type string
    local model <const> = GetDisplayNameFromVehicleModel(GetEntityModel(vehicleId))
    return model
end

--- GetPlate
---@param vehicleId number
---@return string|number
local function GetPlate(vehicleId)
    if not DoesEntityExist(vehicleId) then
        local debug <const> = debug.getinfo
        return sl.log.print(3, "Vehicle didnt exist (Function : ^5%s^7, From : [^5%s^7 : %s])", debug(1, "n").name, debug(2, "Sl").short_src, debug(2, "Sl").currentline)
    end

    local plate <const> = GetVehicleNumberPlateText(vehicleId)
    return plate
end

--- GetStates
---@param vehicleId number
---@return table
local function GetStates(vehicleId)
    if not DoesEntityExist(vehicleId) then
        local debug <const> = debug.getinfo
        return sl.log.print(3, "Vehicle didnt exist (Function : ^5%s^7, From : [^5%s^7 : %s])", debug(1, "n").name, debug(2, "Sl").short_src, debug(2, "Sl").currentline)
    end

--TODO IMPROVE THIS FUNCTION

    local vehicleState <const> = {
        engineHealth = GetVehicleEngineHealth(vehicleId),
        vehicleBodyHealth = GetVehicleBodyHealth(vehicleId),
        dirtLevel = GetVehicleDirtLevel(vehicleId),
        engineState = (GetIsVehicleEngineRunning(vehicleId) == 1)
    }
    return vehicleState
end

--- OpenDoor
---@param vehicleId number
local function OpenDoor(vehicleId, doorId, canBeClosed, instantly)
    if not DoesEntityExist(vehicleId) then
        local debug <const> = debug.getinfo
        return sl.log.print(3, "Vehicle didnt exist (Function : ^5%s^7, From : [^5%s^7 : %s])", debug(1, "n").name, debug(2, "Sl").short_src, debug(2, "Sl").currentline)
    end

    if doorId == "all" then
        for i = 0, 5 do
            SetVehicleDoorOpen(vehicleId, i, canBeClosed or false, instantly or false)
        end
    else
        SetVehicleDoorOpen(vehicleId, doorId, canBeClosed or false, instantly or false)
    end
end

--- Lock
---@param vehicleId number
---@param state boolean
local function Lock(vehicleId, state)
    if not DoesEntityExist(vehicleId) then
        local debug <const> = debug.getinfo
        return sl.log.print(3, "Vehicle didnt exist (Function : ^5%s^7, From : [^5%s^7 : %s])", debug(1, "n").name, debug(2, "Sl").short_src, debug(2, "Sl").currentline)
    end

    SetVehicleDoorsLocked(vehicleId, state and 2 or 1)
end

--- Repair
---@param vehicleId number
local function Repair(vehicleId)
    if not DoesEntityExist(vehicleId) then
        local debug <const> = debug.getinfo
        return sl.log.print(3, "Vehicle didnt exist (Function : ^5%s^7, From : [^5%s^7 : %s])", debug(1, "n").name, debug(2, "Sl").short_src, debug(2, "Sl").currentline)
    end

    SetVehicleFixed(vehicleId)
    SetVehicleDirtLevel(vehicleId, 0.0)
    SetVehicleDeformationFixed(vehicleId)
end

--- SetFuel
---@param vehicleId number
---@param fuel number
local function SetFuel(vehicleId, fuel)
    if not DoesEntityExist(vehicleId) then
        local debug <const> = debug.getinfo
        return sl.log.print(3, "Vehicle didnt exist (Function : ^5%s^7, From : [^5%s^7 : %s])", debug(1, "n").name, debug(2, "Sl").short_src, debug(2, "Sl").currentline)
    end

    return SetVehicleFuelLevel(vehicleId, fuel)
end

--- GetType
---@param model string
---@return string
local function GetType(model)
	local VehicleType = GetVehicleClassFromName(model)
	local type = "automobile"
	if VehicleType == 15 then
		type = "heli"
	elseif VehicleType == 16 then
		type = "plane"
	elseif VehicleType == 14 then
		type = "boat"
	elseif VehicleType == 11 then
		type = "trailer"
	elseif VehicleType == 21 then
		type = "train"
	elseif VehicleType == 13 or VehicleType == 8 then
		type = "bike"
	end
	if model == `submersible` or model == `submersible2` then
		type = "submarine"
	end
    return type
end

--- IsEmpty
---@param vehicleId number
---@return boolean
local function IsEmpty(vehicleId)
    if not DoesEntityExist(vehicleId) then
        local debug <const> = debug.getinfo
        return sl.log.print(3, "Vehicle didnt exist (Function : ^5%s^7, From : [^5%s^7 : %s])", debug(1, "n").name, debug(2, "Sl").short_src, debug(2, "Sl").currentline)
    end
    
    local passengers = GetVehicleNumberOfPassengers(vehicleId)
    local driverSeatFree = IsVehicleSeatFree(vehicleId, -1)
    return passengers == 0 and driverSeatFree
end

return {
    clean = Clean,
    delete = Delete,
    get_fuel_level = GetFuelLevel,
    get_fuel_tank = GetFuelTank,
    model_name = ModelName,
    get_plate = GetPlate,
    get_states = GetStates,
    open_door = OpenDoor,
    lock = Lock,
    repair = Repair,
    set_fuel = SetFuel,
    get_type = GetType,
    is_empty = IsEmpty
}