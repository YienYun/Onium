-- Script path: ReplicatedStorage.Controllers.Game.ShootingStarController.StarConfirmation
-- Decompile time: 3.55 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
local Assets = require(ReplicatedStorage.Data.Assets)
local GUI = require(ReplicatedStorage.Client.GUI)
local MenuNavigation = require(ReplicatedStorage.Client.MenuNavigation)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
return {
    Resolve = function(a1, a2) -- Line: 16
        -- upvalues: GUI (val), Assets (val), AssetRoster (val), Players (val), Simple (val)
        local ApplyStarPopupConfirmationScreen = GUI.Get("ApplyStarPopupConfirmationScreen")
        local Frame = ApplyStarPopupConfirmationScreen:FindFirstChild("Frame")
        assert(Frame and Frame:IsA("GuiObject"), "Star confirmation needs Frame")
        local Content = Frame.Content
        local Template = Content.PetSlot.Template
        assert(Content.Yes:IsA("GuiButton") and Content.No:IsA("GuiButton"), "Star confirmation needs Yes/No")
        local v1 = assert(Assets.Directory[a2], "Unknown pet category")
        local v2 = v1.DisplayName or a2
        if v2 == a2 then
            v2 = ((v2:gsub("(%l)(%u)", "%1 %2")):gsub("(%u)(%u%l)", "%1 %2")):gsub("_", " ")
        end
        Template.Amount.RichText = false
        Template.Amount.Text = v2
        Template.Amount.TextWrapped = true
        Template.Icon.Image = v1.Icon or ""
        v2 = AssetRoster.ReadOwnerPen(Players.LocalPlayer.UserId)[a1]
        local MoneyPerSecond = v2 and v2.MoneyPerSecond
        Template.Cash.Visible = typeof(MoneyPerSecond) == "number"
        Template.Cash.Text = if typeof(MoneyPerSecond) ~= "number" then "" else ("$%*/s"):format((Simple.FormatCompact(MoneyPerSecond)))
        Frame.Header.Title.Text = "Apply Star?"
        if not Frame:FindFirstChild("Pop") then
            v2 = Instance.new("UIScale")
            v2.Name = "Pop"
            v2.Parent = Frame
        end
        return ApplyStarPopupConfirmationScreen, Frame
    end,
    Bind = function(a1, a2, a3, a4) -- Line: 47
        -- upvalues: RunService (val), MenuNavigation (val)
        local Attribute, v1
        local u4 = {}
        for i, j in a2:QueryDescendants("ImageLabel[$Cells][$FPS]") do
            v1 = j:GetAttribute("Cells")
            Attribute = j:GetAttribute("FPS")
            if typeof(v1) == "Vector2"
                and 1 <= v1.X
                and 1 <= v1.Y
                and typeof(Attribute) == "number"
                and Attribute > 0 then
                j.ImageRectOffset = Vector2.zero
                table.insert(u4, {Frame = 0, Image = j, Cells = v1, FPS = Attribute})
            end
        end
        local u18 = 0
        a3:Connect(RunService.Heartbeat, function(a1_2) -- Line: 59 -- upvalues: a1 (val), a2 (val), u18 (ref), u4 (val)
            if a1.Enabled and a2.Visible then
                local ImageRectSize, v1
                u18 = u18 + a1_2
                for i, j in u4 do
                    v1 = (math.floor(u18 * j.FPS)) % (j.Cells.X * j.Cells.Y)
                    if v1 ~= j.Frame then
                        j.Frame = v1
                        ImageRectSize = j.Image.ImageRectSize
                        j.Image.ImageRectOffset = Vector2.new(v1 % j.Cells.X * ImageRectSize.X, (math.floor(v1 / j.Cells.X)) * ImageRectSize.Y)
                    end
                end
                return
            end
        end)
        a3:Add(function() -- Line: 71 -- upvalues: u4 (val), MenuNavigation (upval)
            for i, j in u4 do
                j.Image.ImageRectOffset = Vector2.zero
            end
            MenuNavigation.SetOverride("MountStarConfirmation", nil)
        end)
        MenuNavigation.SetOverride("MountStarConfirmation", a2, a2.Content.No, a4, 100, true)
        a3:Connect(a1:GetPropertyChangedSignal("Enabled"), function() -- Line: 76 -- upvalues: a1 (val), a4 (val)
            if not a1.Enabled then
                a4()
            end
        end)
    end,
}