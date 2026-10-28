-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController.GuardComponent
-- Decompile time: 8.21 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
local GuardWakeLookAt = require(script.Parent.GuardWakeLookAt)
local Log = require(ReplicatedStorage.Packages.Log)
local Trove = require(ReplicatedStorage.Packages.Trove)
local WaitFor = require(ReplicatedStorage.Packages.WaitFor)
local u38 = Log.new()
local u39 = {}
u39.__index = u39
u39.__class = "GuardComponent"
local u47 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true)
local u52 = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u57 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u62 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function u39.new(a1) -- Line: 53
    -- upvalues: t (val), u39 (val), WaitFor (val), Trove (val), GuardWakeLookAt (val)
    local v1
    t.strict(t.instanceIsA("Model"))(a1)
    local u13 = setmetatable({}, u39)
    local Guard = a1:WaitForChild("Guard")
    assert(Guard:IsA("Model"), (("%*.Guard must be a Model"):format((a1:GetFullName()))))
    local v2, v3 = WaitFor.Descendant(Guard, "Head"):await()
    local v4 = ("%* requires a Head descendant for alert GUI"):format((Guard:GetFullName()))
    assert(v2 and v3 ~= nil, v4)
    assert(v3:IsA("BasePart"), (("%* must be a BasePart"):format((v3:GetFullName()))))
    v2 = a1.Name == "Forest"
    local v5 = nil
    if v2 then
        local HumanoidRootPart = Guard:WaitForChild("HumanoidRootPart")
        assert(HumanoidRootPart, (("%* requires a HumanoidRootPart descendant for Forest shake effects"):format((Guard:GetFullName()))))
        assert(HumanoidRootPart:IsA("BasePart"), (("%* must be a BasePart"):format((HumanoidRootPart:GetFullName()))))
        v5 = HumanoidRootPart
    end
    v1, v4 = WaitFor.Descendant(v3, "AlertGui"):await()
    local v6 = ("%* requires an AlertGui descendant"):format((v3:GetFullName()))
    assert(v1 and v4 and v4:IsA("BillboardGui"), v6)
    u13._alertGuiTemplate = v4
    u13._alertGui = nil
    u13._guardModel = Guard
    u13._head = v3
    u13._lastAlertAt = (-1 / 0)
    u13._root = v5
    u13._sleepColorTrove = Trove.new()
    u13._trove = Trove.new()
    if not Guard:GetAttribute("HeadLookAtDisabled") then
        u13._wakeLookAt = GuardWakeLookAt.new(Guard)
    end
    u13._trove:Add(u13._sleepColorTrove)
    u13._trove:Add(((Guard:GetAttributeChangedSignal("TargetPlayer")):Connect(function() -- Line: 100 -- upvalues: u13 (val)
        u13:_updateTargetAlert()
    end)))
    u13._trove:Add(((Guard:GetAttributeChangedSignal("Sleeping")):Connect(function() -- Line: 102 -- upvalues: u13 (val), Guard (val)
        u13:_applySleepVfx()
        if Guard:GetAttribute("Sleeping") == true then
            u13:_clearAlert()
        end
    end)))
    u13._trove:Add(((Guard:GetAttributeChangedSignal("GuardState")):Connect(function() -- Line: 108 -- upvalues: u13 (val)
        u13:_applySleepVfx()
        u13:_applyGuardStatePresentation()
    end)))
    u13._trove:Add(((Guard:GetAttributeChangedSignal("WakeTargetPlayer")):Connect(function() -- Line: 115 -- upvalues: u13 (val)
        u13:_applyGuardStatePresentation()
    end)))
    u13._trove:Add(((Guard:GetAttributeChangedSignal("Hidden")):Connect(function() -- Line: 120 -- upvalues: u13 (val)
        u13:_applySleepVfx()
    end)))
    u13:_applySleepVfx()
    u13:_applyGuardStatePresentation()
    u13:_updateTargetAlert()
    local u232 = false
    u13._trove:Add((Guard.DescendantAdded:Connect(function(a1) -- Line: 127 -- upvalues: u232 (ref), u13 (val) -- types: a1: userdata
        if not a1:IsA("BasePart") then
            return
        end
        task.delay(1, function() -- Line: 131 -- upvalues: u232 (upval), u13 (upval)
            if not u232 then
                u232 = true
                u13:_applyGuardStatePresentation()
                task.wait(1)
                u232 = false
            end
        end)
    end)))
    return u13
end

function u39:_updateTargetAlert() -- Line: 148
    local Attribute = self._guardModel:GetAttribute("TargetPlayer")
    if typeof(Attribute) == "string" and Attribute ~= "" then
        local v1 = os.clock()
        if v1 - self._lastAlertAt < 3 then
            return
        end
        self._lastAlertAt = v1
        self:_showAlert()
        return
    end
end

