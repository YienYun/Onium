-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Gradient
-- Decompile time: 9.49 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local StopRamp = require(script.Parent.StopRamp)
local t = require(ReplicatedStorage.Packages.t)
local Heartbeat = RunService.Heartbeat
local u25 = {TextLabel = true, TextBox = true, TextButton = true}
local u26 = {}
u26.__index = u26
u26.__class = "Gradient"
local u37 = t.strict(t.union(t.instanceIsA("GuiObject"), t.instanceIsA("UIStroke")))
local u40 = t.strict(t.number)
local u43 = t.strict(t.ColorSequence)
local u49 = t.strict(t.union(t.number, t.NumberSequence))

local function flatAlpha(a1) -- Line: 84 -- types: a1: number
    return NumberSequence.new({NumberSequenceKeypoint.new(0, a1), (NumberSequenceKeypoint.new(1, a1))})
end

local function settle(a1) -- Line: 91 -- types: a1: number
    return (math.clamp(a1, 0, 1))
end

local function newSweep(a1) -- Line: 95 -- types: a1: number
    return {now = 0, rate = 0, rateGoal = 0, response = a1}
end

local function holdAt(a1, a2, a3) -- Line: 99 -- types: a1: table, a2: number, a3: number
    a1.goal = a2
    a1.rate = 0
    a1.rateGoal = 0
    a1.response = math.clamp(a3, 0, 1)
end

local function driftAt(a1, a2, a3) -- Line: 106 -- types: a1: table, a2: number, a3: number
    a1.rateGoal = a2
    a1.goal = nil
    a1.response = math.clamp(a3, 0, 1)
end

local function step(a1, a2) -- Line: 112 -- types: a1: table, a2: number
    local goal = a1.goal
    if goal then
        a1.now = a1.now + (goal - a1.now) * a1.response
        return a1.now
    end
    a1.rate = a1.rate + (a1.rateGoal - a1.rate) * a1.response * a2
    a1.now = a1.now + a1.rate * a2
    return a1.now
end

local function borrowGradient(a1) -- Line: 124 -- types: a1: userdata
    local UIGradient = a1:FindFirstChildWhichIsA("UIGradient")
    if UIGradient then
        return UIGradient
    end
    return Instance.new("UIGradient")
end

local function release(a1) -- Line: 132
    a1.driver:Disconnect()
    if a1.gradient then
        a1.gradient:Destroy()
        a1.gradient = nil
    end
end

local function resolvePalette(a1) -- Line: 141 -- upvalues: StopRamp (val)
    local v1 = StopRamp.Drift(a1.palette.Keypoints, StopRamp.Colour, a1.phase.now, 5, 100)
    a1.paletteResolved = ColorSequence.new(v1)
    return a1.paletteResolved
end

