-- Script path: ReplicatedStorage.Controllers.GUI.TheHollowController.BadgeReveal
-- Decompile time: 12.92 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local TheHollowFlags = require(ReplicatedStorage.Shared.Flags.TheHollowFlags)
local MountRace = require(ReplicatedStorage.Data.MountRace)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Sounds = ReplicatedStorage.Assets.Sounds
local Legendary = Sounds.PrizeSounds.Legendary
local CollectSecretRing = Sounds.LightVsDarknessSounds.CollectSecretRing
local u54 = {
    [Enum.KeyCode.E] = true,
    [Enum.KeyCode.ButtonA] = true,
    [Enum.KeyCode.Space] = true,
}
local u61 = nil
local u62 = false
local v1 = {}

local function template() -- Line: 44 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local TheHollow = Assets and Assets:FindFirstChild("TheHollow")
    local v1 = TheHollow and TheHollow:FindFirstChild("BadgeRevealUI")
    if v1 ~= nil and v1:IsA("ScreenGui") then
        return v1
    end
    return nil
end

local function tween(a1, a2, a3, a4, a5) -- Line: 51
    -- upvalues: TweenService (val)
    local new = TweenInfo.new
    TweenService:Create(a1, new(a2, a4 or Enum.EasingStyle.Quad, a5 or Enum.EasingDirection.Out), a3):Play()
end

