-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.ManorGateTimer
-- Decompile time: 5.12 ms

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local HalloweenDimensionFlags = require(ReplicatedStorage.Shared.Flags.HalloweenDimensionFlags)
local HalloweenManor = require(ReplicatedStorage.Data.HalloweenManor)
local Log = require(ReplicatedStorage.Packages.Log)
local ManorInterior = require(ReplicatedStorage.Shared.Util.ManorInterior)
require(ReplicatedStorage.Packages.Trove)
local u38 = Log.new()
local u39 = {}
local v1 = {}

local function gateWait(a1) -- Line: 40 -- types: a1: number
    if a1 >= 86400 then
        return string.format("%dd %02dh", a1 // 86400, a1 % 86400 // 3600)
    end
    if a1 >= 3600 then
        return string.format("%02d:%02d:%02d", a1 // 3600, a1 % 3600 // 60, a1 % 60)
    end
    return string.format("%02d:%02d", a1 // 60, a1 % 60)
end

local function signText() -- Line: 58 -- upvalues: Workspace (val), ManorInterior (val), gateWait (val)
    local ServerTimeNow = Workspace:GetServerTimeNow()
    local v1 = ManorInterior.GateOpensAt(ServerTimeNow)
    return string.format("UNLOCKS IN %s", gateWait(if v1 == nil then 0 else math.max(math.ceil(v1 - ServerTimeNow), 0)))
end

local function labelOf(a1) -- Line: 65 -- upvalues: u38 (val) -- types: a1: userdata
    local Hitbox = a1:FindFirstChild("Hitbox")
    local Sign = if Hitbox == nil then nil else Hitbox:FindFirstChild("Sign")
    local v1 = if Sign == nil then nil else Sign:FindFirstChild("Title")
    if v1 ~= nil and v1:IsA("TextLabel") then
        return v1
    end
    ;(u38:AtWarning()):Log((("%* has no Hitbox.Sign.Title; skipping its timer"):format((a1:GetFullName()))))
    return nil
end

local function forget(a1) -- Line: 76 -- upvalues: u39 (val) -- types: a1: userdata
    local v1 = u39[a1]
    if v1 == nil then
        return
    end
    u39[a1] = nil
    v1.Label.Text = v1.Original
    if v1.Gui ~= nil then
        v1.Gui.Enabled = v1.WasEnabled
    end
end

local function track(a1) -- Line: 88 -- upvalues: Workspace (val), u39 (val), labelOf (val) -- types: a1: userdata
    if a1:IsA("Model") and a1:IsDescendantOf(Workspace) then
        if u39[a1] ~= nil then
            return
        end
        local v1 = labelOf(a1)
        if v1 ~= nil then
            local v2 = v1:FindFirstAncestorWhichIsA("BillboardGui")
            u39[a1] = {
                Gui = v2,
                Label = v1,
                Original = v1.Text,
                WasEnabled = if v2 == nil then true else v2.Enabled,
            }
        end
        return
    end
end

local function refresh(a1) -- Line: 108
    -- upvalues: HalloweenDimensionFlags (val), u39 (val), Workspace (val), CollectionService (val), track (val)
    -- upvalues: ManorInterior (val), gateWait (val)
    local v1
    local v2 = HalloweenDimensionFlags.ManorGateTimerEnabled:Get()
    local v3 = u39
    local v4 = nil
    local v5 = nil
    for i in v3, v4, v5 do
        if not v2 or not i:IsDescendantOf(Workspace) then
            v1 = u39[i]
            if v1 ~= nil then
                u39[i] = nil
                v1.Label.Text = v1.Original
                if v1.Gui ~= nil then
                    v1.Gui.Enabled = v1.WasEnabled
                end
            end
        end
    end
    if not v2 then
        return
    end
    for j, k in CollectionService:GetTagged(a1) do
        track(k)
    end
    v2 = not ManorInterior.GateOpen()
    if not v2 then
        v3 = nil
    else
        local ServerTimeNow = Workspace:GetServerTimeNow()
        v5 = ManorInterior.GateOpensAt(ServerTimeNow)
        v3 = string.format("UNLOCKS IN %s", gateWait(if v5 == nil then 0 else math.max(math.ceil(v5 - ServerTimeNow), 0)))
    end
    v5 = nil
    local v6 = nil
    for n, m in u39, v5, v6 do
        if m.Gui ~= nil and m.Gui.Enabled ~= v2 then
            m.Gui.Enabled = v2
        end
        if v3 ~= nil and m.Label.Text ~= v3 then
            m.Label.Text = v3
        end
    end
end

function v1.Start(a1) -- Line: 137
    -- upvalues: HalloweenManor (val), u38 (val), CollectionService (val), refresh (val), HalloweenDimensionFlags (val)
    -- upvalues: u39 (val)
    local Gate = HalloweenManor.Tags.Gate
    if Gate == nil then
        u38:AtWarning():Log("HalloweenManor.Tags.Gate is missing; no manor gate timer")
        return
    end
    a1:Connect(CollectionService:GetInstanceAddedSignal(Gate), function() -- Line: 143 -- upvalues: refresh (upval), Gate (val)
        refresh(Gate)
    end)
    a1:Connect(HalloweenDimensionFlags.ManorGateOpen.Changed, function() -- Line: 146 -- upvalues: refresh (upval), Gate (val)
        refresh(Gate)
    end)
    a1:Add(function() -- Line: 149 -- upvalues: u39 (upval)
        local v1
        for i in u39 do
            v1 = u39[i]
            if v1 ~= nil then
                u39[i] = nil
                v1.Label.Text = v1.Original
                if v1.Gui ~= nil then
                    v1.Gui.Enabled = v1.WasEnabled
                end
            end
        end
    end)
    a1:Add((task.spawn(function() -- Line: 154 -- upvalues: refresh (upval), Gate (val)
        while true do
            refresh(Gate)
            task.wait(1)
        end
    end)))
end

return table.freeze(v1)