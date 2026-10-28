-- Script path: ReplicatedStorage.Client.SakuraBloomVisibility
-- Decompile time: 2.98 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Trove = require(ReplicatedStorage.Packages.Trove)
local u9 = {"LocalTransparencyModifier", "CanCollide", "CanQuery", "CanTouch"}
local u14 = {CanCollide = false, CanQuery = false, CanTouch = false, LocalTransparencyModifier = 1}
local u15 = {"Decal", "Texture"}
local u18 = {"Transparency"}
local u20 = {Transparency = 1}
local u21 = {"Enabled"}
local u23 = {Enabled = false}
local u24 = {
    "ParticleEmitter",
    "Beam",
    "Trail",
    "BillboardGui",
    "SurfaceGui",
    "Highlight",
    "Light",
    "ProximityPrompt",
}
local v1 = {}

local function anyClassMatches(a1, a2) -- Line: 36 -- types: a1: userdata, a2: table
    for i, j in a2 do
        if a1:IsA(j) then
            return true
        end
    end
    return false
end

local function muteFields(a1, a2, a3, a4) -- Line: 48 -- types: a2: userdata, a3: table, a4: table
    local u6 = table.create(#a3)
    for i, j in a3 do
        u6[i] = a2[j]
        a2[j] = a4[j]
    end
    a1:Add(function() -- Line: 62 -- upvalues: a2 (val), a3 (val), a2 (val), u6 (val)
        if a2.Parent == nil then
            return
        end
        for i, j in a3 do
            a2[j] = u6[i]
        end
    end)
end

local function mute(a1, a2) -- Line: 73
    -- upvalues: muteFields (val), u9 (val), u14 (val), u15 (val), u18 (val), u20 (val), u24 (val), u21 (val), u23 (val)
    if a2:IsA("BasePart") then
        muteFields(a1, a2, u9, u14)
        return
    end
    for i, j in u15 do
        if a2:IsA(j) then
            if true then
                muteFields(a1, a2, u18, u20)
                return
            end
            for k, n in u24 do
                if a2:IsA(n) then
                    if true then
                        muteFields(a1, a2, u21, u23)
                    end
                    return
                end
            end
            if false then
                muteFields(a1, a2, u21, u23)
            end
            return
        end
    end
    if false then
        muteFields(a1, a2, u18, u20)
        return
    end
    for m, i5 in u24 do
        if a2:IsA(i5) then
            if true then
                muteFields(a1, a2, u21, u23)
            end
            return
        end
    end
    if false then
        muteFields(a1, a2, u21, u23)
    end
end

function v1.Conceal(a1) -- Line: 83 -- upvalues: Trove (val), mute (val) -- types: a1: userdata
    local u3 = Trove.new()
    for i, j in a1:GetDescendants() do
        mute(u3, j)
    end
    u3:Add((a1.DescendantAdded:Connect(function(a1) -- Line: 90 -- upvalues: mute (upval), u3 (val) -- types: a1: userdata
        mute(u3, a1)
    end)))
    return u3
end

return table.freeze(v1)