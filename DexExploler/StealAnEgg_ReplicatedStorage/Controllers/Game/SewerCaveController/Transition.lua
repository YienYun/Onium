-- Script path: ReplicatedStorage.Controllers.Game.SewerCaveController.Transition
-- Decompile time: 3.01 ms

local CollectionService = game:GetService("CollectionService")
local ContentProvider = game:GetService("ContentProvider")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Drain = require(script.Drain)
local Flush = require(script.Flush)
local Transition = require(script.Parent.Parent.HalloweenDimensionController.Transition)
local SewerCave = require(ReplicatedStorage.Shared.Util.SewerCave)
local u49 = require(script.Stage)
local LocalPlayer = Players.LocalPlayer
local u51 = false
local u52 = {}

local function whirlpoolDistance() -- Line: 37
    -- upvalues: LocalPlayer (val), CollectionService (val), SewerCave (val), Workspace (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        local v1 = (1 / 0)
        for i, j in CollectionService:GetTagged(SewerCave.WhirlpoolTag) do
            if j:IsA("Model") and j:IsDescendantOf(Workspace) then
                v1 = math.min(v1, ((j:GetPivot()).Position - HumanoidRootPart.Position).Magnitude)
            end
        end
        return v1
    end
    return (1 / 0)
end

local function watch() -- Line: 52 -- upvalues: whirlpoolDistance (val), Drain (val)
    local v1, v2
    local v3 = nil
    while true do
        task.wait(0.5)
        v1 = whirlpoolDistance()
        if v1 < 80 then
            Drain.Prewarm()
        elseif v1 > 140 then
            v2 = v3 or os.clock()
            if 20 < os.clock() - v2 then
                Drain.Release()
            end
        end
    end
end

local function preload() -- Line: 70 -- upvalues: ContentProvider (val)
    local Assets = script:FindFirstChild("Assets")
    if Assets ~= nil then
        pcall(function() -- Line: 73 -- upvalues: ContentProvider (upval), Assets (val)
            ContentProvider:PreloadAsync({Assets})
        end)
    end
end

function u52.Start() -- Line: 83 -- upvalues: u51 (ref), Drain (val), preload (val), watch (val)
    if u51 then
        return
    end
    u51 = true
    Drain.Warm()
    task.spawn(preload)
    task.spawn(watch)
end

function u52.Enter(a1) -- Line: 93 -- upvalues: u52 (val), Drain (val)
    u52.Start()
    return Drain.Run(a1)
end

function u52.Exit(a1) -- Line: 98 -- upvalues: u52 (val), Flush (val)
    u52.Start()
    return Flush.Run(a1)
end

function u52.Abort() -- Line: 103 -- upvalues: u49 (val), Transition (val)
    local v1 = u49.Active()
    if v1 ~= nil then
        u49.Bail(v1)
        return
    end
    Transition.Reveal()
end

function u52.Cover() -- Line: 112 -- upvalues: Transition (val), u49 (val)
    Transition.Cover(u49.Palette, u49.CoverTimeout)
end

function u52.Reveal() -- Line: 116 -- upvalues: Transition (val)
    Transition.Reveal()
end

task.defer(u52.Start)
return (table.freeze(u52))