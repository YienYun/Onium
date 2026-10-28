-- Script path: ReplicatedStorage.Client.AdminPanelEntry
-- Decompile time: 2.50 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Environment = require(ReplicatedStorage.Shared.Modules.Environment)
local Signal = require(ReplicatedStorage.Packages.Signal)
local StaffEntryHotkey = require(ReplicatedStorage.Client.StaffEntryHotkey)
local F8 = Enum.KeyCode.F8
local KeyboardEnabled = UserInputService.KeyboardEnabled
local TouchEnabled = UserInputService.TouchEnabled
local u27 = KeyboardEnabled
if u27 then
    u27 = not TouchEnabled
end
local u31 = TouchEnabled
if u31 then
    u31 = not KeyboardEnabled
end
local u32 = {}
u32.Changed = Signal.new()
local u37 = false
local u38 = false

local function isToggleHonoured() -- Line: 23 -- upvalues: u27 (val), u37 (ref)
    return u27 and u37
end

local function canShowPanel() -- Line: 25
    -- upvalues: StaffEntryHotkey (val), u38 (ref), Environment (val), u31 (val), u27 (val), u37 (ref)
    if StaffEntryHotkey.IsHidden() then
        return false
    end
    return u38 or Environment.IsDevPlace() or Environment.IsTestPlace() or u31 or u27 and u37
end

function u32.CanShowPanel() -- Line: 44
    -- upvalues: StaffEntryHotkey (val), u38 (ref), Environment (val), u31 (val), u27 (val), u37 (ref)
    if StaffEntryHotkey.IsHidden() then
        return false
    end
    return u38 or Environment.IsDevPlace() or Environment.IsTestPlace() or u31 or u27 and u37
end

function u32.SetAdminStatus(a1) -- Line: 46
    -- upvalues: u38 (ref), u32 (val), StaffEntryHotkey (val), Environment (val), u31 (val), u27 (val), u37 (ref)
    if u38 == a1 then
        return
    end
    u32.Changed:Fire(if not StaffEntryHotkey.IsHidden() then a1 or Environment.IsDevPlace() or Environment.IsTestPlace() or u31 or u27 and u37 else false)
end

UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 36
    -- upvalues: u27 (val), F8 (val), u37 (ref), u32 (val), StaffEntryHotkey (val), u38 (ref), Environment (val)
    -- upvalues: u31 (val)
    if u27 and not a2 and a1.KeyCode == F8 then
        u37 = not u37
        u32.Changed:Fire(if not StaffEntryHotkey.IsHidden() then u38 or Environment.IsDevPlace() or Environment.IsTestPlace() or u31 or u27 and u37 else false)
    end
end)
StaffEntryHotkey.Changed:Connect(function() -- Line: 55
    -- upvalues: u32 (val), StaffEntryHotkey (val), u38 (ref), Environment (val), u31 (val), u27 (val), u37 (ref)
    u32.Changed:Fire(if not StaffEntryHotkey.IsHidden() then u38 or Environment.IsDevPlace() or Environment.IsTestPlace() or u31 or u27 and u37 else false)
end)
return u32