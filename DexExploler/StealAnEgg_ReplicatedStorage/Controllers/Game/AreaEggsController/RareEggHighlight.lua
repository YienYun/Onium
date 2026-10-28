-- Script path: ReplicatedStorage.Controllers.Game.AreaEggsController.RareEggHighlight
-- Decompile time: 12.04 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Types.AreaEggResetCycle)
require(ReplicatedStorage.Shared.Types.AreaEggs)
local t = require(ReplicatedStorage.Packages.t)
local Assets = require(ReplicatedStorage.Data.Assets)
local CaptureTheEgg = require(ReplicatedStorage.Data.CaptureTheEgg)
local EggState = require(ReplicatedStorage.Client.EggState)
local Log = require(ReplicatedStorage.Packages.Log)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local u49 = require(script.Parent.WorkspaceEggVisibility)
local Rank = Rarity.Rarities.Secret.Rank
local u55 = Log.new()
local u56 = {}
local u57 = {}
local u58 = {}
local u59 = nil
local u60 = false
local u61 = (-1 / 0)
local u62 = false
local v1 = {}

local function getOutlineColor(a1, a2) -- Line: 50
    -- upvalues: Workspace (val), CaptureTheEgg (val), Assets (val), Rank (val)
    if Workspace:GetAttribute(CaptureTheEgg.EggUidAttribute) == a1 then
        return CaptureTheEgg.EggHighlightColor
    end
    local v1 = Assets.Directory[a2]
    local v2 = ("Missing asset config %*"):format(a2)
    assert(v1 ~= nil, v2)
    local Rarity = v1.Rarity
    if Rarity.Rank < Rank then
        return nil
    end
    return Rarity.Color
end

local function clearBinding(a1) -- Line: 63 -- upvalues: u57 (val) -- types: a1: string
    local v1 = u57[a1]
    if v1 == nil then
        return
    end
    u57[a1] = nil
    local DestroyConnection = v1.DestroyConnection
    if DestroyConnection ~= nil then
        DestroyConnection:Disconnect()
    end
    if v1.Highlight.Parent ~= nil then
        v1.Highlight:Destroy()
    end
end

local function clearAllBindings() -- Line: 78 -- upvalues: u57 (val)
    local DestroyConnection, v1
    for k in pairs(u57) do
        v1 = u57[k]
        if v1 ~= nil then
            u57[k] = nil
            DestroyConnection = v1.DestroyConnection
            if DestroyConnection ~= nil then
                DestroyConnection:Disconnect()
            end
            if v1.Highlight.Parent ~= nil then
                v1.Highlight:Destroy()
            end
        end
    end
end

local function bindModel(a1, a2, a3) -- Line: 84 -- upvalues: u57 (val) -- types: a1: string, a2: userdata, a3: userdata
    local v1 = u57[a1]
    if v1 ~= nil and v1.Model == a2 then
        v1.Highlight.OutlineColor = a3
        return
    end
    v1 = u57[a1]
    if v1 ~= nil then
        u57[a1] = nil
        local DestroyConnection = v1.DestroyConnection
        if DestroyConnection ~= nil then
            DestroyConnection:Disconnect()
        end
        if v1.Highlight.Parent ~= nil then
            v1.Highlight:Destroy()
        end
    end
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "RareAreaEggHighlight"
    Highlight.Adornee = a2
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.FillTransparency = 1
    Highlight.OutlineTransparency = 0.25
    Highlight.OutlineColor = a3
    Highlight.Parent = a2
    local u36 = {Model = a2, Highlight = Highlight}
    u57[a1] = u36
    u36.DestroyConnection = a2.Destroying:Connect(function() -- Line: 107 -- upvalues: u57 (upval), a1 (val), u36 (val)
        if u57[a1] == u36 then
            u57[a1] = nil
        end
    end)
end

