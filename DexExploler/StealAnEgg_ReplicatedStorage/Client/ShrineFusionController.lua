-- Script path: ReplicatedStorage.Client.ShrineFusionController
-- Decompile time: 51.99 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local FusionShrines = require(ReplicatedStorage.Shared.FusionShrines)
local ShrinePadPets = require(ReplicatedStorage.Client.ShrinePadPets)
local ShrineFusion = require(ReplicatedStorage.Shared.Remotes).ShrineFusion
local ShrineFusionStatus = require(ReplicatedStorage.Client.ShrineFusionStatus)
local Trove = require(ReplicatedStorage.Packages.Trove)
local ShrinePadZone = require(ReplicatedStorage.Shared.Util.ShrinePadZone)
local ShrineFusionSequences = ReplicatedStorage.Client:WaitForChild("ShrineFusionSequences")
local Cinematic = (ReplicatedStorage.Assets.UI:WaitForChild("FusionShrine")):WaitForChild("Cinematic")
local FusionShrineHint = ReplicatedStorage.Assets.Billboards:WaitForChild("FusionShrineHint")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local u77 = {
    DiscDiameter = 15.6,
    DiscLift = 0.07,
    OrbCount = 3,
    OrbRadius = 7.2,
    OrbSize = 0.7,
    OrbSpeed = 1.3,
    OrbBob = 0.5,
    OrbHeight = 1.3,
    AnimDistance = 180,
    Approach = 6,
    Breathe = 1.7,
    FieldSize = 46,
    ArcCurve = 9,
    ArcWidth = 0.9,
}
local u78 = {}
local u79 = {Ready = false}
local u80 = false
local u81 = 0
local u82 = nil
local u83 = nil
local u84 = nil
local u85 = nil

local function sequenceOf(a1) -- Line: 100 -- upvalues: ShrineFusionSequences (val)
    return require((ShrineFusionSequences:WaitForChild(a1.Sequence)))
end

local function layoutOf(a1) -- Line: 104 -- upvalues: FusionShrines (val) -- types: a1: userdata
    local v1 = FusionShrines.Of(a1)
    if not v1 then
        return nil, nil
    end
    return v1, FusionShrines.PadsOf(a1, v1)
end

local function centerOf(a1) -- Line: 112 -- types: a1: table
    local v1 = Vector3.new(0, 0, 0)
    local v2 = 0
    for i, j in a1 do
        v1 = v1 + j.Position
        v2 = v2 + 1
    end
    return v1 / math.max(v2, 1)
end

local function mix(a1, a2, a3) -- Line: 121 -- types: a1: number, a2: number, a3: number
    return a1 + (a2 - a1) * a3
end

local function smooth(a1) -- Line: 125 -- types: a1: number
    local v1 = math.clamp(a1, 0, 1)
    return v1 * v1 * (3 - v1 * 2)
end

local function localRoot() -- Line: 130 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = if not Character then nil else Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart.Position
    end
    return nil
end

local function shotRig(a1) -- Line: 136 -- upvalues: LocalPlayer (val)
    local Sides = a1.Kind.Sides
    local Position = a1.Pads[Sides[1]].Position
    local Position_2 = a1.Pads[Sides[2]].Position
    local v1 = Position - Position_2
    local Unit = if not (0.01 < v1.Magnitude) then Vector3.new(1, 0, 0) else v1.Unit
    local v2 = Vector3.new(0, 1, 0):Cross(Unit)
    local v3 = (Position + Position_2) / 2 + Vector3.new(0, 5.5, 0)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = if not Character then nil else Character:FindFirstChild("HumanoidRootPart")
    local Position_3 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart.Position
    local v4 = if not Position_3 then Vector3.new(0, 0, 0) else (v3 - Position_3) * Vector3.new(1, 0, 1)
    return {
        Focus = v3,
        Axis = Unit,
        Front = v2,
        Light = Position,
        Dark = Position_2,
        Span = math.max(18, v1.Magnitude * 1.25),
        Root = Position_3,
        Approach = if not (0.01 < v4.Magnitude) then v2 else v4.Unit,
    }
end

