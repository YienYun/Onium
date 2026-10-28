-- Script path: ReplicatedStorage.Client.DecorationScale
-- Decompile time: 6.98 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ViewportSize = require(ReplicatedStorage.Client.ViewportSize)
local u14 = {LeftControls = true, RightButtons = true}
local u15 = {Chat = true, TouchGui = true}
local u16 = {}
u16.ImageButton = {
    Property = "SliceScale",
    Baseline = "AuthoredSliceScale",
    Applies = function(a1) -- Line: 39 -- types: a1: userdata
        return a1.ScaleType == Enum.ScaleType.Slice
    end,
}
u16.ImageLabel = {
    Property = "SliceScale",
    Baseline = "AuthoredSliceScale",
    Applies = function(a1) -- Line: 46 -- types: a1: userdata
        return a1.ScaleType == Enum.ScaleType.Slice
    end,
}
u16.UIStroke = {
    Property = "Thickness",
    Baseline = "AuthoredThickness",
    Applies = function(a1) -- Line: 53 -- types: a1: userdata
        return a1.StrokeSizingMode == Enum.StrokeSizingMode.FixedSize
    end,
}
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local u28 = 1

local function isScaledScreen(a1) -- Line: 62 -- upvalues: u15 (val) -- types: a1: userdata
    local v1 = a1:IsA("LayerCollector")
    if v1 then
        v1 = false
        if u15[a1.Name] ~= true then
            v1 = a1:GetAttribute("ScaledDecoration") ~= false
        end
    end
    return v1
end

local function screenOf(a1) -- Line: 68 -- upvalues: PlayerGui (val) -- types: a1: userdata
    local Parent = a1
    while Parent ~= nil do
        if Parent.Parent == PlayerGui then
            break
        end
        Parent = Parent.Parent
    end
    return Parent
end

local function pinned(a1, a2, a3) -- Line: 76 -- types: a1: userdata, a2: string, a3: number
    local Attribute = a1:GetAttribute(a2)
    if type(Attribute) == "number" then
        return Attribute
    end
    a1:SetAttribute(a2, a3)
    return a3
end

local function scaleDecoration(a1) -- Line: 85 -- upvalues: u16 (val), u28 (ref) -- types: a1: userdata
    local v1 = u16[a1.ClassName]
    if v1 ~= nil and v1.Applies(a1) then
        local v2
        local Property = v1.Property
        local Baseline = v1.Baseline
        local v3 = a1[v1.Property]
        local Attribute = a1:GetAttribute(Baseline)
        if type(Attribute) ~= "number" then
            a1:SetAttribute(Baseline, v3)
            v2 = v3
        else
            v2 = Attribute
        end
        a1[Property] = v2 * u28
        return
    end
end

local function refit(a1) -- Line: 94 -- upvalues: u28 (ref), PlayerGui (val), u15 (val), u16 (val) -- types: a1: number
    local Attribute, Baseline, Property, v1, v2, v3, v4
    u28 = math.lerp(1, a1, 0.45)
    for i, j in PlayerGui:GetChildren() do
        v4 = j:IsA("LayerCollector")
        if v4 then
            v4 = false
            if u15[j.Name] ~= true then
                v4 = j:GetAttribute("ScaledDecoration") ~= false
            end
        end
        if v4 then
            for k, n in j:GetDescendants() do
                v1 = u16[n.ClassName]
                if v1 ~= nil and v1.Applies(n) then
                    Property = v1.Property
                    Baseline = v1.Baseline
                    v3 = n[v1.Property]
                    Attribute = n:GetAttribute(Baseline)
                    if type(Attribute) ~= "number" then
                        n:SetAttribute(Baseline, v3)
                        v2 = v3
                    else
                        v2 = Attribute
                    end
                    n[Property] = v2 * u28
                end
            end
        end
    end
end

local function adoptLater(a1) -- Line: 106
    -- upvalues: PlayerGui (val), u15 (val), u16 (val), u28 (ref)
    task.defer(function() -- Line: 107 -- upvalues: a1 (val), PlayerGui (upval), u15 (upval), u16 (upval), u28 (upval)
        local Parent = a1
        while Parent ~= nil do
            if Parent.Parent == PlayerGui then
                break
            end
            Parent = Parent.Parent
        end
        if Parent ~= nil then
            local v1 = Parent:IsA("LayerCollector")
            if v1 then
                v1 = false
                if u15[Parent.Name] ~= true then
                    v1 = Parent:GetAttribute("ScaledDecoration") ~= false
                end
            end
            if v1 then
                v1 = a1
                local v2 = u16[v1.ClassName]
                if v2 ~= nil then
                    local v3
                    if not v2.Applies(v1) then
                        return
                    end
                    local Property = v2.Property
                    local Baseline = v2.Baseline
                    local v4 = v1[v2.Property]
                    local Attribute = v1:GetAttribute(Baseline)
                    if type(Attribute) ~= "number" then
                        v1:SetAttribute(Baseline, v4)
                        v3 = v4
                    else
                        v3 = Attribute
                    end
                    v1[Property] = v3 * u28
                end
            end
        end
    end)
end

PlayerGui.DescendantAdded:Connect(function(a1) -- Line: 115 -- upvalues: u16 (val), PlayerGui (val), u15 (val), u28 (ref) -- types: a1: userdata
    if u16[a1.ClassName] ~= nil then
        task.defer(function() -- Line: 107 -- upvalues: a1 (val), PlayerGui (upval), u15 (upval), u16 (upval), u28 (upval)
            local Parent = a1
            while Parent ~= nil do
                if Parent.Parent == PlayerGui then
                    break
                end
                Parent = Parent.Parent
            end
            if Parent ~= nil then
                local v1 = Parent:IsA("LayerCollector")
                if v1 then
                    v1 = false
                    if u15[Parent.Name] ~= true then
                        v1 = Parent:GetAttribute("ScaledDecoration") ~= false
                    end
                end
                if v1 then
                    v1 = a1
                    local v2 = u16[v1.ClassName]
                    if v2 ~= nil then
                        local v3
                        if not v2.Applies(v1) then
                            return
                        end
                        local Property = v2.Property
                        local Baseline = v2.Baseline
                        local v4 = v1[v2.Property]
                        local Attribute = v1:GetAttribute(Baseline)
                        if type(Attribute) ~= "number" then
                            v1:SetAttribute(Baseline, v4)
                            v3 = v4
                        else
                            v3 = Attribute
                        end
                        v1[Property] = v3 * u28
                    end
                end
            end
        end)
    end
end)
ViewportSize.Observe(function(a1, a2) -- Line: 121 -- upvalues: refit (val)
    refit(a2)
end)
task.spawn(function() -- Line: 128 -- upvalues: ReplicatedStorage (val), u14 (val), ViewportSize (val)
    local UIScale
    local Hud = require(ReplicatedStorage.Client.Hud)
    local u41 = {}
    local v1 = {"Game", "Treadmill"}
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        for k, n in Hud.Frame(j):GetChildren() do
            if n:IsA("Frame") and u14[n.Name] == true then
                UIScale = Instance.new("UIScale")
                UIScale.Name = "HudFitScale"
                UIScale.Parent = n
                table.insert(u41, UIScale)
            end
        end
    end
    ViewportSize.Observe(function(a1, a2) -- Line: 144 -- upvalues: u41 (val)
        local v1 = (1 + 0.1 / a2) / 1.1
        for i, j in u41 do
            j.Scale = v1
        end
    end)
end)
return (table.freeze({}))