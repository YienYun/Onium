-- Script path: ReplicatedStorage.Client.Tabs
-- Decompile time: 24.35 ms

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local BossEventFlags = require(ReplicatedStorage.Shared.Flags.BossEventFlags)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GUI = require(ReplicatedStorage.Client.GUI)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local Signal = require(ReplicatedStorage.Packages.Signal)
local u56 = UDim2.fromScale(0.5, 0.5)
local u60 = NumberRange.new(24, 160)
local u65 = TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local u70 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local u71 = {BossMastery = true, BossShop = true}
local u72 = {}
u72.Activated = Signal.new()
u72.Deactivated = Signal.new()
local u77 = nil
local u78 = {}

local function animate(a1, a2, a3, a4) -- Line: 75
    -- upvalues: TweenService (val)
    if a4 then
        for i, j in a3 do
            a1[i] = j
        end
        return nil
    end
    local v1 = TweenService:Create(a1, a2, a3)
    v1:Play()
    return v1
end

local u83 = assert(Workspace.CurrentCamera, "Tabs requires Workspace.CurrentCamera")
local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Enabled = false
BlurEffect.Name = "MenuBackdropBlur"
BlurEffect.Size = 0
BlurEffect.Parent = u83
local u90 = nil
local u91 = false
local u92 = 0
local u93 = {}

local function drive(a1, a2, a3, a4, a5) -- Line: 102
    -- upvalues: u93 (val), TweenService (val)
    local v1 = u93[a1]
    if v1 ~= nil then
        u93[a1] = nil
        v1:Cancel()
    end
    if not a5 then
        local v2 = TweenService:Create(a2, a3, a4)
        v2:Play()
        v1 = v2
    else
        for i, j in a4 do
            a2[i] = j
        end
        v1 = nil
    end
    if v1 ~= nil then
        u93[a1] = v1
    end
    return v1
end

local function tabletLayout() -- Line: 121 -- upvalues: PlatformController (val), u83 (ref)
    return PlatformController.IsMobile() and 600 <= u83.ViewportSize.Y
end

local function parkPlayerList() -- Line: 126
    -- upvalues: u91 (ref), PlatformController (val), u83 (ref), StarterGui (val)
    if not u91 then
        local v1 = PlatformController.IsMobile() and 600 <= u83.ViewportSize.Y
        if v1 then
            if StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) then
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
                u91 = true
            end
            return
        end
    end
end

local function unparkPlayerList() -- Line: 136 -- upvalues: u91 (ref), StarterGui (val)
    if u91 then
        u91 = false
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
    end
end

local function blurIn(a1) -- Line: 144
    -- upvalues: BlurEffect (val), u70 (val), u93 (val), TweenService (val)
    local v1
    BlurEffect.Enabled = true
    local v2 = BlurEffect
    local v3 = {Size = 14}
    local blur = u93.blur
    if blur ~= nil then
        u93.blur = nil
        blur:Cancel()
    end
    if not a1 then
        local v4 = TweenService:Create(v2, u70, v3)
        v4:Play()
        v1 = v4
    else
        for i, j in v3 do
            v2[i] = j
        end
        v1 = nil
    end
    if v1 ~= nil then
        u93.blur = v1
    end
end

local function blurOut(a1) -- Line: 149
    -- upvalues: BlurEffect (val), u70 (val), u93 (val), TweenService (val)
    local v1
    local v2 = BlurEffect
    local v3 = {Size = 0}
    local blur = u93.blur
    if blur ~= nil then
        u93.blur = nil
        blur:Cancel()
    end
    if not a1 then
        local v4 = TweenService:Create(v2, u70, v3)
        v4:Play()
        v1 = v4
    else
        for i, j in v3 do
            v2[i] = j
        end
        v1 = nil
    end
    if v1 ~= nil then
        u93.blur = v1
    end
    return v1
end

