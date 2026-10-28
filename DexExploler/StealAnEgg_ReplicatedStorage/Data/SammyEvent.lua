-- Script path: ReplicatedStorage.Data.SammyEvent
-- Decompile time: 2.49 ms

local u0 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local EMPCoin = ReplicatedStorage.Assets.Models.EMPCoin
local u31 = ((Workspace:WaitForChild("World")):WaitForChild("Areas")):WaitForChild("GuardAreas")
local u32 = nil
u0.SpinSpeed = 2.4
u0.PickupRadius = EMPCoin.Size.Y / 2
u0.ChargeMax = 100
u0.PHASES = {{Id = "Wave1"}, {Id = "Wave2"}, {Id = "Wave3"}}

function u0.PickupTemplate() -- Line: 55 -- upvalues: EMPCoin (val)
    return EMPCoin
end

function u0.Zones() -- Line: 60 -- upvalues: u32 (ref), GuardAreaGeometry (val), u31 (val)
    local v1 = u32
    if v1 then
        return v1
    end
    v1 = GuardAreaGeometry.ReadAreaBounds(u31)
    table.sort(v1, function(a1, a2) -- Line: 66
        return a1.Bounds.Position.X < a2.Bounds.Position.X
    end)
    u32 = v1
    return v1
end

function u0.ZoneIndexAt(a1) -- Line: 74 -- upvalues: u0 (val), GuardAreaGeometry (val) -- types: a1: vector
    local v1
    local v2 = 1
    local v3 = (1 / 0)
    for i, j in (u0.Zones()) do
        if GuardAreaGeometry.IsWithinFootprint(j.Bounds, a1) then
            return i
        end
        v1 = math.abs(j.Bounds.Position.X - a1.X)
        if v1 < v3 then
            v2 = i
        end
    end
    return v2
end

function u0.EncodePickups(a1) -- Line: 91 -- types: a1: table
    local X, Y, Z, v1
    local v2 = buffer.create(#a1 * 12)
    local v3 = 0
    for i, j in a1 do
        X = j.X
        buffer.writef32(v2, v3, X)
        v1 = v3 + 4
        Y = j.Y
        buffer.writef32(v2, v1, Y)
        v1 = v3 + 8
        Z = j.Z
        buffer.writef32(v2, v1, Z)
        v3 = v3 + 12
    end
    return v2
end

function u0.DecodePickups(a1) -- Line: 103 -- types: a1: buffer
    local v1, v2, v3
    local v4 = {}
    for i = 1, buffer.len(a1) // 12 do
        v2 = (i - 1) * 12
        v3 = {X = buffer.readf32(a1, v2)}
        v1 = v2 + 4
        v3.Y = buffer.readf32(a1, v1)
        v1 = v2 + 8
        v3.Z = buffer.readf32(a1, v1)
        v4[i] = v3
    end
    return v4
end

return u0