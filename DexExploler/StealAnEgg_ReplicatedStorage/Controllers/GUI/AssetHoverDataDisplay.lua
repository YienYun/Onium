-- Script path: ReplicatedStorage.Controllers.GUI.AssetHoverDataDisplay
-- Decompile time: 7.89 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local t = require(ReplicatedStorage.Packages.t)
local AssetGender = require(ReplicatedStorage.Shared.Util.AssetGender)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local AssetRuntime = require(ReplicatedStorage.Shared.Types.AssetRuntime)
local GUI = require(ReplicatedStorage.Client.GUI)
local HoverHighlight = require(ReplicatedStorage.Client.WorldFX.HoverHighlight)
local ModelHover = require(ReplicatedStorage.Client.UI.ModelHover)
local u58 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u59 = {}
local u60 = {}
local u61 = nil
local u62 = nil
local u63 = nil
local u64 = 0
local v1 = {}

local function getKey(a1) -- Line: 54
    return (("%*:%*"):format(a1.OwnerUserId, a1.UID))
end

local function bindGui() -- Line: 58 -- upvalues: u61 (ref), GUI (val)
    local v1 = u61
    if v1 ~= nil then
        return v1
    end
    v1 = GUI.AssetHoverData()
    assert(v1:IsA("ScreenGui"), "PlayerGui.AssetHoverData must be a ScreenGui")
    local Frame = v1.Frame
    assert(Frame:IsA("GuiObject"), "AssetHoverData.Frame must be a GuiObject")
    local CanvasGroup = Frame.CanvasGroup
    assert(CanvasGroup:IsA("CanvasGroup"), "AssetHoverData.Frame.CanvasGroup must be a CanvasGroup")
    local Weight = CanvasGroup.Weight
    assert(Weight:IsA("TextLabel"), "AssetHoverData.Frame.CanvasGroup.Weight must be a TextLabel")
    local Gender = CanvasGroup.Gender
    assert(Gender:IsA("ImageLabel"), "AssetHoverData.Frame.CanvasGroup.Gender must be an ImageLabel")
    local v2 = {
        Root = v1,
        Frame = Frame,
        CanvasGroup = CanvasGroup,
        Weight = Weight,
        Gender = Gender,
    }
    u61 = v2
    v1.Enabled = false
    Frame.Visible = false
    CanvasGroup.GroupTransparency = 1
    return v2
end

local function clearActiveHighlight() -- Line: 89 -- upvalues: u63 (ref), HoverHighlight (val)
    local v1 = u63
    u63 = nil
    if v1 ~= nil then
        HoverHighlight.FadeOut(v1, 0.2)
    end
end

local function updateFramePosition(a1, a2) -- Line: 97 -- types: a1: table, a2: userdata
    a1.Frame.Position = UDim2.fromOffset(a2.X, a2.Y)
end

local function updateStaticContent(a1, a2) -- Line: 101
    -- upvalues: AssetItems (val), AssetGender (val)
    a1.Weight.Text = AssetItems.WeightLabel(a2.Record.ItemData)
    a1.Gender.Image = AssetGender.BadgeImage(AssetGender.Settle(a2.Record.ItemData.Category, a2.Record.ItemData.Gender))
end

local function setActiveEntry(a1, a2) -- Line: 108
    -- upvalues: u62 (ref), bindGui (val), u64 (ref), u63 (ref), HoverHighlight (val), TweenService (val), u58 (val)
    -- upvalues: AssetItems (val), AssetGender (val)
    if a1 == nil then
        if u62 == nil then
            return
        end
        local u4 = bindGui()
        u4.Frame.Position = UDim2.fromOffset(a2.X, a2.Y)
        u62 = nil
        u64 = u64 + 1
        local u13 = u64
        local v1 = u63
        u63 = nil
        if v1 ~= nil then
            HoverHighlight.FadeOut(v1, 0.2)
        end
        v1 = TweenService:Create(u4.CanvasGroup, u58, {GroupTransparency = 1})
        v1.Completed:Once(function(a1) -- Line: 121 -- upvalues: u62 (upval), u64 (upval), u13 (val), u4 (val)
            if a1 == Enum.PlaybackState.Completed and u62 == nil and u64 == u13 then
                u4.Frame.Visible = false
                u4.Root.Enabled = false
            end
        end)
        v1:Play()
        return
    end
    local v2 = bindGui()
    v2.Frame.Position = UDim2.fromOffset(a2.X, a2.Y)
    u64 = u64 + 1
    v2.Root.Enabled = true
    v2.Frame.Visible = true
    if u62 ~= a1.Key then
        u62 = a1.Key
        local v3 = u63
        u63 = nil
        if v3 ~= nil then
            HoverHighlight.FadeOut(v3, 0.2)
        end
        HoverHighlight.FadeIn(a1.Model, "AssetHoverHighlight", 0.2)
        v2.Weight.Text = AssetItems.WeightLabel(a1.Record.ItemData)
        v2.Gender.Image = AssetGender.BadgeImage(AssetGender.Settle(a1.Record.ItemData.Category, a1.Record.ItemData.Gender))
        v2.CanvasGroup.GroupTransparency = 1
        TweenService:Create(v2.CanvasGroup, u58, {GroupTransparency = 0}):Play()
    end
