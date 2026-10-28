-- Script path: ReplicatedStorage.Controllers.GUI.BackpackController.Main
-- Decompile time: 275.00 ms

local Name, u3504, v1, v2, v3
if not game:IsLoaded() then
    game.Loaded:Wait()
end
local u9 = nil
local u10 = nil
local u11 = nil
local v4 = game:GetService("ReplicatedStorage")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local v5 = game:GetService("TweenService")
local Areas = require(v4.Data.Areas)
local v6 = require(v4.Client.GridCellFitter)
local v7 = require(v4.Client.GUI)
local MenuNavigation = require(v4.Client.MenuNavigation)
local HiddenUIHandler = require(v4.Client.HiddenUIHandler)
local InputIconsConfig = require(v4.Client.InputIconsConfig)
local Toast = require(v4.Client.Notifications.Toast)
local PlotState = require(v4.Client.PlotState)
local Tabs = require(v4.Client.Tabs)
RarityDirectory = require(v4.Data.Rarity).Rarities
MutationHandler = require(v4.Shared.Modules.Mutations)
HoverCard = require(v4.Client.HoverCard)
local PlatformController = require(v4.Client.PlatformController)
ButtonHintStrip = require(v4.Client.ButtonHintStrip)
ButtonFX = require(v4.Client.UI.VFX.ButtonFX)
SimpleNumber = require(v4.Packages.FormatNumber.Simple)
local AssetEarnings = require(v4.Shared.Util.AssetEarnings)
local AssetIconShape = require(v4.Client.UI.AssetIconShape)
local AssetItems = require(v4.Shared.Util.AssetItems)
require(v4.Shared.Globals.Constants)
local EggRecords = require(v4.Shared.Util.EggRecords)
local EggSkins = require(v4.Data.EggSkins)
local EggState = require(v4.Client.EggState)
local ItemDisplay = require(v4.Shared.Modules.ItemDisplay)
local v8 = require(v4.Shared.Utils.Preload).WarmAssets
require(v4.Shared.Remotes)
require(v4.Shared.Save)
local ToolGameplayGuard = require(v4.Client.ToolGameplayGuard)
local TreadmillFlags = require(v4.Shared.Flags.TreadmillFlags)
local Trove = require(v4.Packages.Trove)
local SlotDragController = require(script.SlotDragController)
local v9 = require(script.SlotFavoriteController)
local HotbarDragFeedback = require(script.HotbarDragFeedback)
local v10 = {
    {Name = "Pets", Image = "rbxassetid://93714449004895", Tags = {"Asset", "Phone"}},
    {Name = "Eggs", Image = "rbxassetid://116524274262912", Tags = {"AssetEgg", "PetEgg"}},
    {
        Name = "Gear",
        Image = "rbxassetid://78687042850233",
        Tags = {"Gear", "MutationConsumable", "MountStar", "MonsterChest", "ButterflyNet", "TrainPass"},
    },
}
if not v10[1] then
    Name = "Pets"
else
    Name = v10[1].Name
    if not Name then
        Name = "Pets"
    end
end
local u3102 = Name
local SetCategory = nil
local u209 = {}
for i, j in v10 do
    u209[j.Name] = j
end

function IsOfCategory(a1) -- Line: 96 -- upvalues: u209 (val), u3102 (ref)
    if not a1 then
        return false
    end
    local v1 = u209[u3102]
    if v1 and v1.Tags then
        for i, j in v1.Tags do
            if a1:GetAttribute("ItemType") == j then
                return true
            end
        end
        return false
    end
    return false
end

function GetCategory(a1) -- Line: 112 -- upvalues: u209 (val), Name (val)
    local v1 = nil
    local v2 = nil
    for i, j in u209, v1, v2 do
        if j.Tags then
            for k, n in j.Tags do
                if a1:GetAttribute("ItemType") == n then
                    return i
                end
            end
        end
    end
    return Name
end

function HasInventoryCategory(a1) -- Line: 126 -- upvalues: u209 (val)
    local v1 = getAttribute(a1, "ItemType")
    if v1 == nil then
        return false
    end
    local v2 = nil
    local v3 = nil
    for i, j in u209, v2, v3 do
        if j.Tags then
            for k, n in j.Tags do
                if v1 == n then
                    return true
                end
            end
        end
    end
    return false
end

local u3116 = {
    IsOpen = false,
    ModuleName = "Backpack",
    KeepVRTopbarOpen = true,
    VRIsExclusive = true,
    VRClosesNonExclusive = true,
}
u3116.StateChanged = Instance.new("BindableEvent")
local u442 = 60
TextSizeAttribute = script:GetAttribute("TextSize")
_BackgroundTransparencyAttribute = script:GetAttribute("BackgroundTransparency")
BackgroundColorAttribute = script:GetAttribute("BackgroundColor")
DraggableColorAttribute = script:GetAttribute("DraggableColor")
EquippedColorAttribute = script:GetAttribute("EquippedColor")
SlotLockedTransparencyAttribute = script:GetAttribute("SlotLockedTransparency")
BorderColorAttribute = script:GetAttribute("BorderColor")
ToggleHotkeys = {Enum.KeyCode.Backquote, Enum.KeyCode.ButtonSelect}
EmptySlotsAttribute = script:GetAttribute("EmptySlots")
_SearchBoxColorAttribute = script:GetAttribute("SearchBoxColor")
_SearchBoxTransparencyAttribute = script:GetAttribute("SearchBoxTransparency")
ApiEvent = v4:FindFirstChild("Api") or script:WaitForChild("Api")
ApiEvent.Parent = v4
SelectedSlot = nil
BackpackEnabled = true
local u3130 = nil
ActiveFuseSelectionState = nil

function GetViewportSize() -- Line: 199
    local v1 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
    local v2 = Instance.new("Frame", v1)
    v2.BackgroundTransparency = 1
    v2.Size = UDim2.new(1, 0, 1, 0)
    local AbsoluteSize = v2.AbsoluteSize
    v1:Destroy()
    return AbsoluteSize
end

local Value = Enum.KeyCode.Zero.Value
local Value_2 = Enum.KeyCode.Backspace.Value
local u3162 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true,
}
UserInputService = game:GetService("UserInputService")
Players = game:GetService("Players")
PlayerGui = Players.LocalPlayer.PlayerGui
BackpackGui = PlayerGui:WaitForChild("BackpackGui")
ContextActionService = game:GetService("ContextActionService")
VRService = game:GetService("VRService")
Utility = require(script.Utility)
require(script.GameTranslator)
TopBarPlus = require(v4.Packages.TopBarPlus)

local function tryCore(a1, ...) -- Line: 231 -- upvalues: StarterGui (val) -- types: a1: string
    local pack, success, v1
    local v2 = 0.03
    local v3 = nil
    for i = 1, 5 do
        pack = table.pack
        success = pcall(StarterGui[a1], StarterGui, ...)
        v1 = pack(success)
        if v1[1] == true then
            return true, table.unpack(v1, 2, v1.n)
        end
        v3 = v1[2]
        if i < 5 then
            task.wait(v2)
            v2 = v2 * 2
        end
    end
    return false, v3
end

local u3068 = require(v4.Shared.Save)
local u377 = require(v4.Shared.Remotes)
local AssetItems_2 = require(v4.Shared.Util.AssetItems)
AssetDirectoryModule = require(v4.Data.Assets)
AssetDirectory = AssetDirectoryModule.Directory
BaseAssetConfig = AssetDirectoryModule.BaseConfig
local Gears = require(v4.Data.Gears)
TryLock = require(v4.Shared.Utils.TryLock)
Audio = require(v4.Shared.Audio)
local u409 = require(v4.Shared.Globals.Constants)
local v11 = require(v4.Client.AssetRoster)
local u414 = nil
local u3204 = false
CloseButton = nil
InventoryStroke = nil
InventoryStrokeDefaultColor = nil
FuseSelectionVisualTrove = nil
FUSE_SELECTION_ASSET_CATEGORY_NAME = "Pets"
FUSE_SELECTION_BACKGROUND_COLOR = Color3.fromRGB(0, 255, 255)
FUSE_SELECTION_STROKE_COLOR = Color3.fromRGB(0, 183, 186)
FUSE_SELECTION_BACKGROUND_TRANSPARENCY = 0
local u3222 = nil

function v4() -- Line: 272 -- upvalues: HiddenUIHandler (val)
    return not BackpackEnabled or not BackpackGui.Enabled or HiddenUIHandler.IsHidden()
end

local u3240 = GuiService:IsTenFootInterface()
if u3240 then
    u442 = 100
    TextSizeAttribute = 24
end
local u444 = false
local v12 = GetViewportSize()
local v13 = UserInputService.TouchEnabled and v12.X < 1024
local u3254 = u442 * 1.5
local LocalPlayer = Players.LocalPlayer
local u459 = nil
local u460 = nil
local u461 = nil
local u462 = nil
local u468 = Color3.fromRGB(79, 63, 0)
local u469 = nil
local u470 = nil
local u471 = nil
local u472 = nil
local CellSize = nil
local u474 = nil
local AspectRatio = nil
local u476 = nil
local u477 = nil
local ScrollingDirection = nil
local PaddingLeft = nil
local u480 = nil
local v14 = UDim2.fromScale(0.02, 0.04)
local Character = LocalPlayer.Character
if not Character then
    Character = LocalPlayer.CharacterAdded:Wait()
end
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local Backpack = LocalPlayer:WaitForChild("Backpack")
local u3362 = TopBarPlus.new()
u3362:setImage("rbxasset://textures/ui/TopBar/inventoryOff.png", "deselected")
u3362:setImage("rbxasset://textures/ui/TopBar/inventoryOn.png", "selected")
for k, n in ToggleHotkeys do
    u3362:bindToggleKey(n)
end
u3362:setName("InventoryIcon")
u3362:setImageScale(1.12)
u3362:setOrder(-5)
u3362:setCaption("Toggle the backpack.")
u3362.deselectWhenOtherIconSelected = false
local u3376 = {}
local u548 = nil
local u3390 = {}
local u3404 = {}
local u3418 = {}
local u552 = 0
local u553 = false
local u554 = false
local u3432 = false
local u3449 = false
local u3463 = false
local u3477 = false
local u560 = {}
local u3491 = false
local u562 = 0
local VREnabled = VRService.VREnabled
if not VREnabled then
    u3504 = if not v13 then 10 else 5
else
    u3504 = EmptySlotsAttribute
    if not u3504 then
        u3504 = if not v13 then 10 else 5
    end
end
local u575 = if not VREnabled then if not v13 then 4 else 2 else 3
local u577 = TryLock()
local u579 = TryLock()
local u586 = v9.new(BackpackGui)
local u587 = nil
local u588 = {}
local u589 = {}
local u590 = {}
local u591 = {}
local u592 = {}
local u3518 = {}
local u3532 = false
local u3546 = {}
local u596 = {}
local u3560 = {}
local u3574 = {}
local u3588 = {}
local u3602 = false
local u601 = nil
local AutoSell = nil
local u603 = nil
local u604 = nil
local u606 = TryLock()
local u607 = 0
local u608 = false
local u3632 = false
local u3646 = true
local u611 = false
local u3660 = false
local u613 = 0
local u628 = (v7.AutoSell():WaitForChild("Frame")):WaitForChild("Frame")
local u629 = {}
local u630 = {}
local u631 = false
local Template = u628.UIGridLayout.Template
local u634 = nil

function invokeBackpack(a1, ...) -- Line: 396
    local u1 = {}
    u1[1] = ...
    local success, err = pcall(function() -- Line: 398 -- upvalues: a1 (val), u1 (val)
        return {a1:InvokeServer((unpack(u1)))}
    end)
    if success then
        return err
    end
    warn((("[Backpack] Failed to invoke '%*': %*"):format(a1 and a1.Name or "?", err)))
    return nil
end

function isLocalPlayerWithinOwnPlotBounds() -- Line: 406
    -- upvalues: PlotState (val), Character (ref), LocalPlayer (ref)
    local v1 = PlotState.ResolvePlot()
    if not v1 then
        return false
    end
    local Character_2 = Character or LocalPlayer.Character
    if not Character_2 then
        return false
    end
    local HumanoidRootPart = Character_2:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        local BoundingBox, BoundingBox_2 = v1.PlotFolder:GetBoundingBox()
        local v2 = BoundingBox:PointToObjectSpace(HumanoidRootPart.Position)
        local v3 = BoundingBox_2 * 0.5
        local v4 = false
        if (math.abs(v2.X)) <= v3.X then
            v4 = (math.abs(v2.Z)) <= v3.Z
        end
        return v4
    end
    return false
end

function updateEquipBestButtonVisibility() -- Line: 429 -- upvalues: u604 (ref)
    if not u604 then
        return
    end
    u604.Visible = false
end

function requestEquipBestStatusRefresh(a1) -- Line: 437
    -- upvalues: u604 (ref), u3660 (ref), u611 (ref), u613 (ref), u377 (ref), u608 (ref), u3632 (ref), u3646 (ref)
    if u604 and u3660 then
        if u611 then
            return
        end
        local ServerTimeNow = workspace:GetServerTimeNow()
        if a1 ~= true and ServerTimeNow - u613 < 0.5 then
            return
        end
        u613 = ServerTimeNow
        u611 = true
        task.spawn(function() -- Line: 457 -- upvalues: u377 (upval), u611 (upval), u608 (upval), u3632 (upval), u3646 (upval)
            local v1 = invokeBackpack(u377.Haul.FetchWearBestStatus)
            u611 = false
            if not v1 then
                updateEquipBestButtonVisibility()
                return
            end
            u608 = v1[1] == true
            u3632 = true
            u3646 = false
            updateEquipBestButtonVisibility()
        end)
        return
    end
    updateEquipBestButtonVisibility()
end

function invalidateEquipBestStatus(a1) -- Line: 473 -- upvalues: u3646 (ref), u3660 (ref) -- types: a1: boolean?
    u3646 = true
    if u3660 then
        requestEquipBestStatusRefresh(a1)
        return
    end
    updateEquipBestButtonVisibility()
end

function showEquipBestDebounceNotification() -- Line: 482 -- upvalues: Toast (val)
    Toast.Show({
        Text = "Please wait a bit before equipping bests again!",
        Seconds = 2,
        Color = Color3.fromRGB(255, 170, 0),
    })
end

function requestEquipBest() -- Line: 490 -- upvalues: u607 (ref), u606 (val), u377 (ref)
    if workspace:GetServerTimeNow() - u607 < 5 then
        showEquipBestDebounceNotification()
        return
    end
    if not u606(function() -- Line: 497 -- upvalues: u607 (upval), u377 (upval)
        local ServerTimeNow, v0, v1, v2, v3
        ServerTimeNow = workspace:GetServerTimeNow()
        v1 = ServerTimeNow - u607
        if not (v1 < 5) then
            u607 = ServerTimeNow
            v0 = invokeBackpack(u377.Haul.WearBest)
            if v0 then
                v1 = v0[1]
                v2 = v0[2]
                if not v1 then
                    if v2 == "DEBOUNCE" or v2 == "LOCKED" then
                        showEquipBestDebounceNotification()
                    end
                    return
                else
                    invalidateEquipBestStatus(true)
                    return
                end
            else
                return
            end
        else
            showEquipBestDebounceNotification()
            return
        end
    end) then
        showEquipBestDebounceNotification()
    end
end

function applyAutoSellSlot(a1, a2) -- Line: 528 -- upvalues: u629 (val) -- types: a1: string, a2: boolean
    local v1 = u629[a1]
    if not v1 then
        return
    end
    local SelectedGradient = v1.SelectedGradient
    if SelectedGradient then
        SelectedGradient.Enabled = a2
    end
    local RarityGradient = v1.RarityGradient
    if RarityGradient then
        RarityGradient.Enabled = not a2
    end
end

function applyAutoSellMap(a1) -- Line: 545 -- upvalues: u630 (ref), u629 (val) -- types: a1: table
    local v1, v2
    u630 = {}
    for k, v in pairs(a1) do
        if v then
            u630[k] = true
        end
    end
    for k2 in pairs(u629) do
        v1 = applyAutoSellSlot
        v2 = u630[k2] == true
        v1(k2, v2)
    end
end

function serializeAutoSellState() -- Line: 558 -- upvalues: u630 (ref)
    local v1 = {}
    for k, v in pairs(u630) do
        if v then
            v1[k] = true
        end
    end
    return v1
end

function pushAutoSellState() -- Line: 568 -- upvalues: u377 (ref)
    local v1 = serializeAutoSellState()
    local v2 = invokeBackpack(u377.Haul.WriteAutoSell, v1)
    if not v2 then
        return false
    end
    v1 = v2[1]
    local v3 = v2[2]
    if v1 then
        if typeof(v3) == "table" then
            applyAutoSellMap(v3)
        end
        return true
    end
    if typeof(v3) == "string" then
        warn((("[Backpack] Failed to update auto-sell: %*"):format(v3)))
    end
    return false
end

function buildAutoSellSlots(a1) -- Line: 591
    -- upvalues: u629 (val), Template (val), u631 (ref), u630 (ref)
    local DisplayName, Rarity, RarityGradient, Selected, TextButton, TextLabel, _id_2, v1, v2, v3
    local v4 = {}
    for k, v in pairs(AssetDirectory) do
        Rarity = v.Rarity
        if Rarity then
            _id_2 = Rarity._id
            if typeof(_id_2) == "string" then
                v4[_id_2] = Rarity
            end
        end
    end
    local v5 = {}
    for k2, i in pairs(v4) do
        table.insert(v5, i)
    end
    table.sort(v5, function(a1, a2) -- Line: 608
        local Rank_2 = not (typeof(a1.Rank) ~= "number") and a1.Rank or 0
        local Rank_4 = not (typeof(a2.Rank) ~= "number") and a2.Rank or 0
        if Rank_2 ~= Rank_4 then
            return Rank_2 < Rank_4
        end
        local DisplayName_3 = not (typeof(a1.DisplayName) ~= "string") and a1.DisplayName or a1._id
        local DisplayName_4 = not (typeof(a2.DisplayName) ~= "string") and a2.DisplayName or a2._id
        return DisplayName_3 < DisplayName_4
    end)
    for i2, j in ipairs(v5) do
        local _id = j._id
        if not u629[_id] then
            v3 = Template:Clone()
            v3.Visible = true
            v3.Name = _id
            v3.LayoutOrder = not (typeof(j.Rank) ~= "number") and j.Rank or 0
            TextButton = v3.TextButton
            Selected = TextButton.Selected
            if not Selected or not Selected:IsA("UIGradient") then
                Selected = nil
            else
                Selected.Enabled = false
            end
            TextLabel = v3:FindFirstChild("TextLabel")
            v1 = if not TextLabel then nil else if not TextLabel:IsA("TextLabel") then nil else TextLabel
            if v1 then
                DisplayName = j.DisplayName
                if typeof(DisplayName) ~= "string" or DisplayName == "" then
                    v1.Text = _id
                else
                    v1.Text = DisplayName
                end
            end
            v3.Parent = a1
            v1 = nil
            RarityGradient = j.RarityGradient
            if typeof(RarityGradient) == "Instance" then
                v2 = RarityGradient:Clone()
                v2.Name = "RarityGradient"
                v2.Parent = TextButton
                v1 = v2
            end
            for i3, k3 in ipairs(TextButton:GetChildren()) do
                if k3:IsA("UIGradient") then
                    if k3 ~= v1 then
                        k3.Enabled = false
                    else
                        k3.Enabled = true
                    end
                end
            end
            u629[_id] = {Button = TextButton, SelectedGradient = Selected, RarityGradient = v1}
            ButtonFX(TextButton, nil, function() -- Line: 676 -- upvalues: u631 (upval), u630 (upval), _id (val)
                if u631 then
                    return
                end
                local v1 = not (u630[_id] == true)
                u630[_id] = v1
                applyAutoSellSlot(_id, v1)
                u631 = true
                if not pushAutoSellState() then
                    local v2
                    u630[_id] = v2
                    applyAutoSellSlot(_id, v2)
                end
                u631 = false
            end)
        end
    end
end

function initializeAutoSellUI() -- Line: 697 -- upvalues: AutoSell (ref), Tabs (val), u377 (ref), u628 (val)
    local v1 = AutoSell
    ButtonFX(v1, nil, function() -- Line: 698 -- upvalues: Tabs (upval)
        Tabs.Toggle("AutoSell")
    end)
    local v2 = {}
    v1 = invokeBackpack(u377.Haul.FetchAutoSell)
    if v1 then
        local v3 = v1[1]
        if typeof(v3) == "table" then
            for k, v in pairs(v3) do
                if v then
                    v2[k] = true
                end
            end
        end
    end
    buildAutoSellSlots(u628)
    applyAutoSellMap(v2)
end

function claimLowestEmptySlot(a1) -- Line: 717 -- upvalues: u548 (ref), u3504 (val), u3376 (val)
    local v1
    local v2 = u548
    if not v2 or not canToolUseHotbarSlot(a1, v2.Index) then
        return nil
    end
    local v3 = nil
    for i = 1, u3504 do
        v1 = u3376[i]
        if v1 and v1 ~= v2 and not v1.Tool and not v1.IsFakeSlot and canToolUseHotbarSlot(a1, i) then
            v3 = v1
            break
        end
    end
    u548 = v3
    return v2
end

function getInsertableHotbarIndices(a1) -- Line: 745 -- upvalues: u3504 (val), u3376 (val)
    local v1
    local v2 = {}
    for i = 1, u3504 do
        v1 = u3376[i]
        if v1 and not v1.IsFakeSlot and canToolUseHotbarSlot(a1, i) then
            table.insert(v2, i)
        end
    end
    return v2
end

