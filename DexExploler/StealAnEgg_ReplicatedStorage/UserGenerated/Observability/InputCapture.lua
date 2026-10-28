-- Script path: ReplicatedStorage.UserGenerated.Observability.InputCapture
-- Decompile time: 11.15 ms

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Observability = require(ReplicatedStorage.UserGenerated.Observability)
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec)
local Op = Observability.Op
local PointerKind = Observability.PointerKind
local PointerState = Observability.PointerState
local u27 = {
    [Enum.KeyCode.Thumbstick1] = true,
    [Enum.KeyCode.Thumbstick2] = true,
    [Enum.KeyCode.Unknown] = true,
}
local u34 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true,
}

local function insetArea(a1) -- Line: 53 -- upvalues: GuiService (val)
    local success, err = pcall(GuiService.GetInsetArea, GuiService, a1)
    if success then
        return err
    end
    return nil
end

local u52 = {}
u52.__index = u52

function u52.new(a1) -- Line: 61
    -- upvalues: u52 (val), UserInputService (val), PointerKind (val), PointerState (val), u34 (val), GuiService (val)
    local v1 = {
        NextTouchId = 1,
        SelectedDirty = false,
        LastViewport = "",
        Clock = a1,
        Events = {},
        Keys = {},
        Held = {},
        LastMove = {},
        PendingMove = {},
        TouchIds = setmetatable({}, {__mode = "k"}),
        Connections = {},
    }
    local u14 = setmetatable(v1, u52)

    local function connect(a1, a2) -- Line: 81 -- upvalues: u14 (val) -- types: a1: userdata, a2: function
        table.insert(u14.Connections, (a1:Connect(a2)))
    end

    table.insert(u14.Connections, (UserInputService.InputBegan:Connect(function(a1) -- Line: 85
        -- upvalues: u14 (val), PointerKind (upval), PointerState (upval), u34 (upval)
        local UserInputType = a1.UserInputType
        if UserInputType ~= Enum.UserInputType.MouseButton1 and UserInputType ~= Enum.UserInputType.MouseButton2 then
            if UserInputType == Enum.UserInputType.Keyboard or u34[UserInputType] then
                u14:_key(a1.KeyCode, true)
            end
            return
        end
        u14:_pointer(PointerKind.Mouse, if UserInputType ~= Enum.UserInputType.MouseButton1 then 2 else 1, PointerState.Down, nil)
    end)))
    table.insert(u14.Connections, (UserInputService.InputEnded:Connect(function(a1) -- Line: 93
        -- upvalues: u14 (val), PointerKind (upval), PointerState (upval), u34 (upval)
        local UserInputType = a1.UserInputType
        if UserInputType ~= Enum.UserInputType.MouseButton1 and UserInputType ~= Enum.UserInputType.MouseButton2 then
            if UserInputType == Enum.UserInputType.Keyboard or u34[UserInputType] then
                u14:_key(a1.KeyCode, false)
            end
            return
        end
        u14:_pointer(PointerKind.Mouse, if UserInputType ~= Enum.UserInputType.MouseButton1 then 2 else 1, PointerState.Up, nil)
    end)))
    table.insert(u14.Connections, (UserInputService.WindowFocusReleased:Connect(function() -- Line: 102 -- upvalues: u14 (val)
        u14:_releaseHeld()
    end)))
    table.insert(u14.Connections, (UserInputService.InputChanged:Connect(function(a1) -- Line: 105 -- upvalues: u14 (val), PointerKind (upval), PointerState (upval) -- types: a1: userdata
        if a1.UserInputType == Enum.UserInputType.MouseMovement then
            u14:_pointer(PointerKind.Mouse, 0, PointerState.Move, nil)
        end
    end)))
    table.insert(u14.Connections, (UserInputService.TouchStarted:Connect(function(a1) -- Line: 110 -- upvalues: u14 (val), PointerKind (upval), PointerState (upval) -- types: a1: userdata
        local NextTouchId = u14.NextTouchId
        u14.NextTouchId = NextTouchId % 255 + 1
        u14.TouchIds[a1] = NextTouchId
        u14:_pointer(PointerKind.Touch, NextTouchId, PointerState.Down, a1.Position)
    end)))
    table.insert(u14.Connections, (UserInputService.TouchMoved:Connect(function(a1) -- Line: 116 -- upvalues: u14 (val), PointerKind (upval), PointerState (upval) -- types: a1: userdata
        local v1 = u14.TouchIds[a1]
        if v1 then
            u14:_pointer(PointerKind.Touch, v1, PointerState.Move, a1.Position)
        end
    end)))
    table.insert(u14.Connections, (UserInputService.TouchEnded:Connect(function(a1) -- Line: 122 -- upvalues: u14 (val), PointerKind (upval), PointerState (upval) -- types: a1: userdata
        local v1 = u14.TouchIds[a1]
        if v1 then
            u14.TouchIds[a1] = nil
            u14:_pointer(PointerKind.Touch, v1, PointerState.Up, a1.Position)
        end
    end)))
    table.insert(u14.Connections, ((GuiService:GetPropertyChangedSignal("SelectedObject")):Connect(function() -- Line: 129 -- upvalues: u14 (val), GuiService (upval)
        u14.Selected = GuiService.SelectedObject
        u14.SelectedDirty = true
    end)))
    return u14
