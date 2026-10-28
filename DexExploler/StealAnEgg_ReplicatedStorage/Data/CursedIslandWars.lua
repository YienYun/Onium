-- Script path: ReplicatedStorage.Data.CursedIslandWars
-- Decompile time: 6.89 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local u10 = {}
local v1 = Vector2.new(0, 0)
local v2 = Vector2.new(0, 3)
local v3 = Vector2.new(0, -3)
local v4 = Vector2.new(3, 0)
local v5 = Vector2.new(-3, 0)
local v6 = Vector2.new(0, 6)
local v7 = Vector2.new(0, -6)
local v8 = Vector2.new(3, 3)
u10[1] = v1
u10[2] = v2
u10[3] = v3
u10[4] = v4
u10[5] = v5
u10[6] = v6
u10[7] = v7
u10[8] = v8
u10[9] = Vector2.new(3, -3)
local Part = Instance.new("Part")
Part.Anchored = true
Part.CanCollide = false
Part.CanQuery = false
Part.CanTouch = false
Part.Transparency = 1
local u55 = {
    ShowAt = 1792249200,
    TeamSize = 4,
    Broadcast = "YOU WANT TO ENTER MY DIMENSION? THEN PROVE YOU DESERVE TO SURVIVE.",
}
u55.IslandAnchor = CFrame.new(-9000, 1200, 11000)
u55.TeamIds = table.freeze({"Red", "Blue"})
u55.Teams = table.freeze({
    Red = table.freeze({
        Name = "RED",
        Color = Color3.fromRGB(255, 0, 0),
        FxColor = Color3.fromRGB(255, 70, 55),
    }),
    Blue = table.freeze({
        Name = "BLUE",
        Color = Color3.fromRGB(0, 85, 255),
        FxColor = Color3.fromRGB(0, 85, 255),
    }),
})
u55.Tools = table.freeze({"Bat", "PumpkinLauncher", "WallBuilder", "Landmine", "JumpPad"})
u55.Pickups = table.freeze({"Landmine", "JumpPad"})
u55.ToolNames = table.freeze({
    Bat = "Bat",
    PumpkinLauncher = "Pumpkin Launcher",
    WallBuilder = "Wall Builder",
    Landmine = "Landmine",
    JumpPad = "Jump Pad",
})
u55.Timing = table.freeze({IntroTeleport = 30, Intro = 46})
u55.Tuning = table.freeze({
    KillCredit = 10,
    VoidDepth = 40,
    Mine = table.freeze({
        Gap = 1.2,
        Side = 0.55,
        Step = 2,
        TriggerRadius = 5,
        Radius = 14,
        StructureRadius = 9,
    }),
    Wall = table.freeze({
        MinRange = 6,
        Range = 18,
        Width = 5,
        Height = 3,
        RowDelay = 0.1,
    }),
    Pad = table.freeze({Range = 14}),
    Crystal = table.freeze({Stages = table.freeze({0.75, 0.5, 0.25})}),
    Barrier = table.freeze({Stages = table.freeze({0.75, 0.5, 0.25})}),
    Brick = table.freeze({Size = 3}),
})
u55.Rewards = table.freeze({Placements = table.freeze({})})
u55.BotNames = table.freeze({"PumpkinPal", "GhostlyGus", "CandyCrusher", "SpookySam", "BatBuddy", "WitchyWin", "BonesMcGee"})
u55.BotAvatars = table.freeze({156, 261, 1, 2, 3})
u55.Assets = ReplicatedStorage.Assets.CursedIslandWars

function u55.WallCells(a1, a2, a3, a4) -- Line: 135
    -- upvalues: u55 (val), Workspace (val)
    local v1, v2, v3
    local Size = u55.Tuning.Brick.Size
    local Wall = u55.Tuning.Wall
    local Pivot = a1:GetPivot()
    local v4 = Pivot:PointToObjectSpace(a3)
    local v5 = Vector3.new(math.round(v4.X / Size) * Size, 0, (math.round(v4.Z / Size)) * Size)
    v4 = if not a4 then Vector3.new(1, 0, 0) else Vector3.new(0, 0, 1)
    local v6 = RaycastParams.new()
    v6.FilterType = Enum.RaycastFilterType.Include
    v6.FilterDescendantsInstances = {a1}
    v6.RespectCanCollide = true
    local v7 = OverlapParams.new()
    v7.FilterType = Enum.RaycastFilterType.Include
    v7.FilterDescendantsInstances = a2
    v7.RespectCanCollide = true
    local v8 = (Wall.Width - 1) / 2
    local v9 = {}
    for i = -v8, v8 do
        v1 = Pivot:PointToWorldSpace(v5 + v4 * i * Size)
        v2 = Workspace:Raycast(Vector3.new(v1.X, a3.Y + 6, v1.Z), Vector3.new(0, -18, 0), v6)
        if v2 ~= nil and not (v2.Normal.Y < 0.7) then
            v3 = Wall.Height - 1
            for j = 0, v3 do
                table.insert(v9, (CFrame.new(v1.X, v2.Position.Y + Size * (j + 0.5), v1.Z)) * Pivot.Rotation)
            end
        end
    end
    return u55.FreeCells(v9, v7)
end

function u55.FreeCells(a1, a2) -- Line: 165
    -- upvalues: Part (val), u55 (val), Workspace (val)
    Part.Size = Vector3.new(1, 1, 1) * (u55.Tuning.Brick.Size - 0.4)
    Part.Parent = Workspace
    local v1 = {}
    for i, j in a1 do
        Part.CFrame = j
        if #Workspace:GetPartsInPart(Part, a2) == 0 then
            table.insert(v1, j)
        end
    end
    Part.Parent = nil
    return v1
end

function u55.WallSearch(a1, a2, a3, a4) -- Line: 179
    -- upvalues: u55 (val), u10 (val)
    local v1, v2, v3
    local Wall = u55.Tuning.Wall
    local v4 = Vector3.new(a4.X - a3.X, 0, a4.Z - a3.Z)
    if v4.Magnitude < 0.1 then
        return nil, false, {}
    end
    local Unit = v4.Unit
    local v5 = Vector3.new(-Unit.Z, 0, Unit.X)
    local v6 = math.clamp(v4.Magnitude, Wall.MinRange, Wall.Range)
    v4 = a1:GetPivot():VectorToObjectSpace(Unit)
    local v7 = math.abs(v4.X)
    local v8 = math.abs(v4.Z) < v7
    v4 = nil
    v7 = {}
    local v9 = nil
    local v10 = nil
    local v11, v12, v13 = a3, a1, a2
    for i, j in u10, v9, v10 do
        v2 = v11 + Unit * math.clamp(v6 + j.X, Wall.MinRange, Wall.Range) + v5 * j.Y
        v1 = u55.WallCells(v12, v13, v2, v8)
        v3 = #v1
        if #v7 < v3 then
            v4 = v2
            v7 = v1
        end
        if #v7 == Wall.Width * Wall.Height then
            break
        end
    end
    return v4, v8, v7
end

function u55.Steer(a1, a2, a3, a4) -- Line: 207 -- types: a1: vector, a2: vector, a3: vector, a4: number
    local v1 = a3 - a2
    local v2 = a1:Cross(v1)
    if v2.Magnitude < 1e-06 then
        return a1
    end
    return (CFrame.fromAxisAngle(v2.Unit, (math.min(math.acos((math.clamp(a1.Unit:Dot(v1.Unit), -1, 1))), a4)))):VectorToWorldSpace(a1)
end

return u55