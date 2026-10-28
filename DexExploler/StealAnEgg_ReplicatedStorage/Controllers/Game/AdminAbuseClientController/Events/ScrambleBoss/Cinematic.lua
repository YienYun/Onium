-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ScrambleBoss.Cinematic
-- Decompile time: 16.97 ms

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local u39 = require(script.Parent.Kit)
local Vfx = require(script.Parent.Vfx)
local u49 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u54 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local u55 = {0, 3.141592653589793, 0.7853981633974483, -0.7853981633974483, 3.9269908169872414, 2.356194490192345}

local function flat(a1) -- Line: 45 -- types: a1: vector
    return (Vector3.new(a1.X, 0, a1.Z))
end

local function visibleBounds(a1) -- Line: 49 -- types: a1: userdata?
    if a1 ~= nil and a1.Parent ~= nil then
        local CFrame, v1, v2, v3
        local v4 = nil
        local v5 = nil
        for i, j in a1:GetDescendants() do
            if j:IsA("BasePart") and not (1 <= j.Transparency) then
                CFrame = j.CFrame
                v3 = j.Size / 2
                v1 = (CFrame.XVector:Abs()) * v3.X + (CFrame.YVector:Abs()) * v3.Y + (CFrame.ZVector:Abs()) * v3.Z
                v3 = CFrame.Position - v1
                v2 = CFrame.Position + v1
                v4 = if not v4 then v3 else v4:Min(v3)
                v5 = if not v5 then v2 else v5:Max(v2)
            end
        end
        return v4, v5
    end
    return nil, nil
end

local function subjectCorners(a1, a2) -- Line: 78 -- upvalues: visibleBounds (val) -- types: a1: table, a2: table
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    table.clear(a2)
    local v10 = nil
    local v11 = nil
    local v12 = nil
    local v13 = nil
    for i, j in a1, v12, v13 do
        v9, v1 = visibleBounds(j.Model)
        if v9 == nil or v1 == nil then
            v9 = j.Fallback - Vector3.new(1.5, 0, 1.5)
            v1 = v9 + Vector3.new(3, 5, 3)
        end
        v2 = v9
        v9 = v1
        v3 = {v2.X, v9.X}
        v4 = nil
        v5 = nil
        for k, n in v3, v4, v5 do
            v6 = {v2.Y, v9.Y}
            v7 = nil
            v8 = nil
            for m, i5 in v6, v7, v8 do
                for i6, i7 in {v2.Z, v9.Z} do
                    table.insert(a2, (Vector3.new(n, i5, i7)))
                end
            end
        end
        v10 = if not v10 then v2 else v10:Min(v2)
        v11 = if not v11 then v9 else v11:Max(v9)
    end
    return (v10 + v11) / 2
end

local function frameBasis(a1, a2) -- Line: 109 -- types: a1: vector, a2: vector
    return CFrame.lookAt(a1 + (a2 * 0.9781476007338057 + Vector3.new(0, 0.2079116851091385, 0)), a1)
end

local function fitDistance(a1, a2, a3, a4, a5) -- Line: 115
    -- upvalues: 
    local v1, v2
    local v3 = math.tan((math.rad(a4)) / 2)
    local v4 = v3 * a5
    local v5 = 6
    for i, j in a1 do
        v1 = j - a2
        v2 = -v1:Dot(a3.LookVector)
        v5 = math.max(v5, (math.abs((v1:Dot(a3.RightVector)))) / (v4 * 0.8) + v2, (math.abs((v1:Dot(a3.UpVector)))) / (v3 * 0.42) + v2)
    end
    return v5 * 1.12
end

local function freeDistance(a1, a2, a3, a4) -- Line: 138
    -- upvalues: Workspace (val)
    local Instance, v1
    local v2 = RaycastParams.new()
    v2.FilterType = Enum.RaycastFilterType.Exclude
    v2.FilterDescendantsInstances = a4
    for i = 1, 8 do
        v1 = Workspace:Raycast(a1, a2 * a3, v2)
        if v1 == nil then
            return a3
        end
        Instance = v1.Instance
        if Instance:IsA("BasePart") and 0.9 <= Instance.Transparency then
            v2:AddToFilter(Instance)
            continue
        end
        return v1.Distance
    end
    return a3
