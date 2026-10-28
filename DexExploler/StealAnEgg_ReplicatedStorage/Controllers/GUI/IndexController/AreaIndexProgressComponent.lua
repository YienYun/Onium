-- Script path: ReplicatedStorage.Controllers.GUI.IndexController.AreaIndexProgressComponent
-- Decompile time: 4.33 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
local Gears = require(ReplicatedStorage.Data.Gears)
local SurfaceButton = require(ReplicatedStorage.Client.UI.VFX.SurfaceButton)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Types.Interface)
local u34 = {}
u34.__index = u34
u34.__class = "AreaIndexProgressComponent"
local u40 = Color3.fromRGB(0, 182, 24)
local u45 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function gearIcon(a1) -- Line: 40 -- upvalues: Gears (val) -- types: a1: string
    local v1 = Gears.Directory[a1]
    if v1 ~= nil then
        return v1.Icon
    end
    return ""
end

function u34.new(a1, a2) -- Line: 49 -- upvalues: u34 (val), Trove (val) -- types: a2: function
    local v1 = setmetatable({}, u34)
    v1._view = a1
    v1._onAction = a2
    v1._sectionId = nil
    v1._actionEnabled = false
    v1._defaultTextColor = a1.TextLabel.TextColor3
    v1._progressTween = nil
    v1._trove = Trove.new()
    v1:_init()
    return v1
end

function u34:_setProgress(a2, a3) -- Line: 69
    -- upvalues: TweenService (val), u45 (val)
    local _progressTween = self._progressTween
    if _progressTween then
        _progressTween:Cancel()
        _progressTween:Destroy()
    end
    local v1 = UDim2.fromScale(a2, 1)
    if a3 then
        self._view.Fill.Size = v1
        return
    end
    local v2 = TweenService:Create(self._view.Fill, u45, {Size = v1})
    self._progressTween = v2
    v2:Play()
end

function u34:_render(a2, a3, a4, a5, a6, a7, a8) -- Line: 91
    -- upvalues: t (val), u40 (val)
    t.strict(t.string)(a2)
    t.strict(t.string)(a3)
    t.strict(t.number)(a4)
    t.strict(t.number)(a5)
    t.strict(t.string)(a6)
    t.strict(t.boolean)(a7)
    t.strict(t.boolean)(a8)
    local _view = self._view
    local v1 = false
    if a5 > 0 then
        v1 = a5 <= a4
    end
    local v2 = v1 and a8
    self._sectionId = a2
    self._actionEnabled = v2
    _view.Active = v2
    _view.ImageLabel.Image = a3
    _view.ImageLabel.Visible = a3 ~= ""
    _view.TextLabel.Text = if not v1 then ("%*/%*"):format(a4, a5) else a6
    _view.TextLabel.TextColor3 = if not v1 then self._defaultTextColor else if not a7 then self._defaultTextColor else u40
    self:_setProgress(if a5 ~= 0 then math.clamp(a4 / a5, 0, 1) else 0)
end

function u34.RenderAreaBat(a1, a2, a3, a4, a5, a6, a7) -- Line: 132
    -- upvalues: t (val), Gears (val)
    t.strict(t.string)(a2)
    t.strict(t.string)(a3)
    t.strict(t.number)(a4)
    t.strict(t.number)(a5)
    t.strict(t.boolean)(a6)
    t.strict(t.boolean)(a7)
    local v1 = Gears.Directory[a3]
    local v2 = if not a7 then "Equip Bat!" else "Equipped"
    a1:_render(a2, if v1 == nil then "" else v1.Icon, a4, a5, v2, a7, not a7)
end

function u34.RenderGearClaim(a1, a2, a3, a4, a5, a6) -- Line: 159
    -- upvalues: t (val), Gears (val)
    t.strict(t.boolean)(a6)
    local v1 = Gears.Directory[a3]
    local v2 = if not a6 then "CLAIM!" else "CLAIMED!"
    a1:_render(a2, if v1 == nil then "" else v1.Icon, a4, a5, v2, a6, not a6)
end

function u34.RenderCollection(a1, a2, a3, a4, a5) -- Line: 180 -- types: a2: string, a3: string, a4: number, a5: number
    a1:_render(a2, a3, a4, a5, "COMPLETE!", true, false)
end

function u34:Destroy() -- Line: 190
    local _progressTween = self._progressTween
    if _progressTween then
        _progressTween:Cancel()
        _progressTween:Destroy()
        self._progressTween = nil
    end
    self._teardown()
    self._trove:Destroy()
end

function u34:_init() -- Line: 205 -- upvalues: SurfaceButton (val)
    self._teardown = SurfaceButton(self._view, 1.04, function() -- Line: 206 -- upvalues: self (val)
        local _sectionId = self._sectionId
        if _sectionId ~= nil and self._actionEnabled then
            self._onAction(_sectionId)
        end
    end)
end

return u34