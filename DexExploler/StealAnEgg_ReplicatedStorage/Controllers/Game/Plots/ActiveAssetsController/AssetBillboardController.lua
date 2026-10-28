-- Script path: ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController.AssetBillboardController
-- Decompile time: 10.49 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
require(ReplicatedStorage.Shared.Types.AssetItem)
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u29 = {}
u29.__index = u29

local function isHiddenByDefault(a1, a2) -- Line: 49 -- types: a1: userdata, a2: userdata
    local Parent = a1
    while Parent ~= nil do
        if Parent == a2 then
            break
        end
        if Parent:IsA("GuiObject") and not Parent.Visible then
            return true
        end
        Parent = Parent.Parent
    end
    return false
end

local function addChannel(a1, a2, a3) -- Line: 61 -- types: a1: table, a2: number, a3: function
    if a2 >= 1 then
        return
    end
    table.insert(a1, {Original = a2, Apply = a3})
end

local function addTextLabelChannels(a1, a2) -- Line: 71 -- types: a1: table, a2: userdata
    local TextTransparency = a2.TextTransparency
    if not (TextTransparency >= 1) then
        table.insert(a1, {
            Original = TextTransparency,
            Apply = function(a1) -- Line: 75 -- upvalues: a2 (val) -- types: a1: number
                a2.TextTransparency = a1
            end,
        })
    end
    local TextStrokeTransparency = a2.TextStrokeTransparency
    if TextStrokeTransparency >= 1 then
        return
    end
    table.insert(a1, {
        Original = TextStrokeTransparency,
        Apply = function(a1) -- Line: 80 -- upvalues: a2 (val) -- types: a1: number
            a2.TextStrokeTransparency = a1
        end,
    })
end

local function addTextButtonChannels(a1, a2) -- Line: 84 -- types: a1: table, a2: userdata
    local TextTransparency = a2.TextTransparency
    if not (TextTransparency >= 1) then
        table.insert(a1, {
            Original = TextTransparency,
            Apply = function(a1) -- Line: 88 -- upvalues: a2 (val) -- types: a1: number
                a2.TextTransparency = a1
            end,
        })
    end
    local TextStrokeTransparency = a2.TextStrokeTransparency
    if TextStrokeTransparency >= 1 then
        return
    end
    table.insert(a1, {
        Original = TextStrokeTransparency,
        Apply = function(a1) -- Line: 93 -- upvalues: a2 (val) -- types: a1: number
            a2.TextStrokeTransparency = a1
        end,
    })
end

local function addTextBoxChannels(a1, a2) -- Line: 97 -- types: a1: table, a2: userdata
    local TextTransparency = a2.TextTransparency
    if not (TextTransparency >= 1) then
        table.insert(a1, {
            Original = TextTransparency,
            Apply = function(a1) -- Line: 101 -- upvalues: a2 (val) -- types: a1: number
                a2.TextTransparency = a1
            end,
        })
    end
    local TextStrokeTransparency = a2.TextStrokeTransparency
    if TextStrokeTransparency >= 1 then
        return
    end
    table.insert(a1, {
        Original = TextStrokeTransparency,
        Apply = function(a1) -- Line: 106 -- upvalues: a2 (val) -- types: a1: number
            a2.TextStrokeTransparency = a1
        end,
    })
end

local function addImageLabelChannel(a1, a2) -- Line: 110 -- types: a1: table, a2: userdata
    local ImageTransparency = a2.ImageTransparency
    if ImageTransparency >= 1 then
        return
    end
    table.insert(a1, {
        Original = ImageTransparency,
        Apply = function(a1) -- Line: 114 -- upvalues: a2 (val) -- types: a1: number
            a2.ImageTransparency = a1
        end,
    })
end

local function addImageButtonChannel(a1, a2) -- Line: 118 -- types: a1: table, a2: userdata
    local ImageTransparency = a2.ImageTransparency
    if ImageTransparency >= 1 then
        return
    end
    table.insert(a1, {
        Original = ImageTransparency,
        Apply = function(a1) -- Line: 122 -- upvalues: a2 (val) -- types: a1: number
            a2.ImageTransparency = a1
        end,
    })
end

