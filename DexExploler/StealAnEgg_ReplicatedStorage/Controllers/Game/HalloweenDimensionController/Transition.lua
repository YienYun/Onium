-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.Transition
-- Decompile time: 23.31 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local Player = require(ReplicatedStorage.Shared.Player)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u48 = {"Assets", "UI", "HalloweenDimension", "HalloweenTransition"}
local v1 = Color3.fromRGB(96, 34, 146)
local v2 = Color3.fromRGB(16, 5, 28)
local v3 = Color3.fromRGB(176, 110, 232)
local u68 = {0.8, 1.6}
local v4 = {
    Color3.fromRGB(255, 150, 48),
    Color3.fromRGB(255, 196, 90),
    (Color3.fromRGB(190, 110, 255)),
}
local u87 = {
    ["in"] = {Id = "rbxassetid://140305170110264", Volume = 0.5},
    out = {Id = "rbxassetid://89104702130285", Volume = 0.35},
}
local Transition = HalloweenDimension.PlayerAttributes.Transition
local u92 = {Core = v1, Edge = v2, Shade = v3, Embers = v4}
local u95 = Random.new()
local u98 = Trove.new()
local u99 = nil
local u100 = nil
local u101 = nil
local u102 = nil
local u103 = nil
local u104 = nil
local u105 = {}
local u106 = {}
local zero = Vector2.zero
local u108 = "clear"
local u109 = 0
local u110 = 0
local u111 = false
local u112 = false
local u113 = nil
local u114 = 0
local u115 = nil
local u116 = ""
local u117 = u92
local u119 = Color3.new()
local u120 = nil
local u121 = nil
local u122 = nil
local u123 = {}

local function findTemplate() -- Line: 131 -- upvalues: ReplicatedStorage (val), u48 (val)
    local v1 = ReplicatedStorage
    for i, j in u48 do
        v1 = if not v1 then nil else v1:FindFirstChild(j)
    end
    if v1 and v1:IsA("ScreenGui") then
        return v1
    end
    return nil
end

local function gradientOf(a1) -- Line: 139 -- types: a1: userdata?
    if a1 then
        return (a1:FindFirstChildOfClass("UIGradient"))
    end
    return nil
end

local function ensureGui() -- Line: 143
    -- upvalues: u99 (ref), findTemplate (val), u98 (val), u105 (ref), u106 (ref), zero (ref), u108 (ref), u100 (ref)
    -- upvalues: u101 (ref), u102 (ref), u103 (ref), u104 (ref), u117 (ref), u92 (val), u119 (ref), u120 (ref)
    -- upvalues: u121 (ref), LocalPlayer (val)
    if u99 and u99.Parent then
        return true
    end
    local v1 = findTemplate()
    if v1 == nil then
        return false
    end
    u98:Clean()
    u105 = {}
    u106 = {}
    zero = Vector2.zero
    u108 = "clear"
    local v2 = u98:Clone(v1)
    v2.Enabled = false
    u100 = v2:WaitForChild("Veil")
    u101 = v2:WaitForChild("Puffs")
    u102 = u101:WaitForChild("Puff")
    u103 = v2:WaitForChild("Embers")
    u104 = u103:WaitForChild("Ember")
    u102.Visible = false
    u104.Visible = false
    u117 = u92
    u119 = u100.BackgroundColor3
    local v3 = u100
    v1 = if not v3 then nil else v3:FindFirstChildOfClass("UIGradient")
    local v4 = u102
    v3 = if not v4 then nil else v4:FindFirstChildOfClass("UIGradient")
    u120 = if not v1 then nil else v1.Color
    u121 = if not v3 then nil else v3.Color
    v2.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u99 = v2
    return true
end

local function tint(a1, a2) -- Line: 177 -- types: a1: userdata?, a2: userdata?
    local UIGradient = if not a1 then nil else a1:FindFirstChildOfClass("UIGradient")
    if UIGradient ~= nil and a2 ~= nil then
        UIGradient.Color = a2
    end
end

