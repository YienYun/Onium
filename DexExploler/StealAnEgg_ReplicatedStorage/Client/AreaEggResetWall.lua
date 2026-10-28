-- Script path: ReplicatedStorage.Client.AreaEggResetWall
-- Decompile time: 12.21 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Signal = require(ReplicatedStorage.Packages.Signal)
local u29 = {
    Seconds = 1,
    Style = Enum.EasingStyle.Elastic,
    Direction = Enum.EasingDirection.Out,
}
local u32 = {
    Seconds = 0.35,
    Style = Enum.EasingStyle.Quad,
    Direction = Enum.EasingDirection.Out,
}
local u35 = {CollapseSeconds = u32.Seconds}
u35.Changed = Signal.new()

local function demandFolder(a1, a2) -- Line: 39 -- types: a1: userdata, a2: string
    local v1 = a1[a2]
    assert(v1:IsA("Folder"), (("%* under %* is not a Folder"):format(a2, a1.Name)))
    return v1
end

local function demandPart(a1, a2) -- Line: 45 -- types: a1: userdata, a2: string
    local v1 = a1[a2]
    assert(v1:IsA("BasePart"), (("%* under %* is not a BasePart"):format(a2, a1.Name)))
    return v1
end

local World = Workspace.World
assert(World:IsA("Folder"), (("World under %* is not a Folder"):format(Workspace.Name)))
local Areas = World.Areas
assert(Areas:IsA("Folder"), (("Areas under %* is not a Folder"):format(World.Name)))
local WallStartVisual = Areas.WallStartVisual
assert(WallStartVisual:IsA("BasePart"), (("WallStartVisual under %* is not a BasePart"):format(Areas.Name)))
local WallStartCollision = Areas.WallStartCollision
assert(WallStartCollision:IsA("BasePart"), (("WallStartCollision under %* is not a BasePart"):format(Areas.Name)))
local LocalPlayer = Players.LocalPlayer
local u92 = WallStartVisual.Size * Vector3.new(1, 0, 1)
local Y = WallStartVisual.Size.Y
local u101 = WallStartVisual.CFrame * CFrame.new(Vector3.new(0, 1, 0) * (Y * -0.5))
local u102 = nil
local u103 = nil
local u104 = false
WallStartVisual.CanCollide = false

local function applyHeight(a1) -- Line: 67
    -- upvalues: Y (val), WallStartVisual (val), u92 (val), u101 (val)
    local v1 = math.clamp(a1, 0, Y)
    WallStartVisual.Size = u92 + Vector3.new(0, 1, 0) * v1
    WallStartVisual.CFrame = u101 * CFrame.new(Vector3.new(0, 1, 0) * (v1 * 0.5))
end

local function barrierPieces() -- Line: 73 -- upvalues: WallStartCollision (val)
    local v1 = {WallStartCollision}
    for i, j in WallStartCollision:GetDescendants() do
        if j:IsA("BasePart") then
            table.insert(v1, j)
        end
    end
    return v1
end

local function setBarrierSolid(a1) -- Line: 83 -- upvalues: barrierPieces (val) -- types: a1: boolean
    for i, j in barrierPieces() do
        j.CanCollide = a1
    end
end

local function partOverlapsPiece(a1, a2) -- Line: 91 -- types: a1: userdata, a2: userdata
    local v1, v2, v3, v4
    local v5 = a1.Size * 0.5
    local v6 = a2.Size * 0.5 + Vector3.new(0.5, 0.5, 0.5)
    local v7 = a2.CFrame:ToObjectSpace(a1.CFrame)
    local v8 = Vector3.new(1, 1, 1) * (1 / 0)
    local v9 = -v8
    local v10 = {-v5.X, v5.X}
    local v11 = nil
    local v12 = nil
    for i, j in v10, v11, v12 do
        v1 = {-v5.Y, v5.Y}
        v2 = nil
        v3 = nil
        for k, n in v1, v2, v3 do
            for m, i5 in {-v5.Z, v5.Z} do
                v4 = v7 * Vector3.new(j, n, i5)
                v8 = v8:Min(v4)
                v9 = v9:Max(v4)
            end
        end
    end
    v10 = false
    local X = v9.X
    if -v6.X <= X then
        v10 = false
        if v8.X <= v6.X then
            v10 = false
            local Y = v9.Y
            if -v6.Y <= Y then
                v10 = false
                if v8.Y <= v6.Y then
                    v10 = false
                    local Z = v9.Z
                    if -v6.Z <= Z then
                        v10 = v8.Z <= v6.Z
                    end
                end
            end
        end
    end
    return v10
end

local function characterInsideBarrier() -- Line: 115
    -- upvalues: LocalPlayer (val), barrierPieces (val), partOverlapsPiece (val)
    local Character = LocalPlayer and LocalPlayer.Character
    if Character == nil then
        return false
    end
    local v1 = barrierPieces()
    for i, j in Character:GetDescendants() do
        if j:IsA("BasePart") then
            if not j.CanCollide and j.Name ~= "HumanoidRootPart" then
                continue
            end
            for k, n in v1 do
                if partOverlapsPiece(j, n) then
                    return true
                end
            end
        end
    end
    return false
end

local function cancelSolidify() -- Line: 133 -- upvalues: u103 (ref)
    local v1 = u103
    u103 = nil
    if v1 then
        v1:Disconnect()
    end
end