local function camFrame(a1, a2, a3, a4) -- Line: 157 -- types: a3: number, a4: number
    local v1, v2, v3, v4, v5, v6, v7
    local Cam = a1.Cam
    if not Cam then
        a1.Cam = {
            Dist = 1.26,
            Height = 9.4,
            FOV = 56,
            Angle = 0.34,
            Drift = 1,
            Shot = 1,
        }
    end
    local v8 = a1.Sequence.FlightFocus()
    local v9 = 1 - math.exp(-a4 * 2.8)
    local v10 = 1 - math.exp(-a4 * 5.2)
    local v11 = math.max(a1.EndsAt - a1.StartedAt, 1)
    local v12 = math.clamp(v11 * 0.24, 0.5, 1.3)
    local v13 = a1.EndsAt - v12
    local v14 = math.clamp((a3 - a1.StartedAt) / v11, 0, 1)
    if a1.PayoffAt then
        v7 = math.clamp((a3 - a1.PayoffAt - 1.1) / 3.4, 0, 1)
        v6 = v7 * v7 * (3 - v7 * 2)
        v1 = 0
        v2 = v6 * 0.24 + 0.6
        v3 = v6 * 1.1999999999999993 + 4.4
        v4 = v6 * 3 + 46
        v5 = 0
    elseif v13 <= a3 then
        v7 = math.clamp((a3 - v13) / v12, 0, 1)
        v6 = v7 * v7 * (3 - v7 * 2)
        v1 = 0
        v2 = v6 * -0.06000000000000005 + 0.56
        v3 = v6 * -0.3999999999999999 + 3.6
        v4 = v6 * -2.5 + 46
        v5 = 0
    elseif not (v14 < 0.38) then
        v6 = math.max((v13 - a1.StartedAt) / v11, 0.43)
        local v15 = math.clamp((v14 - 0.38) / (v6 - 0.38), 0, 1)
        local v16 = v15 * v15 * (3 - v15 * 2)
        v1 = v16 * 0.55 + -0.55
        v2 = v16 * -0.32999999999999996 + 0.95
        v3 = v16 * -0.6000000000000005 + 4.4
        v4 = v16 * -4 + 50
        if Cam.Shot == 1 then
            Cam.Shot = 2
            Cam.Angle = v1
            Cam.Dist = v2
            Cam.Height = v3
            Cam.FOV = v4
            Cam.Drift = 0.5
        end
    else
        v7 = math.clamp(v14 / 0.38, 0, 1)
        v6 = v7 * v7 * (3 - v7 * 2)
        v1 = 0.34
        v2 = v6 * -0.24 + 1.26
        v3 = v6 * -2.2 + 9.4
        v4 = v6 * -3 + 56
        v5 = 1
    end
    local Dist = Cam.Dist
    Cam.Dist = Dist + (v2 - Dist) * v9
    local Height = Cam.Height
    Cam.Height = Height + (v3 - Height) * v9
    local FOV = Cam.FOV
    Cam.FOV = FOV + ((if not v8 then v4 else 51) - FOV) * v9
    local Angle = Cam.Angle
    Cam.Angle = Angle + (v1 - Angle) * v10
    local Drift = Cam.Drift
    Cam.Drift = Drift + (v5 - Drift) * v10
    v5 = Cam.Angle + math.sin((a3 - a1.StartedAt) * 0.33) * 0.05 * Cam.Drift
    local Unit = (a2.Front * math.cos(v5) + a2.Axis * math.sin(v5)).Unit
    v5 = a2.Focus + Unit * a2.Span * Cam.Dist + Vector3.new(0, Cam.Height, 0)
    if v8 and not Cam.Anchor then
        Cam.Anchor = v5
        Cam.AnchorFrom = v5
        Cam.AnchorTo = a2.Focus + Unit * a2.Span * 0.78 + Vector3.new(0, 5.599999904632568, 0)
        Cam.AnchorAt = a3
        Cam.AimPoint = a2.Focus
        Cam.AimGoal = a2.Focus
        Cam.AimVelocity = Vector3.new(0, 0, 0)
    end
    if not Cam.Anchor then
        return (CFrame.lookAt(v5, a2.Focus)), Cam.FOV
    end
    local AnchorFrom = Cam.AnchorFrom
    local AnchorTo = Cam.AnchorTo
    v4 = math.clamp((a3 - Cam.AnchorAt) / 0.55, 0, 1)
    Cam.Anchor = AnchorFrom:Lerp(AnchorTo, v4 * v4 * (3 - v4 * 2))
    local Focus_2 = if not v8 then a2.Focus else a2.Focus:Lerp(v8, 0.42)
    Cam.AimGoal = Focus_2
    v3 = math.min(a4, 0.03333333333333333)
    Cam.AimVelocity = Cam.AimVelocity + ((Cam.AimGoal - Cam.AimPoint) * 30.25 - Cam.AimVelocity * 6.6) * v3
    Cam.AimPoint = Cam.AimPoint + Cam.AimVelocity * v3
    return (CFrame.lookAt(Cam.Anchor, Cam.AimPoint)), Cam.FOV
end