local function pushFieldOfView(a1) -- Line: 156
    -- upvalues: u90 (ref), u83 (ref), u70 (val), u93 (val), TweenService (val)
    local v1
    local FieldOfView = u90 or u83.FieldOfView
    u90 = FieldOfView
    local v2 = u83
    local v3 = {FieldOfView = FieldOfView + 5}
    local fieldOfView = u93.fieldOfView
    if fieldOfView ~= nil then
        u93.fieldOfView = nil
        fieldOfView:Cancel()
    end
    if not a1 then
        local v4 = TweenService:Create(v2, u70, v3)
        v4:Play()
        v1 = v4
    else
        for i, j in v3 do
            v2[i] = j
        end
        v1 = nil
    end
    if v1 ~= nil then
        u93.fieldOfView = v1
    end
end

local function restoreFieldOfView(a1) -- Line: 162
    -- upvalues: u90 (ref), u83 (ref), u70 (val), u93 (val), TweenService (val)
    local v1 = u90
    if v1 ~= nil then
        local v2
        local v3 = u83
        local v4 = {FieldOfView = v1}
        local fieldOfView = u93.fieldOfView
        if fieldOfView ~= nil then
            u93.fieldOfView = nil
            fieldOfView:Cancel()
        end
        if not a1 then
            local v5 = TweenService:Create(v3, u70, v4)
            v5:Play()
            v2 = v5
        else
            for i, j in v4 do
                v3[i] = j
            end
            v2 = nil
        end
        if v2 ~= nil then
            u93.fieldOfView = v2
        end
    end
end

local function raiseBackdrop(a1, a2) -- Line: 169
    -- upvalues: u92 (ref), u90 (ref), u83 (ref), BlurEffect (val), u70 (val), u93 (val), TweenService (val), u91 (ref)
    -- upvalues: PlatformController (val), StarterGui (val)
    local v1, v2
    u92 = u92 + 1
    u90 = u90 or u83.FieldOfView
    BlurEffect.Enabled = true
    local v3 = BlurEffect
    local v4 = {Size = 14}
    local blur = u93.blur
    if blur ~= nil then
        u93.blur = nil
        blur:Cancel()
    end
    if not a2 then
        v2 = TweenService:Create(v3, u70, v4)
        v2:Play()
        v1 = v2
    else
        for i, j in v4 do
            v3[i] = j
        end
        v1 = nil
    end
    if v1 ~= nil then
        u93.blur = v1
    end
    if not a1.holdCamera then
        local FieldOfView_2 = u90 or u83.FieldOfView
        u90 = FieldOfView_2
        local v5 = u83
        v1 = {FieldOfView = FieldOfView_2 + 5}
        local fieldOfView = u93.fieldOfView
        if fieldOfView ~= nil then
            u93.fieldOfView = nil
            fieldOfView:Cancel()
        end
        if not a2 then
            local v6 = TweenService:Create(v5, u70, v1)
            v6:Play()
            v2 = v6
        else
            for k, n in v1 do
                v5[k] = n
            end
            v2 = nil
        end
        if v2 ~= nil then
            u93.fieldOfView = v2
        end
    end
    if not u91 then
        v3 = PlatformController.IsMobile() and 600 <= u83.ViewportSize.Y
        if not v3 then
            return
        end
        if StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) then
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
            u91 = true
        end
    end
end

