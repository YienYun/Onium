-- Script path: ReplicatedStorage.Client.UI.VFX.ButtonFX
-- Decompile time: 14.11 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GUI = require(ReplicatedStorage.Client.GUI)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local u32 = {bound = "PressBound", glyph = "PressGlyph", silent = "MuteSounds", ownedScale = "PressScaleOwner"}
local u36 = Vector2.new(0.5, 0.5)
local u40 = UDim2.fromScale(0, 0.08)
local u45 = TweenInfo.new(0.09, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u46 = {intoSunk = 42, outOfSunk = 26, hover = 22}
local u47 = {volume = 3.4, id = Constants.BUTTON_FX.BUTTON_MOUSE_DOWN_SOUND}
u47.pitch = NumberRange.new(0.93, 1.06)
local u56 = Random.new()
local u57 = 0
local u58 = {}
local u59 = {}
local u60 = nil

local function noop() end

local function stepMotions(a1) -- Line: 100 -- upvalues: u59 (val), u60 (ref) -- types: a1: number
    local v1, v2, v3, v4
    local v5 = nil
    local v6 = nil
    local v7 = a1
    for i, j in u59, v5, v6 do
        if i.Parent ~= nil then
            v1 = i.Scale - j.target
            v2 = math.exp(-j.stiffness * v7)
            v3 = (j.velocity + j.stiffness * v1) * v7
            v4 = (v1 + v3) * v2
            j.velocity = (j.velocity - j.stiffness * v3) * v2
            if not ((math.abs(v4)) < 0.0005) or not ((math.abs(j.velocity)) < 0.0005) then
                i.Scale = j.target + v4
            else
                i.Scale = j.target
                u59[i] = nil
            end
        else
            u59[i] = nil
        end
    end
    if u60 and next(u59) == nil then
        u60:Disconnect()
        u60 = nil
    end
end

local function drive(a1, a2, a3) -- Line: 127
    -- upvalues: u59 (val), u60 (ref), RunService (val), stepMotions (val)
    local v1 = u59[a1]
    if not v1 then
        u59[a1] = {velocity = 0, target = a2, stiffness = a3}
    else
        v1.target = a2
        v1.stiffness = a3
    end
    if u60 == nil then
        RunService.PreRender:Connect(stepMotions)
    end
end

local function accepting(a1) -- Line: 142 -- types: a1: table
    return a1.host.Active and a1.input.GuiState ~= Enum.GuiState.NonInteractable
end

local function poseOf(a1) -- Line: 146 -- upvalues: PlatformController (val) -- types: a1: table
    local Active = a1.host.Active and a1.input.GuiState ~= Enum.GuiState.NonInteractable
    if not Active then
        return "Rest"
    end
    local GuiState = a1.input.GuiState
    if not a1.gamepadHeld and GuiState ~= Enum.GuiState.Press then
        if GuiState == Enum.GuiState.Hover and PlatformController.IsDesktop() then
            return "Raised"
        end
        return "Rest"
    end
    return "Sunk"
end

local function scaleFor(a1, a2) -- Line: 160 -- types: a1: table, a2: string
    if a2 == "Sunk" then
        return a1.sunkScale
    end
    if a2 == "Raised" then
        return a1.raisedScale
    end
    return 1
end

local function stiffnessFor(a1, a2) -- Line: 167 -- types: a1: string, a2: string
    if a2 == "Sunk" then
        return 42
    end
    if a1 == "Sunk" then
        return 26
    end
    return 22
end

local function playPressCue(a1) -- Line: 174 -- upvalues: Audio (val), u47 (val), u56 (val) -- types: a1: number
    Audio.Play(u47.id, script, {
        PlaybackSpeed = u56:NextNumber(u47.pitch.Min, u47.pitch.Max),
        Volume = a1,
    })
end

local function placeGlyph(a1, a2) -- Line: 181
    -- upvalues: u40 (val), TweenService (val), u45 (val)
    local glyph = a1.glyph
    if glyph == nil then
        return
    end
    local glyphRest = if a2 ~= "Sunk" then a1.glyphRest else a1.glyphRest + u40
    TweenService:Create(glyph, u45, {Position = glyphRest}):Play()
end

local function refresh(a1) -- Line: 190
    -- upvalues: PlatformController (val), Audio (val), u47 (val), u56 (val), u46 (val), u59 (val), u60 (ref)
    -- upvalues: RunService (val), stepMotions (val), placeGlyph (val)
    local v1
    local pose = a1.pose
    local Active = a1.host.Active and a1.input.GuiState ~= Enum.GuiState.NonInteractable
    if Active then
        local GuiState = a1.input.GuiState
        v1 = if a1.gamepadHeld then "Sunk" else if GuiState ~= Enum.GuiState.Press then if GuiState ~= Enum.GuiState.Hover then "Rest" else if not PlatformController.IsDesktop() then "Rest" else "Raised" else "Sunk"
    else
        v1 = "Rest"
    end
    if pose == v1 then
        return
    end
    a1.pose = v1
    if v1 == "Sunk" and a1.cueGain then
        local cueGain = a1.cueGain
        Audio.Play(u47.id, script, {
            PlaybackSpeed = u56:NextNumber(u47.pitch.Min, u47.pitch.Max),
            Volume = cueGain,
        })
    end
    local scale = a1.scale
    local sunkScale = if v1 ~= "Sunk" then if v1 ~= "Raised" then 1 else a1.raisedScale else a1.sunkScale
    local intoSunk = if v1 ~= "Sunk" then if pose ~= "Sunk" then u46.hover else u46.outOfSunk else u46.intoSunk
    local v2 = u59[scale]
    if not v2 then
        u59[scale] = {velocity = 0, target = sunkScale, stiffness = intoSunk}
    else
        v2.target = sunkScale
        v2.stiffness = intoSunk
    end
    if u60 == nil then
        RunService.PreRender:Connect(stepMotions)
    end
    placeGlyph(a1, v1)
end

local function centerAnchor(a1) -- Line: 207 -- upvalues: u36 (val) -- types: a1: userdata
    local AnchorPoint = a1.AnchorPoint
    if AnchorPoint == u36 then
        return
    end
    local Position = a1.Position
    local Size = a1.Size
    local v1 = u36 - AnchorPoint
    a1.AnchorPoint = u36
    local Parent = a1.Parent
    local v2 = true
    if a1:FindFirstChildWhichIsA("UIAspectRatioConstraint") == nil then
        v2 = a1:FindFirstChildWhichIsA("UISizeConstraint") ~= nil
    end
    local AbsoluteSize = a1.AbsoluteSize
    local AbsoluteSize_2 = if Parent == nil then Vector2.zero else if not Parent:IsA("GuiBase2d") then Vector2.zero else Parent.AbsoluteSize
    if v2 and 0 < AbsoluteSize.X and 0 < AbsoluteSize.Y and 0 < AbsoluteSize_2.X and 0 < AbsoluteSize_2.Y then
        a1.Position = UDim2.new(
            Position.X.Scale + AbsoluteSize.X * v1.X / AbsoluteSize_2.X,
            Position.X.Offset,
            Position.Y.Scale + AbsoluteSize.Y * v1.Y / AbsoluteSize_2.Y,
            Position.Y.Offset
        )
        return
    end
    a1.Position = UDim2.new(
        Position.X.Scale + Size.X.Scale * v1.X,
        Position.X.Offset + Size.X.Offset * v1.X,
        Position.Y.Scale + Size.Y.Scale * v1.Y,
        Position.Y.Offset + Size.Y.Offset * v1.Y
    )
end

local function adoptScale(a1) -- Line: 243 -- types: a1: userdata
    local UIScale = a1:FindFirstChildOfClass("UIScale")
    if UIScale and UIScale:IsA("UIScale") then
        return UIScale
    end
    local UIScale_2 = Instance.new("UIScale")
    UIScale_2.Name = "PressScale"
    UIScale_2.Parent = a1
    return UIScale_2
end

local function findGlyph(a1) -- Line: 254 -- types: a1: userdata
    local Attribute = a1:GetAttribute("PressGlyph")
    if type(Attribute) ~= "string" then
        return nil
    end
    local v1 = a1:FindFirstChild(Attribute)
    if v1 and v1:IsA("GuiObject") then
        return v1
    end
    return nil
end

local function mirrorActive(a1) -- Line: 263 -- types: a1: table
    local host = a1.host
    local input = a1.input
    if input ~= host then
        input.Active = host.Active
        input.Selectable = host.Active
    end
end

local function liveBinding(a1) -- Line: 273 -- upvalues: u58 (val) -- types: a1: userdata
    local Attribute = a1:GetAttribute("PressBound")
    if type(Attribute) ~= "number" then
        return nil
    end
    local v1 = u58[Attribute]
    if v1 and v1.host == a1 then
        return v1
    end
    return nil
end

local function unbind(a1) -- Line: 284 -- upvalues: u58 (val), u59 (val) -- types: a1: table
    if u58[a1.serial] ~= a1 then
        return
    end
    u58[a1.serial] = nil
    for i, j in a1.links do
        j:Disconnect()
    end
    table.clear(a1.links)
    local activation = a1.activation
    if activation then
        activation:Disconnect()
        a1.activation = nil
    end
    local host = a1.host
    if (host:GetAttribute("PressBound")) == a1.serial then
        host:SetAttribute("PressBound", nil)
    end
    u59[a1.scale] = nil
    if a1.scale.Parent then
        a1.scale.Scale = 1
    end
    local glyph = a1.glyph
    if glyph then
        glyph.Position = a1.glyphRest
    end
    if a1.ownsInput then
        a1.input:Destroy()
    end
end

local function wire(a1) -- Line: 317 -- upvalues: refresh (val), unbind (val), GUI (val) -- types: a1: table
    local host = a1.host
    local input = a1.input
    local links = a1.links
    table.insert(links, ((input:GetPropertyChangedSignal("GuiState")):Connect(function() -- Line: 320 -- upvalues: refresh (upval), a1 (val)
        refresh(a1)
    end)))
    table.insert(links, (input.InputBegan:Connect(function(a1_2) -- Line: 325 -- upvalues: a1 (val), refresh (upval) -- types: a1_2: userdata
        if a1_2.KeyCode == Enum.KeyCode.ButtonA then
            a1.gamepadHeld = true
            refresh(a1)
        end
    end)))
    table.insert(links, (input.InputEnded:Connect(function(a1_2) -- Line: 331 -- upvalues: a1 (val), refresh (upval) -- types: a1_2: userdata
        if a1_2.KeyCode == Enum.KeyCode.ButtonA then
            a1.gamepadHeld = false
            refresh(a1)
        end
    end)))
    table.insert(links, ((host:GetPropertyChangedSignal("Active")):Connect(function() -- Line: 337 -- upvalues: a1 (val), refresh (upval)
        local v1 = a1
        local host = v1.host
        local input = v1.input
        if input ~= host then
            input.Active = host.Active
            input.Selectable = host.Active
        end
        refresh(a1)
    end)))
    table.insert(links, (host.Destroying:Connect(function() -- Line: 341 -- upvalues: unbind (upval), a1 (val)
        unbind(a1)
    end)))
    local onActivate = a1.onActivate
    if onActivate then
        a1.activation = GUI.OnActivated(input, function() -- Line: 347 -- upvalues: a1 (val), onActivate (val)
            local v1 = a1
            local Active = v1.host.Active and v1.input.GuiState ~= Enum.GuiState.NonInteractable
            if Active then
                onActivate()
            end
        end)
    end
end

local function bind(a1) -- Line: 355
    -- upvalues: u32 (val), u58 (val), noop (val), centerAnchor (val), u57 (ref), u47 (val), wire (val), unbind (val)
    local v1, v2, v3
    local host = a1.host
    local Attribute = host:GetAttribute(u32.bound)
    if type(Attribute) == "number" then
        v3 = u58[Attribute]
        v1 = if not v3 then nil else if v3.host ~= host then nil else v3
    else
        v1 = nil
    end
    if v1 then
        return noop
    end
    centerAnchor(host)
    local UIScale = host:FindFirstChildOfClass("UIScale")
    if not UIScale or not UIScale:IsA("UIScale") then
        local UIScale_2 = Instance.new("UIScale")
        UIScale_2.Name = "PressScale"
        UIScale_2.Parent = host
        v1 = UIScale_2
    else
        v1 = UIScale
    end
    v1:SetAttribute("PressScaleOwner", true)
    local Attribute_2 = host:GetAttribute(u32.glyph)
    if type(Attribute_2) == "string" then
        local v4 = host:FindFirstChild(Attribute_2)
        v2 = if not v4 then nil else if not v4:IsA("GuiObject") then nil else v4
    else
        v2 = nil
    end
    v3 = true
    if a1.silent ~= true then
        v3 = host:GetAttribute("MuteSounds") == true
    end
    u57 = u57 + 1
    local u82 = {
        pose = "Rest",
        gamepadHeld = false,
        serial = u57,
        host = host,
        input = a1.input,
        scale = v1,
        glyph = v2,
    }
    local Position = if not v2 then UDim2.new() else v2.Position
    u82.glyphRest = Position
    u82.raisedScale = a1.peakScale or 1.07
    u82.sunkScale = a1.pressedScale or 0.94
    u82.cueGain = if not v3 then a1.cueGain or u47.volume else nil
    u82.onActivate = a1.onActivate
    u82.ownsInput = a1.ownsInput == true
    u82.links = {}
    u58[u82.serial] = u82
    host:SetAttribute("PressBound", u82.serial)
    local host_2 = u82.host
    local input = u82.input
    if input ~= host_2 then
        input.Active = host_2.Active
        input.Selectable = host_2.Active
    end
    wire(u82)
    return function() -- Line: 391 -- upvalues: unbind (upval), u82 (val)
        unbind(u82)
    end
end

return function(a1, a2, a3, a4) -- Line: 396 -- upvalues: bind (val) -- types: a2: number?, a3: function?, a4: boolean?
    if typeof(a1) == "table" then
        return (bind(a1))
    end
    local v1 = false
    if typeof(a1) == "Instance" then
        v1 = a1:IsA("GuiButton")
    end
    assert(v1, "ButtonFX needs a GuiButton")
    v1 = true
    if a2 ~= nil then
        v1 = type(a2) == "number"
    end
    assert(v1, "ButtonFX peak scale must be a number")
    v1 = true
    if a3 ~= nil then
        v1 = type(a3) == "function"
    end
    assert(v1, "ButtonFX activation handler must be a function")
    return (bind({
        host = a1,
        input = a1,
        peakScale = a2,
        onActivate = a3,
        silent = a4,
    }))
end