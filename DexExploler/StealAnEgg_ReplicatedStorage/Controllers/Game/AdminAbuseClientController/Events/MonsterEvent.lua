-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.MonsterEvent
-- Decompile time: 19.73 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Trove = require(ReplicatedStorage.Packages.Trove)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local EggState = require(ReplicatedStorage.Client.EggState)
local Identity = require(ReplicatedStorage.Shared.Utils.Identity)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local AvatarBust = Enum.ThumbnailType.AvatarBust
local Size150x150 = Enum.ThumbnailSize.Size150x150
local u66 = UDim2.fromScale(0, 0)
local u71 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u76 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u81 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u86 = Color3.fromRGB(255, 255, 32)
local u91 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u95 = Vector2.new(0.3, 0.35)
local u99 = Vector2.new(0.7, 0.65)
local u104 = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u109 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local u111 = Trove.new()
local u112 = false
local LocalPlayer = Players.LocalPlayer
local MonsterEventUI = LocalPlayer.PlayerGui:WaitForChild("MonsterEventUI")
local Rows = MonsterEventUI.Board.Rows
local u121 = {}
local u122 = {}
local u123 = {}
local u124 = {}
local u125 = nil
local u126 = false
local u127 = {}
local u128 = {}
local u129 = false
local UpdateWinsUI = nil

local function BuildRow(a1) -- Line: 107 -- upvalues: Rows (val), u66 (val) -- types: a1: string
    local v1 = Rows:FindFirstChild(a1)
    local v2 = ("MonsterEventUI is missing its %* row"):format(a1)
    assert(v1 and v1:IsA("Frame"), v2)
    local Avatar = v1:FindFirstChild("Avatar")
    local v3 = ("the %* row is missing its Avatar"):format(a1)
    assert(Avatar and Avatar:IsA("ImageLabel"), v3)
    local Amount = Avatar:FindFirstChild("Amount")
    local v4 = ("the %* row is missing its Amount label"):format(a1)
    assert(Amount and Amount:IsA("TextLabel"), v4)
    v2 = {
        Shown = false,
        Frame = v1,
        Avatar = Avatar,
        Amount = Amount,
        BaseSize = v1.Size,
        BaseColor = v1.BackgroundColor3,
    }
    v1.Size = u66
    v1.Visible = false
    return v2
end

local function SetRowShown(a1, a2) -- Line: 130
    -- upvalues: u66 (val), TweenService (val), u71 (val)
    if a1.Shown == a2 then
        return
    end
    a1.Shown = a2
    local Frame = a1.Frame
    if a2 then
        Frame.Size = u66
        Frame.Visible = true
        TweenService:Create(Frame, u71, {Size = a1.BaseSize}):Play()
        return
    end
    local v1 = TweenService:Create(Frame, u71, {Size = u66})
    v1.Completed:Once(function() -- Line: 145 -- upvalues: Frame (val), a1 (val)
        Frame.Visible = a1.Shown
    end)
    v1:Play()
end

local function FlashRow(a1) -- Line: 149 -- upvalues: TweenService (val), u76 (val) -- types: a1: table
    a1.Frame.BackgroundColor3 = a1.BaseColor:Lerp(Color3.new(1, 1, 1), 0.6)
    TweenService:Create(a1.Frame, u76, {BackgroundColor3 = a1.BaseColor}):Play()
end

local function ResolvePlayerImage(a1) -- Line: 155
    -- upvalues: u122 (val), u123 (val), Players (val), Identity (val), AvatarBust (val), Size150x150 (val)
    -- upvalues: UpdateWinsUI (ref)
    local v1 = u122[a1]
    if v1 then
        return v1
    end
    if u123[a1] then
        return nil
    end
    local u10 = Players:FindFirstChild(a1)
    if u10 and u10:IsA("Player") then
        u123[a1] = true
        task.spawn(function() -- Line: 165
            -- upvalues: Identity (upval), u10 (val), AvatarBust (upval), Size150x150 (upval), u123 (upval), a1 (val)
            -- upvalues: u122 (upval), UpdateWinsUI (upval)
            local v1 = Size150x150
            local success, err = pcall(Identity.Thumbnail, u10.UserId, AvatarBust, v1)
            u123[a1] = nil
            if success and type(err) == "string" then
                u122[a1] = err
                UpdateWinsUI()
            end
        end)
        return nil
    end
    return nil
