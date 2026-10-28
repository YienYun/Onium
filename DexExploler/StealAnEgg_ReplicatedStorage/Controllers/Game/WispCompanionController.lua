-- Script path: ReplicatedStorage.Controllers.Game.WispCompanionController
-- Decompile time: 46.53 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local GUI = require(ReplicatedStorage.Client.GUI)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local TutorialBeam = require(ReplicatedStorage.Client.WorldFX.TutorialBeam)
local Save = require(ReplicatedStorage.Shared.Save)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local WispQuests = require(ReplicatedStorage.Data.WispQuests)
local WispProgression = require(ReplicatedStorage.Shared.Modules.WispProgression)
local WispCompanion = require(ReplicatedStorage.Shared.Types.WispCompanion)
local u81 = require(script.IntroDialogue).new()
local v1 = {}
local LocalPlayer = Players.LocalPlayer
local u84 = nil
local u85 = nil
local u86 = {}
local u87 = 1
local u88 = nil
local u89 = nil
local u90 = nil
local u92 = WispCompanion.Blank()
local u93 = false
local u94 = nil
local u95 = nil
local u96 = nil
local u97 = nil
local u98 = {}
local u99 = false
local u100 = false
local u101 = nil
local u102 = nil
local u103 = nil
local u104 = nil
local u105 = nil
local u106 = nil
local u107 = false
local u108 = {}
local u109 = {}
local u110 = {}
local u111 = {}
local u112 = {}
local u113 = {}
local u114 = false
Color3.fromRGB(128, 236, 170)
local u124 = Color3.fromRGB(244, 210, 94)
local u125 = nil
local u126 = nil

local function updateCompanionPrompt(a1) -- Line: 57 -- upvalues: LocalPlayer (val), WispQuests (val), u92 (ref)
    local Character = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local Parent = a1.Parent
    if Character and Parent then
        local v1 = Parent.WorldPosition - Character.Position
        a1.MaxActivationDistance = math.sqrt(WispQuests.PromptRadius ^ 2 + v1.Y ^ 2) + 0.1
        local Accepted = u92.Accepted and not u92.Unlocked and Vector3.new(v1.X, 0, v1.Z).Magnitude <= WispQuests.PromptRadius
        a1.Enabled = Accepted
        return
    end
    a1.Enabled = false
end

local function focus() -- Line: 70 -- upvalues: UserInputService (val), GuiService (val), u85 (ref), u86 (val)
    if UserInputService.GamepadEnabled then
        GuiService.GuiNavigationEnabled = true
        local ReturnButton_Ready = if not u85.ReturnButton_Ready.Selectable then u85.Close else u85.ReturnButton_Ready
        for i, j in u86 do
            if j.Claim.Selectable then
                ReturnButton_Ready = j.Claim
                break
            end
        end
        GuiService.SelectedObject = ReturnButton_Ready
    end
end

local function open() -- Line: 84 -- upvalues: u125 (ref), Tabs (val), focus (val)
    u125()
    Tabs.Activate("WispCompanion")
    focus()
end

local function clearArrow() -- Line: 90 -- upvalues: u97 (ref), TutorialBeam (val)
    if u97 then
        TutorialBeam.Destroy(u97)
        u97 = nil
    end
end

local function guide() -- Line: 97 -- upvalues: LocalPlayer (val), u92 (ref), u95 (ref), u97 (ref), TutorialBeam (val)
    local Character = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if u92.Returning and not u92.Unlocked and u95 and Character then
        if not u97 then
            u97 = TutorialBeam.Attach(u95, {BeamName = "WispReturnBeam"})
            return
        end
        TutorialBeam.Retarget(u97, u95)
        return
    end
    if u97 then
        TutorialBeam.Destroy(u97)
        u97 = nil
    end
end

local function openDoors(a1) -- Line: 110 -- upvalues: u94 (ref), u99 (ref), u98 (val), TweenService (val)
    if u94 and not u99 then
        local Pivot, v1, v2
        u99 = true
        for i, j in u94.Doors:GetChildren() do
            if j:IsA("Model") then
                Pivot = u98[j] or j:GetPivot()
                u98[j] = Pivot
                v2 = Pivot + Vector3.new(if j.Name ~= "DoorLeft" then -7 else 7, 0, 0)
                for k, n in j:GetDescendants() do
                    if n:IsA("BasePart") then
                        n.CanCollide = false
                    end
                end
                if not a1 then
                    local u64 = Instance.new("CFrameValue")
                    u64.Value = Pivot
                    local u70 = u64.Changed:Connect(function(a1) -- Line: 131 -- upvalues: j (val)
                        if j.Parent then
                            j:PivotTo(a1)
                        end
                    end)
                    v1 = TweenService:Create(u64, TweenInfo.new(1.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Value = v2})
                    v1.Completed:Once(function() -- Line: 137 -- upvalues: u70 (val), u64 (val)
                        u70:Disconnect()
                        u64:Destroy()
                    end)
                    v1:Play()
                else
                    j:PivotTo(v2)
                end
            end
        end
        return
    end
end

local function canTalkToWisp() -- Line: 147 -- upvalues: Save (val)
    local v1 = Save.Peek()
    local WispCompanion = v1 and v1.WispCompanion
    local v2 = false
    if WispCompanion ~= nil then
        v2 = not WispCompanion.Accepted and not WispCompanion.Unlocked and workspace.World.Build:GetAttribute("EnchantedForestZoneRevealed") == true
    end
    return v2
end

local function canMeetWisp() -- Line: 154 -- upvalues: Save (val), WispQuests (val)
    local v1 = Save.Peek()
    local v2 = Save.Peek()
    local WispCompanion = v2 and v2.WispCompanion
    local v3 = false
    if WispCompanion ~= nil then
        v3 = not WispCompanion.Accepted and not WispCompanion.Unlocked and workspace.World.Build:GetAttribute("EnchantedForestZoneRevealed") == true
    end
    if v3 then
        v3 = false
        if typeof(v1.SpeedPower) == "number" then
            v3 = WispQuests.RequiredSpeedPower <= v1.SpeedPower
        end
    end
    return v3
end

