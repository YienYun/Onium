-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController
-- Decompile time: 10.58 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local BoostPad = require(script.Components.BoostPad)
local HeatVisibility = require(script.HeatVisibility)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Jump = require(script.Components.Jump)
local LoopTheLoop = require(script.Components.LoopTheLoop)
local MountAnimator = require(script.MountAnimator)
local MountController = require(script.MountController)
local MountRace = require(ReplicatedStorage.Data.MountRace)
local PowerUpController = require(script.PowerUpController)
local PowerUpSpawn = require(script.Components.PowerUpSpawn)
local RaceBoard = require(script.RaceBoard)
local RaceCamera = require(script.RaceCamera)
local RaceHud = require(script.RaceHud)
local RaceMusic = require(script.RaceMusic)
local RaceTrackPath = require(ReplicatedStorage.Shared.Modules.RaceTrackPath)
local Respawner = require(script.Respawner)
local Scenery = require(script.Scenery)
local SlowPad = require(script.Components.SlowPad)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u111 = require(script.WrongWay)
local LocalPlayer = Players.LocalPlayer
local PlayerAttributes = MountRace.PlayerAttributes
local u114 = {
    [MountRace.ComponentTags.BoostPad] = BoostPad,
    [MountRace.ComponentTags.SlowPad] = SlowPad,
    [MountRace.ComponentTags.Jump] = Jump,
    [MountRace.ComponentTags.LoopTheLoop] = LoopTheLoop,
    [MountRace.ComponentTags.PowerUpSpawn] = PowerUpSpawn,
}
local u125 = nil

local function findTrack(a1) -- Line: 66 -- upvalues: CollectionService (val), MountRace (val) -- types: a1: string
    for i, j in CollectionService:GetTagged(MountRace.TrackTag) do
        if j.Name == a1 then
            return j
        end
    end
    error((("No race track named %*"):format(a1)))
end

local function waitForGo(a1) -- Line: 75 -- upvalues: MountRace (val), Workspace (val) -- types: a1: userdata
    while true do
        if type((a1:GetAttribute(MountRace.TrackAttributes.GoAt))) == "number" then
            break
        end
        a1:GetAttributeChangedSignal(MountRace.TrackAttributes.GoAt):Wait()
    end
    local Attribute_2 = a1:GetAttribute(MountRace.TrackAttributes.GoAt)
    while Workspace:GetServerTimeNow() < Attribute_2 do
        task.wait()
    end
end

local function bindComponents(a1, a2, a3, a4) -- Line: 85 -- upvalues: u114 (val), CollectionService (val)
    local bind
    local v1 = nil
    local v2 = nil
    for i, j in u114, v1, v2 do
        local u14 = {}

        function bind(a1_2) -- Line: 93
            -- upvalues: u14 (val), a2 (val), i (val), j (val), a1 (val), a3 (val), a4 (val)
            if not u14[a1_2] and a1_2:IsDescendantOf(a2) then
                assert(a1_2:IsA("Model"), (("%* is tagged %* but is not a Model"):format(a1_2:GetFullName(), i)))
                u14[a1_2] = true
                j.Bind(a1, a1_2, a3, a4)
                return
            end
        end

        for k, n in CollectionService:GetTagged(i) do
            bind(n)
        end
        a1:Connect(CollectionService:GetInstanceAddedSignal(i), bind)
    end
end

