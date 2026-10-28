-- Script path: ReplicatedStorage.Shared.Utils.VisualTransform
-- Decompile time: 4.06 ms

local v1 = {"Transparency"}
local u7 = {
    BasePart = v1,
    Beam = v1,
    Decal = v1,
    GuiObject = {"BackgroundTransparency", "ImageTransparency", "TextStrokeTransparency", "TextTransparency"},
    ParticleEmitter = v1,
    Trail = v1,
    UIStroke = v1,
}
local u8 = {}
for i in u7 do
    table.insert(u8, i)
end
table.sort(u8)
local u22 = {}

local function channelsOf(a1) -- Line: 40 -- upvalues: u22 (val), u8 (val), u7 (val) -- types: a1: userdata
    local success
    local v1 = u22[a1.ClassName]
    if v1 then
        return v1
    end
    v1 = {}
    for i, j in u8 do
        if a1:IsA(j) then
            for k, n in u7[j] do
                success = pcall(function() -- Line: 49 -- upvalues: a1 (val), n (val)
                    return a1[n]
                end)
                if success then
                    table.insert(v1, n)
                end
            end
            break
        end
    end
    u22[a1.ClassName] = v1
    return v1
end

local function asOpacity(a1) -- Line: 63
    if typeof(a1) ~= "NumberSequence" then
        return 1 - a1
    end
    local v1 = {}
    for i, j in a1.Keypoints do
        table.insert(v1, {at = j.Time, opacity = 1 - j.Value, spread = j.Envelope})
    end
    return v1
end

local function toward(a1, a2, a3) -- Line: 74 -- types: a1: number, a2: number, a3: number
    return a1 + (a2 - a1) * a3
end

local function transparencyOf(a1, a2, a3) -- Line: 78 -- types: a2: number, a3: number
    local at, new, opacity, v1, v2, v3
    if type(a1) == "number" then
        return 1 - (a1 + (a2 - a1) * a3)
    end
    local v4 = table.create(#a1)
    for i, j in a1 do
        opacity = j.opacity
        v3 = opacity + (a2 - opacity) * a3
        v1 = math.max(0, (math.min(v3, 1 - v3)))
        new = NumberSequenceKeypoint.new
        at = j.at
        v2 = 1 - v3
        v4[i] = (new(at, v2, (math.clamp(j.spread, 0, v1))))
    end
    return NumberSequence.new(v4)
end

local u28 = {}
u28.__index = u28

local function looksOf(a1, a2) -- Line: 94
    -- upvalues: channelsOf (val), asOpacity (val)
    local v1 = a1.looks[a2]
    if v1 == nil then
        v1 = {}
        for i, j in channelsOf(a2) do
            table.insert(v1, {property = j, opacity = asOpacity(a2[j])})
        end
        a1.looks[a2] = v1
    end
    return v1
end

local function skipped(a1, a2, a3) -- Line: 106 -- types: a1: userdata, a2: userdata, a3: table?
    if a3 == nil then
        return false
    end
    local Parent = a1
    while Parent ~= nil do
        if table.find(a3, Parent.ClassName) ~= nil then
            return true
        end
        if Parent == a2 then
            break
        end
        Parent = Parent.Parent
    end
    return false
end

local function subjectsUnder(a1, a2) -- Line: 123 -- upvalues: skipped (val) -- types: a1: userdata, a2: table?
    local v1 = {}
    if not skipped(a1, a1, a2) then
        table.insert(v1, a1)
    end
    for i, j in a1:GetDescendants() do
        if not skipped(j, a1, a2) then
            table.insert(v1, j)
        end
    end
    return v1
end

function u28.Blend(a1, a2, a3, a4, a5) -- Line: 136
    -- upvalues: subjectsUnder (val), looksOf (val), transparencyOf (val)
    for i, j in subjectsUnder(a2, a5) do
        for k, n in looksOf(a1, j) do
            j[n.property] = (transparencyOf(n.opacity, v1, v2))
        end
    end
end

function u28.Hide(a1, a2, a3, a4) -- Line: 144
    -- upvalues: u28 (val)
    u28.Blend(a1, a2, 0, a3, a4)
end

return table.freeze({
    Fader = function() -- Line: 150 -- upvalues: u28 (val)
        return (setmetatable({looks = setmetatable({}, {__mode = "k"})}, u28))
    end,
})