local function applyPalette(a1) -- Line: 184
    -- upvalues: u117 (ref), zero (ref), u100 (ref), u119 (ref), u120 (ref), u102 (ref), u121 (ref)
    if a1 == u117 then
        return
    end
    u117 = a1
    zero = Vector2.zero
    local v1 = u100
    local Veil = a1.Veil or u119
    v1.BackgroundColor3 = Veil
    local VeilTint = a1.VeilTint or u120
    local UIGradient = if not v1 then nil else v1:FindFirstChildOfClass("UIGradient")
    if UIGradient ~= nil and VeilTint ~= nil then
        UIGradient.Color = VeilTint
    end
    local v2 = u102
    local PuffTint = a1.PuffTint or u121
    v1 = if not v2 then nil else v2:FindFirstChildOfClass("UIGradient")
    if v1 ~= nil and PuffTint ~= nil then
        v1.Color = PuffTint
    end
end

local function portalHitbox(a1) -- Line: 196 -- upvalues: Workspace (val), HalloweenDimension (val) -- types: a1: string
    local v1
    if a1 ~= "in" then
        local v2 = Workspace:FindFirstChild(HalloweenDimension.MapName)
        v1 = if not v2 then nil else v2:FindFirstChild("ExitPortal", true)
    else
        local World = Workspace:FindFirstChild("World")
        v1 = if not World then nil else World:FindFirstChild(HalloweenDimension.PortalName)
    end
    local Hitbox = if not v1 then nil else v1:FindFirstChild("Hitbox", true)
    if Hitbox ~= nil and Hitbox:IsA("BasePart") then
        return Hitbox
    end
    return nil
end

local function portalSound(a1) -- Line: 209
    -- upvalues: u87 (val), portalHitbox (val), Player (val), LocalPlayer (val)
    local v1 = u87[a1]
    local v2 = portalHitbox(a1)
    local v3 = Player.FindRootPart(LocalPlayer)
    if v1 ~= nil and v2 ~= nil and v3 ~= nil then
        local v4 = v2.CFrame:PointToObjectSpace(v3.Position)
        v3 = v2.Size / 2 + Vector3.new(8, 8, 8)
        v2 = false
        if (math.abs(v4.X)) <= v3.X then
            v2 = false
            if (math.abs(v4.Y)) <= v3.Y then
                v2 = (math.abs(v4.Z)) <= v3.Z
            end
        end
        if v2 then
            return v1
        end
        return nil
    end
    return nil
end

local function viewport() -- Line: 224 -- upvalues: u99 (ref), Workspace (val)
    local AbsoluteSize = if not u99 then Vector2.zero else u99.AbsoluteSize
    if 1 <= AbsoluteSize.X and 1 <= AbsoluteSize.Y then
        return AbsoluteSize
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        return CurrentCamera.ViewportSize
    end
    return (Vector2.new(1280, 720))
end

