-- Script path: ReplicatedStorage.Client.ObserveUITag
-- Decompile time: 3.39 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer

local function GetPlayerGui() -- Line: 24 -- upvalues: LocalPlayer (val)
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    while PlayerGui == nil do
        LocalPlayer.ChildAdded:Wait()
        PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    end
    return PlayerGui
end

local function IsShowing(a1, a2) -- Line: 33 -- types: a1: userdata, a2: userdata
    local Parent = a1
    local v1 = a2
    while Parent ~= nil do
        if Parent == v1 then
            break
        end
        if Parent:GetAttribute("UIEffectsPaused") == true then
            return false
        end
        if not Parent:IsA("GuiObject") then
            if Parent:IsA("LayerCollector") and not Parent.Enabled then
                return false
            end
        elseif not Parent.Visible then
            return false
        end
        Parent = Parent.Parent
    end
    return Parent == v1
end

local function WatchAncestors(a1, a2, a3, a4) -- Line: 51 -- types: a1: userdata, a2: userdata, a4: function
    local Parent = a1
    local v1, v2, v3 = a2, a4, a3
    while Parent ~= nil do
        if Parent == v1 then
            break
        end
        v3:Connect(Parent:GetAttributeChangedSignal("UIEffectsPaused"), v2)
        if Parent:IsA("GuiObject") then
            v3:Connect(Parent:GetPropertyChangedSignal("Visible"), v2)
        elseif Parent:IsA("LayerCollector") then
            v3:Connect(Parent:GetPropertyChangedSignal("Enabled"), v2)
        end
        Parent = Parent.Parent
    end
end

return function(a1, a2) -- Line: 74
    -- upvalues: GetPlayerGui (val), Observers (val), Trove (val), IsShowing (val), WatchAncestors (val)
    local u3 = GetPlayerGui()
    return Observers.observeTag(a1, function(a1) -- Line: 77
        -- upvalues: Trove (upval), IsShowing (upval), u3 (val), a2 (val), WatchAncestors (upval)
        local u3_2 = Trove.new()
        local u6 = u3_2:Extend()
        local u9 = u3_2:Extend()
        local u10 = true
        local u11 = false

        local function refreshVisibility() -- Line: 84
            -- upvalues: u10 (ref), IsShowing (upval), a1 (val), u3 (upval), u11 (ref), a2 (upval), u9 (val), u3_2 (val)
            local v1 = u10 and IsShowing(a1, u3)
            if v1 == u11 then
                return
            end
            u11 = v1
            if v1 then
                a2(a1, u9, u3_2)
                return
            end
            u9:Clean()
        end

        u3_2:Connect(a1.AncestryChanged, function() -- Line: 97
            -- upvalues: u10 (ref), u6 (val), WatchAncestors (upval), a1 (val), u3 (upval), refreshVisibility (val)
            -- upvalues: IsShowing (upval), u11 (ref), a2 (upval), u9 (val), u3_2 (val)
            if not u10 then
                return
            end
            u6:Clean()
            WatchAncestors(a1, u3, u6, refreshVisibility)
            local v1 = u10 and IsShowing(a1, u3)
            if v1 == u11 then
                return
            end
            u11 = v1
            if v1 then
                a2(a1, u9, u3_2)
                return
            end
            u9:Clean()
        end)
        if u10 then
            u6:Clean()
            WatchAncestors(a1, u3, u6, refreshVisibility)
            local v1 = u10 and IsShowing(a1, u3)
            if v1 ~= u11 then
                if not v1 then
                    u9:Clean()
                else
                    a2(a1, u9, u3_2)
                end
            end
        end
        return function() -- Line: 109 -- upvalues: u10 (ref), u3_2 (val)
            u10 = false
            u3_2:Destroy()
        end
    end, {u3})
end