local function captureFadeChannels(a1) -- Line: 126
    -- upvalues: isHiddenByDefault (val), addTextLabelChannels (val), addTextButtonChannels (val)
    -- upvalues: addTextBoxChannels (val)
    local BackgroundTransparency, GroupTransparency, ImageTransparency, ImageTransparency_2, Transparency
    local v1 = {}
    for i, v in ipairs(a1:GetDescendants()) do
        if not isHiddenByDefault(v, a1) then
            if v:IsA("GuiObject") then
                BackgroundTransparency = v.BackgroundTransparency
                if not (BackgroundTransparency >= 1) then
                    table.insert(v1, {
                        Original = BackgroundTransparency,
                        Apply = function(a1) -- Line: 137 -- upvalues: v (val) -- types: a1: number
                            v.BackgroundTransparency = a1
                        end,
                    })
                end
                if v:IsA("TextLabel") then
                    addTextLabelChannels(v1, v)
                elseif v:IsA("TextButton") then
                    addTextButtonChannels(v1, v)
                elseif v:IsA("TextBox") then
                    addTextBoxChannels(v1, v)
                elseif v:IsA("ImageLabel") then
                    ImageTransparency = v.ImageTransparency
                    if not (ImageTransparency >= 1) then
                        table.insert(v1, {
                            Original = ImageTransparency,
                            Apply = function(a1) -- Line: 114 -- upvalues: v (val) -- types: a1: number
                                v.ImageTransparency = a1
                            end,
                        })
                    end
                elseif v:IsA("ImageButton") then
                    ImageTransparency_2 = v.ImageTransparency
                    if not (ImageTransparency_2 >= 1) then
                        table.insert(v1, {
                            Original = ImageTransparency_2,
                            Apply = function(a1) -- Line: 122 -- upvalues: v (val) -- types: a1: number
                                v.ImageTransparency = a1
                            end,
                        })
                    end
                end
                if v:IsA("CanvasGroup") then
                    GroupTransparency = v.GroupTransparency
                    if not (GroupTransparency >= 1) then
                        table.insert(v1, {
                            Original = GroupTransparency,
                            Apply = function(a1) -- Line: 157 -- upvalues: v (val) -- types: a1: number
                                v.GroupTransparency = a1
                            end,
                        })
                    end
                end
            elseif v:IsA("UIStroke") then
                Transparency = v.Transparency
                if not (Transparency >= 1) then
                    table.insert(v1, {
                        Original = Transparency,
                        Apply = function(a1) -- Line: 165 -- upvalues: v (val) -- types: a1: number
                            v.Transparency = a1
                        end,
                    })
                end
            end
        end
    end
    return v1
end

local function resolveTransparency(a1, a2) -- Line: 173 -- types: a1: number, a2: number
    return 1 - a2 * (1 - a1)
end

local function applyFadeAlpha(a1) -- Line: 177 -- types: a1: table
    local v1
    for i, v in ipairs(a1.Channels) do
        v1 = 1 - a1.Alpha * (1 - v.Original)
        v.Apply(v1)
    end
end

local function applyEntryTargetVisible(a1) -- Line: 184 -- types: a1: table
    local RangeVisible = a1.RangeVisible and a1.SuppressCount <= 0
    a1.TargetVisible = RangeVisible
    if RangeVisible then
        a1.Billboard.Enabled = true
    end
end

local function setEntryRangeVisible(a1, a2) -- Line: 192 -- types: a1: table, a2: boolean
    a1.RangeVisible = a2
    local RangeVisible = a1.RangeVisible and a1.SuppressCount <= 0
    a1.TargetVisible = RangeVisible
    if RangeVisible then
        a1.Billboard.Enabled = true
    end
end

local function stepEntryFade(a1, a2) -- Line: 197 -- upvalues: applyFadeAlpha (val) -- types: a1: table, a2: number
    local v1 = if not a1.TargetVisible then 0 else 1
    if a1.Alpha ~= v1 then
        local v2 = a2 / 0.2
        if not (a1.Alpha < v1) then
            a1.Alpha = math.max(a1.Alpha - v2, v1)
        else
            a1.Alpha = math.min(a1.Alpha + v2, v1)
        end
        applyFadeAlpha(a1)
    end
    if a1.TargetVisible then
        a1.Billboard.Enabled = true
        return
    end
    if a1.Alpha <= 0 then
        a1.Billboard.Enabled = false
    end
