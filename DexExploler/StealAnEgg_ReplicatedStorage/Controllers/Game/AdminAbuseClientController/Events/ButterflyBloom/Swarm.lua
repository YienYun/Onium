-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ButterflyBloom.Swarm
-- Decompile time: 17.02 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ButterflyCatalog = require(ReplicatedStorage.Shared.Modules.ButterflyCatalog)
local Butterflies = ((ReplicatedStorage:WaitForChild("Assets")):WaitForChild("Models")):WaitForChild("Butterflies")
local u32 = {}
local u33 = nil
local u34 = {}
local u35 = {}
local u36 = 0
local u37 = {}

local function trackSpeed(a1, a2) -- Line: 69 -- types: a1: table, a2: number
    return a1.Tier.FlapSpeed / 15 * a2
end

local function getFolder() -- Line: 77 -- upvalues: u33 (ref), Workspace (val)
    if u33 and u33.Parent then
        return u33
    end
    local Folder = Instance.new("Folder")
    Folder.Name = "ButterflyBloomSwarm"
    Folder.Parent = Workspace
    u33 = Folder
    return Folder
end

local function setAlpha(a1, a2) -- Line: 88 -- types: a1: table, a2: number
    local v1
    a1.Alpha = a2
    for i, j in a1.Fadeables do
        v1 = 1 - (1 - a1.Opacity[i]) * a2
        if not j:IsA("Decal") then end
        j.Transparency = v1
    end
end

