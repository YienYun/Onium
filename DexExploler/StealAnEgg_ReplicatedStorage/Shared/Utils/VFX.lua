-- Script path: ReplicatedStorage.Shared.Utils.VFX
-- Decompile time: 8.95 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local u22 = Random.new()
local u23 = {}

function u23.Discard(a1, a2) -- Line: 27 -- upvalues: Debris (val) -- types: a1: userdata, a2: number?
    Debris:AddItem(a1, if a2 == nil then 0 else if not (a2 > 0) then 0 else a2)
end

local function numberAttribute(a1, a2, a3) -- Line: 33 -- types: a1: userdata, a2: string, a3: number
    local Attribute = a1:GetAttribute(a2)
    if type(Attribute) == "number" then
        return Attribute
    end
    return a3
end

local function stochasticRound(a1) -- Line: 40 -- upvalues: u22 (val) -- types: a1: number
    return (math.floor(a1 + (u22:NextNumber())))
end

local function thinForHandheld(a1, a2) -- Line: 44 -- upvalues: Constants (val) -- types: a1: number
    if a2 and Constants.IS_MOBILE and not (a1 <= 1) then
        return (math.max(1, (math.round(a1 * (if type(a2) ~= "number" then 0.1 else a2)))))
    end
    return a1
end

local function isPlaying(a1) -- Line: 52 -- types: a1: userdata
    return 0 < a1.TimeScale
end

local function isHandFired(a1) -- Line: 56 -- types: a1: number
    return not (a1 < (1 / 0))
end

local function cueFor(a1, a2) -- Line: 62 -- upvalues: u22 (val), Constants (val) -- types: a1: userdata
    local Attribute = a1:GetAttribute("EmitDelay")
    local v1 = if type(Attribute) ~= "number" then 0 else Attribute
    if 0 < a1.TimeScale then
        local v2 = v1 < (1 / 0)
        if v2 then
            local Rate = a1.Rate
            local Attribute_2 = a1:GetAttribute("EmitCount")
            local v3 = math.floor((if type(Attribute_2) ~= "number" then Rate else Attribute_2) + (u22:NextNumber()))
            if (if not a2 or not Constants.IS_MOBILE then v3 else if not (v3 <= 1) then math.max(1, (math.round(v3 * (if type(a2) ~= "number" then 0.1 else a2)))) else v3) < 1 then
                return nil
            end
            return {emitter = a1, pieces = v2, at = math.max(v1, 0)}
        end
    end
    return nil
end

local function lifetimeSeconds(a1) -- Line: 72 -- types: a1: userdata
    return a1.Lifetime.Max / a1.TimeScale
end

local function settleSeconds(a1) -- Line: 76 -- types: a1: table
    local at = a1.at
    local emitter = a1.emitter
    return at + emitter.Lifetime.Max / emitter.TimeScale
end

local function byCueTime(a1, a2) -- Line: 80 -- types: a1: table, a2: table
    return a1.at < a2.at
end

local function playTimeline(a1) -- Line: 87 -- upvalues: byCueTime (val) -- types: a1: table
    local at, emitter
    table.sort(a1, byCueTime)
    local v1 = 0
    local v2 = nil
    for i, j in a1, v2 do
        at = j.at
        emitter = j.emitter
        v1 = math.max(v1, at + emitter.Lifetime.Max / emitter.TimeScale)
    end
    local u29 = 1
    while u29 <= #a1 do
        if not (a1[u29].at <= 0) then
            break
        end
        v2 = a1[u29]
        v2.emitter:Emit(v2.pieces)
        u29 = u29 + 1
    end
    if u29 <= #a1 then
        task.spawn(function() -- Line: 103 -- upvalues: u29 (ref), a1 (val)
            local v1
            local v2 = 0
            local v3 = u29
            local v4 = #a1
            for i = v3, v4 do
                v1 = a1[i]
                if v2 < v1.at then
                    v2 = v2 + task.wait(v1.at - v2)
                end
                if v1.emitter:IsDescendantOf(game) then
                    v1.emitter:Emit(v1.pieces)
                end
            end
        end)
    end
    return v1
end

local function collectEmitters(a1) -- Line: 120 -- types: a1: userdata
    local v1 = {}
    if a1:IsA("ParticleEmitter") then
        table.insert(v1, a1)
    end
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            table.insert(v1, j)
        end
    end
    return v1
end

local function cuesFor(a1, a2) -- Line: 133 -- upvalues: cueFor (val) -- types: a1: table
    local v1
    local v2 = {}
    for i, j in a1 do
        v1 = cueFor(j, a2)
        if v1 then
            table.insert(v2, v1)
        end
    end
    return v2
end

function u23.EmitOne(a1, a2) -- Line: 144 -- upvalues: cueFor (val), playTimeline (val) -- types: a1: userdata
    local v1 = cueFor(a1, a2)
    if v1 == nil then
        return 0
    end
    return (playTimeline({v1}))
