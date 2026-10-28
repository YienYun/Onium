-- Script path: ReplicatedStorage.Controllers.GUI.FuseMachineController.FuseMachineBackpackSelection
-- Decompile time: 8.78 ms

game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local AssetIconShape = require(ReplicatedStorage.Client.UI.AssetIconShape)
require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local GridCellFitter = require(ReplicatedStorage.Client.GridCellFitter)
local Directory = require(ReplicatedStorage.Data.Assets).Directory
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local FuseKernel = require(ReplicatedStorage.Shared.Util.FuseKernel)
require(ReplicatedStorage.Shared.Types.FuseMachine)
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local Log = require(ReplicatedStorage.Packages.Log)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
require(ReplicatedStorage.Shared.Save)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u78 = Log.new()
local u79 = {}
u79.__index = u79
u79.__class = "FuseMachineBackpackSelection"
local u84 = UDim2.fromScale(0.02, 0.04)
local v1 = ReplicatedStorage:WaitForChild("Controllers"):WaitForChild("GUI")
assert(v1:IsA("Folder"), "Controllers.GUI must be a Folder")
local Main = v1.BackpackController.Main
assert(Main:IsA("ModuleScript"), "BackpackController.Main must be a ModuleScript")
local InventoryTemplate = Main.InventoryTemplate
assert(InventoryTemplate:IsA("GuiButton"), "BackpackController.Main.InventoryTemplate must be a GuiButton")

function u79.new(a1) -- Line: 66
    -- upvalues: u79 (val), Trove (val), GridCellFitter (val), u84 (val)
    local u4 = setmetatable({}, u79)
    u4._active = false
    u4._rows = Trove.new()
    u4._scrollingFrame = a1
    u4._trove = Trove.new()
    u4._columns = 5
    local UIGridLayout = a1:FindFirstChildOfClass("UIGridLayout")
    assert(UIGridLayout, "Fuse picker needs a grid layout")
    u4._refitGrid = GridCellFitter.Fit(UIGridLayout, u4._columns, u84)
    a1.AutomaticCanvasSize = Enum.AutomaticSize.Y
    a1.ScrollingDirection = Enum.ScrollingDirection.Y
    for i, j in a1:GetChildren() do
        if j:IsA("GuiObject") then
            j:Destroy()
        end
    end
    u4._trove:Add(u4._rows)
    u4._trove:Connect(UIGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function() -- Line: 90 -- upvalues: u4 (val)
        if u4._active then
            u4._refitGrid()
        end
    end)
    return u4
end

local function getConfig(a1) -- Line: 103 -- upvalues: Directory (val)
    local v1 = Directory[a1.Category]
    local v2 = ("Missing asset config %*"):format(a1.Category)
    assert(v1 ~= nil, v2)
    return v1
end

local function getOddsDenominator(a1) -- Line: 109 -- upvalues: Directory (val), Mutations (val)
    local v1 = Directory[a1.Category]
    local v2 = ("Missing asset config %*"):format(a1.Category)
    assert(v1 ~= nil, v2)
    return 1 / v1.DropWeight * Mutations.RarityFactorFor(a1.Mutations, a1.BaseMutation)
end

local function clearDirectGradients(a1) -- Line: 120 -- types: a1: userdata
    for i, v in ipairs(a1:GetChildren()) do
        if v:IsA("UIGradient") then
            v:Destroy()
        end
    end
end

local function sortLikeBackpack(a1, a2, a3, a4) -- Line: 128
    -- upvalues: Directory (val), AssetEarnings (val), Mutations (val), AssetItems (val)
    local v1 = Directory[a1.Category]
    local v2 = ("Missing asset config %*"):format(a1.Category)
    assert(v1 ~= nil, v2)
    local v3 = Directory[a3.Category]
    local v4 = ("Missing asset config %*"):format(a3.Category)
    assert(v3 ~= nil, v4)
    local Rank = v1.Rarity.Rank
    local Rank_2 = v3.Rarity.Rank
    if Rank ~= Rank_2 then
        return Rank_2 < Rank
    end
    v2 = AssetEarnings.MutationOnlyRatePerSecond(a1)
    local v5 = AssetEarnings.MutationOnlyRatePerSecond(a3)
    if v2 ~= v5 then
        return v5 < v2
    end
    v5 = Directory[a1.Category]
    local v6 = ("Missing asset config %*"):format(a1.Category)
    assert(v5 ~= nil, v6)
    v2 = 1 / v5.DropWeight * Mutations.RarityFactorFor(a1.Mutations, a1.BaseMutation)
    local v7 = Directory[a3.Category]
    local v8 = ("Missing asset config %*"):format(a3.Category)
    assert(v7 ~= nil, v8)
    v4 = 1 / v7.DropWeight * Mutations.RarityFactorFor(a3.Mutations, a3.BaseMutation)
    if v2 ~= v4 then
        return v4 < v2
    end
    if v1.DropWeight ~= v3.DropWeight then
        return v1.DropWeight < v3.DropWeight
    end
    v4 = AssetItems.WeightKg(a1)
    v2 = AssetItems.WeightKg(a3)
    if v4 ~= v2 then
        return v2 < v4
    end
    return a2 < a4
end

