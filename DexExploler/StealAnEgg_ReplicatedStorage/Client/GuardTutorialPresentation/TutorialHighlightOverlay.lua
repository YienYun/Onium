-- Script path: ReplicatedStorage.Client.GuardTutorialPresentation.TutorialHighlightOverlay
-- Decompile time: 2.77 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local GUI = require(ReplicatedStorage.Client.GUI)
local TutorialProp = require(script.Parent.TutorialProp)
local t = require(ReplicatedStorage.Packages.t)
local u28 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u32 = UDim2.fromScale(0.01, 0.01)
local u33 = {"AbsolutePosition", "AbsoluteSize"}
local u40 = t.strict(t.instanceIsA("GuiObject"))
local v1 = {}

local function ringGoal(a1, a2) -- Line: 26 -- types: a1: userdata, a2: userdata
    local AbsoluteSize = a1.AbsoluteSize
    local v1 = a1.AbsolutePosition + AbsoluteSize * 0.5 - a2.AbsolutePosition
    return {
        Size = UDim2.new(0, AbsoluteSize.X * 1.15, 0, AbsoluteSize.Y * 1.15),
        Position = UDim2.new(0, v1.X, 0, v1.Y),
    }
end

local function tutorialLayerHost() -- Line: 35 -- upvalues: GUI (val)
    local v1 = GUI.TutorialInstructions()
    assert(v1:IsA("ScreenGui"), "the tutorial instruction layer is not a ScreenGui")
    local Parent = v1.Parent
    assert(Parent and Parent:IsA("PlayerGui"), "the tutorial instruction layer sits outside PlayerGui")
    return Parent
end

function v1.Attach(a1) -- Line: 44
    -- upvalues: u40 (val), TutorialProp (val), GUI (val), u32 (val), ringGoal (val), TweenService (val), u28 (val)
    -- upvalues: u33 (val)
    u40(a1)
    local u8, v1 = TutorialProp.Clone("ClickTarget", "GuardTutorialHighlight")
    u8.Enabled = true
    local v2 = GUI.TutorialInstructions()
    assert(v2:IsA("ScreenGui"), "the tutorial instruction layer is not a ScreenGui")
    local Parent = v2.Parent
    assert(Parent and Parent:IsA("PlayerGui"), "the tutorial instruction layer sits outside PlayerGui")
    u8.Parent = Parent
    local Container = u8.Container
    assert(Container:IsA("Frame"), "the highlight template has no Container frame")
    Container.Size = u32
    local u42 = nil

    local function reseat() -- Line: 64
        -- upvalues: ringGoal (upval), a1 (val), u8 (val), u42 (ref), TweenService (upval), Container (val), u28 (upval)
        local v1 = ringGoal(a1, u8)
        if u42 then
            u42:Cancel()
            u42:Destroy()
        end
        local v2 = TweenService:Create(Container, u28, v1)
        u42 = v2
        v2:Play()
    end

    local v3 = ringGoal(a1, u8)
    if u42 then
        u42:Cancel()
        u42:Destroy()
    end
    ;(TweenService:Create(Container, u28, v3)):Play()
    for i, j in u33 do
        v1:Add(((a1:GetPropertyChangedSignal(j)):Connect(reseat)))
    end
    v1:Add(((u8:GetPropertyChangedSignal("AbsolutePosition")):Connect(reseat)))
    v1:Add(function() -- Line: 57 -- upvalues: u42 (ref)
        if u42 then
            u42:Cancel()
            u42:Destroy()
        end
    end)
    return (TutorialProp.Teardown("Removing the tutorial highlight ring", v1))
end

return v1