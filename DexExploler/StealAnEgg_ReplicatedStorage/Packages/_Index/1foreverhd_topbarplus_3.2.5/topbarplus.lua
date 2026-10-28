-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.2.5.topbarplus
-- Decompile time: 32.12 ms

local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
require(script.Types)
local u19 = script
local Reference = require(u19.Reference)
local v1 = Reference.getObject()
local Value = v1 and v1.Value
if Value and Value ~= u19 then
    return (require(Value))
end
if not v1 then
    Reference.addToReplicatedStorage()
end
local GoodSignal = require(u19.Packages.GoodSignal)
local u48 = require(u19.Packages.Janitor)
local u52 = require(u19.Utility)
local Themes = require(u19.Features.Themes)
local Gamepad = require(u19.Features.Gamepad)
local Overflow = require(u19.Features.Overflow)
local u65 = {}
u65.__index = u65
local LocalPlayer = Players.LocalPlayer
local Themes_2 = u19.Features.Themes
local u72 = {}
local u74 = GoodSignal.new()
local Elements = u19.Elements
local u76 = 0
u65.baseDisplayOrderChanged = GoodSignal.new()
u65.baseDisplayOrder = 10
u65.baseTheme = require(Themes_2.Default)
u65.isOldTopbar = false
u65.iconsDictionary = u72
u65.insetHeightChanged = GoodSignal.new()
u65.container = require(Elements.Container)(u65)
u65.topbarEnabled = true
u65.iconAdded = GoodSignal.new()
u65.iconRemoved = GoodSignal.new()
u65.iconChanged = GoodSignal.new()

function u65.getIcons() -- Line: 90 -- upvalues: u65 (val)
    return u65.iconsDictionary
end

function u65.getIconByUID(a1) -- Line: 94 -- upvalues: u65 (val)
    local v1 = u65.iconsDictionary[a1]
    if v1 then
        return v1
    end
    return nil
end

function u65.getIcon(a1) -- Line: 102 -- upvalues: u65 (val), u72 (val)
    local v1 = u65.getIconByUID(a1)
    if v1 then
        return v1
    end
    for k, v in pairs(u72) do
        if v.name == a1 then
            return v
        end
    end
    return nil
end

function u65.setTopbarEnabled(a1, a2) -- Line: 115 -- upvalues: u65 (val)
    if typeof(a1) ~= "boolean" then
        a1 = u65.topbarEnabled
    end
    if not a2 then
        u65.topbarEnabled = a1
    end
    for k, v in pairs(u65.container) do
        v.Enabled = a1
    end
end

function u65.modifyBaseTheme(a1) -- Line: 127 -- upvalues: Themes (val), u65 (val), u72 (val)
    local baseTheme
    for k, v in pairs((Themes.getModifications(a1))) do
        for k2, i in pairs(u65.baseTheme) do
            Themes.merge(i, v)
        end
    end
    for k3, j in pairs(u72) do
        baseTheme = u65.baseTheme
        j:setTheme(baseTheme)
    end
end

function u65.setDisplayOrder(a1) -- Line: 139 -- upvalues: u65 (val)
    u65.baseDisplayOrder = a1
    u65.baseDisplayOrderChanged:Fire(a1)
end

task.defer(Gamepad.start, u65)
task.defer(Overflow.start, u65)
task.defer(function() -- Line: 147 -- upvalues: LocalPlayer (val), u65 (val), u19 (val)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    for k, v in pairs(u65.container) do
        v.Parent = PlayerGui
    end
    require(u19.Attribute)
end)

