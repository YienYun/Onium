-- Script path: ReplicatedStorage.Controllers.GUI.GuardAreas.GetMoreSpeedOnHitController
-- Decompile time: 6.61 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
require(ReplicatedStorage.Shared.Globals.Constants)
local GUI = require(ReplicatedStorage.Client.GUI)
local EnsureUIScale = require(ReplicatedStorage.Shared.Utils.EnsureUIScale)
local Log = require(ReplicatedStorage.Packages.Log)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u61 = Color3.fromRGB(255, 64, 64)
local u66 = Color3.fromRGB(48, 255, 105)
local u71 = TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u76 = TweenInfo.new(0.62, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local u78 = Log.new()
return {
    Start = function() -- Line: 37
        -- upvalues: GUI (val), EnsureUIScale (val), TweenService (val), Trove (val), u71 (val), u66 (val), u76 (val)
        -- upvalues: ReplicatedStorage (val), Simple (val), ButtonFX (val), u78 (val), Storefront (val), Remotes (val)
        -- upvalues: Toast (val), u61 (val)
        local u2 = GUI.GetMoreSpeedOnHit()
        local Frame = u2.Frame
        assert(Frame:IsA("Frame"), "PlayerGui.GetMoreSpeedOnHit.Frame must be a Frame")
        local Button = Frame.Button
        assert(Button:IsA("GuiButton"), "PlayerGui.GetMoreSpeedOnHit.Frame.Button must be a GuiButton")
        local Frame_2 = Button.Frame
        assert(Frame_2:IsA("Frame"), "PlayerGui.GetMoreSpeedOnHit.Frame.Button.Frame must be a Frame")
        local Title = Frame_2.Title
        assert(Title:IsA("TextLabel"), "PlayerGui.GetMoreSpeedOnHit.Frame.Button.Frame.Title must be a TextLabel")
        local u37 = EnsureUIScale(Frame_2)
        local Position = Frame.Position
        local u47 = UDim2.new(Position.X.Scale, Position.X.Offset, -0.4, Position.Y.Offset)
        local TextColor3 = Title.TextColor3
        local Scale = u37.Scale
        local u50 = nil
        local u51 = nil
        local u52 = nil
        local u53 = 0

        local function playPositionTween(a1, a2) -- Line: 63
            -- upvalues: u50 (ref), TweenService (upval), Frame (val)
            if u50 ~= nil then
                u50:Cancel()
            end
            local v1 = TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, a2), {Position = a1})
            u50 = v1
            v1:Play()
            return v1
        end

        local function stopTitlePulse() -- Line: 77 -- upvalues: u51 (ref)
            local v1 = u51
            if v1 == nil then
                return
            end
            u51 = nil
            v1:Destroy()
        end

        local function startTitlePulse() -- Line: 87
            -- upvalues: u51 (ref), Title (val), TextColor3 (val), u37 (val), Scale (val), Trove (upval)
            -- upvalues: TweenService (upval), u71 (upval), u66 (upval), u76 (upval)
            local v1 = u51
            if v1 ~= nil then
                u51 = nil
                v1:Destroy()
            end
            Title.TextColor3 = TextColor3
            u37.Scale = Scale
            local u11 = Trove.new()
            u51 = u11
            u11:Add(function() -- Line: 94 -- upvalues: Title (upval), TextColor3 (upval), u37 (upval), Scale (upval)
                Title.TextColor3 = TextColor3
                u37.Scale = Scale
            end)
            u11:Add((task.spawn(function() -- Line: 98
                -- upvalues: u51 (upval), u11 (val), Title (upval), TextColor3 (upval), u37 (upval), Scale (upval)
                -- upvalues: TweenService (upval), u71 (upval), u66 (upval), u76 (upval)
                local v1, v2
                while u51 == u11 do
                    Title.TextColor3 = TextColor3
                    u37.Scale = Scale
                    v1 = TweenService:Create(Title, u71, {TextColor3 = u66})
                    v2 = TweenService:Create(u37, u71, {Scale = Scale * 1.3})
                    u11:Add(v1)
                    u11:Add(v2)
                    v1:Play()
                    v2:Play()
                    v2.Completed:Wait()
                    if u51 ~= u11 then
                        break
                    end
                    v2 = TweenService:Create(Title, u76, {TextColor3 = TextColor3})
                    v1 = TweenService:Create(u37, u76, {Scale = Scale})
                    u11:Add(v2)
                    u11:Add(v1)
                    v2:Play()
                    v1:Play()
                    v1.Completed:Wait()
                    Title.TextColor3 = TextColor3
                    u37.Scale = Scale
                end
            end)))
        end

        u2.Enabled = false
        Title.TextColor3 = TextColor3
        u37.Scale = Scale
        ButtonFX(Button, nil, function() -- Line: 174 -- upvalues: u52 (ref), u78 (upval), Storefront (upval)
            local v1 = u52
            if v1 == nil then
                u78:AtWarning():Log("GetMoreSpeedOnHit button activated without an active product")
                return
            end
            Storefront.Prompt(v1, true, "GuardHit")
        end)
        Remotes.GuardPatrol.SpeedTollWarning.OnClientEvent:Connect(function() -- Line: 183 -- upvalues: Toast (upval), u61 (upval)
            Toast.Show({Text = "You don't have enough speed!", Seconds = 2, Color = u61})
        end)
        Remotes.GuardPatrol.SpeedTollOffer.OnClientEvent:Connect(function(a1, a2) -- Line: 136
            -- upvalues: u53 (ref), u52 (ref), ReplicatedStorage (upval), Title (val), Simple (upval), Frame (val)
            -- upvalues: u47 (val), startTitlePulse (val), u2 (val), playPositionTween (val), Position (val), u51 (ref)
            u53 = u53 + 1
            local u4 = u53
            u52 = a1
            local SpeedPacks = require(ReplicatedStorage.Data.SpeedPacks)
            local v1 = SpeedPacks.FindSlot(a1)
            if v1 then
                a2 = SpeedPacks.GetShownAmount(game.Players.LocalPlayer, v1) or a2
            end
            Title.Text = ("+%*"):format((Simple.FormatCompact(a2, ".#")))
            Frame.Position = u47
            startTitlePulse()
            u2.Enabled = true
            playPositionTween(Position, Enum.EasingDirection.Out)
            task.delay(6, function() -- Line: 151
                -- upvalues: u4 (val), u53 (upval), playPositionTween (upval), u47 (upval), u51 (upval), u52 (upval)
                -- upvalues: u2 (upval)
                if u4 ~= u53 then
                    return
                end
                ;(playPositionTween(u47, Enum.EasingDirection.In)).Completed:Once(function() -- Line: 156 -- upvalues: u4 (upval), u53 (upval), u51 (upval), u52 (upval), u2 (upval)
                    if u4 ~= u53 then
                        return
                    end
                    local v1 = u51
                    if v1 ~= nil then
                        u51 = nil
                        v1:Destroy()
                    end
                    u52 = nil
                    u2.Enabled = false
                end)
            end)
        end)
        local SpeedPacks = require(ReplicatedStorage.Data.SpeedPacks)
        local v1 = #SpeedPacks.ProductIds
        for i = 1, v1 do
            SpeedPacks.ObserveShownAmount(game.Players.LocalPlayer, i, function() -- Line: 194 -- upvalues: u52 (ref), SpeedPacks (val), i (val), Title (val), Simple (upval)
                if u52 ~= SpeedPacks.ProductIds[i] then
                    return
                end
                local v1 = SpeedPacks.GetShownAmount(game.Players.LocalPlayer, i)
                if v1 then
                    Title.Text = ("+%*"):format((Simple.FormatCompact(v1, ".#")))
                end
            end)
        end
    end,
}