local function nearSpawn() -- Line: 160 -- upvalues: LocalPlayer (val), u102 (ref), WispQuests (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local v1 = false
    if u102 ~= nil then
        v1 = u102:IsDescendantOf(workspace)
        if v1 then
            v1 = false
            if HumanoidRootPart ~= nil then
                v1 = false
                if Humanoid ~= nil then
                    v1 = false
                    if 0 < Humanoid.Health then
                        v1 = (HumanoidRootPart.Position - u102.Position).Magnitude <= WispQuests.SpawnPromptRadius
                    end
                end
            end
        end
    end
    return v1
end

local function createSpawnBillboard(a1) -- Line: 169
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    local PrimaryPart = a1.PrimaryPart
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "WispNameBillboard"
    BillboardGui.Adornee = PrimaryPart
    BillboardGui.Size = UDim2.fromOffset(160, 36)
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, BoundingBox.Position.Y - PrimaryPart.Position.Y + BoundingBox_2.Y * 0.5 + 1, 0)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.MaxDistance = 150
    BillboardGui.LightInfluence = 0
    local v1 = Instance.new("TextLabel")
    v1.Name = "Title"
    v1.Size = UDim2.fromScale(1, 1)
    v1.BackgroundTransparency = 1
    v1.Font = Enum.Font.GothamBlack
    v1.Text = "Wisp"
    v1.TextScaled = true
    v1.TextColor3 = Color3.new(1, 1, 1)
    v1.TextStrokeColor3 = Color3.new(0, 0, 0)
    v1.TextStrokeTransparency = 0
    v1.Parent = BillboardGui
    BillboardGui.Parent = PrimaryPart
    return BillboardGui
end

local u140 = setmetatable({}, {__mode = "k"})

local function syncWispVisual(a1, a2) -- Line: 197 -- upvalues: u140 (val)
    local Value, v1, v2, v3
    local v4 = {}
    local Descendants = a1:GetDescendants()
    v4[1] = a1
    v4[2] = table.unpack(Descendants)
    local v5 = nil
    local v6 = nil
    for i, j in v4, v5, v6 do
        v1 = nil
        v2 = nil
        if j:IsA("BasePart") then
            v1 = "LocalTransparencyModifier"
            v2 = 1
        elseif j:IsA("Decal") or j:IsA("Texture") then
            v1 = "Transparency"
            v2 = 1
        elseif j:IsA("ParticleEmitter") or j:IsA("Beam") or j:IsA("Trail") or j:IsA("Light") then
            v1 = "Enabled"
            v2 = false
        end
        if v1 then
            v3 = u140[j]
            if not v3 then
                v3 = {Property = v1, Value = if not j:IsA("BasePart") then j[v1] else 0}
                u140[j] = v3
            end
            Value = if not a2 then v2 else v3.Value
            j[v1] = Value
        end
    end
end

local function syncSpawn() -- Line: 222
    -- upvalues: Save (val), u102 (ref), u103 (ref), u107 (ref), u81 (val), u104 (ref), u105 (ref), syncWispVisual (val)
    -- upvalues: ReplicatedStorage (val), WispQuests (val), u106 (ref), createSpawnBillboard (val)
    local EnchantedForestZone = workspace.World.Build:FindFirstChild("EnchantedForestZone")
    local WispVisual = EnchantedForestZone and EnchantedForestZone:FindFirstChild("WispVisual")
    local v1 = Save.Peek()
    local WispCompanion = v1 and v1.WispCompanion
    if WispVisual and WispCompanion then
        if WispCompanion.Accepted or WispCompanion.Unlocked then
            WispVisual:Destroy()
            WispVisual = nil
        end
    end
    local WispSpawn = EnchantedForestZone and EnchantedForestZone:FindFirstChild("WispSpawn")
    v1 = Save.Peek()
    local WispCompanion_2 = v1 and v1.WispCompanion
    local v2 = false
    if WispCompanion_2 ~= nil then
        v2 = not WispCompanion_2.Accepted and not WispCompanion_2.Unlocked and workspace.World.Build:GetAttribute("EnchantedForestZoneRevealed") == true
    end
    if not v2 or not WispVisual or not WispSpawn or not WispSpawn:IsA("BasePart") then
        WispSpawn = nil
    end
    if u102 ~= WispSpawn or u103 and not u103.Parent then
        if u107 then
            u81.Close()
            u107 = false
        end
        if u103 then
            u103:Destroy()
        end
        if u104 then
            u104:Destroy()
        end
        u103 = nil
        u104 = nil
        u105 = nil
        u102 = WispSpawn
    end
    if u102 and not u103 then
        local BoundingBox_2
        local v3 = ReplicatedStorage.Assets.UI.WispStages["1"]:Clone()
        v3.Name = "BabyWisp"
        _, BoundingBox_2 = v3:GetBoundingBox()
        v3:ScaleTo((v3:GetScale()) * WispQuests.CompanionHeights[1] / BoundingBox_2.Y)
        for i, j in v3:GetDescendants() do
            if j:IsA("BasePart") then
                j.Anchored = true
                j.CanCollide = false
                j.CanTouch = false
                j.CanQuery = false
            end
        end
        local BoundingBox_3, BoundingBox_4 = v3:GetBoundingBox()
        local v4 = (v3:GetPivot()):PointToObjectSpace(BoundingBox_3.Position)
        u106 = Vector3.new(-v4.X, WispQuests.SpawnHoverHeight + BoundingBox_4.Y * 0.5 - v4.Y, -v4.Z)
        v3:PivotTo(u102.CFrame * (CFrame.new(u106 + (Vector3.new(0, u102.Size.Y * 0.5, 0)))))
        v3.Parent = workspace.Transient
        u103 = v3
        createSpawnBillboard(v3)
        local ProximityPrompt = Instance.new("ProximityPrompt")
        ProximityPrompt.Name = "WispTalkPrompt"
        ProximityPrompt.ActionText = "Talk"
        ProximityPrompt.ObjectText = "Baby Wisp"
        ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E
        ProximityPrompt.GamepadKeyCode = Enum.KeyCode.ButtonX
        ProximityPrompt.MaxActivationDistance = WispQuests.SpawnPromptRadius
        ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
        ProximityPrompt.HoldDuration = 0
        ProximityPrompt.RequiresLineOfSight = false
        ProximityPrompt.ClickablePrompt = true
        ProximityPrompt.Enabled = false
        ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
        ProximityPrompt.Parent = u102
        u104 = ProximityPrompt
        syncWispVisual(WispVisual, true)
        return
    end
    if WispVisual then
        local v5 = false
        if u102 ~= nil then
            v5 = u103 ~= nil
        end
        syncWispVisual(WispVisual, v5)
    end
