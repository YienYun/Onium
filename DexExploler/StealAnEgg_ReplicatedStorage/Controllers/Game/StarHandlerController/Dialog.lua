-- Script path: ReplicatedStorage.Controllers.Game.StarHandlerController.Dialog
-- Decompile time: 21.54 ms

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local MenuNavigation = require(ReplicatedStorage.Client.MenuNavigation)
local MessageTyper = require(ReplicatedStorage.Client.UI.MessageTyper)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u56 = TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u61 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u66 = TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u67 = {
    Enum.KeyCode.One,
    Enum.KeyCode.Two,
    Enum.KeyCode.Three,
    Enum.KeyCode.Four,
}
local LocalPlayer = Players.LocalPlayer
local u73 = {}
u73.__index = u73

local function templates() -- Line: 59 -- upvalues: ReplicatedStorage (val)
    local Npcs = ReplicatedStorage.Assets.UI.Npcs
    return Npcs.Talk_UI, Npcs.Response_UI, Npcs.Option_UI
end

local function rootPart() -- Line: 66 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end

local function stripScripts(a1) -- Line: 72 -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("BaseScript") then
            j:Destroy()
        end
    end
end

local function popIn(a1, a2) -- Line: 80 -- upvalues: TweenService (val), u66 (val) -- types: a1: userdata
    local UIScale = a1:FindFirstChildOfClass("UIScale")
    if UIScale == nil then
        UIScale = Instance.new("UIScale")
        UIScale.Parent = a1
    end
    local v1 = UIScale
    v1.Scale = 0.6
    a2:Add((TweenService:Create(v1, u66, {Scale = 1}))):Play()
end

