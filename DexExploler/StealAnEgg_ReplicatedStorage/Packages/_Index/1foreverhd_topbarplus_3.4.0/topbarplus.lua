-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.4.0.topbarplus
-- Decompile time: 31.92 ms

local UserInputService = game:GetService("UserInputService")
local ContentProvider = game:GetService("ContentProvider")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
require(script.Types)
local u24 = script
local Reference = require(u24.Reference)
local v1 = Reference.getObject()
local Value = v1 and v1.Value
if Value and Value ~= u24 then
    return (require(Value))
end
if not v1 then
    Reference.addToReplicatedStorage()
end
local GoodSignal = require(u24.Packages.GoodSignal)
local u53 = require(u24.Packages.Janitor)
local u57 = require(u24.Utility)
local Themes = require(u24.Features.Themes)
local Gamepad = require(u24.Features.Gamepad)
local Overflow = require(u24.Features.Overflow)
local u70 = {}
u70.__index = u70
local LocalPlayer = Players.LocalPlayer
local Themes_2 = u24.Features.Themes
local u77 = {}
local u79 = GoodSignal.new()
local Elements = u24.Elements
local u81 = 0
local u82 = {
    mobile = Enum.PreferredInput.Touch,
    desktop = Enum.PreferredInput.KeyboardAndMouse,
    console = Enum.PreferredInput.Gamepad,
}
u70.baseDisplayOrderChanged = GoodSignal.new()
u70.baseDisplayOrder = 10
u70.baseTheme = require(Themes_2.Default)
u70.isOldTopbar = false
u70.iconsDictionary = u77
u70.insetHeightChanged = GoodSignal.new()
u70.container = require(Elements.Container)(u70)
u70.topbarEnabled = true
u70.iconAdded = GoodSignal.new()
u70.iconRemoved = GoodSignal.new()
u70.iconChanged = GoodSignal.new()

function u70.getIcons() -- Line: 110 -- upvalues: u70 (val)
    return u70.iconsDictionary
end

function u70.getIconByUID(a1) -- Line: 114 -- upvalues: u70 (val)
    local v1 = u70.iconsDictionary[a1]
    if v1 then
        return v1
    end
    return nil
end

function u70.getIcon(a1) -- Line: 122 -- upvalues: u70 (val), u77 (val)
    local v1 = u70.getIconByUID(a1)
    if v1 then
        return v1
    end
    for k, v in pairs(u77) do
        if v.name == a1 then
            return v
        end
    end
    return nil
end

function u70.setTopbarEnabled(a1, a2) -- Line: 135 -- upvalues: u70 (val)
    if typeof(a1) ~= "boolean" then
        a1 = u70.topbarEnabled
    end
    if not a2 then
        u70.topbarEnabled = a1
    end
    for k, v in pairs(u70.container) do
        v.Enabled = a1
    end
end

function u70.modifyBaseTheme(a1) -- Line: 147 -- upvalues: Themes (val), u70 (val), u77 (val)
    local baseTheme
    for k, v in pairs((Themes.getModifications(a1))) do
        for k2, i in pairs(u70.baseTheme) do
            Themes.merge(i, v)
        end
    end
    for k3, j in pairs(u77) do
        baseTheme = u70.baseTheme
        j:setTheme(baseTheme)
    end
end

function u70.setDisplayOrder(a1) -- Line: 159 -- upvalues: u70 (val)
    u70.baseDisplayOrder = a1
    u70.baseDisplayOrderChanged:Fire(a1)
end

task.defer(Gamepad.start, u70)
task.defer(Overflow.start, u70)
task.defer(function() -- Line: 169 -- upvalues: LocalPlayer (val), u70 (val), u24 (val)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    for k, v in pairs(u70.container) do
        v.Parent = PlayerGui
    end
    require(u24.Attribute)
end)