local function syncUid(a1) -- Line: 114
    -- upvalues: u56 (val), u58 (val), u57 (val), u60 (ref), Workspace (val), CaptureTheEgg (val), Assets (val)
    -- upvalues: Rank (val), bindModel (val), u49 (val)
    local EggHighlightColor, v1
    local v2 = u56[a1]
    if v2 == nil then
        u58[a1] = nil
        v1 = u57[a1]
        if v1 == nil then
            return
        end
        u57[a1] = nil
        local DestroyConnection = v1.DestroyConnection
        if DestroyConnection ~= nil then
            DestroyConnection:Disconnect()
        end
        if v1.Highlight.Parent ~= nil then
            v1.Highlight:Destroy()
        end
        return
    end
    if u60 then
        v1 = u57[a1]
        if v1 == nil then
            return
        end
        u57[a1] = nil
        local DestroyConnection_2 = v1.DestroyConnection
        if DestroyConnection_2 ~= nil then
            DestroyConnection_2:Disconnect()
        end
        if v1.Highlight.Parent ~= nil then
            v1.Highlight:Destroy()
        end
        return
    end
    local v3 = Workspace
    if v3:GetAttribute(CaptureTheEgg.EggUidAttribute) ~= a1 then
        v3 = Assets.Directory[v2]
        local v4 = ("Missing asset config %*"):format(v2)
        assert(v3 ~= nil, v4)
        local Rarity = v3.Rarity
        EggHighlightColor = if not (Rarity.Rank < Rank) then Rarity.Color else nil
    else
        EggHighlightColor = CaptureTheEgg.EggHighlightColor
    end
    if EggHighlightColor == nil then
        u58[a1] = nil
        v2 = u57[a1]
        if v2 == nil then
            return
        end
        u57[a1] = nil
        local DestroyConnection_3 = v2.DestroyConnection
        if DestroyConnection_3 ~= nil then
            DestroyConnection_3:Disconnect()
        end
        if v2.Highlight.Parent ~= nil then
            v2.Highlight:Destroy()
        end
        return
    end
    v3 = u58[a1]
    u58[a1] = nil
    if v3 ~= nil and v3.Parent ~= nil then
        bindModel(a1, v3, EggHighlightColor)
        return
    end
    v3 = u57[a1]
    if v3 ~= nil and v3.Model.Parent ~= nil then
        v3.Highlight.OutlineColor = EggHighlightColor
        return
    end
    v3 = u49.ResolveModel(a1)
    if v3 ~= nil then
        bindModel(a1, v3, EggHighlightColor)
    end
end

local function beginResetReveal(a1) -- Line: 149 -- upvalues: u61 (ref), u60 (ref), u58 (val), u57 (val)
    local DestroyConnection, v1
    if a1.DayStartsAt <= u61 then
        return
    end
    u61 = a1.DayStartsAt
    u60 = true
    table.clear(u58)
    for k in pairs(u57) do
        v1 = u57[k]
        if v1 ~= nil then
            u57[k] = nil
            DestroyConnection = v1.DestroyConnection
            if DestroyConnection ~= nil then
                DestroyConnection:Disconnect()
            end
            if v1.Highlight.Parent ~= nil then
                v1.Highlight:Destroy()
            end
        end
    end
end

local function completeResetReveal() -- Line: 159 -- upvalues: u60 (ref), u56 (val), syncUid (val)
    u60 = false
    for k in pairs(u56) do
        syncUid(k)
    end
end

local function applyRecord(a1) -- Line: 166 -- upvalues: u56 (val), syncUid (val)
    u56[a1.Uid] = a1.AssetCategory
    syncUid(a1.Uid)
end

local function applySnapshot(a1) -- Line: 171 -- upvalues: u56 (val), u59 (ref), u58 (val), u57 (val), syncUid (val)
    local DestroyConnection, v1
    local v2 = {}
    for i, v in ipairs(a1.Records) do
        v2[v.Uid] = true
        u56[v.Uid] = v.AssetCategory
    end
    for k in pairs(u56) do
        if v2[k] ~= true and k ~= u59 then
            u56[k] = nil
            u58[k] = nil
            v1 = u57[k]
            if v1 ~= nil then
                u57[k] = nil
                DestroyConnection = v1.DestroyConnection
                if DestroyConnection ~= nil then
                    DestroyConnection:Disconnect()
                end
                if v1.Highlight.Parent ~= nil then
                    v1.Highlight:Destroy()
                end
            end
        end
    end
    for k2 in pairs(v2) do
        syncUid(k2)
    end
end

local function applyCarryState(a1) -- Line: 189
    -- upvalues: u59 (ref), u56 (val), syncUid (val), EggState (val), u58 (val), u57 (val)
    local v1, v2
    local v3 = u59
    if a1.IsCarrying then
        v1 = assert(a1.Uid, "Carried area egg state must include Uid")
        v2 = assert(a1.AssetCategory, "Carried area egg state must include AssetCategory")
        u59 = v1
        u56[v1] = v2
        syncUid(v1)
        return
    end
    u59 = nil
    if v3 == nil then
        return
    end
    v1 = EggState.ReadFieldEgg(v3)
    if v1 ~= nil then
        u56[v1.Uid] = v1.AssetCategory
        syncUid(v1.Uid)
        return
    end
    u56[v3] = nil
    u58[v3] = nil
    v2 = u57[v3]
    if v2 == nil then
        return
    end
    u57[v3] = nil
    local DestroyConnection = v2.DestroyConnection
    if DestroyConnection ~= nil then
        DestroyConnection:Disconnect()
    end
    if v2.Highlight.Parent ~= nil then
        v2.Highlight:Destroy()
    end
end