end

function v1.SetEntry(a1) -- Line: 158 -- upvalues: AssetRuntime (val), t (val), u59 (val), u60 (val) -- types: a1: table
    assert(AssetRuntime.SchemaValidation.RuntimeAssetRecord(a1.Record), "Invalid runtime asset record")
    t.strict(t.instanceIsA("Model"))(a1.Model)
    local Record = a1.Record
    local v1 = ("%*:%*"):format(Record.OwnerUserId, Record.UID)
    u59[v1] = {Key = v1, Record = a1.Record, Model = a1.Model}
    u60[v1] = a1.Model
end

function v1.RemoveEntry(a1, a2) -- Line: 174
    -- upvalues: t (val), u59 (val), u60 (val), u62 (ref), UserInputService (val), bindGui (val), u64 (ref), u63 (ref)
    -- upvalues: HoverHighlight (val), TweenService (val), u58 (val)
    t.strict(t.number)(a1)
    t.strict(t.string)(a2)
    local v1 = ("%*:%*"):format(a1, a2)
    u59[v1] = nil
    u60[v1] = nil
    if u62 == v1 then
        local MouseLocation = UserInputService:GetMouseLocation()
        if u62 == nil then
            return
        end
        local u33 = bindGui()
        u33.Frame.Position = UDim2.fromOffset(MouseLocation.X, MouseLocation.Y)
        u62 = nil
        u64 = u64 + 1
        local u42 = u64
        local v2 = u63
        u63 = nil
        if v2 ~= nil then
            HoverHighlight.FadeOut(v2, 0.2)
        end
        v2 = TweenService:Create(u33.CanvasGroup, u58, {GroupTransparency = 1})
        v2.Completed:Once(function(a1) -- Line: 121 -- upvalues: u62 (upval), u64 (upval), u42 (val), u33 (val)
            if a1 == Enum.PlaybackState.Completed and u62 == nil and u64 == u42 then
                u33.Frame.Visible = false
                u33.Root.Enabled = false
            end
        end)
        v2:Play()
    end
end

function v1.DestroyOwner(a1) -- Line: 186
    -- upvalues: t (val), u59 (val), u60 (val), u62 (ref), UserInputService (val), bindGui (val), u64 (ref), u63 (ref)
    -- upvalues: HoverHighlight (val), TweenService (val), u58 (val)
    local MouseLocation, v1
    t.strict(t.number)(a1)
    for k, v in pairs(u59) do
        if v.Record.OwnerUserId == a1 then
            u59[k] = nil
            u60[k] = nil
            if u62 == k then
                MouseLocation = UserInputService:GetMouseLocation()
                if u62 ~= nil then
                    local u34 = bindGui()
                    u34.Frame.Position = UDim2.fromOffset(MouseLocation.X, MouseLocation.Y)
                    u62 = nil
                    u64 = u64 + 1
                    local u43 = u64
                    v1 = u63
                    u63 = nil
                    if v1 ~= nil then
                        HoverHighlight.FadeOut(v1, 0.2)
                    end
                    v1 = TweenService:Create(u34.CanvasGroup, u58, {GroupTransparency = 1})
                    v1.Completed:Once(function(a1) -- Line: 121 -- upvalues: u62 (upval), u64 (upval), u43 (val), u34 (val)
                        if a1 == Enum.PlaybackState.Completed and u62 == nil and u64 == u43 then
                            u34.Frame.Visible = false
                            u34.Root.Enabled = false
                        end
                    end)
                    v1:Play()
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(function() -- Line: 151
    -- upvalues: UserInputService (val), ModelHover (val), u60 (val), u59 (val), setActiveEntry (val)
    local MouseLocation = UserInputService:GetMouseLocation()
    local v1 = ModelHover.KeyUnderCursor(u60, MouseLocation, 200)
    setActiveEntry(if v1 == nil then nil else u59[v1], MouseLocation)
end)
return (table.freeze(v1))