-- Script path: ReplicatedStorage.Client.UI.VFX.GuiTransitionGroup
-- Decompile time: 5.40 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
local u14 = {
    {property = "BackgroundTransparency", classes = {"GuiObject"}},
    {property = "GroupTransparency", classes = {"CanvasGroup"}},
    {property = "ImageTransparency", classes = {"ImageLabel", "ImageButton"}},
    {property = "TextTransparency", classes = {"TextLabel", "TextButton", "TextBox"}},
    {property = "TextStrokeTransparency", classes = {"TextLabel", "TextButton", "TextBox"}},
    {property = "Transparency", classes = {"UIStroke"}},
}
local u38 = {}
u38.__index = u38
u38.__class = "GuiTransitionGroup"

local function isAnyOf(a1, a2) -- Line: 52 -- types: a1: userdata, a2: table
    local v1 = false
    local v2 = nil
    local v3 = nil
    for i, j in a2, v2, v3 do
        v1 = v1 or a1:IsA(j)
    end
    return v1
end

local function captureFade(a1) -- Line: 60 -- upvalues: u14 (val) -- types: a1: userdata
    local v1, v2, v3
    local v4 = {}
    local v5 = {}
    local v6 = nil
    local v7 = nil
    local v8 = a1
    for i, j in u14, v6, v7 do
        v3 = false
        v1 = nil
        v2 = nil
        for k, n in j.classes, v1, v2 do
            v3 = v3 or v8:IsA(n)
        end
        if v3 then
            v4[#v4 + 1] = j.property
            v5[j.property] = v8[j.property]
        end
    end
    if v4[1] then
        return {element = v8, properties = v4, restingAlpha = v5}
    end
    return nil
end

local function raised(a1, a2) -- Line: 76 -- types: a1: userdata, a2: number
    return UDim2.new(a1.X.Scale, a1.X.Offset, a1.Y.Scale - a2, a1.Y.Offset)
end

local function schedule(a1, a2, a3, a4) -- Line: 80
    -- upvalues: TweenService (val)
    local v1 = TweenService:Create(a2, a3, a4)
    a1[#a1 + 1] = v1
    v1:Play()
end

local function placeSlides(a1, a2) -- Line: 86 -- types: a2: boolean
    local element, homePosition
    local v1 = nil
    local v2 = nil
    for i, j in a1.slides, v1, v2 do
        element = j.element
        homePosition = if not a2 then j.liftedPosition else j.homePosition
        element.Position = homePosition
    end
end

local function drift(a1, a2, a3) -- Line: 92 -- upvalues: TweenService (val) -- types: a2: userdata, a3: boolean
    local homePosition, running, running_2, v1, v2, v3, v4, v5
    local fades = a1.fades
    local v6 = nil
    local v7 = nil
    local v8, v9, v10 = a1, a2, a3
    for i, j in fades, v6, v7 do
        v5 = {}
        v1 = nil
        v2 = nil
        for k, n in j.properties, v1, v2 do
            v4 = if not v10 then 1 else j.restingAlpha[n]
            v5[n] = v4
        end
        running_2 = v8.running
        v2 = TweenService:Create(j.element, v9, v5)
        running_2[#running_2 + 1] = v2
        v2:Play()
    end
    v6 = nil
    v7 = nil
    for m, i5 in v8.slides, v6, v7 do
        homePosition = if not v10 then i5.liftedPosition else i5.homePosition
        running = v8.running
        v3 = TweenService:Create(i5.element, v9, {Position = homePosition})
        running[#running + 1] = v3
        v3:Play()
    end
end

function u38.new(a1, a2, a3) -- Line: 107
    -- upvalues: t (val), u38 (val), captureFade (val)
    local Position, slides, v1, v2
    t.strict(t.Instance)(a1)
    t.strict(t.Instance)(a2)
    t.strict(t.number)(a3)
    local v3 = setmetatable({}, u38)
    v3.running = {}
    v3.fades = {}
    v3.slides = {}
    for i, j in a1:GetDescendants() do
        v2 = captureFade(j)
        if v2 ~= nil then
            v3.fades[#v3.fades + 1] = v2
        end
    end
    for k, n in a2:GetChildren() do
        if n:IsA("GuiObject") then
            Position = n.Position
            slides = v3.slides
            v1 = #v3.slides + 1
            slides[v1] = {
                element = n,
                homePosition = Position,
                liftedPosition = UDim2.new(Position.X.Scale, Position.X.Offset, Position.Y.Scale - a3, Position.Y.Offset),
            }
        end
    end
    return v3
end

function u38.Halt(a1) -- Line: 138
    for i, j in a1.running do
        j:Cancel()
    end
    table.clear(a1.running)
end

function u38.SnapHidden(a1) -- Line: 145
    local v1 = nil
    local v2 = nil
    for i, j in a1.fades, v1, v2 do
        for k, n in j.properties do
            j.element[n] = 1
        end
    end
    for m, i5 in a1.slides do
        i5.element.Position = i5.liftedPosition
    end
end

function u38.Reveal(a1, a2) -- Line: 156 -- upvalues: drift (val) -- types: a2: userdata
    drift(a1, a2, true)
end

function u38.Conceal(a1, a2) -- Line: 158 -- upvalues: drift (val) -- types: a2: userdata
    drift(a1, a2, false)
end

function u38.Rehome(a1) -- Line: 160
    for i, j in a1.slides do
        j.element.Position = j.homePosition
    end
end

return u38