function u70.new() -- Line: 180
    -- upvalues: u70 (val), u53 (val), u57 (val), u77 (val), GoodSignal (val), u24 (val), Elements (val), u81 (ref)
    -- upvalues: UserInputService (val), u82 (val), u79 (val), StarterGui (val)
    local u0 = {}
    local v1 = u70
    setmetatable(u0, v1)
    local v2 = u53.new()
    u0.janitor = v2
    u0.themesJanitor = v2:add((u53.new()))
    u0.singleClickJanitor = v2:add((u53.new()))
    u0.captionJanitor = v2:add((u53.new()))
    u0.joinJanitor = v2:add((u53.new()))
    u0.menuJanitor = v2:add((u53.new()))
    u0.dropdownJanitor = v2:add((u53.new()))
    local u46 = u57.generateUID()
    u77[u46] = u0
    v2:add(function() -- Line: 197 -- upvalues: u77 (upval), u46 (val)
        u77[u46] = nil
    end)
    u0.selected = v2:add((GoodSignal.new()))
    u0.deselected = v2:add((GoodSignal.new()))
    u0.toggled = v2:add((GoodSignal.new()))
    u0.viewingStarted = v2:add((GoodSignal.new()))
    u0.viewingEnded = v2:add((GoodSignal.new()))
    u0.stateChanged = v2:add((GoodSignal.new()))
    u0.notified = v2:add((GoodSignal.new()))
    u0.noticeStarted = v2:add((GoodSignal.new()))
    u0.noticeChanged = v2:add((GoodSignal.new()))
    u0.endNotices = v2:add((GoodSignal.new()))
    u0.toggleKeyAdded = v2:add((GoodSignal.new()))
    u0.fakeToggleKeyChanged = v2:add((GoodSignal.new()))
    u0.alignmentChanged = v2:add((GoodSignal.new()))
    u0.updateSize = v2:add((GoodSignal.new()))
    u0.resizingComplete = v2:add((GoodSignal.new()))
    u0.joinedParent = v2:add((GoodSignal.new()))
    u0.menuSet = v2:add((GoodSignal.new()))
    u0.dropdownSet = v2:add((GoodSignal.new()))
    u0.updateMenu = v2:add((GoodSignal.new()))
    u0.startMenuUpdate = v2:add((GoodSignal.new()))
    u0.childThemeModified = v2:add((GoodSignal.new()))
    u0.indicatorSet = v2:add((GoodSignal.new()))
    u0.dropdownChildAdded = v2:add((GoodSignal.new()))
    u0.menuChildAdded = v2:add((GoodSignal.new()))
    u0.iconModule = u24
    u0.UID = u46
    u0.isEnabled = true
    u0.enabled = u0.isEnabled
    u0.isSelected = false
    u0.isViewing = false
    u0.joinedFrame = false
    u0.parentIconUID = false
    u0.deselectWhenOtherIconSelected = true
    u0.totalNotices = 0
    u0.activeState = "Deselected"
    u0.alignment = ""
    u0.originalAlignment = ""
    u0.appliedTheme = {}
    u0.appearance = {}
    u0.cachedInstances = {}
    u0.cachedNamesToInstances = {}
    u0.cachedCollectives = {}
    u0.bindedToggleKeys = {}
    u0.customBehaviours = {}
    u0.toggleItems = {}
    u0.bindedEvents = {}
    u0.notices = {}
    u0.menuIcons = {}
    u0.dropdownIcons = {}
    u0.childIconsDict = {}
    u0.creationTime = os.clock()
    u0.widget = v2:add((require(Elements.Widget)(u0, u70)))
    u0:setAlignment()
    u81 = u81 + 1
    v1 = u81 * 0.01 + 1
    u0:setOrder(v1, "deselected")
    u0:setOrder(v1, "selected")
    u0:setTheme(u70.baseTheme)
    v1 = u0:getInstance("ClickRegion")
    local u260 = false
    local u261 = 0

    local function handleToggle() -- Line: 277 -- upvalues: u0 (val), u261 (ref)
        if u0.locked then
            return
        end
        local v1 = tick()
        if v1 - u261 < 0.1 then
            return
        end
        u261 = v1
        if u0.isSelected then
            u0:deselect("User", u0)
            return
        end
        u0:select("User", u0)
    end

    v1.MouseButton1Click:Connect(function() -- Line: 296 -- upvalues: u260 (ref), u0 (val), u261 (ref)
        u260 = true
        if u0.locked then
            return
        end
        local v1 = tick()
        if v1 - u261 < 0.1 then
            return
        end
        u261 = v1
        if u0.isSelected then
            u0:deselect("User", u0)
            return
        end
        u0:select("User", u0)
    end)
    v1.TouchTap:Connect(function() -- Line: 301 -- upvalues: u260 (ref), u0 (val), u261 (ref)
        if not u260 then
            if u0.locked then
                return
            end
            local v1 = tick()
            if v1 - u261 < 0.1 then
                return
            end
            u261 = v1
            if u0.isSelected then
                u0:deselect("User", u0)
                return
            end
            u0:select("User", u0)
        end
    end)
    v2:add((UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 314 -- upvalues: u0 (val), u261 (ref)
        if u0.locked then
            return
        end
        if u0.bindedToggleKeys[a1.KeyCode] and not a2 then
            if u0.locked then
                return
            end
            local v1 = tick()
            if v1 - u261 < 0.1 then
                return
            end
            u261 = v1
            if u0.isSelected then
                u0:deselect("User", u0)
                return
            end
            u0:select("User", u0)
        end
    end)))

    local function viewingEnded() -- Line: 336 -- upvalues: u0 (val)
        if u0.locked then
            return
        end
        u0.isViewing = false
        u0.viewingEnded:Fire(true)
        u0:setState(nil, "User", u0)
    end

    u0.joinedParent:Connect(function() -- Line: 344 -- upvalues: u0 (val)
        if u0.isViewing then
            if u0.locked then
                return
            end
            u0.isViewing = false
            u0.viewingEnded:Fire(true)
            u0:setState(nil, "User", u0)
        end
    end)
    v1.MouseEnter:Connect(function() -- Line: 349 -- upvalues: UserInputService (upval), u82 (upval), u0 (val)
        local v1 = UserInputService.PreferredInput ~= u82.desktop
        if u0.locked then
            return
        end
        u0.isViewing = true
        u0.viewingStarted:Fire(true)
        if not v1 then
            u0:setState("Viewing", "User", u0)
        end
    end)
    local u294 = 0
    v2:add((UserInputService.TouchEnded:Connect(viewingEnded)))
    v1.MouseLeave:Connect(viewingEnded)
    v1.SelectionGained:Connect(function(a1) -- Line: 326 -- upvalues: u0 (val)
        if u0.locked then
            return
        end
        u0.isViewing = true
        u0.viewingStarted:Fire(true)
        if not a1 then
            u0:setState("Viewing", "User", u0)
        end
    end)
    v1.SelectionLost:Connect(viewingEnded)
    v1.MouseButton1Down:Connect(function() -- Line: 358 -- upvalues: u0 (val), UserInputService (upval), u82 (upval), u294 (ref)
        if not u0.locked and UserInputService.PreferredInput == u82.mobile then
            u294 = u294 + 1
            local u8 = u294
            task.delay(0.2, function() -- Line: 362 -- upvalues: u8 (val), u294 (upval), u0 (upval)
                if u8 == u294 then
                    if u0.locked then
                        return
                    end
                    u0.isViewing = true
                    u0.viewingStarted:Fire(true)
                    u0:setState("Viewing", "User", u0)
                end
            end)
        end
    end)
    v1.MouseButton1Up:Connect(function() -- Line: 369 -- upvalues: u294 (ref)
        u294 = u294 + 1
    end)
    local u333 = u0:getInstance("IconOverlay")
    u0.viewingStarted:Connect(function() -- Line: 375 -- upvalues: u333 (val), u0 (val)
        u333.Visible = not u0.overlayDisabled
    end)
    u0.viewingEnded:Connect(function() -- Line: 378 -- upvalues: u333 (val)
        u333.Visible = false
    end)
    v2:add((u79:Connect(function(a1) -- Line: 383 -- upvalues: u0 (val)
        if a1 ~= u0 and u0.deselectWhenOtherIconSelected and a1.deselectWhenOtherIconSelected then
            u0:deselect("AutoDeselect", a1)
        end
    end)))
    local v3 = string.split(debug.info(2, "s"), ".")
    v2 = game
    local v4 = nil
    for k, v in pairs(v3) do
        v2 = v2:FindFirstChild(v)
        if not v2 then
            break
        end
        if v2:IsA("ScreenGui") then
            v4 = v2
        end
    end
    if v2 and v4 and v4.ResetOnSpawn == true then
        u0.originsScreenGui = v4
        u57.localPlayerRespawned(function() -- Line: 409 -- upvalues: u0 (val)
            u0:destroy()
        end)
    end
    u0.toggled:Connect(function(a1) -- Line: 415 -- upvalues: u0 (val), u70 (upval)
        local v1
        u0.noticeChanged:Fire(u0.totalNotices)
        for k, v in pairs(u0.childIconsDict) do
            v1 = u70.getIconByUID(k)
            v1.noticeChanged:Fire(v1.totalNotices)
            if not a1 and v1.isSelected then
                for k2, i in pairs(v1.childIconsDict) do
                    v1:deselect("HideParentFeature", u0)
                end
            end
        end
    end)
    u0.selected:Connect(function() -- Line: 438 -- upvalues: u0 (val), StarterGui (upval)
        if #u0.dropdownIcons > 0 then
            if StarterGui:GetCore("ChatActive") and u0.alignment ~= "Right" then
                u0.chatWasPreviouslyActive = true
                StarterGui:SetCore("ChatActive", false)
            end
            if StarterGui:GetCoreGuiEnabled("PlayerList") and u0.alignment ~= "Left" then
                u0.playerlistWasPreviouslyActive = true
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
            end
        end
    end)
    u0.deselected:Connect(function() -- Line: 451 -- upvalues: u0 (val), StarterGui (upval)
        if u0.chatWasPreviouslyActive then
            u0.chatWasPreviouslyActive = nil
            StarterGui:SetCore("ChatActive", true)
        end
        if u0.playerlistWasPreviouslyActive then
            u0.playerlistWasPreviouslyActive = nil
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
        end
    end)
    task.delay(0.1, function() -- Line: 465 -- upvalues: u0 (val)
        if u0.activeState == "Deselected" then
            u0.stateChanged:Fire("Deselected")
            u0:refresh()
        end
    end)
    u70.iconAdded:Fire(u0)
    return u0
