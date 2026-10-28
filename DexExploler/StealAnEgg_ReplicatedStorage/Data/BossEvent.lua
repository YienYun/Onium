-- Script path: ReplicatedStorage.Data.BossEvent
-- Decompile time: 3.15 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local BossEventFlags = require(ReplicatedStorage.Shared.Flags.BossEventFlags)
local BossEventSounds = ReplicatedStorage.Assets.Sounds:WaitForChild("BossEventSounds")
local u30 = {}
local u31 = nil
local u32 = {IntervalSeconds = 1800, BossName = "Abyss Overlord"}

function u32.CurrentPeriod() -- Line: 54 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow() // 1800
end

function u32.PeriodStart(a1) -- Line: 58 -- types: a1: number
    return a1 * 1800
end

function u32.ClampDuration(a1) -- Line: 64 -- types: a1: number
    return (math.clamp(a1, 1, 1740))
end

function u32.HealthMultiplier(a1) -- Line: 71 -- upvalues: BossEventFlags (val) -- types: a1: number
    local v1
    local v2 = math.max(math.floor(a1), 1)
    local v3 = nil
    local v4 = (-1 / 0)
    local v5 = nil
    local v6 = (1 / 0)
    for i, j in BossEventFlags.HealthScalesWithPlayers:Get() do
        v1 = tonumber(i)
        if v1 ~= nil then
            if v1 <= v2 and v4 < v1 then
                v3 = j
            end
            if v1 < v6 then
                v5 = j
            end
        end
    end
    return v3 or v5 or 1
end

local function soundNamed(a1) -- Line: 99 -- upvalues: u30 (val), BossEventSounds (val) -- types: a1: string
    local v1 = u30[a1]
    if v1 ~= nil then
        return v1
    end
    v1 = BossEventSounds:FindFirstChild(a1)
    local v2 = false
    if v1 ~= nil then
        v2 = v1:IsA("Sound")
    end
    assert(v2, (("BossEventSounds needs the Sound %*"):format(a1)))
    u30[a1] = v1
    return v1
end

function u32.PlaySound(a1, a2, a3) -- Line: 114
    -- upvalues: u30 (val), BossEventSounds (val), u31 (ref), RunService (val), Audio (val)
    local v1
    local v2 = u30[a1]
    if v2 == nil then
        v2 = BossEventSounds:FindFirstChild(a1)
        local v3 = false
        if v2 ~= nil then
            v3 = v2:IsA("Sound")
        end
        assert(v3, (("BossEventSounds needs the Sound %*"):format(a1)))
        u30[a1] = v2
    end
    local MaxDistance = (if a3 == nil then {} else table.clone(a3)).MaxDistance or v2.RollOffMaxDistance
    v2.MaxDistance = MaxDistance
    v2.SoundGroup = v2.SoundGroup or "SFX"
    local v4 = u31
    if RunService:IsServer() and v4 ~= nil and v2.Recipient == nil then
        local v5
        for i, j in v4() do
            v5 = table.clone(v2)
            v5.Recipient = j
            Audio.Play(v1, a2, v5)
        end
        return nil
    end
    return Audio.Play(v1, a2, v2)
end

function u32.SetAudience(a1) -- Line: 136 -- upvalues: u31 (ref) -- types: a1: function
    u31 = a1
end

function u32.PlaySoundEverywhere(a1, a2) -- Line: 144 -- upvalues: u32 (val), BossEventSounds (val) -- types: a1: string
    return u32.PlaySound(a1, BossEventSounds, a2)
end

function u32.CurrentWindow(a1) -- Line: 148 -- upvalues: u32 (val), Workspace (val) -- types: a1: number
    local v1 = u32.ClampDuration(a1)
    local ServerTimeNow = Workspace:GetServerTimeNow()
    local v2 = u32.PeriodStart(ServerTimeNow // 1800)
    if ServerTimeNow - v2 < v1 then
        return {Open = true, OpensAt = v2, ClosesAt = v2 + v1}
    end
    local v3 = v2 + 1800
    return {Open = false, OpensAt = v3, ClosesAt = v3 + v1}
end

function u32.SecondsUntilNextOpen() -- Line: 169 -- upvalues: Workspace (val)
    return 1800 - Workspace:GetServerTimeNow() % 1800
end

return (table.freeze(u32))