local function runSession(a1, a2, a3) -- Line: 108
    -- upvalues: LocalPlayer (val), MountRace (val), CollectionService (val), HeatVisibility (val), RaceTrackPath (val)
    -- upvalues: HiddenUIHandler (val), MountController (val), PlayerAttributes (val), RaceCamera (val), RaceMusic (val)
    -- upvalues: Respawner (val), RaceHud (val), RaceBoard (val), bindComponents (val), PowerUpController (val)
    -- upvalues: u111 (val), SoundService (val), waitForGo (val)
    local Attribute, HumanoidRootPart, u139, u183, v1, v2, v3, v4, v5, v6
    while true do
        if LocalPlayer:GetAttribute(MountRace.CutsceneAttribute) ~= true then
            break
        end
        LocalPlayer:GetAttributeChangedSignal(MountRace.CutsceneAttribute):Wait()
    end
    local v7 = CollectionService
    for i, j in v7:GetTagged(MountRace.TrackTag) do
        if j.Name == a2 then
            v3 = j
            v7 = MountRace.HeatOf(LocalPlayer)
            if v7 ~= nil then
                HeatVisibility.Run(a1, a2, v7)
            end
            v4 = MountRace.StateOf(v3, v7)
            v6 = ("%* has no state for heat %*"):format(v3:GetFullName(), v7)
            assert(v4 ~= nil, v6)
            v7 = a3:WaitForChild("Humanoid")
            HumanoidRootPart = a3:WaitForChild("HumanoidRootPart")
            v5 = a3:WaitForChild(MountRace.MountName, 10)
            v1 = ("%* has RaceId but no %*"):format(a3:GetFullName(), MountRace.MountName)
            assert(v5 ~= nil, v1)
            v6 = {Character = a3, Humanoid = v7, Root = HumanoidRootPart, Mount = v5}
            v5 = RaceTrackPath.new(v3.AttachmentTrack)
            a1:Add((HiddenUIHandler.Acquire()))
            u139 = MountController.new(a1, v6, v3)
            Attribute = LocalPlayer:GetAttribute(PlayerAttributes.GridFrame)
            v2 = ("%* has RaceId but no %*"):format(LocalPlayer.Name, PlayerAttributes.GridFrame)
            assert(typeof(Attribute) == "CFrame", v2)
            v1 = a1:Add((task.spawn(function() -- Line: 132 -- upvalues: u139 (val), Attribute (val), HumanoidRootPart (val)
                local CFrame
                u139:Place(Attribute)
                while true do
                    task.wait(1)
                    CFrame = HumanoidRootPart.CFrame
                    if 3 < Vector3.new(CFrame.X - Attribute.X, 0, CFrame.Z - Attribute.Z).Magnitude
                        or (CFrame.LookVector:Dot(Attribute.LookVector)) < 0.94 then
                        u139:Place(Attribute)
                    end
                end
            end)))
            u139:SetHold("Grid", true)
            u183 = RaceCamera.Run(a1, u139, v6)
            v2 = RaceMusic.Run(a1, v3)
            Respawner.Run(a1, u139, v6, v3, v5)
            RaceHud.Run(a1, v3, v4, u139, u183, v2)
            RaceBoard.Run(a1, v3, v4, a2)
            bindComponents(a1, v3, u139, u183)
            PowerUpController.Run(a1, v3, u139, u183, v5)
            u111.Run(a1, u139, v6, v5)
            a1:Connect(u139.WallHit, function(a1) -- Line: 154 -- upvalues: u183 (val), SoundService (upval), MountRace (upval) -- types: a1: number
                u183:Shake(a1 * 0.04)
                SoundService:PlayLocalSound(MountRace.Sounds.WallHit)
            end)
            waitForGo(v4)
            a1:Remove(v1)
            u139:SetHold("Grid", false)
            return
        end
    end
    error((("No race track named %*"):format(a2)))
    v7 = MountRace.HeatOf(LocalPlayer)
    if v7 ~= nil then
        HeatVisibility.Run(a1, a2, v7)
    end
    v4 = MountRace.StateOf(nil, v7)
    v6 = ("%* has no state for heat %*"):format(v3:GetFullName(), v7)
    assert(v4 ~= nil, v6)
    v7 = a3:WaitForChild("Humanoid")
    HumanoidRootPart = a3:WaitForChild("HumanoidRootPart")
    v5 = a3:WaitForChild(MountRace.MountName, 10)
    v1 = ("%* has RaceId but no %*"):format(a3:GetFullName(), MountRace.MountName)
    assert(v5 ~= nil, v1)
    v6 = {Character = a3, Humanoid = v7, Root = HumanoidRootPart, Mount = v5}
    v5 = RaceTrackPath.new(v3.AttachmentTrack)
    a1:Add((HiddenUIHandler.Acquire()))
    u139 = MountController.new(a1, v6, v3)
    Attribute = LocalPlayer:GetAttribute(PlayerAttributes.GridFrame)
    v2 = ("%* has RaceId but no %*"):format(LocalPlayer.Name, PlayerAttributes.GridFrame)
    assert(typeof(Attribute) == "CFrame", v2)
    v1 = a1:Add((task.spawn(function() -- Line: 132 -- upvalues: u139 (val), Attribute (val), HumanoidRootPart (val)
        local CFrame
        u139:Place(Attribute)
        while true do
            task.wait(1)
            CFrame = HumanoidRootPart.CFrame
            if 3 < Vector3.new(CFrame.X - Attribute.X, 0, CFrame.Z - Attribute.Z).Magnitude
                or (CFrame.LookVector:Dot(Attribute.LookVector)) < 0.94 then
                u139:Place(Attribute)
            end
        end
    end)))
    u139:SetHold("Grid", true)
    u183 = RaceCamera.Run(a1, u139, v6)
    v2 = RaceMusic.Run(a1, v3)
    Respawner.Run(a1, u139, v6, v3, v5)
    RaceHud.Run(a1, v3, v4, u139, u183, v2)
    RaceBoard.Run(a1, v3, v4, a2)
    bindComponents(a1, v3, u139, u183)
    PowerUpController.Run(a1, v3, u139, u183, v5)
    u111.Run(a1, u139, v6, v5)
    a1:Connect(u139.WallHit, function(a1) -- Line: 154 -- upvalues: u183 (val), SoundService (upval), MountRace (upval) -- types: a1: number
        u183:Shake(a1 * 0.04)
        SoundService:PlayLocalSound(MountRace.Sounds.WallHit)
    end)
    waitForGo(v4)
    a1:Remove(v1)
    u139:SetHold("Grid", false)
