-- Script path: ReplicatedStorage.Client.UI.ModelHover
-- Decompile time: 1.44 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollisionGroups = require(ReplicatedStorage.Shared.Types.CollisionGroups)
local t = require(ReplicatedStorage.Packages.t)
local u17 = t.strict(t.table)
local u20 = t.strict(t.Vector2)
local u23 = t.strict(t.number)
local u26 = t.strict(t.string)
local u31 = t.strict(t.instanceIsA("Model"))
local u34 = RaycastParams.new()
u34.CollisionGroup = CollisionGroups.PLAYER_COLLISION_GROUP
u34.IgnoreWater = true
return {
    KeyUnderCursor = function(a1, a2, a3) -- Line: 20
        -- upvalues: u17 (val), u20 (val), u23 (val), u34 (val), u26 (val), u31 (val)
        u17(a1)
        u20(a2)
        u23(a3)
        assert(a3 > 0, "a hover probe with no reach can never touch anything")
        local CurrentCamera = workspace.CurrentCamera
        local v1 = CurrentCamera and CurrentCamera:ViewportPointToRay(a2.X, a2.Y)
        local v2 = v1 and workspace:Raycast(v1.Origin, v1.Direction * a3, u34)
        if not v2 then
            return nil
        end
        for k, v in pairs(a1) do
            u26(k)
            u31(v)
            if v.Parent and v2.Instance:IsDescendantOf(v) then
                return k
            end
        end
        return nil
    end,
}