local function lowerBackdrop(a1) -- Line: 179
    -- upvalues: u92 (ref), BlurEffect (val), u90 (ref), u83 (ref), u70 (val), u93 (val), TweenService (val), u91 (ref)
    -- upvalues: StarterGui (val)
    local v1, v2, v3
    u92 = u92 + 1
    local u3 = u92

    local function forget() -- Line: 183 -- upvalues: u92 (upval), u3 (val), BlurEffect (upval), u90 (upval)
        if u92 == u3 then
            BlurEffect.Enabled = false
            u90 = nil
        end
    end

    local v4 = u90
    if v4 ~= nil then
        v1 = u83
        v2 = {FieldOfView = v4}
        local fieldOfView = u93.fieldOfView
        if fieldOfView ~= nil then
            u93.fieldOfView = nil
            fieldOfView:Cancel()
        end
        if not a1 then
            local v5 = TweenService:Create(v1, u70, v2)
            v5:Play()
            v3 = v5
        else
            for i, j in v2 do
                v1[i] = j
            end
            v3 = nil
        end
        if v3 ~= nil then
            u93.fieldOfView = v3
        end
    end
    v1 = BlurEffect
    v2 = {Size = 0}
    local blur = u93.blur
    if blur ~= nil then
        u93.blur = nil
        blur:Cancel()
    end
    if not a1 then
        v3 = TweenService:Create(v1, u70, v2)
        v3:Play()
        v4 = v3
    else
        for k, n in v2 do
            v1[k] = n
        end
        v4 = nil
    end
    if v4 ~= nil then
        u93.blur = v4
    end
    if v4 then
        v4.Completed:Once(forget)
    elseif u92 == u3 then
        BlurEffect.Enabled = false
        u90 = nil
    end
    if u91 then
        u91 = false
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
    end
end

