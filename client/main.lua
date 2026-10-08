local isTabletOpen = false

local function getCardinalDirection()
    local heading = GetEntityHeading(PlayerPedId())
    if heading >= 315 or heading < 45 then
        return 'North'
    elseif heading >= 45 and heading < 135 then
        return 'East'
    elseif heading >= 135 and heading < 225 then
        return 'South'
    else
        return 'West'
    end
end

local function getCurrentStreetName()
    local coords = GetEntityCoords(PlayerPedId())
    local streetHash, crossHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local street = GetStreetNameFromHashKey(streetHash)
    if crossHash ~= 0 then
        local cross = GetStreetNameFromHashKey(crossHash)
        return street .. ' / ' .. cross
    end
    return street ~= '' and street or 'Los Santos'
end

local function openTablet()
    if isTabletOpen then return end
    isTabletOpen = true

    local hours = GetClockHours()
    local minutes = GetClockMinutes()
    local period = hours >= 12 and 'PM' or 'AM'
    local displayHours = hours % 12
    if displayHours == 0 then displayHours = 12 end
    local timeFormatted = string.format('%d:%02d %s', displayHours, minutes, period)

    local days = { 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday' }
    local currentDay = days[GetClockDayOfWeek() + 1] or 'Tuesday'

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'setVisible',
        data = true
    })
    SendNUIMessage({
        action = 'updateEnvironment',
        data = {
            currentTime = timeFormatted,
            dayName = currentDay,
            locationName = getCurrentStreetName(),
            currentDate = currentDay .. ', ' .. GetClockMonth() .. 'th'
        }
    })
end

local function closeTablet()
    if not isTabletOpen then return end
    isTabletOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
end

RegisterNUICallback('close', function(_, cb)
    closeTablet()
    cb('ok')
end)

RegisterNUICallback('setWeather', function(data, cb)
    if data and data.weather then
        TriggerServerEvent('qbx_management:server:setWeather', data.weather, data.instant or false)
    end
    cb('ok')
end)

RegisterNUICallback('setTime', function(data, cb)
    if data and data.hours ~= nil and data.minutes ~= nil then
        TriggerServerEvent('qbx_management:server:setTime', tonumber(data.hours), tonumber(data.minutes))
    end
    cb('ok')
end)

RegisterNUICallback('toggleFreezeWeather', function(data, cb)
    TriggerServerEvent('qbx_management:server:toggleFreezeWeather', data.freeze)
    cb('ok')
end)

RegisterNUICallback('toggleInstantChange', function(data, cb)
    TriggerServerEvent('qbx_management:server:toggleInstantChange', data.instant)
    cb('ok')
end)

RegisterNUICallback('toggleBlackout', function(data, cb)
    TriggerServerEvent('qbx_management:server:toggleBlackout', data.blackout)
    cb('ok')
end)

RegisterNUICallback('toggleSnow', function(data, cb)
    TriggerServerEvent('qbx_management:server:toggleSnow', data.snow)
    cb('ok')
end)

RegisterNUICallback('toggleFreezeTime', function(data, cb)
    TriggerServerEvent('qbx_management:server:toggleFreezeTime', data.freeze)
    cb('ok')
end)

RegisterNUICallback('resetWeatherSettings', function(_, cb)
    TriggerServerEvent('qbx_management:server:resetSettings')
    cb('ok')
end)

RegisterCommand('climatime', function()
    openTablet()
end, false)

RegisterKeyMapping('climatime', 'Open Climatime Tablet', 'keyboard', 'F6')

exports('openTablet', openTablet)
exports('closeTablet', closeTablet)
