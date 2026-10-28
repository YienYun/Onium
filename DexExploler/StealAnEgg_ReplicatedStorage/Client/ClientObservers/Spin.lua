-- Script path: ReplicatedStorage.Client.ClientObservers.Spin
-- Decompile time: 1.80 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ObserveUITag = require(ReplicatedStorage.Client.ObserveUITag)
require(ReplicatedStorage.Packages.Trove)
local u18 = {}
local u19 = nil

local function StepSpins(a1) -- Line: 22 -- upvalues: u18 (val) -- types: a1: number
    for i, j in u18 do
        i.Rotation = (i.Rotation + j * a1) % 360
    end
end

local function StartSpin(a1, a2) -- Line: 28
    -- upvalues: u18 (val), u19 (ref), RunService (val), StepSpins (val)
    local Attribute = a1:GetAttribute("SpinSpeed")
    u18[a1] = if type(Attribute) ~= "number" then 20 else Attribute
    if u19 == nil then
        u19 = RunService.RenderStepped:Connect(StepSpins)
    end
    a2:Add(function() -- Line: 36 -- upvalues: u18 (upval), a1 (val), u19 (upval)
        u18[a1] = nil
        if next(u18) == nil and u19 ~= nil then
            u19:Disconnect()
            u19 = nil
        end
    end)
end

ObserveUITag("Spin", function(a1, a2) -- Line: 45 -- upvalues: StartSpin (val) -- types: a1: userdata
    if a1:IsA("GuiObject") then
        StartSpin(a1, a2)
        return
    end
    warn((("Spin tag on %* needs a GuiObject"):format((a1:GetFullName()))))
end)
return nil