-- Script path: ReplicatedStorage.Controllers.GUI.Shop.SpeedPowerProductsController
-- Decompile time: 5.21 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GUI = require(ReplicatedStorage.Client.GUI)
require(ReplicatedStorage.Client.Types.GUI)
local Gifting = require(ReplicatedStorage.Client.Gifting)
local Price = require(ReplicatedStorage.Shared.Utils.Marketplace).Price
require(ReplicatedStorage.Data.Products)
local Products_2 = require(ReplicatedStorage.Data.Products)
local Save = require(ReplicatedStorage.Shared.Save)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local u57 = {
    Products_2.Directory.SpeedPower_150000,
    Products_2.Directory.SpeedPower_1000000,
    Products_2.Directory.SpeedPower_10000000,
    Products_2.Directory.SpeedPower_50000000,
    Products_2.Directory.SpeedPower_500000000,
    Products_2.Directory.SpeedPower_1000000000,
}
local u74 = require(ReplicatedStorage.Data.SpeedPacks)
local LocalPlayer = (game:GetService("Players")).LocalPlayer
return {
    Start = function() -- Line: 38
        -- upvalues: GUI (val), Price (val), Constants (val), u74 (val), LocalPlayer (val), Simple (val), ButtonFX (val)
        -- upvalues: Storefront (val), Gifting (val), Save (val), u57 (val)
        local v1, v2
        local u2 = GUI.Shop()
        local Speed = u2.Frame.ScrollingFrame.Speed
        local v3 = {
            Speed.c1,
            Speed.c2,
            Speed.c3,
            Speed.c4,
            Speed.c5,
            Speed.c6,
        }

        local function updateProductPrice(a1, a2) -- Line: 55
            -- upvalues: Price (upval), Constants (upval)
            if a2 == nil then
                a1.Text = "???"
                return
            end
            local ProductId = a2.ProductId
            if ProductId <= 0 then
                a1.Text = "???"
                return
            end
            task.spawn(function() -- Line: 67 -- upvalues: Price (upval), ProductId (val), a1 (val), Constants (upval)
                local v1 = Price(ProductId, Enum.InfoType.Product)
                a1.Text = ("%*%*"):format(Constants.ROBUX_ICON_STR, if v1 == nil then "???" else tostring(v1))
            end)
        end

        local function bindSpeedPowerProductFrame(a1, a2, a3) -- Line: 73
            -- upvalues: Price (upval), Constants (upval), u74 (upval), LocalPlayer (upval), Simple (upval), u2 (val)
            -- upvalues: Speed (val), ButtonFX (upval), Storefront (upval), Gifting (upval)
            local Price_2 = a1.Btns.Buy.Price
            if a2 ~= nil then
                local ProductId = a2.ProductId
                if not (ProductId <= 0) then
                    task.spawn(function() -- Line: 67 -- upvalues: Price (upval), ProductId (val), Price_2 (val), Constants (upval)
                        local v1 = Price(ProductId, Enum.InfoType.Product)
                        Price_2.Text = ("%*%*"):format(Constants.ROBUX_ICON_STR, if v1 == nil then "???" else tostring(v1))
                    end)
                else
                    Price_2.Text = "???"
                end
            else
                Price_2.Text = "???"
            end
            a1.Title.RichText = true
            local u22 = assert((u74.FindSlot(a2.ProductId)))

            local function refresh() -- Line: 81
                -- upvalues: u74 (upval), LocalPlayer (upval), u22 (val), a1 (val), a3 (val), Simple (upval)
                local v1 = u74.GetShownAmount(LocalPlayer, u22)
                a1.Title.Text = if not v1 then "Loading..." else ("<font color=\"#%*\">+%*</font> SPEED"):format(a3:ToHex(), (Simple.FormatCompact(v1, ".#")))
            end

            u74.ObserveShownAmount(LocalPlayer, u22, refresh)
            ;(u2:GetPropertyChangedSignal("Enabled")):Connect(refresh)
            ;(u2.Frame:GetPropertyChangedSignal("Visible")):Connect(refresh)
            ;(Speed:GetPropertyChangedSignal("Visible")):Connect(refresh)
            ButtonFX(a1.Btns.Buy, nil, function() -- Line: 91 -- upvalues: Storefront (upval), a2 (val)
                Storefront.Prompt(a2.ProductId, true)
            end)
            Gifting.Bind(a1.Btns.Gift, "Product", a2.ProductId)
        end

        Save.Await()
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "SpeedPackMaxNotice"
        TextLabel.LayoutOrder = Speed.LayoutOrder + 1
        TextLabel.Size = UDim2.new(1, 0, 0, 36)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.TextColor3 = Color3.new(1, 1, 1)
        TextLabel.TextStrokeTransparency = 0
        TextLabel.TextScaled = true
        TextLabel.TextWrapped = true
        TextLabel.Text = "Max for now. Bigger packs with the next biome."
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
        UITextSizeConstraint.MaxTextSize = 22
        UITextSizeConstraint.Parent = TextLabel
        TextLabel.Parent = Speed.Parent

        local function refreshNotice() -- Line: 117
            -- upvalues: TextLabel (val), Speed (val), LocalPlayer (upval), u74 (upval)
            local Visible = Speed.Visible
            if Visible then
                Visible = false
                if LocalPlayer:GetAttribute(u74.ReadyAttribute) == true then
                    Visible = LocalPlayer:GetAttribute(u74.MaxAttribute) == true
                end
            end
            TextLabel.Visible = Visible
        end

        ;(LocalPlayer:GetAttributeChangedSignal(u74.RevisionAttribute)):Connect(refreshNotice)
        ;(LocalPlayer:GetAttributeChangedSignal(u74.ReadyAttribute)):Connect(refreshNotice)
        ;(LocalPlayer:GetAttributeChangedSignal(u74.MaxAttribute)):Connect(refreshNotice)
        ;(Speed:GetPropertyChangedSignal("Visible")):Connect(refreshNotice)
        local Visible = Speed.Visible
        if Visible then
            Visible = false
            if LocalPlayer:GetAttribute(u74.ReadyAttribute) == true then
                Visible = LocalPlayer:GetAttribute(u74.MaxAttribute) == true
            end
        end
        TextLabel.Visible = Visible
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            v1 = u57[i]
            v2 = if not (i <= 3) then Color3.fromRGB(255, 200, 0) else Color3.fromRGB(0, 255, 0)
            bindSpeedPowerProductFrame(j, v1, v2)
        end
    end,
}