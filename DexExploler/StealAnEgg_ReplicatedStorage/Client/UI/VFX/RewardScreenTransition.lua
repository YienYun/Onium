-- Script path: ReplicatedStorage.Client.UI.VFX.RewardScreenTransition
-- Decompile time: 1.96 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local OverlayRoot = require(ReplicatedStorage.Client.UI.VFX.OverlayRoot)

local function quintOut(a1, a2) -- Line: 9 -- types: a1: number, a2: number?
    return TweenInfo.new(a1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, a2 or 0)
end

local u21 = {
    pitch = 1,
    lensWide = 100,
    lensResting = 70,
    cues = {{id = 91650233387983, volume = 0.8}, {id = 112792997660073, volume = 1}},
}
u21.sheetProperties = {
    BackgroundTransparency = 0,
    BackgroundColor3 = Color3.fromRGB(255, 175, 0),
    Size = UDim2.new(1, 0, 1, 0),
}
u21.sheetFade = TweenInfo.new(1.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0.05)
u21.lensPush = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0.05)
u21.lensSettle = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0)

local function stage(a1, a2, a3) -- Line: 38
    -- upvalues: TweenService (val)
    return TweenService:Create(a1, a2, a3)
end

return function() -- Line: 42 -- upvalues: u21 (val), Audio (val), OverlayRoot (val), TweenService (val)
    for i, j in u21.cues do
        Audio.Play(j.id, script, {PlaybackSpeed = u21.pitch, Volume = j.volume})
    end
    local Frame = Instance.new("Frame")
    for k, n in u21.sheetProperties do
        Frame[k] = n
    end
    Frame.Parent = OverlayRoot()
    local CurrentCamera = workspace.CurrentCamera
    local u42 = TweenService:Create(CurrentCamera, u21.lensSettle, {FieldOfView = u21.lensResting})
    local v1 = TweenService:Create(CurrentCamera, u21.lensPush, {FieldOfView = u21.lensWide})
    local v2 = TweenService:Create(Frame, u21.sheetFade, {BackgroundTransparency = 1})
    v1.Completed:Once(function() -- Line: 64 -- upvalues: u42 (val)
        u42:Play()
    end)
    v2.Completed:Once(function() -- Line: 65 -- upvalues: Frame (val)
        Frame:Destroy()
    end)
    v1:Play()
    v2:Play()
end