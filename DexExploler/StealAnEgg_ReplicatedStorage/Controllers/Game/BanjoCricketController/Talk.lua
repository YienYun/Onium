-- Script path: ReplicatedStorage.Controllers.Game.BanjoCricketController.Talk
-- Decompile time: 9.11 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local BanjoCricket = require(ReplicatedStorage.Data.BanjoCricket)
local BanjoCricketFlags = require(ReplicatedStorage.Shared.Flags.BanjoCricketFlags)
local MessageTyper = require(ReplicatedStorage.Client.UI.MessageTyper)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u60 = Color3.fromRGB(255, 85, 85)
local LocalPlayer = Players.LocalPlayer
local Talk_UI = ReplicatedStorage.Assets.UI.Npcs.Talk_UI
local u66 = {}
local u67 = nil
local u68 = false
local u69 = false
local u70 = false
local v1 = {}

local function isAvailable() -- Line: 56 -- upvalues: BanjoCricketFlags (val), u68 (ref)
    return BanjoCricketFlags.Enabled:Get() and u68
end

local function close() -- Line: 60 -- upvalues: u67 (ref)
    local v1 = u67
    if v1 == nil then
        return
    end
    u67 = nil
    v1.Trove:Destroy()
end

local function show(a1) -- Line: 69 -- upvalues: Talk_UI (val) -- types: a1: table
    local v1 = a1.Lines[a1.Index]
    local Size = Talk_UI.Size
    local v2 = if not (#v1 > 45) then 1 else 2
    a1.Bubble.Size = UDim2.new(Size.X.Scale, Size.X.Offset, Size.Y.Scale * v2, Size.Y.Offset)
    local v3 = os.clock()
    local v4 = utf8.len(v1) or #v1
    a1.NextAt = v3 + v4 * 0.06 + math.max(2.6, #v1 * 0.05)
    a1.Typer:Type(v1, a1.Label.TextColor3)
end

local function claim() -- Line: 85 -- upvalues: u70 (ref), Remotes (val), Toast (val), u60 (val)
    if u70 then
        return
    end
    u70 = true
    local success, err, v1 = pcall(function() -- Line: 90 -- upvalues: Remotes (upval)
        return Remotes.BanjoCricket.AskClaim:InvokeServer()
    end)
    u70 = false
    if success and err == true then
        return
    end
    Toast.Show({
        Seconds = 3,
        Text = if not success then "Something went wrong, try again." else if typeof(v1) ~= "string" then "Something went wrong, try again." else v1,
        Color = u60,
    })
end

local function advance() -- Line: 106 -- upvalues: u67 (ref), LocalPlayer (val), Workspace (val), show (val)
    local v1 = u67
    if v1 == nil then
        return
    end
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    if HumanoidRootPart ~= nil
        and HumanoidRootPart:IsA("BasePart")
        and Humanoid ~= nil
        and not (Humanoid.Health <= 0)
        and v1.Npc:IsDescendantOf(Workspace) then
        local Magnitude = (HumanoidRootPart.Position - v1.Anchor.WorldPosition).Magnitude
        if not (v1.Prompt.MaxActivationDistance + 8 < Magnitude) then
            if os.clock() < v1.NextAt then
                return
            end
            if v1.Index < #v1.Lines then
                v1.Index = v1.Index + 1
                show(v1)
                return
            end
            local Finished = v1.Finished
            local v2 = u67
            if v2 ~= nil then
                u67 = nil
                v2.Trove:Destroy()
            end
            task.spawn(Finished)
            return
        end
    end
    local v3 = u67
    if v3 == nil then
        return
    end
    u67 = nil
    v3.Trove:Destroy()
end

local function converse(a1, a2) -- Line: 139
    -- upvalues: u67 (ref), LocalPlayer (val), Trove (val), Talk_UI (val), MessageTyper (val), BanjoCricketFlags (val)
    -- upvalues: u68 (ref), u69 (ref), BanjoCricket (val), claim (val), RunService (val), advance (val), show (val)
    local v1 = u67
    if v1 ~= nil then
        u67 = nil
        v1.Trove:Destroy()
    end
    local PrimaryPart = a1.PrimaryPart
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if PrimaryPart ~= nil and PlayerGui ~= nil then
        local v2 = Trove.new()
        local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
        local v3 = v2:Add((Instance.new("Attachment")))
        v3.Name = "BanjoCricketSpeech"
        v3.Position = PrimaryPart.CFrame:PointToObjectSpace(BoundingBox.Position + (Vector3.new(0, BoundingBox_2.Y / 2, 0)))
        v3.Parent = PrimaryPart
        local v4 = v2:Add((Talk_UI:Clone()))
        v4.Name = "BanjoCricketSpeech"
        v4.Adornee = v3
        v4.MaxDistance = 45
        v4.Enabled = true
        v4.Parent = PlayerGui
        local v5 = v4:FindFirstChildOfClass("TextLabel")
        assert(v5, "Talk_UI needs a TextLabel")
        v5.Text = ""
        local u69_2 = MessageTyper.new(v5, nil, 0.06, false)
        a2.Enabled = false
        v2:Add(function() -- Line: 165 -- upvalues: u69_2 (val), a2 (val), BanjoCricketFlags (upval), u68 (upval)
            u69_2:Halt()
            if a2.Parent ~= nil then
                local v1 = BanjoCricketFlags.Enabled:Get() and u68
                a2.Enabled = v1
            end
        end)
        v1 = {Index = 1, NextAt = 0, Npc = a1, Prompt = a2}
        local Encore = if not u69 then BanjoCricket.Lines.Reward else BanjoCricket.Lines.Encore
        v1.Lines = Encore
        v1.Anchor = v3
        v1.Bubble = v4
        v1.Label = v5
        v1.Typer = u69_2
        v1.Finished = if not u69 then claim else function() end
        v1.Trove = v2
        u67 = v1
        v2:Connect(RunService.Heartbeat, advance)
        show(v1)
        return
    end
end

local function promptParent(a1) -- Line: 191 -- upvalues: BanjoCricket (val) -- types: a1: userdata
    local v1 = a1:FindFirstChild(BanjoCricket.InteractionPoint, true)
    if v1 and v1:IsA("Attachment") then
        return v1
    end
    return a1.PrimaryPart
end

local function refreshPrompts() -- Line: 199 -- upvalues: BanjoCricketFlags (val), u68 (ref), u66 (val), u67 (ref)
    local v1
    local v2 = BanjoCricketFlags.Enabled:Get() and u68
    local v3 = nil
    local v4 = nil
    for i, j in u66, v3, v4 do
        v1 = u67
        if v1 == nil or v1.Prompt ~= j then
            j.Enabled = v2
        end
    end
end

local function bind(a1) -- Line: 209
    -- upvalues: u66 (val), Workspace (val), BanjoCricket (val), BanjoCricketFlags (val), u68 (ref), u67 (ref)
    -- upvalues: converse (val)
    if not u66[a1] and a1:IsA("Model") then
        local v1 = Workspace
        if a1:IsDescendantOf(v1) then
            local PrimaryPart
            local v2 = a1:FindFirstChild(BanjoCricket.InteractionPoint, true)
            if (if not v2 then a1.PrimaryPart else if not v2:IsA("Attachment") then a1.PrimaryPart else v2) == nil then
                return
            end
            local ProximityPrompt = Instance.new("ProximityPrompt")
            ProximityPrompt.Name = "BanjoCricketTalk"
            ProximityPrompt.ActionText = "Talk"
            ProximityPrompt.ObjectText = BanjoCricket.NpcDisplayName
            ProximityPrompt.HoldDuration = 0
            ProximityPrompt.MaxActivationDistance = BanjoCricket.TalkDistance
            ProximityPrompt.RequiresLineOfSight = false
            ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
            v1 = BanjoCricketFlags.Enabled:Get() and u68
            ProximityPrompt.Enabled = v1
            ProximityPrompt.Parent = PrimaryPart
            u66[a1] = ProximityPrompt
            ProximityPrompt.Triggered:Connect(function() -- Line: 233 -- upvalues: u67 (upval), converse (upval), a1 (val), ProximityPrompt (val)
                if u67 == nil then
                    converse(a1, ProximityPrompt)
                end
            end)
            return
        end
    end
end

local function unbind(a1) -- Line: 240 -- upvalues: u66 (val), u67 (ref) -- types: a1: userdata
    local v1 = u66[a1]
    if v1 == nil then
        return
    end
    u66[a1] = nil
    local v2 = u67
    if v2 and v2.Npc == a1 then
        local v3 = u67
        if v3 ~= nil then
            u67 = nil
            v3.Trove:Destroy()
        end
    end
    v1:Destroy()
end

function v1.Start() -- Line: 253
    -- upvalues: BanjoCricket (val), CollectionService (val), bind (val), unbind (val), BanjoCricketFlags (val)
    -- upvalues: refreshPrompts (val), Tabs (val), close (val)
    local Npc = BanjoCricket.Tags.Npc
    ;(CollectionService:GetInstanceAddedSignal(Npc)):Connect(bind)
    ;(CollectionService:GetInstanceRemovedSignal(Npc)):Connect(unbind)
    for i, j in CollectionService:GetTagged(Npc) do
        bind(j)
    end
    BanjoCricketFlags.Enabled.Changed:Connect(refreshPrompts)
    Tabs.Activated:Connect(close)
end

function v1.Sync(a1, a2) -- Line: 264
    -- upvalues: u68 (ref), u69 (ref), BanjoCricketFlags (val), u66 (val), u67 (ref)
    local v1
    u69 = a2
    local v2 = BanjoCricketFlags.Enabled:Get() and a1
    local v3 = nil
    local v4 = nil
    for i, j in u66, v3, v4 do
        v1 = u67
        if v1 == nil or v1.Prompt ~= j then
            j.Enabled = v2
        end
    end
end

return (table.freeze(v1))