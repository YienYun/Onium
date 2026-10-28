-- Script path: ReplicatedStorage.Client.WorldFX.TutorialBeam
-- Decompile time: 4.24 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local u18 = {
    stockName = "TutorialBeam",
    anchorPin = "TutorialBeamTargetAttachment",
    followerPin = "TutorialBeamPlayerAttachment",
    rootPart = "HumanoidRootPart",
    rootPartTimeout = 5,
}
u18.drifterProperties = {
    Anchored = true,
    CanCollide = false,
    Name = "TutorialBeamContainer",
    Size = Vector3.new(1, 1, 1),
    Transparency = 1,
}
u18.beamProperties = {Enabled = false, FaceCamera = true}
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local TutorialBeam = ReplicatedStorage.Assets.Extra.TutorialBeam

local function dress(a1, a2) -- Line: 51 -- types: a1: userdata, a2: table
    for i, j in a2 do
        a1[i] = j
    end
    return a1
end

local function demandAnchor(a1, a2) -- Line: 58 -- types: a2: string
    local v1 = true
    if typeof(a1) ~= "Vector3" then
        v1 = false
        if typeof(a1) == "Instance" then
            v1 = a1:IsA("BasePart")
        end
    end
    assert(v1, (("%* needs a BasePart or a Vector3"):format(a2)))
end

local function pinTo(a1, a2) -- Line: 64 -- upvalues: u18 (val)
    local Attachment = Instance.new("Attachment")
    Attachment.Name = u18.anchorPin
    if typeof(a1) ~= "Vector3" then
        Attachment.Parent = a1
        return Attachment, nil
    end
    local Part = Instance.new("Part")
    for i, j in u18.drifterProperties do
        Part[i] = j
    end
    Part.Position = a1
    Part.Parent = workspace
    a2:Add(Part)
    Attachment.Parent = Part
    return Attachment, Part
end

local function rideCharacter(a1) -- Line: 82 -- upvalues: u18 (val) -- types: a1: table
    local Character = a1.owner.Character
    local v1 = if not Character then nil else Character:WaitForChild(u18.rootPart, u18.rootPartTimeout)
    if v1 ~= nil and v1:IsA("BasePart") then
        local pins = a1.pins
        if pins.follower then
            a1.scope:Remove(pins.follower)
        end
        local Attachment = Instance.new("Attachment")
        Attachment.Name = u18.followerPin
        Attachment.Parent = v1
        pins.follower = a1.scope:Add(Attachment)
        a1.beam.Attachment0 = Attachment
        a1.beam.Enabled = true
        return
    end
    a1.beam.Enabled = false
end

function v1.Retarget(a1, a2) -- Line: 105 -- upvalues: t (val), pinTo (val) -- types: a1: table
    t.strict(t.table)(a1)
    local v1 = true
    if typeof(a2) ~= "Vector3" then
        v1 = false
        if typeof(a2) == "Instance" then
            v1 = a2:IsA("BasePart")
        end
    end
    assert(v1, "beam retarget needs a BasePart or a Vector3")
    local pins = a1.pins
    if typeof(a2) == "Vector3" and pins.drifter ~= nil then
        pins.drifter.Position = a2
        return
    end
    if a2 == pins.anchor.Parent then
        return
    end
    a1.scope:Remove(pins.anchor)
    if pins.drifter ~= nil then
        a1.scope:Remove(pins.drifter)
    end
    local v2, v3 = pinTo(a2, a1.scope)
    pins.anchor = v2
    pins.drifter = v3
    a1.scope:Add(pins.anchor)
    a1.beam.Attachment1 = pins.anchor
end

function v1:Destroy() -- Line: 128 -- upvalues: t (val) -- types: self: table
    t.strict(t.table)(self)
    self.scope:Destroy()
end

function v1.Attach(a1, a2) -- Line: 133
    -- upvalues: Trove (val), pinTo (val), TutorialBeam (val), u18 (val), LocalPlayer (val), rideCharacter (val)
    local v1 = true
    if typeof(a1) ~= "Vector3" then
        v1 = false
        if typeof(a1) == "Instance" then
            v1 = a1:IsA("BasePart")
        end
    end
    assert(v1, "beam anchor needs a BasePart or a Vector3")
    v1 = Trove.new()
    local v2, v3 = pinTo(a1, v1)
    v1:Add(v2)
    local v4 = (if not a2 then TutorialBeam else if not a2.Template then TutorialBeam else a2.Template):Clone()
    for i, j in u18.beamProperties do
        v4[i] = j
    end
    local BeamName = if not a2 then u18.stockName else if not a2.BeamName then u18.stockName else a2.BeamName
    v4.Name = BeamName
    v4.Attachment1 = v2
    v4.Parent = workspace
    v1:Add(v4)
    local u72 = {scope = v1, beam = v4, owner = LocalPlayer}
    u72.pins = {anchor = v2, drifter = v3}
    rideCharacter(u72)

    local function remountOn(a1) -- Line: 155
        -- upvalues: u18 (upval), rideCharacter (upval), u72 (val)
        if a1:WaitForChild(u18.rootPart, u18.rootPartTimeout) then
            rideCharacter(u72)
        end
    end

    v1:Connect(LocalPlayer.CharacterAdded, function(a1) -- Line: 161 -- upvalues: remountOn (val)
        task.spawn(remountOn, a1)
    end)
    return u72
end

return v1