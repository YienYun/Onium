-- Script path: ReplicatedStorage.Controllers.Game.TreadmillAdPopupController
-- Decompile time: 11.79 ms

return {
    Start = function() -- Line: 6
        print("[TreadmillAdPopup] Booted")
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local RunService = game:GetService("RunService")
        local AdEggBoostClient = require(script.AdEggBoostClient)
        local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
        local GUI = require(ReplicatedStorage.Client.GUI)
        require(ReplicatedStorage.Shared.Audio)
        local AdEggBoostRemotes = ReplicatedStorage:WaitForChild("AdEggBoostRemotes")
        local Remotes = require(ReplicatedStorage.Shared.Remotes)
        local Sparkles = require(ReplicatedStorage.Client.UI.VFX.Sparkles)
        local u55 = game:GetService("TweenService")

        local function dbg(a1) -- Line: 47 -- types: a1: string
            print("[TreadmillAdPopup]", a1)
        end

        local u58 = false
        local u59 = false
        local u60 = false
        local u61 = false
        local u62 = false
        local u63 = 0
        local u73 = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("AdEggBoostPopupUI")
        local u78 = u73:WaitForChild("Container")
        local UIScale = u78:WaitForChild("UIScale")
        local Close = u78:WaitForChild("Close")
        local Claim = u78:WaitForChild("Claim")
        local Select = u78:WaitForChild("Select")
        local Shine = Select:WaitForChild("Shine")
        local Audio_2 = u73:WaitForChild("Audio")
        local OnHover = Audio_2:WaitForChild("OnHover")
        local OnOpen = Audio_2:WaitForChild("OnOpen")
        local OnClick = Audio_2:WaitForChild("OnClick")
        u73.ResetOnSpawn = false
        Select.Visible = false
        Shine.Offset = Vector2.new(1, 0)
        ;(u73:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 81 -- upvalues: u73 (val), u60 (ref)
            if u73.Enabled and not u60 then
                u73.Enabled = false
            end
        end)
        local u129 = nil
        local u130 = 0

        local function startPulse() -- Line: 92
            -- upvalues: u129 (ref), u130 (ref), RunService (val), u60 (ref), UIScale (val), u63 (ref)
            if u129 then
                return
            end
            u130 = 0
            RunService.RenderStepped:Connect(function(a1) -- Line: 97 -- upvalues: u60 (upval), u130 (upval), UIScale (upval), u63 (upval) -- types: a1: number
                if not u60 then
                    return
                end
                u130 = u130 + a1
                local v1 = math.sin(u130 * 2.0943951023931953) * 0.02
                UIScale.Scale = v1 + 1 + u63
            end)
        end

        local function stopPulse() -- Line: 107 -- upvalues: u129 (ref), u63 (ref), UIScale (val)
            if u129 then
                u129:Disconnect()
                u129 = nil
            end
            u63 = 0
            UIScale.Scale = 1
        end

        local EggImage = u78:WaitForChild("Design"):WaitForChild("EggImage")
        local u141 = nil
        local u142 = false

        local function rattleEgg() -- Line: 122 -- upvalues: u142 (ref), RunService (val), EggImage (val)
            local v1
            if u142 then
                return
            end
            u142 = true
            local v2 = 0
            while v2 < 2 do
                v2 = v2 + RunService.RenderStepped:Wait()
                v1 = 1 - v2 / 2
                EggImage.Rotation = math.sin(v2 * 9.42477796076938) * 10 * v1
            end
            EggImage.Rotation = 0
            u142 = false
        end

        local function runRattleLoop() -- Line: 140 -- upvalues: u60 (ref), rattleEgg (val)
            while u60 do
                task.wait(5 + math.random() * 5)
                if u60 then
                    rattleEgg()
                end
            end
        end

        local function startRattle() -- Line: 150 -- upvalues: u141 (ref), runRattleLoop (val)
            if u141 then
                return
            end
            task.spawn(runRattleLoop)
        end

        local function stopRattle() -- Line: 157 -- upvalues: u141 (ref), EggImage (val), u142 (ref)
            if u141 then
                task.cancel(u141)
                u141 = nil
            end
            EggImage.Rotation = 0
            u142 = false
        end

        local u147 = nil
        local u148 = nil

        local function startSparkles() -- Line: 170
            -- upvalues: u147 (ref), Sparkles (val), EggImage (val), u148 (ref), u78 (val)
            if not u147 then
                Sparkles(EggImage, {Size = 0.6, Pace = 2, Lanes = 7})
            end
            if not u148 then
                Sparkles(u78, {Size = 0.3, Pace = 1, Lanes = 1})
            end
        end

        local function clearSparkles() -- Line: 179 -- upvalues: u147 (ref), u148 (ref)
            if u147 then
                u147()
                u147 = nil
            end
            if u148 then
                u148()
                u148 = nil
            end
        end

        local function showPopup() -- Line: 191
            -- upvalues: u60 (ref), AdEggBoostRemotes (val), u73 (val), UIScale (val), u55 (val), OnOpen (val)
            -- upvalues: u129 (ref), u130 (ref), RunService (val), u63 (ref), startSparkles (val), rattleEgg (val)
            -- upvalues: u141 (ref), runRattleLoop (val)
            if u60 then
                print("[TreadmillAdPopup]", "showPopup skipped - already visible")
                return
            end
            print("[TreadmillAdPopup]", "showPopup")
            u60 = true
            AdEggBoostRemotes.LogTelemetry:FireServer("RegisterOpportunity")
            u73.Enabled = true
            UIScale.Scale = 1.35
            u55:Create(UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
            OnOpen:Play()
            if not u129 then
                u130 = 0
                RunService.RenderStepped:Connect(function(a1) -- Line: 97 -- upvalues: u60 (upval), u130 (upval), UIScale (upval), u63 (upval) -- types: a1: number
                    if not u60 then
                        return
                    end
                    u130 = u130 + a1
                    local v1 = math.sin(u130 * 2.0943951023931953) * 0.02
                    UIScale.Scale = v1 + 1 + u63
                end)
            end
            startSparkles()
            task.spawn(rattleEgg)
            if u141 then
                return
            end
            task.spawn(runRattleLoop)
        end

        local function hidePopup() -- Line: 209
            -- upvalues: u60 (ref), u129 (ref), u63 (ref), UIScale (val), u147 (ref), u148 (ref), u141 (ref)
            -- upvalues: EggImage (val), u142 (ref), Select (val), u55 (val), u73 (val)
            if not u60 then
                return
            end
            print("[TreadmillAdPopup]", "hidePopup")
            u60 = false
            if u129 then
                u129:Disconnect()
                u129 = nil
            end
            u63 = 0
            UIScale.Scale = 1
            if u147 then
                u147()
                u147 = nil
            end
            if u148 then
                u148()
                u148 = nil
            end
            if u141 then
                task.cancel(u141)
                u141 = nil
            end
            EggImage.Rotation = 0
            u142 = false
            Select.Visible = false
            u55:Create(UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 0}):Play()
            task.delay(0.2, function() -- Line: 220 -- upvalues: u60 (upval), u73 (upval), UIScale (upval)
                if not u60 then
                    u73.Enabled = false
                    UIScale.Scale = 1
                end
            end)
        end

        local function tryShowPrompt() -- Line: 229
            -- upvalues: u59 (ref), u58 (ref), u61 (ref), AdEggBoostClient (val), showPopup (val)
            local v1 = "tryShowPrompt: silenced=" .. (tostring(u59)) .. " onTreadmill=" .. (tostring(u58)) .. " adPending=" .. tostring(u61)
            print("[TreadmillAdPopup]", v1)
            if not u59 and u58 and not u61 and not AdEggBoostClient.IsGated() then
                task.spawn(function() -- Line: 235 -- upvalues: AdEggBoostClient (upval), u58 (upval), u59 (upval), showPopup (upval)
                    print("[TreadmillAdPopup]", "tryShowPrompt - checking ad availability")
                    local v1 = AdEggBoostClient.CheckAdAvailable()
                    local v2 = "tryShowPrompt - available=" .. (tostring(v1)) .. " onTreadmill=" .. (tostring(u58)) .. " silenced=" .. tostring(u59)
                    print("[TreadmillAdPopup]", v2)
                    if v1 and u58 and not u59 then
                        showPopup()
                    end
                end)
                return
            end
            print("[TreadmillAdPopup]", "tryShowPrompt - blocked")
        end

        local u154 = nil

        local function easeLinear(a1) -- Line: 248 -- types: a1: number
            return a1
        end

        local function easeBackOut(a1) -- Line: 252 -- types: a1: number
            local v1 = a1 - 1
            return v1 * v1 * (v1 * 2.70158 + 1.70158) + 1
        end

        local function sweepOffset(a1, a2, a3) -- Line: 258
            -- upvalues: RunService (val), Shine (val)
            local v1 = 0
            local v2 = a2 - a1
            while v1 < 0.2 do
                v1 = v1 + RunService.RenderStepped:Wait()
                Shine.Offset = Vector2.new(a1 + v2 * a3((math.clamp(v1 / 0.2, 0, 1))), 0)
            end
            Shine.Offset = Vector2.new(a2, 0)
        end

        local function runShine() -- Line: 270
            -- upvalues: Shine (val), sweepOffset (val), easeLinear (val), easeBackOut (val), u154 (ref)
            local X = Shine.Offset.X
            if X < 1 then
                sweepOffset(X, 1, easeLinear)
            end
            Shine.Offset = Vector2.new(-1, 0)
            sweepOffset(-1, 0, easeBackOut)
            u154 = nil
        end

        local function startShine() -- Line: 287
            -- upvalues: u154 (ref), Shine (val), sweepOffset (val), easeBackOut (val), runShine (val)
            if u154 then
                task.cancel(u154)
                u154 = nil
            end
            local X = Shine.Offset.X
            if X < 0 then
                task.spawn(function() -- Line: 297 -- upvalues: sweepOffset (upval), X (val), easeBackOut (upval), u154 (upval)
                    sweepOffset(X, 0, easeBackOut)
                    u154 = nil
                end)
                return
            end
            task.spawn(runShine)
        end

        local function stopShine() -- Line: 306 -- upvalues: u154 (ref)
            if u154 then
                task.cancel(u154)
                u154 = nil
            end
        end

        Claim.MouseEnter:Connect(function() -- Line: 314
            -- upvalues: u62 (ref), Select (val), u63 (ref), startShine (val), rattleEgg (val), OnHover (val)
            u62 = true
            Select.Visible = true
            u63 = 0.08
            startShine()
            task.spawn(rattleEgg)
            OnHover:Play()
        end)
        Claim.MouseLeave:Connect(function() -- Line: 323 -- upvalues: u62 (ref), Select (val), u63 (ref)
            u62 = false
            Select.Visible = false
            u63 = 0
        end)
        AdEggBoostClient.AdCompleted:Connect(function(a1) -- Line: 363 -- upvalues: u61 (ref), u58 (ref), tryShowPrompt (val) -- types: a1: boolean
            u61 = false
            if u58 then
                task.delay(30, tryShowPrompt)
            end
        end)
        Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(a1) -- Line: 373 -- upvalues: u58 (ref), tryShowPrompt (val), hidePopup (val) -- types: a1: string?
            u58 = a1 ~= nil
            local v1 = "AssignedBeltShifted: treadmillId=" .. (tostring(a1)) .. " onTreadmill=" .. tostring(u58)
            print("[TreadmillAdPopup]", v1)
            if not u58 then
                print("[TreadmillAdPopup]", "Dismounted - hiding popup")
                hidePopup()
                return
            end
            v1 = "Mounted - waiting " .. 1 .. "s before tryShowPrompt"
            print("[TreadmillAdPopup]", v1)
            task.delay(1, tryShowPrompt)
        end)
        local u185 = {}
        for i, j in u78:GetDescendants() do
            if j.Name == "Rays" and j:IsA("GuiObject") then
                table.insert(u185, j)
            end
        end
        RunService.RenderStepped:Connect(function(a1) -- Line: 393 -- upvalues: u60 (ref), u185 (val) -- types: a1: number
            if not u60 then
                return
            end
            for i, j in u185 do
                j.Rotation = (j.Rotation + a1 * 22.5) % 360
            end
        end)
        GUI.OnActivated(Claim, function() -- Line: 330
            -- upvalues: u61 (ref), OnClick (val), u63 (ref), Select (val), hidePopup (val), AdEggBoostClient (val)
            print("[TreadmillAdPopup]", "onClaimClicked")
            if u61 then
                print("[TreadmillAdPopup]", "onClaimClicked - blocked, ad pending")
                return
            end
            OnClick:Play()
            u63 = -0.08
            Select.Visible = true
            task.delay(0.1, function() -- Line: 341 -- upvalues: Select (upval), u63 (upval)
                Select.Visible = false
                u63 = 0
            end)
            u61 = true
            hidePopup()
            AdEggBoostClient.RequestAd()
        end)
        ButtonFX(Claim, 1.08)
        GUI.OnActivated(Close, function() -- Line: 352 -- upvalues: AdEggBoostRemotes (val), hidePopup (val), u59 (ref)
            local v1 = "onCloseClicked - silencing for " .. 120 .. "s"
            print("[TreadmillAdPopup]", v1)
            AdEggBoostRemotes.LogTelemetry:FireServer("PopupDismissed")
            hidePopup()
            u59 = true
            task.delay(120, function() -- Line: 357 -- upvalues: u59 (upval)
                u59 = false
            end)
        end)
    end,
}