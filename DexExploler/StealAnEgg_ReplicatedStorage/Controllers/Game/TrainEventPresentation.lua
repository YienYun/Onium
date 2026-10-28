-- Script path: ReplicatedStorage.Controllers.Game.TrainEventPresentation
-- Decompile time: 19.04 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local SoundService = game:GetService("SoundService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local GUI = require(ReplicatedStorage.Client.GUI)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local TrainEvent = require(ReplicatedStorage.Shared.Remotes).TrainEvent
local TrainEventFlags = require(ReplicatedStorage.Shared.Flags.TrainEventFlags)
local PumpkinBossState = require(ReplicatedStorage.Shared.Util.PumpkinBossState)
local u68 = require(script.Parent.TrainRewardFlight)
local u69 = {}
local u71 = {Phase = "Home", ArrivalOpen = false}
local u72 = nil
local u73 = false
local u74 = false
local u75 = {}
local u76 = {}
local u77 = false
local u78 = nil
local u79 = nil
local u80 = nil
local u81 = nil
local u82 = nil

local function bindEventBannerStack(a1, a2, a3, a4) -- Line: 33
    -- upvalues: Players (val)
    local Position = a1.Position
    local u126 = {}
    local u127 = nil
    local u128 = false
    local u129 = false

    local function verticalBounds(a1) -- Line: 39 -- types: a1: userdata
        local visit
        local Y = a1.AbsolutePosition.Y
        local u5 = Y + a1.AbsoluteSize.Y

        function visit(a1) -- Line: 42 -- upvalues: Y (ref), u5 (ref), visit (val) -- types: a1: userdata
            for i, j in a1:GetChildren() do
                if j:IsA("GuiObject") and j.Visible then
                    math.min(Y, j.AbsolutePosition.Y)
                    math.max(u5, j.AbsolutePosition.Y + j.AbsoluteSize.Y)
                    visit(j)
                end
            end
        end

        visit(a1)
        return Y, u5
    end

    local function refresh() -- Line: 54
        -- upvalues: u128 (ref), u129 (ref), a3 (val), a1 (val), Position (val), a2 (val), u127 (ref)
        u128 = false
        if u129 then
            return
        end
        local Y_4 = a3.AbsoluteSize.Y
        if a1.Visible and not (Y_4 <= 0) then
            local v1, visit_3
            local v2 = (-1 / 0)
            if a2.Visible then
                local visit
                v1 = a2
                local Y = v1.AbsolutePosition.Y
                local u16 = Y + v1.AbsoluteSize.Y

                function visit(a1) -- Line: 42 -- upvalues: Y (ref), u16 (ref), visit (val) -- types: a1: userdata
                    for i, j in a1:GetChildren() do
                        if j:IsA("GuiObject") and j.Visible then
                            math.min(Y, j.AbsolutePosition.Y)
                            math.max(u16, j.AbsolutePosition.Y + j.AbsoluteSize.Y)
                            visit(j)
                        end
                    end
                end

                visit(v1)
                v2 = u16
            end
            if u127 and u127.Parent and u127.Enabled then
                for i, j in u127:GetChildren() do
                    if j:IsA("GuiObject") and j.Visible then
                        local Y_2 = j.AbsolutePosition.Y
                        local u51 = Y_2 + j.AbsoluteSize.Y

                        local function visit_2(a1) -- Line: 42
                            -- upvalues: Y_2 (ref), u51 (ref), visit_2 (val)
                            for i, j in a1:GetChildren() do
                                if j:IsA("GuiObject") and j.Visible then
                                    math.min(Y_2, j.AbsolutePosition.Y)
                                    math.max(u51, j.AbsolutePosition.Y + j.AbsoluteSize.Y)
                                    visit_2(j)
                                end
                            end
                        end

                        visit_2(j)
                        v2 = math.max(v2, u51)
                    end
                end
            end
            local v3 = a1
            local Y_3 = v3.AbsolutePosition.Y
            local u70 = Y_3 + v3.AbsoluteSize.Y

            function visit_3(a1) -- Line: 42 -- upvalues: Y_3 (ref), u70 (ref), visit_3 (val) -- types: a1: userdata
                for i, j in a1:GetChildren() do
                    if j:IsA("GuiObject") and j.Visible then
                        math.min(Y_3, j.AbsolutePosition.Y)
                        math.max(u70, j.AbsolutePosition.Y + j.AbsoluteSize.Y)
                        visit_3(j)
                    end
                end
            end

            visit_3(v3)
            local v4 = Y_3
            v1 = v4 - (a1.Position.Y.Scale - Position.Y.Scale) * Y_4
            a1.Position = Position + UDim2.fromScale(0, (math.max(0, v2 + (math.max(8, Y_4 * 0.012)) - v1)) / Y_4)
            return
        end
        a1.Position = Position
    end

    local function schedule() -- Line: 83 -- upvalues: u128 (ref), u129 (ref), refresh (val)
        if not u128 and not u129 then
            u128 = true
            task.defer(refresh)
            return
        end
    end

    local function watch(a1) -- Line: 88 -- upvalues: u126 (val), schedule (val) -- types: a1: userdata
        if a1:IsA("GuiObject") then
            table.insert(u126, ((a1:GetPropertyChangedSignal("Visible")):Connect(schedule)))
            table.insert(u126, ((a1:GetPropertyChangedSignal("AbsoluteSize")):Connect(schedule)))
        end
    end

    local v1 = {a1, a2}
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        watch(j)
        for k, n in j:GetDescendants() do
            watch(n)
        end
    end

    local function bindPumpkin(a1) -- Line: 98
        -- upvalues: u127 (ref), u126 (val), schedule (val), watch (val), u128 (ref), u129 (ref), refresh (val)
        if a1.Name == "ReturnPumpkinsHUDTimer" and a1:IsA("ScreenGui") and a1 ~= u127 then
            u127 = a1
            table.insert(u126, ((a1:GetPropertyChangedSignal("Enabled")):Connect(schedule)))
            table.insert(u126, (a1.AncestryChanged:Connect(schedule)))
            table.insert(u126, (a1.DescendantAdded:Connect(function(a1) -- Line: 103 -- upvalues: watch (upval), u128 (upval), u129 (upval), refresh (upval)
                watch(a1)
                if not u128 then
                    if u129 then
                        return
                    end
                    u128 = true
                    task.defer(refresh)
                end
            end)))
            for i, j in a1:GetDescendants() do
                watch(j)
            end
            if not u128 then
                if u129 then
                    return
                end
                u128 = true
                task.defer(refresh)
            end
            return
        end
    end

    local PlayerGui = a4 or Players.LocalPlayer:WaitForChild("PlayerGui")
    for m, i5 in PlayerGui:GetChildren() do
        bindPumpkin(i5)
    end
    table.insert(u126, (PlayerGui.ChildAdded:Connect(bindPumpkin)))
    table.insert(u126, ((a3:GetPropertyChangedSignal("AbsoluteSize")):Connect(schedule)))
    if not u128 and not u129 then
        task.defer(refresh)
    end
    return function() -- Line: 115 -- upvalues: u129 (ref), u126 (val), a1 (val), Position (val)
        u129 = true
        for i, j in u126 do
            j:Disconnect()
        end
        a1.Position = Position
    end
end

local function notice(a1, a2) -- Line: 122 -- upvalues: Toast (val)
    local Show = Toast.Show
    local v1 = {Lane = "Feed", Seconds = 3, Text = a1}
    local v2 = if not a2 then Color3.fromRGB(255, 120, 120) else Color3.fromRGB(150, 255, 120)
    v1.Color = v2
    Show(v1)
end

function u69.Update(a1) -- Line: 130 -- upvalues: u71 (ref)
    u71 = a1
end

function u69.InvasionTimer(a1, a2) -- Line: 133
    local StartsAt, v1
    local Invasion = a1.Invasion
    if a1.Phase ~= "Town" and a1.Phase ~= "Respawning" then
        return false, ""
    end
    if typeof(Invasion) ~= "table" then
        return false, ""
    end
    if Invasion.Phase == "Warmup" then
        v1 = "Starts in"
        StartsAt = Invasion.StartsAt
    elseif Invasion.Phase ~= "Active" then
        v1 = "Return in"
        StartsAt = a1.ReturnAt
    else
        v1 = "Invasion"
        StartsAt = Invasion.EndsAt
    end
    if type(StartsAt) == "number" and StartsAt == StartsAt and math.abs(StartsAt) ~= (1 / 0) then
        local v2 = math.max(0, (math.ceil(StartsAt - a2)))
        if v2 ~= 0 then
            return true, string.format("%s\n%02d:%02d", v1, math.floor(v2 / 60), v2 % 60)
        end
        local v3 = Invasion.Phase == "Active"
        if Invasion.Phase == "Active" then
            return v3, "Invasion ended"
        end
        return v3, ""
    end
    return false, ""
end

function u69.TrainBanner(a1, a2, a3) -- Line: 162 -- types: a3: boolean
    local v1
    local Invasion = a1.Invasion
    if a1.Phase == "Town" then
        v1 = false
        if typeof(Invasion) == "table" then
            v1 = false
            if Invasion.Phase ~= "Warmup" then
                v1 = Invasion.Phase ~= "Active"
            end
        end
    else
        v1 = false
        if a1.Phase == "Respawning" then
            v1 = false
            if typeof(Invasion) == "table" then
                v1 = false
                if Invasion.Phase ~= "Warmup" then
                    v1 = Invasion.Phase ~= "Active"
                end
            end
        end
    end
    if v1 and not a3 then
        return false, "", ""
    end
    local ReturnAt = if not v1 then a1.DepartureAt else a1.ReturnAt
    if type(ReturnAt) == "number" and ReturnAt == ReturnAt and math.abs(ReturnAt) ~= (1 / 0) then
        local v2 = math.max(0, (math.ceil(ReturnAt - a2)))
        local ArrivalOpen = false
        if v2 > 0 then
            ArrivalOpen = v1
            if not ArrivalOpen then
                ArrivalOpen = a1.ArrivalOpen
                if ArrivalOpen then
                    ArrivalOpen = true
                    if a1.Phase ~= "Home" then
                        ArrivalOpen = a1.Phase == "Boarded"
                    end
                end
            end
        end
        local v3 = ArrivalOpen
        local v4 = string.format("%s In: %d:%02d", if not v1 then "Boarding Closes" else "Returning", math.floor(v2 / 60), v2 % 60)
        if v1 then
            return v3, v4, "The Phantom Express is leaving!"
        end
        return v3, v4, "The Phantom Express has arrived!"
    end
    return false, "", ""
end

function u69.UpdateInvasion(a1) -- Line: 190 -- upvalues: u71 (ref)
    u71.Invasion = a1
end

function u69.HasArrivalBanner() -- Line: 193 -- upvalues: u75 (val)
    return #u75 > 0
end

local function refreshShop() -- Line: 196
    -- upvalues: u78 (ref), u71 (ref), u79 (ref), u80 (ref), u81 (ref), TrainEventFlags (val), u82 (ref), u77 (ref)
    -- upvalues: Tabs (val)
    if not u78 then
        return
    end
    local SoulShop = u71.SoulShop
    if not SoulShop then
        u79.Active = false
        return
    end
    u80.ItemName.Text = "Haunted Spirits (Souls)"
    u80.Quantity.RichText = true
    u80.Quantity.Text = string.format(
        "<font color=\"%s\">%d</font> / %d",
        if not (SoulShop.Cost <= SoulShop.Souls) then "#FF6B6B" else "#7CFF6B",
        SoulShop.Souls,
        SoulShop.Cost
    )
    u81.Quantity.Text = ("x1 · %*%%"):format((TrainEventFlags.SpectralSuccessPercent:Get()))
    u81:SetAttribute("OwnedCount", SoulShop.Count)
    u81.ItemName.Text = "Spectral Mutation"
    u82.Text = if SoulShop.Enabled then string.format("Trade %d Souls for 1 Spectral Mutation Consumable", SoulShop.Cost) else SoulShop.Reason or "Trading is temporarily unavailable."
    local AtShop = SoulShop.AtShop and SoulShop.CanTrade and not u77
    u79.Active = not u77
    u79:SetAttribute("Disabled", not AtShop)
    local v1 = if not u77 then "TRADE" else "TRADING..."
    u79.Title.Text = v1
    u79.ImageTransparency = if not AtShop then 0.4 else 0
    if Tabs.IsActive("SoulsTradeInMachine") then
        if u71.Phase ~= "Town" or not SoulShop.AtShop then
            Tabs.Deactivate()
        end
    end
end

local function fetch() -- Line: 228 -- upvalues: u73 (ref), TrainEvent (val), u69 (val), refreshShop (val)
    if u73 then
        return
    end
    u73 = true
    local success, err, v1 = pcall(function() -- Line: 233 -- upvalues: TrainEvent (upval)
        return TrainEvent.Action:InvokeServer("Status")
    end)
    if success and err and typeof(v1) == "table" then
        u69.Update(v1)
    end
    u73 = false
    refreshShop()
end

function u69.Start() -- Line: 242
    -- upvalues: u74 (ref), u78 (ref), GUI (val), u80 (ref), u81 (ref), u79 (ref), u82 (ref), ButtonFX (val), u77 (ref)
    -- upvalues: u71 (ref), notice (val), refreshShop (val), TrainEvent (val), fetch (val), u68 (val), u76 (val)
    -- upvalues: u75 (val), bindEventBannerStack (val), ProximityPromptService (val), Players (val), u69 (val)
    -- upvalues: Tabs (val), TrainEventFlags (val), PumpkinBossState (val), RunService (val), u72 (ref), Audio (val)
    -- upvalues: SoundService (val)
    local BottomRight, GhostInvasionTimer, TextButton, TrainNotification, WorldEventNotification, v1
    if u74 then
        return
    end
    u74 = true
    u78 = GUI.Get("SoulsTradeInMachine")
    local TradeUp = u78.Frame.Collection.TradeUp
    u80 = TradeUp.InputSlot.HauntedSpirit
    u81 = TradeUp.OutputSlot.MutationItem
    u79 = TradeUp.TradeButton
    u82 = u78.Frame.Collection.Hint
    ButtonFX(u79)
    GUI.OnActivated(u79, function() -- Line: 254
        -- upvalues: u77 (upval), u71 (upval), notice (upval), u79 (upval), refreshShop (upval), TrainEvent (upval)
        -- upvalues: fetch (upval), u68 (upval), u81 (upval)
        if u77 then
            return
        end
        if not u71.SoulShop then
            notice("Your data is still loading.", false)
            return
        end
        if u79:GetAttribute("Disabled") then
            notice(if u71.SoulShop.AtShop then u71.SoulShop.Reason or "Trade is unavailable." else "Get closer to the Soul Keeper.", false)
            return
        end
        u77 = true
        refreshShop()
        local success, err, v1 = pcall(function() -- Line: 273 -- upvalues: TrainEvent (upval), u71 (upval)
            return TrainEvent.Action:InvokeServer("TradeSouls", u71.SoulShop.Cost)
        end)
        u77 = false
        local v2 = notice
        local v3 = success and err == true
        v2(
            if not success then "Trade could not finish. Please try again." else if typeof(v1) ~= "string" then "Trade could not finish. Please try again." else v1,
            v3
        )
        fetch()
        if success and err == true then
            u68.Play(u81, "Spectral")
        end
    end)
    local HUD = GUI.Get("HUD")
    local v2 = {"GameHUD", "TradmilHud"}
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        v1 = HUD:FindFirstChild(j)
        TrainNotification = v1 and v1:FindFirstChild("TrainNotification")
        BottomRight = v1 and v1:FindFirstChild("BottomRight")
        GhostInvasionTimer = BottomRight and BottomRight:FindFirstChild("GhostInvasionTimer")
        if GhostInvasionTimer then
            GhostInvasionTimer.Visible = false
            table.insert(u76, GhostInvasionTimer)
        end
        if TrainNotification then
            table.insert(u75, TrainNotification)
            TrainNotification.Visible = false
            WorldEventNotification = v1:FindFirstChild("WorldEventNotification")
            if WorldEventNotification and WorldEventNotification:IsA("GuiObject") then
                bindEventBannerStack(TrainNotification, WorldEventNotification, v1)
            end
            TextButton = Instance.new("TextButton")
            TextButton.Name = "TrainStationAction"
            TextButton.Text = ""
            TextButton.BackgroundTransparency = 1
            TextButton.Size = UDim2.fromScale(1, 1)
            TextButton.ZIndex = 100
            TextButton.Parent = TrainNotification
            GUI.OnActivated(TextButton, function() -- Line: 312 -- upvalues: u77 (upval), u71 (upval), TrainEvent (upval), notice (upval)
                if not u77
                    and u71.StationAvailable == true
                    and u71.ArrivalOpen
                    and u71.Phase == "Home"
                    and not u71.AtStation then
                    u77 = true
                    local success, err, v1 = pcall(function() -- Line: 323 -- upvalues: TrainEvent (upval)
                        return TrainEvent.Action:InvokeServer("Station")
                    end)
                    u77 = false
                    if not success or not err then
                        notice(if typeof(v1) ~= "string" then "Station is unavailable." else v1, false)
                    end
                    return
                end
            end)
        end
    end
    ProximityPromptService.PromptTriggered:Connect(function(a1, a2) -- Line: 336
        -- upvalues: Players (upval), u77 (upval), TrainEvent (upval), u69 (upval), refreshShop (upval), Tabs (upval)
        -- upvalues: notice (upval)
        if a2 and a2 ~= Players.LocalPlayer then
            return
        end
        if a1:GetAttribute("TrainEventAction") == "OpenSoulShop" and not u77 then
            u77 = true
            local success, err, v1 = pcall(function() -- Line: 344 -- upvalues: TrainEvent (upval)
                return TrainEvent.Action:InvokeServer("OpenSoulShop")
            end)
            u77 = false
            if success and err and typeof(v1) == "table" then
                u69.Update(v1)
                refreshShop()
                if Tabs.IsActive("SoulsTradeInMachine") then
                    return
                end
                Tabs.Activate("SoulsTradeInMachine")
                return
            end
            notice(if typeof(v1) ~= "string" then "The Soul Keeper is unavailable." else v1, false)
            return
        end
    end)
    TrainEventFlags.SpectralSuccessPercent.Changed:Connect(refreshShop)
    Tabs.Activated:Connect(function(a1) -- Line: 362 -- upvalues: fetch (upval)
        if a1 == "SoulsTradeInMachine" then
            fetch()
        end
    end)
    local u62 = 0
    local u63 = 0
    local u64 = false
    local u65 = false
    local u66 = nil

    local function readArena() -- Line: 372 -- upvalues: u64 (ref), Players (upval), PumpkinBossState (upval)
        u64 = Players.LocalPlayer:GetAttribute(PumpkinBossState.MemberAttribute) == true
    end

    RunService.Heartbeat:Connect(function(a1) -- Line: 375
        -- upvalues: u69 (upval), u71 (upval), u76 (upval), Players (upval), u63 (ref), u65 (ref), u64 (ref)
        -- upvalues: PumpkinBossState (upval), u66 (ref), u75 (upval), u72 (upval), Audio (upval), SoundService (upval)
        -- upvalues: u62 (ref), refreshShop (upval), Tabs (upval), u77 (upval), fetch (upval)
        local v1, v2 = u69.InvasionTimer(u71, workspace:GetServerTimeNow())
        for i, j in u76 do
            j.Visible = v1
            j.Value.Text = v2
        end
        local Character = Players.LocalPlayer.Character
        local TrainBanner = u69.TrainBanner
        local ServerTimeNow = workspace:GetServerTimeNow()
        local v3 = false
        if Character ~= nil then
            v3 = Character:GetAttribute("TrainEventInForgottenTown") == true
        end
        local v4, v5, v6 = TrainBanner(u71, ServerTimeNow, v3)
        u63 = u63 + a1
        if not v4 then
            if u63 >= 0.5 then
                u63 = 0
                u64 = Players.LocalPlayer:GetAttribute(PumpkinBossState.MemberAttribute) == true
            end
        elseif not u65 or u63 >= 0.5 then
            u63 = 0
            u64 = Players.LocalPlayer:GetAttribute(PumpkinBossState.MemberAttribute) == true
        end
        u65 = v4
        v2 = v4 and not u64
        v1 = v2 ~= u66
        u66 = v2
        local v7 = nil
        local v8 = nil
        for k, n in u75, v7, v8 do
            if v1 then
                n.Visible = v2
            end
            n.TimerHolder.TimerLabel.Text = v5
            n.txt.Text = v6
        end
        if v4 and u71.ArrivalOpen and u71.Phase == "Home" and u71.DepartureAt ~= u72 then
            u72 = u71.DepartureAt
            task.delay(1.25, Audio.Play, 120773212780205, SoundService, {Volume = 0.55})
        end
        u62 = u62 + v9
        if u62 >= 1 then
            u62 = 0
            refreshShop()
            if Tabs.IsActive("SoulsTradeInMachine") and not u77 then
                task.spawn(fetch)
            end
        end
    end)
end

return u69