;(Workspace:GetPropertyChangedSignal("CurrentCamera")):Connect(function() -- Line: 200 -- upvalues: Workspace (val), u83 (ref), BlurEffect (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera ~= nil and CurrentCamera ~= u83 then
        u83 = CurrentCamera
        BlurEffect.Parent = CurrentCamera
    end
end)
local u112 = {}

u112[1] = function(a1) -- Line: 211
    return a1:FindFirstChild("Frame")
end

u112[2] = function(a1) -- Line: 214
    return a1:FindFirstChildOfClass("Frame")
end

u112[3] = function(a1) -- Line: 217
    return a1:FindFirstChildWhichIsA("ImageLabel")
end

local function stageFor(a1) -- Line: 222 -- upvalues: u78 (val) -- types: a1: string
    local v1 = u78[a1]
    if v1 then
        return v1
    end
    v1 = {generation = 0, wired = false}
    u78[a1] = v1
    return v1
end

local function dropCloser(a1) -- Line: 232 -- types: a1: table
    local closer = a1.closer
    if closer then
        closer:Disconnect()
        a1.closer = nil
    end
end

local function screenNamed(a1) -- Line: 240 -- upvalues: GUI (val) -- types: a1: string
    local v1 = GUI.Get(a1)
    assert(v1:IsA("ScreenGui"), (("tab %* must resolve to a ScreenGui"):format(a1)))
    return v1
end

local function bodyOf(a1) -- Line: 246 -- upvalues: u112 (val) -- types: a1: userdata
    local v1
    for i, j in u112 do
        v1 = j(a1)
        if v1 and v1:IsA("GuiObject") then
            return v1
        end
    end
    error((("tab %* has no GuiObject body"):format(a1.Name)))
end

local function scaleOf(a1) -- Line: 257 -- types: a1: userdata
    local MenuScale = a1:FindFirstChild("MenuScale")
    if MenuScale and MenuScale:IsA("UIScale") then
        return MenuScale
    end
    local UIScale = a1:FindFirstChildOfClass("UIScale")
    if UIScale then
        return UIScale
    end
    local UIScale_2 = Instance.new("UIScale")
    UIScale_2.Name = "MenuScale"
    UIScale_2.Parent = a1
    return UIScale_2
end

local function specOf(a1) -- Line: 272 -- types: a1: userdata
    return {
        holdCamera = a1:GetAttribute("ModalDialog") == true,
        selfAnimated = a1:GetAttribute("AuthoredOpenAnimation") == true,
        snapClose = a1:GetAttribute("ImmediateClose") == true,
    }
end

local function entryTravel(a1) -- Line: 280 -- upvalues: u83 (ref), u60 (val) -- types: a1: userdata
    local Y = a1.AbsoluteSize.Y
    if Y <= 0 then
        Y = u83.ViewportSize.Y / 2
    end
    return (math.clamp(Y * 0.18, u60.Min, u60.Max))
end

local function loweredPose(a1) -- Line: 288 -- upvalues: u56 (val), u83 (ref), u60 (val) -- types: a1: userdata
    local fromOffset = UDim2.fromOffset
    local Y = a1.AbsoluteSize.Y
    if Y <= 0 then
        Y = u83.ViewportSize.Y / 2
    end
    return u56 + fromOffset(0, (math.clamp(Y * 0.18, u60.Min, u60.Max)))
end

local function closeButtonOf(a1) -- Line: 292 -- types: a1: userdata
    local Close = a1:FindFirstChild("Close")
    if Close == nil then
        local Frame = a1:FindFirstChildWhichIsA("Frame")
        Close = if not Frame then nil else Frame:FindFirstChild("Close")
    end
    if Close == nil then
        return nil
    end
    assert(Close:IsA("GuiButton"), (("%* must be a GuiButton"):format((Close:GetFullName()))))
    return Close
end

local function wireCloseButton(a1, a2) -- Line: 306
    -- upvalues: closeButtonOf (val), ButtonFX (val), GUI (val), u72 (val), GamepadBindings (val)
    if a1.wired then
        return
    end
    local v1 = closeButtonOf(a2)
    if v1 then
        ButtonFX(v1, 1.08)
        GUI.OnActivated(v1, function() -- Line: 313 -- upvalues: u72 (upval)
            u72.Deactivate()
        end)
        GamepadBindings.Inspect(v1)
    end
    a1.wired = true
end

local function releaseFocus(a1) -- Line: 322 -- upvalues: GuiService (val) -- types: a1: userdata
    local SelectedObject = GuiService.SelectedObject
    if SelectedObject ~= nil and SelectedObject:IsDescendantOf(a1) then
        GuiService.SelectedObject = nil
        GuiService.GuiNavigationEnabled = false
    end
end

local function admitted(a1) -- Line: 330 -- upvalues: u71 (val), BossEventFlags (val) -- types: a1: string
    local v1 = true
    if u71[a1] == true then
        v1 = BossEventFlags.ContentEnabled:Get() == true
    end
    return v1
end

local function exit(a1, a2) -- Line: 336
    -- upvalues: u78 (val), GUI (val), specOf (val), bodyOf (val), u77 (ref), GuiService (val), u65 (val)
    -- upvalues: TweenService (val), u56 (val), u83 (ref), u60 (val), lowerBackdrop (val), u72 (val)
    local v1
    local v2 = u78[a1]
    if not v2 then
        u78[a1] = {generation = 0, wired = false}
    end
    local u7 = v2
    local u12 = GUI.Get(a1)
    assert(u12:IsA("ScreenGui"), (("tab %* must resolve to a ScreenGui"):format(a1)))
    local v3 = specOf(u12)
    local u29 = bodyOf(u12)
    local MenuScale = u29:FindFirstChild("MenuScale")
    if not MenuScale or not MenuScale:IsA("UIScale") then
        local UIScale = u29:FindFirstChildOfClass("UIScale")
        if not UIScale then
            local UIScale_2 = Instance.new("UIScale")
            UIScale_2.Name = "MenuScale"
            UIScale_2.Parent = u29
            v1 = UIScale_2
        else
            v1 = UIScale
        end
    else
        v1 = MenuScale
    end
    local snapClose = true
    if a2.instant ~= true then
        snapClose = v3.snapClose
    end
    local replacedBy = a2.replacedBy
    u7.generation = u7.generation + 1
    local generation = u7.generation
    local closer = u7.closer
    if closer then
        closer:Disconnect()
        u7.closer = nil
    end
    u77 = nil
    local SelectedObject = GuiService.SelectedObject
    if SelectedObject ~= nil and SelectedObject:IsDescendantOf(u12) then
        GuiService.SelectedObject = nil
        GuiService.GuiNavigationEnabled = false
    end

    local function settle() -- Line: 351 -- upvalues: u7 (val), generation (val), u12 (val)
        if u7.generation ~= generation then
            return
        end
        local v1 = u7
        local closer = v1.closer
        if closer then
            closer:Disconnect()
            v1.closer = nil
        end
        u12.Enabled = false
    end

    if v3.selfAnimated then
        local closer_2
        u12:SetAttribute("Open", false)
        if snapClose then
            if u7.generation == generation then
                closer_2 = u7.closer
                if closer_2 then
                    closer_2:Disconnect()
                    u7.closer = nil
                end
                u12.Enabled = false
            end
        elseif u29.Visible then
            u7.closer = (u29:GetPropertyChangedSignal("Visible")):Connect(function() -- Line: 364 -- upvalues: u29 (val), u7 (val), generation (val), u12 (val)
                if not u29.Visible then
                    if u7.generation ~= generation then
                        return
                    end
                    local v1 = u7
                    local closer = v1.closer
                    if closer then
                        closer:Disconnect()
                        v1.closer = nil
                    end
                    u12.Enabled = false
                end
            end)
            task.delay(1.2, settle)
        elseif u7.generation == generation then
            closer_2 = u7.closer
            if closer_2 then
                closer_2:Disconnect()
                u7.closer = nil
            end
            u12.Enabled = false
        end
    elseif not snapClose then
        TweenService:Create(v1, u65, {Scale = 0.9}):Play()
        local v4 = {}
        local fromOffset = UDim2.fromOffset
        local Y = u29.AbsoluteSize.Y
        if Y <= 0 then
            Y = u83.ViewportSize.Y / 2
        end
        v4.Position = u56 + fromOffset(0, (math.clamp(Y * 0.18, u60.Min, u60.Max)))
        local v5 = TweenService:Create(u29, u65, v4)
        v5:Play()
        local v6 = v5
        if v6 then
            v6.Completed:Once(settle)
        end
    else
        v1.Scale = 0.9
        if u7.generation == generation then
            local closer_3 = u7.closer
            if closer_3 then
                closer_3:Disconnect()
                u7.closer = nil
            end
            u12.Enabled = false
        end
    end
    if replacedBy == nil then
        lowerBackdrop(snapClose)
    end
    u72.Deactivated:Fire(a1, {instant = snapClose, replacedBy = replacedBy})
end

local function enter(a1, a2) -- Line: 388
    -- upvalues: u78 (val), GUI (val), specOf (val), bodyOf (val), wireCloseButton (val), u77 (ref), u92 (ref)
    -- upvalues: u90 (ref), u83 (ref), BlurEffect (val), u70 (val), u93 (val), TweenService (val), u91 (ref)
    -- upvalues: PlatformController (val), StarterGui (val), u56 (val), u60 (val), u65 (val), u72 (val)
    local v1, v2
    local v3 = u78[a1]
    if not v3 then
        u78[a1] = {generation = 0, wired = false}
    end
    local v4 = v3
    v3 = GUI.Get(a1)
    assert(v3:IsA("ScreenGui"), (("tab %* must resolve to a ScreenGui"):format(a1)))
    local v5 = specOf(v3)
    local v6 = bodyOf(v3)
    local MenuScale = v6:FindFirstChild("MenuScale")
    if not MenuScale or not MenuScale:IsA("UIScale") then
        local UIScale = v6:FindFirstChildOfClass("UIScale")
        if not UIScale then
            local UIScale_2 = Instance.new("UIScale")
            UIScale_2.Name = "MenuScale"
            UIScale_2.Parent = v6
            v2 = UIScale_2
        else
            v2 = UIScale
        end
    else
        v2 = MenuScale
    end
    v4.generation = v4.generation + 1
    local closer = v4.closer
    if closer then
        closer:Disconnect()
        v4.closer = nil
    end
    wireCloseButton(v4, v6)
    u77 = a1
    v3.Enabled = true
    u92 = u92 + 1
    u90 = u90 or u83.FieldOfView
    BlurEffect.Enabled = true
    local v7 = BlurEffect
    local v8 = {Size = 14}
    local blur = u93.blur
    if blur ~= nil then
        u93.blur = nil
        blur:Cancel()
    end
    if not a2 then
        v1 = TweenService:Create(v7, u70, v8)
        v1:Play()
        v4 = v1
    else
        for i, j in v8 do
            v7[i] = j
        end
        v4 = nil
    end
    if v4 ~= nil then
        u93.blur = v4
    end
    if not v5.holdCamera then
        local v9
        local FieldOfView_2 = u90 or u83.FieldOfView
        u90 = FieldOfView_2
        local v10 = u83
        v1 = {FieldOfView = FieldOfView_2 + 5}
        local fieldOfView = u93.fieldOfView
        if fieldOfView ~= nil then
            u93.fieldOfView = nil
            fieldOfView:Cancel()
        end
        if not a2 then
            local v11 = TweenService:Create(v10, u70, v1)
            v11:Play()
            v9 = v11
        else
            for k, n in v1 do
                v10[k] = n
            end
            v9 = nil
        end
        if v9 ~= nil then
            u93.fieldOfView = v9
        end
    end
    if not u91 then
        v7 = PlatformController.IsMobile() and 600 <= u83.ViewportSize.Y
        if v7 and StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) then
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
            u91 = true
        end
    end
    if v5.selfAnimated then
        v6.Position = u56
        v3:SetAttribute("Open", true)
    elseif not a2 then
        local fromOffset = UDim2.fromOffset
        local Y = v6.AbsoluteSize.Y
        if Y <= 0 then
            Y = u83.ViewportSize.Y / 2
        end
        v6.Position = u56 + fromOffset(0, (math.clamp(Y * 0.18, u60.Min, u60.Max)))
        v2.Scale = 0.96
        TweenService:Create(v6, u65, {Position = u56}):Play()
        TweenService:Create(v2, u65, {Scale = 1}):Play()
    else
        v6.Position = u56
        v2.Scale = 1
    end
    u72.Activated:Fire(a1, {instant = a2})
