-- Script path: ReplicatedStorage.Controllers.Game.FishingController
-- Decompile time: 61.25 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Fishing = require(ReplicatedStorage.Shared.Util.Fishing)
local FishingFlags = require(ReplicatedStorage.Shared.Flags.FishingFlags)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Line = require(script.Line)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Spots = require(script.Spots)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Ui = require(script.Ui)
local LocalPlayer = Players.LocalPlayer
local u89 = Color3.fromRGB(255, 85, 85)
local u94 = Color3.fromRGB(180, 230, 255)
local u95 = {DynamicThumbstickFrame = true, ThumbstickFrame = true}
local ButtonR2 = Enum.KeyCode.ButtonR2
local u97 = {
    [Enum.KeyCode.One] = true,
    [Enum.KeyCode.Two] = true,
    [Enum.KeyCode.Three] = true,
    [Enum.KeyCode.Four] = true,
    [Enum.KeyCode.Five] = true,
    [Enum.KeyCode.Six] = true,
    [Enum.KeyCode.Seven] = true,
    [Enum.KeyCode.Eight] = true,
    [Enum.KeyCode.Nine] = true,
    [Enum.KeyCode.Backspace] = true,
    [Enum.KeyCode.ButtonB] = true,
}
local u120 = {
    Mouse = {Cast = "Hold to Cast", Reel = "Click Fast!"},
    Touch = {Cast = "Hold to Cast", Reel = "Tap Fast!"},
    Gamepad = {Cast = "Hold R2 to Cast", Reel = "Mash R2!"},
}
local u124 = nil
local u125 = nil
local u126 = 0
local u127 = nil
local u128 = nil
local u129 = nil
local u130 = 0
local u131 = false
local v1 = {}

local function quest() -- Line: 108 -- upvalues: u127 (ref)
    if u127 == nil then
        local GhostDogQuestController = script.Parent:FindFirstChild("GhostDogQuestController")
        if GhostDogQuestController and GhostDogQuestController:IsA("ModuleScript") then
            local success, err = pcall(require, GhostDogQuestController)
            if success then
                u127 = err
            end
        end
    end
    return u127
end

local function fx() -- Line: 121 -- upvalues: u128 (ref)
    if u128 == nil then
        local GhostDogQuestController = script.Parent:FindFirstChild("GhostDogQuestController")
        local Fx = GhostDogQuestController and GhostDogQuestController:FindFirstChild("Fx")
        if Fx and Fx:IsA("ModuleScript") then
            local success, err = pcall(require, Fx)
            if success then
                u128 = err
            end
        end
    end
    return u128
end

local function keyCatch() -- Line: 135 -- upvalues: u129 (ref)
    if u129 == nil then
        local KeyCatch = script:FindFirstChild("KeyCatch")
        if KeyCatch and KeyCatch:IsA("ModuleScript") then
            local success, err = pcall(require, KeyCatch)
            if success and type(err) == "table" then
                u129 = err
            end
        end
    end
    return u129
end

local function splash(a1, a2) -- Line: 148 -- upvalues: fx (val) -- types: a1: vector, a2: number
    local v1 = fx()
    if v1 and type(v1.Splash) == "function" then
        pcall(v1.Splash, a1 + Vector3.new(0, 0.30000001192092896, 0), a2)
    end
end

local function ripple(a1, a2) -- Line: 155 -- upvalues: fx (val) -- types: a1: vector, a2: number
    local v1 = fx()
    if v1 and type(v1.Ripple) == "function" then
        pcall(v1.Ripple, a1 + Vector3.new(0, 0.30000001192092896, 0), a2)
    end
end

local function inputKind() -- Line: 162 -- upvalues: UserInputService (val)
    local LastInputType = UserInputService:GetLastInputType()
    if LastInputType == Enum.UserInputType.Touch then
        return "Touch"
    end
    if string.find(LastInputType.Name, "Gamepad", 1, true) then
        return "Gamepad"
    end
    if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
        return "Touch"
    end
    return "Mouse"
end

