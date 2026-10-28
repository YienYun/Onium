-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.WallTimer
-- Decompile time: 5.35 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local AreaEggResetWall = require(ReplicatedStorage.Client.AreaEggResetWall)
local Audio = require(ReplicatedStorage.Shared.Audio)
local GUI = require(ReplicatedStorage.Client.GUI)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Inside = HalloweenDimension.PlayerAttributes.Inside
local v1 = {}

local function isInside() -- Line: 56 -- upvalues: LocalPlayer (val), Inside (val)
    return LocalPlayer:GetAttribute(Inside) == true
end

local function faceOf(a1) -- Line: 60
    local TextLabel = a1.Frame.TextLabel
    return {
        Gui = a1,
        NightTimer = a1.Frame.NightTimer,
        Stroke = a1.Frame.NightTimer.UIStroke,
        SleepIcon = a1.Frame.SleepIcon,
        Count = TextLabel,
        Scale = TextLabel:FindFirstChildOfClass("UIScale"),
    }
end

local function newAnchor(a1) -- Line: 72 -- upvalues: Workspace (val)
    local v1 = a1:Add((Instance.new("Part")))
    v1.Name = "HalloweenNightWallTimer"
    v1.Anchored = true
    v1.CanCollide = false
    v1.CanQuery = false
    v1.CanTouch = false
    v1.CastShadow = false
    v1.Transparency = 1
    v1.Parent = Workspace
    return v1
end

local function faceCenter(a1) -- Line: 85 -- types: a1: userdata
    return a1.Position + a1.CFrame.LookVector * (a1.Size.Z * 0.5)
end

local function mirror(a1, a2) -- Line: 89 -- types: a1: table, a2: table
    a2.NightTimer.Text = a1.NightTimer.Text
    a2.NightTimer.TextTransparency = a1.NightTimer.TextTransparency
    a2.Stroke.Transparency = a1.Stroke.Transparency
    a2.SleepIcon.Image = a1.SleepIcon.Image
    a2.SleepIcon.ImageTransparency = a1.SleepIcon.ImageTransparency
    a2.Count.Text = a1.Count.Text
    a2.Count.Visible = a1.Count.Visible
    a2.Scale.Scale = a1.Scale.Scale
end

local function bindFace(a1, a2) -- Line: 100
    -- upvalues: GUI (val), faceOf (val), AreaEggResetWall (val), Workspace (val), Audio (val), mirror (val)
    -- upvalues: LocalPlayer (val), Inside (val), RunService (val)
    local u4 = GUI.ResetStartTimer()
    GUI.ResetStartTimerLabelScale()
    local u10 = faceOf(u4)
    local u13 = AreaEggResetWall.ResolveWallPart()
    local u19 = a1:Add((Instance.new("Part")))
    u19.Name = "HalloweenNightWallTimer"
    u19.Anchored = true
    u19.CanCollide = false
    u19.CanQuery = false
    u19.CanTouch = false
    u19.CastShadow = false
    u19.Transparency = 1
    u19.Parent = Workspace
    local u31 = a1:Clone(u4)
    u31.Name = "HalloweenResetStartTimer"
    u31.Enabled = false
    u31.Adornee = u19
    u31.Parent = u4.Parent
    local u37 = faceOf(u31)
    local u40 = a1:Extend()
    local Text = nil

    local function place(a1) -- Line: 117 -- upvalues: u19 (val), u13 (val) -- types: a1: userdata
        u19.Size = Vector3.new(u13.Size.X, a1.Size.Y, a1.Size.Z + 0.1)
        u19.CFrame = a1.CFrame
    end

    local function tickIfCounted(a1) -- Line: 122
        -- upvalues: u10 (val), Text (ref), Audio (upval)
        if not u10.Count.Visible then
            Text = nil
            return
        end
        if u10.Count.Text == Text then
            return
        end
        Text = u10.Count.Text
        Audio.Play(117751546358455, a1.Position + a1.CFrame.LookVector * (a1.Size.Z * 0.5), {Volume = 2, MaxDistance = 220})
    end

    local function step() -- Line: 137
        -- upvalues: a2 (val), u4 (val), u31 (val), u19 (val), u13 (val), mirror (upval), u10 (val), u37 (val)
        -- upvalues: tickIfCounted (val)
        local v1 = a2()
        local Enabled = u4.Enabled
        if Enabled then
            Enabled = false
            if v1 ~= nil then
                Enabled = 0.05 < v1.Size.Y
            end
        end
        u31.Enabled = Enabled
        if v1 ~= nil and Enabled then
            u19.Size = Vector3.new(u13.Size.X, v1.Size.Y, v1.Size.Z + 0.1)
            u19.CFrame = v1.CFrame
            mirror(u10, u37)
            tickIfCounted(v1)
            return
        end
    end

    a1:Connect(LocalPlayer:GetAttributeChangedSignal(Inside), function() -- Line: 149
        -- upvalues: u40 (val), LocalPlayer (upval), Inside (upval), u31 (val), Text (ref), u10 (val)
        -- upvalues: RunService (upval), step (val)
        u40:Clean()
        if not (LocalPlayer:GetAttribute(Inside) == true) then
            u31.Enabled = false
            return
        end
        Text = if not u10.Count.Visible then nil else u10.Count.Text
        u40:Connect(RunService.PreRender, step)
        step()
    end)
    a1:Connect(AreaEggResetWall.Changed, function(a1) -- Line: 161
        -- upvalues: a2 (val), LocalPlayer (upval), Inside (upval), Audio (upval)
        local v1 = a2()
        if not a1 and v1 ~= nil and LocalPlayer:GetAttribute(Inside) == true then
            Audio.Play(136029417452204, v1.Position + v1.CFrame.LookVector * (v1.Size.Z * 0.5), {Volume = 1.5, MaxDistance = 220})
            return
        end
    end)
    u40:Clean()
    if LocalPlayer:GetAttribute(Inside) == true then
        if u10.Count.Visible then
            Text = u10.Count.Text
        end
        u40:Connect(RunService.PreRender, step)
        step()
    else
        u31.Enabled = false
    end
end

function v1.Bind(a1, a2) -- Line: 178 -- upvalues: bindFace (val) -- types: a2: function
    a1:Add((task.spawn(bindFace, a1, a2)))
end

return v1