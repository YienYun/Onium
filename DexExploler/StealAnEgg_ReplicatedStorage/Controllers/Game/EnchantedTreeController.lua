-- Script path: ReplicatedStorage.Controllers.Game.EnchantedTreeController
-- Decompile time: 19.40 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ButterflyCatalog = require(ReplicatedStorage.Shared.Modules.ButterflyCatalog)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u56 = {"Assets", "UI", "EnchantedTree", "EnchantedTransition"}
local u65 = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u70 = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local u71 = {0.9, 1.6}
local u78 = Color3.fromRGB(150, 255, 214)
local u83 = Color3.fromRGB(122, 64, 214)
local LocalPlayer = Players.LocalPlayer
local u87 = Random.new()
local u89 = Trove.new()
local u90 = nil
local u91 = nil
local u92 = nil
local u93 = nil
local u94 = nil
local u95 = nil
local u96 = nil
local u97 = nil
local u98 = {}
local u99 = {}
local zero = Vector2.zero
local u101 = "clear"
local u102 = 0
local u103 = 0
local u104 = false
local u105 = false
local u106 = 0
local u107 = nil
local u108 = nil
local u109 = {}

local function findTemplate() -- Line: 95 -- upvalues: ReplicatedStorage (val), u56 (val)
    local v1 = ReplicatedStorage
    for i, j in u56 do
        v1 = if not v1 then nil else v1:FindFirstChild(j)
    end
    if v1 and v1:IsA("ScreenGui") then
        return v1
    end
    return nil
end

local function ensureGui() -- Line: 103
    -- upvalues: u90 (ref), findTemplate (val), u89 (val), u98 (ref), u99 (ref), zero (ref), u101 (ref), u91 (ref)
    -- upvalues: u92 (ref), u96 (ref), u94 (ref), u95 (ref), u93 (ref), u97 (ref), LocalPlayer (val)
    if u90 and u90.Parent then
        return true
    end
    local v1 = findTemplate()
    if v1 == nil then
        return false
    end
    u89:Clean()
    u98 = {}
    u99 = {}
    zero = Vector2.zero
    u101 = "clear"
    local v2 = u89:Clone(v1)
    v2.Enabled = false
    v2:WaitForChild("Veil")
    u92 = v2:WaitForChild("Petals")
    v1 = u92:WaitForChild("Petal")
    u96 = v2:WaitForChild("Motes")
    local Mote = u96:WaitForChild("Mote")
    u94 = v2:WaitForChild("Emblem")
    u94:WaitForChild("UIScale")
    v1.Visible = false
    Mote.Visible = false
    u93 = v1
    u97 = Mote
    v2.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u90 = v2
    return true
end

local function viewport() -- Line: 135 -- upvalues: u90 (ref), Workspace (val)
    local AbsoluteSize = if not u90 then Vector2.zero else u90.AbsoluteSize
    if 1 <= AbsoluteSize.X and 1 <= AbsoluteSize.Y then
        return AbsoluteSize
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        return CurrentCamera.ViewportSize
    end
    return (Vector2.new(1280, 720))
end

local function rebuild() -- Line: 144
    -- upvalues: u90 (ref), Workspace (val), zero (ref), u98 (ref), u101 (ref), u93 (ref), u78 (val), u83 (val)
    -- upvalues: u87 (val), u92 (ref)
    local ViewportSize, v1, v2, v3, v4
    local AbsoluteSize = if not u90 then Vector2.zero else u90.AbsoluteSize
    if not (1 <= AbsoluteSize.X) or not (1 <= AbsoluteSize.Y) then
        local CurrentCamera = Workspace.CurrentCamera
        ViewportSize = if not CurrentCamera then Vector2.new(1280, 720) else CurrentCamera.ViewportSize
    else
        ViewportSize = AbsoluteSize
    end
    if ViewportSize == zero and #u98 > 0 then
        return
    end
    zero = ViewportSize
    for i, j in u98 do
        j.Frame:Destroy()
    end
    table.clear(u98)
    local v5 = math.max(ViewportSize.X, ViewportSize.Y) / 14
    local v6 = math.ceil(ViewportSize.X / v5) + 1
    local v7 = math.ceil(ViewportSize.Y / v5) + 1
    local v8 = ViewportSize / 2
    local Magnitude = v8.Magnitude
    local v9 = if u101 ~= "covered" then 0 else 1
    local v10 = v6 - 1
    for k = 0, v10 do
        v1 = v7 - 1
        for n = 0, v1 do
            v2 = Vector2.new((k + n % 2 * 0.5) * v5, n * v5)
            v3 = (v2 - v8).Magnitude / Magnitude
            v4 = u93:Clone()
            v4.Name = ("%*_%*"):format(k, n)
            v4.Position = UDim2.fromScale(v2.X / ViewportSize.X, v2.Y / ViewportSize.Y)
            v4.Size = UDim2.fromScale(v5 * 1.5 / ViewportSize.X, v5 * 1.5 / ViewportSize.Y)
            v4.Visible = true
            v2 = u78:Lerp(u83, (math.clamp(v3 + u87:NextNumber(-0.08, 0.08), 0, 1)))
            if not v4:IsA("ImageLabel") then
                v4.BackgroundColor3 = v2
            else
                v4.ImageColor3 = v2
            end
            v2 = v4:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
            v2.Scale = v9
            v2.Parent = v4
            v4.Parent = u92
            table.insert(u98, {
                Frame = v4,
                Scale = v2,
                Delay = v3 * 0.38 + u87:NextNumber(0, 0.05),
                Spin = u87:NextNumber(-70, 70),
                Value = v9,
            })
        end
    end
