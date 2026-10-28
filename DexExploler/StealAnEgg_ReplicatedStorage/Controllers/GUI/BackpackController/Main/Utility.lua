-- Script path: ReplicatedStorage.Controllers.GUI.BackpackController.Main.Utility
-- Decompile time: 96.79 ms

local u4 = Color3.fromRGB(0, 162, 255)
local u9 = Color3.fromRGB(78, 84, 96)
local u14 = Color3.fromRGB(204, 204, 204)
local u19 = Color3.fromRGB(255, 255, 255)
local u24 = Color3.fromRGB(150, 150, 150)
local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local PlayerGui = game.Players.LocalPlayer.PlayerGui
PlayerGui:WaitForChild("BackpackGui")
local ContextActionService = game:GetService("ContextActionService")
local VRService = game:GetService("VRService")
local success, err = pcall(function() -- Line: 39
    return false
end)
local u67 = success and err
local u68 = {}

function u68.Create(a1) -- Line: 48
    return function(a1_2) -- Line: 49 -- upvalues: a1 (val)
        local v1 = Instance.new(a1)
        local v2 = nil
        for k, v in pairs(a1_2) do
            if type(k) == "number" then
                v.Parent = v1
            elseif k ~= "Parent" then
                v1[k] = v
            else
                v2 = v
            end
        end
        if v2 then
            v1.Parent = v2
        end
        return v1
    end
end

local u70 = {}
setmetatable(u70, {__mode = "k"})
local u79 = u68.Create("ImageLabel")({Image = "", BackgroundTransparency = 1})

function clamp(a1, a2, a3) -- Line: 79
    return (math.max(a1, (math.min(a2, a3))))
end

function ClampVector2(a1, a2, a3) -- Line: 81
    return Vector2.new(clamp(a1.x, a2.x, a3.x), clamp(a1.y, a2.y, a3.y))
end

local function Linear(a1, a2, a3, a4) -- Line: 86
    if a4 <= a1 then
        return a2 + a3
    end
    return a3 * a1 / a4 + a2
end

local function EaseOutQuad(a1, a2, a3, a4) -- Line: 94
    if a4 <= a1 then
        return a2 + a3
    end
    local v1 = a1 / a4
    return a2 - a3 * v1 * (v1 - 2)
end

local function EaseInOutQuad(a1, a2, a3, a4) -- Line: 103
    if a4 <= a1 then
        return a2 + a3
    end
    local v1 = a1 / a4
    if v1 < 0.5 then
        return 2 * a3 * v1 * v1 + a2
    end
    return a2 + a3 * (2 * (2 - v1) * v1 - 1)
end

function PropertyTweener(a1, a2, a3, a4, a5, a6, a7) -- Line: 115 -- upvalues: RunService (val)
    local u7 = {}
    u7.StartTime = tick()
    u7.EndTime = u7.StartTime + a5
    u7.Cancelled = false
    local u13 = false
    local u14 = 0

    local function finalize() -- Line: 124
        -- upvalues: a1 (val), a2 (val), a6 (val), a3 (val), a4 (val), u13 (ref), u14 (ref), a7 (val)
        if a1 then
            a1[a2] = (a6(1, a3, a4 - a3, 1))
        end
        u13 = true
        u14 = 1
        if a7 then
            a7()
        end
    end

    a1[a2] = (a6(0, a3, a4 - a3, a5))
    coroutine.wrap(function() -- Line: 137
        -- upvalues: u7 (val), a1 (val), a2 (val), a6 (val), a3 (val), a4 (val), a5 (val), u14 (ref), RunService (upval)
        -- upvalues: u13 (ref), a7 (val)
        local v1 = tick()
        while v1 < u7.EndTime do
            if not a1 then
                break
            end
            if u7.Cancelled then
                return
            end
            a1[a2] = (a6(v1 - u7.StartTime, a3, a4 - a3, a5))
            clamp(0, 1, (v1 - u7.StartTime) / a5)
            RunService.RenderStepped:wait()
            tick()
        end
        if u7.Cancelled == false and a1 then
            if a1 then
                a1[a2] = (a6(1, a3, a4 - a3, 1))
            end
            u13 = true
            u14 = 1
            if a7 then
                a7()
            end
        end
    end)()

    function u7.GetFinal(a1) -- Line: 153 -- upvalues: a4 (val)
        return a4
    end

    function u7.GetPercentComplete(a1) -- Line: 155 -- upvalues: u14 (ref)
        return u14
    end

    function u7.IsFinished(a1) -- Line: 157 -- upvalues: u13 (ref)
        return u13
    end

    function u7.Finish(a1_2) -- Line: 159
        -- upvalues: u13 (ref), a1 (val), a2 (val), a6 (val), a3 (val), a4 (val), u14 (ref), a7 (val)
        if not u13 then
            a1_2:Cancel()
            if a1 then
                a1[a2] = (a6(1, a3, a4 - a3, 1))
            end
            u13 = true
            u14 = 1
            if a7 then
                a7()
            end
        end
    end

    function u7.Cancel(a1) -- Line: 166 -- upvalues: u7 (val)
        u7.Cancelled = true
    end

    return u7
end

local function CreateSignal() -- Line: 173
    local v1 = {}
    local BindableEvent = Instance.new("BindableEvent")
    local u4 = nil
    local u5 = nil

    function v1.fire(a1, ...) -- Line: 181 -- upvalues: u4 (ref), u5 (ref), BindableEvent (val)
        u4 = {...}
        select("#", ...)
        BindableEvent:Fire()
    end

    function v1.connect(a1, a2) -- Line: 187 -- upvalues: BindableEvent (val), u4 (ref), u5 (ref)
        if not a2 then
            error("connect(nil)", 2)
        end
        return BindableEvent.Event:Connect(function() -- Line: 191 -- upvalues: a2 (val), u4 (upval), u5 (upval)
            local v1 = u5
            a2(unpack(u4, 1, v1))
        end)
    end

    function v1.wait(a1) -- Line: 194 -- upvalues: BindableEvent (val), u4 (ref), u5 (ref)
        BindableEvent.Event:wait()
        if not u4 then
            error("Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.")
        end
        return unpack(u4, 1, u5)
    end

    return v1
end

local function getViewportSize() -- Line: 205
    while not workspace.CurrentCamera do
        workspace.Changed:wait()
    end
    while true do
        if workspace.CurrentCamera.ViewportSize == Vector2.new(0, 0) then
            workspace.CurrentCamera.Changed:wait()
            continue
        end
        if workspace.CurrentCamera.ViewportSize ~= Vector2.new(1, 1) then
            break
        end
        workspace.CurrentCamera.Changed:wait()
    end
    return workspace.CurrentCamera.ViewportSize
end

local function isSmallTouchScreen() -- Line: 222 -- upvalues: getViewportSize (val), UserInputService (val)
    local v1 = getViewportSize()
    local TouchEnabled = UserInputService.TouchEnabled
    if TouchEnabled then
        TouchEnabled = true
        if not (v1.Y < 500) then
            TouchEnabled = v1.X < 700
        end
    end
    return TouchEnabled
end

local function isPortrait() -- Line: 227 -- upvalues: getViewportSize (val)
    local v1 = getViewportSize()
    return v1.X < v1.Y
end

local function isTenFootInterface() -- Line: 232
    return false
end

local function usesSelectedObject() -- Line: 234 -- upvalues: VRService (val), UserInputService (val)
    if VRService.VREnabled then
        return false
    end
    if UserInputService.TouchEnabled and not UserInputService.GamepadEnabled then
        return false
    end
    return true
end

local function isPosOverGui(a1, a2, a3) -- Line: 247
    local x = a2.AbsolutePosition.x
    local y = a2.AbsolutePosition.y
    local x_2 = a2.AbsoluteSize.x
    local y_2 = a2.AbsoluteSize.y
    local v1 = x + x_2
    local v2 = y + y_2
    local v3 = false
    if x < a1.x then
        v3 = false
        if a1.x < v1 then
            v3 = false
            if y < a1.y then
                v3 = a1.y < v2
            end
        end
    end
    return v3
end

local function isPosOverGuiWithClipping(a1, a2) -- Line: 255
    local v1, v2, v3, v4, x_3, x_4, y_3, y_4
    local x = a2.AbsolutePosition.x
    local y = a2.AbsolutePosition.y
    local x_2 = a2.AbsoluteSize.x
    local y_2 = a2.AbsoluteSize.y
    local v5 = x + x_2
    local v6 = y + y_2
    local v7 = false
    if x < a1.x then
        v7 = false
        if a1.x < v5 then
            v7 = false
            if y < a1.y then
                v7 = a1.y < v6
            end
        end
    end
    if not v7 then
        return false
    end
    local Parent = a2
    while Parent ~= nil do
        if not Parent:IsA("GuiObject") then
            if not Parent:IsA("LayerCollector") then
                break
            end
        end
        if not Parent:IsA("GuiObject") then
            if Parent:IsA("LayerCollector") then
                x_3 = Parent.AbsolutePosition.x
                y_3 = Parent.AbsolutePosition.y
                x_4 = Parent.AbsoluteSize.x
                y_4 = Parent.AbsoluteSize.y
                v2 = x_3 + x_4
                v3 = y_3 + y_4
                v4 = false
                if x_3 < v1.x then
                    v4 = false
                    if v1.x < v2 then
                        v4 = false
                        if y_3 < v1.y then
                            v4 = v1.y < v3
                        end
                    end
                end
                if v4 then
                    Parent = Parent.Parent
                    continue
                else
                    v7 = true
                end
            elseif not Parent.ClipsDescendants then
                Parent = Parent.Parent
                continue
            else
                x_3 = Parent.AbsolutePosition.x
                y_3 = Parent.AbsolutePosition.y
                x_4 = Parent.AbsoluteSize.x
                y_4 = Parent.AbsoluteSize.y
                v2 = x_3 + x_4
                v3 = y_3 + y_4
                v4 = false
                if x_3 < v1.x then
                    v4 = false
                    if v1.x < v2 then
                        v4 = false
                        if y_3 < v1.y then
                            v4 = v1.y < v3
                        end
                    end
                end
                if v4 then
                    Parent = Parent.Parent
                    continue
                else
                    v7 = true
                end
            end
        elseif not Parent.Visible then
            v7 = true
        elseif Parent:IsA("LayerCollector") then
            x_3 = Parent.AbsolutePosition.x
            y_3 = Parent.AbsolutePosition.y
            x_4 = Parent.AbsoluteSize.x
            y_4 = Parent.AbsoluteSize.y
            v2 = x_3 + x_4
            v3 = y_3 + y_4
            v4 = false
            if x_3 < v1.x then
                v4 = false
                if v1.x < v2 then
                    v4 = false
                    if y_3 < v1.y then
                        v4 = v1.y < v3
                    end
                end
            end
            if v4 then
                Parent = Parent.Parent
                continue
            else
                v7 = true
            end
        elseif not Parent.ClipsDescendants then
            Parent = Parent.Parent
            continue
        else
            x_3 = Parent.AbsolutePosition.x
            y_3 = Parent.AbsolutePosition.y
            x_4 = Parent.AbsoluteSize.x
            y_4 = Parent.AbsoluteSize.y
            v2 = x_3 + x_4
            v3 = y_3 + y_4
            v4 = false
            if x_3 < v1.x then
                v4 = false
                if v1.x < v2 then
                    v4 = false
                    if y_3 < v1.y then
                        v4 = v1.y < v3
                    end
                end
            end
            if v4 then
                Parent = Parent.Parent
                continue
            else
                v7 = true
            end
        end
        return not v7
    end
    v7 = true
    if Parent and Parent:IsA("CoreGui") then
        v7 = false
    end
    return not v7
end

local function areGuisIntersecting(a1, a2) -- Line: 288
    local x = a1.AbsolutePosition.x
    local y = a1.AbsolutePosition.y
    local x_2 = a1.AbsoluteSize.x
    local y_2 = a1.AbsoluteSize.y
    local v1 = x + x_2
    local v2 = y + y_2
    local x_3 = a2.AbsolutePosition.x
    local y_3 = a2.AbsolutePosition.y
    local x_4 = a2.AbsoluteSize.x
    local y_4 = a2.AbsoluteSize.y
    local v3 = x_3 + x_4
    local v4 = y_3 + y_4
    local v5 = false
    if x < v3 then
        v5 = x_3 < v1
    end
    v3 = false
    if y < v4 then
        v3 = y_3 < v2
    end
    return v5 and v3
end