local function play(a1, a2, a3) -- Line: 176
    -- upvalues: ReplicatedStorage (val), Audio (val), SoundService (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local Fishing = Assets and Assets:FindFirstChild("Fishing")
    local v1 = Fishing and Fishing:FindFirstChild("Sounds")
    local v2 = v1 and v1:FindFirstChild(a1)
    if v2 ~= nil and v2:IsA("Sound") then
        v1 = table.clone(a3 or {})
        if v1.SoundGroup == nil then
            v1.SoundGroup = "SFX"
        end
        if a2 ~= nil and v1.MaxDistance == nil then
            v1.MaxDistance = 250
        end
        return Audio.Play(v2, a2 or SoundService, v1)
    end
    return nil
end

local function toast(a1, a2) -- Line: 194 -- upvalues: Toast (val), u94 (val) -- types: a1: string, a2: userdata?
    Toast.Show({Seconds = 2.5, Text = a1, Color = a2 or u94})
end

local function characterParts() -- Line: 198 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    if Character ~= nil and HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") and Humanoid ~= nil then
        return Character, HumanoidRootPart, Humanoid
    end
    return nil, nil, nil
end

local function walking() -- Line: 208 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local v1 = if Character == nil then nil else if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else if Humanoid ~= nil then Humanoid else nil
    local v2 = false
    if v1 ~= nil then
        v2 = 0.1 < v1.MoveDirection.Magnitude
    end
    return v2
end

local function inGuiRect(a1, a2) -- Line: 213 -- types: a1: userdata, a2: userdata
    if not a1:IsA("GuiObject") then
        return false, false
    end
    local AbsoluteSize = a1.AbsoluteSize
    if not (AbsoluteSize.X <= 0) and not (AbsoluteSize.Y <= 0) then
        local AbsolutePosition = a1.AbsolutePosition
        local v1 = false
        if AbsolutePosition.X <= a2.X then
            v1 = false
            if AbsolutePosition.Y <= a2.Y then
                v1 = false
                if a2.X <= AbsolutePosition.X + AbsoluteSize.X then
                    v1 = a2.Y <= AbsolutePosition.Y + AbsoluteSize.Y
                end
            end
        end
        return true, v1
    end
    return false, false
end

local function inStickZone(a1) -- Line: 229
    -- upvalues: LocalPlayer (val), u95 (val), inGuiRect (val), Workspace (val)
    local v1
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local TouchGui = PlayerGui and PlayerGui:FindFirstChild("TouchGui")
    local v2 = TouchGui and TouchGui:FindFirstChild("TouchControlFrame")
    local v3 = false
    if not v2 then
        v1 = a1
    else
        local v4, v5
        for i, j in v2:GetChildren() do
            if not u95[j.Name] and j.Name ~= "JumpButton" then
                continue
            end
            v4, v5 = inGuiRect(j, a1)
            if v5 then
                return true
            end
            if v4 and u95[j.Name] then
                v3 = true
            end
        end
    end
    if v3 then
        return false
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return false
    end
    local ViewportSize = CurrentCamera.ViewportSize
    local v6 = false
    if v1.X < ViewportSize.X * 0.5 then
        local Y = v1.Y
        v6 = ViewportSize.Y * 0.4 < Y
    end
    return v6
end

local function rodTip(a1) -- Line: 258 -- types: a1: userdata
    local RodTip = a1:FindFirstChild("RodTip", true)
    if RodTip and RodTip:IsA("Attachment") then
        return RodTip
    end
    return nil
end

local function screenPoint(a1) -- Line: 263 -- upvalues: Workspace (val) -- types: a1: vector
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return nil
    end
    local v1, v2 = CurrentCamera:WorldToViewportPoint(a1)
    local ViewportSize = CurrentCamera.ViewportSize
    if v2 and not (ViewportSize.X <= 0) and not (ViewportSize.Y <= 0) then
        return Vector2.new(v1.X / ViewportSize.X, v1.Y / ViewportSize.Y)
    end
    return nil
end

local function cursorPoint() -- Line: 276 -- upvalues: Workspace (val), UserInputService (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return nil
    end
    local ViewportSize = CurrentCamera.ViewportSize
    local v1 = UserInputService:GetMouseLocation()
    if not (ViewportSize.X <= 0) and not (ViewportSize.Y <= 0) then
        return Vector2.new(v1.X / ViewportSize.X, v1.Y / ViewportSize.Y)
    end
    return nil
end

local function besideCharacter(a1) -- Line: 289 -- upvalues: Workspace (val), screenPoint (val) -- types: a1: userdata
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return nil
    end
    return screenPoint(a1.Position + CurrentCamera.CFrame.RightVector * 1.6 + Vector3.new(0, 0.6000000238418579, 0))
end

local function aimLook(a1, a2) -- Line: 297
    -- upvalues: Workspace (val), UserInputService (val)
    local v1
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return a2.CFrame.LookVector
    end
    local LookVector = CurrentCamera.CFrame.LookVector
    local LastInputType = UserInputService:GetLastInputType()
    if (if LastInputType ~= Enum.UserInputType.Touch then if not string.find(LastInputType.Name, "Gamepad", 1, true) then if not UserInputService.TouchEnabled then "Mouse" else if UserInputService.MouseEnabled then "Mouse" else "Touch" else "Gamepad" else "Touch") ~= "Mouse" then
        return LookVector
    end
    local MouseLocation = UserInputService:GetMouseLocation()
    local v2 = CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y)
    local v3 = RaycastParams.new()
    v3.FilterType = Enum.RaycastFilterType.Exclude
    v3.FilterDescendantsInstances = {a1 or a2}
    local v4 = Workspace:Raycast(v2.Origin, v2.Direction * 500, v3)
    if not v4 then
        v3 = a2.Position.Y - 3
        local v5 = if not (v2.Direction.Y < -0.01) then -1 else (v3 - v2.Origin.Y) / v2.Direction.Y
        v1 = if not (v5 > 0) then v2.Direction * 3 else v2.Origin + v2.Direction * v5 - a2.Position
    else
        v1 = v4.Position - a2.Position
    end
    v1 = Vector3.new(v1.X, 0, v1.Z)
    if v1.Magnitude < 2 then
        return LookVector
    end
    return v1.Unit
end

local function lockControls(a1) -- Line: 336 -- upvalues: LocalPlayer (val)
    local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
    local PlayerModule = PlayerScripts and PlayerScripts:FindFirstChild("PlayerModule")
    if PlayerModule == nil then
        return
    end
    local success, err = pcall(require, PlayerModule)
    if not success then
        return
    end
    local u20 = err:GetControls()
    if u20 then
        u20:Disable()
        a1:Add(function() -- Line: 349 -- upvalues: u20 (val)
            u20:Enable()
        end)
    end
end

local function hideBackpack(a1) -- Line: 355 -- upvalues: LocalPlayer (val), StarterGui (val), HiddenUIHandler (val)
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local BackpackGui = PlayerGui
    if BackpackGui then
        BackpackGui = PlayerGui:FindFirstChild("BackpackGui")
    end
    local Enabled = false
    if BackpackGui and BackpackGui:IsA("ScreenGui") then
        Enabled = BackpackGui.Enabled
        BackpackGui.Enabled = false
    end
    local success, err = pcall(function() -- Line: 363 -- upvalues: StarterGui (upval)
        return StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack)
    end)
    pcall(function() -- Line: 366 -- upvalues: StarterGui (upval)
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
    end)
    a1:Add(function() -- Line: 369
        -- upvalues: BackpackGui (val), Enabled (ref), HiddenUIHandler (upval), success (val), err (val)
        -- upvalues: StarterGui (upval)
        if BackpackGui and BackpackGui:IsA("ScreenGui") and Enabled and not HiddenUIHandler.IsHidden() then
            BackpackGui.Enabled = true
        end
        if success and err == true then
            pcall(function() -- Line: 379 -- upvalues: StarterGui (upval)
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
            end)
        end
    end)
end

local function hideRodLine(a1, a2) -- Line: 386 -- types: a2: userdata
    for i, j in a2:GetDescendants() do
        if j:IsA("Beam") and j.Enabled then
            j.Enabled = false
            a1:Add(function() -- Line: 390 -- upvalues: j (val)
                if j.Parent ~= nil then
                    j.Enabled = true
                end
            end)
        end
    end
end

