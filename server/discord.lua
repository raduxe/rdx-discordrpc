if not Config.Discord.Enabled then return end

local function UpdatePlayerCount()
    local playerCount = GetNumPlayerIndices()
    local maxClients = GetConvarInt("sv_maxclients", Config.Discord.MaxClients or 100)

    GlobalState.PlayerCount = playerCount
    GlobalState.MaxClients = maxClients
end

Citizen.CreateThread(function()
    UpdatePlayerCount()
    
    while true do
        Wait(Config.Discord.UpdateInterval or 30000)
        UpdatePlayerCount()
    end
end)

AddEventHandler("playerJoining", function()
    SetTimeout(500, function()
        UpdatePlayerCount()
    end)
end)

AddEventHandler("playerDropped", function()
    SetTimeout(500, function()
        UpdatePlayerCount()
    end)
end)