end

function u29.new() -- Line: 220
    -- upvalues: u29 (val), Trove (val), RunService (val), Players (val), ItemDisplay (val), stepEntryFade (val)
    local u3 = setmetatable({}, u29)
    u3._trove = Trove.new()
    u3._entries = {}
    u3._elapsed = 0
    u3._trove:Add((RunService.Heartbeat:Connect(function(a1) -- Line: 225
        -- upvalues: u3 (val), Players (upval), ItemDisplay (upval), stepEntryFade (upval)
        local PrimaryPart, RangeVisible, RangeVisible_2, v1, v2
        local v3 = u3
        v3._elapsed = v3._elapsed + a1
        if 0.15 <= u3._elapsed then
            u3._elapsed = 0
        end
        local Character = Players.LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        local v4 = if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
        for k, v in pairs(u3._entries) do
            if v3 then
                PrimaryPart = k.PrimaryPart
                if PrimaryPart == nil or k.Parent == nil then
                    v.RangeVisible = false
                    RangeVisible_2 = v.RangeVisible and v.SuppressCount <= 0
                    v.TargetVisible = RangeVisible_2
                    if RangeVisible_2 then
                        v.Billboard.Enabled = true
                    end
                elseif v4 ~= nil then
                    v2 = PrimaryPart.Position - v4.Position
                    v1 = Vector2.new(v2.X, v2.Z).Magnitude <= ItemDisplay.GetDataBillboardMaxDistance()
                    v.RangeVisible = v1
                    RangeVisible = v.RangeVisible and v.SuppressCount <= 0
                    v.TargetVisible = RangeVisible
                    if RangeVisible then
                        v.Billboard.Enabled = true
                    end
                else
                    v.RangeVisible = false
                    RangeVisible_2 = v.RangeVisible and v.SuppressCount <= 0
                    v.TargetVisible = RangeVisible_2
                    if RangeVisible_2 then
                        v.Billboard.Enabled = true
                    end
                end
            end
            stepEntryFade(v, a1)
        end
    end)))
    return u3
end

function u29:Add(a2, a3, a4) -- Line: 259
    -- upvalues: ItemDisplay (val), captureFadeChannels (val), applyFadeAlpha (val)
    local v1 = ItemDisplay.CreateDataBillboard(a2, a3.Category, a3, a4)
    local v2 = ("Asset model %* must expose CENTER for its data billboard"):format(a2.Name)
    assert(v1 ~= nil, v2)
    v1.MaxDistance = 100000
    local v3 = {
        Alpha = 0,
        RangeVisible = false,
        SuppressCount = 0,
        TargetVisible = false,
        Model = a2,
        Billboard = v1,
        Channels = captureFadeChannels(v1),
    }
    applyFadeAlpha(v3)
    v1.Enabled = false
    self._entries[a2] = v3
end

function u29.UpdateMoneyPerSecond(a1, a2, a3) -- Line: 283
    -- upvalues: ItemDisplay (val)
    local v1 = a1._entries[a2]
    local v2 = ("Asset model %* must have a data billboard before its MPS can update"):format(a2.Name)
    assert(v1 ~= nil, v2)
    ItemDisplay.SetDataBillboardMoneyPerSecond(v1.Billboard, a3)
end

function u29.SetSuppressed(a1, a2, a3) -- Line: 296 -- types: a2: userdata, a3: boolean
    local v1 = a1._entries[a2]
    if v1 == nil then
        return
    end
    if a3 then
        v1.SuppressCount = v1.SuppressCount + 1
    elseif 0 < v1.SuppressCount then
        v1.SuppressCount = v1.SuppressCount - 1
    end
    local RangeVisible = v1.RangeVisible and v1.SuppressCount <= 0
    v1.TargetVisible = RangeVisible
    if RangeVisible then
        v1.Billboard.Enabled = true
    end
end

function u29:Remove(a2) -- Line: 314 -- types: a2: userdata
    local v1 = self._entries[a2]
    if v1 ~= nil then
        v1.Billboard:Destroy()
        self._entries[a2] = nil
    end
end

function u29:Destroy() -- Line: 322
    for k in pairs(self._entries) do
        self:Remove(k)
    end
    self._trove:Destroy()
end

return u29