function insertToolIntoFrontHotbar(a1) -- Line: 758 -- upvalues: u3376 (val), u548 (ref)
    local v1, v2
    local v3 = getInsertableHotbarIndices(a1)
    local v4 = v3[1]
    if not v4 then
        return nil
    end
    local v5 = u3376[v4]
    if not v5 then
        return nil
    end
    if v5.Tool and getLockedHotbarSlotForTool(a1) == v4 and canToolUseHotbarSlot(v5.Tool, v4) then
        return nil
    end
    v4 = u548
    if v4 then
        v2 = table.find(v3, v4.Index)
        if v2 then
            local v6, v7
            for i = v2, 2, -1 do
                v6 = u3376[v3[i]]
                v7 = u3376[v3[i - 1]]
                if v6 and v7 then
                    v7:Swap(v6)
                end
            end
            v5:Fill(v1)
            return v5
        end
    end
    v4 = v3[#v3]
    v2 = v4 and u3376[v4]
    if v2 and v2.Tool then
        v2:MoveToInventory()
    end
    for j = #v3, 2, -1 do
        v2 = u3376[v3[j]]
        v4 = u3376[v3[j - 1]]
        if v2 and v4 then
            v4:Swap(v2)
        end
    end
    v5:Fill(v1)
    return v5
end

function _getAssetUID(a1) -- Line: 812
    if typeof(a1) ~= "table" then
        if typeof(a1) == "Instance" then
            return a1:GetAttribute("UID")
        end
        return nil
    end
    if not a1.IsVirtualAsset and not a1.IsVirtualEgg then
        if typeof(a1) == "Instance" then
            return a1:GetAttribute("UID")
        end
        return nil
    end
    return a1.UID
end

function getAttribute(a1, a2) -- Line: 822
    if not a1 then
        return nil
    end
    if typeof(a1) == "table" and a1.GetAttribute then
        return a1:GetAttribute(a2)
    end
    if typeof(a1) == "Instance" then
        return a1:GetAttribute(a2)
    end
    return nil
end

function parseMutations(a1) -- Line: 836
    local v1
    if typeof(a1) == "table" then
        return table.clone(a1)
    end
    if typeof(a1) ~= "string" then
        return {}
    end
    local v2 = {}
    for i in string.gmatch(a1, "[^,]+") do
        v1 = string.match(i, "^%s*(.-)%s*$")
        if v1 ~= "" then
            table.insert(v2, v1)
        end
    end
    return v2
end

function isAssetUIDFavorite(a1) -- Line: 857 -- upvalues: u3068 (ref), AssetItems_2 (val)
    if typeof(a1) == "string" and a1 ~= "" then
        local v1 = u3068.Await()
        local Inventory = v1 and v1.Inventory
        if typeof(if typeof(Inventory) ~= "table" then nil else Inventory[a1]) ~= "table" then
            return false
        end
        return AssetItems_2.Decode(v1).IsFavorite == true
    end
    return false
end

function isToolFavorite(a1) -- Line: 872
    if not isAssetTool(a1) then
        return getAttribute(a1, "Favorite") == true
    end
    local v1 = getAttribute(a1, "Favorite")
    if typeof(v1) == "boolean" then
        return v1
    end
    v1 = getAttribute(a1, "ItemData")
    if typeof(v1) == "table" and v1.IsFavorite == true then
        return true
    end
    return isAssetUIDFavorite(_getAssetUID(a1))
end

function getAssetItemData(a1) -- Line: 890
    local v1 = getAttribute(a1, "ItemData")
    if typeof(v1) == "table" then
        return v1
    end
    v1 = getAttribute(a1, "Category")
    if not v1 then
        return nil
    end
    local v2 = getAttribute(a1, "Scale")
    local v3 = {
        Category = v1,
        Mutations = parseMutations(getAttribute(a1, "Mutations")),
        BaseMutation = getAttribute(a1, "BaseMutation"),
    }
    v3.Scale = not (typeof(v2) ~= "number") and v2 or 1
    v3.IsFavorite = isAssetUIDFavorite(_getAssetUID(a1))
    return v3
end

function getAssetItemDisplayName(a1, a2) -- Line: 912 -- upvalues: ItemDisplay (val)
    local v1
    if typeof(a1) == "table" and typeof(a1.Category) == "string" and AssetDirectory[a1.Category] then
        return ItemDisplay.GetNameFromItemData(a1)
    end
    local DisplayName = if not v1 then nil else a1.DisplayName
    local Category_2 = if not v1 then nil else a1.Category
    return DisplayName or a2 and a2.DisplayName or Category_2 or "Asset"
end

function getAssetItemDisplayNameWithVisualWeight(a1, a2) -- Line: 927 -- upvalues: AssetItems (val)
    return (("%* (%*)"):format(getAssetItemDisplayName(a1, a2), (AssetItems.WeightLabel(a1))))
end

function isAssetTool(a1) -- Line: 932
    return getAttribute(a1, "ItemType") == "Asset"
end

function getGearName(a1) -- Line: 934
    local v1 = getAttribute(a1, "GearName")
    if typeof(v1) == "string" and v1 ~= "" then
        return v1
    end
    return nil
end

function getGearConfig(a1) -- Line: 939 -- upvalues: Gears (val)
    local v1 = getGearName(a1)
    if v1 then
        return Gears.Directory[v1]
    end
    return nil
end

function getToolUses(a1) -- Line: 944
    local v1 = getAttribute(a1, "Uses")
    if typeof(v1) == "number" then
        return (math.max(v1, 0))
    end
    return 0
end

function shouldDisplayToolUses(a1) -- Line: 949
    local v1 = getAttribute(a1, "ItemType")
    if v1 ~= "MutationConsumable" and v1 ~= "MountStar" then
        if v1 ~= "Gear" then
            return false
        end
        v1 = getGearConfig(a1)
        if not v1 then
            return false
        end
        local v2 = false
        if typeof(v1.ActiveDeploymentAttribute) == "string" then
            v2 = v1.ActiveDeploymentAttribute ~= ""
        end
        return v2
    end
    return true
end

function getToolUsesText(a1) -- Line: 967
    return (("x%*"):format((getToolUses(a1))))
end

function getHotbarFillTool(a1) -- Line: 971
    if typeof(a1) ~= "table" then
        return a1
    end
    if not a1.IsVirtualAsset and not a1.IsVirtualEgg then
        return a1
    end
    return a1
end

function virtualAssetMatchesUID(a1, a2) -- Line: 979 -- types: a2: string?
    if typeof(a1) == "table" and a1.IsVirtualAsset and typeof(a2) == "string" then
        return a1.UID == a2
    end
    return false
end

function getVirtualAssetUID(a1) -- Line: 987
    if typeof(a1) == "table" and a1.IsVirtualAsset then
        return a1.UID
    end
    return nil
end

function getVirtualEggUID(a1) -- Line: 995
    if typeof(a1) == "table" and a1.IsVirtualEgg then
        return a1.UID
    end
    return nil
end

function virtualEggSlotMatchesUID(a1, a2) -- Line: 1003 -- types: a2: string
    if a1 and not a1.IsDeleted then
        return getVirtualEggUID(a1.Tool) == a2
    end
    return false
end

function findVirtualEggSlotByUID(a1) -- Line: 1011 -- upvalues: u3376 (val) -- types: a1: string
    for k, v in pairs(u3376) do
        if virtualEggSlotMatchesUID(v, a1) then
            return v
        end
    end
    return nil
end

function clearVirtualEggSlotsByUID(a1) -- Line: 1021 -- upvalues: u3376 (val), u3504 (val) -- types: a1: string
    local v1
    for i = #u3376, 1, -1 do
        v1 = u3376[i]
        if virtualEggSlotMatchesUID(v1, a1) then
            v1:Clear()
            if u3504 < v1.Index then
                v1:Delete()
            end
        end
    end
end

function clearDuplicateVirtualEggSlotsByUID(a1, a2) -- Line: 1033
    -- upvalues: u3376 (val), u3504 (val)
    local v1
    local v2, v3 = a2, a1
    for i = #u3376, 1, -1 do
        v1 = u3376[i]
        if v1 ~= v2 and virtualEggSlotMatchesUID(v1, v3) then
            v1:Clear()
            if u3504 < v1.Index then
                v1:Delete()
            end
        end
    end
end

function getRegisteredBackpackSlot(a1) -- Line: 1045 -- upvalues: u588 (val), u3546 (val), u3390 (val)
    local v1 = getVirtualAssetUID(a1)
    if v1 then
        return u588[v1]
    end
    v1 = getVirtualEggUID(a1)
    if v1 then
        return u3546[v1]
    end
    return u3390[a1]
end

function registeredSlotContainsTool(a1, a2) -- Line: 1059
    if a1 and not a1.IsDeleted then
        local Tool = a1.Tool
        local v1 = getVirtualAssetUID(a2)
        if v1 then
            return getVirtualAssetUID(Tool) == v1
        end
        v1 = getVirtualEggUID(a2)
        if v1 then
            return getVirtualEggUID(Tool) == v1
        end
        return Tool == a2
    end
    return false
end

function unregisterVirtualBackpackSlot(a1, a2) -- Line: 1078
    -- upvalues: u588 (val), u589 (val), u3546 (val), u596 (val)
    local v1 = getVirtualAssetUID(a2)
    if v1 and u588[v1] == a1 then
        u588[v1] = nil
    end
    if v1 and u589[v1] == a2 then
        u589[v1] = nil
    end
    v1 = getVirtualEggUID(a2)
    if v1 and u3546[v1] == a1 then
        u3546[v1] = nil
    end
    if v1 and u596[v1] == a2 then
        u596[v1] = nil
    end
end

function unregisterBackpackSlotTool(a1, a2) -- Line: 1096 -- upvalues: u3390 (val)
    unregisterVirtualBackpackSlot(a1, a2)
    if a2 and u3390[a2] == a1 then
        u3390[a2] = nil
    end
end

function registerVirtualBackpackSlot(a1, a2) -- Line: 1104 -- upvalues: u588 (val), u589 (val), u3546 (val), u596 (val)
    local v1 = getVirtualAssetUID(a2)
    if v1 then
        u588[v1] = a1
        u589[v1] = a2
    end
    v1 = getVirtualEggUID(a2)
    if v1 then
        u3546[v1] = a1
        u596[v1] = a2
    end
end

function createVirtualAsset(a1, a2) -- Line: 1118 -- upvalues: u3068 (ref) -- types: a1: string
    local Category = a2.Category
    local v1 = AssetDirectory[Category] or BaseAssetConfig
    local u9 = table.clone(a2)
    local u14 = getAssetItemDisplayName(u9, v1)
    return {
        IsVirtualAsset = true,
        ToolTip = "",
        UID = a1,
        Name = u14,
        TextureId = v1.Icon or "",
        GetAttribute = function(a1_2, a2) -- Line: 1130 -- upvalues: a1 (val), Category (val), u14 (val), u9 (val), u3068 (upval)
            if a2 == "ItemType" then
                return "Asset"
            end
            if a2 == "UID" then
                return a1
            end
            if a2 == "Category" then
                return Category
            end
            if a2 == "DisplayName" then
                return u14
            end
            if a2 == "Mutations" then
                return table.concat(u9.Mutations or {}, ", ")
            end
            if a2 == "BaseMutation" then
                return u9.BaseMutation
            end
            if a2 == "Scale" then
                return u9.Scale
            end
            if a2 == "ItemData" then
                return u9
            end
            if a2 ~= "Favorite" then
                return nil
            end
            local v1 = u3068.Await()
            if v1 and typeof(v1.Inventory) == "table" then
                return isAssetUIDFavorite(a1)
            end
            return u9.IsFavorite == true
        end,
        IsA = function(a1, a2) -- Line: 1158
            return a2 == "Tool"
        end,
    }
end

function isAssetUIDPlaced(a1) -- Line: 1162 -- upvalues: u590 (ref)
    local v1 = false
    if typeof(a1) == "string" then
        v1 = u590[a1] == true
    end
    return v1
end

function hasLocalAssetToolUID(a1) -- Line: 1166 -- types: a1: string
    return findAssetToolByUID(a1) ~= nil
end

function refreshPlacedAssetUIDs(a1) -- Line: 1168 -- upvalues: u590 (ref)
    local v1 = {}
    for k in pairs(a1) do
        if typeof(k) == "string" then
            v1[k] = true
        end
    end
    u590 = v1
end

function assetSignatureField(a1) -- Line: 1179
    if a1 == nil then
        return ""
    end
    return (tostring(a1))
end

function getAssetItemSignature(a1) -- Line: 1187
    return table.concat({
        assetSignatureField(a1.Category),
        table.concat(a1.Mutations or {}, ","),
        assetSignatureField(a1.BaseMutation),
        assetSignatureField(a1.Scale),
        assetSignatureField(a1.Gender),
        assetSignatureField(a1.EyeColor),
        assetSignatureField(a1.ColorSeed),
        assetSignatureField(a1.ColorIndex),
        assetSignatureField(a1.GeneratedMoney),
        assetSignatureField(a1.PendingEggName),
        assetSignatureField(a1.Claimed),
        (assetSignatureField(a1.HasBeenFirstPlaced)),
    }, "\031")
end

function buildEligibleAssetDataFromSave() -- Line: 1204 -- upvalues: u3068 (ref), AssetItems_2 (val)
    local v1 = u3068.Await()
    if v1 and typeof(v1.Inventory) == "table" then
        local EquippedAssets, find, v2, v3
        local v4 = {}
        local v5 = {}
        for k, v in pairs(v1.Inventory) do
            if typeof(k) == "string" and typeof(v) == "table" then
                v2 = AssetItems_2.Decode(v)
                find = table.find
                EquippedAssets = v1.EquippedAssets or {}
                v3 = find(EquippedAssets, k) ~= nil
                if v2.InFuse ~= true then
                    if not v3 then
                        if not isAssetUIDPlaced(k) then
                            v4[k] = v2
                            v5[k] = (getAssetItemSignature(v2))
                        end
                    elseif hasLocalAssetToolUID(k) and not isAssetUIDPlaced(k) then
                        v4[k] = v2
                        v5[k] = (getAssetItemSignature(v2))
                    end
                end
            end
        end
        return v4, v5
    end
    return {}, {}
end

function isSerializedAssetEligibleForBackpack(a1, a2) -- Line: 1234 -- upvalues: AssetItems_2 (val), u3068 (ref)
    if typeof(a2) ~= "table" then
        return false
    end
    local v1 = AssetItems_2.Decode(a2)
    local v2 = u3068.Await()
    local v3 = v2
    if v3 then
        local find = table.find
        local EquippedAssets = v2.EquippedAssets or {}
        v3 = find(EquippedAssets, a1) ~= nil
    end
    if v1.InFuse ~= true then
        if v3 and not hasLocalAssetToolUID(a1) then
            return false
        end
        if not isAssetUIDPlaced(a1) then
            return true
        end
    end
    return false
end

function captureEligibleAssetUIDs() -- Line: 1253 -- upvalues: u3068 (ref)
    local v1 = u3068.Await()
    local v2 = {}
    if v1 and typeof(v1.Inventory) == "table" then
        for k, v in pairs(v1.Inventory) do
            if typeof(k) == "string" and isSerializedAssetEligibleForBackpack(k, v) then
                v2[k] = true
            end
        end
        return v2
    end
    return v2
end

function queueNewEligibleAssetsForHotbar(a1, a2) -- Line: 1273 -- upvalues: u592 (val)
    for k in pairs(a2) do
        if a1[k] ~= true then
            u592[k] = true
        end
    end
end

function getEggConfigForRecord(a1) -- Line: 1281
    if typeof(a1) == "table" and typeof(a1.AssetCategory) == "string" then
        local v1 = AssetDirectory[a1.AssetCategory]
        if not v1 then
            return nil, nil
        end
        return v1.Egg, v1
    end
    return nil, nil
end

function getAreaForEggRecord(a1) -- Line: 1294 -- upvalues: Areas (val)
    local v1
    _, v1 = getEggConfigForRecord(a1)
    if v1 and v1.Rarity then
        local AssetCategory = a1.AssetCategory
        local _id = v1.Rarity._id or v1.Rarity.DisplayName
        for k, v in pairs(Areas.Directory) do
            for i, i2 in ipairs(v.DropTable) do
                v1 = i2[1]
                if v1 ~= AssetCategory and v1 ~= _id then
                    continue
                end
                return v
            end
        end
        return nil
    end
    return nil
end

function getEggDisplayName(a1) -- Line: 1314 -- upvalues: EggSkins (val)
    local v1 = EggSkins.Get(a1.EggSkin)
    if v1 then
        return v1.DisplayName
    end
    v1 = MutationHandler.EggDisplayName(a1.Mutations, a1.BaseMutation)
    if v1 then
        return v1
    end
    v1 = getAreaForEggRecord(a1)
    if v1 then
        return (("%* Egg"):format(v1.DisplayName))
    end
    return "Egg"
end

function getEggDisplayNameWithWeight(a1) -- Line: 1333 -- upvalues: EggRecords (val)
    return (("%* (%*)"):format(getEggDisplayName(a1), (EggRecords.WeightLabel(a1))))
end

function getEggIconForRecord(a1, a2) -- Line: 1338 -- upvalues: EggSkins (val)
    if typeof(a1) == "table" then
        local v1 = EggSkins.Get(a1.EggSkin)
        if v1 then
            return v1.Icon
        end
        v1 = MutationHandler.EggIcon(a1.Mutations, a1.BaseMutation)
        if v1 and v1 ~= "" then
            return v1
        end
    end
    return a2 and a2.Icon or ""
end

function isRobuxEgg(a1, a2) -- Line: 1353 -- upvalues: u3068 (ref)
    local v1
    local PurchaseId = if typeof(a1) ~= "table" then nil else a1.PurchaseId
    if PurchaseId == nil and a2 ~= nil then
        v1 = getAttribute(a2, "UID")
        local v2 = u3068.Peek()
        local EggInventory = v2 and v2.EggInventory
        v2 = if typeof(v1) ~= "string" then nil else if typeof(EggInventory) ~= "table" then nil else EggInventory[v1]
        PurchaseId = if typeof(v2) ~= "table" then nil else v2.PurchaseId
    end
    v1 = false
    if typeof(PurchaseId) == "string" then
        v1 = PurchaseId ~= ""
    end
    return v1
end

function getEggRecordFromTool(a1) -- Line: 1367
    local v1 = getAttribute(a1, "EggRecord")
    if typeof(v1) == "table" then
        return v1
    end
    v1 = getAttribute(a1, "AssetCategory") or getAttribute(a1, "Category")
    local v2 = getAttribute(a1, "AssetScale") or getAttribute(a1, "Scale")
    if typeof(v1) == "string" and typeof(v2) == "number" then
        return {
            AssetCategory = v1,
            AssetScale = v2,
            Mutations = parseMutations(getAttribute(a1, "Mutations")),
            BaseMutation = getAttribute(a1, "BaseMutation"),
            EggSkin = getAttribute(a1, "EggSkin"),
        }
    end
    return nil
end

function createVirtualEgg(a1, a2) -- Line: 1388 -- upvalues: EggRecords (val) -- types: a1: string
    local v1, v2 = getEggConfigForRecord(a2)
    if v1 and v2 then
        local u8 = getEggDisplayNameWithWeight(a2)
        local u12 = EggRecords.WeightKg(a2)
        return {
            IsVirtualEgg = true,
            UID = a1,
            Name = u8,
            TextureId = getEggIconForRecord(a2, v1),
            ToolTip = u8,
            GetAttribute = function(a1_2, a2_2) -- Line: 1402 -- upvalues: a1 (val), a2 (val), u8 (val), u12 (val)
                if a2_2 == "ItemType" then
                    return "AssetEgg"
                end
                if a2_2 == "UID" then
                    return a1
                end
                if a2_2 ~= "AssetCategory" and a2_2 ~= "Category" then
                    if a2_2 == "DisplayName" or a2_2 == "EggDisplayName" then
                        return u8
                    end
                    if a2_2 == "EggRecord" then
                        return table.clone(a2)
                    end
                    if a2_2 == "Mutations" then
                        return table.concat(a2.Mutations or {}, ", ")
                    end
                    if a2_2 == "BaseMutation" then
                        return a2.BaseMutation
                    end
                    if a2_2 ~= "Weight" and a2_2 ~= "WeightKg" then
                        if a2_2 == "Favorite" then
                            return false
                        end
                        return nil
                    end
                    return u12
                end
                return a2.AssetCategory
            end,
            IsA = function(a1, a2) -- Line: 1427
                return a2 == "Tool"
            end,
        }
    end
    return nil
end

function buildVirtualEggsFromSave() -- Line: 1431 -- upvalues: u3068 (ref)
    local v1
    local v2 = u3068.Await()
    local EggInventory = v2 and v2.EggInventory
    v2 = {}
    if typeof(EggInventory) ~= "table" then
        return v2
    end
    for k, v in pairs(EggInventory) do
        if typeof(k) == "string" and typeof(v) == "table" and v.Placement == nil then
            v1 = createVirtualEgg(k, v)
            if v1 then
                v2[k] = v1
            end
        end
    end
    return v2
end

function captureEggUIDs() -- Line: 1453 -- upvalues: u3068 (ref)
    local v1 = u3068.Await()
    local EggInventory = v1 and v1.EggInventory
    v1 = {}
    if typeof(EggInventory) ~= "table" then
        return v1
    end
    for k, v in pairs(EggInventory) do
        if typeof(k) == "string" and typeof(v) == "table" and v.Placement == nil then
            v1[k] = true
        end
    end
    return v1
end

function queueNewEggsForHotbar(a1, a2) -- Line: 1470 -- upvalues: u3560 (val)
    for k in pairs(a2) do
        if not a1[k] then
            u3560[k] = true
        end
    end
end

function clearInstanceAssetSlots() -- Line: 1478 -- upvalues: u3376 (val), u3504 (val)
    local Tool
    local v1 = false
    for k, v in pairs(u3376) do
        Tool = v and v.Tool
        if v and typeof(Tool) == "Instance" and Tool:IsA("Tool") and isAssetTool(Tool) then
            v:Clear()
            v1 = true
            if u3504 < v.Index then
                v:Delete()
            end
        end
    end
    return v1
end

function clearPlacedAssetBackpackSlot(a1) -- Line: 1494
    -- upvalues: u592 (val), u591 (val), u3376 (val), u3504 (val), u588 (val), u589 (val)
    local Tool, v1
    local v2 = false
    u592[a1] = nil
    u591[a1] = nil
    for i = #u3376, 1, -1 do
        v1 = u3376[i]
        Tool = v1 and v1.Tool
        if v1 and Tool and getAttribute(Tool, "ItemType") == "Asset" and _getAssetUID(Tool) == a1 then
            v1:Clear()
            v2 = true
            if u3504 < v1.Index then
                v1:Delete()
            end
        end
    end
    u588[a1] = nil
    u589[a1] = nil
    return v2
end

function clearPlacedAssetBackpackSlots(a1) -- Line: 1521
    local v1 = false
    for k in pairs(a1) do
        if typeof(k) == "string" and clearPlacedAssetBackpackSlot(k) then
            v1 = true
        end
    end
    return v1
end

function syncAssetsFromSave() -- Line: 1532 -- upvalues: u470 (ref), u588 (val), u3504 (val), u591 (val), u589 (val)
    local v1, v2, v3
    if not u470 then
        return false
    end
    local v4, v5 = buildEligibleAssetDataFromSave()
    local v6 = clearInstanceAssetSlots()
    for k, v in pairs(u588) do
        if not v4[k] then
            if v and not v.IsDeleted then
                v:Clear()
                if u3504 < v.Index then
                    v:Delete()
                end
            end
            u588[k] = nil
            u591[k] = nil
            v6 = true
        end
    end
    for k2, i in pairs(v4) do
        v2 = v5[k2]
        v3 = u588[k2]
        v1 = v3 and not v3.IsDeleted and virtualAssetMatchesUID(v3.Tool, k2)
        if not v1 or u591[k2] ~= v2 then
            if not v1 then
                v3 = FindEmptyInventorySlot() or MakeSlot(u470)
            end
            u588[k2] = v3
            u589[k2] = (createVirtualAsset(k2, i))
            u591[k2] = v2
            v3:Fill(u589[k2])
            v6 = true
        elseif v3 then
            u589[k2] = v3.Tool
            u591[k2] = v2
            if v3.UpdateFavoriteVisual and v3:UpdateFavoriteVisual() then
                v6 = true
            end
        end
    end
    for k3 in pairs(u589) do
        if not v4[k3] then
            u589[k3] = nil
        end
    end
    if v6 then
        AdjustHotbarFrames()
        UpdateInventorySlots()
    end
    return v6
end

function syncEggsFromSave() -- Line: 1590 -- upvalues: u470 (ref), u3546 (val), u596 (val)
    local v1
    if not u470 then
        return
    end
    local v2 = buildVirtualEggsFromSave()
    for k in pairs(u3546) do
        if not v2[k] then
            clearVirtualEggSlotsByUID(k)
            u3546[k] = nil
        end
    end
    for k2, v in pairs(v2) do
        v1 = u3546[k2]
        if not virtualEggSlotMatchesUID(v1, k2) then
            v1 = findVirtualEggSlotByUID(k2)
        end
        if not v1 or v1.IsDeleted then
            v1 = FindEmptyInventorySlot() or MakeSlot(u470)
        end
        u3546[k2] = v1
        u596[k2] = v
        clearDuplicateVirtualEggSlotsByUID(k2, v1)
        v1:Fill(v)
    end
    for k3 in pairs(u596) do
        if not v2[k3] then
            u596[k3] = nil
        end
    end
    AdjustHotbarFrames()
    UpdateInventorySlots()
end

function getAssetRarityNumber(a1) -- Line: 1629
    local v1 = getAttribute(a1, "Category")
    local v2 = v1 and AssetDirectory[v1] or BaseAssetConfig
    local Rarity = v2 and v2.Rarity
    if Rarity then
        if Rarity.Rank then
            return Rarity.Rank
        end
        if RarityDirectory[Rarity] and RarityDirectory[Rarity].Rank then
            return RarityDirectory[Rarity].Rank
        end
    end
    return (1 / 0)
end

function getAssetDropWeight(a1) -- Line: 1645
    local v1 = getAttribute(a1, "Category")
    local v2 = v1 and AssetDirectory[v1] or BaseAssetConfig
    if v2 and typeof(v2.DropWeight) == "number" then
        return v2.DropWeight
    end
    return (1 / 0)
end

function getAssetOddsDenominator(a1) -- Line: 1656
    if getAttribute(a1, "ItemType") ~= "Asset" then
        return 0
    end
    local v1 = getAttribute(a1, "Category")
    local v2 = v1 and AssetDirectory[v1] or BaseAssetConfig
    local DropWeight = v2 and v2.DropWeight
    if typeof(DropWeight) == "number" and not (DropWeight <= 0) then
        v2 = getAssetItemData(a1)
        if not v2 then
            return 0
        end
        return 1 / DropWeight * MutationHandler.RarityFactorFor(v2.Mutations, v2.BaseMutation)
    end
    return 0
end

function getAssetEarningRate(a1) -- Line: 1677 -- upvalues: AssetEarnings (val)
    if getAttribute(a1, "ItemType") ~= "Asset" then
        return 0
    end
    local v1 = getAssetItemData(a1)
    if not v1 then
        return 0
    end
    return AssetEarnings.MutationOnlyRatePerSecond(v1)
end

function getEggAssetConfig(a1) -- Line: 1690
    local v1
    local v2 = getEggRecordFromTool(a1)
    _, v1 = getEggConfigForRecord(v2)
    if v1 then
        return v1
    end
    v1 = getAttribute(a1, "AssetCategory") or getAttribute(a1, "Category")
    return v1 and AssetDirectory[v1] or nil
end

function getEggRarityNumber(a1) -- Line: 1701
    local v1 = getEggAssetConfig(a1)
    local Rarity = v1 and v1.Rarity
    if Rarity then
        if Rarity.Rank then
            return Rarity.Rank
        end
        if RarityDirectory[Rarity] and RarityDirectory[Rarity].Rank then
            return RarityDirectory[Rarity].Rank
        end
    end
    return (1 / 0)
end

function getEggBaseEarningRate(a1) -- Line: 1716
    local v1 = getEggAssetConfig(a1)
    if v1 and typeof(v1.EarningRate) == "number" then
        return v1.EarningRate
    end
    return 0
end

function requestFavoriteToggle(a1) -- Line: 1721 -- upvalues: u579 (val), u377 (ref)
    if ActiveFuseSelectionState or not isAssetTool(a1) then
        return
    end
    local u7 = _getAssetUID(a1)
    if typeof(u7) == "string" and u7 ~= "" then
        local u14 = not isToolFavorite(a1)
        u579(function() -- Line: 1736 -- upvalues: u377 (upval), u7 (val), u14 (val)
            u377.PetSatchel.WriteFavourite:FireServer(u7, u14)
        end)
        return
    end
end

function getStackQuantity(a1) -- Line: 1739
    local v1 = getAttribute(a1, "StackQuantity")
    if typeof(v1) == "number" and v1 > 1 then
        return (math.floor(v1))
    end
    return 1
end

function clearMutationIconFrame(a1, a2) -- Line: 1748 -- types: a1: userdata?, a2: userdata?
    if a1 and a2 then
        for i, v in ipairs(a1:GetChildren()) do
            if v:IsA("ImageLabel") and v ~= a2 then
                v:Destroy()
            end
        end
        a1.Visible = false
        return
    end
end

function populateMutationIconFrame(a1, a2, a3, a4) -- Line: 1762
    -- upvalues: 
    if a1 and a2 then
        clearMutationIconFrame(a1, a2)
        a1.Visible = false
        return
    end
end

function updateEquipSelectionVisuals() -- Line: 1777 -- upvalues: u3376 (val)
    for k, v in pairs(u3376) do
        if v then
            v:UpdateEquipView()
        end
    end
end

function findVirtualAssetSlotContainingUID(a1) -- Line: 1785 -- upvalues: u3376 (val) -- types: a1: string
    for k, v in pairs(u3376) do
        if v and virtualAssetMatchesUID(v.Tool, a1) then
            return v
        end
    end
    return nil
end

function getCharacterAssetToolUID() -- Line: 1795 -- upvalues: Character (ref)
    local Attribute
    for i, v in ipairs(Character:GetChildren()) do
        if v:IsA("Tool") and v:GetAttribute("ItemType") == "Asset" then
            Attribute = v:GetAttribute("UID")
            if typeof(Attribute) == "string" then
                return Attribute
            end
        end
    end
    return nil
end

function findAssetToolByUID(a1) -- Line: 1808 -- upvalues: Character (ref), Backpack (ref) -- types: a1: string
    local function searchContainer(a1_2) -- Line: 1809 -- upvalues: a1 (val)
        if not a1_2 then
            return nil
        end
        for i, v in ipairs(a1_2:GetChildren()) do
            if v:IsA("Tool") and v:GetAttribute("ItemType") == "Asset" and (v:GetAttribute("UID")) == a1 then
                return v
            end
        end
        return nil
    end

    local v1 = searchContainer(Character)
    if v1 then
        return v1
    end
    v1 = searchContainer(Backpack)
    if v1 then
        return v1
    end
    return nil
end

function applyVirtualAssetEquipUID(a1) -- Line: 1840 -- upvalues: u587 (ref) -- types: a1: string?
    u587 = a1
    if typeof(a1) == "string" then
        SelectedSlot = findVirtualAssetSlotContainingUID(a1)
    elseif SelectedSlot and getAttribute(SelectedSlot.Tool, "ItemType") == "Asset" then
        SelectedSlot = nil
    end
    updateEquipSelectionVisuals()
end

function reconcileVirtualAssetEquipState() -- Line: 1851 -- upvalues: u587 (ref)
    local v1 = getCharacterAssetToolUID()
    if v1 ~= u587 then
        applyVirtualAssetEquipUID(v1)
        return v1
    end
    if typeof(v1) == "string" and not SelectedSlot then
        SelectedSlot = findVirtualAssetSlotContainingUID(v1)
        updateEquipSelectionVisuals()
    end
    return v1
end

function syncVirtualAssetEquipStateFromTool(a1) -- Line: 1863
    -- upvalues: Character (ref), Backpack (ref), u587 (ref)
    local Attribute = a1:GetAttribute("UID")
    if typeof(Attribute) ~= "string" then
        return
    end
    if a1.Parent == Character then
        applyVirtualAssetEquipUID(Attribute)
        return
    end
    if a1.Parent == Backpack and u587 == Attribute then
        task.defer(reconcileVirtualAssetEquipState)
    end
end

function getCharacterEggToolUID() -- Line: 1876 -- upvalues: Character (ref)
    local Attribute
    for i, v in ipairs(Character:GetChildren()) do
        if v:IsA("Tool") and v:GetAttribute("ItemType") == "AssetEgg" then
            Attribute = v:GetAttribute("UID")
            if typeof(Attribute) == "string" then
                return Attribute
            end
        end
    end
    return nil
end

function applyVirtualEggEquipUID(a1) -- Line: 1889 -- upvalues: u601 (ref) -- types: a1: string?
    u601 = a1
    if typeof(a1) == "string" then
        SelectedSlot = findVirtualEggSlotByUID(a1)
    elseif SelectedSlot and getAttribute(SelectedSlot.Tool, "ItemType") == "AssetEgg" then
        SelectedSlot = nil
    end
    updateEquipSelectionVisuals()
end

function reconcileVirtualEggEquipState() -- Line: 1900 -- upvalues: u601 (ref)
    local v1 = getCharacterEggToolUID()
    if v1 ~= u601 then
        applyVirtualEggEquipUID(v1)
        return v1
    end
    if typeof(v1) == "string" and not SelectedSlot then
        SelectedSlot = findVirtualEggSlotByUID(v1)
        updateEquipSelectionVisuals()
    end
    return v1
end

function syncVirtualEggEquipStateFromTool(a1) -- Line: 1912
    -- upvalues: Character (ref), Backpack (ref), u601 (ref)
    local Attribute = a1:GetAttribute("UID")
    if typeof(Attribute) ~= "string" then
        return
    end
    if a1.Parent == Character then
        applyVirtualEggEquipUID(Attribute)
        return
    end
    if a1.Parent == Backpack and u601 == Attribute then
        task.defer(reconcileVirtualEggEquipState)
    end
end

function requestUnequipVirtualEgg() -- Line: 1925 -- upvalues: u601 (ref), u577 (val), EggState (val), Toast (val)
    reconcileVirtualEggEquipState()
    if not u601 then
        return true
    end
    local u4 = false
    u577(function() -- Line: 1932 -- upvalues: u601 (upval), EggState (upval), u4 (ref), Toast (upval)
        local v1 = u601
        local v2, v3 = EggState.DoffEggTool(v1)
        if not v2 then
            if v3 then
                Toast.Show({Seconds = 2, Text = v3, Color = Color3.fromRGB(255, 64, 64)})
            end
            return
        end
        u601 = nil
        if SelectedSlot and getAttribute(SelectedSlot.Tool, "UID") == v1 then
            SelectedSlot = nil
        end
        updateEquipSelectionVisuals()
        u4 = true
    end)
    return u4
end

function requestEquipVirtualEgg(a1, a2) -- Line: 1957
    -- upvalues: HiddenUIHandler (val), u577 (val), Humanoid (ref), EggState (val), u601 (ref), Toast (val)
    if not BackpackEnabled or not BackpackGui.Enabled or HiddenUIHandler.IsHidden() then
        return
    end
    if reconcileVirtualEggEquipState() ~= a1 then
        u577(function() -- Line: 1968
            -- upvalues: Humanoid (upval), EggState (upval), a1 (val), u601 (upval), a2 (val), Toast (upval)
            requestUnequipVirtualAsset()
            if Humanoid then
                Humanoid:UnequipTools()
            end
            local v1, v2 = EggState.WearEggTool(a1)
            if not v1 then
                if v2 then
                    Toast.Show({Seconds = 2, Text = v2, Color = Color3.fromRGB(255, 64, 64)})
                end
                return
            end
            u601 = a1
            SelectedSlot = a2
            updateEquipSelectionVisuals()
        end)
        return
    end
    SelectedSlot = a2
    updateEquipSelectionVisuals()
end

function requestUnequipVirtualAsset() -- Line: 1992 -- upvalues: u587 (ref), u577 (val), u377 (ref), Toast (val)
    reconcileVirtualAssetEquipState()
    if not u587 then
        return true
    end
    local u4 = false
    u577(function() -- Line: 1999 -- upvalues: u587 (upval), u377 (upval), u4 (ref), Toast (upval)
        local v1 = u587
        local v2, v3 = u377.PenRoster.AskDoff:InvokeServer(v1)
        if v2 == false then
            if v3 and v3 ~= "Asset is not available." then
                Toast.Show({Seconds = 2, Text = v3, Color = Color3.fromRGB(255, 64, 64)})
            end
            return
        end
        u587 = nil
        if SelectedSlot and virtualAssetMatchesUID(SelectedSlot.Tool, v1) then
            SelectedSlot = nil
        end
        updateEquipSelectionVisuals()
        u4 = true
    end)
    return u4
end

function addVirtualAssetOverlay(a1, a2, a3, a4, a5) -- Line: 2024
    -- upvalues: AssetEarnings (val), ItemDisplay (val), AssetItems (val)
    local DisplayName
    if not a1:GetAttribute("IsInventorySlot") and not a5 then
        return
    end
    if a1:GetAttribute("HasAssetOverlay") and not a5 then
        return
    end
    if not a3.Rarity then
        DisplayName = "Unknown"
    else
        DisplayName = a3.Rarity.DisplayName
        if not DisplayName then
            DisplayName = a3.Rarity._id
            if not DisplayName then
                DisplayName = a3.Rarity.Name
            end
        end
    end
    local u32 = getAssetItemDisplayName(a2, a3)
    local u50 = if typeof(a2) ~= "table" then AssetEarnings.ComputeBaseRateFromDropWeight(a3.DropWeight) else if typeof(a2.Category) ~= "string" then AssetEarnings.ComputeBaseRateFromDropWeight(a3.DropWeight) else if not AssetDirectory[a2.Category] then AssetEarnings.ComputeBaseRateFromDropWeight(a3.DropWeight) else AssetEarnings.MutationOnlyRatePerSecond(a2)
    local u64 = if typeof(a2) ~= "table" then nil else if typeof(a2.Mutations) ~= "table" then nil else ItemDisplay.GetMutationRichTextLine(a2.Mutations, a2.BaseMutation)
    local u80 = if typeof(a2) ~= "table" or typeof(a2.Category) ~= "string" then nil else if typeof(a2.Scale) ~= "number" then nil else AssetItems.WeightLabel(a2)
    local v1 = HoverCard.Attach(a1, function() -- Line: 2057 -- upvalues: a1 (val), u32 (val), DisplayName (val), u50 (val), u80 (val), u64 (val)
        if not a1:GetAttribute("IsInventorySlot") then
            return nil
        end
        local v1 = {
            {kind = "heading", text = u32},
            {kind = "rule"},
            {kind = "tier", rarity = DisplayName},
            {kind = "rule"},
            {
                kind = "heading",
                text = "$" .. (SimpleNumber.FormatCompact(u50, ".#")) .. "/s",
                tint = Color3.new(0, 1, 0),
            },
        }
        if u80 then
            table.insert(v1, 2, {kind = "body", text = u80})
        end
        if u64 then
            table.insert(v1, {kind = "rule"})
            table.insert(v1, {kind = "body", text = u64})
        end
        return v1
    end)
    if a4 then
        a4:Add(v1)
    end
    a1:SetAttribute("HasAssetOverlay", true)
end

function addVirtualEggOverlay(a1, a2, a3, a4) -- Line: 2091 -- types: a1: userdata
    local DisplayName, v1
    if not a1:GetAttribute("IsInventorySlot") or a1:GetAttribute("HasEggOverlay") then
        return
    end
    local u14 = getEggDisplayNameWithWeight(a2)
    _, v1 = getEggConfigForRecord(a2)
    local Rarity = v1 and v1.Rarity
    local u31 = false
    if v1 ~= nil then
        u31 = true
        if v1.Egg.HideRarity ~= true then
            u31 = isRobuxEgg(a2, a4)
        end
    end
    if not Rarity then
        DisplayName = "Egg"
    else
        DisplayName = Rarity.DisplayName
        if not DisplayName then
            DisplayName = Rarity._id
            if not DisplayName then
                DisplayName = Rarity.Name
            end
        end
    end
    local Color = if not Rarity then nil else if isRobuxEgg(a2) then nil else Rarity.Color
    local v2 = HoverCard.Attach(a1, function() -- Line: 2108 -- upvalues: a1 (val), u14 (val), u31 (val), DisplayName (val), Color (val)
        if not a1:GetAttribute("IsInventorySlot") then
            return nil
        end
        local v1 = {{kind = "heading", text = u14}}
        if not u31 then
            table.insert(v1, {kind = "rule"})
            table.insert(v1, {kind = "heading", text = DisplayName, tint = Color})
        end
        return v1
    end)
    if a3 then
        a3:Add(v2)
    end
    a1:SetAttribute("HasEggOverlay", true)
end

function NewGui(a1, a2) -- Line: 2131
    local v1 = Instance.new(a1)
    v1.Name = a2
    v1.BackgroundColor3 = Color3.new(0, 0, 0)
    v1.BackgroundTransparency = 1
    v1.BorderColor3 = Color3.new(0, 0, 0)
    v1.BorderSizePixel = 0
    v1.Size = UDim2.new(1, 0, 1, 0)
    if a1:match("Text") then
        v1.TextColor3 = Color3.new(1, 1, 1)
        v1.Text = ""
        v1.FontFace = script:GetAttribute("LabelFont")
        v1.TextSize = TextSizeAttribute
        v1.TextWrapped = true
        if a1 == "TextButton" then
            v1.FontFace = script:GetAttribute("SlotFont")
        end
    end
    return v1
end

function FindLowestEmpty(a1) -- Line: 2151 -- upvalues: u3504 (val), u3376 (val)
    local v1
    for i = 1, u3504 do
        v1 = u3376[i]
        if v1 and not v1.IsFakeSlot and not v1.Tool and canToolUseHotbarSlot(a1, i) then
            return v1
        end
    end
    return nil
end

function FindEmptyInventorySlot() -- Line: 2165 -- upvalues: u3504 (val), u3376 (val)
    local v1
    local v2 = u3504 + 1
    local v3 = #u3376
    for i = v2, v3 do
        v1 = u3376[i]
        if v1 and not v1.Tool then
            return v1
        end
    end
    return nil
end

function cancelPendingBackpackRoundRestore() -- Line: 2175 -- upvalues: u634 (ref)
    if u634 then
        task.cancel(u634)
        u634 = nil
    end
end

function moveRestrictedHotbarToolsToInventory() -- Line: 2182 -- upvalues: u3504 (val), u3376 (val)
    local v1
    for i = 1, u3504 do
        v1 = u3376[i]
        if v1 and not v1.IsFakeSlot and v1.Tool and not isToolLockedToCurrentHotbarSlot(v1) then
            v1:MoveToInventory()
        end
    end
end

function isGearTool(a1) -- Line: 2191
    local v1 = true
    if getAttribute(a1, "ItemType") ~= "Gear" then
        v1 = typeof((getAttribute(a1, "GearName"))) == "string"
    end
    return v1
end

function isPhoneTool(a1) -- Line: 2196
    return getAttribute(a1, "ItemType") == "Phone"
end

function isBatGearTool(a1) -- Line: 2198
    local v1 = getGearConfig(a1)
    local v2 = false
    if v1 ~= nil then
        v2 = true
        if getGearName(a1) ~= "Bat" then
            v2 = v1.IndexBatTier ~= nil
        end
    end
    return v2
end

function isTrapGearTool(a1) -- Line: 2203
    return getGearName(a1) == "Trap"
end

function getLockedHotbarSlotForTool(a1) -- Line: 2205 -- upvalues: TreadmillFlags (val)
    if typeof(a1) == "Instance" and a1:IsA("Tool") then
        if isPhoneTool(a1) and TreadmillFlags.PhoneEnabled:Get() then
            return 3
        end
        if not isGearTool(a1) then
            return nil
        end
        if isBatGearTool(a1) then
            return 1
        end
        if isTrapGearTool(a1) then
            return 2
        end
        return nil
    end
    return nil
end

function canToolUseHotbarSlot(a1, a2) -- Line: 2226 -- upvalues: TreadmillFlags (val) -- types: a2: number
    local v1
    if a2 == 3 and TreadmillFlags.PhoneEnabled:Get() then
        v1 = false
        if typeof(a1) == "Instance" then
            v1 = a1:IsA("Tool") and isPhoneTool(a1)
        end
        return v1
    end
    if a2 == 1 then
        v1 = false
        if typeof(a1) == "Instance" then
            v1 = a1:IsA("Tool") and isGearTool(a1) and isBatGearTool(a1)
        end
        return v1
    end
    if a2 == 2 then
        v1 = false
        if typeof(a1) == "Instance" then
            v1 = a1:IsA("Tool") and isGearTool(a1) and isTrapGearTool(a1)
        end
        return v1
    end
    v1 = getLockedHotbarSlotForTool(a1)
    local v2 = true
    if v1 ~= nil then
        v2 = v1 == a2
    end
    return v2
end

function isToolLockedToCurrentHotbarSlot(a1) -- Line: 2247
    if a1 and not a1.IsFakeSlot and a1.Tool then
        local v1 = getLockedHotbarSlotForTool(a1.Tool)
        local v2 = false
        if v1 ~= nil then
            v2 = v1 == a1.Index
        end
        return v2
    end
    return false
end

function findGearSlot(a1) -- Line: 2256 -- upvalues: u3376 (val) -- types: a1: function
    for k, v in pairs(u3376) do
        if v and not v.IsFakeSlot and v.Tool and isGearTool(v.Tool) and a1(v.Tool) then
            return v
        end
    end
    return nil
end

function moveGameplayGearToHotbarSlot(a1, a2) -- Line: 2272
    -- upvalues: u3376 (val), u3504 (val)
    local v1 = findGearSlot(a1)
    if not v1 then
        return false
    end
    local v2 = u3376[a2]
    if v2 and not v2.IsFakeSlot then
        if v1 == v2 then
            return false
        end
        if v2.Tool and canToolUseHotbarSlot(v2.Tool, a2) then
            return false
        end
        v1:Swap(v2)
        if u3504 < v1.Index and not v1.Tool then
            v1:Delete()
        end
        return true
    end
    return false
end

function moveInvalidLockedHotbarSlotToolToInventory(a1) -- Line: 2301 -- upvalues: u3376 (val) -- types: a1: number
    local v1 = u3376[a1]
    if v1 and not v1.IsFakeSlot and v1.Tool then
        if canToolUseHotbarSlot(v1.Tool, a1) then
            return false
        end
        local Tool = v1.Tool
        v1:MoveToInventory()
        return v1.Tool ~= Tool
    end
    return false
end

function returnUncategorizedToolsToHotbar() -- Line: 2315 -- upvalues: u3376 (val), u3504 (val)
    local v1
    local v2 = {}
    for k, v in pairs(u3376) do
        if v and not v.IsFakeSlot and u3504 < v.Index and v.Tool and not HasInventoryCategory(v.Tool) then
            table.insert(v2, v)
        end
    end
    local v3 = false
    local v4 = nil
    local v5 = nil
    for i, j in v2, v4, v5 do
        if j.Tool then
            for k2 = 1, u3504 do
                v1 = u3376[k2]
                if v1 and not v1.IsFakeSlot and not v1.Tool and canToolUseHotbarSlot(j.Tool, k2) then
                    j:Swap(v1)
                    if not j.Tool then
                        j:Delete()
                    end
                    v3 = true
                    break
                end
            end
        end
    end
    return v3
end

function ensureGameplayGearHotbarSlots() -- Line: 2354 -- upvalues: u10 (ref)
    local v1 = false
    if moveGameplayGearToHotbarSlot(isBatGearTool, 1) then
        v1 = true
    end
    if moveGameplayGearToHotbarSlot(isTrapGearTool, 2) then
        v1 = true
    end
    if moveInvalidLockedHotbarSlotToolToInventory(1) then
        v1 = true
    end
    if moveInvalidLockedHotbarSlotToolToInventory(2) then
        v1 = true
    end
    if returnUncategorizedToolsToHotbar() then
        v1 = true
    end
    if not v1 then
        return
    end
    AdjustHotbarFrames()
    UpdateInventorySlots()
    if u10 then
        u10(true)
    end
end

function isToolInCharacterOrBackpack(a1) -- Line: 2382 -- upvalues: Character (ref), Backpack (ref)
    if typeof(a1) == "Instance" and a1:IsA("Tool") then
        local Parent = a1.Parent
        local v1 = true
        if Parent ~= Character then
            v1 = Parent == Backpack
        end
        return v1
    end
    return false
end

function _isInventoryEmpty() -- Line: 2391 -- upvalues: u3504 (val), u3376 (val)
    local v1
    local v2 = u3504 + 1
    local v3 = #u3376
    for i = v2, v3 do
        v1 = u3376[i]
        if v1 and v1.Tool then
            return false
        end
    end
    return true
end

function _UseGazeSelection() -- Line: 2400
    return UserInputService.VREnabled
end

function AdjustHotbarFrames() -- Line: 2401 -- upvalues: u3504 (val), u3376 (val), u462 (ref), u3432 (ref), u552 (ref)
    local IsFakeSlot, Slot, v1, v2, v3
    debug.profilebegin("BackpackController :: AdjustHotbarFrames")
    for i = 1, u3504 do
        v1 = u3376[i]
        if v1 then
            v1:SetNumberText(nil)
        end
    end
    local v4 = {}
    for j = 1, u3504 do
        v2 = u3376[j]
        IsFakeSlot = v2 and (v2.IsFakeSlot or v2.Tool or u462.Visible)
        if u3432 then
            IsFakeSlot = v2 and v2.Tool and isPhoneTool(v2.Tool)
        end
        if IsFakeSlot then
            table.insert(v4, {Kind = "Slot", Slot = v2})
        end
    end
    local v5 = math.max(1, #v4)
    u552 = v5
    local v6 = 0
    for k = 1, u3504 do
        v3 = u3376[k]
        if v3 then
            v3.Frame.Visible = false
        end
    end
    for i2, v in ipairs(v4) do
        v6 = v6 + 1
        Slot = v.Slot
        if Slot then
            Slot.Frame.LayoutOrder = v6
            Slot:Readjust(v6, v5)
            Slot.Frame.Visible = true
        end
    end
    PositionInventoryAffordances()
    debug.profileend()
end

function UpdateScrollingFrameCanvasSize() -- Line: 2452 -- upvalues: u472 (ref)
    debug.profilebegin("BackpackController :: UpdateScrollingFrameCanvasSize")
    if u472 then
        u472()
    end
    debug.profileend()
end

function UpdateInventorySlots() -- Line: 2461 -- upvalues: u3477 (ref), u10 (ref), u3504 (val), u3376 (val)
    local Tool, v1, v2, v3, v4
    debug.profilebegin("BackpackController :: UpdateInventorySlots")
    if u3477 then
        if u10 then
            u10()
        end
        return
    end
    local v5 = {}
    local v6 = {}
    local v7 = {}
    local v8 = {}
    local v9 = {}
    local v10 = u3504 + 1
    local v11 = #u3376
    for i = v10, v11 do
        v4 = u3376[i]
        Tool = v4.Tool
        if not Tool then
            table.insert(v9, v4)
            v4.Frame.Visible = false
        elseif not IsOfCategory(Tool) then
            v4.Frame.Visible = false
        else
            v1 = getAttribute(Tool, "ItemType")
            if v1 == "Asset" then
                table.insert(v5, v4)
            elseif v1 == "AssetEgg" then
                table.insert(v6, v4)
            elseif v1 ~= "Sword" then
                table.insert(v8, v4)
            else
                table.insert(v7, v4)
            end
            v4.Frame.Visible = true
        end
    end
    table.sort(v5, function(a1, a2) -- Line: 2499
        local Tool = a1.Tool
        local Tool_2 = a2.Tool
        local v1 = Tool and isToolFavorite(Tool)
        if v1 ~= (Tool_2 and isToolFavorite(Tool_2)) then
            return v1
        end
        local v2 = Tool and getAssetRarityNumber(Tool) or (1 / 0)
        v1 = Tool_2 and getAssetRarityNumber(Tool_2) or (1 / 0)
        if v2 ~= v1 then
            return v1 < v2
        end
        local v3 = Tool and getAssetEarningRate(Tool) or 0
        local v4 = Tool_2 and getAssetEarningRate(Tool_2) or 0
        if v3 ~= v4 then
            return v4 < v3
        end
        v4 = Tool and getAssetOddsDenominator(Tool) or 0
        v3 = Tool_2 and getAssetOddsDenominator(Tool_2) or 0
        if v4 ~= v3 then
            return v3 < v4
        end
        v4 = Tool and getAssetDropWeight(Tool) or (1 / 0)
        v3 = Tool_2 and getAssetDropWeight(Tool_2) or (1 / 0)
        if v4 ~= v3 then
            return v4 < v3
        end
        v4 = Tool and getAttribute(Tool, "Weight") or 0
        v3 = Tool_2 and getAttribute(Tool_2, "Weight") or 0
        if v4 ~= v3 then
            return v3 < v4
        end
        return (Tool and getAttribute(Tool, "UID") or "") < (Tool_2 and getAttribute(Tool_2, "UID") or "")
    end)
    local u87 = {}
    for i2, v in ipairs(v6) do
        v2 = isRobuxEgg
        v3 = getEggRecordFromTool(v.Tool)
        u87[v] = (v2(v3, v.Tool))
    end
    table.sort(v6, function(a1, a2) -- Line: 2553 -- upvalues: u87 (val)
        local Tool = a1.Tool
        local Tool_2 = a2.Tool
        local v1 = not u87[a1] and Tool and getEggRarityNumber(Tool) or (1 / 0)
        local v2 = not u87[a2] and Tool_2 and getEggRarityNumber(Tool_2) or (1 / 0)
        if v1 ~= v2 then
            return v2 < v1
        end
        v2 = not u87[a1] and Tool and getEggBaseEarningRate(Tool) or 0
        v1 = not u87[a2] and Tool_2 and getEggBaseEarningRate(Tool_2) or 0
        if v2 ~= v1 then
            return v1 < v2
        end
        return (Tool and getAttribute(Tool, "UID") or "") < (Tool_2 and getAttribute(Tool_2, "UID") or "")
    end)
    table.sort(v7, function(a1, a2) -- Line: 2583
        local v1 = getAttribute(a1.Tool, "MoneyCost") or 0
        return (getAttribute(a2.Tool, "MoneyCost") or 0) < v1
    end)
    local v12 = u3504
    for i3, j in ipairs(v5) do
        v12 = v12 + 1
        j.Frame.LayoutOrder = v12
    end
    for i4, k in ipairs(v6) do
        v12 = v12 + 1
        v5 = if not k.Tool then nil else getEggAssetConfig(k.Tool)
        k.Frame.LayoutOrder = if not v5 then v12 else if not v5.Egg.HideRarity then v12 else -2147483648
    end
    for i5, n in ipairs(v7) do
        v12 = v12 + 1
        n.Frame.LayoutOrder = v12
    end
    for i6, m in ipairs(v8) do
        v12 = v12 + 1
        m.Frame.LayoutOrder = v12
    end
    for i7, i52 in ipairs(v9) do
        v12 = v12 + 1
        i52.Frame.LayoutOrder = v12
    end
    UpdateScrollingFrameCanvasSize()
    debug.profileend()
end

function ResizeContainers() -- Line: 2617
    -- upvalues: u461 (ref), u3504 (val), u442 (ref), u460 (ref), u575 (val), VREnabled (val)
    u461.Size = UDim2.new(0, 5 + u3504 * (u442 + 5), 0, u442 + 5 + 5)
    u461.Position = UDim2.new(0.5, -u461.Size.X.Offset / 2, 1, -u461.Size.Y.Offset)
    local v1 = u460
    local new_3 = UDim2.new
    local v2 = if not VREnabled then 0 else 80
    v1.Size = new_3(0, u461.Size.X.Offset, 0, u461.Size.Y.Offset * u575 + 40 + v2)
    u460.Position = UDim2.new(0.5, -u460.Size.X.Offset / 2, 1, u461.Position.Y.Offset - u460.Size.Y.Offset)
    PositionInventoryAffordances()
    AdjustHotbarFrames()
    UpdateInventorySlots()
end

INVENTORY_AFFORDANCE_GAP = 8
PROMPT_HOTBAR_GAP = 28

function PositionInventoryAffordances() -- Line: 2641
    -- upvalues: u442 (ref), u552 (ref), PlatformController (val), u554 (ref)
    local X = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize.X or 0
    if X > 0 then
        local v1 = 2.5 - (u442 + 5) * math.max(1, u552) * 0.5
        ButtonHintStrip.PinRight(0.5 + (v1 - PROMPT_HOTBAR_GAP) / X)
    end
    if PlatformController.IsConsole() and u554 then
        ButtonHintStrip.Present("Backpack", Enum.KeyCode.ButtonSelect, "Backpack")
        return
    end
    ButtonHintStrip.Retract("Backpack")
end

function _Clamp(a1, a2, a3) -- Line: 2655
    return (math.min(a2, (math.max(a1, a3))))
end

function CheckBounds(a1, a2, a3) -- Line: 2656
    local AbsolutePosition = a1.AbsolutePosition
    local AbsoluteSize = a1.AbsoluteSize
    local v1 = false
    if AbsolutePosition.X < a2 then
        v1 = false
        if a2 <= AbsolutePosition.X + AbsoluteSize.X then
            v1 = false
            if AbsolutePosition.Y < a3 then
                v1 = a3 <= AbsolutePosition.Y + AbsoluteSize.Y
            end
        end
    end
    return v1
end

function GetOffset(a1, a2) -- Line: 2671
    return (a1.AbsolutePosition + a1.AbsoluteSize / 2 - a2).magnitude
end

function UnequipAllTools(a1, a2) -- Line: 2675 -- upvalues: Humanoid (ref) -- types: a1: boolean?, a2: boolean?
    requestUnequipVirtualAsset()
    requestUnequipVirtualEgg()
    if Humanoid then
        Humanoid:UnequipTools()
    end
end

function _EquipNewTool(a1) -- Line: 2682 -- upvalues: HiddenUIHandler (val), Humanoid (ref), Character (ref)
    if not BackpackEnabled or not BackpackGui.Enabled or HiddenUIHandler.IsHidden() then
        return
    end
    if Humanoid ~= nil and not (Humanoid.Health <= 0) then
        UnequipAllTools()
        a1.Parent = Character
        return
    end
end

function _ToggleFavoriteTool(a1) -- Line: 2693
    local Tool = a1.Tool
    if not Tool then
        return
    end
    requestFavoriteToggle(Tool)
end

function _IsEquipped(a1) -- Line: 2702 -- upvalues: Character (ref)
    return a1 and a1.Parent == Character
end

function MakeSlot(a1, a2) -- Line: 2704
    -- upvalues: u3376 (val), u470 (ref), u3504 (val), Trove (val), u462 (ref), MenuNavigation (val), RunService (val)
    -- upvalues: u461 (ref), u442 (ref), AssetIconShape (val), u552 (ref), u554 (ref), u444 (ref), u3390 (val)
    -- upvalues: u548 (ref), u3477 (ref), u587 (ref), u601 (ref), Character (ref), u3130 (ref), u3116 (val)
    -- upvalues: HiddenUIHandler (val), Humanoid (ref), Backpack (ref), u3254 (val), u3204 (ref), GuiService (val)
    -- upvalues: u10 (ref), u586 (val), u3404 (val), Value (val), u3418 (val), HotbarDragFeedback (val), u3362 (val)
    -- upvalues: u3102 (ref), Name (val), SetCategory (ref), u9 (ref), SlotDragController (val), LocalPlayer (ref)
    local v1 = a2 or #u3376 + 1
    local u8 = {IsFakeSlot = false, IsDeleted = false, Index = v1}
    local u14 = true
    if a1 ~= u470 then
        u14 = u3504 < v1
    end
    local u16 = nil
    local Shadow = nil
    local ToolName = nil
    local Weight = nil
    local u22 = nil
    local u23 = nil
    local u24 = nil
    local u25 = nil
    local u26 = nil
    local u29 = {}
    local u30 = nil
    local u31 = nil
    local Selector = nil
    local ToolTip = nil
    local Number = nil
    local FavIcon = nil
    local u36 = nil
    local TextXAlignment = nil
    local TextYAlignment = nil
    local u39 = 0
    local u40 = nil
    local u50 = (if not u14 then script.HotbarTemplate else script.InventoryTemplate):Clone()
    u50.Name = v1
    u50.ZIndex = 20
    local Icon = u50.Icon
    local u59 = NewGui("Frame", "CooldownOverlay")
    u59.BackgroundColor3 = Color3.new(0, 0, 0)
    u59.BackgroundTransparency = 0.35
    u59.BorderSizePixel = 0
    u59.Size = UDim2.fromScale(1, 1)
    u59.Visible = false
    u59.ZIndex = 20
    u59.Parent = u50
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = script:GetAttribute("CornerRadius")
    UICorner.Parent = u59
    local u85 = NewGui("TextLabel", "CooldownLabel")
    u85.BackgroundTransparency = 1
    u85.Size = UDim2.new(1, -4, 1, -4)
    u85.Position = UDim2.fromOffset(2, 2)
    u85.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
    u85.TextColor3 = Color3.new(1, 1, 1)
    u85.TextStrokeColor3 = Color3.new(0, 0, 0)
    u85.TextStrokeTransparency = 0.4
    u85.TextScaled = true
    u85.TextXAlignment = Enum.TextXAlignment.Center
    u85.TextYAlignment = Enum.TextYAlignment.Center
    u85.Visible = false
    u85.ZIndex = u59.ZIndex + 1
    u85.Text = ""
    u85.Parent = u59
    local u121 = Trove.new()

    local function restoreAssetIconHover(a1) end

    local function clearSlotOverlays() -- Line: 2780 -- upvalues: u121 (val), u22 (ref), u23 (ref), u50 (ref)
        u121:Clean()
        clearMutationIconFrame(u22, u23)
        if u50 then
            u50:SetAttribute("HasAssetOverlay", nil)
            u50:SetAttribute("HasEggOverlay", nil)
            u50:SetAttribute("HasSwordOverlay", nil)
        end
    end

    local function isDragRestrictedItemType(a1) -- Line: 2790
        return false
    end

    local function canPlaceToolInSlot(a1, a2) -- Line: 2792 -- upvalues: u3504 (upval)
        if a1.IsFakeSlot then
            return false
        end
        if not a2 then
            return true
        end
        local Index = a1.Index
        if u3504 < Index then
            return true
        end
        if not canToolUseHotbarSlot(a2, a1.Index) then
            return false
        end
        if typeof(a2) ~= "table" then
            getAttribute(a2, "ItemType")
            return true
        end
        if not a2.IsVirtualAsset and not a2.IsVirtualEgg then
            getAttribute(a2, "ItemType")
            return true
        end
        return getHotbarFillTool(a2) ~= nil
    end

    local function shouldAllowSlotDragging(a1) -- Line: 2818
        -- upvalues: u8 (val), canPlaceToolInSlot (val), u3504 (upval), u462 (upval)
        local Tool = a1 or u8.Tool
        if not Tool then
            return false
        end
        if typeof(Tool) == "Instance" then
            getAttribute(Tool, "ItemType")
            if not canPlaceToolInSlot(u8, Tool) or UserInputService.VREnabled then
                return false
            end
            return not (u8.Index <= u3504) or u462.Visible
        end
        if typeof(Tool) ~= "table" then
            return false
        end
        if not Tool.IsVirtualAsset and not Tool.IsVirtualEgg then
            return false
        end
        getAttribute(Tool, "ItemType")
        if not canPlaceToolInSlot(u8, Tool) or UserInputService.VREnabled then
            return false
        end
        return not (u8.Index <= u3504) or u462.Visible
    end

    function u8.RefreshDragDetector(a1) -- Line: 2848 -- upvalues: u16 (ref), MenuNavigation (upval), u50 (ref)
        if u16 then
            local v1 = false
            if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
                v1 = not MenuNavigation.IsCursorActive()
            end
            local v2 = u16
            local v3 = false
            if u50:GetAttribute("Draggable") == true then
                v3 = not v1 and not UserInputService.VREnabled
            end
            v2:SetEnabled(v3)
        end
    end

    local function applySlotDraggableState(a1) -- Line: 2859 -- upvalues: u50 (ref), u8 (val)
        u50:SetAttribute("Draggable", a1)
        u8:RefreshDragDetector()
    end

    local function stopCooldownHeartbeat() -- Line: 2864 -- upvalues: u30 (ref)
        if u30 then
            u30:Disconnect()
            u30 = nil
        end
    end

    local function disconnectCooldownConnections() -- Line: 2871 -- upvalues: u29 (ref)
        for i, v in ipairs(u29) do
            v:Disconnect()
        end
        u29 = {}
    end

    local function hideCooldownOverlay() -- Line: 2878 -- upvalues: u30 (ref), u59 (ref), u85 (ref)
        if u30 then
            u30:Disconnect()
            u30 = nil
        end
        if u59 then
            u59.Visible = false
        end
        if u85 then
            u85.Visible = false
            u85.Text = ""
        end
    end

    local function updateCooldownDisplay() -- Line: 2889 -- upvalues: u8 (val), u30 (ref), u59 (ref), u85 (ref)
        local Tool = u8.Tool
        if not Tool then
            if u30 then
                u30:Disconnect()
                u30 = nil
            end
            if u59 then
                u59.Visible = false
            end
            if u85 then
                u85.Visible = false
                u85.Text = ""
            end
            return false
        end
        local Attribute = Tool:GetAttribute("CooldownEndTime")
        if typeof(Attribute) == "number" and not (Attribute <= 0) then
            if not Tool:GetAttribute("CooldownActive") then
                if u30 then
                    u30:Disconnect()
                    u30 = nil
                end
                if u59 then
                    u59.Visible = false
                end
                if u85 then
                    u85.Visible = false
                    u85.Text = ""
                end
                return false
            end
            local v1 = Attribute - workspace:GetServerTimeNow()
            if not (v1 <= 1) then
                if u59 then
                    u59.Visible = true
                end
                if u85 then
                    u85.Visible = true
                    u85.Text = tostring((math.max(math.ceil(v1), 0)))
                end
                return true
            end
            if u30 then
                u30:Disconnect()
                u30 = nil
            end
            if u59 then
                u59.Visible = false
            end
            if u85 then
                u85.Visible = false
                u85.Text = ""
            end
            return false
        end
        if u30 then
            u30:Disconnect()
            u30 = nil
        end
        if u59 then
            u59.Visible = false
        end
        if u85 then
            u85.Visible = false
            u85.Text = ""
        end
        return false
    end

    local function ensureCooldownHeartbeat(a1) -- Line: 2926
        -- upvalues: u30 (ref), RunService (upval), u8 (val), u59 (ref), u85 (ref), updateCooldownDisplay (val)
        if u30 then
            return
        end
        RunService.Heartbeat:Connect(function() -- Line: 2931
            -- upvalues: u8 (upval), a1 (val), u30 (upval), u59 (upval), u85 (upval), updateCooldownDisplay (upval)
            if u8.Tool == a1 then
                if not updateCooldownDisplay() and u30 then
                    u30:Disconnect()
                    u30 = nil
                end
                return
            end
            if u30 then
                u30:Disconnect()
                u30 = nil
            end
            if u59 then
                u59.Visible = false
            end
            if u85 then
                u85.Visible = false
                u85.Text = ""
            end
            if u30 then
                u30:Disconnect()
                u30 = nil
            end
        end)
    end

    local function connectCooldownListeners(a1) -- Line: 2944
        -- upvalues: disconnectCooldownConnections (val), u30 (ref), u59 (ref), u85 (ref), updateCooldownDisplay (val)
        -- upvalues: RunService (upval), u8 (val), u29 (ref)
        disconnectCooldownConnections()
        if u30 then
            u30:Disconnect()
            u30 = nil
        end
        if u59 then
            u59.Visible = false
        end
        if u85 then
            u85.Visible = false
            u85.Text = ""
        end
        if not a1 then
            return
        end

        local function onAttributeChanged() -- Line: 2952
            -- upvalues: updateCooldownDisplay (upval), a1 (val), u30 (upval), RunService (upval), u8 (upval)
            -- upvalues: u59 (upval), u85 (upval)
            if not updateCooldownDisplay() then
                if u30 then
                    u30:Disconnect()
                    u30 = nil
                end
                return
            end
            local u2 = a1
            if u30 then
                return
            end
            RunService.Heartbeat:Connect(function() -- Line: 2931
                -- upvalues: u8 (upval), u2 (val), u30 (upval), u59 (upval), u85 (upval), updateCooldownDisplay (upval)
                if u8.Tool == u2 then
                    if not updateCooldownDisplay() and u30 then
                        u30:Disconnect()
                        u30 = nil
                    end
                    return
                end
                if u30 then
                    u30:Disconnect()
                    u30 = nil
                end
                if u59 then
                    u59.Visible = false
                end
                if u85 then
                    u85.Visible = false
                    u85.Text = ""
                end
                if u30 then
                    u30:Disconnect()
                    u30 = nil
                end
            end)
        end

        table.insert(u29, ((a1:GetAttributeChangedSignal("CooldownEndTime")):Connect(onAttributeChanged)))
        table.insert(u29, ((a1:GetAttributeChangedSignal("CooldownActive")):Connect(onAttributeChanged)))
        table.insert(u29, ((a1:GetAttributeChangedSignal("CooldownDuration")):Connect(onAttributeChanged)))
        if updateCooldownDisplay() then
            if u30 then
                return
            end
            u30 = RunService.Heartbeat:Connect(function() -- Line: 2931
                -- upvalues: u8 (upval), a1 (val), u30 (upval), u59 (upval), u85 (upval), updateCooldownDisplay (upval)
                if u8.Tool == a1 then
                    if not updateCooldownDisplay() and u30 then
                        u30:Disconnect()
                        u30 = nil
                    end
                    return
                end
                if u30 then
                    u30:Disconnect()
                    u30 = nil
                end
                if u59 then
                    u59.Visible = false
                end
                if u85 then
                    u85.Visible = false
                    u85.Text = ""
                end
                if u30 then
                    u30:Disconnect()
                    u30 = nil
                end
            end)
            return
        end
        if u30 then
            u30:Disconnect()
            u30 = nil
        end
    end

    function u8:updateDragAppearance() -- Line: 2977 -- upvalues: u8 (val), u50 (ref), u14 (val)
        if u8.IsFakeSlot then
            u50.BackgroundTransparency = SlotLockedTransparencyAttribute
            u50.BackgroundColor3 = BackgroundColorAttribute
            return
        end
        u50.SelectionImageObject = nil
        local Tool = self.Tool and getAttribute(self.Tool, "ItemType")
        if not u14 then
            local Attribute = u50:GetAttribute("Draggable")
            u50.BackgroundTransparency = SlotLockedTransparencyAttribute
            u50.BackgroundColor3 = Attribute and DraggableColorAttribute or BackgroundColorAttribute
            return
        end
        local v1 = true
        if Tool ~= "Asset" then
            v1 = Tool == "Sword"
        end
        u50.BackgroundTransparency = if not v1 then 0.5 else 0.5
        u50.BackgroundColor3 = Color3.new(0, 0, 0)
    end

    function u8.Readjust(a1, a2, a3) -- Line: 2999 -- upvalues: u461 (upval), u442 (upval), u50 (ref)
        local v1 = u461.Size.X.Offset / 2
        local v2 = u442 + 5
        local v3 = a2 - (a3 / 2 + 0.5)
        local AnchorPoint = u50.AnchorPoint
        local Size = u50.Size
        u50.Position = UDim2.new(0, v1 - u442 / 2 + v2 * v3 + Size.X.Offset * AnchorPoint.X, 0, 5 + Size.Y.Offset * AnchorPoint.Y)
    end

    function u8.SetNumberText(a1, a2) -- Line: 3014
        -- upvalues: Number (ref), u36 (ref)
        if Number then
            Number.Text = a2 or u36 or ""
        end
    end

    function u8:Fill(a2) -- Line: 3019
        -- upvalues: canPlaceToolInSlot (val), u16 (ref), u39 (ref), u40 (ref), clearSlotOverlays (val), u25 (ref)
        -- upvalues: u26 (ref), disconnectCooldownConnections (val), u30 (ref), u59 (ref), u85 (ref), u3504 (upval)
        -- upvalues: AssetIconShape (upval), Icon (ref), ToolName (ref), TextXAlignment (ref), TextYAlignment (ref)
        -- upvalues: Shadow (ref), u22 (ref), u23 (ref), Weight (ref), u14 (val), Selector (ref), ToolTip (ref)
        -- upvalues: u8 (val), u24 (ref), connectCooldownListeners (val), shouldAllowSlotDragging (val), u50 (ref)
        -- upvalues: u552 (upval), u554 (upval), u444 (upval), u3390 (upval), u121 (val), u548 (upval), u462 (upval)
        -- upvalues: u3477 (upval)
        if self.IsFakeSlot and self.FakeType ~= "SwordEquip" then
            return
        end
        if a2 and not canPlaceToolInSlot(self, a2) then
            return
        end
        if u16 then
            u16:Cancel()
        end
        if self.Tool ~= a2 then
            u39 = 0
            u40 = nil
        end
        clearSlotOverlays()
        if u25 then
            u25:Disconnect()
            u25 = nil
        end
        if u26 then
            u26:Disconnect()
            u26 = nil
        end
        disconnectCooldownConnections()
        if u30 then
            u30:Disconnect()
            u30 = nil
        end
        if u59 then
            u59.Visible = false
        end
        if u85 then
            u85.Visible = false
            u85.Text = ""
        end
        if not a2 then
            return self:Clear()
        end
        if self.Tool and self.Tool ~= a2 then
            self:Clear()
        end
        local v1 = typeof(a2) == "Instance"
        local u82 = getAttribute(a2, "ItemType")
        local v2 = getRegisteredBackpackSlot(a2)
        if v2 and v2 ~= self and registeredSlotContainsTool(v2, a2) then
            v2:Clear()
            local Index = v2.Index
            if u3504 < Index then
                v2:Delete()
            end
        end
        self.Tool = a2
        registerVirtualBackpackSlot(self, a2)
        self:UpdateFavoriteVisual()
        if v1 then
            (a2:GetAttributeChangedSignal("Favorite")):Connect(function() -- Line: 3070 -- upvalues: self (val), a2 (val)
                self:UpdateFavoriteVisual()
                if isAssetTool(a2) then
                    UpdateInventorySlots()
                end
            end)
        end

        function u8.UpdateVisuals() -- Line: 3077
            -- upvalues: a2 (val), AssetIconShape (upval), Icon (upval), ToolName (upval), TextXAlignment (upval)
            -- upvalues: TextYAlignment (upval), Shadow (upval), u22 (upval), u23 (upval), Weight (upval), u82 (val)
            -- upvalues: u14 (upval), Selector (upval), ToolTip (upval), self (val), u3504 (upval)
            local v1, v2, v3
            local TextureId = a2.TextureId
            AssetIconShape.Strip(Icon)
            Icon.Image = TextureId
            Icon.ScaleType = Enum.ScaleType.Fit
            ToolName.TextXAlignment = TextXAlignment
            ToolName.TextYAlignment = TextYAlignment
            Shadow.Visible = false
            clearMutationIconFrame(u22, u23)
            for i, v in ipairs(Shadow:GetChildren()) do
                if v:IsA("UIGradient") then
                    v:Destroy()
                end
            end
            for i2, i3 in ipairs(ToolName:GetChildren()) do
                if i3:IsA("UIGradient") then
                    i3:Destroy()
                end
            end
            for i4, j in ipairs(Weight:GetChildren()) do
                if j:IsA("UIGradient") then
                    j:Destroy()
                end
            end
            local v4 = string.match(a2.Name, "%[X(%d+)%]")
            local Name = a2.Name
            local v5 = Name
            local v6 = true
            local v7 = ""
            local v8 = false
            if u82 == "Asset" then
                v1 = getAttribute(a2, "Category")
                v2 = v1 and AssetDirectory[v1]
                if v2 then
                    v1 = getAssetItemData(a2)
                    if not v1 then
                        Icon.Image = v2.Icon or TextureId
                    else
                        AssetIconShape.Paint(Icon, v1)
                    end
                    Icon.ImageColor3 = Color3.new(1, 1, 1)
                    if v2.Rarity and v2.Rarity.RarityGradient then
                        v1 = ToolName
                        v2.Rarity.RarityGradient:Clone().Parent = v1
                        if u14 then
                            v1 = v2.Rarity.RarityGradient:Clone()
                            v1.Parent = Shadow
                        end
                    end
                end
                Shadow.Visible = u14
                v3 = getAssetItemData(a2)
                local Name_2 = if not v3 then getAttribute(a2, "DisplayName") or a2.Name else getAssetItemDisplayNameWithVisualWeight(v3, v2 or BaseAssetConfig)
                v3 = parseMutations(getAttribute(a2, "Mutations"))
                v2 = getAttribute(a2, "BaseMutation")
                Name = Name_2
                v6 = true
                if u14 then
                    populateMutationIconFrame(u22, u23, v2, v3)
                    v7 = ""
                    v8 = false
                    if not u14 then
                        v6 = false
                    end
                elseif typeof(a2) ~= "table" or not a2.IsVirtualAsset then
                    Name = ""
                else
                    populateMutationIconFrame(u22, u23, v2, v3)
                    v7 = ""
                    v8 = false
                    if not u14 then
                        v6 = false
                    end
                end
                v5 = Name
            elseif u82 == "AssetEgg" then
                v1 = getEggRecordFromTool(a2)
                v2, v3 = getEggConfigForRecord(v1)
                if v2 and v3 then
                    local v9 = getEggIconForRecord(v1, v2)
                    Icon.Image = not (v9 == "") and v9 or TextureId
                    Icon.ImageColor3 = Color3.new(1, 1, 1)
                    if not v2.HideRarity and not isRobuxEgg(v1, a2) and v3.Rarity and v3.Rarity.RarityGradient then
                        v9 = ToolName
                        v3.Rarity.RarityGradient:Clone().Parent = v9
                        if u14 then
                            v9 = v3.Rarity.RarityGradient:Clone()
                            v9.Parent = Shadow
                        end
                    end
                end
                Shadow.Visible = u14
                v5 = if not v1 then getAttribute(a2, "DisplayName") or a2.Name else getEggDisplayNameWithWeight(v1)
                v6 = true
                v7 = ""
                v8 = false
            elseif u82 == "Gear" or u82 == "MutationConsumable" or u82 == "MountStar" then
                v1 = getGearConfig(a2)
                Icon.Image = TextureId and not (TextureId == "") and TextureId or v1 and v1.Icon or ""
                Icon.ImageColor3 = Color3.new(1, 1, 1)
                Shadow.Visible = false
                Name = ""
                if (if not shouldDisplayToolUses(a2) then "" else getToolUsesText(a2)) ~= "" then
                    ToolName.TextXAlignment = Enum.TextXAlignment.Center
                    ToolName.TextYAlignment = Enum.TextYAlignment.Center
                end
                v7 = ""
                v8 = false
            elseif TextureId == "" then
                v8 = false
            else
                v8 = false
                if not v4 then
                    v6 = false
                else
                    v5 = ""
                    Name = ""
                end
            end
            if not u14 then
                if not shouldDisplayToolUses(a2) then
                    v5 = ""
                    Name = ""
                    v6 = false
                end
                v7 = ""
                v8 = false
            end
            ToolName.Text = v5 or Name
            ToolName.Visible = v6
            Weight.Text = v7
            Weight.Visible = v8
            if Selector then
                Selector.Visible = true
            end
            if ToolTip and a2:IsA("Tool") then
                v8 = false
                if self.Index <= u3504 then
                    v8 = true
                    if u82 ~= "Asset" then
                        v8 = true
                        if u82 ~= "Pet" then
                            v8 = true
                            if u82 ~= "AssetEgg" then
                                v8 = u82 == "Gear"
                            end
                        end
                    end
                end
                if v8 then
                    ToolTip.Text = ""
                    ToolTip.Visible = false
                    return
                end
                local ToolTip_2 = a2.ToolTip
                if ToolTip_2 == "" then
                    ToolTip_2 = a2.Name
                end
                ToolTip.Text = ToolTip_2
            end
        end

        u8.UpdateVisuals()
        if u24 then
            u24:Disconnect()
            u24 = nil
        end
        if v1 then
            a2.Changed:Connect(function(a1) -- Line: 3271 -- upvalues: u8 (upval)
                if a1 == "TextureId" or a1 == "Name" or a1 == "ToolTip" then
                    u8.UpdateVisuals()
                end
            end)
        end
        if not v1 then
            if v1 then
                if u82 == "Gear" or u82 == "MutationConsumable" or u82 == "MountStar" then
                    (a2:GetAttributeChangedSignal("Uses")):Connect(function() -- Line: 3286 -- upvalues: u8 (upval)
                        u8.UpdateVisuals()
                    end)
                    if u82 == "Gear" then
                        connectCooldownListeners(a2)
                    end
                end
            end
        elseif u82 == "Asset" then
            (a2:GetAttributeChangedSignal("Weight")):Connect(function() -- Line: 3280
                UpdateInventorySlots()
            end)
        elseif v1 then
            if u82 == "Gear" or u82 == "MutationConsumable" or u82 == "MountStar" then
                (a2:GetAttributeChangedSignal("Uses")):Connect(function() -- Line: 3286 -- upvalues: u8 (upval)
                    u8.UpdateVisuals()
                end)
                if u82 == "Gear" then
                    connectCooldownListeners(a2)
                end
            end
        end
        v2 = self.Index <= u3504
        v1 = shouldAllowSlotDragging(a2)
        u50:SetAttribute("Draggable", v1)
        u8:RefreshDragDetector()
        self:UpdateEquipView()
        if v2 and not self.IsFakeSlot then
            u552 = u552 + 1
            if u554 and u552 >= 1 and not u444 then
                u444 = true
                ContextActionService:BindAction("RBXHotbarEquip", changeTool, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
            end
        end
        if typeof(a2) == "Instance" then
            u3390[a2] = self
        end
        if u82 == "Asset" then
            v2 = AssetDirectory[getAttribute(a2, "Category")] or BaseAssetConfig
            v1 = getAssetItemData(a2) or {}
            addVirtualAssetOverlay(u50, v1, v2, u121)
        elseif u82 == "AssetEgg" then
            local v3 = getEggRecordFromTool(a2)
            if v3 then
                addVirtualEggOverlay(u50, v3, u121, a2)
            end
        end
        FindLowestEmpty()
        if u14 and u462.Visible and not u3477 then
            u50.Visible = IsOfCategory(a2)
        end
    end

    function u8:Clear() -- Line: 3332
        -- upvalues: u16 (ref), u39 (ref), u40 (ref), clearSlotOverlays (val), u24 (ref), u25 (ref), u26 (ref)
        -- upvalues: disconnectCooldownConnections (val), u30 (ref), u59 (ref), u85 (ref), Shadow (ref)
        -- upvalues: AssetIconShape (upval), Icon (ref), ToolName (ref), Weight (ref), ToolTip (ref), u50 (ref)
        -- upvalues: u8 (val), FavIcon (ref), u3504 (upval), u552 (upval), u444 (upval), u548 (upval)
        if not self.Tool or self.IsFakeSlot then
            return
        end
        if u16 then
            u16:Cancel()
        end
        u39 = 0
        u40 = nil
        clearSlotOverlays()
        if u24 then
            u24:Disconnect()
            u24 = nil
        end
        if u25 then
            u25:Disconnect()
            u25 = nil
        end
        if u26 then
            u26:Disconnect()
            u26 = nil
        end
        disconnectCooldownConnections()
        if u30 then
            u30:Disconnect()
            u30 = nil
        end
        if u59 then
            u59.Visible = false
        end
        if u85 then
            u85.Visible = false
            u85.Text = ""
        end
        for i, v in ipairs(Shadow:GetChildren()) do
            if v:IsA("UIGradient") then
                v:Destroy()
            end
        end
        Shadow.Visible = false
        AssetIconShape.Strip(Icon)
        Icon.Image = ""
        ToolName.Text = ""
        ToolName.Visible = true
        Weight.Text = ""
        Weight.Visible = false
        if ToolTip then
            ToolTip.Text = ""
            ToolTip.Visible = false
        end
        u50:SetAttribute("Draggable", false)
        u8:RefreshDragDetector()
        FavIcon.Visible = false
        self:UpdateEquipView(true)
        if self.Index <= u3504 and not self.IsFakeSlot then
            u552 = u552 - 1
            if u552 < 1 then
                u444 = false
                ContextActionService:UnbindAction("RBXHotbarEquip")
            end
        end
        unregisterBackpackSlotTool(self, self.Tool)
        self.Tool = nil
        FindLowestEmpty()
    end

    function u8:UpdateEquipView(a2) -- Line: 3394
        -- upvalues: u587 (upval), u601 (upval), Character (upval), u31 (ref), u50 (ref)
        local Tool_3, v1
        if self.IsFakeSlot then
            return
        end
        local v2 = false
        local v3 = getAttribute(self.Tool, "ItemType")
        if v3 ~= "Asset" or typeof(self.Tool) ~= "table" then
            if v3 ~= "AssetEgg" or typeof(self.Tool) ~= "table" then
                if not a2 then
                    Tool_3 = self.Tool
                    if Tool_3 and typeof(Tool_3) == "Instance" and Tool_3.Parent == Character then
                        v2 = true
                    end
                end
            elseif self.Tool.IsVirtualEgg then
                v1 = not a2
                if v1 then
                    v1 = false
                    if typeof(u601) == "string" then
                        v1 = self.Tool.UID == u601
                    end
                end
                v2 = v1
            elseif not a2 then
                Tool_3 = self.Tool
                if Tool_3 and typeof(Tool_3) == "Instance" and Tool_3.Parent == Character then
                    v2 = true
                end
            end
        elseif self.Tool.IsVirtualAsset then
            v2 = not a2 and virtualAssetMatchesUID(self.Tool, u587)
        elseif v3 ~= "AssetEgg" or typeof(self.Tool) ~= "table" then
            if not a2 then
                Tool_3 = self.Tool
                if Tool_3 and typeof(Tool_3) == "Instance" and Tool_3.Parent == Character then
                    v2 = true
                end
            end
        elseif self.Tool.IsVirtualEgg then
            v1 = not a2
            if v1 then
                v1 = false
                if typeof(u601) == "string" then
                    v1 = self.Tool.UID == u601
                end
            end
            v2 = v1
        elseif not a2 then
            Tool_3 = self.Tool
            if Tool_3 and typeof(Tool_3) == "Instance" and Tool_3.Parent == Character then
                v2 = true
            end
        end
        if not v2 then
            if u31 then
                u31.Parent = nil
            end
            return
        end
        if not u31 then
            u31 = NewGui("Frame", "Equipped")
            u31.ZIndex = 3
            u31.Size = UDim2.fromScale(1, 1)
            u31.AnchorPoint = Vector2.new(0.5, 0.5)
            u31.Position = UDim2.fromScale(0.5, 0.5)
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = script:GetAttribute("CornerRadius")
            UICorner.Parent = u31
            local UIStroke = Instance.new("UIStroke")
            UIStroke.Color = EquippedColorAttribute
            UIStroke.Thickness = 3.8
            UIStroke.Parent = u31
        end
        u31.Parent = u50
    end

    function u8:Delete() -- Line: 3434
        -- upvalues: u16 (ref), clearSlotOverlays (val), disconnectCooldownConnections (val), u30 (ref), u59 (ref)
        -- upvalues: u85 (ref), u50 (ref), u3376 (upval)
        if not self.IsFakeSlot and not self.IsDeleted then
            self.IsDeleted = true
            if u16 then
                u16:Destroy()
            end
            if self.Tool then
                self:Clear()
            end
            clearSlotOverlays()
            disconnectCooldownConnections()
            if u30 then
                u30:Disconnect()
                u30 = nil
            end
            if u59 then
                u59.Visible = false
            end
            if u85 then
                u85.Visible = false
                u85.Text = ""
            end
            u50:Destroy()
            local v1 = table.find(u3376, self)
            if v1 then
                table.remove(u3376, v1)
                local v2 = #u3376
                for i = v1, v2 do
                    u3376[i]:SlideBack()
                end
            end
            UpdateScrollingFrameCanvasSize()
            return
        end
    end

    function u8:UpdateFavoriteVisual() -- Line: 3462 -- upvalues: FavIcon (ref)
        if FavIcon and self.Tool then
            local v1 = isToolFavorite(self.Tool)
            if FavIcon.Visible ~= v1 then
                FavIcon.Visible = v1
                return true
            end
        end
        return false
    end

    function u8:CanSwap(a2) -- Line: 3473 -- upvalues: canPlaceToolInSlot (val)
        if not self.IsFakeSlot and not a2.IsFakeSlot then
            local Tool_2 = self.Tool
            local Tool = a2.Tool
            if Tool_2 and isToolLockedToCurrentHotbarSlot(self) and a2 ~= self then
                return false
            end
            if Tool and isToolLockedToCurrentHotbarSlot(a2) and self ~= a2 then
                return false
            end
            if Tool_2 and not canPlaceToolInSlot(a2, Tool_2) then
                return false
            end
            if Tool and not canPlaceToolInSlot(self, Tool) then
                return false
            end
            return true
        end
        return false
    end

    function u8:Swap(a2) -- Line: 3495
        if not self:CanSwap(a2) then
            return
        end
        local Tool = self.Tool
        local Tool_2 = a2.Tool
        self:Clear()
        if Tool_2 then
            a2:Clear()
            self:Fill(Tool_2)
        end
        if Tool then
            a2:Fill(Tool)
            return
        end
        a2:Clear()
    end

    function u8:SlideBack() -- Line: 3514 -- upvalues: u50 (ref)
        self.Index = self.Index - 1
        u50.Name = self.Index
        u50.LayoutOrder = self.Index
    end

    function u8.TurnNumber(a1, a2) -- Line: 3519 -- upvalues: Number (ref)
        if Number then
            Number.Visible = a2
        end
    end

    function u8:SetClickability(a2) -- Line: 3525 -- upvalues: shouldAllowSlotDragging (val), u50 (ref), u8 (val)
        if self.IsFakeSlot then
            return
        end
        if self.Tool then
            local v1 = not a2 and shouldAllowSlotDragging(self.Tool)
            u50:SetAttribute("Draggable", v1)
            u8:RefreshDragDetector()
            self:updateDragAppearance()
        end
    end

    function u8:CheckTerms(a2) -- Line: 3536 -- upvalues: ToolName (ref), ToolTip (ref)
        local v1 = 0
        local Tool = self.Tool
        if Tool then
            local v2
            local v3 = {}
            if ToolName and ToolName.Text ~= "" then
                table.insert(v3, (ToolName.Text:lower()))
            end
            local Name = not (typeof(Tool) ~= "table") and Tool.Name or Tool.Name
            if Name then
                table.insert(v3, (tostring(Name):lower()))
            end
            local Text = ToolTip and ToolTip.Text
            if Text and Text ~= "" then
                table.insert(v3, (Text:lower()))
            end
            local ToolTip_2 = not (typeof(Tool) ~= "table") and Tool.ToolTip or Tool.ToolTip
            if ToolTip_2 and ToolTip_2 ~= "" then
                table.insert(v3, (tostring(ToolTip_2):lower()))
            end
            for k in pairs(a2) do
                for i, v in ipairs(v3) do
                    _, v2 = v:gsub(k, "")
                    v1 = v1 + v2
                end
            end
        end
        return v1
    end

    function u8:Select() -- Line: 3569
        -- upvalues: u3130 (upval), u3504 (upval), u3116 (upval), HiddenUIHandler (upval), Humanoid (upval)
        -- upvalues: Character (upval), u587 (upval), Backpack (upval)
        local v1, v2
        local Tool = self.Tool
        if Tool and u3130 then
            if u3130.ItemType == getAttribute(Tool, "ItemType") then
                local Index = self.Index
                v2 = u3504 < Index
                if not v2 and not u3130.AllowHotbar then
                    if ActiveFuseSelectionState then
                        return
                    end
                    if Tool then
                        v1 = not BackpackEnabled or not BackpackGui.Enabled or HiddenUIHandler.IsHidden()
                        if v1 then
                            return
                        end
                        if typeof(Tool) == "table" and Tool.IsVirtualAsset then
                            v1 = _getAssetUID(Tool)
                            if typeof(v1) ~= "string" then
                                return
                            end
                            SelectedSlot = self
                            v2 = findAssetToolByUID(v1)
                            if not v2 or not Humanoid then
                                if u587 == v1 then
                                    requestUnequipVirtualAsset()
                                end
                            elseif v2.Parent ~= Character then
                                Humanoid:UnequipTools()
                                Humanoid:EquipTool(v2)
                            else
                                Humanoid:UnequipTools()
                            end
                            updateEquipSelectionVisuals()
                            return
                        end
                        if typeof(Tool) == "table" and Tool.IsVirtualEgg then
                            v1 = reconcileVirtualEggEquipState()
                            v2 = getAttribute(Tool, "UID")
                            if typeof(v2) ~= "string" then
                                return
                            end
                            if v1 == v2 then
                                requestUnequipVirtualEgg()
                                return
                            end
                            requestEquipVirtualEgg(v2, self)
                            return
                        end
                        SelectedSlot = self
                        if Tool.Parent == Character then
                            SelectedSlot = nil
                            if Humanoid then
                                UnequipAllTools()
                                return
                            end
                        elseif Tool.Parent == Backpack then
                            if Humanoid ~= nil and not (Humanoid.Health <= 0) then
                                UnequipAllTools()
                                Tool.Parent = Character
                                return
                            end
                            SelectedSlot = nil
                            return
                        end
                    end
                    return
                end
                local Validator = u3130.Validator
                if Validator and Validator(Tool) == false then
                    if ActiveFuseSelectionState then
                        return
                    end
                    if Tool then
                        v1 = not BackpackEnabled or not BackpackGui.Enabled or HiddenUIHandler.IsHidden()
                        if v1 then
                            return
                        end
                        if typeof(Tool) == "table" and Tool.IsVirtualAsset then
                            v1 = _getAssetUID(Tool)
                            if typeof(v1) ~= "string" then
                                return
                            end
                            SelectedSlot = self
                            v2 = findAssetToolByUID(v1)
                            if not v2 or not Humanoid then
                                if u587 == v1 then
                                    requestUnequipVirtualAsset()
                                end
                            elseif v2.Parent ~= Character then
                                Humanoid:UnequipTools()
                                Humanoid:EquipTool(v2)
                            else
                                Humanoid:UnequipTools()
                            end
                            updateEquipSelectionVisuals()
                            return
                        end
                        if typeof(Tool) == "table" and Tool.IsVirtualEgg then
                            v1 = reconcileVirtualEggEquipState()
                            v2 = getAttribute(Tool, "UID")
                            if typeof(v2) ~= "string" then
                                return
                            end
                            if v1 == v2 then
                                requestUnequipVirtualEgg()
                                return
                            end
                            requestEquipVirtualEgg(v2, self)
                            return
                        end
                        SelectedSlot = self
                        if Tool.Parent == Character then
                            SelectedSlot = nil
                            if Humanoid then
                                UnequipAllTools()
                                return
                            end
                        elseif Tool.Parent == Backpack then
                            if Humanoid ~= nil and not (Humanoid.Health <= 0) then
                                UnequipAllTools()
                                Tool.Parent = Character
                                return
                            end
                            SelectedSlot = nil
                            return
                        end
                    end
                    return
                end
                local v3 = u3130
                if ActiveFuseSelectionState then
                    u3116:EndFuseSelection()
                    task.spawn(v3.Callback, Tool)
                    return
                end
                v3.Callback(Tool)
                if v3.Preserve ~= true then
                    u3130 = nil
                end
                return
            end
            if ActiveFuseSelectionState then
                return
            end
        end
        if Tool then
            v1 = not BackpackEnabled or not BackpackGui.Enabled or HiddenUIHandler.IsHidden()
            if v1 then
                return
            end
            if typeof(Tool) == "table" and Tool.IsVirtualAsset then
                v1 = _getAssetUID(Tool)
                if typeof(v1) ~= "string" then
                    return
                end
                SelectedSlot = self
                v2 = findAssetToolByUID(v1)
                if not v2 or not Humanoid then
                    if u587 == v1 then
                        requestUnequipVirtualAsset()
                    end
                elseif v2.Parent ~= Character then
                    Humanoid:UnequipTools()
                    Humanoid:EquipTool(v2)
                else
                    Humanoid:UnequipTools()
                end
                updateEquipSelectionVisuals()
                return
            end
            if typeof(Tool) == "table" and Tool.IsVirtualEgg then
                v1 = reconcileVirtualEggEquipState()
                v2 = getAttribute(Tool, "UID")
                if typeof(v2) ~= "string" then
                    return
                end
                if v1 == v2 then
                    requestUnequipVirtualEgg()
                    return
                end
                requestEquipVirtualEgg(v2, self)
                return
            end
            SelectedSlot = self
            if Tool.Parent == Character then
                SelectedSlot = nil
                if Humanoid then
                    UnequipAllTools()
                    return
                end
            elseif Tool.Parent == Backpack then
                if Humanoid ~= nil and not (Humanoid.Health <= 0) then
                    UnequipAllTools()
                    Tool.Parent = Character
                    return
                end
                SelectedSlot = nil
                return
            end
        end
    end

    u8.MainImage = u50.ImageLabel
    local BaseTemplate = u50.BaseTemplate
    BaseTemplate.Amount.Visible = false
    BaseTemplate.Amount.Text = ""
    u22 = BaseTemplate:FindFirstChild("Mutations")
    u23 = u22 and u22:FindFirstChild("Template")
    clearMutationIconFrame(u22, u23)
    local UIStroke = u50.UIStroke
    UIStroke.Thickness = 0
    local v2 = u14 and Color3.new(0, 0, 0) or BackgroundColorAttribute
    u50.BackgroundColor3 = v2
    UIStroke.Color = BorderColorAttribute
    u50.Text = ""
    u50.AutoButtonColor = false
    u50.BorderSizePixel = 0
    local v3 = not (a1 ~= u470) and u3254 or u442
    u50.Size = UDim2.new(0, v3, 0, v3)
    u50.Active = true
    u50.Draggable = false
    u50:SetAttribute("Draggable", false)
    u50:SetAttribute("IsInventorySlot", u14)
    v2 = if not u14 then SlotLockedTransparencyAttribute else 0.5
    u50.BackgroundTransparency = v2
    ButtonFX(u50, 1.015, nil, true)

    local function activateSlot(a1) -- Line: 3684
        -- upvalues: u16 (ref), u8 (val), u3204 (upval), u39 (ref), u40 (ref), u3504 (upval), u3130 (upval)
        -- upvalues: HiddenUIHandler (upval), u50 (ref), shouldAllowSlotDragging (val), MenuNavigation (upval)
        -- upvalues: GuiService (upval), canPlaceToolInSlot (val), u10 (upval)
        if os.clock() < 0 then
            return
        end
        if u16 and u16:IsActivationSuppressed() then
            return
        end
        local Tool = u8.Tool
        if u3204 and Tool and isAssetTool(Tool) then
            u39 = 0
            u40 = nil
            requestFavoriteToggle(Tool)
            return
        end
        local v1 = true
        if a1 ~= Enum.UserInputType.MouseButton1 then
            v1 = true
            if a1 ~= Enum.UserInputType.MouseMovement then
                v1 = a1 == Enum.UserInputType.Touch
            end
        end
        local v2 = v1
        if v2 then
            v2 = false
            local Index = u8.Index
            if u3504 < Index then
                v2 = false
                if Tool ~= nil then
                    v2 = not u8.IsDeleted
                    if v2 then
                        v2 = not u3204
                        if v2 then
                            v2 = not u3130
                            if v2 then
                                v2 = not ActiveFuseSelectionState
                                if v2 then
                                    v2 = not (not BackpackEnabled or not BackpackGui.Enabled or HiddenUIHandler.IsHidden())
                                    if v2 then
                                        v2 = false
                                        if u50:GetAttribute("Draggable") == true then
                                            v2 = shouldAllowSlotDragging(Tool) and (MenuNavigation.IsCursorActive() or u50 ~= GuiService.SelectedObject)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        v1 = os.clock()
        local v3 = v2
        if v3 then
            v3 = false
            if u40 == Tool then
                v3 = v1 - u39 < 0.5
            end
        end
        u40 = if not v2 then nil else if v3 then nil else Tool
        u39 = if not v2 then 0 else if v3 then 0 else v1
        if v3 then
            v2 = FindLowestEmpty(Tool)
            if v2 and canPlaceToolInSlot(v2, Tool) then
                u8:Swap(v2)
                if not u8.Tool then
                    u8:Delete()
                end
                if u10 then
                    task.defer(function() -- Line: 3722 -- upvalues: u10 (upval)
                        u10(true)
                    end)
                end
                return
            end
        end
        changeSlot(u8)
    end

    u50.Activated:Connect(function(a1) -- Line: 3730 -- upvalues: u16 (ref), activateSlot (val)
        if not u16 or u16:ShouldHandleNativeActivation() then
            activateSlot(a1 and a1.UserInputType)
        end
    end)
    if UserInputService.TouchEnabled then
        u50.TouchLongPress:Connect(function(a1, a2, a3) -- Line: 3738 -- upvalues: u16 (ref), u8 (val)
            if a2 == Enum.UserInputState.End then
                if not u16 or not u16:IsActivationSuppressed() then
                    local Tool = u8.Tool
                    if Tool and isAssetTool(Tool) then
                        requestFavoriteToggle(Tool)
                    end
                end
            end
        end)
    end
    v2 = u586
    local v4 = {
        GetTool = function() -- Line: 3750 -- upvalues: u8 (val)
            return u8.Tool
        end,
        CanFavorite = function(a1) -- Line: 3751 -- upvalues: u462 (upval), u8 (val), u3130 (upval), u16 (ref)
            local Visible = u462.Visible
            if Visible then
                Visible = not u8.IsDeleted
                if Visible then
                    Visible = false
                    if a1 ~= nil then
                        Visible = isAssetTool(a1) and not ActiveFuseSelectionState and not u3130 and not (u16 and u16:IsActivationSuppressed())
                    end
                end
            end
            return Visible
        end,
        OnFavorite = function(a1) -- Line: 3756 -- upvalues: u39 (ref), u40 (ref), u16 (ref)
            u39 = 0
            u40 = nil
            if u16 then
                u16:Cancel()
            end
            requestFavoriteToggle(a1)
        end,
    }
    v2:Register(u50, v4)
    u8.Frame = u50
    Selector = u50.SelectionObjectClipper.Selector
    u50.Shadow.Visible = false
    u8.IconImage = Icon
    u50.FavIcon.Visible = false
    ToolName = u50.ToolName
    TextXAlignment = ToolName.TextXAlignment
    TextYAlignment = ToolName.TextYAlignment
    u50.Weight.Visible = false
    u8.Frame.LayoutOrder = u8.Index
    if v1 <= u3504 then
        u50.StrokeFrame.Visible = false
        ToolTip = u50.ToolTip
        ToolTip.Visible = false
        u8.TooltipLabel = ToolTip
        u50.MouseEnter:Connect(function() -- Line: 3788 -- upvalues: ToolTip (ref)
            if ToolTip.Text ~= "" then
                ToolTip.Visible = false
            end
        end)
        u50.MouseLeave:Connect(function() -- Line: 3793 -- upvalues: ToolTip (ref)
            ToolTip.Visible = false
        end)

        function u8:MoveToInventory() -- Line: 3794
            -- upvalues: u3504 (upval), u470 (upval), Character (upval), Humanoid (upval), u3477 (upval), u462 (upval)
            if self.IsFakeSlot or isToolLockedToCurrentHotbarSlot(self) then
                return
            end
            if self.Tool ~= nil and not HasInventoryCategory(self.Tool) then
                return
            end
            if self.Index <= u3504 then
                local Tool = self.Tool
                self:Clear()
                local v1 = MakeSlot(u470)
                v1:Fill(Tool)
                if Tool and Tool.Parent == Character and Humanoid then
                    UnequipAllTools()
                end
                if Tool and typeof(Tool) == "Instance" and getAttribute(Tool, "ItemType") == "Asset" then
                    task.defer(syncAssetsFromSave)
                end
                if u3477 then
                    v1.Frame.Visible = false
                    v1.Frame.Parent = u462
                end
            end
        end

        if v1 <= 10 then
            v2 = if v1 ~= 10 then v1 else 0
            Number = u50.Number
            Number.Text = v2
            tostring(v2)
            Number.Visible = false
            local v5 = u3404
            local v6 = Value + v2

            v5[v6] = function() -- Line: 3828 -- upvalues: u8 (val)
                changeSlot(u8)
            end
        end
    end
    local u381 = nil
    local new = SlotDragController.new
    local v7 = {
        ScrollingFrame = if not u14 then nil else u470,
        CanStart = function() -- Line: 3922 -- upvalues: u8 (val), u50 (ref), HiddenUIHandler (upval), shouldAllowSlotDragging (val)
            local v1 = not u8.IsDeleted
            if v1 then
                v1 = false
                if u50:GetAttribute("Draggable") == true then
                    v1 = not (not BackpackEnabled or not BackpackGui.Enabled or HiddenUIHandler.IsHidden()) and shouldAllowSlotDragging(u8.Tool)
                end
            end
            return v1
        end,
        OnActivate = activateSlot,
        OnDragStart = function() -- Line: 3928
            -- upvalues: u39 (ref), u40 (ref), u3504 (upval), u3376 (upval), u8 (val), HotbarDragFeedback (upval)
            -- upvalues: u3418 (upval), u50 (ref), UIStroke (val), u3362 (upval), u381 (ref), LocalPlayer (upval)
            -- upvalues: u16 (ref)
            local v1
            u39 = 0
            u40 = nil
            local v2 = {}
            local v3 = u3504
            for i = 1, v3 do
                v1 = u3376[i]
                if v1 and v1 ~= u8 and not u8:CanSwap(v1) then
                    table.insert(v2, v1.Frame)
                end
            end
            HotbarDragFeedback.Start(v2)
            u3418[u50] = true
            UIStroke.Thickness = 2
            u3362:lock()
            local Tool = u8.Tool
            if typeof(Tool) == "Instance" then
                Tool.AncestryChanged:Connect(function() -- Line: 3945 -- upvalues: u8 (upval), Tool (val), LocalPlayer (upval), u16 (upval)
                    if u8.Tool ~= Tool
                        or Tool.Parent ~= LocalPlayer.Backpack and Tool.Parent ~= LocalPlayer.Character then
                        u16:Cancel()
                    end
                end)
            end
        end,
        OnDragEnd = function(a1, a2) -- Line: 3832
            -- upvalues: u3418 (upval), u50 (ref), HotbarDragFeedback (upval), u381 (ref), UIStroke (val), u3362 (upval)
            -- upvalues: u8 (val), shouldAllowSlotDragging (val), u461 (upval), u462 (upval), u3504 (upval)
            -- upvalues: u3102 (upval), Name (upval), SetCategory (upval), u9 (upval), u10 (upval), u3376 (upval)
            -- upvalues: Character (upval), Humanoid (upval), u3477 (upval)
            u3418[u50] = nil
            HotbarDragFeedback.Finish()
            if u381 then
                u381:Disconnect()
                u381 = nil
            end
            UIStroke.Thickness = 0
            u3362:unlock()
            if not a2 and not u8.IsDeleted and u8.Tool then
                local v1
                if not shouldAllowSlotDragging(u8.Tool) then
                    u50:SetAttribute("Draggable", false)
                    u8:RefreshDragDetector()
                    u8:updateDragAppearance()
                    return
                end
                local v2 = CheckBounds(u461, a1.X, a1.Y)
                if isToolLockedToCurrentHotbarSlot(u8) and not v2 and not CheckBounds(u50, a1.X, a1.Y) then
                    HotbarDragFeedback.Reject(u50)
                end
                if not CheckBounds(u462, a1.X, a1.Y) then
                    if v2 then
                        local Frame, v3, v4
                        v1 = {(1 / 0), nil}
                        for i = 1, u3504 do
                            v4 = u3376[i]
                            Frame = v4.Frame
                            v3 = GetOffset(Frame, a1)
                            if v3 < v1[1] then
                                v1 = {v3, v4}
                            end
                        end
                        local v5 = v1[2]
                        if v5 ~= u8 then
                            if not u8:CanSwap(v5) then
                                HotbarDragFeedback.Reject(v5.Frame)
                            end
                            u8:Swap(v5)
                            local Index = u8.Index
                            if u3504 < Index then
                                local Tool = u8.Tool
                                if Tool then
                                    if Tool.Parent == Character and Humanoid then
                                        UnequipAllTools()
                                    end
                                    if u3477 then
                                        u8.Frame.Visible = false
                                        u8.Frame.Parent = u462
                                    end
                                else
                                    u8:Delete()
                                end
                            end
                        end
                    elseif u8.Index <= u3504 then
                        u8:MoveToInventory()
                        task.delay(0.01, function() -- Line: 3905 -- upvalues: u10 (upval)
                            if u10 then
                                u10(true)
                            end
                        end)
                    elseif typeof(u8.Tool) == "Instance" and u8.Tool:IsA("Tool") and u8.Tool.CanBeDropped then
                        u8.Tool.Parent = workspace
                    end
                elseif u8.Index <= u3504 then
                    if u3102 ~= Name then
                        v1 = GetCategory(u8.Tool)
                        SetCategory(v1)
                    end
                    u8:MoveToInventory()
                    u9.Text = ""
                    task.delay(0.01, function() -- Line: 3865 -- upvalues: u10 (upval)
                        if u10 then
                            u10(true)
                        end
                    end)
                end
                task.delay(0.01, function() -- Line: 3914 -- upvalues: u10 (upval)
                    if u10 then
                        u10(true)
                    end
                end)
                return
            end
        end,
    }
    v4 = new(u50, v7)
    u50.Parent = a1
    u3376[v1] = u8
    if u3504 < v1 then
        local CanvasPosition = u470.CanvasPosition
        UpdateScrollingFrameCanvasSize()
        v4 = u470.AbsoluteCanvasSize.Y - u470.AbsoluteSize.Y
        if not u462.Visible or u3477 then
            u470.CanvasPosition = CanvasPosition
        else
            u470.CanvasPosition = Vector2.new(CanvasPosition.X, (math.min(CanvasPosition.Y, (math.max(0, v4)))))
        end
    end
    return u8
end

function moveStackSlotIntoFrontHotbar(a1) -- Line: 3972 -- upvalues: u3504 (val), u3376 (val), u548 (ref)
    if a1 and not a1.IsDeleted then
        local v1, v2, v3
        if a1.Index <= u3504 then
            return a1
        end
        local v4 = getInsertableHotbarIndices(a1.Tool)
        local v5 = v4[1]
        if not v5 then
            return nil
        end
        local v6 = u3376[v5]
        if not v6 then
            return nil
        end
        v5 = u548
        local v7 = v5 and table.find(v4, v5.Index)
        if not v7 then
            v5 = v4[#v4]
            local v8 = v5 and u3376[v5]
            if v8 and v8.Tool then
                v8:MoveToInventory()
                v7 = #v4
            end
        end
        if not v7 then
            return nil
        end
        for i = v7, 2, -1 do
            v2 = u3376[v4[i]]
            v3 = u3376[v4[i - 1]]
            if v2 and v3 then
                v3:Swap(v2)
            end
        end
        v1:Swap(v6)
        if u3504 < v1.Index and not v1.Tool then
            v1:Delete()
        end
        return v6
    end
    return nil
end

function movePendingHotbarAssets() -- Line: 4021 -- upvalues: u592 (val), u588 (val), u10 (ref)
    local v1, v2
    local v3 = false
    for k in pairs(u592) do
        v1 = u588[k]
        if v1 then
            v2 = moveStackSlotIntoFrontHotbar(v1)
            if v2 then
                u588[k] = v2
                u592[k] = nil
                v3 = true
            end
        end
    end
    if v3 then
        AdjustHotbarFrames()
        UpdateInventorySlots()
        if u10 then
            u10(true)
        end
    end
    return v3
end

function movePendingHotbarEggs() -- Line: 4046
    -- upvalues: u3560 (val), u3546 (val), u10 (ref), u3574 (val), u3116 (val)
    local v1, v2
    local v3 = false
    for k in pairs(u3560) do
        v1 = u3546[k]
        if v1 then
            v2 = moveStackSlotIntoFrontHotbar(v1)
            if v2 then
                u3546[k] = v2
                u3560[k] = nil
                v3 = true
            end
        end
    end
    if v3 then
        AdjustHotbarFrames()
        UpdateInventorySlots()
        if u10 then
            u10(true)
        end
    end
    for k2 in pairs(u3574) do
        if u3116:ForceEggIntoTutorialHotbar(k2) ~= nil then
            u3574[k2] = nil
        end
    end
    return v3
end

function OnChildAdded(a1, a2) -- Line: 4077
    -- upvalues: Character (ref), Humanoid (ref), u562 (ref), u470 (ref), u553 (ref), u3390 (val), LocalPlayer (ref)
    -- upvalues: Backpack (ref), u10 (ref), u3504 (val), u462 (ref)
    if not a1:IsA("Tool") then
        if a1:IsA("Humanoid") and a1.Parent == Character then
            Humanoid = a1
        end
        return
    end
    if a1.Parent == Character then
        tick()
    end
    local Attribute = a1:GetAttribute("ItemType")
    if Attribute == "Asset" then
        invalidateEquipBestStatus()
        syncVirtualAssetEquipStateFromTool(a1)
        task.defer(syncAssetsFromSave)
        return
    end
    if Attribute == "AssetEgg" then
        syncVirtualEggEquipStateFromTool(a1)
        return
    end
    local v1 = u470
    local CanvasPosition = u470.CanvasPosition
    if not u553 and a1.Parent == Character and not u3390[a1] then
        local StarterGear = LocalPlayer:FindFirstChild("StarterGear")
        if StarterGear and StarterGear:FindFirstChild(a1.Name) then
            u553 = true
            local v2 = insertToolIntoFrontHotbar(a1) or claimLowestEmptySlot(a1) or MakeSlot(u470)
            if v2.Tool ~= a1 then
                v2:Fill(a1)
            end
            if isGearTool(a1) then
                ensureGameplayGearHotbarSlots()
            end
            for k, v in pairs(Character:GetChildren()) do
                if v:IsA("Tool") and v ~= a1 then
                    v.Parent = Backpack
                end
            end
            AdjustHotbarFrames()
            if u10 then
                u10(true)
            end
            UpdateInventorySlots()
            v1.CanvasPosition = Vector2.new(CanvasPosition.X, (math.min(CanvasPosition.Y, (math.max(0, v1.AbsoluteCanvasSize.Y - v1.AbsoluteSize.Y)))))
            return
        end
    end
    local v3 = u3390[a1]
    if v3 then
        v3:UpdateEquipView()
        return
    end
    v3 = insertToolIntoFrontHotbar(a1) or claimLowestEmptySlot(a1) or MakeSlot(u470)
    if v3.Tool ~= a1 then
        v3:Fill(a1)
    end
    if isGearTool(a1) then
        ensureGameplayGearHotbarSlots()
    end
    if v3.Index <= u3504 and not u462.Visible then
        AdjustHotbarFrames()
    end
    UpdateInventorySlots()
    v1.CanvasPosition = Vector2.new(CanvasPosition.X, (math.min(CanvasPosition.Y, (math.max(0, v1.AbsoluteCanvasSize.Y - v1.AbsoluteSize.Y)))))
    task.delay(0.05, function() -- Line: 4156 -- upvalues: u10 (upval)
        if u10 then
            u10(true)
        end
    end)
end

function OnChildRemoved(a1) -- Line: 4165
    -- upvalues: u562 (ref), u3390 (val), u3504 (val), u462 (ref), Character (ref), Backpack (ref), u3376 (val)
    if not a1:IsA("Tool") then
        return
    end
    tick()
    local Attribute = a1:GetAttribute("ItemType")
    if Attribute == "Asset" then
        invalidateEquipBestStatus()
        task.defer(reconcileVirtualAssetEquipState)
        task.defer(syncAssetsFromSave)
        local v1 = u3390[a1]
        if v1 and v1.Tool == a1 then
            v1:Clear()
            if u3504 < v1.Index then
                v1:Delete()
            end
            if v1.Index <= u3504 and not u462.Visible then
                AdjustHotbarFrames()
            end
            UpdateInventorySlots()
        end
        return
    end
    if Attribute == "AssetEgg" then
        task.defer(reconcileVirtualEggEquipState)
        return
    end
    local v2 = u3390[a1]
    local Parent = a1.Parent
    if Parent ~= Character and Parent ~= Backpack then
        local v3 = v2
        if not v3 then
            for k, v in pairs(u3376) do
                if v.Tool == a1 then
                    v3 = v
                    break
                end
            end
        elseif v3.Tool ~= a1 then
            for k2, i in pairs(u3376) do
                if i.Tool == a1 then
                    v3 = i
                    break
                end
            end
        end
        if v3 and v3.Tool == a1 then
            v3:Clear()
            if u3504 < v3.Index then
                v3:Delete()
            end
            if v3.Index <= u3504 and not u462.Visible then
                AdjustHotbarFrames()
            end
            UpdateInventorySlots()
        end
    end
end

function SetupCharacter(a1) -- Line: 4222
    -- upvalues: u587 (ref), u601 (ref), u3376 (val), u560 (ref), Character (ref), u409 (ref), Backpack (ref)
    -- upvalues: LocalPlayer (ref)
    local v1
    u587 = nil
    u601 = nil
    for i = #u3376, 1, -1 do
        v1 = u3376[i]
        if v1.Tool then
            if typeof(v1.Tool) ~= "Instance" then
                v1:UpdateEquipView(true)
            else
                v1:Clear()
            end
        end
    end
    for k, v in pairs(u560) do
        v:Disconnect()
    end
    u560 = {}
    Character = a1
    table.insert(u560, (a1.ChildRemoved:Connect(OnChildRemoved)))
    table.insert(u560, (a1.ChildAdded:Connect(function(a1) -- Line: 4244 -- upvalues: u409 (upval)
        if not a1:IsA("Tool") then
            OnChildAdded(a1, false)
            return
        end
        if a1.Name ~= u409.LUCKY_BLOCK_TOOL_NAME and a1:GetAttribute("HideFromBackpackUI") ~= true then
            OnChildAdded(a1, false)
            return
        end
    end)))
    for k2, j in pairs(a1:GetChildren()) do
        task.spawn(OnChildAdded, j, false)
    end
    Backpack = LocalPlayer:WaitForChild("Backpack")
    table.insert(u560, (Backpack.ChildRemoved:Connect(OnChildRemoved)))
    table.insert(u560, (Backpack.ChildAdded:Connect(function(a1) -- Line: 4264 -- upvalues: u409 (upval)
        if not a1:IsA("Tool") then
            OnChildAdded(a1, true)
            return
        end
        if a1.Name ~= u409.LUCKY_BLOCK_TOOL_NAME and a1:GetAttribute("HideFromBackpackUI") ~= true then
            OnChildAdded(a1, true)
            return
        end
    end)))
    for k3, k4 in pairs(Backpack:GetChildren()) do
        task.spawn(OnChildAdded, k4, false)
    end
    table.insert(u560, (LocalPlayer.ChildAdded:Connect(function(a1_2) -- Line: 4282 -- upvalues: Backpack (upval), Character (upval), a1 (val)
        if a1_2:IsA("Backpack") and a1_2 ~= Backpack and Character == a1 then
            SetupCharacter(a1)
        end
    end)))
    AdjustHotbarFrames()
    invalidateEquipBestStatus(true)
    reconcileVirtualAssetEquipState()
end

local PlayerGui_2 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

function HandleInputBegan(a1, a2) -- Line: 4293
    -- upvalues: u3463 (ref), u554 (ref), Value_2 (val), u3404 (val), u462 (ref), PlayerGui_2 (val), u3362 (val)
    if a2 == false then
        local MouseLocation, UserInputType
        if a1.UserInputType == Enum.UserInputType.Keyboard and not u3463 then
            if not u554 and a1.KeyCode.Value ~= Value_2 then
                UserInputType = a1.UserInputType
                if UserInputType == Enum.UserInputType.MouseButton1 then
                    if u462.Visible and not ActiveFuseSelectionState then
                        MouseLocation = UserInputService:GetMouseLocation()
                        for i, j in PlayerGui_2:GetGuiObjectsAtPosition(MouseLocation.X, MouseLocation.Y) do
                            if j.Name:find("CategoryFrame") then
                                if not j then
                                    u3362:deselect()
                                end
                                return
                            end
                        end
                        if true then
                            u3362:deselect()
                        end
                    end
                elseif UserInputType == Enum.UserInputType.Touch and u462.Visible and not ActiveFuseSelectionState then
                    MouseLocation = UserInputService:GetMouseLocation()
                    for k, n in PlayerGui_2:GetGuiObjectsAtPosition(MouseLocation.X, MouseLocation.Y) do
                        if n.Name:find("CategoryFrame") then
                            if not n then
                                u3362:deselect()
                            end
                            return
                        end
                    end
                    if true then
                        u3362:deselect()
                    end
                end
                return
            end
            local v1 = u3404[a1.KeyCode.Value]
            if v1 then
                if ActiveFuseSelectionState then
                    return
                end
                v1(a2)
            end
        end
        UserInputType = a1.UserInputType
        if UserInputType == Enum.UserInputType.MouseButton1 then
            if u462.Visible and not ActiveFuseSelectionState then
                MouseLocation = UserInputService:GetMouseLocation()
                for m, i5 in PlayerGui_2:GetGuiObjectsAtPosition(MouseLocation.X, MouseLocation.Y) do
                    if i5.Name:find("CategoryFrame") then
                        if not i5 then
                            u3362:deselect()
                        end
                        return
                    end
                end
                if true then
                    u3362:deselect()
                end
            end
        elseif UserInputType == Enum.UserInputType.Touch and u462.Visible and not ActiveFuseSelectionState then
            MouseLocation = UserInputService:GetMouseLocation()
            for i6, i7 in PlayerGui_2:GetGuiObjectsAtPosition(MouseLocation.X, MouseLocation.Y) do
                if i7.Name:find("CategoryFrame") then
                    if not i7 then
                        u3362:deselect()
                    end
                    return
                end
            end
            if true then
                u3362:deselect()
            end
        end
    end
end

function OnInputServiceChanged(a1) -- Line: 4328 -- upvalues: u3504 (val), u3376 (val)
    local KeyboardEnabled
    if a1 == "KeyboardEnabled" then
        KeyboardEnabled = UserInputService.KeyboardEnabled and not UserInputService.VREnabled
        for i = 1, u3504 do
            u3376[i]:TurnNumber(KeyboardEnabled)
        end
    elseif a1 == "VREnabled" then
        KeyboardEnabled = UserInputService.KeyboardEnabled and not UserInputService.VREnabled
        for j = 1, u3504 do
            u3376[j]:TurnNumber(KeyboardEnabled)
        end
    end
end

function OnGamepadFocus() -- Line: 4336 -- upvalues: MenuNavigation (val)
    if MenuNavigation.IsCursorActive() then
        return Enum.ContextActionResult.Pass
    end
    return Enum.ContextActionResult.Sink
end

function unbindAllGamepadEquipActions() -- Line: 4339
    ContextActionService:UnbindAction("RBXBackpackHasGamepadFocus")
    ContextActionService:UnbindAction("RBXCloseInventory")
end

function _setHotbarVisibility(a1, a2) -- Line: 4343 -- upvalues: u3504 (val), u3376 (val)
    local v1
    local v2, v3 = a2, a1
    for i = 1, u3504 do
        v1 = u3376[i]
        if v1 and v1.Frame then
            if v2 or v1.Tool then
                v1.Frame.Visible = v3
            end
        end
    end
end

function getEquippedHotbarSlot() -- Line: 4351
    -- upvalues: u588 (val), u3504 (val), u3546 (val), Character (ref), u3390 (val)
    local v1
    local v2 = reconcileVirtualAssetEquipState()
    if typeof(v2) == "string" then
        v1 = u588[v2]
        if v1 and not v1.IsDeleted and v1.Index <= u3504 and v1.Tool then
            return v1
        end
    end
    v2 = reconcileVirtualEggEquipState()
    if typeof(v2) == "string" then
        v1 = u3546[v2]
        if v1 and not v1.IsDeleted and v1.Index <= u3504 and v1.Tool then
            return v1
        end
    end
    if Character then
        for i, v in ipairs(Character:GetChildren()) do
            if v:IsA("Tool") then
                v2 = u3390[v]
                if v2 and v2.Index <= u3504 and v2.Tool then
                    return v2
                end
            end
        end
    end
    return nil
end

function changeTool(a1, a2, a3) -- Line: 4391 -- upvalues: u3504 (val), u3376 (val)
    local v1
    if a2 ~= Enum.UserInputState.Begin then
        return
    end
    local v2 = if a3.KeyCode ~= Enum.KeyCode.ButtonL1 then 1 else -1
    local v3 = getEquippedHotbarSlot()
    local Index = if not v3 then if v2 ~= -1 then u3504 else 1 else v3.Index
    for i = 1, u3504 do
        Index = Index + v2
        if u3504 < Index then
            Index = 1
        elseif Index < 1 then
            Index = u3504
        end
        v1 = u3376[Index]
        if v1.Tool and v1 ~= v3 then
            v1:Select()
            return
        end
    end
end

function getGamepadSwapSlot() -- Line: 4418 -- upvalues: u3376 (val)
    local v1 = #u3376
    for i = 1, v1 do
        if 0 < u3376[i].Frame:WaitForChild("UIStroke").Thickness then
            return u3376[i]
        end
    end
end

function changeSlot(a1) -- Line: 4426
    -- upvalues: u462 (ref), MenuNavigation (val), GuiService (val), u469 (ref), u3504 (val)
    if a1.IsFakeSlot then
        a1:Select()
        return
    end
    local Visible = not VRService.VREnabled or u462.Visible
    if not MenuNavigation.IsCursorActive() and a1.Frame == GuiService.SelectedObject and Visible then
        local v1 = getGamepadSwapSlot()
        if not v1 then
            local Size = a1.Frame.Size
            local Position = a1.Frame.Position
            a1.Frame:TweenSizeAndPosition(Size + UDim2.new(0, 10, 0, 10), Position - UDim2.new(0, 5, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function() -- Line: 4465 -- upvalues: a1 (val), Size (val), Position (val)
                a1.Frame:TweenSizeAndPosition(Size, Position, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true)
            end)
            local UIStroke_2 = a1.Frame:WaitForChild("UIStroke")
            UIStroke_2.Thickness = 3
            u469.SelectionImageObject.Visible = true
            return
        end
        local UIStroke = v1.Frame:WaitForChild("UIStroke")
        UIStroke.Thickness = 0
        if v1 ~= a1 then
            a1:Swap(v1)
            u469.SelectionImageObject.Visible = false
            if u3504 < a1.Index and not a1.Tool then
                if GuiService.SelectedObject == a1.Frame then
                    GuiService.SelectedObject = v1.Frame
                end
                a1:Delete()
            end
            if u3504 < v1.Index and not v1.Tool then
                if GuiService.SelectedObject == v1.Frame then
                    GuiService.SelectedObject = a1.Frame
                end
                v1:Delete()
                return
            end
        end
        return
    end
    a1:Select()
    u469.SelectionImageObject.Visible = false
end

function vrMoveSlotToInventory() -- Line: 4485 -- upvalues: u469 (ref)
    if not VRService.VREnabled then
        return
    end
    local v1 = getGamepadSwapSlot()
    if v1 and v1.Tool then
        local UIStroke = v1:WaitForChild("UIStroke")
        UIStroke.Thickness = 0
        v1:MoveToInventory()
        u469.SelectionImageObject.Visible = false
    end
end

function enableGamepadInventoryControl() -- Line: 4496
    -- upvalues: u462 (ref), u3362 (val), MenuNavigation (val), GuiService (val), u461 (ref)
    ContextActionService:BindAction("RBXBackpackHasGamepadFocus", OnGamepadFocus, false, Enum.UserInputType.Gamepad1)
    local v1 = ContextActionService
    local ButtonB = Enum.KeyCode.ButtonB
    local ButtonStart = Enum.KeyCode.ButtonStart
    local ButtonSelect = Enum.KeyCode.ButtonSelect
    v1:BindAction("RBXCloseInventory", function(a1, a2) -- Line: 4497 -- upvalues: u462 (upval), u3362 (upval)
        if a2 ~= Enum.UserInputState.Begin then
            return
        end
        local v1 = getGamepadSwapSlot()
        if v1 then
            local UIStroke = v1.Frame:WaitForChild("UIStroke")
            UIStroke.Thickness = 0
            return
        end
        if u462.Visible then
            u3362:deselect()
        end
    end, false, ButtonB, ButtonStart, ButtonSelect)
    if not UserInputService.VREnabled and not MenuNavigation.IsCursorActive() then
        GuiService.SelectedObject = u461:FindFirstChild("1")
    end
end

function disableGamepadInventoryControl() -- Line: 4528
    -- upvalues: u3504 (val), u3376 (val), GuiService (val), u459 (ref)
    local UIStroke, v1
    unbindAllGamepadEquipActions()
    for i = 1, u3504 do
        v1 = u3376[i]
        if v1 and v1.Frame then
            UIStroke = v1.Frame:WaitForChild("UIStroke")
            UIStroke.Thickness = 0
        end
    end
    if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(u459) then
        GuiService.SelectedObject = nil
    end
end

function _bindBackpackHotbarAction() -- Line: 4540 -- upvalues: u554 (ref), u444 (ref)
    if u554 and not u444 then
        u444 = true
        ContextActionService:BindAction("RBXHotbarEquip", changeTool, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
    end
end

function _unbindBackpackHotbarAction() -- Line: 4552 -- upvalues: u444 (ref)
    disableGamepadInventoryControl()
    u444 = false
    ContextActionService:UnbindAction("RBXHotbarEquip")
end

function gamepadDisconnected() -- Line: 4557 -- upvalues: u3491 (ref)
    u3491 = false
    disableGamepadInventoryControl()
end

function gamepadConnected() -- Line: 4561
    -- upvalues: u3491 (ref), GuiService (val), u459 (ref), u552 (ref), u554 (ref), u444 (ref), u462 (ref)
    u3491 = true
    GuiService:AddSelectionParent("RBXBackpackSelection", u459)
    if u552 >= 1 and u554 and not u444 then
        u444 = true
        ContextActionService:BindAction("RBXHotbarEquip", changeTool, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
    end
    if u462.Visible then
        enableGamepadInventoryControl()
    end
end

function OnIconChanged(a1) -- Line: 4579
    -- upvalues: tryCore (val), u3362 (val), GuiService (val), u554 (ref), u459 (ref), u552 (ref), u444 (ref)
    local v1 = a1 and tryCore("GetCore", "TopbarEnabled")
    u3362:setEnabled(v1 and not GuiService.MenuIsOpen and not ActiveFuseSelectionState)
    u459.Visible = v1
    PositionInventoryAffordances()
    if not v1 then
        disableGamepadInventoryControl()
        u444 = false
        ContextActionService:UnbindAction("RBXHotbarEquip")
        return
    end
    if u552 >= 1 and v1 and not u444 then
        u444 = true
        ContextActionService:BindAction("RBXHotbarEquip", changeTool, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
        return
    end
end

function createScrollButton(a1, a2) -- Line: 4602
    local v1 = NewGui("ImageButton", a1)
    v1.Size = UDim2.new(0, 40, 0, 40)
    v1.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png"
    local v2 = NewGui("ImageLabel", "Icon")
    v2.Size = UDim2.new(0.5, 0, 0.5, 0)
    v2.Position = UDim2.new(0.25, 0, 0.25, 0)
    v2.Image = a2
    v2.Parent = v1
    local v3 = NewGui("ImageLabel", "Selection")
    v3.Size = UDim2.new(0.9, 0, 0.9, 0)
    v3.Position = UDim2.new(0.05, 0, 0.05, 0)
    v3.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png"
    v1.SelectionImageObject = v3
    return v1, v2, v3
end

u459 = BackpackGui:WaitForChild("Backpack")
u459.Visible = false
u461 = NewGui("Frame", "Hotbar")
u461.Parent = u459
local v15 = script:FindFirstChild("RoundChoices")
if v15 then
    v15.Parent = u461
    if v13 then
        v15.Size = UDim2.fromScale(1, 0.4)
    end
elseif RunService:IsStudio() then
    error("RoundChoices frame not found in Backpack script")
end
for m = 1, u3504 do
    MakeSlot(u461, m).Frame.Visible = false
end
u460 = u459:WaitForChild("Main")
u462 = u460:WaitForChild("Inventory")
local u1114 = u462:WaitForChild("Loading")
u1114.Visible = false
task.spawn(v8, u462.ImageLabel.ImageLabel)
AutoSell = u462.AutoSell
AutoSell.Visible = false
task.spawn(initializeAutoSellUI)
FindLowestEmpty()
AdjustHotbarFrames()
u3362.selected:Connect(function() -- Line: 4653 -- upvalues: GuiService (val), u3116 (val)
    if not GuiService.MenuIsOpen then
        u3116.OpenClose()
    end
end)
u3362.deselected:Connect(function() -- Line: 4658 -- upvalues: u462 (ref), u3116 (val)
    if u462.Visible then
        u3116.OpenClose()
    end
end)
v8 = NewGui("ImageLabel", "LeftBumper")
v8.Size = UDim2.new(0, 40, 0, 40)
v8.Position = UDim2.new(0, -v8.Size.X.Offset, 0.5, -v8.Size.Y.Offset / 2)
v8 = NewGui("ImageLabel", "RightBumper")
v8.Size = UDim2.new(0, 40, 0, 40)
v8.Position = UDim2.new(1, 0, 0.5, -v8.Size.Y.Offset / 2)
local BackgroundColor3 = u462.BackgroundColor3
InventoryStroke = u462:FindFirstChildWhichIsA("UIStroke")
InventoryStrokeDefaultColor = InventoryStroke and InventoryStroke.Color or nil
InventoryStrokeDefaultTransparency = u462.BackgroundTransparency
u462.Visible = false

function refreshInventoryFrameVisuals() -- Line: 4675
    -- upvalues: u462 (ref), u3204 (ref), u468 (val), BackgroundColor3 (val)
    if ActiveFuseSelectionState then
        u462.BackgroundColor3 = FUSE_SELECTION_BACKGROUND_COLOR
        if InventoryStroke then
            InventoryStroke.Color = FUSE_SELECTION_STROKE_COLOR
        end
        u462.BackgroundTransparency = FUSE_SELECTION_BACKGROUND_TRANSPARENCY
        return
    end
    u462.BackgroundColor3 = u3204 and u468 or BackgroundColor3
    if InventoryStroke and InventoryStrokeDefaultColor then
        InventoryStroke.Color = InventoryStrokeDefaultColor
    end
    u462.BackgroundTransparency = InventoryStrokeDefaultTransparency
end

local u1238 = Instance.new("UIStroke")
u1238.Name = "FavoriteMode"
u1238.Thickness = 4.5
u1238.Color = Color3.fromRGB(255, 170, 0)
u1238.Enabled = false
u1238.ZIndex = 2
u1238.Parent = u462

function updateFavoriteModeVisuals() -- Line: 4699 -- upvalues: u414 (ref), u3204 (ref), u1238 (ref)
    local TextLabel = u414 and u414:FindFirstChildWhichIsA("TextLabel")
    if TextLabel then
        TextLabel.Text = if not u3204 then "Favorite: OFF" else "Favorite: ON"
    end
    if u1238 then
        u1238.Enabled = u3204 and not ActiveFuseSelectionState
    end
    refreshInventoryFrameVisuals()
end

function setFavoriteModeActive(a1) -- Line: 4712 -- upvalues: u3204 (ref), u414 (ref), u1238 (ref)
    if u414 then
        updateFavoriteModeVisuals()
        return
    end
    refreshInventoryFrameVisuals()
    if u1238 then
        u1238.Enabled = a1 and not ActiveFuseSelectionState
    end
end

function hideFavoriteModeButton() -- Line: 4725 -- upvalues: u3204 (ref), u414 (ref), AutoSell (ref), u603 (ref)
    if u3204 then
        setFavoriteModeActive(false)
    end
    if u414 then
        u414.Visible = false
        if AutoSell then
            AutoSell.Visible = false
        end
        if u603 then
            u603.Visible = false
        end
    end
end

function refreshFavoriteModeVisibility() -- Line: 4741
    -- upvalues: u414 (ref), u209 (val), u3102 (ref), Name (val), AutoSell (ref), u603 (ref)
    if not u414 then
        return
    end
    local v1 = u209[u3102]
    local v2 = u3102 == Name
    if v1 and v1.Tags then
        for i, j in v1.Tags do
            if j == "Asset" then
                v2 = true
                break
            end
        end
    end
    if not v2 then
        hideFavoriteModeButton()
    else
        u414.Visible = false
        if AutoSell then
            AutoSell.Visible = false
        end
        if u603 then
            u603.Visible = false
        end
    end
    updateEquipBestButtonVisibility()
end

u414 = u462:FindFirstChild("FavoriteMode") or script:FindFirstChild("FavoriteMode")
if u414 then
    u414.Parent = u462
    u414.Visible = false
    updateFavoriteModeVisuals()
    local v16 = u414
    ButtonFX(v16, nil, function() -- Line: 4779 -- upvalues: u3204 (ref)
        setFavoriteModeActive(not u3204)
    end)
end
u603 = u462:FindFirstChild("EquipBest")
if u603 then
    u603.Visible = false
    ButtonFX(u603, nil, requestEquipBest)
end
local v17 = script:FindFirstChild("EquipBest")
if v17 and v17:IsA("GuiButton") then
    u604 = v17:Clone()
    assert(u604, "missing hotbar")
    u604.Parent = u461
    u604.Visible = false
    ButtonFX(u604, nil, requestEquipBest)
end
v17 = u462:FindFirstChild("CategoryLabel") or script.CategoryTemplate:Clone()
v17.Parent = u462
local TextLabel = if not v17:IsA("TextLabel") then v17:FindFirstChildWhichIsA("TextLabel", true) else v17
assert(TextLabel and TextLabel:IsA("TextLabel"), "Category label template must contain a TextLabel")
local u1382 = {}
local u1383 = {}

local function u3105() -- Line: 4809 -- upvalues: u1383 (val)
    local ImageButton, v1
    local v2 = ActiveFuseSelectionState
    local v3 = v2 ~= nil
    local v4 = nil
    local v5 = nil
    for i, j in u1383, v4, v5 do
        v1 = true
        if v3 then
            v1 = v2.AllowedCategories[i] == true
        end
        j.Visible = v1
        ImageButton = j:FindFirstChild("ImageButton")
        if ImageButton and ImageButton:IsA("GuiButton") then
            ImageButton.Active = v1
        end
    end
end

function updateCategorySelectionVisuals() -- Line: 4826 -- upvalues: u1382 (val), u3102 (ref)
    local v1
    local v2 = nil
    local v3 = nil
    for i, j in u1382, v2, v3 do
        v1 = i == u3102
        j.Enabled = v1
    end
end

function updateCategoryLabel(a1) -- Line: 4832 -- upvalues: TextLabel (val), u462 (ref) -- types: a1: string
    TextLabel.Text = a1
    u462:SetAttribute("CapacityCategory", a1)
end

function applyCategoryLayout() -- Line: 4837
    -- upvalues: u471 (ref), u470 (ref), CellSize (ref), u474 (ref), AspectRatio (ref), ScrollingDirection (ref)
    -- upvalues: u476 (ref), u477 (ref), u480 (ref), PaddingLeft (ref)
    if u471 and u470 then
        if not CellSize then
            CellSize = u471.CellSize
        end
        if not u474 then
            u474 = u471:FindFirstChildWhichIsA("UIAspectRatioConstraint") or u470:FindFirstChildWhichIsA("UIAspectRatioConstraint")
            if u474 then
                AspectRatio = u474.AspectRatio
            end
        end
        if not ScrollingDirection then
            ScrollingDirection = u470.ScrollingDirection
        end
        if not u476 then
            u476 = u471.FillDirection
        end
        if not u477 then
            u477 = u471.HorizontalAlignment
        end
        if u480 and not PaddingLeft then
            PaddingLeft = u480.PaddingLeft
        end
        u471.CellSize = CellSize
        if u474 and AspectRatio then
            u474.AspectRatio = AspectRatio
        end
        u470.AutomaticCanvasSize = Enum.AutomaticSize.Y
        u470.ScrollingDirection = ScrollingDirection
        u471.FillDirection = u476
        u471.HorizontalAlignment = u477
        if u480 and PaddingLeft then
            u480.PaddingLeft = PaddingLeft
        end
        return
    end
end

function SetCategory(a1) -- Line: 4883
    -- upvalues: u3102 (ref), u9 (ref), u11 (ref), Name (val), u3204 (ref), u1114 (ref), u470 (ref), u10 (ref)
    if ActiveFuseSelectionState and ActiveFuseSelectionState.AllowedCategories[a1] ~= true then
        a1 = ActiveFuseSelectionState.PreferredCategory
    end
    if u3102 == a1 then
        updateCategoryLabel(a1)
        updateCategorySelectionVisuals()
        return
    end
    u3102 = a1
    applyCategoryLayout()
    if u9 and u9.Text ~= "" then
        if u11 then
            u11()
        end
        u9.Text = ""
    end
    if u3102 ~= Name and u3204 then
        setFavoriteModeActive(false)
    end
    if u1114 and u3102 ~= Name then
        u1114.Visible = false
    end
    refreshFavoriteModeVisibility()
    updateCategoryLabel(a1)
    if u470 then
        u470.CanvasPosition = Vector2.new(0, 0)
    end
    u10()
    updateCategorySelectionVisuals()
end

local v18 = u462:WaitForChild("CategoryFrame")
local v19 = v18.CategoryTemplate
if not v18:FindFirstChildWhichIsA("UIGridLayout") then
    v18:FindFirstChildWhichIsA("UIListLayout")
end

function createHintForCategory(a1, a2) -- Line: 4922
    local v1, v2, v3 = a1:ToHSV()
    v3 = math.clamp(v3 + a2, 0, 1)
    return Color3.fromHSV(v1, v2, v3)
end

local v20 = nil
local v21 = nil
for i5, i6 in v10, v20, v21 do
    local Name_2 = i6.Name
    v1 = v19:Clone()
    v2 = v1.ImageButton
    v3 = v1:FindFirstChild("CategoryName")
    if v3 and v3:IsA("TextLabel") then
        v3.Text = Name_2
    end
    v3 = v1.BackgroundColor3
    local u2872 = v5:Create(v1, TweenInfo.new(0.2), {BackgroundColor3 = createHintForCategory(v3, 0.2)})
    local u2880 = v5:Create(v1, TweenInfo.new(0.2), {BackgroundColor3 = v3})
    v2.MouseEnter:Connect(function() -- Line: 4942 -- upvalues: u2872 (val)
        u2872:Play()
    end)
    v2.MouseLeave:Connect(function() -- Line: 4943 -- upvalues: u2880 (val)
        u2880:Play()
    end)
    v2.MouseButton1Down:Connect(function() -- Line: 4944 -- upvalues: u2880 (val)
        u2880:Play()
    end)
    v2.Activated:Connect(function() -- Line: 4945 -- upvalues: u2872 (val), SetCategory (ref), Name_2 (val)
        u2872:Play()
        SetCategory(Name_2)
    end)
    v3 = v1.UIStroke
    assert(v3:IsA("UIStroke"), "Category button UIStroke must be a UIStroke")
    v3.Enabled = false
    u1382[Name_2] = v3
    u1383[Name_2] = v1
    v2.Image = i6.Image
    v1.Visible = true
    v1.Parent = v18
end
u3105()
updateCategoryLabel(u3102)
updateCategorySelectionVisuals()
refreshFavoriteModeVisibility()
u469 = NewGui("TextButton", "VRInventorySelector")
u469.Position = UDim2.new(0, 0, 0, 0)
u469.Size = UDim2.new(1, 0, 1, 0)
u469.BackgroundTransparency = 1
u469.Text = ""
u469.Parent = u462
v19 = NewGui("ImageLabel", "Selector")
v19.Size = UDim2.new(1, 0, 1, 0)
v19.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
v19.ScaleType = Enum.ScaleType.Slice
v19.SliceCenter = Rect.new(12, 12, 52, 52)
v19.Visible = false
u469.SelectionImageObject = v19
u469.MouseButton1Click:Connect(function() -- Line: 4975
    vrMoveSlotToInventory()
end)
u470 = u462:WaitForChild("ScrollingFrame")
u471 = u470:WaitForChild("UIGridLayout")
u480 = u470:FindFirstChildWhichIsA("UIPadding")
u474 = u471:FindFirstChildWhichIsA("UIAspectRatioConstraint") or u470:FindFirstChildWhichIsA("UIAspectRatioConstraint")
if u474 then
    AspectRatio = u474.AspectRatio
end
ScrollingDirection = u470.ScrollingDirection
if u480 then
    PaddingLeft = u480.PaddingLeft
end
if v13 then
    u471.CellSize = UDim2.new(u471.CellSize.X.Scale, u471.CellSize.X.Offset, u471.CellSize.Y.Scale, u471.CellSize.Y.Offset / 2)
end
CellSize = u471.CellSize
applyCategoryLayout()
v6.Fit(u471, if not v13 then 6 else 5, v14)
local u1799 = createScrollButton("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")
u1799.Size = UDim2.new(0, 34, 0, 34)
local v22 = UDim2.new
v21 = -u1799.Size.X.Offset / 2
u1799.Position = v22(0.5, v21, 0, 43)
u1799.Icon.Position = u1799.Icon.Position - UDim2.new(0, 0, 0, 2)
u1799.MouseButton1Click:Connect(function() -- Line: 5015 -- upvalues: u470 (ref), u3254 (val)
    u470.CanvasPosition = Vector2.new(
        u470.CanvasPosition.X,
        (math.min(u470.AbsoluteCanvasSize.Y - u470.AbsoluteWindowSize.Y, (math.max(0, u470.CanvasPosition.Y - (u3254 + 5)))))
    )
end)
local u1843 = createScrollButton("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")
u1843.Rotation = 180
u1843.Icon.Position = u1843.Icon.Position - UDim2.new(0, 0, 0, 2)
u1843.Size = UDim2.new(0, 34, 0, 34)
v22 = UDim2.new
v21 = -u1843.Size.X.Offset / 2
v1 = -u1843.Size.Y.Offset
u1843.Position = v22(0.5, v21, 1, v1 - 3)
u1843.MouseButton1Click:Connect(function() -- Line: 5040 -- upvalues: u470 (ref), u3254 (val)
    u470.CanvasPosition = Vector2.new(
        u470.CanvasPosition.X,
        (math.min(u470.AbsoluteCanvasSize.Y - u470.AbsoluteWindowSize.Y, (math.max(0, u470.CanvasPosition.Y + (u3254 + 5)))))
    )
end)
u470.Changed:Connect(function(a1) -- Line: 5052 -- upvalues: u470 (ref), u1799 (ref), u1843 (ref)
    if a1 == "AbsoluteWindowSize" or a1 == "CanvasPosition" or a1 == "AbsoluteCanvasSize" then
        local v1 = u470.CanvasPosition.Y ~= 0
        local v2 = u470.CanvasPosition.Y < u470.AbsoluteCanvasSize.Y - u470.AbsoluteWindowSize.Y
        u1799.Visible = v1
        u1843.Visible = v2
    end
end)
ResizeContainers()
;(u462:GetPropertyChangedSignal("Visible")):Connect(PositionInventoryAffordances)
PlatformController.Changed:Connect(PositionInventoryAffordances)
PositionInventoryAffordances()
local u1948 = Utility:Create("Frame")({
    Name = "GamepadHintsFrame",
    BackgroundTransparency = 1,
    Visible = false,
    AnchorPoint = Vector2.new(0, 0.5),
    Position = UDim2.fromScale(0.22, 0.062),
    Size = UDim2.new(0.76, 0, 0, if not u3240 then 32 else 36),
    Parent = u462,
})

function createHint(a1, a2) -- Line: 5080 -- upvalues: u1948 (ref), InputIconsConfig (val), u3240 (val)
    local v1 = Utility:Create("Frame")({
        Name = "HintFrame",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, -5),
        Position = UDim2.new(0, 0, 0, 0),
        Parent = u1948,
    })
    local u46 = Utility:Create("ImageLabel")({
        Name = "HintImage",
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.fromOffset(48, 48),
        Image = InputIconsConfig.Image(a1) or "",
        ScaleType = Enum.ScaleType.Fit,
        Parent = v1,
    })
    InputIconsConfig.Changed:Connect(function() -- Line: 5098 -- upvalues: u46 (val), InputIconsConfig (upval), a1 (val)
        u46.Image = InputIconsConfig.Image(a1) or ""
    end)
    local v2 = Utility:Create("TextLabel")({
        Name = "HintText",
        BackgroundTransparency = 1,
        TextWrapped = false,
        Position = UDim2.fromOffset(56, 0),
        Size = UDim2.new(1, -56, 1, 0),
        Font = Enum.Font.SourceSansBold,
        TextSize = if not u3240 then 22 else 26,
        Text = a2,
        TextColor3 = Color3.new(1, 1, 1),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = v1,
    })
    local v3 = Instance.new("UITextSizeConstraint", v2)
    v3.MaxTextSize = v2.TextSize
end

function PositionHintFrame() -- Line: 5116 -- upvalues: u3240 (val), u1948 (ref)
    local TextSize, new, v1, v2
    local v3 = if not u3240 then 32 else 36
    local v4 = if not u3240 then 22 else 26
    local TextService = game:GetService("TextService")
    local v5 = 0
    local Children = u1948:GetChildren()
    local v6 = {}
    for i, j in Children do
        TextSize = TextService:GetTextSize(j.HintText.Text, v4, j.HintText.Font, (Vector2.new(10000, v3)))
        v1 = v3 + 8
        v6[i] = v1 + math.ceil(TextSize.X) + 4
        v5 = v5 + v6[i]
    end
    local v7 = u1948.AbsoluteSize.Y / v3
    local v8 = u1948.AbsoluteSize.X / math.max(v7, 0.001)
    v7 = math.max(1, #Children - 1)
    local v9 = math.min(1, v8 / (v5 + v7 * 20))
    local v10 = (v8 - v5 * v9) / v7
    v8 = 0
    for k, n in Children do
        n.Position = UDim2.fromOffset(v8, 0)
        new = UDim2.new
        v2 = v6[k] * v9
        n.Size = new(0, v2, 1, 0)
        n.HintImage.Size = UDim2.fromOffset(v3 * v9, v3 * v9)
        n.HintText.Position = UDim2.fromOffset((v3 + 8) * v9, 0)
        n.HintText.Size = UDim2.new(1, -(v3 + 8) * v9, 1, 0)
        n.HintText.TextSize = v4 * v9
        v8 = v8 + (v6[k] * v9 + v10)
    end
end

createHint(Enum.KeyCode.ButtonX, "Remove From Hotbar")
createHint(Enum.KeyCode.ButtonA, "Select/Swap")
createHint(Enum.KeyCode.ButtonB, "Close Backpack")
;(u1948:GetPropertyChangedSignal("AbsoluteSize")):Connect(PositionHintFrame)
PositionHintFrame()
local u1984 = u462:WaitForChild("Search")
u9 = u1984:WaitForChild("TextBox")
u9.ClearTextOnFocus = false
u9.TextXAlignment = Enum.TextXAlignment.Left
CloseButton = u462:FindFirstChild("Close")
if CloseButton and CloseButton:IsA("GuiButton") then
    ButtonFX(CloseButton, nil, function() -- Line: 5164 -- upvalues: u462 (ref), u3116 (val)
        if u462.Visible then
            u3116.OpenClose()
        end
    end)
end
local u2029 = u1984:FindFirstChild("StrokeTemplate")
if not u2029 then
    u2029 = u1984:FindFirstChildWhichIsA("UIStroke")
    if not u2029 then
        u2029 = script.StrokeTemplate:Clone()
    end
end
u2029.Enabled = false
u2029.Parent = u1984
RunService.Heartbeat:Connect(function(a1) -- Line: 5176 -- upvalues: u2029 (val) -- types: a1: number
    if not u2029.Enabled then
        return
    end
    local UIGradient = u2029.UIGradient
    UIGradient.Rotation = (UIGradient.Rotation + a1 * 20) % 360
end)
local u2060 = u1984:FindFirstChild("X")
if not u2060 then
    u2060 = u1984:FindFirstChild("ClearSearch")
    if not u2060 then
        u2060 = u1984:WaitForChild("X")
    end
end
u2060.Visible = false

function PerformSearch() -- Line: 5187
    -- upvalues: u9 (ref), u3504 (val), u3376 (val), u462 (ref), u3477 (ref), u470 (ref), u2060 (val)
    local v1
    if u9.Text == "" then
        ResetSearchResults()
        return
    end
    local v2 = {}
    for i in u9.Text:gmatch("%S+") do
        v2[(i:lower())] = true
    end
    local v3 = {}
    local v4 = u3504 + 1
    local v5 = #u3376
    for j = v4, v5 do
        local u29 = u3376[j]
        if u29 and u29.Tool then
            if IsOfCategory(u29.Tool) then
                table.insert(v3, {u29, u29:CheckTerms(v2)})
                u29.Frame.Visible = false
                pcall(function() -- Line: 5210 -- upvalues: u29 (val), u462 (upval)
                    u29.Frame.Parent = u462
                end)
            else
                u29.Frame.Visible = false
            end
        end
    end
    table.sort(v3, function(a1, a2) -- Line: 5213
        local v1 = a1[2]
        return a2[2] < v1
    end)
    u3477 = true
    v2 = 0
    for i2, v in ipairs(v3) do
        v1 = v[1]
        if not (0 < v[2]) then
            v1.Frame.Visible = false
        else
            v1.Frame.Visible = true
            v1.Frame.Parent = u470
            v1.Frame.LayoutOrder = u3504 + v2
            v2 = v2 + 1
        end
    end
    UpdateScrollingFrameCanvasSize()
    u2060.ZIndex = 2000
end

u10 = PerformSearch

function ResetSearchResults() -- Line: 5232 -- upvalues: u3477 (ref), u3504 (val), u3376 (val), u470 (ref), u2060 (val)
    local Tool, v1
    u3477 = false
    local v2 = u3504 + 1
    local v3 = #u3376
    for i = v2, v3 do
        v1 = u3376[i]
        if v1 and v1.Tool then
            Tool = v1.Tool
            if not IsOfCategory(Tool) then
                v1.Frame.Visible = false
            else
                v1.Frame.Parent = u470
                v1.Frame.Visible = true
            end
        end
    end
    u2060.ZIndex = 0
    UpdateInventorySlots()
end

u11 = ResetSearchResults

function ClearSearchText() -- Line: 5250 -- upvalues: u9 (ref)
    ResetSearchResults()
    u9.Text = ""
end

function OnSearchTextChanged(a1) -- Line: 5254 -- upvalues: u9 (ref), u2060 (val), u2029 (val)
    if a1 == "Text" then
        local v1
        PerformSearch()
        u2060.Visible = u9.Text ~= ""
        u2029.Enabled = v1
    end
end

function OnSearchFocusLost(a1) -- Line: 5262
    if a1 then
        PerformSearch()
    end
end

u2060.MouseButton1Click:Connect(ClearSearchText)
u9.Changed:Connect(OnSearchTextChanged)
u9.FocusLost:Connect(OnSearchFocusLost)
u3116.StateChanged.Event:Connect(function(a1) -- Line: 5270 -- upvalues: u462 (ref), u3362 (val)
    if not a1 and not u462.Visible then
        u3362:deselect()
    end
end)

function OnEscapePressed(a1) -- Line: 5275 -- upvalues: u462 (ref), u3362 (val)
    if a1 or ActiveFuseSelectionState then
        return
    end
    if u462.Visible then
        u3362:deselect()
    end
end

u3404[Enum.KeyCode.Escape.Value] = OnEscapePressed

function v6() -- Line: 5296 -- upvalues: u1984 (val), u3376 (val)
    local VREnabled = UserInputService.VREnabled or UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad
    u1984.Visible = VREnabled
    for i, j in u3376 do
        if not j.IsDeleted then
            j:RefreshDragDetector()
        end
    end
end

;(UserInputService:GetPropertyChangedSignal("PreferredInput")):Connect(v6)
;(UserInputService:GetPropertyChangedSignal("VREnabled")):Connect(v6)
MenuNavigation.CursorChanged:Connect(function() -- Line: 5289 -- upvalues: u3376 (val)
    for i, j in u3376 do
        if not j.IsDeleted then
            j:RefreshDragDetector()
        end
    end
end)
;(u462:GetPropertyChangedSignal("Visible")):Connect(function() -- Line: 5285 -- upvalues: u1984 (val)
    local VREnabled = UserInputService.VREnabled or UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad
    u1984.Visible = VREnabled
end)
v6()
GuiService.MenuOpened:Connect(function() -- Line: 5305 -- upvalues: u462 (ref), u3362 (val)
    if u462.Visible then
        u3362:deselect()
    end
end)

function RemoveSlotAction(a1, a2, a3) -- Line: 5310 -- upvalues: GuiService (val), u3504 (val), u3376 (val), u11 (ref)
    if a2 ~= Enum.UserInputState.Begin or not GuiService.SelectedObject then
        return
    end
    for i = 1, u3504 do
        if u3376[i].Frame == GuiService.SelectedObject and u3376[i].Tool then
            u3376[i]:MoveToInventory()
            u11()
            return
        end
    end
    u11()
end

function setInventoryVisibility(a1) -- Line: 5328
    -- upvalues: u462 (ref), u461 (ref), u3504 (val), u3376 (val), u3491 (ref), u3162 (val), u1948 (ref)
    -- upvalues: MenuNavigation (val), u459 (ref), u3362 (val), u3116 (val), u3222 (ref), u3130 (ref), u3204 (ref)
    u462.Visible = a1
    AdjustHotbarFrames()
    u461.Active = not a1
    for i = 1, u3504 do
        u3376[i]:SetClickability(not a1)
    end
    if not u462.Visible then
        if u3491 then
            u1948.Visible = false
        end
        disableGamepadInventoryControl()
    elseif u3491 then
        if u3162[UserInputService:GetLastInputType()] then
            PositionHintFrame()
            u1948.Visible = not UserInputService.VREnabled
        end
        enableGamepadInventoryControl()
    end
    if not u462.Visible then
        ContextActionService:UnbindAction("RBXRemoveSlot")
    else
        ContextActionService:BindActionAtPriority(
            "RBXRemoveSlot",
            RemoveSlotAction,
            false,
            Enum.ContextActionPriority.High.Value + 100,
            Enum.KeyCode.ButtonX
        )
    end
    local SetOverride = MenuNavigation.SetOverride
    local v1 = u461:FindFirstChild("1")
    SetOverride("Backpack", if not a1 then nil else u459, v1, function() -- Line: 5364 -- upvalues: u3362 (upval)
        u3362:deselect()
    end, 100)
    u3116.IsOpen = u462.Visible
    u3116.StateChanged:Fire(u462.Visible)
    if not u462.Visible then
        local v2 = false
        if ActiveFuseSelectionState and u3222 then
            u3222(false)
            v2 = true
        end
        if not v2 then
            u3130 = nil
            if u3204 then
                setFavoriteModeActive(false)
            end
        end
    end
end

function u3116.OpenClose() -- Line: 5384 -- upvalues: u3432 (ref), u462 (ref), u3116 (val), u3418 (val)
    if u3432 and not u462.Visible then
        return
    end
    if not ActiveFuseSelectionState then
        if next(u3418) then
            return
        end
        setInventoryVisibility(not u462.Visible)
        return
    end
    if u462.Visible then
        setInventoryVisibility(false)
        return
    end
    u3116.IsOpen = u462.Visible
end

function setFuseSelectionSlotClickability(a1) -- Line: 5404 -- upvalues: u3376 (val)
    for i, j in u3376 do
        if j and j.Tool then
            j:SetClickability(not a1)
        end
    end
end

function captureFuseHotbarSnapshot() -- Line: 5412 -- upvalues: u3504 (val), u3376 (val)
    local Tool, v1
    local v2 = {}
    for i = 1, u3504 do
        v1 = u3376[i]
        Tool = v1 and v1.Tool
        if v1 and not v1.IsFakeSlot and typeof(Tool) == "Instance" and Tool:IsA("Tool") and isAssetTool(Tool) then
            v2[i] = Tool
        end
    end
    return v2
end

function moveFuseHotbarAssetsToInventory() -- Line: 5432 -- upvalues: u3504 (val), u3376 (val)
    local v1
    for i = 1, u3504 do
        v1 = u3376[i]
        if v1 and not v1.IsFakeSlot and v1.Tool and isAssetTool(v1.Tool) then
            v1:MoveToInventory()
        end
    end
end

function restoreFuseHotbarSnapshot(a1) -- Line: 5441
    -- upvalues: u3504 (val), u3376 (val), u3390 (val)
    local v1, v2, v3
    local v4 = {}
    for i, j in a1 do
        if typeof(j) == "Instance" and j:IsA("Tool") and j.Parent then
            v4[j] = i
        end
    end
    for k = 1, u3504 do
        v2 = u3376[k]
        if v2 and not v2.IsFakeSlot and v2.Tool and isAssetTool(v2.Tool) and not v4[v2.Tool] then
            v2:MoveToInventory()
        end
    end
    local v5 = nil
    local v6 = nil
    for n, m in v1, v5, v6 do
        if typeof(m) == "Instance" and m:IsA("Tool") and m.Parent then
            v4 = u3376[n]
            v3 = u3390[m]
            if v4 and not v4.IsFakeSlot and v3 and not v3.IsFakeSlot and v3.Tool == m and v4 ~= v3 then
                if v4.Tool then
                    v4:MoveToInventory()
                end
                v3:Swap(v4)
            end
        end
    end
end

function stopFuseSelectionVisuals() -- Line: 5490
    if FuseSelectionVisualTrove then
        FuseSelectionVisualTrove:Clean()
        FuseSelectionVisualTrove = nil
    end
    refreshInventoryFrameVisuals()
end

function startFuseSelectionVisuals() -- Line: 5499 -- upvalues: Trove (val), RunService (val)
    stopFuseSelectionVisuals()
    if not InventoryStroke then
        refreshInventoryFrameVisuals()
        return
    end
    FuseSelectionVisualTrove = Trove.new()
    local u8 = 0
    FuseSelectionVisualTrove:Add((RunService.Heartbeat:Connect(function(a1) -- Line: 5509 -- upvalues: u8 (ref)
        if not ActiveFuseSelectionState then
            return
        end
        u8 = u8 + a1 * 3
        local v1 = (math.sin(u8) + 1) / 2
        local v2 = InventoryStroke
        v2.Color = FUSE_SELECTION_STROKE_COLOR:Lerp(Color3.fromRGB(255, 255, 255), v1)
    end)))
    refreshInventoryFrameVisuals()
end

function u3116:StartMachineSelection(a2, a3, a4, a5, a6) -- Line: 5521
    -- upvalues: u3102 (ref), u3204 (ref), u9 (ref), u11 (ref), u414 (ref), AutoSell (ref), u603 (ref), u3477 (ref)
    -- upvalues: u3105 (ref), SetCategory (ref)
    assert(type(a2) == "string", "Expected machine selection item type to be a string")
    assert(type(a3) == "function", "Expected fuse selection callback to be a function")
    assert(type(a6) == "string", "Expected preferred category to be a string")
    if ActiveFuseSelectionState then
        self:EndFuseSelection()
    end
    ActiveFuseSelectionState = {
        AllowedCategories = a5,
        ItemType = a2,
        PreviousCategory = u3102,
        PreviousFavoriteModeActive = u3204,
        PreferredCategory = a6,
        HotbarSnapshot = captureFuseHotbarSnapshot(),
    }
    self:RequestSelection(a2, a3, false, false, a4)
    if u3204 then
        setFavoriteModeActive(false)
    end
    if u9 and u9.Text ~= "" then
        if u11 then
            u11()
        end
        u9.Text = ""
    end
    if u414 then
        u414.Visible = false
        if AutoSell then
            AutoSell.Visible = false
        end
        if u603 then
            u603.Visible = false
        end
    end
    if u3477 and u11 then
        u11()
    end
    if u9 and u9.Text ~= "" then
        u9.Text = ""
    end
    u3105()
    updateEquipBestButtonVisibility()
    SetCategory(a6)
    if a2 == "Asset" then
        moveFuseHotbarAssetsToInventory()
    end
    AdjustHotbarFrames()
    setInventoryVisibility(true)
    setFuseSelectionSlotClickability(false)
    UpdateInventorySlots()
    startFuseSelectionVisuals()
    OnIconChanged(BackpackEnabled)
    return true
end

function u3222(a1) -- Line: 5591
    -- upvalues: u3130 (ref), u414 (ref), AutoSell (ref), u603 (ref), u3105 (ref), SetCategory (ref)
    local v1 = ActiveFuseSelectionState
    if not v1 then
        return
    end
    ActiveFuseSelectionState = nil
    stopFuseSelectionVisuals()
    u3130 = nil
    if a1 then
        setInventoryVisibility(false)
    end
    setFuseSelectionSlotClickability(true)
    if CloseButton then
        CloseButton.Active = true
        CloseButton.Visible = true
    end
    if u414 then
        u414.Visible = false
        if AutoSell then
            AutoSell.Visible = false
        end
        if u603 then
            u603.Visible = false
        end
    end
    u3105()
    if v1.ItemType == "Asset" then
        restoreFuseHotbarSnapshot(v1.HotbarSnapshot)
    end
    SetCategory(v1.PreviousCategory)
    refreshFavoriteModeVisibility()
    if not v1.PreviousFavoriteModeActive then
        refreshInventoryFrameVisuals()
    else
        setFavoriteModeActive(true)
    end
    UpdateInventorySlots()
    OnIconChanged(BackpackEnabled)
    updateEquipBestButtonVisibility()
end

function u3116.EndFuseSelection(a1) -- Line: 5635 -- upvalues: u3222 (ref)
    u3222(true)
end

function u3116.StartFuseSelection(a1, a2, a3) -- Line: 5637 -- types: a1: table, a2: function, a3: function?
    return a1:StartMachineSelection("Asset", a2, a3, {[FUSE_SELECTION_ASSET_CATEGORY_NAME] = true}, FUSE_SELECTION_ASSET_CATEGORY_NAME)
end

function u3116.IsFuseSelectionActive(a1) -- Line: 5646
    return ActiveFuseSelectionState ~= nil
end

tryCore("SetCoreGuiEnabled", Enum.CoreGuiType.Backpack, false)
while not LocalPlayer do
    wait()
    LocalPlayer = Players.LocalPlayer
end
LocalPlayer.CharacterAdded:Connect(SetupCharacter)
if LocalPlayer.Character then
    SetupCharacter(LocalPlayer.Character)
end

local function handleLocalActiveAssetRecords(a1) -- Line: 5658
    refreshPlacedAssetUIDs(a1)
    local v1 = clearPlacedAssetBackpackSlots(a1)
    local v2 = syncAssetsFromSave()
    if v1 and not v2 then
        AdjustHotbarFrames()
        UpdateInventorySlots()
    end
    reconcileVirtualAssetEquipState()
end

refreshPlacedAssetUIDs(v11.ReadOwnerPen(LocalPlayer.UserId))
v11.OwnerRefreshed:Connect(function(a1, a2) -- Line: 5671 -- upvalues: LocalPlayer (ref), handleLocalActiveAssetRecords (val)
    if a1 == LocalPlayer.UserId then
        handleLocalActiveAssetRecords(a2)
    end
end)
v11.OwnerCleared:Connect(function(a1) -- Line: 5677 -- upvalues: LocalPlayer (ref), handleLocalActiveAssetRecords (val)
    if a1 == LocalPlayer.UserId then
        handleLocalActiveAssetRecords({})
    end
end)
task.spawn(function() -- Line: 5683 -- upvalues: u3068 (ref), u3518 (ref), u3588 (ref), u3532 (ref), u3602 (ref)
    u3068.Await()
    syncAssetsFromSave()
    syncEggsFromSave()
    reconcileVirtualAssetEquipState()
    reconcileVirtualEggEquipState()
    captureEligibleAssetUIDs()
    captureEggUIDs()
    u3532 = true
    u3602 = true
end)
u3068.WatchFields({"Inventory", "AssetFavoriteCategories"}, function() -- Line: 5696 -- upvalues: u3532 (ref), u3518 (ref)
    local v1 = captureEligibleAssetUIDs()
    if u3532 then
        queueNewEligibleAssetsForHotbar(u3518, v1)
    end
    u3518 = v1
    u3532 = true
    syncAssetsFromSave()
    reconcileVirtualAssetEquipState()
    movePendingHotbarAssets()
end)
u3068.WatchFields({"EquippedAssets", "BaseUpgradeLevel", "Gamepasses", "Products"}, function() -- Line: 5708
    syncAssetsFromSave()
    reconcileVirtualAssetEquipState()
end)
u3068.WatchFields("EggInventory", function() -- Line: 5713 -- upvalues: u3602 (ref), u3588 (ref)
    local v1 = captureEggUIDs()
    if u3602 then
        queueNewEggsForHotbar(u3588, v1)
    end
    u3588 = v1
    u3602 = true
    syncEggsFromSave()
    reconcileVirtualEggEquipState()
    movePendingHotbarEggs()
end)
EggState.SnapshotRefreshed:Connect(function() -- Line: 5725
    syncEggsFromSave()
    reconcileVirtualEggEquipState()
end)
PlotState.LocalPlotChanged:Connect(function() -- Line: 5730
    invalidateEquipBestStatus(true)
end)
PlotState.FolderChanged:Connect(function() -- Line: 5731
    invalidateEquipBestStatus(true)
end)
UserInputService.InputBegan:Connect(HandleInputBegan)
UserInputService.TextBoxFocused:Connect(function() -- Line: 5734 -- upvalues: u3463 (ref)
    u3463 = true
end)
UserInputService.TextBoxFocusReleased:Connect(function() -- Line: 5735 -- upvalues: u3463 (ref)
    u3463 = false
end)

u3404[Value_2] = function() -- Line: 5736 -- upvalues: Humanoid (ref)
    if Humanoid then
        UnequipAllTools()
    end
end

UserInputService.Changed:Connect(OnInputServiceChanged)
OnInputServiceChanged("KeyboardEnabled")
if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
    gamepadConnected()
end
UserInputService.GamepadConnected:Connect(function(a1) -- Line: 5746
    if a1 == Enum.UserInputType.Gamepad1 then
        gamepadConnected()
    end
end)
UserInputService.GamepadDisconnected:Connect(function(a1) -- Line: 5751
    if a1 == Enum.UserInputType.Gamepad1 then
        gamepadDisconnected()
    end
end)

function u3116.RequestSelection(a1, a2, a3, a4, a5, a6) -- Line: 5756
    -- upvalues: u3130 (ref)
    u3130 = {
        ItemType = a2,
        Callback = a3,
        AllowHotbar = a4 == true,
        Preserve = a5 == true,
        Validator = a6,
    }
end

function u3116.ClearSelectionRequest(a1) -- Line: 5771 -- upvalues: u3130 (ref)
    u3130 = nil
end

function u3116.SetCategory(a1, a2) -- Line: 5772 -- upvalues: SetCategory (ref) -- types: a1: table, a2: string
    SetCategory(a2)
end

function u3116.OpenInventory(a1) -- Line: 5773 -- upvalues: u3116 (val)
    if not u3116.IsOpen then
        u3116.OpenClose()
    end
end

function u3116.SetBackpackEnabled(a1, a2) -- Line: 5778
    BackpackEnabled = a2
end

function u3116.SetTreadmillPhoneOnlyMode(a1, a2) -- Line: 5779
    -- upvalues: u3432 (ref), u462 (ref), u3362 (val)
    if u3432 == a2 then
        return
    end
    u3432 = a2
    if a2 and u462.Visible then
        u3362:deselect()
    end
    AdjustHotbarFrames()
end

function u3116.IsOpened(a1) -- Line: 5789 -- upvalues: u3116 (val)
    return u3116.IsOpen
end

function u3116.GetBackpackEnabled(a1) -- Line: 5790
    return BackpackEnabled
end

function u3116.GetCategory(a1) -- Line: 5791 -- upvalues: u3102 (ref)
    return u3102
end

function u3116.RefreshInventory(a1) -- Line: 5792 -- upvalues: u10 (ref)
    if u10 then
        u10()
        return
    end
    UpdateInventorySlots()
end

function u3116.GetStateChangedEvent(a1) -- Line: 5800 -- upvalues: u3116 (val)
    return u3116.StateChanged.Event
end

function u3116.ForceEggIntoTutorialHotbar(a1, a2) -- Line: 5802
    -- upvalues: u3546 (val), u3574 (val), u3560 (val), u3376 (val), u10 (ref)
    local v1 = u3546[a2] or findVirtualEggSlotByUID(a2)
    if v1 and not v1.IsDeleted then
        u3560[a2] = nil
        u3574[a2] = nil
        local v2 = u3376[5]
        assert(v2 and not v2.IsFakeSlot, (("Tutorial egg hotbar slot %* must be available"):format(5)))
        assert(canToolUseHotbarSlot(v1.Tool, 5), (("Tutorial egg must be insertable in slot %*"):format(5)))
        if v2.Tool and v2 ~= v1 then
            v2:MoveToInventory()
        end
        if v1 ~= v2 then
            v1:Swap(v2)
        end
        u3546[a2] = v2
        AdjustHotbarFrames()
        UpdateInventorySlots()
        if u10 then
            u10(true)
        end
        if reconcileVirtualEggEquipState() ~= a2 then
            v2:Select()
        end
        return v2.Frame
    end
    u3574[a2] = true
    return nil
end

function u3116.GetPhoneSlotFrame(a1) -- Line: 5844 -- upvalues: u3504 (val), u3376 (val)
    local v1
    for i = 1, u3504 do
        v1 = u3376[i]
        if v1 and not v1.IsFakeSlot and v1.Tool and isPhoneTool(v1.Tool) then
            return v1.Frame
        end
    end
    return nil
end

function u3116.GetEggSlotFrame(a1, a2) -- Line: 5855 -- upvalues: u3546 (val) -- types: a1: table, a2: string
    local v1 = u3546[a2] or findVirtualEggSlotByUID(a2)
    if v1 ~= nil and not v1.IsDeleted then
        return v1.Frame
    end
    return nil
end

RunService.Heartbeat:Connect(function() -- Line: 5866 -- upvalues: ToolGameplayGuard (val), u3449 (ref), u3660 (ref), u3646 (ref), u3632 (ref)
    OnIconChanged(BackpackEnabled)
    local v1 = ToolGameplayGuard.IsLocalInsideArena()
    if v1 and not u3449 then
        ensureGameplayGearHotbarSlots()
    end
    u3449 = v1
    v1 = isLocalPlayerWithinOwnPlotBounds()
    if u3660 ~= v1 then
        u3660 = v1
        if v1 then
            requestEquipBestStatusRefresh(true)
            return
        end
        updateEquipBestButtonVisibility()
        return
    end
    if not u3660 then
        updateEquipBestButtonVisibility()
        return
    end
    if not u3646 and u3632 then
        updateEquipBestButtonVisibility()
        return
    end
    requestEquipBestStatusRefresh()
end)
ApiEvent.Event:Connect(function(a1, a2) -- Line: 5891 -- upvalues: u3116 (val)
    if a1 == "SetBackpackEnabled" then
        u3116:SetBackpackEnabled(a2)
        return
    end
    if a1 ~= "SetInventoryOpen" then
        if a1 == "ToggleBackpack" then
            u3116.OpenClose()
        end
        return
    end
    if type(a2) == "boolean" and a2 == true then
        u3116.IsOpen = true
        return
    end
    if type(a2) ~= "boolean" then
        return
    end
    u3116.IsOpen = false
end)
require(script.Navigation)(u459, u462, u470, u461, v18)
require(script.Capacity)(u462, u459)
require(script.MutationHint)(u461, u462)

function u3116.GetMutationRewardTarget(a1, a2) -- Line: 5914
    -- upvalues: u3376 (val), u3504 (val), u461 (ref)
    local Tool
    for i, j in u3376 do
        Tool = j.Tool
        if j.Index <= u3504
            and typeof(Tool) == "Instance"
            and Tool:IsA("Tool")
            and Tool:GetAttribute("MutationId") == a2
            and j.Frame
            and j.Frame.Visible
            and not j.IsDeleted then
            return j.Frame
        end
    end
    return u461
end

return u3116