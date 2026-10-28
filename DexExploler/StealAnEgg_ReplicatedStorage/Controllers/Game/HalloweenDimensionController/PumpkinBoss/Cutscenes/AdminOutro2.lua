-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.Cutscenes.AdminOutro2
-- Decompile time: 9.91 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local BulkFade = require(ReplicatedStorage.Client.Modules.BulkFade)
local MoonScene = require(script.Parent.MoonScene)
require(script.Parent.Parent.Scenes)
local Transition = require(script.Parent.Parent.Transition)
require(ReplicatedStorage.Packages.Trove)
local OutroCutscene2 = ReplicatedStorage.CutsceneAssets.PumpkinBossCutsceneAssets.OutroCutscene2
local UnixTimestamp = DateTime.fromUniversalTime(2026, 10, 28, 15).UnixTimestamp
local u61 = Color3.new(1, 0.784314, 0.415686)
local u66 = Color3.new(1, 1, 1)

local function linear(a1, a2) -- Line: 44 -- types: a1: number, a2: number
    return TweenInfo.new((a2 - a1) / 60, Enum.EasingStyle.Linear)
end

local function countdown(a1) -- Line: 48 -- types: a1: number
    local v1 = math.max(0, (math.floor(a1)))
    return string.format("%02i:%02i:%02i:%02i", v1 // 86400, v1 // 3600 % 24, v1 // 60 % 60, v1 % 60)
end

local function build(a1) -- Line: 53 -- upvalues: u66 (val), u61 (val)
    local SetProperty = a1.SetProperty
    local TweenProperty = a1.TweenProperty
    local SetEmitting = a1.SetEmitting
    local Decor = a1.Rigs.EnvelopeRig.GoldenEnvelope.Decor
    local v1 = {}
    local v2 = {}
    local v3 = SetProperty("Workspace.CurrentCamera.FieldOfView", 35)
    local v4 = SetProperty("PlayerGui.CutsceneUI.Vignette.ImageColor3", Color3.new(1, 0.588978, 0.25098))
    local v5 = SetProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", 1)
    local v6 = SetProperty("Lighting.Gold.TintColor", u66)
    local v7 = SetProperty("Lighting.Gold.Brightness", 0)
    local v8 = SetProperty("Lighting.Gold.Saturation", 0)
    local v9 = SetProperty("Lighting.Gold.Contrast", 0)
    local v10 = SetProperty("Lighting.CutsceneDepthOfField.Enabled", true)
    local v11 = SetProperty("Lighting.CutsceneDepthOfField.FarIntensity", 0.09)
    local v12 = SetProperty("Lighting.CutsceneBlur.Enabled", true)
    local v13 = SetProperty("Lighting.CutsceneBlur.Size", 15)
    local v14 = TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear), 2)
    local v15 = SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0)
    local v16 = TweenInfo.new(0.38333333333333336, Enum.EasingStyle.Linear)
    v2[1] = v3

    v2[2] = function() -- Line: 62 -- upvalues: SetEmitting (val), Decor (val)
        SetEmitting(Decor, true)
    end

    v2[3] = v4
    v2[4] = v5
    v2[5] = v6
    v2[6] = v7
    v2[7] = v8
    v2[8] = v9
    v2[9] = v10
    v2[10] = v11
    v2[11] = v12
    v2[12] = v13
    v2[13] = v14
    v2[14] = v15
    v2[15] = TweenProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", v16, 1)
    v1[0] = v2
    v1[180] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.2833333333333333, Enum.EasingStyle.Linear), 15)),
    }
    v1[197] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(1, Enum.EasingStyle.Linear), 4)),
    }
    v1[240] = {
        TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(1.3333333333333333, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.Gold.TintColor", TweenInfo.new(1.3333333333333333, Enum.EasingStyle.Linear), u61),
        TweenProperty("Lighting.Gold.Brightness", TweenInfo.new(1.3333333333333333, Enum.EasingStyle.Linear), 0.3),
        TweenProperty("Lighting.Gold.Saturation", TweenInfo.new(1.3333333333333333, Enum.EasingStyle.Linear), 0.5),
        (TweenProperty("Lighting.Gold.Contrast", TweenInfo.new(1.3333333333333333, Enum.EasingStyle.Linear), 0.7)),
    }
    v1[307] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.25, Enum.EasingStyle.Linear), 10)),
    }
    v1[322] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.3, Enum.EasingStyle.Linear), 4)),
    }
    v1[390] = {
        TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), 1),
        TweenProperty("Lighting.Gold.TintColor", TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), u66),
        TweenProperty("Lighting.Gold.Brightness", TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), 0),
        TweenProperty("Lighting.Gold.Saturation", TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), 0),
        (TweenProperty("Lighting.Gold.Contrast", TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), 0)),
    }
    v1[402] = {
        function() -- Line: 98 -- upvalues: SetEmitting (val), Decor (val)
            SetEmitting(Decor, false)
        end,
    }
    v1[421] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.05, Enum.EasingStyle.Linear), 10)),
    }
    v1[424] = {
        (TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 0.5)),
    }
    v1[425] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), 2)),
    }
    v1[645] = {
        TweenProperty("Workspace.CurrentCamera.FieldOfView", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 32),
        TweenProperty("Lighting.CutsceneDepthOfField.FarIntensity", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 1),
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), 7)),
    }
    v1[646] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), 4)),
    }
    v1[769] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.45, Enum.EasingStyle.Linear), 0)),
    }
    v1[796] = {
        (TweenProperty("PlayerGui.CutsceneUI.Vignette.ImageTransparency", TweenInfo.new(0.5666666666666667, Enum.EasingStyle.Linear), 1)),
    }
    v1[1147] = {
        (TweenProperty("Lighting.CutsceneBlur.Size", TweenInfo.new(0.21666666666666667, Enum.EasingStyle.Linear), 10)),
    }
    v1[1160] = {SetProperty("PlayerGui.CutsceneUI.Black.BackgroundTransparency", 0)}
    return v1
