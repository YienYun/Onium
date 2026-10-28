-- Script path: ReplicatedStorage.Shared.Audio
-- Decompile time: 14.63 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local AssetIds = require(ReplicatedStorage.Shared.Utils.AssetIds)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Spread = require(ReplicatedStorage.Shared.Utils.Spread)
local u46 = RunService:IsClient()
local u52 = if not u46 then nil else require(ReplicatedStorage.Shared.Preferences)
local u54 = {Failure = 1, Notice = 0.55, Prompt = 0.75}
local u55 = {Ambient = Enum.RollOffMode.Linear, OneShot = Enum.RollOffMode.LinearSquare}
local u58 = {Style = Enum.EasingStyle.Sine, Direction = Enum.EasingDirection.InOut}
local u61 = {
    {Option = "Looped", Property = "Looped"},
    {Option = "MaxDistance", Property = "RollOffMaxDistance"},
    {Option = "PlaybackSpeed", Property = "PlaybackSpeed", Sampled = true},
    {Option = "TimePosition", Property = "TimePosition"},
    {Option = "Volume", Property = "Volume", Sampled = true},
}
local u67 = {HalfExtent = 0}
local u68 = {}
local u70 = Random.new()
local u71 = nil
local u75 = setmetatable({}, {__mode = "k"})
local pickAsset = nil
local u77 = {}

function u77.number(a1) -- Line: 104
    assert(a1 > 0, "asset ids are positive numbers")
    return a1
end

function u77.string(a1) -- Line: 108 -- upvalues: AssetIds (val)
    return AssetIds.Parse(a1) or error(("\"%*\" does not name an asset"):format(a1), 2)
end

