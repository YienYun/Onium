-- Script path: ReplicatedStorage.Client.SpeedPowerProjection
-- Decompile time: 16.99 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Save = require(ReplicatedStorage.Shared.Save)
local Signal = require(ReplicatedStorage.Packages.Signal)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local t = require(ReplicatedStorage.Packages.t)
local u30 = t.strict(t.number)
local u31 = {}
u31.Changed = Signal.new()
local DEFAULT_BASE_SPEED_POWER = TreadmillUtil.DEFAULT_BASE_SPEED_POWER
local u35 = DEFAULT_BASE_SPEED_POWER
local u69 = nil
local u37 = false
local u71 = DEFAULT_BASE_SPEED_POWER
local u72 = 0

local function readSavedPower() -- Line: 31 -- upvalues: Save (val), TreadmillUtil (val)
    local v1 = Save.Await()
    return TreadmillUtil.NormalizeSpeedPower(if v1 ~= nil then v1.SpeedPower else nil)
end

local function readOverride(a1) -- Line: 37 -- upvalues: Workspace (val) -- types: a1: string
    local Attribute = Workspace:GetAttribute(a1)
    if type(Attribute) == "number" and Attribute > 0 then
        return Attribute
    end
    return nil
end

local function runTotal() -- Line: 42
    -- upvalues: u71 (ref), u72 (ref), u69 (ref), DEFAULT_BASE_SPEED_POWER (ref), u37 (ref)
    local v1 = u71 + u72
    if u69 == nil then
        return DEFAULT_BASE_SPEED_POWER
    end
    if u37 then
        return v1
    end
    return (math.max(DEFAULT_BASE_SPEED_POWER, v1))
end

local function computeShown() -- Line: 52
    -- upvalues: Workspace (val), u71 (ref), u72 (ref), u69 (ref), DEFAULT_BASE_SPEED_POWER (ref), u37 (ref)
    local Attribute = Workspace:GetAttribute("EqualisedSpeedPower")
    local v1 = if type(Attribute) ~= "number" then nil else if not (Attribute > 0) then nil else Attribute
    if v1 ~= nil then
        return v1
    end
    local v2 = u71 + u72
    v1 = if u69 == nil then DEFAULT_BASE_SPEED_POWER else if not u37 then math.max(DEFAULT_BASE_SPEED_POWER, v2) else v2
    local Attribute_2 = Workspace:GetAttribute("MinimumSpeedPower")
    if (if type(Attribute_2) ~= "number" then nil else if not (Attribute_2 > 0) then nil else Attribute_2) == nil then
        return v1
    end
    return (math.max(v1, v2))
end

local function republish() -- Line: 63
    -- upvalues: Workspace (val), u71 (ref), u72 (ref), u69 (ref), DEFAULT_BASE_SPEED_POWER (ref), u37 (ref), u35 (ref)
    -- upvalues: u31 (val)
    local v1
    local Attribute = Workspace:GetAttribute("EqualisedSpeedPower")
    local v2 = if type(Attribute) ~= "number" then nil else if not (Attribute > 0) then nil else Attribute
    if v2 == nil then
        local v3 = u71 + u72
        v2 = if u69 == nil then DEFAULT_BASE_SPEED_POWER else if not u37 then math.max(DEFAULT_BASE_SPEED_POWER, v3) else v3
        local Attribute_2 = Workspace:GetAttribute("MinimumSpeedPower")
        v3 = if type(Attribute_2) ~= "number" then nil else if not (Attribute_2 > 0) then nil else Attribute_2
        v1 = if v3 ~= nil then math.max(v2, v3) else v2
    else
        v1 = v2
    end
    if v1 ~= u35 then
        u31.Changed:Fire(v1)
    end
end

