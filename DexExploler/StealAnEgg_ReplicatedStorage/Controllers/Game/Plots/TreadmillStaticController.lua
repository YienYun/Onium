-- Script path: ReplicatedStorage.Controllers.Game.Plots.TreadmillStaticController
-- Decompile time: 30.79 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local t = require(ReplicatedStorage.Packages.t)
local u43 = t.intersection(t.array(t.integer), function(a1) -- Line: 17
    local v1 = {}
    for i, v in ipairs(a1) do
        if v1[v] then
            return false
        end
        v1[v] = true
    end
    return true
end)
local Transition = require(ReplicatedStorage.Client.BaseUpgrade).Transition
require(ReplicatedStorage.Shared.Globals.Constants)
local EmitAt = require(ReplicatedStorage.Shared.Utils.VFX).EmitAt
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local Log = require(ReplicatedStorage.Packages.Log)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local PlotUpgradeVisibility = require(ReplicatedStorage.Client.PlotUpgradeVisibility)
local WarmAssets = require(ReplicatedStorage.Shared.Utils.Preload).WarmAssets
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local TreadmillStaticCover = require(ReplicatedStorage.Client.UI.TreadmillStaticCover)
local TreadmillVideoGate = require(ReplicatedStorage.Client.TreadmillVideoGate)
local Render = require(script.Render)
require(script.Types.Interface)
local TreadmillVideoController = require(ReplicatedStorage.Shared.TreadmillVideoController)
local Treadmills = require(ReplicatedStorage.Data.Treadmills)
local LocalPlayer = Players.LocalPlayer
local u124 = Log.new()

local function releaseActiveTreadmill(a1) -- Line: 70 -- upvalues: CollectionService (val) -- types: a1: string?
    local v1 = a1
    for i, j in CollectionService:GetTagged("ActiveTreadmill") do
        if v1 == nil or j:GetAttribute("ActiveTreadmillId") == v1 then
            CollectionService:RemoveTag(j, "ActiveTreadmill")
            j:SetAttribute("ActiveTreadmillId", nil)
        end
    end
end

local function bindActiveTreadmill(a1, a2) -- Line: 82
    -- upvalues: releaseActiveTreadmill (val), CollectionService (val)
    releaseActiveTreadmill(a1)
    CollectionService:RemoveTag(a2, "ActiveTreadmill")
    a2:SetAttribute("ActiveTreadmillId", a1)
    CollectionService:AddTag(a2, "ActiveTreadmill")
end

