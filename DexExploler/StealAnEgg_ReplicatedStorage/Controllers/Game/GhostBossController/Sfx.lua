-- Script path: ReplicatedStorage.Controllers.Game.GhostBossController.Sfx
-- Decompile time: 8.81 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local GhostBoss = require(ReplicatedStorage.Shared.Util.GhostBoss)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Attributes = GhostBoss.Attributes
local Phases = GhostBoss.Phases
local u20 = {"Moan1", "Moan2", "Moan3"}
local u24 = {"Hurt1", "Hurt2", "Hurt3"}
local u29 = Random.new()
local u30 = {}
u30.__index = u30

local function template(a1) -- Line: 61 -- upvalues: ReplicatedStorage (val), GhostBoss (val) -- types: a1: string
    local v1 = ReplicatedStorage:FindFirstChild(GhostBoss.AssetsName)
    local Sounds = if not v1 then nil else v1:FindFirstChild("Sounds")
    v1 = if not Sounds then nil else Sounds:FindFirstChild(a1)
    if v1 and v1:IsA("Sound") then
        return v1
    end
    return nil
end

local function play(a1, a2, a3) -- Line: 68
    -- upvalues: ReplicatedStorage (val), GhostBoss (val), Audio (val)
    local v1
    local v2 = ReplicatedStorage:FindFirstChild(GhostBoss.AssetsName)
    local Sounds = if not v2 then nil else v2:FindFirstChild("Sounds")
    v2 = if not Sounds then nil else Sounds:FindFirstChild(a1)
    if (if not v2 then nil else if not v2:IsA("Sound") then nil else v2) == nil then
        return nil
    end
    return Audio.Play(v1, a2, {SoundGroup = "Gameplay", Looped = a3, MaxDistance = v1.RollOffMaxDistance})
end

local function fadeOut(a1, a2) -- Line: 80 -- upvalues: Audio (val) -- types: a1: userdata?, a2: number
    if a1 ~= nil and a1.Parent ~= nil then
        (Audio.FadeTo(a1, {Volume = 0, Seconds = a2})).Completed:Once(function() -- Line: 84 -- upvalues: a1 (val)
            a1:Destroy()
        end)
        return
    end
end