end

local function showCompletedOffTrack() -- Line: 165
    -- upvalues: LocalPlayer (val), PlayerAttributes (val), RaceHud (val)
    local Attribute = LocalPlayer:GetAttribute(PlayerAttributes.FinishPlace)
    if type(Attribute) == "number" and LocalPlayer:GetAttribute(PlayerAttributes.RaceId) == nil then
        RaceHud.ShowCompleted(Attribute)
    end
end

local function refreshSession() -- Line: 172
    -- upvalues: u125 (ref), LocalPlayer (val), PlayerAttributes (val), RaceHud (val), Trove (val), runSession (val)
    local v1 = u125
    if v1 ~= nil then
        u125 = nil
        v1:Destroy()
    end
    local Attribute = LocalPlayer:GetAttribute(PlayerAttributes.RaceId)
    local Character = LocalPlayer.Character
    if type(Attribute) == "string" and Character ~= nil then
        local v2 = Trove.new()
        v2:Add((task.spawn(runSession, v2, Attribute, Character)))
        u125 = v2
        return
    end
    local Attribute_2 = LocalPlayer:GetAttribute(PlayerAttributes.FinishPlace)
    if type(Attribute_2) == "number" and LocalPlayer:GetAttribute(PlayerAttributes.RaceId) == nil then
        RaceHud.ShowCompleted(Attribute_2)
    end
end

return {
    Start = function() -- Line: 193
        -- upvalues: MountAnimator (val), Scenery (val), LocalPlayer (val), PlayerAttributes (val), refreshSession (val)
        -- upvalues: showCompletedOffTrack (val)
        MountAnimator.Start()
        Scenery.Start()
        ;(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.RaceId)):Connect(refreshSession)
        ;(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.FinishPlace)):Connect(showCompletedOffTrack)
        LocalPlayer.CharacterAdded:Connect(refreshSession)
        refreshSession()
    end,
}