local function isGuiVisible(a1, a2) -- Line: 303
    local v1, v2, v3, v4, v5, v6, v7, x, x_2, x_3, x_4, y, y_2, y_3, y_4
    local Parent = a1
    while Parent ~= nil do
        if not Parent:IsA("GuiObject") then
            if not Parent:IsA("LayerCollector") then
                break
            end
        end
        if not Parent:IsA("GuiObject") then
            if Parent:IsA("LayerCollector") then
                x = Parent.AbsolutePosition.x
                y = Parent.AbsolutePosition.y
                x_2 = Parent.AbsoluteSize.x
                y_2 = Parent.AbsoluteSize.y
                v2 = x + x_2
                v3 = y + y_2
                x_3 = v1.AbsolutePosition.x
                y_3 = v1.AbsolutePosition.y
                x_4 = v1.AbsoluteSize.x
                y_4 = v1.AbsoluteSize.y
                v5 = x_3 + x_4
                v6 = y_3 + y_4
                v4 = false
                if x < v5 then
                    v4 = x_3 < v2
                end
                v5 = false
                if y < v6 then
                    v5 = y_3 < v3
                end
                if v4 and v5 then
                    Parent = Parent.Parent
                    continue
                else
                    v7 = true
                end
            elseif not Parent.ClipsDescendants then
                Parent = Parent.Parent
                continue
            else
                x = Parent.AbsolutePosition.x
                y = Parent.AbsolutePosition.y
                x_2 = Parent.AbsoluteSize.x
                y_2 = Parent.AbsoluteSize.y
                v2 = x + x_2
                v3 = y + y_2
                x_3 = v1.AbsolutePosition.x
                y_3 = v1.AbsolutePosition.y
                x_4 = v1.AbsoluteSize.x
                y_4 = v1.AbsoluteSize.y
                v5 = x_3 + x_4
                v6 = y_3 + y_4
                v4 = false
                if x < v5 then
                    v4 = x_3 < v2
                end
                v5 = false
                if y < v6 then
                    v5 = y_3 < v3
                end
                if v4 and v5 then
                    Parent = Parent.Parent
                    continue
                else
                    v7 = true
                end
            end
        elseif not Parent.Visible then
            v7 = true
        elseif Parent:IsA("LayerCollector") then
            x = Parent.AbsolutePosition.x
            y = Parent.AbsolutePosition.y
            x_2 = Parent.AbsoluteSize.x
            y_2 = Parent.AbsoluteSize.y
            v2 = x + x_2
            v3 = y + y_2
            x_3 = v1.AbsolutePosition.x
            y_3 = v1.AbsolutePosition.y
            x_4 = v1.AbsoluteSize.x
            y_4 = v1.AbsoluteSize.y
            v5 = x_3 + x_4
            v6 = y_3 + y_4
            v4 = false
            if x < v5 then
                v4 = x_3 < v2
            end
            v5 = false
            if y < v6 then
                v5 = y_3 < v3
            end
            if v4 and v5 then
                Parent = Parent.Parent
                continue
            else
                v7 = true
            end
        elseif not Parent.ClipsDescendants then
            Parent = Parent.Parent
            continue
        else
            x = Parent.AbsolutePosition.x
            y = Parent.AbsolutePosition.y
            x_2 = Parent.AbsoluteSize.x
            y_2 = Parent.AbsoluteSize.y
            v2 = x + x_2
            v3 = y + y_2
            x_3 = v1.AbsolutePosition.x
            y_3 = v1.AbsolutePosition.y
            x_4 = v1.AbsoluteSize.x
            y_4 = v1.AbsoluteSize.y
            v5 = x_3 + x_4
            v6 = y_3 + y_4
            v4 = false
            if x < v5 then
                v4 = x_3 < v2
            end
            v5 = false
            if y < v6 then
                v5 = y_3 < v3
            end
            if v4 and v5 then
                Parent = Parent.Parent
                continue
            else
                v7 = true
            end
        end
        return not v7
    end
    v7 = true
    if Parent and Parent:IsA("CoreGui") then
        v7 = false
    end
    return not v7
end

local function addHoverState(a1, a2, a3, a4) -- Line: 332
    local function onNormalButtonStateCallback() -- Line: 333 -- upvalues: a1 (val), a3 (val), a2 (val)
        if a1.Active then
            a3(a2)
        end
    end

    local function onHoverButtonStateCallback() -- Line: 338 -- upvalues: a1 (val), a4 (val), a2 (val)
        if a1.Active then
            a4(a2)
        end
    end

    a1.MouseEnter:Connect(onHoverButtonStateCallback)
    a1.SelectionGained:Connect(onHoverButtonStateCallback)
    a1.MouseLeave:Connect(onNormalButtonStateCallback)
    a1.SelectionLost:Connect(onNormalButtonStateCallback)
    a3(a2)
end

local function addOnResizedCallback(a1, a2) -- Line: 352 -- upvalues: u70 (val), getViewportSize (val)
    u70[a1] = a2
    local v1 = getViewportSize()
    local v2 = getViewportSize()
    a2(v1, v2.X < v2.Y)
end

local u98 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true,
}

local function MakeDefaultButton(a1, a2, a3, a4, a5) -- Line: 368
    -- upvalues: u68 (val), u98 (val), UserInputService (val), GuiService (val), VRService (val)
    local v1 = u68.Create("ImageLabel")({Image = "", BackgroundTransparency = 1})
    local u26 = u68.Create("ImageButton")({
        Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        ZIndex = 2,
        Name = a1 .. "Button",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 6, 46, 44),
        Size = a2,
        SelectionImageObject = v1,
    })
    u68.Create("BoolValue")({Name = "Enabled", Value = true, Parent = u26})
    if a3 then
        u26.MouseButton1Click:Connect(function() -- Line: 394 -- upvalues: a3 (val), u98 (upval), UserInputService (upval)
            a3(u98[UserInputService:GetLastInputType()] or false)
        end)
    end

    local function isPointerInput(a1) -- Line: 398
        local v1 = true
        if a1.UserInputType ~= Enum.UserInputType.MouseMovement then
            v1 = a1.UserInputType == Enum.UserInputType.Touch
        end
        return v1
    end

    local u40 = nil

    local function selectButton() -- Line: 406 -- upvalues: a5 (val), a4 (val), u26 (val), u40 (ref)
        local v1
        local HubRef = a5
        if HubRef == nil and a4 then
            HubRef = a4.HubRef
        end
        if not HubRef then
            if HubRef == nil then
                u26.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
                v1 = u26
                if u40 then
                    v1 = u40
                end
                if HubRef then
                    HubRef:ScrollToFrame(v1)
                end
            end
        elseif HubRef.Active or HubRef == nil then
            u26.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
            v1 = u26
            if u40 then
                v1 = u40
            end
            if HubRef then
                HubRef:ScrollToFrame(v1)
            end
        end
    end

    local function deselectButton() -- Line: 427 -- upvalues: u26 (val)
        u26.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
    end

    u26.InputBegan:Connect(function(a1) -- Line: 431 -- upvalues: u26 (val), a5 (val), a4 (val), u40 (ref)
        if u26.Selectable then
            local v1 = true
            if a1.UserInputType ~= Enum.UserInputType.MouseMovement then
                v1 = a1.UserInputType == Enum.UserInputType.Touch
            end
            if v1 then
                local v2
                local HubRef = a5
                if HubRef == nil and a4 then
                    HubRef = a4.HubRef
                end
                if not HubRef then
                    if HubRef == nil then
                        u26.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
                        v2 = u26
                        if u40 then
                            v2 = u40
                        end
                        if HubRef then
                            HubRef:ScrollToFrame(v2)
                        end
                    end
                elseif HubRef.Active or HubRef == nil then
                    u26.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
                    v2 = u26
                    if u40 then
                        v2 = u40
                    end
                    if HubRef then
                        HubRef:ScrollToFrame(v2)
                    end
                end
            end
        end
    end)
    u26.InputEnded:Connect(function(a1) -- Line: 436 -- upvalues: u26 (val), GuiService (upval)
        if u26.Selectable and GuiService.SelectedCoreObject ~= u26 then
            local v1 = true
            if a1.UserInputType ~= Enum.UserInputType.MouseMovement then
                v1 = a1.UserInputType == Enum.UserInputType.Touch
            end
            if v1 then
                u26.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
            end
        end
    end)
    u26.SelectionGained:Connect(function() -- Line: 446 -- upvalues: a5 (val), a4 (val), u26 (val), u40 (ref)
        local v1
        local HubRef = a5
        if HubRef == nil and a4 then
            HubRef = a4.HubRef
        end
        if not HubRef then
            if HubRef == nil then
                u26.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
                v1 = u26
                if u40 then
                    v1 = u40
                end
                if HubRef then
                    HubRef:ScrollToFrame(v1)
                end
            end
        elseif HubRef.Active or HubRef == nil then
            u26.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
            v1 = u26
            if u40 then
                v1 = u40
            end
            if HubRef then
                HubRef:ScrollToFrame(v1)
            end
        end
    end)
    u26.SelectionLost:Connect(function() -- Line: 447 -- upvalues: u26 (val)
        u26.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
    end)
    GuiService.Changed:Connect(function(a1) -- Line: 449
        -- upvalues: VRService (upval), UserInputService (upval), GuiService (upval), u26 (val), a5 (val), a4 (val)
        -- upvalues: u40 (ref)
        if a1 ~= "SelectedCoreObject"
            or not (if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false) then
            return
        end
        if GuiService.SelectedCoreObject ~= nil and GuiService.SelectedCoreObject == u26 then
            if u26.Selectable then
                local v1
                local HubRef = a5
                if HubRef == nil and a4 then
                    HubRef = a4.HubRef
                end
                if not HubRef then
                    if HubRef == nil then
                        u26.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
                        v1 = u26
                        if u40 then
                            v1 = u40
                        end
                        if HubRef then
                            HubRef:ScrollToFrame(v1)
                        end
                    end
                elseif HubRef.Active or HubRef == nil then
                    u26.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButtonSelected.png"
                    v1 = u26
                    if u40 then
                        v1 = u40
                    end
                    if HubRef then
                        HubRef:ScrollToFrame(v1)
                    end
                end
            end
            return
        end
        u26.Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png"
    end)
    return u26, function(a1) -- Line: 404 -- upvalues: u40 (ref)
        u40 = a1
    end
end

local function MakeButton(a1, a2, a3, a4, a5, a6) -- Line: 470
    -- upvalues: MakeDefaultButton (val), u68 (val), getViewportSize (val), UserInputService (val)
    local v1, v2 = MakeDefaultButton(a1, a3, a4, a5, a6)
    local v3 = u68.Create("TextLabel")({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        TextSize = 24,
        TextScaled = true,
        TextWrapped = true,
        ZIndex = 2,
        Name = a1 .. "TextLabel",
        Size = UDim2.new(1, 0, 1, -8),
        Position = UDim2.new(0, 0, 0, 0),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextYAlignment = Enum.TextYAlignment.Center,
        Font = Enum.Font.SourceSansBold,
        Text = a2,
        Parent = v1,
    })
    local v4 = Instance.new("UITextSizeConstraint", v3)
    local v5 = getViewportSize()
    local TouchEnabled = UserInputService.TouchEnabled
    if TouchEnabled then
        TouchEnabled = true
        if not (v5.Y < 500) then
            TouchEnabled = v5.X < 700
        end
    end
    if TouchEnabled then
        v3.TextSize = 18
    elseif false then
        v3.TextSize = 36
    end
    v4.MaxTextSize = v3.TextSize
    return v1, v3, v2
end

local function MakeImageButton(a1, a2, a3, a4, a5, a6, a7) -- Line: 501 -- upvalues: MakeDefaultButton (val), u68 (val)
    local v1, v2 = MakeDefaultButton(a1, a3, a5, a6, a7)
    return v1, (u68.Create("ImageLabel")({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 2,
        Name = a1 .. "ImageLabel",
        Size = a4,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Image = a2,
        Parent = v1,
    })), v2
end

local function AddButtonRow(a1, a2, a3, a4, a5, a6) -- Line: 519 -- upvalues: MakeButton (val), u68 (val)
    local v1, v2, v3 = MakeButton(a2, a3, a4, a5, a1, a6)
    local v4 = u68.Create("Frame")({
        BackgroundTransparency = 1,
        Name = a2 .. "Row",
        Size = UDim2.new(1, 0, a4.Y.Scale, a4.Y.Offset),
        Parent = a1.Page,
    })
    v1.Parent = v4
    v1.AnchorPoint = Vector2.new(1, 0)
    v1.Position = UDim2.new(1, -20, 0, 0)
    return v4, v1, v2, v3
end