end

function u23.EmitTree(a1, a2) -- Line: 152
    -- upvalues: playTimeline (val), cuesFor (val), collectEmitters (val)
    return (playTimeline((cuesFor(collectEmitters(a1), a2))))
end

local function scaleSequence(a1, a2) -- Line: 158 -- types: a1: userdata, a2: number
    local Time, new, v1
    local v2 = table.create(#a1.Keypoints)
    for i, j in a1.Keypoints do
        new = NumberSequenceKeypoint.new
        Time = j.Time
        v1 = j.Value * a2
        v2[i] = (new(Time, v1, j.Envelope * a2))
    end
    return NumberSequence.new(v2)
end

function u23.Rescale(a1, a2) -- Line: 166 -- upvalues: scaleSequence (val) -- types: a1: userdata, a2: number
    a1.Acceleration = a1.Acceleration * a2
    a1.Size = scaleSequence(a1.Size, a2)
    a1.Speed = NumberRange.new(a1.Speed.Min * a2, a1.Speed.Max * a2)
end

local u41 = {
    Anchored = true,
    CanCollide = false,
    CanQuery = false,
    CanTouch = false,
    CastShadow = false,
    Locked = true,
    Massless = true,
    Name = "EffectAnchor",
    Size = Vector3.new(0, 0, 0),
    Transparency = 1,
}

local function newAnchorPart(a1) -- Line: 187 -- upvalues: u41 (val), Workspace (val) -- types: a1: userdata
    local Part = Instance.new("Part")
    for i, j in u41 do
        Part[i] = j
    end
    Part:PivotTo(a1)
    Part.Parent = Workspace:WaitForChild("Transient")
    return Part
end

local function hostOfInstance(a1) -- Line: 198 -- types: a1: userdata
    if not a1:IsA("Model") then
        return a1
    end
    local PrimaryPart = a1.PrimaryPart
    assert(PrimaryPart, (("%* needs a PrimaryPart to anchor effects"):format((a1:GetFullName()))))
    return PrimaryPart
end

local u44 = {}

function u44.CFrame(a1) -- Line: 208 -- upvalues: u41 (val), Workspace (val)
    local Part = Instance.new("Part")
    for i, j in u41 do
        Part[i] = j
    end
    Part:PivotTo(a1)
    Part.Parent = Workspace:WaitForChild("Transient")
    return Part, Part
end

function u44.Instance(a1) -- Line: 212
    local v1
    if a1:IsA("Model") then
        local PrimaryPart = a1.PrimaryPart
        assert(PrimaryPart, (("%* needs a PrimaryPart to anchor effects"):format((a1:GetFullName()))))
        v1 = PrimaryPart
    else
        v1 = a1
    end
    return v1, nil
end

function u44.Vector3(a1) -- Line: 215 -- upvalues: u41 (val), Workspace (val)
    local v1 = CFrame.new(a1)
    local v2 = Instance.new("Part")
    for i, j in u41 do
        v2[i] = j
    end
    v2:PivotTo(v1)
    v2.Parent = Workspace:WaitForChild("Transient")
    return v2, v2
end

local function anchorFor(a1) -- Line: 223 -- upvalues: u44 (val)
    local v1 = u44[typeof(a1)]
    if v1 == nil then
        error((("effects cannot be placed at a %*"):format((typeof(a1)))))
    end
    return v1(a1)
end

function u23.EmitAt(a1, a2, a3) -- Line: 233
    -- upvalues: u44 (val), cueFor (val), u23 (val), playTimeline (val)
    local v1 = u44[typeof(a1)]
    if v1 == nil then
        error((("effects cannot be placed at a %*"):format((typeof(a1)))))
    end
    local v2, v3 = v1(a1)
    local u23_2 = v2
    local u69 = v3
    local u70 = {}
    local u71 = {}

    local function stageClone(a1) -- Line: 238
        -- upvalues: a3 (val), u23_2 (val), cueFor (upval), u70 (val), u71 (val), u69 (val), u23 (upval)
        local v1 = a1:Clone()
        v1.Enabled = false
        if a3 then
            a3(v1)
        end
        v1.Parent = u23_2
        local v2 = cueFor(v1, true)
        if v2 == nil then
            v1:Destroy()
            return
        end
        table.insert(u70, v1)
        table.insert(u71, v2)
        if u69 == nil then
            local Discard = u23.Discard
            local at = v2.at
            local emitter = v2.emitter
            Discard(v1, at + emitter.Lifetime.Max / emitter.TimeScale)
        end
    end

    local v4 = nil
    local v5 = nil
    for i, j in a2, v4, v5 do
        if j:IsA("ParticleEmitter") and 0 < j.TimeScale then
            stageClone(j)
        end
    end
    v3 = playTimeline(u71)
    if u69 then
        u23.Discard(u69, v3)
    end
    return {clones = u70, settleSeconds = v3}
end

return table.freeze(u23)