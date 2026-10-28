-- Script path: ReplicatedStorage.Controllers.GUI.Shop.ServerLuckController
-- Decompile time: 5.47 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Timecode = require(ReplicatedStorage.Shared.Utils.Time).Timecode
local GUI = require(ReplicatedStorage.Client.GUI)
local Price = require(ReplicatedStorage.Shared.Utils.Marketplace).Price
local Products = require(ReplicatedStorage.Data.Products)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ServerLuck = require(ReplicatedStorage.Shared.Types.ServerLuck)
return {
    Start = function() -- Line: 20
        -- upvalues: Constants (val), Products (val), GUI (val), Timecode (val), Price (val), ButtonFX (val)
        -- upvalues: Storefront (val), Remotes (val), ServerLuck (val), RunService (val)
        if Constants.IS_STUDIO then
            assert(Products.Directory.ServerLuck_X2, "ServerLuck_X2 product not found in Products directory")
            assert(Products.Directory.ServerLuck_X4, "ServerLuck_X4 product not found in Products directory")
            assert(Products.Directory.ServerLuck_X8, "ServerLuck_X8 product not found in Products directory")
        end
        local ServerLuck_2 = GUI.Shop():FindFirstChild("ServerLuck", true)
        if ServerLuck_2 == nil then
            return
        end
        local u32 = ServerLuck_2:FindFirstChild("Main") or ServerLuck_2
        local ExpiresIn = u32:WaitForChild("ExpiresIn")
        local BuyButton = u32:WaitForChild("BuyButton")
        local Price_2 = BuyButton:WaitForChild("Price")
        local Available = u32:WaitForChild("Available")
        local u52 = Available:WaitForChild("1")
        local u56 = Available:WaitForChild("2")
        local u61 = u32:WaitForChild("ButtonsWithExtension")
        local List = u61:WaitForChild("List")
        local u69 = List:WaitForChild("15Min")
        local u73 = List:WaitForChild("30Min")
        local u112 = {Multiplier = 1}

        local function getNextMultiplier(a1) -- Line: 54 -- types: a1: number
            if a1 < 2 then
                return 2
            end
            if a1 < 4 then
                return 4
            end
            return 8
        end

        local function updateLuckTimer(a1) -- Line: 64
            -- upvalues: Timecode (upval), ExpiresIn (val)
            ExpiresIn.Text = if not (a1 > 0) then "<font color=\"rgb(255, 0, 0)\">15 mins</font>" else ("<stroke color=\"rgb(0,0,0)\" joins=\"round\" thickness=\"2\"><font color=\"rgb(255, 0, 0)\">%*</font></stroke>"):format((Timecode(a1)))
        end

        local function updateUI() -- Line: 79
            -- upvalues: u112 (ref), Timecode (upval), ExpiresIn (val), u32 (val), u61 (val), u52 (val), u56 (val)
            -- upvalues: Products (upval), Price (upval), Price_2 (val), u69 (val), u73 (val)
            local v1 = 0
            if u112.ExpiresAt then
                v1 = math.max(0, u112.ExpiresAt - (workspace:GetServerTimeNow()))
            end
            ExpiresIn.Text = if not (v1 > 0) then "<font color=\"rgb(255, 0, 0)\">15 mins</font>" else ("<stroke color=\"rgb(0,0,0)\" joins=\"round\" thickness=\"2\"><font color=\"rgb(255, 0, 0)\">%*</font></stroke>"):format((Timecode(v1)))
            u32.Available.Visible = u112.Multiplier ~= 8
            u32.MaxedOut.Visible = u112.Multiplier == 8
            u61.Visible = 1 < u112.Multiplier
            if not (u112.Multiplier < 8) then
                Price_2.Text = "Maxed"
                return
            end
            local Multiplier = u112.Multiplier
            u52.Text = ("<stroke color=\"rgb(0,0,0)\" joins=\"round\" thickness=\"2\">%*<font color=\"rgb(56, 232, 57)\"></font></stroke>x"):format(u112.Multiplier)
            u56.Text = ("<stroke color=\"rgb(0,0,0)\" joins=\"round\" thickness=\"2\"><font color=\"rgb(56, 232, 57)\">%*</font></stroke>x"):format(if not (Multiplier < 2) then if not (Multiplier < 4) then 8 else 4 else 2)
            local v2 = Products.Directory[("ServerLuck_X%*"):format(v1)]
            if v2 then
                Price_2.Text = ("%*"):format(Price(v2.ProductId, Enum.InfoType.Product) or 0)
            end
            if u61.Visible then
                local ServerLuck_Extend15 = Products.Directory.ServerLuck_Extend15
                if ServerLuck_Extend15 then
                    u69.Text = ("%*"):format(Price(ServerLuck_Extend15.ProductId, Enum.InfoType.Product) or 0)
                end
                local ServerLuck_Extend30 = Products.Directory.ServerLuck_Extend30
                if ServerLuck_Extend30 then
                    u73.Text = ("%*"):format(Price(ServerLuck_Extend30.ProductId, Enum.InfoType.Product) or 0)
                    return
                end
            end
        end

        ButtonFX(BuyButton, nil, function() -- Line: 119 -- upvalues: u112 (ref), Products (upval), Storefront (upval)
            if u112.Multiplier < 8 then
                local Multiplier = u112.Multiplier
                local v1 = if not (Multiplier < 2) then if not (Multiplier < 4) then 8 else 4 else 2
                local v2 = Products.Directory[("ServerLuck_X%*"):format(v1)]
                if v2 then
                    Storefront.Prompt(v2.ProductId, true)
                end
            end
        end)
        ButtonFX(u69, nil, function() -- Line: 129 -- upvalues: u112 (ref), Products (upval), Storefront (upval)
            if 1 < u112.Multiplier then
                local ServerLuck_Extend15 = Products.Directory.ServerLuck_Extend15
                if ServerLuck_Extend15 then
                    Storefront.Prompt(ServerLuck_Extend15.ProductId, true)
                end
            end
        end)
        ButtonFX(u73, nil, function() -- Line: 138 -- upvalues: u112 (ref), Products (upval), Storefront (upval)
            if 1 < u112.Multiplier then
                local ServerLuck_Extend30 = Products.Directory.ServerLuck_Extend30
                if ServerLuck_Extend30 then
                    Storefront.Prompt(ServerLuck_Extend30.ProductId, true)
                end
            end
        end)
        Remotes.LuckWindow.StateRefreshed.OnClientEvent:Connect(function(a1) -- Line: 147 -- upvalues: ServerLuck (upval), u112 (ref), updateUI (val)
            if ServerLuck.State(a1) then
                u112 = a1
                updateUI()
            end
        end)
        local success, err = pcall(function() -- Line: 154 -- upvalues: Remotes (upval)
            return Remotes.LuckWindow.FetchState:InvokeServer()
        end)
        if success and type(err) == "table" and ServerLuck.State(err) then
            u112 = err
            updateUI()
        end
        RunService.Heartbeat:Connect(function() -- Line: 160 -- upvalues: u112 (ref), updateUI (val)
            if u112.ExpiresAt then
                updateUI()
            end
        end)
    end,
}