local function pick(a1, a2) -- Line: 89 -- upvalues: u29 (val) -- types: a1: table, a2: string?
    local v1 = a1[u29:NextInteger(1, #a1)]
    if v1 == a2 and #a1 > 1 then
        v1 = a1[table.find(a1, v1) % #a1 + 1]
    end
    return v1
end

local function numberAttribute(a1, a2, a3) -- Line: 98 -- types: a1: userdata, a2: string, a3: number
    local Attribute = a1:GetAttribute(a2)
    if type(Attribute) == "number" then
        return Attribute
    end
    return a3
end

local function moanDelay() -- Line: 103 -- upvalues: u29 (val)
    return u29:NextNumber(7, 12)
end

function u30.Swing(a1) -- Line: 111 -- upvalues: play (val)
    return play("Swing", a1)
end

function u30.Charge(a1) -- Line: 115 -- upvalues: play (val)
    return play("Charge", a1)
end

function u30.new(a1, a2, a3) -- Line: 119
    -- upvalues: Trove (val), Attributes (val), u29 (val), u30 (val), Phases (val), ReplicatedStorage (val)
    -- upvalues: GhostBoss (val), Audio (val)
    local v1 = Trove.new()
    local v2 = {
        Struggling = false,
        StruggleAt = (-1 / 0),
        VoiceAt = (-1 / 0),
        Destroyed = false,
        State = a1,
        Trove = v1,
        Emitter = a2,
        Phase = a3,
    }
    local Attribute = a1:GetAttribute(Attributes.Health)
    v2.CryHealth = if type(Attribute) ~= "number" then 0 else Attribute
    local Attribute_2 = a1:GetAttribute(Attributes.AttackSerial)
    v2.AttackSerial = if type(Attribute_2) ~= "number" then 0 else Attribute_2
    v2.AttackPhase = a1:GetAttribute(Attributes.AttackPhase)
    v2.NextMoanAt = os.clock() + u29:NextNumber(7, 12)
    local u52 = setmetatable(v2, u30)
    v1:Connect(a2.Destroying, function() -- Line: 141 -- upvalues: u52 (val)
        u52:Destroy()
    end)
    if a3 == Phases.Spawning or a3 == Phases.Alive then
        local v3 = ReplicatedStorage:FindFirstChild(GhostBoss.AssetsName)
        local Sounds = if not v3 then nil else v3:FindFirstChild("Sounds")
        v3 = if not Sounds then nil else Sounds:FindFirstChild("Ambience")
        local v4 = if not v3 then nil else if not v3:IsA("Sound") then nil else v3
        v2 = if v4 ~= nil then Audio.Play(v4, a2, {Looped = true, SoundGroup = "Gameplay", MaxDistance = v4.RollOffMaxDistance}) else nil
        if v2 then
            local Volume = v2.Volume
            v2.Volume = 0
            Audio.FadeTo(v2, {Seconds = 2.5, Volume = Volume})
            v1:Add(v2)
            u52.Ambience = v2
        end
    end
    return u52
end

function u30:Voice(a2) -- Line: 159
    -- upvalues: fadeOut (val), ReplicatedStorage (val), GhostBoss (val), Audio (val)
    fadeOut(self.Voiced, 0.25)
    self.VoiceAt = os.clock()
    local Emitter = self.Emitter
    local v1 = ReplicatedStorage:FindFirstChild(GhostBoss.AssetsName)
    local Sounds = if not v1 then nil else v1:FindFirstChild("Sounds")
    v1 = if not Sounds then nil else Sounds:FindFirstChild(a2)
    local v2 = if not v1 then nil else if not v1:IsA("Sound") then nil else v1
    self.Voiced = if v2 ~= nil then Audio.Play(v2, Emitter, {SoundGroup = "Gameplay", MaxDistance = v2.RollOffMaxDistance}) else nil
end

function u30.Spawn(a1) -- Line: 165 -- upvalues: u29 (val)
    a1:Voice("Spawn")
    a1.NextMoanAt = os.clock() + u29:NextNumber(7, 12)
end

function u30:Hush(a2) -- Line: 170 -- upvalues: fadeOut (val) -- types: a2: number
    fadeOut(self.Ambience, a2)
    fadeOut(self.Voiced, a2)
    self.Ambience = nil
    self.Voiced = nil
end

function u30.Step(a1, a2) -- Line: 177
    -- upvalues: Phases (val), Attributes (val), u30 (val), GhostBoss (val), u24 (val), u29 (val), u20 (val)
    local v1
    if a1.Destroyed then
        return
    end
    if a2 ~= a1.Phase then
        a1.Phase = a2
        if a2 == Phases.Capturing or a2 == Phases.Defeated then
            a1:Hush(0.8)
        elseif a2 == Phases.Escaped then
            a1:Hush(1.6)
        end
    end
    if a2 ~= Phases.Alive then
        return
    end
    local State = a1.State
    local v2 = os.clock()
    local AttackSerial = Attributes.AttackSerial
    local AttackSerial_2 = a1.AttackSerial
    local Attribute = State:GetAttribute(AttackSerial)
    local v3 = if type(Attribute) ~= "number" then AttackSerial_2 else Attribute
    if a1.AttackSerial < v3 then
        a1.AttackSerial = v3
        u30.Swing(a1.Emitter)
    end
    local Attribute_2 = State:GetAttribute(Attributes.AttackPhase)
    if Attribute_2 ~= a1.AttackPhase then
        a1.AttackPhase = Attribute_2
        if Attribute_2 == GhostBoss.AttackPhases.Windup then
            u30.Charge(a1.Emitter)
        end
    end
    local Attribute_3 = State:GetAttribute(Attributes.Suckers)
    local v4 = false
    if type(Attribute_3) == "string" then
        v4 = Attribute_3 ~= ""
    end
    if v4 and not a1.Struggling and 6 <= v2 - a1.StruggleAt then
        a1.StruggleAt = v2
        a1:Voice("Struggle")
    end
    a1.Struggling = v4
    local Attribute_4 = State:GetAttribute(Attributes.MaxHealth)
    v3 = math.max(if type(Attribute_4) ~= "number" then 1 else Attribute_4, 1)
    local Attribute_5 = State:GetAttribute(Attributes.Health)
    local v5 = if type(Attribute_5) ~= "number" then v3 else Attribute_5
    if not (a1.CryHealth < v5) then
        v1 = (a1.CryHealth - v5) / v3
        if v1 >= 0.12 then
            v1 = v2 - a1.VoiceAt
            if v1 >= 2.5 then
                a1.CryHealth = v5
                v1 = u24
                local LastHurt = a1.LastHurt
                local v6 = v1[u29:NextInteger(1, #v1)]
                if v6 == LastHurt and #v1 > 1 then
                    v6 = v1[table.find(v1, v6) % #v1 + 1]
                end
                a1.LastHurt = v6
                a1:Voice(v6)
            end
        end
    else
        a1.CryHealth = v5
    end
    local Voiced = a1.Voiced
    v3 = true
    if Voiced ~= nil then
        v3 = true
        if Voiced.Parent ~= nil then
            v3 = not Voiced.IsPlaying
        end
    end
    if not v4 and v3 and a1.NextMoanAt <= v2 then
        v1 = u20
        local LastMoan = a1.LastMoan
        v5 = v1[u29:NextInteger(1, #v1)]
        if v5 == LastMoan and #v1 > 1 then
            v5 = v1[table.find(v1, v5) % #v1 + 1]
        end
        a1.LastMoan = v5
        a1.NextMoanAt = v2 + u29:NextNumber(7, 12)
        a1:Voice(v5)
    end
end

function u30:Destroy() -- Line: 240
    if self.Destroyed then
        return
    end
    self.Destroyed = true
    local Voiced = self.Voiced
    self.Voiced = nil
    self.Ambience = nil
    if Voiced then
        Voiced:Destroy()
    end
    self.Trove:Destroy()
end

return u30