local function build(a1) -- Line: 101
    -- upvalues: Butterflies (val), ButterflyCatalog (val), Workspace (val), setAlpha (val), u33 (ref), u37 (val)
    local v1 = Butterflies:FindFirstChild(a1.Tier)
    if v1 ~= nil and v1:IsA("Model") and v1.PrimaryPart ~= nil then
        local v2, v3
        local v4 = ButterflyCatalog.Get(a1.Tier)
        local v5 = v1:Clone()
        v5:ScaleTo((v1:GetScale()) * v4.Scale)
        local PrimaryPart = v5.PrimaryPart
        local v6 = {}
        local v7 = {}
        local v8 = {}
        local v9 = {}
        local v10 = {}
        local v11 = {}
        local AnimationController = v5:FindFirstChildOfClass("AnimationController")
        local Animator = if not AnimationController then nil else AnimationController:FindFirstChildOfClass("Animator")
        local v12 = a1
        for i, j in v5:GetDescendants() do
            if not Animator or not j:IsA("BasePart") then
                if j:IsA("BasePart") then
                    j.Anchored = true
                    j.CanCollide = false
                    j.CanQuery = false
                    j.CanTouch = false
                    j.CastShadow = false
                    v2 = PrimaryPart.CFrame:ToObjectSpace(j.CFrame)
                    table.insert(v6, j)
                    table.insert(v7, v2)
                    if not (j:GetAttribute("Wing") == true) then
                        table.insert(v8, CFrame.identity)
                        table.insert(v9, 0)
                    else
                        table.insert(v8, (CFrame.new(0, v2.Y, 0)))
                        table.insert(v9, if not (0 <= v2.X) then -1 else 1)
                    end
                    if j.Transparency < 1 then
                        table.insert(v10, j)
                        table.insert(v11, j.Transparency)
                    end
                elseif j:IsA("Decal") then
                    table.insert(v10, j)
                    table.insert(v11, j.Transparency)
                end
            elseif j ~= PrimaryPart then
                j.Anchored = false
                j.Massless = true
                j.CanCollide = false
                j.CanQuery = false
                j.CanTouch = false
                j.CastShadow = false
                if j.Transparency < 1 then
                    table.insert(v10, j)
                    table.insert(v11, j.Transparency)
                end
            elseif j:IsA("BasePart") then
                j.Anchored = true
                j.CanCollide = false
                j.CanQuery = false
                j.CanTouch = false
                j.CastShadow = false
                v2 = PrimaryPart.CFrame:ToObjectSpace(j.CFrame)
                table.insert(v6, j)
                table.insert(v7, v2)
                if not (j:GetAttribute("Wing") == true) then
                    table.insert(v8, CFrame.identity)
                    table.insert(v9, 0)
                else
                    table.insert(v8, (CFrame.new(0, v2.Y, 0)))
                    table.insert(v9, if not (0 <= v2.X) then -1 else 1)
                end
                if j.Transparency < 1 then
                    table.insert(v10, j)
                    table.insert(v11, j.Transparency)
                end
            elseif j:IsA("Decal") then
                table.insert(v10, j)
                table.insert(v11, j.Transparency)
            end
        end
        local v13 = ButterflyCatalog.PositionAt(v12, (Workspace:GetServerTimeNow()))
        local v14 = {
            Heading = Vector3.new(0, 0, -1),
            HoldUntil = 0,
            Leaving = false,
            Alpha = 0,
            PlayingSpeed = 0,
            Tracked = false,
            SteppedAt = 0,
            PinnedUntil = 0,
        }
        v14.Flight = v12
        v14.Tier = v4
        v14.Model = v5
        v14.Body = PrimaryPart
        v14.Parts = v6
        v14.Rest = v7
        v14.Hinge = v8
        v14.Side = v9
        v14.Fadeables = v10
        v14.Opacity = v11
        v14.Position = v13
        v14.FlapPhase = v12.Seed % 628 / 100
        v14.Animator = Animator
        v14.Tracks = {}
        setAlpha(v14, 0)
        v5:PivotTo((CFrame.new(v13)))
        if not u33 or not u33.Parent then
            v13 = Instance.new("Folder")
            v13.Name = "ButterflyBloomSwarm"
            v13.Parent = Workspace
            u33 = v13
            v3 = v13
        else
            v3 = u33
        end
        v5.Parent = v3
        if Animator then
            for k, n in ButterflyCatalog.TierAnimations[v12.Tier] or ButterflyCatalog.Animations do
                v10 = Instance.new("Animation")
                v10.AnimationId = n
                v9 = Animator:LoadAnimation(v10)
                v9.Looped = true
                v14.Tracks[k] = v9
            end
            u37.PlayTrack(v14, "Fly", 1)
        end
        return v14
    end
    warn((("[ButterflyBloom] Assets.Models.Butterflies.%* needs a PrimaryPart"):format(a1.Tier)))
    return nil
end

local function destroy(a1) -- Line: 203 -- types: a1: table
    a1.Model:Destroy()
end

function u37.Add(a1) -- Line: 211 -- upvalues: u32 (val), build (val)
    local v1 = u32[a1.Id]
    if v1 then
        v1.Flight = a1
        return v1
    end
    v1 = build(a1)
    if v1 then
        u32[a1.Id] = v1
    end
    return v1
end

function u37.Update(a1) -- Line: 224 -- upvalues: u32 (val), u37 (val)
    local v1 = u32[a1.Id]
    if v1 == nil then
        u37.Add(a1)
        return
    end
    v1.Flight = a1
    v1.HoldUntil = 0
end

function u37.Get(a1) -- Line: 234 -- upvalues: u32 (val) -- types: a1: number
    return u32[a1]
end

function u37.PlayTrack(a1, a2, a3) -- Line: 238 -- types: a1: table, a2: string, a3: number
    local v1 = a1.Tracks[a2]
    if v1 == nil then
        return
    end
    local v2 = a1.Tier.FlapSpeed / 15 * a3
    if a1.Playing == a2 then
        if a1.PlayingSpeed ~= v2 then
            a1.PlayingSpeed = v2
            v1:AdjustSpeed(v2)
        end
        return
    end
    local v3 = if not a1.Playing then nil else a1.Tracks[a1.Playing]
    if v3 then
        v3:Stop(0.15)
    end
    a1.Playing = a2
    a1.PlayingSpeed = v2
    v1:Play(0.15, 1, v2)
