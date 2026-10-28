-- Script path: ReplicatedStorage.Controllers.GUI.BackpackController.Main.SlotDragController
-- Decompile time: 11.65 ms

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local u10 = {}
u10.__index = u10
local u11 = nil

local function toGuiPosition(a1, a2) -- Line: 14
    local v1 = a1:FindFirstAncestorWhichIsA("ScreenGui")
    return a2 + (if not v1 then Vector2.zero else v1.AbsolutePosition)
end

local function disconnectAll(a1) -- Line: 20
    for i, j in a1 do
        j:Disconnect()
    end
    table.clear(a1)
end

local function isVisible(a1) -- Line: 27
    local Parent = a1
    while Parent do
        if Parent:IsA("GuiObject") and not Parent.Visible then
            return false
        end
        if Parent:IsA("ScreenGui") then
            return Parent.Enabled
        end
        Parent = Parent.Parent
    end
    return false
end

local function inheritedScale(a1) -- Line: 40
    local v1 = 1
    local Parent = a1
    while Parent do
        if not Parent:IsA("GuiObject") then
            break
        end
        for i, j in Parent:GetChildren() do
            if j:IsA("UIScale") then
                v1 = v1 * j.Scale
            end
        end
        Parent = Parent.Parent
    end
    return (math.max(v1, 0.001))
end

function u10.new(a1, a2) -- Line: 54 -- upvalues: u10 (val)
    local v1 = {
        SuppressActivationUntil = 0,
        DetectorHandledActivation = false,
        Destroyed = false,
        Button = a1,
        Options = a2,
        Connections = {},
        GestureConnections = {},
    }
    local u7 = setmetatable(v1, u10)
    local UIDragDetector = Instance.new("UIDragDetector")
    UIDragDetector.Name = "SlotDragDetector"
    UIDragDetector.DragStyle = Enum.UIDragDetectorDragStyle.TranslatePlane
    UIDragDetector.ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomOffset
    UIDragDetector.Enabled = false
    UIDragDetector.Parent = a1
    u7.Detector = UIDragDetector
    table.insert(u7.Connections, (UIDragDetector.DragStart:Connect(function(a1_2) -- Line: 76 -- upvalues: u7 (val), a1 (val)
        local v1 = a1:FindFirstAncestorWhichIsA("ScreenGui")
        u7:_begin(a1_2 + (if not v1 then Vector2.zero else v1.AbsolutePosition))
    end)))
    table.insert(u7.Connections, (UIDragDetector.DragContinue:Connect(function(a1_2) -- Line: 82 -- upvalues: u7 (val), a1 (val)
        local v1 = a1:FindFirstAncestorWhichIsA("ScreenGui")
        u7:_continue(a1_2 + (if not v1 then Vector2.zero else v1.AbsolutePosition))
    end)))
    table.insert(u7.Connections, (UIDragDetector.DragEnd:Connect(function(a1_2) -- Line: 88 -- upvalues: u7 (val), a1 (val)
        local v1 = a1:FindFirstAncestorWhichIsA("ScreenGui")
        u7:_finish(a1_2 + (if not v1 then Vector2.zero else v1.AbsolutePosition), false)
    end)))
    table.insert(u7.Connections, (a1.InputBegan:Connect(function(a1) -- Line: 94 -- upvalues: u7 (val), UIDragDetector (val)
        if u7.Gesture and u7.InputConnection then
            return
        end
        if a1.UserInputType ~= Enum.UserInputType.MouseButton1
            and a1.UserInputType ~= Enum.UserInputType.Touch
            and a1.KeyCode ~= Enum.KeyCode.ButtonA then
            return
        end
        u7.DetectorHandledActivation = false
        if not UIDragDetector.Enabled then
            return
        end
        if u7.InputConnection then
            u7.InputConnection:Disconnect()
        end
        u7.InputConnection = (a1:GetPropertyChangedSignal("UserInputState")):Connect(function() -- Line: 112 -- upvalues: a1 (val), u7 (upval)
            if a1.UserInputState == Enum.UserInputState.Cancel then
                u7:Cancel()
                return
            end
            if a1.UserInputState == Enum.UserInputState.End and u7.InputConnection then
                u7.InputConnection:Disconnect()
                u7.InputConnection = nil
            end
        end)
    end)))
    table.insert(u7.Connections, (a1.Destroying:Connect(function() -- Line: 130 -- upvalues: u7 (val)
        u7:Destroy()
    end)))
    return u7
end

function u10.SetEnabled(a1, a2) -- Line: 137
    if a1.Destroyed then
        return
    end
    if not a2 then
        a1:Cancel()
    end
    a1.Detector.Enabled = a2
end