local function cinematicGui() -- Line: 250 -- upvalues: Cinematic (val), PlayerGui (val), TweenService (val)
    local v1, v2, v3
    local v4 = Cinematic:Clone()
    v4.ResetOnSpawn = false
    local TopBar = v4:WaitForChild("TopBar")
    local BottomBar = v4:WaitForChild("BottomBar")
    local Help = v4:WaitForChild("Help")
    local v5 = v4:GetAttribute("BarHeight") or 0.115
    v4.Parent = PlayerGui
    for i, j in {TopBar, BottomBar} do
        j.Size = UDim2.fromScale(1, 0)
        v1 = TweenService
        v2 = TweenInfo.new(0.55, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        v3 = {Size = UDim2.fromScale(1, v5)}
        v1:Create(j, v2, v3):Play()
    end
    return v4, TopBar, BottomBar, Help
end

local function setBillboards(a1, a2) -- Line: 269 -- types: a2: boolean
    if a1.BillboardsOn == a2 then
        return
    end
    a1.BillboardsOn = a2
    for i, j in a1.Billboards do
        if j.Parent then
            j.Enabled = a2
        end
    end
end

local function refresh() -- Line: 281 -- upvalues: u80 (ref), ShrineFusion (val), u79 (ref)
    if u80 then
        return
    end
    u80 = true
    task.spawn(function() -- Line: 286 -- upvalues: ShrineFusion (upval), u79 (upval), u80 (upval)
        local success, err, v1 = pcall(function() -- Line: 287 -- upvalues: ShrineFusion (upval)
            return ShrineFusion.AskState:InvokeServer()
        end)
        if success and err and type(v1) == "table" then
            u79 = v1
        end
        u80 = false
    end)
end

local function completed(a1) -- Line: 297 -- upvalues: u79 (ref)
    local Status_2
    if not (if not u79.Ready then nil else if type(u79.Status) ~= "table" then nil else u79.Status) then
        return false
    end
    for i, j in a1.Tiers do
        if Status_2[j] ~= "COMPLETED" then
            return false
        end
    end
    return true
end

local function settle(a1, a2) -- Line: 310 -- upvalues: ShrineFusionSequences (val), u79 (ref) -- types: a2: boolean
    local Kind = a1.Kind
    local v1 = require((ShrineFusionSequences:WaitForChild(Kind.Sequence)))
    if v1.Settle and not a2 and u79.Ready then
        if a1.Settled ~= u79 then
            local v2
            a1.Settled = u79
            local Kind_2 = a1.Kind
            local Status_2 = if not u79.Ready then nil else if type(u79.Status) ~= "table" then nil else u79.Status
            if Status_2 then
                for i, j in Kind_2.Tiers do
                    if Status_2[j] ~= "COMPLETED" then
                        a1.Cleared = false
                        v1.Settle(a1.Model, a1.Cleared == true)
                        return
                    end
                end
                v2 = true
            else
                v2 = false
            end
            a1.Cleared = v2
        end
        v1.Settle(a1.Model, a1.Cleared == true)
        return
    end
end

local function characterOf(a1) -- Line: 322 -- upvalues: Players (val)
    local PlayerByUserId = if type(a1) ~= "number" then nil else Players:GetPlayerByUserId(a1)
    if PlayerByUserId then
        return PlayerByUserId.Character
    end
    return nil
end

local function recipeOf(a1) -- Line: 327 -- upvalues: u79 (ref)
    if u79.Ready and type(u79.Recipes) == "table" then
        return u79.Recipes[a1]
    end
    return nil
end

local function play(a1, a2) -- Line: 331 -- upvalues: u83 (ref)
    if u83 and u83 ~= a1 then
        u83.Cancel()
    end
    u83 = a1
    return a1.Begin(a2)
end

local function beginContext(a1, a2, a3, a4, a5, a6) -- Line: 339
    -- upvalues: Players (val), u79 (ref)
    local Character_2, PlayerByUserId_2, v1
    local v2 = {}
    local Sides = a2.Sides
    local v3 = nil
    local v4 = nil
    local v5, v6, v7, v8, v9, v10 = a4, a2, a1, a3, a6, a5
    for i, j in Sides, v3, v4 do
        v1 = if type(v10) ~= "table" then nil else v10[j]
        PlayerByUserId_2 = if type(v1) ~= "number" then nil else Players:GetPlayerByUserId(v1)
        Character_2 = if not PlayerByUserId_2 then nil else PlayerByUserId_2.Character
        v2[j] = Character_2
    end
    local Tier = v5.Tier
    local v11 = if not u79.Ready then nil else if type(u79.Recipes) ~= "table" then nil else u79.Recipes[Tier]
    v3 = nil
    if type(v5.Seats) == "table" then
        local PlayerByUserId, UserId, v12, v13, v14, v15, v16
        v3 = {}
        local v17 = nil
        local v18 = nil
        for k, n in v5.Seats, v17, v18 do
            if type(n) == "table" then
                v12 = {}
                UserId = n.UserId
                PlayerByUserId = if type(UserId) ~= "number" then nil else Players:GetPlayerByUserId(UserId)
                v12.Character = if not PlayerByUserId then nil else PlayerByUserId.Character
                v13 = nil
                v14 = nil
                for m, i5 in v6.Sides, v13, v14 do
                    v15 = n[i5]
                    v16 = if typeof(v15) ~= "Instance" then nil else if not v15:IsA("BasePart") then nil else v15
                    v12[i5] = v16
                end
                table.insert(v3, v12)
            end
        end
    end
    return {
        Shrine = v7,
        Kind = v6,
        Pads = v8,
        Seats = v3,
        Characters = v2,
        LightCharacter = v2.Light,
        DarkCharacter = v2.Dark,
        EndsAt = v5.EndsAt,
        Tier = v5.Tier,
        Recipe = v11,
        FusedCategory = if not v11 then nil else v11.Fused,
        Participant = v9 ~= nil,
        Gui = v9,
    }
end

local function releaseCamera(a1, a2) -- Line: 385 -- types: a2: userdata?
    local CurrentCamera = workspace.CurrentCamera
    if CurrentCamera == a1.Camera and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
        CurrentCamera.CameraType = a1.Type
        CurrentCamera.FieldOfView = a1.FOV
        if a2 then
            CurrentCamera.CFrame = a2
        end
        CurrentCamera.CameraSubject = a1.Subject
    end
end

local function dropBars(a1) -- Line: 397 -- upvalues: TweenService (val)
    local v1, v2
    local v3 = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
    for i, j in {a1.Top, a1.Bottom} do
        v2 = TweenService
        v1 = {Size = UDim2.fromScale(1, 0)}
        v2:Create(j, v3, v1):Play()
    end
    task.delay(0.5, function() -- Line: 402 -- upvalues: a1 (val)
        a1.Gui:Destroy()
    end)
end

local function hideHud(a1) -- Line: 407 -- upvalues: PlayerGui (val)
    a1.HiddenHud = {}
    if not a1.Kind.HideHud then
        return
    end
    for i, j in PlayerGui:GetChildren() do
        if j:IsA("ScreenGui") and j ~= a1.Gui and j.Enabled and j.DisplayOrder < a1.Gui.DisplayOrder then
            j.Enabled = false
            table.insert(a1.HiddenHud, j)
        end
    end
end

local function showHud(a1) -- Line: 425
    for i, j in a1.HiddenHud or {} do
        if j.Parent then
            j.Enabled = true
        end
    end
    a1.HiddenHud = nil
end

local function stopCutscene(a1) -- Line: 434
    -- upvalues: u82 (ref), u84 (ref), LocalPlayer (val), dropBars (val)
    local v1 = u82
    u82 = nil
    if v1 then
        for i, j in v1.HiddenHud or {} do
            if j.Parent then
                j.Enabled = true
            end
        end
        v1.HiddenHud = nil
    end
    if not v1 then
        if a1 == true and u84 then
            local v2 = u84
            u84 = nil
            local CurrentCamera = workspace.CurrentCamera
            if CurrentCamera == v2.Camera and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                CurrentCamera.CameraType = v2.Type
                CurrentCamera.FieldOfView = v2.FOV
                CurrentCamera.CameraSubject = v2.Subject
            end
            v2.Gui:Destroy()
        end
        return
    end
    v1.Help.Visible = false
    local CurrentCamera_2 = workspace.CurrentCamera
    local Character = LocalPlayer.Character
    local HumanoidRootPart = if not Character then nil else Character:FindFirstChild("HumanoidRootPart")
    local Position = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart.Position
    if a1 ~= true
        and CurrentCamera_2 == v1.Camera
        and CurrentCamera_2.CameraType == Enum.CameraType.Scriptable
        and Position
        and not (140 < (Position - CurrentCamera_2.CFrame.Position).Magnitude) then
        u84 = {
            T = 0,
            Camera = v1.Camera,
            Type = v1.Type,
            FOV = v1.FOV,
            Subject = v1.Subject,
            Gui = v1.Gui,
            Top = v1.Top,
            Bottom = v1.Bottom,
            From = CurrentCamera_2.CFrame,
            FromFOV = CurrentCamera_2.FieldOfView,
            Offset = v1.CamOffset,
        }
        return
    end
    local CFrame = v1.CFrame
    local CurrentCamera_3 = workspace.CurrentCamera
    if CurrentCamera_3 == v1.Camera and CurrentCamera_3.CameraType == Enum.CameraType.Scriptable then
        CurrentCamera_3.CameraType = v1.Type
        CurrentCamera_3.FieldOfView = v1.FOV
        if CFrame then
            CurrentCamera_3.CFrame = CFrame
        end
        CurrentCamera_3.CameraSubject = v1.Subject
    end
    if a1 == true then
        v1.Gui:Destroy()
        return
    end
    dropBars(v1)
end

local function startCutscene(a1) -- Line: 482
    -- upvalues: u82 (ref), u84 (ref), LocalPlayer (val), FusionShrines (val), ShrineFusionSequences (val)
    -- upvalues: cinematicGui (val), hideHud (val), u78 (val), beginContext (val), u83 (ref)
    local v1 = u82
    u82 = nil
    if v1 then
        for i, j in v1.HiddenHud or {} do
            if j.Parent then
                j.Enabled = true
            end
        end
        v1.HiddenHud = nil
    end
    if v1 then
        v1.Help.Visible = false
        local CurrentCamera_2 = workspace.CurrentCamera
        local Character = LocalPlayer.Character
        local HumanoidRootPart = if not Character then nil else Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
            local Position = HumanoidRootPart.Position
        end
        local CFrame = v1.CFrame
        local CurrentCamera_3 = workspace.CurrentCamera
        if CurrentCamera_3 == v1.Camera and CurrentCamera_3.CameraType == Enum.CameraType.Scriptable then
            CurrentCamera_3.CameraType = v1.Type
            CurrentCamera_3.FieldOfView = v1.FOV
            if CFrame then
                CurrentCamera_3.CFrame = CFrame
            end
            CurrentCamera_3.CameraSubject = v1.Subject
        end
        v1.Gui:Destroy()
    elseif u84 then
        local v2 = u84
        u84 = nil
        local CurrentCamera = workspace.CurrentCamera
        if CurrentCamera == v2.Camera and CurrentCamera.CameraType == Enum.CameraType.Scriptable then
            CurrentCamera.CameraType = v2.Type
            CurrentCamera.FieldOfView = v2.FOV
            CurrentCamera.CameraSubject = v2.Subject
        end
        v2.Gui:Destroy()
    end
    local Shrine = a1.Shrine
    local CurrentCamera_4 = workspace.CurrentCamera
    if typeof(Shrine) == "Instance" then
        local v3 = workspace
        if Shrine:IsDescendantOf(v3) and CurrentCamera_4 then
            local v4, v5
            v3 = FusionShrines.Of(Shrine)
            if v3 then
                v4 = v3
                v5 = FusionShrines.PadsOf(Shrine, v3)
            else
                v4 = nil
                v5 = nil
            end
            if v4 and v5 then
                v3 = require((ShrineFusionSequences:WaitForChild(v4.Sequence)))
                local v6, v7, v8, v9 = cinematicGui()
                v9.Visible = type(a1.Seats) ~= "table"
                local Character_2 = LocalPlayer.Character
                local HumanoidRootPart_2 = if not Character_2 then nil else Character_2:FindFirstChild("HumanoidRootPart")
                local Position_2 = if not HumanoidRootPart_2 then nil else if not HumanoidRootPart_2:IsA("BasePart") then nil else HumanoidRootPart_2.Position
                local v10 = {
                    Id = a1.SessionId,
                    Tier = a1.Tier,
                    Model = Shrine,
                    Kind = v4,
                    Pads = v5,
                    Sequence = v3,
                    EndsAt = a1.EndsAt,
                    StartedAt = workspace:GetServerTimeNow(),
                    Camera = CurrentCamera_4,
                    Type = CurrentCamera_4.CameraType,
                    FOV = CurrentCamera_4.FieldOfView,
                    CFrame = CurrentCamera_4.CFrame,
                    Subject = CurrentCamera_4.CameraSubject,
                }
                local v11 = if not Position_2 then CurrentCamera_4.CFrame.LookVector * -12 + Vector3.new(0, 4, 0) else CurrentCamera_4.CFrame.Position - Position_2
                v10.CamOffset = v11
                v10.Gui = v6
                v10.Help = v9
                v10.Top = v7
                v10.Bottom = v8
                CurrentCamera_4.CameraType = Enum.CameraType.Scriptable
                CurrentCamera_4.FieldOfView = 56
                hideHud(v10)
                local v12 = u78[Shrine]
                if v12 and v12.BillboardsOn ~= false then
                    v12.BillboardsOn = false
                    for k, n in v12.Billboards do
                        if n.Parent then
                            n.Enabled = false
                        end
                    end
                end
                v10 = beginContext(Shrine, v4, v5, a1, a1.Participants, v6)
                if u83 and u83 ~= v3 then
                    u83.Cancel()
                end
                u83 = v3
                v3.Begin(v10)
                return
            end
            return
        end
    end
end

local function padVisual(a1, a2, a3, a4) -- Line: 541 -- types: a2: string, a3: userdata, a4: number
    local Part_2
    local Vfx = a1.Vfx
    local v1 = a1.Kind.Colors[a2]
    local v2 = a3.Position.Y + a3.Size.Y / 2
    local Part = Instance.new("Part")
    Part.Name = "FusionGlowDisc" .. a2
    Part.Shape = Enum.PartType.Cylinder
    Part.Size = Vector3.new(0.18, Vfx.DiscDiameter, Vfx.DiscDiameter)
    Part.CFrame = (CFrame.new(a3.Position.X, v2 + Vfx.DiscLift, a3.Position.Z)) * CFrame.Angles(0, 0, 1.5707963267948966)
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanTouch = false
    Part.CanQuery = false
    Part.CastShadow = false
    Part.Material = Enum.Material.Neon
    Part.Color = v1
    Part.Transparency = 1
    Part.Parent = a1.Model
    a1.Trove:Add(Part)
    local PointLight = Instance.new("PointLight")
    PointLight.Color = v1
    PointLight.Range = 16
    PointLight.Brightness = 0
    PointLight.Enabled = false
    PointLight.Parent = Part
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    ParticleEmitter.Color = ColorSequence.new(v1)
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.LightInfluence = 0
    ParticleEmitter.Lifetime = NumberRange.new(1.1, 2.2)
    ParticleEmitter.Speed = NumberRange.new(2, 4.5)
    ParticleEmitter.SpreadAngle = Vector2.new(24, 24)
    ParticleEmitter.Acceleration = Vector3.new(0, 1.5, 0)
    ParticleEmitter.EmissionDirection = Enum.NormalId.Right
    ParticleEmitter.Rate = 0
    ParticleEmitter.Enabled = false
    ParticleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.4), (NumberSequenceKeypoint.new(1, 0))})
    ParticleEmitter.Parent = Part
    local v3 = {}
    local OrbCount = Vfx.OrbCount
    for i = 1, OrbCount do
        Part_2 = Instance.new("Part")
        Part_2.Name = "FusionGlowOrb" .. a2
        Part_2.Shape = Enum.PartType.Ball
        Part_2.Size = Vector3.new(1, 1, 1) * Vfx.OrbSize
        Part_2.CFrame = CFrame.new(a3.Position.X, v2 + Vfx.OrbHeight, a3.Position.Z)
        Part_2.Anchored = true
        Part_2.CanCollide = false
        Part_2.CanTouch = false
        Part_2.CanQuery = false
        Part_2.CastShadow = false
        Part_2.Material = Enum.Material.Neon
        Part_2.Color = v1
        Part_2.Transparency = 1
        Part_2.Parent = a1.Model
        a1.Trove:Add(Part_2)
        table.insert(v3, Part_2)
    end
    return {
        DiscT = 1,
        LightT = 0,
        OrbA = 0,
        Pad = a3,
        Disc = Part,
        Glow = PointLight,
        Embers = ParticleEmitter,
        Orbs = v3,
        Top = v2,
        Offset = (a4 - 1) * 2.1,
        Goal = {Disc = 0.62, Breathe = 0.16, Light = 0.7, Orb = 0},
    }