function u39:_applySleepVfx() -- Line: 163 -- upvalues: u38 (val)
    local v1 = false
    if self._guardModel:GetAttribute("GuardState") == "Sleeping" then
        v1 = self._guardModel:GetAttribute("Hidden") ~= true
    end
    local SleepVFXAttachment = self._guardModel:FindFirstChild("SleepVFXAttachment", true)
    if not SleepVFXAttachment then
        (u38:AtWarning()):Log((("Guard model %* is missing SleepVFXAttachment"):format((self._guardModel:GetFullName()))))
        return
    end
    for i, v in ipairs(SleepVFXAttachment:GetDescendants()) do
        if v:IsA("ParticleEmitter") then
            v.Enabled = v1
            if not v1 then
                v:Clear()
            end
        end
    end
end

function u39:_applyGuardStatePresentation() -- Line: 184 -- upvalues: t (val)
    local Attribute = self._guardModel:GetAttribute("GuardState")
    local Attribute_2 = self._guardModel:GetAttribute("WakeTargetPlayer")
    t.strict(t.optional(t.string))(Attribute_2)
    if self._wakeLookAt then
        local _wakeLookAt = self._wakeLookAt
        local v1 = if Attribute_2 ~= "" then Attribute_2 else nil
        _wakeLookAt:SetWaking(Attribute == "Waking", v1)
    end
    if Attribute == "Sleeping" then
        self:_applySleepDetailColors()
        return
    end
    if Attribute ~= "Waking" then
        return
    end
    self:_animateSleepDetailColorsToOriginal()
end

function u39:_applySleepDetailColors() -- Line: 207
    local Attribute, Color
    self._sleepColorTrove:Clean()
    for i, v in ipairs(self._guardModel:GetDescendants()) do
        if v:IsA("BasePart") then
            Attribute = v:GetAttribute("SleepColor")
            if Attribute then
                if v:GetAttribute("OriginalColor") == nil then
                    Color = v.Color
                    v:SetAttribute("OriginalColor", Color)
                end
                v.Color = Attribute
            end
        end
    end
end

function u39:_animateSleepDetailColorsToOriginal() -- Line: 227
    local Attribute
    self._sleepColorTrove:Clean()
    for i, v in ipairs(self._guardModel:GetDescendants()) do
        if v:IsA("BasePart") and v:GetAttribute("SleepColor") then
            Attribute = v:GetAttribute("OriginalColor")
            if Attribute == nil then
                Attribute = v.Color
                v:SetAttribute("OriginalColor", Attribute)
            end
            assert(Attribute, "luau")
            v.Color = Attribute
        end
    end
end

function u39:_clearAlert() -- Line: 245
    local _alertGui = self._alertGui
    if _alertGui == nil then
        return
    end
    self._alertGui = nil
    _alertGui:Destroy()
end

function u39:_showAlert() -- Line: 255 -- upvalues: TweenService (val), u52 (val), u57 (val), u62 (val), u38 (val)
    if self._alertGui ~= nil then
        return
    end
    local u5 = self._alertGuiTemplate:Clone()
    local u11 = assert((u5:FindFirstChildWhichIsA("ImageLabel")))
    u11.Transparency = 1
    u5.AlwaysOnTop = true
    u5.Enabled = true
    u5.Parent = self._head
    self._alertGui = u5
    self._trove:Add(u5)
    TweenService:Create(u11, u52, {ImageTransparency = 0}):Play()
    local v1 = TweenService
    local v2 = u57
    local v3 = {}
    local StudsOffset = u5.StudsOffset
    local v4 = u5.StudsOffset.Y * 0.6
    v3.StudsOffset = StudsOffset + Vector3.new(0, 1, 0) * math.max(v4, 1)
    v1 = v1:Create(u5, v2, v3)
    v1.Completed:Once(function() -- Line: 274 -- upvalues: TweenService (upval), u11 (val), u62 (upval)
        task.wait(1)
        TweenService:Create(u11, u62, {ImageTransparency = 1}):Play()
    end)
    v1:Play()
    task.delay(3, function() -- Line: 280 -- upvalues: u5 (val), self (val)
        if u5.Parent == nil then
            return
        end
        if self._alertGui == u5 then
            self._alertGui = nil
        end
        u5:Destroy()
    end)
    ;(u38:AtTrace()):Log((("Guard alert shown for %*"):format((self._guardModel:GetFullName()))))
end

function u39:Destroy() -- Line: 298
    if self._wakeLookAt then
        self._wakeLookAt:Destroy()
    end
    self._trove:Destroy()
end

function u39.GetGuardModel(a1) -- Line: 305
    return a1._guardModel
end

function u39.PlayWakeUp(a1) -- Line: 307 -- upvalues: TweenService (val), u47 (val), Debris (val)
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "GuardWakeHighlight"
    Highlight.FillColor = Color3.fromRGB(255, 0, 0)
    Highlight.OutlineColor = Color3.fromRGB(132, 0, 0)
    Highlight.FillTransparency = 1
    Highlight.OutlineTransparency = 1
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Parent = a1._guardModel
    TweenService:Create(Highlight, u47, {FillTransparency = 0.35, OutlineTransparency = 0}):Play()
    Debris:AddItem(Highlight, u47.Time * 2 + 0.05)
end

return u39