local function rebuild() -- Line: 233
    -- upvalues: u99 (ref), Workspace (val), zero (ref), u105 (ref), u108 (ref), u95 (val), u102 (ref), u117 (ref)
    -- upvalues: u101 (ref)
    local Shade, UIScale, ViewportSize, v1, v2, v3, v4
    local AbsoluteSize = if not u99 then Vector2.zero else u99.AbsoluteSize
    if not (1 <= AbsoluteSize.X) or not (1 <= AbsoluteSize.Y) then
        local CurrentCamera = Workspace.CurrentCamera
        ViewportSize = if not CurrentCamera then Vector2.new(1280, 720) else CurrentCamera.ViewportSize
    else
        ViewportSize = AbsoluteSize
    end
    if ViewportSize == zero and #u105 > 0 then
        return
    end
    zero = ViewportSize
    for i, j in u105 do
        j.Frame:Destroy()
    end
    table.clear(u105)
    local v5 = math.max(ViewportSize.X, ViewportSize.Y) / 11
    local v6 = math.ceil(ViewportSize.X / v5) + 1
    local v7 = math.ceil(ViewportSize.Y / v5) + 1
    local v8 = ViewportSize / 2
    local Magnitude = v8.Magnitude
    local v9 = if u108 ~= "covered" then 0 else 1
    local v10 = v6 - 1
    for k = 0, v10 do
        v1 = v7 - 1
        for n = 0, v1 do
            v2 = Vector2.new((k + n % 2 * 0.5 + u95:NextNumber(-0.28, 0.28)) * v5, (n + u95:NextNumber(-0.28, 0.28)) * v5)
            v3 = math.clamp((v2 - v8).Magnitude / Magnitude, 0, 1)
            v4 = u102:Clone()
            v4.Name = ("%*_%*"):format(k, n)
            v4.Position = UDim2.fromScale(v2.X / ViewportSize.X, v2.Y / ViewportSize.Y)
            v2 = v5 * 1.75 * u95:NextNumber(0.85, 1.3)
            v4.Size = UDim2.fromScale(v2 / ViewportSize.X, v2 / ViewportSize.Y)
            v4.Visible = true
            v2 = u117.Core:Lerp(u117.Edge, (math.clamp(v3 + u95:NextNumber(-0.1, 0.1), 0, 1)))
            v4.BackgroundColor3 = v2
            Shade = v4:FindFirstChild("Shade")
            if Shade ~= nil and Shade:IsA("GuiObject") then
                Shade.BackgroundColor3 = v2:Lerp(u117.Shade, 0.14)
                Shade.Position = UDim2.fromScale(u95:NextNumber(0.36, 0.48), u95:NextNumber(0.32, 0.44))
            end
            UIScale = v4:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
            UIScale.Scale = v9
            UIScale.Parent = v4
            v4.Parent = u101
            table.insert(u105, {
                Frame = v4,
                Scale = UIScale,
                Reach = v3,
                Jitter = u95:NextNumber(0, 0.05),
                Spin = u95:NextNumber(-55, 55),
            })
        end
    end
end

