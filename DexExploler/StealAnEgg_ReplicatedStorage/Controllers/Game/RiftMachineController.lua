-- Script path: ReplicatedStorage.Controllers.Game.RiftMachineController
-- Decompile time: 14.00 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local RiftEligibility = require(ReplicatedStorage.Shared.Util.RiftEligibility)
local RiftFlags = require(ReplicatedStorage.Shared.Flags.RiftFlags)
local ScrambleTradeInEligibility = require(ReplicatedStorage.Shared.Util.ScrambleTradeInEligibility)
local ScrambleTradeInFlags = require(ReplicatedStorage.Shared.Flags.ScrambleTradeInFlags)
local ScrambleLeaveTimer = require(ReplicatedStorage.Shared.Util.ScrambleLeaveTimer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
return {
    Start = function() -- Line: 20
        -- upvalues: ReplicatedStorage (val), Players (val), Workspace (val), Trove (val), ScrambleTradeInFlags (val)
        -- upvalues: ScrambleLeaveTimer (val), Save (val), ScrambleTradeInEligibility (val), RiftEligibility (val)
        -- upvalues: TreadmillUtil (val), RiftFlags (val), Toast (val), Tabs (val)
        local RiftTradeIn = ReplicatedStorage.Assets.VFX.RiftTradeIn
        local u8 = Color3.fromRGB(196, 152, 255)
        local LocalPlayer = Players.LocalPlayer
        local Machines = Workspace:WaitForChild("World"):WaitForChild("Machines")
        local v1 = Trove.new()
        local u26 = Trove.new()
        v1:Add(u26)
        local u31 = nil
        local u32 = 0
        v1:Add(function() -- Line: 40 -- upvalues: u32 (ref)
            u32 = u32 + 1
        end)

        local function bindMachine(a1) -- Line: 42
            -- upvalues: u32 (ref), u26 (val), ScrambleTradeInFlags (upval), RiftTradeIn (val)
            -- upvalues: ScrambleLeaveTimer (upval), Save (upval), ScrambleTradeInEligibility (upval)
            -- upvalues: RiftEligibility (upval), LocalPlayer (val), TreadmillUtil (upval), Workspace (upval)
            -- upvalues: RiftFlags (upval), Toast (upval), u8 (val), Tabs (upval), Machines (val)
            local v1
            local u268 = u32
            local Rift = a1:WaitForChild("Rift")
            local ProximityPrompt = (a1:WaitForChild("Machine"):WaitForChild("Attachment")):WaitForChild("ProximityPrompt")
            local ObjectText = ProximityPrompt.ObjectText
            local BillboardGui = (a1:WaitForChild("Overhead")):WaitForChild("BillboardGui")
            local Timer = ((a1:WaitForChild("Overhead")):WaitForChild("TimerGui")):WaitForChild("Timer")
            local Shop = Timer:WaitForChild("Shop")
            local u280 = Color3.new(1, 1, 1)
            local u282 = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 52, 52)),
                ColorSequenceKeypoint.new(0.45, Color3.fromRGB(255, 30, 40)),
                (ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 170))),
            })
            local UIGradient = Shop:FindFirstChildOfClass("UIGradient")
            local StudsOffset = Timer.StudsOffset
            local Size = Timer.Size
            local TextColor3 = Shop.TextColor3
            local Color = if not UIGradient then nil else UIGradient.Color
            Timer.Enabled = false
            local u264 = {}
            local u293 = {}
            for i, j in Rift:GetDescendants() do
                if j:IsA("ParticleEmitter") or j:IsA("Beam") or j:IsA("Light") then
                    u264[j] = j.Enabled
                elseif j:IsA("BasePart") then
                    v1 = {
                        CanCollide = j.CanCollide,
                        CanQuery = j.CanQuery,
                        CanTouch = j.CanTouch,
                    }
                    u293[j] = v1
                end
            end
            local u101 = nil
            u26:Add(function() -- Line: 82
                -- upvalues: ProximityPrompt (val), BillboardGui (val), Timer (val), u101 (ref), u293 (val), u264 (val)
                ProximityPrompt.Enabled = false
                BillboardGui.Enabled = false
                Timer.Enabled = false
                if u101 then
                    u101:Destroy()
                end
                for i, j in u293 do
                    i.LocalTransparencyModifier = 0
                    i.CanCollide = j.CanCollide
                    i.CanQuery = j.CanQuery
                    i.CanTouch = j.CanTouch
                end
                for k, n in u264 do
                    k.Enabled = n
                end
            end)
            local u112 = nil
            local u113 = false
            local u114 = false
            local Shop_2 = BillboardGui:FindFirstChild("Shop")

            local function lockedVisual() -- Line: 102
                -- upvalues: ScrambleTradeInFlags (upval), u101 (ref), u114 (ref), RiftTradeIn (upval), Rift (val)
                local v1 = ScrambleTradeInFlags.Enabled:Get()
                local v2 = u101
                if v2 ~= nil then
                    if u114 == v1 then
                        return v2
                    end
                    v2:Destroy()
                end
                u114 = v1
                v1 = (if not v1 then RiftTradeIn.LockedPortal else RiftTradeIn.LockedLaboratory):Clone()
                local Attribute = v1:GetAttribute("RiftPivotOffset")
                assert(typeof(Attribute) == "CFrame", "LockedPortal needs a RiftPivotOffset CFrame attribute")
                v1.Name = "LockedPortal"
                v1:PivotTo((Rift:GetPivot()) * Attribute)
                u101 = v1
                return v1
            end

            local function laboratoryActive() -- Line: 122 -- upvalues: ScrambleTradeInFlags (upval)
                return ScrambleTradeInFlags.Enabled:Get()
            end

            local function resolveState() -- Line: 126
                -- upvalues: ScrambleLeaveTimer (upval), ScrambleTradeInFlags (upval), Save (upval)
                -- upvalues: ScrambleTradeInEligibility (upval), RiftEligibility (upval), LocalPlayer (upval)
                local v1
                if ScrambleLeaveTimer.IsExpired() then
                    return "Hidden"
                end
                if ScrambleTradeInFlags.Enabled:Get() then
                    v1 = Save.Await()
                    if v1 ~= nil and ScrambleTradeInEligibility.RequiredSpeedPower() ~= nil then
                        if ScrambleTradeInEligibility.IsEligible(v1.SpeedPower) then
                            return "Open"
                        end
                        if not RiftEligibility.IsEligible(v1.SpeedPower)
                            and v1.LastLogout == 0
                            and not RiftEligibility.HasSeenReveal(LocalPlayer) then
                            return "Hidden"
                        end
                        return "Locked"
                    end
                    return "Hidden"
                end
                if not RiftEligibility.IsFeatureLive() then
                    return "Hidden"
                end
                v1 = Save.Await()
                if v1 ~= nil and RiftEligibility.IsEligible(v1.SpeedPower) then
                    return "Open"
                end
                local SpeedPower = if v1 == nil then 0 else v1.SpeedPower
                local LastLogout = if v1 == nil then 0 else v1.LastLogout
                if RiftEligibility.IsRevealed(LocalPlayer, SpeedPower, LastLogout) then
                    return "Locked"
                end
                return "Hidden"
            end

            local function applyState(a1_2) -- Line: 158
                -- upvalues: ScrambleTradeInEligibility (upval), ScrambleTradeInFlags (upval), ProximityPrompt (val)
                -- upvalues: TreadmillUtil (upval), ObjectText (val), u112 (ref), u113 (ref), u293 (val), u264 (val)
                -- upvalues: BillboardGui (val), Shop_2 (val), lockedVisual (val), a1 (val), u101 (ref)
                local CanCollide, CanQuery, CanTouch
                local v1 = ScrambleTradeInEligibility.RequiredSpeedPower()
                local v2 = false
                if a1_2 == "Locked" then
                    v2 = ScrambleTradeInFlags.Enabled:Get() and v1 ~= nil
                end
                ProximityPrompt:SetAttribute("ObjectTextBelow", v2)
                ProximityPrompt.ObjectText = if not v2 then ObjectText else ("Unlocked at %* speed"):format((TreadmillUtil.FormatSpeedPower(v1)))
                if u112 == a1_2 and u113 == ScrambleTradeInFlags.Enabled:Get() then
                    return
                end
                u112 = a1_2
                u113 = ScrambleTradeInFlags.Enabled:Get()
                v2 = a1_2 == "Open"
                local v3 = nil
                local v4 = nil
                local v5 = a1_2
                for i, j in u293, v3, v4 do
                    i.LocalTransparencyModifier = if not v2 then 1 else 0
                    CanCollide = if not v2 then false else j.CanCollide
                    i.CanCollide = CanCollide
                    CanQuery = if not v2 then false else j.CanQuery
                    i.CanQuery = CanQuery
                    CanTouch = if not v2 then false else j.CanTouch
                    i.CanTouch = CanTouch
                end
                v3 = nil
                v4 = nil
                for k, n in u264, v3, v4 do
                    k.Enabled = if not v2 then false else n
                end
                BillboardGui.Enabled = v2
                if Shop_2 then
                    Shop_2.Text = if not u113 then "THE RIFT" else "DR. SCRAMBLE'S LABORATORY"
                end
                if v5 == "Locked" then
                    lockedVisual().Parent = a1
                elseif u101 ~= nil then
                    u101.Parent = nil
                end
                ProximityPrompt.ActionText = if v5 ~= "Locked" then if not u113 then "The Rift" else "Dr. Scramble's Laboratory" else "Locked"
                ProximityPrompt.Enabled = v5 ~= "Hidden"
            end

            local function paintTimer(a1) -- Line: 196
                -- upvalues: Timer (val), BillboardGui (val), Size (val), Shop (val), u280 (val), UIGradient (val)
                -- upvalues: u282 (val), StudsOffset (val), TextColor3 (val), Color (val)
                if a1 then
                    Timer.StudsOffset = BillboardGui.StudsOffset + Vector3.new(0, 1.7999999523162842, 0)
                    Timer.Size = UDim2.new(Size.X.Scale * 0.75, Size.X.Offset * 0.75, Size.Y.Scale * 0.75, Size.Y.Offset * 0.75)
                    Shop.TextColor3 = u280
                    if UIGradient then
                        UIGradient.Color = u282
                    end
                    return
                end
                Timer.StudsOffset = StudsOffset
                Timer.Size = Size
                Shop.TextColor3 = TextColor3
                if UIGradient and Color then
                    UIGradient.Color = Color
                end
            end

            local function refreshTimer() -- Line: 219
                -- upvalues: ScrambleTradeInFlags (upval), Timer (val), BillboardGui (val), Size (val), Shop (val)
                -- upvalues: u280 (val), UIGradient (val), u282 (val), ScrambleLeaveTimer (upval), u112 (ref)
                -- upvalues: StudsOffset (val), TextColor3 (val), Color (val), Workspace (upval)
                local v1, v2
                if ScrambleTradeInFlags.Enabled:Get() then
                    Timer.StudsOffset = BillboardGui.StudsOffset + Vector3.new(0, 1.7999999523162842, 0)
                    Timer.Size = UDim2.new(Size.X.Scale * 0.75, Size.X.Offset * 0.75, Size.Y.Scale * 0.75, Size.Y.Offset * 0.75)
                    Shop.TextColor3 = u280
                    if UIGradient then
                        UIGradient.Color = u282
                    end
                    v1 = ScrambleLeaveTimer.SecondsLeft()
                    v2 = false
                    if u112 == "Open" then
                        v2 = v1 > 0
                    end
                    Timer.Enabled = v2
                    Shop.Text = ScrambleLeaveTimer.Text(v1)
                    return 1
                end
                Timer.StudsOffset = StudsOffset
                Timer.Size = Size
                Shop.TextColor3 = TextColor3
                if UIGradient and Color then
                    UIGradient.Color = Color
                end
                v1 = 1790434800 - Workspace:GetServerTimeNow()
                local v3 = false
                if u112 == "Open" then
                    v3 = v1 > 0
                end
                Timer.Enabled = v3
                if v3 then
                    v2 = math.ceil(v1)
                    local v4 = math.floor(v2 / 86400)
                    local v5 = math.floor(v2 % 86400 / 3600)
                    local v6 = math.floor(v2 % 3600 / 60)
                    if v4 > 0 then
                        Shop.Text = string.format("%s%dd %dh", "Animals Leaving In: ", v4, v5)
                        return v1
                    end
                    if v5 > 0 then
                        Shop.Text = string.format("%s%dh %dm", "Animals Leaving In: ", v5, v6)
                        return v1
                    end
                    Shop.Text = string.format("%s%dm %ds", "Animals Leaving In: ", v6, v2 % 60)
                end
                return v1
            end

            local function refresh() -- Line: 248 -- upvalues: applyState (val), resolveState (val), refreshTimer (val)
                applyState((resolveState()))
                refreshTimer()
            end

            ProximityPrompt.ActionText = "The Rift"
            u26:Connect(ProximityPrompt.Triggered, function() -- Line: 254
                -- upvalues: ScrambleLeaveTimer (upval), u112 (ref), applyState (val), resolveState (val)
                -- upvalues: refreshTimer (val), ScrambleTradeInFlags (upval), ScrambleTradeInEligibility (upval)
                -- upvalues: RiftFlags (upval), Toast (upval), TreadmillUtil (upval), u8 (upval), Tabs (upval)
                if not ScrambleLeaveTimer.IsExpired() and u112 ~= "Hidden" then
                    if u112 ~= "Locked" then
                        Tabs.Activate(if not ScrambleTradeInFlags.Enabled:Get() then "RiftTradeIn" else "DrScrambleTradeIn")
                        return
                    end
                    local v1 = if not ScrambleTradeInFlags.Enabled:Get() then RiftFlags.SpeedPowerRequirement:Get() else ScrambleTradeInEligibility.RequiredSpeedPower()
                    if v1 ~= nil then
                        Toast.Show({
                            Seconds = 3,
                            Text = ("You need %* Speed to use this!"):format((TreadmillUtil.FormatSpeedPower(v1))),
                            Color = if not ScrambleTradeInFlags.Enabled:Get() then u8 else Color3.fromRGB(81, 226, 36),
                        })
                        return
                    end
                    applyState((resolveState()))
                    refreshTimer()
                    return
                end
                applyState((resolveState()))
                refreshTimer()
            end)
            applyState("Hidden")
            Save.Await()
            if not a1:IsDescendantOf(Machines) then
                return
            end
            applyState((resolveState()))
            refreshTimer()
            u26:Add((Save.WatchFields("SpeedPower", refresh)))
            u26:Connect(RiftFlags.SpeedPowerRequirement.Changed, refresh)
            u26:Connect(RiftFlags.Retired.Changed, refresh)
            u26:Connect(ScrambleTradeInEligibility.Changed, refresh)
            u26:Connect(ScrambleTradeInFlags.Enabled.Changed, refresh)
            u26:Connect(ScrambleTradeInFlags.SpeedPowerRequirement.Changed, refresh)
            u26:Connect(ScrambleTradeInFlags.LeavesAtUnix.Changed, refresh)
            u26:Connect(Workspace:GetAttributeChangedSignal(RiftEligibility.OpenAttribute), refresh)
            u26:Connect(LocalPlayer:GetAttributeChangedSignal(RiftEligibility.CutsceneSeenAttribute), refresh)
            task.spawn(function() -- Line: 291
                -- upvalues: u32 (upval), u268 (val), a1 (val), Machines (upval), applyState (val), resolveState (val)
                -- upvalues: refreshTimer (val)
                local v1
                while u32 == u268 do
                    if not a1:IsDescendantOf(Machines) then
                        break
                    end
                    applyState((resolveState()))
                    v1 = refreshTimer()
                    if v1 <= 0 then
                        break
                    end
                    task.wait((math.min(1, v1)))
                end
            end)
        end

        local function refreshMachine() -- Line: 304
            -- upvalues: Machines (val), u31 (ref), u32 (ref), u26 (val), bindMachine (val)
            local RiftMachine = Machines:FindFirstChild("RiftMachine")
            if RiftMachine == u31 then
                return
            end
            u32 = u32 + 1
            u26:Clean()
            u31 = RiftMachine
            if RiftMachine then
                bindMachine(RiftMachine)
            end
        end

        v1:Connect(Machines.ChildAdded, refreshMachine)
        v1:Connect(Machines.ChildRemoved, refreshMachine)
        local RiftMachine = Machines:FindFirstChild("RiftMachine")
        if RiftMachine ~= u31 then
            u32 = u32 + 1
            u26:Clean()
            if RiftMachine then
                bindMachine(RiftMachine)
            end
        end
        return v1
    end,
}