-- Script path: ReplicatedStorage.Controllers.Game.AudioSettingsController
-- Decompile time: 3.29 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Preferences = require(ReplicatedStorage.Shared.Preferences)
local Signal = require(ReplicatedStorage.Packages.Signal)
local u18 = {Music = {"Music"}, SFX = {"Gameplay", "GameplayReverb"}}
local u24 = {Music = 1, SFX = 1}
local u25 = {}
local u26 = {}
u26.Changed = Signal.new()

function u26.Get(a1) -- Line: 36 -- upvalues: u24 (val) -- types: a1: string
    return u24[a1]
end

function u26.Set(a1, a2) -- Line: 40 -- upvalues: u24 (val), u26 (val) -- types: a1: string, a2: number
    assert(u24[a1] ~= nil, (("no volume category called %*"):format(a1)))
    local v1 = math.clamp(a2, 0, 1)
    if u24[a1] == v1 then
        return
    end
    u24[a1] = v1
    u26.Changed:Fire(a1, v1)
end

function u26.Start() -- Line: 50 -- upvalues: Preferences (val), u26 (val), u25 (val), u18 (val), SoundService (val)
    local v1, v2, v3

    local function gainFor(a1) -- Line: 52 -- upvalues: Preferences (upval), u26 (upval) -- types: a1: string
        if Preferences.IsOn(a1) then
            return (u26.Get(a1))
        end
        return 0
    end

    local function apply(a1) -- Line: 56 -- upvalues: Preferences (upval), u26 (upval) -- types: a1: table
        local Setting = a1.Setting
        local v1 = if not Preferences.IsOn(Setting) then 0 else u26.Get(Setting)
        for i, j in a1.Groups do
            j.Volume = a1.Authored[i] * v1
        end
    end

    local function onTouched(a1) -- Line: 63
        -- upvalues: u25 (upval), Preferences (upval), u26 (upval)
        local v1 = u25[a1]
        if v1 ~= nil then
            local Setting = v1.Setting
            local v2 = if not Preferences.IsOn(Setting) then 0 else u26.Get(Setting)
            for i, j in v1.Groups do
                j.Volume = v1.Authored[i] * v2
            end
        end
    end

    local v4 = nil
    local v5 = nil
    for i, j in u18, v4, v5 do
        v2 = {}
        v3 = {}
        for k, n in j do
            v1 = SoundService:WaitForChild(n)
            table.insert(v2, v1)
            table.insert(v3, v1.Volume)
        end
        u25[i] = {Setting = i, Groups = v2, Authored = v3}
    end
    u26.Changed:Connect(onTouched)
    for m, i5 in u25 do
        Preferences.Observe(i5.Setting, function() -- Line: 87 -- upvalues: i5 (val), Preferences (upval), u26 (upval)
            local v1 = i5
            local Setting = v1.Setting
            local v2 = if not Preferences.IsOn(Setting) then 0 else u26.Get(Setting)
            for i, j in v1.Groups do
                j.Volume = v1.Authored[i] * v2
            end
        end)
    end
end

return table.freeze(u26)