end

local function FillRow(a1, a2, a3) -- Line: 177
    -- upvalues: ResolvePlayerImage (val), Simple (val), FlashRow (val), u66 (val), TweenService (val), u71 (val)
    local v1 = ResolvePlayerImage(a2)
    a1.Avatar.Image = v1 or ""
    a1.Amount.Text = Simple.FormatCompact(a3, ".#")
    if a1.Occupant ~= nil and a1.Occupant ~= a2 then
        FlashRow(a1)
    end
    a1.Occupant = a2
    if a1.Shown == true then
        return
    end
    a1.Shown = true
    local Frame = a1.Frame
    Frame.Size = u66
    Frame.Visible = true
    TweenService:Create(Frame, u71, {Size = a1.BaseSize}):Play()
end

local function ClearRow(a1) -- Line: 190 -- upvalues: TweenService (val), u71 (val), u66 (val) -- types: a1: table
    a1.Occupant = nil
    if a1.Shown == false then
        return
    end
    a1.Shown = false
    local Frame = a1.Frame
    local v1 = TweenService:Create(Frame, u71, {Size = u66})
    v1.Completed:Once(function() -- Line: 145 -- upvalues: Frame (val), a1 (val)
        Frame.Visible = a1.Shown
    end)
    v1:Play()
end

function UpdateWinsUI() -- Line: 195
    -- upvalues: u121 (ref), LocalPlayer (val), u124 (val), TweenService (val), u71 (val), u66 (val), FillRow (val)
    -- upvalues: u125 (ref)
    local v1, v2
    local v3 = {}
    for i, j in u121 do
        if j > 0 then
            table.insert(v3, {Name = i, Wins = j})
        end
    end
    table.sort(v3, function(a1, a2) -- Line: 204
        if a1.Wins ~= a2.Wins then
            return a2.Wins < a1.Wins
        end
        return a1.Name < a2.Name
    end)
    local v4 = false
    local v5 = nil
    local v6 = nil
    for k, n in u124, v5, v6 do
        v2 = v3[k]
        if v2 ~= nil then
            FillRow(n, v2.Name, v2.Wins)
            v4 = v4 or v2.Name == LocalPlayer.Name
        else
            n.Occupant = nil
            if n.Shown ~= false then
                n.Shown = false
                local Frame_2 = n.Frame
                v1 = TweenService:Create(Frame_2, u71, {Size = u66})
                v1.Completed:Once(function() -- Line: 145 -- upvalues: Frame_2 (val), n (val)
                    Frame_2.Visible = n.Shown
                end)
                v1:Play()
            end
        end
    end
    local u29 = u125
    assert(u29, "MonsterEventUI has no You row")
    if not v4 then
        local Name
        FillRow(u29, Name, u121[Name] or 0)
        return
    end
    u29.Occupant = nil
    if u29.Shown == false then
        return
    end
    u29.Shown = false
    local Frame = u29.Frame
    v5 = TweenService:Create(Frame, u71, {Size = u66})
    v5.Completed:Once(function() -- Line: 145 -- upvalues: Frame (val), u29 (val)
        Frame.Visible = u29.Shown
    end)
    v5:Play()
end

local function CollectWinPartFades(a1) -- Line: 235 -- types: a1: userdata
    local v1 = {{Property = "Transparency", Object = a1, Base = a1.Transparency}}
    for i, j in a1:GetDescendants() do
        if j:IsA("TextLabel") then
            table.insert(v1, {Property = "TextTransparency", Object = j, Base = j.TextTransparency})
            table.insert(v1, {Property = "BackgroundTransparency", Object = j, Base = j.BackgroundTransparency})
        elseif j:IsA("ImageLabel") then
            table.insert(v1, {Property = "ImageTransparency", Object = j, Base = j.ImageTransparency})
            table.insert(v1, {Property = "BackgroundTransparency", Object = j, Base = j.BackgroundTransparency})
        elseif j:IsA("Frame") then
            table.insert(v1, {Property = "BackgroundTransparency", Object = j, Base = j.BackgroundTransparency})
        elseif j:IsA("UIStroke") then
            table.insert(v1, {Property = "Transparency", Object = j, Base = j.Transparency})
        end
    end
    return v1
end

