-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.HeadSwap
-- Decompile time: 7.19 ms

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Kit = require(script.Parent.Kit)
local Vfx = require(script.Parent.Vfx)

local function headParts(a1) -- Line: 28 -- types: a1: userdata
    local v1 = {}
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") and j:GetAttribute("Head") == true then
            table.insert(v1, j)
        end
    end
    return v1
end

local function largest(a1) -- Line: 38 -- types: a1: table
    local v1
    local v2 = nil
    local v3 = -1
    for i, j in a1 do
        v1 = j.Size.X * j.Size.Y * j.Size.Z
        if v3 < v1 then
            v2 = j
        end
    end
    return v2
end

local function restRotation(a1, a2) -- Line: 51 -- types: a1: userdata, a2: userdata?
    for i, j in a1:GetChildren() do
        if j:IsA("Motor6D") and j.Part0 == a2 and j.Part1 == a1 then
            return (j.C0 * j.C1:Inverse()).Rotation
        end
    end
    if a2 then
        return a2.CFrame:ToObjectSpace(a1.CFrame).Rotation
    end
    return CFrame.identity
end

local function impact(a1, a2, a3) -- Line: 60
    -- upvalues: Vfx (val), Kit (val)
    Vfx.Play(Vfx.PhaseTwo, {"HeadExplode"}, CFrame.new(a2), a3)
    Kit.Poof(a1, a3 * 2.5)
    Kit.Burst(a1, a3 * 18, Color3.fromRGB(150, 120, 90), 0.4)
    Kit.ShakeFrom(a2, 12, 320)
end

local function standIn(a1) -- Line: 67 -- upvalues: Vfx (val), Kit (val) -- types: a1: userdata
    local v1 = Vfx.Library()
    local PumpkinBruteHead = v1 and v1:FindFirstChild("PumpkinBruteHead")
    local PrimaryPart = if not PumpkinBruteHead then nil else if not PumpkinBruteHead:IsA("Model") then nil else PumpkinBruteHead.PrimaryPart
    if PumpkinBruteHead ~= nil and PumpkinBruteHead:IsA("Model") and PrimaryPart ~= nil then
        local v2 = PumpkinBruteHead:Clone()
        for i, j in v2:GetDescendants() do
            if j:IsA("BasePart") then
                j.Anchored = true
                j.CanCollide = false
                j.CanQuery = false
                j.CanTouch = false
            end
        end
        local v3 = a1.Size.X / math.max(PrimaryPart.Size.X, 0.001)
        v2:ScaleTo((v2:GetScale()) * v3)
        v2.Parent = Kit.Debris()
        return v2, v3
    end
    return nil, 1
end

return {
    Play = function(a1, a2, a3, a4, a5, a6) -- Line: 92
        -- upvalues: headParts (val), largest (val), standIn (val), Workspace (val), impact (val), Kit (val)
        -- upvalues: restRotation (val), RunService (val)
        local v1
        local v2 = if not a1 then {} else headParts(a1)
        local v3 = if not a1 then nil else a1:FindFirstChild("Pumpkin Monster Main.001", true)
        local v4 = if not v3 then largest(v2) else if not v3:IsA("BasePart") then largest(v2) else v3
        local u36 = nil
        local u37 = 1
        if v4 then
            local v5
            v1, v5 = standIn(v4)
            u36 = v1
            u37 = v5
        end
        if u36 ~= nil and v4 ~= nil then
            v1 = u36.PrimaryPart.CFrame:ToObjectSpace((u36:GetPivot()))
            local u155 = v4.CFrame * v1
            for i, j in v2 do
                j.LocalTransparencyModifier = 1
            end
            v2 = Kit.Flat(a3)
            local lookAt = CFrame.lookAt
            local Unit = if not (0.001 < v2.Magnitude) then Vector3.new(-0, -0, -1) else v2.Unit
            v2 = (lookAt(Vector3.new(0, 0, 0), Unit)) * restRotation(v4, a1 and a1.PrimaryPart) * v1.Rotation
            local v6 = (CFrame.new(a2)) * v2
            u36:PivotTo(v6)
            local BoundingBox, BoundingBox_2 = u36:GetBoundingBox()
            local v7 = a2.Y - (BoundingBox.Position.Y - BoundingBox_2.Y / 2)
            local u129 = CFrame.new(a2 + Vector3.new(0, v7, 0)) * v2
            local u136 = BoundingBox.Position + Vector3.new(0, v7, 0)
            if u155.Position.Y < u129.Position.Y then
                u155 = (CFrame.new((Vector3.new(u155.Position.X, u129.Position.Y, u155.Position.Z)))) * u155.Rotation
            end
            local u174 = Vector3.new(u129.Position.X, (math.max(u155.Position.Y, u129.Position.Y)) + BoundingBox_2.Y * 2, u129.Position.Z)
            u36:PivotTo(u155)
            local u180 = nil
            RunService.RenderStepped:Connect(function() -- Line: 146
                -- upvalues: u36 (ref), u180 (ref), Workspace (upval), a6 (val), a4 (val), u155 (ref), u174 (val)
                -- upvalues: u129 (val), impact (upval), a2 (val), u136 (val), u37 (ref)
                local v1
                if u36.Parent == nil then
                    u180:Disconnect()
                    return
                end
                local v2 = math.clamp((Workspace:GetServerTimeNow() - a6) / math.max(a4, 0.001), 0, 1)
                if not (v2 < 1) then
                    u180:Disconnect()
                    u36:Destroy()
                    impact(a2, u136, u37)
                    return
                end
                if not (v2 < 0.45) then
                    v1 = u174:Lerp(u129.Position, ((v2 - 0.45) / 0.55) ^ 3)
                else
                    local v3 = v2 / 0.45
                    v1 = u155.Position:Lerp(u174, 1 - (1 - v3) ^ 2)
                end
                local v4 = 18.84955592153876 * (1 - (1 - v2) ^ 2)
                local v5 = u155.Rotation:Lerp(u129.Rotation, (math.min(v2 * 2, 1)))
                u36:PivotTo(CFrame.new(v1) * v5 * (CFrame.Angles(math.sin(v2 * 3.141592653589793) * 0.6108652381980153, v4, 0)))
            end)
            return
        end
        v3 = a2 + Vector3.new(0, 4, 0)
        task.delay(math.max(a6 + a4 - Workspace:GetServerTimeNow(), 0), impact, a2, v3, 1)
    end,
}