function u10:IsActivationSuppressed() -- Line: 147
    local Gesture = self.Gesture
    local v1 = true
    if not (os.clock() < self.SuppressActivationUntil) then
        v1 = false
        if Gesture ~= nil then
            v1 = Gesture.Mode ~= "pending"
        end
    end
    return v1
end

function u10.ShouldHandleNativeActivation(a1) -- Line: 153
    local v1 = false
    if a1.Gesture == nil then
        v1 = not a1:IsActivationSuppressed() and not a1.DetectorHandledActivation
    end
    return v1
end

function u10:_begin(a2) -- Line: 162 -- upvalues: u11 (ref), isVisible (val), UserInputService (val), GuiService (val)
    if not self.Destroyed
        and not self.Gesture
        and not u11
        and self.Detector.Enabled
        and isVisible(self.Button)
        and self.Options.CanStart() then
        local v1
        self.DetectorHandledActivation = false
        local LastInputType = UserInputService:GetLastInputType()
        local ScrollingFrame = if not (LastInputType == Enum.UserInputType.Touch) then nil else self.Options.ScrollingFrame
        if ScrollingFrame and not self.Button:IsDescendantOf(ScrollingFrame) then
            ScrollingFrame = nil
        end
        self.Gesture = {
            Mode = "pending",
            StartPosition = a2,
            LastPosition = a2,
            Touch = v1,
            InputType = LastInputType,
            Scroller = ScrollingFrame,
            CanvasPosition = if not ScrollingFrame then nil else ScrollingFrame.CanvasPosition,
            ScrollingEnabled = if not ScrollingFrame then nil else ScrollingFrame.ScrollingEnabled,
        }
        u11 = self
        if ScrollingFrame then
            ScrollingFrame.ScrollingEnabled = false
        end

        local function cancel() -- Line: 200 -- upvalues: self (val)
            self:Cancel()
        end

        table.insert(self.GestureConnections, (UserInputService.WindowFocusReleased:Connect(cancel)))
        table.insert(self.GestureConnections, (GuiService.MenuOpened:Connect(cancel)))
        table.insert(self.GestureConnections, (self.Button.AncestryChanged:Connect(cancel)))
        local Button = self.Button
        while Button do
            if not Button:IsA("GuiObject") then
                if Button:IsA("ScreenGui") then
                    table.insert(self.GestureConnections, ((Button:GetPropertyChangedSignal("Enabled")):Connect(cancel)))
                    return
                end
            else
                table.insert(self.GestureConnections, ((Button:GetPropertyChangedSignal("Visible")):Connect(function() -- Line: 217 -- upvalues: isVisible (upval), self (val)
                    if not isVisible(self.Button) then
                        self:Cancel()
                    end
                end)))
            end
            Button = Button.Parent
        end
        return
    end
end

function u10:_createPreview(a2) -- Line: 234 -- upvalues: inheritedScale (val)
    local Button = self.Button
    local v1 = Button:FindFirstAncestorWhichIsA("ScreenGui")
    if not v1 then
        return false
    end
    local Frame = Instance.new("Frame")
    Frame.Name = "BackpackDragPreview"
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.fromScale(1, 1)
    Frame.Active = false
    Frame.ZIndex = 100
    Frame.Parent = v1
    a2.PreviewLayer = Frame
    v1 = Button:Clone()
    local Descendants = v1:GetDescendants()
    table.insert(Descendants, v1)
    local v2 = nil
    local v3 = nil
    local v4 = a2
    for i, j in Descendants, v2, v3 do
        if j:IsA("UIDragDetector") then
            j:Destroy()
        elseif not j:IsA("LuaSourceContainer") then
            for k, n in j:GetTags() do
                j:RemoveTag(n)
            end
            if j:IsA("GuiObject") then
                j.Active = false
                j.Selectable = false
                j.Interactable = false
            end
        else
            j:Destroy()
        end
    end
    for m, i5 in v1:GetChildren() do
        if i5:IsA("UIScale") or i5:IsA("UIAspectRatioConstraint") or i5:IsA("UISizeConstraint") then
            i5:Destroy()
        end
    end
    local v5 = inheritedScale(Button)
    local UIScale = Instance.new("UIScale")
    UIScale.Scale = v5
    UIScale.Parent = v1
    v1.Name = "Item"
    v1.AnchorPoint = Vector2.zero
    v1.Position = UDim2.fromOffset(0, 0)
    v1.Size = UDim2.fromOffset(Button.AbsoluteSize.X / v5, Button.AbsoluteSize.Y / v5)
    v1.AutomaticSize = Enum.AutomaticSize.None
    v1.Rotation = Button.AbsoluteRotation
    v1.ZIndex = 100
    v1.Visible = true
    local Frame_2 = Instance.new("Frame")
    Frame_2.Name = "Position"
    Frame_2.BackgroundTransparency = 1
    Frame_2.Size = UDim2.fromOffset(0, 0)
    Frame_2.ZIndex = 100
    Frame_2.Parent = Frame
    v1.Parent = Frame_2
    v4.PreviewHolder = Frame_2
    v4.PreviewOrigin = Button.AbsolutePosition
    return true
