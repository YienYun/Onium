-- Script path: ReplicatedStorage.Controllers.Game.BanjoCricketController.Reveal
-- Decompile time: 9.92 ms

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local BanjoCricket = require(ReplicatedStorage.Data.BanjoCricket)
local u38 = require(script.Parent.Mushrooms)
local Sounds = require(script.Parent.Sounds)
local u44 = {}
local u45 = {}
local u46 = {}
local u47 = "Closed"
local u48 = nil
local u49 = 0
local v1 = {}

local function rootsOpened(a1, a2) -- Line: 45 -- upvalues: BanjoCricket (val) -- types: a1: userdata, a2: userdata
    local BoundingBox_2
    local Attribute = a1:GetAttribute(BanjoCricket.Attributes.RevealOffset)
    if typeof(Attribute) == "Vector3" then
        return a2 + Attribute
    end
    _, BoundingBox_2 = a1:GetBoundingBox()
    return a2 - Vector3.new(0, BoundingBox_2.Y, 0)
end

local function doorOpened(a1, a2) -- Line: 54 -- upvalues: BanjoCricket (val) -- types: a1: userdata, a2: userdata
    local Attribute = a1:GetAttribute(BanjoCricket.Attributes.DoorOpenAngle)
    return a2 * CFrame.Angles(0, math.rad(if typeof(Attribute) ~= "number" then 100 else Attribute), 0)
end

local function makePassable(a1) -- Line: 62 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.CanCollide = false
        end
    end
end

local function snapOpen(a1) -- Line: 70 -- upvalues: makePassable (val) -- types: a1: table
    a1.Model:PivotTo(a1.Opened)
    makePassable(a1.Model)
end

local function glide(a1, a2, a3) -- Line: 75
    -- upvalues: makePassable (val), TweenService (val)
    makePassable(a1.Model)
    local CFrameValue = Instance.new("CFrameValue")
    CFrameValue.Value = a1.Closed
    CFrameValue.Changed:Connect(function(a1_2) -- Line: 79 -- upvalues: a1 (val) -- types: a1_2: userdata
        if a1.Model.Parent ~= nil then
            a1.Model:PivotTo(a1_2)
        end
    end)
    local v1 = TweenService:Create(CFrameValue, TweenInfo.new(a2, a3, Enum.EasingDirection.Out), {Value = a1.Opened})
    v1.Completed:Once(function() -- Line: 89 -- upvalues: CFrameValue (val)
        CFrameValue:Destroy()
    end)
    v1:Play()
end

local function binder(a1, a2) -- Line: 95
    -- upvalues: Workspace (val), u47 (ref), makePassable (val)
    return function(a1_2) -- Line: 99
        -- upvalues: a1 (val), Workspace (upval), a2 (val), u47 (upval), makePassable (upval)
        if not a1[a1_2] and a1_2:IsA("Model") and a1_2:IsDescendantOf(Workspace) then
            local Pivot = a1_2:GetPivot()
            local v1 = {Model = a1_2, Closed = Pivot, Opened = a2(a1_2, Pivot)}
            a1[a1_2] = v1
            if u47 == "Open" then
                v1.Model:PivotTo(v1.Opened)
                makePassable(v1.Model)
            end
            return
        end
    end
end

local function track(a1, a2, a3) -- Line: 120
    -- upvalues: Workspace (val), u47 (ref), makePassable (val), CollectionService (val)
    local function v1(a1) -- Line: 99
        -- upvalues: a2 (val), Workspace (upval), a3 (val), u47 (upval), makePassable (upval)
        if not a2[a1] and a1:IsA("Model") and a1:IsDescendantOf(Workspace) then
            local Pivot = a1:GetPivot()
            local v1 = {Model = a1, Closed = Pivot, Opened = a3(a1, Pivot)}
            a2[a1] = v1
            if u47 == "Open" then
                v1.Model:PivotTo(v1.Opened)
                makePassable(v1.Model)
            end
            return
        end
    end

    ;(CollectionService:GetInstanceAddedSignal(a1)):Connect(v1)
    ;(CollectionService:GetInstanceRemovedSignal(a1)):Connect(function(a1) -- Line: 127 -- upvalues: a2 (val)
        a2[a1] = nil
    end)
    for i, j in CollectionService:GetTagged(a1) do
        v1(j)
    end
end

local function openDoorways() -- Line: 135 -- upvalues: u46 (val)
    for i, j in u46 do
        j.CanCollide = false
    end
end

local function trackDoorways() -- Line: 141
    -- upvalues: BanjoCricket (val), Workspace (val), u46 (val), u47 (ref), CollectionService (val)
    local Doorway = BanjoCricket.Tags.Doorway
    ;(CollectionService:GetInstanceAddedSignal(Doorway)):Connect(function(a1) -- Line: 143 -- upvalues: Workspace (upval), u46 (upval), u47 (upval) -- types: a1: userdata
        if a1:IsA("BasePart") and a1:IsDescendantOf(Workspace) then
            u46[a1] = a1
            if u47 == "Open" then
                a1.CanCollide = false
            end
            return
        end
    end)
    ;(CollectionService:GetInstanceRemovedSignal(Doorway)):Connect(function(a1) -- Line: 156 -- upvalues: u46 (upval)
        u46[a1] = nil
    end)
    for i, j in CollectionService:GetTagged(Doorway) do
        if j:IsA("BasePart") and j:IsDescendantOf(Workspace) then
            u46[j] = j
            if u47 == "Open" then
                j.CanCollide = false
            end
        end
    end
