local DISCORD_COMPONENT = {}
DISCORD_COMPONENT._name = "discord"

if Config.DisableDefaultRPC then
    SetDiscordAppId = function() end
    SetDiscordRichPresenceAsset = function() end
    SetDiscordRichPresenceAssetSmall = function() end
    SetDiscordRichPresenceAssetSmallText = function() end
    SetDiscordRichPresenceAssetText = function() end
    SetDiscordRichPresenceAction = function() end
    SetRichPresence = function() end
end

function DISCORD_COMPONENT:RichPresence()
    if not Config.Discord.Enabled then return end

    local conf = Config.Discord

    if conf.AppId and conf.AppId ~= '' then
        SetDiscordAppId(conf.AppId)
    end

    SetDiscordRichPresenceAsset(conf.Assets.LargeLogo)
    SetDiscordRichPresenceAssetText(conf.Assets.LargeText)

    if conf.Assets.SmallLogo and conf.Assets.SmallLogo ~= '' then
        SetDiscordRichPresenceAssetSmall(conf.Assets.SmallLogo)
        SetDiscordRichPresenceAssetSmallText(conf.Assets.SmallText)
    end

    local serverUrl = conf.Urls.ServerInfo
    local discordUrl = conf.Urls.Discord

    SetDiscordRichPresenceAction(0, "Register / Info", "https://" .. serverUrl)
    SetDiscordRichPresenceAction(1, "Join Our Discord", discordUrl)

    local function GetCharacterName()
        if conf.Framework == 'qbx' then
            local pData = nil
            pcall(function()
                pData = exports.qbx_core:GetPlayerData()
            end)
            if pData and pData.charinfo then
                return pData.charinfo.firstname, pData.charinfo.lastname
            end
        elseif conf.Framework == 'qb' then
            local QBCore = exports['qb-core']:GetCoreObject()
            local pData = QBCore.Functions.GetPlayerData()
            if pData and pData.charinfo then
                return pData.charinfo.firstname, pData.charinfo.lastname
            end
        elseif conf.Framework == 'custom' then
            local character = LocalPlayer.state.Character
            if character then
                return character:GetData("First"), character:GetData("Last")
            end
        end
        return nil, nil
    end

    Citizen.CreateThread(function()
        while true do
            local playerCount = GlobalState.PlayerCount or 0
            local maxClients = GlobalState.MaxClients or conf.MaxClients or 100

            local fName, lName = GetCharacterName()

            if fName and lName then
                SetRichPresence(string.format("%s/%s Players - Playing %s %s", playerCount, maxClients, fName, lName))
            else
                SetRichPresence(string.format("%s/%s Players - Selecting a Character", playerCount, maxClients))
            end

            Citizen.Wait(conf.UpdateInterval)
        end
    end)
end

Citizen.CreateThread(function()
    DISCORD_COMPONENT:RichPresence()
end)