end

local function register(a1) -- Line: 615
    -- upvalues: u78 (val), FusionShrines (val), u77 (val), Trove (val), ShrineFusionStatus (val), PlayerGui (val)
    -- upvalues: FusionShrineHint (val), padVisual (val), ShrinePadPets (val), u82 (ref), stopCutscene (val), u80 (ref)
    -- upvalues: ShrineFusion (val), u79 (ref)
    if not u78[a1] and a1:IsA("Model") then
        local v1 = workspace
        if a1:IsDescendantOf(v1) then
            local v2, v3
            v1 = FusionShrines.Of(a1)
            if v1 then
                v2 = v1
                v3 = FusionShrines.PadsOf(a1, v1)
            else
                v2 = nil
                v3 = nil
            end
            if v2 and v3 then
                v1 = FusionShrines.SlotsOf(a1, v2)
                if v2.Placement and not v1 then
                    return
                end
                local v4 = table.clone(u77)
                for i, j in v2.PadVfx do
                    v4[i] = j
                end
                local v5 = Vector3.new(0, 0, 0)
                local v6 = 0
                for k, n in v3 do
                    v5 = v5 + n.Position
                    v6 = v6 + 1
                end
                local v7 = v5 / math.max(v6, 1)
                v5 = 0
                for m, i5 in v3 do
                    v5 = math.max(v5, (i5.Position - v7).Magnitude)
                end
                v6 = v3[v2.Sides[1]]
                local v8 = v3[v2.Sides[2]]
                local v9 = {
                    BillboardsOn = true,
                    Model = a1,
                    Kind = v2,
                    Pads = v3,
                    Vfx = v4,
                    Trove = Trove.new(),
                }
                v9.Visuals = {}
                v9.Billboards = {}
                v9.Reach = v5 + 100
                v9.Anim = {Center = v7}
                u78[a1] = v9
                v5 = Instance.new("Attachment")
                v5.Name = "FusionStatusAnchor"
                v5.Position = v6.CFrame:PointToObjectSpace(v7)
                v5.Parent = v6
                v9.Trove:Add(v5)
                v9.Status = ShrineFusionStatus.new(v2, v3, v5, PlayerGui, v1)
                v9.Trove:Add(v9.Status)
                for i6, i7 in v9.Status.Guis do
                    table.insert(v9.Billboards, i7)
                end
                local v10 = FusionShrineHint:Clone()
                v10.Name = "PersonalFusionHint"
                v10.Adornee = v5
                v10.ResetOnSpawn = false
                v10.Enabled = false
                if v4.HintHeight then
                    v10.StudsOffsetWorldSpace = Vector3.new(0, v4.HintHeight, 0)
                end
                v10.Parent = PlayerGui
                v9.Trove:Add(v10)
                v9.Hint = v10
                v9.Message = v10:WaitForChild("Guidance")
                v10 = {}
                if not v1 then
                    for i8, i9 in v2.Sides do
                        v9.Visuals[i9] = (padVisual(v9, i9, v3[i9], i8))
                        table.insert(v10, i9)
                    end
                else
                    for i10, i11 in v1 do
                        v9.Visuals[i11.Name] = (padVisual(v9, i11.Side, i11.Pad, i10))
                        table.insert(v10, i11.Name)
                    end
                    v9.PadPets = ShrinePadPets.new(a1, v2, v1, v7)
                    v9.Trove:Add(v9.PadPets)
                end
                v5 = Instance.new("Attachment")
                v5.Parent = v9.Visuals[v10[1]].Disc
                v1 = Instance.new("Attachment")
                v1.Parent = v9.Visuals[v10[2]].Disc
                v3 = Instance.new("Beam")
                v3.Attachment0 = v5
                v3.Attachment1 = v1
                v3.CurveSize0 = v4.ArcCurve
                v3.CurveSize1 = v4.ArcCurve
                v3.Width0 = v4.ArcWidth
                v3.Width1 = v4.ArcWidth
                v3.Segments = 24
                v3.FaceCamera = true
                v3.LightEmission = 1
                v3.LightInfluence = 0
                v3.Color = ColorSequence.new(v2.Colors[v2.Sides[1]], v2.Colors[v2.Sides[2]])
                v3.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.75),
                    NumberSequenceKeypoint.new(0.5, 0.45),
                    (NumberSequenceKeypoint.new(1, 0.75)),
                })
                v3.Parent = v9.Visuals[v10[1]].Disc
                v9.Arc = v3
                local Part = Instance.new("Part")
                Part.Name = "FusionGlowField"
                Part.Size = Vector3.new(v4.FieldSize, 0.2, v4.FieldSize)
                Part.CFrame = CFrame.new(v7.X, (math.min(v6.Position.Y, v8.Position.Y)) + v6.Size.Y / 2 - 0.4, v7.Z)
                Part.Anchored = true
                Part.CanCollide = false
                Part.CanTouch = false
                Part.CanQuery = false
                Part.CastShadow = false
                Part.Transparency = 1
                Part.Parent = a1
                v9.Trove:Add(Part)
                for i12, i13 in v2.Sides do
                    v8 = Instance.new("ParticleEmitter")
                    v8.Texture = "rbxasset://textures/particles/sparkles_main.dds"
                    v8.Color = ColorSequence.new(v2.Colors[i13])
                    v8.LightEmission = 1
                    v8.LightInfluence = 0
                    v8.Lifetime = NumberRange.new(4, 7)
                    v8.Speed = NumberRange.new(0.6, 1.8)
                    v8.Rate = 3.5
                    v8.EmissionDirection = Enum.NormalId.Top
                    v8.Size = NumberSequence.new(0.22)
                    v8.Transparency = NumberSequence.new({
                        NumberSequenceKeypoint.new(0, 1),
                        NumberSequenceKeypoint.new(0.15, 0.3),
                        NumberSequenceKeypoint.new(0.8, 0.4),
                        (NumberSequenceKeypoint.new(1, 1)),
                    })
                    v8.Parent = Part
                end
                v9.Trove:Connect(a1.AncestryChanged, function() -- Line: 744 -- upvalues: a1 (val), u78 (upval), u82 (upval), stopCutscene (upval)
                    local v1 = a1
                    if not v1:IsDescendantOf(workspace) then
                        v1 = a1
                        local v2 = u78[v1]
                        if not v2 then
                            return
                        end
                        u78[v1] = nil
                        v2.Trove:Destroy()
                        if u82 and u82.Model == v1 then
                            stopCutscene()
                        end
                    end
                end)
                if u80 then
                    return
                end
                u80 = true
                task.spawn(function() -- Line: 286 -- upvalues: ShrineFusion (upval), u79 (upval), u80 (upval)
                    local success, err, v1 = pcall(function() -- Line: 287 -- upvalues: ShrineFusion (upval)
                        return ShrineFusion.AskState:InvokeServer()
                    end)
                    if success and err and type(v1) == "table" then
                        u79 = v1
                    end
                    u80 = false
                end)
                return
            end
            return
        end
    end