end

function u52:_pointer(a2, a3, a4, a5) -- Line: 138
    -- upvalues: GuiService (val), UserInputService (val), PointerState (val)
    local X, Y
    local v1 = self.Clock()
    if not a5 then
        local MouseLocation = UserInputService:GetMouseLocation()
        X = MouseLocation.X
        Y = MouseLocation.Y
    else
        local Origin = self.Origin or GuiService:GetGuiInset()
        X = a5.X + Origin.X
        Y = a5.Y + Origin.Y
    end
    local v2 = {
        Ms = v1,
        Kind = a2,
        PointerId = a3,
        State = a4,
        X = X,
        Y = Y,
    }
    local v3 = ("%*:%*"):format(a2, a3)
    if a4 == PointerState.Move then
        local v4 = self.LastMove[v3]
        if v4 and v1 - v4 < 33.333333333333336 then
            self.PendingMove[v3] = v2
            return
        end
        self.LastMove[v3] = v1
    end
    self.PendingMove[v3] = nil
    table.insert(self.Events, v2)
end

function u52:_key(a2, a3) -- Line: 163 -- upvalues: u27 (val), UserInputService (val) -- types: self: table, a3: boolean
    if u27[a2] then
        return
    end
    local Value = a2.Value
    if not a3 then
        if self.Held[Value] then
            self.Held[Value] = nil
            table.insert(self.Keys, {Ms = self.Clock(), Code = Value, Down = a3})
            return
        end
        return
    end
    if not self.Held[Value] and not UserInputService:GetFocusedTextBox() then
        self.Held[Value] = true
        table.insert(self.Keys, {Ms = self.Clock(), Code = Value, Down = a3})
        return
    end
end

function u52:_releaseHeld() -- Line: 182
    local v1 = self.Clock()
    for i in self.Held do
        table.insert(self.Keys, {Down = false, Ms = v1, Code = i})
    end
    table.clear(self.Held)
end

function u52:_sampleVirtualCursor() -- Line: 190
    -- upvalues: u34 (val), UserInputService (val), PointerKind (val), PointerState (val)
    if not u34[UserInputService:GetLastInputType()] then
        self.LastVirtualCursor = nil
        return
    end
    local MouseLocation = UserInputService:GetMouseLocation()
    if self.LastVirtualCursor ~= MouseLocation then
        self.LastVirtualCursor = MouseLocation
        table.insert(self.Events, {
            PointerId = 0,
            Ms = self.Clock(),
            Kind = PointerKind.VirtualCursor,
            State = PointerState.Move,
            X = MouseLocation.X,
            Y = MouseLocation.Y,
        })
    end
end