end

local function songEmitter() -- Line: 164
    -- upvalues: CollectionService (val), BanjoCricket (val), Workspace (val), u45 (val)
    for i, j in CollectionService:GetTagged(BanjoCricket.Tags.Music) do
        if j:IsDescendantOf(Workspace) then
            return j
        end
    end
    for k, n in u45 do
        return n.Model
    end
    return nil
end

local function playSong(a1) -- Line: 176
    -- upvalues: u48 (ref), songEmitter (val), Audio (val), BanjoCricket (val)
    if u48 ~= nil then
        return
    end
    local v1 = songEmitter()
    if v1 == nil then
        return
    end
    Audio.Play(BanjoCricket.Sounds.Band, v1, {Looped = true, MaxDistance = 90, Volume = a1})
end

local function creakRoots(a1) -- Line: 191 -- upvalues: u44 (val), Sounds (val) -- types: a1: number
    local v1
    _, v1 = next(u44)
    if v1 then
        Sounds.Creak(v1.Closed, a1)
    end
end

function v1.Start() -- Line: 198
    -- upvalues: track (val), BanjoCricket (val), u44 (val), rootsOpened (val), u45 (val), doorOpened (val)
    -- upvalues: trackDoorways (val)
    track(BanjoCricket.Tags.Roots, u44, rootsOpened)
    track(BanjoCricket.Tags.Door, u45, doorOpened)
    trackDoorways()
end

function v1.Strain(a1) -- Line: 205
    -- upvalues: u47 (ref), u49 (ref), u44 (val), Sounds (val), RunService (val)
    local v1
    if u47 ~= "Closed" then
        return
    end
    u49 = u49 + 1
    local u4 = u49
    local u6 = os.clock()
    local u12 = math.clamp(a1, 0, 1) * 0.06981317007977318
    _, v1 = next(u44)
    if v1 then
        Sounds.Creak(v1.Closed, a1)
    end
    local u22 = nil
    RunService.PreRender:Connect(function() -- Line: 215 -- upvalues: u6 (val), u49 (upval), u4 (val), u47 (upval), u22 (ref), u44 (upval), u12 (val)
        local v1 = (os.clock() - u6) / 0.6
        local v2 = false
        if u49 == u4 then
            v2 = u47 == "Closed"
        end
        if v2 and not (v1 >= 1) then
            v2 = u12 * (1 - v1)
            for i, j in u44 do
                j.Model:PivotTo(j.Closed * (CFrame.Angles(math.sin(v1 * 40) * v2, 0, (math.cos(v1 * 29)) * v2)))
            end
            return
        end
        u22:Disconnect()
        if v2 then
            for k, n in u44 do
                n.Model:PivotTo(n.Closed)
            end
        end
    end)
end

function v1.Open() -- Line: 242
    -- upvalues: u47 (ref), u44 (val), makePassable (val), u45 (val), u46 (val), BanjoCricket (val), u48 (ref)
    -- upvalues: songEmitter (val), Audio (val)
    if u47 ~= "Closed" then
        return
    end
    u47 = "Open"
    for i, j in u44 do
        j.Model:PivotTo(j.Opened)
        makePassable(j.Model)
    end
    for k, n in u45 do
        n.Model:PivotTo(n.Opened)
        makePassable(n.Model)
    end
    for m, i5 in u46 do
        i5.CanCollide = false
    end
    local Band = BanjoCricket.Volume.Band
    if u48 ~= nil then
        return
    end
    local v1 = songEmitter()
    if v1 == nil then
        return
    end
    Audio.Play(BanjoCricket.Sounds.Band, v1, {Looped = true, MaxDistance = 90, Volume = Band})
end

function v1.Play() -- Line: 257
    -- upvalues: u47 (ref), BanjoCricket (val), u38 (val), Sounds (val), playSong (val), u44 (val), glide (val)
    -- upvalues: u45 (val), u46 (val), u48 (ref), Audio (val)
    if u47 ~= "Closed" then
        return
    end
    u47 = "Revealing"
    local Reveal = BanjoCricket.Reveal
    task.delay(Reveal.LightsAt, u38.SetAllLit, true)
    task.delay(Reveal.HarmonyAt, Sounds.Strum)
    task.delay(Reveal.MusicAt, playSong, BanjoCricket.Volume.BandFaint)
    task.delay(Reveal.RootsAt, function() -- Line: 266 -- upvalues: u44 (upval), Sounds (upval), glide (upval), Reveal (val)
        local v1
        _, v1 = next(u44)
        if v1 then
            Sounds.Creak(v1.Closed, 1)
        end
        for i, j in u44 do
            glide(j, Reveal.RootsSeconds, Enum.EasingStyle.Quad)
        end
    end)
    task.delay(Reveal.DoorAt, function() -- Line: 272
        -- upvalues: u47 (upval), u45 (upval), glide (upval), Reveal (val), u46 (upval), u48 (upval), Audio (upval)
        -- upvalues: BanjoCricket (upval)
        u47 = "Open"
        for i, j in u45 do
            glide(j, Reveal.DoorSeconds, Enum.EasingStyle.Back)
        end
        for k, n in u46 do
            n.CanCollide = false
        end
        local v1 = u48
        if v1 then
            Audio.FadeTo(v1, {Volume = BanjoCricket.Volume.Band, Seconds = Reveal.DoorSeconds})
        end
    end)
    task.delay(Reveal.LightsOffAt, u38.SetAllLit, false)
end

return (table.freeze(v1))