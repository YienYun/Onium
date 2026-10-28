-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.GuardTutorialController.Steps.TreadmillIntro
-- Decompile time: 0.96 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Client.GuardTutorialPresentation)
require(script.Parent.Types.Interface)
local u19 = Color3.fromRGB(255, 255, 255)
return {
    StepId = "TreadmillIntro",
    IsSatisfied = function(a1) -- Line: 24
        return a1:HasFinishedTreadmillIntro()
    end,
    Bind = function(a1, a2) -- Line: 28 -- types: a2: function
        local u2 = false
        task.delay(7, function() -- Line: 30 -- upvalues: u2 (ref), a1 (val), a2 (val)
            if u2 then
                return
            end
            a1:MarkTreadmillIntroFinished()
            a2()
        end)
        return function() -- Line: 38 -- upvalues: u2 (ref)
            u2 = true
        end
    end,
    Present = function(a1, a2) -- Line: 41 -- upvalues: u19 (val)
        a1:AnnounceTyped("Use your treadmill to become faster!", u19)
        return function() -- Line: 47 -- upvalues: a1 (val)
            a1:DropEverything()
        end
    end,
}