end

local function yawed(a1, a2) -- Line: 165 -- types: a1: vector, a2: number
    return (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), a2)):VectorToWorldSpace(a1)
end

local function setBars(a1, a2) -- Line: 169
    -- upvalues: u49 (val), u54 (val), TweenService (val)
    local BarTop = a1:FindFirstChild("BarTop")
    local BarBottom = a1:FindFirstChild("BarBottom")
    if BarTop ~= nil and BarBottom ~= nil then
        local v1
        BarTop.Visible = true
        BarBottom.Visible = true
        TweenService:Create(BarTop, if not a2 then u54 else u49, {Position = UDim2.fromScale(0, if not a2 then -0.13 else 0)}):Play()
        TweenService:Create(BarBottom, v1, {Position = UDim2.fromScale(0, if not a2 then 1 else 0.87)}):Play()
        return
    end
end

local function freezeCharacter(a1) -- Line: 187 -- types: a1: userdata?
    local u1 = {}
    local Animator = a1 and a1:FindFirstChildWhichIsA("Animator", true)
    if Animator then
        for i, j in Animator:GetPlayingAnimationTracks() do
            j:AdjustSpeed(0)
            table.insert(u1, j)
        end
    end
    return function() -- Line: 197 -- upvalues: u1 (val)
        for i, j in u1 do
            j:AdjustSpeed(1)
        end
    end
end

local function attachTrail(a1, a2) -- Line: 204 -- upvalues: Vfx (val) -- types: a1: userdata?
    local PrimaryPart = a1 and a1.PrimaryPart
    if a1 ~= nil and PrimaryPart ~= nil then
        local BoundingBox_2
        _, BoundingBox_2 = a1:GetBoundingBox()
        for i, j in Vfx.Trail(PrimaryPart, BoundingBox_2.X) do
            a2:Add(j)
        end
        return
    end
end

local function hideBystanders(a1, a2) -- Line: 216 -- upvalues: Players (val), RunService (val) -- types: a1: userdata?
    local u2 = {}
    local u3 = {}
    local u4 = {}
    local u5 = false

    local function hide() -- Line: 222 -- upvalues: Players (upval), a1 (val), u2 (val), u3 (val), u4 (val)
        local Character
        for i, j in Players:GetPlayers() do
            Character = j.Character
            if j ~= a1 and Character ~= nil then
                for k, n in Character:GetDescendants() do
                    if n:IsA("BasePart") or n:IsA("Decal") then
                        if u2[n] == nil then
                            u2[n] = n.LocalTransparencyModifier
                        end
                        n.LocalTransparencyModifier = 1
                    elseif not n:IsA("BillboardGui") then
                        if n:IsA("Humanoid") and u4[n] == nil then
                            u4[n] = n.DisplayDistanceType
                            n.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                        end
                    elseif u3[n] == nil then
                        u3[n] = n.Enabled
                        n.Enabled = false
                    elseif n:IsA("Humanoid") and u4[n] == nil then
                        u4[n] = n.DisplayDistanceType
                        n.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                    end
                end
            end
        end
    end

    local function restore() -- Line: 246 -- upvalues: u5 (ref), RunService (upval), u2 (val), u3 (val), u4 (val)
        if u5 then
            return
        end
        u5 = true
        RunService:UnbindFromRenderStep("ScrambleFinalHitHide")
        for i, j in u2 do
            i.LocalTransparencyModifier = j
        end
        for k, n in u3 do
            k.Enabled = n
        end
        for m, i5 in u4 do
            m.DisplayDistanceType = i5
        end
    end

    hide()
    RunService:BindToRenderStep("ScrambleFinalHitHide", Enum.RenderPriority.Camera.Value + 1, hide)
    a2:Add(restore)
    task.delay(7.2, restore)
end