local function steerFacing(a1, a2) -- Line: 399 -- upvalues: RunService (val), LocalPlayer (val) -- types: a2: userdata
    local AutoRotate = a2.AutoRotate
    a2.AutoRotate = false
    a1:Add(function() -- Line: 402 -- upvalues: a2 (val), AutoRotate (val)
        if a2.Parent ~= nil then
            a2.AutoRotate = AutoRotate
        end
    end)
    local u8 = nil
    a1:Connect(RunService.RenderStepped, function(a1) -- Line: 408 -- upvalues: LocalPlayer (upval), u8 (ref) -- types: a1: number
        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local v1 = if Character == nil then nil else if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else if Humanoid ~= nil then HumanoidRootPart else nil
        if u8 ~= nil and v1 ~= nil then
            local v2
            _, v2 = v1.CFrame:ToEulerAnglesYXZ()
            local v3 = (u8 - v2 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
            if (math.abs(v3)) < 0.002 then
                return
            end
            local v4 = v2 + v3 * (1 - (math.exp(a1 * -14)))
            v1.CFrame = (CFrame.new(v1.Position)) * CFrame.fromEulerAnglesYXZ(0, v4, 0)
            return
        end
    end)
    return function(a1) -- Line: 421 -- upvalues: u8 (ref) -- types: a1: vector
        local v1 = Vector3.new(a1.X, 0, a1.Z)
        if v1.Magnitude < 0.01 then
            return
        end
        math.atan2(-v1.X, -v1.Z)
    end
end

local function waterInReach(a1, a2) -- Line: 430
    -- upvalues: aimLook (val), Fishing (val)
    local v1 = aimLook(a1, a2)
    for i = 0, 7 do
        if Fishing.Probe(Fishing.Aim(a2.Position, v1, i / 7), {a1}).Water then
            return true
        end
    end
    return false
end

local function finish(a1) -- Line: 442 -- upvalues: u124 (ref), u126 (ref), FishingFlags (val) -- types: a1: table
    if a1.Ended then
        return
    end
    a1.Ended = true
    if u124 == a1 then
        u124 = nil
    end
    local Bobber = a1.Bobber
    if Bobber and not a1.HandedOff then
        Bobber:Destroy()
    end
    a1.Trove:Destroy()
    u126 = os.clock() + FishingFlags.CastCooldown:Get()
end

local function alive(a1) -- Line: 458 -- upvalues: u124 (ref) -- types: a1: table
    return function() -- Line: 459 -- upvalues: a1 (val), u124 (upval)
        return not a1.Ended and u124 == a1
    end
end

local function reelBack(a1) -- Line: 464 -- upvalues: Line (val), finish (val) -- types: a1: table
    local Bobber = a1.Bobber
    if Bobber and Bobber.Parent ~= nil and not a1.Ended then
        local Return = Line.Return
        local RodTip = a1.Tool:FindFirstChild("RodTip", true)
        Return(Bobber, if not RodTip then nil else if not RodTip:IsA("Attachment") then nil else RodTip, 0.4)
    end
    finish(a1)
end

local function cancelServer(a1) -- Line: 472 -- upvalues: Remotes (val) -- types: a1: table
    if a1.Id ~= 0 then
        Remotes.Fishing.Cancel:FireServer(a1.Id)
    end
end

local function biteMark(a1) -- Line: 478
    -- upvalues: ReplicatedStorage (val), LocalPlayer (val), TweenService (val)
    local Bobber = a1.Bobber
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local Fishing = Assets and Assets:FindFirstChild("Fishing")
    local v1 = Fishing and Fishing:FindFirstChild("Bite")
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if Bobber ~= nil and v1 ~= nil and v1:IsA("BillboardGui") and PlayerGui ~= nil then
        local v2 = a1.Trove:Add((v1:Clone()))
        local PrimaryPart = Bobber.PrimaryPart or Bobber:FindFirstChildWhichIsA("BasePart", true)
        v2.Adornee = PrimaryPart
        v2.Parent = PlayerGui
        local v3 = v2:FindFirstChildWhichIsA("TextLabel", true)
        local UIScale = v3 and v3:FindFirstChildOfClass("UIScale")
        if UIScale then
            UIScale.Scale = 2.2
            TweenService:Create(UIScale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
        end
        return
    end
end

local function revealReward(a1, a2) -- Line: 499 -- upvalues: play (val), Ui (val), finish (val) -- types: a1: table
    play("Catch")
    Ui.Reveal(a2, 2.6)
    finish(a1)
end

local function catchKey(a1, a2) -- Line: 505
    -- upvalues: u129 (ref), Ui (val), fx (val), finish (val)
    if u129 == nil then
        local KeyCatch = script:FindFirstChild("KeyCatch")
        if KeyCatch and KeyCatch:IsA("ModuleScript") then
            local success, err = pcall(require, KeyCatch)
            if success and type(err) == "table" then
                u129 = err
            end
        end
    end
    local v1 = u129
    local Surface = a1.Surface
    if v1 ~= nil and type(v1.Play) == "function" and Surface ~= nil then
        Ui.ShowReel(false)
        local Bobber = a1.Bobber
        local Play_2 = v1.Play
        local v2 = {Reward = a2, Landing = Surface, Bobber = Bobber}
        local RodTip = a1.Tool:FindFirstChild("RodTip", true)
        v2.Tip = if not RodTip then nil else if not RodTip:IsA("Attachment") then nil else RodTip
        v2.Fx = fx()
        local success_2, err_2 = pcall(Play_2, v2)
        if not success_2 then
            warn((("[Fishing] manor key catch failed: %*"):format(err_2)))
            return false
        end
        if err_2 ~= true then
            return false
        end
        a1.Bobber = nil
        finish(a1)
        if type(v1.Stow) == "function" then
            pcall(v1.Stow, a2.Icon)
        end
        return true
    end
    return false
end

local function resolveCatch(a1) -- Line: 535
    -- upvalues: Remotes (val), catchKey (val), Ui (val), play (val), finish (val), Fishing (val), Toast (val)
    -- upvalues: u94 (val), u89 (val)
    a1.Phase = "Resolving"
    local success, err, v1 = pcall(function() -- Line: 537 -- upvalues: Remotes (upval), a1 (val)
        return Remotes.Fishing.Reel:InvokeServer(a1.Id, "Caught", a1.Clicks)
    end)
    if a1.Ended then
        return
    end
    if success and err == true and type(v1) == "table" and v1.Kind == "ManorKey" and catchKey(a1, v1) then
        return
    end
    local Bobber = a1.Bobber
    if Bobber then
        Bobber:Destroy()
        a1.Bobber = nil
    end
    Ui.ShowReel(false)
    if success and err == true and type(v1) == "table" then
        play("Catch")
        Ui.Reveal(v1, 2.6)
        finish(a1)
        return
    end
    if not success or err ~= true then
        play("Escape")
        Toast.Show({Seconds = 2.5, Text = Fishing.Messages.Escaped, Color = u89 or u94})
    else
        Toast.Show({Seconds = 2.5, Text = Fishing.Messages.Nothing, Color = u94})
    end
    finish(a1)
end

local function escape(a1) -- Line: 571
    -- upvalues: Remotes (val), Ui (val), play (val), Fishing (val), u89 (val), Toast (val), u94 (val), Line (val)
    -- upvalues: finish (val)
    if a1.Phase ~= "Reeling" then
        return
    end
    a1.Phase = "Resolving"
    local Id = a1.Id
    task.spawn(function() -- Line: 577 -- upvalues: Remotes (upval), Id (val)
        pcall(function() -- Line: 578 -- upvalues: Remotes (upval), Id (upval)
            local v1 = Id
            Remotes.Fishing.Reel:InvokeServer(v1, "Escaped", 0)
        end)
    end)
    Ui.ShowReel(false)
    play("Escape")
    Toast.Show({Seconds = 2.5, Text = Fishing.Messages.Escaped, Color = u89 or u94})
    local Bobber = a1.Bobber
    if Bobber and Bobber.Parent ~= nil and not a1.Ended then
        local Return = Line.Return
        local RodTip = a1.Tool:FindFirstChild("RodTip", true)
        Return(Bobber, if not RodTip then nil else if not RodTip:IsA("Attachment") then nil else RodTip, 0.4)
    end
    finish(a1)
end

local function click(a1) -- Line: 588 -- upvalues: FishingFlags (val), Ui (val), resolveCatch (val) -- types: a1: table
    if a1.Phase ~= "Reeling" then
        return
    end
    a1.Clicks = a1.Clicks + 1
    a1.Fill = math.min(a1.Fill + FishingFlags.ReelClickGain:Get(), 1)
    Ui.PunchReel()
    if 1 <= a1.Fill then
        task.spawn(resolveCatch, a1)
    end
end

local function startReel(a1) -- Line: 600
    -- upvalues: FishingFlags (val), u120 (val), UserInputService (val), Ui (val), play (val), escape (val)
    -- upvalues: RunService (val), Line (val)
    a1.Phase = "Reeling"
    a1.Fill = FishingFlags.ReelStart:Get()
    a1.Clicks = 0
    local LastInputType = UserInputService:GetLastInputType()
    local Reel = u120[if LastInputType ~= Enum.UserInputType.Touch then if not string.find(LastInputType.Name, "Gamepad", 1, true) then if not UserInputService.TouchEnabled then "Mouse" else if UserInputService.MouseEnabled then "Mouse" else "Touch" else "Gamepad" else "Touch"].Reel
    Ui.Tooltip(false)
    Ui.SetReel(a1.Fill, 0, Reel)
    Ui.ShowReel(true, nil)
    local u54 = play("Reel", nil, {Looped = true})
    if u54 then
        a1.Trove:Add(u54)
    end
    local v1 = Ui.StopButton()
    if v1 then
        a1.Trove:Connect(v1.Activated, function() -- Line: 614 -- upvalues: escape (upval), a1 (val)
            escape(a1)
        end)
    end
    local u70 = 0
    local u71 = 0
    a1.Trove:Connect(RunService.RenderStepped, function(a1_2) -- Line: 620
        -- upvalues: a1 (val), FishingFlags (upval), u70 (ref), u71 (ref), u54 (val), Line (upval), Ui (upval)
        -- upvalues: Reel (val), escape (upval)
        if a1.Phase ~= "Reeling" then
            return
        end
        local v1 = a1
        v1.Fill = v1.Fill - FishingFlags.ReelDrainPerSecond:Get() * a1_2
        v1 = a1.Clicks - u70
        u70 = a1.Clicks
        u71 = u71 + (v1 / math.max(a1_2, 0.004166666666666667) - u71) * math.min(a1_2 * 4, 1)
        if u54 then
            u54.PlaybackSpeed = math.clamp(u71 / 12, 0, 0.6) + 0.85
        end
        local Surface = a1.Surface
        local Bobber = a1.Bobber
        if Bobber and Surface then
            Line.Thrash(Bobber, Surface, a1.Fill + 0.6)
        end
        Ui.SetReel(a1.Fill, a1.Clicks, Reel)
        if a1.Fill <= 0 then
            escape(a1)
        end
    end)
end

local function handOff(a1, a2) -- Line: 643
    -- upvalues: Remotes (val), u127 (ref), Line (val), finish (val), Ui (val)
    a1.Phase = "Quest"
    if a1.Id ~= 0 then
        Remotes.Fishing.Cancel:FireServer(a1.Id)
    end
    local Bobber = a1.Bobber
    if u127 == nil then
        local GhostDogQuestController = script.Parent:FindFirstChild("GhostDogQuestController")
        if GhostDogQuestController and GhostDogQuestController:IsA("ModuleScript") then
            local success, err = pcall(require, GhostDogQuestController)
            if success then
                u127 = err
            end
        end
    end
    local v1 = u127
    if Bobber ~= nil and v1 ~= nil and type(v1.Hooked) == "function" then
        a1.HandedOff = true
        a1.Lock:Destroy()
        Ui.Tooltip(false)
        local success_2, err_2 = pcall(v1.Hooked, {Bobber = Bobber, Target = a2})
        if not success_2 then
            warn((("[Fishing] quest hand-off failed: %*"):format(err_2)))
        end
        if Bobber.Parent ~= nil then
            Bobber:Destroy()
        end
        finish(a1)
        return
    end
    local Bobber_2 = a1.Bobber
    if Bobber_2 and Bobber_2.Parent ~= nil and not a1.Ended then
        local Return = Line.Return
        local RodTip = a1.Tool:FindFirstChild("RodTip", true)
        Return(Bobber_2, if not RodTip then nil else if not RodTip:IsA("Attachment") then nil else RodTip, 0.4)
    end
    finish(a1)
end

local function handOffGhostFish(a1, a2) -- Line: 665
    -- upvalues: u127 (ref), Remotes (val), Line (val), finish (val), Ui (val), play (val), Fishing (val), u89 (val)
    -- upvalues: Toast (val), u94 (val)
    a1.Phase = "Quest"
    local Bobber = a1.Bobber
    if u127 == nil then
        local GhostDogQuestController = script.Parent:FindFirstChild("GhostDogQuestController")
        if GhostDogQuestController and GhostDogQuestController:IsA("ModuleScript") then
            local success, err = pcall(require, GhostDogQuestController)
            if success then
                u127 = err
            end
        end
    end
    local v1 = u127
    if Bobber ~= nil and v1 ~= nil and type(v1.GhostFish) == "function" then
        a1.HandedOff = true
        a1.Lock:Destroy()
        Ui.Tooltip(false)
        local success_2, err_2 = pcall(v1.GhostFish, {Bobber = Bobber, Target = a2, Id = a1.Id})
        if not success_2 then
            warn((("[Fishing] ghost fish hand-off failed: %*"):format(err_2)))
        end
        if Bobber.Parent ~= nil then
            Bobber:Destroy()
        end
        if not success_2 or type(err_2) ~= "table" then
            play("Escape")
            Toast.Show({Seconds = 2.5, Text = Fishing.Messages.Escaped, Color = u89 or u94})
        else
            v1 = Ui.Acquire()
            play("Catch")
            Ui.Reveal(err_2, 2.6)
            v1()
        end
        finish(a1)
        return
    end
    if a1.Id ~= 0 then
        Remotes.Fishing.Cancel:FireServer(a1.Id)
    end
    local Bobber_2 = a1.Bobber
    if Bobber_2 and Bobber_2.Parent ~= nil and not a1.Ended then
        local Return = Line.Return
        local RodTip = a1.Tool:FindFirstChild("RodTip", true)
        Return(Bobber_2, if not RodTip then nil else if not RodTip:IsA("Attachment") then nil else RodTip, 0.4)
    end
    finish(a1)
end

local function waitForBite(a1, a2, a3) -- Line: 697
    -- upvalues: u124 (ref), play (val), fx (val), Line (val), Remotes (val), Fishing (val), Toast (val), u94 (val)
    -- upvalues: finish (val), biteMark (val), handOff (val), handOffGhostFish (val), startReel (val)
    local Bobber, Float, Surface, v1, v2, v3
    a1.Phase = "Waiting"
    local v4 = os.clock()
    local v5 = v4 + a2.Wait
    local v6 = {}
    if a2.Mode ~= "Nothing" then
        for i = 1, (math.random(1, 3)) do
            table.insert(v6, v4 + (math.random()) * (math.max(a2.Wait - 0.8, 0.2)))
        end
        table.sort(v6)
    end
    local v7 = 1
    local v8 = 0

    local function v9() -- Line: 459 -- upvalues: a1 (val), u124 (upval)
        return not a1.Ended and u124 == a1
    end

    while v9() do
        if a1.Phase ~= "Waiting" then
            break
        end
        v3 = os.clock()
        Surface = a1.Surface
        Bobber = a1.Bobber
        if v6[v7] and v6[v7] <= v3 then
            v7 = v7 + 1
            v8 = v3 + 0.25
            play("Nibble", Surface, {PlaybackSpeed = 0.9 + math.random() * 0.3})
            v1 = fx()
            if v1 and type(v1.Ripple) == "function" then
                pcall(v1.Ripple, Surface + Vector3.new(0, 0.30000001192092896, 0), 0.5)
            end
        end
        if Bobber then
            Float = Line.Float
            v2 = if not (v3 < v8) then 0 else 0.45
            Float(Bobber, Surface, v3 - v4, v2)
        end
        if v5 <= v3 then
            break
        end
        task.wait()
    end
    if v9() and a1.Phase == "Waiting" then
        if a2.Mode == "Nothing" then
            if a1.Id ~= 0 then
                Remotes.Fishing.Cancel:FireServer(a1.Id)
            end
            Toast.Show({Seconds = 2.5, Text = Fishing.Messages.Nothing, Color = u94})
            local Bobber_2 = a1.Bobber
            if Bobber_2 and Bobber_2.Parent ~= nil and not a1.Ended then
                local Return = Line.Return
                v7 = a1.Tool:FindFirstChild("RodTip", true)
                Return(Bobber_2, if not v7 then nil else if not v7:IsA("Attachment") then nil else v7, 0.4)
            end
            finish(a1)
            return
        end
        play("Bite", a3)
        biteMark(a1)
        v6 = fx()
        if v6 and type(v6.Splash) == "function" then
            pcall(v6.Splash, a3 + Vector3.new(0, 0.30000001192092896, 0), 0.6)
        end
        local Bobber_3 = a1.Bobber
        if Bobber_3 then
            Line.Float(Bobber_3, a3, 0, 0.6)
        end
        if a2.Mode == "Quest" then
            a1.Phase = "Resolving"
            task.wait(0.45)
            if v9() then
                handOff(a1, a3)
            end
            return
        end
        if a2.Mode ~= "GhostFish" then
            startReel(a1)
            return
        end
        a1.Phase = "Resolving"
        task.wait(0.45)
        if v9() then
            handOffGhostFish(a1, a3)
        end
        return
    end
end

local function release(a1) -- Line: 766
    -- upvalues: LocalPlayer (val), finish (val), Fishing (val), Ui (val), screenPoint (val), play (val), aimLook (val)
    -- upvalues: Line (val), Remotes (val), u124 (ref), u89 (val), Toast (val), u94 (val), fx (val), waitForBite (val)
    local v1, v2
    if a1.Phase ~= "Charging" then
        return
    end
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    if Character == nil or HumanoidRootPart == nil or not HumanoidRootPart:IsA("BasePart") then
        v1 = nil
        v2 = nil
    elseif Humanoid ~= nil then
        v1 = Character
        v2 = HumanoidRootPart
    else
        v1 = nil
        v2 = nil
    end
    if v1 ~= nil and v2 ~= nil then
        local Surface
        local u36 = os.clock() - a1.HoldStart
        local v3 = Fishing.ChargeAt(u36)
        local v4 = Fishing.IsPerfect(v3)
        a1.Phase = "Casting"
        Ui.ShowCharge(false)
        if v4 then
            local Head = v1:FindFirstChild("Head")
            Ui.Perfect(if not Head then nil else if not Head:IsA("BasePart") then nil else screenPoint(Head.Position + Vector3.new(0, 2.5999999046325684, 0)))
            play("Perfect", nil, {PlaybackSpeed = 1.25})
        end
        v4 = aimLook(v1, v2)
        a1.Face(v4)
        local u410 = Fishing.Probe(Fishing.Aim(v2.Position, v4, v3), {v1})
        v1 = a1.Tool:FindFirstChild("RodTip", true)
        local v5 = if not v1 then nil else if not v1:IsA("Attachment") then nil else v1
        a1.Bobber = Line.Spawn(v5, if not v5 then v2.Position + Vector3.new(0, 4, 0) else v5.WorldPosition)
        a1.Surface = u410.Point
        play("Release", nil, {PlaybackSpeed = 0.85 + v3 * 0.3})
        play("LineOut", nil, {PlaybackSpeed = 0.9 + v3 * 0.3})
        local u302 = nil
        local u309 = nil
        local u292 = false
        if u410.Water then
            task.spawn(function() -- Line: 802 -- upvalues: Remotes (upval), u36 (val), u410 (val), u302 (ref), u309 (ref), u292 (ref)
                local success, err, v1 = pcall(function() -- Line: 803 -- upvalues: Remotes (upval), u36 (upval), u410 (upval)
                    return Remotes.Fishing.Cast:InvokeServer(u36, u410.Point)
                end)
                if not success then
                    if success and type(v1) == "string" then
                        u309 = v1
                    end
                elseif type(err) == "table" then
                    u302 = err
                elseif success and type(v1) == "string" then
                    u309 = v1
                end
                u292 = true
            end)
        end

        function v5() -- Line: 459 -- upvalues: a1 (val), u124 (upval)
            return not a1.Ended and u124 == a1
        end

        local Bobber = a1.Bobber
        if Bobber then
            local WorldPosition
            Line.Fly(Bobber, WorldPosition, u410.Point, Fishing.FlightSeconds, v5)
        end
        if not v5() then
            return
        end
        if not u410.Water then
            Toast.Show({Seconds = 2.5, Text = Fishing.Messages.Miss, Color = u89 or u94})
            task.wait(0.35)
            local Bobber_2 = a1.Bobber
            if Bobber_2 and Bobber_2.Parent ~= nil and not a1.Ended then
                local Return = Line.Return
                v2 = a1.Tool:FindFirstChild("RodTip", true)
                Return(Bobber_2, if not v2 then nil else if not v2:IsA("Attachment") then nil else v2, 0.4)
            end
            finish(a1)
            return
        end
        play("Splash", u410.Point)
        local Point = u410.Point
        local v6 = fx()
        if v6 and type(v6.Splash) == "function" then
            pcall(v6.Splash, Point + Vector3.new(0, 0.30000001192092896, 0), 0.45)
        end
        local v7 = os.clock()
        while v5() do
            if u292 or not (os.clock() - v7 < 10) then
                break
            end
            Surface = a1.Surface
            if Bobber then
                Line.Float(Bobber, Surface, os.clock() - v7, 0)
            end
            task.wait()
        end
        if not v5() then
            return
        end
        v7 = u302
        if v7 == nil then
            if u309 then
                Toast.Show({Seconds = 2.5, Text = u309, Color = u89 or u94})
            end
            local Bobber_3 = a1.Bobber
            if Bobber_3 and Bobber_3.Parent ~= nil and not a1.Ended then
                local Return_2 = Line.Return
                v3 = a1.Tool:FindFirstChild("RodTip", true)
                Return_2(Bobber_3, if not v3 then nil else if not v3:IsA("Attachment") then nil else v3, 0.4)
            end
            finish(a1)
            return
        end
        a1.Id = v7.Id
        if v7.Mode ~= "Hint" then
            Ui.Tooltip(false)
            waitForBite(a1, v7, u410.Point)
            return
        end
        Toast.Show({Seconds = 2.5, Text = Fishing.Messages.Hint, Color = u94})
        task.wait(0.35)
        local Bobber_4 = a1.Bobber
        if Bobber_4 and Bobber_4.Parent ~= nil and not a1.Ended then
            local Return_3 = Line.Return
            local RodTip = a1.Tool:FindFirstChild("RodTip", true)
            Return_3(Bobber_4, if not RodTip then nil else if not RodTip:IsA("Attachment") then nil else RodTip, 0.4)
        end
        finish(a1)
        return
    end
    finish(a1)
end

local function press(a1) -- Line: 860
    -- upvalues: u124 (ref), click (val), Remotes (val), reelBack (val), u126 (ref), FishingFlags (val), Ui (val)
    -- upvalues: LocalPlayer (val), Fishing (val), Toast (val), u94 (val), u127 (ref), u125 (ref), lockControls (val)
    -- upvalues: steerFacing (val), hideBackpack (val), hideRodLine (val), play (val), UserInputService (val), u97 (val)
    -- upvalues: RunService (val), aimLook (val), besideCharacter (val)
    local v1 = u124
    if v1 then
        if v1.Phase == "Reeling" then
            click(v1)
            return
        end
        if v1.Phase == "Waiting" then
            v1.Phase = "Resolving"
            if v1.Id ~= 0 then
                Remotes.Fishing.Cancel:FireServer(v1.Id)
            end
            task.spawn(reelBack, v1)
        end
        return
    end
    if not (os.clock() < u126) and FishingFlags.Enabled:Get() and Ui.Ready() then
        local v2, v3, v4
        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        if Character == nil or HumanoidRootPart == nil or not HumanoidRootPart:IsA("BasePart") then
            v2 = nil
            v3 = nil
            v4 = nil
        elseif Humanoid ~= nil then
            v2 = Character
            v3 = HumanoidRootPart
            v4 = Humanoid
        else
            v2 = nil
            v3 = nil
            v4 = nil
        end
        if v2 ~= nil and v3 ~= nil and v4 ~= nil and a1.Parent == v2 then
            if FishingFlags.DimensionOnly:Get()
                and LocalPlayer:GetAttribute("InHalloweenDimension") ~= true
                and LocalPlayer:GetAttribute("InSewerCave") ~= true then
                Toast.Show({Seconds = 2.5, Text = Fishing.Messages.Dimension, Color = u94})
                return
            end
            if u127 == nil then
                v2 = script.Parent:FindFirstChild("GhostDogQuestController")
                if v2 and v2:IsA("ModuleScript") then
                    local success, err = pcall(require, v2)
                    if success then
                        u127 = err
                    end
                end
            end
            v3 = u127
            if v3 and type(v3.PrepareCast) == "function" then
                local success_2, err_2 = pcall(v3.PrepareCast)
                if success_2 and err_2 == false then
                    return
                end
            end
            v3 = u125
            if v3 == nil then
                return
            end
            local v5 = v3:Extend()
            v3 = v5:Extend()
            local u123 = {
                Phase = "Charging",
                Id = 0,
                Fill = 0,
                Clicks = 0,
                HandedOff = false,
                Ended = false,
                Trove = v5,
                Lock = v3,
                Tool = a1,
            }

            function u123.Face() end

            u123.HoldStart = os.clock()
            u124 = u123
            v5:Add(function() -- Line: 916 -- upvalues: u123 (val), u124 (upval), Remotes (upval), Ui (upval)
                if not u123.Ended then
                    u123.Ended = true
                    if u124 == u123 then
                        u124 = nil
                    end
                    local v1 = u123
                    if v1.Id ~= 0 then
                        Remotes.Fishing.Cancel:FireServer(v1.Id)
                    end
                    local Bobber = u123.Bobber
                    if Bobber and not u123.HandedOff then
                        Bobber:Destroy()
                    end
                end
                Ui.ShowCharge(false)
                Ui.ShowReel(false)
            end)
            Remotes.Fishing.Hold:FireServer()
            lockControls(v3)
            u123.Face = steerFacing(v3, v4)
            hideBackpack(v5)
            hideRodLine(v5, a1)
            Ui.Tooltip(false)
            Ui.ShowCharge(true, FishingFlags.PerfectMin:Get(), FishingFlags.PerfectMax:Get())
            local u180 = play("Charge", nil, {Looped = true})
            if u180 then
                v5:Add(u180)
            end
            v5:Connect(UserInputService.InputBegan, function(a1) -- Line: 942
                -- upvalues: u97 (upval), u123 (val), LocalPlayer (upval), click (upval)
                if u97[a1.KeyCode] and u123.Phase ~= "Quest" then
                    local v1
                    local Character = LocalPlayer.Character
                    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                    if not (if Character == nil then nil else if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else if Humanoid ~= nil then Humanoid else nil) then
                        return
                    end
                    v1:UnequipTools()
                    return
                end
                if a1.KeyCode == Enum.KeyCode.ButtonA and u123.Phase == "Reeling" then
                    click(u123)
                end
            end)
            v5:Connect(RunService.RenderStepped, function() -- Line: 952
                -- upvalues: u123 (val), u180 (val), LocalPlayer (upval), Fishing (upval), aimLook (upval), Ui (upval)
                -- upvalues: besideCharacter (upval)
                local v1, v2
                if u123.Phase ~= "Charging" then
                    if u180 and u180.Parent ~= nil then
                        u180:Destroy()
                    end
                    return
                end
                local Character = LocalPlayer.Character
                local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                if Character == nil or HumanoidRootPart == nil or not HumanoidRootPart:IsA("BasePart") then
                    v1 = nil
                    v2 = nil
                elseif Humanoid ~= nil then
                    v1 = Character
                    v2 = HumanoidRootPart
                else
                    v1 = nil
                    v2 = nil
                end
                if v2 == nil then
                    return
                end
                local v3 = Fishing.ChargeAt(os.clock() - u123.HoldStart)
                u123.Face((aimLook(v1, v2)))
                Ui.SetCharge(v3, Fishing.LuckText(Fishing.LuckFor(v3)), Fishing.IsPerfect(v3), besideCharacter(v2))
                if u180 then
                    u180.PlaybackSpeed = 0.8 + v3 * 0.7
                end
            end)
            return
        end
        return
    end
end

local function updateTooltip(a1) -- Line: 977
    -- upvalues: u124 (ref), LocalPlayer (val), UserInputService (val), u120 (val), Workspace (val), screenPoint (val)
    -- upvalues: Ui (val), u126 (ref), FishingFlags (val), u131 (ref), u130 (ref), waterInReach (val)
    local v1, v2, v3, v4, v5
    local v6 = u124
    if v6 and v6.Phase ~= "Waiting" then
        return
    end
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    if Character == nil or HumanoidRootPart == nil or not HumanoidRootPart:IsA("BasePart") then
        v1 = nil
        v2 = nil
    elseif Humanoid ~= nil then
        v1 = Character
        v2 = HumanoidRootPart
    else
        v1 = nil
        v2 = nil
    end
    local LastInputType = UserInputService:GetLastInputType()
    local Cast = u120[if LastInputType ~= Enum.UserInputType.Touch then if not string.find(LastInputType.Name, "Gamepad", 1, true) then if not UserInputService.TouchEnabled then "Mouse" else if UserInputService.MouseEnabled then "Mouse" else "Touch" else "Gamepad" else "Touch"].Cast
    if v3 == "Mouse" then
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera ~= nil then
            local ViewportSize = CurrentCamera.ViewportSize
            v5 = UserInputService:GetMouseLocation()
            v4 = if ViewportSize.X <= 0 then nil else if not (ViewportSize.Y <= 0) then Vector2.new(v5.X / ViewportSize.X, v5.Y / ViewportSize.Y) else nil
        else
            v4 = nil
        end
    elseif not v2 then
        v4 = Ui.TouchAnchor()
    else
        local CurrentCamera_2 = Workspace.CurrentCamera
        v4 = (if CurrentCamera_2 ~= nil then screenPoint(v2.Position + CurrentCamera_2.CFrame.RightVector * 1.6 + Vector3.new(0, 0.6000000238418579, 0)) else nil) or Ui.TouchAnchor()
    end
    v3 = false
    if v6 == nil then
        v3 = false
        v5 = os.clock()
        if u126 <= v5 then
            v3 = FishingFlags.Enabled:Get()
            if v3 then
                v3 = false
                if v1 ~= nil then
                    v3 = false
                    if v2 ~= nil then
                        v3 = false
                        if a1.Parent == v1 then
                            v5 = FishingFlags.DimensionOnly:Get()
                            if v5 then
                                v5 = false
                                if LocalPlayer:GetAttribute("InHalloweenDimension") ~= true then
                                    v5 = LocalPlayer:GetAttribute("InSewerCave") ~= true
                                end
                            end
                            v3 = not v5
                        end
                    end
                end
            end
        end
    end
    if v3 then
        v5 = os.clock()
        if u130 <= v5 and v1 and v2 then
            u130 = os.clock() + 0.1
            u131 = waterInReach(v1, v2)
        end
    else
        u131 = false
        u130 = 0
    end
    Ui.Tooltip(v3 and u131 and v4 ~= nil, Cast, v4)
end

local function onEquipped(a1) -- Line: 1015
    -- upvalues: u125 (ref), Trove (val), u130 (ref), u131 (ref), Ui (val), u124 (ref), finish (val), release (val)
    -- upvalues: LocalPlayer (val), press (val), UserInputService (val), ButtonR2 (val), inStickZone (val)
    -- upvalues: RunService (val), updateTooltip (val)
    local v1 = u125
    if v1 then
        v1:Destroy()
    end
    v1 = Trove.new()
    u125 = v1
    u130 = 0
    u131 = false
    v1:Add((Ui.Acquire()))
    v1:Add(function() -- Line: 1025 -- upvalues: u124 (upval), finish (upval), Ui (upval)
        local v1 = u124
        if v1 and not v1.HandedOff then
            finish(v1)
        end
        Ui.Tooltip(false)
    end)
    local u20 = {}
    local u21 = nil
    local u22 = nil
    local u23 = (-1 / 0)
    local u24 = nil
    local zero = Vector2.zero
    local u26 = 0

    local function touchOwned() -- Line: 1041 -- upvalues: u20 (val), u23 (ref)
        local v1 = true
        if next(u20) == nil then
            v1 = os.clock() - u23 < 0.35
        end
        return v1
    end

    local u28 = nil
    local u29 = nil
    local u30 = (-1 / 0)

    local function padDown() -- Line: 1049 -- upvalues: u28 (ref)
        local v1 = u28
        if v1 == nil then
            return false
        end
        local UserInputState = v1.UserInputState
        local v2 = false
        if UserInputState ~= Enum.UserInputState.End then
            v2 = UserInputState ~= Enum.UserInputState.Cancel
        end
        return v2
    end

    local function claimPad() -- Line: 1058 -- upvalues: u124 (upval), u29 (ref), u28 (ref)
        local v1 = u124
        if u29 == nil then
            local v2
            local v3 = u28
            if v3 ~= nil then
                local UserInputState = v3.UserInputState
                v2 = false
                if UserInputState ~= Enum.UserInputState.End then
                    v2 = UserInputState ~= Enum.UserInputState.Cancel
                end
            else
                v2 = false
            end
            if v2 and v1 and v1.Phase == "Charging" and os.clock() - v1.HoldStart < 0.25 then
                u29 = v1
            end
        end
    end

    local function endPad() -- Line: 1071 -- upvalues: u28 (ref), u30 (ref), u29 (ref), u124 (upval), release (upval)
        u28 = nil
        os.clock()
        local v1 = u29
        u29 = nil
        if v1 and u124 == v1 and v1.Phase == "Charging" then
            task.spawn(release, v1)
        end
    end

    local function promoteTouch() -- Line: 1081
        -- upvalues: u24 (ref), zero (ref), u26 (ref), u124 (upval), LocalPlayer (upval), press (upval), a1 (val)
        -- upvalues: u21 (ref), u22 (ref)
        local v1 = u24
        if v1 == nil then
            return
        end
        local UserInputState = v1.UserInputState
        if UserInputState ~= Enum.UserInputState.End and UserInputState ~= Enum.UserInputState.Cancel then
            if 12 < ((Vector2.new(v1.Position.X, v1.Position.Y)) - zero).Magnitude then
                u24 = nil
                return
            end
            if os.clock() - u26 < 0.13 then
                return
            end
            u24 = nil
            if u124 == nil then
                local Character = LocalPlayer.Character
                local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                local v2 = if Character == nil then nil else if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else if Humanoid ~= nil then Humanoid else nil
                local v3 = false
                if v2 ~= nil then
                    v3 = 0.1 < v2.MoveDirection.Magnitude
                end
                if not v3 then
                    press(a1)
                    v3 = u124
                    if v3 and v3.Phase == "Charging" then
                        u21 = v1
                        u22 = v3
                    end
                    return
                end
            end
            return
        end
        u24 = nil
    end

    local function endTouch(a1) -- Line: 1111
        -- upvalues: u20 (val), u23 (ref), u24 (ref), u21 (ref), u22 (ref), u124 (upval), release (upval)
        if u20[a1] then
            u20[a1] = nil
            os.clock()
        end
        if a1 == u24 then
            u24 = nil
        end
        if a1 ~= u21 then
            return
        end
        local v1 = u22
        u21 = nil
        u22 = nil
        if v1 and u124 == v1 and v1.Phase == "Charging" then
            task.spawn(release, v1)
        end
    end

    v1:Connect(a1.Activated, function() -- Line: 1130
        -- upvalues: u20 (val), u23 (ref), u124 (upval), u30 (ref), press (upval), a1 (val), u29 (ref), u28 (ref)
        local v1 = true
        if next(u20) == nil then
            v1 = os.clock() - u23 < 0.35
        end
        if v1 then
            return
        end
        if u124 ~= nil and os.clock() - u30 < 0.35 then
            return
        end
        press(a1)
        v1 = u124
        if u29 == nil then
            local v2
            local v3 = u28
            if v3 ~= nil then
                local UserInputState = v3.UserInputState
                v2 = false
                if UserInputState ~= Enum.UserInputState.End then
                    v2 = UserInputState ~= Enum.UserInputState.Cancel
                end
            else
                v2 = false
            end
            if v2 and v1 and v1.Phase == "Charging" and os.clock() - v1.HoldStart < 0.25 then
                u29 = v1
            end
        end
    end)
    v1:Connect(a1.Deactivated, function() -- Line: 1140 -- upvalues: u20 (val), u23 (ref), u29 (ref), u124 (upval), release (upval)
        local v1 = true
        if next(u20) == nil then
            v1 = os.clock() - u23 < 0.35
        end
        if not v1 and u29 == nil then
            v1 = u124
            if v1 and v1.Phase == "Charging" then
                task.spawn(release, v1)
            end
            return
        end
    end)
    v1:Connect(UserInputService.InputBegan, function(a1_2, a2) -- Line: 1149
        -- upvalues: ButtonR2 (upval), u28 (ref), u30 (ref), u124 (upval), press (upval), a1 (val), u29 (ref), u20 (val)
        -- upvalues: u23 (ref), inStickZone (upval), u24 (ref), LocalPlayer (upval), zero (ref), u26 (ref)
        local UserInputState, v1, v2, v3, v4
        if a1_2.KeyCode ~= ButtonR2 then
            if a1_2.UserInputType == Enum.UserInputType.Touch and not a2 then
                u20[a1_2] = true
                os.clock()
                v1 = u124
                if v1 and v1.Phase == "Charging" then
                    return
                end
                v2 = Vector2.new(a1_2.Position.X, a1_2.Position.Y)
                if inStickZone(v2) then
                    return
                end
                if v1 then
                    press(a1)
                    return
                end
                if u24 == nil then
                    local Character = LocalPlayer.Character
                    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
                    local v5 = if Character == nil then nil else if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else if Humanoid ~= nil then Humanoid else nil
                    v3 = false
                    if v5 ~= nil then
                        v3 = 0.1 < v5.MoveDirection.Magnitude
                    end
                    if not v3 then
                        u24 = a1_2
                        zero = v2
                        os.clock()
                        return
                    end
                end
                return
            end
            return
        end
        u28 = a1_2
        os.clock()
        v1 = u124
        if not v1 then
            v2 = u124
            if u29 == nil then
                v4 = u28
                if v4 ~= nil then
                    UserInputState = v4.UserInputState
                    v3 = false
                    if UserInputState ~= Enum.UserInputState.End then
                        v3 = UserInputState ~= Enum.UserInputState.Cancel
                    end
                else
                    v3 = false
                end
                if v3 and v2 and v2.Phase == "Charging" and os.clock() - v2.HoldStart < 0.25 then
                    u29 = v2
                end
            end
            return
        end
        if v1.Phase ~= "Reeling" and v1.Phase ~= "Waiting" then
            v2 = u124
            if u29 == nil then
                v4 = u28
                if v4 ~= nil then
                    UserInputState = v4.UserInputState
                    v3 = false
                    if UserInputState ~= Enum.UserInputState.End then
                        v3 = UserInputState ~= Enum.UserInputState.Cancel
                    end
                else
                    v3 = false
                end
                if v3 and v2 and v2.Phase == "Charging" and os.clock() - v2.HoldStart < 0.25 then
                    u29 = v2
                end
            end
            return
        end
        press(a1)
    end)
    v1:Connect(UserInputService.InputEnded, function(a1) -- Line: 1185
        -- upvalues: endTouch (val), ButtonR2 (upval), u28 (ref), u30 (ref), u29 (ref), u124 (upval), release (upval)
        if a1.UserInputType == Enum.UserInputType.Touch then
            endTouch(a1)
            return
        end
        if a1.KeyCode == ButtonR2 then
            u28 = nil
            os.clock()
            local v1 = u29
            u29 = nil
            if v1 and u124 == v1 and v1.Phase == "Charging" then
                task.spawn(release, v1)
            end
        end
    end)
    v1:Connect(RunService.RenderStepped, function() -- Line: 1192
        -- upvalues: u28 (ref), u30 (ref), u29 (ref), u124 (upval), release (upval), u20 (val), endTouch (val)
        -- upvalues: promoteTouch (val), updateTooltip (upval), a1 (val)
        local UserInputState, v1
        if u28 then
            local v2
            v1 = u28
            if v1 ~= nil then
                local UserInputState_2 = v1.UserInputState
                v2 = false
                if UserInputState_2 ~= Enum.UserInputState.End then
                    v2 = UserInputState_2 ~= Enum.UserInputState.Cancel
                end
            else
                v2 = false
            end
            if not v2 then
                u28 = nil
                os.clock()
                v2 = u29
                u29 = nil
                if v2 and u124 == v2 and v2.Phase == "Charging" then
                    task.spawn(release, v2)
                end
            end
        end
        v1 = nil
        local v3 = nil
        for i in u20, v1, v3 do
            UserInputState = i.UserInputState
            if UserInputState == Enum.UserInputState.End or UserInputState == Enum.UserInputState.Cancel then
                endTouch(i)
            end
        end
        promoteTouch()
        updateTooltip(a1)
    end)
end

local function onUnequipped(a1) -- Line: 1207 -- upvalues: u125 (ref), u124 (ref) -- types: a1: userdata
    local v1 = u125
    if v1 == nil then
        return
    end
    local v2 = u124
    if v2 and v2.Tool ~= a1 then
        return
    end
    if v2 and v2.HandedOff then
        return
    end
    u125 = nil
    v1:Destroy()
end

local function watchCharacter(a1, a2) -- Line: 1223
    -- upvalues: Fishing (val), onEquipped (val), u125 (ref), u124 (ref)
    local u4 = a2:Extend()
    u4:Connect(a1.ChildAdded, function(a1) -- Line: 1225 -- upvalues: Fishing (upval), onEquipped (upval) -- types: a1: userdata
        if Fishing.IsRod(a1) then
            onEquipped(a1)
        end
    end)
    u4:Connect(a1.ChildRemoved, function(a1) -- Line: 1230 -- upvalues: Fishing (upval), u125 (upval), u124 (upval) -- types: a1: userdata
        if Fishing.IsRod(a1) then
            local v1 = u125
            if v1 == nil then
                return
            end
            local v2 = u124
            if v2 and v2.Tool ~= a1 then
                return
            end
            if v2 and v2.HandedOff then
                return
            end
            u125 = nil
            v1:Destroy()
        end
    end)
    u4:Connect(a1.AncestryChanged, function() -- Line: 1235 -- upvalues: a1 (val), u4 (val)
        if a1.Parent == nil then
            u4:Destroy()
        end
    end)
    u4:Add(function() -- Line: 1240 -- upvalues: u125 (upval), u124 (upval)
        local v1 = u125
        local v2 = u124
        if v1 then
            if not v2 or not v2.HandedOff then
                u125 = nil
                v1:Destroy()
            end
        end
    end)
    local v1 = Fishing.EquippedRod(a1)
    if v1 then
        onEquipped(v1)
    end
end

function v1.Start() -- Line: 1254
    -- upvalues: Trove (val), LocalPlayer (val), watchCharacter (val), Spots (val), u124 (ref), u125 (ref)
    local u2 = Trove.new()
    u2:Connect(LocalPlayer.CharacterAdded, function(a1) -- Line: 1256 -- upvalues: watchCharacter (upval), u2 (val) -- types: a1: userdata
        watchCharacter(a1, u2)
    end)
    if LocalPlayer.Character then
        watchCharacter(LocalPlayer.Character, u2)
    end
    Spots.Start(u2, function() -- Line: 1262 -- upvalues: u124 (upval)
        return u124 ~= nil
    end)
    u2:Add(function() -- Line: 1265 -- upvalues: u125 (upval)
        local v1 = u125
        u125 = nil
        if v1 then
            v1:Destroy()
        end
    end)
    return u2
end

return v1