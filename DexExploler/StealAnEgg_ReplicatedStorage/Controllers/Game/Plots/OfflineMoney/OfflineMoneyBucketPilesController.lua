-- Script path: ReplicatedStorage.Controllers.Game.Plots.OfflineMoney.OfflineMoneyBucketPilesController
-- Decompile time: 13.44 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ActiveAssetsController = require(script.Parent.Parent.ActiveAssetsController)
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Currency = require(ReplicatedStorage.Shared.Types.Currency)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local Reward = require(ReplicatedStorage.Client.Notifications.Reward)
local OfflineAssets = require(ReplicatedStorage.Client.Types.OfflineAssets)
local ClaimVisual = require(script.ClaimVisual)
local Player = require(ReplicatedStorage.Shared.Player)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Money = Currency.AllCurrencyTypes.Money
local LocalPlayer = Players.LocalPlayer
local u77 = nil
local u78 = 0
local u79 = nil
local u80 = {}
return {
    Start = function() -- Line: 50
        -- upvalues: OfflineAssets (val), Save (val), u77 (ref), Constants (val), u79 (ref), Player (val)
        -- upvalues: LocalPlayer (val), u78 (ref), Remotes (val), u80 (val), Reward (val), Money (val), Trove (val)
        -- upvalues: ClaimVisual (val), TryLock (val), RunService (val), AssetRoster (val), PlotState (val)
        -- upvalues: ActiveAssetsController (val)
        local function readSummary(a1) -- Line: 55 -- upvalues: OfflineAssets (upval)
            if not OfflineAssets.OfflineClaimSummary(a1) then
                return nil
            end
            return a1
        end

        local function readRedeemResult(a1) -- Line: 63 -- upvalues: OfflineAssets (upval)
            if not OfflineAssets.OfflineRedeemResult(a1) then
                return nil
            end
            return a1
        end

        local function hasReadiness() -- Line: 71 -- upvalues: Save (upval)
            return Save.IsLoaded()
        end

        local function currentClaimAmount() -- Line: 75 -- upvalues: u77 (upval), Constants (upval)
            local v1 = u77
            local v2 = if not v1 then 0 else math.max(v1.TotalAmount, 0)
            if Constants.OFFLINE_ASSETS.MIN_CLAIM_MONEY <= v2 then
                return v2
            end
            return 0
        end

        local function clearSession(a1) -- Line: 82 -- upvalues: u79 (upval) -- types: a1: table?
            local v1 = u79
            if a1 ~= nil and v1 ~= a1 then
                return
            end
            u79 = nil
            if v1 then
                v1.trove:Destroy()
            end
        end

        local function feetInsideSession(a1) -- Line: 96
            -- upvalues: Player (upval), LocalPlayer (upval)
            local v1 = Player.FindFeetCFrame(LocalPlayer)
            local v2 = false
            if v1 ~= nil then
                v2 = a1.visual:ContainsWorldPosition(v1.Position)
            end
            return v2
        end

        local function requestSummary() -- Line: 102
            -- upvalues: u78 (upval), Remotes (upval), OfflineAssets (upval), u77 (upval), u80 (upval)
            u78 = u78 + 1
            local u2 = u78
            task.spawn(function() -- Line: 106
                -- upvalues: Remotes (upval), OfflineAssets (upval), u2 (val), u78 (upval), u77 (upval), u80 (upval)
                local v1 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
                local v2 = if OfflineAssets.OfflineClaimSummary(v1) then v1 else nil
                if u2 ~= u78 then
                    return
                end
                if v2 then
                    u77 = v2
                end
                u80.Sync()
            end)
        end

        local function showOfflineMoneyNotification(a1) -- Line: 121
            -- upvalues: Reward (upval), Money (upval)
            if a1 <= 0 then
                return
            end
            Reward.Show({Item = {Kind = "Currency", Id = Money, Amount = math.round(a1)}})
        end

        local function claim(a1) -- Line: 135
            -- upvalues: u77 (upval), Remotes (upval), OfflineAssets (upval), showOfflineMoneyNotification (val)
            -- upvalues: u79 (upval), u78 (upval), u80 (upval)
            if a1.amount <= 0 then
                return
            end
            a1.claimLock(function() -- Line: 140
                -- upvalues: u77 (upval), a1 (val), Remotes (upval), OfflineAssets (upval)
                -- upvalues: showOfflineMoneyNotification (upval), u79 (upval), u78 (upval), u80 (upval)
                local v1, v2
                u77 = {
                    ClaimableAmount = 0,
                    ReservedAmount = 0,
                    TotalAmount = 0,
                    IsMultiplierPurchasePending = false,
                }
                a1.visual:PlayClaim()
                v1, _, v2 = Remotes.AwayEarnings.AskCollect:InvokeServer({Kind = "Claim"})
                local v3 = if OfflineAssets.OfflineRedeemResult(v2) then v2 else nil
                if v1 == true and v3 ~= nil then
                    showOfflineMoneyNotification(v3.AwardedAmount)
                    local v4 = a1
                    v2 = u79
                    if v4 ~= nil and v2 ~= v4 then
                        return
                    end
                    u79 = nil
                    if v2 then
                        v2.trove:Destroy()
                    end
                    return
                end
                u78 = u78 + 1
                local u36 = u78
                task.spawn(function() -- Line: 106
                    -- upvalues: Remotes (upval), OfflineAssets (upval), u36 (val), u78 (upval), u77 (upval)
                    -- upvalues: u80 (upval)
                    local v1 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
                    local v2 = if OfflineAssets.OfflineClaimSummary(v1) then v1 else nil
                    if u36 ~= u78 then
                        return
                    end
                    if v2 then
                        u77 = v2
                    end
                    u80.Sync()
                end)
            end)
        end

        local function updateClaimEntry(a1) -- Line: 165
            -- upvalues: Player (upval), LocalPlayer (upval), u77 (upval), Remotes (upval), OfflineAssets (upval)
            -- upvalues: showOfflineMoneyNotification (val), u79 (upval), u78 (upval), u80 (upval)
            local v1 = Player.FindFeetCFrame(LocalPlayer)
            local v2 = false
            if v1 ~= nil then
                v2 = a1.visual:ContainsWorldPosition(v1.Position)
            end
            local feetInside = a1.feetInside
            a1.feetInside = v2
            a1.visual:SetBillboardEnabled(not v2)
            if v2 and not feetInside then
                if a1.amount <= 0 then
                    return
                end
                a1.claimLock(function() -- Line: 140
                    -- upvalues: u77 (upval), a1 (val), Remotes (upval), OfflineAssets (upval)
                    -- upvalues: showOfflineMoneyNotification (upval), u79 (upval), u78 (upval), u80 (upval)
                    local v1, v2
                    u77 = {
                        ClaimableAmount = 0,
                        ReservedAmount = 0,
                        TotalAmount = 0,
                        IsMultiplierPurchasePending = false,
                    }
                    a1.visual:PlayClaim()
                    v1, _, v2 = Remotes.AwayEarnings.AskCollect:InvokeServer({Kind = "Claim"})
                    local v3 = if OfflineAssets.OfflineRedeemResult(v2) then v2 else nil
                    if v1 == true and v3 ~= nil then
                        showOfflineMoneyNotification(v3.AwardedAmount)
                        local v4 = a1
                        v2 = u79
                        if v4 ~= nil and v2 ~= v4 then
                            return
                        end
                        u79 = nil
                        if v2 then
                            v2.trove:Destroy()
                        end
                        return
                    end
                    u78 = u78 + 1
                    local u36 = u78
                    task.spawn(function() -- Line: 106
                        -- upvalues: Remotes (upval), OfflineAssets (upval), u36 (val), u78 (upval), u77 (upval)
                        -- upvalues: u80 (upval)
                        local v1 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
                        local v2 = if OfflineAssets.OfflineClaimSummary(v1) then v1 else nil
                        if u36 ~= u78 then
                            return
                        end
                        if v2 then
                            u77 = v2
                        end
                        u80.Sync()
                    end)
                end)
            end
        end

        local function sessionFor(a1, a2, a3) -- Line: 177
            -- upvalues: Trove (upval), ClaimVisual (upval), TryLock (upval), RunService (upval), Player (upval)
            -- upvalues: LocalPlayer (upval), u77 (upval), Remotes (upval), OfflineAssets (upval)
            -- upvalues: showOfflineMoneyNotification (val), u79 (upval), u78 (upval), u80 (upval)
            local v1 = Trove.new()
            local u11 = ClaimVisual.new(a1, a2, a3)
            local u12 = {feetInside = false, trove = v1, amount = a1, visual = u11}
            u12.claimLock = TryLock()
            v1:Add(function() -- Line: 188 -- upvalues: u11 (val)
                u11:Destroy()
            end)
            v1:Add((RunService.Heartbeat:Connect(function() -- Line: 192
                -- upvalues: u12 (val), Player (upval), LocalPlayer (upval), u77 (upval), Remotes (upval)
                -- upvalues: OfflineAssets (upval), showOfflineMoneyNotification (upval), u79 (upval), u78 (upval)
                -- upvalues: u80 (upval)
                local u0 = u12
                local v1 = Player.FindFeetCFrame(LocalPlayer)
                local v2 = false
                if v1 ~= nil then
                    v2 = u0.visual:ContainsWorldPosition(v1.Position)
                end
                local feetInside = u0.feetInside
                u0.feetInside = v2
                u0.visual:SetBillboardEnabled(not v2)
                if v2 and not feetInside then
                    if u0.amount <= 0 then
                        return
                    end
                    u0.claimLock(function() -- Line: 140
                        -- upvalues: u77 (upval), u0 (val), Remotes (upval), OfflineAssets (upval)
                        -- upvalues: showOfflineMoneyNotification (upval), u79 (upval), u78 (upval), u80 (upval)
                        local v1, v2
                        u77 = {
                            ClaimableAmount = 0,
                            ReservedAmount = 0,
                            TotalAmount = 0,
                            IsMultiplierPurchasePending = false,
                        }
                        u0.visual:PlayClaim()
                        v1, _, v2 = Remotes.AwayEarnings.AskCollect:InvokeServer({Kind = "Claim"})
                        local v3 = if OfflineAssets.OfflineRedeemResult(v2) then v2 else nil
                        if v1 == true and v3 ~= nil then
                            showOfflineMoneyNotification(v3.AwardedAmount)
                            local v4 = u0
                            v2 = u79
                            if v4 ~= nil and v2 ~= v4 then
                                return
                            end
                            u79 = nil
                            if v2 then
                                v2.trove:Destroy()
                            end
                            return
                        end
                        u78 = u78 + 1
                        local u36 = u78
                        task.spawn(function() -- Line: 106
                            -- upvalues: Remotes (upval), OfflineAssets (upval), u36 (val), u78 (upval), u77 (upval)
                            -- upvalues: u80 (upval)
                            local v1 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
                            local v2 = if OfflineAssets.OfflineClaimSummary(v1) then v1 else nil
                            if u36 ~= u78 then
                                return
                            end
                            if v2 then
                                u77 = v2
                            end
                            u80.Sync()
                        end)
                    end)
                end
            end)))
            return u12
        end

        local function tryInitialize() -- Line: 199
            -- upvalues: Save (upval), u78 (upval), Remotes (upval), OfflineAssets (upval), u77 (upval), u80 (upval)
            if not Save.IsLoaded() then
                return
            end
            u78 = u78 + 1
            local u5 = u78
            task.spawn(function() -- Line: 106
                -- upvalues: Remotes (upval), OfflineAssets (upval), u5 (val), u78 (upval), u77 (upval), u80 (upval)
                local v1 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
                local v2 = if OfflineAssets.OfflineClaimSummary(v1) then v1 else nil
                if u5 ~= u78 then
                    return
                end
                if v2 then
                    u77 = v2
                end
                u80.Sync()
            end)
            u80.Sync()
        end

        function u80.Sync() -- Line: 212
            -- upvalues: Save (upval), u77 (upval), Constants (upval), u79 (upval), AssetRoster (upval)
            -- upvalues: LocalPlayer (upval), PlotState (upval), sessionFor (val), Player (upval), Remotes (upval)
            -- upvalues: OfflineAssets (upval), showOfflineMoneyNotification (val), u78 (upval), u80 (upval)
            local v1
            if not Save.IsLoaded() then
                return
            end
            local v2 = u77
            local v3 = if not v2 then 0 else math.max(v2.TotalAmount, 0)
            if (if not (Constants.OFFLINE_ASSETS.MIN_CLAIM_MONEY <= v3) then 0 else v3) <= 0 then
                v2 = u79
                u79 = nil
                if v2 then
                    v2.trove:Destroy()
                end
                return
            end
            v2 = AssetRoster.FindPenArea(LocalPlayer)
            if v2 == nil then
                v3 = u79
                u79 = nil
                if v3 then
                    v3.trove:Destroy()
                end
                return
            end
            v3 = PlotState.ResolvePlot()
            local PlotFolder = if not v3 then workspace else v3.PlotFolder
            local u38 = u79
            if u38 == nil then
                local u46 = sessionFor(v1, v2, PlotFolder)
                u79 = u46
                local v4 = Player.FindFeetCFrame(LocalPlayer)
                local v5 = false
                if v4 ~= nil then
                    v5 = u46.visual:ContainsWorldPosition(v4.Position)
                end
                local feetInside = u46.feetInside
                u46.feetInside = v5
                u46.visual:SetBillboardEnabled(not v5)
                if v5 and not feetInside then
                    if u46.amount <= 0 then
                        return
                    end
                    u46.claimLock(function() -- Line: 140
                        -- upvalues: u77 (upval), u46 (val), Remotes (upval), OfflineAssets (upval)
                        -- upvalues: showOfflineMoneyNotification (upval), u79 (upval), u78 (upval), u80 (upval)
                        local v1, v2
                        u77 = {
                            ClaimableAmount = 0,
                            ReservedAmount = 0,
                            TotalAmount = 0,
                            IsMultiplierPurchasePending = false,
                        }
                        u46.visual:PlayClaim()
                        v1, _, v2 = Remotes.AwayEarnings.AskCollect:InvokeServer({Kind = "Claim"})
                        local v3 = if OfflineAssets.OfflineRedeemResult(v2) then v2 else nil
                        if v1 == true and v3 ~= nil then
                            showOfflineMoneyNotification(v3.AwardedAmount)
                            local v4 = u46
                            v2 = u79
                            if v4 ~= nil and v2 ~= v4 then
                                return
                            end
                            u79 = nil
                            if v2 then
                                v2.trove:Destroy()
                            end
                            return
                        end
                        u78 = u78 + 1
                        local u36 = u78
                        task.spawn(function() -- Line: 106
                            -- upvalues: Remotes (upval), OfflineAssets (upval), u36 (val), u78 (upval), u77 (upval)
                            -- upvalues: u80 (upval)
                            local v1 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
                            local v2 = if OfflineAssets.OfflineClaimSummary(v1) then v1 else nil
                            if u36 ~= u78 then
                                return
                            end
                            if v2 then
                                u77 = v2
                            end
                            u80.Sync()
                        end)
                    end)
                end
                return
            end
            u38.amount = v1
            u38.visual:Update(v1, v2)
            v2 = Player.FindFeetCFrame(LocalPlayer)
            local v6 = false
            if v2 ~= nil then
                v6 = u38.visual:ContainsWorldPosition(v2.Position)
            end
            local feetInside_2 = u38.feetInside
            u38.feetInside = v6
            u38.visual:SetBillboardEnabled(not v6)
            if v6 and not feetInside_2 then
                if u38.amount <= 0 then
                    return
                end
                u38.claimLock(function() -- Line: 140
                    -- upvalues: u77 (upval), u38 (val), Remotes (upval), OfflineAssets (upval)
                    -- upvalues: showOfflineMoneyNotification (upval), u79 (upval), u78 (upval), u80 (upval)
                    local v1, v2
                    u77 = {
                        ClaimableAmount = 0,
                        ReservedAmount = 0,
                        TotalAmount = 0,
                        IsMultiplierPurchasePending = false,
                    }
                    u38.visual:PlayClaim()
                    v1, _, v2 = Remotes.AwayEarnings.AskCollect:InvokeServer({Kind = "Claim"})
                    local v3 = if OfflineAssets.OfflineRedeemResult(v2) then v2 else nil
                    if v1 == true and v3 ~= nil then
                        showOfflineMoneyNotification(v3.AwardedAmount)
                        local v4 = u38
                        v2 = u79
                        if v4 ~= nil and v2 ~= v4 then
                            return
                        end
                        u79 = nil
                        if v2 then
                            v2.trove:Destroy()
                        end
                        return
                    end
                    u78 = u78 + 1
                    local u36 = u78
                    task.spawn(function() -- Line: 106
                        -- upvalues: Remotes (upval), OfflineAssets (upval), u36 (val), u78 (upval), u77 (upval)
                        -- upvalues: u80 (upval)
                        local v1 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
                        local v2 = if OfflineAssets.OfflineClaimSummary(v1) then v1 else nil
                        if u36 ~= u78 then
                            return
                        end
                        if v2 then
                            u77 = v2
                        end
                        u80.Sync()
                    end)
                end)
            end
        end

        Remotes.AwayEarnings.SummaryRefreshed.OnClientEvent:Connect(function(a1) -- Line: 252 -- upvalues: OfflineAssets (upval), u77 (upval), u80 (upval)
            local v1 = if OfflineAssets.OfflineClaimSummary(a1) then a1 else nil
            if v1 then
                u77 = v1
                u80.Sync()
            end
        end)
        Remotes.AwayEarnings.Redeemed.OnClientEvent:Connect(function(a1) -- Line: 261
            -- upvalues: OfflineAssets (upval), u79 (upval), u78 (upval), Remotes (upval), u77 (upval), u80 (upval)
            local v1 = if OfflineAssets.OfflineRedeemResult(a1) then a1 else nil
            if v1 then
                v1 = u79
                u79 = nil
                if v1 then
                    v1.trove:Destroy()
                end
                u78 = u78 + 1
                local u16 = u78
                task.spawn(function() -- Line: 106
                    -- upvalues: Remotes (upval), OfflineAssets (upval), u16 (val), u78 (upval), u77 (upval)
                    -- upvalues: u80 (upval)
                    local v1 = Remotes.AwayEarnings.FetchSummary:InvokeServer()
                    local v2 = if OfflineAssets.OfflineClaimSummary(v1) then v1 else nil
                    if u16 ~= u78 then
                        return
                    end
                    if v2 then
                        u77 = v2
                    end
                    u80.Sync()
                end)
            end
        end)
        AssetRoster.PenAreaChanged:Connect(function(a1) -- Line: 268 -- upvalues: LocalPlayer (upval), u80 (upval) -- types: a1: userdata
            if a1 == LocalPlayer then
                u80.Sync()
            end
        end)
        PlotState.LocalPlotChanged:Connect(u80.Sync)
        ActiveAssetsController.ItemAdded:Connect(requestSummary)
        ActiveAssetsController.ItemRemoved:Connect(requestSummary)
        ActiveAssetsController.CashCollected:Connect(requestSummary)
        ActiveAssetsController.InitialLoadCompleted:Connect(tryInitialize)
        Save.Loaded:Connect(tryInitialize)
        task.defer(tryInitialize)
    end,
}