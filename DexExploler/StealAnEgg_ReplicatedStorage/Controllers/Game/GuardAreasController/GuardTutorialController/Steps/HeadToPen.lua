-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.GuardTutorialController.Steps.HeadToPen
-- Decompile time: 2.13 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Client.GuardTutorialPresentation)
require(script.Parent.Types.Interface)
local u24 = Color3.fromRGB(255, 255, 255)
local u25 = {StepId = "HeadToPen"}

function u25.IsSatisfied(a1) -- Line: 25
    return a1:HasReturnedToPen()
end

function u25.Bind(a1, a2) -- Line: 27 -- upvalues: u25 (val), RunService (val) -- types: a2: function
    local u2 = 0
    local u3 = false

    local function refresh() -- Line: 31 -- upvalues: u3 (ref), u25 (upval), a1 (val), a2 (val)
        if not u3 and u25.IsSatisfied(a1) then
            u3 = true
            a2()
            return
        end
    end

    local u9 = a1.Changed:Connect(refresh)
    local u15 = RunService.Heartbeat:Connect(function(a1_2) -- Line: 41 -- upvalues: u2 (ref), u3 (ref), u25 (upval), a1 (val), a2 (val) -- types: a1_2: number
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
    return function() -- Line: 52 -- upvalues: u9 (val), u15 (val)
        u9:Disconnect()
        u15:Disconnect()
    end
end

function u25.Present(a1, a2) -- Line: 58 -- upvalues: u25 (val), u24 (val)
    local function refreshPresentation() -- Line: 62 -- upvalues: u25 (upval), a2 (val), a1 (val), u24 (upval)
        if u25.IsSatisfied(a2) then
            a1:DropEverything()
            return
        end
        local PlotSpawnTarget = a2:GetPlotSpawnTarget()
        a1:AnnounceTyped("Go to your Pen!", u24)
        if PlotSpawnTarget ~= nil then
            a1:RetargetBeam(PlotSpawnTarget)
            return
        end
        a1:DropBeam()
    end

    local u7 = a2.Changed:Connect(refreshPresentation)
    refreshPresentation()
    return function() -- Line: 80 -- upvalues: u7 (val), a1 (val)
        u7:Disconnect()
        a1:DropEverything()
    end
end

return u25