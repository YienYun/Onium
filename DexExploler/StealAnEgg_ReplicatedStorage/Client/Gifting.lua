-- Script path: ReplicatedStorage.Client.Gifting
-- Decompile time: 17.87 ms

local GuiService = game:GetService("GuiService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local CashPacks = require(ReplicatedStorage.Data.CashPacks)
local SpeedPacks = require(ReplicatedStorage.Data.SpeedPacks)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local Gamepasses = require(ReplicatedStorage.Data.Gamepasses)
local GiftProductsMapping = require(ReplicatedStorage.Data.GiftProductsMapping)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u83 = GUI.Shop()
local Frame = u83:WaitForChild("Frame")
local GiftingPopUp = u83:WaitForChild("GiftingPopUp")
local ScrollingFrame = GiftingPopUp:WaitForChild("ScrollingFrame")
local PlayerTemplate = ScrollingFrame:WaitForChild("PlayerTemplate")
local PendingPurchase = LocalPlayer.PlayerGui:WaitForChild("PendingPurchase")
local PendingPurchaseHandler = require(PendingPurchase:WaitForChild("PendingPurchaseHandler"))
local u115 = require(ReplicatedStorage.Client.MenuNavigation)
local u116 = {}
local u117 = nil
local u118 = nil
local u119 = {}
local u124 = GiftingPopUp.Header.Title:Clone()
u124.Name = "CashPackNotice"
u124.Text = "Cash gifts use the receiver's pack value.\nIt may differ from yours."
u124.AnchorPoint = Vector2.new(0.5, 0)
u124.Size = UDim2.fromScale(0.92, 0.12)
u124.BackgroundTransparency = 1
u124.TextWrapped = true
u124.TextScaled = true
u124.TextXAlignment = Enum.TextXAlignment.Center
u124.TextYAlignment = Enum.TextYAlignment.Center
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
UITextSizeConstraint.MinTextSize = 1
UITextSizeConstraint.MaxTextSize = 28
UITextSizeConstraint.Parent = u124
local UIStroke = u124:FindFirstChildOfClass("UIStroke")
if UIStroke then
    UIStroke.Thickness = 0.06
end
u124.Visible = false
u124.Parent = GiftingPopUp
local Position = ScrollingFrame.Position
local Size = ScrollingFrame.Size
local u166 = UDim2.new(Size.X.Scale, Size.X.Offset, Size.Y.Scale - 0.15, Size.Y.Offset)
u124.Position = UDim2.fromScale(0.5, Position.Y.Scale - Size.Y.Scale * ScrollingFrame.AnchorPoint.Y + 0.01)
local Text = GiftingPopUp.Header.Title.Text
GiftingPopUp.Visible = false
for i, j in ScrollingFrame:GetChildren() do
    if j.Name == "PlayerTemplate" and j:IsA("GuiObject") then
        j.Visible = false
    end
end

local function notify(a1) -- Line: 68 -- upvalues: Toast (val) -- types: a1: string
    Toast.Show({Seconds = 5, Text = a1})
end

local function closePicker(a1) -- Line: 72
    -- upvalues: u117 (ref), u115 (val), GiftingPopUp (val), u124 (val), ScrollingFrame (val), Position (val)
    -- upvalues: Size (val), Text (val), Frame (val), GuiService (val), Tabs (val)
    local v1 = u117
    u117 = nil
    u115.SetOverride("Gifting", nil)
    GiftingPopUp.Visible = false
    u124.Visible = false
    ScrollingFrame.Position = Position
    ScrollingFrame.Size = Size
    GiftingPopUp.Header.Title.Text = Text
    Frame.Visible = true
    if v1 then
        v1.trove:Destroy()
    end
    if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(GiftingPopUp) then
        GuiService.SelectedObject = nil
    end
    if a1 ~= false and v1 and v1.sourceTab and v1.sourceTab ~= "Shop" and Tabs.IsActive("Shop") then
        Tabs.Activate(v1.sourceTab)
    end
end

local function stopOverlay(a1) -- Line: 99
    if a1.cleanup then
        a1.cleanup()
        a1.cleanup = nil
    end
end

local function finish(a1) -- Line: 106 -- upvalues: u118 (ref)
    if a1.cleanup then
        a1.cleanup()
        a1.cleanup = nil
    end
    if u118 == a1 then
        u118 = nil
    end
end

local function selectPlayer(a1, a2) -- Line: 113
    -- upvalues: u117 (ref), u118 (ref), Players (val), Toast (val), GameFlags (val), CashPacks (val), SpeedPacks (val)
    -- upvalues: HttpService (val), PendingPurchaseHandler (val), Remotes (val), closePicker (val)
    if u117 == a1 and not u118 then
        if a2.Parent ~= Players then
            Toast.Show({Text = "That player has left the server.", Seconds = 5})
            return
        end
        if not GameFlags.StorefrontOpen:Get() then
            Toast.Show({Text = "Purchases are temporarily disabled.", Seconds = 5})
            return
        end
        if a1.cashSlot and CashPacks.GetShownAmount(a2, a1.cashSlot) == nil then
            Toast.Show({Text = "That player's cash packs are still loading. Please try again.", Seconds = 5})
            return
        end
        if a1.speedSlot and SpeedPacks.GetShownAmount(a2, a1.speedSlot) == nil then
            Toast.Show({Text = "That player's speed packs are still loading. Please try again.", Seconds = 5})
            return
        end
        local u41 = {productId = a1.productId}
        u41.token = HttpService:GenerateGUID(false)
        u41.cleanup = PendingPurchaseHandler.observePendingPurchase()
        u118 = u41
        task.delay(60, function() -- Line: 140 -- upvalues: u118 (upval), u41 (val), Toast (upval)
            if u118 == u41 then
                local v1 = u41
                if v1.cleanup then
                    v1.cleanup()
                    v1.cleanup = nil
                end
                if u118 == v1 then
                    u118 = nil
                end
                Toast.Show({
                    Text = "Your gift is still awaiting confirmation. Delivery may be delayed; please check before trying again.",
                    Seconds = 5,
                })
            end
        end)
        local success, err, v1 = pcall(function() -- Line: 150 -- upvalues: Remotes (upval), a2 (val), a1 (val), u41 (val), SpeedPacks (upval)
            local AskGift = Remotes.Gifting.AskGift
            local UserId = a2.UserId
            local kind = a1.kind
            local itemId = a1.itemId
            local token = u41.token
            return AskGift:InvokeServer(
                UserId,
                kind,
                itemId,
                token,
                if not a1.speedSlot then nil else a2:GetAttribute(SpeedPacks.RevisionAttribute)
            )
        end)
        if u118 ~= u41 then
            return
        end
        if success and err then
            closePicker()
            return
        end
        if u41.cleanup then
            u41.cleanup()
            u41.cleanup = nil
        end
        if u118 == u41 then
            u118 = nil
        end
        local v2 = if not success then "Could not start this gift. Please try again." else if type(v1) ~= "string" then "Could not start this gift. Please try again." else v1
        Toast.Show({Seconds = 5, Text = v2})
        return
    end
end

function u116.Open(a1, a2) -- Line: 171
    -- upvalues: u118 (ref), Toast (val), Gamepasses (val), GiftProductsMapping (val), u117 (ref), Tabs (val)
    -- upvalues: u115 (val), GiftingPopUp (val), u124 (val), ScrollingFrame (val), Position (val), Size (val)
    -- upvalues: Text (val), Frame (val), GuiService (val), Trove (val), SpeedPacks (val), CashPacks (val), u166 (val)
    -- upvalues: closePicker (val), PlatformController (val), LocalPlayer (val), PlayerTemplate (val), Simple (val)
    -- upvalues: ButtonFX (val), selectPlayer (val), Players (val)
    if u118 then
        Toast.Show({Text = "Finish your current gift purchase first.", Seconds = 5})
        return
    end
    local v1 = a2
    if a1 == "Gamepass" then
        local v2 = Gamepasses.FromProductId(a2)
        v1 = v2 and GiftProductsMapping[v2.Name] or 0
    end
    if v1 <= 0 then
        Toast.Show({Text = "Gifting is not available for this item yet.", Seconds = 5})
        return
    end
    local sourceTab = if not u117 then Tabs.Active() else u117.sourceTab
    local v3 = u117
    u117 = nil
    u115.SetOverride("Gifting", nil)
    GiftingPopUp.Visible = false
    u124.Visible = false
    ScrollingFrame.Position = Position
    ScrollingFrame.Size = Size
    GiftingPopUp.Header.Title.Text = Text
    Frame.Visible = true
    if v3 then
        v3.trove:Destroy()
    end
    if GuiService.SelectedObject then
        local v4 = GiftingPopUp
        if GuiService.SelectedObject:IsDescendantOf(v4) then
            GuiService.SelectedObject = nil
        end
    end
    Tabs.Activate("Shop")
    local u68 = {sourceTab = sourceTab}
    u68.trove = Trove.new()
    u68.rows = {}
    u68.kind = a1
    u68.itemId = a2
    u68.productId = v1
    u68.speedSlot = if a1 ~= "Product" then nil else SpeedPacks.FindSlot(v1)
    u68.cashSlot = if a1 ~= "Product" then nil else CashPacks.FindSlot(v1)
    u117 = u68
    if u68.cashSlot or u68.speedSlot then
        local Title = GiftingPopUp.Header.Title
        local DisplayName = if not u68.speedSlot then CashPacks.Offers[u68.cashSlot].DisplayName else SpeedPacks.Names[u68.speedSlot]
        Title.Text = "Gift " .. DisplayName
        u124.Text = if not u68.speedSlot then "Cash gifts use the receiver's pack value.\nIt may differ from yours." else "Speed gifts use the receiver's pack value.\nTheir amount is shown below."
        u124.Visible = true
        ScrollingFrame.Size = u166
    end
    Frame.Visible = false
    GiftingPopUp.Visible = true
    u115.SetOverride("Gifting", GiftingPopUp, GiftingPopUp.Close, function() -- Line: 215 -- upvalues: closePicker (upval)
        closePicker()
    end, 1000, true)
    ScrollingFrame.CanvasPosition = Vector2.zero

    local function sortRows() -- Line: 219
        -- upvalues: u68 (val), PlatformController (upval), u115 (upval), GuiService (upval), GiftingPopUp (upval)
        local v1 = {}
        for i in u68.rows do
            table.insert(v1, i)
        end
        table.sort(v1, function(a1, a2) -- Line: 224
            local v1 = string.lower(a1.DisplayName)
            local v2 = string.lower(a2.DisplayName)
            if v1 == v2 then
                return a1.UserId < a2.UserId
            end
            return v1 < v2
        end)
        local v2 = v1
        local v3 = nil
        for j, k in v2, nil, v3 do
            u68.rows[k].card.LayoutOrder = j
        end
        if PlatformController.IsConsole() and not u115.IsCursorActive() then
            local Select
            if not GuiService.SelectedObject then
                GuiService.GuiNavigationEnabled = true
                v2 = GuiService
                Select = if not v1[1] then GiftingPopUp.Close else u68.rows[v1[1]].card.Select
                v2.SelectedObject = Select
            else
                v3 = GiftingPopUp
                if not GuiService.SelectedObject:IsDescendantOf(v3) then
                    GuiService.GuiNavigationEnabled = true
                    v2 = GuiService
                    Select = if not v1[1] then GiftingPopUp.Close else u68.rows[v1[1]].card.Select
                    v2.SelectedObject = Select
                end
            end
        end
    end

    local function addPlayer(a1) -- Line: 240
        -- upvalues: LocalPlayer (upval), u68 (val), u117 (upval), Trove (upval), PlayerTemplate (upval)
        -- upvalues: ScrollingFrame (upval), Size (upval), u166 (upval), SpeedPacks (upval), CashPacks (upval)
        -- upvalues: Simple (upval), ButtonFX (upval), selectPlayer (upval), sortRows (val)
        if a1 ~= LocalPlayer and not u68.rows[a1] and u117 == u68 then
            local v1 = Trove.new()
            local u13 = PlayerTemplate:Clone()
            u13.Name = tostring(a1.UserId)
            u13.PlayerNickName.Text = a1.DisplayName
            u13.PlayerName.Text = "@" .. a1.Name
            u13.PlayerIcon.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(a1.UserId)
            local Gift = u13:FindFirstChild("Gift")
            if Gift and Gift:IsA("GuiObject") then
                Gift.Visible = false
            end
            u13.Visible = true
            u13.Parent = ScrollingFrame
            v1:Add(u13)
            if u68.cashSlot or u68.speedSlot then
                u13.Size = UDim2.new(u13.Size.X.Scale, u13.Size.X.Offset, u13.Size.Y.Scale * Size.Y.Scale / u166.Y.Scale, u13.Size.Y.Offset)

                local function refreshGiftAmount() -- Line: 264
                    -- upvalues: u68 (upval), SpeedPacks (upval), a1 (val), CashPacks (upval), u13 (val), Simple (upval)
                    local v1 = if not u68.speedSlot then CashPacks.GetShownAmount(a1, u68.cashSlot) else SpeedPacks.GetShownAmount(a1, u68.speedSlot)
                    if not u68.speedSlot then
                        u13.Select.Title.Text = if not v1 then "Loading..." else "Gift $" .. Simple.FormatCompact(v1, ".#")
                        return
                    end
                    u13.Select.Title.Text = if not v1 then "Loading..." else a1.DisplayName .. " gets +" .. (Simple.FormatCompact(v1, ".#")) .. " Speed"
                    u13.Select.Title.TextScaled = true
                    u13.Select.Title.TextWrapped = true
                end

                if not u68.speedSlot then
                    v1:Connect(a1:GetAttributeChangedSignal(CashPacks.RevisionAttribute), refreshGiftAmount)
                    refreshGiftAmount()
                else
                    v1:Add((SpeedPacks.ObserveShownAmount(a1, u68.speedSlot, refreshGiftAmount)))
                end
            end
            v1:Add((ButtonFX(u13.Select, nil, function() -- Line: 287 -- upvalues: selectPlayer (upval), u68 (upval), a1 (val)
                selectPlayer(u68, a1)
            end)))
            u68.rows[a1] = {card = u13, trove = v1}
            sortRows()
            return
        end
    end

    u68.trove:Add(function() -- Line: 293 -- upvalues: u68 (val)
        for i, j in u68.rows do
            j.trove:Destroy()
        end
        table.clear(u68.rows)
    end)
    u68.trove:Connect(Players.PlayerAdded, addPlayer)
    u68.trove:Connect(Players.PlayerRemoving, function(a1) -- Line: 300 -- upvalues: u68 (val), GuiService (upval), sortRows (val)
        local v1 = u68.rows[a1]
        if v1 then
            if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(v1.card) then
                GuiService.SelectedObject = nil
            end
            v1.trove:Destroy()
            u68.rows[a1] = nil
            sortRows()
        end
    end)
    for i, j in Players:GetPlayers() do
        addPlayer(j)
    end
    sortRows()
    if next(u68.rows) == nil then
        Toast.Show({Text = "There are no other players in this server yet.", Seconds = 5})
    end
end

function u116.Bind(a1, a2, a3) -- Line: 321
    -- upvalues: ButtonFX (val), u116 (val)
    return ButtonFX(a1, nil, function() -- Line: 322 -- upvalues: u116 (upval), a2 (val), a3 (val)
        u116.Open(a2, a3)
    end)
end

ButtonFX(GiftingPopUp.Close)
GamepadBindings.Inspect(GiftingPopUp.Close)
GUI.OnActivated(GiftingPopUp.Close, function() -- Line: 330 -- upvalues: closePicker (val)
    closePicker()
end)
Tabs.Deactivated:Connect(function(a1) -- Line: 333
    -- upvalues: u117 (ref), u115 (val), GiftingPopUp (val), u124 (val), ScrollingFrame (val), Position (val)
    -- upvalues: Size (val), Text (val), Frame (val), GuiService (val), u118 (ref)
    if a1 == "Shop" then
        local v1 = u117
        u117 = nil
        u115.SetOverride("Gifting", nil)
        GiftingPopUp.Visible = false
        u124.Visible = false
        ScrollingFrame.Position = Position
        ScrollingFrame.Size = Size
        GiftingPopUp.Header.Title.Text = Text
        Frame.Visible = true
        if v1 then
            v1.trove:Destroy()
        end
        if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(GiftingPopUp) then
            GuiService.SelectedObject = nil
        end
        if u118 then
            v1 = u118
            if v1.cleanup then
                v1.cleanup()
                v1.cleanup = nil
            end
        end
    end
end)
;(u83:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 341
    -- upvalues: u83 (val), u117 (ref), u115 (val), GiftingPopUp (val), u124 (val), ScrollingFrame (val), Position (val)
    -- upvalues: Size (val), Text (val), Frame (val), GuiService (val), u118 (ref)
    if not u83.Enabled then
        local v1 = u117
        u117 = nil
        u115.SetOverride("Gifting", nil)
        GiftingPopUp.Visible = false
        u124.Visible = false
        ScrollingFrame.Position = Position
        ScrollingFrame.Size = Size
        GiftingPopUp.Header.Title.Text = Text
        Frame.Visible = true
        if v1 then
            v1.trove:Destroy()
        end
        if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(GiftingPopUp) then
            GuiService.SelectedObject = nil
        end
        if u118 then
            v1 = u118
            if v1.cleanup then
                v1.cleanup()
                v1.cleanup = nil
            end
        end
    end
end)
Remotes.Gifting.PromptFinished.OnClientEvent:Connect(function(a1, a2) -- Line: 350 -- upvalues: u118 (ref), closePicker (val) -- types: a1: number, a2: string
    local v1 = u118
    if v1 and v1.productId == a1 and v1.token == a2 then
        if v1.cleanup then
            v1.cleanup()
            v1.cleanup = nil
        end
        if u118 == v1 then
            u118 = nil
        end
        closePicker()
        return
    end
end)
Remotes.Gifting.Completed.OnClientEvent:Connect(function(a1, a2, a3, a4) -- Line: 359 -- upvalues: u119 (val), u118 (ref), closePicker (val)
    if u119[a3] then
        return
    end
    u119[a3] = true
    local v1 = u118
    if v1 and v1.productId == a1 and v1.token == a4 then
        if v1.cleanup then
            v1.cleanup()
            v1.cleanup = nil
        end
        if u118 == v1 then
            u118 = nil
        end
        closePicker()
    end
end)
return u116