end

local function updateWorld() -- Line: 288
    -- upvalues: u94 (ref), u96 (ref), u92 (ref), u100 (ref), openDoors (val), u101 (ref), u95 (ref)
    -- upvalues: ReplicatedStorage (val), WispQuests (val), guide (val)
    if not u94 then
        return
    end
    if u96 then
        local v1 = u96
        local Accepted = u92.Accepted and u92.Returning and not u92.Unlocked
        v1.Enabled = Accepted
        u96.ActionText = "Return Wisp"
        u96.ObjectText = "Enchanted Tree"
    end
    if not u92.Unlocked then
        if u101 then
            u101:Destroy()
            u101 = nil
        end
    elseif not u100 then
        openDoors(true)
        if not u101 and u95 then
            local BoundingBox_2
            u101 = ReplicatedStorage.Assets.UI.WispStages["4"]:Clone()
            u101.Name = "ReturnedWisp"
            _, BoundingBox_2 = u101:GetBoundingBox()
            u101:ScaleTo((u101:GetScale()) * WispQuests.CompanionHeights[4] / BoundingBox_2.Y)
            u101:PivotTo(u95.CFrame * (CFrame.new(0, 4, 16)))
            u101.Parent = workspace.Transient
        end
    elseif u101 then
        u101:Destroy()
        u101 = nil
    end
    guide()
end

local function rebuildRows() -- Line: 314
    -- upvalues: u86 (val), WispQuests (val), u89 (ref), GUI (val), u93 (ref), u92 (ref), u126 (ref)
    local TextButton, v1
    for i, j in u86 do
        j:Destroy()
    end
    table.clear(u86)
    for k, n in WispQuests.List do
        v1 = u89.Template:Clone()
        v1.Name = n.Id
        v1.Visible = true
        v1.LayoutOrder = k
        v1.QuestName.Text = n.Title
        v1.Icon.Image = n.Icon
        v1.Parent = u89
        TextButton = Instance.new("TextButton")
        TextButton.Name = "Claim"
        TextButton.Size = UDim2.fromScale(1, 1)
        TextButton.BackgroundTransparency = 1
        TextButton.Text = ""
        TextButton.ZIndex = 20
        TextButton.Parent = v1
        u86[n.Id] = v1
        GUI.OnActivated(TextButton, function() -- Line: 335 -- upvalues: u93 (upval), k (val), u92 (upval), n (val), u126 (upval)
            if not u93
                and k == u92.Stage
                and u92.Accepted
                and not u92.Claimed[n.Id]
                and n.Target <= (u92.Progress[n.Id] or 0) then
                u126("Claim", n.Id)
            end
        end)
    end
end

function u125() -- Line: 343
    -- upvalues: u85 (ref), u88 (ref), u92 (ref), u87 (ref), WispQuests (val), u90 (ref), u124 (val), u86 (val)
    -- upvalues: rebuildRows (val), u93 (ref), u113 (val), updateCompanionPrompt (val), WispProgression (val), u89 (ref)
    local Accepted, Accepted_2, Accepted_3, Target, Unlocked, v1, v2, v3, v4
    if not u85 then
        return
    end
    if u88 ~= u92.Stage then
        u88 = u92.Stage
        math.min(u92.Stage, WispQuests.StageCount)
        u85:SetAttribute("ViewedStage", nil)
    end
    local StageCount_2 = WispQuests.StageCount
    for i = 1, StageCount_2 do
        v2 = u90["Stage" .. i]
        Accepted = u92.Accepted and i <= u92.Stage
        Accepted_2 = u92.Accepted
        if Accepted_2 then
            Accepted_2 = false
            if i == u92.Stage then
                Accepted_2 = not u92.Unlocked
            end
        end
        v2.CompletedHolder.Visible = Accepted
        v2.RequirementHolder.Visible = false
        v2.LockedHolder.Visible = not Accepted
        v2.LockedOverlay.Visible = not Accepted
        v2.Glow.Visible = Accepted_2
        v2.UIStroke.Color = if not Accepted_2 then Color3.fromRGB(25, 25, 25) else u124
    end
    if next(u86) == nil then
        rebuildRows()
    end
    local v5 = nil
    local v6 = nil
    for j, k in WispQuests.List, v5, v6 do
        v3 = u86[k.Id]
        Unlocked = true
        if u92.Claimed[k.Id] ~= true then
            Unlocked = u92.Unlocked
        end
        v4 = not u92.Accepted or u92.Stage < j
        Target = if not Unlocked then u92.Progress[k.Id] or 0 else k.Target
        Accepted_3 = u92.Accepted
        if Accepted_3 then
            Accepted_3 = not Unlocked
            if Accepted_3 then
                Accepted_3 = false
                if j == u92.Stage then
                    Accepted_3 = k.Target <= Target
                end
            end
        end
        v3.Count.Text = ("%* / %*"):format(math.min(Target, k.Target), k.Target)
        v3.Progress.Fill.Size = UDim2.fromScale(math.clamp(Target / k.Target, 0, 1), 1)
        v3.Reward.Amount.Text = ("+%*"):format(k.Reward)
        if Accepted_3 then
            v3.Count.Text = "CLAIM"
        end
        v3.CompletedOverlay.Visible = Unlocked
        v1 = v4 and not Unlocked
        v3.LockedOverlay.Visible = v1
        v3.LockedOverlay.Requirement.Text = if u92.Accepted then ("Finish Quest %* & unlock Stage %*"):format(j - 1, j) else "Talk to the Baby Wisp"
        v1 = Accepted_3 and not u93
        v3.Claim.Active = v1
        v1 = Accepted_3 and not u93
        v3.Claim.Selectable = v1
        v3.Claim.Visible = Accepted_3
    end
    for n, m in u113 do
        updateCompanionPrompt(m.Prompt)
        m.Claim.Enabled = WispProgression.HasClaimable(u92)
    end
    u85.Dialogue.Visible = false
    u89.Visible = true
    local v7 = WispProgression.IsReady(u92)
    local Returning = not u92.Accepted or v7 or u92.Returning
    local ReturnButton_Ready = u85.ReturnButton_Ready
    ReturnButton_Ready.Visible = Returning and not u92.Unlocked
    u85.ReturnButton_Unready.Visible = not ReturnButton_Ready.Visible
    ReturnButton_Ready.Title.Text = if not u93 then if u92.Accepted then if not u92.Returning then "RETURN THE WISP" else "Show me the tree" else "Meet the Baby Wisp" else "Please wait..."
    ReturnButton_Ready.Active = not u93 and Returning and not u92.Unlocked
    ReturnButton_Ready.Selectable = ReturnButton_Ready.Active
    u85.ReturnButton_Unready.Title.Text = if not u92.Unlocked then "RETURN THE WISP" else "TREE UNLOCKED"
    u85.ReturnButton_Unready.SubTitle.Text = if not u92.Unlocked then "Complete all 3 quests" else "Your Wisp is home"
    u85.ReturnButton_Unready.Lock.Visible = not u92.Unlocked
    u85.ReturnButton_Unready.Active = false
    u85.ReturnButton_Unready.Selectable = false
