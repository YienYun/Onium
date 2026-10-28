-- Script path: ReplicatedStorage.Client.UI.SlideDock
-- Decompile time: 7.56 ms

local TweenService = game:GetService("TweenService")
local u5 = {}
local u6 = {}
local u7 = {}
u7.__index = u7

local function slideSeconds(a1) -- Line: 40 -- types: a1: userdata
    local Attribute = a1:GetAttribute("SlideSeconds")
    if typeof(Attribute) == "number" then
        return Attribute
    end
    return 0.3
end

local function enterInfo(a1) -- Line: 45 -- types: a1: userdata
    local new = TweenInfo.new
    local Attribute = a1:GetAttribute("SlideSeconds")
    return new(if typeof(Attribute) ~= "number" then 0.3 else Attribute, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end

local function exitInfo(a1) -- Line: 49 -- types: a1: userdata
    local new = TweenInfo.new
    local Attribute = a1:GetAttribute("SlideSeconds")
    return new((if typeof(Attribute) ~= "number" then 0.3 else Attribute) * 0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
end

local function stop(a1) -- Line: 53 -- types: a1: table
    if a1.tween ~= nil then
        a1.tween:Cancel()
        a1.tween = nil
    end
end

local function offscreenDistance(a1, a2) -- Line: 65 -- types: a1: table, a2: number
    local v1 = a1.frame:FindFirstAncestorWhichIsA("LayerCollector")
    local v2 = ("%* must live under a ScreenGui to slide"):format((a1.frame:GetFullName()))
    assert(v1 ~= nil, v2)
    return math.max(v1.AbsoluteSize.X - (a1.frame.AbsolutePosition.X - (a1.frame.Position.X.Offset - a1.home.X.Offset)), 0) + a2
end

local function awayPosition(a1, a2) -- Line: 73 -- upvalues: offscreenDistance (val) -- types: a1: table, a2: number
    return a1.home + UDim2.fromOffset(offscreenDistance(a1, a2), 0)
end

local function play(a1, a2, a3) -- Line: 77
    -- upvalues: TweenService (val)
    if a1.tween ~= nil then
        a1.tween:Cancel()
        a1.tween = nil
    end
    local v1 = TweenService:Create(a1.frame, a3, {Position = a2})
    a1.tween = v1
    v1:Play()
    return v1
end

function u7.EscortFramesOf(a1) -- Line: 87 -- types: a1: table
    local Parent
    local v1 = {}
    for i, j in a1 do
        Parent = j.Parent
        if Parent ~= nil and Parent:IsA("GuiObject") and table.find(v1, Parent) == nil then
            table.insert(v1, Parent)
        end
    end
    return v1
end

function u7.new(a1, a2, a3) -- Line: 98
    -- upvalues: u7 (val), u5 (val), u6 (val)
    local v1
    local v2 = {_generation = 0, _root = a1, _panel = {frame = a2, home = a2.Position}, _escorts = {}}
    local v3 = setmetatable(v2, u7)
    local v4 = nil
    local v5 = nil
    for i, j in a3, v4, v5 do
        v1 = u5[j]
        if v1 == nil then
            v1 = {frame = j, home = j.Position}
            u5[j] = v1
            u6[j] = 0
        end
        table.insert(v3._escorts, v1)
    end
    return v3
end

function u7.IsOpen(a1) -- Line: 121
    return a1._open == true
end

function u7.SetOpen(a1, a2, a3) -- Line: 125
    -- upvalues: u6 (val), offscreenDistance (val), TweenService (val)
    local Attribute_3, frame_5, home_5, home_7, new_3, new_4, v1, v2, v3, v4, v5, v6
    if a1._open == a2 then
        return
    end
    a1._open = a2
    a1._generation = a1._generation + 1
    local _generation = a1._generation
    local frame = a1._panel.frame
    local _escorts = a1._escorts
    local v7 = nil
    local v8 = nil
    local v9, v10 = a2, a3
    for i, j in _escorts, v7, v8 do
        v1 = u6[j.frame]
        v1 = if not v9 then math.max(v1 - 1, 0) else v1 + 1
        u6[j.frame] = v1
        v2 = v1 > 0
        if v10 then
            if j.tween ~= nil then
                j.tween:Cancel()
                j.tween = nil
            end
            frame_5 = j.frame
            home_5 = if not v2 then j.home else j.home + UDim2.fromOffset(offscreenDistance(j, 12), 0)
            frame_5.Position = home_5
        else
            if not v2 then
                home_7 = j.home
                new_4 = TweenInfo.new
                Attribute_3 = frame:GetAttribute("SlideSeconds")
                v4 = new_4(if typeof(Attribute_3) ~= "number" then 0.3 else Attribute_3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                if j.tween ~= nil then
                    j.tween:Cancel()
                    j.tween = nil
                end
                v5 = TweenService:Create(j.frame, v4, {Position = home_7})
            else
                v3 = j.home + UDim2.fromOffset(offscreenDistance(j, 12), 0)
                new_3 = TweenInfo.new
                v1 = frame:GetAttribute("SlideSeconds")
                v4 = new_3((if typeof(v1) ~= "number" then 0.3 else v1) * 0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                if j.tween ~= nil then
                    j.tween:Cancel()
                    j.tween = nil
                end
                v5 = TweenService:Create(j.frame, v4, {Position = v3})
            end
            j.tween = v5
            v5:Play()
        end
    end
    local _panel = a1._panel
    v7 = frame.AbsoluteSize.X * 0.3 + 12
    if not v9 then
        if v10 then
            if _panel.tween ~= nil then
                _panel.tween:Cancel()
                _panel.tween = nil
            end
            _panel.frame.Position = _panel.home
            a1._root.Enabled = false
            return
        end
        local v11 = _panel.home + UDim2.fromOffset(offscreenDistance(_panel, v7), 0)
        local new_2 = TweenInfo.new
        local Attribute_2 = frame:GetAttribute("SlideSeconds")
        v6 = new_2((if typeof(Attribute_2) ~= "number" then 0.3 else Attribute_2) * 0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        if _panel.tween ~= nil then
            _panel.tween:Cancel()
            _panel.tween = nil
        end
        v8 = TweenService:Create(_panel.frame, v6, {Position = v11})
        _panel.tween = v8
        v8:Play()
        v8.Completed:Once(function(a1_2) -- Line: 171 -- upvalues: a1 (val), _generation (val), _panel (val)
            if a1._generation == _generation and a1_2 == Enum.PlaybackState.Completed then
                _panel.tween = nil
                a1._root.Enabled = false
                _panel.frame.Position = _panel.home
            end
        end)
        return
    end
    v8 = not a1._root.Enabled
    a1._root.Enabled = true
    if v10 then
        if _panel.tween ~= nil then
            _panel.tween:Cancel()
            _panel.tween = nil
        end
        _panel.frame.Position = _panel.home
        return
    end
    if v8 then
        _panel.frame.Position = _panel.home + UDim2.fromOffset(offscreenDistance(_panel, v7), 0)
    end
    local home_2 = _panel.home
    local new = TweenInfo.new
    local Attribute = frame:GetAttribute("SlideSeconds")
    v6 = new(if typeof(Attribute) ~= "number" then 0.3 else Attribute, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    if _panel.tween ~= nil then
        _panel.tween:Cancel()
        _panel.tween = nil
    end
    v1 = TweenService:Create(_panel.frame, v6, {Position = home_2})
    _panel.tween = v1
    v1:Play()
end

return u7