local function solidifyWhenClear() -- Line: 145
    -- upvalues: u103 (ref), characterInsideBarrier (val), barrierPieces (val), RunService (val)
    local v1 = u103
    u103 = nil
    if v1 then
        v1:Disconnect()
    end
    if not characterInsideBarrier() then
        for k, n in barrierPieces() do
            n.CanCollide = true
        end
        return
    end
    for i, j in barrierPieces() do
        j.CanCollide = false
    end
    local u30 = nil
    u30 = RunService.Heartbeat:Connect(function() -- Line: 153 -- upvalues: characterInsideBarrier (upval), u30 (ref), u103 (upval), barrierPieces (upval)
        if characterInsideBarrier() then
            return
        end
        u30:Disconnect()
        if u103 == u30 then
            u103 = nil
            for i, j in barrierPieces() do
                j.CanCollide = true
            end
        end
    end)
    u103 = u30
end

local function publishSealed(a1) -- Line: 166 -- upvalues: u104 (ref), u35 (val) -- types: a1: boolean
    if u104 ~= a1 then
        u35.Changed:Fire(a1)
    end
end

local function abortSweep() -- Line: 173 -- upvalues: u102 (ref)
    local v1 = u102
    u102 = nil
    if v1 then
        v1:Disconnect()
    end
end

local function runSweep(a1, a2, a3) -- Line: 184
    -- upvalues: u102 (ref), Y (val), WallStartVisual (val), u92 (val), u101 (val), RunService (val), TweenService (val)
    local v1 = u102
    u102 = nil
    if v1 then
        v1:Disconnect()
    end
    v1 = math.clamp(a2, 0, Y)
    WallStartVisual.Size = u92 + Vector3.new(0, 1, 0) * v1
    WallStartVisual.CFrame = u101 * CFrame.new(Vector3.new(0, 1, 0) * (v1 * 0.5))
    local u28 = a3 - a2
    local u29 = 0
    local u30 = nil
    u30 = RunService.PreRender:Connect(function(a1_2) -- Line: 191
        -- upvalues: u29 (ref), a1 (val), TweenService (upval), a2 (val), u28 (val), Y (upval), WallStartVisual (upval)
        -- upvalues: u92 (upval), u101 (upval), u30 (ref)
        u29 = math.min(u29 + a1_2, a1.Seconds)
        local v1 = math.clamp(a2 + u28 * (TweenService:GetValue(u29 / a1.Seconds, a1.Style, a1.Direction)), 0, Y)
        WallStartVisual.Size = u92 + Vector3.new(0, 1, 0) * v1
        WallStartVisual.CFrame = u101 * CFrame.new(Vector3.new(0, 1, 0) * (v1 * 0.5))
        if a1.Seconds <= u29 then
            u30:Disconnect()
        end
    end)
    u102 = u30
    task.delay(a1.Seconds * 3, function() -- Line: 202 -- upvalues: u102 (upval), u30 (ref)
        if u102 == u30 then
            u30:Disconnect()
        end
    end)
    while u30.Connected do
        task.wait()
    end
    if u102 ~= u30 then
        return false
    end
    u102 = nil
    local v2 = math.clamp(a3, 0, Y)
    WallStartVisual.Size = u92 + Vector3.new(0, 1, 0) * v2
    WallStartVisual.CFrame = u101 * CFrame.new(Vector3.new(0, 1, 0) * (v2 * 0.5))
    return true
end

function u35.ArmReveal() -- Line: 219
    -- upvalues: u102 (ref), Y (val), WallStartVisual (val), u92 (val), u101 (val), solidifyWhenClear (val), u104 (ref)
    -- upvalues: u35 (val)
    local v1 = u102
    u102 = nil
    if v1 then
        v1:Disconnect()
    end
    v1 = math.clamp(0, 0, Y)
    WallStartVisual.Size = u92 + Vector3.new(0, 1, 0) * v1
    WallStartVisual.CFrame = u101 * CFrame.new(Vector3.new(0, 1, 0) * (v1 * 0.5))
    solidifyWhenClear()
    if u104 ~= true then
        u104 = true
        u35.Changed:Fire(u104)
    end
end

function u35.RaiseWall() -- Line: 226 -- upvalues: runSweep (val), u29 (val), Y (val)
    runSweep(u29, 0, Y)
end

function u35.DropWall() -- Line: 228
    -- upvalues: u103 (ref), barrierPieces (val), u104 (ref), u35 (val), runSweep (val), u32 (val)
    -- upvalues: WallStartVisual (val)
    local v1 = u103
    u103 = nil
    if v1 then
        v1:Disconnect()
    end
    for i, j in barrierPieces() do
        j.CanCollide = false
    end
    if u104 ~= false then
        u104 = false
        u35.Changed:Fire(u104)
    end
    runSweep(u32, WallStartVisual.Size.Y, 0)
end

function u35.ClearWall() -- Line: 236
    -- upvalues: u102 (ref), u103 (ref), Y (val), WallStartVisual (val), u92 (val), u101 (val), barrierPieces (val)
    -- upvalues: u104 (ref), u35 (val)
    local v1 = u102
    u102 = nil
    if v1 then
        v1:Disconnect()
    end
    v1 = u103
    u103 = nil
    if v1 then
        v1:Disconnect()
    end
    v1 = math.clamp(0, 0, Y)
    WallStartVisual.Size = u92 + Vector3.new(0, 1, 0) * v1
    WallStartVisual.CFrame = u101 * CFrame.new(Vector3.new(0, 1, 0) * (v1 * 0.5))
    for i, j in barrierPieces() do
        j.CanCollide = false
    end
    if u104 ~= false then
        u104 = false
        u35.Changed:Fire(u104)
    end
end

function u35.ResolveWallPart() -- Line: 244 -- upvalues: WallStartVisual (val)
    return WallStartVisual
end

function u35.ResolveFullHeight() -- Line: 246 -- upvalues: Y (val)
    return Y
end

function u35.IsSealed() -- Line: 248 -- upvalues: u104 (ref)
    return u104
end

return u35