end

return table.freeze({
    Play = function(self) -- Line: 119
        -- upvalues: BulkFade (val), UnixTimestamp (val), Workspace (val), MoonScene (val), OutroCutscene2 (val)
        -- upvalues: build (val), Players (val), Transition (val), SoundService (val)
        local ConcertTeaser = self.Player.PlayerGui.CutsceneUI.ConcertTeaser
        local TimeRemaining = ConcertTeaser.TimeRemaining
        local u12 = BulkFade.new(ConcertTeaser, TweenInfo.new(1))
        local u13 = nil

        local function showTeaser() -- Line: 125
            -- upvalues: u12 (val), ConcertTeaser (val), TimeRemaining (val), UnixTimestamp (upval), Workspace (upval)
            -- upvalues: u13 (ref)
            local v1, v2
            u12:FadeOutInstant()
            ConcertTeaser.Visible = true
            u12:FadeIn()
            local v3 = os.clock() + 5 + 1
            while ConcertTeaser.Visible do
                if not (os.clock() < v3) then
                    break
                end
                v1 = TimeRemaining
                v2 = math.max(0, (math.floor(UnixTimestamp - Workspace:GetServerTimeNow())))
                v1.Text = ("ARTIST REVEAL IN %*"):format((string.format("%02i:%02i:%02i:%02i", v2 // 86400, v2 // 3600 % 24, v2 // 60 % 60, v2 % 60)))
                v1 = u13
                if v1 then
                    v1:Play()
                end
                task.wait(1)
            end
        end

        return (MoonScene.Play(self, {
            Prefix = "PumpkinOutro2",
            Frames = 1580,
            CameraPart = "Cam",
            HoldBlack = true,
            Assets = OutroCutscene2,
            Build = function(a1) -- Line: 146 -- upvalues: build (upval), showTeaser (val), u12 (val)
                local v1 = build(a1)
                table.insert(v1[1160], showTeaser)
                v1[1520] = {
                    function() -- Line: 150 -- upvalues: u12 (upval)
                        u12:FadeOut()
                    end,
                }
                return v1
            end,
            Setup = function(a1) -- Line: 156
                -- upvalues: Players (upval), Transition (upval), SoundService (upval), u13 (ref), ConcertTeaser (val)
                -- upvalues: u12 (val)
                Players.LocalPlayer.PlayerGui.CutsceneUI.Black.BackgroundTransparency = 0
                Transition.Reveal(0)
                local v1 = a1:Add((Instance.new("Sound")))
                v1.SoundId = "rbxassetid://119317416196943"
                v1.Volume = 0.2
                v1.Parent = SoundService
                u13 = v1
                a1:Add(function() -- Line: 166 -- upvalues: u13 (upval), ConcertTeaser (upval), u12 (upval)
                    u13 = nil
                    ConcertTeaser.Visible = false
                    u12:FadeIn()
                end)
            end,
        }))
    end,
})