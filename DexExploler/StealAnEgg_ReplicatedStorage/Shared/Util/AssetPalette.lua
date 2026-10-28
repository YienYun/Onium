-- Script path: ReplicatedStorage.Shared.Util.AssetPalette
-- Decompile time: 6.43 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local t = require(ReplicatedStorage.Packages.t)
local DrawWeighted = require(ReplicatedStorage.Shared.Utils.Numeric).DrawWeighted
local u29 = Color3.fromRGB(255, 255, 255)
local u32 = t.strict(t.Color3)
local u37 = t.strict(t.optional(t.number))
local u42 = t.strict(t.optional(t.string))
local u47 = t.strict(t.instanceIsA("Model"))
local u50 = t.strict(t.number)
local u53 = t.strict(t.string)
local u54 = {}

local function speciesEntry(a1) -- Line: 43 -- upvalues: Assets (val) -- types: a1: string
    local v1 = Assets.Directory[a1]
    local v2 = ("Asset catalog carries no palette named %*"):format(a1)
    assert(v1 ~= nil, v2)
    return v1
end

local function wearsIris(a1) -- Line: 49 -- types: a1: userdata
    local v1 = true
    if a1:GetAttribute("IsEye") ~= true then
        v1 = string.find(string.lower(a1.Name), "eye", 1, true) ~= nil
    end
    return v1
end

local function wearsBaseCoat(a1, a2) -- Line: 56 -- types: a1: userdata, a2: userdata
    local v1
    local v2, v3, v4 = a1:ToHSV()
    local v5, v6, v7 = a2:ToHSV()
    local v8 = v3 < 0.16
    if v6 < 0.16 then
        v1 = v8
        if v1 then
            if v7 < 0.08 then
                return v4 <= 0.08
            end
            v1 = (math.abs(v4 - v7)) <= 0.18
        end
        return v1
    end
    v6 = math.abs(v2 - v5)
    v5 = v4 / math.max(v7, 0.001)
    v1 = not v8
    if v1 then
        v1 = false
        if (math.min(v6, 1 - v6)) <= 0.08 then
            v1 = false
            if v5 >= 0.08 then
                v1 = v5 <= 1.6
            end
        end
    end
    return v1
end

local function tint(a1, a2, a3, a4, a5) -- Line: 79
    -- upvalues: 
    local v1, v2
    _, _, v2 = a1.Color:ToHSV()
    _, _, v1 = a2:ToHSV()
    local v3, v4, v5 = a3:ToHSV()
    a1.Color = Color3.fromHSV(v3, v4, (math.clamp(
        (if not (v1 < 0.08) then v5 * (v2 / math.max(v1, 0.001)) else v5) * Random.new(a4 + 7919 + a5):NextNumber(0.8333333333333334, 1.2),
        0,
        1
    )))
    if a1:IsA("UnionOperation") then
        a1.UsePartColor = true
    end
end

function u54.DrawEyeColorHex(a1) -- Line: 95 -- upvalues: t (val) -- types: a1: userdata
    assert(t.Random(a1), "An iris draw needs a generator to draw from")
    return Color3.fromHSV(a1:NextNumber(), a1:NextNumber(0.35, 0.85), (a1:NextNumber(0.35, 0.9))):ToHex()
end

function u54.DrawColorSeed(a1) -- Line: 104 -- upvalues: t (val) -- types: a1: userdata
    assert(t.Random(a1), "A colour seed draw needs a generator to draw from")
    return a1:NextInteger(1, 2147483647)
end

function u54.DrawColorIndex(a1, a2) -- Line: 110
    -- upvalues: u53 (val), t (val), DrawWeighted (val), Assets (val)
    u53(a1)
    assert(t.Random(a2), "A palette slot draw needs a generator to draw from")
    local v1 = Assets.Directory[a1]
    local v2 = ("Asset catalog carries no palette named %*"):format(a1)
    assert(v1 ~= nil, v2)
    local v3 = DrawWeighted(v1.PossibleModelColors, a2)
    if v3 then
        return v3.Index
    end
    return 0
end

function u54.DrawFields(a1, a2) -- Line: 119
    -- upvalues: u53 (val), t (val), u54 (val)
    u53(a1)
    assert(t.Random(a2), "A palette draw needs a generator to draw from")
    return {
        EyeColor = u54.DrawEyeColorHex(a2),
        ColorSeed = u54.DrawColorSeed(a2),
        ColorIndex = u54.DrawColorIndex(a1, a2),
    }
end

function u54.SettleFields(a1, a2, a3, a4) -- Line: 130
    -- upvalues: u53 (val), u42 (val), u37 (val), u54 (val)
    u53(a1)
    u42(a2)
    u37(a3)
    u37(a4)
    local v1 = if a3 == nil then 1 else a3
    return {
        EyeColor = if a2 == nil then u54.DrawEyeColorHex(Random.new(v1)) else if a2 == "" then u54.DrawEyeColorHex(Random.new(v1)) else a2,
        ColorSeed = v1,
        ColorIndex = if a4 == nil then 1 else a4,
    }
end

function u54.ModelColorAt(a1, a2) -- Line: 153
    -- upvalues: u53 (val), u50 (val), Assets (val), Constants (val), u32 (val)
    u53(a1)
    u50(a2)
    local v1 = Assets.Directory[a1]
    local v2 = ("Asset catalog carries no palette named %*"):format(a1)
    assert(v1 ~= nil, v2)
    local PossibleModelColors = v1.PossibleModelColors
    if #PossibleModelColors ~= 0 and not (a2 <= 0) then
        if Constants.IS_STUDIO then
            assert(PossibleModelColors[a2], (("Palette for %* stops short of slot %*"):format(a1, a2)))
        end
        local v3 = PossibleModelColors[(a2 - 1) % #PossibleModelColors + 1][1]
        u32(v3)
        return v3
    end
    return nil
end

function u54.PaintModel(a1, a2, a3, a4, a5) -- Line: 170
    -- upvalues: u47 (val), u53 (val), u50 (val), Assets (val), u54 (val), u29 (val), wearsBaseCoat (val), tint (val)
    local v1, v2
    u47(a1)
    u53(a2)
    u53(a3)
    u50(a4)
    u50(a5)
    local v3 = Assets.Directory[a2]
    local v4 = ("Asset catalog carries no palette named %*"):format(a2)
    assert(v3 ~= nil, v4)
    local v5 = Color3.fromHex(a3)
    local v6 = u54.ModelColorAt(a2, a5)
    v4 = (Random.new(a4):NextNumber()) < 0.5
    local v7 = 0
    for i, j in a1:GetDescendants() do
        v1 = if not j:IsA("BasePart") then nil else j
        if v1 ~= nil and not v1:GetAttribute("DontModify") and not (1 <= v1.Transparency) then
            v7 = v7 + 1
            v2 = true
            if v1:GetAttribute("IsEye") ~= true then
                v2 = string.find(string.lower(v1.Name), "eye", 1, true) ~= nil
            end
            if not v2 then
                if v6 ~= nil then
                    if v6 ~= u29 then
                        if wearsBaseCoat(v1.Color, v3.BaseModelColor) then
                            tint(v1, v3.BaseModelColor, v6, v8, v7)
                        end
                    elseif v3.AlbinosColorFullWhite then
                        v1.Color = v6
                    elseif wearsBaseCoat(v1.Color, v3.BaseModelColor) then
                        tint(v1, v3.BaseModelColor, v6, v8, v7)
                    end
                end
            elseif v4 then
                v1.Color = v5
            end
        end
    end
end

return u54