end

function u126(a1, a2) -- Line: 400 -- upvalues: u93 (ref), u125 (ref), Remotes (val), u85 (ref)
    if u93 then
        return false
    end
    u93 = true
    u125()
    local success, err, v1 = pcall(function() -- Line: 406 -- upvalues: Remotes (upval), a1 (val), a2 (val)
        return Remotes.WispCompanion.Request:InvokeServer(a1, a2)
    end)
    u93 = false
    if success and err then
        u85.Status.Text = if a1 ~= "Claim" then "Your Wisp progress is saved." else "Your Wisp grew!"
        u125()
        return true
    end
    u85.Status.Text = if typeof(v1) ~= "string" then "Your Wisp could not save. Please try again." else v1
    u125()
    return false
end

local function returnWisp() -- Line: 420
    -- upvalues: u100 (ref), u93 (ref), u95 (ref), LocalPlayer (val), u126 (ref), Tabs (val), u97 (ref)
    -- upvalues: TutorialBeam (val), TweenService (val), openDoors (val), updateWorld (val)
    if not u100 and not u93 and u95 then
        local Character = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("WispCompanion")
        local u58 = Character
        if u58 then
            u58 = Character:Clone()
        end
        if u58 then
            for i, j in u58:GetDescendants() do
                if j:IsA("ProximityPrompt") or j:IsA("ClickDetector") or j.Name == "WispFollowJoint" then
                    j:Destroy()
                elseif j:IsA("BasePart") then
                    j.Anchored = true
                    j.CanCollide = false
                end
            end
        end
        u100 = true
        if not u126("Return") then
            u100 = false
            if u58 then
                u58:Destroy()
            end
            return
        end
        Tabs.Deactivate()
        if u97 then
            TutorialBeam.Destroy(u97)
            u97 = nil
        end
        if u58 then
            u58.Name = "WispReturnVisual"
            u58.Parent = workspace.Transient
            local v1 = Instance.new("CFrameValue")
            v1.Value = u58:GetPivot()
            local v2 = v1.Changed:Connect(function(a1) -- Line: 449 -- upvalues: u58 (val)
                u58:PivotTo(a1)
            end)
            local v3 = TweenService:Create(
                v1,
                TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Value = u95.CFrame * CFrame.new(0, 4, 16)}
            )
            v3:Play()
            v3.Completed:Wait()
            v2:Disconnect()
            v1:Destroy()
            u58:Destroy()
        end
        u100 = false
        openDoors(false)
        updateWorld()
        return
    end
end

local function startDialogue(a1, a2) -- Line: 464 -- upvalues: LocalPlayer (val), Tabs (val), u81 (val)
    local Character = LocalPlayer.Character
    local WispCompanion = Character and Character:FindFirstChild("WispCompanion")
    if not WispCompanion and Character then
        WispCompanion = Character:WaitForChild("WispCompanion", 5)
    end
    if LocalPlayer.Character == Character and WispCompanion then
        if Tabs.IsActive("WispCompanion") then
            Tabs.Deactivate({instant = true})
        end
        return u81.Start(WispCompanion, a1, a2)
    end
    return false
end

local function startIntro() -- Line: 475
    -- upvalues: startDialogue (val), WispQuests (val), u92 (ref), u100 (ref), u125 (ref), Tabs (val), focus (val)
    return startDialogue(WispQuests.Intro, function() -- Line: 476 -- upvalues: u92 (upval), u100 (upval), u125 (upval), Tabs (upval), focus (upval)
        if u92.Accepted and not u92.Unlocked and not u100 then
            u125()
            Tabs.Activate("WispCompanion")
            focus()
        end
    end)
end

local function startFinishedDialogue() -- Line: 483
    -- upvalues: u93 (ref), u100 (ref), u114 (ref), u81 (val), WispProgression (val), u92 (ref), startDialogue (val)
    -- upvalues: WispQuests (val), u126 (ref), guide (val), u125 (ref), Tabs (val), focus (val), u85 (ref)
    if not u93 and not u100 and not u114 and not u81.IsPlaying() and WispProgression.IsReady(u92) then
        u114 = true
        local v1 = startDialogue(WispQuests.Finished, function() -- Line: 486
            -- upvalues: WispProgression (upval), u92 (upval), u100 (upval), u126 (upval), guide (upval), u125 (upval)
            -- upvalues: Tabs (upval), focus (upval)
            task.spawn(function() -- Line: 487
                -- upvalues: WispProgression (upval), u92 (upval), u100 (upval), u126 (upval), guide (upval)
                -- upvalues: u125 (upval), Tabs (upval), focus (upval)
                if WispProgression.IsReady(u92) and not u100 then
                    if u126("BeginReturn") then
                        guide()
                        return
                    end
                    u125()
                    Tabs.Activate("WispCompanion")
                    focus()
                    return
                end
            end)
        end)
        u114 = false
        if not v1 then
            u85.Status.Text = "Your Wisp is not ready to talk. Please try again."
            u125()
            Tabs.Activate("WispCompanion")
            focus()
        end
        return
    end
