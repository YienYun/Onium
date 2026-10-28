-- Script path: ReplicatedStorage.Controllers.GUI.GrowingEggListController
-- Decompile time: 46.57 ms

local ServerClock = require(game:GetService("ReplicatedStorage").Shared.Util.ServerClock)
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
game:GetService("Workspace")
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
require(ReplicatedStorage.Shared.Eggs.Types)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggState = require(ReplicatedStorage.Client.EggState)
require(ReplicatedStorage.Shared.Types.Eggs)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local Elapsed = require(ReplicatedStorage.Shared.Utils.Time).Elapsed
local GUI = require(ReplicatedStorage.Client.GUI)
local Hud = require(ReplicatedStorage.Client.Hud)
local GrowingEggListRow = require(ReplicatedStorage.Shared.Eggs.GrowingEggListRow)
local Log = require(ReplicatedStorage.Packages.Log)
local MenuNavigation = require(ReplicatedStorage.Client.MenuNavigation)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local PlacedEggRenderer = require(ReplicatedStorage.Shared.Eggs.PlacedEggRenderer)
local Products = require(ReplicatedStorage.Data.Products)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local SlideDock = require(ReplicatedStorage.Client.UI.SlideDock)
return {
    Start = function() -- Line: 67
        -- upvalues: Players (val), GUI (val), Hud (val), GamepadBindings (val), SlideDock (val), Log (val)
        -- upvalues: ServerClock (val), EggRecords (val), Elapsed (val), GuiService (val), MenuNavigation (val)
        -- upvalues: Products (val), GrowingEggListRow (val), PlacedEggRenderer (val), Toast (val), EggState (val)
        -- upvalues: Storefront (val), ButtonFX (val), AreaEggCycle (val), RunService (val)
        local u46, u63, v1, v2

        local function claimRowTemplate(a1) -- Line: 70 -- types: a1: userdata
            local v1 = nil
            for i, j in a1:GetChildren() do
                if j.Name == "Template" and j:IsA("GuiObject") then
                    if v1 ~= nil then
                        j:Destroy()
                    else
                        v1 = j
                    end
                end
            end
            assert(v1 ~= nil, "GrowingEggs.Frame.ScrollingFrame has no Template row")
            return v1
        end

        local function optionalBadge(a1, a2) -- Line: 86 -- types: a1: userdata?, a2: string
            if a1 == nil then
                return nil
            end
            local v1 = a1:FindFirstChild(a2)
            if v1 ~= nil then
                return v1
            end
            return nil
        end

        local LocalPlayer = Players.LocalPlayer
        local u6 = GUI.GrowingEggs()
        local Frame = u6.Frame
        local Close = Frame.Close
        local GrowAll = Frame.Header.GrowAll
        local ScrollingFrame = Frame.ScrollingFrame
        local EmptyLast = ScrollingFrame:FindFirstChild("EmptyLast")
        local u18 = claimRowTemplate(ScrollingFrame)
        local v3 = Hud.Every("EggsButton")
        local EggsButton = Hud.Find("EggsButton")
        local NightImage = if EggsButton == nil then nil else EggsButton:FindFirstChild("NightImage")
        local NightText = if EggsButton == nil then nil else EggsButton:FindFirstChild("NightText")
        if EggsButton ~= nil then
            local Notification = EggsButton:FindFirstChild("Notification")
            u46 = if Notification == nil then nil else Notification
        else
            u46 = nil
        end
        local TextLabel = if u46 == nil then nil else u46.InletTexture.TextLabel
        local Shadow = if TextLabel == nil then nil else TextLabel.Shadow
        if EggsButton ~= nil then
            local ReadyNotification = EggsButton:FindFirstChild("ReadyNotification")
            u63 = if ReadyNotification == nil then nil else ReadyNotification
        else
            u63 = nil
        end
        local TextLabel_2 = if u63 == nil then nil else u63.InletTexture.TextLabel
        local Shadow_2 = if TextLabel_2 == nil then nil else TextLabel_2.Shadow
        local u71 = {}
        local u72 = {}
        local u73 = {}
        local u74 = {}
        local u75 = {}
        local u76 = {}
        local u77 = 0
        local u78 = 0
        local u79 = 0
        assert(u6:IsA("ScreenGui"), "PlayerGui.GrowingEggs must be a ScreenGui")
        assert(Frame:IsA("GuiObject"), "GrowingEggs.Frame must be a GuiObject")
        assert(Close:IsA("GuiButton"), "GrowingEggs.Frame.Close must be a GuiButton")
        assert(GrowAll:IsA("GuiButton"), "GrowingEggs.Frame.Header.GrowAll must be a GuiButton")
        assert(ScrollingFrame:IsA("ScrollingFrame"), "GrowingEggs.Frame.ScrollingFrame must be a ScrollingFrame")
        assert(#v3 > 0, "the HUD has no EggsButton to open GrowingEggs with")
        u6.ResetOnSpawn = false
        GamepadBindings.TrackCloseButton(Close)
        local u188 = SlideDock.new(u6, Frame, SlideDock.EscortFramesOf(v3))
        local u192 = Log.new()

        local function setNightDecoration(a1) -- Line: 157
            -- upvalues: NightImage (val), NightText (val)
            if NightImage ~= nil then
                NightImage.Visible = a1
            end
            if NightText ~= nil then
                NightText.Visible = a1
            end
        end

        local function setOpen(a1, a2) -- Line: 166 -- upvalues: u188 (val) -- types: a1: boolean, a2: boolean?
            u188:SetOpen(a1, a2)
        end

        local function getGrowthAlpha(a1) -- Line: 170
            -- upvalues: ServerClock (upval), EggRecords (upval), LocalPlayer (val)
            local v1 = ServerClock.Now()
            return EggRecords.GrowthAlpha(
                a1,
                v1,
                a1.GrowthSpeedMultiplier,
                EggRecords.CurrentNightCredit(a1, v1, a1.GrowthSpeedMultiplier),
                LocalPlayer
            )
        end

        local function isReady(a1) -- Line: 181 -- upvalues: ServerClock (upval), EggRecords (upval), LocalPlayer (val)
            local v1 = ServerClock.Now()
            return 1 <= EggRecords.GrowthAlpha(
                a1,
                v1,
                a1.GrowthSpeedMultiplier,
                EggRecords.CurrentNightCredit(a1, v1, a1.GrowthSpeedMultiplier),
                LocalPlayer
            )
        end

        local function getRemainingSeconds(a1) -- Line: 183
            -- upvalues: ServerClock (upval), EggRecords (upval), LocalPlayer (val)
            if a1.Placement ~= nil then
                local v1 = ServerClock.Now()
                if not (1 <= EggRecords.GrowthAlpha(
                    a1,
                    v1,
                    a1.GrowthSpeedMultiplier,
                    EggRecords.CurrentNightCredit(a1, v1, a1.GrowthSpeedMultiplier),
                    LocalPlayer
                )) then
                    local v2 = ServerClock.Now()
                    return EggRecords.GrowthSecondsRemaining(
                        a1,
                        v2,
                        a1.GrowthSpeedMultiplier,
                        EggRecords.CurrentNightCredit(a1, v2, a1.GrowthSpeedMultiplier),
                        LocalPlayer
                    )
                end
            end
            return 0
        end

        local function getRemainingText(a1) -- Line: 199
            -- upvalues: ServerClock (upval), EggRecords (upval), LocalPlayer (val), Elapsed (upval)
            local Placement = a1.Placement
            if Placement ~= nil and Placement.ReadyAt == nil then
                local v1
                if a1.Placement == nil then
                    v1 = 0
                else
                    local v2 = ServerClock.Now()
                    if not (1 <= EggRecords.GrowthAlpha(
                        a1,
                        v2,
                        a1.GrowthSpeedMultiplier,
                        EggRecords.CurrentNightCredit(a1, v2, a1.GrowthSpeedMultiplier),
                        LocalPlayer
                    )) then
                        local v3 = ServerClock.Now()
                        v1 = EggRecords.GrowthSecondsRemaining(
                            a1,
                            v3,
                            a1.GrowthSpeedMultiplier,
                            EggRecords.CurrentNightCredit(a1, v3, a1.GrowthSpeedMultiplier),
                            LocalPlayer
                        )
                    else
                        v1 = 0
                    end
                end
                if v1 <= 0 then
                    return "Ready!"
                end
                return (Elapsed(v1))
            end
            return "Ready!"
        end

        local function updateRow(a1) -- Line: 209
            -- upvalues: GuiService (upval), u6 (val), MenuNavigation (upval), ServerClock (upval), EggRecords (upval)
            -- upvalues: LocalPlayer (val), Products (upval), getRemainingSeconds (val), GrowingEggListRow (upval)
            -- upvalues: Elapsed (upval)
            local v1
            local SelectedObject = GuiService.SelectedObject
            local Enabled = u6.Enabled
            if Enabled then
                Enabled = not MenuNavigation.IsSuspended()
                if Enabled then
                    Enabled = not MenuNavigation.IsCursorActive()
                    if Enabled then
                        Enabled = true
                        if SelectedObject ~= a1.GrowButton then
                            Enabled = SelectedObject == a1.HatchButton
                        end
                    end
                end
            end
            local Record = a1.Record
            local v2 = ServerClock.Now()
            local v3 = EggRecords.GrowthAlpha(
                Record,
                v2,
                Record.GrowthSpeedMultiplier,
                EggRecords.CurrentNightCredit(Record, v2, Record.GrowthSpeedMultiplier),
                LocalPlayer
            )
            local Update = GrowingEggListRow.Update
            local v4 = EggRecords.EggIcon(Record)
            local Placement = Record.Placement
            if Placement == nil then
                v1 = "Ready!"
            elseif Placement.ReadyAt == nil then
                local v5
                if Record.Placement == nil then
                    v5 = 0
                else
                    local v6 = ServerClock.Now()
                    if not (1 <= EggRecords.GrowthAlpha(
                        Record,
                        v6,
                        Record.GrowthSpeedMultiplier,
                        EggRecords.CurrentNightCredit(Record, v6, Record.GrowthSpeedMultiplier),
                        LocalPlayer
                    )) then
                        local v7 = ServerClock.Now()
                        v5 = EggRecords.GrowthSecondsRemaining(
                            Record,
                            v7,
                            Record.GrowthSpeedMultiplier,
                            EggRecords.CurrentNightCredit(Record, v7, Record.GrowthSpeedMultiplier),
                            LocalPlayer
                        )
                    else
                        v5 = 0
                    end
                end
                v1 = if not (v5 <= 0) then Elapsed(v5) else "Ready!"
            else
                v1 = "Ready!"
            end
            Update(a1, v4, v3, v1, v2, not (v3 >= 1) and Products.GetEggSkipGrowthProduct(getRemainingSeconds(Record)) ~= nil)
            if Enabled then
                local HatchButton = if not v2 then a1.GrowButton else a1.HatchButton
                if HatchButton.Visible and HatchButton.Active and HatchButton.Interactable then
                    HatchButton.Selectable = true
                    if GuiService.SelectedObject ~= HatchButton then
                        GuiService.SelectedObject = HatchButton
                    end
                end
            end
        end

        local function updateNotification(a1, a2, a3, a4) -- Line: 237
            -- upvalues: 
            if a1 ~= nil and a2 ~= nil and a3 ~= nil then
                local v1
                a1.Visible = a4 > 0
                if v1 then
                    local v2 = tostring(a4)
                    a2.Text = v2
                    a3.Text = v2
                end
                return
            end
        end

        local function updatePlacedNotification() -- Line: 256
            -- upvalues: u46 (val), TextLabel (val), Shadow (val), u77 (ref)
            local v1 = u46
            local v2 = TextLabel
            local v3 = Shadow
            local v4 = u77
            if v1 ~= nil and v2 ~= nil then
                local v5
                if v3 == nil then
                    return
                end
                v1.Visible = v4 > 0
                if v5 then
                    local v6 = tostring(v4)
                    v2.Text = v6
                    v3.Text = v6
                end
            end
        end

        local function updateReadyNotification() -- Line: 265
            -- upvalues: u63 (val), TextLabel_2 (val), Shadow_2 (val), u78 (ref)
            local v1 = u63
            local v2 = TextLabel_2
            local v3 = Shadow_2
            local v4 = u78
            if v1 ~= nil and v2 ~= nil then
                local v5
                if v3 == nil then
                    return
                end
                v1.Visible = v4 > 0
                if v5 then
                    local v6 = tostring(v4)
                    v2.Text = v6
                    v3.Text = v6
                end
            end
        end

        local function clearPlacedNotification() -- Line: 274
            -- upvalues: u77 (ref), u75 (val), u46 (val), TextLabel (val), Shadow (val)
            u77 = 0
            table.clear(u75)
            local v1 = u46
            local v2 = TextLabel
            local v3 = Shadow
            local v4 = u77
            if v1 ~= nil and v2 ~= nil then
                local v5
                if v3 == nil then
                    return
                end
                v1.Visible = v4 > 0
                if v5 then
                    local v6 = tostring(v4)
                    v2.Text = v6
                    v3.Text = v6
                end
            end
        end

        local function clearReadyNotification() -- Line: 280
            -- upvalues: u78 (ref), u76 (val), u63 (val), TextLabel_2 (val), Shadow_2 (val)
            u78 = 0
            table.clear(u76)
            local v1 = u63
            local v2 = TextLabel_2
            local v3 = Shadow_2
            local v4 = u78
            if v1 ~= nil and v2 ~= nil then
                local v5
                if v3 == nil then
                    return
                end
                v1.Visible = v4 > 0
                if v5 then
                    local v6 = tostring(v4)
                    v2.Text = v6
                    v3.Text = v6
                end
            end
        end

        local function incrementPlacedNotification(a1) -- Line: 286
            -- upvalues: u6 (val), u75 (val), u77 (ref), u46 (val), TextLabel (val), Shadow (val)
            if not u6.Enabled and not u75[a1] then
                u75[a1] = true
                u77 = u77 + 1
                local v1 = u46
                local v2 = TextLabel
                local v3 = Shadow
                local v4 = u77
                if v1 ~= nil and v2 ~= nil then
                    local v5
                    if v3 == nil then
                        return
                    end
                    v1.Visible = v4 > 0
                    if v5 then
                        local v6 = tostring(v4)
                        v2.Text = v6
                        v3.Text = v6
                    end
                end
                return
            end
        end

        local function incrementReadyNotification(a1) -- Line: 296
            -- upvalues: u6 (val), u76 (val), u78 (ref), u63 (val), TextLabel_2 (val), Shadow_2 (val)
            if not u6.Enabled and not u76[a1] then
                u76[a1] = true
                u78 = u78 + 1
                local v1 = u63
                local v2 = TextLabel_2
                local v3 = Shadow_2
                local v4 = u78
                if v1 ~= nil and v2 ~= nil then
                    local v5
                    if v3 == nil then
                        return
                    end
                    v1.Visible = v4 > 0
                    if v5 then
                        local v6 = tostring(v4)
                        v2.Text = v6
                        v3.Text = v6
                    end
                end
                return
            end
        end

        local function consumePlacedNotification(a1) -- Line: 306
            -- upvalues: u75 (val), u77 (ref), u46 (val), TextLabel (val), Shadow (val)
            if not u75[a1] then
                return
            end
            u75[a1] = nil
            u77 = math.max(u77 - 1, 0)
            local v1 = u46
            local v2 = TextLabel
            local v3 = Shadow
            local v4 = u77
            if v1 ~= nil and v2 ~= nil then
                local v5
                if v3 == nil then
                    return
                end
                v1.Visible = v4 > 0
                if v5 then
                    local v6 = tostring(v4)
                    v2.Text = v6
                    v3.Text = v6
                end
            end
        end

        local function consumeReadyNotification(a1) -- Line: 316
            -- upvalues: u76 (val), u78 (ref), u63 (val), TextLabel_2 (val), Shadow_2 (val)
            if not u76[a1] then
                return
            end
            u76[a1] = nil
            u78 = math.max(u78 - 1, 0)
            local v1 = u63
            local v2 = TextLabel_2
            local v3 = Shadow_2
            local v4 = u78
            if v1 ~= nil and v2 ~= nil then
                local v5
                if v3 == nil then
                    return
                end
                v1.Visible = v4 > 0
                if v5 then
                    local v6 = tostring(v4)
                    v2.Text = v6
                    v3.Text = v6
                end
            end
        end

        local function syncReadyState(a1, a2, a3) -- Line: 326
            -- upvalues: ServerClock (upval), EggRecords (upval), LocalPlayer (val), u74 (val), u6 (val), u76 (val)
            -- upvalues: u78 (ref), u63 (val), TextLabel_2 (val), Shadow_2 (val)
            local v1, v2, v3, v4, v5
            local v6 = ServerClock.Now()
            local v7 = 1 <= EggRecords.GrowthAlpha(
                a2,
                v6,
                a2.GrowthSpeedMultiplier,
                EggRecords.CurrentNightCredit(a2, v6, a2.GrowthSpeedMultiplier),
                LocalPlayer
            )
            if v7 and not u74[a1] then
                u74[a1] = true
                if a3 and not u6.Enabled then
                    if u76[a1] then
                        return v7
                    end
                    u76[a1] = true
                    u78 = u78 + 1
                    v1 = u63
                    v6 = TextLabel_2
                    v2 = Shadow_2
                    v3 = u78
                    if v1 ~= nil and v6 ~= nil then
                        if v2 == nil then
                            return v7
                        end
                        v1.Visible = v3 > 0
                        if v4 then
                            v5 = tostring(v3)
                            v6.Text = v5
                            v2.Text = v5
                            return v7
                        end
                    end
                end
                return v7
            end
            if not v7 and u74[a1] then
                u74[a1] = nil
                if not u76[a1] then
                    return v7
                end
                u76[a1] = nil
                u78 = math.max(u78 - 1, 0)
                v1 = u63
                v6 = TextLabel_2
                v2 = Shadow_2
                v3 = u78
                if v1 ~= nil and v6 ~= nil then
                    if v2 == nil then
                        return v7
                    end
                    v1.Visible = v3 > 0
                    if v4 then
                        v5 = tostring(v3)
                        v6.Text = v5
                        v2.Text = v5
                    end
                end
            end
            return v7
        end

        local function compareRows(a1, a2) -- Line: 345
            -- upvalues: ServerClock (upval), EggRecords (upval), LocalPlayer (val)
            local v1, v2
            local Record = a1.Record
            local v3 = ServerClock.Now()
            local v4 = 1 <= EggRecords.GrowthAlpha(
                Record,
                v3,
                Record.GrowthSpeedMultiplier,
                EggRecords.CurrentNightCredit(Record, v3, Record.GrowthSpeedMultiplier),
                LocalPlayer
            )
            local Record_2 = a2.Record
            local v5 = ServerClock.Now()
            if v4 ~= (1 <= EggRecords.GrowthAlpha(
                Record_2,
                v5,
                Record_2.GrowthSpeedMultiplier,
                EggRecords.CurrentNightCredit(Record_2, v5, Record_2.GrowthSpeedMultiplier),
                LocalPlayer
            )) then
                return v4
            end
            local Record_3 = a1.Record
            if Record_3.Placement == nil then
                v1 = 0
            else
                local v6 = ServerClock.Now()
                if not (1 <= EggRecords.GrowthAlpha(
                    Record_3,
                    v6,
                    Record_3.GrowthSpeedMultiplier,
                    EggRecords.CurrentNightCredit(Record_3, v6, Record_3.GrowthSpeedMultiplier),
                    LocalPlayer
                )) then
                    v4 = ServerClock.Now()
                    v1 = EggRecords.GrowthSecondsRemaining(
                        Record_3,
                        v4,
                        Record_3.GrowthSpeedMultiplier,
                        EggRecords.CurrentNightCredit(Record_3, v4, Record_3.GrowthSpeedMultiplier),
                        LocalPlayer
                    )
                else
                    v1 = 0
                end
            end
            local Record_4 = a2.Record
            if Record_4.Placement == nil then
                v2 = 0
            else
                local v7 = ServerClock.Now()
                if not (1 <= EggRecords.GrowthAlpha(
                    Record_4,
                    v7,
                    Record_4.GrowthSpeedMultiplier,
                    EggRecords.CurrentNightCredit(Record_4, v7, Record_4.GrowthSpeedMultiplier),
                    LocalPlayer
                )) then
                    v5 = ServerClock.Now()
                    v2 = EggRecords.GrowthSecondsRemaining(
                        Record_4,
                        v5,
                        Record_4.GrowthSpeedMultiplier,
                        EggRecords.CurrentNightCredit(Record_4, v5, Record_4.GrowthSpeedMultiplier),
                        LocalPlayer
                    )
                else
                    v2 = 0
                end
            end
            if v1 ~= v2 then
                return v1 < v2
            end
            return (tostring(a1.Uid)) < tostring(a2.Uid)
        end

        local function pinEmptyLast() -- Line: 361 -- upvalues: EmptyLast (val)
            if EmptyLast ~= nil then
                EmptyLast.LayoutOrder = 1000000
            end
        end

        local function rowAction(a1) -- Line: 367
            local HatchButton = if not a1.Ready then a1.GrowButton else a1.HatchButton
            if HatchButton.Visible and HatchButton.Active and HatchButton.Interactable then
                return HatchButton
            end
            return nil
        end

        local function linkRows() -- Line: 372 -- upvalues: u71 (val), GrowAll (val), Close (val)
            local HatchButton, v1
            local v2 = {}
            for i, j in u71 do
                table.insert(v2, j)
            end
            table.sort(v2, function(a1, a2) -- Line: 375
                return a1.Root.LayoutOrder < a2.Root.LayoutOrder
            end)
            local v3 = {}
            local v4 = nil
            local v5 = nil
            for k, n in v2, v4, v5 do
                for m, i5 in {n.GrowButton, n.HatchButton} do
                    i5.NextSelectionUp = nil
                    i5.NextSelectionDown = nil
                    i5.NextSelectionLeft = nil
                    i5.NextSelectionRight = nil
                end
                HatchButton = if not n.Ready then n.GrowButton else n.HatchButton
                v1 = if not HatchButton.Visible then nil else if not HatchButton.Active then nil else if not HatchButton.Interactable then nil else HatchButton
                if v1 then
                    table.insert(v3, v1)
                end
            end
            GrowAll.NextSelectionUp = Close
            GrowAll.NextSelectionLeft = GrowAll
            GrowAll.NextSelectionRight = Close
            Close.NextSelectionUp = Close
            Close.NextSelectionLeft = GrowAll
            Close.NextSelectionRight = Close
            v4 = v3[1] or Close
            GrowAll.NextSelectionDown = v4
            v4 = v3[1] or GrowAll
            Close.NextSelectionDown = v4
            v4 = nil
            v5 = nil
            for i6, i7 in v3, v4, v5 do
                v1 = v3[i6 - 1] or GrowAll
                i7.NextSelectionUp = v1
                v1 = v3[i6 + 1] or Close
                i7.NextSelectionDown = v1
                i7.NextSelectionLeft = i7
                i7.NextSelectionRight = Close
            end
        end

        local function relayoutRows() -- Line: 405
            -- upvalues: u71 (val), compareRows (val), EmptyLast (val), linkRows (val)
            local v1 = {}
            for k, v in pairs(u71) do
                table.insert(v1, v)
            end
            table.sort(v1, compareRows)
            for i, i2 in ipairs(v1) do
                i2.Root.LayoutOrder = i
            end
            if EmptyLast ~= nil then
                EmptyLast.LayoutOrder = 1000000
            end
            linkRows()
        end

        local function destroyRow(a1) -- Line: 419
            -- upvalues: u71 (val), GuiService (upval), u6 (val), MenuNavigation (upval), GrowAll (val)
            -- upvalues: GrowingEggListRow (upval), linkRows (val)
            local v1 = u71[a1]
            if v1 == nil then
                return
            end
            u71[a1] = nil
            local SelectedObject = GuiService.SelectedObject
            if u6.Enabled
                and not MenuNavigation.IsSuspended()
                and not MenuNavigation.IsCursorActive()
                and SelectedObject
                and SelectedObject:IsDescendantOf(v1.Root) then
                local HatchButton_2
                local v2 = nil
                local v3 = nil
                local v4 = nil
                local v5 = nil
                for i, j in u71, v4, v5 do
                    HatchButton_2 = if not j.Ready then j.GrowButton else j.HatchButton
                    if if not HatchButton_2.Visible then nil else if not HatchButton_2.Active then nil else if not HatchButton_2.Interactable then nil else HatchButton_2 then
                        if not (v1.Root.LayoutOrder <= j.Root.LayoutOrder) then
                            if v3 == nil or v3.Root.LayoutOrder < j.Root.LayoutOrder then
                                v3 = j
                            end
                        elseif v2 == nil or j.Root.LayoutOrder < v2.Root.LayoutOrder then
                            v2 = j
                        end
                    end
                end
                local v6 = v2 or v3
                if not v6 then
                    v3 = GrowAll
                else
                    local HatchButton = if not v6.Ready then v6.GrowButton else v6.HatchButton
                    v3 = if not HatchButton.Visible then nil else if not HatchButton.Active then nil else if not HatchButton.Interactable then nil else HatchButton
                end
                if v3 then
                    v3.Selectable = true
                end
                GuiService.SelectedObject = v3
            end
            GrowingEggListRow.Destroy(v1)
            linkRows()
        end

        local function requestGrow(a1) -- Line: 448
            -- upvalues: PlacedEggRenderer (upval), u192 (val)
            local v1, v2 = PlacedEggRenderer.RequestSkipGrowthForLocalEgg(a1)
            if not v1 then
                (u192:AtWarning()):Log((("Failed to request egg growth skip from list for %*: %*"):format(a1, v2 or "unknown")))
            end
        end

        local function showNoGrowingEggs(a1) -- Line: 456 -- upvalues: Toast (upval) -- types: a1: string?
            Toast.Show({
                Seconds = 2,
                Text = a1 or "You have no growing eggs!",
                Color = Color3.fromRGB(255, 80, 80),
            })
        end

        local function requestGrowAll() -- Line: 464
            -- upvalues: EggState (upval), Toast (upval), Storefront (upval), Products (upval)
            local v1, v2 = EggState.MayBuyGrowAll()
            if not v1 then
                Toast.Show({
                    Seconds = 2,
                    Text = v2 or "You have no growing eggs!",
                    Color = Color3.fromRGB(255, 80, 80),
                })
                return
            end
            EggState.ForgetChosenSkip()
            Storefront.Prompt(Products.Directory.EggGrowAll.ProductId, true)
        end

        local function requestHatch(a1) -- Line: 475
            -- upvalues: PlacedEggRenderer (upval), u192 (val)
            local v1, v2 = PlacedEggRenderer.ActivateLocalEgg(a1)
            if not v1 then
                (u192:AtWarning()):Log((("Failed to hatch egg from list for %*: %*"):format(a1, v2 or "unknown")))
            end
        end

        local function removeHatchingRow(a1) -- Line: 482
            -- upvalues: u72 (val), u75 (val), u77 (ref), u46 (val), TextLabel (val), Shadow (val), u76 (val), u78 (ref)
            -- upvalues: u63 (val), TextLabel_2 (val), Shadow_2 (val), destroyRow (val)
            local v1, v2, v3, v4, v5, v6
            u72[a1] = true
            if u75[a1] then
                u75[a1] = nil
                u77 = math.max(u77 - 1, 0)
                v1 = u46
                v2 = TextLabel
                v3 = Shadow
                v4 = u77
                if v1 ~= nil and v2 ~= nil and v3 ~= nil then
                    v1.Visible = v4 > 0
                    if v5 then
                        v6 = tostring(v4)
                        v2.Text = v6
                        v3.Text = v6
                    end
                end
            end
            if u76[a1] then
                u76[a1] = nil
                u78 = math.max(u78 - 1, 0)
                v1 = u63
                v2 = TextLabel_2
                v3 = Shadow_2
                v4 = u78
                if v1 ~= nil and v2 ~= nil and v3 ~= nil then
                    v1.Visible = v4 > 0
                    if v5 then
                        v6 = tostring(v4)
                        v2.Text = v6
                        v3.Text = v6
                    end
                end
            end
            destroyRow(a1)
        end

        local function mountRow(a1, a2) -- Line: 489
            -- upvalues: GrowingEggListRow (upval), u18 (val), ScrollingFrame (val), requestGrow (val)
            -- upvalues: requestHatch (val), u71 (val), ButtonFX (upval), updateRow (val)
            local v1 = GrowingEggListRow.Mount(u18, ScrollingFrame, a1, requestGrow, requestHatch)
            v1.Record = a2
            u71[a1] = v1
            v1.Trove:Add((ButtonFX(v1.GrowButton, 1.08)))
            if v1.HatchButton ~= v1.GrowButton then
                v1.Trove:Add((ButtonFX(v1.HatchButton, 1.08)))
            end
            updateRow(v1)
            return v1
        end

        local function refreshRows(a1, a2) -- Line: 503
            -- upvalues: EggState (upval), LocalPlayer (val), u73 (val), u6 (val), u75 (val), u77 (ref), u46 (val)
            -- upvalues: TextLabel (val), Shadow (val), ServerClock (upval), EggRecords (upval), u74 (val), u76 (val)
            -- upvalues: u78 (ref), u63 (val), TextLabel_2 (val), Shadow_2 (val), u72 (val), destroyRow (val), u71 (val)
            -- upvalues: mountRow (val), updateRow (val), relayoutRows (val)
            local GrowthAlpha, GrowthSpeedMultiplier, v1, v2, v3, v4, v5, v6, v7, v8, v9
            local v10 = {}
            local v11 = {}
            local v12, v13 = a1, a2
            for k, v in pairs((EggState.ReadOwnerEggs(LocalPlayer.UserId))) do
                if v.Placement ~= nil then
                    v11[k] = true
                    if not u73[k] then
                        u73[k] = true
                        if v12 and not u6.Enabled and not u75[k] then
                            u75[k] = true
                            u77 = u77 + 1
                            v1 = u46
                            v2 = TextLabel
                            v3 = Shadow
                            v4 = u77
                            if v1 ~= nil and v2 ~= nil and v3 ~= nil then
                                v1.Visible = v4 > 0
                                if v5 then
                                    v6 = tostring(v4)
                                    v2.Text = v6
                                    v3.Text = v6
                                end
                            end
                        end
                    end
                    v3 = ServerClock.Now()
                    GrowthAlpha = EggRecords.GrowthAlpha
                    GrowthSpeedMultiplier = v.GrowthSpeedMultiplier
                    v8 = EggRecords.CurrentNightCredit(v, v3, v.GrowthSpeedMultiplier)
                    v1 = 1 <= GrowthAlpha(v, v3, GrowthSpeedMultiplier, v8, LocalPlayer)
                    if not v1 then
                        if not v1 and u74[k] then
                            u74[k] = nil
                            if u76[k] then
                                u76[k] = nil
                                u78 = math.max(u78 - 1, 0)
                                v2 = u63
                                v3 = TextLabel_2
                                v4 = Shadow_2
                                v5 = u78
                                if v2 ~= nil and v3 ~= nil and v4 ~= nil then
                                    v2.Visible = v5 > 0
                                    if v6 then
                                        v7 = tostring(v5)
                                        v3.Text = v7
                                        v4.Text = v7
                                    end
                                end
                            end
                        end
                    elseif not u74[k] then
                        u74[k] = true
                        if v13 and not u6.Enabled and not u76[k] then
                            u76[k] = true
                            u78 = u78 + 1
                            v2 = u63
                            v3 = TextLabel_2
                            v4 = Shadow_2
                            v5 = u78
                            if v2 ~= nil and v3 ~= nil and v4 ~= nil then
                                v2.Visible = v5 > 0
                                if v6 then
                                    v7 = tostring(v5)
                                    v3.Text = v7
                                    v4.Text = v7
                                end
                            end
                        end
                    elseif not v1 and u74[k] then
                        u74[k] = nil
                        if u76[k] then
                            u76[k] = nil
                            u78 = math.max(u78 - 1, 0)
                            v2 = u63
                            v3 = TextLabel_2
                            v4 = Shadow_2
                            v5 = u78
                            if v2 ~= nil and v3 ~= nil and v4 ~= nil then
                                v2.Visible = v5 > 0
                                if v6 then
                                    v7 = tostring(v5)
                                    v3.Text = v7
                                    v4.Text = v7
                                end
                            end
                        end
                    end
                    if not u72[k] then
                        v10[k] = true
                        v1 = u71[k]
                        if v1 ~= nil then
                            v1.Record = v
                            updateRow(v1)
                        else
                            mountRow(k, v)
                        end
                    else
                        destroyRow(k)
                    end
                end
            end
            for k2 in pairs(u71) do
                if not v10[k2] then
                    destroyRow(k2)
                end
            end
            for k3 in pairs(u73) do
                if not v11[k3] then
                    if u75[k3] then
                        u75[k3] = nil
                        u77 = math.max(u77 - 1, 0)
                        v1 = u46
                        v2 = TextLabel
                        v3 = Shadow
                        v4 = u77
                        if v1 ~= nil and v2 ~= nil and v3 ~= nil then
                            v1.Visible = v4 > 0
                            if v10 then
                                v9 = tostring(v4)
                                v2.Text = v9
                                v3.Text = v9
                            end
                        end
                    end
                    if u76[k3] then
                        u76[k3] = nil
                        u78 = math.max(u78 - 1, 0)
                        v1 = u63
                        v2 = TextLabel_2
                        v3 = Shadow_2
                        v4 = u78
                        if v1 ~= nil and v2 ~= nil and v3 ~= nil then
                            v1.Visible = v4 > 0
                            if v5 then
                                v6 = tostring(v4)
                                v2.Text = v6
                                v3.Text = v6
                            end
                        end
                    end
                    u73[k3] = nil
                    u74[k3] = nil
                    u72[k3] = nil
                end
            end
            relayoutRows()
        end

        local function updateVisibleRows() -- Line: 554
            -- upvalues: ServerClock (upval), u79 (ref), AreaEggCycle (upval), NightImage (val), NightText (val)
            -- upvalues: u71 (val), u74 (val), EggRecords (upval), LocalPlayer (val), u6 (val), u76 (val), u78 (ref)
            -- upvalues: u63 (val), TextLabel_2 (val), Shadow_2 (val), updateRow (val), relayoutRows (val)
            -- upvalues: linkRows (val)
            local Record, Uid, v1, v2, v3, v4, v5, v6, v7, v8
            local v9 = ServerClock.Now()
            if v9 - u79 < 0.25 then
                return
            end
            u79 = v9
            local v10 = AreaEggCycle.IsNightPhase(v9)
            if NightImage ~= nil then
                NightImage.Visible = v10
            end
            if NightText ~= nil then
                NightText.Visible = v10
            end
            v9 = false
            for k, v in pairs(u71) do
                v7 = u74[v.Uid] == true
                Uid = v.Uid
                Record = v.Record
                v2 = ServerClock.Now()
                v8 = 1 <= EggRecords.GrowthAlpha(
                    Record,
                    v2,
                    Record.GrowthSpeedMultiplier,
                    EggRecords.CurrentNightCredit(Record, v2, Record.GrowthSpeedMultiplier),
                    LocalPlayer
                )
                if not v8 then
                    if not v8 and u74[Uid] then
                        u74[Uid] = nil
                        if u76[Uid] then
                            u76[Uid] = nil
                            u78 = math.max(u78 - 1, 0)
                            v1 = u63
                            v2 = TextLabel_2
                            v3 = Shadow_2
                            v4 = u78
                            if v1 ~= nil and v2 ~= nil and v3 ~= nil then
                                v1.Visible = v4 > 0
                                if v5 then
                                    v6 = tostring(v4)
                                    v2.Text = v6
                                    v3.Text = v6
                                end
                            end
                        end
                    end
                elseif not u74[Uid] then
                    u74[Uid] = true
                    if not u6.Enabled and not u76[Uid] then
                        u76[Uid] = true
                        u78 = u78 + 1
                        v1 = u63
                        v2 = TextLabel_2
                        v3 = Shadow_2
                        v4 = u78
                        if v1 ~= nil and v2 ~= nil and v3 ~= nil then
                            v1.Visible = v4 > 0
                            if v5 then
                                v6 = tostring(v4)
                                v2.Text = v6
                                v3.Text = v6
                            end
                        end
                    end
                elseif not v8 and u74[Uid] then
                    u74[Uid] = nil
                    if u76[Uid] then
                        u76[Uid] = nil
                        u78 = math.max(u78 - 1, 0)
                        v1 = u63
                        v2 = TextLabel_2
                        v3 = Shadow_2
                        v4 = u78
                        if v1 ~= nil and v2 ~= nil and v3 ~= nil then
                            v1.Visible = v4 > 0
                            if v5 then
                                v6 = tostring(v4)
                                v2.Text = v6
                                v3.Text = v6
                            end
                        end
                    end
                end
                if v8 ~= v7 then
                    v9 = true
                end
                updateRow(v)
            end
            if v9 then
                relayoutRows()
                return
            end
            linkRows()
        end

        u18.Visible = false
        u188:SetOpen(false, true)
        local v4 = u77
        if u46 ~= nil and TextLabel ~= nil and Shadow ~= nil then
            u46.Visible = v4 > 0
            if v1 then
                v2 = tostring(v4)
                TextLabel.Text = v2
                Shadow.Text = v2
            end
        end
        v4 = u78
        if u63 ~= nil and TextLabel_2 ~= nil and Shadow_2 ~= nil then
            u63.Visible = v4 > 0
            if v1 then
                v2 = tostring(v4)
                TextLabel_2.Text = v2
                Shadow_2.Text = v2
            end
        end
        v4 = AreaEggCycle.IsNightPhase(ServerClock.Now())
        if NightImage ~= nil then
            NightImage.Visible = v4
        end
        if NightText ~= nil then
            NightText.Visible = v4
        end
        refreshRows(false, true)
        for i, j in v3 do
            GUI.OnActivated(j, function() -- Line: 591
                -- upvalues: u188 (val), u77 (ref), u75 (val), u46 (val), TextLabel (val), Shadow (val), u78 (ref)
                -- upvalues: u76 (val), u63 (val), TextLabel_2 (val), Shadow_2 (val), refreshRows (val)
                local v1, v2
                u188:SetOpen(true, nil)
                u77 = 0
                table.clear(u75)
                local v3 = u46
                local v4 = TextLabel
                local v5 = Shadow
                local v6 = u77
                if v3 ~= nil and v4 ~= nil and v5 ~= nil then
                    v3.Visible = v6 > 0
                    if v1 then
                        v2 = tostring(v6)
                        v4.Text = v2
                        v5.Text = v2
                    end
                end
                u78 = 0
                table.clear(u76)
                v3 = u63
                v4 = TextLabel_2
                v5 = Shadow_2
                v6 = u78
                if v3 ~= nil and v4 ~= nil and v5 ~= nil then
                    v3.Visible = v6 > 0
                    if v1 then
                        v2 = tostring(v6)
                        v4.Text = v2
                        v5.Text = v2
                    end
                end
                refreshRows(true, true)
            end)
            ButtonFX(j, 1.08)
        end
        GUI.OnActivated(Close, function() -- Line: 599 -- upvalues: u188 (val)
            u188:SetOpen(false, nil)
        end)
        ButtonFX(Close, 1.08)
        GUI.OnActivated(GrowAll, requestGrowAll)
        ButtonFX(GrowAll, 1.08)
        EggState.SnapshotRefreshed:Connect(function() -- Line: 603 -- upvalues: refreshRows (val)
            refreshRows(true, true)
        end)
        EggState.OwnerRefreshed:Connect(function(a1) -- Line: 604 -- upvalues: LocalPlayer (val), refreshRows (val) -- types: a1: number
            if a1 == LocalPlayer.UserId then
                refreshRows(true, true)
            end
        end)
        EggState.OwnerCleared:Connect(function(a1) -- Line: 609
            -- upvalues: LocalPlayer (val), u71 (val), destroyRow (val), u72 (val), u73 (val), u74 (val), u77 (ref)
            -- upvalues: u75 (val), u46 (val), TextLabel (val), Shadow (val), u78 (ref), u76 (val), u63 (val)
            -- upvalues: TextLabel_2 (val), Shadow_2 (val)
            local v1, v2
            if a1 ~= LocalPlayer.UserId then
                return
            end
            for k in pairs(u71) do
                destroyRow(k)
            end
            table.clear(u72)
            table.clear(u73)
            table.clear(u74)
            u77 = 0
            table.clear(u75)
            local v3 = u46
            local v4 = TextLabel
            local v5 = Shadow
            local v6 = u77
            if v3 ~= nil and v4 ~= nil and v5 ~= nil then
                v3.Visible = v6 > 0
                if v1 then
                    v2 = tostring(v6)
                    v4.Text = v2
                    v5.Text = v2
                end
            end
            u78 = 0
            table.clear(u76)
            v3 = u63
            v4 = TextLabel_2
            v5 = Shadow_2
            v6 = u78
            if v3 ~= nil and v4 ~= nil then
                if v5 == nil then
                    return
                end
                v3.Visible = v6 > 0
                if v1 then
                    v2 = tostring(v6)
                    v4.Text = v2
                    v5.Text = v2
                end
            end
        end)
        PlacedEggRenderer.LocalEggHatchStarted:Connect(removeHatchingRow)
        RunService.Heartbeat:Connect(updateVisibleRows)
    end,
}