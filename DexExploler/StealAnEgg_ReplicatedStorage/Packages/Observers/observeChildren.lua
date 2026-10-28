-- Script path: ReplicatedStorage.Packages.Observers.observeChildren
-- Decompile time: 1.12 ms

function observeChildren(a1, a2) -- Line: 4 -- types: a1: userdata, a2: function
    local u2 = {}
    local u3 = nil

    local function OnInstanceAdded(a1) -- Line: 19 -- upvalues: u3 (ref), u2 (val), a2 (val) -- types: a1: userdata
        if u3.Connected and not u2[a1] then
            u2[a1] = true
            u2[a1] = (a2(a1))
            return
        end
    end

    u3 = a1.ChildAdded:Connect(OnInstanceAdded)
    local u18 = a1.ChildRemoved:Connect(function(a1) -- Line: 10 -- upvalues: u2 (val) -- types: a1: userdata
        local v1 = u2[a1]
        u2[a1] = nil
        if typeof(v1) == "function" then
            task.spawn(v1)
        end
    end)
    task.defer(function() -- Line: 34 -- upvalues: u3 (ref), a1 (val), OnInstanceAdded (val)
        if not u3.Connected then
            return
        end
        for i, j in a1:GetChildren() do
            task.spawn(OnInstanceAdded, j)
        end
    end)
    return function() -- Line: 45 -- upvalues: u3 (ref), u18 (ref), u2 (val)
        local v1
        u3:Disconnect()
        u18:Disconnect()
        local v2 = next(u2)
        while v2 do
            v1 = u2[v2]
            u2[v2] = nil
            if typeof(v1) == "function" then
                task.spawn(v1)
            end
            next(u2)
        end
    end
end

return observeChildren