function u65.new() -- Line: 156
    -- upvalues: u65 (val), u48 (val), u52 (val), u72 (val), GoodSignal (val), u19 (val), Elements (val), u76 (ref)
    -- upvalues: UserInputService (val), u74 (val), StarterGui (val)
    local u0 = {}
    local v1 = u65
    setmetatable(u0, v1)
    local v2 = u48.new()
    u0.janitor = v2
    u0.themesJanitor = v2:add((u48.new()))
    u0.singleClickJanitor = v2:add((u48.new()))
    u0.captionJanitor = v2:add((u48.new()))
    u0.joinJanitor = v2:add((u48.new()))
    u0.menuJanitor = v2:add((u48.new()))
    u0.dropdownJanitor = v2:add((u48.new()))
    local u46 = u52.generateUID()
    u72[u46] = u0
    v2:add(function() -- Line: 173 -- upvalues: u72 (upval), u46 (val)
        u72[u46] = nil
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
    u0.iconModule = u19
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
    u0.widget = v2:add((require(Elements.Widget)(u0, u65)))
    u0:setAlignment()
    u76 = u76 + 1
    v1 = u76 * 0.01 + 1
    u0:setOrder(v1, "deselected")
    u0:setOrder(v1, "selected")
    u0:setTheme(u65.baseTheme)
    v1 = u0:getInstance("ClickRegion")

    local function handleToggle() -- Line: 249 -- upvalues: u0 (val)
        if u0.locked then
            return
        end
        if u0.isSelected then
            u0:deselect("User", u0)
            return
        end
        u0:select("User", u0)
    end

    local u261 = false
    local u262 = false
    v1.MouseButton1Click:Connect(function() -- Line: 261 -- upvalues: u261 (ref), u262 (ref), u0 (val)
        if u261 then
            return
        end
        u262 = true
        task.delay(0.01, function() -- Line: 266 -- upvalues: u262 (upval)
            u262 = false
        end)
        if u0.locked then
            return
        end
        if u0.isSelected then
            u0:deselect("User", u0)
            return
        end
        u0:select("User", u0)
    end)
    v1.TouchTap:Connect(function() -- Line: 271 -- upvalues: u262 (ref), u261 (ref), u0 (val)
        if u262 then
            return
        end
        u261 = true
        task.delay(0.01, function() -- Line: 278 -- upvalues: u261 (upval)
            u261 = false
        end)
        if u0.locked then
            return
        end
        if u0.isSelected then
            u0:deselect("User", u0)
            return
        end
        u0:select("User", u0)
    end)
    v2:add((UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 285 -- upvalues: u0 (val)
        if u0.locked then
            return
        end
        if u0.bindedToggleKeys[a1.KeyCode] and not a2 then
            if u0.locked then
                return
            end
            if u0.isSelected then
                u0:deselect("User", u0)
                return
            end
            u0:select("User", u0)
        end
    end)))

    local function viewingEnded() -- Line: 307 -- upvalues: u0 (val)
        if u0.locked then
            return
        end
        u0.isViewing = false
        u0.viewingEnded:Fire(true)
        u0:setState(nil, "User", u0)
    end

    u0.joinedParent:Connect(function() -- Line: 315 -- upvalues: u0 (val)
        if u0.isViewing then
            if u0.locked then
                return
            end
            u0.isViewing = false
            u0.viewingEnded:Fire(true)
            u0:setState(nil, "User", u0)
        end
    end)
    v1.MouseEnter:Connect(function() -- Line: 320 -- upvalues: UserInputService (upval), u0 (val)
        local v1 = not UserInputService.KeyboardEnabled
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
    v1.SelectionGained:Connect(function(a1) -- Line: 297 -- upvalues: u0 (val)
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
    v1.MouseButton1Down:Connect(function() -- Line: 329 -- upvalues: u0 (val), UserInputService (upval), u294 (ref)
        if not u0.locked and UserInputService.TouchEnabled then
            u294 = u294 + 1
            local u6 = u294
            task.delay(0.2, function() -- Line: 333 -- upvalues: u6 (val), u294 (upval), u0 (upval)
                if u6 == u294 then
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
    v1.MouseButton1Up:Connect(function() -- Line: 340 -- upvalues: u294 (ref)
        u294 = u294 + 1
    end)
    local u333 = u0:getInstance("IconOverlay")
    u0.viewingStarted:Connect(function() -- Line: 346 -- upvalues: u333 (val), u0 (val)
        u333.Visible = not u0.overlayDisabled
    end)
    u0.viewingEnded:Connect(function() -- Line: 349 -- upvalues: u333 (val)
        u333.Visible = false
    end)
    v2:add((u74:Connect(function(a1) -- Line: 354 -- upvalues: u0 (val)
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
        u52.localPlayerRespawned(function() -- Line: 383 -- upvalues: u0 (val)
            u0:destroy()
        end)
    end
    u0.toggled:Connect(function(a1) -- Line: 389 -- upvalues: u0 (val), u65 (upval)
        local v1
        u0.noticeChanged:Fire(u0.totalNotices)
        for k, v in pairs(u0.childIconsDict) do
            v1 = u65.getIconByUID(k)
            v1.noticeChanged:Fire(v1.totalNotices)
            if not a1 and v1.isSelected then
                for k2, i in pairs(v1.childIconsDict) do
                    v1:deselect("HideParentFeature", u0)
                end
            end
        end
    end)
    u0.selected:Connect(function() -- Line: 412 -- upvalues: u0 (val), StarterGui (upval)
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
    u0.deselected:Connect(function() -- Line: 425 -- upvalues: u0 (val), StarterGui (upval)
        if u0.chatWasPreviouslyActive then
            u0.chatWasPreviouslyActive = nil
            StarterGui:SetCore("ChatActive", true)
        end
        if u0.playerlistWasPreviouslyActive then
            u0.playerlistWasPreviouslyActive = nil
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
        end
    end)
    task.delay(0.1, function() -- Line: 439 -- upvalues: u0 (val)
        if u0.activeState == "Deselected" then
            u0.stateChanged:Fire("Deselected")
            u0:refresh()
        end
    end)
    u65.iconAdded:Fire(u0)
    return u0
end

function u65.setName(a1, a2) -- Line: 453
    a1.widget.Name = a2
    a1.name = a2
    return a1
end

function u65:setState(a2, a3, a4) -- Line: 459 -- upvalues: u52 (val), u74 (val)
    if not a2 then
        a2 = if not self.isSelected then "Deselected" else "Selected"
    end
    local v1 = u52.formatStateName(a2)
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
            u74:Fire(self, a3, a4)
        end
        self:_setToggleItemsVisible(true, a3, a4)
    end
    self.stateChanged:Fire(v1, a3, a4)
end

function u65:getInstance(a2) -- Line: 492 -- upvalues: Themes (val)
    local scanChildren
    local v1 = self.cachedNamesToInstances[a2]
    if v1 then
        return v1
    end

    local function cacheInstance(a1, a2) -- Line: 500 -- upvalues: self (val)
        if not self.cachedInstances[a2] then
            local Attribute = a2:GetAttribute("Collective")
            local v1 = Attribute and self.cachedCollectives[Attribute]
            if v1 then
                table.insert(v1, a2)
            end
            self.cachedNamesToInstances[a1] = a2
            self.cachedInstances[a2] = true
            a2.Destroying:Once(function() -- Line: 510 -- upvalues: self (upval), a1 (val), a2 (val)
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

    function scanChildren(a1) -- Line: 523
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

function u65:getCollective(a2) -- Line: 552
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

function u65:getInstanceOrCollective(a2) -- Line: 573
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

function u65.getStateGroup(a1, a2) -- Line: 587
    local activeState = a2 or a1.activeState
    local v1 = a1.appearance[activeState]
    if not v1 then
        a1.appearance[activeState] = {}
    end
    return v1
end

function u65.refreshAppearance(a1, a2, a3) -- Line: 597 -- upvalues: Themes (val)
    Themes.refresh(a1, a2, a3)
    return a1
end

function u65:refresh() -- Line: 602
    self:refreshAppearance(self.widget)
    self.updateSize:Fire()
    return self
end

function u65:updateParent() -- Line: 608 -- upvalues: u65 (val)
    local v1 = u65.getIconByUID(self.parentIconUID)
    if v1 then
        v1.updateSize:Fire()
    end
end

function u65.setBehaviour(a1, a2, a3, a4, a5) -- Line: 615
    local v1 = a2 .. "-" .. a3
    a1.customBehaviours[v1] = a4
    if a5 then
        for k, v in pairs((a1:getInstanceOrCollective(a2))) do
            a1:refreshAppearance(v, a3)
        end
    end
end

function u65.modifyTheme(a1, a2, a3) -- Line: 628 -- upvalues: Themes (val)
    return a1, (Themes.modify(a1, a2, a3))
end

function u65.modifyChildTheme(a1, a2, a3) -- Line: 633 -- upvalues: u65 (val)
    a1.childModifications = a2
    a1.childModificationsUID = a3
    for k, v in pairs(a1.childIconsDict) do
        u65.getIconByUID(k):modifyTheme(a2, a3)
    end
    a1.childThemeModified:Fire()
    return a1
end

function u65.removeModification(a1, a2) -- Line: 646 -- upvalues: Themes (val)
    Themes.remove(a1, a2)
    return a1
end

function u65.removeModificationWith(a1, a2, a3, a4) -- Line: 651 -- upvalues: Themes (val)
    Themes.removeWith(a1, a2, a3, a4)
    return a1
end

function u65.setTheme(a1, a2) -- Line: 656 -- upvalues: Themes (val)
    Themes.set(a1, a2)
    return a1
end

function u65.setEnabled(a1, a2) -- Line: 661
    a1.isEnabled = a2
    a1.enabled = a1.isEnabled
    a1.widget.Visible = a2
    a1:updateParent()
    return a1
end

function u65:select(a2, a3) -- Line: 669
    self:setState("Selected", a2, a3)
    return self
end

function u65:deselect(a2, a3) -- Line: 674
    self:setState("Deselected", a2, a3)
    return self
end

function u65.notify(a1, a2, a3) -- Line: 679 -- upvalues: Elements (val), u65 (val)
    if not a1.notice then
        a1.notice = require(Elements.Notice)(a1, u65)
    end
    a1.noticeStarted:Fire(a2, a3)
    return a1
end

function u65:clearNotices() -- Line: 693
    self.endNotices:Fire()
    return self
end

function u65.disableOverlay(a1, a2) -- Line: 698
    a1.overlayDisabled = a2
    return a1
end

u65.disableStateOverlay = u65.disableOverlay

function u65.setImage(a1, a2, a3) -- Line: 704
    a1:modifyTheme({"IconImage", "Image", a2, a3})
    return a1
end

function u65:setLabel(a2, a3) -- Line: 709
    self:modifyTheme({"IconLabel", "Text", a2, a3})
    return self
end

function u65:setOrder(a2, a3) -- Line: 714
    local v1 = a2 * 100
    self:modifyTheme({"IconSpot", "LayoutOrder", v1, a3})
    self:modifyTheme({"Widget", "LayoutOrder", v1, a3})
    return self
end

function u65.setCornerRadius(a1, a2, a3) -- Line: 723
    a1:modifyTheme({"IconCorners", "CornerRadius", a2, a3})
    return a1
end

function u65.align(a1, a2, a3) -- Line: 728 -- upvalues: u65 (val)
    local v1 = tostring(a2):lower()
    if v1 == "mid" or v1 == "centre" then
        v1 = "center"
    end
    if v1 ~= "left" and v1 ~= "center" and v1 ~= "right" then
        v1 = "left"
    end
    local TopbarCentered = not (v1 ~= "center") and u65.container.TopbarCentered or u65.container.TopbarStandard
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
    u65.iconChanged:Fire(a1)
    return a1
end

u65.setAlignment = u65.align

function u65.setLeft(a1) -- Line: 757
    a1:setAlignment("Left")
    return a1
end

function u65.setMid(a1) -- Line: 762
    a1:setAlignment("Center")
    return a1
end

function u65.setRight(a1) -- Line: 767
    a1:setAlignment("Right")
    return a1
end

function u65.setWidth(a1, a2, a3) -- Line: 772
    a1:modifyTheme({"Widget", "DesiredWidth", a2, a3})
    return a1
end

function u65.setImageScale(a1, a2, a3) -- Line: 780
    a1:modifyTheme({"IconImageScale", "Value", a2, a3})
    return a1
end

function u65.setImageRatio(a1, a2, a3) -- Line: 785
    a1:modifyTheme({"IconImageRatio", "AspectRatio", a2, a3})
    return a1
end

function u65.setTextSize(a1, a2, a3) -- Line: 790
    a1:modifyTheme({"IconLabel", "TextSize", a2, a3})
    return a1
end

function u65.setTextFont(a1, a2, a3, a4, a5) -- Line: 795
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

function u65.bindToggleItem(a1, a2) -- Line: 816
    if not a2:IsA("GuiObject") and not a2:IsA("LayerCollector") then
        error("Toggle item must be a GuiObject or LayerCollector!")
    end
    a1.toggleItems[a2] = true
    a1:_updateSelectionInstances()
    return a1
end

function u65.unbindToggleItem(a1, a2) -- Line: 825
    a1.toggleItems[a2] = nil
    a1:_updateSelectionInstances()
    return a1
end

function u65:_updateSelectionInstances() -- Line: 831
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

function u65:_setToggleItemsVisible(a2, a3, a4) -- Line: 845
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

function u65:bindEvent(a2, a3) -- Line: 857
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
    self.bindedEvents[a2] = (v1:Connect(function(...) -- Line: 864 -- upvalues: a3 (val), self (val)
        a3(self, ...)
    end))
    return self
end

function u65.unbindEvent(a1, a2) -- Line: 870
    local v1 = a1.bindedEvents[a2]
    if v1 then
        v1:Disconnect()
        a1.bindedEvents[a2] = nil
    end
    return a1
end

function u65.bindToggleKey(a1, a2) -- Line: 879
    assert(typeof(a2) == "EnumItem", "argument[1] must be a KeyCode EnumItem!")
    a1.bindedToggleKeys[a2] = true
    a1.toggleKeyAdded:Fire(a2)
    a1:setCaption("_hotkey_")
    return a1
end

function u65.unbindToggleKey(a1, a2) -- Line: 887
    assert(typeof(a2) == "EnumItem", "argument[1] must be a KeyCode EnumItem!")
    a1.bindedToggleKeys[a2] = nil
    return a1
end

function u65.call(a1, a2, ...) -- Line: 893
    local u4 = table.pack(...)
    task.spawn(function() -- Line: 895 -- upvalues: a2 (val), a1 (val), u4 (val)
        a2(a1, table.unpack(u4))
    end)
    return a1
end

function u65:addToJanitor(a2, a3, a4) -- Line: 901
    self.janitor:add(a2, a3, a4)
    return self
end

function u65:lock() -- Line: 906
    local v1 = self:getInstance("ClickRegion")
    v1.Visible = false
    self.locked = true
    return self
end

function u65:unlock() -- Line: 914
    local v1 = self:getInstance("ClickRegion")
    v1.Visible = true
    self.locked = false
    return self
end

function u65.debounce(a1, a2) -- Line: 921
    a1:lock()
    task.wait(a2)
    a1:unlock()
    return a1
end

function u65.autoDeselect(a1, a2) -- Line: 928
    if a2 == nil then
        a2 = true
    end
    a1.deselectWhenOtherIconSelected = a2
    return a1
end

function u65.oneClick(a1, a2) -- Line: 938
    local singleClickJanitor = a1.singleClickJanitor
    singleClickJanitor:clean()
    if a2 or a2 == nil then
        singleClickJanitor:add((a1.selected:Connect(function() -- Line: 944 -- upvalues: a1 (val)
            a1:deselect("OneClick", a1)
        end)))
    end
    a1.oneClickEnabled = true
    return a1
end

function u65:setCaption(a2) -- Line: 952 -- upvalues: Elements (val)
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

function u65.setCaptionHint(a1, a2) -- Line: 970
    assert(typeof(a2) == "EnumItem", "argument[1] must be a KeyCode EnumItem!")
    a1.fakeToggleKey = a2
    a1.fakeToggleKeyChanged:Fire(a2)
    a1:setCaption("_hotkey_")
    return a1
end

function u65:leave() -- Line: 978
    self.joinJanitor:clean()
    return self
end

function u65.joinMenu(a1, a2) -- Line: 984 -- upvalues: u52 (val)
    u52.joinFeature(a1, a2, a2.menuIcons, a2:getInstance("Menu"))
    a2.menuChildAdded:Fire(a1)
    return a1
end

function u65:setMenu(a2) -- Line: 990
    self.menuSet:Fire(a2)
    return self
end

function u65.setFrozenMenu(a1, a2) -- Line: 995
    a1:freezeMenu(a2)
    a1:setMenu(a2)
end

function u65:freezeMenu() -- Line: 1000
    self:select("FrozenMenu", self)
    self:bindEvent("deselected", function(a1) -- Line: 1004 -- upvalues: self (val)
        a1:select("FrozenMenu", self)
    end)
    self:modifyTheme({"IconSpot", "Visible", false})
end

function u65.joinDropdown(a1, a2) -- Line: 1010 -- upvalues: u52 (val)
    a2:getDropdown()
    u52.joinFeature(a1, a2, a2.dropdownIcons, a2:getInstance("DropdownScroller"))
    a2.dropdownChildAdded:Fire(a1)
    return a1
end

function u65:getDropdown() -- Line: 1017 -- upvalues: Elements (val)
    local dropdown = self.dropdown
    if not dropdown then
        dropdown = require(Elements.Dropdown)(self)
        self.dropdown = dropdown
        self:clipOutside(dropdown)
    end
    return dropdown
end

function u65.setDropdown(a1, a2) -- Line: 1027
    a1:getDropdown()
    a1.dropdownSet:Fire(a2)
    return a1
end

function u65:clipOutside(a2) -- Line: 1033 -- upvalues: u52 (val)
    local v1 = u52.clipOutside(self, a2)
    self:refreshAppearance(a2)
    return self, v1
end

function u65.setIndicator(a1, a2) -- Line: 1044 -- upvalues: Elements (val), u65 (val)
    if not a1.indicator then
        a1.indicator = a1.janitor:add((require(Elements.Indicator)(a1, u65)))
    end
    a1.indicatorSet:Fire(a2)
end

function u65.convertLabelToNumberSpinner(a1, a2) -- Line: 1056
    local u5 = a1:getInstance("IconLabel")
    u5.Transparency = 1
    a2.Parent = u5.Parent
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
        a2[v] = u5[v]
        a1:addToJanitor(((u5:GetPropertyChangedSignal(v)):Connect(function() -- Line: 1078 -- upvalues: a2 (val), v (val), u5 (val)
            a2[v] = u5[v]
        end)))
    end

    local function getSpinnerSizeAndDigitCount() -- Line: 1085 -- upvalues: a2 (val)
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

    local function getLabelParentContainerXSize() -- Line: 1103 -- upvalues: u5 (val), a2 (val)
        local Parent = u5.Parent.Parent
        if Parent == nil then
            return 0
        end
        if Parent.IconImage.Visible == true then
            return a2.Frame.AbsoluteSize.X + u5.Parent.Parent.IconImage.AbsoluteSize.X
        end
        return Parent.AbsoluteSize.X
    end

    local function getNumberSpinnerXSize() -- Line: 1114 -- upvalues: a2 (val)
        return a2.Frame.AbsoluteSize.X
    end

    local function adjustSize() -- Line: 1118
        -- upvalues: getSpinnerSizeAndDigitCount (val), a1 (val), a2 (val), u5 (val)
        local Parent_2, v1, v2
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
                a2.TextSize = u5.TextSize
                break
            end
            v1 = a2
            v1.TextSize = v1.TextSize + 1
            X = a2.Frame.AbsoluteSize.X
            v1, v2 = getSpinnerSizeAndDigitCount()
            v3 = v1
            v4 = v2
        end
        local Parent = u5.Parent.Parent
        local X_2 = if Parent ~= nil then if Parent.IconImage.Visible ~= true then Parent.AbsoluteSize.X else a2.Frame.AbsoluteSize.X + u5.Parent.Parent.IconImage.AbsoluteSize.X else 0
        while X_2 < v3 do
            if a1.isDestroyed == true then
                break
            end
            task.wait(0.05)
            if v4 < 8 and v4 > 0 then
                a2.TextSize = u5.TextSize
                return
            end
            v1 = a2
            v1.TextSize = v1.TextSize - 1
            Parent_2 = u5.Parent.Parent
            X_2 = if Parent_2 ~= nil then if Parent_2.IconImage.Visible ~= true then Parent_2.AbsoluteSize.X else a2.Frame.AbsoluteSize.X + u5.Parent.Parent.IconImage.AbsoluteSize.X else 0
            v1, v2 = getSpinnerSizeAndDigitCount()
            v3 = v1
        end
    end

    a1:addToJanitor((a2.Frame.ChildAdded:Connect(adjustSize)))
    a1:addToJanitor((a2.Frame.ChildRemoved:Connect(adjustSize)))
    a1:addToJanitor((a1.iconAdded:Connect(function() -- Line: 1156 -- upvalues: adjustSize (val)
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
    return a1
end

function u65:destroy() -- Line: 1176 -- upvalues: u65 (val)
    if self.isDestroyed then
        return
    end
    self:clearNotices()
    if self.parentIconUID then
        self:leave()
    end
    self.isDestroyed = true
    self.janitor:clean()
    u65.iconRemoved:Fire(self)
end

u65.Destroy = u65.destroy
return u65