-- Script path: ReplicatedStorage.UserGenerated.Roblox.DeviceForm
-- Decompile time: 4.82 ms

local GuiService = game:GetService("GuiService")
local TextService = game:GetService("TextService")
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")

local function SafeGet(a1, a2, a3) -- Line: 34 -- types: a2: string
    local success, err = pcall(function() -- Line: 35 -- upvalues: a1 (val), a2 (val)
        return a1[a2]
    end)
    if success then
        return err
    end
    return a3
end

local function IsWindows() -- Line: 41 -- upvalues: GuiService (val)
    local u0 = GuiService
    local u1 = "IsWindows"
    local success, err = pcall(function() -- Line: 35 -- upvalues: u0 (val), u1 (val)
        return u0[u1]
    end)
    if success then
        return err
    end
    return false
end

local function GetCharacterSize(a1) -- Line: 45 -- upvalues: TextService (val) -- types: a1: number
    return TextService:GetTextSize(utf8.char(a1), 16, Enum.Font.SourceSans, (Vector2.new(1000, 1000)))
end

local TextSize = TextService:GetTextSize(utf8.char(65535), 16, Enum.Font.SourceSans, (Vector2.new(1000, 1000)))

local function IsValidCharacter(a1) -- Line: 51 -- upvalues: TextService (val), TextSize (val) -- types: a1: number
    return (TextService:GetTextSize(utf8.char(a1), 16, Enum.Font.SourceSans, (Vector2.new(1000, 1000)))) ~= TextSize
end

return table.freeze({
    DetectorVersion = "heuristic_v1",
    Get = function() -- Line: 106 -- upvalues: UserInputService (val), GuiService (val)
        if UserInputService.VREnabled then
            return Enum.DeviceForm.VR
        end
        if GuiService:IsTenFootInterface() then
            return Enum.DeviceForm.Console
        end
        local u8 = GuiService
        local u9 = "IsWindows"
        local success, err = pcall(function() -- Line: 35 -- upvalues: u8 (val), u9 (val)
            return u8[u9]
        end)
        if if not success then false else err then
            return Enum.DeviceForm.Desktop
        end
        if not UserInputService.GyroscopeEnabled and not UserInputService.AccelerometerEnabled then
            if UserInputService.MouseEnabled then
                return Enum.DeviceForm.Desktop
            end
            if UserInputService.TouchEnabled then
                return Enum.DeviceForm.Phone
            end
            if UserInputService.GamepadEnabled then
                return Enum.DeviceForm.Console
            end
            return nil
        end
        return Enum.DeviceForm.Phone
    end,
    GetPlatform = function() -- Line: 57
        -- upvalues: UserInputService (val), GuiService (val), VRService (val), TextService (val), TextSize (val)
        local v1 = tostring((version()))
        local u4 = ""
        pcall(function() -- Line: 60 -- upvalues: u4 (ref), UserInputService (upval)
            UserInputService:GetImageForKeyCode(Enum.KeyCode.ButtonSelect):lower()
        end)
        local v2 = v1:find("^0%.") ~= nil
        local v3 = GuiService:IsTenFootInterface() and v1:find("^1%.") ~= nil
        local v4 = v1:find("^2%.") ~= nil
        local VREnabled = UserInputService.VREnabled and VRService.VREnabled
        local u36 = GuiService
        local u37 = "IsWindows"
        local success_2, err = pcall(function() -- Line: 35 -- upvalues: u36 (val), u37 (val)
            return u36[u37]
        end)
        local v5 = if not success_2 then false else err
        local v6 = (TextService:GetTextSize(utf8.char(63743), 16, Enum.Font.SourceSans, (Vector2.new(1000, 1000)))) ~= TextSize
        if v3 then
            local v7 = u4:find("xbox") ~= nil
            local v8 = u4:find("ps4") ~= nil
            local v9 = u4:find("ps5") ~= nil
            if not v7 and not v5 then
                if v8 then
                    return Enum.Platform.PS4
                end
                if v9 then
                    return Enum.Platform.PS5
                end
                return Enum.Platform.None
            end
            return Enum.Platform.XBoxOne
        end
        if not v4 then
            if v2 then
                if v5 then
                    return Enum.Platform.Windows
                end
                return Enum.Platform.OSX
            end
            return Enum.Platform.None
        end
        if v5 then
            return Enum.Platform.UWP
        end
        if VREnabled then
            return Enum.Platform.MetaOS
        end
        if v6 then
            return Enum.Platform.IOS
        end
        if not UserInputService.TouchEnabled then
            return Enum.Platform.Linux
        end
        return Enum.Platform.Android
    end,
})