local function spawnEmber(a1) -- Line: 291
    -- upvalues: u99 (ref), Workspace (val), u104 (ref), u117 (ref), u95 (val), u103 (ref), u106 (ref), u68 (val)
    local ViewportSize
    local AbsoluteSize = if not u99 then Vector2.zero else u99.AbsoluteSize
    if not (1 <= AbsoluteSize.X) or not (1 <= AbsoluteSize.Y) then
        local CurrentCamera = Workspace.CurrentCamera
        ViewportSize = if not CurrentCamera then Vector2.new(1280, 720) else CurrentCamera.ViewportSize
    else
        ViewportSize = AbsoluteSize
    end
    local v1 = u104:Clone()
    local Embers = u117.Embers
    v1.ImageColor3 = Embers[u95:NextInteger(1, #Embers)]
    v1.Visible = true
    v1.Parent = u103
    table.insert(u106, {
        Frame = v1,
        Born = a1,
        Life = u95:NextNumber(u68[1], u68[2]),
        From = Vector2.new(u95:NextNumber(0.06, 0.94), u95:NextNumber(0.55, 1.05)),
        Drift = Vector2.new(u95:NextNumber(-0.06, 0.06), -u95:NextNumber(0.18, 0.4)),
        Size = (u95:NextNumber(0.018, 0.04)) * math.min(ViewportSize.X, ViewportSize.Y),
    })
end

local function stepEmbers(a1) -- Line: 308
    -- upvalues: u99 (ref), Workspace (val), u106 (ref), u108 (ref), spawnEmber (val)
    local ViewportSize, v1, v2, v3, v4, v5
    local AbsoluteSize = if not u99 then Vector2.zero else u99.AbsoluteSize
    if not (1 <= AbsoluteSize.X) or not (1 <= AbsoluteSize.Y) then
        local CurrentCamera = Workspace.CurrentCamera
        ViewportSize = if not CurrentCamera then Vector2.new(1280, 720) else CurrentCamera.ViewportSize
    else
        ViewportSize = AbsoluteSize
    end
    local v6 = a1
    for i = #u106, 1, -1 do
        v1 = u106[i]
        v2 = (v6 - v1.Born) / v1.Life
        if not (v2 >= 1) then
            v3 = (math.sin(v2 * 3.141592653589793 * 3 + v1.Life * 7)) * 0.012
            v4 = v1.From + v1.Drift * v2 + Vector2.new(v3, 0)
            v3 = math.sin(v2 * 3.141592653589793)
            v5 = v1.Size * (v3 * 0.5 + 0.5)
            v1.Frame.Position = UDim2.fromScale(v4.X, v4.Y)
            v1.Frame.Size = UDim2.fromScale(v5 / ViewportSize.X, v5 / ViewportSize.Y)
            v1.Frame.Rotation = v2 * 240
            v1.Frame.ImageTransparency = 1 - v3
        else
            v1.Frame:Destroy()
            table.remove(u106, i)
        end
    end
    if u108 ~= "clear" and u108 ~= "revealing" and #u106 < 24 then
        spawnEmber(v6)
    end
end

local function clearEmbers() -- Line: 332 -- upvalues: u106 (ref)
    for i, j in u106 do
        j.Frame:Destroy()
    end
    table.clear(u106)
end

local function setVeil(a1) -- Line: 339 -- upvalues: u100 (ref) -- types: a1: number
    local v1 = u100
    v1.BackgroundTransparency = 1 - a1
    v1.Visible = a1 > 0
end

local u137 = nil
local u138 = nil

local function finish() -- Line: 348
    -- upvalues: u109 (ref), u108 (ref), u100 (ref), u112 (ref), u137 (ref), u122 (ref), u113 (ref), u106 (ref)
    -- upvalues: u105 (ref), u99 (ref)
    local v1
    if u109 == 1 then
        u108 = "covered"
        v1 = u100
        v1.BackgroundTransparency = 0
        v1.Visible = true
        if u112 then
            u112 = false
            u137(0)
        end
        return
    end
    u108 = "clear"
    u122 = nil
    if u113 then
        u113:Disconnect()
        u113 = nil
    end
    for i, j in u106 do
        j.Frame:Destroy()
    end
    table.clear(u106)
    for k, n in u105 do
        n.Scale.Scale = 0
    end
    v1 = u100
    v1.BackgroundTransparency = 1
    v1.Visible = false
    if u99 then
        u99.Enabled = false
    end
end

local function step() -- Line: 374
    -- upvalues: stepEmbers (val), u108 (ref), u111 (ref), u105 (ref), u110 (ref), u109 (ref), u100 (ref), finish (val)
    -- upvalues: TweenService (val)
    local v1, v2, v3
    local v4 = os.clock()
    stepEmbers(v4)
    if u108 == "covered" and not u111 then
        for i, j in u105 do
            j.Scale.Scale = math.sin(v4 * 2.2 + j.Spin) * 0.05 + 1
        end
    end
    if u108 ~= "covering" and u108 ~= "revealing" then
        return
    end
    local v5 = v4 - u110
    if u111 then
        v4 = math.clamp(v5 / 0.2, 0, 1)
        v1 = if u109 ~= 1 then 1 - v4 else v4
        local v6 = u100
        v6.BackgroundTransparency = 1 - v1
        v6.Visible = v1 > 0
        if v4 >= 1 then
            finish()
        end
        return
    end
    v1 = true
    local v7 = nil
    local v8 = nil
    for k, n in u105, v7, v8 do
        v3 = math.clamp((v5 - (if u109 ~= 1 then n.Reach * 0.3 + n.Jitter else (1 - n.Reach) * 0.34 + n.Jitter)) / 0.3, 0, 1)
        if v3 < 1 then
            v1 = false
        end
        v2 = if u109 ~= 1 then 1 - TweenService:GetValue(v3, Enum.EasingStyle.Quad, Enum.EasingDirection.In) else TweenService:GetValue(v3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        n.Scale.Scale = math.max(v2, 0)
        n.Frame.Rotation = n.Spin * (1 - v2)
    end
    if v1 then
        finish()
    end
end

function u137(a1) -- Line: 414
    -- upvalues: u99 (ref), u111 (ref), GuiService (val), u109 (ref), u110 (ref), u108 (ref), rebuild (val), u100 (ref)
    -- upvalues: u122 (ref), Audio (val), u113 (ref), RunService (val), step (val)
    local v1 = u99
    u111 = GuiService.ReducedMotionEnabled
    u109 = a1
    os.clock()
    u108 = if a1 ~= 1 then "revealing" else "covering"
    if not u111 then
        rebuild()
        if a1 == 0 then
            local v2 = u100
            v2.BackgroundTransparency = 1
            v2.Visible = false
        end
    end
    v1.Enabled = true
    if u122 == nil then
        if a1 ~= 1 then
            Audio.Play("rbxassetid://71759553024274", script, {Volume = 0.3, PlaybackSpeed = 0.85})
        else
            Audio.Play("rbxassetid://138533090376585", script, {Volume = 0.35, PlaybackSpeed = 0.7})
        end
    elseif a1 == 1 then
        Audio.Play(u122.Id, script, {Volume = u122.Volume})
    end
    if u113 == nil then
        RunService.RenderStepped:Connect(step)
    end
end

local function rootPosition() -- Line: 443 -- upvalues: Player (val), LocalPlayer (val)
    local v1 = Player.FindRootPart(LocalPlayer)
    if v1 then
        return v1.Position
    end
    return nil
end

local function cameraModule() -- Line: 448 -- upvalues: LocalPlayer (val)
    local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
    local PlayerModule = if not PlayerScripts then nil else PlayerScripts:FindFirstChild("PlayerModule")
    if PlayerModule ~= nil and PlayerModule:IsA("ModuleScript") then
        return require(PlayerModule):GetCameras()
    end
    return nil
end

local function faceForward() -- Line: 457
    -- upvalues: Workspace (val), Player (val), LocalPlayer (val), cameraModule (val)
    local CurrentCamera = Workspace.CurrentCamera
    local v1 = Player.FindRootPart(LocalPlayer)
    if CurrentCamera ~= nil and v1 ~= nil and CurrentCamera.CameraType == Enum.CameraType.Custom then
        local LookVector = v1.CFrame.LookVector
        local v2 = Vector3.new(LookVector.X, 0, LookVector.Z)
        if v2.Magnitude < 0.01 then
            return
        end
        local v3 = cameraModule()
        local v4 = (if not v3 then nil else v3:GetCameraSubjectPosition()) or v1.Position + Vector3.new(0, 1.5, 0)
        v1 = math.max(
            (if not v3 then nil else v3:GetCameraToSubjectDistance()) or (CurrentCamera.CFrame.Position - CurrentCamera.Focus.Position).Magnitude,
            0.5
        )
        v2 = CFrame.lookAt(v4 - (v2.Unit * 0.9781476007338057 + Vector3.new(-0, -0.2079116851091385, -0)) * v1, v4)
        CurrentCamera.CFrame = v2
        if v3 then
            v3:CommitCameraCFrame(v2, Enum.CameraType.Custom)
        end
        return
    end
end

local function onSignal() -- Line: 484
    -- upvalues: LocalPlayer (val), Transition (val), u116 (ref), u138 (ref), portalSound (val), u123 (val)
    local Attribute = LocalPlayer:GetAttribute(Transition)
    if type(Attribute) == "string" and Attribute ~= u116 then
        local v1, v2
        u116 = Attribute
        _, v1, v2 = string.match(Attribute, "^(%d+):(%a+):(%a+)$")
        if v1 == "cover" then
            u138(nil, nil, if not v2 then nil else portalSound(v2))
            return
        end
        if v1 == "reveal" then
            u123.RevealAfterMove()
        end
        return
    end
end

function u138(a1, a2, a3) -- Line: 502
    -- upvalues: ensureGui (val), u114 (ref), u115 (ref), Player (val), LocalPlayer (val), u112 (ref), u108 (ref)
    -- upvalues: u123 (val), u92 (val), u117 (ref), zero (ref), u100 (ref), u119 (ref), u120 (ref), u102 (ref)
    -- upvalues: u121 (ref), u122 (ref), u137 (ref)
    if not ensureGui() then
        return
    end
    u114 = u114 + 1
    local u7 = u114
    local v1 = Player.FindRootPart(LocalPlayer)
    u115 = if not v1 then nil else v1.Position
    u112 = false
    task.delay(math.clamp(a2 or 6, 6, 30), function() -- Line: 511 -- upvalues: u114 (upval), u7 (val), u108 (upval), u123 (upval)
        if u114 == u7 and u108 ~= "clear" and u108 ~= "revealing" then
            u123.Reveal()
        end
    end)
    if u108 ~= "covered" and u108 ~= "covering" then
        v1 = a1 or u92
        if v1 ~= u117 then
            u117 = v1
            zero = Vector2.zero
            local v2 = u100
            local Veil = v1.Veil or u119
            v2.BackgroundColor3 = Veil
            local VeilTint = v1.VeilTint or u120
            local UIGradient = if not v2 then nil else v2:FindFirstChildOfClass("UIGradient")
            if UIGradient ~= nil and VeilTint ~= nil then
                UIGradient.Color = VeilTint
            end
            local v3 = u102
            local PuffTint = v1.PuffTint or u121
            v2 = if not v3 then nil else v3:FindFirstChildOfClass("UIGradient")
            if v2 ~= nil and PuffTint ~= nil then
                v2.Color = PuffTint
            end
        end
        u122 = a3
        u137(1)
        return
    end
end

function u123.Cover(a1, a2) -- Line: 524 -- upvalues: u138 (ref) -- types: a1: table?, a2: number?
    u138(a1, a2, nil)
end

function u123.IsCovering() -- Line: 528 -- upvalues: u108 (ref)
    local v1 = true
    if u108 ~= "covering" then
        v1 = u108 == "covered"
    end
    return v1
end

function u123.Reveal() -- Line: 532 -- upvalues: u99 (ref), u108 (ref), u112 (ref), u137 (ref)
    if u99 ~= nil and u108 ~= "clear" and u108 ~= "revealing" then
        if u108 == "covering" then
            u112 = true
            return
        end
        u137(0)
        return
    end
end

function u123.RevealAfterMove() -- Line: 543
    -- upvalues: u114 (ref), u115 (ref), Player (val), LocalPlayer (val), faceForward (val), u123 (val)
    local u0 = u114
    local u1 = u115
    local u3 = os.clock()
    task.spawn(function() -- Line: 547
        -- upvalues: u3 (val), u114 (upval), u0 (val), Player (upval), LocalPlayer (upval), u1 (val)
        -- upvalues: faceForward (upval), u123 (upval)
        local Position, v1
        while true do
            if not (os.clock() - u3 < 1.2) then
                break
            end
            if u114 ~= u0 then
                return
            end
            v1 = Player.FindRootPart(LocalPlayer)
            Position = if not v1 then nil else v1.Position
            if u1 == nil then
                break
            end
            if Position and 12 < (Position - u1).Magnitude then
                break
            end
            task.wait()
        end
        task.wait(0.15)
        if u114 == u0 then
            faceForward()
            u123.Reveal()
        end
    end)
end

function u123.Start(a1) -- Line: 566
    -- upvalues: u116 (ref), LocalPlayer (val), Transition (val), onSignal (val), u113 (ref), u98 (val), u99 (ref)
    -- upvalues: u108 (ref)
    u116 = ""
    local Attribute = LocalPlayer:GetAttribute(Transition)
    if type(Attribute) == "string" then
        u116 = Attribute
    end
    a1:Connect(LocalPlayer:GetAttributeChangedSignal(Transition), onSignal)
    a1:Add(function() -- Line: 573 -- upvalues: u113 (upval), u98 (upval), u99 (upval), u108 (upval)
        if u113 then
            u113:Disconnect()
            u113 = nil
        end
        u98:Clean()
        u99 = nil
        u108 = "clear"
    end)
end

return u123