end

function u70.setName(a1, a2) -- Line: 481
    a1.widget.Name = a2
    a1.name = a2
    return a1
end

function u70:setState(a2, a3, a4) -- Line: 487 -- upvalues: u57 (val), u79 (val)
    if not a2 then
        a2 = if not self.isSelected then "Deselected" else "Selected"
    end
    local v1 = u57.formatStateName(a2)
    if self.activeState == v1 then
        return
    end
    local isSelected = self.isSelected
    self.activeState = v1
    if v1 == "Deselected" then
        self.isSelected = false
        if isSelected then
            self.toggled:Fire(false, a3, a4)
            self.deselected:Fire(a3, a4)
        end
        self:_setToggleItemsVisible(false, a3, a4)
    elseif v1 == "Selected" then
        self.isSelected = true
        if not isSelected then
            self.toggled:Fire(true, a3, a4)
            self.selected:Fire(a3, a4)
            u79:Fire(self, a3, a4)
        end
        self:_setToggleItemsVisible(true, a3, a4)
    end
    self.stateChanged:Fire(v1, a3, a4)
end

function u70:getInstance(a2) -- Line: 520 -- upvalues: Themes (val)
    local scanChildren
    local v1 = self.cachedNamesToInstances[a2]
    if v1 then
        return v1
    end

    local function cacheInstance(a1, a2) -- Line: 528 -- upvalues: self (val)
        if not self.cachedInstances[a2] then
            local Attribute = a2:GetAttribute("Collective")
            local v1 = Attribute and self.cachedCollectives[Attribute]
            if v1 then
                table.insert(v1, a2)
            end
            self.cachedNamesToInstances[a1] = a2
            self.cachedInstances[a2] = true
            a2.Destroying:Once(function() -- Line: 538 -- upvalues: self (upval), a1 (val), a2 (val)
                self.cachedNamesToInstances[a1] = nil
                self.cachedInstances[a2] = nil
            end)
        end
    end

    local widget = self.widget
    cacheInstance("Widget", widget)
    if a2 == "Widget" then
        return widget
    end
    local u10 = nil

    function scanChildren(a1) -- Line: 551
        -- upvalues: self (val), Themes (upval), scanChildren (val), cacheInstance (val), a2 (val), u10 (ref)
        local Attribute, Name, v1
        for k, v in pairs(a1:GetChildren()) do
            Attribute = v:GetAttribute("WidgetUID")
            if not Attribute or Attribute == self.UID then
                v1 = Themes.getRealInstance(v)
                if v1 then
                    v = v1
                end
                scanChildren(v)
                if v:IsA("GuiBase") or v:IsA("UIBase") or v:IsA("ValueBase") then
                    Name = v.Name
                    cacheInstance(Name, v)
                    if Name == a2 then
                        u10 = v
                    end
                end
            end
        end
    end

    scanChildren(widget)
    return u10