local function CreateDropDown(a1, a2, a3) -- Line: 533
    -- upvalues: HttpService (val), u68 (val), PlayerGui (val), VRService (val), UserInputService (val)
    -- upvalues: GuiService (val), ContextActionService (val), MakeButton (val)
    local u7 = Color3.fromRGB(178, 178, 178)
    local u12 = Color3.fromRGB(229, 229, 229)
    local u17 = Color3.fromRGB(255, 255, 255)
    local u18 = nil
    local u19 = {CurrentIndex = nil}
    local BindableEvent_2 = Instance.new("BindableEvent")
    BindableEvent_2.Name = "IndexChanged"
    if type(a1) ~= "table" then
        error("CreateDropDown dropDownStringTable (first arg) is not a table", 2)
        return u19
    end
    local BindableEvent = Instance.new("BindableEvent")
    BindableEvent.Name = "IndexChanged"
    local u36 = true
    local u41 = HttpService:GenerateGUID(false)
    local Enabled = nil
    local u43 = a1
    local u62 = u68.Create("ImageButton")({
        Name = "DropDownFullscreenFrame",
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        ZIndex = 10,
        Active = true,
        Visible = false,
        Selectable = false,
        AutoButtonColor = false,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        Parent = PlayerGui.RobloxGui,
    })

    local function onVREnabled(a1) -- Line: 579
        -- upvalues: VRService (upval), PlayerGui (upval), u62 (val), u19 (val), u43 (ref)
        if a1 ~= "VREnabled" then
            return
        end
        if not VRService.VREnabled then
            u62.Parent = PlayerGui.RobloxGui
            u62.BackgroundTransparency = 0.2
        else
            u62.Parent = (require(PlayerGui.RobloxGui.Modules.VR.Panel3D)).Get("SettingsMenu"):GetGUI()
            u62.BackgroundTransparency = 1
        end
        if u19.UpdateDropDownList then
            u19:UpdateDropDownList(u43)
        end
    end

    VRService.Changed:Connect(onVREnabled)
    onVREnabled("VREnabled")
    local u101 = u68.Create("ImageLabel")({
        Name = "DropDownSelectionFrame",
        Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
        BackgroundTransparency = 1,
        ZIndex = 10,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 6, 46, 44),
        Size = UDim2.new(0.6, 0, 0.9, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Parent = u62,
    })
    local u119 = u68.Create("ScrollingFrame")({
        Name = "DropDownScrollingFrame",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 10,
        Size = UDim2.new(1, -20, 1, -25),
        Position = UDim2.new(0, 10, 0, 10),
        Parent = u101,
    })
    local u120 = nil
    local u121 = false

    local function u122(a1, a2) -- Line: 625
        -- upvalues: u19 (val), u36 (ref), a3 (val), u62 (val), VRService (upval), UserInputService (upval)
        -- upvalues: GuiService (upval), u18 (ref), u120 (ref), ContextActionService (upval), u41 (val), Enabled (ref)
        -- upvalues: u121 (ref), PlayerGui (upval)
        if a1 ~= nil and a2 ~= Enum.UserInputState.Begin then
            return
        end
        u19.DropDownFrame.Selectable = u36
        a3:SetActive(true)
        if u62.Visible
            and (if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false) then
            GuiService.SelectedCoreObject = u18
        end
        u62.Visible = false
        if u120 then
            u120:Disconnect()
        end
        ContextActionService:UnbindAction(u41 .. "Action")
        ContextActionService:UnbindAction(u41 .. "FreezeAction")
        Enabled.Value = u36
        u121 = false
        if VRService.VREnabled then
            ((require(PlayerGui.RobloxGui.Modules.VR.Panel3D)).Get("SettingsMenu")):SetSubpanelDepth(u62, 0)
        end
    end

    local function u123() end

    local function u124() -- Line: 655
        -- upvalues: u36 (ref), u19 (val), u121 (ref), u62 (val), VRService (upval), PlayerGui (upval), u18 (ref)
        -- upvalues: GuiService (upval), u120 (ref), u17 (val), u12 (val), u7 (val), ContextActionService (upval)
        -- upvalues: u41 (val), u123 (val), u122 (val), a3 (val), Enabled (ref)
        if not u36 then
            return
        end
        u19.DropDownFrame.Selectable = false
        u121 = true
        u62.Visible = true
        if VRService.VREnabled then
            ((require(PlayerGui.RobloxGui.Modules.VR.Panel3D)).Get("SettingsMenu")):SetSubpanelDepth(u62, 0.5)
        end
        u18 = u19.DropDownFrame
        if u19.CurrentIndex and 0 < u19.CurrentIndex then
            GuiService.SelectedCoreObject = u19.Selections[u19.CurrentIndex]
        end
        ;(GuiService:GetPropertyChangedSignal("SelectedCoreObject")):Connect(function() -- Line: 675
            -- upvalues: u19 (upval), GuiService (upval), u17 (upval), VRService (upval), u12 (upval), u7 (upval)
            local v1
            local v2 = #u19.Selections
            for i = 1, v2 do
                if GuiService.SelectedCoreObject ~= u19.Selections[i] then
                    v1 = u19.Selections[i]
                    v1.TextColor3 = VRService.VREnabled and u12 or u7
                else
                    v1 = u19.Selections[i]
                    v1.TextColor3 = u17
                end
            end
        end)
        ContextActionService:BindActionAtPriority(
            u41 .. "FreezeAction",
            u123,
            false,
            Enum.ContextActionPriority.High.Value,
            Enum.UserInputType.Keyboard,
            Enum.UserInputType.Gamepad1
        )
        ContextActionService:BindActionAtPriority(
            u41 .. "Action",
            u122,
            false,
            Enum.ContextActionPriority.High.Value,
            Enum.KeyCode.ButtonB,
            Enum.KeyCode.Escape
        )
        a3:SetActive(false)
        Enabled.Value = false
    end

    u19.DropDownFrame = MakeButton("DropDownFrame", "Choose One", UDim2.new(0.6, 0, 0, 50), u124, nil, a3)
    u19.DropDownFrame.Position = UDim2.new(1, 0, 0.5, 0)
    u19.DropDownFrame.AnchorPoint = Vector2.new(1, 0.5)
    Enabled = u19.DropDownFrame.Enabled
    local DropDownFrameTextLabel = u19.DropDownFrame.DropDownFrameTextLabel
    DropDownFrameTextLabel.Position = UDim2.new(0, 15, 0, 0)
    DropDownFrameTextLabel.Size = UDim2.new(1, -50, 1, -8)
    DropDownFrameTextLabel.ClipsDescendants = true
    DropDownFrameTextLabel.TextXAlignment = Enum.TextXAlignment.Left
    local u191 = u68.Create("ImageLabel")({
        Name = "DropDownImage",
        Image = "rbxasset://textures/ui/Settings/DropDown/DropDown.png",
        BackgroundTransparency = 1,
        ZIndex = 2,
        AnchorPoint = Vector2.new(1, 0.5),
        Size = UDim2.new(0, 15, 0, 10),
        Position = UDim2.new(1, -12, 0.5, 0),
        Parent = u19.DropDownFrame,
    })
    u19.DropDownImage = u191

    local function setSelection(a1) -- Line: 739
        -- upvalues: u19 (val), DropDownFrameTextLabel (val), BindableEvent (val)
        local v1 = false
        for k, v in pairs(u19.Selections) do
            if k == a1 then
                DropDownFrameTextLabel.Text = v.Text
                u19.CurrentIndex = k
                v1 = true
            end
        end
        if v1 then
            BindableEvent:Fire(a1)
        end
    end

    local function setSelectionByValue(a1) -- Line: 755
        -- upvalues: u19 (val), DropDownFrameTextLabel (val), BindableEvent (val)
        local v1 = false
        for k, v in pairs(u19.Selections) do
            if v.Text == a1 then
                DropDownFrameTextLabel.Text = v.Text
                u19.CurrentIndex = k
                v1 = true
            end
        end
        if v1 then
            BindableEvent:Fire(u19.CurrentIndex)
        end
        return v1
    end

    local u194 = false

    local function processInput(a1) -- Line: 773 -- upvalues: GuiService (upval), u19 (val), u194 (ref), u124 (val)
        if a1.UserInputState == Enum.UserInputState.Begin then
            if a1.KeyCode ~= Enum.KeyCode.Return then
                return
            end
            if GuiService.SelectedCoreObject == u19.DropDownFrame then
                u194 = true
                return
            end
            if u19.SelectionInfo and u19.SelectionInfo[GuiService.SelectedCoreObject] then
                u194 = true
                return
            end
            return
        end
        if a1.UserInputState == Enum.UserInputState.End and a1.KeyCode == Enum.KeyCode.Return and u194 then
            u194 = false
            if GuiService.SelectedCoreObject == u19.DropDownFrame then
                u124()
                return
            end
            if u19.SelectionInfo and u19.SelectionInfo[GuiService.SelectedCoreObject] then
                u19.SelectionInfo[GuiService.SelectedCoreObject].Clicked()
            end
        end
    end

    local function setIsFaded(a1) -- Line: 796 -- upvalues: u19 (val)
        if a1 then
            u19.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0.5
            u19.DropDownFrame.ImageTransparency = 0.5
            u19.DropDownImage.ImageTransparency = 0.5
            return
        end
        u19.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0
        u19.DropDownFrame.ImageTransparency = 0
        u19.DropDownImage.ImageTransparency = 0
    end

    u19.IndexChanged = BindableEvent.Event

    function u19.SetSelectionIndex(a1, a2) -- Line: 811 -- upvalues: setSelection (val)
        setSelection(a2)
    end

    function u19.SetSelectionByValue(a1, a2) -- Line: 813 -- upvalues: setSelectionByValue (val)
        return (setSelectionByValue(a2))
    end

    function u19.ResetSelectionIndex(a1) -- Line: 815 -- upvalues: u19 (val), DropDownFrameTextLabel (val), u122 (val)
        u19.CurrentIndex = nil
        DropDownFrameTextLabel.Text = "Choose One"
        u122()
    end

    function u19.GetSelectedIndex(a1) -- Line: 821 -- upvalues: u19 (val)
        return u19.CurrentIndex
    end

    function u19.SetZIndex(a1, a2) -- Line: 823 -- upvalues: u19 (val), u191 (val), DropDownFrameTextLabel (val)
        u19.DropDownFrame.ZIndex = a2
        u191.ZIndex = a2
        DropDownFrameTextLabel.ZIndex = a2
    end

    function u19.SetInteractable(a1, a2) -- Line: 829
        -- upvalues: u36 (ref), u19 (val), u122 (val), VRService (upval), Enabled (ref), u121 (ref)
        u36 = a2
        u19.DropDownFrame.Selectable = u36
        if u36 then
            u19.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0
            u19.DropDownFrame.ImageTransparency = 0
            u19.DropDownImage.ImageTransparency = 0
            if not VRService.VREnabled then
                u19:SetZIndex(2)
            end
        else
            u122()
            if not VRService.VREnabled then
                u19.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0
                u19.DropDownFrame.ImageTransparency = 0
                u19.DropDownImage.ImageTransparency = 0
            else
                u19.DropDownFrame.DropDownFrameTextLabel.TextTransparency = 0.5
                u19.DropDownFrame.ImageTransparency = 0.5
                u19.DropDownImage.ImageTransparency = 0.5
            end
            if not VRService.VREnabled then
                u19:SetZIndex(1)
            end
        end
        Enabled.Value = a2 and not u121
    end

    function u19.UpdateDropDownList(a1, a2_2) -- Line: 849
        -- upvalues: u43 (ref), u19 (val), VRService (upval), u68 (upval), u12 (val), u7 (val), u119 (val), a2 (val)
        -- upvalues: DropDownFrameTextLabel (val), u17 (val), u122 (val), BindableEvent (val), UserInputService (upval)
        -- upvalues: GuiService (upval), u41 (val), u62 (val), u101 (val)
        local TextButton, v1, v2, v3
        u43 = a2_2
        if u19.Selections then
            v2 = #u19.Selections
            for i = 1, v2 do
                u19.Selections[i]:Destroy()
            end
        end
        u19.Selections = {}
        u19.SelectionInfo = {}
        local VREnabled = VRService.VREnabled
        local SourceSansBold = VREnabled and Enum.Font.SourceSansBold or Enum.Font.SourceSans
        local v4 = if not VREnabled then 24 else 36
        local v5 = (if not VREnabled then 50 else 70) + 1
        local u202 = if not VREnabled then 400 else 600
        for k, v in pairs(a2_2) do
            v2 = u68.Create("Frame")({BackgroundTransparency = 0.7, BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0)})
            TextButton = u68.Create("TextButton")
            v1 = {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                ZIndex = 10,
                Name = "Selection" .. tostring(k),
                Size = UDim2.new(1, -28, 0, v3),
                Position = UDim2.new(0, 14, 0, (k - 1) * v5),
            }
            v1.TextColor3 = VRService.VREnabled and u12 or u7
            v1.Font = SourceSansBold
            v1.TextSize = v4
            v1.Text = v
            v1.SelectionImageObject = v2
            v1.Parent = u119
            local u152 = TextButton(v1)
            if k == a2 then
                u19.CurrentIndex = k
                DropDownFrameTextLabel.Text = v
                u152.TextColor3 = u17
            elseif not a2 and k == 1 then
                u152.TextColor3 = u17
            end

            function v2() -- Line: 902
                -- upvalues: DropDownFrameTextLabel (upval), u152 (val), u122 (upval), u19 (upval), k (val)
                -- upvalues: BindableEvent (upval)
                DropDownFrameTextLabel.Text = u152.Text
                u122()
                u19.CurrentIndex = k
                BindableEvent:Fire(k)
            end

            u152.MouseButton1Click:Connect(v2)
            u152.MouseEnter:Connect(function() -- Line: 911 -- upvalues: VRService (upval), UserInputService (upval), GuiService (upval), u152 (val)
                if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
                    GuiService.SelectedCoreObject = u152
                end
            end)
            u19.Selections[k] = u152
            u19.SelectionInfo[u152] = {Clicked = v2}
        end
        GuiService:RemoveSelectionGroup(u41)
        local v6 = GuiService
        local v7 = u41
        local Selections = u19.Selections
        v6:AddSelectionTuple(v7, (unpack(Selections)))
        u119.CanvasSize = UDim2.new(1, -20, 0, #a2_2 * v5)

        local function updateDropDownSize() -- Line: 926
            -- upvalues: u119 (upval), u62 (upval), u101 (upval), u202 (val)
            if u119.CanvasSize.Y.Offset < u62.AbsoluteSize.Y - 10 then
                u101.Size = UDim2.new(0, u202, 0, u119.CanvasSize.Y.Offset + 25)
                return
            end
            u101.Size = UDim2.new(0, u202, 0.9, 0)
        end

        u62.Changed:Connect(function(a1) -- Line: 941 -- upvalues: updateDropDownSize (val)
            if a1 ~= "AbsoluteSize" then
                return
            end
            updateDropDownSize()
        end)
        updateDropDownSize()
    end

    u19:UpdateDropDownList(a1)
    u62.MouseButton1Click:Connect(u122)
    a3.PoppedMenu:Connect(function(a1) -- Line: 956 -- upvalues: u62 (val), u122 (val)
        if a1 == u62 then
            u122()
        end
    end)
    return u19
end

local function CreateSelector(a1, a2) -- Line: 965
    -- upvalues: u68 (val), u79 (val), u14 (val), UserInputService (val), u19 (val), addHoverState (val)
    -- upvalues: VRService (val), GuiService (val), EaseOutQuad (val), u24 (val), u70 (val), getViewportSize (val)
    local u2 = 0
    local u3 = {HubRef = nil}
    if type(a1) ~= "table" then
        error("CreateSelector selectionStringTable (first arg) is not a table", 2)
        return u3
    end
    local BindableEvent = Instance.new("BindableEvent")
    BindableEvent.Name = "IndexChanged"
    local u16 = true
    u3.CurrentIndex = 0
    u3.SelectorFrame = u68.Create("ImageButton")({
        Name = "Selector",
        Image = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        ZIndex = 2,
        NextSelectionLeft = u3.SelectorFrame,
        NextSelectionRight = u3.SelectorFrame,
        Size = UDim2.new(0.6, 0, 0, 50),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        SelectionImageObject = u79,
    })
    local u66 = u68.Create("ImageButton")({
        Name = "LeftButton",
        BackgroundTransparency = 1,
        Image = "",
        ZIndex = 3,
        Selectable = false,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(0, 50, 0, 50),
        SelectionImageObject = u79,
        Parent = u3.SelectorFrame,
    })
    local u90 = u68.Create("ImageButton")({
        Name = "RightButton",
        BackgroundTransparency = 1,
        Image = "",
        ZIndex = 3,
        Selectable = false,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 50, 0, 50),
        SelectionImageObject = u79,
        Parent = u3.SelectorFrame,
    })
    local u113 = u68.Create("ImageLabel")({
        Name = "LeftButton",
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/Settings/Slider/Left.png",
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 18, 0, 30),
        ImageColor3 = u14,
        Parent = u66,
    })
    local ImageLabel_2 = u68.Create("ImageLabel")
    local v1 = {
        Name = "RightButton",
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/Settings/Slider/Right.png",
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 18, 0, 30),
        ImageColor3 = u14,
        Parent = u90,
    }
    local u136 = ImageLabel_2(v1)
    if not UserInputService.TouchEnabled then
        function v1(a1) -- Line: 1050 -- upvalues: u14 (upval)
            a1.ImageColor3 = u14
        end

        local function v2(a1) -- Line: 1051 -- upvalues: u19 (upval)
            a1.ImageColor3 = u19
        end

        addHoverState(u66, u113, v1, v2)
        addHoverState(u90, u136, v1, v2)
    end
    u3.Selections = {}
    local u155 = {}
    local u156 = {}
    local u182 = u68.Create("ImageButton")({
        Name = "AutoSelectButton",
        BackgroundTransparency = 1,
        Image = "",
        ZIndex = 2,
        Position = UDim2.new(0, u66.Size.X.Offset, 0, 0),
        Size = UDim2.new(1, u66.Size.X.Offset * -2, 1, 0),
        Parent = u3.SelectorFrame,
        SelectionImageObject = u79,
    })
    u182.MouseButton1Click:Connect(function() -- Line: 1070
        -- upvalues: u16 (ref), u3 (val), VRService (upval), UserInputService (upval), GuiService (upval)
        if not u16 then
            return
        end
        if #u3.Selections <= 1 then
            return
        end
        local v1 = u3.CurrentIndex + 1
        if #u3.Selections < v1 then
            v1 = 1
        end
        u3:SetSelectionIndex(v1)
        if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
            GuiService.SelectedCoreObject = u3.SelectorFrame
        end
    end)
    u156[u182] = true

    local function setSelection(a1, a2) -- Line: 1089
        -- upvalues: u3 (val), u66 (val), u155 (ref), EaseOutQuad (upval), BindableEvent (val)
        local In, Out, Quad, Quad_2, v1, v2, v3, v4
        local v5 = a1
        for k, v in pairs(u3.Selections) do
            v2 = k == v5
            v3 = UDim2.new(0, u66.Size.X.Offset, 0, 0)
            v4 = UDim2.new(0, u66.Size.X.Offset * v6 * 3, 0, 0)
            if u155[v] then
                v4 = UDim2.new(0, u66.Size.X.Offset * -v6 * 3, 0, 0)
            end
            if v4.X.Offset < 0 then
                v4 = UDim2.new(0, v4.X.Offset + v.AbsoluteSize.X / 4, 0, 0)
            end
            if v2 then
                u155[v] = true
                v.Position = v4
                v.Visible = true
                PropertyTweener(v, "TextTransparency", 1, 0, 0.165, EaseOutQuad)
                v1 = game
                if not v:IsDescendantOf(v1) then
                    v.Position = v3
                else
                    In = Enum.EasingDirection.In
                    Quad = Enum.EasingStyle.Quad
                    v:TweenPosition(v3, In, Quad, 0.15, true)
                end
                u3.CurrentIndex = k
                BindableEvent:Fire(v5)
            elseif u155[v] then
                u155[v] = false
                PropertyTweener(v, "TextTransparency", 0, 1, 0.165, EaseOutQuad)
                v1 = game
                if not v:IsDescendantOf(v1) then
                    v.Position = UDim2.new(v4)
                else
                    Out = Enum.EasingDirection.Out
                    Quad_2 = Enum.EasingStyle.Quad
                    v:TweenPosition(v4, Out, Quad_2, 0.135, true)
                end
            end
        end
    end

    local function stepFunc(a1, a2) -- Line: 1140
        -- upvalues: u16 (ref), VRService (upval), UserInputService (upval), GuiService (upval), u3 (val)
        -- upvalues: setSelection (val)
        if not u16 then
            return
        end
        if a1 ~= nil
            and a1.UserInputType ~= Enum.UserInputType.MouseButton1
            and a1.UserInputType ~= Enum.UserInputType.Gamepad1
            and a1.UserInputType ~= Enum.UserInputType.Gamepad2
            and a1.UserInputType ~= Enum.UserInputType.Gamepad3
            and a1.UserInputType ~= Enum.UserInputType.Gamepad4
            and a1.UserInputType ~= Enum.UserInputType.Keyboard then
            return
        end
        if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
            GuiService.SelectedCoreObject = u3.SelectorFrame
        end
        local v1 = a2 + u3.CurrentIndex
        local v2 = if not (u3.CurrentIndex < v1) then -1 else 1
        if #u3.Selections < v1 then
            v1 = 1
        elseif v1 < 1 then
            v1 = #u3.Selections
        end
        setSelection(v1, v2)
    end

    local u193 = nil

    local function connectToGuiService() -- Line: 1180
        -- upvalues: u193 (ref), GuiService (upval), u3 (val), u156 (val), VRService (upval)
        (GuiService:GetPropertyChangedSignal("SelectedCoreObject")):Connect(function() -- Line: 1181 -- upvalues: u3 (upval), GuiService (upval), u156 (upval), VRService (upval)
            local v1
            if #u3.Selections <= 0 then
                return
            end
            if GuiService.SelectedCoreObject == u3.SelectorFrame then
                v1 = u3.Selections[u3.CurrentIndex]
                v1.TextTransparency = 0
                return
            end
            if GuiService.SelectedCoreObject ~= nil and u156[GuiService.SelectedCoreObject] then
                if not VRService.VREnabled then
                    GuiService.SelectedCoreObject = u3.SelectorFrame
                    return
                end
                v1 = u3.Selections[u3.CurrentIndex]
                v1.TextTransparency = 0
                return
            end
            v1 = u3.Selections[u3.CurrentIndex]
            v1.TextTransparency = 0.5
        end)
    end

    u3.IndexChanged = BindableEvent.Event

    function u3.SetSelectionIndex(a1, a2) -- Line: 1207 -- upvalues: setSelection (val)
        setSelection(a2, 1)
    end

    function u3.GetSelectedIndex(a1) -- Line: 1209 -- upvalues: u3 (val)
        return u3.CurrentIndex
    end

    function u3.SetZIndex(a1, a2) -- Line: 1211 -- upvalues: u66 (val), u90 (val), u113 (val), u136 (val), u3 (val)
        u66.ZIndex = a2
        u90.ZIndex = a2
        u113.ZIndex = a2
        u136.ZIndex = a2
        local v1 = #u3.Selections
        for i = 1, v1 do
            u3.Selections[i].ZIndex = a2
        end
    end

    function u3.SetInteractable(a1, a2) -- Line: 1222
        -- upvalues: u16 (ref), u3 (val), u66 (val), u90 (val), u113 (val), u24 (upval), u136 (val), u14 (upval)
        u16 = a2
        u3.SelectorFrame.Selectable = u16
        u66.Active = u16
        u90.Active = u16
        if not u16 then
            for k2, i in pairs(u3.Selections) do
                i.TextColor3 = Color3.fromRGB(49, 49, 49)
            end
            u113.ImageColor3 = u24
            u136.ImageColor3 = u24
            return
        end
        for k, v in pairs(u3.Selections) do
            v.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        u113.ImageColor3 = u14
        u136.ImageColor3 = u14
    end

    function u3.UpdateOptions(a1, a2_2) -- Line: 1244
        -- upvalues: u3 (val), u155 (ref), u68 (upval), u66 (val), a2 (val), u90 (val)
        local v1, v2
        for k, v in pairs(u3.Selections) do
            v:Destroy()
        end
        u155 = {}
        u3.Selections = {}
        for k2, i in pairs(a2_2) do
            v2 = u68.Create("TextLabel")({
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                TextTransparency = 0.5,
                TextSize = 24,
                ZIndex = 2,
                Visible = false,
                Name = "Selection" .. tostring(k2),
                Size = UDim2.new(1, u66.Size.X.Offset * -2, 1, 0),
                Position = UDim2.new(1, 0, 0, 0),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextYAlignment = Enum.TextYAlignment.Center,
                Font = Enum.Font.SourceSans,
                Text = i,
                Parent = u3.SelectorFrame,
            })
            if false then
                v2.TextSize = 36
            end
            if k2 ~= a2 then
                u155[v2] = false
            else
                u3.CurrentIndex = k2
                v2.Position = UDim2.new(0, u66.Size.X.Offset, 0, 0)
                v2.Visible = true
                u155[v2] = true
            end
            u3.Selections[k2] = v2
        end
        u66.Visible = #u3.Selections > 1
        u90.Visible = v1
    end

    VRService.Changed:Connect(function(a1) -- Line: 1292 -- upvalues: VRService (upval), u66 (val), u90 (val), u182 (val)
        if a1 ~= "VREnabled" then
            return
        end
        local VREnabled = VRService.VREnabled
        u66.Selectable = VREnabled
        u90.Selectable = VREnabled
        u182.Selectable = VREnabled
    end)
    local VREnabled = VRService.VREnabled
    u66.Selectable = VREnabled
    u90.Selectable = VREnabled
    u182.Selectable = VREnabled
    u66.InputBegan:Connect(function(a1) -- Line: 1304
        -- upvalues: u16 (ref), VRService (upval), UserInputService (upval), GuiService (upval), u3 (val)
        -- upvalues: setSelection (val)
        if a1.UserInputType == Enum.UserInputType.Touch then
            if not u16 then
                return
            end
            if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
                GuiService.SelectedCoreObject = u3.SelectorFrame
            end
            local v1 = -1 + u3.CurrentIndex
            local v2 = if not (u3.CurrentIndex < v1) then -1 else 1
            if #u3.Selections < v1 then
                v1 = 1
            elseif v1 < 1 then
                v1 = #u3.Selections
            end
            setSelection(v1, v2)
        end
    end)
    u66.MouseButton1Click:Connect(function() -- Line: 1309
        -- upvalues: UserInputService (upval), u16 (ref), VRService (upval), GuiService (upval), u3 (val)
        -- upvalues: setSelection (val)
        if not UserInputService.TouchEnabled then
            if not u16 then
                return
            end
            if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
                GuiService.SelectedCoreObject = u3.SelectorFrame
            end
            local v1 = -1 + u3.CurrentIndex
            local v2 = if not (u3.CurrentIndex < v1) then -1 else 1
            if #u3.Selections < v1 then
                v1 = 1
            elseif v1 < 1 then
                v1 = #u3.Selections
            end
            setSelection(v1, v2)
        end
    end)
    u90.InputBegan:Connect(function(a1) -- Line: 1314
        -- upvalues: u16 (ref), VRService (upval), UserInputService (upval), GuiService (upval), u3 (val)
        -- upvalues: setSelection (val)
        if a1.UserInputType == Enum.UserInputType.Touch then
            if not u16 then
                return
            end
            if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
                GuiService.SelectedCoreObject = u3.SelectorFrame
            end
            local v1 = 1 + u3.CurrentIndex
            local v2 = if not (u3.CurrentIndex < v1) then -1 else 1
            if #u3.Selections < v1 then
                v1 = 1
            elseif v1 < 1 then
                v1 = #u3.Selections
            end
            setSelection(v1, v2)
        end
    end)
    u90.MouseButton1Click:Connect(function() -- Line: 1319
        -- upvalues: UserInputService (upval), u16 (ref), VRService (upval), GuiService (upval), u3 (val)
        -- upvalues: setSelection (val)
        if not UserInputService.TouchEnabled then
            if not u16 then
                return
            end
            if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
                GuiService.SelectedCoreObject = u3.SelectorFrame
            end
            local v1 = 1 + u3.CurrentIndex
            local v2 = if not (u3.CurrentIndex < v1) then -1 else 1
            if #u3.Selections < v1 then
                v1 = 1
            elseif v1 < 1 then
                v1 = #u3.Selections
            end
            setSelection(v1, v2)
        end
    end)
    local u234 = true
    u3:UpdateOptions(a1)
    UserInputService.InputBegan:Connect(function(a1) -- Line: 1328
        -- upvalues: u16 (ref), u234 (ref), GuiService (upval), u3 (val), VRService (upval), UserInputService (upval)
        -- upvalues: setSelection (val)
        local v1, v2
        if not u16 or not u234 then
            return
        end
        if a1.UserInputType ~= Enum.UserInputType.Gamepad1 and a1.UserInputType ~= Enum.UserInputType.Keyboard then
            return
        end
        if GuiService.SelectedCoreObject ~= u3.SelectorFrame then
            return
        end
        if a1.KeyCode ~= Enum.KeyCode.DPadLeft
            and a1.KeyCode ~= Enum.KeyCode.Left
            and a1.KeyCode ~= Enum.KeyCode.A then
            if a1.KeyCode ~= Enum.KeyCode.DPadRight
                and a1.KeyCode ~= Enum.KeyCode.Right
                and a1.KeyCode ~= Enum.KeyCode.D then
                return
            end
            if not u16 then
                return
            end
            if a1 ~= nil
                and a1.UserInputType ~= Enum.UserInputType.MouseButton1
                and a1.UserInputType ~= Enum.UserInputType.Gamepad1
                and a1.UserInputType ~= Enum.UserInputType.Gamepad2
                and a1.UserInputType ~= Enum.UserInputType.Gamepad3
                and a1.UserInputType ~= Enum.UserInputType.Gamepad4
                and a1.UserInputType ~= Enum.UserInputType.Keyboard then
                return
            end
            if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
                GuiService.SelectedCoreObject = u3.SelectorFrame
            end
            v1 = 1 + u3.CurrentIndex
            v2 = if not (u3.CurrentIndex < v1) then -1 else 1
            if #u3.Selections < v1 then
                v1 = 1
            elseif v1 < 1 then
                v1 = #u3.Selections
            end
            setSelection(v1, v2)
            return
        end
        if not u16 then
            return
        end
        if a1 ~= nil
            and a1.UserInputType ~= Enum.UserInputType.MouseButton1
            and a1.UserInputType ~= Enum.UserInputType.Gamepad1
            and a1.UserInputType ~= Enum.UserInputType.Gamepad2
            and a1.UserInputType ~= Enum.UserInputType.Gamepad3
            and a1.UserInputType ~= Enum.UserInputType.Gamepad4
            and a1.UserInputType ~= Enum.UserInputType.Keyboard then
            return
        end
        if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
            GuiService.SelectedCoreObject = u3.SelectorFrame
        end
        v1 = -1 + u3.CurrentIndex
        v2 = if not (u3.CurrentIndex < v1) then -1 else 1
        if #u3.Selections < v1 then
            v1 = 1
        elseif v1 < 1 then
            v1 = #u3.Selections
        end
        setSelection(v1, v2)
    end)
    UserInputService.InputChanged:Connect(function(a1) -- Line: 1361 -- upvalues: u16 (ref), u234 (ref), u2 (ref), GuiService (upval), u3 (val), stepFunc (val)
        if not u16 then
            return
        end
        if not u234 then
            u2 = 0
            return
        end
        if a1.UserInputType ~= Enum.UserInputType.Gamepad1 then
            return
        end
        local SelectedCoreObject = GuiService.SelectedCoreObject
        if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(u3.SelectorFrame.Parent) then
            if a1.KeyCode ~= Enum.KeyCode.Thumbstick1 then
                return
            end
            if 0.8 < a1.Position.X and 0 < a1.Delta.X and u2 ~= 1 then
                u2 = 1
                stepFunc(a1, u2)
                return
            end
            if a1.Position.X < -0.8 and a1.Delta.X < 0 and u2 ~= -1 then
                u2 = -1
                stepFunc(a1, u2)
                return
            end
            if (math.abs(a1.Position.X)) < 0.8 then
                u2 = 0
            end
            return
        end
    end)
    u3.SelectorFrame.AncestryChanged:Connect(function(a1, a2) -- Line: 1402
        -- upvalues: u234 (ref), u193 (ref), GuiService (upval), u3 (val), u156 (val), VRService (upval)
        if a2 then
            u193 = (GuiService:GetPropertyChangedSignal("SelectedCoreObject")):Connect(function() -- Line: 1181 -- upvalues: u3 (upval), GuiService (upval), u156 (upval), VRService (upval)
                local v1
                if #u3.Selections <= 0 then
                    return
                end
                if GuiService.SelectedCoreObject == u3.SelectorFrame then
                    v1 = u3.Selections[u3.CurrentIndex]
                    v1.TextTransparency = 0
                    return
                end
                if GuiService.SelectedCoreObject ~= nil and u156[GuiService.SelectedCoreObject] then
                    if not VRService.VREnabled then
                        GuiService.SelectedCoreObject = u3.SelectorFrame
                        return
                    end
                    v1 = u3.Selections[u3.CurrentIndex]
                    v1.TextTransparency = 0
                    return
                end
                v1 = u3.Selections[u3.CurrentIndex]
                v1.TextTransparency = 0.5
            end)
            return
        end
        if not u193 then
            return
        end
        u193:Disconnect()
    end)

    u70[u3.SelectorFrame] = function(a1, a2) -- Line: 1413 -- upvalues: u3 (val)
        local v1 = if not a2 then 24 else 16
        for k, v in pairs(u3.Selections) do
            v.TextSize = v1
        end
    end

    getViewportSize()
    local v3 = getViewportSize()
    v3 = if not (v3.X < v3.Y) then 24 else 16
    for k, v in pairs(u3.Selections) do
        v.TextSize = v3
    end
    ;(GuiService:GetPropertyChangedSignal("SelectedCoreObject")):Connect(function() -- Line: 1181 -- upvalues: u3 (val), GuiService (upval), u156 (val), VRService (upval)
        local v1
        if #u3.Selections <= 0 then
            return
        end
        if GuiService.SelectedCoreObject == u3.SelectorFrame then
            v1 = u3.Selections[u3.CurrentIndex]
            v1.TextTransparency = 0
            return
        end
        if GuiService.SelectedCoreObject ~= nil and u156[GuiService.SelectedCoreObject] then
            if not VRService.VREnabled then
                GuiService.SelectedCoreObject = u3.SelectorFrame
                return
            end
            v1 = u3.Selections[u3.CurrentIndex]
            v1.TextTransparency = 0
            return
        end
        v1 = u3.Selections[u3.CurrentIndex]
        v1.TextTransparency = 0.5
    end)
    return u3
