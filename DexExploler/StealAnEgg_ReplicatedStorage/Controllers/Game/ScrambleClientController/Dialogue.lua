-- Script path: ReplicatedStorage.Controllers.Game.ScrambleClientController.Dialogue
-- Decompile time: 4.07 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Tabs = require(ReplicatedStorage.Client.Tabs)
local MessageTyper = require(ReplicatedStorage.Client.UI.MessageTyper)
local Talk_UI = ReplicatedStorage.Assets.UI.Npcs.Talk_UI
local LocalPlayer = Players.LocalPlayer
return {
    new = function() -- Line: 12 -- upvalues: Talk_UI (val), LocalPlayer (val), MessageTyper (val), Tabs (val)
        local u0 = {}
        local u1 = nil

        local function display() -- Line: 15 -- upvalues: u1 (ref), Talk_UI (upval)
            local v1 = u1.Lines[u1.Index]
            local Size = Talk_UI.Size
            u1.Bubble.Size = UDim2.new(Size.X.Scale, Size.X.Offset, Size.Y.Scale * (if not (#v1 > 45) then 1 else 2), Size.Y.Offset)
            local v2 = u1
            local v3 = os.clock()
            local v4 = utf8.len(v1) or #v1
            v2.NextAt = v3 + v4 * 0.03 + math.max(1.3, #v1 * 0.025)
            u1.Typer:Type(v1, u1.Label.TextColor3)
        end

        function u0.Close(a1) -- Line: 23 -- upvalues: u1 (ref) -- types: a1: boolean?
            local v1 = u1
            u1 = nil
            if not v1 then
                return
            end
            v1.Typer:Halt()
            v1.Bubble:Destroy()
            v1.Anchor:Destroy()
            if v1.Prompt.Parent then
                local Prompt = v1.Prompt
                local Enabled = v1.Enabled and a1 ~= false
                Prompt.Enabled = Enabled
            end
        end

        function u0.Start(a1, a2, a3) -- Line: 36
            -- upvalues: u0 (val), Talk_UI (upval), LocalPlayer (upval), u1 (ref), MessageTyper (upval), display (val)
            u0.Close()
            local PrimaryPart = a1.PrimaryPart
            if not PrimaryPart then
                return
            end
            local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
            local Attachment = Instance.new("Attachment")
            Attachment.Name = "ScrambleDialoguePoint"
            Attachment.Position = PrimaryPart.CFrame:PointToObjectSpace(BoundingBox.Position + (Vector3.new(0, BoundingBox_2.Y / 2, 0)))
            Attachment.Parent = PrimaryPart
            local v1 = Talk_UI:Clone()
            v1.Name = "ScrambleDialogue"
            v1.Adornee = Attachment
            v1.MaxDistance = 45
            v1.Enabled = true
            v1.Parent = LocalPlayer.PlayerGui
            local TextLabel = v1.TextLabel
            TextLabel.Text = ""
            u1 = {
                Index = 1,
                NextAt = 0,
                Model = a1,
                Character = LocalPlayer.Character,
                Prompt = a2,
                Enabled = a2.Enabled,
                Anchor = Attachment,
                Bubble = v1,
                Label = TextLabel,
                Typer = MessageTyper.new(TextLabel, nil, 0.03, false),
                Finished = a3,
                Lines = {
                    "SHHH! Don't tell him I'm here!",
                    "I stole this when I escaped his lab...",
                    "But it broke on the way out.",
                    "I lost two of the parts... and his drones took the other three.",
                    "Help me fix it and whatever's inside is yours.",
                },
            }
            a2.Enabled = false
            display()
        end

        function u0.IsPlaying(a1) -- Line: 78 -- upvalues: u1 (ref) -- types: a1: userdata?
            local v1 = false
            if u1 ~= nil then
                v1 = true
                if a1 ~= nil then
                    v1 = u1.Model == a1
                end
            end
            return v1
        end

        function u0.Tick(a1) -- Line: 81
            -- upvalues: u1 (ref), LocalPlayer (upval), u0 (val), display (val)
            if not u1 then
                return
            end
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            if a1
                and Character == u1.Character
                and HumanoidRootPart
                and Humanoid
                and not (Humanoid.Health <= 0)
                and u1.Model:IsDescendantOf(workspace)
                and u1.Prompt.Parent then
                local Magnitude = (HumanoidRootPart.Position - u1.Anchor.WorldPosition).Magnitude
                if not (u1.Prompt.MaxActivationDistance + 8 < Magnitude) then
                    local v1 = os.clock()
                    if u1.NextAt <= v1 then
                        if u1.Index < #u1.Lines then
                            v1 = u1
                            v1.Index = v1.Index + 1
                            display()
                            return
                        end
                        local Finished = u1.Finished
                        u0.Close()
                        Finished()
                    end
                    return
                end
            end
            u0.Close(a1)
        end

        local u12 = Tabs.Activated:Connect(function() -- Line: 112 -- upvalues: u0 (val)
            u0.Close()
        end)

        function u0.Destroy() -- Line: 115 -- upvalues: u0 (val), u12 (val)
            u0.Close()
            u12:Disconnect()
        end

        return u0
    end,
}