end

function u70:getCollective(a2) -- Line: 580
    local v1 = self.cachedCollectives[a2]
    if v1 then
        return v1
    end
    v1 = {}
    for k, v in pairs(self.cachedInstances) do
        if k:GetAttribute("Collective") == a2 then
            table.insert(v1, k)
        end
    end
    self.cachedCollectives[a2] = v1
    return v1
end

function u70:getInstanceOrCollective(a2) -- Line: 601
    local v1 = {}
    local v2 = self:getInstance(a2)
    if v2 then
        table.insert(v1, v2)
    end
    if #v1 == 0 then
        v1 = self:getCollective(a2)
    end
    return v1
end

function u70.getStateGroup(a1, a2) -- Line: 615
    local activeState = a2 or a1.activeState
    local v1 = a1.appearance[activeState]
    if not v1 then
        a1.appearance[activeState] = {}
    end
    return v1
end

function u70.refreshAppearance(a1, a2, a3) -- Line: 625 -- upvalues: Themes (val)
    Themes.refresh(a1, a2, a3)
    return a1
end

function u70:refresh() -- Line: 630
    self:refreshAppearance(self.widget)
    self.updateSize:Fire()
    return self
end

function u70:updateParent() -- Line: 636 -- upvalues: u70 (val)
    local v1 = u70.getIconByUID(self.parentIconUID)
    if v1 then
        v1.updateSize:Fire()
    end
end

function u70.setBehaviour(a1, a2, a3, a4, a5) -- Line: 643
    local v1 = a2 .. "-" .. a3
    a1.customBehaviours[v1] = a4
    if a5 then
        for k, v in pairs((a1:getInstanceOrCollective(a2))) do
            a1:refreshAppearance(v, a3)
        end
    end
end

function u70.modifyTheme(a1, a2, a3) -- Line: 656 -- upvalues: Themes (val)
    return a1, (Themes.modify(a1, a2, a3))
