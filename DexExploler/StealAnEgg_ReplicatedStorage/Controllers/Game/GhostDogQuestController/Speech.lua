-- Script path: ReplicatedStorage.Controllers.Game.GhostDogQuestController.Speech
-- Decompile time: 8.03 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Fx = require(script.Parent.Fx)
local MessageTyper = require(ReplicatedStorage.Client.UI.MessageTyper)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u35 = {
    [Enum.KeyCode.E] = true,
    [Enum.KeyCode.ButtonX] = true,
    [Enum.KeyCode.Return] = true,
    [Enum.KeyCode.Space] = true,
}
local BuddyChatter1 = ReplicatedStorage.Assets.ShootingStar.Sounds.BuddyChatter1
local u48 = nil
local u49 = {}

local function template() -- Line: 44 -- upvalues: ReplicatedStorage (val)
    local Talk_UI = ReplicatedStorage.Assets.UI.Npcs:FindFirstChild("Talk_UI")
    if Talk_UI ~= nil and Talk_UI:IsA("BillboardGui") then
        return Talk_UI
    end
    return nil
end

local function topOf(a1) -- Line: 49 -- types: a1: userdata
    local v1 = a1.Position.Y + a1.Size.Y * 0.5
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            v1 = math.max(v1, j.Position.Y + j.Size.Y * 0.5)
        end
    end
    return v1
end

function u49.Stop() -- Line: 59 -- upvalues: u48 (ref)
    local v1 = u48
    u48 = nil
    if v1 then
        v1:Destroy()
    end
end

function u49.IsTalking() -- Line: 67 -- upvalues: u48 (ref)
    return u48 ~= nil
end

