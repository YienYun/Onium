-- Script path: ReplicatedStorage.Controllers.GUI.MoneyUpdateController
-- Decompile time: 12.67 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
local AddCommas = require(ReplicatedStorage.Shared.Utils.Numbers).AddCommas
local Hud = require(ReplicatedStorage.Client.Hud)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Preferences = require(ReplicatedStorage.Shared.Preferences)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local u55 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u60 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local u65 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.InOut)
local u70 = TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local u71 = 0
local u72 = 0
local u73 = 1
local u74 = nil
local u75 = nil
local u76 = 0
return {
    Start = function() -- Line: 40
        -- upvalues: SoundService (val), ReplicatedStorage (val), Hud (val), Preferences (val), u72 (ref), u73 (ref)
        -- upvalues: TweenService (val), u60 (val), u65 (val), u70 (val), Debris (val), Simple (val), t (val)
        -- upvalues: AddCommas (val), u74 (ref), u75 (ref), u55 (val), Save (val), u71 (ref), u76 (ref), Remotes (val)
        local CashCollect = SoundService.CashCollect
        local MoneyChange = ReplicatedStorage.Assets.MoneyChange
        local Money = Hud.Get("Money")
        local MoneyValue = Hud.Every("MoneyValue")

        local function playCashCollectSound() -- Line: 55
            -- upvalues: Preferences (upval), u72 (upval), u73 (upval), CashCollect (val)
            if not Preferences.IsOn("SFX") then
                return
            end
            if 2 < tick() - u72 or u73 >= 3 then
                u73 = 1
            end
            tick()
            CashCollect.TimePosition = 0
            CashCollect.PlaybackSpeed = u73
            CashCollect:Play()
            u73 = u73 + 0.07
        end

        local function createMoneyChangeClone() -- Line: 72 -- upvalues: MoneyChange (val)
            local v1 = MoneyChange:Clone()
            local Label = v1.Label
            local UIScale = v1.UIScale
            local UIStroke = Label.UIStroke
            local More = Label.More
            local Less = Label.Less
            local Icon = v1.Icon
            Label.TextTransparency = 1
            UIStroke.Transparency = 1
            UIScale.Scale = 0
            Icon.ImageTransparency = 1
            return v1, Label, UIScale, UIStroke, Icon, More, Less
        end

        local function getTransparencyProperty(a1) -- Line: 97 -- types: a1: userdata
            if not a1:IsA("ImageLabel") and not a1:IsA("ImageButton") then
                if not a1:IsA("TextLabel") and not a1:IsA("TextButton") then
                    if a1:IsA("UIStroke") then
                        return "Transparency"
                    end
                    return nil
                end
                return "TextTransparency"
            end
            return "ImageTransparency"
        end

        local function animateNotification(a1, a2, a3, a4, a5) -- Line: 109
            -- upvalues: TweenService (upval), u60 (upval), u65 (upval), getTransparencyProperty (val), u70 (upval)
            -- upvalues: Debris (upval)
            local v1
            TweenService:Create(a2, u60, {TextTransparency = 0.25}):Play()
            TweenService:Create(a4, u60, {Transparency = 0.25}):Play()
            TweenService:Create(a3, u65, {Scale = 1}):Play()
            for i, v in ipairs(a5) do
                v1 = getTransparencyProperty(v)
                if v1 then
                    if v1 == "ImageTransparency" then
                        v.ImageTransparency = 1
                    elseif v1 == "TextTransparency" then
                        v.TextTransparency = 1
                    elseif v1 == "Transparency" then
                        v.Transparency = 1
                    end
                    TweenService:Create(v, u60, {[v1] = 0}):Play()
                end
            end
            task.delay(1, function() -- Line: 135
                -- upvalues: TweenService (upval), a2 (val), u70 (upval), a4 (val), a5 (val)
                -- upvalues: getTransparencyProperty (upval), Debris (upval), a1 (val)
                local v1
                TweenService:Create(a2, u70, {TextTransparency = 1}):Play()
                TweenService:Create(a4, u70, {Transparency = 1}):Play()
                for i, v in ipairs(a5) do
                    v1 = getTransparencyProperty(v)
                    if v1 then
                        TweenService:Create(v, u70, {[v1] = 1}):Play()
                    end
                end
                Debris:AddItem(a1, 0.75)
            end)
        end

        local function spawnFloatingMoney(a1, a2) -- Line: 150
            -- upvalues: MoneyChange (val), Simple (upval), Money (val), animateNotification (val)
            local v1
            local v2 = if not (a1 < 0) then "+" else "-"
            local v3 = MoneyChange:Clone()
            local Label = v3.Label
            local UIScale = v3.UIScale
            local UIStroke = Label.UIStroke
            local More = Label.More
            local Less = Label.Less
            local Icon = v3.Icon
            Label.TextTransparency = 1
            UIStroke.Transparency = 1
            UIScale.Scale = 0
            Icon.ImageTransparency = 1
            local v4 = v3
            local v5 = Label
            local v6 = More
            local v7 = Less
            if v6 and v6:IsA("UIGradient") then
                v6.Enabled = not v1
            end
            if v7 and v7:IsA("UIGradient") then
                v7.Enabled = v1
            end
            v5.Text = v2 .. "$" .. Simple.FormatCompact(math.round((math.abs(a1))), ".#")
            Icon.Visible = false
            v4.ZIndex = 10
            v4.Parent = Money
            animateNotification(v4, v5, UIScale, UIStroke, {})
        end

        local function displayMoneyChange(a1, a2, a3) -- Line: 176
            -- upvalues: playCashCollectSound (val), spawnFloatingMoney (val)
            if a1 == 0 then
                return
            end
            if a1 > 0 and a3 ~= false then
                playCashCollectSound()
            end
            spawnFloatingMoney(a1, a2)
        end

        local function updateMoneyLabels(a1) -- Line: 188 -- upvalues: t (upval), MoneyValue (val) -- types: a1: string
            local Shadow
            t.strict(t.string)(a1)
            for i, j in MoneyValue do
                j.Text = a1
                Shadow = j:FindFirstChild("Shadow")
                if Shadow ~= nil then
                    Shadow.Text = a1
                end
            end
        end

        local function formatMoneyText(a1) -- Line: 200
            -- upvalues: Simple (upval), AddCommas (upval)
            if a1 > 99999 then
                return "$" .. Simple.FormatCompact(math.round(a1), ".#")
            end
            return "$" .. AddCommas((math.round(a1)))
        end

        local function cancelMoneyLabelTween() -- Line: 208 -- upvalues: u74 (upval), u75 (upval)
            if u74 then
                u74:Cancel()
                u74 = nil
            end
            if u75 then
                u75:Destroy()
                u75 = nil
            end
        end

        local function setMoneyLabelValue(a1) -- Line: 220
            -- upvalues: updateMoneyLabels (val), Simple (upval), AddCommas (upval)
            updateMoneyLabels(if not (a1 > 99999) then "$" .. AddCommas((math.round(a1))) else "$" .. Simple.FormatCompact(math.round(a1), ".#"))
        end

        local function tweenMoneyLabelValue(a1, a2) -- Line: 222
            -- upvalues: u74 (upval), u75 (upval), updateMoneyLabels (val), Simple (upval), AddCommas (upval)
            -- upvalues: setMoneyLabelValue (val), TweenService (upval), u55 (upval)
            if u74 then
                u74:Cancel()
                u74 = nil
            end
            if u75 then
                u75:Destroy()
                u75 = nil
            end
            local NumberValue = Instance.new("NumberValue")
            NumberValue.Value = a1
            u75 = NumberValue
            updateMoneyLabels(if not (a1 > 99999) then "$" .. AddCommas((math.round(a1))) else "$" .. Simple.FormatCompact(math.round(a1), ".#"))
            NumberValue.Changed:Connect(setMoneyLabelValue)
            local u55_2 = TweenService:Create(NumberValue, u55, {Value = a2})
            u74 = u55_2
            u55_2.Completed:Once(function(a1) -- Line: 235
                -- upvalues: u74 (upval), u55_2 (val), u75 (upval), a2 (val), updateMoneyLabels (upval), Simple (upval)
                -- upvalues: AddCommas (upval), NumberValue (val)
                if u74 ~= u55_2 then
                    return
                end
                u74 = nil
                u75 = nil
                if a1 == Enum.PlaybackState.Completed then
                    local v1 = a2
                    updateMoneyLabels(if not (v1 > 99999) then "$" .. AddCommas((math.round(v1))) else "$" .. Simple.FormatCompact(math.round(v1), ".#"))
                end
                NumberValue:Destroy()
            end)
            u55_2:Play()
        end

        local function updateMoney(a1) -- Line: 252
            -- upvalues: Save (upval), u71 (upval), u75 (upval), tweenMoneyLabelValue (val), u74 (upval)
            -- upvalues: updateMoneyLabels (val), Simple (upval), AddCommas (upval), u76 (upval)
            -- upvalues: playCashCollectSound (val), spawnFloatingMoney (val)
            local v1 = Save.Await()
            if not v1 then
                return
            end
            local Money = v1.Money
            local forceUpdate = a1 and a1.forceUpdate
            if Money == u71 and not forceUpdate then
                return
            end
            local v2 = not forceUpdate and u71 < Money
            if not v2 then
                if u74 then
                    u74:Cancel()
                    u74 = nil
                end
                if u75 then
                    u75:Destroy()
                    u75 = nil
                end
                updateMoneyLabels(if not (Money > 99999) then "$" .. AddCommas((math.round(Money))) else "$" .. Simple.FormatCompact(math.round(Money), ".#"))
            else
                tweenMoneyLabelValue(if not u75 then u71 else u75.Value, Money)
            end
            if not forceUpdate then
                local v3
                v2 = Money - u71
                if v2 > 0 and u76 > 0 then
                    v3 = math.min(v2, u76)
                    v2 = v2 - v3
                    u76 = u76 - v3
                end
                if v2 ~= 0 then
                    v3 = v2 > 0
                    local allowPositiveAnimation = if not a1 then true else if a1.allowPositiveAnimation == nil then true else a1.allowPositiveAnimation
                    if not v3 then
                        if v2 ~= 0 then
                            if v2 > 0 then
                                playCashCollectSound()
                            end
                            spawnFloatingMoney(v2, nil)
                        end
                    elseif allowPositiveAnimation and v2 ~= 0 then
                        if v2 > 0 then
                            playCashCollectSound()
                        end
                        spawnFloatingMoney(v2, nil)
                    end
                end
            end
            u71 = Money
        end

        Save.Loaded:Connect(function() -- Line: 301 -- upvalues: updateMoney (val)
            updateMoney({forceUpdate = true})
        end)
        local Treadmill = Hud.Frame("Treadmill")
        ;(Treadmill:GetPropertyChangedSignal("Visible")):Connect(function() -- Line: 304 -- upvalues: Treadmill (val), updateMoney (val)
            if Treadmill.Visible then
                updateMoney({forceUpdate = true})
            end
        end)
        updateMoney({forceUpdate = true})
        Save.Changed:Connect(function(a1) -- Line: 312 -- upvalues: updateMoney (val) -- types: a1: string
            if a1 == "Money" then
                updateMoney({allowPositiveAnimation = false})
            end
        end)
        Remotes.PenRoster.CoinsGathered.OnClientEvent:Connect(function(a1, a2) -- Line: 319
            -- upvalues: playCashCollectSound (val), spawnFloatingMoney (val), u76 (upval)
            if a1 and not a2 then
                local amount_3, icon, v1
                local v2 = 0
                local v3 = false
                for i, v in ipairs(a1) do
                    if v and typeof(v.amount) == "number" then
                        v2 = v2 + math.max(v.amount, 0)
                        v1 = v.playSound ~= false and not v3
                        amount_3 = v.amount
                        icon = v.icon
                        if amount_3 ~= 0 then
                            if amount_3 > 0 and v1 ~= false then
                                playCashCollectSound()
                            end
                            spawnFloatingMoney(amount_3, icon)
                        end
                        if 0 < v.amount and v1 then end
                    end
                end
                if v2 > 0 then
                    u76 = u76 + v2
                end
                return
            end
        end)
    end,
}