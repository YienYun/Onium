-- Script path: ReplicatedStorage.Controllers.Game.Tools.TrapGameplayHighlightController
-- Decompile time: 6.69 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GuardAreaGeometry = require(ReplicatedStorage.Shared.Util.GuardAreaGeometry)
local Player = require(ReplicatedStorage.Shared.Player)
local u49 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u54 = Color3.fromRGB(255, 255, 255)
local PLACED_TRAP = Constants.TAGS_MAP.Traps.PLACED_TRAP
local LocalPlayer = Players.LocalPlayer
return {
    Start = function() -- Line: 46
        -- upvalues: Workspace (val), LocalPlayer (val), u54 (val), TweenService (val), u49 (val)
        -- upvalues: CollectionService (val), PLACED_TRAP (val), RunService (val), Player (val), GuardAreaGeometry (val)
        local World = Workspace.World
        assert(World:IsA("Folder"), "Workspace.World must be a Folder")
        local Areas = World.Areas
        assert(Areas:IsA("Folder"), "Workspace.World.Areas must be a Folder")
        local SeparationLine = Areas.SeparationLine
        assert(SeparationLine:IsA("BasePart"), "Workspace.World.Areas.SeparationLine must be a BasePart")
        local u25 = {}
        local u26 = nil
        local u27 = false

        local function getOrCreateState(a1) -- Line: 65 -- upvalues: u25 (val) -- types: a1: userdata
            local v1 = u25[a1]
            if v1 then
                return v1
            end
            v1 = {FadeOutVersion = 0}
            u25[a1] = v1
            return v1
        end

        local function cancelTween(a1) -- Line: 80 -- types: a1: table
            local Tween = a1.Tween
            if Tween then
                a1.Tween = nil
                Tween:Cancel()
            end
        end

        local function isOwnedTrap(a1) -- Line: 88 -- upvalues: LocalPlayer (upval) -- types: a1: userdata
            return (a1:GetAttribute("Owner")) == LocalPlayer.Name
        end

        local function showTrapHighlight(a1) -- Line: 92
            -- upvalues: LocalPlayer (upval), u25 (val), u54 (upval), TweenService (upval), u49 (upval)
            local v1
            if not ((a1:GetAttribute("Owner")) == LocalPlayer.Name) then
                return
            end
            local v2 = u25[a1]
            if not v2 then
                u25[a1] = {FadeOutVersion = 0}
            end
            local v3 = v2
            v3.FadeOutVersion = v3.FadeOutVersion + 1
            local Tween = v3.Tween
            if Tween then
                v3.Tween = nil
                Tween:Cancel()
            end
            local TrapGameplayHighlight = a1:FindFirstChild("TrapGameplayHighlight")
            if not TrapGameplayHighlight or not TrapGameplayHighlight:IsA("Highlight") then
                v1 = Instance.new("Highlight")
                v1.Name = "TrapGameplayHighlight"
                v1.Parent = a1
            else
                v1 = TrapGameplayHighlight
            end
            v1.Adornee = a1
            v1.DepthMode = Enum.HighlightDepthMode.Occluded
            v1.FillColor = u54
            v1.FillTransparency = 1
            v1.OutlineColor = u54
            v1.OutlineTransparency = 1
            v3.Highlight = v1
            v2 = TweenService:Create(v1, u49, {OutlineTransparency = 0.3})
            v3.Tween = v2
            v2:Play()
        end

        local function hideTrapHighlight(a1) -- Line: 123
            -- upvalues: u25 (val), TweenService (upval), u49 (upval)
            local u2 = u25[a1]
            if not u2 then
                return
            end
            local Highlight = u2.Highlight
            if not Highlight then
                return
            end
            u2.FadeOutVersion = u2.FadeOutVersion + 1
            local FadeOutVersion = u2.FadeOutVersion
            local Tween = u2.Tween
            if Tween then
                u2.Tween = nil
                Tween:Cancel()
            end
            local v1 = TweenService:Create(Highlight, u49, {OutlineTransparency = 1})
            v1:Play()
            u2.Tween = v1
            v1.Completed:Once(function(a1) -- Line: 140 -- upvalues: u2 (val), FadeOutVersion (val), Highlight (val)
                if a1 == Enum.PlaybackState.Completed and u2.FadeOutVersion == FadeOutVersion then
                    if Highlight.Parent then
                        Highlight:Destroy()
                    end
                    u2.Highlight = nil
                    u2.Tween = nil
                    return
                end
            end)
        end

        local function setTrapHighlightsVisible(a1) -- Line: 153
            -- upvalues: u25 (val), showTrapHighlight (val), hideTrapHighlight (val)
            for k in pairs(u25) do
                if not a1 then
                    hideTrapHighlight(k)
                else
                    showTrapHighlight(k)
                end
            end
        end

        local function cleanupTrap(a1) -- Line: 163 -- upvalues: u25 (val) -- types: a1: userdata
            local v1 = u25[a1]
            if not v1 then
                return
            end
            local Tween = v1.Tween
            if Tween then
                v1.Tween = nil
                Tween:Cancel()
            end
            local Highlight = v1.Highlight
            if Highlight and Highlight.Parent then
                Highlight:Destroy()
            end
            u25[a1] = nil
        end

        local function trackTrap(a1) -- Line: 177
            -- upvalues: LocalPlayer (upval), u25 (val), u27 (ref), showTrapHighlight (val)
            if not a1:IsA("BasePart") or not ((a1:GetAttribute("Owner")) == LocalPlayer.Name) then
                return
            end
            if not u25[a1] then
                u25[a1] = {FadeOutVersion = 0}
            end
            if u27 then
                showTrapHighlight(a1)
            end
            a1.Destroying:Once(function() -- Line: 190 -- upvalues: a1 (val), u25 (upval)
                local v1 = a1
                local v2 = u25[v1]
                if not v2 then
                    return
                end
                local Tween = v2.Tween
                if Tween then
                    v2.Tween = nil
                    Tween:Cancel()
                end
                local Highlight = v2.Highlight
                if Highlight and Highlight.Parent then
                    Highlight:Destroy()
                end
                u25[v1] = nil
            end)
        end

        for i, v in ipairs(CollectionService:GetTagged(PLACED_TRAP)) do
            trackTrap(v)
        end
        ;(CollectionService:GetInstanceAddedSignal(PLACED_TRAP)):Connect(trackTrap)
        ;(CollectionService:GetInstanceRemovedSignal(PLACED_TRAP)):Connect(function(a1) -- Line: 193 -- upvalues: u27 (ref), hideTrapHighlight (val), u25 (val) -- types: a1: userdata
            if not a1:IsA("BasePart") then
                return
            end
            if u27 then
                hideTrapHighlight(a1)
                return
            end
            local v1 = u25[a1]
            if not v1 then
                return
            end
            local Tween = v1.Tween
            if Tween then
                v1.Tween = nil
                Tween:Cancel()
            end
            local Highlight = v1.Highlight
            if Highlight and Highlight.Parent then
                Highlight:Destroy()
            end
            u25[a1] = nil
        end)
        RunService.PreRender:Connect(function() -- Line: 212
            -- upvalues: Player (upval), LocalPlayer (upval), u26 (ref), u27 (ref), GuardAreaGeometry (upval)
            -- upvalues: SeparationLine (val), u25 (val), showTrapHighlight (val), hideTrapHighlight (val)
            local v1 = Player.FindRootPart(LocalPlayer)
            if v1 ~= nil and v1:IsA("BasePart") then
                local Position = v1.Position
                v1 = u26
                u26 = Position
                if v1 == nil then
                    u27 = GuardAreaGeometry.IsPastLine(SeparationLine, Position)
                    if u27 then
                        for k3 in pairs(u25) do
                            showTrapHighlight(k3)
                        end
                    end
                    return
                end
                if GuardAreaGeometry.CrossedLineInward(SeparationLine, v1, Position) then
                    u27 = true
                    for k2 in pairs(u25) do
                        showTrapHighlight(k2)
                    end
                    return
                end
                if GuardAreaGeometry.CrossedLineOutward(SeparationLine, v1, Position) then
                    u27 = false
                    for k in pairs(u25) do
                        hideTrapHighlight(k)
                    end
                end
                return
            end
        end)
    end,
}