local function syncWithSave() -- Line: 71
    -- upvalues: DEFAULT_BASE_SPEED_POWER (ref), Save (val), TreadmillUtil (val), u37 (ref), u69 (ref), u71 (ref)
    -- upvalues: u72 (ref), Workspace (val), u35 (ref), u31 (val)
    local v1 = Save.Await()
    DEFAULT_BASE_SPEED_POWER = TreadmillUtil.NormalizeSpeedPower(if v1 ~= nil then v1.SpeedPower else nil)
    local v2 = not u37
    if v2 then
        v2 = false
        if u69 ~= nil then
            v1 = DEFAULT_BASE_SPEED_POWER
            v2 = u71 + u72 <= v1
        end
    end
    if v2 then
        u69 = nil
        u71 = DEFAULT_BASE_SPEED_POWER
        u72 = 0
    end
    local Attribute = Workspace:GetAttribute("EqualisedSpeedPower")
    v1 = if type(Attribute) ~= "number" then nil else if not (Attribute > 0) then nil else Attribute
    if v1 == nil then
        local v3 = u71 + u72
        v1 = if u69 == nil then DEFAULT_BASE_SPEED_POWER else if not u37 then math.max(DEFAULT_BASE_SPEED_POWER, v3) else v3
        local Attribute_2 = Workspace:GetAttribute("MinimumSpeedPower")
        v3 = if type(Attribute_2) ~= "number" then nil else if not (Attribute_2 > 0) then nil else Attribute_2
        v2 = if v3 ~= nil then math.max(v1, v3) else v1
    else
        v2 = v1
    end
    if v2 ~= u35 then
        u31.Changed:Fire(v2)
    end
end

function u31.ReadProjected() -- Line: 84 -- upvalues: u35 (ref)
    return u35
end

function u31.OpenSession(a1) -- Line: 86
    -- upvalues: u30 (val), DEFAULT_BASE_SPEED_POWER (ref), Save (val), TreadmillUtil (val), u37 (ref), u69 (ref)
    -- upvalues: u71 (ref), u35 (ref), u72 (ref), Workspace (val), u31 (val)
    local v1
    u30(a1)
    local v2 = Save.Await()
    DEFAULT_BASE_SPEED_POWER = TreadmillUtil.NormalizeSpeedPower(if v2 ~= nil then v2.SpeedPower else nil)
    u37 = true
    u71 = math.max(DEFAULT_BASE_SPEED_POWER, u35)
    u72 = 0
    local Attribute = Workspace:GetAttribute("EqualisedSpeedPower")
    v2 = if type(Attribute) ~= "number" then nil else if not (Attribute > 0) then nil else Attribute
    if v2 == nil then
        local v3 = u71 + u72
        v2 = if a1 == nil then DEFAULT_BASE_SPEED_POWER else if not u37 then math.max(DEFAULT_BASE_SPEED_POWER, v3) else v3
        local Attribute_2 = Workspace:GetAttribute("MinimumSpeedPower")
        v3 = if type(Attribute_2) ~= "number" then nil else if not (Attribute_2 > 0) then nil else Attribute_2
        v1 = if v3 ~= nil then math.max(v2, v3) else v2
    else
        v1 = v2
    end
    if v1 ~= u35 then
        u31.Changed:Fire(v1)
    end
end

function u31.CreditRevealedGain(a1, a2) -- Line: 97
    -- upvalues: u30 (val), u69 (ref), u72 (ref), Workspace (val), u71 (ref), DEFAULT_BASE_SPEED_POWER (ref), u37 (ref)
    -- upvalues: u35 (ref), u31 (val)
    u30(a1)
    u30(a2)
    local v1 = false
    if u69 == a1 then
        v1 = a2 > 0
    end
    if v1 then
        local v2
        u72 = u72 + a2
        local Attribute = Workspace:GetAttribute("EqualisedSpeedPower")
        local v3 = if type(Attribute) ~= "number" then nil else if not (Attribute > 0) then nil else Attribute
        if v3 == nil then
            local v4 = u71 + u72
            v3 = if u69 == nil then DEFAULT_BASE_SPEED_POWER else if not u37 then math.max(DEFAULT_BASE_SPEED_POWER, v4) else v4
            local Attribute_2 = Workspace:GetAttribute("MinimumSpeedPower")
            v4 = if type(Attribute_2) ~= "number" then nil else if not (Attribute_2 > 0) then nil else Attribute_2
            v2 = if v4 ~= nil then math.max(v3, v4) else v3
        else
            v2 = v3
        end
        if v2 ~= u35 then
            u31.Changed:Fire(v2)
        end
    end
    return v1