end

local function ShowAlert(a1, a2, a3, a4, a5) -- Line: 1432
    -- upvalues: PlayerGui (val), VRService (val), u68 (val), HttpService (val), ContextActionService (val)
    -- upvalues: GuiService (val), MakeButton (val), UserInputService (val)
    local v1, v2
    local RobloxGui = PlayerGui.RobloxGui
    if RobloxGui:FindFirstChild("AlertViewFullScreen") then
        return
    end
    local u11 = nil

    local function onVREnabled(a1) -- Line: 1443
        -- upvalues: VRService (upval), PlayerGui (upval), RobloxGui (ref), u11 (ref)
        if a1 ~= "VREnabled" then
            return
        end
        RobloxGui = if not VRService.VREnabled then PlayerGui.RobloxGui else (require(PlayerGui.RobloxGui.Modules.VR.Panel3D).Get("SettingsMenu")):GetGUI()
        if u11 and u11.Parent ~= nil then
            u11.Parent = RobloxGui
            if VRService.VREnabled then
                (nil):SetSubpanelDepth(u11, 0.5)
            end
        end
    end

    local u18 = VRService.Changed:Connect(onVREnabled)
    Color3.fromRGB(59, 166, 241)
    Color3.fromRGB(255, 255, 255)
    u11 = u68.Create("ImageLabel")({
        Name = "AlertViewBacking",
        Image = "rbxasset://textures/ui/Settings/MenuBarAssets/MenuButton.png",
        BackgroundTransparency = 1,
        ImageTransparency = 1,
        ZIndex = 9,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(8, 6, 46, 44),
        Size = UDim2.new(0, 400, 0, 350),
        Position = UDim2.new(0.5, -200, 0.5, -175),
        Parent = RobloxGui,
    })
    onVREnabled("VREnabled")
    if a5 then
        u11.ImageTransparency = 0
    elseif not VRService.VREnabled then
        u11.Size = UDim2.new(0.8, 0, 0, 350)
        u11.Position = UDim2.new(0.1, 0, 0.1, 0)
    else
        u11.ImageTransparency = 0
    end
    if PlayerGui.RobloxGui.AbsoluteSize.Y <= u11.Size.Y.Offset then
        u11.Size = UDim2.new(u11.Size.X.Scale, u11.Size.X.Offset, u11.Size.Y.Scale, PlayerGui.RobloxGui.AbsoluteSize.Y)
        local new = UDim2.new
        local Scale = u11.Position.X.Scale
        v1 = -u11.Size.X.Offset / 2
        u11.Position = new(Scale, v1, 0.5, -u11.Size.Y.Offset / 2)
    end
    u68.Create("TextLabel")({
        Name = "AlertViewText",
        BackgroundTransparency = 1,
        TextSize = 36,
        TextWrapped = true,
        ZIndex = 10,
        Size = UDim2.new(0.95, 0, 0.6, 0),
        Position = UDim2.new(0.025, 0, 0.05, 0),
        Font = Enum.Font.SourceSansBold,
        Text = a1,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        Parent = u11,
    })
    u68.Create("ImageLabel")({Image = "", BackgroundTransparency = 1})
    local u153 = HttpService:GenerateGUID(false)

    local function v3(a1, a2) -- Line: 1526
        -- upvalues: VRService (upval), u11 (ref), PlayerGui (upval), a4 (val), ContextActionService (upval), u153 (val)
        -- upvalues: GuiService (upval), a3 (val), u18 (val)
        if not VRService.VREnabled then
            if not u11 then
                return
            end
            if VRService.VREnabled then
                ((require(PlayerGui.RobloxGui.Modules.VR.Panel3D)).Get("SettingsMenu")):SetSubpanelDepth(u11, 0)
            end
            u11:Destroy()
            u11 = nil
            if a4 then
                a4()
            end
            ContextActionService:UnbindAction(u153)
            GuiService.SelectedCoreObject = nil
            if a3 then
                a3:ShowBar()
            end
            if u18 then
                u18:Disconnect()
            end
            return
        end
        if a2 ~= Enum.UserInputState.Begin and a2 ~= Enum.UserInputState.Cancel then
            if not u11 then
                return
            end
            if VRService.VREnabled then
                ((require(PlayerGui.RobloxGui.Modules.VR.Panel3D)).Get("SettingsMenu")):SetSubpanelDepth(u11, 0)
            end
            u11:Destroy()
            u11 = nil
            if a4 then
                a4()
            end
            ContextActionService:UnbindAction(u153)
            GuiService.SelectedCoreObject = nil
            if a3 then
                a3:ShowBar()
            end
            if u18 then
                u18:Disconnect()
            end
            return
        end
    end

    local v4 = UDim2.new(1, -20, 0, 60)
    local v5 = UDim2.new(0, 10, 0.65, 0)
    if not a5 then
        v4 = UDim2.new(0, 200, 0, 50)
        v5 = UDim2.new(0.5, -100, 0.65, 0)
    end
    v1, v2 = MakeButton("AlertViewButton", a2, v4, v3)
    v1.Position = v5
    v1.NextSelectionLeft = v1
    v1.NextSelectionRight = v1
    v1.NextSelectionUp = v1
    v1.NextSelectionDown = v1
    v1.ZIndex = 9
    v2.ZIndex = v1.ZIndex
    v1.Parent = u11
    if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
        GuiService.SelectedCoreObject = v1
    end
    GuiService.SelectedCoreObject = v1
    ContextActionService:BindActionAtPriority(
        u153,
        v3,
        false,
        Enum.ContextActionPriority.High.Value,
        Enum.KeyCode.Escape,
        Enum.KeyCode.ButtonB,
        Enum.KeyCode.ButtonA
    )
    if a3 and not VRService.VREnabled then
        a3:HideBar()
        a3.Pages.CurrentPage:Hide(1, 1)
    end
