-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.GuardTutorialController.Steps.HatchEgg
-- Decompile time: 1.55 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Client.GuardTutorialPresentation)
require(script.Parent.Types.Interface)
local StepUtils = require(script.Parent.Parent.StepUtils)
local u31 = Color3.fromRGB(255, 255, 255)
local u32 = {StepId = "HatchEgg"}

function u32.IsSatisfied(a1) -- Line: 26
    return a1:HasHatchedEgg()
end

function u32.Bind(a1, a2) -- Line: 28 -- upvalues: StepUtils (val), u32 (val) -- types: a2: function
    return StepUtils.BindOnAdapterChanged(a1, u32.IsSatisfied, a2)
end

function u32.Present(a1, a2) -- Line: 32 -- upvalues: u32 (val), u31 (val), RunService (val)
    local function refreshPresentation() -- Line: 36 -- upvalues: u32 (upval), a2 (val), a1 (val), u31 (upval)
        if u32.IsSatisfied(a2) or not a2:HasHatchableEgg() then
            a1:DropEverything()
            return
        end
        a1:AnnounceTyped("Hatch the Egg!", u31)
        local NearestHatchableEggTarget = a2:GetNearestHatchableEggTarget()
        if NearestHatchableEggTarget ~= nil then
            a1:RetargetBeam(NearestHatchableEggTarget)
            return
        end
        a1:DropBeam()
    end

    local u7 = a2.Changed:Connect(refreshPresentation)
    local u8 = 0
    local u14 = RunService.Heartbeat:Connect(function(a1) -- Line: 58 -- upvalues: u8 (ref), refreshPresentation (val) -- types: a1: number
        u8 = u8 + a1
        if u8 < 0.25 then
            return
        end
        u8 = 0
        refreshPresentation()
    end)
    refreshPresentation()
    return function() -- Line: 69 -- upvalues: u7 (val), u14 (val), a1 (val)
        u7:Disconnect()
        u14:Disconnect()
        a1:DropEverything()
    end
end

return u32