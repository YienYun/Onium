-- Script path: ReplicatedStorage.Controllers.GUI.AreaGuiController
-- Decompile time: 3.70 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AreaNotificationTracker = require(script.Parent.Parent.Game.GuardAreasController.AreaNotificationTracker)
require(ReplicatedStorage.Data.Areas)
local GUI = require(ReplicatedStorage.Client.GUI)
local SwapGradient = require(ReplicatedStorage.Shared.Utils.SwapGradient)
local GuiTransitionGroup = require(ReplicatedStorage.Client.UI.VFX.GuiTransitionGroup)
local SubBiomeCycle = require(ReplicatedStorage.Shared.Util.SubBiomeCycle)
local u42 = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u47 = TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local u48 = nil
return {
    Show = function(a1, a2, a3) -- Line: 41 -- upvalues: u48 (ref) -- types: a1: string, a2: string, a3: userdata
        local v1 = u48
        assert(v1 ~= nil, "AreaGuiController must be started before Show")
        v1(a1, a2, a3)
    end,
    Start = function() -- Line: 47
        -- upvalues: GUI (val), SwapGradient (val), SubBiomeCycle (val), u42 (val), u47 (val), u48 (ref)
        -- upvalues: GuiTransitionGroup (val), AreaNotificationTracker (val)
        local u2 = GUI.AreaGui()
        local Frame = u2.Frame
        local Main = Frame.Texts.Main
        local Emoji = Frame.Texts.Emoji
        local u11 = Instance.new("UIGradient")
        u11.Rotation = 22
        local v1 = {}
        local u14 = 0
        local u15 = nil

        local function applyAreaGradient(a1, a2) -- Line: 66 -- upvalues: u11 (val), SwapGradient (upval), Main (val)
            local Gradient
            if (if a2 == nil then nil else a2.Gradient) == nil then
                SwapGradient(Main, a1.ZoneGradient or a1.Rarity.RarityGradient)
                return
            end
            u11.Color = Gradient
            SwapGradient(Main, u11)
        end

        local function renderArea(a1, a2) -- Line: 80
            -- upvalues: SubBiomeCycle (upval), Main (val), Emoji (val), u11 (val), SwapGradient (upval)
            local Gradient
            local v1 = SubBiomeCycle.Active(a2)
            if v1 == nil then
                Main.Text = ("%*"):format(a1.DisplayName)
                Emoji.Text = ("%*"):format(a1.Emoji)
            else
                Main.Text = ("%*"):format(v1.DisplayName)
                Emoji.Text = ("%*"):format(v1.Emoji or a1.Emoji)
            end
            if (if v1 == nil then nil else v1.Gradient) == nil then
                SwapGradient(Main, a1.ZoneGradient or a1.Rarity.RarityGradient)
                return
            end
            u11.Color = Gradient
            SwapGradient(Main, u11)
        end

        local function animate(a1) -- Line: 92
            -- upvalues: u14 (ref), u15 (ref), u2 (val), u42 (upval), u47 (upval)
            u14 = u14 + 1
            local u3 = u14
            local u4 = u15
            assert(u4 ~= nil, "AreaGui transition group must be initialized before show")
            u4:Halt()
            a1()
            u4:SnapHidden()
            u2.Enabled = true
            u4:Reveal(u42)
            task.delay(1, function() -- Line: 107 -- upvalues: u3 (val), u14 (upval), u4 (val), u47 (upval), u2 (upval)
                if u3 ~= u14 then
                    return
                end
                u4:Halt()
                u4:Conceal(u47)
                task.delay(u47.Time, function() -- Line: 115 -- upvalues: u3 (upval), u14 (upval), u2 (upval), u4 (upval)
                    if u3 ~= u14 then
                        return
                    end
                    u2.Enabled = false
                    u4:Rehome()
                end)
            end)
        end

        local function showArea(a1, a2) -- Line: 126
            -- upvalues: u14 (ref), animate (val), renderArea (val)
            if workspace:GetAttribute("Event_DragonEggEvent") then
                u14 = u14 + 1
                return
            end
            animate(function() -- Line: 132 -- upvalues: renderArea (upval), a1 (val), a2 (val)
                renderArea(a1, a2)
            end)
        end

        function u48(a1, a2, a3) -- Line: 137
            -- upvalues: animate (val), Main (val), Emoji (val), SwapGradient (upval)
            animate(function() -- Line: 138 -- upvalues: Main (upval), a1 (val), Emoji (upval), a2 (val), SwapGradient (upval), a3 (val)
                Main.Text = a1
                Emoji.Text = a2
                SwapGradient(Main, a3)
            end)
        end

        local function start() -- Line: 145
            -- upvalues: u15 (ref), GuiTransitionGroup (upval), u2 (val), AreaNotificationTracker (upval)
            -- upvalues: showArea (val)
            GuiTransitionGroup.new(u2, u2, 0.02)
            u2.Enabled = false
            AreaNotificationTracker.Start(showArea)
        end

        function v1.Start() -- Line: 155
            -- upvalues: u15 (ref), GuiTransitionGroup (upval), u2 (val), AreaNotificationTracker (upval)
            -- upvalues: showArea (val)
            GuiTransitionGroup.new(u2, u2, 0.02)
            u2.Enabled = false
            AreaNotificationTracker.Start(showArea)
        end

        v1.Start()
    end,
}