end

function u37.Pin(a1, a2, a3) -- Line: 260 -- upvalues: u32 (val), u37 (val) -- types: a1: number, a2: vector, a3: number
    local v1 = u32[a1]
    if v1 == nil then
        return
    end
    v1.PinPosition = a2
    v1.PinnedUntil = os.clock() + a3
    v1.Position = a2
    u37.PlayTrack(v1, "Struggle", 1)
end

function u37.Hold(a1, a2) -- Line: 271 -- upvalues: u32 (val) -- types: a1: number, a2: number
    local v1 = u32[a1]
    if v1 then
        v1.HoldUntil = os.clock() + a2
    end
end

function u37.Take(a1) -- Line: 278 -- upvalues: u32 (val) -- types: a1: number
    local v1 = u32[a1]
    if v1 == nil then
        return nil
    end
    u32[a1] = nil
    v1.Leaving = true
    return v1
end

function u37.Release(a1, a2) -- Line: 288 -- upvalues: setAlpha (val) -- types: a1: table, a2: number?
    local u2 = a2 or 0.7
    local u4 = os.clock()
    local Alpha = a1.Alpha
    task.spawn(function() -- Line: 292 -- upvalues: a1 (val), u4 (val), u2 (val), setAlpha (upval), Alpha (val)
        local v1
        while a1.Model.Parent do
            v1 = math.clamp((os.clock() - u4) / u2, 0, 1)
            setAlpha(a1, Alpha * (1 - v1))
            if v1 >= 1 then
                break
            end
            task.wait()
        end
        a1.Model:Destroy()
    end)
end

function u37.Remove(a1) -- Line: 305 -- upvalues: u37 (val) -- types: a1: number
    local v1 = u37.Take(a1)
    if v1 then
        u37.Release(v1)
    end
end

function u37.Clear(a1) -- Line: 312 -- upvalues: u32 (val), u37 (val) -- types: a1: boolean?
    local v1
    for i in u32 do
        v1 = u37.Take(i)
        if v1 then
            if not a1 then
                u37.Release(v1)
            else
                v1.Model:Destroy()
            end
        end
    end
end

function u37.Count() -- Line: 325 -- upvalues: u32 (val)
    local v1 = 0
    for i in u32 do
        v1 = v1 + 1
    end
    return v1
end

function u37.Each() -- Line: 333 -- upvalues: u32 (val)
    return u32
end

function u37.Pose(a1, a2, a3, a4, a5) -- Line: 337 -- types: a1: table, a2: userdata, a3: number, a4: table, a5: table
    local v1, v2, v3
    local Parts = a1.Parts
    local v4 = nil
    local v5 = nil
    local v6, v7, v8 = a1, a2, a3
    for i, j in Parts, v4, v5 do
        v1 = v6.Rest[i]
        v2 = v6.Hinge[i]
        v3 = if v6.Side[i] == 0 then v7 * v1 else v7 * v2 * CFrame.Angles(0, 0, v8 * v6.Side[i]) * v2:Inverse() * v1
        table.insert(v9, j)
        table.insert(v10, v3)
    end
end

