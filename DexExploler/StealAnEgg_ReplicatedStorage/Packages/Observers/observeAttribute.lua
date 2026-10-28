-- Script path: ReplicatedStorage.Packages.Observers.observeAttribute
-- Decompile time: 1.29 ms

local function defaultGuard(a1) -- Line: 3
    return true
end

return function(a1, a2, a3, a4) -- Line: 44
    -- upvalues: defaultGuard (val)
    local u4 = nil
    local u5 = nil
    local u6 = 0
    local u8 = if a4 == nil then defaultGuard else a4

    local function OnAttributeChanged() -- Line: 57
        -- upvalues: u4 (ref), u6 (ref), a1 (val), a2 (val), u8 (val), a3 (val), u5 (ref)
        if u4 ~= nil then
            task.spawn(u4)
            u4 = nil
        end
        u6 = u6 + 1
        local u7 = u6
        local Attribute = a1:GetAttribute(a2)
        if Attribute ~= nil and u8(Attribute) then
            task.spawn(function() -- Line: 69 -- upvalues: a3 (upval), Attribute (val), u7 (val), u6 (upval), u5 (upval), u4 (upval)
                local v1 = a3(Attribute)
                if typeof(v1) == "function" then
                    if u7 == u6 and u5.Connected then
                        u4 = v1
                        return
                    end
                    task.spawn(v1)
                end
            end)
        end
    end

    u5 = (a1:GetAttributeChangedSignal(a2)):Connect(OnAttributeChanged)
    task.defer(function() -- Line: 86 -- upvalues: u5 (ref), OnAttributeChanged (val)
        if not u5.Connected then
            return
        end
        OnAttributeChanged()
    end)
    return function() -- Line: 95 -- upvalues: u5 (ref), u4 (ref)
        u5:Disconnect()
        if u4 ~= nil then
            task.spawn(u4)
            u4 = nil
        end
    end
end