return {
    FinalHit = function(a1, a2, a3, a4) -- Line: 272
        -- upvalues: Workspace (val), Players (val), Lighting (val), HiddenUIHandler (val), setBars (val)
        -- upvalues: hideBystanders (val), freezeCharacter (val), u39 (val), Vfx (val), subjectCorners (val)
        -- upvalues: visibleBounds (val), u55 (val), fitDistance (val), freeDistance (val), RunService (val)
        -- upvalues: attachTrail (val), TweenService (val)
        local Position, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera == nil then
            return
        end
        local PlayerByUserId = Players:GetPlayerByUserId(a4.UserId or 0)
        local v12 = a4.At or Vector3.new(0, 0, 0)
        local v13 = a4.From or v12
        local v14 = v12 - v13
        local v15 = Vector3.new(v14.X, 0, v14.Z)
        if v15.Magnitude < 0.1 then
            v15 = Vector3.new(0, 0, 1)
        end
        local Unit = v15.Unit
        v14 = Unit:Cross((Vector3.new(0, 1, 0)))
        local CameraType = CurrentCamera.CameraType
        local FieldOfView = CurrentCamera.FieldOfView
        local CameraSubject = CurrentCamera.CameraSubject
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
        ColorCorrectionEffect.Name = "ScrambleFinalHit"
        ColorCorrectionEffect.Parent = Lighting
        local BlurEffect = Instance.new("BlurEffect")
        BlurEffect.Name = "ScrambleFinalHitBlur"
        BlurEffect.Size = 0
        BlurEffect.Parent = Lighting
        local v16 = a1:Extend()
        local v17 = HiddenUIHandler.Acquire()
        v16:Add(ColorCorrectionEffect)
        v16:Add(BlurEffect)
        v16:Add(v17)
        v16:Add(function() -- Line: 310
            -- upvalues: CurrentCamera (val), CameraType (val), FieldOfView (val), CameraSubject (val), setBars (upval)
            -- upvalues: a3 (val)
            CurrentCamera.CameraType = CameraType
            CurrentCamera.FieldOfView = FieldOfView
            if CameraSubject and CameraSubject.Parent then
                CurrentCamera.CameraSubject = CameraSubject
            end
            setBars(a3.Gui, false)
        end)
        local ScrambleHuman = a2:FindFirstChild("ScrambleHuman")
        hideBystanders(PlayerByUserId, v16)
        local v18 = freezeCharacter(PlayerByUserId and PlayerByUserId.Character)
        v16:Add(v18)
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        setBars(a3.Gui, true)
        a3:FlashScreen(Color3.new(1, 1, 1), 0.3, 1)
        u39.Sound("FinalHit", nil, 1.5)
        u39.Sound("Boom", nil, 1.2, 0.8)
        ColorCorrectionEffect.Saturation = -1
        ColorCorrectionEffect.Contrast = 0.9
        BlurEffect.Size = 6
        task.delay(0.14, function() -- Line: 332 -- upvalues: ColorCorrectionEffect (val), BlurEffect (val)
            ColorCorrectionEffect.Saturation = 0.35
            ColorCorrectionEffect.Contrast = 0.25
            BlurEffect.Size = 0
        end)
        Vfx.Burst("SpiderSlashes", Vfx.Frame("SpiderSlashes", v12, Unit), 0.8, 0.3)
        a3:Say(if not PlayerByUserId then "FINAL HIT!" else ("%*!"):format((string.upper(PlayerByUserId.DisplayName))), "FINAL HIT", 2.4)
        local v19 = {
            {
                Model = PlayerByUserId and PlayerByUserId.Character,
                Fallback = v13 - Vector3.new(0, 3, 0),
            },
            {Model = ScrambleHuman, Fallback = v12},
        }
        v13 = {}
        for i, j in Players:GetPlayers() do
            if j.Character then
                table.insert(v13, j.Character)
            end
        end
        if ScrambleHuman then
            table.insert(v13, ScrambleHuman)
        end
        local v20 = {}
        local v21 = subjectCorners(v19, v20)
        local v22 = CurrentCamera.ViewportSize.X / math.max(CurrentCamera.ViewportSize.Y, 1)
        local v23 = v19[2].Fallback - v19[1].Fallback
        local v24 = Vector3.new(v23.X, 0, v23.Z)
        if ScrambleHuman and PlayerByUserId and PlayerByUserId.Character then
            v23, v1 = visibleBounds(ScrambleHuman)
            v2, v3 = visibleBounds(PlayerByUserId.Character)
            if v23 and v1 and v2 and v3 then
                v4 = (v23 + v1) / 2 - (v2 + v3) / 2
                v24 = Vector3.new(v4.X, 0, v4.Z)
            end
        end
        v24 = if not (0.1 < v24.Magnitude) then v14 else v24.Unit:Cross((Vector3.new(0, 1, 0)))
        v23 = -1
        v1 = 38
        v3 = nil
        v4 = nil
        for k, n in u55, v3, v4 do
            v7 = (CFrame.fromAxisAngle(Vector3.new(0, 1, 0), n)):VectorToWorldSpace(v11)
            v8 = CFrame.lookAt(v21 + (v7 * 0.9781476007338057 + Vector3.new(0, 0.2079116851091385, 0)), v21)
            v9 = fitDistance(v20, v21, v8, 38, v22)
            v10 = freeDistance(v21, -v8.LookVector, v9 + 2, v13)
            if v9 + 0.75 <= v10 then
                v24 = v7
                v23 = v10
                break
            end
            if v23 < v10 then
                v24 = v7
                v23 = v10
            end
        end
        while v1 < 80 do
            if fitDistance(v20, v21, CFrame.lookAt(v21 + (v24 * 0.9781476007338057 + Vector3.new(0, 0.2079116851091385, 0)), v21), v1, v22) + 0.75 <= v23 then
                break
            end
            v1 = v1 + 4
        end
        v23 = math.max(52, v1)
        v2 = os.clock()
        while true do
            if not (os.clock() - v2 < 2.6) then
                break
            end
            v4 = 1 - (1 - (os.clock() - v2) / 2.6) ^ 3
            v21 = v21:Lerp(subjectCorners(v19, v20), 0.25)
            v3 = v23 + (v1 - v23) * v4
            v9 = 0.2792526803190927 * (0.5 - v4)
            v5 = CFrame.lookAt(
                v21 + ((CFrame.fromAxisAngle(Vector3.new(0, 1, 0), v9)):VectorToWorldSpace(v24) * 0.9781476007338057 + Vector3.new(0, 0.2079116851091385, 0)),
                v21
            )
            v6 = -v5.LookVector
            v7 = fitDistance(v20, v21, v5, v3, v22)
            v7 = math.max(math.min(v7, (freeDistance(v21, v6, v7 + 1, v13)) - 0.75), 1)
            v8 = math.tan((math.rad(v3)) / 2)
            CurrentCamera.CFrame = (CFrame.lookAt(v21 + v6 * v7, v21 - v5.UpVector * (v8 * 0.3 * v7))) * CFrame.Angles(0, 0, (math.rad(-4 - v4 * 5)))
            CurrentCamera.FieldOfView = v3
            RunService.RenderStepped:Wait()
        end
        v18()
        ColorCorrectionEffect.Saturation = 0.2
        ColorCorrectionEffect.Contrast = 0.1
        a3:FlashScreen(Color3.new(1, 1, 1), 0.25, 0.6)
        u39.Shake(10, 18, 1.4)
        Vfx.Burst("Slam", CFrame.new(Vfx.Ground(v12, a2:GetAttribute("FloorY"))), 0.6)
        Vfx.Burst("SpiderSlashes", Vfx.Frame("SpiderSlashes", v12, Unit), 0.8, 0.4)
        attachTrail(ScrambleHuman, v16)
        a3:Say("BYE BYE SCRAMBLE!", nil, 2.5)
        v2 = os.clock()
        local CFrame_2 = CurrentCamera.CFrame
        while true do
            if not (os.clock() - v2 < 1.6) then
                break
            end
            v23 = (os.clock() - v2) / 1.6
            CFrame_2 = CFrame_2:Lerp(CFrame.lookAt(
                (if not ScrambleHuman then v12 else if not ScrambleHuman.PrimaryPart then v12 else ScrambleHuman.PrimaryPart.Position) - Unit * (40 + v23 * 30) + Vector3.new(0, 12 + v23 * 16, 0) + v14 * 16,
                Position
            ), 0.18)
            CurrentCamera.CFrame = CFrame_2
            CurrentCamera.FieldOfView = math.min(CurrentCamera.FieldOfView + 1.2, 62)
            RunService.RenderStepped:Wait()
        end
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {Saturation = 0, Contrast = 0}):Play()
        v16:Destroy()
    end,
}