end

local function CreateNewSlider(a1, a2, a3) -- Line: 1595
    -- upvalues: HttpService (val), u68 (val), u79 (val), UserInputService (val), u19 (val), u14 (val), u19 (val)
    -- upvalues: addHoverState (val), getViewportSize (val), u4 (val), u9 (val), VRService (val), GuiService (val)
    -- upvalues: RunService (val)
    local u304 = {}
    local u324 = tonumber(a1)
    local u509 = a2
    local u419 = 0
    local u523 = nil
    local u407 = true
    local u579 = HttpService:GenerateGUID(false)
    if u324 <= 0 then
        error("CreateNewSlider failed because numOfSteps (first arg) is 0 or negative, please supply a positive integer", 2)
        return
    end
    local BindableEvent = Instance.new("BindableEvent")
    BindableEvent.Name = "ValueChanged"
    u304.SliderFrame = u68.Create("ImageButton")({
        Name = "Slider",
        Image = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        ZIndex = 2,
        NextSelectionLeft = u304.SliderFrame,
        NextSelectionRight = u304.SliderFrame,
        Size = UDim2.new(0.6, 0, 0, 50),
        Position = UDim2.new(1, 0, 0.5, 0),
        AnchorPoint = Vector2.new(1, 0.5),
        SelectionImageObject = u79,
    })
    u304.StepsContainer = u68.Create("Frame")({
        Name = "StepsContainer",
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, -100, 1, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Parent = u304.SliderFrame,
    })
    local u361 = u68.Create("ImageButton")({
        Name = "LeftButton",
        BackgroundTransparency = 1,
        Image = "",
        ZIndex = 3,
        Selectable = false,
        Active = true,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0),
        Size = UDim2.new(0, 50, 0, 50),
        SelectionImageObject = u79,
        Parent = u304.SliderFrame,
    })
    local u369 = u68.Create("ImageButton")({
        Name = "RightButton",
        BackgroundTransparency = 1,
        Image = "",
        ZIndex = 3,
        Selectable = false,
        Active = true,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, 50, 0, 50),
        SelectionImageObject = u79,
        Parent = u304.SliderFrame,
    })
    local ImageLabel = u68.Create("ImageLabel")
    local v1 = {
        Name = "LeftButton",
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/Settings/Slider/Less.png",
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 30, 0, 30),
        Parent = u361,
    }
    v1.ImageColor3 = UserInputService.TouchEnabled and u19 or u14
    local u434 = ImageLabel(v1)
    local ImageLabel_2 = u68.Create("ImageLabel")
    local v2 = {
        Name = "RightButton",
        BackgroundTransparency = 1,
        Image = "rbxasset://textures/ui/Settings/Slider/More.png",
        ZIndex = 4,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0, 30, 0, 30),
        Parent = u369,
    }
    local v3 = UserInputService.TouchEnabled and u19 or u14
    v2.ImageColor3 = v3
    local u442 = ImageLabel_2(v2)
    if not UserInputService.TouchEnabled then
        function v2(a1) -- Line: 1701 -- upvalues: u14 (upval)
            a1.ImageColor3 = u14
        end

        function v3(a1) -- Line: 1702 -- upvalues: u19 (upval)
            a1.ImageColor3 = u19
        end

        addHoverState(u361, u434, v2, v3)
        addHoverState(u369, u442, v2, v3)
    end
    u304.Steps = {}
    local v4 = getViewportSize()
    local TouchEnabled = UserInputService.TouchEnabled
    if TouchEnabled then
        TouchEnabled = true
        if not (v4.Y < 500) then
            TouchEnabled = v4.X < 700
        end
    end
    if not TouchEnabled then end
    v3 = 1 / u324
    for i = 1, u324 do
        v2 = u68.Create("ImageButton")({
            BackgroundTransparency = 0.36,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            Active = false,
            Image = "",
            ZIndex = 3,
            Selectable = false,
            ImageTransparency = 0.36,
            Name = "Step" .. tostring(i),
            BackgroundColor3 = u4,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new((i - 1) * v3, 2, 0.5, 0),
            Size = UDim2.new(v3, -4, 0.48, 0),
            Parent = u304.StepsContainer,
            SelectionImageObject = u79,
        })
        if u509 < i then
            v2.BackgroundColor3 = u9
        end
        if i == 1 or i == u324 then
            v2.BackgroundTransparency = 1
            v2.ScaleType = Enum.ScaleType.Slice
            v2.SliceCenter = Rect.new(3, 3, 32, 21)
            if not (i <= u509) then
                if i ~= 1 then
                    v2.Image = "rbxasset://textures/ui/Settings/Slider/BarRight.png"
                else
                    v2.Image = "rbxasset://textures/ui/Settings/Slider/BarLeft.png"
                end
            elseif i ~= 1 then
                v2.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png"
            else
                v2.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png"
            end
        end
        u304.Steps[#u304.Steps + 1] = v2
    end

    local function hideSelection() -- Line: 1764 -- upvalues: u324 (val), u304 (val), u9 (upval)
        local v1
        for i = 1, u324 do
            v1 = u304.Steps[i]
            v1.BackgroundColor3 = u9
            if i == 1 then
                v1 = u304.Steps[i]
                v1.Image = "rbxasset://textures/ui/Settings/Slider/BarLeft.png"
            elseif i == u324 then
                v1 = u304.Steps[i]
                v1.Image = "rbxasset://textures/ui/Settings/Slider/BarRight.png"
            end
        end
    end

    local function showSelection() -- Line: 1774 -- upvalues: u324 (val), u509 (ref), u304 (val), u4 (upval)
        local v1
        for i = 1, u324 do
            if u509 < i then
                break
            end
            v1 = u304.Steps[i]
            v1.BackgroundColor3 = u4
            if i == 1 then
                v1 = u304.Steps[i]
                v1.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarLeft.png"
            elseif i == u324 then
                v1 = u304.Steps[i]
                v1.Image = "rbxasset://textures/ui/Settings/Slider/SelectedBarRight.png"
            end
        end
    end

    local function modifySelection(a1) -- Line: 1787 -- upvalues: u324 (val), u304 (val)
        local v1 = a1
        for i = 1, u324 do
            if i == 1 then
                u304.Steps[i].ImageTransparency = v1
            elseif i ~= u324 then
                u304.Steps[i].BackgroundTransparency = v1
            else
                u304.Steps[i].ImageTransparency = v1
            end
        end
    end

    local function setCurrentStep(a1) -- Line: 1797
        -- upvalues: a3 (ref), u361 (val), u369 (val), u324 (val), u509 (ref), hideSelection (val), showSelection (val)
        -- upvalues: u523 (ref), BindableEvent (val)
        local v1
        if not a3 then
            a3 = 0
        end
        u361.Visible = true
        u369.Visible = true
        if not (a1 <= a3) then
            v1 = a1
        else
            v1 = a3
            u361.Visible = false
        end
        if u324 <= v1 then
            v1 = u324
            u369.Visible = false
        end
        if u509 == v1 then
            return
        end
        hideSelection()
        showSelection()
        tick()
        BindableEvent:Fire(v1)
    end

    local function isActivateEvent(a1) -- Line: 1827
        if not a1 then
            return false
        end
        local v1 = true
        if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
            v1 = true
            if a1.UserInputType ~= Enum.UserInputType.Touch then
                v1 = false
                if a1.UserInputType == Enum.UserInputType.Gamepad1 then
                    v1 = a1.KeyCode == Enum.KeyCode.ButtonA
                end
            end
        end
        return v1
    end

    local function mouseDownFunc(a1, a2, a3) -- Line: 1838
        -- upvalues: u407 (ref), VRService (upval), UserInputService (upval), GuiService (upval), u304 (val), u419 (ref)
        -- upvalues: u509 (ref), u324 (val), setCurrentStep (val)
        local v1
        if not u407 or a1 == nil then
            return
        end
        if a1 then
            v1 = true
            if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
                v1 = true
                if a1.UserInputType ~= Enum.UserInputType.Touch then
                    v1 = false
                    if a1.UserInputType == Enum.UserInputType.Gamepad1 then
                        v1 = a1.KeyCode == Enum.KeyCode.ButtonA
                    end
                end
            end
        else
            v1 = false
        end
        if not v1 then
            return
        end
        if (if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false)
            and not VRService.VREnabled then
            GuiService.SelectedCoreObject = u304.SliderFrame
        end
        if VRService.VREnabled then
            u419 = 0
        elseif not a3 then
            u419 = 0
            local u48 = nil
            local u55 = UserInputService.InputChanged:Connect(function(a1) -- Line: 1864 -- upvalues: u324 (upval), u304 (upval), setCurrentStep (upval)
                local X_2, X_3
                if a1.UserInputType ~= Enum.UserInputType.MouseMovement then
                    return
                end
                local X = a1.Position.X
                local v1 = u324
                for i = 1, v1 do
                    X_2 = u304.Steps[i].AbsolutePosition.X
                    X_3 = u304.Steps[i].AbsoluteSize.X
                    if X_2 <= X and X <= X_2 + X_3 then
                        setCurrentStep(i)
                        return
                    end
                    if i == 1 and X < X_2 then
                        setCurrentStep(0)
                        return
                    end
                    if i == u324 and X_2 <= X then
                        setCurrentStep(i)
                        return
                    end
                end
            end)
            UserInputService.InputEnded:Connect(function(a1) -- Line: 1885 -- upvalues: u419 (upval), u48 (ref), u55 (ref)
                local v1
                if a1 then
                    v1 = true
                    if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
                        v1 = true
                        if a1.UserInputType ~= Enum.UserInputType.Touch then
                            v1 = false
                            if a1.UserInputType == Enum.UserInputType.Gamepad1 then
                                v1 = a1.KeyCode == Enum.KeyCode.ButtonA
                            end
                        end
                    end
                else
                    v1 = false
                end
                if not v1 then
                    return
                end
                u419 = 0
                u48:Disconnect()
                u55:Disconnect()
            end)
        else
            u419 = a2 - u509
        end
        setCurrentStep(a2)
    end

    local function mouseUpFunc(a1) -- Line: 1902 -- upvalues: u407 (ref), u419 (ref)
        local v1
        if not u407 then
            return
        end
        if a1 then
            v1 = true
            if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
                v1 = true
                if a1.UserInputType ~= Enum.UserInputType.Touch then
                    v1 = false
                    if a1.UserInputType == Enum.UserInputType.Gamepad1 then
                        v1 = a1.KeyCode == Enum.KeyCode.ButtonA
                    end
                end
            end
        else
            v1 = false
        end
        if not v1 then
            return
        end
        u419 = 0
    end

    local function touchClickFunc(a1, a2, a3) -- Line: 1913 -- upvalues: mouseDownFunc (val)
        mouseDownFunc(a1, a2, a3)
    end

    u304.ValueChanged = BindableEvent.Event

    function u304.SetValue(a1, a2) -- Line: 1920 -- upvalues: setCurrentStep (val)
        setCurrentStep(a2)
    end

    function u304.GetValue(a1) -- Line: 1922 -- upvalues: u509 (ref)
        return u509
    end

    function u304.SetInteractable(a1, a2) -- Line: 1924
        -- upvalues: u419 (ref), u407 (ref), u304 (val), hideSelection (val), showSelection (val)
        u419 = 0
        u304.SliderFrame.Selectable = a2
        if not a2 then
            hideSelection()
            return
        end
        showSelection()
    end

    function u304.SetZIndex(a1, a2) -- Line: 1935
        -- upvalues: u361 (val), u369 (val), u434 (val), u442 (val), u304 (val)
        u361.ZIndex = a2
        u369.ZIndex = a2
        u434.ZIndex = a2
        u442.ZIndex = a2
        local v1 = #u304.Steps
        for i = 1, v1 do
            u304.Steps[i].ZIndex = a2
        end
    end

    function u304.SetMinStep(a1, a2) -- Line: 1946 -- upvalues: u324 (val), a3 (ref), u509 (ref), u361 (val), u369 (val)
        if a2 >= 0 and a2 <= u324 then
            a3 = a2
        end
        if u509 <= a3 then
            u509 = a3
            u361.Visible = false
        end
        if u324 <= u509 then
            u509 = u324
            u369.Visible = false
        end
    end

    u361.InputBegan:Connect(function(a1) -- Line: 1964
        -- upvalues: u509 (ref), u407 (ref), VRService (upval), UserInputService (upval), GuiService (upval), u304 (val)
        -- upvalues: u419 (ref), setCurrentStep (val)
        local v1
        local v2 = u509 - 1
        if not u407 or a1 == nil then
            return
        end
        if a1 then
            v1 = true
            if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
                v1 = true
                if a1.UserInputType ~= Enum.UserInputType.Touch then
                    v1 = false
                    if a1.UserInputType == Enum.UserInputType.Gamepad1 then
                        v1 = a1.KeyCode == Enum.KeyCode.ButtonA
                    end
                end
            end
        else
            v1 = false
        end
        if not v1 then
            return
        end
        if (if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false)
            and not VRService.VREnabled then
            GuiService.SelectedCoreObject = u304.SliderFrame
        end
        u419 = if VRService.VREnabled then 0 else v2 - u509
        setCurrentStep(v2)
    end)
    u361.InputEnded:Connect(function(a1) -- Line: 1966 -- upvalues: u407 (ref), u419 (ref)
        local v1
        if not u407 then
            return
        end
        if a1 then
            v1 = true
            if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
                v1 = true
                if a1.UserInputType ~= Enum.UserInputType.Touch then
                    v1 = false
                    if a1.UserInputType == Enum.UserInputType.Gamepad1 then
                        v1 = a1.KeyCode == Enum.KeyCode.ButtonA
                    end
                end
            end
        else
            v1 = false
        end
        if not v1 then
            return
        end
        u419 = 0
    end)
    u369.InputBegan:Connect(function(a1) -- Line: 1968
        -- upvalues: u509 (ref), u407 (ref), VRService (upval), UserInputService (upval), GuiService (upval), u304 (val)
        -- upvalues: u419 (ref), setCurrentStep (val)
        local v1
        local v2 = u509 + 1
        if not u407 or a1 == nil then
            return
        end
        if a1 then
            v1 = true
            if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
                v1 = true
                if a1.UserInputType ~= Enum.UserInputType.Touch then
                    v1 = false
                    if a1.UserInputType == Enum.UserInputType.Gamepad1 then
                        v1 = a1.KeyCode == Enum.KeyCode.ButtonA
                    end
                end
            end
        else
            v1 = false
        end
        if not v1 then
            return
        end
        if (if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false)
            and not VRService.VREnabled then
            GuiService.SelectedCoreObject = u304.SliderFrame
        end
        u419 = if VRService.VREnabled then 0 else v2 - u509
        setCurrentStep(v2)
    end)
    u369.InputEnded:Connect(function(a1) -- Line: 1970 -- upvalues: u407 (ref), u419 (ref)
        local v1
        if not u407 then
            return
        end
        if a1 then
            v1 = true
            if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
                v1 = true
                if a1.UserInputType ~= Enum.UserInputType.Touch then
                    v1 = false
                    if a1.UserInputType == Enum.UserInputType.Gamepad1 then
                        v1 = a1.KeyCode == Enum.KeyCode.ButtonA
                    end
                end
            end
        else
            v1 = false
        end
        if not v1 then
            return
        end
        u419 = 0
    end)

    local function onVREnabled(a1) -- Line: 1972
        -- upvalues: VRService (upval), u361 (val), u407 (ref), u369 (val), u304 (val), u324 (val)
        local v1
        if a1 ~= "VREnabled" then
            return
        end
        if VRService.VREnabled then
            u361.Selectable = u407
            u369.Selectable = u407
            u304.SliderFrame.Selectable = u407
            for j = 1, u324 do
                v1 = u304.Steps[j]
                v1.Selectable = u407
                v1 = u304.Steps[j]
                v1.Active = u407
            end
            return
        end
        u361.Selectable = false
        u369.Selectable = false
        u304.SliderFrame.Selectable = u407
        for i = 1, u324 do
            v1 = u304.Steps[i]
            v1.Selectable = false
            v1 = u304.Steps[i]
            v1.Active = false
        end
    end

    VRService.Changed:Connect(onVREnabled)
    onVREnabled("VREnabled")
    for j = 1, u324 do
        u304.Steps[j].InputBegan:Connect(function(a1) -- Line: 1999 -- upvalues: mouseDownFunc (val), j (val)
            mouseDownFunc(a1, j)
        end)
        u304.Steps[j].InputEnded:Connect(function(a1) -- Line: 2000 -- upvalues: u407 (ref), u419 (ref)
            local v1
            if not u407 then
                return
            end
            if a1 then
                v1 = true
                if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    v1 = true
                    if a1.UserInputType ~= Enum.UserInputType.Touch then
                        v1 = false
                        if a1.UserInputType == Enum.UserInputType.Gamepad1 then
                            v1 = a1.KeyCode == Enum.KeyCode.ButtonA
                        end
                    end
                end
            else
                v1 = false
            end
            if not v1 then
                return
            end
            u419 = 0
        end)
    end
    u304.SliderFrame.InputBegan:Connect(function(a1) -- Line: 2003
        -- upvalues: VRService (upval), GuiService (upval), u304 (val), mouseDownFunc (val), u509 (ref)
        if not VRService.VREnabled then
            mouseDownFunc(a1, u509)
            return
        end
        local SelectedCoreObject = GuiService.SelectedCoreObject
        if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(u304.SliderFrame.Parent) then
            mouseDownFunc(a1, u509)
            return
        end
    end)
    u304.SliderFrame.InputEnded:Connect(function(a1) -- Line: 2012 -- upvalues: VRService (upval), GuiService (upval), u304 (val), u407 (ref), u419 (ref)
        local v1
        if not VRService.VREnabled then
            if not u407 then
                return
            end
            if a1 then
                v1 = true
                if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    v1 = true
                    if a1.UserInputType ~= Enum.UserInputType.Touch then
                        v1 = false
                        if a1.UserInputType == Enum.UserInputType.Gamepad1 then
                            v1 = a1.KeyCode == Enum.KeyCode.ButtonA
                        end
                    end
                end
            else
                v1 = false
            end
            if not v1 then
                return
            end
            u419 = 0
            return
        end
        local SelectedCoreObject = GuiService.SelectedCoreObject
        if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(u304.SliderFrame.Parent) then
            if not u407 then
                return
            end
            if a1 then
                v1 = true
                if a1.UserInputType ~= Enum.UserInputType.MouseButton1 then
                    v1 = true
                    if a1.UserInputType ~= Enum.UserInputType.Touch then
                        v1 = false
                        if a1.UserInputType == Enum.UserInputType.Gamepad1 then
                            v1 = a1.KeyCode == Enum.KeyCode.ButtonA
                        end
                    end
                end
            else
                v1 = false
            end
            if not v1 then
                return
            end
            u419 = 0
            return
        end
    end)

    local function u521() -- Line: 2022 -- upvalues: u523 (ref), setCurrentStep (val), u509 (ref), u419 (ref)
        if u523 == nil then
            return
        end
        if 0.2 <= tick() - u523 then
            setCurrentStep(u509 + u419)
        end
    end

    local u526 = true
    local u527 = {
        [Enum.KeyCode.Thumbstick1] = true,
        [Enum.KeyCode.DPadLeft] = -1,
        [Enum.KeyCode.DPadRight] = 1,
        [Enum.KeyCode.Left] = -1,
        [Enum.KeyCode.Right] = 1,
        [Enum.KeyCode.A] = -1,
        [Enum.KeyCode.D] = 1,
        [Enum.KeyCode.ButtonA] = true,
    }
    UserInputService.InputBegan:Connect(function(a1) -- Line: 2048
        -- upvalues: u407 (ref), u526 (ref), GuiService (upval), u304 (val), u527 (val), u419 (ref)
        -- upvalues: setCurrentStep (val), u509 (ref)
        if not u407 or not u526 then
            return
        end
        if a1.UserInputType ~= Enum.UserInputType.Gamepad1 and a1.UserInputType ~= Enum.UserInputType.Keyboard then
            return
        end
        local SelectedCoreObject = GuiService.SelectedCoreObject
        if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(u304.SliderFrame.Parent) then
            if u527[a1.KeyCode] == -1 then
                u419 = -1
                setCurrentStep(u509 - 1)
                return
            end
            if u527[a1.KeyCode] == 1 then
                u419 = 1
                setCurrentStep(u509 + 1)
            end
            return
        end
    end)
    UserInputService.InputEnded:Connect(function(a1) -- Line: 2076 -- upvalues: u407 (ref), GuiService (upval), u304 (val), u527 (val), u419 (ref)
        if not u407 then
            return
        end
        if a1.UserInputType ~= Enum.UserInputType.Gamepad1 and a1.UserInputType ~= Enum.UserInputType.Keyboard then
            return
        end
        local SelectedCoreObject = GuiService.SelectedCoreObject
        if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(u304.SliderFrame.Parent) then
            if u527[a1.KeyCode] then
                u419 = 0
            end
            return
        end
    end)
    UserInputService.InputChanged:Connect(function(a1) -- Line: 2097
        -- upvalues: u407 (ref), u419 (ref), u526 (ref), GuiService (upval), u304 (val), setCurrentStep (val)
        -- upvalues: u509 (ref)
        if not u407 or not u526 then
            u419 = 0
            return
        end
        if a1.UserInputType ~= Enum.UserInputType.Gamepad1 then
            return
        end
        local SelectedCoreObject = GuiService.SelectedCoreObject
        if SelectedCoreObject and SelectedCoreObject:IsDescendantOf(u304.SliderFrame.Parent) then
            if a1.KeyCode ~= Enum.KeyCode.Thumbstick1 then
                return
            end
            if 0.8 < a1.Position.X and 0 < a1.Delta.X and u419 ~= 1 then
                u419 = 1
                setCurrentStep(u509 + 1)
                return
            end
            if a1.Position.X < -0.8 and a1.Delta.X < 0 and u419 ~= -1 then
                u419 = -1
                setCurrentStep(u509 - 1)
                return
            end
            if (math.abs(a1.Position.X)) < 0.8 then
                u419 = 0
            end
            return
        end
    end)
    local u562 = false
    GuiService.Changed:Connect(function(a1) -- Line: 2138
        -- upvalues: GuiService (upval), u304 (val), modifySelection (val), u562 (ref), u523 (ref), RunService (upval)
        -- upvalues: u579 (val), u521 (val)
        if a1 ~= "SelectedCoreObject" then
            return
        end
        local SelectedCoreObject = GuiService.SelectedCoreObject
        if not (SelectedCoreObject and SelectedCoreObject:IsDescendantOf(u304.SliderFrame.Parent)) then
            modifySelection(0.36)
            if u562 then
                u562 = false
                RunService:UnbindFromRenderStep(u579)
            end
            return
        end
        modifySelection(0)
        if u562 then
            return
        end
        u562 = true
        tick()
        RunService:BindToRenderStep(u579, Enum.RenderPriority.Input.Value + 1, u521)
    end)
    u304.SliderFrame.AncestryChanged:Connect(function(a1, a2) -- Line: 2165 -- upvalues: u526 (ref)
        u526 = a2
    end)
    setCurrentStep(u509)
    return u304
end

local u125 = 50
if false then
    u125 = 90
end
local u126 = {}

local function AddNewRow(a1, a2, a3, a4, a5, a6) -- Line: 2178
    -- upvalues: u126 (val), u68 (val), u125 (ref), u79 (val), u67 (val), getViewportSize (val), u70 (val)
    -- upvalues: CreateNewSlider (val), CreateSelector (val), CreateDropDown (val), VRService (val)
    -- upvalues: UserInputService (val), GuiService (val), PlayerGui (val)
    local v1
    local v2 = 0
    local v3 = a3 ~= "TextBox"
    if u126[a1] then
        v2 = u126[a1]
    end
    local u50 = u68.Create("ImageButton")({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png",
        ImageTransparency = 1,
        Active = false,
        AutoButtonColor = false,
        ZIndex = 2,
        Selectable = false,
        Name = a2 .. "Frame",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(2, 2, 18, 18),
        Size = UDim2.new(1, 0, 0, u125),
        Position = UDim2.new(0, 0, 0, v2),
        SelectionImageObject = u79,
        Parent = a1.Page,
    })
    u50.ImageColor3 = u50.BackgroundColor3
    if u50 and a6 then
        u50.Position = UDim2.new(u50.Position.X.Scale, u50.Position.X.Offset, u50.Position.Y.Scale, u50.Position.Y.Offset + a6)
    end
    local TextLabel = u68.Create("TextLabel")
    local v4 = {
        TextSize = 16,
        BackgroundTransparency = 1,
        ZIndex = 2,
        Name = a2 .. "Label",
        Text = a2,
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Parent = u50,
    }
    local u100 = TextLabel(v4)
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
    if u67 then
        u100.Size = UDim2.new(0.35, 0, 1, 0)
        u100.TextScaled = true
        u100.TextWrapped = true
        UITextSizeConstraint.Parent = u100
        UITextSizeConstraint.MaxTextSize = 16
    end
    if not v3 then
        u100.Text = ""
    end

    local function onResized(a1, a2) -- Line: 2250 -- upvalues: u100 (ref), UITextSizeConstraint (val)
        if not a2 then
            u100.TextSize = 24
        else
            u100.TextSize = 16
        end
        UITextSizeConstraint.MaxTextSize = u100.TextSize
    end

    getViewportSize()
    local v5 = getViewportSize()
    if not (v5.X < v5.Y) then
        u100.TextSize = 24
    else
        u100.TextSize = 16
    end
    UITextSizeConstraint.MaxTextSize = u100.TextSize
    local v6 = u50
    u70[v6] = onResized
    getViewportSize()
    local v7 = getViewportSize()
    if not (v7.X < v7.Y) then
        u100.TextSize = 24
    else
        u100.TextSize = 16
    end
    UITextSizeConstraint.MaxTextSize = u100.TextSize
    local SliderFrame = nil
    local u366 = nil
    if a3 == "Slider" then
        u366 = CreateNewSlider(a4, a5)
        u366.SliderFrame.Parent = u50
        SliderFrame = u366.SliderFrame
    elseif a3 == "Selector" then
        u366 = CreateSelector(a4, a5)
        u366.SelectorFrame.Parent = u50
        SliderFrame = u366.SelectorFrame
    elseif a3 == "DropDown" then
        u366 = CreateDropDown(a4, a5, a1.HubRef)
        u366.DropDownFrame.Parent = u50
        SliderFrame = u366.DropDownFrame
    elseif a3 == "TextBox" then
        local u245 = false
        local u246 = false
        v4 = u68.Create("ImageLabel")({Image = "", BackgroundTransparency = 1})
        u366 = {HubRef = nil}
        local u293 = u68.Create("TextBox")({
            BackgroundTransparency = 0.5,
            BorderSizePixel = 0,
            TextWrapped = true,
            TextSize = 24,
            ZIndex = 2,
            ClearTextOnFocus = false,
            AnchorPoint = Vector2.new(1, 0.5),
            Size = UDim2.new(0.6, 0, 1, 0),
            Position = UDim2.new(1, 0, 0.5, 0),
            Text = a2,
            TextColor3 = Color3.fromRGB(49, 49, 49),
            TextYAlignment = Enum.TextYAlignment.Top,
            TextXAlignment = Enum.TextXAlignment.Left,
            Font = Enum.Font.SourceSans,
            SelectionImageObject = v4,
            Parent = u50,
        })
        SliderFrame = u293
        u293.Focused:Connect(function() -- Line: 2306
            -- upvalues: VRService (upval), UserInputService (upval), GuiService (upval), u293 (val), a2 (val)
            if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
                GuiService.SelectedCoreObject = u293
            end
            if u293.Text == a2 then
                u293.Text = ""
            end
        end)
        u293.FocusLost:Connect(function(a1, a2) -- Line: 2316 -- upvalues: u246 (ref)
            u246 = false
        end)
        if a6 then
            u293.Position = UDim2.new(u293.Position.X.Scale, u293.Position.X.Offset, u293.Position.Y.Scale, u293.Position.Y.Offset + a6)
        end
        SliderFrame.SelectionGained:Connect(function() -- Line: 2327
            -- upvalues: VRService (upval), UserInputService (upval), u293 (val), u366 (ref), SliderFrame (ref)
            if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
                u293.BackgroundTransparency = 0.1
                if u366.HubRef then
                    local v1 = SliderFrame
                    u366.HubRef:ScrollToFrame(v1)
                end
            end
        end)
        SliderFrame.SelectionLost:Connect(function() -- Line: 2336 -- upvalues: VRService (upval), UserInputService (upval), u293 (val)
            if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
                u293.BackgroundTransparency = 0.5
            end
        end)
        u293.MouseEnter:Connect(function() -- Line: 2342
            -- upvalues: PlayerGui (upval), SliderFrame (ref), VRService (upval), UserInputService (upval), a1 (val)
            -- upvalues: GuiService (upval), u245 (ref)
            local DropDownFullscreenFrame = PlayerGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame")
            if DropDownFullscreenFrame and DropDownFullscreenFrame.Visible then
                return
            end
            local v1 = SliderFrame
            if v1
                and v1.Visible
                and 1 < v1.ZIndex
                and (if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false)
                and a1.Active then
                GuiService.SelectedCoreObject = v1
                u245 = true
            end
        end)
        UserInputService.InputBegan:Connect(function(a1) -- Line: 2361 -- upvalues: GuiService (upval), SliderFrame (ref), u246 (ref), u293 (val)
            if a1.UserInputState == Enum.UserInputState.Begin
                and a1.KeyCode == Enum.KeyCode.Return
                and GuiService.SelectedCoreObject == SliderFrame then
                u246 = true
                u293:CaptureFocus()
            end
        end)
    elseif a3 == "TextEntry" then
        local u358 = false
        local u359 = false
        v1 = u68.Create("ImageLabel")({Image = "", BackgroundTransparency = 1})
        u366 = {HubRef = nil}
        local u397 = u68.Create("TextBox")({
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            TextWrapped = false,
            TextSize = 24,
            ZIndex = 2,
            ClearTextOnFocus = false,
            AnchorPoint = Vector2.new(1, 0.5),
            Size = UDim2.new(0.4, -10, 0, 40),
            Position = UDim2.new(1, 0, 0.5, 0),
            Text = a2,
            TextColor3 = Color3.fromRGB(178, 178, 178),
            TextYAlignment = Enum.TextYAlignment.Center,
            TextXAlignment = Enum.TextXAlignment.Center,
            Font = Enum.Font.SourceSans,
            SelectionImageObject = v1,
            Parent = u50,
        })
        SliderFrame = u397
        u397.Focused:Connect(function() -- Line: 2405
            -- upvalues: VRService (upval), UserInputService (upval), GuiService (upval), u397 (val), a2 (val)
            if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
                GuiService.SelectedCoreObject = u397
            end
            if u397.Text == a2 then
                u397.Text = ""
            end
        end)
        u397.FocusLost:Connect(function(a1, a2) -- Line: 2415 -- upvalues: u359 (ref)
            u359 = false
        end)
        if a6 then
            u397.Position = UDim2.new(u397.Position.X.Scale, u397.Position.X.Offset, u397.Position.Y.Scale, u397.Position.Y.Offset + a6)
        end
        SliderFrame.SelectionGained:Connect(function() -- Line: 2426
            -- upvalues: VRService (upval), UserInputService (upval), u397 (val), u366 (ref), SliderFrame (ref)
            if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
                u397.BackgroundTransparency = 0.8
                if u366.HubRef then
                    local v1 = SliderFrame
                    u366.HubRef:ScrollToFrame(v1)
                end
            end
        end)
        SliderFrame.SelectionLost:Connect(function() -- Line: 2435 -- upvalues: VRService (upval), UserInputService (upval), u397 (val)
            if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
                u397.BackgroundTransparency = 1
            end
        end)
        u50.MouseEnter:Connect(function() -- Line: 2441
            -- upvalues: PlayerGui (upval), SliderFrame (ref), VRService (upval), UserInputService (upval), a1 (val)
            -- upvalues: GuiService (upval), u358 (ref)
            local DropDownFullscreenFrame = PlayerGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame")
            if DropDownFullscreenFrame and DropDownFullscreenFrame.Visible then
                return
            end
            local v1 = SliderFrame
            if v1
                and v1.Visible
                and 1 < v1.ZIndex
                and (if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false)
                and a1.Active then
                GuiService.SelectedCoreObject = v1
                u358 = true
            end
        end)

        function u366.SetZIndex(a1, a2) -- Line: 2472 -- upvalues: u397 (val)
            u397.ZIndex = a2
        end

        function u366.SetInteractable(a1, a2) -- Line: 2474 -- upvalues: u397 (val)
            u397.Selectable = a2
            if not a2 then
                u397.TextColor3 = Color3.fromRGB(49, 49, 49)
                u397.ZIndex = 1
                return
            end
            u397.TextColor3 = Color3.fromRGB(178, 178, 178)
            u397.ZIndex = 2
        end

        function u366.SetValue(a1, a2) -- Line: 2485 -- upvalues: u397 (val)
            u397.Text = a2
        end

        local u454 = Instance.new("BindableEvent")
        u454.Name = "ValueChanged"
        u397.FocusLost:Connect(function() -- Line: 2492 -- upvalues: u454 (val), u397 (val)
            u454:Fire(u397.Text)
        end)
        u366.ValueChanged = u454.Event
        UserInputService.InputBegan:Connect(function(a1) -- Line: 2460 -- upvalues: GuiService (upval), SliderFrame (ref), u359 (ref), u397 (val)
            if a1.UserInputState == Enum.UserInputState.Begin
                and a1.KeyCode == Enum.KeyCode.Return
                and GuiService.SelectedCoreObject == SliderFrame then
                u359 = true
                u397:CaptureFocus()
            end
        end)
    end
    u366.Name = a2 .. "ValueChanger"
    v2 = v2 + u125
    if a6 then
        v2 = v2 + a6
    end
    u126[a1] = v2
    if v3 then
        u50.MouseEnter:Connect(function() -- Line: 2509
            -- upvalues: PlayerGui (upval), u366 (ref), VRService (upval), UserInputService (upval), a1 (val)
            -- upvalues: GuiService (upval)
            local DropDownFullscreenFrame = PlayerGui.RobloxGui:FindFirstChild("DropDownFullscreenFrame")
            if DropDownFullscreenFrame and DropDownFullscreenFrame.Visible then
                return
            end
            local SliderFrame = u366.SliderFrame or u366.SliderFrame or u366.DropDownFrame or u366.SelectorFrame
            if SliderFrame
                and SliderFrame.Visible
                and 1 < SliderFrame.ZIndex
                and (if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false)
                and a1.Active then
                GuiService.SelectedCoreObject = SliderFrame
            end
        end)
        VRService.Changed:Connect(function(a1) -- Line: 2539 -- upvalues: VRService (upval), u50 (ref), SliderFrame (ref), GuiService (upval)
            if a1 == "VREnabled" then
                if VRService.VREnabled then
                    u50.Selectable = true
                    u50.Active = true
                    SliderFrame.Active = true
                    GuiService.Changed:Connect(function(a1) -- Line: 2545 -- upvalues: GuiService (upval), u50 (upval)
                        if a1 == "SelectedCoreObject" then
                            local SelectedCoreObject = GuiService.SelectedCoreObject
                            if SelectedCoreObject then
                                if SelectedCoreObject ~= u50 and not SelectedCoreObject:IsDescendantOf(u50) then
                                    u50.ImageTransparency = 1
                                    u50.BackgroundTransparency = 1
                                    return
                                end
                                u50.ImageTransparency = 0.5
                                u50.BackgroundTransparency = 1
                                return
                            end
                            u50.ImageTransparency = 1
                            u50.BackgroundTransparency = 1
                        end
                    end)
                    return
                end
                u50.Selectable = false
                u50.Active = false
            end
        end)
        if not VRService.VREnabled then
            u50.Selectable = false
            u50.Active = false
        else
            u50.Selectable = true
            u50.Active = true
            SliderFrame.Active = true
            GuiService.Changed:Connect(function(a1) -- Line: 2545 -- upvalues: GuiService (upval), u50 (ref)
                if a1 == "SelectedCoreObject" then
                    local SelectedCoreObject = GuiService.SelectedCoreObject
                    if SelectedCoreObject then
                        if SelectedCoreObject ~= u50 and not SelectedCoreObject:IsDescendantOf(u50) then
                            u50.ImageTransparency = 1
                            u50.BackgroundTransparency = 1
                            return
                        end
                        u50.ImageTransparency = 0.5
                        u50.BackgroundTransparency = 1
                        return
                    end
                    u50.ImageTransparency = 1
                    u50.BackgroundTransparency = 1
                end
            end)
        end
        SliderFrame.SelectionGained:Connect(function() -- Line: 2566 -- upvalues: VRService (upval), UserInputService (upval), u50 (ref), u366 (ref)
            if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
                if not VRService.VREnabled then
                    u50.ImageTransparency = 1
                    u50.BackgroundTransparency = 0.5
                else
                    u50.ImageTransparency = 0.5
                    u50.BackgroundTransparency = 1
                end
                if u366.HubRef then
                    local v1 = u50
                    u366.HubRef:ScrollToFrame(v1)
                end
            end
        end)
        SliderFrame.SelectionLost:Connect(function() -- Line: 2581 -- upvalues: VRService (upval), UserInputService (upval), u50 (ref)
            if if not VRService.VREnabled then if not UserInputService.TouchEnabled then true else if UserInputService.GamepadEnabled then true else false else false then
                u50.ImageTransparency = 1
                u50.BackgroundTransparency = 1
            end
        end)
    end
    a1:AddRow(u50, u100, u366, a6, false)
    u366.Selection = SliderFrame
    v1 = u366
    return u50, u100, v1
end

local function AddNewRowObject(a1, a2, a3, a4) -- Line: 2596
    -- upvalues: u126 (val), u68 (val), u125 (ref), u79 (val), u70 (val), getViewportSize (val), GuiService (val)
    -- upvalues: VRService (val)
    local v1 = 0
    if u126[a1] then
        v1 = u126[a1]
    end
    local u41 = u68.Create("ImageButton")({
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Image = "rbxasset://textures/ui/VR/rectBackgroundWhite.png",
        ImageTransparency = 1,
        Active = false,
        AutoButtonColor = false,
        ZIndex = 2,
        Selectable = false,
        Name = a2 .. "Frame",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 10, 10),
        Size = UDim2.new(1, 0, 0, u125),
        Position = UDim2.new(0, 0, 0, v1),
        SelectionImageObject = u79,
        Parent = a1.Page,
    })
    u41.ImageColor3 = u41.BackgroundColor3
    u41.SelectionGained:Connect(function() -- Line: 2621 -- upvalues: u41 (val)
        u41.BackgroundTransparency = 0.5
    end)
    u41.SelectionLost:Connect(function() -- Line: 2622 -- upvalues: u41 (val)
        u41.BackgroundTransparency = 1
    end)
    local u80 = u68.Create("TextLabel")({
        TextSize = 16,
        BackgroundTransparency = 1,
        ZIndex = 2,
        Name = a2 .. "Label",
        Text = a2,
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        Parent = u41,
    })

    u70[u41] = function(a1, a2) -- Line: 2637 -- upvalues: u80 (val)
        if a2 then
            u80.TextSize = 16
            return
        end
        u80.TextSize = 24
    end

    getViewportSize()
    local v2 = getViewportSize()
    if not (v2.X < v2.Y) then
        u80.TextSize = 24
    else
        u80.TextSize = 16
    end
    if a4 then
        u41.Position = UDim2.new(u41.Position.X.Scale, u41.Position.X.Offset, u41.Position.Y.Scale, u41.Position.Y.Offset + a4)
    end
    v1 = v1 + u125
    if a4 then
        v1 = v1 + a4
    end
    u126[a1] = v1
    u41.MouseEnter:Connect(function() -- Line: 2662 -- upvalues: u41 (val), GuiService (upval)
        if u41.Visible then
            GuiService.SelectedCoreObject = u41
        end
    end)
    a3.SelectionImageObject = u79
    a3.SelectionGained:Connect(function() -- Line: 2671 -- upvalues: VRService (upval), u41 (val)
        if VRService.VREnabled then
            u41.ImageTransparency = 0.5
            u41.BackgroundTransparency = 1
            return
        end
        u41.ImageTransparency = 1
        u41.BackgroundTransparency = 0.5
    end)
    a3.SelectionLost:Connect(function() -- Line: 2680 -- upvalues: u41 (val)
        u41.ImageTransparency = 1
        u41.BackgroundTransparency = 1
    end)
    a3.Parent = u41
    a1:AddRow(u41, u80, a3, a4, true)
    return u41
