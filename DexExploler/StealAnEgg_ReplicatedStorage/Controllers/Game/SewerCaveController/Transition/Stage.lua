-- Script path: ReplicatedStorage.Controllers.Game.SewerCaveController.Transition.Stage
-- Decompile time: 11.33 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Double = require(script.Parent.Double)
local Transition = require(script.Parent.Parent.Parent.HalloweenDimensionController.Transition)
local Kit = require(script.Parent.Kit)
local Overlay = require(script.Parent.Overlay)
local Score = require(script.Parent.Score)
local SewerCave = require(ReplicatedStorage.Shared.Util.SewerCave)
local Splash = require(script.Parent.Splash)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u65 = Enum.RenderPriority.Camera.Value + 1
local u66 = {}
u66.Core = Color3.fromRGB(6, 70, 74)
u66.Edge = Color3.fromRGB(2, 16, 20)
u66.Shade = Color3.fromRGB(64, 196, 186)
u66.Embers = {
    Color3.fromRGB(120, 230, 214),
    Color3.fromRGB(60, 170, 190),
    (Color3.fromRGB(200, 250, 240)),
}
u66.Veil = Color3.fromRGB(2, 16, 20)
u66.VeilTint = ColorSequence.new(Color3.fromRGB(12, 120, 120), Color3.new(1, 1, 1))
u66.PuffTint = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(150, 180, 178))
local u127 = nil
local u128 = {Palette = u66, CoverTimeout = 20}

local function restoreCamera(a1) -- Line: 104 -- types: a1: table
    if not a1.OwnsCamera then
        return
    end
    local Camera = a1.Camera
    Camera.FieldOfView = a1.FieldOfView
    local HandBack = a1.HandBack
    if HandBack ~= nil then
        Camera.CFrame = HandBack
    end
    Camera.CameraType = Enum.CameraType.Custom
end

local function report(a1) -- Line: 117
    warn((("[SewerCave] transition stopped: %*"):format((debug.traceback((tostring(a1)))))))
end

function u128.Active() -- Line: 125 -- upvalues: u127 (ref)
    return u127
end

function u128.Begin(a1, a2) -- Line: 129
    -- upvalues: u127 (ref), u128 (val), Workspace (val), LocalPlayer (val), Trove (val), Kit (val), GuiService (val)
    -- upvalues: Overlay (val), Score (val), Splash (val), Double (val)
    local v1 = u127
    if v1 ~= nil then
        u128.Finish(v1, false)
    end
    local CurrentCamera = Workspace.CurrentCamera
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if CurrentCamera ~= nil
        and Character ~= nil
        and Humanoid ~= nil
        and not (Humanoid.Health <= 0)
        and HumanoidRootPart ~= nil
        and HumanoidRootPart:IsA("BasePart") then
        local v2 = Trove.new()
        local v3 = v2:Extend()
        local v4 = Trove.new()
        local v5 = v3:Add((Instance.new("Folder")))
        v5.Name = "SewerDrain"
        v5.Parent = CurrentCamera
        local v6 = Kit.LowQuality()
        local v7 = CurrentCamera.Focus.Position - HumanoidRootPart.Position
        local u58 = {
            Clock = 0,
            Phase = "Start",
            PhaseAt = 0,
            ArriveState = "Idle",
            Moved = false,
            Done = false,
            Result = false,
            Name = a1,
            Context = a2,
            Trove = v2,
            Scenery = v3,
            Folder = v5,
            Camera = CurrentCamera,
            Character = Character,
            Root = HumanoidRootPart,
            Humanoid = Humanoid,
            Calm = GuiService.ReducedMotionEnabled,
            Low = v6,
        }
        u58.OwnsCamera = CurrentCamera.CameraType == Enum.CameraType.Custom
        u58.FieldOfView = CurrentCamera.FieldOfView
        u58.Zoom = math.clamp((CurrentCamera.CFrame.Position - CurrentCamera.Focus.Position).Magnitude, 6, 22)
        u58.SubjectOffset = if not (v7.Magnitude < 4) then Vector3.new(0, 1.5, 0) else v7
        u58.StartedAt = os.clock()
        u58.StartRoot = HumanoidRootPart.Position
        u58.Grade = Kit.Grade(v3, CurrentCamera)
        u58.Overlay = Overlay.Build(v3)
        u58.Score = Score.Build(v4)
        u58.ScoreTrove = v4
        u58.Splash = Splash.Build(v3, v5, v6)
        u58.Cloak = Double.Cloak(v2, Character)
        u58.State = {}
        v3:Add(function() -- Line: 190 -- upvalues: u58 (val)
            local v1 = u58
            if not v1.OwnsCamera then
                return
            end
            local Camera = v1.Camera
            Camera.FieldOfView = v1.FieldOfView
            local HandBack = v1.HandBack
            if HandBack ~= nil then
                Camera.CFrame = HandBack
            end
            Camera.CameraType = Enum.CameraType.Custom
        end)
        u58.Double = Double.Build(v3, Character, v5)
        u127 = u58
        v2:Connect(Humanoid.Died, function() -- Line: 195 -- upvalues: u128 (upval), u58 (val)
            u128.Finish(u58, false)
        end)
        v2:Connect(LocalPlayer.CharacterAdded, function() -- Line: 198 -- upvalues: u128 (upval), u58 (val)
            u128.Finish(u58, false)
        end)
        return u58
    end
    return nil
