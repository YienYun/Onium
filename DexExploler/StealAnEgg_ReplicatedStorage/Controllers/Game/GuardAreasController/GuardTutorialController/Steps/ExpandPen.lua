-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.GuardTutorialController.Steps.ExpandPen
-- Decompile time: 3.57 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Client.GuardTutorialPresentation)
require(script.Parent.Types.Interface)
local SurfaceButtons = require(ReplicatedStorage.Client.UI.SurfaceButtons)
local u30 = Color3.fromRGB(255, 255, 255)
local u31 = {StepId = "ExpandPen"}

local function shouldPresent(a1) -- Line: 31
    return a1:CanAffordFirstBaseExpansion() and not a1:IsLocalPlayerInGameplay()
end

function u31.IsSatisfied(a1) -- Line: 39
    return a1:HasFinishedFirstBaseExpansion()
end

function u31.Bind(a1, a2) -- Line: 43 -- upvalues: u31 (val), RunService (val) -- types: a2: function
    local u2 = 0
    local u3 = false

    local function refresh() -- Line: 47 -- upvalues: u3 (ref), u31 (upval), a1 (val), a2 (val)
        if not u3 and u31.IsSatisfied(a1) then
            u3 = true
            a2()
            return
        end
    end

    local u9 = a1.Changed:Connect(refresh)
    local u15 = RunService.Heartbeat:Connect(function(a1_2) -- Line: 56 -- upvalues: u2 (ref), u3 (ref), u31 (upval), a1 (val), a2 (val) -- types: a1_2: number
        u2 = u2 + a1_2
        if u2 >= 0.1 then
            u2 = 0
            if not u3 then
                if not u31.IsSatisfied(a1) then
                    return
                end
                u3 = true
                a2()
            end
        end
    end)
    task.defer(refresh)
    return function() -- Line: 65 -- upvalues: u9 (val), u15 (val)
        u9:Disconnect()
        u15:Disconnect()
    end
end

function u31.Present(a1, a2) -- Line: 71 -- upvalues: u31 (val), SurfaceButtons (val), u30 (val), RunService (val)
    local u2 = 0
    local u3 = false
    local u4 = false
    local u5 = nil

    local function clear() -- Line: 80 -- upvalues: u3 (ref), u4 (ref), u5 (ref), a1 (val)
        if not u3 then
            return
        end
        u3 = false
        u4 = false
        u5 = nil
        a1:DropEverything()
    end

    local function refresh() -- Line: 90
        -- upvalues: u31 (upval), a2 (val), u3 (ref), u4 (ref), u5 (ref), a1 (val), SurfaceButtons (upval), u30 (upval)
        if not u31.IsSatisfied(a2) then
            local v1 = a2
            if v1:CanAffordFirstBaseExpansion() and not v1:IsLocalPlayerInGameplay() then
                local PlotUpgradeSignTarget = a2:GetPlotUpgradeSignTarget()
                if PlotUpgradeSignTarget == nil then
                    if not u3 then
                        return
                    end
                    u3 = false
                    u4 = false
                    u5 = nil
                    a1:DropEverything()
                    return
                end
                if u3 and u5 == PlotUpgradeSignTarget then
                    if not u4 then
                        v1 = SurfaceButtons.Find(PlotUpgradeSignTarget, "FirstUpgrade")
                        if v1 ~= nil then
                            a1:MarkTapTarget(v1, true)
                            u4 = true
                        end
                    end
                    return
                end
                u3 = true
                u5 = PlotUpgradeSignTarget
                a1:AnnounceTyped("Upgrade your Pen!", u30)
                a1:PointBeamAt(PlotUpgradeSignTarget.Position + Vector3.new(0, -1, 0))
                v1 = SurfaceButtons.Find(PlotUpgradeSignTarget, "FirstUpgrade")
                if v1 ~= nil then
                    a1:MarkTapTarget(v1, true)
                    u4 = true
                end
                return
            end
        end
        if not u3 then
            return
        end
        u3 = false
        u4 = false
        u5 = nil
        a1:DropEverything()
    end

    local u12 = a2.Changed:Connect(refresh)
    local u18 = RunService.Heartbeat:Connect(function(a1) -- Line: 124 -- upvalues: u2 (ref), refresh (val) -- types: a1: number
        u2 = u2 + a1
        if u2 >= 0.1 then
            u2 = 0
            refresh()
        end
    end)
    refresh()
    return function() -- Line: 133 -- upvalues: u12 (val), u18 (val), u3 (ref), u4 (ref), u5 (ref), a1 (val)
        u12:Disconnect()
        u18:Disconnect()
        if not u3 then
            return
        end
        u3 = false
        u4 = false
        u5 = nil
        a1:DropEverything()
    end
end

return u31