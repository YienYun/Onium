-- Script path: ReplicatedStorage.Packages.Observers.observeCharacter
-- Decompile time: 1.24 ms

return function(a1, a2) -- Line: 18 -- types: a1: userdata, a2: function
    local u2 = nil
    local u3 = nil

    local function OnCharacterAdded(a1_2) -- Line: 23
        -- upvalues: a2 (val), a1 (val), u3 (ref), u2 (ref)
        local u1 = nil
        task.defer(function() -- Line: 27 -- upvalues: a2 (upval), a1 (upval), a1_2 (val), u3 (upval), u1 (ref), u2 (upval)
            local v1 = a2(a1, a1_2)
            if typeof(v1) == "function" then
                if u3.Connected and a1_2.Parent then
                    u1 = v1
                    u2 = v1
                    return
                end
                task.spawn(v1)
            end
        end)
        local u5 = nil
        a1_2.AncestryChanged:Connect(function(a1, a2) -- Line: 43 -- upvalues: u5 (ref), u1 (ref), u2 (upval)
            if a2 == nil and u5.Connected then
                u5:Disconnect()
                if u1 ~= nil then
                    task.spawn(u1)
                    if u2 == u1 then
                        u2 = nil
                    end
                    u1 = nil
                end
            end
        end)
    end

    u3 = a1.CharacterAdded:Connect(OnCharacterAdded)
    task.defer(function() -- Line: 61 -- upvalues: a1 (val), u3 (ref), OnCharacterAdded (val)
        if a1.Character and u3.Connected then
            task.spawn(OnCharacterAdded, a1.Character)
        end
    end)
    return function() -- Line: 68 -- upvalues: u3 (ref), u2 (ref)
        u3:Disconnect()
        if u2 ~= nil then
            task.spawn(u2)
            u2 = nil
        end
    end
end