local function SetWinPartHidden(a1, a2) -- Line: 255
    -- upvalues: TweenService (val), u81 (val)
    local Base
    if a1.Hidden == a2 then
        return
    end
    a1.Hidden = a2
    if not a2 then
        a1.Gui.Enabled = true
    end
    local v1 = nil
    local v2 = nil
    local v3 = a2
    for i, j in a1.Fades, v1, v2 do
        Base = if not v3 then j.Base else 1
        TweenService:Create(j.Object, u81, {[j.Property] = Base}):Play()
    end
    if v3 then
        task.delay(0.35, function() -- Line: 269 -- upvalues: a1 (val)
            if a1.Hidden then
                a1.Gui.Enabled = false
            end
        end)
    end
end

local function ApplyWinPartVisibility() -- Line: 277
    -- upvalues: u127 (ref), SetWinPartHidden (val), u129 (ref), u128 (ref)
    local v1
    local v2 = nil
    local v3 = nil
    for i, j in u127, v2, v3 do
        v1 = u129 or u128[i] == true
        SetWinPartHidden(j, v1)
    end
end

local function FlashWinClaim() -- Line: 284 -- upvalues: u86 (val), Lighting (val), TweenService (val), u91 (val)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect")
    ColorCorrectionEffect.Name = "MonsterEventWinFlash"
    ColorCorrectionEffect.TintColor = u86
    ColorCorrectionEffect.Contrast = 0.2
    ColorCorrectionEffect.Saturation = 0.1
    ColorCorrectionEffect.Parent = Lighting
    ColorCorrectionEffect.Enabled = true
    local v1 = TweenService:Create(ColorCorrectionEffect, u91, {Contrast = 0, Saturation = 0, TintColor = Color3.new(1, 1, 1)})
    v1.Completed:Once(function() -- Line: 300 -- upvalues: ColorCorrectionEffect (val)
        ColorCorrectionEffect:Destroy()
    end)
    v1:Play()
end

local function GetLocalRowAvatar() -- Line: 305 -- upvalues: LocalPlayer (val), u124 (val), u125 (ref)
    local Name = LocalPlayer.Name
    for i, j in u124 do
        if j.Shown and j.Occupant == Name then
            return j.Avatar
        end
    end
    local v1 = u125
    if v1 ~= nil and v1.Shown and v1.Occupant == Name then
        return v1.Avatar
    end
    return nil
end

local function ScreenPositionOf(a1) -- Line: 318 -- upvalues: MonsterEventUI (val) -- types: a1: userdata
    local AbsoluteSize = MonsterEventUI.AbsoluteSize
    local v1 = a1.AbsolutePosition + a1.AbsoluteSize * 0.5 - MonsterEventUI.AbsolutePosition
    return UDim2.fromScale(v1.X / AbsoluteSize.X, v1.Y / AbsoluteSize.Y)
end

local function SpawnTrophyBurst(a1) -- Line: 324
    -- upvalues: TweenService (val), u95 (val), u99 (val), MonsterEventUI (val), u104 (val), GetLocalRowAvatar (val)
    -- upvalues: u109 (val)
    local UIAspectRatioConstraint
    for i = 1, (math.clamp(a1, 1, 7)) do
        local ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "MonsterEventTrophy"
        ImageLabel.Image = "rbxassetid://82857133407630"
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.ImageTransparency = 1
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        ImageLabel.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(ImageLabel, TweenInfo.new(0.1), {Size = UDim2.fromScale(0.06, 0.06)}):Play()
        ImageLabel.Rotation = math.random(0, 359)
        ImageLabel.Position = UDim2.fromScale(u95.X + math.random() * (u99.X - u95.X), u95.Y + math.random() * (u99.Y - u95.Y))
        ImageLabel.ZIndex = 10
        UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
        UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
        UIAspectRatioConstraint.Parent = ImageLabel
        ImageLabel.Parent = MonsterEventUI
        TweenService:Create(ImageLabel, u104, {ImageTransparency = 0}):Play()
        task.delay(0.2, function() -- Line: 348
            -- upvalues: ImageLabel (val), GetLocalRowAvatar (upval), MonsterEventUI (upval), TweenService (upval)
            -- upvalues: u109 (upval)
            if ImageLabel.Parent == nil then
                return
            end
            local v1 = GetLocalRowAvatar()
            local v2 = {ImageTransparency = 1}
            if v1 ~= nil then
                local AbsoluteSize = MonsterEventUI.AbsoluteSize
                local v3 = v1.AbsolutePosition + v1.AbsoluteSize * 0.5 - MonsterEventUI.AbsolutePosition
                v2.Position = UDim2.fromScale(v3.X / AbsoluteSize.X, v3.Y / AbsoluteSize.Y)
            end
            v1 = TweenService:Create(ImageLabel, u109, v2)
            v1.Completed:Once(function() -- Line: 359 -- upvalues: ImageLabel (upval)
                ImageLabel:Destroy()
            end)
            v1:Play()
        end)
    end
