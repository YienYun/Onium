-- Script path: ReplicatedStorage.Shared.Util.AssetSounds
-- Decompile time: 3.30 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local v1 = {}

local function sizeFactor(a1, a2, a3) -- Line: 39 -- types: a1: userdata, a2: string, a3: table?
    local weight = if not a3 then nil else a3.weight
    local baseWeight = if not a3 then nil else a3.baseWeight
    if a2 == "WalkSound" and typeof(weight) == "number" and typeof(baseWeight) == "number" and baseWeight > 0 then
        return (math.max(weight / baseWeight, 0.001))
    end
    local baseModelScale_2 = 1
    if a3 and typeof(a3.baseModelScale) == "number" then
        baseModelScale_2 = a3.baseModelScale
    end
    if baseModelScale_2 <= 0 then
        baseModelScale_2 = 1
    end
    return (math.max(a1:GetScale() / baseModelScale_2, 0.001))
end

local function scaled(a1, a2, a3, a4) -- Line: 62 -- types: a1: number?, a2: number, a3: number, a4: number
    if typeof(a1) ~= "number" then
        return nil
    end
    return a1 * math.clamp(a2, a3, a4)
end

local function splitMutationList(a1) -- Line: 70
    local v1 = {}
    if typeof(a1) == "string" and a1 ~= "" then
        local v2
        for i in string.gmatch(a1, "[^,]+") do
            v2 = i:gsub("^%s*(.-)%s*$", "%1")
            if v2 ~= "" then
                table.insert(v1, v2)
            end
        end
        return v1
    end
    return v1
end

function v1.BuildSound(a1, a2, a3, a4, a5) -- Line: 86
    -- upvalues: Audio (val), sizeFactor (val)
    local v1
    if not a3 then
        return nil
    end
    local Sound = Instance.new("Sound")
    Sound.Name = a4
    Audio.Configure(Sound, a3)
    Sound.RollOffMaxDistance = 40
    local v2 = sizeFactor(a2, a4, a5)
    if 0 < Sound.Volume then
        v1 = if a4 ~= "WalkSound" then 3 else 3.5
        local Volume = Sound.Volume
        local v3 = if typeof(Volume) == "number" then Volume * math.clamp(v2, 1, v1) else nil
        if v3 then
            Sound.Volume = v3
        end
    end
    if 0 < Sound.RollOffMaxDistance then
        local RollOffMaxDistance = Sound.RollOffMaxDistance
        v1 = if typeof(RollOffMaxDistance) == "number" then RollOffMaxDistance * math.clamp(v2, 0.7, 1.2) else nil
        if v1 then
            Sound.RollOffMaxDistance = v1
        end
    end
    Sound.Parent = a1
    return Sound
end

function v1.WeightedParams(a1) -- Line: 129 -- types: a1: number?
    if a1 ~= nil and not (a1 <= 0) then
        local v1 = math.clamp(a1, 50, 480)
        local v2 = (math.log(v1) - 3.912023005428146) / 2.2617630984737906
        local v3 = v2 * 0.5 + 2.5
        if v1 >= 80 and v1 <= 110 then
            return v3, 1
        end
        return v3, 2 - v2 * 1.5
    end
    return 1, 1
end

function v1.ParseMutationList(a1) -- Line: 145 -- upvalues: splitMutationList (val)
    return (splitMutationList(a1))
end

function v1.ReadMutationState(a1, a2, a3) -- Line: 147
    -- upvalues: splitMutationList (val)
    local v1 = splitMutationList(a1:GetAttribute(a2 or "Mutations"))
    local Attribute = a1:GetAttribute(a3 or "BaseMutation")
    return v1, if typeof(Attribute) ~= "string" then nil else if Attribute == "" then nil else Attribute
end

function v1.AttachEffects(a1, a2) -- Line: 160 -- types: a1: table?, a2: userdata
    if not a1 then
        return nil
    end
    for i, v in ipairs(a1) do
        v.Parent = a2
    end
    return a1
end

function v1.StartFootsteps(a1) -- Line: 172 -- types: a1: userdata?
    if a1 and not a1.IsPlaying then
        a1.TimePosition = 0
        a1.Looped = true
        a1:Play()
        return
    end
end

function v1.StopFootsteps(a1) -- Line: 182 -- types: a1: userdata?
    if a1 and a1.IsPlaying then
        a1:Stop()
        return
    end
end

function v1.PlayJump(a1) -- Line: 190 -- types: a1: userdata?
    if not a1 then
        return
    end
    a1.TimePosition = 0
    a1.Looped = false
    a1:Play()
end

return v1