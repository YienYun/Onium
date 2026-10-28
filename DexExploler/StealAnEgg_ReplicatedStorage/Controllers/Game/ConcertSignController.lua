-- Script path: ReplicatedStorage.Controllers.Game.ConcertSignController
-- Decompile time: 17.54 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local BaseUpgrade = require(ReplicatedStorage.Client.BaseUpgrade)
local Save = require(ReplicatedStorage.Shared.Save)
local Trove = require(ReplicatedStorage.Packages.Trove)
local VFX = require(ReplicatedStorage.Shared.Utils.VFX)
local UnixTimestamp = (DateTime.fromUniversalTime(2026, 10, 28, 15)).UnixTimestamp
local LocalPlayer = Players.LocalPlayer
return {
    Start = function() -- Line: 48
        -- upvalues: Workspace (val), Trove (val), UnixTimestamp (val), RunService (val), ReplicatedStorage (val)
        -- upvalues: VFX (val), Audio (val), TweenService (val), Save (val), BaseUpgrade (val), LocalPlayer (val)
        local Sign = Workspace:WaitForChild("Sign", 30)
        if Sign == nil then
            return
        end
        local FlyingCurtain = Sign:WaitForChild("FlyingCurtain", 10)
        if FlyingCurtain == nil then
            return
        end
        local Plane = FlyingCurtain:WaitForChild("Plane")
        local CurtainCountdown = Plane:WaitForChild("CurtainCountdown")
        local CurtainRevealed = Plane:WaitForChild("CurtainRevealed")
        local Timer = CurtainCountdown:WaitForChild("Timer")
        local u29 = Trove.new()
        local u30 = {}
        local u31 = {}

        local function hidePart(a1) -- Line: 72 -- upvalues: u30 (val) -- types: a1: userdata
            local Transparency = a1.Transparency
            local CanCollide = a1.CanCollide
            local CanQuery = a1.CanQuery
            local CanTouch = a1.CanTouch
            a1.Transparency = 1
            a1.CanCollide = false
            a1.CanQuery = false
            a1.CanTouch = false
            table.insert(u30, function() -- Line: 81 -- upvalues: a1 (val), Transparency (val), CanCollide (val), CanQuery (val), CanTouch (val)
                a1.Transparency = Transparency
                a1.CanCollide = CanCollide
                a1.CanQuery = CanQuery
                a1.CanTouch = CanTouch
            end)
        end

        local function hideEmitter(a1) -- Line: 89 -- upvalues: u31 (val) -- types: a1: userdata
            local Enabled = a1.Enabled
            a1.Enabled = false
            a1:Clear()
            table.insert(u31, function() -- Line: 95 -- upvalues: a1 (val), Enabled (val)
                a1.Enabled = Enabled
            end)
        end

        local function hideBeam(a1) -- Line: 100 -- upvalues: u30 (val) -- types: a1: userdata
            local Enabled = a1.Enabled
            a1.Enabled = false
            table.insert(u30, function() -- Line: 105 -- upvalues: a1 (val), Enabled (val)
                a1.Enabled = Enabled
            end)
        end

        local function hideSign() -- Line: 110
            -- upvalues: Sign (val), u30 (val), u31 (val), CurtainCountdown (val), CurtainRevealed (val)
            for i, j in Sign:GetDescendants() do
                if j:IsA("BasePart") then
                    local Transparency = j.Transparency
                    local CanCollide = j.CanCollide
                    local CanQuery = j.CanQuery
                    local CanTouch = j.CanTouch
                    j.Transparency = 1
                    j.CanCollide = false
                    j.CanQuery = false
                    j.CanTouch = false
                    table.insert(u30, function() -- Line: 81 -- upvalues: j (val), Transparency (val), CanCollide (val), CanQuery (val), CanTouch (val)
                        j.Transparency = Transparency
                        j.CanCollide = CanCollide
                        j.CanQuery = CanQuery
                        j.CanTouch = CanTouch
                    end)
                elseif j:IsA("ParticleEmitter") then
                    local Enabled = j.Enabled
                    j.Enabled = false
                    j:Clear()
                    table.insert(u31, function() -- Line: 95 -- upvalues: j (val), Enabled (val)
                        j.Enabled = Enabled
                    end)
                elseif j:IsA("Beam") then
                    local Enabled_2 = j.Enabled
                    j.Enabled = false
                    table.insert(u30, function() -- Line: 105 -- upvalues: j (val), Enabled_2 (val)
                        j.Enabled = Enabled_2
                    end)
                end
            end
            CurtainCountdown.Enabled = false
            CurtainRevealed.Enabled = false
        end

        local function formatRemaining(a1) -- Line: 125 -- types: a1: number
            local v1 = math.max(0, (math.floor(a1)))
            return string.format("%dD %02d:%02d:%02d", v1 // 86400, v1 // 3600 % 24, v1 // 60 % 60, v1 % 60)
        end

        local function refreshCountdown() -- Line: 134
            -- upvalues: UnixTimestamp (upval), Workspace (upval), CurtainCountdown (val), CurtainRevealed (val)
            -- upvalues: Timer (val)
            local v1
            local v2 = UnixTimestamp - Workspace:GetServerTimeNow()
            CurtainCountdown.Enabled = not (v2 <= 0)
            CurtainRevealed.Enabled = v1
            if not v1 then
                local v3 = Timer
                local v4 = math.max(0, (math.floor(v2)))
                v3.Text = string.format("%dD %02d:%02d:%02d", v4 // 86400, v4 // 3600 % 24, v4 // 60 % 60, v4 % 60)
            end
            return v1
        end

        local function startCountdown() -- Line: 147
            -- upvalues: UnixTimestamp (upval), Workspace (upval), CurtainCountdown (val), CurtainRevealed (val)
            -- upvalues: Timer (val), u29 (val)
            local v1 = UnixTimestamp - Workspace:GetServerTimeNow()
            local v2 = v1 <= 0
            CurtainCountdown.Enabled = not v2
            CurtainRevealed.Enabled = v2
            if not v2 then
                local v3 = Timer
                local v4 = math.max(0, (math.floor(v1)))
                v3.Text = string.format("%dD %02d:%02d:%02d", v4 // 86400, v4 // 3600 % 24, v4 // 60 % 60, v4 % 60)
            end
            if v2 then
                return
            end
            u29:Add((task.spawn(function() -- Line: 152
                -- upvalues: Workspace (upval), UnixTimestamp (upval), CurtainCountdown (upval), CurtainRevealed (upval)
                -- upvalues: Timer (upval)
                local v1, v2, v3, v4
                repeat
                    task.wait(1 - Workspace:GetServerTimeNow() % 1)
                    v2 = UnixTimestamp - Workspace:GetServerTimeNow()
                    v1 = v2 <= 0
                    CurtainCountdown.Enabled = not v1
                    CurtainRevealed.Enabled = v1
                    if not v1 then
                        v3 = Timer
                        v4 = math.max(0, (math.floor(v2)))
                        v3.Text = string.format("%dD %02d:%02d:%02d", v4 // 86400, v4 // 3600 % 24, v4 // 60 % 60, v4 % 60)
                    end
                until v1
            end)))
        end

        local Pivot = FlyingCurtain:GetPivot()
        local Scale = FlyingCurtain:GetScale()
        local u46 = os.clock()

        local function wobbleAt(a1) -- Line: 163 -- upvalues: Pivot (val) -- types: a1: number
            local v1 = math.sin(a1 * 6.283185307179586 / 3.1) * 1.4
            local v2 = math.sin(a1 * 6.283185307179586 / 4.3) * 0.06981317007977318
            local v3 = math.sin(a1 * 6.283185307179586 / 3.7 + 1.3) * 0.027925268031909273
            local v4 = (math.sin(a1 * 6.283185307179586 / 5.9 + 2.1)) * 0.041887902047863905
            return (CFrame.new(Pivot.Position + Vector3.new(0, v1, 0))) * CFrame.Angles(v2, v4, v3) * Pivot.Rotation
        end

        local function startWobble() -- Line: 175
            -- upvalues: u46 (ref), u29 (val), RunService (upval), Workspace (upval), Pivot (val), FlyingCurtain (val)
            -- upvalues: wobbleAt (val)
            u46 = os.clock()
            u29:Connect(RunService.RenderStepped, function() -- Line: 178
                -- upvalues: Workspace (upval), Pivot (upval), FlyingCurtain (upval), wobbleAt (upval), u46 (upval)
                local CurrentCamera = Workspace.CurrentCamera
                if CurrentCamera ~= nil and 900 < (CurrentCamera.CFrame.Position - Pivot.Position).Magnitude then
                    return
                end
                FlyingCurtain:PivotTo((wobbleAt((os.clock()) - u46)))
            end)
        end

        local function playPoof() -- Line: 191
            -- upvalues: Plane (val), ReplicatedStorage (upval), VFX (upval), Audio (upval)
            local X = Plane.Size.X
            local EggPoof = ReplicatedStorage.Assets:FindFirstChild("EggPoof")
            local TreadmillUpgrade = ReplicatedStorage.Assets.Particles:FindFirstChild("TreadmillUpgrade")
            if EggPoof ~= nil then
                local v1
                for i = 1, 5 do
                    v1 = Plane.CFrame * CFrame.new(((i - 1) / 4 - 0.5) * X * 0.9, 0, 0)
                    VFX.EmitAt(v1, EggPoof:GetChildren(), function(a1) -- Line: 201 -- upvalues: VFX (upval)
                        VFX.Rescale(a1, 20)
                        a1:SetAttribute("EmitCount", 40)
                    end)
                end
            end
            if TreadmillUpgrade ~= nil then
                VFX.EmitAt(Plane.CFrame, TreadmillUpgrade:GetChildren(), function(a1) -- Line: 209 -- upvalues: VFX (upval)
                    VFX.Rescale(a1, 8)
                end)
            end
            Audio.Play("rbxassetid://102267539121951", Plane, {MaxDistance = 500, Volume = 1.2})
        end

        local function popIn() -- Line: 217
            -- upvalues: FlyingCurtain (val), Scale (val), Pivot (val), u30 (val), playPoof (val), u46 (ref), u29 (val)
            -- upvalues: RunService (upval), Workspace (upval), wobbleAt (val), UnixTimestamp (upval)
            -- upvalues: CurtainCountdown (val), CurtainRevealed (val), Timer (val), TweenService (upval), u31 (val)
            local Value
            local v1 = os.clock()
            FlyingCurtain:ScaleTo(Scale * 0.05)
            FlyingCurtain:PivotTo((CFrame.new(Pivot.Position + Vector3.new(0, 0, 0))) * CFrame.Angles(0, 0.03615802939698666, 0.026907620592115246) * Pivot.Rotation)
            for i, j in u30 do
                j()
            end
            playPoof()
            u46 = os.clock()
            u29:Connect(RunService.RenderStepped, function() -- Line: 178
                -- upvalues: Workspace (upval), Pivot (upval), FlyingCurtain (upval), wobbleAt (upval), u46 (upval)
                local CurrentCamera = Workspace.CurrentCamera
                if CurrentCamera ~= nil and 900 < (CurrentCamera.CFrame.Position - Pivot.Position).Magnitude then
                    return
                end
                FlyingCurtain:PivotTo((wobbleAt((os.clock()) - u46)))
            end)
            local v2 = UnixTimestamp - Workspace:GetServerTimeNow()
            local v3 = v2 <= 0
            CurtainCountdown.Enabled = not v3
            CurtainRevealed.Enabled = v3
            if not v3 then
                local v4 = Timer
                local v5 = math.max(0, (math.floor(v2)))
                v4.Text = string.format("%dD %02d:%02d:%02d", v5 // 86400, v5 // 3600 % 24, v5 // 60 % 60, v5 % 60)
            end
            if not v3 then
                u29:Add((task.spawn(function() -- Line: 152
                    -- upvalues: Workspace (upval), UnixTimestamp (upval), CurtainCountdown (upval)
                    -- upvalues: CurtainRevealed (upval), Timer (upval)
                    local v1, v2, v3, v4
                    repeat
                        task.wait(1 - Workspace:GetServerTimeNow() % 1)
                        v2 = UnixTimestamp - Workspace:GetServerTimeNow()
                        v1 = v2 <= 0
                        CurtainCountdown.Enabled = not v1
                        CurtainRevealed.Enabled = v1
                        if not v1 then
                            v3 = Timer
                            v4 = math.max(0, (math.floor(v2)))
                            v3.Text = string.format("%dD %02d:%02d:%02d", v4 // 86400, v4 // 3600 % 24, v4 // 60 % 60, v4 % 60)
                        end
                    until v1
                end)))
            end
            while true do
                v3 = math.min(1, ((os.clock()) - v1) / 0.75)
                Value = TweenService:GetValue(v3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                FlyingCurtain:ScaleTo(Scale * (math.max(0.05, 0.05 + 0.95 * Value)))
                if v3 >= 1 then
                    break
                end
                RunService.RenderStepped:Wait()
            end
            FlyingCurtain:ScaleTo(Scale)
            for k, n in u31 do
                n()
            end
        end

        local function awaitFirstTreadmill() -- Line: 251 -- upvalues: Save (upval), BaseUpgrade (upval)
            if 0 < Save.Await().BaseUpgradeLevel then
                return
            end
            local BindableEvent = Instance.new("BindableEvent")
            local v1 = (Save.Watch("BaseUpgradeLevel")):Connect(function(a1) -- Line: 258 -- upvalues: BindableEvent (val)
                if a1 > 0 then
                    BindableEvent:Fire()
                end
            end)
            BindableEvent.Event:Wait()
            v1:Disconnect()
            BindableEvent:Destroy()
            if BaseUpgrade.Transition.IsPlaying() then
                BaseUpgrade.Transition.Completed:Wait()
            end
            task.wait(2.5)
        end

        hideSign()
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end
        if LocalPlayer.Character == nil then
            LocalPlayer.CharacterAdded:Wait()
        end
        awaitFirstTreadmill()
        task.wait(1.5)
        popIn()
    end,
}