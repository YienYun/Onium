-- Script path: ReplicatedStorage.Client.UI.VFX.Flash
-- Decompile time: 7.94 ms

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local OverlayRoot = require(script.Parent.OverlayRoot)
local u15 = {Attack = 0.5, Decay = 0.9, Opacity = 1}
u15.Tint = Color3.new(1, 1, 1)
local u21 = {style = Enum.EasingStyle.Quint, direction = Enum.EasingDirection.Out}
local u24 = {style = Enum.EasingStyle.Cubic, direction = Enum.EasingDirection.InOut}
local u27 = {}
local u28 = nil
local u29 = nil

local function attach(a1) -- Line: 48 -- upvalues: u28 (ref), OverlayRoot (val) -- types: a1: userdata
    local v1 = u28
    if v1 and v1.Parent then
        a1.Parent = v1
        return
    end
    task.spawn(function() -- Line: 54 -- upvalues: OverlayRoot (upval), u28 (upval), a1 (val)
        local v1 = OverlayRoot()
        u28 = v1
        a1.Parent = v1
    end)
end

local function sheetFor(a1) -- Line: 61 -- upvalues: u27 (val), u28 (ref), OverlayRoot (val) -- types: a1: userdata
    local u3 = a1:ToHex()
    local v1 = u27[u3]
    if v1 then
        return v1
    end
    local Frame = Instance.new("Frame")
    Frame.Name = ("Wash_%*"):format(u3)
    Frame.ZIndex = 500
    Frame.BorderSizePixel = 0
    Frame.BackgroundColor3 = a1
    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.fromScale(1, 1)
    Frame.Visible = false
    local u22 = {startedAt = 0, frame = Frame}
    u27[u3] = u22
    Frame.Destroying:Connect(function() -- Line: 79 -- upvalues: u27 (upval), u3 (val), u22 (val)
        if u27[u3] == u22 then
            u27[u3] = nil
        end
    end)
    local v2 = u28
    if v2 and v2.Parent then
        Frame.Parent = v2
        return u22
    end
    task.spawn(function() -- Line: 54 -- upvalues: OverlayRoot (upval), u28 (upval), Frame (val)
        local v1 = OverlayRoot()
        u28 = v1
        Frame.Parent = v1
    end)
    return u22
end

local function envelope(a1, a2) -- Line: 88 -- upvalues: u15 (val), u21 (val), u24 (val) -- types: a1: number, a2: table
    local Attack = a2.Attack or u15.Attack
    local Decay = a2.Decay or u15.Decay
    local v1 = math.clamp(a2.Opacity or u15.Opacity, 0, 1)
    return {
        {at = 0, level = a1, style = u21.style, direction = u21.direction},
        {at = Attack, level = v1, style = u21.style, direction = u21.direction},
        {
            level = 0,
            at = Attack + Decay,
            style = u24.style,
            direction = u24.direction,
        },
    }
end

local function levelAt(a1, a2) -- Line: 100 -- upvalues: TweenService (val) -- types: a1: table, a2: number
    local Value, v1, v2, v3
    local v4 = #a1
    for i = 2, v4 do
        v1 = a1[i]
        if a2 < v1.at then
            v2 = a1[i - 1]
            v3 = v1.at - v2.at
            Value = TweenService:GetValue(if not (v3 > 0) then 1 else (a2 - v2.at) / v3, v1.style, v1.direction)
            return v2.level + (v1.level - v2.level) * Value, false
        end
    end
    return a1[#a1].level, true
end

local function step() -- Line: 114 -- upvalues: u27 (val), levelAt (val), u29 (ref)
    local keys, v1, v2
    local v3 = os.clock()
    local v4 = false
    for i, j in u27 do
        keys = j.keys
        if keys ~= nil then
            v1, v2 = levelAt(keys, v3 - j.startedAt)
            j.frame.BackgroundTransparency = 1 - v1
            if not v2 then
                v4 = true
            else
                j.keys = nil
                j.frame.Visible = false
            end
        end
    end
    if not v4 and u29 then
        u29:Disconnect()
        u29 = nil
    end
end

return (table.freeze({
    Play = function(a1) -- Line: 139
        -- upvalues: sheetFor (val), u15 (val), envelope (val), u29 (ref), RunService (val), step (val)
        local v1 = sheetFor(a1.Tint or u15.Tint)
        v1.keys = envelope(1 - v1.frame.BackgroundTransparency, a1)
        v1.startedAt = os.clock()
        v1.frame.Visible = true
        if u29 == nil then
            RunService.Heartbeat:Connect(step)
        end
        step()
    end,
}))