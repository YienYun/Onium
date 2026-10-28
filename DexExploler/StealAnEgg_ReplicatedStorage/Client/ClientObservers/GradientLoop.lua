-- Script path: ReplicatedStorage.Client.ClientObservers.GradientLoop
-- Decompile time: 6.29 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ObserveUITag = require(ReplicatedStorage.Client.ObserveUITag)
require(ReplicatedStorage.Packages.Trove)
local u25 = if not UserInputService.TouchEnabled then 64 else 32
local u26 = {}
u26.Aqua = {
    Resolution = 19,
    Stops = {
        {Position = 0, Color = Color3.fromRGB(69, 212, 255)},
        {Position = 0.151986, Color = Color3.fromRGB(51, 255, 160)},
        {Position = 0.326425, Color = Color3.fromRGB(41, 173, 255)},
        {Position = 0.587219, Color = Color3.fromRGB(52, 255, 204)},
        {Position = 0.777202, Color = Color3.fromRGB(49, 255, 145)},
        {Position = 1, Color = Color3.fromRGB(51, 177, 255)},
    },
}
u26.Fire = {
    Resolution = 19,
    Stops = {
        {Position = 0, Color = Color3.fromRGB(255, 247, 15)},
        {Position = 0.151986, Color = Color3.fromRGB(255, 62, 23)},
        {Position = 0.326425, Color = Color3.fromRGB(255, 30, 34)},
        {Position = 0.587219, Color = Color3.fromRGB(255, 71, 34)},
        {Position = 0.777202, Color = Color3.fromRGB(255, 234, 0)},
        {Position = 1, Color = Color3.fromRGB(255, 238, 152)},
    },
}
u26.Gold = {
    Resolution = 13,
    PhaseSteps = 60,
    Stops = {
        {Position = 0, Color = Color3.fromRGB(255, 225, 0)},
        {Position = 0.14285714285714285, Color = Color3.fromRGB(255, 225, 0)},
        {Position = 0.2857142857142857, Color = Color3.fromRGB(255, 248, 39)},
        {Position = 0.42857142857142855, Color = Color3.fromRGB(255, 191, 0)},
        {Position = 0.5714285714285714, Color = Color3.fromRGB(255, 225, 0)},
        {Position = 0.7142857142857143, Color = Color3.fromRGB(255, 250, 115)},
        {Position = 0.8571428571428571, Color = Color3.fromRGB(255, 225, 0)},
        {Position = 1, Color = Color3.fromRGB(255, 225, 0)},
    },
}
u26.Halloween = {
    Resolution = 19,
    Stops = {
        {Position = 0, Color = Color3.fromRGB(255, 165, 20)},
        {Position = 0.151986, Color = Color3.fromRGB(82, 25, 138)},
        {Position = 0.326425, Color = Color3.fromRGB(182, 56, 255)},
        {Position = 0.587219, Color = Color3.fromRGB(255, 138, 20)},
        {Position = 0.777202, Color = Color3.fromRGB(255, 234, 0)},
        {Position = 1, Color = Color3.fromRGB(255, 238, 152)},
    },
}
u26.Rainbow = {
    Resolution = 19,
    Stops = {
        {Position = 0, Color = Color3.fromRGB(255, 0, 0)},
        {Position = 0.125, Color = Color3.fromRGB(255, 127, 0)},
        {Position = 0.25, Color = Color3.fromRGB(255, 255, 0)},
        {Position = 0.375, Color = Color3.fromRGB(0, 255, 0)},
        {Position = 0.5, Color = Color3.fromRGB(0, 255, 255)},
        {Position = 0.625, Color = Color3.fromRGB(17, 0, 255)},
        {Position = 0.75, Color = Color3.fromRGB(149, 0, 255)},
        {Position = 0.875, Color = Color3.fromRGB(255, 0, 255)},
        {Position = 1, Color = Color3.fromRGB(255, 0, 0)},
    },
}
u26.Sheen = {
    Resolution = 19,
    Stops = {
        {Position = 0, Color = Color3.fromRGB(255, 255, 255)},
        {Position = 0.272884, Color = Color3.fromRGB(255, 255, 255)},
        {Position = 0.502591, Color = Color3.fromRGB(135, 118, 255)},
        {Position = 0.547496, Color = Color3.fromRGB(137, 169, 252)},
        {Position = 0.73057, Color = Color3.fromRGB(246, 249, 255)},
        {Position = 1, Color = Color3.fromRGB(255, 255, 255)},
    },
}
local u285 = {}
local u286 = {}
local u287 = nil