local function punch(a1, a2, a3) -- Line: 69
    -- upvalues: TweenService (val)
    if a1 == nil then
        return
    end
    a1.Scale = a2
    local Back = Enum.EasingStyle.Back
    local new = TweenInfo.new
    TweenService:Create(a1, new(a3, Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
end

local function textAlpha(a1, a2, a3) -- Line: 77
    -- upvalues: TweenService (val)
    local UIStroke = a1:FindFirstChildOfClass("UIStroke")
    if a2 <= 0 then
        a1.TextTransparency = a3
        if UIStroke then
            UIStroke.Transparency = a3
        end
        return
    end
    TweenService:Create(a1, TweenInfo.new(a2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = a3}):Play()
    if UIStroke then
        TweenService:Create(UIStroke, TweenInfo.new(a2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = a3}):Play()
    end
end

local function play(a1) -- Line: 92 -- upvalues: Audio (val), SoundService (val) -- types: a1: userdata
    Audio.Play(a1, SoundService, {Volume = 0.6, SoundGroup = "SFX"})
end

local function racing() -- Line: 96 -- upvalues: LocalPlayer (val), MountRace (val)
    return LocalPlayer:GetAttribute(MountRace.PlayerAttributes.RaceId) ~= nil
end

local function bannerShown() -- Line: 100 -- upvalues: LocalPlayer (val)
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local MountRaceUI = PlayerGui and PlayerGui:FindFirstChild("MountRaceUI")
    if MountRaceUI ~= nil and MountRaceUI:IsA("ScreenGui") and MountRaceUI.Enabled then
        local v1 = MountRaceUI:FindFirstChild("FinishBanner")
        local Visible = false
        if v1 ~= nil then
            Visible = v1:IsA("GuiObject") and v1.Visible
        end
        return Visible
    end
    return false
end

local function waitUntilFree() -- Line: 110 -- upvalues: LocalPlayer (val), MountRace (val), bannerShown (val)
    local v1
    local v2 = nil
    while true do
        if LocalPlayer:GetAttribute(MountRace.PlayerAttributes.RaceId) ~= nil then
            v2 = nil
            task.wait(0.25)
            continue
        end
        v1 = v2 or os.clock()
        if not bannerShown() or 8 <= os.clock() - v1 then
            break
        end
        task.wait(0.25)
    end
end

local function reveal(a1, a2) -- Line: 126
    -- upvalues: ReplicatedStorage (val), LocalPlayer (val), TheHollowFlags (val), RunService (val), TweenService (val)
    -- upvalues: Legendary (val), Audio (val), SoundService (val), CollectSecretRing (val), textAlpha (val)
    -- upvalues: UserInputService (val), u54 (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local TheHollow = Assets and Assets:FindFirstChild("TheHollow")
    local v1 = TheHollow and TheHollow:FindFirstChild("BadgeRevealUI")
    local v2 = if v1 == nil then nil else if not v1:IsA("ScreenGui") then nil else v1
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if v2 ~= nil and PlayerGui ~= nil then
        local v3 = a1:Add((v2:Clone()))
        local Reveal = v3.Reveal
        local Holder = Reveal.Holder
        local Flip = Holder.Flip
        local Prize = Holder.Prize
        local Title = Reveal.Title
        local Position = Holder.Position
        local Icon = a2.Icon
        local v4 = false
        if Icon ~= nil then
            v4 = Icon ~= ""
        end
        Flip.Badge.Image = TheHollowFlags.BadgeRevealImage:Get()
        Reveal.Sub.Visible = false
        local v5 = if not v4 then "" else Icon
        Prize.Icon.Image = v5
        Prize.Visible = false
        Reveal.Dim.BackgroundTransparency = 1
        Reveal.Rays.ImageTransparency = 1
        Reveal.Shine.ImageTransparency = 1
        Reveal.Flash.BackgroundTransparency = 1
        local Tap = Reveal.Tap
        v4 = Tap:FindFirstChildOfClass("UIStroke")
        Tap.TextTransparency = 1
        if v4 then
            v4.Transparency = 1
        end
        local v6 = Title:FindFirstChildOfClass("UIStroke")
        Title.TextTransparency = 1
        if v6 then
            v6.Transparency = 1
        end
        local Event = Reveal.Event
        local v7 = Event:FindFirstChildOfClass("UIStroke")
        Event.TextTransparency = 1
        if v7 then
            v7.Transparency = 1
        end
        local Sub = Reveal.Sub
        local UIStroke = Sub:FindFirstChildOfClass("UIStroke")
        Sub.TextTransparency = 1
        if UIStroke then
            UIStroke.Transparency = 1
        end
        Holder.Position = UDim2.fromScale(Position.X.Scale, -0.4)
        Holder.Rotation = -25
        v3.Enabled = true
        v3.Parent = PlayerGui
        local u154 = (os.clock())
        a1:Connect(RunService.RenderStepped, function() -- Line: 161 -- upvalues: u154 (val), Flip (val), Reveal (val)
            local v1 = os.clock() - u154
            local v2 = math.max(0, 1 - v1 / 0.9)
            Flip.Size = UDim2.fromScale(
                math.max(math.abs((math.cos(v2 * v2 * 3.141592653589793 * 4 + math.sin(v1 * 0.9) * 0.3141592653589793))), 0.02),
                1
            )
            Flip.Position = UDim2.fromScale(0.5, math.sin(v1 * 2) * 0.012 + 0.5)
            Flip.Rotation = math.sin(v1 * 1.3) * 3
            Reveal.Rays.Rotation = v1 * 36
            Reveal.Shine.Rotation = v1 * -22
        end)
        TweenService:Create(
            Reveal.Dim,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.35}
        ):Play()
        local Back = Enum.EasingStyle.Back
        local new = TweenInfo.new
        TweenService:Create(Holder, new(0.55, Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 4, Position = Position}):Play()
        Audio.Play(Legendary, SoundService, {Volume = 0.6, SoundGroup = "SFX"})
        task.wait(0.5)
        local Sine = Enum.EasingStyle.Sine
        local new_2 = TweenInfo.new
        TweenService:Create(Holder, new_2(0.3, Sine or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
        TweenService:Create(Reveal.Rays, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.25}):Play()
        TweenService:Create(Reveal.Shine, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0.45}):Play()
        task.wait(0.4)
        Audio.Play(CollectSecretRing, SoundService, {Volume = 0.6, SoundGroup = "SFX"})
        local UIScale = Holder:FindFirstChildOfClass("UIScale")
        if UIScale ~= nil then
            UIScale.Scale = 1.08
            local Back_2 = Enum.EasingStyle.Back
            local new_3 = TweenInfo.new
            TweenService:Create(UIScale, new_3(0.3, Back_2 or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
        end
        Reveal.Flash.BackgroundTransparency = 0.55
        TweenService:Create(
            Reveal.Flash,
            TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
        ):Play()
        v1 = Title:FindFirstChildOfClass("UIStroke")
        Title.TextTransparency = 0
        if v1 then
            v1.Transparency = 0
        end
        local UIScale_2 = Title:FindFirstChildOfClass("UIScale")
        if UIScale_2 ~= nil then
            UIScale_2.Scale = 1.5
            local Back_3 = Enum.EasingStyle.Back
            local new_4 = TweenInfo.new
            TweenService:Create(UIScale_2, new_4(0.4, Back_3 or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
        end
        textAlpha(Reveal.Event, 0.3, 0)
        textAlpha(Reveal.Sub, 0.4, 0)
        task.wait(0.6)
        textAlpha(Reveal.Tap, 0.4, 0.45)
        local u403 = false
        a1:Connect(Reveal.Catch.Activated, function() -- Line: 192 -- upvalues: u403 (ref)
            u403 = true
        end)
        a1:Connect(UserInputService.InputBegan, function(a1) -- Line: 195 -- upvalues: u54 (upval), u403 (ref) -- types: a1: userdata
            if u54[a1.KeyCode] then
                u403 = true
            end
        end)
        v5 = os.clock()
        while not u403 do
            if not (os.clock() - v5 < 4) then
                break
            end
            task.wait()
        end
        local v8 = {Rotation = 15, Position = UDim2.fromScale(Position.X.Scale, 1.4)}
        local Back_4 = Enum.EasingStyle.Back
        local In = Enum.EasingDirection.In
        local new_5 = TweenInfo.new
        TweenService:Create(Holder, new_5(0.35, Back_4 or Enum.EasingStyle.Quad, In or Enum.EasingDirection.Out), v8):Play()
        TweenService:Create(Reveal.Dim, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
        textAlpha(Title, 0.3, 1)
        textAlpha(Reveal.Event, 0.3, 1)
        textAlpha(Reveal.Sub, 0.3, 1)
        textAlpha(Reveal.Tap, 0.3, 1)
        TweenService:Create(Reveal.Rays, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
        TweenService:Create(Reveal.Shine, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
        task.wait(0.4)
        return
    end
    warn("TheHollow: ReplicatedStorage.Assets.TheHollow.BadgeRevealUI is missing")
end

function v1.Show(a1) -- Line: 222
    -- upvalues: u61 (ref), u62 (ref), waitUntilFree (val), LocalPlayer (val), MountRace (val), Trove (val)
    -- upvalues: reveal (val)
    u61 = a1
    if u62 then
        return
    end
    u62 = true
    task.spawn(function() -- Line: 228
        -- upvalues: u61 (upval), waitUntilFree (upval), LocalPlayer (upval), MountRace (upval), Trove (upval)
        -- upvalues: reveal (upval), u62 (upval)
        local err, success, v1, v2
        while u61 ~= nil do
            waitUntilFree()
            task.wait(1)
            v1 = u61
            v2 = LocalPlayer:GetAttribute(MountRace.PlayerAttributes.RaceId) ~= nil
            if not v2 and v1 ~= nil then
                u61 = nil
                v2 = Trove.new()
                success, err = pcall(reveal, v2, v1)
                v2:Destroy()
                if not success then
                    warn((("TheHollow: badge reveal failed: %*"):format(err)))
                end
            end
        end
        u62 = false
    end)
end

return (table.freeze(v1))