local function resolveAlpha(a1) -- Line: 153 -- upvalues: StopRamp (val)
    local Keypoints = a1.alphaStopsGoal.Keypoints
    if #Keypoints == 2 and Keypoints[1].Value == Keypoints[2].Value then
        a1.alphaResolved = a1.alphaStopsGoal
        return a1.alphaStopsGoal
    end
    local Keypoints_2 = a1.alphaStops.Keypoints
    local v1 = StopRamp.Drift(Keypoints_2, StopRamp.Alpha, a1.alphaPhase.now, #Keypoints_2 + 1, (1 / 0))
    a1.alphaResolved = NumberSequence.new(v1)
    return a1.alphaResolved
end

local function advance(a1, a2) -- Line: 168 -- upvalues: StopRamp (val), resolveAlpha (val) -- types: a2: number
    if a1.paletteBlend ~= 1 then
        a1.palette = ColorSequence.new(StopRamp.Restripe(a1.paletteGoal.Keypoints, a1.palette.Keypoints, a1.paletteBlend, StopRamp.Colour))
    else
        a1.palette = a1.paletteGoal
    end
    if a1.alphaBlend == 1 then
        a1.alphaStops = a1.alphaStopsGoal
    end
    local gradient = a1.gradient
    local angle = a1.angle
    local goal = angle.goal
    if not goal then
        angle.rate = angle.rate + (angle.rateGoal - angle.rate) * angle.response * a2
        angle.now = angle.now + angle.rate * a2
    else
        angle.now = angle.now + (goal - angle.now) * angle.response
    end
    local now_2 = angle.now
    gradient.Rotation = now_2
    local phase = a1.phase
    local goal_2 = phase.goal
    if not goal_2 then
        phase.rate = phase.rate + (phase.rateGoal - phase.rate) * phase.response * a2
        phase.now = phase.now + phase.rate * a2
        local now_5 = phase.now
    else
        phase.now = phase.now + (goal_2 - phase.now) * phase.response
        local now_4 = phase.now
    end
    local alphaPhase = a1.alphaPhase
    local goal_3 = alphaPhase.goal
    if not goal_3 then
        alphaPhase.rate = alphaPhase.rate + (alphaPhase.rateGoal - alphaPhase.rate) * alphaPhase.response * a2
        alphaPhase.now = alphaPhase.now + alphaPhase.rate * a2
        local now_8 = alphaPhase.now
    else
        alphaPhase.now = alphaPhase.now + (goal_3 - alphaPhase.now) * alphaPhase.response
        local now_7 = alphaPhase.now
    end
    local v1 = StopRamp.Drift(a1.palette.Keypoints, StopRamp.Colour, a1.phase.now, 5, 100)
    a1.paletteResolved = ColorSequence.new(v1)
    gradient.Color = a1.paletteResolved
    gradient.Transparency = resolveAlpha(a1)
end

function u26.new(a1, a2, a3) -- Line: 194
    -- upvalues: u37 (val), u43 (val), u49 (val), flatAlpha (val), u25 (val), u26 (val), Heartbeat (val)
    -- upvalues: Constants (val), advance (val)
    u37(a1)
    u43(a2)
    u49(a3)
    assert(#a2.Keypoints <= 19, (("a wash accepts at most %* colour stops"):format(19)))
    if typeof(a3) == "NumberSequence" then
        assert(#a3.Keypoints <= 19, (("a wash accepts at most %* alpha stops"):format(19)))
    end
    local v1 = if typeof(a3) ~= "number" then a3 else flatAlpha(a3)
    local v2 = {
        isPaused = false,
        frameDebt = 0.05,
        paletteBlend = 1,
        alphaBlend = 1,
        host = a1,
    }
    local UIGradient = a1:FindFirstChildWhichIsA("UIGradient")
    v2.gradient = if not UIGradient then Instance.new("UIGradient") else UIGradient
    v2.isTextHost = u25[a1.ClassName] == true
    v2.palette = a2
    v2.paletteGoal = a2
    v2.alphaStops = v1
    v2.alphaStopsGoal = v1
    v2.phase = {now = 0, rate = 0, rateGoal = 0, response = 1}
    v2.alphaPhase = {now = 0, rate = 0, rateGoal = 0, response = 1}
    v2.angle = {now = 0, rate = 0, rateGoal = 0, response = 0}
    local u89 = setmetatable(v2, u26)
    u89.driver = Heartbeat:Connect(function(a1) -- Line: 244 -- upvalues: u89 (val), Constants (upval), advance (upval) -- types: a1: number
        local v1
        if u89.isPaused then
            return
        end
        if Constants.IS_MOBILE then
            v1 = u89
            v1.frameDebt = v1.frameDebt + a1
            if u89.frameDebt < 0.05 then
                return
            end
            a1 = u89.frameDebt
            u89.frameDebt = 0
        end
        debug.profilebegin("EasyVisuals/wash")
        if u89.host and u89.host.Parent ~= nil then
            advance(u89, a1)
            debug.profileend()
            return
        end
        v1 = u89
        v1.driver:Disconnect()
        if v1.gradient then
            v1.gradient:Destroy()
            v1.gradient = nil
        end
    end)
    u89.gradient.Parent = u89.host
    return u89
end

function u26:Destroy() -- Line: 277
    self.driver:Disconnect()
    if self.gradient then
        self.gradient:Destroy()
        self.gradient = nil
    end
end

function u26.Suspend(a1) -- Line: 279
    a1.isPaused = true
end

function u26.Wake(a1) -- Line: 281
    a1.isPaused = false
end

function u26.SetRotation(a1, a2, a3) -- Line: 283 -- upvalues: u40 (val) -- types: a2: number, a3: number?
    u40(a2)
    u40(a3)
    local angle = a1.angle
    angle.goal = a2
    angle.rate = 0
    angle.rateGoal = 0
    angle.response = math.clamp(a3, 0, 1)
end

function u26.Spin(a1, a2, a3) -- Line: 289 -- upvalues: u40 (val) -- types: a2: number, a3: number?
    u40(a2)
    u40(a3)
    local angle = a1.angle
    angle.rateGoal = a2
    angle.goal = nil
    angle.response = math.clamp(a3, 0, 1)
end

function u26.PhaseTo(a1, a2, a3) -- Line: 295 -- upvalues: u40 (val) -- types: a2: number, a3: number?
    u40(a2)
    u40(a3)
    local phase = a1.phase
    phase.goal = a2
    phase.rate = 0
    phase.rateGoal = 0
    phase.response = math.clamp(a3, 0, 1)
end

function u26.Drift(a1, a2, a3) -- Line: 301 -- upvalues: u40 (val) -- types: a2: number, a3: number?
    u40(a2)
    u40(a3)
    local phase = a1.phase
    phase.rateGoal = a2
    phase.goal = nil
    phase.response = math.clamp(a3, 0, 1)
end

function u26.AlphaPhaseTo(a1, a2, a3) -- Line: 307 -- upvalues: u40 (val) -- types: a2: number, a3: number
    u40(a2)
    u40(a3)
    local alphaPhase = a1.alphaPhase
    alphaPhase.goal = a2
    alphaPhase.rate = 0
    alphaPhase.rateGoal = 0
    alphaPhase.response = math.clamp(a3, 0, 1)
end

function u26.AlphaDrift(a1, a2, a3) -- Line: 313 -- upvalues: u40 (val) -- types: a2: number, a3: number
    u40(a2)
    u40(a3)
    local alphaPhase = a1.alphaPhase
    alphaPhase.rateGoal = a2
    alphaPhase.goal = nil
    alphaPhase.response = math.clamp(a3, 0, 1)
end

function u26.Recolor(a1, a2, a3) -- Line: 319 -- upvalues: u43 (val) -- types: a2: userdata, a3: number?
    u43(a2)
    a1.paletteBlend = a3 or 1
    a1.paletteGoal = a2
    return a1.paletteGoal
end

function u26.Refade(a1, a2, a3) -- Line: 334 -- upvalues: u40 (val), flatAlpha (val) -- types: a3: number
    assert(a2, "a wash needs alpha stops to fade toward")
    u40(a3)
    if typeof(a2) == "number" then
        a1.strandedAlphaGoal = flatAlpha(a2)
    elseif typeof(a2) ~= "NumberSequence" then
        warn("a wash was handed alpha stops that were neither a number nor a NumberSequence")
    else
        a1.strandedAlphaGoal = a2
    end
    a1.strandedAlphaResponse = math.clamp(a3, 0, 1)
end

return table.freeze(u26)