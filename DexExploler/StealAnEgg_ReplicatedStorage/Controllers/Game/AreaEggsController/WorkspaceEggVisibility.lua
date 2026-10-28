-- Script path: ReplicatedStorage.Controllers.Game.AreaEggsController.WorkspaceEggVisibility
-- Decompile time: 1.83 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
local Signal = require(ReplicatedStorage.Packages.Signal)
local u18 = {}
local u19 = {}
u19.ModelAdded = Signal.new()

function u19.ApplyModelHidden(a1, a2) -- Line: 23 -- upvalues: t (val) -- types: a1: userdata, a2: boolean
    t.strict(t.instanceIsA("Model"))(a1)
    t.strict(t.boolean)(a2)
    for i, v in ipairs(a1:GetDescendants()) do
        if v:IsA("BasePart") then
            v.LocalTransparencyModifier = if not a2 then 0 else 1
        end
    end
end

function u19.ResolveModel(a1) -- Line: 34 -- upvalues: t (val), Workspace (val) -- types: a1: string
    t.strict(t.string)(a1)
    local v1 = Workspace:FindFirstChild(a1)
    if v1 == nil then
        return nil
    end
    assert(v1:IsA("Model"), (("Workspace area egg %* must be a Model"):format(a1)))
    return v1
end

function u19.SetHidden(a1, a2) -- Line: 44
    -- upvalues: t (val), u18 (val), Workspace (val), u19 (val)
    t.strict(t.string)(a1)
    t.strict(t.boolean)(a2)
    if not a2 then
        u18[a1] = nil
    else
        u18[a1] = true
    end
    for i, v in ipairs(Workspace:GetChildren()) do
        if v.Name == a1 and v:IsA("Model") then
            u19.ApplyModelHidden(v, a2)
        end
    end
end

function u19.Start() -- Line: 60 -- upvalues: Workspace (val), u18 (val), u19 (val)
    Workspace.ChildAdded:Connect(function(a1) -- Line: 61 -- upvalues: Workspace (upval), u18 (upval), u19 (upval) -- types: a1: userdata
        if a1:IsA("Model") and a1.Parent == Workspace then
            if u18[a1.Name] == true then
                u19.ApplyModelHidden(a1, true)
            end
            u19.ModelAdded:Fire(a1)
            return
        end
    end)
end

return table.freeze(u19)