end

function u70.modifyChildTheme(a1, a2, a3) -- Line: 661 -- upvalues: u70 (val)
    a1.childModifications = a2
    a1.childModificationsUID = a3
    for k, v in pairs(a1.childIconsDict) do
        u70.getIconByUID(k):modifyTheme(a2, a3)
    end
    a1.childThemeModified:Fire()
    return a1
end

function u70.removeModification(a1, a2) -- Line: 674 -- upvalues: Themes (val)
    Themes.remove(a1, a2)
    return a1
end

function u70.removeModificationWith(a1, a2, a3, a4) -- Line: 679 -- upvalues: Themes (val)
    Themes.removeWith(a1, a2, a3, a4)
    return a1
end

function u70.setTheme(a1, a2) -- Line: 684 -- upvalues: Themes (val)
    Themes.set(a1, a2)
    return a1
end

function u70.setEnabled(a1, a2) -- Line: 689
    a1.isEnabled = a2
    a1.enabled = a1.isEnabled
    a1.widget.Visible = a2
    a1:updateParent()
    return a1
end

function u70:select(a2, a3) -- Line: 697
    self:setState("Selected", a2, a3)
    return self
end

function u70:deselect(a2, a3) -- Line: 702
    self:setState("Deselected", a2, a3)
    return self
end

function u70.notify(a1, a2, a3) -- Line: 707 -- upvalues: Elements (val), u70 (val)
    if not a1.notice then
        a1.notice = require(Elements.Notice)(a1, u70)
    end
    a1.noticeStarted:Fire(a2, a3)
    return a1
end

function u70:clearNotices() -- Line: 721
    self.endNotices:Fire()
    return self
end

function u70.disableOverlay(a1, a2) -- Line: 726
    a1.overlayDisabled = a2
    return a1
end

u70.disableStateOverlay = u70.disableOverlay

function u70.setImage(a1, a2, a3) -- Line: 732 -- upvalues: ContentProvider (val)
    a1:modifyTheme({"IconImage", "Image", a2, a3})
    task.spawn(function() -- Line: 736 -- upvalues: a2 (val), ContentProvider (upval)
        local v1 = if not tonumber(a2) then a2 else ("rbxassetid://%*"):format(a2)
        if (ContentProvider:GetAssetFetchStatus(v1)) ~= Enum.AssetFetchStatus.Success then
            pcall(ContentProvider.PreloadAsync, ContentProvider, {v1})
        end
    end)
    return a1
end

function u70:setLabel(a2, a3) -- Line: 748
    self:modifyTheme({"IconLabel", "Text", a2, a3})
    return self
end

function u70:setOrder(a2, a3) -- Line: 753
    local v1 = a2 * 100
    self:modifyTheme({"IconSpot", "LayoutOrder", v1, a3})
    self:modifyTheme({"Widget", "LayoutOrder", v1, a3})
    return self
end

function u70.setCornerRadius(a1, a2, a3) -- Line: 762
    a1:modifyTheme({"IconCorners", "CornerRadius", a2, a3})
    return a1
end

function u70.align(a1, a2, a3) -- Line: 767 -- upvalues: u70 (val)
    local v1 = tostring(a2):lower()
    if v1 == "mid" or v1 == "centre" then
        v1 = "center"
    end
    if v1 ~= "left" and v1 ~= "center" and v1 ~= "right" then
        v1 = "left"
    end
    local TopbarCentered = not (v1 ~= "center") and u70.container.TopbarCentered or u70.container.TopbarStandard
    local Holders = TopbarCentered.Holders
    local v2 = (string.upper((string.sub(v1, 1, 1)))) .. string.sub(v1, 2)
    if not a3 then
        a1.originalAlignment = v2
    end
    local joinedFrame = a1.joinedFrame
    local v3 = Holders[v2]
    a1.screenGui = TopbarCentered
    a1.alignmentHolder = v3
    if not a1.isDestroyed then
        a1.widget.Parent = joinedFrame or v3
    end
    a1.alignment = v2
    a1.alignmentChanged:Fire(v2)
    u70.iconChanged:Fire(a1)
    return a1
end

u70.setAlignment = u70.align

function u70.setLeft(a1) -- Line: 796
    a1:setAlignment("Left")
    return a1
end

function u70.setMid(a1) -- Line: 801
    a1:setAlignment("Center")
    return a1
end

function u70.setRight(a1) -- Line: 806
    a1:setAlignment("Right")
    return a1
end

function u70.setWidth(a1, a2, a3) -- Line: 811
    a1:modifyTheme({"Widget", "DesiredWidth", a2, a3})
    return a1
end

function u70.setImageScale(a1, a2, a3) -- Line: 819
    a1:modifyTheme({"IconImageScale", "Value", a2, a3})
    return a1
