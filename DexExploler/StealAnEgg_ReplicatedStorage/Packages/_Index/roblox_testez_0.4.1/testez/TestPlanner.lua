-- Script path: ReplicatedStorage.Packages._Index.roblox_testez@0.4.1.testez.TestPlanner
-- Decompile time: 0.49 ms

local TestPlan = require(script.Parent.TestPlan)
return {
    createPlan = function(a1, a2, a3) -- Line: 26 -- upvalues: TestPlan (val)
        local v1 = TestPlan.new(a2, a3)
        table.sort(a1, function(a1, a2) -- Line: 29
            return a1.pathStringForSorting < a2.pathStringForSorting
        end)
        for i, v in ipairs(a1) do
            v1:addRoot(v.path, v.method)
        end
        return v1
    end,
}