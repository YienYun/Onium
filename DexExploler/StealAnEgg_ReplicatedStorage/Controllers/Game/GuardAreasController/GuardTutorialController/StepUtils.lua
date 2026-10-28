-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.GuardTutorialController.StepUtils
-- Decompile time: 0.58 ms

require(script.Parent.Types.Interface)
return {
    BindOnAdapterChanged = function(a1, a2, a3) -- Line: 16 -- types: a2: function, a3: function
        local u7 = a1.Changed:Connect(function() -- Line: 21 -- upvalues: a2 (val), a1 (val), a3 (val)
            if a2(a1) then
                a3()
            end
        end)
        task.defer(function() -- Line: 27 -- upvalues: a2 (val), a1 (val), a3 (val)
            if a2(a1) then
                a3()
            end
        end)
        return function() -- Line: 33 -- upvalues: u7 (val)
            u7:Disconnect()
        end
    end,
}