end

local function acceptWisp() -- Line: 503
    -- upvalues: u93 (ref), u100 (ref), u114 (ref), u81 (val), Save (val), nearSpawn (val), u103 (ref), Tabs (val)
    -- upvalues: WispQuests (val), u107 (ref), u126 (ref), u125 (ref), focus (val)
    if not u93 and not u100 and not u114 and not u81.IsPlaying() then
        local v1 = Save.Peek()
        local WispCompanion = v1 and v1.WispCompanion
        local v2 = false
        if WispCompanion ~= nil then
            v2 = not WispCompanion.Accepted and not WispCompanion.Unlocked and workspace.World.Build:GetAttribute("EnchantedForestZoneRevealed") == true
        end
        if v2 and nearSpawn() and u103 then
            if Tabs.IsActive("WispCompanion") then
                Tabs.Deactivate({instant = true})
            end
            v1 = Save.Peek()
            local v3 = Save.Peek()
            local WispCompanion_2 = v3 and v3.WispCompanion
            v2 = false
            if WispCompanion_2 ~= nil then
                v2 = not WispCompanion_2.Accepted and not WispCompanion_2.Unlocked and workspace.World.Build:GetAttribute("EnchantedForestZoneRevealed") == true
            end
            if v2 then
                v2 = false
                if typeof(v1.SpeedPower) == "number" then
                    local SpeedPower_2 = v1.SpeedPower
                    v2 = WispQuests.RequiredSpeedPower <= SpeedPower_2
                end
            end
            if not v2 then
                u107 = u81.Start(u103, WispQuests.LockedIntro, function() -- Line: 507 -- upvalues: u107 (upval)
                    u107 = false
                end)
                return
            end
            u81.Start(u103, WispQuests.Intro, function() -- Line: 512
                -- upvalues: u107 (upval), Save (upval), WispQuests (upval), nearSpawn (upval), u114 (upval)
                -- upvalues: u126 (upval), u125 (upval), Tabs (upval), focus (upval)
                u107 = false
                local v1 = Save.Peek()
                local v2 = Save.Peek()
                local WispCompanion = v2 and v2.WispCompanion
                local v3 = false
                if WispCompanion ~= nil then
                    v3 = not WispCompanion.Accepted and not WispCompanion.Unlocked and workspace.World.Build:GetAttribute("EnchantedForestZoneRevealed") == true
                end
                if v3 then
                    v3 = false
                    if typeof(v1.SpeedPower) == "number" then
                        local SpeedPower_2 = v1.SpeedPower
                        v3 = WispQuests.RequiredSpeedPower <= SpeedPower_2
                    end
                end
                if v3 and nearSpawn() then
                    task.spawn(function() -- Line: 515 -- upvalues: u114 (upval), u126 (upval), u125 (upval), Tabs (upval), focus (upval)
                        u114 = true
                        u126("Accept")
                        u125()
                        Tabs.Activate("WispCompanion")
                        focus()
                        u114 = false
                    end)
                    return
                end
            end)
            return
        end
    end
end

local function openCompanion() -- Line: 524
    -- upvalues: u100 (ref), u114 (ref), u81 (val), u92 (ref), Tabs (val), startDialogue (val), WispQuests (val)
    -- upvalues: u125 (ref), focus (val), u126 (ref)
    if not u100 and not u114 and not u81.IsPlaying() and u92.Accepted and not u92.Unlocked then
        if Tabs.IsActive("WispCompanion") then
            return
        end
        if u92.MenuOpened then
            u125()
            Tabs.Activate("WispCompanion")
            focus()
            return
        end
        u114 = true
        if startDialogue(WispQuests.Intro, function() -- Line: 476 -- upvalues: u92 (upval), u100 (upval), u125 (upval), Tabs (upval), focus (upval)
            local WispCompanion, v0
            if u92.Accepted then
                if not u92.Unlocked then
                    if not u100 then
                        u125()
                        Tabs.Activate("WispCompanion")
                        focus()
                    end
                end
            end
            return
        end) then
            u126("Open")
        end
        u114 = false
        return
    end
end

