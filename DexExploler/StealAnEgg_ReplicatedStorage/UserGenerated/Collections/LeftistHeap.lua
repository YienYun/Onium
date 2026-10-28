-- Script path: ReplicatedStorage.UserGenerated.Collections.LeftistHeap
-- Decompile time: 2.18 ms

function _merge1(a1, a2, a3) -- Line: 93 -- types: a1: function, a2: table, a3: table
    if not a2.Left then
        a2.Left = a3
        return a2
    end
    a2.Right = _merge(a1, a2.Right, a3)
    if a2.Left.Npl < a2.Right.Npl then
        local Right = a2.Right
        local Left = a2.Left
        a2.Left = Right
        a2.Right = Left
    end
    a2.Npl = a2.Right.Npl + 1
    return a2
end

function _merge(a1, a2, a3) -- Line: 112 -- types: a1: function, a2: table?, a3: table?
    if not a2 then
        return a3
    end
    if not a3 then
        return a2
    end
    if (a1(a2.Value, a3.Value)) < 0 then
        return _merge1(a1, a2, a3)
    end
    return _merge1(a1, a3, a2)
end

local v1 = {}
local u5 = table.freeze({__index = v1})

function v1.Merge(a1, a2) -- Line: 131
    if a1.Root ~= a2.Root then
        a1.Root = _merge(a1.Comparator, a1.Root, a2.Root)
        a2.Root = nil
    end
end

function v1.Insert(a1, a2) -- Line: 138
    a1.Root = _merge(a1.Comparator, {Npl = 0, Value = a2}, a1.Root)
end

function v1.Min(a1) -- Line: 145
    assert(a1.Root)
    return a1.Root.Value
end

function v1.TryMin(a1) -- Line: 150
    if a1.Root then
        return true, a1.Root.Value
    end
    return false, nil
end

function v1.Pop(a1) -- Line: 157
    assert(a1.Root)
    local Value = a1.Root.Value
    a1.Root = _merge(a1.Comparator, a1.Root.Left, a1.Root.Right)
    return Value
end

function v1.TryPop(a1) -- Line: 164
    if not a1.Root then
        return false, nil
    end
    local Value = a1.Root.Value
    a1.Root = _merge(a1.Comparator, a1.Root.Left, a1.Root.Right)
    return true, Value
end

function v1.PopFast(a1) -- Line: 173
    a1.Root = _merge(a1.Comparator, a1.Root.Left, a1.Root.Right)
end

function v1.Empty(a1) -- Line: 177
    return a1.Root == nil
end

function v1.Clear(a1) -- Line: 181
    a1.Root = nil
end

table.freeze(v1)
return table.freeze({
    Compare = function(a1, a2) -- Line: 190
        if a1 < a2 then
            return -1
        end
        if a2 < a1 then
            return 1
        end
        return 0
    end,
    new = function(a1, a2) -- Line: 200 -- upvalues: u5 (val) -- types: a1: function
        assert(type(a1) == "function")
        return (setmetatable({Comparator = a1}, u5))
    end,
})