function u37.Step(a1, a2) -- Line: 359
    -- upvalues: u34 (val), u35 (val), u36 (ref), Workspace (val), u32 (val), setAlpha (val), ButterflyCatalog (val)
    -- upvalues: u37 (val)
    local Alpha, Flight, Magnitude, Unit_2, v1, v2, v3, v4, v5, v6
    local v7 = u34
    local v8 = u35
    table.clear(v7)
    table.clear(v8)
    u36 = u36 + 1
    local CurrentCamera = Workspace.CurrentCamera
    local Position = if not CurrentCamera then nil else CurrentCamera.CFrame.Position
    local v9 = nil
    local v10 = nil
    local v11, v12 = a1, a2
    for i, j in u32, v9, v10 do
        Flight = j.Flight
        if j.Alpha < 1 then
            v1 = math.clamp((v11 - Flight.Born) / 0.6, 0, 1)
            if Flight.Born < Flight.FleeAt then
                v1 = 1
            end
            v2 = setAlpha
            Alpha = j.Alpha
            v2(j, (math.max(Alpha, v1)))
        end
        if not Position or (u36 + i) % 3 == 0 or not (250 < (j.Position - Position).Magnitude) then
            if not (v12 < j.PinnedUntil) and j.PinPosition then
                Flight.FleeFrom = j.PinPosition
                j.PinPosition = nil
            end
            v2 = v1 or v12 < j.HoldUntil
            if v1 then
                j.Position = j.PinPosition
                j.Tracked = false
            elseif not v2 then
                v3 = ButterflyCatalog.PositionAt(Flight, v11)
                v4 = v11 - j.SteppedAt
                if j.Tracked and v4 > 0 then
                    v5 = v3 - j.Position
                    v6 = Vector3.new(v5.X, 0, v5.Z)
                    Magnitude = v6.Magnitude
                    if v4 * 0.05 < Magnitude then
                        j.Heading = j.Heading:Lerp(v6.Unit, 0.2)
                    end
                end
                j.Position = v3
                j.Tracked = true
            else
                j.Tracked = false
            end
            j.SteppedAt = v11
            if j.Animator and not v1 then
                v4 = not (v11 < Flight.FleeAt + Flight.FleeSeconds) and 0.8 < (math.sin(v12 * 0.45 + j.FlapPhase))
                u37.PlayTrack(j, if not v4 then "Fly" else "Glide", if not v3 then if not v2 then 1 else 0.25 else 1.6)
            end
            v2 = j.Tier.FlapSpeed * (if not v2 then 1 else 0.25)
            v1 = math.rad((math.sin(v12 * v2 + j.FlapPhase)) * 52 + 14)
            Unit_2 = if not (0 < j.Heading.Magnitude) then Vector3.new(0, 0, -1) else j.Heading.Unit
            v3 = math.rad((math.sin(v12 * 1.7 + j.FlapPhase)) * 10)
            v3 = (CFrame.lookAt(j.Position, j.Position + Unit_2)) * CFrame.Angles(-0.20943951023931956, 0, v3)
            u37.Pose(j, v3, v1, v7, v8)
        end
    end
    if #v7 > 0 then
        Workspace:BulkMoveTo(v7, v8, Enum.BulkMoveMode.FireCFrameChanged)
    end
end

function u37.Nearest(a1, a2, a3) -- Line: 436 -- upvalues: u32 (val) -- types: a1: vector, a2: vector, a3: number
    local Magnitude, v1, v2
    local v3 = nil
    local v4 = (1 / 0)
    local v5 = Vector3.new(a2.X, 0, a2.Z)
    local Unit = if not (0 < v5.Magnitude) then Vector3.new(0, 0, -1) else v5.Unit
    local v6 = nil
    local v7 = nil
    local v8, v9 = a1, a3
    for i, j in u32, v6, v7 do
        if not (j.Alpha < 0.5) then
            v1 = j.Position - v8
            Magnitude = v1.Magnitude
            if not (v9 < Magnitude) then
                v2 = Vector3.new(v1.X, 0, v1.Z)
                v2 = Magnitude - (if not (0 < v2.Magnitude) then 1 else Unit:Dot(v2.Unit)) * 5
                if v2 < v4 then
                    v3 = j
                end
            end
        end
    end
    return v3
end

function u37.Tween(a1, a2, a3, a4) -- Line: 461
    -- upvalues: TweenService (val)
    local v1 = TweenService:Create(a1, TweenInfo.new(a2, a4 or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), a3)
    v1:Play()
    return v1
end

return u37