local function bindCompanion(a1) -- Line: 536
    -- upvalues: LocalPlayer (val), u108 (val), u112 (val), u109 (val), WispQuests (val), openCompanion (val)
    -- upvalues: updateCompanionPrompt (val), WispProgression (val), u92 (ref), u113 (val), u110 (val), u111 (val)
    if (a1:GetAttribute("OwnerUserId")) == LocalPlayer.UserId and not u108[a1] then
        local RootPart = a1:WaitForChild("RootPart", 5)
        local WispFollowJoint = RootPart and RootPart:WaitForChild("WispFollowJoint", 5)
        if not WispFollowJoint then
            return
        end
        u108[a1] = WispFollowJoint
        local v1 = u112
        local Rotation = if not WispFollowJoint.Part0 then RootPart.CFrame.Rotation else WispFollowJoint.Part0.CFrame.Rotation
        v1[a1] = Rotation
        v1 = u109
        local CFrame = if not WispFollowJoint.Part0 then RootPart.CFrame else WispFollowJoint.Part0.CFrame * WispQuests.FollowOffset
        v1[a1] = CFrame
        local v2 = (a1:GetAttribute("OwnerUserId")) == LocalPlayer.UserId
        for i, j in a1:GetDescendants() do
            if j:IsA("ProximityPrompt") then
                j:Destroy()
            end
        end
        local ClickDetector = a1:FindFirstChildWhichIsA("ClickDetector", true)
        local u83 = nil
        local u75 = nil
        local u76 = nil
        if v2 then
            if ClickDetector then
                u83 = ClickDetector.MouseClick:Connect(openCompanion)
            end
            local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
            u75 = Instance.new("Attachment")
            u75.Name = "WispMenuAttachment"
            local CFrame_2 = RootPart.CFrame
            local v3 = BoundingBox.Position - (Vector3.new(0, BoundingBox_2.Y * 0.5 + 1.8, 0))
            u75.Position = CFrame_2:PointToObjectSpace(v3)
            u75.Parent = RootPart
            local ProximityPrompt = Instance.new("ProximityPrompt")
            ProximityPrompt.Name = "WispMenuPrompt"
            ProximityPrompt.ActionText = "Open"
            ProximityPrompt.ObjectText = "Your Wisp"
            ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E
            ProximityPrompt.GamepadKeyCode = Enum.KeyCode.ButtonX
            ProximityPrompt.MaxActivationDistance = WispQuests.PromptRadius
            ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
            ProximityPrompt.HoldDuration = 0
            ProximityPrompt.RequiresLineOfSight = false
            ProximityPrompt.ClickablePrompt = true
            ProximityPrompt.Enabled = false
            ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
            ProximityPrompt.Parent = u75
            updateCompanionPrompt(ProximityPrompt)
            u76 = Instance.new("BillboardGui")
            u76.Name = "WispClaimHint"
            u76.Adornee = RootPart
            u76.Size = UDim2.fromOffset(48, 56)
            local v4 = BoundingBox.Position.Y - RootPart.Position.Y + BoundingBox_2.Y * 0.5 + 0.8
            u76.StudsOffsetWorldSpace = Vector3.new(0, v4, 0)
            u76.AlwaysOnTop = true
            u76.Active = true
            u76.Enabled = WispProgression.HasClaimable(u92)
            local v5 = Instance.new("TextButton")
            v5.Name = "OpenMenu"
            v5.Size = UDim2.fromScale(1, 1)
            v5.BackgroundTransparency = 1
            v5.Text = "!"
            v5.Font = Enum.Font.GothamBlack
            v5.TextScaled = true
            v5.TextColor3 = Color3.fromRGB(255, 0, 0)
            v5.TextStrokeTransparency = 0
            v5.Selectable = false
            v5.Parent = u76
            v5.Activated:Connect(openCompanion)
            u76.Parent = LocalPlayer:WaitForChild("PlayerGui")
            u113[a1] = {Prompt = ProximityPrompt, Claim = u76}
        elseif ClickDetector then
            ClickDetector.MaxActivationDistance = 0
        end
        a1.Destroying:Once(function() -- Line: 599
            -- upvalues: u83 (ref), u75 (ref), u76 (ref), u113 (upval), a1 (val), u108 (upval), u109 (upval)
            -- upvalues: u110 (upval), u111 (upval), u112 (upval)
            if u83 then
                u83:Disconnect()
            end
            if u75 then
                u75:Destroy()
            end
            if u76 then
                u76:Destroy()
            end
            u113[a1] = nil
            u108[a1] = nil
            u109[a1] = nil
            u110[a1] = nil
            u111[a1] = nil
            u112[a1] = nil
        end)
        return
    end
end

local function syncCompanion() -- Line: 612
    -- upvalues: LocalPlayer (val), u92 (ref), WispQuests (val), ReplicatedStorage (val), bindCompanion (val)
    local Character = LocalPlayer.Character
    if not Character then
        return
    end
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local WispCompanion = Character:FindFirstChild("WispCompanion")
    if u92.Accepted and not u92.Unlocked and HumanoidRootPart and Humanoid and not (Humanoid.Health <= 0) then
        local BoundingBox_2
        local v1 = math.min(u92.Stage, WispQuests.StageCount)
        if WispCompanion and WispCompanion:GetAttribute("Stage") == v1 then
            return
        end
        if WispCompanion then
            WispCompanion:Destroy()
        end
        local v2 = ReplicatedStorage.Assets.UI.WispStages[tostring(v1)]:Clone()
        v2.Name = "WispCompanion"
        v2:SetAttribute("Stage", v1)
        v2:SetAttribute("OwnerUserId", LocalPlayer.UserId)
        _, BoundingBox_2 = v2:GetBoundingBox()
        v2:ScaleTo((v2:GetScale()) * WispQuests.CompanionHeights[v1] / BoundingBox_2.Y)
        for i, j in v2:GetDescendants() do
            if j:IsA("BasePart") then
                j.Anchored = false
                j.CanCollide = false
                j.CanTouch = false
                j.CanQuery = true
                j.Massless = true
                j.RootPriority = -127
            end
        end
        v2:PivotTo(HumanoidRootPart.CFrame * WispQuests.FollowOffset)
        local Motor6D = Instance.new("Motor6D")
        Motor6D.Name = "WispFollowJoint"
        Motor6D.Part0 = HumanoidRootPart
        Motor6D.Part1 = v2.PrimaryPart
        Motor6D.C0 = WispQuests.FollowOffset
        Motor6D.Parent = v2.PrimaryPart
        local ClickDetector = Instance.new("ClickDetector")
        ClickDetector.MaxActivationDistance = 24
        ClickDetector.Parent = v2
        v2.Parent = Character
        bindCompanion(v2)
        return
    end
    if WispCompanion then
        WispCompanion:Destroy()
    end
end

local function watchCharacter(a1) -- Line: 655
    -- upvalues: u81 (val), u97 (ref), TutorialBeam (val), Tabs (val), LocalPlayer (val), syncCompanion (val)
    u81.Close()
    if u97 then
        TutorialBeam.Destroy(u97)
        u97 = nil
    end
    if Tabs.IsActive("WispCompanion") then
        Tabs.Deactivate({instant = true})
    end
    task.spawn(function() -- Line: 659 -- upvalues: a1 (val), LocalPlayer (upval), syncCompanion (upval)
        local HumanoidRootPart = a1:WaitForChild("HumanoidRootPart", 15)
        local Humanoid = a1:WaitForChild("Humanoid", 15)
        if LocalPlayer.Character == a1 and HumanoidRootPart and Humanoid then
            Humanoid.Died:Once(syncCompanion)
            syncCompanion()
            return
        end
    end)
end