end

function u31.CloseSession(a1) -- Line: 110
    -- upvalues: u30 (val), u69 (ref), u37 (ref), DEFAULT_BASE_SPEED_POWER (ref), Save (val), TreadmillUtil (val)
    -- upvalues: u71 (ref), u72 (ref), Workspace (val), u35 (ref), u31 (val)
    u30(a1)
    if u69 == a1 then
        u37 = false
        local v1 = Save.Await()
        DEFAULT_BASE_SPEED_POWER = TreadmillUtil.NormalizeSpeedPower(if v1 ~= nil then v1.SpeedPower else nil)
        local v2 = not u37
        if v2 then
            v2 = false
            if u69 ~= nil then
                v1 = DEFAULT_BASE_SPEED_POWER
                v2 = u71 + u72 <= v1
            end
        end
        if v2 then
            u69 = nil
            u71 = DEFAULT_BASE_SPEED_POWER
            u72 = 0
        end
        local Attribute = Workspace:GetAttribute("EqualisedSpeedPower")
        v1 = if type(Attribute) ~= "number" then nil else if not (Attribute > 0) then nil else Attribute
        if v1 == nil then
            local v3 = u71 + u72
            v1 = if u69 == nil then DEFAULT_BASE_SPEED_POWER else if not u37 then math.max(DEFAULT_BASE_SPEED_POWER, v3) else v3
            local Attribute_2 = Workspace:GetAttribute("MinimumSpeedPower")
            v3 = if type(Attribute_2) ~= "number" then nil else if not (Attribute_2 > 0) then nil else Attribute_2
            v2 = if v3 ~= nil then math.max(v1, v3) else v1
        else
            v2 = v1
        end
        if v2 ~= u35 then
            u31.Changed:Fire(v2)
        end
    end
end

local v1 = Save.Await()
DEFAULT_BASE_SPEED_POWER = TreadmillUtil.NormalizeSpeedPower(if v1 ~= nil then v1.SpeedPower else nil)
v1 = not u37
if v1 then
    v1 = false
    if u69 ~= nil then
        v1 = u71 + u72 <= DEFAULT_BASE_SPEED_POWER
    end
end
if v1 then
    u69 = nil
    u71 = DEFAULT_BASE_SPEED_POWER
    u72 = 0
end
local Attribute = Workspace:GetAttribute("EqualisedSpeedPower")
local v2 = if type(Attribute) ~= "number" then nil else if not (Attribute > 0) then nil else Attribute
if v2 == nil then
    local v3 = u71 + u72
    v2 = if u69 == nil then DEFAULT_BASE_SPEED_POWER else if not u37 then math.max(DEFAULT_BASE_SPEED_POWER, v3) else v3
    local Attribute_2 = Workspace:GetAttribute("MinimumSpeedPower")
    v3 = if type(Attribute_2) ~= "number" then nil else if not (Attribute_2 > 0) then nil else Attribute_2
    v1 = if v3 ~= nil then math.max(v2, v3) else v2
else
    v1 = v2
end
if v1 ~= u35 then
    u31.Changed:Fire(v1)
end
Save.Watch("SpeedPower"):Connect(syncWithSave)
;(Workspace:GetAttributeChangedSignal("EqualisedSpeedPower")):Connect(republish)
;(Workspace:GetAttributeChangedSignal("MinimumSpeedPower")):Connect(republish)
return u31