-- Script path: ReplicatedStorage.Controllers.Game.TrainEventController
-- Decompile time: 59.85 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local TrainEvent = require(ReplicatedStorage.Shared.Remotes).TrainEvent
local TrainGhostVisuals = require(script.Parent.TrainGhostVisuals)
local TrainReturnPrompt = require(ReplicatedStorage.Shared.Modules.TrainReturnPrompt)
local TrainTravelTransition = require(script.Parent.TrainTravelTransition)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local TrainEventPresentation = require(script.Parent.TrainEventPresentation)
local TicketFlight = require(script.TicketFlight)
local GhostBoss = require(ReplicatedStorage.Shared.Util.GhostBoss)
local GhostBossFlags = require(ReplicatedStorage.Shared.Flags.GhostBossFlags)
local TrainEventFlags = require(ReplicatedStorage.Shared.Flags.TrainEventFlags)
local TrainCaptureRules = require(ReplicatedStorage.Shared.Modules.TrainCaptureRules)
local v1 = {}
local u85 = false
local u90 = Color3.fromRGB(150, 255, 120)
local u95 = Color3.fromRGB(20, 70, 10)

function v1.Start() -- Line: 26
    -- upvalues: u85 (ref), Players (val), TrainGhostVisuals (val), TrainTravelTransition (val)
    -- upvalues: TrainEventPresentation (val), TicketFlight (val), u90 (val), TrainEvent (val), Workspace (val)
    -- upvalues: TrainEventFlags (val), TrainCaptureRules (val), Toast (val), u95 (val), UserInputService (val)
    -- upvalues: ContextActionService (val), TrainReturnPrompt (val), GhostBoss (val), ReplicatedStorage (val)
    -- upvalues: GhostBossFlags (val), RunService (val)
    if u85 then
        return
    end
    u85 = true
    local LocalPlayer = Players.LocalPlayer
    require(script.Parent.TrainServerTravel).Start()
    TrainGhostVisuals.Start()
    TrainTravelTransition.Start()
    TrainEventPresentation.Start()
    TicketFlight.Start()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TrainEventJourney"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 40
    local Frame = Instance.new("Frame")
    Frame.AnchorPoint = Vector2.new(0.5, 0)
    Frame.Position = UDim2.new(0.5, 0, 0, 12)
    Frame.Size = UDim2.new(0.85, 0, 0, 160)
    Frame.BackgroundColor3 = Color3.fromRGB(29, 24, 43)
    Frame.BackgroundTransparency = 0.08
    Frame.Parent = ScreenGui
    local UISizeConstraint = Instance.new("UISizeConstraint")
    UISizeConstraint.MaxSize = Vector2.new(430, 310)
    UISizeConstraint.Parent = Frame
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Frame

    local function label(a1, a2, a3) -- Line: 36 -- upvalues: Frame (val)
        local TextLabel = Instance.new("TextLabel")
        TextLabel.BackgroundTransparency = 1
        TextLabel.Position = UDim2.new(0, 12, 0, a1)
        TextLabel.Size = UDim2.new(1, -24, 0, a2)
        TextLabel.TextColor3 = Color3.fromRGB(233, 215, 255)
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.TextSize = a3
        TextLabel.TextWrapped = true
        TextLabel.Parent = Frame
        return TextLabel
    end

    local u73 = label(8, 28, 20)
    local u78 = label(38, 25, 16)
    local u83 = label(66, 44, 13)
    u83.TextColor3 = u90
    local u89 = label(112, 38, 14)
    u89.Size = UDim2.new(1, -24, 0, 38)
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "VacuumCaptureHUD"
    Frame_2.BackgroundTransparency = 1
    Frame_2.AnchorPoint = Vector2.new(0, 0.5)
    Frame_2.Position = UDim2.new(0.5, 90, 0.5, 0)
    Frame_2.Size = UDim2.fromOffset(120, 160)
    Frame_2.Visible = false
    Frame_2.Parent = ScreenGui
    local u120 = label(152, 40, 14)
    u120.Name = "CaptureTarget"
    u120.Parent = Frame_2
    u120.AnchorPoint = Vector2.new(0.5, 1)
    u120.Position = UDim2.fromOffset(10, -8)
    u120.Size = UDim2.fromOffset(150, 32)
    u120.TextStrokeTransparency = 0.25
    u120.TextStrokeColor3 = Color3.new(0, 0, 0)
    local u143 = Instance.new("Frame")
    u143.Name = "GhostCaptureProgress"
    u143.Position = UDim2.fromOffset(0, 0)
    u143.Size = UDim2.fromOffset(20, 128)
    u143.BackgroundColor3 = Color3.fromRGB(64, 54, 83)
    u143.Parent = Frame_2
    local Frame_3 = Instance.new("Frame")
    Frame_3.Name = "Fill"
    Frame_3.AnchorPoint = Vector2.new(0, 1)
    Frame_3.Position = UDim2.fromScale(0, 1)
    Frame_3.Size = UDim2.fromScale(1, 0)
    Frame_3.BackgroundColor3 = Color3.fromRGB(182, 114, 255)
    Frame_3.BorderSizePixel = 0
    Frame_3.Parent = u143
    Frame_3.BackgroundColor3 = u90
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "Percent"
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.fromOffset(-20, 132)
    TextLabel.Size = UDim2.fromOffset(60, 24)
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.TextSize = 16
    TextLabel.TextColor3 = u90
    TextLabel.TextStrokeTransparency = 0.2
    TextLabel.Parent = Frame_2
    local u198 = {Phase = "Home", ArrivalOpen = false, DepartureAt = 0, ReturnAt = 0}
    local u199 = nil
    local u200 = 0
    local u201 = false
    local u202 = false
    local u203 = nil
    local u204 = {}
    local u205 = 0
    local u206 = 0
    local u207 = nil
    local u208 = false
    local u209 = false
    local u210 = (-1 / 0)
    local u212 = RaycastParams.new()
    u212.FilterType = Enum.RaycastFilterType.Exclude
    u212.RespectCanCollide = true

    local function canVacuum() -- Line: 58 -- upvalues: u198 (ref), u203 (ref), LocalPlayer (val), u199 (ref)
        local v1 = false
        if u198.Phase == "Town" then
            v1 = false
            if u203 ~= nil then
                v1 = false
                if u203.Parent == LocalPlayer.Character then
                    v1 = false
                    if u199 ~= nil then
                        v1 = u199.Phase == "Active"
                    end
                end
            end
        end
        return v1
    end

    local function refreshHolding() -- Line: 61
        -- upvalues: u208 (ref), u209 (ref), u198 (ref), u203 (ref), LocalPlayer (val), u199 (ref), u202 (ref)
        -- upvalues: TrainGhostVisuals (upval), TrainEvent (upval)
        local v1
        if u208 then
            v1 = false
            if u198.Phase == "Town" then
                v1 = false
                if u203 ~= nil then
                    v1 = false
                    if u203.Parent == LocalPlayer.Character then
                        v1 = false
                        if u199 ~= nil then
                            v1 = u199.Phase == "Active"
                        end
                    end
                end
            end
        else
            v1 = u209
            if v1 then
                v1 = false
                if u198.Phase == "Town" then
                    v1 = false
                    if u203 ~= nil then
                        v1 = false
                        if u203.Parent == LocalPlayer.Character then
                            v1 = false
                            if u199 ~= nil then
                                v1 = u199.Phase == "Active"
                            end
                        end
                    end
                end
            end
        end
        if not v1 then
            u208 = false
        end
        if u202 == v1 then
            return
        end
        u202 = v1
        TrainGhostVisuals.SetInput(v1)
        TrainEvent.Suction:FireServer(v1)
    end

    local function setHolding(a1) -- Line: 68
        -- upvalues: u208 (ref), u209 (ref), u198 (ref), u203 (ref), LocalPlayer (val), u199 (ref), u202 (ref)
        -- upvalues: TrainGhostVisuals (upval), TrainEvent (upval)
        local v1
        u208 = a1 == true
        if u208 then
            v1 = false
            if u198.Phase == "Town" then
                v1 = false
                if u203 ~= nil then
                    v1 = false
                    if u203.Parent == LocalPlayer.Character then
                        v1 = false
                        if u199 ~= nil then
                            v1 = u199.Phase == "Active"
                        end
                    end
                end
            end
        else
            v1 = u209
            if v1 then
                v1 = false
                if u198.Phase == "Town" then
                    v1 = false
                    if u203 ~= nil then
                        v1 = false
                        if u203.Parent == LocalPlayer.Character then
                            v1 = false
                            if u199 ~= nil then
                                v1 = u199.Phase == "Active"
                            end
                        end
                    end
                end
            end
        end
        if not v1 then
            u208 = false
        end
        if u202 == v1 then
            return
        end
        u202 = v1
        TrainGhostVisuals.SetInput(v1)
        TrainEvent.Suction:FireServer(v1)
    end

    local function ghostInReach(a1) -- Line: 72
        -- upvalues: Workspace (upval), Players (upval), u212 (val), TrainEventFlags (upval), u202 (ref), u199 (ref)
        -- upvalues: LocalPlayer (val), TrainCaptureRules (upval)
        local Position_2
        local TrainGhostVisuals = Workspace:FindFirstChild("TrainGhostVisuals")
        if not TrainGhostVisuals then
            return false
        end
        local v1 = {TrainGhostVisuals}
        for i, j in Players:GetPlayers() do
            if j.Character then
                table.insert(v1, j.Character)
            end
        end
        u212.FilterDescendantsInstances = v1
        local Position = a1.Position
        local LookVector = a1.CFrame.LookVector
        local v2 = TrainEventFlags.VacuumReachStuds:Get()
        local v3 = TrainEventFlags.VacuumConeDegrees:Get()
        local v4 = TrainEventFlags.VacuumCloseRangeStuds:Get()
        local v5 = TrainEventFlags.VacuumVerticalToleranceStuds:Get()
        local TargetId = u202 and u199 and u199.TargetId
        local v6 = false
        if typeof(TargetId) == "string" then
            v6 = TrainGhostVisuals:FindFirstChild(TargetId)
        end
        if v6 and v6:IsA("Model") and (v6:GetPivot().Position - Position).Magnitude <= v2 * 1.15 then
            return true
        end
        for k, n in TrainGhostVisuals:GetChildren() do
            if n:IsA("Model")
                and n:GetAttribute("TrainGhost") == true
                and (n:GetAttribute("OwnerUserId")) == LocalPlayer.UserId then
                Position_2 = n:GetPivot().Position
                if TrainCaptureRules.InCaptureCone(Position, LookVector, Position_2, v2, v3, v4, v5)
                    and Workspace:Raycast(Position, Position_2 - Position, u212) == nil then
                    return true
                end
            end
        end
        return false
    end

    local function apply(a1) -- Line: 92
        -- upvalues: u198 (ref), u199 (ref), TrainEventPresentation (upval), u208 (ref), u209 (ref), u203 (ref)
        -- upvalues: LocalPlayer (val), u202 (ref), TrainGhostVisuals (upval), TrainEvent (upval), u83 (val), u200 (ref)
        -- upvalues: Toast (upval), u90 (upval), u95 (upval)
        local v1
        if typeof(a1) ~= "table" then
            return
        end
        u198 = a1
        u199 = a1.Invasion
        TrainEventPresentation.Update(a1)
        if u198.Phase ~= "Town" or u199 and u199.Phase ~= "Active" then
            u208 = false
            if u208 then
                v1 = false
                if u198.Phase == "Town" then
                    v1 = false
                    if u203 ~= nil then
                        v1 = false
                        if u203.Parent == LocalPlayer.Character then
                            v1 = false
                            if u199 ~= nil then
                                v1 = u199.Phase == "Active"
                            end
                        end
                    end
                end
            else
                v1 = u209
                if v1 then
                    v1 = false
                    if u198.Phase == "Town" then
                        v1 = false
                        if u203 ~= nil then
                            v1 = false
                            if u203.Parent == LocalPlayer.Character then
                                v1 = false
                                if u199 ~= nil then
                                    v1 = u199.Phase == "Active"
                                end
                            end
                        end
                    end
                end
            end
            if not v1 then
                u208 = false
            end
            if u202 ~= v1 then
                u202 = v1
                TrainGhostVisuals.SetInput(v1)
                TrainEvent.Suction:FireServer(v1)
            end
        end
        if typeof(a1.Message) == "string" then
            local v2
            v1 = string.sub(a1.Message, 1, 20) == "The train is leaving"
            local Character = LocalPlayer.Character
            if v1 then
                if Character and Character:GetAttribute("TrainEventInForgottenTown") == true then
                    u83.Text = a1.Message
                    u200 = os.clock() + 5
                    v2 = true
                    if a1.Message ~= "You need a Train Pass." then
                        v2 = true
                        if a1.Message ~= "Hold your pass in your hand!" then
                            v2 = a1.Message == "You need a Train Pass to board the train!"
                        end
                    end
                    if v2
                        or string.sub(a1.Message, 1, 8) == "Captured"
                        or string.sub(a1.Message, 1, 17) == "Vacuum collected!"
                        or v1 then
                        Toast.Show({
                            Lane = "Feed",
                            Seconds = 3,
                            Text = a1.Message,
                            Color = if not v2 then u90 else Color3.fromRGB(255, 100, 100),
                            StrokeColor = if not v2 then u95 else Color3.fromRGB(80, 15, 15),
                        })
                    end
                    return
                end
                return
            end
            u83.Text = a1.Message
            u200 = os.clock() + 5
            v2 = true
            if a1.Message ~= "You need a Train Pass." then
                v2 = true
                if a1.Message ~= "Hold your pass in your hand!" then
                    v2 = a1.Message == "You need a Train Pass to board the train!"
                end
            end
            if v2
                or string.sub(a1.Message, 1, 8) == "Captured"
                or string.sub(a1.Message, 1, 17) == "Vacuum collected!"
                or v1 then
                Toast.Show({
                    Lane = "Feed",
                    Seconds = 3,
                    Text = a1.Message,
                    Color = if not v2 then u90 else Color3.fromRGB(255, 100, 100),
                    StrokeColor = if not v2 then u95 else Color3.fromRGB(80, 15, 15),
                })
            end
        end
    end

    local u220 = {}
    ;(function(a1, a2, a3, a4) -- Line: 107
        -- upvalues: Frame (val), u220 (val), u201 (ref), u208 (ref), u209 (ref), u198 (ref), u203 (ref)
        -- upvalues: LocalPlayer (val), u199 (ref), u202 (ref), TrainGhostVisuals (upval), TrainEvent (upval), u83 (val)
        -- upvalues: u200 (ref)
        local TextButton = Instance.new("TextButton")
        TextButton.Name = a1
        TextButton.Position = UDim2.new(a3, 4, 0, 116)
        TextButton.Size = UDim2.new(a4, -8, 0, 36)
        TextButton.BackgroundColor3 = Color3.fromRGB(115, 68, 174)
        TextButton.TextColor3 = Color3.new(1, 1, 1)
        TextButton.Font = Enum.Font.GothamBold
        TextButton.TextSize = 14
        TextButton.Text = a2
        TextButton.Parent = Frame
        u220[a1] = TextButton
        TextButton.Activated:Connect(function() -- Line: 110
            -- upvalues: u201 (upval), a1 (val), u208 (upval), u209 (upval), u198 (upval), u203 (upval)
            -- upvalues: LocalPlayer (upval), u199 (upval), u202 (upval), TrainGhostVisuals (upval), TrainEvent (upval)
            -- upvalues: u83 (upval), u200 (upval)
            local success, v1
            if u201 then
                return
            end
            u201 = true
            if a1 == "Return" then
                local v2
                u208 = false
                if u208 then
                    v2 = false
                    if u198.Phase == "Town" then
                        v2 = false
                        if u203 ~= nil then
                            v2 = false
                            if u203.Parent == LocalPlayer.Character then
                                v2 = false
                                if u199 ~= nil then
                                    v2 = u199.Phase == "Active"
                                end
                            end
                        end
                    end
                else
                    v2 = u209
                    if v2 then
                        v2 = false
                        if u198.Phase == "Town" then
                            v2 = false
                            if u203 ~= nil then
                                v2 = false
                                if u203.Parent == LocalPlayer.Character then
                                    v2 = false
                                    if u199 ~= nil then
                                        v2 = u199.Phase == "Active"
                                    end
                                end
                            end
                        end
                    end
                end
                if not v2 then
                    u208 = false
                end
                if u202 ~= v2 then
                    u202 = v2
                    TrainGhostVisuals.SetInput(v2)
                    TrainEvent.Suction:FireServer(v2)
                end
            end
            success, _, v1 = pcall(function() -- Line: 113 -- upvalues: TrainEvent (upval), a1 (upval)
                local v1 = a1
                return TrainEvent.Action:InvokeServer(v1)
            end)
            u201 = false
            if typeof(v1) == "string" then
                u83.Text = v1
                u200 = os.clock() + 5
                return
            end
            if not success then
                u83.Text = "Please try again."
                u200 = os.clock() + 5
            end
        end)
        return TextButton
    end)(
        "Station",
        "Go to Station",
        0,
        1
    )
    UserInputService.WindowFocusReleased:Connect(function() -- Line: 120
        -- upvalues: u208 (ref), u209 (ref), u198 (ref), u203 (ref), LocalPlayer (val), u199 (ref), u202 (ref)
        -- upvalues: TrainGhostVisuals (upval), TrainEvent (upval)
        local v1
        u208 = false
        if u208 then
            v1 = false
            if u198.Phase == "Town" then
                v1 = false
                if u203 ~= nil then
                    v1 = false
                    if u203.Parent == LocalPlayer.Character then
                        v1 = false
                        if u199 ~= nil then
                            v1 = u199.Phase == "Active"
                        end
                    end
                end
            end
        else
            v1 = u209
            if v1 then
                v1 = false
                if u198.Phase == "Town" then
                    v1 = false
                    if u203 ~= nil then
                        v1 = false
                        if u203.Parent == LocalPlayer.Character then
                            v1 = false
                            if u199 ~= nil then
                                v1 = u199.Phase == "Active"
                            end
                        end
                    end
                end
            end
        end
        if not v1 then
            u208 = false
        end
        if u202 == v1 then
            return
        end
        u202 = v1
        TrainGhostVisuals.SetInput(v1)
        TrainEvent.Suction:FireServer(v1)
    end)

    local function bind(a1) -- Line: 121
        -- upvalues: u204 (val), LocalPlayer (val), u203 (ref), u208 (ref), u209 (ref), u198 (ref), u199 (ref)
        -- upvalues: u202 (ref), TrainGhostVisuals (upval), TrainEvent (upval)
        if a1:IsA("Tool") and a1:GetAttribute("GhostVacuum") == true and not u204[a1] then
            local u11 = {}
            u204[a1] = u11
            table.insert(u11, (a1.Equipped:Connect(function() -- Line: 125
                -- upvalues: a1 (val), LocalPlayer (upval), u203 (upval), u208 (upval), u209 (upval), u198 (upval)
                -- upvalues: u199 (upval), u202 (upval), TrainGhostVisuals (upval), TrainEvent (upval)
                if a1.Parent == LocalPlayer.Character then
                    u203 = a1
                    return
                end
                if u203 == a1 then
                    local v1
                    u208 = false
                    if u208 then
                        v1 = false
                        if u198.Phase == "Town" then
                            v1 = false
                            if u203 ~= nil then
                                v1 = false
                                if u203.Parent == LocalPlayer.Character then
                                    v1 = false
                                    if u199 ~= nil then
                                        v1 = u199.Phase == "Active"
                                    end
                                end
                            end
                        end
                    else
                        v1 = u209
                        if v1 then
                            v1 = false
                            if u198.Phase == "Town" then
                                v1 = false
                                if u203 ~= nil then
                                    v1 = false
                                    if u203.Parent == LocalPlayer.Character then
                                        v1 = false
                                        if u199 ~= nil then
                                            v1 = u199.Phase == "Active"
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if not v1 then
                        u208 = false
                    end
                    if u202 ~= v1 then
                        u202 = v1
                        TrainGhostVisuals.SetInput(v1)
                        TrainEvent.Suction:FireServer(v1)
                    end
                    u203 = nil
                end
            end)))
            table.insert(u11, (a1.Unequipped:Connect(function() -- Line: 130
                -- upvalues: u203 (upval), a1 (val), u208 (upval), u209 (upval), u198 (upval), LocalPlayer (upval)
                -- upvalues: u199 (upval), u202 (upval), TrainGhostVisuals (upval), TrainEvent (upval)
                if u203 == a1 then
                    local v1
                    u208 = false
                    if u208 then
                        v1 = false
                        if u198.Phase == "Town" then
                            v1 = false
                            if u203 ~= nil then
                                v1 = false
                                if u203.Parent == LocalPlayer.Character then
                                    v1 = false
                                    if u199 ~= nil then
                                        v1 = u199.Phase == "Active"
                                    end
                                end
                            end
                        end
                    else
                        v1 = u209
                        if v1 then
                            v1 = false
                            if u198.Phase == "Town" then
                                v1 = false
                                if u203 ~= nil then
                                    v1 = false
                                    if u203.Parent == LocalPlayer.Character then
                                        v1 = false
                                        if u199 ~= nil then
                                            v1 = u199.Phase == "Active"
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if not v1 then
                        u208 = false
                    end
                    if u202 ~= v1 then
                        u202 = v1
                        TrainGhostVisuals.SetInput(v1)
                        TrainEvent.Suction:FireServer(v1)
                    end
                    u203 = nil
                end
            end)))
            table.insert(u11, (a1.Activated:Connect(function() -- Line: 131
                -- upvalues: u203 (upval), a1 (val), u208 (upval), u209 (upval), u198 (upval), LocalPlayer (upval)
                -- upvalues: u199 (upval), u202 (upval), TrainGhostVisuals (upval), TrainEvent (upval)
                local v1
                u203 = a1
                u208 = true
                if u208 then
                    v1 = false
                    if u198.Phase == "Town" then
                        v1 = false
                        if u203 ~= nil then
                            v1 = false
                            if u203.Parent == LocalPlayer.Character then
                                v1 = false
                                if u199 ~= nil then
                                    v1 = u199.Phase == "Active"
                                end
                            end
                        end
                    end
                else
                    v1 = u209
                    if v1 then
                        v1 = false
                        if u198.Phase == "Town" then
                            v1 = false
                            if u203 ~= nil then
                                v1 = false
                                if u203.Parent == LocalPlayer.Character then
                                    v1 = false
                                    if u199 ~= nil then
                                        v1 = u199.Phase == "Active"
                                    end
                                end
                            end
                        end
                    end
                end
                if not v1 then
                    u208 = false
                end
                if u202 == v1 then
                    return
                end
                u202 = v1
                TrainGhostVisuals.SetInput(v1)
                TrainEvent.Suction:FireServer(v1)
            end)))
            table.insert(u11, (a1.Deactivated:Connect(function() -- Line: 132
                -- upvalues: u208 (upval), u209 (upval), u198 (upval), u203 (upval), LocalPlayer (upval), u199 (upval)
                -- upvalues: u202 (upval), TrainGhostVisuals (upval), TrainEvent (upval)
                local v1
                u208 = false
                if u208 then
                    v1 = false
                    if u198.Phase == "Town" then
                        v1 = false
                        if u203 ~= nil then
                            v1 = false
                            if u203.Parent == LocalPlayer.Character then
                                v1 = false
                                if u199 ~= nil then
                                    v1 = u199.Phase == "Active"
                                end
                            end
                        end
                    end
                else
                    v1 = u209
                    if v1 then
                        v1 = false
                        if u198.Phase == "Town" then
                            v1 = false
                            if u203 ~= nil then
                                v1 = false
                                if u203.Parent == LocalPlayer.Character then
                                    v1 = false
                                    if u199 ~= nil then
                                        v1 = u199.Phase == "Active"
                                    end
                                end
                            end
                        end
                    end
                end
                if not v1 then
                    u208 = false
                end
                if u202 == v1 then
                    return
                end
                u202 = v1
                TrainGhostVisuals.SetInput(v1)
                TrainEvent.Suction:FireServer(v1)
            end)))
            table.insert(u11, (a1.AncestryChanged:Connect(function() -- Line: 133
                -- upvalues: a1 (val), LocalPlayer (upval), u203 (upval), u208 (upval), u209 (upval), u198 (upval)
                -- upvalues: u199 (upval), u202 (upval), TrainGhostVisuals (upval), TrainEvent (upval), u11 (val)
                -- upvalues: u204 (upval)
                if a1.Parent == LocalPlayer.Character then
                    u203 = a1
                elseif u203 == a1 then
                    local v1
                    u208 = false
                    if u208 then
                        v1 = false
                        if u198.Phase == "Town" then
                            v1 = false
                            if u203 ~= nil then
                                v1 = false
                                if u203.Parent == LocalPlayer.Character then
                                    v1 = false
                                    if u199 ~= nil then
                                        v1 = u199.Phase == "Active"
                                    end
                                end
                            end
                        end
                    else
                        v1 = u209
                        if v1 then
                            v1 = false
                            if u198.Phase == "Town" then
                                v1 = false
                                if u203 ~= nil then
                                    v1 = false
                                    if u203.Parent == LocalPlayer.Character then
                                        v1 = false
                                        if u199 ~= nil then
                                            v1 = u199.Phase == "Active"
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if not v1 then
                        u208 = false
                    end
                    if u202 ~= v1 then
                        u202 = v1
                        TrainGhostVisuals.SetInput(v1)
                        TrainEvent.Suction:FireServer(v1)
                    end
                    u203 = nil
                end
                if not a1:IsDescendantOf(game) then
                    for i, j in u11 do
                        j:Disconnect()
                    end
                    u204[a1] = nil
                end
            end)))
            if a1.Parent == LocalPlayer.Character then
                u203 = a1
                return
            end
            if u203 == a1 then
                local v1
                u208 = false
                if u208 then
                    v1 = false
                    if u198.Phase == "Town" then
                        v1 = false
                        if u203 ~= nil then
                            v1 = false
                            if u203.Parent == LocalPlayer.Character then
                                v1 = false
                                if u199 ~= nil then
                                    v1 = u199.Phase == "Active"
                                end
                            end
                        end
                    end
                else
                    v1 = u209
                    if v1 then
                        v1 = false
                        if u198.Phase == "Town" then
                            v1 = false
                            if u203 ~= nil then
                                v1 = false
                                if u203.Parent == LocalPlayer.Character then
                                    v1 = false
                                    if u199 ~= nil then
                                        v1 = u199.Phase == "Active"
                                    end
                                end
                            end
                        end
                    end
                end
                if not v1 then
                    u208 = false
                end
                if u202 ~= v1 then
                    u202 = v1
                    TrainGhostVisuals.SetInput(v1)
                    TrainEvent.Suction:FireServer(v1)
                end
                u203 = nil
            end
            return
        end
    end

    local function trackCharacter(a1) -- Line: 139
        -- upvalues: u208 (ref), u209 (ref), u198 (ref), u203 (ref), LocalPlayer (val), u199 (ref), u202 (ref)
        -- upvalues: TrainGhostVisuals (upval), TrainEvent (upval), bind (val)
        local v1
        u208 = false
        if u208 then
            v1 = false
            if u198.Phase == "Town" then
                v1 = false
                if u203 ~= nil then
                    v1 = false
                    if u203.Parent == LocalPlayer.Character then
                        v1 = false
                        if u199 ~= nil then
                            v1 = u199.Phase == "Active"
                        end
                    end
                end
            end
        else
            v1 = u209
            if v1 then
                v1 = false
                if u198.Phase == "Town" then
                    v1 = false
                    if u203 ~= nil then
                        v1 = false
                        if u203.Parent == LocalPlayer.Character then
                            v1 = false
                            if u199 ~= nil then
                                v1 = u199.Phase == "Active"
                            end
                        end
                    end
                end
            end
        end
        if not v1 then
            u208 = false
        end
        if u202 ~= v1 then
            u202 = v1
            TrainGhostVisuals.SetInput(v1)
            TrainEvent.Suction:FireServer(v1)
        end
        u203 = nil
        for i, j in a1:GetChildren() do
            bind(j)
        end
        a1.ChildAdded:Connect(bind)
    end

    LocalPlayer.CharacterAdded:Connect(trackCharacter)
    if LocalPlayer.Character then
        trackCharacter(LocalPlayer.Character)
    end
    task.spawn(function() -- Line: 146 -- upvalues: LocalPlayer (val), bind (val)
        local Backpack = LocalPlayer:WaitForChild("Backpack")
        for i, j in Backpack:GetChildren() do
            bind(j)
        end
        Backpack.ChildAdded:Connect(bind)
    end)
    local v1 = ContextActionService
    local ButtonR2 = Enum.KeyCode.ButtonR2
    v1:BindAction("TrainVacuumTrigger", function(a1, a2) -- Line: 150
        -- upvalues: u203 (ref), u198 (ref), u208 (ref), u209 (ref), LocalPlayer (val), u199 (ref), u202 (ref)
        -- upvalues: TrainGhostVisuals (upval), TrainEvent (upval)
        if u203 and u198.Phase == "Town" then
            local v1
            if a2 == Enum.UserInputState.Begin then
                u208 = true
                if u208 then
                    v1 = false
                    if u198.Phase == "Town" then
                        v1 = false
                        if u203 ~= nil then
                            v1 = false
                            if u203.Parent == LocalPlayer.Character then
                                v1 = false
                                if u199 ~= nil then
                                    v1 = u199.Phase == "Active"
                                end
                            end
                        end
                    end
                else
                    v1 = u209
                    if v1 then
                        v1 = false
                        if u198.Phase == "Town" then
                            v1 = false
                            if u203 ~= nil then
                                v1 = false
                                if u203.Parent == LocalPlayer.Character then
                                    v1 = false
                                    if u199 ~= nil then
                                        v1 = u199.Phase == "Active"
                                    end
                                end
                            end
                        end
                    end
                end
                if not v1 then
                    u208 = false
                end
                if u202 ~= v1 then
                    u202 = v1
                    TrainGhostVisuals.SetInput(v1)
                    TrainEvent.Suction:FireServer(v1)
                end
            elseif a2 == Enum.UserInputState.End or a2 == Enum.UserInputState.Cancel then
                u208 = false
                if u208 then
                    v1 = false
                    if u198.Phase == "Town" then
                        v1 = false
                        if u203 ~= nil then
                            v1 = false
                            if u203.Parent == LocalPlayer.Character then
                                v1 = false
                                if u199 ~= nil then
                                    v1 = u199.Phase == "Active"
                                end
                            end
                        end
                    end
                else
                    v1 = u209
                    if v1 then
                        v1 = false
                        if u198.Phase == "Town" then
                            v1 = false
                            if u203 ~= nil then
                                v1 = false
                                if u203.Parent == LocalPlayer.Character then
                                    v1 = false
                                    if u199 ~= nil then
                                        v1 = u199.Phase == "Active"
                                    end
                                end
                            end
                        end
                    end
                end
                if not v1 then
                    u208 = false
                end
                if u202 ~= v1 then
                    u202 = v1
                    TrainGhostVisuals.SetInput(v1)
                    TrainEvent.Suction:FireServer(v1)
                end
            end
            return Enum.ContextActionResult.Sink
        end
        return Enum.ContextActionResult.Pass
    end, false, ButtonR2)
    local u264 = {}
    local u265 = nil
    local u266 = nil
    local u267 = nil

    local function trackPrompt(a1) -- Line: 157 -- upvalues: u264 (val)
        if a1:IsA("ProximityPrompt") and a1:GetAttribute("TrainEventAction") then
            u264[a1] = true
        end
    end

    local u269 = nil
    local u270 = nil
    local u271 = nil

    local function updateBoardingPrompt() -- Line: 161
        -- upvalues: u264 (val), u271 (ref), u269 (ref), u270 (ref), Workspace (upval), u201 (ref), u198 (ref)
        -- upvalues: TrainEvent (upval), Toast (upval), LocalPlayer (val), TrainReturnPrompt (upval)
        local v1 = nil
        for i in u264 do
            if i.Parent and i.Name == "TrainBoard" and not i:GetAttribute("TrainLocalBoarding") then
                v1 = i
                break
            end
        end
        if v1 ~= u271 then
            if u269 then
                u269:Destroy()
            end
            u269 = nil
            u270 = nil
            u271 = v1
            if v1 then
                u269 = Instance.new("Part")
                u269.Name = "TrainBoardingPromptAnchor"
                u269.Size = Vector3.new(1, 1, 1)
                u269.Transparency = 1
                u269.Anchored = true
                u269.CanCollide = false
                u269.CanTouch = false
                u269.CanQuery = false
                u270 = v1:Clone()
                u270.Name = "TrainBoardingMoving"
                u270:SetAttribute("TrainLocalBoarding", true)
                u270.Enabled = false
                u270.KeyboardKeyCode = Enum.KeyCode.E
                u270.ClickablePrompt = true
                u270.Parent = u269
                u269.Parent = Workspace
                u270.Triggered:Connect(function() -- Line: 177 -- upvalues: u201 (upval), u198 (upval), TrainEvent (upval), Toast (upval)
                    if not u201 and u198.ArrivalOpen and u198.Phase == "Home" then
                        u201 = true
                        local success, err, v1 = pcall(function() -- Line: 181 -- upvalues: TrainEvent (upval)
                            return TrainEvent.Action:InvokeServer("Board")
                        end)
                        u201 = false
                        if not success or not err then
                            Toast.Show({
                                Lane = "Feed",
                                Seconds = 3,
                                Text = if typeof(v1) ~= "string" then "Boarding could not finish. Please try again." else v1,
                                Color = Color3.fromRGB(255, 100, 100),
                                StrokeColor = Color3.fromRGB(80, 15, 15),
                            })
                        end
                        return
                    end
                end)
            end
        end
        if u270 and u269 and v1 then
            v1.Enabled = false
            local Character = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local Attribute = v1:GetAttribute("BoardRailStart")
            local Attribute_2 = v1:GetAttribute("BoardRailEnd")
            u270.ActionText = "Board Train"
            u270.ObjectText = "Phantom Express"
            u270.MaxActivationDistance = v1.MaxActivationDistance
            if Character and typeof(Attribute) == "Vector3" and typeof(Attribute_2) == "Vector3" then
                u269.Position = TrainReturnPrompt.ClosestPoint(Character.Position, Attribute, Attribute_2)
                local v2 = u270
                local v3 = false
                if u198.ArrivalOpen == true then
                    v3 = false
                    if u198.Phase == "Home" then
                        v3 = (Character.Position - u269.Position).Magnitude <= v1.MaxActivationDistance
                    end
                end
                v2.Enabled = v3
                return
            end
            u270.Enabled = false
            return
        end
    end

    script.Destroying:Connect(function() -- Line: 201 -- upvalues: u269 (ref)
        if u269 then
            u269:Destroy()
        end
    end)

    local function updateReturnPrompt() -- Line: 203
        -- upvalues: u264 (val), u267 (ref), u265 (ref), u266 (ref), Workspace (upval), u201 (ref), u198 (ref)
        -- upvalues: u208 (ref), u209 (ref), u203 (ref), LocalPlayer (val), u199 (ref), u202 (ref)
        -- upvalues: TrainGhostVisuals (upval), TrainEvent (upval), u83 (val), u200 (ref), TrainReturnPrompt (upval)
        local v1 = nil
        for i in u264 do
            if i.Parent
                and i.Name == "TrainReturn"
                and i:GetAttribute("TrainEventRequiredPhase") == "Town"
                and not i:GetAttribute("TrainLocalReturn") then
                v1 = i
                break
            end
        end
        if v1 ~= u267 then
            if u265 then
                u265:Destroy()
            end
            u265 = nil
            u266 = nil
            u267 = v1
            if v1 then
                u265 = Instance.new("Part")
                u265.Name = "TrainReturnPromptAnchor"
                u265.Size = Vector3.new(1, 1, 1)
                u265.Transparency = 1
                u265.Anchored = true
                u265.CanCollide = false
                u265.CanTouch = false
                u265.CanQuery = false
                u266 = v1:Clone()
                u266:SetAttribute("TrainLocalReturn", true)
                u266.Enabled = false
                u266.KeyboardKeyCode = Enum.KeyCode.E
                u266.ClickablePrompt = true
                u266.Parent = u265
                u265.Parent = Workspace
                u266.Triggered:Connect(function() -- Line: 218
                    -- upvalues: u201 (upval), u198 (upval), u208 (upval), u209 (upval), u203 (upval)
                    -- upvalues: LocalPlayer (upval), u199 (upval), u202 (upval), TrainGhostVisuals (upval)
                    -- upvalues: TrainEvent (upval), u83 (upval), u200 (upval)
                    if not u201 and u198.Phase == "Town" then
                        local success, v1, v2
                        u201 = true
                        u208 = false
                        if u208 then
                            v1 = false
                            if u198.Phase == "Town" then
                                v1 = false
                                if u203 ~= nil then
                                    v1 = false
                                    if u203.Parent == LocalPlayer.Character then
                                        v1 = false
                                        if u199 ~= nil then
                                            v1 = u199.Phase == "Active"
                                        end
                                    end
                                end
                            end
                        else
                            v1 = u209
                            if v1 then
                                v1 = false
                                if u198.Phase == "Town" then
                                    v1 = false
                                    if u203 ~= nil then
                                        v1 = false
                                        if u203.Parent == LocalPlayer.Character then
                                            v1 = false
                                            if u199 ~= nil then
                                                v1 = u199.Phase == "Active"
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        if not v1 then
                            u208 = false
                        end
                        if u202 ~= v1 then
                            u202 = v1
                            TrainGhostVisuals.SetInput(v1)
                            TrainEvent.Suction:FireServer(v1)
                        end
                        success, _, v2 = pcall(function() -- Line: 221 -- upvalues: TrainEvent (upval)
                            return TrainEvent.Action:InvokeServer("Return")
                        end)
                        u201 = false
                        if typeof(v2) == "string" then
                            u83.Text = v2
                            u200 = os.clock() + 5
                            return
                        end
                        if not success then
                            u83.Text = "Please try again."
                            u200 = os.clock() + 5
                        end
                        return
                    end
                end)
            end
        end
        if u266 and u265 and v1 then
            v1.Enabled = false
            local Character = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local Attribute = v1:GetAttribute("ReturnRailStart")
            local Attribute_2 = v1:GetAttribute("ReturnRailEnd")
            if Character and typeof(Attribute) == "Vector3" and typeof(Attribute_2) == "Vector3" then
                u265.Position = TrainReturnPrompt.ClosestPoint(Character.Position, Attribute, Attribute_2)
                local v2 = u266
                local v3 = false
                if u198.Phase == "Town" then
                    v3 = (Character.Position - u265.Position).Magnitude <= v1.MaxActivationDistance
                end
                v2.Enabled = v3
                return
            end
            u266.Enabled = false
            return
        end
    end

    script.Destroying:Connect(function() -- Line: 237 -- upvalues: u265 (ref)
        if u265 then
            u265:Destroy()
        end
    end)
    Workspace.DescendantAdded:Connect(function(a1) -- Line: 238 -- upvalues: trackPrompt (val)
        if a1:IsA("ProximityPrompt") then
            task.defer(trackPrompt, a1)
        end
    end)
    for i, j in Workspace:GetDescendants() do
        if j:IsA("ProximityPrompt") and j:GetAttribute("TrainEventAction") then
            u264[j] = true
        end
    end
    local u308 = nil
    local u309 = nil
    Frame.Visible = false
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    TrainEvent.State.OnClientEvent:Connect(apply)
    TrainEvent.CaptureState.OnClientEvent:Connect(function(a1) -- Line: 243
        -- upvalues: u198 (ref), u199 (ref), TrainEventPresentation (upval), u208 (ref), u209 (ref), u203 (ref)
        -- upvalues: LocalPlayer (val), u202 (ref), TrainGhostVisuals (upval), TrainEvent (upval)
        if u198.Phase == "Town" then
            u199 = a1
            TrainEventPresentation.UpdateInvasion(a1)
            if a1.Phase ~= "Active" then
                local v1
                u208 = false
                if u208 then
                    v1 = false
                    if u198.Phase == "Town" then
                        v1 = false
                        if u203 ~= nil then
                            v1 = false
                            if u203.Parent == LocalPlayer.Character then
                                v1 = false
                                if u199 ~= nil then
                                    v1 = u199.Phase == "Active"
                                end
                            end
                        end
                    end
                else
                    v1 = u209
                    if v1 then
                        v1 = false
                        if u198.Phase == "Town" then
                            v1 = false
                            if u203 ~= nil then
                                v1 = false
                                if u203.Parent == LocalPlayer.Character then
                                    v1 = false
                                    if u199 ~= nil then
                                        v1 = u199.Phase == "Active"
                                    end
                                end
                            end
                        end
                    end
                end
                if not v1 then
                    u208 = false
                end
                if u202 == v1 then
                    return
                end
                u202 = v1
                TrainGhostVisuals.SetInput(v1)
                TrainEvent.Suction:FireServer(v1)
            end
        end
    end)

    local function clock(a1) -- Line: 244 -- upvalues: Workspace (upval)
        local v1 = math.max(0, (math.ceil((a1 or 0) - (Workspace:GetServerTimeNow()))))
        return string.format("%02d:%02d", math.floor(v1 / 60), v1 % 60)
    end

    local function bossSuction() -- Line: 248
        -- upvalues: LocalPlayer (val), GhostBoss (upval), ReplicatedStorage (upval), GhostBossFlags (upval)
        if LocalPlayer:GetAttribute(GhostBoss.SuckingAttribute) ~= true then
            return nil
        end
        local v1 = ReplicatedStorage:FindFirstChild(GhostBoss.StateName)
        if not v1 then
            return nil
        end
        local v2 = math.max(tonumber((v1:GetAttribute(GhostBoss.Attributes.MaxHealth))) or 1, 1)
        return GhostBoss.CaptureProgress(
            math.clamp((tonumber((v1:GetAttribute(GhostBoss.Attributes.Health))) or v2) / v2, 0, 1),
            GhostBossFlags.CaptureHealthFraction:Get()
        )
    end

    RunService.RenderStepped:Connect(function(a1) -- Line: 255
        -- upvalues: updateReturnPrompt (val), updateBoardingPrompt (val), bossSuction (val), u199 (ref), u205 (ref)
        -- upvalues: Frame_3 (val), u143 (val), TextLabel (val), u207 (ref), u120 (val), LocalPlayer (val), u198 (ref)
        -- upvalues: u203 (ref), ghostInReach (val), u210 (ref), u209 (ref), u208 (ref), u202 (ref)
        -- upvalues: TrainGhostVisuals (upval), TrainEvent (upval), u206 (ref)
        local v1
        updateReturnPrompt()
        updateBoardingPrompt()
        local v2 = bossSuction()
        local v3 = if v2 then v2 else if not u199 or not u199.Target then 0 else math.clamp(u199.Progress or 0, 0, 1)
        u205 = if v3 ~= 0 then u205 + (v3 - u205) * (1 - math.exp(-18 * a1)) else 0
        Frame_3.Size = UDim2.fromScale(1, u205)
        u143:SetAttribute("ServerProgress", v3)
        TextLabel.Text = (tostring((math.floor(v3 * 100)))) .. "%"
        if u207 and u207.Parent then
            u207.GhostCaptureProgress.Fill.Size = Frame_3.Size
            u207.Percent.Text = TextLabel.Text
            u207.CaptureTarget.Text = u120.Text
        end
        v3 = false
        local Character = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if Character and Character:IsA("BasePart") then
            v1 = false
            if u198.Phase == "Town" then
                v1 = false
                if u203 ~= nil then
                    v1 = false
                    if u203.Parent == LocalPlayer.Character then
                        v1 = false
                        if u199 ~= nil then
                            v1 = u199.Phase == "Active"
                        end
                    end
                end
            end
            if v1 then
                if ghostInReach(Character) then
                    u210 = os.clock()
                end
                v3 = os.clock() - u210 <= 0.3
            end
        end
        if v3 ~= u209 then
            if u208 then
                v2 = false
                if u198.Phase == "Town" then
                    v2 = false
                    if u203 ~= nil then
                        v2 = false
                        if u203.Parent == LocalPlayer.Character then
                            v2 = false
                            if u199 ~= nil then
                                v2 = u199.Phase == "Active"
                            end
                        end
                    end
                end
            else
                v2 = v3
                if v2 then
                    v2 = false
                    if u198.Phase == "Town" then
                        v2 = false
                        if u203 ~= nil then
                            v2 = false
                            if u203.Parent == LocalPlayer.Character then
                                v2 = false
                                if u199 ~= nil then
                                    v2 = u199.Phase == "Active"
                                end
                            end
                        end
                    end
                end
            end
            if not v2 then
                u208 = false
            end
            if u202 ~= v2 then
                u202 = v2
                TrainGhostVisuals.SetInput(v2)
                TrainEvent.Suction:FireServer(v2)
            end
        end
        if not u202 then
            return
        end
        if u203 and u203.Parent == LocalPlayer.Character then
            v1 = os.clock()
            if u206 <= v1 then
                u206 = os.clock() + 0.25
                TrainEvent.Suction:FireServer(true)
            end
            return
        end
        u208 = false
        if u208 then
            v3 = false
            if u198.Phase == "Town" then
                v3 = false
                if u203 ~= nil then
                    v3 = false
                    if u203.Parent == LocalPlayer.Character then
                        v3 = false
                        if u199 ~= nil then
                            v3 = u199.Phase == "Active"
                        end
                    end
                end
            end
        else
            v3 = u209
            if v3 then
                v3 = false
                if u198.Phase == "Town" then
                    v3 = false
                    if u203 ~= nil then
                        v3 = false
                        if u203.Parent == LocalPlayer.Character then
                            v3 = false
                            if u199 ~= nil then
                                v3 = u199.Phase == "Active"
                            end
                        end
                    end
                end
            end
        end
        if not v3 then
            u208 = false
        end
        if u202 == v3 then
            return
        end
        u202 = v3
        TrainGhostVisuals.SetInput(v3)
        TrainEvent.Suction:FireServer(v3)
    end)
    RunService.Heartbeat:Connect(function() -- Line: 281
        -- upvalues: u198 (ref), Workspace (upval), Frame (val), UserInputService (upval), u73 (val), u220 (val)
        -- upvalues: u264 (val), u199 (ref), u308 (ref), u309 (ref), u89 (val), Frame_2 (val), u202 (ref)
        -- upvalues: LocalPlayer (val), u207 (ref), u120 (val), u143 (val), u78 (val), bossSuction (val)
        -- upvalues: GhostBoss (upval), u200 (ref), u83 (val)
        local Attribute, v1
        local ArrivalOpen = u198.ArrivalOpen
        if ArrivalOpen then
            local DepartureAt = u198.DepartureAt
            ArrivalOpen = Workspace:GetServerTimeNow() < DepartureAt
        end
        local v2 = u198.Phase == "Town"
        local new = UDim2.new
        local v3 = 0
        Frame.Size = new(
            0.85,
            0,
            v3,
            if not v2 then if not ArrivalOpen then 112 else if u198.Phase ~= "Home" then 112 else if u198.Prototype ~= true then 112 else if u198.AtStation then 112 else 160 else if not UserInputService.TouchEnabled then 156 else 200
        )
        Frame.Visible = false
        u73.Text = if not v2 then "PHANTOM EXPRESS" else "GHOST INVASION"
        local v4 = u198.AtStation == true
        local Station = u220.Station
        local v5 = ArrivalOpen
        if v5 then
            v5 = false
            if u198.Phase == "Home" then
                v5 = false
                if u198.Prototype == true then
                    v5 = not v4
                end
            end
        end
        Station.Visible = v5
        local v6 = u264
        v5 = nil
        local v7 = nil
        for i in v6, v5, v7 do
            if i.Parent then
                Attribute = i:GetAttribute("TrainEventAction")
                if not i:GetAttribute("TrainLocalBoarding") then
                    if i.Name == "TrainBoard" or i.Name == "TrainCancel" then
                        i.Enabled = false
                    elseif Attribute == "HandIn" then
                        v1 = ArrivalOpen
                        if v1 then
                            v1 = false
                            if u198.Phase == "Home" then
                                v1 = false
                                if u198.StationAvailable ~= false then
                                    v1 = not u198.AccessUnlocked
                                end
                            end
                        end
                        i.Enabled = v1
                    elseif Attribute == "Board" then
                        v1 = ArrivalOpen
                        if v1 then
                            v1 = false
                            if u198.Phase == "Home" then
                                v1 = u198.StationAvailable ~= false
                            end
                        end
                        i.Enabled = v1
                    elseif Attribute ~= "Return" then
                        if Attribute == "OpenSoulShop" then
                            v1 = v2 and u198.TravelBusy ~= true
                            i.Enabled = v1
                        elseif Attribute == "PickupVacuum" then
                            v1 = v2
                            if v1 then
                                v1 = false
                                if u198.TravelBusy ~= true then
                                    v1 = false
                                    if u199 ~= nil then
                                        v1 = not u199.VacuumOwned
                                    end
                                end
                            end
                            i.Enabled = v1
                        end
                    elseif not i:GetAttribute("TrainLocalReturn") then
                        if i.Name ~= "TrainReturn" or i:GetAttribute("TrainLocalReturn") then
                            v1 = u198.Phase == i:GetAttribute("TrainEventRequiredPhase")
                            i.Enabled = v1
                        else
                            i.Enabled = false
                        end
                    end
                end
            else
                u264[i] = nil
            end
        end
        local TrainEventRuntime = Workspace:FindFirstChild("TrainEventRuntime")
        local GhostVacuum = TrainEventRuntime and TrainEventRuntime:FindFirstChild("GhostVacuum")
        if GhostVacuum and GhostVacuum:IsA("Model") then
            if u308 ~= GhostVacuum then
                u308 = GhostVacuum
                u309 = GhostVacuum:GetPivot()
            end
            v7 = v2
            if v7 then
                v7 = false
                if u199 ~= nil then
                    v7 = u199.VacuumOwned == true
                end
            end
            for j, k in GhostVacuum:GetDescendants() do
                if k:IsA("BasePart") then
                    k.LocalTransparencyModifier = if not v7 then 0 else 1
                elseif k:IsA("BillboardGui") then
                    k.Enabled = not v7
                end
            end
            if u309 then
                GhostVacuum:PivotTo(if not v2 or v7 then u309 else u309 * CFrame.new(0, math.sin((os.clock()) * 1.8) * 0.35, 0) * CFrame.Angles(0, os.clock() * 0.6, 0))
            end
        end
        v7 = v2
        if v7 then
            v7 = false
            if u198.TravelBusy ~= true then
                v7 = false
                if u199 ~= nil then
                    v7 = not u199.VacuumOwned
                end
            end
        end
        local PickupGlow = GhostVacuum and GhostVacuum:FindFirstChild("PickupGlow")
        if PickupGlow and PickupGlow:IsA("Highlight") then
            PickupGlow.Enabled = v7
        end
        local GhostVacuumRing = TrainEventRuntime and TrainEventRuntime:FindFirstChild("GhostVacuumRing")
        if GhostVacuumRing then
            for n, m in GhostVacuumRing:GetDescendants() do
                if m:IsA("BasePart") then
                    m.LocalTransparencyModifier = if not v7 then 1 else 0
                end
            end
        end
        u89.Visible = v2
        local v8 = v2
        if v8 then
            v8 = false
            if u199 ~= nil then
                v8 = false
                if u199.VacuumEquipped == true then
                    v8 = false
                    if u199.Phase == "Active" then
                        v8 = u202
                        if not v8 then
                            v8 = true
                            if u199.Holding ~= true then
                                v8 = u199.Target ~= nil
                            end
                        end
                    end
                end
            end
        end
        Frame_2.Visible = v8
        local Character = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("TrainVacuumBackpack")
        v7 = Character and Character:FindFirstChildWhichIsA("BillboardGui", true)
        if u207 then
            if not u207.Parent or u207.Parent ~= v7 then
                u207:Destroy()
                u207 = nil
            end
        end
        if v7 and not u207 then
            u207 = Frame_2:Clone()
            u207.Name = "TrainCaptureProgress"
            u207.AnchorPoint = Vector2.new(0.5, 0.5)
            u207.Position = UDim2.fromScale(0.5, 0.5)
            u207.Parent = v7
        end
        if u207 then
            u207.Visible = Frame_2.Visible
            Frame_2.Visible = false
        end
        u120.Visible = true
        u143.Visible = true
        local CurrentCamera = Workspace.CurrentCamera
        local v9 = Frame_2
        v8 = if not UserInputService.TouchEnabled then UDim2.new(0.5, math.clamp((CurrentCamera and CurrentCamera.ViewportSize.X or 1000) * 0.08, 48, 110), 0.5, 0) else UDim2.fromScale(0.7, 0.44)
        v9.Position = v8
        if not v2 or not u199 then
            if u198.Phase == "Departing" then
                v8 = "Travelling to Forgotten Town…"
            elseif u198.Phase == "Returning" then
                v8 = "Returning to Halloween…"
            elseif not ArrivalOpen then
                v8 = ""
            else
                v6 = math.max(0, (math.ceil((u198.DepartureAt or 0) - (Workspace:GetServerTimeNow()))))
                v8 = "Boarding closes in " .. string.format("%02d:%02d", math.floor(v6 / 60), v6 % 60)
            end
            u78.Text = v8
        else
            if u199.Phase == "Warmup" then
                v3 = math.max(0, (math.ceil((u199.StartsAt or 0) - (Workspace:GetServerTimeNow()))))
                v8 = "Invasion starts in " .. string.format("%02d:%02d", math.floor(v3 / 60), v3 % 60)
            elseif u199.Phase ~= "Active" then
                local v10 = string.lower(u199.Phase)
                v5 = math.max(0, (math.ceil((u198.ReturnAt or 0) - (Workspace:GetServerTimeNow()))))
                v8 = "Invasion " .. v10 .. " • return in " .. string.format("%02d:%02d", math.floor(v5 / 60), v5 % 60)
            else
                v7 = math.max(0, (math.ceil((u199.EndsAt or 0) - (Workspace:GetServerTimeNow()))))
                v8 = "Invasion ends in " .. string.format("%02d:%02d", math.floor(v7 / 60), v7 % 60)
            end
            u78.Text = v8
            u89.Text = ("Captured %* • Souls this visit %*\nSaved Souls %*%*"):format(
                u199.Captured,
                u199.VisitSouls,
                u199.SavedSouls,
                if not u199.Practice then "" else " • PRACTICE: rewards not saved"
            )
            u120.Text = if not bossSuction() then if not u199.Interrupted then u199.Target or "Aim at a ghost" else "Suction interrupted!" else GhostBoss.DisplayName
        end
        if ArrivalOpen and u198.Phase == "Home" then
            v9 = os.clock()
            if u200 < v9 then
                u83.Text = if not v4 then if not u198.Prototype then "Go to the Halloween station to board." else "The test station is away from spawn. Use Go to Station." else if not u198.AccessUnlocked then "Use Board Train with your Train Pass to unlock permanent access." else "Use the Board Train prompt before departure."
            end
        end
    end)
    task.spawn(function() -- Line: 342 -- upvalues: ScreenGui (val), TrainEvent (upval), apply (val)
        local err, success, v1
        while ScreenGui.Parent do
            success, err, v1 = pcall(function() -- Line: 343 -- upvalues: TrainEvent (upval)
                return TrainEvent.Action:InvokeServer("Status")
            end)
            if success and err then
                apply(v1)
            end
            task.wait(3)
        end
    end)
end

return v1