end

local u142 = {}

function u142.Create(a1, a2) -- Line: 2694
    return function(a1) -- Line: 2695 -- upvalues: a2 (val)
        local v1 = Instance.new(a2)
        local v2 = nil
        for k, v in pairs(a1) do
            if type(k) == "number" then
                v.Parent = v1
            elseif k ~= "Parent" then
                v1[k] = v
            else
                v2 = v
            end
        end
        if v2 then
            v1.Parent = v2
        end
        return v1
    end
end

function u142.RayPlaneIntersection(a1, a2, a3, a4) -- Line: 2716
    local unit = a3.unit
    local Unit = a2.Unit
    local v1 = unit:Dot(Unit.Direction)
    if v1 == 0 then
        return nil
    end
    local v2 = unit:Dot(a4 - Unit.Origin) / v1
    if v2 < 0 then
        return nil
    end
    return Unit.Origin + Unit.Direction * v2
end

function u142.GetEaseLinear(a1) -- Line: 2734 -- upvalues: Linear (val)
    return Linear
end

function u142.GetEaseOutQuad(a1) -- Line: 2735 -- upvalues: EaseOutQuad (val)
    return EaseOutQuad
end

function u142.GetEaseInOutQuad(a1) -- Line: 2736 -- upvalues: EaseInOutQuad (val)
    return EaseInOutQuad
