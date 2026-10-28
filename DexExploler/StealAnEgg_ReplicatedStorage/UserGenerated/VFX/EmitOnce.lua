-- Script path: ReplicatedStorage.UserGenerated.VFX.EmitOnce
-- Decompile time: 1.51 ms

return function(a1) -- Line: 20 -- types: a1: userdata
    local TimeScale = a1.TimeScale
    if TimeScale <= 0 then
        return 0
    end
    local Rate = a1.Rate
    local Attribute = a1:GetAttribute("EmitCount")
    if type(Attribute) == "number" then
        Rate = Attribute
    end
    local u23 = math.floor(Rate)
    local v1 = Rate - u23
    if v1 > 0 and math.random() < v1 then
        u23 = u23 + 1
    end
    if u23 < 1 then
        return 0
    end
    v1 = 0
    local Attribute_2 = a1:GetAttribute("EmitDelay")
    if type(Attribute_2) == "number" then
        v1 = Attribute_2
    end
    if v1 == (1 / 0) then
        return 0
    end
    v1 = math.max(v1, 0)
    task.delay(v1, function() -- Line: 51 -- upvalues: a1 (val), u23 (ref)
        a1:Emit(u23)
    end)
    return v1 + a1.Lifetime.Max / TimeScale
end