end

ShrineFusion.Feedback.OnClientEvent:Connect(function(a1) -- Line: 752 -- upvalues: u85 (ref)
    if type(a1) == "table" and type(a1.Message) == "string" then
        u85 = {Message = a1.Message, Until = os.clock() + 4}
    end
end)
ShrineFusion.Ritual.OnClientEvent:Connect(function(a1) -- Line: 758
    -- upvalues: startCutscene (val), u82 (ref), u78 (val), u80 (ref), ShrineFusion (val), u79 (ref), u83 (ref)
    -- upvalues: stopCutscene (val)
    if type(a1) ~= "table" then
        return
    end
    if a1.Phase == "Started" then
        startCutscene(a1)
        return
    end
    if u82 and u82.Id ~= a1.SessionId then
        return
    end
    if a1.Phase ~= "Completed" then
        if u83 then
            u83.Cancel()
        end
        stopCutscene()
        return
    end
    local v1 = if not u82 then nil else u78[u82.Model]
    if v1 then
        v1.Cleared = true
    end
    if not u80 then
        u80 = true
        task.spawn(function() -- Line: 286 -- upvalues: ShrineFusion (upval), u79 (upval), u80 (upval)
            local success, err, v1 = pcall(function() -- Line: 287 -- upvalues: ShrineFusion (upval)
                return ShrineFusion.AskState:InvokeServer()
            end)
            if success and err and type(v1) == "table" then
                u79 = v1
            end
            u80 = false
        end)
    end
    if u82 then
        u82.PayoffAt = workspace:GetServerTimeNow()
        u82.Help.Visible = false
    end
    if u83 and u83.Payoff(stopCutscene) then
        return
    end
    stopCutscene()
end)
ShrineFusion.StateChanged.OnClientEvent:Connect(function(a1, a2) -- Line: 787
    -- upvalues: u82 (ref), u83 (ref), FusionShrines (val), ShrineFusionSequences (val), beginContext (val)
    local v1 = a2
    if type(v1) == "table" and typeof(a1) == "Instance" then
        if a2.Phase == "Ritual" then
            task.defer(function() -- Line: 792
                -- upvalues: u82 (upval), u83 (upval), a1 (val), FusionShrines (upval), a2 (ref)
                -- upvalues: ShrineFusionSequences (upval), beginContext (upval)
                if not u82 then
                    if u83 and u83.IsPlaying() then
                        return
                    end
                    local v1 = a1
                    local v2 = workspace
                    if v1:IsDescendantOf(v2) then
                        local v3
                        v2 = a1
                        local v4 = FusionShrines.Of(v2)
                        if v4 then
                            v1 = v4
                            v3 = FusionShrines.PadsOf(v2, v4)
                        else
                            v1 = nil
                            v3 = nil
                        end
                        if v1 and v3 then
                            v2 = {}
                            local v5 = nil
                            local v6 = nil
                            for i, j in v3, v5, v6 do
                                v2[i] = (j:GetAttribute("FusionUserId"))
                            end
                            v4 = FusionShrines.SlotsOf(a1, v1)
                            if v4 then
                                local Attribute
                                v5 = {}
                                v6 = {}
                                local v7 = nil
                                local v8 = nil
                                for k, n in v4, v7, v8 do
                                    Attribute = n.Pad:GetAttribute("PlacedUserId")
                                    if type(Attribute) == "number" then
                                        if not v5[Attribute] then
                                            v5[Attribute] = {UserId = Attribute}
                                            table.insert(v6, v5[Attribute])
                                        end
                                        v5[Attribute][n.Side] = n.Pad
                                    end
                                end
                                a2 = table.clone(a2)
                                a2.Seats = v6
                            end
                            v5 = require((ShrineFusionSequences:WaitForChild(v1.Sequence)))
                            v6 = beginContext(a1, v1, v3, a2, v2, nil)
                            if u83 and u83 ~= v5 then
                                u83.Cancel()
                            end
                            u83 = v5
                            v5.Begin(v6)
                            return
                        end
                        return
                    end
                end
            end)
        elseif a2.Phase ~= "Committing" then
            if a2.Phase == "Idle" and not u82 and u83 and u83.IsPlaying() and not u83.IsResolving() then
                u83.Cancel()
            end
        elseif not u82 and u83 and u83.IsPlaying() then
            u83.Payoff()
        end
        return
    end
end)
LocalPlayer.CharacterAdded:Connect(function() -- Line: 841 -- upvalues: u83 (ref), stopCutscene (val)
    if u83 then
        u83.Cancel()
    end
    stopCutscene()
end)