end

function u128.Bind(a1, a2) -- Line: 204
    -- upvalues: u65 (val), report (val), u128 (val)
    a1.Scenery:BindToRenderStep("SewerDrain", u65, function(a1_2) -- Line: 205 -- upvalues: a1 (val), a2 (val), report (upval), u128 (upval) -- types: a1_2: number
        if a1.Done then
            return
        end
        a1.Cloak.Step()
        local Position = a1.Root.Position
        if not a1.Moved and 12 < (Position - a1.StartRoot).Magnitude then
            a1.Moved = true
        end
        local v1 = a1
        v1.Clock = v1.Clock + a1_2
        local success = xpcall(a2, report, a1, a1_2)
        if not success then
            u128.Bail(a1)
        end
    end)
end

function u128.Phase(a1, a2) -- Line: 221 -- types: a1: table, a2: string
    a1.Phase = a2
    a1.PhaseAt = a1.Clock
end

function u128.Since(a1) -- Line: 226 -- types: a1: table
    return a1.Clock - a1.PhaseAt
end

function u128.Elapsed(a1) -- Line: 230 -- types: a1: table
    return a1.Clock
end

function u128.Scriptable(a1) -- Line: 234 -- types: a1: table
    if a1.OwnsCamera then
        a1.Camera.CameraType = Enum.CameraType.Scriptable
    end
end

function u128.Arrive(a1) -- Line: 240 -- types: a1: table
    if a1.ArriveState ~= "Idle" then
        return
    end
    a1.ArriveState = "Waiting"
    a1.ArriveAt = os.clock()
    a1.Trove:Add((task.spawn(function() -- Line: 246 -- upvalues: a1 (val)
        local success, err = pcall(a1.Context.Arrive)
        if a1.Done then
            return
        end
        a1.ArriveState = if not success then "Failed" else if err ~= true then "Failed" else "Arrived"
    end)))
end

function u128.Settled(a1) -- Line: 255 -- types: a1: table
    if a1.ArriveState ~= "Arrived" then
        return false
    end
    if a1.Moved then
        return true
    end
    local ArriveAt = a1.ArriveAt
    local v1 = false
    if ArriveAt ~= nil then
        v1 = 2.5 < os.clock() - ArriveAt
    end
    return v1
end

function u128.Landing(a1, a2) -- Line: 266 -- upvalues: Kit (val) -- types: a1: table, a2: number
    local Root = a1.Root
    local v1 = Kit.FlatUnit(Root.CFrame.LookVector, (Vector3.new(0, 0, 1))) * 0.9781476007338057 + Vector3.new(-0, -0.2079116851091385, -0)
    local v2 = Root.Position + a1.SubjectOffset
    local v3 = {a1.Character, a1.Folder}
    v1 = Kit.Clamp(v2, v2 - v1 * a2, v3, true)
    return CFrame.lookAt(v1, v2)
end

function u128.SwingFrame(a1, a2, a3, a4) -- Line: 277
    -- upvalues: Kit (val)
    local v1 = a1.Root.Position + a1.SubjectOffset
    return CFrame.lookAt(
        Kit.Swing(v1, a2.Position, a3.Position, a4, {a1.Character, a1.Folder}),
        ((a2.Position + a2.LookVector * (a2.Position - v1).Magnitude):Lerp(v1, (Kit.Smooth(a4))))
    )
