-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Layers
-- Decompile time: 5.04 ms

local RunService = game:GetService("RunService")
local Gradient = require(script.Parent.Gradient)
local GradientTemplates = require(script.Parent.GradientTemplates)
local Stroke = require(script.Parent.Stroke)
local Heartbeat = RunService.Heartbeat
local u26 = Color3.fromRGB(255, 255, 255)
local u27 = {0, 0.5, 1}
local u31 = {
    TextButton = "BackgroundColor3",
    TextLabel = "TextColor3",
    ImageLabel = "ImageColor3",
    ImageButton = "ImageColor3",
    Frame = "BackgroundColor3",
    ScrollingFrame = "BackgroundColor3",
    ViewportFrame = "BackgroundColor3",
}
local u32 = {}
u32[1] = {
    field = "StartPhase",
    apply = function(a1, a2) -- Line: 59
        a1.phase.now = a2
    end,
}
u32[2] = {
    field = "Rotation",
    apply = function(a1, a2) -- Line: 60
        a1:SetRotation(a2, 1)
    end,
}
u32[3] = {
    field = "Spin",
    apply = function(a1, a2) -- Line: 61
        a1:Spin(a2, 1)
    end,
}
u32[4] = {
    field = "PhaseGoal",
    apply = function(a1, a2) -- Line: 62
        a1:PhaseTo(a2, 1)
    end,
}
u32[5] = {
    field = "Drift",
    apply = function(a1, a2) -- Line: 63
        a1:Drift(a2, 1)
    end,
}
u32[6] = {
    field = "AlphaDrift",
    apply = function(a1, a2) -- Line: 64
        a1:AlphaDrift(a2, 1)
    end,
}
local u47 = table.freeze({})
local v1 = {}

local function paletteOf(a1) -- Line: 71 -- upvalues: GradientTemplates (val) -- types: a1: table
    local Palette = a1.Palette
    if typeof(Palette) == "string" then
        return GradientTemplates[Palette].Color
    end
    return Palette
end

function v1.Paint(a1, a2) -- Line: 76
    -- upvalues: Gradient (val), GradientTemplates (val), u32 (val)
    local v1
    local new = Gradient.new
    local Palette = a2.Palette
    local v2 = new(a1, if typeof(Palette) ~= "string" then Palette else GradientTemplates[Palette].Color, a2.Alpha or 0)
    for i, j in u32 do
        v1 = a2[j.field]
        if v1 then
            j.apply(v2, v1)
        end
    end
    return v2
end

function v1.Edge(a1, a2) -- Line: 89 -- upvalues: Stroke (val) -- types: a1: userdata, a2: number
    return Stroke.new(a1, a2)
end

function v1.AcceptsEdge(a1) -- Line: 95 -- types: a1: userdata
    local v1 = a1:IsA("ImageLabel") and a1.BackgroundTransparency == 1
    return not v1
end

function v1.AlphaStops(a1) -- Line: 99 -- upvalues: GradientTemplates (val) -- types: a1: string
    return GradientTemplates[a1].Transparency
end

function v1.HostColor(a1) -- Line: 105 -- upvalues: u31 (val), u26 (val) -- types: a1: userdata
    return a1[u31[a1.ClassName]] or u26
end

function v1.FlatPalette(a1) -- Line: 109 -- upvalues: u27 (val) -- types: a1: userdata
    local v1 = table.create(#u27)
    for i, j in u27 do
        v1[i] = (ColorSequenceKeypoint.new(j, a1))
    end
    return ColorSequence.new(v1)
end

function v1.ShinePalette(a1, a2) -- Line: 117 -- upvalues: u26 (val) -- types: a1: userdata, a2: number
    return ColorSequence.new({
        ColorSequenceKeypoint.new(0, a1),
        ColorSequenceKeypoint.new(0.5, a1:Lerp(u26, a2)),
        (ColorSequenceKeypoint.new(1, a1)),
    })
end

function v1.Turn(a1, a2, a3, a4) -- Line: 125
    -- upvalues: Heartbeat (val)
    local u4 = a3
    local u5 = nil
    u5 = (Heartbeat:Connect(function(a1_2) -- Line: 134 -- upvalues: a2 (val), u5 (ref), u4 (ref), a4 (val), a1 (val) -- types: a1_2: number
        if a2.Parent == nil then
            u5:Disconnect()
        end
        u4 = u4 + a4 * a1_2
        a1:SetRotation(u4, 1)
    end))
    return u5
end

function v1.Breathe(a1, a2, a3, a4, a5) -- Line: 149
    -- upvalues: Heartbeat (val)
    local u5 = nil
    u5 = (Heartbeat:Connect(function() -- Line: 158 -- upvalues: a1 (val), u5 (ref), a2 (val), a3 (val), a4 (val), a5 (val)
        if a1.outline and a1.outline.Parent ~= nil then
            a1:EaseWidth(a2 * (a3 * math.sin((tick()) * a4) + 1), a5)
            return
        end
        u5:Disconnect()
    end))
    return u5
end

function v1.Replay(a1, a2) -- Line: 172 -- upvalues: u47 (val) -- types: a2: table?
    local v1
    for i, j in if typeof(a2) ~= "table" then u47 else a2 do
        v1 = a1[j.Function]
        if typeof(v1) == "function" and typeof(j.Package) == "table" then
            v1(a1, table.unpack(j.Package))
        end
    end
end

function v1.Result(a1, a2) -- Line: 183 -- types: a1: table, a2: table?
    return {Effects = a1, Connections = a2}
end

return table.freeze(v1)