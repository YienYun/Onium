-- Script path: ReplicatedStorage.Controllers.GUI.PlotSignHomeButtonFade
-- Decompile time: 1.73 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Trove = require(ReplicatedStorage.Packages.Trove)
local u14 = {}
u14.__index = u14
local u19 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function u14.new(a1) -- Line: 36 -- upvalues: u14 (val), Trove (val) -- types: a1: userdata
    local Home = a1:FindFirstChild("Home")
    assert(Home ~= nil, "YourBase.Home must exist")
    assert(Home:IsA("ImageButton"), "YourBase.Home must be an ImageButton")
    local v1 = setmetatable({}, u14)
    v1._activeTween = nil
    v1._home = Home
    v1._revision = 0
    v1._trove = Trove.new()
    v1._visible = nil
    v1._yourBase = a1
    return v1
end

function u14.SetVisible(a1, a2) -- Line: 56 -- upvalues: TweenService (val), u19 (val) -- types: a2: boolean
    if a1._visible == a2 then
        return
    end
    a1._visible = a2
    a1._revision = a1._revision + 1
    local _revision = a1._revision
    a1._trove:Clean()
    if a2 then
        a1._yourBase.Enabled = true
    end
    local u27 = TweenService:Create(a1._home, u19, {ImageTransparency = if not a2 then 1 else 0})
    a1._activeTween = u27
    a1._trove:Add(function() -- Line: 74 -- upvalues: a1 (val), u27 (val)
        if a1._activeTween == u27 then
            u27:Cancel()
            a1._activeTween = nil
        end
    end)
    a1._trove:Add((u27.Completed:Connect(function(a1_2) -- Line: 80 -- upvalues: a1 (val), _revision (val), u27 (val), a2 (val)
        if a1._revision == _revision and a1._activeTween == u27 then
            a1._activeTween = nil
            if a1_2 == Enum.PlaybackState.Completed and not a2 then
                a1._yourBase.Enabled = false
            end
            return
        end
    end)))
    u27:Play()
end

function u14:Destroy() -- Line: 93
    self._revision = self._revision + 1
    self._trove:Destroy()
end

return u14