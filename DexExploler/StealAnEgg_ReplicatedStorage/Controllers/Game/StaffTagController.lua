-- Script path: ReplicatedStorage.Controllers.Game.StaffTagController
-- Decompile time: 3.44 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Staff = require(ReplicatedStorage.Shared.Modules.Staff)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
return {
    Start = function() -- Line: 26
        -- upvalues: LocalPlayer (val), ReplicatedStorage (val), Staff (val), Trove (val), RunService (val)
        -- upvalues: Players (val)
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        local StaffTag = ReplicatedStorage.Assets.Billboards:WaitForChild("StaffTag")
        local u12 = {}
        local u13 = {}

        local function tagCharacter(a1, a2, a3) -- Line: 33
            -- upvalues: StaffTag (val), Staff (upval), u13 (val), PlayerGui (val)
            local Head = a1:WaitForChild("Head", 10)
            if Head ~= nil and Head:IsA("BasePart") and a1.Parent ~= nil then
                local v1 = a3:Clone(StaffTag)
                local Label = v1:FindFirstChild("Label")
                if Label == nil or not Label:IsA("TextLabel") then
                    error("Assets.Billboards.StaffTag is missing a TextLabel named Label")
                end
                Label.Text = Staff.OverheadLabel(a2)
                Label.TextColor3 = Color3.new(1, 1, 1)
                local UIGradient = Label:FindFirstChildOfClass("UIGradient")
                if not UIGradient then
                    UIGradient = Instance.new("UIGradient")
                end
                UIGradient.Name = "Sheen"
                UIGradient.Color = Staff.GradientOf(a2)
                UIGradient.Parent = Label
                u13[UIGradient] = true
                a3:Add(function() -- Line: 57 -- upvalues: u13 (upval), UIGradient (val)
                    u13[UIGradient] = nil
                end)
                v1.Name = ("StaffTag_%*"):format(a1.Name)
                v1.Adornee = Head
                v1.Enabled = true
                v1.Parent = PlayerGui
                return
            end
        end

        local function trackPlayer(a1) -- Line: 67
            -- upvalues: u12 (val), Trove (upval), Staff (upval), tagCharacter (val)
            if u12[a1] then
                return
            end
            local v1 = Trove.new()
            local u8 = v1:Extend()
            u12[a1] = v1

            local function onCharacter(a1_2) -- Line: 77
                -- upvalues: u8 (val), a1 (val), Staff (upval), tagCharacter (upval)
                u8:Clean()
                local Attribute = a1:GetAttribute("CreatorDisguiseUserId")
                local v1 = Staff.RoleOf(if typeof(Attribute) ~= "number" then a1.UserId else Attribute)
                if v1 ~= nil then
                    tagCharacter(a1_2, v1, u8)
                end
            end

            v1:Connect(a1.CharacterAdded, onCharacter)
            v1:Connect(a1:GetAttributeChangedSignal("CreatorDisguiseUserId"), function() -- Line: 90 -- upvalues: a1 (val), onCharacter (val)
                if a1.Character then
                    task.spawn(onCharacter, a1.Character)
                end
            end)
            v1:Connect(a1.CharacterRemoving, function() -- Line: 95 -- upvalues: u8 (val)
                u8:Clean()
            end)
            if a1.Character then
                task.spawn(onCharacter, a1.Character)
            end
        end

        RunService.Heartbeat:Connect(function() -- Line: 115 -- upvalues: u13 (val)
            if next(u13) == nil then
                return
            end
            local v1 = Vector2.new(os.clock() % 2.4 / 2.4 * 2 - 1, 0)
            for i in u13 do
                i.Offset = v1
            end
        end)
        for i, j in Players:GetPlayers() do
            trackPlayer(j)
        end
        Players.PlayerAdded:Connect(trackPlayer)
        Players.PlayerRemoving:Connect(function(a1) -- Line: 104 -- upvalues: u12 (val) -- types: a1: userdata
            local v1 = u12[a1]
            if v1 == nil then
                return
            end
            u12[a1] = nil
            v1:Destroy()
        end)
        Staff.Changed:Connect(function() -- Line: 138 -- upvalues: Players (upval), u12 (val), trackPlayer (val)
            local v1
            for i, j in Players:GetPlayers() do
                v1 = u12[j]
                if v1 ~= nil then
                    u12[j] = nil
                    v1:Destroy()
                end
                trackPlayer(j)
            end
        end)
    end,
}