-- Script path: ReplicatedStorage.Client.InputIconsConfig
-- Decompile time: 8.36 ms

local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Signal = require(ReplicatedStorage.Packages.Signal)

local function asset(a1) -- Line: 14 -- types: a1: string
    return (("rbxassetid://%*"):format(a1))
end

local u20 = {}
u20.microsoft = {
    [Enum.KeyCode.ButtonA] = "rbxassetid://113824701684322",
    [Enum.KeyCode.ButtonB] = "rbxassetid://107100143818564",
    [Enum.KeyCode.ButtonX] = "rbxassetid://121994310218398",
    [Enum.KeyCode.ButtonY] = "rbxassetid://118121490246715",
    [Enum.KeyCode.ButtonL1] = "rbxassetid://128016621986260",
    [Enum.KeyCode.ButtonL2] = "rbxassetid://121095629027146",
    [Enum.KeyCode.ButtonL3] = "rbxassetid://98426369439432",
    [Enum.KeyCode.ButtonR1] = "rbxassetid://86739128961101",
    [Enum.KeyCode.ButtonR2] = "rbxassetid://121138812911138",
    [Enum.KeyCode.ButtonR3] = "rbxassetid://108823668376359",
    [Enum.KeyCode.ButtonSelect] = "rbxassetid://73640706748399",
    [Enum.KeyCode.ButtonStart] = "rbxassetid://121407964275535",
    [Enum.KeyCode.DPadDown] = "rbxassetid://134006970980101",
    [Enum.KeyCode.DPadLeft] = "rbxassetid://113523064631322",
    [Enum.KeyCode.DPadRight] = "rbxassetid://125621109562134",
    [Enum.KeyCode.DPadUp] = "rbxassetid://110656716055777",
    [Enum.KeyCode.Thumbstick1] = "rbxassetid://86234104961357",
    [Enum.KeyCode.Thumbstick2] = "rbxassetid://92731666763608",
}
u20.sony = {
    [Enum.KeyCode.ButtonA] = "rbxassetid://140688515494419",
    [Enum.KeyCode.ButtonB] = "rbxassetid://89979188218128",
    [Enum.KeyCode.ButtonX] = "rbxassetid://105740811198422",
    [Enum.KeyCode.ButtonY] = "rbxassetid://102844478766253",
    [Enum.KeyCode.ButtonL1] = "rbxassetid://101741164721625",
    [Enum.KeyCode.ButtonL2] = "rbxassetid://92051888341203",
    [Enum.KeyCode.ButtonL3] = "rbxassetid://71736763291675",
    [Enum.KeyCode.ButtonR1] = "rbxassetid://108359563054786",
    [Enum.KeyCode.ButtonR2] = "rbxassetid://95486021989419",
    [Enum.KeyCode.ButtonR3] = "rbxassetid://100766112822921",
    [Enum.KeyCode.ButtonStart] = "rbxassetid://115132567456286",
    [Enum.KeyCode.DPadDown] = "rbxassetid://101700700938948",
    [Enum.KeyCode.DPadLeft] = "rbxassetid://114773739810891",
    [Enum.KeyCode.DPadRight] = "rbxassetid://110011411664004",
    [Enum.KeyCode.DPadUp] = "rbxassetid://77095582918408",
    [Enum.KeyCode.Thumbstick1] = "rbxassetid://87994926804700",
    [Enum.KeyCode.Thumbstick2] = "rbxassetid://123691072001381",
}
local u93 = {}
u93.Changed = Signal.new()
local u96 = {}
local u97 = {}
local u98 = nil

local function relabelled(a1) -- Line: 75 -- upvalues: UserInputService (val)
    local success, err = pcall(UserInputService.GetStringForKeyCode, UserInputService, a1)
    local v1 = success
    if v1 then
        v1 = false
        if typeof(err) == "string" then
            v1 = false
            if err ~= "" then
                v1 = err ~= a1.Name
            end
        end
    end
    return v1
end

local function vendor() -- Line: 80 -- upvalues: u98 (ref), UserInputService (val)
    local v1 = u98
    if v1 == nil then
        local ButtonY = Enum.KeyCode.ButtonY
        local success, err = pcall(UserInputService.GetStringForKeyCode, UserInputService, ButtonY)
        local v2 = success
        if v2 then
            v2 = false
            if typeof(err) == "string" then
                v2 = false
                if err ~= "" then
                    v2 = err ~= ButtonY.Name
                end
            end
        end
        u98 = if not v2 then "microsoft" else "sony"
    end
    return v1
end

local function verify(a1) -- Line: 89
    -- upvalues: u97 (val), ContentProvider (val), u96 (val), u93 (val)
    u97[a1] = true
    task.spawn(function() -- Line: 91 -- upvalues: ContentProvider (upval), a1 (val), u97 (upval), u96 (upval), u93 (upval)
        local u0 = false
        pcall(function() -- Line: 93 -- upvalues: ContentProvider (upval), a1 (upval), u0 (ref)
            ContentProvider:PreloadAsync({a1}, function(a1, a2) -- Line: 94 -- upvalues: u0 (upval) -- types: a1: string
                u0 = a2 == Enum.AssetFetchStatus.Success
            end)
        end)
        u97[a1] = nil
        u96[a1] = u0
        if not u0 then
            local v1 = a1
            warn((("gamepad glyph %* did not load; using the engine glyph instead"):format(v1)))
            u93.Changed:Fire()
        end
    end)
