local serverState = {
    weather = 'CLEAR',
    freezeWeather = false,
    instantChange = false,
    blackout = false,
    forceSnow = false,
    freezeTime = false,
    hours = 12,
    minutes = 0,
}

local validWeatherTypes = {
    CLEAR = true,
    CLOUDS = true,
    EXTRASUNNY = true,
    OVERCAST = true,
    RAIN = true,
    THUNDER = true,
    XMAS = true,
    FOGGY = true,
    CLEARING = true,
    SMOG = true,
    NEUTRAL = true,
    BLIZZARD = true,
    SNOWLIGHT = true,
    HALLOWEEN = true,
}

RegisterNetEvent('qbx_management:server:setWeather', function(weather, instant)
    local src = source
    if not validWeatherTypes[weather] then return end

    serverState.weather = weather
    serverState.instantChange = instant and true or false

    TriggerClientEvent('qbx_management:client:syncWeather', -1, serverState.weather, serverState.instantChange)
end)

RegisterNetEvent('qbx_management:server:setTime', function(hours, minutes)
    local src = source
    hours = math.max(0, math.min(23, tonumber(hours) or 12))
    minutes = math.max(0, math.min(59, tonumber(minutes) or 0))

    serverState.hours = hours
    serverState.minutes = minutes

    TriggerClientEvent('qbx_management:client:syncTime', -1, serverState.hours, serverState.minutes)
end)

RegisterNetEvent('qbx_management:server:toggleFreezeWeather', function(freeze)
    serverState.freezeWeather = freeze and true or false
    TriggerClientEvent('qbx_management:client:syncFreezeWeather', -1, serverState.freezeWeather)
end)

RegisterNetEvent('qbx_management:server:toggleInstantChange', function(instant)
    serverState.instantChange = instant and true or false
end)

RegisterNetEvent('qbx_management:server:toggleBlackout', function(blackout)
    serverState.blackout = blackout and true or false
    TriggerClientEvent('qbx_management:client:syncBlackout', -1, serverState.blackout)
end)

RegisterNetEvent('qbx_management:server:toggleSnow', function(snow)
    serverState.forceSnow = snow and true or false
    TriggerClientEvent('qbx_management:client:syncSnow', -1, serverState.forceSnow)
end)

RegisterNetEvent('qbx_management:server:toggleFreezeTime', function(freeze)
    serverState.freezeTime = freeze and true or false
    TriggerClientEvent('qbx_management:client:syncFreezeTime', -1, serverState.freezeTime)
end)

RegisterNetEvent('qbx_management:server:resetSettings', function()
    serverState.weather = 'CLEAR'
    serverState.freezeWeather = false
    serverState.instantChange = false
    serverState.blackout = false
    serverState.forceSnow = false
    serverState.freezeTime = false

    TriggerClientEvent('qbx_management:client:syncWeather', -1, serverState.weather, false)
    TriggerClientEvent('qbx_management:client:syncBlackout', -1, false)
    TriggerClientEvent('qbx_management:client:syncSnow', -1, false)
    TriggerClientEvent('qbx_management:client:syncFreezeWeather', -1, false)
    TriggerClientEvent('qbx_management:client:syncFreezeTime', -1, false)
end)
