-- Script path: ReplicatedStorage.Shared.Utils.PartBounds
-- Decompile time: 1.89 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local u12 = t.strict(t.table)

local function corner(a1, a2) -- Line: 17 -- types: a1: vector, a2: number
    return (Vector3.new(if a2 % 2 ~= 0 then a1.X else -a1.X, if a2 // 2 % 2 ~= 0 then a1.Y else -a1.Y, if a2 // 4 ~= 0 then a1.Z else -a1.Z))
end

return function(a1, a2) -- Line: 27 -- upvalues: u12 (val) -- types: a1: table, a2: userdata?
    local X, Y, Z, v1, v2, v3
    u12(a1)
    assert(#a1 > 0, "PartBounds needs at least one part")
    local identity = a2 or CFrame.identity
    local v4 = Vector3.new(1, 1, 1) * (1 / 0)
    local v5 = -v4
    local v6 = nil
    local v7 = nil
    for i, j in a1, v6, v7 do
        if j:IsA("BasePart") then
            v1 = identity:ToObjectSpace(j.CFrame)
            v2 = j.Size / 2
            for k = 0, 7 do
                X = if k % 2 ~= 0 then v2.X else -v2.X
                Y = if k // 2 % 2 ~= 0 then v2.Y else -v2.Y
                Z = if k // 4 ~= 0 then v2.Z else -v2.Z
                v3 = v1 * Vector3.new(X, Y, Z)
                v4 = v4:Min(v3)
                v5 = v5:Max(v3)
            end
        end
    end
    return identity * CFrame.new((v4 + v5) / 2), v5 - v4
end