function u79:_createRow(a2, a3, a4, a5) -- Line: 167
    -- upvalues: InventoryTemplate (val), AssetIconShape (val), Directory (val), clearDirectGradients (val)
    -- upvalues: ItemDisplay (val), AssetItems (val), ButtonFX (val)
    local v1 = InventoryTemplate:Clone()
    v1.Name = ("FuseSelection.%*"):format(a2)
    v1.LayoutOrder = a4
    v1:SetAttribute("IsInventorySlot", true)
    v1.Active = true
    v1.AutoButtonColor = false
    v1.BackgroundColor3 = Color3.new(0, 0, 0)
    v1.BackgroundTransparency = 0.5
    local UIStroke = v1.UIStroke
    assert(UIStroke:IsA("UIStroke"), "Fuse inventory row requires UIStroke")
    UIStroke.Thickness = 0
    v1.Visible = true
    v1.Parent = self._scrollingFrame
    self._rows:Add(v1)
    local BaseTemplate = v1.BaseTemplate
    local Amount = BaseTemplate.Amount
    assert(Amount:IsA("TextLabel"), "Fuse inventory row Amount must be a TextLabel")
    Amount.Text = ""
    Amount.Visible = false
    local Mutations = BaseTemplate.Mutations
    assert(Mutations:IsA("GuiObject"), "Fuse inventory row Mutations must be a GuiObject")
    Mutations.Visible = false
    local Icon = v1.Icon
    assert(Icon:IsA("ImageLabel"), "Fuse inventory row Icon must be an ImageLabel")
    AssetIconShape.Paint(Icon, a3)
    Icon.ImageColor3 = Color3.new(1, 1, 1)
    local v2 = Directory[a3.Category]
    local v3 = ("Missing asset config %*"):format(a3.Category)
    assert(v2 ~= nil, v3)
    local ToolName = v1.ToolName
    assert(ToolName:IsA("TextLabel"), "Fuse inventory row ToolName must be a TextLabel")
    clearDirectGradients(ToolName)
    v2.Rarity.RarityGradient:Clone().Parent = ToolName
    ToolName.Text = ("%* (%*)"):format(ItemDisplay.GetNameFromItemData(a3), (AssetItems.WeightLabel(a3)))
    ToolName.Visible = true
    local Shadow = v1.Shadow
    assert(Shadow:IsA("ImageLabel"), "Fuse inventory row Shadow must be an ImageLabel")
    clearDirectGradients(Shadow)
    v2.Rarity.RarityGradient:Clone().Parent = Shadow
    Shadow.Visible = true
    local FavIcon = v1.FavIcon
    assert(FavIcon:IsA("GuiObject"), "Fuse inventory row FavIcon must be a GuiObject")
    FavIcon.Visible = false
    local Weight = v1.Weight
    assert(Weight:IsA("GuiObject"), "Fuse inventory row Weight must be a GuiObject")
    Weight.Visible = false
    self._rows:Add((v1.Activated:Connect(function() -- Line: 248 -- upvalues: a5 (val), a2 (val)
        a5(a2)
    end)))
    ButtonFX(v1, 1.015)
end

function u79.Open(a1, a2, a3, a4, a5, a6) -- Line: 258
    -- upvalues: FuseKernel (val), AssetItems (val), sortLikeBackpack (val)
    local v1
    if a1._active then
        return 0
    end
    local v2 = {}
    local u104 = {}
    local v3 = {}
    for i, v in ipairs(a2.EquippedAssets) do
        v3[v] = true
    end
    local v4, v5, v6, v7, v8 = a1, a4, a5, a3, a6
    for k, i2 in pairs(a2.Inventory) do
        if not v3[k] then
            if FuseKernel.MayEnterFuse(k, i2, v7, false, v8) then
                table.insert(v2, k)
                u104[k] = (AssetItems.Decode(i2))
            end
        elseif v6 == true and FuseKernel.MayEnterFuse(k, i2, v7, false, v8) then
            table.insert(v2, k)
            u104[k] = (AssetItems.Decode(i2))
        end
    end
    table.sort(v2, function(a1, a2) -- Line: 293 -- upvalues: sortLikeBackpack (upval), u104 (val) -- types: a1: string, a2: string
        return (sortLikeBackpack(
            assert(u104[a1], (("Missing Fuse selection item data for %*"):format(a1))),
            a1,
            assert(u104[a2], (("Missing Fuse selection item data for %*"):format(a2))),
            a2
        ))
    end)
    v4._active = true
    v4._scrollingFrame.CanvasPosition = Vector2.zero
    for i3, j in ipairs(v2) do
        v1 = assert(u104[j], (("Missing Fuse selection item data for %*"):format(j)))
        v4:_createRow(j, v1, i3, v5)
    end
    return #v2
end

function u79:Close() -- Line: 324
    if not self._active then
        return
    end
    self._rows:Clean()
    self._scrollingFrame.CanvasPosition = Vector2.zero
    self._active = false
end

function u79.RefreshGridLayout(a1) -- Line: 336
    assert(a1._active, "FuseMachine backpack selection must be open before refreshing its grid")
    local X = a1._scrollingFrame.AbsoluteSize.X
    local v1 = a1._scrollingFrame.AbsoluteSize.Y < 150
    a1._columns = if not (X < 420) then if not (X < 650) then 5 else 4 else if v1 then if not (X < 650) then 5 else 4 else 3
    local UIGridLayout = a1._scrollingFrame:FindFirstChildOfClass("UIGridLayout")
    assert(UIGridLayout, "Fuse picker needs a grid layout")
    UIGridLayout.FillDirectionMaxCells = a1._columns
    a1._refitGrid(a1._columns)
end

function u79.IsOpen(a1) -- Line: 355
    return a1._active
end

function u79:Destroy() -- Line: 361 -- upvalues: u78 (val)
    self:Close()
    self._trove:Destroy()
    u78:AtTrace():Log("Destroyed FuseMachine backpack selection")
end

return u79