end

function u70.setImageRatio(a1, a2, a3) -- Line: 824
    a1:modifyTheme({"IconImageRatio", "AspectRatio", a2, a3})
    return a1
end

function u70.setTextSize(a1, a2, a3) -- Line: 829
    a1:modifyTheme({"IconLabel", "TextSize", a2, a3})
    return a1
end

function u70.setTextFont(a1, a2, a3, a4, a5) -- Line: 834
    local v1 = a3 or Enum.FontWeight.Regular
    local v2 = a4 or Enum.FontStyle.Normal
    local v3 = nil
    local v4 = typeof(a2)
    if v4 == "number" then
        v3 = Font.fromId(a2, v1, v2)
    elseif v4 == "EnumItem" then
        v3 = Font.fromEnum(a2)
    elseif v4 == "string" and not a2:match("rbxasset") then
        v3 = Font.fromName(a2, v1, v2)
    end
    if not v3 then
        v3 = Font.new(a2, v1, v2)
    end
    a1:modifyTheme({"IconLabel", "FontFace", v3, a5})
    return a1
end

function u70.setTextColor(a1, a2, a3) -- Line: 855
    if a2 == nil or a2 == "" or type(a2) ~= "userdata" or typeof(a2) ~= "Color3" then
        if a2 ~= nil and a2 ~= "" then
            warn("setTextColor item must be a Color3 value! Changed the color to white.")
        end
        a2 = Color3.fromRGB(255, 255, 255)
    end
    a1:modifyTheme({"IconLabel", "TextColor3", a2, a3})
    return a1
end

function u70.bindToggleItem(a1, a2) -- Line: 867
    if not a2:IsA("GuiObject") and not a2:IsA("LayerCollector") then
        error("Toggle item must be a GuiObject or LayerCollector!")
    end
    a1.toggleItems[a2] = true
    a1:_updateSelectionInstances()
    return a1
end

function u70.unbindToggleItem(a1, a2) -- Line: 876
    a1.toggleItems[a2] = nil
    a1:_updateSelectionInstances()
    return a1
end

function u70:_updateSelectionInstances() -- Line: 882
    local v1
    for k, v in pairs(self.toggleItems) do
        v1 = {}
        for k2, i in pairs(k:GetDescendants()) do
            if i:IsA("TextButton") then
                if i.Active then
                    table.insert(v1, i)
                end
            elseif i:IsA("ImageButton") and i.Active then
                table.insert(v1, i)
            end
        end
        self.toggleItems[k] = v1
    end
end

function u70:_setToggleItemsVisible(a2, a3, a4) -- Line: 896
    local v1
    local v2, v3, v4 = a4, self, a2
    for k, v in pairs(self.toggleItems) do
        if not v2 or v2 == v3 or v2.toggleItems[k] == nil then
            v1 = "Visible"
            if k:IsA("LayerCollector") then
                v1 = "Enabled"
            end
            k[v1] = v4
        end
    end
end

function u70:bindEvent(a2, a3) -- Line: 908
    local v1 = self[a2]
    local Connect = v1
    if Connect then
        Connect = false
        if typeof(v1) == "table" then
            Connect = v1.Connect
        end
    end
    assert(Connect, "argument[1] must be a valid topbarplus icon event name!")
    assert(typeof(a3) == "function", "argument[2] must be a function!")
    self.bindedEvents[a2] = (v1:Connect(function(...) -- Line: 912 -- upvalues: a3 (val), self (val)
        a3(self, ...)
    end))
    return self
end

function u70.unbindEvent(a1, a2) -- Line: 918
    local v1 = a1.bindedEvents[a2]
    if v1 then
        v1:Disconnect()
        a1.bindedEvents[a2] = nil
    end
    return a1
end

function u70.bindToggleKey(a1, a2) -- Line: 927
    assert(typeof(a2) == "EnumItem", "argument[1] must be a KeyCode EnumItem!")
    a1.bindedToggleKeys[a2] = true
    a1.toggleKeyAdded:Fire(a2)
    a1:setCaption("_hotkey_")
    return a1
end

function u70.unbindToggleKey(a1, a2) -- Line: 935
    assert(typeof(a2) == "EnumItem", "argument[1] must be a KeyCode EnumItem!")
    a1.bindedToggleKeys[a2] = nil
    return a1
end

function u70.call(a1, a2, ...) -- Line: 941
    local u4 = table.pack(...)
    task.spawn(function() -- Line: 943 -- upvalues: a2 (val), a1 (val), u4 (val)
        a2(a1, table.unpack(u4))
    end)
    return a1
end

function u70:addToJanitor(a2, a3, a4) -- Line: 949
    self.janitor:add(a2, a3, a4)
    return self
end

function u70:lock() -- Line: 954
    local v1 = self:getInstance("ClickRegion")
    v1.Visible = false
    self.locked = true
    return self