local function SampleColor(a1, a2) -- Line: 105 -- types: a1: table, a2: number
    local v1, v2, v3
    local v4 = a2 % 1
    local v5 = #a1 - 1
    for i = 1, v5 do
        v1 = a1[i]
        v2 = a1[i + 1]
        if v4 <= v2.Position then
            v3 = v2.Position - v1.Position
            return v1.Color:Lerp(v2.Color, if not (v3 > 0) then 0 else (v4 - v1.Position) / v3)
        end
    end
    return a1[#a1].Color
end

local function BuildPhases(a1) -- Line: 119 -- upvalues: u25 (val), SampleColor (val) -- types: a1: table
    local v1, v2
    local PhaseSteps = a1.PhaseSteps or u25
    local Resolution = a1.Resolution
    local v3 = table.create(PhaseSteps)
    local v4 = table.create(Resolution + 1)
    local v5 = PhaseSteps - 1
    for i = 0, v5 do
        v2 = i / PhaseSteps
        for j = 0, Resolution do
            v1 = j / Resolution
            v4[j + 1] = (ColorSequenceKeypoint.new(v1, SampleColor(a1.Stops, v1 * 0.5 - v2)))
        end
        v3[i + 1] = (ColorSequence.new(v4))
    end
    return v3
end

local function GetPhases(a1) -- Line: 136 -- upvalues: u285 (val), u26 (val), BuildPhases (val) -- types: a1: string
    local v1 = u285[a1]
    if v1 ~= nil then
        return v1
    end
    v1 = u26[a1]
    if v1 == nil then
        return nil
    end
    local v2 = BuildPhases(v1)
    u285[a1] = v2
    return v2
end

local function StepGradients() -- Line: 150 -- upvalues: u286 (val)
    local Phases, v1
    local v2 = os.clock() % 2 / 2
    for i, j in u286 do
        Phases = j.Phases
        v1 = v2 * #Phases // 1 % #Phases + 1
        if v1 ~= j.LastIndex then
            j.LastIndex = v1
            i.Color = Phases[v1]
        end
    end
end

local function StartGradient(a1, a2) -- Line: 162
    -- upvalues: u285 (val), u26 (val), BuildPhases (val), u286 (val), u287 (ref), RunService (val), StepGradients (val)
    local v1
    local Attribute = a1:GetAttribute("Palette")
    if type(Attribute) ~= "string" then
        v1 = nil
    else
        local v2 = u285[Attribute]
        if v2 == nil then
            v2 = u26[Attribute]
            if v2 ~= nil then
                local v3 = BuildPhases(v2)
                u285[Attribute] = v3
                v1 = v3
            else
                v1 = nil
            end
        else
            v1 = v2
        end
    end
    if v1 == nil then
        warn((("%* needs a Palette attribute naming one of the GradientLoop palettes"):format((a1:GetFullName()))))
        return
    end
    u286[a1] = {LastIndex = 0, Phases = v1}
    if u287 == nil then
        u287 = RunService.Heartbeat:Connect(StepGradients)
    end
    a2:Add(function() -- Line: 173 -- upvalues: u286 (upval), a1 (val), u287 (upval)
        u286[a1] = nil
        if next(u286) == nil and u287 ~= nil then
            u287:Disconnect()
            u287 = nil
        end
    end)
end

ObserveUITag("GradientLoop", function(a1, a2) -- Line: 182 -- upvalues: StartGradient (val) -- types: a1: userdata
    if a1:IsA("UIGradient") then
        StartGradient(a1, a2)
        return
    end
    warn((("GradientLoop tag on %* needs a UIGradient"):format((a1:GetFullName()))))
end)
return nil