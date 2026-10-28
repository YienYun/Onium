-- Script path: ReplicatedStorage.Packages.Observers.observeTagNoAncestry
-- Decompile time: 2.33 ms

local CollectionService = game:GetService("CollectionService")

function observeTagNoAncestry(a1, a2) -- Line: 5 -- upvalues: CollectionService (val) -- types: a1: string, a2: function
    local u2 = {}
    local u3 = nil

    local function OnInstanceAdded(a1_2) -- Line: 11
        -- upvalues: u3 (ref), a2 (val), a1 (val), u2 (val)
        if not u3.Connected then
            return
        end
        task.defer(function() -- Line: 17 -- upvalues: a2 (upval), a1_2 (val), a1 (upval), u2 (upval)
            local success, result = xpcall(function(a1) -- Line: 19 -- upvalues: a2 (upval) -- types: a1: userdata
                local v1 = a2(a1)
                local v2 = true
                if typeof(v1) ~= "nil" then
                    v2 = typeof(v1) == "function"
                end
                assert(v2, "callback must return a function")
                return v1
            end, debug.traceback, a1_2)
            if success then
                if type(result) == "function" then
                    if not a1_2:HasTag(a1) then
                        task.spawn(result)
                        return
                    end
                    u2[a1_2] = result
                end
                return
            end
            local v1 = ""
            local v2 = string.split(result, "\n")[1]
            local v3 = string.find(v2, ": ")
            if v3 then
                v1 = v2:sub(v3 + 1)
            end
            local v4 = a1
            warn((("error while calling observeTag(\"%*\") callback:%*\n%*"):format(v4, v1, result)))
        end)
    end

    u3 = (CollectionService:GetInstanceAddedSignal(a1)):Connect(OnInstanceAdded)
    local u26 = (CollectionService:GetInstanceRemovedSignal(a1)):Connect(function(a1) -- Line: 49 -- upvalues: u2 (val) -- types: a1: userdata
        local v1 = u2[a1]
        if typeof(v1) == "function" then
            task.spawn(v1)
        end
    end)
    task.defer(function() -- Line: 61 -- upvalues: u3 (ref), CollectionService (upval), a1 (val), OnInstanceAdded (val)
        if not u3.Connected then
            return
        end
        for i, j in CollectionService:GetTagged(a1) do
            task.spawn(OnInstanceAdded, j)
        end
    end)
    return function() -- Line: 72 -- upvalues: u3 (ref), u26 (ref), u2 (val)
        local v1
        u3:Disconnect()
        u26:Disconnect()
        local v2 = next(u2)
        while v2 do
            v1 = u2[v2]
            if typeof(v1) == "function" then
                task.spawn(v1)
            end
            next(u2)
        end
    end
end

return observeTagNoAncestry