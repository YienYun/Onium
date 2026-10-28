-- Script path: ReplicatedStorage.Controllers.GUI.PetListController
-- Decompile time: 28.40 ms

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
local BaseUpgrade = require(ReplicatedStorage.Client.BaseUpgrade)
local Bases = require(ReplicatedStorage.Data.Bases)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
require(ReplicatedStorage.Shared.Globals.Constants)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local GUI = require(ReplicatedStorage.Client.GUI)
local SwapGradient = require(ReplicatedStorage.Shared.Utils.SwapGradient)
local Hud = require(ReplicatedStorage.Client.Hud)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local MenuNavigation = require(ReplicatedStorage.Client.MenuNavigation)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local PetPenCapacityGuidanceController = require(script.PetPenCapacityGuidanceController)
local PetMountFlags = require(ReplicatedStorage.Shared.Flags.PetMountFlags)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local SlideDock = require(ReplicatedStorage.Client.UI.SlideDock)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u114 = Color3.fromRGB(255, 70, 70)
local u119 = Color3.fromRGB(85, 255, 85)
local u131 = ColorSequence.new(Color3.fromRGB(214, 17, 17), Color3.fromRGB(253, 20, 20))
local u136 = Color3.fromRGB(72, 0, 0)
local u141 = Color3.fromRGB(255, 103, 103)
return {
    Start = function() -- Line: 101
        -- upvalues: Players (val), GUI (val), Hud (val), GamepadBindings (val), SlideDock (val), Bases (val)
        -- upvalues: Simple (val), MenuNavigation (val), GuiService (val), BaseUpgrade (val), u131 (val), u136 (val)
        -- upvalues: u141 (val), AssetItems (val), Assets (val), AssetEarnings (val), AssetRoster (val), Toast (val)
        -- upvalues: u114 (val), Remotes (val), SwapGradient (val), PetMountFlags (val), Trove (val), ButtonFX (val)
        -- upvalues: Save (val), PetPenCapacityGuidanceController (val), u119 (val)
        local function claimRowTemplate(a1) -- Line: 104 -- types: a1: userdata
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
            assert(v1 ~= nil, "ActivePets.Frame.ScrollingFrame has no Template row")
            return v1
        end

        local function shadowFor(a1) -- Line: 121 -- types: a1: userdata
            local TextLabel = a1:FindFirstChild("TextLabel")
            if TextLabel ~= nil and TextLabel:IsA("TextLabel") then
                return TextLabel
            end
            return a1
        end

        local LocalPlayer = Players.LocalPlayer
        local u6 = GUI.ActivePets()
        local Frame = u6.Frame
        local Title = Frame.Header.Title
        local TextLabel_2 = Title:FindFirstChild("TextLabel")
        local u20 = if TextLabel_2 == nil then Title else if not TextLabel_2:IsA("TextLabel") then Title else TextLabel_2
        local PlusEquip = Frame.Header.PlusEquip
        local TextLabel = PlusEquip:FindFirstChild("TextLabel")
        local ScrollingFrame = Frame.ScrollingFrame
        local EmptyLast = ScrollingFrame:FindFirstChild("EmptyLast")
        local u38 = claimRowTemplate(ScrollingFrame)
        local Close = Frame.Close
        local EquipBest = Frame.EquipBest
        local PetsButton = Hud.Every("PetsButton")
        local UIGradient = PlusEquip:FindFirstChildOfClass("UIGradient")
        local UIStroke = PlusEquip:FindFirstChild("UIStroke")
        local UIStrokeClr = PlusEquip:FindFirstChild("UIStrokeClr")
        local Color = if UIGradient == nil then nil else UIGradient.Color
        local Color_2 = if UIStroke == nil then nil else UIStroke.Color
        local Color_3 = if UIStrokeClr == nil then nil else UIStrokeClr.Color
        local u66 = {}
        local u67 = {}
        local u68 = 0
        local u69 = false
        local u70 = 0
        local u71 = false
        local ButtonsHolder = u38.Spacer.ButtonsHolder
        local UIListLayout = ButtonsHolder:FindFirstChildOfClass("UIListLayout")
        local Size = ButtonsHolder.Unequip.Size
        local Size_4 = ButtonsHolder.Ride.Size
        local TextLabel_3 = ButtonsHolder.Ride:FindFirstChild("TextLabel")
        local Label = ButtonsHolder.Unequip:FindFirstChild("Label")
        local Size_2 = if TextLabel_3 == nil then nil else if not TextLabel_3:IsA("GuiObject") then nil else TextLabel_3.Size
        local Size_3 = if Label == nil then Size_2 else if not Label:IsA("GuiObject") then Size_2 else Label.Size
        local Padding = if UIListLayout == nil then UDim.new(0, 0) else UIListLayout.Padding
        local u160 = UDim2.new(
            UDim.new(Size.X.Scale * 0.87, Size.X.Offset * 0.87),
            UDim.new((Size.Y.Scale + Padding.Scale + Size_4.Y.Scale) * 0.65, (Size.Y.Offset + Padding.Offset + Size_4.Y.Offset) * 0.65)
        )
        assert(u6:IsA("ScreenGui"), "PlayerGui.ActivePets must be a ScreenGui")
        assert(Frame:IsA("GuiObject"), "ActivePets.Frame must be a GuiObject")
        assert(Title:IsA("TextLabel"), "ActivePets.Frame.Header.Title must be a TextLabel")
        assert(PlusEquip:IsA("GuiButton"), "ActivePets.Frame.Header.PlusEquip must be a GuiButton")
        local v1 = false
        if TextLabel ~= nil then
            v1 = TextLabel:IsA("TextLabel")
        end
        assert(v1, "ActivePets.Frame.Header.PlusEquip.TextLabel must be a TextLabel")
        assert(ScrollingFrame:IsA("ScrollingFrame"), "ActivePets.Frame.ScrollingFrame must be a ScrollingFrame")
        assert(Close:IsA("GuiButton"), "ActivePets.Frame.Close must be a GuiButton")
        assert(EquipBest:IsA("GuiButton"), "ActivePets.Frame.EquipBest must be a GuiButton")
        assert(#PetsButton > 0, "the HUD has no PetsButton to open ActivePets with")
        assert(ButtonsHolder.Ride:IsA("GuiButton"), "ActivePets row ButtonsHolder.Ride must be a GuiButton")
        assert(ButtonsHolder.Unequip:IsA("GuiButton"), "ActivePets row ButtonsHolder.Unequip must be a GuiButton")
        local v2 = TextLabel:FindFirstChild("TextLabel")
        local u342 = if v2 == nil then TextLabel else if not v2:IsA("TextLabel") then TextLabel else v2
        u6.ResetOnSpawn = false
        PlusEquip.AutoButtonColor = false
        GamepadBindings.TrackCloseButton(Close)
        local u376 = SlideDock.new(u6, Frame, SlideDock.EscortFramesOf(PetsButton))

        local function setOpen(a1, a2) -- Line: 204 -- upvalues: u376 (val) -- types: a1: boolean, a2: boolean?
            u376:SetOpen(a1, a2)
        end

        local function getCapacity(a1) -- Line: 208 -- upvalues: Bases (upval)
            return Bases.GetAssetEquipCapacity(if a1 == nil then nil else a1.BaseUpgradeLevel)
        end

        local function setTextWithShadow(a1, a2, a3) -- Line: 212 -- types: a1: userdata, a2: userdata, a3: string
            a1.Text = a3
            a2.Text = a3
        end

        local function formatDisplayNameWithRate(a1) -- Line: 217 -- upvalues: Simple (upval) -- types: a1: table
            return a1.DisplayName .. " ($" .. (Simple.FormatCompact(a1.Rate, ".#")) .. "/s)"
        end

        local function ownsButtonSelection() -- Line: 221 -- upvalues: u6 (val), Frame (val), MenuNavigation (upval)
            return u6.Enabled and Frame.Visible and not MenuNavigation.IsSuspended() and not MenuNavigation.IsCursorActive()
        end

        local function keepRowVisible(a1) -- Line: 226
            -- upvalues: u6 (val), Frame (val), MenuNavigation (upval), GuiService (upval), ScrollingFrame (val)
            local Enabled = u6.Enabled and Frame.Visible and not MenuNavigation.IsSuspended() and not MenuNavigation.IsCursorActive()
            if Enabled and GuiService.SelectedObject == a1 then
                local v1 = a1.AbsolutePosition.Y - ScrollingFrame.AbsolutePosition.Y
                local v2 = v1 + a1.AbsoluteSize.Y
                local Y = ScrollingFrame.AbsoluteWindowSize.Y
                local v3 = if not (v1 < 0) then if not (Y < v2) then 0 else v2 - Y else v1
                if v3 ~= 0 then
                    local CanvasPosition = ScrollingFrame.CanvasPosition
                    v1 = math.max(0, ScrollingFrame.AbsoluteCanvasSize.Y - Y)
                    ScrollingFrame.CanvasPosition = Vector2.new(CanvasPosition.X, (math.clamp(CanvasPosition.Y + v3, 0, v1)))
                end
                return
            end
        end

        local function ridingUID() -- Line: 239 -- upvalues: LocalPlayer (val)
            local Character = LocalPlayer.Character
            local PetMountSession = if Character == nil then nil else Character:FindFirstChild("PetMountSession")
            local v1 = if PetMountSession == nil then nil else PetMountSession:GetAttribute("UID")
            if typeof(v1) == "string" then
                return v1
            end
            return nil
        end

        local function orderedButtons() -- Line: 246 -- upvalues: u67 (ref)
            local v1 = {}
            local v2 = nil
            local v3 = nil
            for i, j in u67, v2, v3 do
                if j.CanRide then
                    table.insert(v1, j.Ride)
                end
                table.insert(v1, j.Unequip)
            end
            return v1
        end

        local function updateNavigation() -- Line: 257
            -- upvalues: PlusEquip (val), Close (val), orderedButtons (val), EquipBest (val)
            local v1, v2
            local v3 = if not PlusEquip.Active then Close else PlusEquip
            local v4 = orderedButtons()
            local v5 = if not (#v4 > 0) then EquipBest else v4[1]
            local v6 = if not (#v4 > 0) then v3 else v4[#v4]
            PlusEquip.NextSelectionUp = Close
            PlusEquip.NextSelectionDown = v5
            PlusEquip.NextSelectionLeft = PlusEquip
            PlusEquip.NextSelectionRight = Close
            Close.NextSelectionUp = Close
            Close.NextSelectionDown = v5
            Close.NextSelectionLeft = v3
            Close.NextSelectionRight = Close
            EquipBest.NextSelectionUp = v6
            EquipBest.NextSelectionDown = Close
            EquipBest.NextSelectionLeft = EquipBest
            EquipBest.NextSelectionRight = Close
            local v7 = nil
            local v8 = nil
            for i, j in v4, v7, v8 do
                v1 = i == 1
                j:SetAttribute("DefaultFocus", v1)
                v2 = if i ~= 1 then v4[i - 1] else v3
                j.NextSelectionUp = v2
                v2 = if i ~= #v4 then v4[i + 1] else EquipBest
                j.NextSelectionDown = v2
                j.NextSelectionLeft = j
                j.NextSelectionRight = Close
            end
            EquipBest:SetAttribute("DefaultFocus", #v4 == 0)
        end

        local function updateHeader(a1, a2) -- Line: 285
            -- upvalues: Bases (upval), Title (val), u20 (val), BaseUpgrade (upval), Simple (upval), TextLabel (val)
            -- upvalues: u342 (val), GuiService (upval), PlusEquip (val), u6 (val), Frame (val), MenuNavigation (upval)
            -- upvalues: u67 (ref), EquipBest (val), UIGradient (val), u131 (upval), Color (val), UIStroke (val)
            -- upvalues: u136 (upval), Color_2 (val), UIStrokeClr (val), u141 (upval), Color_3 (val)
            -- upvalues: updateNavigation (val)
            local v1 = Bases.GetAssetEquipCapacity(if a1 == nil then nil else a1.BaseUpgradeLevel)
            local v2 = Title
            local v3 = u20
            local v4 = ("%*/%* Active"):format(a2, v1)
            v2.Text = v4
            v3.Text = v4
            local Cost = nil
            if a1 ~= nil then
                _, v3 = BaseUpgrade.ResolveNextTier(a1)
                Cost = if v3 == nil then nil else v3.Cost
            end
            v2 = if Cost ~= nil then ("+1 EQUIP [$%*]"):format((Simple.FormatCompact(math.floor(Cost), ".#"))) else "MAX EQUIP"
            v4 = u342
            TextLabel.Text = v2
            v4.Text = v2
            if Cost == nil and GuiService.SelectedObject == PlusEquip then
                local Enabled = u6.Enabled and Frame.Visible and not MenuNavigation.IsSuspended() and not MenuNavigation.IsCursorActive()
                if Enabled then
                    GuiService.SelectedObject = if not (#u67 > 0) then EquipBest else u67[1].Button
                end
            end
            PlusEquip.Active = Cost ~= nil
            v2 = false
            if Cost ~= nil then
                v2 = false
                if a1 ~= nil then
                    v2 = Cost <= a1.Money
                end
            end
            v3 = false
            if Cost ~= nil then
                v3 = not v2
            end
            if UIGradient ~= nil then
                UIGradient.Color = if not v3 then Color else u131
            end
            if UIStroke ~= nil then
                UIStroke.Color = if not v3 then Color_2 else u136
            end
            if UIStrokeClr ~= nil then
                UIStrokeClr.Color = if not v3 then Color_3 else u141
            end
            updateNavigation()
        end

        local function compareEntries(a1, a2) -- Line: 325 -- types: a1: table, a2: table
            if a1.Rank ~= a2.Rank then
                return a2.Rank < a1.Rank
            end
            if a1.Rate ~= a2.Rate then
                return a2.Rate < a1.Rate
            end
            return a1.UID < a2.UID
        end

        local function buildEntries(a1) -- Line: 335
            -- upvalues: AssetItems (upval), Assets (upval), AssetEarnings (upval), Players (upval)
            -- upvalues: compareEntries (val)
            local DisplayName, Rarity, v1, v2, v3
            if a1 == nil then
                return {}
            end
            local v4 = {}
            local v5 = a1
            for i, v in ipairs(a1.EquippedAssets) do
                v2 = v5.Inventory[v]
                if v2 ~= nil then
                    v3 = AssetItems.Decode(v2)
                    v2 = Assets.Directory[v3.Category]
                    Rarity = v2.Rarity
                    v1 = {UID = v}
                    DisplayName = if v2.DisplayName == "" then v3.Category else v2.DisplayName
                    v1.DisplayName = DisplayName
                    v1.Icon = v2.Icon
                    v1.Rate = AssetEarnings.LiveRatePerSecond(v3, v5.Gamepasses, v5.Products, Players.LocalPlayer)
                    v1.Rank = Rarity.Rank
                    v1.RarityGradient = Rarity.RarityGradient
                    v1.Rideable = v3.Rideable == true
                    table.insert(v4, v1)
                end
            end
            table.sort(v4, compareEntries)
            return v4
        end

        local function requestUnequip(a1) -- Line: 370
            -- upvalues: AssetRoster (upval), Toast (upval), u114 (upval)
            local v1, v2 = AssetRoster.DoffAsset(a1)
            if not v1 and v2 ~= nil then
                Toast.Show({Seconds = 2, Text = v2, Color = u114})
            end
        end

        local function requestRide(a1) -- Line: 381
            -- upvalues: u71 (ref), LocalPlayer (val), Remotes (upval), u376 (val), Toast (upval), u114 (upval)
            if u71 then
                return
            end
            u71 = true
            local Character = LocalPlayer.Character
            local PetMountSession = if Character == nil then nil else Character:FindFirstChild("PetMountSession")
            local v1 = if PetMountSession == nil then nil else PetMountSession:GetAttribute("UID")
            local u28 = (if typeof(v1) ~= "string" then nil else v1) == a1
            local success, err, v2 = pcall(function() -- Line: 387 -- upvalues: u28 (val), Remotes (upval), a1 (val)
                if u28 then
                    return Remotes.PetMount.Request:InvokeServer("dismount")
                end
                return Remotes.PetMount.Request:InvokeServer("mount", a1)
            end)
            u71 = false
            if success and err == true then
                if not u28 then
                    u376:SetOpen(false, nil)
                end
                return
            end
            Toast.Show({
                Seconds = 2,
                Text = if not success then "Couldn't ride this pet. Try again." else if typeof(v2) ~= "string" then "Couldn't ride this pet. Try again." else v2,
                Color = u114,
            })
        end

        local function updateRow(a1, a2, a3) -- Line: 407
            -- upvalues: SwapGradient (upval), Simple (upval), PetMountFlags (upval), GuiService (upval), u6 (val)
            -- upvalues: Frame (val), MenuNavigation (upval), Size (val), u160 (val), LocalPlayer (val), Size_2 (val)
            -- upvalues: Size_3 (val)
            a1.Root.LayoutOrder = a3
            if a1.Gradient ~= a2.RarityGradient then
                SwapGradient(a1.Label, a2.RarityGradient)
                if a1.Shadow ~= a1.Label then
                    SwapGradient(a1.Shadow, a2.RarityGradient)
                end
                a1.Gradient = a2.RarityGradient
            end
            local Label = a1.Label
            local Shadow = a1.Shadow
            local v1 = a2.DisplayName .. " ($" .. (Simple.FormatCompact(a2.Rate, ".#")) .. "/s)"
            Label.Text = v1
            Shadow.Text = v1
            a1.Icon.Image = a2.Icon or ""
            local Rideable = a2.Rideable and PetMountFlags.Enabled:Get()
            if not Rideable and GuiService.SelectedObject == a1.Ride then
                local Enabled = u6.Enabled and Frame.Visible and not MenuNavigation.IsSuspended() and not MenuNavigation.IsCursorActive()
                if Enabled then
                    GuiService.SelectedObject = a1.Unequip
                end
            end
            a1.CanRide = Rideable
            a1.Ride.Visible = Rideable
            v1 = if not Rideable then u160 else Size
            a1.Unequip.Size = v1
            local Ride = if not Rideable then a1.Unequip else a1.Ride
            a1.Button = Ride
            if not Rideable then
                a1.Ride:SetAttribute("DefaultFocus", false)
            end
            if a1.RideLabel ~= nil and a1.RideShadow ~= nil then
                local v2
                local Character = LocalPlayer.Character
                local PetMountSession = if Character == nil then nil else Character:FindFirstChild("PetMountSession")
                v1 = if PetMountSession == nil then nil else PetMountSession:GetAttribute("UID")
                local v3 = (if typeof(v1) ~= "string" then nil else v1) == a2.UID
                local RideLabel = a1.RideLabel
                local RideShadow = a1.RideShadow
                RideLabel.Text = if not v3 then "Ride" else "Dismount"
                RideShadow.Text = v2
                if Size_2 ~= nil and Size_3 ~= nil then
                    v1 = if not v3 then Size_2 else Size_3
                    a1.RideLabel.Size = v1
                end
            end
        end

        local function mountRow(a1, a2) -- Line: 436
            -- upvalues: Trove (upval), u38 (val), SwapGradient (upval), AssetRoster (upval), Toast (upval)
            -- upvalues: u114 (upval), keepRowVisible (val), ButtonFX (upval), requestRide (val), updateRow (val)
            -- upvalues: ScrollingFrame (val)
            local v1
            local v2 = Trove.new()
            local v3 = u38:Clone()
            v3.Name = ("Pet_%*"):format(a1.UID)
            v3.LayoutOrder = a2
            v3.Visible = true
            v3:SetAttribute("PetListRowClone", true)
            v2:Add(v3)
            local Spacer = v3.Spacer
            local TextLabel = Spacer.TextLabel
            local TextLabel_2 = TextLabel:FindFirstChild("TextLabel")
            local v4 = if TextLabel_2 == nil then TextLabel else if not TextLabel_2:IsA("TextLabel") then TextLabel else TextLabel_2
            local Icon = Spacer.Icon
            local ButtonsHolder = Spacer.ButtonsHolder
            local Ride = ButtonsHolder.Ride
            local Unequip = ButtonsHolder.Unequip
            local v5 = Ride:FindFirstChild("TextLabel")
            local v6 = if v5 == nil then nil else if not v5:IsA("TextLabel") then nil else v5
            Ride.LayoutOrder = 1
            Unequip.LayoutOrder = 2
            Ride.Selectable = true
            Unequip.Selectable = true
            SwapGradient(TextLabel, nil)
            if v4 ~= TextLabel then
                SwapGradient(v4, nil)
            end
            v2:Connect(Unequip.Activated, function() -- Line: 463 -- upvalues: a1 (val), AssetRoster (upval), Toast (upval), u114 (upval)
                local UID = a1.UID
                local v1, v2 = AssetRoster.DoffAsset(UID)
                if not v1 and v2 ~= nil then
                    Toast.Show({Seconds = 2, Text = v2, Color = u114})
                end
            end)
            v2:Connect(Unequip.SelectionGained, function() -- Line: 464 -- upvalues: keepRowVisible (upval), Unequip (val)
                keepRowVisible(Unequip)
            end)
            v2:Add((ButtonFX(Unequip, 1.08)))
            v2:Connect(Ride.Activated, function() -- Line: 466 -- upvalues: requestRide (upval), a1 (val)
                requestRide(a1.UID)
            end)
            v2:Connect(Ride.SelectionGained, function() -- Line: 467 -- upvalues: keepRowVisible (upval), Ride (val)
                keepRowVisible(Ride)
            end)
            v2:Add((ButtonFX(Ride, 1.08)))
            v5 = {
                CanRide = false,
                Root = v3,
                Button = Unequip,
                Ride = Ride,
                Unequip = Unequip,
                RideLabel = v6,
            }
            if v6 == nil then
                v1 = nil
            else
                local TextLabel_3 = v6:FindFirstChild("TextLabel")
                v1 = if TextLabel_3 == nil then v6 else if not TextLabel_3:IsA("TextLabel") then v6 else TextLabel_3
            end
            v5.RideShadow = v1
            v5.Label = TextLabel
            v5.Shadow = v4
            v5.Icon = Icon
            v5.Trove = v2
            updateRow(v5, a1, a2)
            v3.Parent = ScrollingFrame
            return v5
        end

        local function pinEmptyLast() -- Line: 480 -- upvalues: EmptyLast (val)
            if EmptyLast ~= nil then
                EmptyLast.LayoutOrder = 1000000
            end
        end

        local function refresh() -- Line: 486
            -- upvalues: GuiService (upval), u67 (ref), Save (upval), LocalPlayer (val), buildEntries (val), u66 (val)
            -- upvalues: mountRow (val), updateRow (val), u70 (ref), EmptyLast (val), updateHeader (val), u6 (val)
            -- upvalues: Frame (val), MenuNavigation (upval), EquipBest (val), ScrollingFrame (val)
            -- upvalues: keepRowVisible (val)
            local v1
            local SelectedObject_2 = GuiService.SelectedObject
            local v2 = nil
            local v3 = nil
            for i, j in u67 do
                if SelectedObject_2 ~= j.Ride and SelectedObject_2 ~= j.Unequip then
                    continue
                end
                v2 = i
                v3 = j
                break
            end
            local v4 = Save.Await(LocalPlayer)
            local v5 = {}
            local v6 = {}
            local v7 = false
            for i2, v in ipairs((buildEntries(v4))) do
                if not v5[v.UID] then
                    v5[v.UID] = true
                    v1 = u66[v.UID]
                    if v1 ~= nil then
                        updateRow(v1, v, #v6 + 1)
                    else
                        v1 = mountRow(v, #v6 + 1)
                        u66[v.UID] = v1
                    end
                    table.insert(v6, v1)
                    if u67[i2] ~= v1 then
                        v7 = true
                    end
                end
            end
            v7 = v7 or #v6 ~= #u67
            u67 = v6
            u70 = #v6
            if EmptyLast ~= nil then
                EmptyLast.LayoutOrder = 1000000
            end
            updateHeader(v4, u70)
            if v2 ~= nil and v3 ~= nil and not table.find(v6, v3) then
                local Enabled = u6.Enabled and Frame.Visible and not MenuNavigation.IsSuspended() and not MenuNavigation.IsCursorActive()
                if Enabled and GuiService.SelectedObject == SelectedObject_2 then
                    GuiService.SelectedObject = if not (#v6 > 0) then EquipBest else v6[math.min(v2, #v6)].Button
                end
            end
            for k, n in u66 do
                if not v5[k] then
                    u66[k] = nil
                    n.Trove:Destroy()
                end
            end
            if v7 and v2 ~= nil then
                local SelectedObject = GuiService.SelectedObject
                if SelectedObject ~= nil and SelectedObject:IsDescendantOf(ScrollingFrame) then
                    task.defer(function() -- Line: 534 -- upvalues: SelectedObject (val), keepRowVisible (upval)
                        if SelectedObject.Parent ~= nil then
                            keepRowVisible(SelectedObject)
                        end
                    end)
                end
            end
        end

        local function showEquipBestDebounceNotification() -- Line: 543 -- upvalues: Toast (upval)
            Toast.Show({
                Text = "Please wait a bit before equipping bests again!",
                Seconds = 2,
                Color = Color3.fromRGB(255, 170, 0),
            })
        end

        local function requestEquipBest() -- Line: 551
            -- upvalues: u69 (ref), u68 (ref), Toast (upval), Remotes (upval), refresh (val), u114 (upval)
            local ServerTimeNow = workspace:GetServerTimeNow()
            if not u69 then
                local v1 = ServerTimeNow - u68
                if not (v1 < 5) then
                    local v2
                    u68 = ServerTimeNow
                    u69 = true
                    v1, v2 = Remotes.Haul.WearBest:InvokeServer()
                    u69 = false
                    if v1 == true then
                        refresh()
                        return
                    end
                    Toast.Show({
                        Seconds = 2,
                        Text = if typeof(v2) ~= "string" then "Please wait a bit before equipping bests again!" else v2,
                        Color = u114,
                    })
                    return
                end
            end
            Toast.Show({
                Text = "Please wait a bit before equipping bests again!",
                Seconds = 2,
                Color = Color3.fromRGB(255, 170, 0),
            })
        end

        u38.Visible = false
        u376:SetOpen(false, true)
        refresh()
        PetPenCapacityGuidanceController.Initialize()
        for i, j in PetsButton do
            GUI.OnActivated(j, function() -- Line: 586 -- upvalues: PetPenCapacityGuidanceController (upval), u376 (val), refresh (val)
                PetPenCapacityGuidanceController.AcknowledgePetsBadge()
                u376:SetOpen(true, nil)
                refresh()
            end)
            ButtonFX(j, 1.08)
        end
        GUI.OnActivated(Close, function() -- Line: 593 -- upvalues: u376 (val)
            u376:SetOpen(false, nil)
        end)
        ButtonFX(Close, 1.08)
        GUI.OnActivated(PlusEquip, function() -- Line: 574 -- upvalues: BaseUpgrade (upval)
            BaseUpgrade.PurchaseNextTier()
        end)
        ButtonFX(PlusEquip, 1.08)
        GUI.OnActivated(EquipBest, function() -- Line: 597 -- upvalues: PetPenCapacityGuidanceController (upval), requestEquipBest (val)
            PetPenCapacityGuidanceController.AcknowledgeEquipBestBadge()
            requestEquipBest()
        end)
        ButtonFX(EquipBest, 1.08)
        Save.WatchFields({"Inventory", "EquippedAssets", "BaseUpgradeLevel", "Gamepasses", "Products"}, refresh)
        Save.Watch("Money"):Connect(function() -- Line: 541 -- upvalues: updateHeader (val), Save (upval), LocalPlayer (val), u70 (ref)
            updateHeader(Save.Await(LocalPlayer), u70)
        end)
        AssetRoster.SnapshotRefreshed:Connect(refresh)
        PetMountFlags.Enabled.Changed:Connect(function() -- Line: 609 -- upvalues: refresh (val)
            task.defer(refresh)
        end)

        local function watchMount(a1) -- Line: 610 -- upvalues: refresh (val) -- types: a1: userdata?
            if a1 == nil then
                return
            end
            a1.ChildAdded:Connect(function(a1) -- Line: 614 -- upvalues: refresh (upval) -- types: a1: userdata
                if a1.Name == "PetMountSession" then
                    task.defer(refresh)
                end
            end)
            a1.ChildRemoved:Connect(function(a1) -- Line: 617 -- upvalues: refresh (upval) -- types: a1: userdata
                if a1.Name == "PetMountSession" then
                    task.defer(refresh)
                end
            end)
        end

        LocalPlayer.CharacterAdded:Connect(watchMount)
        watchMount(LocalPlayer.Character)
        AssetRoster.OwnerRefreshed:Connect(function(a1) -- Line: 623 -- upvalues: LocalPlayer (val), refresh (val) -- types: a1: number
            if a1 == LocalPlayer.UserId then
                refresh()
            end
        end)
        AssetRoster.OwnerCleared:Connect(function(a1) -- Line: 628 -- upvalues: LocalPlayer (val), refresh (val) -- types: a1: number
            if a1 == LocalPlayer.UserId then
                refresh()
            end
        end)
        Remotes.Homestead.BaseTierRaised.OnClientEvent:Connect(function() -- Line: 633 -- upvalues: Toast (upval), u119 (upval), refresh (val)
            Toast.Show({Text = "Successfully upgraded your base!", Seconds = 0.7, Color = u119})
            refresh()
        end)
    end,
}