end

function u128.Swap(a1) -- Line: 287 -- upvalues: Double (val) -- types: a1: table
    local Double_2 = a1.Double
    if Double_2 ~= nil then
        Double.Visible(Double_2, false)
    end
    a1.Cloak.Lift()
end

function u128.HandBack(a1, a2) -- Line: 295 -- upvalues: u128 (val) -- types: a1: table, a2: userdata
    a1.HandBack = a2
    a1.Result = true
    u128.Finish(a1, true)
end

function u128.Finish(a1, a2) -- Line: 301 -- upvalues: u127 (ref), Score (val) -- types: a1: table, a2: boolean
    if a1.Done then
        return
    end
    a1.Done = true
    a1.Result = a2
    if u127 == a1 then
        u127 = nil
    end
    a1.Trove:Destroy()
    local ScoreTrove = a1.ScoreTrove
    if a2 then
        Score.Duck(a1.Score, false, 1.6)
        task.delay(2.6, function() -- Line: 314 -- upvalues: ScoreTrove (val)
            ScoreTrove:Destroy()
        end)
        return
    end
    Score.StopAll(a1.Score)
    ScoreTrove:Destroy()
end

function u128.Bail(a1) -- Line: 323 -- upvalues: Transition (val), u66 (val), u128 (val) -- types: a1: table
    if a1.Done then
        return
    end
    Transition.Cover(u66, 20)
    u128.Finish(a1, false)
    task.delay(0.35, Transition.Reveal)
end

function u128.Fallback(a1) -- Line: 332 -- upvalues: Transition (val), u66 (val) -- types: a1: table
    Transition.Cover(u66, 20)
    task.wait(0.75)
    local success, err = pcall(a1.Arrive)
    task.wait(0.35)
    Transition.Reveal()
    return success and err == true
end

function u128.Prepare(a1, a2) -- Line: 341 -- upvalues: u128 (val) -- types: a1: table, a2: function
    local success, err = pcall(a2, a1)
    if success then
        return true
    end
    warn((("[SewerCave] transition stopped: %*"):format((debug.traceback((tostring(err)))))))
    u128.Finish(a1, false)
    return false
end

function u128.Wait(a1) -- Line: 351 -- types: a1: table
    while not a1.Done do
        task.wait()
    end
    return a1.Result
end

function u128.CaveFlange() -- Line: 358 -- upvalues: SewerCave (val)
    local v1 = SewerCave.Cave()
    local Structures = v1 and v1:FindFirstChild("Structures")
    v1 = Structures and Structures:FindFirstChild("vertical pipe")
    local v2 = v1 and v1:FindFirstChild("Bolted Outlet Flange", true)
    if v2 ~= nil and v2:IsA("BasePart") then
        return v2
    end
    return nil
end

function u128.OutletFlange() -- Line: 366 -- upvalues: SewerCave (val)
    local v1 = SewerCave.Cave()
    local Structures = v1 and v1:FindFirstChild("Structures")
    v1 = Structures and Structures:FindFirstChild("Sewer Outlet")
    local v2 = v1 and v1:FindFirstChild("Bolted Outlet Flange", true)
    if v2 ~= nil and v2:IsA("BasePart") then
        return v2
    end
    return nil
end

function u128.Axis(a1) -- Line: 374 -- types: a1: userdata
    local v1
    local CFrame = a1.CFrame
    local v2 = {
        {CFrame.RightVector, a1.Size.X},
        {CFrame.UpVector, a1.Size.Y},
        {CFrame.LookVector, a1.Size.Z},
    }
    local v3 = v2[1]
    for i, j in v2 do
        v1 = math.abs(j[1].Y)
        if math.abs(v3[1].Y) < v1 then
            v3 = j
        end
    end
    return v3[1], v3[2]
end

function u128.Ground(a1, a2) -- Line: 390 -- upvalues: Workspace (val) -- types: a1: vector, a2: table
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Exclude
    v1.FilterDescendantsInstances = a2
    v1.RespectCanCollide = true
    local v2 = Workspace:Raycast(a1 + Vector3.new(0, 6, 0), Vector3.new(0, -30, 0), v1)
    if v2 then
        return v2.Position
    end
    return a1 - Vector3.new(0, 3, 0)
end

return (table.freeze(u128))