end

function u142.CreateNewSlider(a1, a2, a3, a4) -- Line: 2738 -- upvalues: CreateNewSlider (val)
    return CreateNewSlider(a2, a3, a4)
end

function u142.CreateNewSelector(a1, a2, a3) -- Line: 2742 -- upvalues: CreateSelector (val)
    return (CreateSelector(a2, a3))
end

function u142.CreateNewDropDown(a1, a2, a3) -- Line: 2746 -- upvalues: CreateDropDown (val)
    return (CreateDropDown(a2, a3, nil))
end

function u142.AddNewRow(a1, a2, a3, a4, a5, a6, a7) -- Line: 2750 -- upvalues: AddNewRow (val)
    return AddNewRow(a2, a3, a4, a5, a6, a7)
end

function u142.AddNewRowObject(a1, a2, a3, a4, a5) -- Line: 2761 -- upvalues: AddNewRowObject (val)
    return (AddNewRowObject(a2, a3, a4, a5))
end

function u142.ShowAlert(a1, a2, a3, a4, a5, a6) -- Line: 2765 -- upvalues: ShowAlert (val)
    ShowAlert(a2, a3, a4, a5, a6)
end

function u142.IsSmallTouchScreen(a1) -- Line: 2775 -- upvalues: getViewportSize (val), UserInputService (val)
    local v1 = getViewportSize()
    local TouchEnabled = UserInputService.TouchEnabled
    if TouchEnabled then
        TouchEnabled = true
        if not (v1.Y < 500) then
            TouchEnabled = v1.X < 700
        end
    end
    return TouchEnabled