function v1.Start() -- Line: 668
    -- upvalues: syncSpawn (val), u84 (ref), GUI (val), u85 (ref), u89 (ref), u90 (ref), ButtonFX (val), u93 (ref)
    -- upvalues: u114 (ref), u81 (val), u92 (ref), Tabs (val), guide (val), WispProgression (val)
    -- upvalues: startFinishedDialogue (val), acceptWisp (val), Save (val), WispCompanion (val), syncCompanion (val)
    -- upvalues: u125 (ref), updateWorld (val), ProximityPromptService (val), LocalPlayer (val), u104 (ref), u96 (ref)
    -- upvalues: returnWisp (val), u113 (val), openCompanion (val), u108 (val), UserInputService (val)
    -- upvalues: watchCharacter (val), u97 (ref), TutorialBeam (val), RunService (val), u107 (ref), nearSpawn (val)
    -- upvalues: u100 (ref), u103 (ref), u102 (ref), u106 (ref), u105 (ref), updateCompanionPrompt (val), u109 (val)
    -- upvalues: WispQuests (val), u111 (val), u112 (val), u110 (val), u94 (ref), u101 (ref), u99 (ref), u98 (val)
    -- upvalues: u95 (ref)
    syncSpawn()
    u84 = GUI.Get("WispCompanion")
    u85 = u84.Frame
    u89 = u85.ContentFrame.QuestHolder
    u90 = u85.ContentFrame.ProgressionHolder.ContentHolder
    ButtonFX(u85.ReturnButton_Ready, 1.025, function() -- Line: 674
        -- upvalues: u93 (upval), u114 (upval), u81 (upval), u92 (upval), Tabs (upval), guide (upval)
        -- upvalues: WispProgression (upval), startFinishedDialogue (upval), acceptWisp (upval)
        if not u93 and not u114 and not u81.IsPlaying() then
            if u92.Returning then
                Tabs.Deactivate()
                guide()
                return
            end
            if WispProgression.IsReady(u92) then
                startFinishedDialogue()
                return
            end
            if not u92.Accepted then
                acceptWisp()
            end
            return
        end
    end)
    Save.WatchFields("WispCompanion", function() -- Line: 685
        -- upvalues: Save (upval), u92 (upval), WispCompanion (upval), syncCompanion (upval), syncSpawn (upval)
        -- upvalues: u125 (upval), updateWorld (upval)
        local v1 = Save.Peek()
        u92 = if not v1 then WispCompanion.Blank() else if not v1.WispCompanion then WispCompanion.Blank() else v1.WispCompanion
        syncCompanion()
        syncSpawn()
        u125()
        updateWorld()
    end)
    Save.WatchFields("SpeedPower", syncSpawn)
    ;(workspace.World.Build:GetAttributeChangedSignal("EnchantedForestZoneRevealed")):Connect(syncSpawn)

    local function spawnChanged(a1) -- Line: 696 -- upvalues: syncSpawn (upval)
        if a1.Name == "EnchantedForestZone" or a1.Name == "WispSpawn" or a1.Name == "WispVisual" then
            task.defer(syncSpawn)
        end
    end

    workspace.World.Build.DescendantAdded:Connect(spawnChanged)
    workspace.World.Build.DescendantRemoving:Connect(spawnChanged)
    task.spawn(function() -- Line: 703
        -- upvalues: Save (upval), u92 (upval), WispCompanion (upval), syncCompanion (upval), syncSpawn (upval)
        -- upvalues: u125 (upval), updateWorld (upval)
        Save.Await()
        local v1 = Save.Peek()
        u92 = if not v1 then WispCompanion.Blank() else if not v1.WispCompanion then WispCompanion.Blank() else v1.WispCompanion
        syncCompanion()
        syncSpawn()
        u125()
        updateWorld()
    end)
    ProximityPromptService.PromptTriggered:Connect(function(a1, a2) -- Line: 707
        -- upvalues: LocalPlayer (upval), u104 (upval), acceptWisp (upval), u96 (upval), u92 (upval), returnWisp (upval)
        -- upvalues: u113 (upval), openCompanion (upval)
        if a2 ~= LocalPlayer then
            return
        end
        if a1 == u104 then
            acceptWisp()
            return
        end
        if a1 == u96 then
            if not u92.Returning then
                return
            end
            returnWisp()
            return
        end
        for i, j in u113 do
            if a1 == j.Prompt then
                openCompanion()
                return
            end
        end
    end)

    local function tapCompanion(a1) -- Line: 724 -- upvalues: LocalPlayer (upval), u108 (upval), openCompanion (upval)
        local Character = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("WispCompanion")
        local CurrentCamera = workspace.CurrentCamera
        if Character and CurrentCamera and u108[Character] then
            local v1 = CurrentCamera:ScreenPointToRay(a1.X, a1.Y)
            local v2 = RaycastParams.new()
            v2.FilterType = Enum.RaycastFilterType.Include
            v2.FilterDescendantsInstances = {Character}
            if workspace:Raycast(v1.Origin, v1.Direction * 1000, v2) then
                openCompanion()
            end
            return
        end
    end

    UserInputService.InputEnded:Connect(function(a1, a2) -- Line: 736 -- upvalues: tapCompanion (val)
        if not a2 and a1.UserInputType == Enum.UserInputType.MouseButton1 then
            tapCompanion(a1.Position)
        end
    end)
    UserInputService.TouchTapInWorld:Connect(function(a1, a2) -- Line: 741 -- upvalues: tapCompanion (val)
        if not a2 then
            tapCompanion(a1)
        end
    end)
    LocalPlayer.CharacterAdded:Connect(watchCharacter)
    LocalPlayer.CharacterRemoving:Connect(function(a1) -- Line: 746 -- upvalues: u81 (upval), u97 (upval), TutorialBeam (upval)
        local WispCompanion = a1:FindFirstChild("WispCompanion")
        if WispCompanion then
            WispCompanion:Destroy()
        end
        u81.Close()
        if u97 then
            TutorialBeam.Destroy(u97)
            u97 = nil
        end
    end)
    if LocalPlayer.Character then
        watchCharacter(LocalPlayer.Character)
    end
    RunService:BindToRenderStep("WispCompanionFollow", Enum.RenderPriority.Character.Value + 1, function(a1) -- Line: 753
        -- upvalues: u107 (upval), Save (upval), nearSpawn (upval), u81 (upval), u100 (upval), u92 (upval), u103 (upval)
        -- upvalues: u102 (upval), u106 (upval), u105 (upval), u104 (upval), u93 (upval), u114 (upval), u113 (upval)
        -- upvalues: updateCompanionPrompt (upval), u108 (upval), u109 (upval), WispQuests (upval), u111 (upval)
        -- upvalues: u112 (upval), u110 (upval)
        local CFrame_3, Magnitude, Magnitude_4, Part0, Rotation, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13
        local v14 = u107
        if v14 then
            v8 = Save.Peek()
            local WispCompanion = v8 and v8.WispCompanion
            v14 = false
            if WispCompanion ~= nil then
                v14 = not WispCompanion.Accepted and not WispCompanion.Unlocked and workspace.World.Build:GetAttribute("EnchantedForestZoneRevealed") == true
            end
            if v14 then
                v14 = nearSpawn()
            end
        end
        u81.Tick(not u100 and (v14 or u92.Accepted and not u92.Unlocked))
        if u107 and not u81.IsPlaying() then
            u107 = false
        end
        local ServerTimeNow = workspace:GetServerTimeNow()
        if u103 and u102 then
            v8 = u102
            v10 = workspace
            if v8:IsDescendantOf(v10) then
                v8 = Vector3.new(0, u102.Size.Y * 0.5 + math.sin(ServerTimeNow * 2) * 0.3, 0)
                u103:PivotTo(u102.CFrame * (CFrame.new(u106 + v8)))
                u105.Enabled = not u81.IsPlaying()
                v9 = u104
                v8 = Save.Peek()
                local WispCompanion_2 = v8 and v8.WispCompanion
                v10 = false
                if WispCompanion_2 ~= nil then
                    v10 = not WispCompanion_2.Accepted and not WispCompanion_2.Unlocked and workspace.World.Build:GetAttribute("EnchantedForestZoneRevealed") == true
                end
                if v10 then
                    v10 = nearSpawn() and not u93 and not u100 and not u114 and not u81.IsPlaying()
                end
                v9.Enabled = v10
            end
        end
        for i, j in u113 do
            updateCompanionPrompt(j.Prompt)
            if j.Claim.Enabled then
                v11 = (1 - math.cos(ServerTimeNow * 3.141592653589793)) * 0.5
                j.Claim.OpenMenu.TextTransparency = v11
                j.Claim.OpenMenu.TextStrokeTransparency = v11
            end
        end
        v9 = nil
        v10 = nil
        for k, n in u108, v9, v10 do
            if n.Parent and n.Part0 then
                Part0 = n.Part0
                v12 = u109[k]
                v13 = Part0.Position + Vector3.new(0, WispQuests.FollowOffset.Y, 0)
                Magnitude = (v12.Position - v13).Magnitude
                v1 = u111[k]
                v2 = if not v1 then Vector3.new(0, 0, 0) else Part0.Position - v1
                v4 = math.max(120, Part0.AssemblyLinearVelocity.Magnitude * a1 * 2 + 20)
                v3 = v1 and v4 < v2.Magnitude
                u111[k] = Part0.Position
                if not v3 then
                    if WispQuests.FollowStartRadius < Magnitude then
                        u110[k] = true
                    elseif Magnitude <= WispQuests.FollowRadius + 0.05 then
                        u110[k] = false
                    end
                    if u110[k] then
                        v1 = v12 + v2
                        v5 = (Vector3.new(v2.X, 0, v2.Z)).Magnitude / (math.max(a1, 0.001))
                        v6 = math.clamp(
                            WispQuests.FollowRadius + v5 * WispQuests.FollowTrailSeconds,
                            WispQuests.FollowRadius,
                            WispQuests.FollowMaxDistance
                        )
                        Magnitude_4 = v2.Magnitude
                        if math.max(0.02, a1) < Magnitude_4 then
                            u112[k] = Part0.CFrame.Rotation
                        end
                        v5 = (CFrame.new(Part0.Position)) * u112[k] * CFrame.new(WispQuests.FollowOffset.X, WispQuests.FollowOffset.Y, v6)
                        v6 = v13 - v1.Position
                        v7 = Vector3.new(v6.X, 0, v6.Z)
                        Rotation = if not (0.001 < v7.Magnitude) then v12.Rotation else CFrame.lookAt(Vector3.new(0, 0, 0), v7)
                        if ((v1:Lerp(CFrame.new(v5.Position) * Rotation, 1 - math.exp(-WispQuests.FollowResponse * (math.min(a1, 0.1))))).Position - v13).Magnitude <= WispQuests.FollowRadius + 0.05 then
                            u110[k] = false
                        end
                    end
                else
                    v12 = Part0.CFrame * WispQuests.FollowOffset
                    u112[k] = Part0.CFrame.Rotation
                    u110[k] = false
                end
                u109[k] = v12
                v3 = ServerTimeNow * 2 + (k:GetAttribute("OwnerUserId") or 0) % 13
                v2 = (CFrame.new(0, math.sin(v3) * 0.3, 0)) * CFrame.Angles(0, math.sin(v3 * 0.7) * 0.14, math.sin(v3) * 0.07)
                CFrame_3 = Part0.CFrame
                v7 = v12 * v2
                n.C0 = CFrame_3:ToObjectSpace(v7)
            end
        end
    end)
    task.spawn(function() -- Line: 820
        -- upvalues: syncSpawn (upval), u94 (upval), u101 (upval), u99 (upval), u98 (upval), u95 (upval), u96 (upval)
        -- upvalues: updateWorld (upval)
        local EnchantedForestZone, Zone13Props, v1
        while true do
            syncSpawn()
            EnchantedForestZone = workspace.World.Build:FindFirstChild("EnchantedForestZone")
            Zone13Props = EnchantedForestZone and EnchantedForestZone:FindFirstChild("Zone13Props")
            v1 = Zone13Props and Zone13Props:FindFirstChild("EnchantedTree")
            if v1 and v1:FindFirstChild("WispAnchor") then
                if u94 ~= v1 then
                    if u101 then
                        u101:Destroy()
                        u101 = nil
                    end
                    u94 = v1
                    u99 = false
                    table.clear(u98)
                end
                u95 = v1.WispAnchor
                u95:FindFirstChild("WispTreePrompt")
                updateWorld()
            end
            task.wait(0.5)
        end
    end)
    u125()
end

return v1