local function observeWorkspaceChild(a1) -- Line: 215
    -- upvalues: u60 (ref), u56 (val), Workspace (val), CaptureTheEgg (val), Assets (val), Rank (val), bindModel (val)
    if not a1:IsA("Model") then
        return
    end
    task.defer(function() -- Line: 219
        -- upvalues: u60 (upval), a1 (val), u56 (upval), Workspace (upval), CaptureTheEgg (upval), Assets (upval)
        -- upvalues: Rank (upval), bindModel (upval)
        if u60 then
            return
        end
        local Name = a1.Name
        local v1 = u56[Name]
        if a1.Parent == Workspace and v1 ~= nil then
            local EggHighlightColor
            local v2 = Workspace
            if v2:GetAttribute(CaptureTheEgg.EggUidAttribute) ~= Name then
                v2 = Assets.Directory[v1]
                local v3 = ("Missing asset config %*"):format(v1)
                assert(v2 ~= nil, v3)
                local Rarity = v2.Rarity
                EggHighlightColor = if not (Rarity.Rank < Rank) then Rarity.Color else nil
            else
                EggHighlightColor = CaptureTheEgg.EggHighlightColor
            end
            if EggHighlightColor ~= nil then
                bindModel(Name, a1, EggHighlightColor)
            end
            return
        end
    end)
end

function v1.BindRenderedModel(a1, a2) -- Line: 239
    -- upvalues: t (val), u56 (val), u60 (ref), u58 (val), u57 (val), Workspace (val), CaptureTheEgg (val), Assets (val)
    -- upvalues: Rank (val), bindModel (val)
    local EggHighlightColor
    t.strict(t.table)(a1)
    t.strict(t.instanceIsA("Model"))(a2)
    u56[a1.Uid] = a1.AssetCategory
    if u60 then
        u58[a1.Uid] = a2
        local Uid = a1.Uid
        local v1 = u57[Uid]
        if v1 == nil then
            return
        end
        u57[Uid] = nil
        local DestroyConnection = v1.DestroyConnection
        if DestroyConnection ~= nil then
            DestroyConnection:Disconnect()
        end
        if v1.Highlight.Parent ~= nil then
            v1.Highlight:Destroy()
        end
        return
    end
    local Uid_2 = a1.Uid
    local AssetCategory = a1.AssetCategory
    local v2 = Workspace
    if v2:GetAttribute(CaptureTheEgg.EggUidAttribute) ~= Uid_2 then
        v2 = Assets.Directory[AssetCategory]
        local v3 = ("Missing asset config %*"):format(AssetCategory)
        assert(v2 ~= nil, v3)
        local Rarity = v2.Rarity
        EggHighlightColor = if not (Rarity.Rank < Rank) then Rarity.Color else nil
    else
        EggHighlightColor = CaptureTheEgg.EggHighlightColor
    end
    if EggHighlightColor ~= nil then
        bindModel(a1.Uid, a2, EggHighlightColor)
        return
    end
    local Uid_3 = a1.Uid
    local v4 = u57[Uid_3]
    if v4 == nil then
        return
    end
    u57[Uid_3] = nil
    local DestroyConnection_2 = v4.DestroyConnection
    if DestroyConnection_2 ~= nil then
        DestroyConnection_2:Disconnect()
    end
    if v4.Highlight.Parent ~= nil then
        v4.Highlight:Destroy()
    end
end

function v1.Start() -- Line: 256
    -- upvalues: u62 (ref), EggState (val), beginResetReveal (val), completeResetReveal (val), applySnapshot (val)
    -- upvalues: applyRecord (val), u59 (ref), u56 (val), u58 (val), u57 (val), syncUid (val), applyCarryState (val)
    -- upvalues: Workspace (val), observeWorkspaceChild (val), CaptureTheEgg (val), u55 (val)
    assert(not u62, "RareEggHighlight.Start may only be called once")
    u62 = true
    EggState.ResetCountdown:Connect(beginResetReveal)
    EggState.RarityPresented:Connect(completeResetReveal)
    EggState.FieldRefreshed:Connect(applySnapshot)
    EggState.FieldShifted:Connect(applyRecord)
    EggState.FieldGone:Connect(function(a1) -- Line: 263
        -- upvalues: u59 (upval), u56 (upval), u58 (upval), u57 (upval), syncUid (upval)
        if a1 == u59 then
            syncUid(a1)
            return
        end
        u56[a1] = nil
        u58[a1] = nil
        local v1 = u57[a1]
        if v1 == nil then
            return
        end
        u57[a1] = nil
        local DestroyConnection = v1.DestroyConnection
        if DestroyConnection ~= nil then
            DestroyConnection:Disconnect()
        end
        if v1.Highlight.Parent == nil then
            return
        end
        v1.Highlight:Destroy()
    end)
    EggState.CarryChanged:Connect(applyCarryState)
    Workspace.ChildAdded:Connect(observeWorkspaceChild)
    ;(Workspace:GetAttributeChangedSignal(CaptureTheEgg.EggUidAttribute)):Connect(function() -- Line: 274 -- upvalues: u56 (upval), syncUid (upval)
        for k in pairs(u56) do
            syncUid(k)
        end
    end)
    applySnapshot(EggState.ReadFieldEggs())
    u55:AtDebug():Log("Rare area egg highlight lifecycle started")
end

return (table.freeze(v1))