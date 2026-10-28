-- Script path: ReplicatedStorage.Controllers.GUI.GuardAreas.RequiredSpeedSign
-- Decompile time: 2.48 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u18 = {}
u18.__index = u18
u18.__class = "RequiredSpeedSign"
local u24 = Color3.fromRGB(0, 255, 0)
local u29 = Color3.fromRGB(153, 255, 0)
local u34 = Color3.fromRGB(255, 170, 0)
local u39 = Color3.fromRGB(255, 0, 0)

function u18.new(a1) -- Line: 44 -- upvalues: t (val), u18 (val), Trove (val) -- types: a1: userdata
    t.strict(t.instanceIsA("Model"))(a1)
    local u13 = setmetatable({}, u18)
    u13._areaModel = a1
    u13._color = Color3.new(1, 1, 1)
    u13._text = "Loading..."
    u13._trove = Trove.new()
    u13._trove:Add((a1.DescendantAdded:Connect(function() -- Line: 53 -- upvalues: u13 (val)
        u13:_render()
    end)))
    u13:_render()
    return u13
end

function u18:_render() -- Line: 65
    local RequiredSpeedSign = self._areaModel:FindFirstChild("RequiredSpeedSign")
    local Main = if not RequiredSpeedSign then nil else RequiredSpeedSign:FindFirstChild("Main")
    local v1 = if not Main then nil else Main:FindFirstChild("SurfaceGui")
    local Info = if not v1 then nil else v1:FindFirstChild("Info")
    local Required = if not v1 then nil else v1:FindFirstChild("Required")
    v1 = if not Required then nil else Required:FindFirstChild("Speed")
    if Info and Info:IsA("TextLabel") then
        Info.TextColor3 = self._color
    end
    if v1 and v1:IsA("TextLabel") then
        v1.Text = self._text
        v1.TextColor3 = self._color
    end
end

function u18.SetLoading(a1) -- Line: 83
    a1._text = "Loading..."
    a1._color = Color3.new(1, 1, 1)
    a1:_render()
end

function u18.SetSlowdownTolerance(a1, a2) -- Line: 89
    -- upvalues: t (val), u39 (val), u34 (val), u29 (val), u24 (val)
    t.strict(t.number)(a2)
    a1._color = if a2 < 0.03 then u39 else if a2 < 0.1 then u34:Lerp(u29, (a2 - 0.03) / 0.07) else if not (a2 < 0.4) then u24 else u29:Lerp(u24, (a2 - 0.1) / 0.30000000000000004)
    a1:_render()
end

function u18.SetSpeedPowerRequirement(a1, a2) -- Line: 119
    -- upvalues: t (val), TreadmillUtil (val)
    t.strict(t.number)(a2)
    if a2 > 0 then
        local v1 = 10 ^ (math.floor((math.log10(a2))) - 1)
        a2 = math.round(a2 / v1) * v1
    end
    a1._text = TreadmillUtil.FormatSpeedPower(a2)
    a1:_render()
end

function u18:Destroy() -- Line: 132
    self._trove:Destroy()
end

return u18