end

local function spawnMote(a1) -- Line: 194
    -- upvalues: u90 (ref), Workspace (val), u97 (ref), u87 (val), u96 (ref), u99 (ref), u71 (val)
    local ViewportSize
    local AbsoluteSize = if not u90 then Vector2.zero else u90.AbsoluteSize
    if not (1 <= AbsoluteSize.X) or not (1 <= AbsoluteSize.Y) then
        local CurrentCamera = Workspace.CurrentCamera
        ViewportSize = if not CurrentCamera then Vector2.new(1280, 720) else CurrentCamera.ViewportSize
    else
        ViewportSize = AbsoluteSize
    end
    local v1 = u97:Clone()
    local v2 = Vector2.new(u87:NextNumber(0.08, 0.92), u87:NextNumber(0.2, 1))
    local v3 = (u87:NextNumber(0.018, 0.04)) * math.min(ViewportSize.X, ViewportSize.Y)
    v1.Visible = true
    v1.Parent = u96
    table.insert(u99, {
        Image = v1,
        Born = a1,
        Life = u87:NextNumber(u71[1], u71[2]),
        From = v2,
        Drift = Vector2.new(u87:NextNumber(-0.05, 0.05), -u87:NextNumber(0.12, 0.28)),
        Size = v3,
    })
end

local function stepMotes(a1) -- Line: 211
    -- upvalues: u90 (ref), Workspace (val), u99 (ref), u101 (ref), spawnMote (val)
    local ViewportSize, v1, v2, v3, v4, v5
    local AbsoluteSize = if not u90 then Vector2.zero else u90.AbsoluteSize
    if not (1 <= AbsoluteSize.X) or not (1 <= AbsoluteSize.Y) then
        local CurrentCamera = Workspace.CurrentCamera
        ViewportSize = if not CurrentCamera then Vector2.new(1280, 720) else CurrentCamera.ViewportSize
    else
        ViewportSize = AbsoluteSize
    end
    local v6 = a1
    for i = #u99, 1, -1 do
        v1 = u99[i]
        v2 = (v6 - v1.Born) / v1.Life
        if not (v2 >= 1) then
            v3 = v1.From + v1.Drift * v2
            v4 = math.sin(v2 * 3.141592653589793)
            v5 = v1.Size * (v4 * 0.6 + 0.4)
            v1.Image.Position = UDim2.fromScale(v3.X, v3.Y)
            v1.Image.Size = UDim2.fromScale(v5 / ViewportSize.X, v5 / ViewportSize.Y)
            v1.Image.Rotation = v2 * 180
            if v1.Image:IsA("ImageLabel") then
                v1.Image.ImageTransparency = 1 - v4
            end
        else
            v1.Image:Destroy()
            table.remove(u99, i)
        end
    end
    if u101 ~= "clear" and u101 ~= "revealing" and #u99 < 26 then
        spawnMote(v6)
    end
end

local function clearMotes() -- Line: 236 -- upvalues: u99 (ref)
    for i, j in u99 do
        j.Image:Destroy()
    end
    table.clear(u99)
end

local function setVeil(a1) -- Line: 243 -- upvalues: u91 (ref) -- types: a1: number
    local v1 = u91
    v1.BackgroundTransparency = 1 - a1
    v1.Visible = a1 > 0
end

local u118 = nil

local function finish() -- Line: 251
    -- upvalues: u102 (ref), u101 (ref), u105 (ref), u118 (ref), u108 (ref), u99 (ref), u98 (ref), u91 (ref), u90 (ref)
    if u102 == 1 then
        u101 = "covered"
        if u105 then
            u105 = false
            u118(0)
        end
        return
    end
    u101 = "clear"
    if u108 then
        u108:Disconnect()
        u108 = nil
    end
    for i, j in u99 do
        j.Image:Destroy()
    end
    table.clear(u99)
    for k, n in u98 do
        n.Value = 0
        n.Scale.Scale = 0
    end
    local v1 = u91
    v1.BackgroundTransparency = 1
    v1.Visible = false
    if u90 then
        u90.Enabled = false
    end