local function sizeFor(a1, a2) -- Line: 91 -- types: a1: userdata, a2: string
    local Size = a1.Size
    return UDim2.new(Size.X.Scale, Size.X.Offset, Size.Y.Scale * (if not (#a2 > 45) then 1 else 2), Size.Y.Offset)
end

local function keepReadable(a1, a2, a3) -- Line: 97
    -- upvalues: RunService (val), Workspace (val)
    return RunService.RenderStepped:Connect(function() -- Line: 98 -- upvalues: Workspace (upval), a1 (val), a2 (val), a3 (val)
        local CurrentCamera = Workspace.CurrentCamera
        local Adornee = a1.Adornee
        local WorldPosition = if not Adornee then if not Adornee then nil else if not Adornee:IsA("BasePart") then nil else Adornee.Position else if not Adornee:IsA("Attachment") then if not Adornee then nil else if not Adornee:IsA("BasePart") then nil else Adornee.Position else Adornee.WorldPosition
        if CurrentCamera ~= nil and WorldPosition ~= nil then
            local v1 = math.max(1, (CurrentCamera.CFrame.Position - WorldPosition).Magnitude / 17)
            local v2 = a2()
            a1.Size = UDim2.new(v2.X.Scale * v1, v2.X.Offset, v2.Y.Scale * v1, v2.Y.Offset)
            a1.StudsOffset = a3 * v1
            return
        end
    end)
end

function u73.new(a1, a2, a3) -- Line: 119
    -- upvalues: ReplicatedStorage (val), Trove (val), stripScripts (val), LocalPlayer (val), popIn (val)
    -- upvalues: MessageTyper (val), u73 (val), keepReadable (val), RunService (val), Workspace (val), Tabs (val)
    -- upvalues: UserInputService (val)
    local Npcs = ReplicatedStorage.Assets.UI.Npcs
    local Talk_UI = Npcs.Talk_UI
    local Response_UI = Npcs.Response_UI
    local Option_UI = Npcs.Option_UI
    local v1 = Trove.new()
    local PrimaryPart = a1.PrimaryPart
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    local u23 = v1:Add((Instance.new("Attachment")))
    u23.Name = "StarHandlerSpeech"
    u23.Position = PrimaryPart.CFrame:PointToObjectSpace(BoundingBox.Position + (Vector3.new(0, BoundingBox_2.Y / 2, 0)))
    u23.Parent = PrimaryPart
    local v2 = v1:Add((Talk_UI:Clone()))
    v2.Name = "StarHandlerSpeech"
    v2.Adornee = u23
    v2.MaxDistance = (1 / 0)
    stripScripts(v2)
    local v3 = v2:FindFirstChildOfClass("TextLabel")
    v3.Text = ""
    v2.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    popIn(v2, v1)
    local u71 = MessageTyper.new(v3, nil, 0.035, true)
    v1:Add(function() -- Line: 140 -- upvalues: u71 (val)
        u71:Halt()
    end)
    local v4 = {
        Closed = false,
        _skip = false,
        _npc = a1,
        _prompt = a2,
        _anchor = u23,
        _bubble = v2,
        _label = v3,
        _typer = u71,
        _trove = v1,
        _rows = {},
        _size = Talk_UI.Size,
        _onClose = a3,
    }
    local u81 = setmetatable(v4, u73)
    local v5 = keepReadable
    local StudsOffset = Talk_UI.StudsOffset
    v5 = v5(v2, function() -- Line: 159 -- upvalues: u81 (val)
        return u81._size
    end, StudsOffset)
    v1:Add(v5)
    a2.Enabled = false
    v1:Add(function() -- Line: 164 -- upvalues: a2 (val)
        a2.Enabled = true
    end)
    v1:Connect(RunService.Heartbeat, function() -- Line: 168 -- upvalues: LocalPlayer (upval), a1 (val), Workspace (upval), u23 (val), a2 (val), u81 (val)
        local Character = LocalPlayer.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local Character_2 = LocalPlayer.Character
        local HumanoidRootPart = Character_2 and Character_2:FindFirstChild("HumanoidRootPart")
        local v1 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
        if v1 == nil or Humanoid == nil or Humanoid.Health <= 0 or not a1:IsDescendantOf(Workspace) then
            u81:Close()
        else
            local Magnitude = (v1.Position - u23.WorldPosition).Magnitude
            if a2.MaxActivationDistance + 8 < Magnitude then
                u81:Close()
            end
        end
    end)
    v1:Connect(Tabs.Activated, function(a1) -- Line: 183 -- upvalues: u81 (val) -- types: a1: string
        if a1 ~= "StarBundles" then
            u81:Close()
        end
    end)
    v1:Connect(UserInputService.InputBegan, function(a1, a2) -- Line: 188 -- upvalues: u81 (val) -- types: a1: userdata, a2: boolean
        if a2 then
            return
        end
        local UserInputType = a1.UserInputType
        if UserInputType == Enum.UserInputType.MouseButton1
            or UserInputType == Enum.UserInputType.Touch
            or a1.KeyCode == Enum.KeyCode.Space
            or a1.KeyCode == Enum.KeyCode.ButtonA then
            u81._skip = true
        end
    end)
    return u81
end

function u73.Say(a1, a2) -- Line: 205 -- upvalues: ReplicatedStorage (val) -- types: a2: table
    local Npcs, Option_UI, Response_UI, Size, Talk_UI, TextColor3, TextColor3_2, _typer, _typer_2, v1, v2
    local v3 = nil
    local v4 = nil
    local v5 = a1
    for i, j in a2, v3, v4 do
        if v5.Closed then
            return false
        end
        Npcs = ReplicatedStorage.Assets.UI.Npcs
        Talk_UI = Npcs.Talk_UI
        Response_UI = Npcs.Response_UI
        Option_UI = Npcs.Option_UI
        Size = Talk_UI.Size
        v5._size = UDim2.new(Size.X.Scale, Size.X.Offset, Size.Y.Scale * (if not (#j > 45) then 1 else 2), Size.Y.Offset)
        v5._skip = false
        _typer = v5._typer
        TextColor3 = v5._label.TextColor3
        _typer:Type(j, TextColor3)
        v1 = utf8.len(j) or #j
        v2 = os.clock() + v1 * 0.035
        while os.clock() < v2 do
            if v5._skip or v5.Closed then
                break
            end
            task.wait()
        end
        if v5._skip then
            _typer_2 = v5._typer
            TextColor3_2 = v5._label.TextColor3
            _typer_2:ShowAll(j, TextColor3_2)
            v5._skip = false
        end
        v2 = (os.clock()) + math.max(1.15, #j * 0.022)
        while os.clock() < v2 do
            if v5._skip or v5.Closed then
                break
            end
            task.wait()
        end
    end
    return not v5.Closed
end

function u73:Echo(a2) -- Line: 230
    -- upvalues: ReplicatedStorage (val), LocalPlayer (val), stripScripts (val), RunService (val), Workspace (val)
    -- upvalues: popIn (val), TweenService (val), u61 (val)
    if self.Closed then
        return
    end
    local Npcs = ReplicatedStorage.Assets.UI.Npcs
    local Talk_UI = Npcs.Talk_UI
    local Response_UI = Npcs.Response_UI
    local Option_UI = Npcs.Option_UI
    local Character = LocalPlayer.Character
    local Head = Character and Character:FindFirstChild("Head")
    if Head == nil then
        return
    end
    local u22 = Response_UI:Clone()
    stripScripts(u22)
    u22.Adornee = Head
    u22.MaxDistance = (1 / 0)
    local Size = u22.Size

    local function u28() -- Line: 245 -- upvalues: Size (val)
        return Size
    end

    local StudsOffset = u22.StudsOffset
    local u36 = RunService.RenderStepped:Connect(function() -- Line: 98 -- upvalues: Workspace (upval), u22 (val), u28 (val), StudsOffset (val)
        local CurrentCamera = Workspace.CurrentCamera
        local Adornee = u22.Adornee
        local WorldPosition = if not Adornee then if not Adornee then nil else if not Adornee:IsA("BasePart") then nil else Adornee.Position else if not Adornee:IsA("Attachment") then if not Adornee then nil else if not Adornee:IsA("BasePart") then nil else Adornee.Position else Adornee.WorldPosition
        if CurrentCamera ~= nil and WorldPosition ~= nil then
            local v1 = math.max(1, (CurrentCamera.CFrame.Position - WorldPosition).Magnitude / 17)
            local v2 = u28()
            u22.Size = UDim2.new(v2.X.Scale * v1, v2.X.Offset, v2.Y.Scale * v1, v2.Y.Offset)
            u22.StudsOffset = StudsOffset * v1
            return
        end
    end)
    u22.Destroying:Once(function() -- Line: 248 -- upvalues: u36 (val)
        u36:Disconnect()
    end)
    u22.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local TextLabel = u22:FindFirstChildOfClass("TextLabel")
    if TextLabel then
        TextLabel.Text = a2
        TextLabel.MaxVisibleGraphemes = -1
    end
    popIn(u22, self._trove)
    self._trove:Add(u22)
    task.delay(1.4, function() -- Line: 259 -- upvalues: u22 (val), TweenService (upval), u61 (upval)
        if u22.Parent == nil then
            return
        end
        for i, j in u22:GetDescendants() do
            if j:IsA("TextLabel") then
                TweenService:Create(j, u61, {TextTransparency = 1}):Play()
            elseif j:IsA("ImageLabel") then
                TweenService:Create(j, u61, {ImageTransparency = 1}):Play()
            end
        end
        task.delay(u61.Time, function() -- Line: 270 -- upvalues: u22 (upval)
            u22:Destroy()
        end)
    end)
end

function u73:_clearChoices() -- Line: 276
    for i, j in self._rows do
        j:Destroy()
    end
    table.clear(self._rows)
end

function u73.Ask(a1, a2) -- Line: 283
    -- upvalues: ReplicatedStorage (val), LocalPlayer (val), keepReadable (val), HttpService (val), MenuNavigation (val)
    -- upvalues: stripScripts (val), TweenService (val), u61 (val), u56 (val), UserInputService (val), u67 (val)
    if a1.Closed then
        return nil
    end
    local Npcs = ReplicatedStorage.Assets.UI.Npcs
    local Talk_UI = Npcs.Talk_UI
    local Response_UI = Npcs.Response_UI
    local Option_UI = Npcs.Option_UI
    local v1 = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local v2 = v1 and v1:FindFirstChild("Billboard_UI")
    if v2 ~= nil and v2:IsA("BillboardGui") then
        local Frame, Frame_2, ImageButton, TextLabel, Text_Element, UIScale, v3, v4
        local v5 = a1._trove:Extend()
        local v6 = v5:Add((v2:Clone()))
        for i, j in v6:GetChildren() do
            if not j:IsA("UIListLayout") then
                j:Destroy()
            end
        end
        v6.Name = "StarHandlerChoices"
        v6.Active = true
        v6.Enabled = true
        v2 = Instance.new("Frame")
        v2.Name = "Choices"
        v2.BackgroundTransparency = 1
        v2.Size = UDim2.fromScale(1, 1)
        v2.Parent = v6
        local UIListLayout = v6:FindFirstChildOfClass("UIListLayout")
        if UIListLayout then
            UIListLayout.Parent = v2
        end
        v6.Parent = v1
        if v6:IsA("BillboardGui") then
            local Size = v6.Size
            local StudsOffset = v6.StudsOffset
            v6.MaxDistance = (1 / 0)
            v5:Add((keepReadable(v6, function() -- Line: 313 -- upvalues: Size (val)
                return Size
            end, StudsOffset)))
        end
        local u344 = nil
        local u346 = 0
        local v7 = a1._trove:Extend()
        v6 = {}
        local u523 = "StarHandlerChoices:" .. HttpService:GenerateGUID(false)

        local function releaseNavigation() -- Line: 322 -- upvalues: MenuNavigation (upval), u523 (val)
            MenuNavigation.SetOverride(u523, nil)
        end

        v7:Add(releaseNavigation)
        a1._releaseChoices = releaseNavigation

        local function pick(a1_2) -- Line: 328
            -- upvalues: u344 (ref), a1 (val), a2 (val), u346 (ref)
            if u344 == nil and not a1.Closed then
                local v1 = a2[a1_2]
                if v1 == nil then
                    return
                end
                u344 = v1.Key
                u346 = a1_2
                return
            end
        end

        local v8 = nil
        local v9 = nil
        for k, n in a2, v8, v9 do
            if a1.Closed then
                break
            end
            local u131 = Option_UI:Clone()
            stripScripts(u131)
            u131.Name = ("StarHandlerChoice%*"):format(k)
            u131.LayoutOrder = k
            Frame = u131:FindFirstChild("Frame")
            Frame_2 = Frame and Frame:FindFirstChild("Frame")
            Text_Element = Frame_2 and Frame_2:FindFirstChild("Text_Element")
            TextLabel = Frame_2 and Frame_2:FindFirstChild("TextLabel")
            if Text_Element then
                Text_Element.Text = n.Text
                Text_Element:SetAttribute("Text", n.Text)
            end
            if TextLabel then
                TextLabel.Text = ("%*."):format(k)
            end
            ImageButton = Frame and Frame:FindFirstChild("ImageButton")
            if ImageButton then
                ImageButton.ZIndex = 10
                ImageButton.Active = true
                ImageButton.Interactable = true
                ImageButton.Selectable = true
                ImageButton.LayoutOrder = k
                ImageButton:SetAttribute("DefaultFocus", k == 1)
                table.insert(v6, ImageButton)
                v7:Connect(ImageButton.Activated, function() -- Line: 366 -- upvalues: k (val), u344 (ref), a1 (val), a2 (val), u346 (ref)
                    local v1 = k
                    if u344 == nil then
                        if a1.Closed then
                            return
                        end
                        local v2 = a2[v1]
                        if v2 == nil then
                            return
                        end
                        u344 = v2.Key
                        u346 = v1
                    end
                end)
                v7:Connect(ImageButton.MouseEnter, function() -- Line: 369 -- upvalues: TweenService (upval), u131 (val), u61 (upval), Option_UI (val)
                    TweenService:Create(u131, u61, {Size = Option_UI.Size + UDim2.fromScale(0.04, 0.01)}):Play()
                end)
                v7:Connect(ImageButton.MouseLeave, function() -- Line: 374 -- upvalues: TweenService (upval), u131 (val), u61 (upval), Option_UI (val)
                    TweenService:Create(u131, u61, {Size = Option_UI.Size}):Play()
                end)
            end
            UIScale = u131:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
            UIScale.Scale = 0
            UIScale.Parent = u131
            u131.Parent = v2
            table.insert(a1._rows, u131)
            TweenService:Create(UIScale, u56, {Scale = 1}):Play()
            task.wait(0.07)
        end
        for m, i5 in v6 do
            v4 = m - 1
            i5.NextSelectionUp = v6[math.max(1, v4)]
            v3 = #v6
            v4 = m + 1
            i5.NextSelectionDown = v6[math.min(v3, v4)]
            i5.NextSelectionLeft = i5
            i5.NextSelectionRight = i5
        end
        if not a1.Closed then
            MenuNavigation.SetOverride(u523, v2, v6[1], function() -- Line: 394 -- upvalues: a1 (val)
                a1:Close()
            end, 950, true, true)
        end
        v7:Connect(UserInputService.InputBegan, function(a1_2, a2_2) -- Line: 399
            -- upvalues: u67 (upval), u344 (ref), a1 (val), a2 (val), u346 (ref)
            if a2_2 then
                return
            end
            local v1 = table.find(u67, a1_2.KeyCode)
            if v1 and u344 == nil then
                if a1.Closed then
                    return
                end
                local v2 = a2[v1]
                if v2 == nil then
                    return
                end
                u344 = v2.Key
                u346 = v1
            end
        end)
        while u344 == nil do
            if a1.Closed then
                break
            end
            task.wait()
        end
        v7:Destroy()
        a1._releaseChoices = nil
        v8 = nil
        v9 = nil
        for i6, i7 in a1._rows, v8, v9 do
            v7 = i7:FindFirstChildOfClass("UIScale")
            if v7 then
                v4 = u61
                TweenService:Create(v7, v4, {Scale = if i6 ~= u346 then 0 else 1.08}):Play()
            end
        end
        task.wait(u61.Time)
        a1:_clearChoices()
        v5:Destroy()
        v6 = a2[u346]
        if v6 and v6.Echo then
            a1:Echo(v6.Echo)
            task.wait(0.35)
        end
        return u344
    end
    return nil
end

function u73:Close() -- Line: 433 -- upvalues: TweenService (val), u61 (val)
    if self.Closed then
        return
    end
    self.Closed = true
    if self._releaseChoices then
        self._releaseChoices()
    end
    self:_clearChoices()
    for i, j in self._bubble:GetDescendants() do
        if j:IsA("TextLabel") then
            TweenService:Create(j, u61, {TextTransparency = 1}):Play()
        elseif j:IsA("ImageLabel") then
            TweenService:Create(j, u61, {ImageTransparency = 1}):Play()
        end
    end
    local _trove = self._trove
    task.delay(u61.Time, function() -- Line: 449 -- upvalues: _trove (val)
        _trove:Destroy()
    end)
    if self._onClose then
        task.spawn(self._onClose)
    end
end

return u73