-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.ChromaBeacon
-- Decompile time: 3.23 ms

local CollectionService = game:GetService("CollectionService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Packages.Trove)
local v1 = {}

local function colorsAt(a1) -- Line: 32 -- types: a1: number
    local v1, v2
    local v3 = table.create(9)
    for i = 0, 8 do
        v1 = i / 8
        v2 = (a1 - v1 * 1) % 1
        v3[i + 1] = (ColorSequenceKeypoint.new(v1, Color3.fromHSV(v2, 1, 1)))
    end
    return ColorSequence.new(v3)
end

local function glowOf(a1) -- Line: 42 -- types: a1: userdata
    local Parent = a1.Parent
    local EggGlow = if Parent == nil then nil else Parent:FindFirstChild("EggGlow")
    if EggGlow ~= nil and EggGlow:IsA("PointLight") then
        return EggGlow
    end
    return nil
end

function v1.Start(a1) -- Line: 52
    -- upvalues: GuiService (val), colorsAt (val), RunService (val), CollectionService (val)
    local u1 = {}
    local u2 = nil

    local function step() -- Line: 56 -- upvalues: GuiService (upval), colorsAt (upval), u1 (val)
        local Glow
        if GuiService.ReducedMotionEnabled then
            return
        end
        local v1 = os.clock() / 3.5 % 1
        local v2 = colorsAt(v1)
        local v3 = Color3.fromHSV(v1, 1, 1)
        local v4 = nil
        local v5 = nil
        for i, j in u1, v4, v5 do
            if j.Beam.Enabled then
                j.Beam.Color = v2
            end
            Glow = j.Glow
            if Glow ~= nil then
                Glow.Color = v3
            end
        end
    end

    local function track(a1_2) -- Line: 75
        -- upvalues: u1 (val), u2 (ref), a1 (val), RunService (upval), step (val)
        if a1_2:IsA("Beam") and u1[a1_2] == nil then
            local v1 = u1
            local v2 = {Beam = a1_2}
            local Parent = a1_2.Parent
            local EggGlow = if Parent == nil then nil else Parent:FindFirstChild("EggGlow")
            v2.Glow = if EggGlow == nil then nil else if not EggGlow:IsA("PointLight") then nil else EggGlow
            v1[a1_2] = v2
            if u2 == nil then
                v1 = a1:Extend()
                v1:Connect(RunService.RenderStepped, step)
                u2 = v1
            end
            return
        end
    end

    a1:Connect(CollectionService:GetInstanceAddedSignal("HalloweenChromaBeacon"), track)
    a1:Connect(CollectionService:GetInstanceRemovedSignal("HalloweenChromaBeacon"), function(a1_2) -- Line: 91 -- upvalues: u1 (val), u2 (ref), a1 (val) -- types: a1_2: userdata
        if u1[a1_2] == nil then
            return
        end
        u1[a1_2] = nil
        local v1 = u2
        if v1 ~= nil and next(u1) == nil then
            u2 = nil
            a1:Remove(v1)
        end
    end)
    a1:Add(function() -- Line: 106 -- upvalues: u1 (val), u2 (ref)
        table.clear(u1)
        u2 = nil
    end)
    for i, j in CollectionService:GetTagged("HalloweenChromaBeacon") do
        track(j)
    end
end

return v1