function u49.Say(a1, a2, a3, a4) -- Line: 71
    -- upvalues: u49 (val), LocalPlayer (val), ReplicatedStorage (val), Trove (val), u48 (ref), topOf (val)
    -- upvalues: MessageTyper (val), BuddyChatter1 (val), Fx (val), UserInputService (val), u35 (val), RunService (val)
    u49.Stop()
    local u8 = a4
    if not u8 then
        u8 = {}
    end
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local Talk_UI = ReplicatedStorage.Assets.UI.Npcs:FindFirstChild("Talk_UI")
    local v1 = if Talk_UI == nil then nil else if not Talk_UI:IsA("BillboardGui") then nil else Talk_UI
    if PlayerGui ~= nil and v1 ~= nil and #a3 ~= 0 then
        local v2 = Trove.new()
        u48 = v2
        local Position = a1:GetPivot().Position
        local u50 = v2:Add((Instance.new("Attachment")))
        u50.Name = "GhostDogSpeech"
        u50.Parent = a2
        u50.WorldPosition = Vector3.new(Position.X, topOf(a2) + 0.6, Position.Z)
        local u69 = v2:Add((v1:Clone()))
        u69.Name = "GhostDogSpeech"
        u69.Adornee = u50
        u69.MaxDistance = 80
        u69.Enabled = true
        u69.Parent = PlayerGui
        local v3 = u69:FindFirstChildOfClass("TextLabel")
        local UIScale = u69:FindFirstChildOfClass("UIScale")
        if v3 == nil then
            v2:Destroy()
            u48 = nil
            return false
        end
        v3.Text = ""
        local Tint = u8.Tint
        if not Tint then
            Tint = v3.TextColor3
        end
        local u108 = MessageTyper.new(v3, nil, 0.035, u8.Clicks ~= false)
        v2:Add(function() -- Line: 107 -- upvalues: u108 (val)
            u108:Halt()
        end)
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "Next"
        TextLabel.BackgroundTransparency = 1
        TextLabel.AnchorPoint = Vector2.new(1, 1)
        TextLabel.Position = UDim2.fromScale(0.98, 1.05)
        TextLabel.Size = UDim2.fromScale(0.08, 0.35)
        TextLabel.TextScaled = true
        TextLabel.Text = "▶"
        TextLabel.TextColor3 = Tint
        TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
        TextLabel.Visible = false
        TextLabel.ZIndex = v3.ZIndex + 1
        TextLabel.Parent = v3
        local Size = v1.Size
        local u147 = 0
        local u148 = 0
        local u149 = 0
        local u150 = false
        local u151 = false
        local Voice = u8.Voice
        if not Voice then
            Voice = {BuddyChatter1}
        end
        local u156 = 0

        local function show() -- Line: 132
            -- upvalues: a3 (val), u147 (ref), u69 (val), Size (val), u149 (ref), u148 (ref), u108 (val), Tint (val)
            -- upvalues: UIScale (val), Fx (upval), Voice (val), u156 (ref), a2 (val), u8 (val)
            local v1 = a3[u147]
            u69.Size = UDim2.new(
                Size.X.Scale,
                Size.X.Offset,
                Size.Y.Scale * (if not (#v1 > 84) then if not (#v1 > 42) then 1 else 2 else 3),
                Size.Y.Offset
            )
            local v2 = os.clock()
            local v3 = utf8.len(v1) or #v1
            u149 = v2 + v3 * 0.035
            u148 = u149 + math.max(2.5, #v1 * 0.06)
            u108:Type(v1, Tint)
            if UIScale then
                Fx.Punch(UIScale, 1.15, 0.25)
            end
            local v4 = math.random(1, #Voice)
            if #Voice > 1 and v4 == u156 then
                v4 = v4 % #Voice + 1
            end
            u156 = v4
            Fx.PlayAt(Voice[v4], a2, {Looped = false, PlaybackSpeed = 0.95 + math.random() * 0.15})
            if u8.OnLine then
                task.spawn(u8.OnLine, u147)
            end
        end

        local function advance() -- Line: 161
            -- upvalues: u149 (ref), u108 (val), a3 (val), u147 (ref), Tint (val), u148 (ref), u150 (ref), u151 (ref)
            -- upvalues: show (val)
            if os.clock() < u149 then
                os.clock()
                u108:ShowAll(a3[u147], Tint)
                u148 = os.clock() + 1.2
                return
            end
            local v1 = u147
            if #a3 <= v1 then
                u150 = true
                u151 = true
                return
            end
            u147 = u147 + 1
            show()
        end

        local u181 = {}
        v2:Connect(UserInputService.InputBegan, function(a1, a2) -- Line: 178 -- upvalues: u35 (upval), advance (val), u181 (val) -- types: a1: userdata, a2: boolean
            if a2 then
                return
            end
            if u35[a1.KeyCode] then
                advance()
                return
            end
            if a1.UserInputType == Enum.UserInputType.Touch then
                u181[a1] = {At = os.clock(), Position = a1.Position}
            end
        end)
        v2:Connect(UserInputService.InputEnded, function(a1) -- Line: 188 -- upvalues: u181 (val), advance (val) -- types: a1: userdata
            local v1 = u181[a1]
            if v1 == nil then
                return
            end
            u181[a1] = nil
            if os.clock() - v1.At <= 0.25 and (a1.Position - v1.Position).Magnitude <= 12 then
                advance()
            end
        end)
        v2:Connect(RunService.Heartbeat, function() -- Line: 201
            -- upvalues: u150 (ref), u8 (val), LocalPlayer (upval), u50 (val), TextLabel (val), u149 (ref), u148 (ref)
            -- upvalues: advance (val)
            if u150 then
                return
            end
            local WalkAway = u8.WalkAway
            if WalkAway then
                local Character = LocalPlayer.Character
                local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                if HumanoidRootPart
                    and HumanoidRootPart:IsA("BasePart")
                    and WalkAway < (HumanoidRootPart.Position - u50.WorldPosition).Magnitude then
                    u150 = true
                    return
                end
            end
            local v1 = os.clock()
            TextLabel.Visible = u149 <= v1
            TextLabel.Position = UDim2.fromScale(0.98, math.abs((math.sin((os.clock()) * 6))) * 0.08 + 1.05)
            local v2 = os.clock()
            if u148 <= v2 then
                advance()
            end
        end)
        show()
        while not u150 do
            if u48 ~= v2 then
                break
            end
            task.wait()
        end
        if u48 == v2 then
            u48 = nil
            v2:Destroy()
        end
        return u151
    end
    return false
end

return (table.freeze(u49))