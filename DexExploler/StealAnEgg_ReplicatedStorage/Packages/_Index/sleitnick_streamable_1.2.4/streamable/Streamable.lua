-- Script path: ReplicatedStorage.Packages._Index.sleitnick_streamable@1.2.4.streamable.Streamable
-- Decompile time: 2.65 ms

local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)
local u12 = {}
u12.__index = u12

function u12.new(a1, a2) -- Line: 96
    -- upvalues: u12 (val), Trove (val), Signal (val)
    local u2 = {}
    setmetatable(u2, u12)
    u2._trove = Trove.new()
    u2._shown = u2._trove:Construct(Signal)
    u2._shownTrove = Trove.new()
    u2._trove:Add(u2._shownTrove)
    u2.Instance = a1:FindFirstChild(a2)

    local function OnInstanceSet() -- Line: 107 -- upvalues: u2 (val)
        local Instance = u2.Instance
        if typeof(Instance) == "Instance" then
            u2._shown:Fire(Instance, u2._shownTrove)
            u2._shownTrove:Connect(Instance:GetPropertyChangedSignal("Parent"), function() -- Line: 111 -- upvalues: Instance (val), u2 (upval)
                if not Instance.Parent then
                    u2._shownTrove:Clean()
                end
            end)
            u2._shownTrove:Add(function() -- Line: 116 -- upvalues: u2 (upval), Instance (val)
                if u2.Instance == Instance then
                    u2.Instance = nil
                end
            end)
        end
    end

    u2._trove:Connect(a1.ChildAdded, function(a1) -- Line: 124 -- upvalues: a2 (val), u2 (val), OnInstanceSet (val) -- types: a1: userdata
        if a1.Name == a2 and not u2.Instance then
            u2.Instance = a1
            OnInstanceSet()
        end
    end)
    if u2.Instance then
        OnInstanceSet()
    end
    return u2
end

function u12.primary(a1) -- Line: 146 -- upvalues: u12 (val), Trove (val), Signal (val) -- types: a1: userdata
    local u1 = {}
    setmetatable(u1, u12)
    u1._trove = Trove.new()
    u1._shown = u1._trove:Construct(Signal)
    u1._shownTrove = Trove.new()
    u1._trove:Add(u1._shownTrove)
    u1.Instance = a1.PrimaryPart
    u1._trove:Connect(a1:GetPropertyChangedSignal("PrimaryPart"), function() -- Line: 157 -- upvalues: a1 (val), u1 (val)
        local PrimaryPart = a1.PrimaryPart
        u1._shownTrove:Clean()
        u1.Instance = PrimaryPart
        if PrimaryPart then
            u1._shown:Fire(PrimaryPart, u1._shownTrove)
        end
    end)
    if u1.Instance then
        local PrimaryPart = a1.PrimaryPart
        u1._shownTrove:Clean()
        u1.Instance = PrimaryPart
        if PrimaryPart then
            u1._shown:Fire(PrimaryPart, u1._shownTrove)
        end
    end
    return u1
end

function u12.Observe(a1, a2) -- Line: 184
    if a1.Instance then
        task.spawn(a2, a1.Instance, a1._shownTrove)
    end
    return a1._shown:Connect(a2)
end

function u12:Destroy() -- Line: 196
    self._trove:Destroy()
end

return u12