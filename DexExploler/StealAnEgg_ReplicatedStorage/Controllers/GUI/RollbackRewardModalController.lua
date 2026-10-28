-- Script path: ReplicatedStorage.Controllers.GUI.RollbackRewardModalController
-- Decompile time: 1.81 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
return {
    Start = function() -- Line: 18 -- upvalues: GUI (val), Remotes (val)
        local u2 = GUI.RollbackReward()
        local Main = u2.Main
        local Close = Main.Close
        local Contents = Main.Contents
        local Ok = Contents.Ok
        local Title = Contents.Title
        local Description = Contents.Description
        local ImageHolder = Contents.ImageHolder
        local ImageLabel = ImageHolder.ImageLabel

        local function hideModal() -- Line: 34 -- upvalues: u2 (val)
            u2.Enabled = false
        end

        local function showNotice(a1, a2, a3, a4) -- Line: 36
            -- upvalues: Title (val), Description (val), ImageLabel (val), ImageHolder (val), u2 (val)
            Title.Text = a1 or ""
            Description.Text = a2 or ""
            ImageLabel.Image = a3 or ""
            local UIGradient = ImageHolder:FindFirstChildOfClass("UIGradient")
            if UIGradient then
                UIGradient:Destroy()
            end
            if a4 then
                local v1 = a4:Clone()
                v1.Parent = ImageHolder
            end
            u2.Enabled = true
        end

        u2.Enabled = false
        GUI.OnActivated(Close, function() -- Line: 65 -- upvalues: u2 (val)
            u2.Enabled = false
        end)
        GUI.OnActivated(Ok, function() -- Line: 66 -- upvalues: u2 (val)
            u2.Enabled = false
        end)
        Remotes.RollbackRewards.ShowNotice.OnClientEvent:Connect(function(a1, a2, a3, a4) -- Line: 69
            -- upvalues: Title (val), Description (val), ImageLabel (val), ImageHolder (val), u2 (val)
            local v1 = nil
            if typeof(a4) == "Instance" and a4:IsA("UIGradient") then
                v1 = a4
            end
            Title.Text = a1 or ""
            Description.Text = a2 or ""
            ImageLabel.Image = a3 or ""
            local UIGradient = ImageHolder:FindFirstChildOfClass("UIGradient")
            if UIGradient then
                UIGradient:Destroy()
            end
            if v1 then
                local v2 = v1:Clone()
                v2.Parent = ImageHolder
            end
            u2.Enabled = true
        end)
    end,
}