-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals
-- Decompile time: 5.90 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Dropshadow = require(script.Dropshadow)
local Gradient = require(script.Gradient)
require(script.Layers)
local GradientTemplates = require(script.GradientTemplates)
local Stroke = require(script.Stroke)
local t = require(ReplicatedStorage.Packages.t)
local u33 = require(script.VisibilityGate)
local u34 = {UIStroke = true, UIGradient = true}
local u35 = {}
u35.__index = u35
u35.Gradient = Gradient
u35.Stroke = Stroke
u35.Dropshadow = Dropshadow
u35.Templates = GradientTemplates
u35.CurrentEffects = {}
local Presets = script.Presets
local u49 = t.strict(t.union(t.instanceIsA("GuiObject"), t.instanceIsA("UIStroke")))
local u53 = t.strict(t.string)
local u57 = t.strict(t.number)
local u63 = t.strict(t.union(t.ColorSequence, t.Color3))
local u69 = t.strict(t.union(t.NumberSequence, t.number))

local function broadcast(a1, a2) -- Line: 61 -- types: a2: string
    local v1
    for i, j in a1.EffectObjects do
        v1 = j[a2]
        if v1 then
            v1(j)
        end
    end
end

local function absorb(a1, a2) -- Line: 70 -- types: a1: table, a2: table?
    if not a2 then
        return
    end
    for i, j in a2 do
        a1[#a1 + 1] = j
    end
end

local function teardown(a1) -- Line: 80
    local Destroy
    for i, j in a1.detached do
        j.Parent = a1.host
    end
    local v1 = nil
    local v2 = nil
    local v3 = a1
    for k, n in a1.watchers, v1, v2 do
        if typeof(n) ~= "table" or typeof(n.Destroy) ~= "function" then
            n:Disconnect()
        else
            n:Destroy()
        end
    end
    table.clear(v3.detached)
    table.clear(v3.watchers)
    for m, i5 in v3.EffectObjects do
        Destroy = i5.Destroy
        if Destroy then
            Destroy(i5)
        end
    end
    v3.lifeWatch:Disconnect()
end

local function watchLifetime(a1) -- Line: 102 -- upvalues: teardown (val)
    local host = a1.host
    return host.AncestryChanged:Connect(function() -- Line: 105 -- upvalues: host (val), teardown (upval), a1 (val)
        if host:IsDescendantOf(game) then
            return
        end
        teardown(a1)
    end)
end

local function stashExisting(a1) -- Line: 114 -- upvalues: u34 (val)
    local detached = a1.detached
    for i, j in (a1.host:GetChildren()) do
        if u34[j.ClassName] then
            detached[#detached + 1] = j
            j.Parent = nil
        end
    end
end

function u35.new(a1, a2, a3, a4, a5, a6, a7, a8, a9) -- Line: 126
    -- upvalues: u49 (val), u53 (val), Presets (val), u57 (val), u63 (val), u69 (val), u35 (val), stashExisting (val)
    -- upvalues: teardown (val), u33 (val)
    u49(a1)
    u53(a2)
    local v1 = Presets:FindFirstChild(a2)
    assert(v1, (("EasyVisuals has no preset named %*"):format(a2)))
    if a3 then
        u57(a3)
    end
    if a4 then
        u57(a4)
    end
    if a6 then
        u63(a6)
    end
    if a7 then
        u69(a7)
    end
    local v2 = {
        isPaused = false,
        Diagnostic = "DIAGNOSTIC VALUE",
        host = a1,
        EffectObjects = {},
        detached = {},
        watchers = {},
    }
    local v3 = true
    if a8 ~= nil then
        v3 = a8
    end
    v2.resumesWhenShown = v3
    v2.drift = a3 or 0.007
    v2.width = a4 or 1
    local u75 = setmetatable(v2, u35)
    v1 = require(v1)({
        Host = a1,
        Drift = u75.drift,
        Width = u75.width,
        Color = a6,
        Alpha = a7,
        Chain = a9,
    })
    assert(typeof(v1) == "table", "an effect preset must hand back a table")
    if a5 then
        stashExisting(u75)
    end
    local watchers = u75.watchers
    local Connections = v1.Connections
    if Connections then
        for i, j in Connections do
            watchers[#watchers + 1] = j
        end
    end
    local EffectObjects = u75.EffectObjects
    local Effects = v1.Effects
    if Effects then
        for k, n in Effects do
            EffectObjects[#EffectObjects + 1] = n
        end
    end
    local host = u75.host
    u75.lifeWatch = host.AncestryChanged:Connect(function() -- Line: 105 -- upvalues: host (val), teardown (upval), u75 (val)
        if host:IsDescendantOf(game) then
            return
        end
        teardown(u75)
    end)
    v1 = u33.Watch(a1, function() -- Line: 193 -- upvalues: u75 (val)
        local Suspend
        for i, j in u75.EffectObjects do
            Suspend = j.Suspend
            if Suspend then
                Suspend(j)
            end
        end
    end, function() -- Line: 193 -- upvalues: u75 (val)
        if u75.resumesWhenShown then
            local Wake
            for i, j in u75.EffectObjects do
                Wake = j.Wake
                if Wake then
                    Wake(j)
                end
            end
        end
    end)
    if v1 then
        local watchers_2 = u75.watchers
        watchers_2[#watchers_2 + 1] = v1
    end
    return u75
end

function u35.Destroy(a1) -- Line: 207 -- upvalues: teardown (val)
    teardown(a1)
end

function u35.Suspend(a1) -- Line: 209
    local Suspend
    for i, j in a1.EffectObjects do
        Suspend = j.Suspend
        if Suspend then
            Suspend(j)
        end
    end
end

function u35.Wake(a1) -- Line: 211
    local Wake
    for i, j in a1.EffectObjects do
        Wake = j.Wake
        if Wake then
            Wake(j)
        end
    end
end

return table.freeze(u35)