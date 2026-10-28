-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.GuardTutorialController.Steps.StealEgg
-- Decompile time: 2.75 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Client.GuardTutorialPresentation)
require(script.Parent.Types.Interface)
local u24 = Color3.fromRGB(255, 255, 255)
local u25 = {StepId = "StealEgg"}

function u25.IsSatisfied(a1) -- Line: 25
    return a1:HasStolenFirstEgg() and not a1:IsLocalPlayerInGameplay()
end

function u25.Bind(a1, a2) -- Line: 29 -- upvalues: u25 (val), RunService (val) -- types: a2: function
    local u2 = 0
    local u3 = false

    local function refresh() -- Line: 33 -- upvalues: u3 (ref), u25 (upval), a1 (val), a2 (val)
        if not u3 and u25.IsSatisfied(a1) then
            u3 = true
            a2()
            return
        end
    end

    local u9 = a1.Changed:Connect(refresh)
    local u15 = RunService.Heartbeat:Connect(function(a1_2) -- Line: 43 -- upvalues: u2 (ref), u3 (ref), u25 (upval), a1 (val), a2 (val) -- types: a1_2: number
        u2 = u2 + a1_2
        if u2 < 0.1 then
            return
        end
        u2 = 0
        if not u3 then
            if not u25.IsSatisfied(a1) then
                return
            end
            u3 = true
            a2()
        end
    end)
    task.defer(refresh)
    return function() -- Line: 54 -- upvalues: u9 (val), u15 (val)
        u9:Disconnect()
        u15:Disconnect()
    end
end

function u25.Present(a1, a2) -- Line: 60 -- upvalues: u25 (val), u24 (val), RunService (val)
    local function refreshPresentation() -- Line: 64 -- upvalues: u25 (upval), a2 (val), a1 (val), u24 (upval)
        if u25.IsSatisfied(a2) then
            a1:DropEverything()
            return
        end
        if not a2:IsCarryingAreaEgg() and not a2:HasStolenFirstEgg() then
            local ClosestAreaEggTarget = a2:GetClosestAreaEggTarget()
            if ClosestAreaEggTarget == nil then
                a1:DropBeam()
                a1:AnnounceTyped("Steal an Egg!", u24)
                return
            end
            a1:AnnounceTyped("Steal an Egg!", u24)
            a1:RetargetBeam(ClosestAreaEggTarget)
            return
        end
        a1:DropAnnounce()
        a1:RetargetBeam((a2:GetGameplayExitTarget()))
    end

    local function refreshMovingExitTarget() -- Line: 87 -- upvalues: u25 (upval), a2 (val), a1 (val)
        if u25.IsSatisfied(a2) then
            a1:DropEverything()
            return
        end
        if not a2:IsCarryingAreaEgg() and not a2:HasStolenFirstEgg() then
            return
        end
        a1:DropAnnounce()
        a1:RetargetBeam((a2:GetGameplayExitTarget()))
    end

    local u8 = a2.Changed:Connect(refreshPresentation)
    local u9 = 0
    local u15 = RunService.Heartbeat:Connect(function(a1) -- Line: 103 -- upvalues: u9 (ref), refreshMovingExitTarget (val) -- types: a1: number
        u9 = u9 + a1
        if u9 < 0.1 then
            return
        end
        u9 = 0
        refreshMovingExitTarget()
    end)
    refreshPresentation()
    return function() -- Line: 114 -- upvalues: u8 (val), u15 (val), a1 (val)
        u8:Disconnect()
        u15:Disconnect()
        a1:DropEverything()
    end
end

return u25