end

local function bespoke(a1) -- Line: 107
    -- upvalues: u20 (val), u98 (ref), UserInputService (val), u96 (val), u97 (val), ContentProvider (val), u93 (val)
    local v1 = u98
    if v1 == nil then
        local ButtonY = Enum.KeyCode.ButtonY
        local success, err = pcall(UserInputService.GetStringForKeyCode, UserInputService, ButtonY)
        local v2 = success
        if v2 then
            v2 = false
            if typeof(err) == "string" then
                v2 = false
                if err ~= "" then
                    v2 = err ~= ButtonY.Name
                end
            end
        end
        u98 = if not v2 then "microsoft" else "sony"
    end
    local u32 = u20[v1][a1]
    if u32 == nil then
        return nil
    end
    if u96[u32] == nil and u97[u32] == nil then
        u97[u32] = true
        task.spawn(function() -- Line: 91 -- upvalues: ContentProvider (upval), u32 (val), u97 (upval), u96 (upval), u93 (upval)
            local u0 = false
            pcall(function() -- Line: 93 -- upvalues: ContentProvider (upval), u32 (upval), u0 (ref)
                ContentProvider:PreloadAsync({u32}, function(a1, a2) -- Line: 94 -- upvalues: u0 (upval) -- types: a1: string
                    u0 = a2 == Enum.AssetFetchStatus.Success
                end)
            end)
            u97[u32] = nil
            u96[u32] = u0
            if not u0 then
                local v1 = u32
                warn((("gamepad glyph %* did not load; using the engine glyph instead"):format(v1)))
                u93.Changed:Fire()
            end
        end)
    end
    if u96[u32] == false then
        return nil
    end
    return u32
end

local function engineGlyph(a1) -- Line: 118 -- upvalues: UserInputService (val)
    local success, err = pcall(UserInputService.GetImageForKeyCode, UserInputService, a1)
    if success and typeof(err) == "string" and err ~= "" then
        return err
    end
    return nil
end

local function announce() -- Line: 123 -- upvalues: u98 (ref), u93 (val)
    u98 = nil
    u93.Changed:Fire()
end

function u93.Vendor() -- Line: 128 -- upvalues: u98 (ref), UserInputService (val)
    local v1 = u98
    if v1 == nil then
        local ButtonY = Enum.KeyCode.ButtonY
        local success, err = pcall(UserInputService.GetStringForKeyCode, UserInputService, ButtonY)
        local v2 = success
        if v2 then
            v2 = false
            if typeof(err) == "string" then
                v2 = false
                if err ~= "" then
                    v2 = err ~= ButtonY.Name
                end
            end
        end
        u98 = if not v2 then "microsoft" else "sony"
    end
    return v1
end

function u93.Image(a1) -- Line: 132
    -- upvalues: u20 (val), u98 (ref), UserInputService (val), u96 (val), u97 (val), ContentProvider (val), u93 (val)
    local v1
    local v2 = u98
    if v2 == nil then
        local ButtonY = Enum.KeyCode.ButtonY
        local success, err = pcall(UserInputService.GetStringForKeyCode, UserInputService, ButtonY)
        local v3 = success
        if v3 then
            v3 = false
            if typeof(err) == "string" then
                v3 = false
                if err ~= "" then
                    v3 = err ~= ButtonY.Name
                end
            end
        end
        u98 = if not v3 then "microsoft" else "sony"
    end
    local u32 = u20[v2][a1]
    if u32 ~= nil then
        if u96[u32] == nil and u97[u32] == nil then
            u97[u32] = true
            task.spawn(function() -- Line: 91 -- upvalues: ContentProvider (upval), u32 (val), u97 (upval), u96 (upval), u93 (upval)
                local u0 = false
                pcall(function() -- Line: 93 -- upvalues: ContentProvider (upval), u32 (upval), u0 (ref)
                    ContentProvider:PreloadAsync({u32}, function(a1, a2) -- Line: 94 -- upvalues: u0 (upval) -- types: a1: string
                        u0 = a2 == Enum.AssetFetchStatus.Success
                    end)
                end)
                u97[u32] = nil
                u96[u32] = u0
                if not u0 then
                    local v1 = u32
                    warn((("gamepad glyph %* did not load; using the engine glyph instead"):format(v1)))
                    u93.Changed:Fire()
                end
            end)
        end
        v1 = if u96[u32] ~= false then u32 else nil
    else
        v1 = nil
    end
    if not v1 then
        local success_2, err_2 = pcall(UserInputService.GetImageForKeyCode, UserInputService, a1)
        if success_2 and typeof(err_2) == "string" and err_2 ~= "" then
            return err_2
        end
        v1 = nil
    end
    return v1
end

UserInputService.GamepadConnected:Connect(announce)
UserInputService.GamepadDisconnected:Connect(announce)
UserInputService.LastInputTypeChanged:Connect(function(a1) -- Line: 138 -- upvalues: u98 (ref), u93 (val)
    if string.find(a1.Name, "Gamepad", 1, true) == 1 then
        u98 = nil
        u93.Changed:Fire()
    end
end)
return (table.freeze(u93))