function u77.table(a1) -- Line: 111 -- upvalues: pickAsset (ref), u70 (val)
    assert(#a1 > 0, "a sound list needs at least one entry")
    return pickAsset(a1[u70:NextInteger(1, #a1)])
end

function pickAsset(a1) -- Line: 118 -- upvalues: u77 (val)
    local v1 = u77[typeof(a1)]
    if v1 == nil then
        error(("cannot turn a %* into a sound id"):format((typeof(a1))), 2)
    end
    return v1(a1)
end

local function assetUri(a1) -- Line: 126 -- upvalues: pickAsset (ref)
    return (("rbxassetid://%*"):format((pickAsset(a1))))
end

local function resolveGroup(a1, a2) -- Line: 130 -- upvalues: SoundService (val) -- types: a2: string
    local v1 = if typeof(a1) ~= "Instance" then SoundService:FindFirstChild(a1 or a2) else a1
    if v1 == nil or not v1:IsA("SoundGroup") then
        error(("SoundService has no SoundGroup named %*"):format((tostring(a1 or a2))), 2)
    end
    if v1.Name == "Music" then
        local GameMusic = v1:FindFirstChild("GameMusic")
        if GameMusic and GameMusic:IsA("SoundGroup") then
            return GameMusic
        end
    end
    return v1
end

local function nearField(a1) -- Line: 146 -- types: a1: number
    return (math.clamp(a1 * 0.005, 0.01, 1))
end

local function rolloffFor(a1) -- Line: 150 -- upvalues: u55 (val) -- types: a1: boolean
    if a1 then
        return u55.Ambient
    end
    return u55.OneShot
end

local function authorSound(a1, a2, a3) -- Line: 156
    -- upvalues: Spread (val), u70 (val), u55 (val), resolveGroup (val), pickAsset (ref)
    local v1 = a3.Looped == true
    local v2 = a3.MaxDistance or 200
    a1.Looped = v1
    a1.PlaybackSpeed = Spread.Sample(a3.PlaybackSpeed, 1, u70)
    a1.RollOffMaxDistance = v2
    a1.RollOffMinDistance = math.clamp(v2 * 0.005, 0.01, 1)
    local Ambient = if not v1 then u55.OneShot else u55.Ambient
    a1.RollOffMode = Ambient
    a1.SoundGroup = resolveGroup(a3.SoundGroup, "Gameplay")
    a1.SoundId = ("rbxassetid://%*"):format((pickAsset(a2)))
    a1.TimePosition = a3.TimePosition or 0
    a1.Volume = Spread.Sample(a3.Volume, 1, u70)
    return a1
end

local function retouchSound(a1, a2) -- Line: 171
    -- upvalues: u61 (val), Spread (val), u70 (val), resolveGroup (val)
    local Property, v1
    local v2 = nil
    local v3 = nil
    local v4, v5 = a2, a1
    for i, j in u61, v2, v3 do
        v1 = v4[j.Option]
        if v1 ~= nil then
            Property = j.Property
            v5[Property] = if not j.Sampled then v1 else Spread.Sample(v1, 1, u70)
        end
    end
    if v4.SoundGroup ~= nil then
        v5.SoundGroup = resolveGroup(v4.SoundGroup, "Gameplay")
    end
    return v5
end

local function attachEffects(a1, a2) -- Line: 186 -- types: a1: userdata, a2: table?
    for i, j in a2 or {} do
        j:Clone().Parent = a1
    end
end

local function optionsFromCatalog(a1) -- Line: 192 -- types: a1: table
    return {
        Deferred = a1.SkipPlay,
        Looped = a1.Looped,
        MaxDistance = a1.MaxDistance,
        PlaybackSpeed = a1.Speed,
        Recipient = a1.Player,
        SoundGroup = a1.SoundGroup,
        TimePosition = a1.TimePos,
        Volume = a1.Volume,
    }
end

local function placementOfPart(a1) -- Line: 207 -- types: a1: userdata
    return {Frame = a1.CFrame, HalfExtent = a1.Size.Magnitude / 2}
end

local u94 = {}

function u94.CFrame(a1) -- Line: 212
    return {HalfExtent = 0, Frame = a1}
end

function u94.Vector3(a1) -- Line: 215
    return {HalfExtent = 0, Frame = CFrame.new(a1)}
end

local u97 = {}
local v1 = {
    Class = "Workspace",
    Resolve = function() -- Line: 235 -- upvalues: u67 (val)
        return u67
    end,
}
local v2 = {
    Class = "Model",
    Resolve = function(a1) -- Line: 241 -- upvalues: u67 (val) -- types: a1: userdata
        local PrimaryPart = a1.PrimaryPart
        if PrimaryPart then
            return {
                Frame = PrimaryPart.CFrame,
                HalfExtent = PrimaryPart.Size.Magnitude / 2,
            }
        end
        return u67
    end,
}
u97[1] = {
    Class = "Attachment",
    Resolve = function(a1) -- Line: 223 -- types: a1: userdata
        return {HalfExtent = 0, Frame = a1.WorldCFrame}
    end,
}
u97[2] = {
    Class = "BasePart",
    Resolve = function(a1) -- Line: 229 -- types: a1: userdata
        return {Frame = a1.CFrame, HalfExtent = a1.Size.Magnitude / 2}
    end,
}
u97[3] = v1
u97[4] = v2
u97[5] = {
    Class = "PVInstance",
    Resolve = function(a1) -- Line: 248 -- types: a1: userdata
        return {HalfExtent = 0, Frame = a1:GetPivot()}
    end,
}

local function needsPrimaryPart(a1) -- Line: 254
    if typeof(a1) ~= "Instance" then
        return false
    end
    return a1:IsA("Model") and not a1:IsA("Workspace")
end

local function placementOf(a1) -- Line: 262 -- upvalues: u94 (val), u97 (val), u67 (val)
    local v1 = u94[typeof(a1)]
    if v1 ~= nil then
        return v1(a1)
    end
    for i, j in u97 do
        if a1:IsA(j.Class) then
            return j.Resolve(a1)
        end
    end
    return u67
end

local function earshotSlack(a1, a2) -- Line: 276 -- upvalues: u75 (val) -- types: a2: number
    if typeof(a1) ~= "Instance" then
        return 1.5
    end
    local v1 = u75[a1]
    local v2 = false
    if v1 ~= nil then
        v2 = a2 - v1 < 4
    end
    if v2 then
        return 2
    end
    return 1.5
end

local function inEarshot(a1, a2, a3) -- Line: 285
    -- upvalues: Workspace (val), u75 (val)
    local CurrentCamera = Workspace.CurrentCamera
    local Frame = a2.Frame
    if CurrentCamera ~= nil and Frame ~= nil then
        local v1, v2
        local v3 = os.clock()
        local v4 = (CurrentCamera:GetRenderCFrame().Position - Frame.Position).Magnitude - a2.HalfExtent
        if typeof(a1) == "Instance" then
            local v5 = u75[a1]
            local v6 = false
            if v5 ~= nil then
                v6 = v3 - v5 < 4
            end
            v2 = if not v6 then 1.5 else 2
        else
            v2 = 1.5
        end
        if v4 <= a3 * v2 and typeof(a1) == "Instance" then
            u75[a1] = v3
        end
        return v1
    end
    return true
end

local function shelf() -- Line: 301 -- upvalues: u71 (ref), SoundService (val)
    local v1 = u71
    if v1 and v1.Parent ~= nil then
        return v1
    end
    local Folder = Instance.new("Folder")
    Folder.Name = "MusicTracks"
    Folder.Parent = SoundService
    u71 = Folder
    return Folder
end

local function stageFor(a1, a2) -- Line: 315 -- upvalues: Workspace (val) -- types: a2: userdata?
    if typeof(a1) == "Instance" then
        if if typeof(a1) == "Instance" then a1:IsA("Model") and not a1:IsA("Workspace") else false then
            return (assert(a1.PrimaryPart)), nil
        end
        return a1, nil
    end
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "SoundStage"
    Attachment.Parent = Workspace.Terrain
    Attachment.WorldCFrame = a2
    return Attachment, Attachment
end

local function launch(a1, a2) -- Line: 330 -- types: a1: userdata, a2: userdata
    local function retire() -- Line: 331 -- upvalues: a2 (val)
        a2:Destroy()
    end

    a1.Ended:Once(retire)
    a1.Stopped:Once(retire)
    a1:Play()
    return a1
end

local function sfxMuted() -- Line: 342 -- upvalues: GameFlags (val), u52 (val)
    if not GameFlags.SoundEffects:Get() then
        return true
    end
    local v1 = false
    if u52 ~= nil then
        v1 = not u52.IsOn("SFX")
    end
    return v1
end

local function dispatch(a1, a2, a3) -- Line: 350 -- upvalues: Remotes (val) -- types: a3: table
    local Recipient = a3.Recipient
    local v1 = table.clone(a3)
    v1.Recipient = nil
    local v2 = {Source = a1, Emitter = a2, Options = v1}
    local EmitSound = Remotes.SoundBus.EmitSound
    if Recipient == nil then
        EmitSound:FireAllClients(v2)
        return
    end
    if typeof(Recipient) == "Instance" then
        EmitSound:FireClient(Recipient, v2)
        return
    end
    for i, j in Recipient do
        EmitSound:FireClient(j, v2)
    end
end

function u68:Play(a2, a3) -- Line: 369
    -- upvalues: u46 (val), dispatch (val), GameFlags (val), u52 (val), placementOf (val), inEarshot (val)
    -- upvalues: retouchSound (val), authorSound (val), attachEffects (val), Workspace (val)
    local u150, v1, v2, v3
    local v4 = a3 or {}
    if not u46 then
        dispatch(self, a2, v4)
        return nil
    end
    if GameFlags.SoundEffects:Get() then
        v1 = false
        if u52 ~= nil then
            v1 = not u52.IsOn("SFX")
        end
    else
        v1 = true
    end
    if v1 then
        return nil
    end
    v1 = placementOf(a2)
    if v1.Frame == nil
        and (if typeof(a2) == "Instance" then a2:IsA("Model") and not a2:IsA("Workspace") else false) then
        warn((("Audio.Play skipped: %* has no PrimaryPart"):format((a2:GetFullName()))))
        return nil
    end
    local v5 = v4.MaxDistance or 200
    if v4.Looped ~= true and not inEarshot(a2, v1, v5) then
        return nil
    end
    if typeof(self) ~= "Instance" then
        v2 = authorSound(Instance.new("Sound"), self, v4)
    else
        assert(self:IsA("Sound"), "an Instance sound source must be a Sound")
        v2 = retouchSound(self:Clone(), v4)
    end
    attachEffects(v2, v4.Effects)
    local Frame = v1.Frame
    if typeof(a2) ~= "Instance" then
        v5 = Instance.new("Attachment")
        v5.Name = "SoundStage"
        v5.Parent = Workspace.Terrain
        v5.WorldCFrame = Frame
        v3 = v5
        u150 = v5
    else
        v3 = if not (if typeof(a2) == "Instance" then a2:IsA("Model") and not a2:IsA("Workspace") else false) then a2 else assert(a2.PrimaryPart)
        u150 = nil
    end
    v2.Parent = v3
    if v4.Deferred then
        if u150 ~= nil then
            v2.Destroying:Once(function() -- Line: 403 -- upvalues: u150 (val)
                u150:Destroy()
            end)
        end
        return v2
    end
    local v6 = v2
    local u165 = u150 or v2

    local function retire() -- Line: 331 -- upvalues: u165 (val)
        u165:Destroy()
    end

    v6.Ended:Once(retire)
    v6.Stopped:Once(retire)
    v6:Play()
    return v6
end

function u68.PlaySound(a1, a2) -- Line: 412 -- types: a1: userdata, a2: userdata?
    if a2 then
        a1.Parent = a2
    end

    local function retire() -- Line: 331 -- upvalues: a1 (val)
        a1:Destroy()
    end

    a1.Ended:Once(retire)
    a1.Stopped:Once(retire)
    a1:Play()
    return a1
end

function u68.PlayFile(a1, a2, a3) -- Line: 419 -- upvalues: u68 (val) -- types: a1: table, a3: table?
    local Data = a1.Data
    return u68.Play(a1.SoundId, a2, {
        Deferred = Data.SkipPlay,
        Looped = Data.Looped,
        MaxDistance = Data.MaxDistance,
        PlaybackSpeed = Data.Speed,
        Recipient = Data.Player,
        SoundGroup = Data.SoundGroup,
        TimePosition = Data.TimePos,
        Volume = Data.Volume,
        Effects = a3,
    })
end

function u68.Configure(a1, a2) -- Line: 425 -- upvalues: authorSound (val) -- types: a1: userdata, a2: table
    local SoundId = a2.SoundId
    assert(typeof(SoundId) ~= "Instance", "a catalogued Sound cannot be configured from another Sound")
    local v1 = authorSound
    local Data = a2.Data
    return (v1(a1, SoundId, {
        Deferred = Data.SkipPlay,
        Looped = Data.Looped,
        MaxDistance = Data.MaxDistance,
        PlaybackSpeed = Data.Speed,
        Recipient = Data.Player,
        SoundGroup = Data.SoundGroup,
        TimePosition = Data.TimePos,
        Volume = Data.Volume,
    }))
end

function u68.CreateConfigured(a1, a2, a3) -- Line: 431
    -- upvalues: u68 (val)
    local v1 = u68.Configure(Instance.new("Sound"), a2)
    v1.Name = a3 or "CatalogSound"
    v1.Parent = a1
    return v1
end

function u68.MusicTrack(a1) -- Line: 439
    -- upvalues: resolveGroup (val), pickAsset (ref), u71 (ref), SoundService (val)
    local v1
    local Sound = Instance.new("Sound")
    Sound.Looped = a1.Looped
    Sound.Name = a1.Name
    Sound.SoundGroup = resolveGroup(nil, "Music")
    Sound.SoundId = ("rbxassetid://%*"):format((pickAsset(a1.Source)))
    Sound.Volume = 0
    local v2 = u71
    if not v2 or v2.Parent == nil then
        local Folder = Instance.new("Folder")
        Folder.Name = "MusicTracks"
        Folder.Parent = SoundService
        u71 = Folder
        v1 = Folder
    else
        v1 = v2
    end
    Sound.Parent = v1
    return Sound
end

function u68.FadeTo(a1, a2) -- Line: 450 -- upvalues: u58 (val), TweenService (val) -- types: a1: userdata, a2: table
    local v1 = TweenService:Create(a1, TweenInfo.new(a2.Seconds, a2.Style or u58.Style, a2.Direction or u58.Direction), {Volume = a2.Volume})
    v1:Play()
    return v1
end

function u68.Chime(a1, a2, a3) -- Line: 462
    -- upvalues: u68 (val), u54 (val)
    u68.Play(131342831254185, script, {Recipient = a3, Volume = (u54[a1] or 1) * (a2 or 1)})
end

if u46 then
    Remotes.SoundBus.EmitSound.OnClientEvent:Connect(function(a1) -- Line: 472 -- upvalues: u68 (val) -- types: a1: table
        u68.Play(a1.Source, a1.Emitter, a1.Options)
    end)
end
return (table.freeze(u68))