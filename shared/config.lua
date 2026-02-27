Config = Config or {}

Config.Discord = {
    Enabled = true,

    -- Disable the default QBCore Discord RPC
    DisableDefaultRPC = true,

    -- Discord Application ID (replace with yours)
    AppId = 'APP ID',

    -- Assets uploaded to Discord Developer Portal
    Assets = {
        LargeLogo = 'Large Logo',
        LargeText = 'Large Logo Text',
        SmallLogo = 'Small Logo',
        SmallText = 'Small Text'
    },

    -- URLs for buttons
    Urls = {
        ServerInfo = 'Server Info',
        Discord = 'Discord Invite Link'
    },

    -- Framework selection: 'qbx' | 'qb' | 'none'
    Framework = 'qbx',

    -- Maximum clients setting, fallback if not caught from Convars
    MaxClients = 100,

    -- Update Interval (in ms)
    UpdateInterval = 2500 
}