end

local function InitWinParts() -- Line: 365 -- upvalues: u127 (ref), CollectWinPartFades (val), u111 (val)
    local v1, v2
    local MonsterEventMap = workspace:WaitForChild("MonsterEventMap", 10)
    if MonsterEventMap == nil then
        return
    end
    local WinParts = MonsterEventMap:FindFirstChild("WinParts")
    assert(WinParts ~= nil, "MonsterEventMap is missing its WinParts model")
    for i, j in WinParts:GetChildren() do
        assert(j:IsA("BasePart"), (("Win part %* is not a BasePart"):format(j.Name)))
        v1 = j:FindFirstChildOfClass("SurfaceGui")
        v2 = ("Win part %* is missing its SurfaceGui"):format(j.Name)
        assert(v1 ~= nil, v2)
        u127[j.Name] = {Hidden = false, Part = j, Gui = v1, Fades = CollectWinPartFades(j)}
    end
    u111:Add(function() -- Line: 385 -- upvalues: u127 (upval)
        u127 = {}
    end)
end

for i, j in {"First", "Second", "Third"} do
    u124[i] = (BuildRow(j))
end
BuildRow("You")
Remotes.MonsterEvent.WinsUpdated.OnClientEvent:Connect(function(a1) -- Line: 395 -- upvalues: u121 (ref), UpdateWinsUI (ref)
    u121 = a1
    UpdateWinsUI()
end)
Remotes.MonsterEvent.PlaySFX.OnClientEvent:Connect(function(a1) -- Line: 400
    script.SFX[a1]:Play()
end)
EggState.CarryChanged:Connect(function(a1) -- Line: 404 -- upvalues: u126 (ref)
    u126 = a1.IsCarrying
end)
Remotes.MonsterEvent.WinPartsUpdated.OnClientEvent:Connect(function(a1, a2) -- Line: 406
    -- upvalues: u128 (ref), u127 (ref), SetWinPartHidden (val), u129 (ref), FlashWinClaim (val), SpawnTrophyBurst (val)
    local v1
    local v2 = nil
    local v3 = nil
    local v4 = a2
    for i, j in u127, v2, v3 do
        v1 = u129 or a1[i] == true
        SetWinPartHidden(j, v1)
    end
    if v4 ~= nil then
        FlashWinClaim()
        SpawnTrophyBurst(v4)
    end
end)
local u198 = false
;(CollectionService:GetInstanceAddedSignal("MonsterEventKillBrick")):Connect(function(a1) -- Line: 418
    -- upvalues: LocalPlayer (val), u198 (ref), MonsterEventUI (val), TweenService (val)
    a1.Touched:Connect(function(a1) -- Line: 419 -- upvalues: LocalPlayer (upval), u198 (upval), MonsterEventUI (upval), TweenService (upval)
        if a1.Parent ~= LocalPlayer.Character or u198 then
            return
        end
        script.SFX.Died:Play()
        MonsterEventUI.Cover.Position = UDim2.new(-2, 0, 0.5, 0)
        u198 = true
        TweenService:Create(MonsterEventUI.Cover, TweenInfo.new(0.2), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
        task.wait(0.6)
        TweenService:Create(MonsterEventUI.Cover, TweenInfo.new(0.2), {Position = UDim2.new(2.7, 0, 0.5, 0)}):Play()
        task.wait(0.2)
        u198 = false
    end)
end)
for k, n in CollectionService:GetTagged("MonsterEventKillBrick") do
    n.Touched:Connect(function(a1) -- Line: 419 -- upvalues: LocalPlayer (val), u198 (ref), MonsterEventUI (val), TweenService (val)
        if a1.Parent ~= LocalPlayer.Character or u198 then
            return
        end
        script.SFX.Died:Play()
        MonsterEventUI.Cover.Position = UDim2.new(-2, 0, 0.5, 0)
        u198 = true
        TweenService:Create(MonsterEventUI.Cover, TweenInfo.new(0.2), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
        task.wait(0.6)
        TweenService:Create(MonsterEventUI.Cover, TweenInfo.new(0.2), {Position = UDim2.new(2.7, 0, 0.5, 0)}):Play()
        task.wait(0.2)
        u198 = false
    end)
end
return {
    StartEvent = function(a1, a2) -- Line: 454
        -- upvalues: u111 (val), u112 (ref), MonsterEventUI (val), Workspace (val), u126 (ref), u121 (ref)
        -- upvalues: Remotes (val), UpdateWinsUI (ref), LightingController (val), InitWinParts (val), u128 (ref)
        -- upvalues: u127 (ref), SetWinPartHidden (val), u129 (ref), TweenService (val)
        local v1
        u111:Clean()
        u112 = true
        MonsterEventUI.Enabled = true
        for i, j in game.Workspace.World.Build["1"].COLLISIONS["COLL GUARD"]["WALL RIGHT (COLL GUARD)"]:GetChildren() do
            if j:IsA("BasePart") then
                j.CanCollide = false
                u111:Add(function() -- Line: 463 -- upvalues: j (val)
                    j.CanCollide = true
                end)
            end
        end
        task.spawn(function() -- Line: 470 -- upvalues: Workspace (upval), u112 (upval), u126 (upval)
            local FrozenWallRight = Workspace.World.Build["1"].COLLISIONS["GUARD NO COLLIDE"].PLAYER["WALL RIGHT"].FrozenWallRight
            while u112 do
                FrozenWallRight.CanCollide = u126
                task.wait()
            end
            FrozenWallRight.CanCollide = true
        end)
        workspace.World.Build.MainMap.Bases.SIDE_WALLS.CanCollide = false
        u111:Add(function() -- Line: 483
            workspace.World.Build.MainMap.Bases.SIDE_WALLS.CanCollide = true
        end)
        Remotes.MonsterEvent.GetWins:InvokeServer()
        UpdateWinsUI()
        LightingController.SetLayer("MonsterEvent", "MonsterEvent", 25, 2)
        InitWinParts()
        u128 = Remotes.MonsterEvent.GetWinParts:InvokeServer()
        local v2 = nil
        local v3 = nil
        for k, n in u127, v2, v3 do
            v1 = u129 or u128[k] == true
            SetWinPartHidden(n, v1)
        end
        if workspace:GetAttribute("PlayMonsterCutscene") then
            local v4
            u129 = true
            v2 = nil
            v3 = nil
            for m, i5 in u127, v2, v3 do
                v1 = u129 or u128[m] == true
                SetWinPartHidden(i5, v1)
            end
            xpcall((require(script.Cutscene)(u111)).Run, warn)
            u129 = false
            v3 = nil
            local v5 = nil
            for i6, i7 in u127, v3, v5 do
                v4 = u129 or u128[i6] == true
                SetWinPartHidden(i7, v4)
            end
        end
        local MonsterEventMap = workspace:FindFirstChild("MonsterEventMap")
        if MonsterEventMap then
            local SurfaceGui = MonsterEventMap.WallStartVisual1.SurfaceGui
            local SurfaceGui_2 = MonsterEventMap.WallStartVisual2.SurfaceGui
            SurfaceGui.Enabled = true
            SurfaceGui_2.Enabled = true
        end
        local MonsterEventMusic = workspace:FindFirstChild("MonsterEventMusic")
        if MonsterEventMusic then
            TweenService:Create(MonsterEventMusic, TweenInfo.new(5), {Volume = 0.5}):Play()
        end
    end,
    StopEvent = function(a1) -- Line: 523
        -- upvalues: u111 (val), u112 (ref), MonsterEventUI (val), u121 (ref), UpdateWinsUI (ref), u128 (ref)
        -- upvalues: u129 (ref), LightingController (val)
        u111:Clean()
        u112 = false
        MonsterEventUI.Enabled = false
        u121 = {}
        UpdateWinsUI()
        u128 = {}
        u129 = false
        LightingController.ClearLayer("MonsterEvent", 2)
    end,
}