end

function u142.IsPortrait(a1) -- Line: 2777 -- upvalues: getViewportSize (val)
    local v1 = getViewportSize()
    return v1.X < v1.Y
end

function u142.MakeStyledButton(a1, a2, a3, a4, a5, a6, a7) -- Line: 2779 -- upvalues: MakeButton (val)
    return MakeButton(a2, a3, a4, a5, a6, a7)
end

function u142.MakeStyledImageButton(a1, a2, a3, a4, a5, a6, a7, a8) -- Line: 2783 -- upvalues: MakeImageButton (val)
    return MakeImageButton(a2, a3, a4, a5, a6, a7, a8)
end

function u142.AddButtonRow(a1, a2, a3, a4, a5, a6, a7) -- Line: 2795 -- upvalues: AddButtonRow (val)
    return AddButtonRow(a2, a3, a4, a5, a6, a7)
end

function u142.CreateSignal(a1) -- Line: 2799 -- upvalues: CreateSignal (val)
    return (CreateSignal())
end

function u142.UsesSelectedObject(a1) -- Line: 2801 -- upvalues: VRService (val), UserInputService (val)
    if VRService.VREnabled then
        return false
    end
    if UserInputService.TouchEnabled and not UserInputService.GamepadEnabled then
        return false
    end
    return true
end

function u142.TweenProperty(a1, a2, a3, a4, a5, a6, a7, a8) -- Line: 2803
    return PropertyTweener(a2, a3, a4, a5, a6, a7, a8)
end

function u142.OnResized(a1, a2, a3) -- Line: 2815 -- upvalues: addOnResizedCallback (val)
    return addOnResizedCallback(a2, a3)
end

function u142.FireOnResized(a1) -- Line: 2817 -- upvalues: getViewportSize (val), u142 (val), u70 (val)
    local v1 = getViewportSize()
    local v2 = u142:IsPortrait()
    for k, v in pairs(u70) do
        v(v1, v2)
    end
end

function u142.Lerp(a1, a2, a3, a4) -- Line: 2828
    return (1 - a2) * a3 + a2 * a4
end

function u142.Round(a1, a2) -- Line: 2831
    return 0.5 <= a2 % 1 and math.ceil(a2) or math.floor(a2)
end

return u142