function u52:WriteViewport(a2, a3) -- Line: 210
    -- upvalues: GuiService (val), Op (val), Codec (val)
    local CurrentCamera = workspace.CurrentCamera
    if not CurrentCamera then
        return
    end
    local ViewportSize = CurrentCamera.ViewportSize
    local GuiInset, GuiInset_2 = GuiService:GetGuiInset()
    local success, err = pcall(GuiService.GetInsetArea, GuiService, Enum.ScreenInsets.None)
    local v1 = if not success then nil else err
    local success_2, err_2 = pcall(GuiService.GetInsetArea, GuiService, Enum.ScreenInsets.DeviceSafeInsets)
    local v2 = if not success_2 then nil else err_2
    local success_3, err_3 = pcall(GuiService.GetInsetArea, GuiService, Enum.ScreenInsets.TopbarSafeInsets)
    local v3 = if not success_3 then nil else err_3
    local v4 = if not v1 or not v2 or not v3 then nil else {
        v2.Min.X - v1.Min.X,
        v2.Min.Y - v1.Min.Y,
        v1.Max.X - v2.Max.X,
        v1.Max.Y - v2.Max.Y,
        v3.Min.X - v2.Min.X,
        v3.Min.Y - v2.Min.Y,
        v2.Max.X - v3.Max.X,
        v2.Max.Y - v3.Max.Y,
    }
    self.Origin = if not v1 then nil else -v1.Min
    v3 = (("%*,%*,%*,%*,%*,%*"):format(ViewportSize.X, ViewportSize.Y, GuiInset.X, GuiInset.Y, GuiInset_2.X, GuiInset_2.Y)) .. (if not v4 then "" else "," .. table.concat(v4, ","))
    if not a3 and v3 == self.LastViewport then
        return
    end
    self.LastViewport = v3
    local W = a2.W
    W:u8(Op.Viewport)
    W:u16((math.clamp(math.round(ViewportSize.X), 0, 65535)))
    W:u16((math.clamp(math.round(ViewportSize.Y), 0, 65535)))
    Codec.i16(W, GuiInset.X)
    Codec.i16(W, GuiInset.Y)
    Codec.i16(W, GuiInset_2.X)
    Codec.i16(W, GuiInset_2.Y)
    a2:EndRecord()
    if v4 then
        W:u8(Op.SafeArea)
        for i, j in v4 do
            Codec.i16(W, j)
        end
        a2:EndRecord()
    end
end

function u52.Flush(a1, a2, a3) -- Line: 258 -- upvalues: Op (val), Codec (val) -- types: a1: table, a3: function
    local W_3, v1, v2, v3
    a1:_sampleVirtualCursor()
    local Events = a1.Events
    a1.Events = {}
    for i, j in a1.PendingMove do
        a1.LastMove[i] = j.Ms
        table.insert(Events, j)
    end
    table.clear(a1.PendingMove)
    local v4 = nil
    local v5 = nil
    for k, n in Events, v4, v5 do
        a2:Time(n.Ms)
        W_3 = a2.W
        W_3:u8(Op.Pointer)
        W_3:u8(n.Kind)
        W_3:u8(n.PointerId)
        W_3:u8(n.State)
        Codec.i16(W_3, n.X)
        Codec.i16(W_3, n.Y)
        a2:EndRecord()
    end
    local Keys = a1.Keys
    if not (#Keys > 0) then
        v1, v2, v3 = a1, a2, a3
    else
        local W
        a1.Keys = {}
        v4 = nil
        v5 = nil
        v2, v1, v3 = a2, a1, a3
        for m, i5 in Keys, v4, v5 do
            v2:Time(i5.Ms)
            W = v2.W
            W:u8(if not i5.Down then Op.KeyUp else Op.KeyDown)
            Codec.varuint(W, i5.Code)
            v2:EndRecord()
        end
    end
    v2:Time((v1.Clock()))
    v1:WriteViewport(v2)
    if v1.SelectedDirty then
        v1.SelectedDirty = false
        local v6 = v3(v1.Selected)
        local W_2 = v2.W
        W_2:u8(Op.Selected)
        Codec.varuint(W_2, if not v6 then 0 else v6 + 1)
        v2:EndRecord()
    end
end

function u52.Destroy(a1) -- Line: 301
    for i, j in a1.Connections do
        j:Disconnect()
    end
    table.clear(a1.Connections)
    a1.Events = {}
    a1.Keys = {}
    table.clear(a1.Held)
    a1.Selected = nil
end

return u52