end

local function step() -- Line: 276
    -- upvalues: stepMotes (val), u101 (ref), u103 (ref), u104 (ref), u102 (ref), u91 (ref), finish (val), u98 (ref)
    -- upvalues: TweenService (val)
    local v1, v2, v3
    local v4 = os.clock()
    stepMotes(v4)
    if u101 ~= "covering" and u101 ~= "revealing" then
        return
    end
    local v5 = v4 - u103
    if u104 then
        v4 = math.clamp(v5 / 0.2, 0, 1)
        v1 = if u102 ~= 1 then 1 - v4 else v4
        local v6 = u91
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
    for i, j in u98, v7, v8 do
        v3 = math.clamp((v5 - (if u102 ~= 1 then j.Delay * 0.8 else j.Delay)) / 0.26, 0, 1)
        if v3 < 1 then
            v1 = false
        end
        v2 = if u102 ~= 1 then 1 - TweenService:GetValue(v3, Enum.EasingStyle.Quad, Enum.EasingDirection.In) else TweenService:GetValue(v3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        j.Value = v2
        j.Scale.Scale = math.max(v2, 0)
        j.Frame.Rotation = 45 + j.Spin * (1 - v2)
    end
    if v1 then
        finish()
    end
end

function u118(a1) -- Line: 310
    -- upvalues: u90 (ref), u104 (ref), GuiService (val), u102 (ref), u103 (ref), u101 (ref), rebuild (val), u94 (ref)
    -- upvalues: u95 (ref), TweenService (val), u65 (val), Audio (val), ButterflyCatalog (val), u70 (val), u108 (ref)
    -- upvalues: RunService (val), step (val)
    local v1 = u90
    u104 = GuiService.ReducedMotionEnabled
    u102 = a1
    os.clock()
    u101 = if a1 ~= 1 then "revealing" else "covering"
    if not u104 then
        rebuild()
    end
    v1.Enabled = true
    local v2 = u95
    if a1 ~= 1 then
        TweenService:Create(v2, u70, {Scale = 0}):Play()
        Audio.Play(ButterflyCatalog.Sounds.Craft, script, {Volume = 0.5, PlaybackSpeed = 1.2})
    else
        u94.Visible = true
        v2.Scale = 0.4
        TweenService:Create(v2, u65, {Scale = 1}):Play()
        Audio.Play(ButterflyCatalog.Sounds.BloomStart, script, {Volume = 0.55, PlaybackSpeed = 1.15})
    end
    if u108 == nil then
        RunService.RenderStepped:Connect(step)
    end
end

local function rootPosition() -- Line: 342 -- upvalues: Player (val), LocalPlayer (val)
    local v1 = Player.FindRootPart(LocalPlayer)
    if v1 then
        return v1.Position
    end
    return nil
end

local function cameraModule() -- Line: 347 -- upvalues: LocalPlayer (val)
    local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
    local PlayerModule = if not PlayerScripts then nil else PlayerScripts:FindFirstChild("PlayerModule")
    if PlayerModule ~= nil and PlayerModule:IsA("ModuleScript") then
        return require(PlayerModule):GetCameras()
    end
    return nil
end

local function faceForward() -- Line: 356
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

local function syncLighting() -- Line: 383 -- upvalues: LocalPlayer (val), LightingController (val)
    if LocalPlayer:GetAttribute("InEnchantedTree") ~= true then
        LightingController.ClearLayer("EnchantedTree", 0)
        return
    end
    if not LightingController.Presets.EnchantedTree then
        return
    end
    LightingController.SetLayer("EnchantedTree", "EnchantedTree", 150, 0)
end

function u109.Cover(a1) -- Line: 397
    -- upvalues: ensureGui (val), u106 (ref), u107 (ref), Player (val), LocalPlayer (val), u105 (ref), u101 (ref)
    -- upvalues: u109 (val), u118 (ref)
    if not ensureGui() then
        return
    end
    u106 = u106 + 1
    local u5 = u106
    local v1 = Player.FindRootPart(LocalPlayer)
    u107 = if not v1 then nil else v1.Position
    u105 = false
    task.delay(math.clamp(a1 or 6, 6, 30), function() -- Line: 405 -- upvalues: u106 (upval), u5 (val), u101 (upval), u109 (upval)
        if u106 == u5 and u101 ~= "clear" and u101 ~= "revealing" then
            u109.Reveal()
        end
    end)
    if u101 ~= "covered" and u101 ~= "covering" then
        u118(1)
        return
    end
end

function u109.Reveal() -- Line: 416 -- upvalues: u90 (ref), u101 (ref), u105 (ref), u118 (ref)
    if u90 ~= nil and u101 ~= "clear" and u101 ~= "revealing" then
        if u101 == "covering" then
            u105 = true
            return
        end
        u118(0)
        return
    end
end

function u109.RevealAfterMove(a1, a2, a3) -- Line: 427
    -- upvalues: u106 (ref), u107 (ref), u101 (ref), Player (val), LocalPlayer (val), LightingController (val)
    -- upvalues: faceForward (val), u109 (val)
    local u3 = u106
    local u4 = u107
    local u6 = os.clock()
    task.spawn(function() -- Line: 431
        -- upvalues: a1 (val), u6 (val), u106 (upval), u3 (val), u101 (upval), Player (upval), LocalPlayer (upval)
        -- upvalues: a2 (val), a3 (val), LightingController (upval), faceForward (upval), u109 (upval), u4 (val)
        local Character, Humanoid, Position, v1, v2
        if not a1 then
            local Position_2, v3
            while true do
                if not (os.clock() - u6 < 1) then
                    break
                end
                if u106 ~= u3 then
                    return
                end
                v3 = Player.FindRootPart(LocalPlayer)
                Position_2 = if not v3 then nil else v3.Position
                if u4 == nil then
                    break
                end
                if Position_2 and 12 < (Position_2 - u4).Magnitude then
                    break
                end
                task.wait()
            end
            if LocalPlayer:GetAttribute("InEnchantedTree") ~= true then
                LightingController.ClearLayer("EnchantedTree", 0)
            elseif LightingController.Presets.EnchantedTree then
                LightingController.SetLayer("EnchantedTree", "EnchantedTree", 150, 0)
            end
            task.wait(0.12)
            if u106 == u3 then
                faceForward()
                u109.Reveal()
            end
            return
        end
        local v4 = nil
        while true do
            if not (os.clock() - u6 < 20) then
                break
            end
            if u106 == u3 and u101 ~= "clear" and u101 ~= "revealing" then
                v1 = Player.FindRootPart(LocalPlayer)
                Position = if not v1 then nil else v1.Position
                Character = LocalPlayer.Character
                Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                v2 = false
                if Character == a2 then
                    v2 = false
                    if Humanoid ~= nil then
                        v2 = false
                        if 0 < Humanoid.Health then
                            v2 = false
                            if Position ~= nil then
                                v2 = (Position - a1).Magnitude <= 24
                            end
                        end
                    end
                end
                if not v2 then
                    v4 = nil
                    task.wait()
                    continue
                end
                v4 = v4 or os.clock()
                if not ((a3 or 0.12) <= os.clock() - v4) then
                    task.wait()
                    continue
                end
                if LocalPlayer:GetAttribute("InEnchantedTree") ~= true then
                    LightingController.ClearLayer("EnchantedTree", 0)
                elseif LightingController.Presets.EnchantedTree then
                    LightingController.SetLayer("EnchantedTree", "EnchantedTree", 150, 0)
                end
                faceForward()
                u109.Reveal()
                return
            end
            return
        end
    end)
end

function u109.Start() -- Line: 479
    -- upvalues: Remotes (val), u109 (val), LocalPlayer (val), u101 (ref), LightingController (val)
    Remotes.EnchantedTree.Transition.OnClientEvent:Connect(function(a1, a2, a3, a4) -- Line: 481 -- upvalues: u109 (upval)
        if a3 ~= nil then
            return
        end
        local v1 = if typeof(a4) ~= "table" then nil else a4
        if a1 == "Cover" then
            u109.Cover(v1 and v1.TimeoutSeconds)
            return
        end
        if a1 == "Reveal" then
            u109.RevealAfterMove(v1 and v1.Destination, v1 and v1.Character, v1 and v1.HoldSeconds)
        end
    end)
    ;(LocalPlayer:GetAttributeChangedSignal("InEnchantedTree")):Connect(function() -- Line: 498 -- upvalues: u101 (upval), LocalPlayer (upval), LightingController (upval)
        if u101 == "clear" then
            if LocalPlayer:GetAttribute("InEnchantedTree") ~= true then
                LightingController.ClearLayer("EnchantedTree", 0)
            elseif LightingController.Presets.EnchantedTree then
                LightingController.SetLayer("EnchantedTree", "EnchantedTree", 150, 0)
                return
            end
        end
    end)
    if LocalPlayer:GetAttribute("InEnchantedTree") ~= true then
        LightingController.ClearLayer("EnchantedTree", 0)
        return
    end
    if not LightingController.Presets.EnchantedTree then
        return
    end
    LightingController.SetLayer("EnchantedTree", "EnchantedTree", 150, 0)
end

return u109