end

function u70:unlock() -- Line: 962
    local v1 = self:getInstance("ClickRegion")
    v1.Visible = true
    self.locked = false
    return self
end

function u70.debounce(a1, a2) -- Line: 969
    a1:lock()
    task.wait(a2)
    a1:unlock()
    return a1
end

function u70.autoDeselect(a1, a2) -- Line: 976
    if a2 == nil then
        a2 = true
    end
    a1.deselectWhenOtherIconSelected = a2
    return a1
end

function u70.oneClick(a1, a2) -- Line: 986
    local singleClickJanitor = a1.singleClickJanitor
    singleClickJanitor:clean()
    if a2 or a2 == nil then
        singleClickJanitor:add((a1.selected:Connect(function() -- Line: 992 -- upvalues: a1 (val)
            a1:deselect("OneClick", a1)
        end)))
    end
    a1.oneClickEnabled = true
    return a1
end

function u70:setCaption(a2) -- Line: 1000 -- upvalues: Elements (val)
    if a2 == "_hotkey_" and self.captionText then
        return self
    end
    local captionJanitor = self.captionJanitor
    self.captionJanitor:clean()
    if a2 and a2 ~= "" then
        local v1 = captionJanitor:add((require(Elements.Caption)(self)))
        v1:SetAttribute("CaptionText", a2)
        self.caption = v1
        self.captionText = a2
        return self
    end
    self.caption = nil
    self.captionText = nil
    return self
end

function u70.setCaptionHint(a1, a2) -- Line: 1018
    assert(typeof(a2) == "EnumItem", "argument[1] must be a KeyCode EnumItem!")
    a1.fakeToggleKey = a2
    a1.fakeToggleKeyChanged:Fire(a2)
    a1:setCaption("_hotkey_")
    return a1
end

function u70:leave() -- Line: 1026
    self.joinJanitor:clean()
    return self
end

function u70.joinMenu(a1, a2) -- Line: 1032 -- upvalues: u57 (val)
    u57.joinFeature(a1, a2, a2.menuIcons, a2:getInstance("Menu"))
    a2.menuChildAdded:Fire(a1)
    return a1
end

function u70:setMenu(a2) -- Line: 1038
    self.menuSet:Fire(a2)
    return self
end

function u70.setFixedMenu(a1, a2) -- Line: 1043
    a1:freezeMenu(a2)
    a1:setMenu(a2)
end

u70.setFrozenMenu = u70.setFixedMenu

function u70:freezeMenu() -- Line: 1049
    self:select("FrozenMenu", self)
    self:bindEvent("deselected", function(a1) -- Line: 1053 -- upvalues: self (val)
        a1:select("FrozenMenu", self)
    end)
    self:modifyTheme({"IconSpot", "Visible", false})
end

function u70.joinDropdown(a1, a2) -- Line: 1059 -- upvalues: u57 (val)
    a2:getDropdown()
    u57.joinFeature(a1, a2, a2.dropdownIcons, a2:getInstance("DropdownScroller"))
    a2.dropdownChildAdded:Fire(a1)
    return a1
end

function u70:getDropdown() -- Line: 1066 -- upvalues: Elements (val)
    local dropdown = self.dropdown
    if not dropdown then
        dropdown = require(Elements.Dropdown)(self)
        self.dropdown = dropdown
        self:clipOutside(dropdown)
    end
    return dropdown
end

function u70.setDropdown(a1, a2) -- Line: 1076
    a1:getDropdown()
    a1.dropdownSet:Fire(a2)
    return a1
end

function u70:clipOutside(a2) -- Line: 1082 -- upvalues: u57 (val)
    local v1 = u57.clipOutside(self, a2)
    self:refreshAppearance(a2)
    return self, v1
end

function u70.setIndicator(a1, a2) -- Line: 1093 -- upvalues: Elements (val), u70 (val)
    if not a1.indicator then
        a1.indicator = a1.janitor:add((require(Elements.Indicator)(a1, u70)))
    end
    a1.indicatorSet:Fire(a2)
end

