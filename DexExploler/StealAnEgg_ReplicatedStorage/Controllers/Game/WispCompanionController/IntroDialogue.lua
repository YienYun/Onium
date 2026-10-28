-- Script path: ReplicatedStorage.Controllers.Game.WispCompanionController.IntroDialogue
-- Decompile time: 3.58 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Tabs = require(ReplicatedStorage.Client.Tabs)
local MessageTyper = require(ReplicatedStorage.Client.UI.MessageTyper)
local Talk_UI = ReplicatedStorage.Assets.UI.Npcs.Talk_UI
local LocalPlayer = Players.LocalPlayer
return {
    new = function() -- Line: 10 -- upvalues: Talk_UI (val), LocalPlayer (val), MessageTyper (val), Tabs (val)
        local u0 = {}
        local u1 = nil

        local function display() -- Line: 13 -- upvalues: u1 (ref), Talk_UI (upval)
            local v1 = u1.Lines[u1.Index]
            local Size = Talk_UI.Size
            u1.Bubble.Size = UDim2.new(Size.X.Scale, Size.X.Offset, Size.Y.Scale * (if not (#v1 > 45) then 1 else 2), Size.Y.Offset)
            local v2 = u1
            local v3 = os.clock()
            local v4 = utf8.len(v1) or #v1
            v2.NextAt = v3 + v4 * 0.06 + math.max(2.6, #v1 * 0.05)
            u1.Typer:Type(v1, u1.Label.TextColor3)
        end

        function u0.Close() -- Line: 20 -- upvalues: u1 (ref)
            local v1 = u1
            u1 = nil
            if not v1 then
                return
            end
            v1.Typer:Halt()
            v1.Bubble:Destroy()
            v1.Anchor:Destroy()
        end

        function u0.Start(a1, a2, a3) -- Line: 28
            -- upvalues: u0 (val), Talk_UI (upval), LocalPlayer (upval), u1 (ref), MessageTyper (upval), display (val)
            u0.Close()
            local PrimaryPart = a1 and a1.PrimaryPart
            if PrimaryPart and #a2 ~= 0 and a1:IsDescendantOf(workspace) then
                local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
                local Attachment = Instance.new("Attachment")
                Attachment.Name = "WispDialoguePoint"
                Attachment.Position = PrimaryPart.CFrame:PointToObjectSpace(BoundingBox.Position + (Vector3.new(0, BoundingBox_2.Y / 2, 0)))
                Attachment.Parent = PrimaryPart
                local v1 = Talk_UI:Clone()
                v1.Name = "WispDialogue"
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
                    Anchor = Attachment,
                    Bubble = v1,
                    Label = TextLabel,
                    Typer = MessageTyper.new(TextLabel, nil, 0.06, false),
                    Finished = a3,
                    Lines = a2,
                }
                display()
                return true
            end
            return false
        end

        function u0.IsPlaying() -- Line: 60 -- upvalues: u1 (ref)
            return u1 ~= nil
        end

        function u0.Tick(a1) -- Line: 63 -- upvalues: u1 (ref), LocalPlayer (upval), u0 (val), display (val)
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
                and u1.Anchor.Parent
                and not (35 < (HumanoidRootPart.Position - u1.Anchor.WorldPosition).Magnitude) then
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
            u0.Close()
        end

        local u12 = Tabs.Activated:Connect(u0.Close)

        function u0.Destroy() -- Line: 86 -- upvalues: u0 (val), u12 (val)
            u0.Close()
            u12:Disconnect()
        end

        return u0
    end,
}