return {
    Start = function() -- Line: 93
        -- upvalues: ReplicatedStorage (val), Workspace (val), WarmAssets (val), TryLock (val), LocalPlayer (val)
        -- upvalues: CollectionService (val), PlotState (val), RunService (val), TweenService (val), Render (val)
        -- upvalues: EmitAt (val), Audio (val), Toast (val), TreadmillStaticCover (val), releaseActiveTreadmill (val)
        -- upvalues: Players (val), Save (val), Transition (val), Remotes (val), t (val), u43 (val), Treadmills (val)
        -- upvalues: PlotUpgradeVisibility (val), u124 (val), TreadmillVideoGate (val), TreadmillVideoController (val)
        local OverrideAttribute
        local TreadmillUpgrade = ReplicatedStorage.Assets.Particles.TreadmillUpgrade
        local Folder = Instance.new("Folder")
        Folder.Name = "__ClientTreadmillRenders"
        Folder.Parent = Workspace
        task.spawn(WarmAssets, TreadmillUpgrade)
        local u13 = nil
        local u14 = false
        local u15 = {}
        local u16 = false
        local u18 = TryLock()
        local u19 = false
        local BaseUpgradeLevel = 0
        local u22 = true
        local u23 = 0
        local u24 = 0
        local u25 = false
        local u26 = false
        local u27 = false
        local u28 = {}
        local u29 = {}
        local u30 = {}

        local function destroyRender(a1) -- Line: 123
            -- upvalues: u29 (val), LocalPlayer (upval), CollectionService (upval)
            local v1 = u29[a1]
            if v1 == nil then
                return
            end
            u29[a1] = nil
            if v1.OwnerUserId == LocalPlayer.UserId then
                CollectionService:RemoveTag(v1.Model, "ActiveTreadmill")
            end
            if v1.Cover ~= nil then
                v1.Cover:Destroy()
            end
            v1.Model:Destroy()
        end

        local function resolveLocalRender() -- Line: 138 -- upvalues: PlotState (upval), u29 (val)
            local v1 = PlotState.ResolveLocalSlot()
            if v1 == nil then
                return nil
            end
            return u29[v1]
        end

        local function animateScale(a1, a2, a3, a4, a5) -- Line: 143
            -- upvalues: RunService (upval), TweenService (upval), Render (upval)
            local Value, v1
            local v2 = 0
            while v2 < a4 do
                v1 = RunService.PreRender:Wait()
                if a1.Model.Parent == nil then
                    break
                end
                v2 = math.min(v2 + v1, a4)
                Value = TweenService:GetValue(v2 / a4, a5, Enum.EasingDirection.Out)
                Render.SetGroundedScale(a1, a2 + (a3 - a2) * Value)
            end
            if a1.Model.Parent ~= nil then
                Render.SetGroundedScale(a1, a3)
            end
        end

        local function runLocalUpgradeAnimation(a1, a2) -- Line: 169
            -- upvalues: TweenService (upval), TreadmillUpgrade (val), EmitAt (upval), Audio (upval), Toast (upval)
            -- upvalues: animateScale (val)
            local Root = a1.Model.Root
            assert(Root:IsA("BasePart"), (("Treadmill \"%*\" Root must be a BasePart"):format(a1.TreadmillId)))
            local Highlight = Instance.new("Highlight")
            Highlight.Adornee = a1.Model
            Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            Highlight.FillColor = Color3.new(1, 1, 1)
            Highlight.FillTransparency = 1
            Highlight.OutlineColor = Color3.new(1, 1, 1)
            Highlight.OutlineTransparency = 1
            Highlight.Parent = a1.Model
            local v1 = TweenService:Create(
                Highlight,
                TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {FillTransparency = 0.15, OutlineTransparency = 0}
            )
            local u54 = TweenService:Create(
                Highlight,
                TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {FillTransparency = 1, OutlineTransparency = 1}
            )
            v1.Completed:Once(function() -- Line: 201 -- upvalues: u54 (val)
                u54:Play()
            end)
            u54.Completed:Once(function() -- Line: 204 -- upvalues: Highlight (val)
                Highlight:Destroy()
            end)
            v1:Play()
            v1 = TreadmillUpgrade:Clone()
            EmitAt(Root, v1:GetChildren())
            Audio.Play(130233661094961, script, {Volume = 1.5, PlaybackSpeed = {0.9, 1.1}})
            Toast.Show({
                Text = "Successfully upgraded your treadmill!",
                Seconds = 0.7,
                Color = Color3.fromRGB(0, 255, 47),
            })
            animateScale(a1, a2 * 0.8, a2, 0.55, Enum.EasingStyle.Elastic)
        end

        local function replaceRender(a1, a2, a3, a4) -- Line: 226
            -- upvalues: u30 (val), u29 (val), animateScale (val), LocalPlayer (upval), CollectionService (upval)
            -- upvalues: Render (upval), Folder (val), u13 (ref), TreadmillStaticCover (upval), u14 (ref)
            -- upvalues: releaseActiveTreadmill (upval), runLocalUpgradeAnimation (val)
            local v1 = (u30[a1] or 0) + 1
            u30[a1] = v1
            local v2 = u29[a1]
            if a4 and v2 ~= nil then
                local Scale = v2.Model:GetScale()
                animateScale(v2, Scale, Scale * 0.8, 0.22, Enum.EasingStyle.Quad)
                if u30[a1] ~= v1 then
                    return
                end
            end
            v2 = u29[a1]
            if v2 ~= nil then
                u29[a1] = nil
                if v2.OwnerUserId == LocalPlayer.UserId then
                    CollectionService:RemoveTag(v2.Model, "ActiveTreadmill")
                end
                if v2.Cover ~= nil then
                    v2.Cover:Destroy()
                end
                v2.Model:Destroy()
            end
            v1 = Render.Build(a1, a2, a3, if not a4 then 1 else 0.8, a2 == LocalPlayer.UserId, Folder)
            u29[a1] = v1
            if a2 == LocalPlayer.UserId then
                v1.RateSign.Enabled = u13 == nil
                local Cover = v1.Cover
                if Cover ~= nil then
                    TreadmillStaticCover.SetEnabled(Cover, u13 == nil)
                end
                if u13 ~= nil and not u14 then
                    local TreadmillId = v1.TreadmillId
                    local Model_2 = v1.Model
                    releaseActiveTreadmill(TreadmillId)
                    CollectionService:RemoveTag(Model_2, "ActiveTreadmill")
                    Model_2:SetAttribute("ActiveTreadmillId", TreadmillId)
                    CollectionService:AddTag(Model_2, "ActiveTreadmill")
                end
            end
            if a4 then
                runLocalUpgradeAnimation(v1, v1.Model:GetScale() / 0.8)
            end
        end

        local function refreshSlot(a1, a2, a3) -- Line: 273
            -- upvalues: u30 (val), u29 (val), LocalPlayer (upval), CollectionService (upval), u15 (val)
            -- upvalues: Players (upval), Save (upval), PlotState (upval), u27 (ref), BaseUpgradeLevel (ref)
            -- upvalues: Transition (upval), replaceRender (val)
            local v1
            if a2 == nil then
                u30[a1] = (u30[a1] or 0) + 1
                v1 = u29[a1]
                if v1 == nil then
                    return
                end
                u29[a1] = nil
                if v1.OwnerUserId == LocalPlayer.UserId then
                    CollectionService:RemoveTag(v1.Model, "ActiveTreadmill")
                end
                if v1.Cover ~= nil then
                    v1.Cover:Destroy()
                end
                v1.Model:Destroy()
                return
            end
            if a2 ~= LocalPlayer.UserId and u15[a2] ~= true then
                u30[a1] = (u30[a1] or 0) + 1
                v1 = u29[a1]
                if v1 == nil then
                    return
                end
                u29[a1] = nil
                if v1.OwnerUserId == LocalPlayer.UserId then
                    CollectionService:RemoveTag(v1.Model, "ActiveTreadmill")
                end
                if v1.Cover ~= nil then
                    v1.Cover:Destroy()
                end
                v1.Model:Destroy()
                return
            end
            local PlayerByUserId = Players:GetPlayerByUserId(a2)
            if PlayerByUserId == nil then
                return
            end
            local v2 = Save.Await(PlayerByUserId)
            if v2 ~= nil and PlotState.LookupOwner(a1) == a2 then
                local v3
                if v2.BaseUpgradeLevel == 0 then
                    v1 = u29[a1]
                    if v1 == nil then
                        return
                    end
                    u29[a1] = nil
                    if v1.OwnerUserId == LocalPlayer.UserId then
                        CollectionService:RemoveTag(v1.Model, "ActiveTreadmill")
                    end
                    if v1.Cover ~= nil then
                        v1.Cover:Destroy()
                    end
                    v1.Model:Destroy()
                    return
                end
                if a2 ~= LocalPlayer.UserId then
                    replaceRender(a1, a2, v2, a3)
                    return
                end
                if u27 then
                    u27 = true
                    v3 = u29[a1]
                    if v3 == nil then
                        return
                    end
                    u29[a1] = nil
                    if v3.OwnerUserId == LocalPlayer.UserId then
                        CollectionService:RemoveTag(v3.Model, "ActiveTreadmill")
                    end
                    if v3.Cover ~= nil then
                        v3.Cover:Destroy()
                    end
                    v3.Model:Destroy()
                    return
                end
                if BaseUpgradeLevel == 0 and Transition.IsPlaying() then
                    u27 = true
                    v3 = u29[a1]
                    if v3 == nil then
                        return
                    end
                    u29[a1] = nil
                    if v3.OwnerUserId == LocalPlayer.UserId then
                        CollectionService:RemoveTag(v3.Model, "ActiveTreadmill")
                    end
                    if v3.Cover ~= nil then
                        v3.Cover:Destroy()
                    end
                    v3.Model:Destroy()
                    return
                end
                replaceRender(a1, a2, v2, a3)
                return
            end
        end

        local function refreshPlayerRender(a1, a2) -- Line: 310
            -- upvalues: PlotState (upval), refreshSlot (val)
            for k, v in pairs(PlotState.ReadOwners()) do
                if v == a1.UserId then
                    refreshSlot(k, v, a2)
                    return
                end
            end
        end

        local function applyRemoteSessionTransition(a1, a2, a3) -- Line: 319
            -- upvalues: u23 (ref), LocalPlayer (upval), u15 (val), refreshPlayerRender (val)
            if a3 <= u23 then
                return
            end
            u23 = a3
            if a1 == LocalPlayer then
                return
            end
            if not a2 then
                u15[a1.UserId] = nil
            else
                u15[a1.UserId] = true
            end
            refreshPlayerRender(a1, false)
        end

        local function synchronizeRemoteSessionSnapshot() -- Line: 335
            -- upvalues: Remotes (upval), t (upval), u43 (upval), u15 (val), LocalPlayer (upval), u23 (ref), u28 (val)
            -- upvalues: u22 (ref), refreshPlayerRender (val)
            local Active, Player, Revision
            local v1, v2 = Remotes.Treadmill.AskRenderSnapshot:InvokeServer()
            t.strict(u43)(v1)
            t.strict(t.number)(v2)
            table.clear(u15)
            for i, v in ipairs(v1) do
                if v ~= LocalPlayer.UserId then
                    u15[v] = true
                end
            end
            u23 = v2
            table.sort(u28, function(a1, a2) -- Line: 346
                return a1.Revision < a2.Revision
            end)
            u22 = false
            for i2, i3 in ipairs(u28) do
                Player = i3.Player
                Active = i3.Active
                Revision = i3.Revision
                if not (Revision <= u23) then
                    u23 = Revision
                    if Player ~= LocalPlayer then
                        if not Active then
                            u15[Player.UserId] = nil
                        else
                            u15[Player.UserId] = true
                        end
                        refreshPlayerRender(Player, false)
                    end
                end
            end
            table.clear(u28)
        end

        local function refreshLocalRender(a1) -- Line: 356
            -- upvalues: u19 (ref), refreshPlayerRender (val), LocalPlayer (upval)
            u19 = true
            refreshPlayerRender(LocalPlayer, a1)
            u19 = false
        end

        local function consumePendingUpgradeRefresh() -- Line: 362
            -- upvalues: u16 (ref), u25 (ref), u13 (ref), u26 (ref), u19 (ref), refreshPlayerRender (val)
            -- upvalues: LocalPlayer (upval), u24 (ref), Workspace (upval)
            if u16 and u25 and u13 == nil then
                local v1 = u26
                u16 = false
                u25 = false
                u26 = false
                u19 = true
                refreshPlayerRender(LocalPlayer, v1)
                u19 = false
                u24 = Workspace:GetServerTimeNow() + 1.25
                return
            end
        end

        local function onTreadmillOverrideChanged(a1) -- Line: 374
            -- upvalues: LocalPlayer (upval), refreshPlayerRender (val), u13 (ref), u16 (ref), u25 (ref), u26 (ref)
            -- upvalues: u19 (ref), u24 (ref), Workspace (upval)
            if a1 ~= LocalPlayer then
                refreshPlayerRender(a1, false)
                return
            end
            if u13 == nil and not u16 then
                u19 = true
                refreshPlayerRender(LocalPlayer, false)
                u19 = false
                return
            end
            u25 = true
            if u16 and u25 then
                if u13 ~= nil then
                    return
                end
                local v1 = u26
                u16 = false
                u25 = false
                u26 = false
                u19 = true
                refreshPlayerRender(LocalPlayer, v1)
                u19 = false
                u24 = Workspace:GetServerTimeNow() + 1.25
            end
        end

        local function refreshPlotUpgradeVisibility() -- Line: 395
            -- upvalues: PlotUpgradeVisibility (upval), BaseUpgradeLevel (ref)
            PlotUpgradeVisibility.Apply("TreadmillUpgrade", BaseUpgradeLevel > 0)
        end

        local function revealFirstExpansionTreadmill() -- Line: 399
            -- upvalues: Save (upval), BaseUpgradeLevel (ref), u27 (ref), PlotUpgradeVisibility (upval), u19 (ref)
            -- upvalues: refreshPlayerRender (val), LocalPlayer (upval), u24 (ref), Workspace (upval)
            local v1 = Save.Await()
            assert(v1 ~= nil, "First expansion treadmill reveal requires local save data")
            if v1.BaseUpgradeLevel == 0 then
                return
            end
            BaseUpgradeLevel = v1.BaseUpgradeLevel
            u27 = false
            PlotUpgradeVisibility.Apply("TreadmillUpgrade", BaseUpgradeLevel > 0)
            u19 = true
            refreshPlayerRender(LocalPlayer, true)
            u19 = false
            u24 = Workspace:GetServerTimeNow() + 1.25
        end

        Save.Await()
        local v1 = Save.Await()
        assert(v1 ~= nil, "Static treadmill controller requires local save data")
        local TreadmillUpgradeLevel = v1.TreadmillUpgradeLevel
        BaseUpgradeLevel = v1.BaseUpgradeLevel
        Remotes.Treadmill.RenderStateShifted.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 462
            -- upvalues: t (upval), u22 (ref), u28 (val), u23 (ref), LocalPlayer (upval), u15 (val)
            -- upvalues: refreshPlayerRender (val)
            t.strict(t.instanceIsA("Player"))(a1)
            t.strict(t.boolean)(a2)
            t.strict(t.number)(a3)
            if u22 then
                table.insert(u28, {Active = a2, Player = a1, Revision = a3})
                return
            end
            if a3 <= u23 then
                return
            end
            u23 = a3
            if a1 == LocalPlayer then
                return
            end
            if not a2 then
                u15[a1.UserId] = nil
            else
                u15[a1.UserId] = true
            end
            refreshPlayerRender(a1, false)
        end)
        synchronizeRemoteSessionSnapshot()
        for k, v in pairs(PlotState.ReadOwners()) do
            task.spawn(refreshSlot, k, v, false)
        end
        PlotUpgradeVisibility.Apply("TreadmillUpgrade", BaseUpgradeLevel > 0)
        PlotState.PlotChanged:Connect(function(a1, a2) -- Line: 483
            -- upvalues: PlotUpgradeVisibility (upval), BaseUpgradeLevel (ref), refreshSlot (val)
            PlotUpgradeVisibility.Apply("TreadmillUpgrade", BaseUpgradeLevel > 0)
            task.spawn(refreshSlot, a1, a2, false)
        end)
        TreadmillVideoGate.Changed:Connect(function() -- Line: 488 -- upvalues: PlotState (upval), LocalPlayer (upval), u13 (ref), refreshSlot (val)
            for k, v in pairs(PlotState.ReadOwners()) do
                if v ~= LocalPlayer.UserId or u13 == nil then
                    task.spawn(refreshSlot, k, v, false)
                end
            end
        end)
        PlotState.FolderChanged:Connect(function() -- Line: 496
            -- upvalues: PlotUpgradeVisibility (upval), BaseUpgradeLevel (ref), PlotState (upval), refreshSlot (val)
            PlotUpgradeVisibility.Apply("TreadmillUpgrade", BaseUpgradeLevel > 0)
            for k, v in pairs(PlotState.ReadOwners()) do
                task.spawn(refreshSlot, k, v, false)
            end
        end)
        Players.PlayerAdded:Connect(function(a1) -- Line: 502 -- upvalues: refreshPlayerRender (val)
            task.spawn(refreshPlayerRender, a1, false)
        end)
        Players.PlayerAdded:Connect(function(a1) -- Line: 389
            -- upvalues: Treadmills (upval), LocalPlayer (upval), refreshPlayerRender (val), u13 (ref), u16 (ref)
            -- upvalues: u25 (ref), u26 (ref), u19 (ref), u24 (ref), Workspace (upval)
            (a1:GetAttributeChangedSignal(Treadmills.OverrideAttribute)):Connect(function() -- Line: 390
                -- upvalues: a1 (val), LocalPlayer (upval), refreshPlayerRender (upval), u13 (upval), u16 (upval)
                -- upvalues: u25 (upval), u26 (upval), u19 (upval), u24 (upval), Workspace (upval)
                local v1 = a1
                if v1 ~= LocalPlayer then
                    refreshPlayerRender(v1, false)
                    return
                end
                if u13 == nil and not u16 then
                    u19 = true
                    refreshPlayerRender(LocalPlayer, false)
                    u19 = false
                    return
                end
                u25 = true
                if u16 and u25 then
                    if u13 ~= nil then
                        return
                    end
                    local v2 = u26
                    u16 = false
                    u25 = false
                    u26 = false
                    u19 = true
                    refreshPlayerRender(LocalPlayer, v2)
                    u19 = false
                    u24 = Workspace:GetServerTimeNow() + 1.25
                    return
                end
            end)
        end)
        for i, j in Players:GetPlayers() do
            OverrideAttribute = Treadmills.OverrideAttribute
            ;(j:GetAttributeChangedSignal(OverrideAttribute)):Connect(function() -- Line: 390
                -- upvalues: j (val), LocalPlayer (upval), refreshPlayerRender (val), u13 (ref), u16 (ref), u25 (ref)
                -- upvalues: u26 (ref), u19 (ref), u24 (ref), Workspace (upval)
                local v1 = j
                if v1 ~= LocalPlayer then
                    refreshPlayerRender(v1, false)
                    return
                end
                if u13 == nil and not u16 then
                    u19 = true
                    refreshPlayerRender(LocalPlayer, false)
                    u19 = false
                    return
                end
                u25 = true
                if u16 and u25 then
                    if u13 ~= nil then
                        return
                    end
                    local v2 = u26
                    u16 = false
                    u25 = false
                    u26 = false
                    u19 = true
                    refreshPlayerRender(LocalPlayer, v2)
                    u19 = false
                    u24 = Workspace:GetServerTimeNow() + 1.25
                    return
                end
            end)
        end
        Players.PlayerRemoving:Connect(function(a1) -- Line: 509 -- upvalues: u15 (val), u29 (val), u30 (val), LocalPlayer (upval), CollectionService (upval)
            local v1
            u15[a1.UserId] = nil
            for k, v in pairs(u29) do
                if v and v.OwnerUserId == a1.UserId then
                    u30[k] = (u30[k] or 0) + 1
                    v1 = u29[k]
                    if v1 ~= nil then
                        u29[k] = nil
                        if v1.OwnerUserId == LocalPlayer.UserId then
                            CollectionService:RemoveTag(v1.Model, "ActiveTreadmill")
                        end
                        if v1.Cover ~= nil then
                            v1.Cover:Destroy()
                        end
                        v1.Model:Destroy()
                    end
                end
            end
        end)
        Save.PeerLoaded:Connect(function(a1) -- Line: 518 -- upvalues: refreshPlayerRender (val) -- types: a1: userdata
            refreshPlayerRender(a1, false)
        end)
        Save.PeerChanged:Connect(function(a1, a2) -- Line: 521
            -- upvalues: refreshPlayerRender (val), Save (upval), u29 (val), TreadmillStaticCover (upval)
            if a2 == "TreadmillUpgradeLevel" then
                refreshPlayerRender(a1, false)
                return
            end
            if a2 == "TreadmillMediaFeedState" then
                local v1 = Save.Peek(a1)
                if v1 ~= nil then
                    for k, v in pairs(u29) do
                        if v and v.OwnerUserId == a1.UserId and v.Cover ~= nil then
                            TreadmillStaticCover.ApplyFeed(v.Cover, v1.TreadmillMediaFeedState)
                        end
                    end
                end
            end
        end)
        Remotes.Treadmill.ViewStateShifted.OnClientEvent:Connect(function(a1, a2) -- Line: 538
            -- upvalues: t (upval), LocalPlayer (upval), TreadmillVideoController (upval), u29 (val)
            -- upvalues: TreadmillStaticCover (upval)
            t.strict(t.instanceIsA("Player"))(a1)
            t.strict(t.string)(a2)
            if a1 == LocalPlayer then
                return
            end
            local v1 = TreadmillVideoController.GetMediaEntryByKey(a2)
            if v1 == nil then
                return
            end
            for k, v in pairs(u29) do
                if v and v.OwnerUserId == a1.UserId and v.Cover ~= nil then
                    TreadmillStaticCover.ApplyMedia(v.Cover, v1)
                end
            end
        end)
        ;(Save.Watch("TreadmillUpgradeLevel")):Connect(function() -- Line: 557
            -- upvalues: Save (upval), TreadmillUpgradeLevel (ref), PlotUpgradeVisibility (upval)
            -- upvalues: BaseUpgradeLevel (ref), u13 (ref), u16 (ref), u25 (ref), u26 (ref), u19 (ref)
            -- upvalues: refreshPlayerRender (val), LocalPlayer (upval), u24 (ref), Workspace (upval)
            local v1 = Save.Await()
            assert(v1 ~= nil, "Local treadmill upgrade requires save data")
            local TreadmillUpgradeLevel_2 = v1.TreadmillUpgradeLevel
            local v2 = TreadmillUpgradeLevel < TreadmillUpgradeLevel_2
            TreadmillUpgradeLevel = v1.TreadmillUpgradeLevel
            PlotUpgradeVisibility.Apply("TreadmillUpgrade", BaseUpgradeLevel > 0)
            if u13 == nil and not u16 then
                u19 = true
                refreshPlayerRender(LocalPlayer, v2)
                u19 = false
                return
            end
            u25 = true
            u26 = u26 or v2
            if u16 and u25 then
                if u13 ~= nil then
                    return
                end
                v1 = u26
                u16 = false
                u25 = false
                u26 = false
                u19 = true
                refreshPlayerRender(LocalPlayer, v1)
                u19 = false
                u24 = Workspace:GetServerTimeNow() + 1.25
            end
        end)
        ;(Save.Watch("BaseUpgradeLevel")):Connect(function() -- Line: 571
            -- upvalues: Save (upval), BaseUpgradeLevel (ref), PlotUpgradeVisibility (upval), Transition (upval)
            -- upvalues: u27 (ref), u19 (ref), refreshPlayerRender (val), LocalPlayer (upval), u24 (ref)
            -- upvalues: Workspace (upval)
            local v1 = Save.Await()
            assert(v1 ~= nil, "Local base upgrade requires save data")
            local v2 = false
            if BaseUpgradeLevel == 0 then
                v2 = 0 < v1.BaseUpgradeLevel
            end
            BaseUpgradeLevel = v1.BaseUpgradeLevel
            if not v2 then
                PlotUpgradeVisibility.Apply("TreadmillUpgrade", BaseUpgradeLevel > 0)
                return
            end
            if Transition.IsPlaying() then
                BaseUpgradeLevel = 0
                u27 = true
                PlotUpgradeVisibility.Apply("TreadmillUpgrade", BaseUpgradeLevel > 0)
                return
            end
            v2 = Save.Await()
            assert(v2 ~= nil, "First expansion treadmill reveal requires local save data")
            if v2.BaseUpgradeLevel == 0 then
                return
            end
            BaseUpgradeLevel = v2.BaseUpgradeLevel
            u27 = false
            PlotUpgradeVisibility.Apply("TreadmillUpgrade", BaseUpgradeLevel > 0)
            u19 = true
            refreshPlayerRender(LocalPlayer, true)
            u19 = false
            u24 = Workspace:GetServerTimeNow() + 1.25
        end)
        Transition.Completed:Connect(function() -- Line: 590
            -- upvalues: u27 (ref), Save (upval), BaseUpgradeLevel (ref), PlotUpgradeVisibility (upval), u19 (ref)
            -- upvalues: refreshPlayerRender (val), LocalPlayer (upval), u24 (ref), Workspace (upval)
            if u27 then
                local v1 = Save.Await()
                assert(v1 ~= nil, "First expansion treadmill reveal requires local save data")
                if v1.BaseUpgradeLevel == 0 then
                    return
                end
                BaseUpgradeLevel = v1.BaseUpgradeLevel
                u27 = false
                PlotUpgradeVisibility.Apply("TreadmillUpgrade", BaseUpgradeLevel > 0)
                u19 = true
                refreshPlayerRender(LocalPlayer, true)
                u19 = false
                u24 = Workspace:GetServerTimeNow() + 1.25
            end
        end)
        Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(a1, a2, a3, a4, a5, a6) -- Line: 596
            -- upvalues: u13 (ref), u14 (ref), Workspace (upval), releaseActiveTreadmill (upval)
            -- upvalues: CollectionService (upval), PlotState (upval), u29 (val), u24 (ref), u16 (ref), u25 (ref)
            -- upvalues: u26 (ref), u19 (ref), refreshPlayerRender (val), LocalPlayer (upval)
            -- upvalues: TreadmillStaticCover (upval)
            local Model, v1, v2
            u13 = a1
            local v3 = false
            if a1 ~= nil then
                v3 = a6 == true
            end
            u14 = v3
            if a1 == nil then
                if a1 == nil then
                    releaseActiveTreadmill()
                    u24 = Workspace:GetServerTimeNow() + 1.25
                    if a5 == true then
                        u16 = true
                        if u16 and u25 and u13 == nil then
                            v3 = u26
                            u16 = false
                            u25 = false
                            u26 = false
                            u19 = true
                            refreshPlayerRender(LocalPlayer, v3)
                            u19 = false
                            u24 = Workspace:GetServerTimeNow() + 1.25
                        end
                    end
                else
                    v1 = PlotState.ResolveLocalSlot()
                    v3 = if v1 ~= nil then u29[v1] else nil
                    v2 = false
                    if v3 ~= nil then
                        v2 = v3.TreadmillId == a1
                    end
                    assert(v2, (("Missing active treadmill render \"%*\""):format(a1)))
                    Model = v3.Model
                    releaseActiveTreadmill(a1)
                    CollectionService:RemoveTag(Model, "ActiveTreadmill")
                    Model:SetAttribute("ActiveTreadmillId", a1)
                    CollectionService:AddTag(Model, "ActiveTreadmill")
                end
            elseif a6 == true then
                local AdminTreadmill = Workspace:WaitForChild("AdminTreadmill", 5)
                v2 = false
                if AdminTreadmill ~= nil then
                    v2 = AdminTreadmill:IsA("Tool")
                end
                assert(v2, "Workspace.AdminTreadmill must be a Tool")
                releaseActiveTreadmill(a1)
                CollectionService:RemoveTag(AdminTreadmill, "ActiveTreadmill")
                AdminTreadmill:SetAttribute("ActiveTreadmillId", a1)
                CollectionService:AddTag(AdminTreadmill, "ActiveTreadmill")
            elseif a1 == nil then
                releaseActiveTreadmill()
                u24 = Workspace:GetServerTimeNow() + 1.25
                if a5 == true then
                    u16 = true
                    if u16 and u25 and u13 == nil then
                        v3 = u26
                        u16 = false
                        u25 = false
                        u26 = false
                        u19 = true
                        refreshPlayerRender(LocalPlayer, v3)
                        u19 = false
                        u24 = Workspace:GetServerTimeNow() + 1.25
                    end
                end
            else
                v1 = PlotState.ResolveLocalSlot()
                v3 = if v1 ~= nil then u29[v1] else nil
                v2 = false
                if v3 ~= nil then
                    v2 = v3.TreadmillId == a1
                end
                assert(v2, (("Missing active treadmill render \"%*\""):format(a1)))
                Model = v3.Model
                releaseActiveTreadmill(a1)
                CollectionService:RemoveTag(Model, "ActiveTreadmill")
                Model:SetAttribute("ActiveTreadmillId", a1)
                CollectionService:AddTag(Model, "ActiveTreadmill")
            end
            v1 = PlotState.ResolveLocalSlot()
            v3 = if v1 ~= nil then u29[v1] else nil
            if v3 ~= nil then
                v1 = true
                if a1 ~= nil then
                    v1 = a6 == true
                end
                v3.RateSign.Enabled = v1
                local Cover = v3.Cover
                if Cover ~= nil then
                    TreadmillStaticCover.SetEnabled(Cover, v1)
                end
            end
        end)
        TreadmillVideoController.MediaChanged:Connect(function(a1) -- Line: 639 -- upvalues: PlotState (upval), u29 (val), TreadmillStaticCover (upval)
            local v1 = PlotState.ResolveLocalSlot()
            local v2 = if v1 ~= nil then u29[v1] else nil
            if v2 ~= nil then
                local Cover = v2.Cover
                if Cover ~= nil then
                    TreadmillStaticCover.ApplyMedia(Cover, a1)
                end
            end
        end)
        RunService.Heartbeat:Connect(function() -- Line: 413
            -- upvalues: PlotState (upval), u29 (val), u13 (ref), u16 (ref), u19 (ref), Workspace (upval), u24 (ref)
            -- upvalues: LocalPlayer (upval), u18 (val), releaseActiveTreadmill (upval), CollectionService (upval)
            -- upvalues: Remotes (upval), u124 (upval)
            local v1 = PlotState.ResolveLocalSlot()
            local u5 = if v1 ~= nil then u29[v1] else nil
            if u13 == nil and not u16 and not u19 and u5 ~= nil then
                local ServerTimeNow = Workspace:GetServerTimeNow()
                if ServerTimeNow < u24 then
                    return
                end
                local Character = LocalPlayer.Character
                local HumanoidRootPart = if Character ~= nil then Character:FindFirstChild("HumanoidRootPart") else nil
                if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
                    local v2 = RaycastParams.new()
                    v2.FilterType = Enum.RaycastFilterType.Include
                    v2.FilterDescendantsInstances = {u5.Bottom}
                    if Workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -8, 0), v2) == nil then
                        return
                    end
                    u24 = ServerTimeNow + 1.25
                    u18(function() -- Line: 442
                        -- upvalues: u5 (val), releaseActiveTreadmill (upval), CollectionService (upval)
                        -- upvalues: Remotes (upval), u124 (upval)
                        local TreadmillId = u5.TreadmillId
                        local Model = u5.Model
                        releaseActiveTreadmill(TreadmillId)
                        CollectionService:RemoveTag(Model, "ActiveTreadmill")
                        Model:SetAttribute("ActiveTreadmillId", TreadmillId)
                        CollectionService:AddTag(Model, "ActiveTreadmill")
                        local v1, v2 = Remotes.Treadmill.AskWearStill:InvokeServer()
                        if v1 ~= true then
                            releaseActiveTreadmill(u5.TreadmillId)
                            ;(u124:AtWarning()):Log((("Static treadmill entry rejected: %*"):format(v2)))
                        end
                    end)
                    return
                end
                return
            end
        end)
    end,
}