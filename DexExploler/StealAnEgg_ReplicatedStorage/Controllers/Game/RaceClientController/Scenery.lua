-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.Scenery
-- Decompile time: 5.79 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local MountRace = require(ReplicatedStorage.Data.MountRace)
local LocalPlayer = Players.LocalPlayer

local function trackNamed(a1) -- Line: 41
    -- upvalues: CollectionService (val), MountRace (val), Workspace (val)
    for i, j in CollectionService:GetTagged(MountRace.TrackTag) do
        if j.Name == a1 and j:IsDescendantOf(Workspace) then
            return j
        end
    end
    return nil
end

local function boundsOf(a1) -- Line: 50 -- types: a1: userdata
    local AttachmentTrack = a1:FindFirstChild("AttachmentTrack")
    if AttachmentTrack == nil then
        return nil
    end
    local v1 = Vector3.new(1, 1, 1) * (1 / 0)
    local v2 = Vector3.new(-1, -1, -1) * (1 / 0)
    for i, j in AttachmentTrack:GetChildren() do
        if j:IsA("Attachment") then
            v1 = v1:Min(j.WorldPosition)
            v2 = v2:Max(j.WorldPosition)
        end
    end
    if v1.X == (1 / 0) then
        return nil
    end
    return {
        Min = v1 - Vector3.new(600, 600, 600),
        Max = v2 + Vector3.new(600, 600, 600),
    }
end

local function within(a1, a2) -- Line: 69 -- types: a1: vector, a2: table
    local v1 = false
    if a1 == a1:Max(a2.Min) then
        v1 = a1 == a1:Min(a2.Max)
    end
    return v1
end

return table.freeze({
    Start = function() -- Line: 77
        -- upvalues: LocalPlayer (val), Workspace (val), LightingController (val), trackNamed (val), boundsOf (val)
        -- upvalues: RunService (val)
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        local Folder = Instance.new("Folder")
        Folder.Name = "RaceScenery"
        Folder.Parent = Workspace
        local u10 = {}

        local function watchHolder(a1) -- Line: 84 -- upvalues: u10 (val) -- types: a1: userdata
            a1.ChildAdded:Connect(function(a1_2) -- Line: 85 -- upvalues: u10 (upval), a1 (val) -- types: a1_2: userdata
                if u10[a1_2] == nil then
                    u10[a1_2] = {Shown = false, Holder = a1}
                end
            end)
            for i, j in a1:GetChildren() do
                if u10[j] == nil then
                    u10[j] = {Shown = false, Holder = a1}
                end
            end
        end

        local function show(a1, a2) -- Line: 96
            -- upvalues: Folder (val), LightingController (upval)
            a2.Shown = true
            if a2.Lighting == nil then
                local LightingSettings = a1:FindFirstChild("LightingSettings")
                if LightingSettings ~= nil then
                    LightingSettings.Parent = nil
                    a2.Lighting = LightingSettings
                end
            end
            a1.Parent = Folder
            local Lighting = a2.Lighting
            if Lighting ~= nil then
                LightingController.SetAuthoredLayer("RaceScenery", Lighting, 150, 1)
            end
        end

        local function hide(a1, a2) -- Line: 112
            -- upvalues: LightingController (upval)
            a2.Shown = false
            LightingController.ClearLayer("RaceScenery", 1)
            if a1.Parent ~= nil then
                a1.Parent = a2.Holder
            end
        end

        local function sync() -- Line: 120
            -- upvalues: LocalPlayer (upval), u10 (val), LightingController (upval), trackNamed (upval)
            -- upvalues: boundsOf (upval), Folder (val)
            local Bounds, Lighting, Position, v1, v2, v3
            local Character = LocalPlayer.Character
            local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
            local v4 = nil
            local v5 = nil
            for i, j in u10, v4, v5 do
                if i.Parent ~= nil then
                    if j.Bounds == nil then
                        v1 = trackNamed(i.Name)
                        v2 = if v1 == nil then nil else boundsOf(v1)
                        j.Bounds = v2
                    end
                    Bounds = j.Bounds
                    v3 = false
                    if HumanoidRootPart ~= nil then
                        v3 = HumanoidRootPart:IsA("BasePart")
                        if v3 then
                            v3 = false
                            if Bounds ~= nil then
                                Position = HumanoidRootPart.Position
                                v3 = false
                                if Position == Position:Max(Bounds.Min) then
                                    v3 = Position == Position:Min(Bounds.Max)
                                end
                            end
                        end
                    end
                    if not v3 then
                        if not v3 and j.Shown then
                            j.Shown = false
                            LightingController.ClearLayer("RaceScenery", 1)
                            if i.Parent ~= nil then
                                i.Parent = j.Holder
                            end
                        end
                    elseif not j.Shown then
                        j.Shown = true
                        if j.Lighting == nil then
                            v2 = i:FindFirstChild("LightingSettings")
                            if v2 ~= nil then
                                v2.Parent = nil
                                j.Lighting = v2
                            end
                        end
                        i.Parent = Folder
                        Lighting = j.Lighting
                        if Lighting ~= nil then
                            LightingController.SetAuthoredLayer("RaceScenery", Lighting, 150, 1)
                        end
                    elseif not v3 and j.Shown then
                        j.Shown = false
                        LightingController.ClearLayer("RaceScenery", 1)
                        if i.Parent ~= nil then
                            i.Parent = j.Holder
                        end
                    end
                else
                    u10[i] = nil
                    if j.Shown then
                        j.Shown = false
                        LightingController.ClearLayer("RaceScenery", 1)
                    end
                end
            end
        end

        PlayerGui.ChildAdded:Connect(function(a1) -- Line: 147 -- upvalues: watchHolder (val) -- types: a1: userdata
            if a1.Name == "RaceScenery" then
                watchHolder(a1)
            end
        end)
        local RaceScenery = PlayerGui:FindFirstChild("RaceScenery")
        if RaceScenery ~= nil then
            watchHolder(RaceScenery)
        end
        local u27 = 0
        RunService.Heartbeat:Connect(function(a1) -- Line: 158 -- upvalues: u27 (ref), sync (val) -- types: a1: number
            u27 = u27 + a1
            if u27 < 0.25 then
                return
            end
            u27 = 0
            local success, err = pcall(sync)
            if not success then
                warn((("[RaceScenery] %*"):format(err)))
            end
        end)
    end,
})