end

function u10:_continue(a2) -- Line: 307 -- upvalues: isVisible (val)
    local Gesture = self.Gesture
    if not Gesture then
        return
    end
    Gesture.LastPosition = a2
    if self.Options.CanStart() and isVisible(self.Button) then
        local Scroller, v1, v2
        local v3 = a2 - Gesture.StartPosition
        if Gesture.Mode == "pending" then
            if v3.Magnitude < (if not Gesture.Touch then 8 else 12) then
                return
            end
            if Gesture.Scroller and Gesture.ScrollingEnabled then
                v2 = math.abs(v3.Y)
                if math.abs(v3.X) <= v2 then
                    Gesture.Mode = "scrolling"
                    if Gesture.Mode == "scrolling" then
                        Scroller = Gesture.Scroller
                        v2 = math.max(0, Scroller.AbsoluteCanvasSize.Y - Scroller.AbsoluteWindowSize.Y)
                        Scroller.CanvasPosition = Vector2.new(Gesture.CanvasPosition.X, (math.clamp(Gesture.CanvasPosition.Y - v3.Y, 0, v2)))
                        return
                    end
                    if Gesture.Mode == "dragging" then
                        v1 = Gesture.PreviewOrigin + v3 - Gesture.PreviewLayer.AbsolutePosition
                        Gesture.PreviewHolder.Position = UDim2.fromOffset(v1.X, v1.Y)
                    end
                    return
                end
            end
            Gesture.Mode = "dragging"
            self.Options.OnDragStart()
            if self.Gesture ~= Gesture then
                return
            end
            if not self:_createPreview(Gesture) then
                self:Cancel()
                return
            end
        end
        if Gesture.Mode == "scrolling" then
            Scroller = Gesture.Scroller
            v2 = math.max(0, Scroller.AbsoluteCanvasSize.Y - Scroller.AbsoluteWindowSize.Y)
            Scroller.CanvasPosition = Vector2.new(Gesture.CanvasPosition.X, (math.clamp(Gesture.CanvasPosition.Y - v3.Y, 0, v2)))
            return
        end
        if Gesture.Mode == "dragging" then
            v1 = Gesture.PreviewOrigin + v3 - Gesture.PreviewLayer.AbsolutePosition
            Gesture.PreviewHolder.Position = UDim2.fromOffset(v1.X, v1.Y)
        end
        return
    end
    self:Cancel()
end

function u10:_finish(a2, a3) -- Line: 361 -- upvalues: isVisible (val), u11 (ref)
    local Gesture = self.Gesture
    if not Gesture then
        return
    end
    local v1 = a3 or not self.Options.CanStart() or not isVisible(self.Button)
    self.Gesture = nil
    if u11 == self then
        u11 = nil
    end
    local GestureConnections = self.GestureConnections
    local v2 = GestureConnections
    for i, j in v2 do
        j:Disconnect()
    end
    table.clear(GestureConnections)
    if self.InputConnection then
        self.InputConnection:Disconnect()
        self.InputConnection = nil
    end
    if Gesture.PreviewLayer then
        Gesture.PreviewLayer:Destroy()
    end
    if Gesture.Scroller and Gesture.Scroller.Parent then
        Gesture.Scroller.ScrollingEnabled = Gesture.ScrollingEnabled
    end
    if v1 or Gesture.Mode ~= "pending" then
        self.SuppressActivationUntil = os.clock() + 0.2
    end
    if Gesture.Mode == "dragging" then
        self.Options.OnDragEnd(a2, v1)
        return
    end
    if Gesture.Mode == "pending" and not v1 and self.Options.CanStart() and isVisible(self.Button) then
        local AbsolutePosition = self.Button.AbsolutePosition
        v2 = AbsolutePosition + self.Button.AbsoluteSize
        if AbsolutePosition.X <= a2.X and AbsolutePosition.Y <= a2.Y and a2.X <= v2.X and a2.Y <= v2.Y then
            self.DetectorHandledActivation = true
            self.Options.OnActivate(Gesture.InputType)
        end
    end
end

function u10:Cancel() -- Line: 412
    local Gesture = self.Gesture
    if Gesture then
        self:_finish(Gesture.LastPosition, true)
    end
end

function u10:Destroy() -- Line: 419
    if self.Destroyed then
        return
    end
    self.Destroyed = true
    self:Cancel()
    local Connections = self.Connections
    for i, j in Connections do
        j:Disconnect()
    end
    table.clear(Connections)
    if self.InputConnection then
        self.InputConnection:Disconnect()
        self.InputConnection = nil
    end
    self.Detector:Destroy()
end

return u10