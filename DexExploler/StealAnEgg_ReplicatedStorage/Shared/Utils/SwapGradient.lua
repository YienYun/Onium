-- Script path: ReplicatedStorage.Shared.Utils.SwapGradient
-- Decompile time: 1.11 ms

local u0 = {"Color", "Enabled", "Name", "Offset", "Rotation", "Transparency"}

local function gradientsUnder(a1) -- Line: 5 -- types: a1: userdata
    local v1 = {}
    for i, j in a1:GetChildren() do
        if j:IsA("UIGradient") then
            table.insert(v1, j)
        end
    end
    return v1
end

local function paint(a1, a2) -- Line: 15 -- upvalues: u0 (val) -- types: a1: userdata, a2: userdata
    for i, j in u0 do
        a1[j] = a2[j]
    end
    for k, n in a2:GetAttributes() do
        a1:SetAttribute(k, n)
    end
end

return function(a1, a2) -- Line: 28 -- upvalues: gradientsUnder (val), paint (val) -- types: a1: userdata, a2: userdata?
    local v1 = gradientsUnder(a1)
    if a2 == nil then
        for k, n in v1 do
            n:Destroy()
        end
        return nil
    end
    local v2 = table.remove(v1, 1)
    for i, j in v1 do
        j:Destroy()
    end
    if v2 ~= nil then
        paint(v2, a2)
        return v2
    end
    v2 = a2:Clone()
    v2.Parent = a1
    return v2
end