function u70.convertLabelToNumberSpinner(a1, a2, a3) -- Line: 1105
    task.defer(function() -- Line: 1106 -- upvalues: a1 (val), a2 (val), a3 (val)
        local u4 = a1:getInstance("IconLabel")
        u4.Transparency = 1
        a2.Parent = u4.Parent
        a2.Size = UDim2.fromScale(1, 1)
        a2.AnchorPoint = Vector2.new(0.5, 0.5)
        a2.Position = UDim2.new(0.5, 0, 0.5, 0)
        a2.TextXAlignment = Enum.TextXAlignment.Center
        a2.ClipsDescendants = false
        for i, v in ipairs({
            "FontFace",
            "BorderSizePixel",
            "BorderColor3",
            "Rotation",
            "TextStrokeTransparency",
            "TextStrokeColor3",
            "TextStrokeTransparency",
            "TextColor3",
        }) do
            a2[v] = u4[v]
            a1:addToJanitor(((u4:GetPropertyChangedSignal(v)):Connect(function() -- Line: 1129 -- upvalues: a2 (upval), v (val), u4 (val)
                a2[v] = u4[v]
            end)))
        end

        local function getSpinnerSizeAndDigitCount() -- Line: 1136 -- upvalues: a2 (upval)
            local v1
            local v2 = 0
            local v3 = 0
            for i, j in a2.Frame:GetChildren() do
                v1 = string.lower(j.Name)
                if v1 == "digit" then
                    v2 = v2 + j.AbsoluteSize.X
                    v3 = v3 + 1
                elseif v1 == "prefix" or v1 == "suffix" then
                    if j.Text ~= "" then
                        v2 = v2 + j.AbsoluteSize.X
                        v3 = v3 + 1
                    end
                elseif v1 == "comma" and j.Text ~= "" then
                    v2 = v2 + j.AbsoluteSize.X
                    v3 = v3 + 1
                end
            end
            return v2, v3
        end

        local function getLabelParentContainerXSize() -- Line: 1154 -- upvalues: u4 (val), a2 (upval)
            local Parent = u4.Parent
            local Parent_2 = Parent and Parent.Parent
            if Parent_2 == nil then
                return 0
            end
            if Parent_2.IconImage.Visible == true then
                return a2.Frame.AbsoluteSize.X + u4.Parent.Parent.IconImage.AbsoluteSize.X
            end
            return Parent_2.AbsoluteSize.X
        end

        local function getNumberSpinnerXSize() -- Line: 1166 -- upvalues: a2 (upval)
            return a2.Frame.AbsoluteSize.X
        end

        local function adjustSize() -- Line: 1170
            -- upvalues: getSpinnerSizeAndDigitCount (val), a1 (upval), a2 (upval), u4 (val)
            local Parent_3, Parent_4, v1, v2
            local v3, v4 = getSpinnerSizeAndDigitCount()
            if v4 < 18 then
                a1:setLabel(a2.Value)
            end
            local X = a2.Frame.AbsoluteSize.X
            while v3 < X do
                if a1.isDestroyed == true then
                    break
                end
                task.wait(0.05)
                if v4 > 0 and v4 < 8 then
                    a2.TextSize = u4.TextSize
                    break
                end
                v1 = a2
                v1.TextSize = v1.TextSize + 1
                X = a2.Frame.AbsoluteSize.X
                v1, v2 = getSpinnerSizeAndDigitCount()
                v3 = v1
                v4 = v2
            end
            local Parent = u4.Parent
            local Parent_2 = Parent and Parent.Parent
            local X_2 = if Parent_2 ~= nil then if Parent_2.IconImage.Visible ~= true then Parent_2.AbsoluteSize.X else a2.Frame.AbsoluteSize.X + u4.Parent.Parent.IconImage.AbsoluteSize.X else 0
            while X_2 < v3 do
                if a1.isDestroyed == true then
                    break
                end
                task.wait(0.05)
                if v4 < 8 and v4 > 0 then
                    a2.TextSize = u4.TextSize
                    return
                end
                v1 = a2
                v1.TextSize = v1.TextSize - 1
                Parent_3 = u4.Parent
                Parent_4 = Parent_3 and Parent_3.Parent
                X_2 = if Parent_4 ~= nil then if Parent_4.IconImage.Visible ~= true then Parent_4.AbsoluteSize.X else a2.Frame.AbsoluteSize.X + u4.Parent.Parent.IconImage.AbsoluteSize.X else 0
                v1, v2 = getSpinnerSizeAndDigitCount()
                v3 = v1
            end
        end

        a1:addToJanitor((a2.Frame.ChildAdded:Connect(adjustSize)))
        a1:addToJanitor((a2.Frame.ChildRemoved:Connect(adjustSize)))
        a1:addToJanitor((a1.iconAdded:Connect(function() -- Line: 1208 -- upvalues: adjustSize (val)
            task.wait(1)
            adjustSize()
        end)))
        a1:updateParent()
        a2.Name = "LabelSpinner"
        a2.Prefix = "$"
        a2.Commas = true
        a2.Decimals = 0
        a2.Duration = 0.25
        a2.Value = 10
        task.wait(0.2)
        if typeof(a3) == "function" then
            a3()
        end
    end)
    return a1
end

function u70:destroy() -- Line: 1235 -- upvalues: u70 (val)
    if self.isDestroyed then
        return
    end
    self:clearNotices()
    if self.parentIconUID then
        self:leave()
    end
    self.isDestroyed = true
    self.janitor:clean()
    u70.iconRemoved:Fire(self)
end

u70.Destroy = u70.destroy
return u70