end

function u72.Active() -- Line: 421 -- upvalues: u77 (ref)
    return u77
end

function u72.IsActive(a1) -- Line: 425 -- upvalues: u77 (ref) -- types: a1: string?
    local v1 = false
    if u77 ~= nil then
        v1 = true
        if a1 ~= nil then
            v1 = u77 == a1
        end
    end
    return v1
end

function u72.Activate(a1, a2) -- Line: 430
    -- upvalues: u77 (ref), u71 (val), BossEventFlags (val), exit (val), enter (val)
    if u77 ~= a1 then
        local v1 = true
        if u71[a1] == true then
            v1 = BossEventFlags.ContentEnabled:Get() == true
        end
        if v1 then
            v1 = u77
            if v1 ~= nil then
                exit(v1, {instant = true, replacedBy = a1})
            end
            local v2 = false
            if a2 ~= nil then
                v2 = a2.instant == true
            end
            enter(a1, v2)
            return true
        end
    end
    return false
end

function u72.Deactivate(a1) -- Line: 442 -- upvalues: u77 (ref), exit (val) -- types: a1: table?
    local v1 = u77
    if v1 ~= nil then
        local v2 = {}
        local v3 = false
        if a1 ~= nil then
            v3 = a1.instant == true
        end
        v2.instant = v3
        exit(v1, v2)
    end
end

function u72.Toggle(a1, a2) -- Line: 449 -- upvalues: u72 (val), u77 (ref) -- types: a1: string, a2: table?
    if not u72.Activate(a1, a2) and u77 == a1 then
        u72.Deactivate(a2)
    end
end

BossEventFlags.ContentEnabled.Changed:Connect(function() -- Line: 455 -- upvalues: u77 (ref), u71 (val), BossEventFlags (val), u72 (val)
    local v1 = u77
    if v1 ~= nil then
        local v2 = true
        if u71[v1] == true then
            v2 = BossEventFlags.ContentEnabled:Get() == true
        end
        if not v2 then
            u72.Deactivate({instant = true})
        end
    end
end)
return (table.freeze(u72))