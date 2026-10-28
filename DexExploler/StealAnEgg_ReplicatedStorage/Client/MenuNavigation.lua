-- Script path: ReplicatedStorage.Client.MenuNavigation
-- Decompile time: 7.33 ms

local GamepadService = game:GetService("GamepadService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local Preferences = require(ReplicatedStorage.Shared.Preferences)
local Signal = require(ReplicatedStorage.Packages.Signal)
local u32 = {}
u32.Changed = Signal.new()
u32.CursorChanged = Signal.new()
u32.SaveFailed = Signal.new()
u32.CursorFailed = Signal.new()
u32.SwitchKey = Enum.KeyCode.ButtonR3
local VirtualCursor = Preferences.IsOn("VirtualCursor")
local u45 = false
local u46 = false
local u47 = 0
local u48 = nil
local u49 = nil
local u50 = {}
local u51 = 0
local u52 = true
local u53 = {}

function u32.IsSuspended() -- Line: 41
    -- upvalues: PlatformController (val), UserInputService (val), GuiService (val), u52 (ref), u53 (val)
    return not PlatformController.IsConsole() or not UserInputService.GamepadEnabled or UserInputService.VREnabled or GuiService.MenuIsOpen or not u52 or next(u53) ~= nil
end

function u32.PrefersCursor() -- Line: 50 -- upvalues: VirtualCursor (ref)
    return VirtualCursor
end

function u32.IsCursorActive() -- Line: 53 -- upvalues: u48 (ref)
    return u48 ~= nil
end

function u32.Release() -- Line: 57 -- upvalues: u48 (ref), GamepadService (val), u32 (val)
    if u48 == nil then
        return
    end
    u48 = nil
    local success, err = pcall(function() -- Line: 62 -- upvalues: GamepadService (upval)
        GamepadService:DisableGamepadCursor()
    end)
    if not success then
        warn((("Could not release menu cursor: %*"):format(err)))
    end
    u32.CursorChanged:Fire(false)
end

function u32.SetContext(a1, a2) -- Line: 71
    -- upvalues: VirtualCursor (ref), u32 (val), u49 (ref), u48 (ref), GamepadService (val)
    if a1 ~= nil and VirtualCursor and not u32.IsSuspended() then
        if a1 == u48 then
            return true
        end
        if a1 == u49 then
            return false
        end
        u32.Release()
        local success, err = pcall(function() -- Line: 85 -- upvalues: GamepadService (upval), a2 (val)
            GamepadService:EnableGamepadCursor(a2)
        end)
        if not success then
            u49 = a1
            u32.CursorFailed:Fire()
            warn((("Could not enable menu cursor: %*"):format(err)))
            return false
        end
        u49 = nil
        u48 = a1
        u32.CursorChanged:Fire(true)
        return true
    end
    u32.Release()
    u49 = nil
    return false
end

function u32.SetPreference(a1) -- Line: 102
    -- upvalues: VirtualCursor (ref), u45 (ref), u46 (ref), u47 (ref), u49 (ref), u32 (val), Preferences (val)
    if VirtualCursor == a1 and not u45 and not u46 then
        return
    end
    VirtualCursor = a1
    u46 = true
    u47 = u47 + 1
    u49 = nil
    if not a1 then
        u32.Release()
    end
    u32.Changed:Fire()
    if u45 then
        return
    end
    u45 = true
    task.spawn(function() -- Line: 118
        -- upvalues: u47 (upval), VirtualCursor (upval), Preferences (upval), u45 (upval), u46 (upval), u32 (upval)
        local v1, v2, v3
        repeat
            v1 = u47
            v2 = VirtualCursor
            v3 = Preferences.Set("VirtualCursor", v2)
        until v1 == u47
        u45 = false
        u46 = not v3
        if v3 then
            return
        end
        u32.SaveFailed:Fire()
    end)
end

function u32.Toggle() -- Line: 134 -- upvalues: u32 (val), VirtualCursor (ref)
    u32.SetPreference(not VirtualCursor)
end

function u32.Suspend(a1, a2) -- Line: 138 -- upvalues: u53 (val), u32 (val) -- types: a1: string, a2: boolean
    if u53[a1] == true == a2 then
        return
    end
    u53[a1] = if not a2 then nil else true
    if a2 then
        u32.Release()
    end
    u32.Changed:Fire()
end

function u32.SetOverride(a1, a2, a3, a4, a5, a6, a7) -- Line: 149
    -- upvalues: u50 (val), u51 (ref), u32 (val)
    if a2 ~= nil then
        u51 = u51 + 1
        u50[a1] = {
            Root = a2,
            Initial = a3,
            Back = a4,
            Priority = a5 or 0,
            Modal = a6 == true,
            BackInButtons = a7 == true,
            Order = u51,
        }
    else
        u50[a1] = nil
    end
    u32.Changed:Fire()
end

local function visible(a1) -- Line: 175 -- types: a1: userdata
    local v1 = a1:FindFirstAncestorWhichIsA("LayerCollector")
    if v1 ~= nil and v1.Enabled then
        local Parent = a1
        while true do
            if Parent:IsA("GuiObject") then
                if not Parent.Visible then
                    return false
                end
            end
            Parent = Parent.Parent
            if Parent == v1 then
                return true
            end
        end
    end
    return false
end

function u32.TopOverride() -- Line: 190 -- upvalues: u50 (val), visible (val)
    local v1 = nil
    local v2 = nil
    local v3 = nil
    for i, j in u50, v2, v3 do
        if j.Root.Parent and visible(j.Root) then
            if v1 == nil or v1.Priority < j.Priority or j.Priority == v1.Priority and v1.Order < j.Order then
                v1 = j
            end
        end
    end
    return v1
end

Preferences.Observe("VirtualCursor", function(a1) -- Line: 209
    -- upvalues: VirtualCursor (ref), u45 (ref), u46 (ref), u49 (ref), u32 (val)
    if a1 ~= VirtualCursor and not u45 and not u46 then
        VirtualCursor = a1
        u49 = nil
        u32.Changed:Fire()
        return
    end
end)

local function refresh() -- Line: 218 -- upvalues: u32 (val)
    if u32.IsSuspended() then
        u32.Release()
    end
    u32.Changed:Fire()
end

PlatformController.Changed:Connect(refresh)
GuiService.MenuOpened:Connect(refresh)
GuiService.MenuClosed:Connect(refresh)
UserInputService.GamepadConnected:Connect(refresh)
UserInputService.GamepadDisconnected:Connect(refresh)
UserInputService.WindowFocusReleased:Connect(function() -- Line: 229 -- upvalues: u52 (ref), u32 (val)
    u52 = false
    if u32.IsSuspended() then
        u32.Release()
    end
    u32.Changed:Fire()
end)
UserInputService.WindowFocused:Connect(function() -- Line: 233 -- upvalues: u52 (ref), u32 (val)
    u52 = true
    if u32.IsSuspended() then
        u32.Release()
    end
    u32.Changed:Fire()
end)
pcall(function() -- Line: 240 -- upvalues: GamepadService (val), u48 (ref), u32 (val)
    (GamepadService:GetPropertyChangedSignal("GamepadCursorEnabled")):Connect(function() -- Line: 242 -- upvalues: GamepadService (upval), u48 (upval), u32 (upval)
        local success, err = pcall(function() -- Line: 243 -- upvalues: GamepadService (upval)
            return GamepadService.GamepadCursorEnabled
        end)
        if success and not err and u48 ~= nil then
            u48 = nil
            u32.CursorChanged:Fire(false)
            u32.Changed:Fire()
        end
    end)
end)
return u32