local function stepPads(a1, a2, a3) -- Line: 848 -- types: a2: number, a3: number
    local DiscT, Goal, LightT, OrbA, new, v1, v2, v3, v4, v5, v6, v7
    local Vfx = a1.Vfx
    local v8 = 1 - math.exp(-a3 * Vfx.Approach)
    local v9 = nil
    local v10 = nil
    local v11 = a2
    for i, j in a1.Visuals, v9, v10 do
        Goal = j.Goal
        v2 = ((math.sin(v11 * Vfx.Breathe + j.Offset)) + 1) * 0.5
        DiscT = j.DiscT
        j.DiscT = DiscT + (Goal.Disc + Goal.Breathe * v2 - DiscT) * v8
        j.Disc.Transparency = j.DiscT
        LightT = j.LightT
        j.LightT = LightT + (Goal.Light - LightT) * v8
        j.Glow.Brightness = j.LightT
        j.Glow.Enabled = 0.05 < j.LightT
        OrbA = j.OrbA
        j.OrbA = OrbA + (Goal.Orb - OrbA) * v8
        v2 = 0.02 < j.OrbA
        v3 = nil
        v4 = nil
        for k, n in j.Orbs, v3, v4 do
            if v2 then
                v1 = v11 * Vfx.OrbSpeed + j.Offset + k * (6.283185307179586 / #j.Orbs)
                v5 = Vfx.OrbRadius * (0.55 + 0.45 * j.OrbA)
                new = CFrame.new
                v6 = j.Pad.Position.X + math.cos(v1) * v5
                v7 = j.Top + Vfx.OrbHeight + (math.sin(v11 * 2.3 + k * 1.7)) * Vfx.OrbBob
                n.CFrame = new(v6, v7, j.Pad.Position.Z + math.sin(v1) * v5)
            end
            n.Transparency = 1 - j.OrbA * 0.85
        end
    end
end

local function padGoals(a1, a2, a3) -- Line: 878 -- types: a3: boolean
    local Goal, v1, v2
    local v3 = a2 ~= "Disabled"
    local v4 = nil
    local v5 = nil
    for i, j in a1.Visuals, v4, v5 do
        v1 = j.Pad:GetAttribute("FusionActive") == true
        if v1 then
            v1 = true
            if v6 ~= "Ritual" then
                v1 = v6 == "Committing"
            end
        end
        Goal = j.Goal
        if v7 then
            Goal.Disc = 0.75
            Goal.Breathe = 0.08
            Goal.Light = 0.5
            Goal.Orb = 0
            j.Embers.Rate = 0
        elseif not v3 then
            Goal.Disc = 0.93
            Goal.Breathe = 0.03
            Goal.Light = 0
            Goal.Orb = 0
            j.Embers.Rate = 0
        elseif v1 then
            Goal.Disc = 0.12
            Goal.Breathe = 0.05
            Goal.Light = 3
            Goal.Orb = 1
            j.Embers.Rate = 26
        elseif not v2 then
            Goal.Disc = 0.62
            Goal.Breathe = 0.16
            Goal.Light = 0.7
            Goal.Orb = 0
            j.Embers.Rate = 4
        else
            Goal.Disc = 0.3
            Goal.Breathe = 0.08
            Goal.Light = 1.8
            Goal.Orb = 1
            j.Embers.Rate = 15
        end
        j.Embers.Enabled = 0 < j.Embers.Rate
    end
end

local function guidanceFor(a1, a2, a3) -- Line: 904
    -- upvalues: u79 (ref), u85 (ref), ShrinePadZone (val)
    local v1
    if a1.PadPets then
        v1 = false
        if a3 ~= nil then
            v1 = (a3.Position - a1.Anim.Center).Magnitude < a1.Reach
        end
        if not v1 then
            return nil
        end
        if u79.Ready and not u79.Enabled then
            return "Shrine unavailable. Try again later."
        end
        if a2 == "Mismatch" then
            return a1.Kind.Copy.Mismatch
        end
        if u85 then
            local Until = u85.Until
            if os.clock() < Until then
                return u85.Message
            end
        end
        return nil
    end
    v1 = nil
    if a3 then
        for i, j in a1.Kind.Sides do
            if ShrinePadZone.ContainsPoint(a1.Pads[j], a3.Position) then
                v1 = j
                break
            end
        end
    end
    if u79.Ready and not u79.Enabled then
        return "Shrine unavailable. Try again later."
    end
    if u79.Ready then
        local v2 = next
        local Recipes = u79.Recipes or {}
        if v2(Recipes) == nil then
            return "Shrine not ready. Try again later."
        end
    end
    if a2 == "Mismatch" then
        return a1.Kind.Copy.Mismatch
    end
    if v1 and u85 then
        local Until_2 = u85.Until
        if os.clock() < Until_2 then
            return u85.Message
        end
    end
    if v1 then
        return a1.Kind.Copy.Hold(v1, u79.Recipes)
    end
    return nil
end

local function intact(a1, a2) -- Line: 941 -- types: a1: userdata
    if not a1:IsDescendantOf(workspace) then
        return false
    end
    for i, j in a2.Pads do
        if not j:IsDescendantOf(a1) then
            return false
        end
    end
    return true
end

local u139 = 0
RunService.RenderStepped:Connect(function(a1) -- Line: 954
    -- upvalues: u82 (ref), stopCutscene (val), camFrame (val), shotRig (val), u84 (ref), dropBars (val)
    -- upvalues: LocalPlayer (val), u78 (val), u83 (ref), stepPads (val), u139 (ref), intact (val), padGoals (val)
    -- upvalues: u79 (ref), ShrineFusionSequences (val), guidanceFor (val), u81 (ref), u80 (ref), ShrineFusion (val)
    local Arc, Attribute, BillboardsOn, Hint, Kind, Kind_2, PadPets_2, Status_3, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    if u82 then
        local CurrentCamera = workspace.CurrentCamera
        local ServerTimeNow = workspace:GetServerTimeNow()
        if CurrentCamera ~= u82.Camera then
            stopCutscene()
        else
            local Model = u82.Model
            v9 = workspace
            if not Model:IsDescendantOf(v9) then
                stopCutscene()
            elseif not (u82.EndsAt + 5 < ServerTimeNow) or u82.Sequence.IsResolving() then
                v7 = nil
                v8 = nil
                if u82.Sequence.Camera then
                    v9, v10 = u82.Sequence.Camera(ServerTimeNow, a1)
                    v7 = v9
                    v8 = v10
                end
                if not v7 then
                    v9, v10 = camFrame(u82, shotRig(u82), ServerTimeNow, a1)
                    v7 = v9
                    v8 = v10
                end
                CurrentCamera.CFrame = v7
                CurrentCamera.FieldOfView = v8
            else
                stopCutscene()
            end
        end
    end
    if u84 then
        v1 = u84
        local CurrentCamera_2 = workspace.CurrentCamera
        if CurrentCamera_2 ~= v1.Camera then
            u84 = nil
            dropBars(v1)
        elseif CurrentCamera_2.CameraType == Enum.CameraType.Scriptable then
            v1.T = v1.T + a1
            v9 = math.clamp(math.clamp(v1.T / 0.9, 0, 1), 0, 1)
            v7 = v9 * v9 * (3 - v9 * 2)
            local Character = LocalPlayer.Character
            local HumanoidRootPart = if not Character then nil else Character:FindFirstChild("HumanoidRootPart")
            local Position = (if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart.Position) or v1.From.Position - v1.Offset
            CurrentCamera_2.CFrame = v1.From:Lerp(CFrame.lookAt(Position + v1.Offset, Position + Vector3.new(0, 2.200000047683716, 0)), v7)
            local FromFOV = v1.FromFOV
            CurrentCamera_2.FieldOfView = FromFOV + (v1.FOV - FromFOV) * v7
            if v7 >= 1 then
                u84 = nil
                local CurrentCamera_3 = workspace.CurrentCamera
                if CurrentCamera_3 == v1.Camera and CurrentCamera_3.CameraType == Enum.CameraType.Scriptable then
                    CurrentCamera_3.CameraType = v1.Type
                    CurrentCamera_3.FieldOfView = v1.FOV
                    CurrentCamera_3.CameraSubject = v1.Subject
                end
                dropBars(v1)
            end
        else
            u84 = nil
            dropBars(v1)
        end
    end
    local CurrentCamera_4 = workspace.CurrentCamera
    if CurrentCamera_4 then
        local PadPets
        v6 = os.clock()
        v9 = nil
        v10 = nil
        for i, j in u78, v9, v10 do
            if j.PadPets then
                PadPets = j.PadPets
                v3 = false
                if u83 ~= nil then
                    v3 = u83.ActiveShrine() == j.Model
                end
                PadPets:SetHidden(v3)
            end
            if (CurrentCamera_4.CFrame.Position - j.Anim.Center).Magnitude <= j.Vfx.AnimDistance + j.Reach - 100 then
                stepPads(j, v6, a1)
                if j.PadPets then
                    j.PadPets:Step(v6, a1)
                end
            end
        end
    end
    u139 = u139 + a1
    if u139 < 0.2 then
        return
    end
    u139 = 0
    local Character_2 = LocalPlayer.Character
    local HumanoidRootPart_2 = if not Character_2 then nil else Character_2:FindFirstChild("HumanoidRootPart")
    v1 = if not HumanoidRootPart_2 then nil else if not HumanoidRootPart_2:IsA("BasePart") then nil else HumanoidRootPart_2
    v6 = false
    v7 = u78
    v8 = nil
    v9 = nil
    for k, n in v7, v8, v9 do
        if intact(k, n) then
            v11 = false
            if u83 ~= nil then
                v11 = u83.ActiveShrine() == k
            end
            v12 = not v11
            if n.BillboardsOn ~= v12 then
                n.BillboardsOn = v12
                for m, i5 in n.Billboards do
                    if i5.Parent then
                        i5.Enabled = v12
                    end
                end
            end
            Attribute = k:GetAttribute("FusionPhase")
            Arc = n.Arc
            v3 = false
            if 0 < n.Vfx.ArcWidth then
                v3 = not v11 and Attribute ~= "Disabled"
            end
            Arc.Enabled = v3
            padGoals(n, Attribute, v11)
            if n.PadPets then
                PadPets_2 = n.PadPets
                v5 = v11
                if not v5 then
                    v5 = true
                    if Attribute ~= "Ritual" then
                        v5 = true
                        if Attribute ~= "Committing" then
                            v5 = Attribute == "Disabled"
                        end
                    end
                end
                PadPets_2:UpdatePrompts(u79, v5)
            end
            v4 = u79
            n.Status:Update(v4)
            Kind = n.Kind
            v2 = require((ShrineFusionSequences:WaitForChild(Kind.Sequence)))
            if v2.Settle and not v11 and u79.Ready then
                if n.Settled ~= u79 then
                    n.Settled = u79
                    Kind_2 = n.Kind
                    Status_3 = if not u79.Ready then nil else if type(u79.Status) ~= "table" then nil else u79.Status
                    if Status_3 then
                        for i6, i7 in Kind_2.Tiers do
                            if Status_3[i7] ~= "COMPLETED" then
                                n.Cleared = false
                                v2.Settle(n.Model, n.Cleared == true)
                                v11 = guidanceFor(n, Attribute, v1)
                                n.Message.Text = v11 or ""
                                Hint = n.Hint
                                BillboardsOn = n.BillboardsOn and v11 ~= nil
                                Hint.Enabled = BillboardsOn
                                if v1 and (v1.Position - n.Anim.Center).Magnitude < n.Reach then
                                    v6 = true
                                end
                                break
                            end
                        end
                        v3 = true
                    else
                        v3 = false
                    end
                    n.Cleared = v3
                end
                v2.Settle(n.Model, n.Cleared == true)
            end
            v11 = guidanceFor(n, Attribute, v1)
            n.Message.Text = v11 or ""
            Hint = n.Hint
            BillboardsOn = n.BillboardsOn and v11 ~= nil
            Hint.Enabled = BillboardsOn
            if v1 and (v1.Position - n.Anim.Center).Magnitude < n.Reach then
                v6 = true
            end
        else
            v11 = u78[k]
            if v11 then
                u78[k] = nil
                v11.Trove:Destroy()
                if u82 and u82.Model == k then
                    stopCutscene()
                end
            end
        end
    end
    if v6 then
        v7 = os.clock()
        if u81 <= v7 then
            u81 = os.clock() + 5
            if u80 then
                return
            end
            u80 = true
            task.spawn(function() -- Line: 286 -- upvalues: ShrineFusion (upval), u79 (upval), u80 (upval)
                local success, err, v1 = pcall(function() -- Line: 287 -- upvalues: ShrineFusion (upval)
                    return ShrineFusion.AskState:InvokeServer()
                end)
                if success and err and type(v1) == "table" then
                    u79 = v1
                end
                u80 = false
            end)
        end
    end
end)
;(CollectionService:GetInstanceAddedSignal("ShrineFusion")):Connect(register)
;(CollectionService:GetInstanceRemovedSignal("ShrineFusion")):Connect(function(a1) -- Line: 529 -- upvalues: u78 (val), u82 (ref), stopCutscene (val) -- types: a1: userdata
    local v1 = u78[a1]
    if not v1 then
        return
    end
    u78[a1] = nil
    v1.Trove:Destroy()
    if u82 and u82.Model == a1 then
        stopCutscene()
    end
end)
workspace.DescendantAdded:Connect(function(a1) -- Line: 1058 -- upvalues: CollectionService (val), register (val)
    local Parent = a1.Parent
    if a1:IsA("BasePart") and Parent and CollectionService:HasTag(Parent, "ShrineFusion") then
        task.defer(register, Parent)
    end
end)
for i, j in CollectionService:GetTagged("ShrineFusion") do
    register(j)
end
return (table.freeze({}))