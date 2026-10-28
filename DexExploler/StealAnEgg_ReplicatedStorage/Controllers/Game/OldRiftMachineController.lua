-- Script path: ReplicatedStorage.Controllers.Game.OldRiftMachineController
-- Decompile time: 7.31 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RiftMachineSchedule = require(ReplicatedStorage.Shared.Util.RiftMachineSchedule)
return {
    Start = function() -- Line: 10 -- upvalues: RiftMachineSchedule (val), ReplicatedStorage (val), Players (val), Workspace (val)
        local v1
        if RiftMachineSchedule.IsLaboratoryTime() then
            return
        end
        local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
        local RiftEligibility = require(ReplicatedStorage.Shared.Util.RiftEligibility)
        local RiftFlags = require(ReplicatedStorage.Shared.Flags.RiftFlags)
        local Save = require(ReplicatedStorage.Shared.Save)
        local Tabs = require(ReplicatedStorage.Client.Tabs)
        local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
        local LocalPlayer = Players.LocalPlayer
        local OldRiftMachine = (Workspace:WaitForChild("World")):WaitForChild("Machines"):WaitForChild("OldRiftMachine", 5)
        if OldRiftMachine == nil then
            return
        end
        local u234 = OldRiftMachine:WaitForChild("Rift")
        local ProximityPrompt = ((OldRiftMachine:WaitForChild("Machine")):WaitForChild("Attachment")):WaitForChild("ProximityPrompt")
        local BillboardGui = (OldRiftMachine:WaitForChild("Overhead")):WaitForChild("BillboardGui")
        local Timer = (OldRiftMachine.Overhead:WaitForChild("TimerGui")):WaitForChild("Timer")
        local Shop = Timer:WaitForChild("Shop")
        Timer.Enabled = false
        local u240 = {}
        local u226 = {}
        for i, j in u234:GetDescendants() do
            if j:IsA("BasePart") then
                v1 = {Collide = j.CanCollide, Query = j.CanQuery, Touch = j.CanTouch}
                u240[j] = v1
            elseif j:IsA("ParticleEmitter") or j:IsA("Beam") or j:IsA("Light") then
                u226[j] = j.Enabled
            end
        end
        local u106 = nil
        local u107 = nil
        local u108 = {}
        local u109 = true

        local function resolveState() -- Line: 54 -- upvalues: RiftEligibility (val), Save (val), LocalPlayer (val)
            if not RiftEligibility.IsFeatureLive() then
                return "Hidden"
            end
            local v1 = Save.Await()
            if v1 ~= nil and RiftEligibility.IsEligible(v1.SpeedPower) then
                return "Open"
            end
            if RiftEligibility.IsRevealed(LocalPlayer, if v1 == nil then 0 else v1.SpeedPower, if v1 == nil then 0 else v1.LastLogout) then
                return "Locked"
            end
            return "Hidden"
        end

        local function applyState(a1) -- Line: 70
            -- upvalues: u107 (ref), u240 (val), u226 (val), BillboardGui (val), u106 (ref), ReplicatedStorage (upval)
            -- upvalues: u234 (val), OldRiftMachine (val), ProximityPrompt (val)
            local Collide, Query, Touch
            if u107 == a1 then
                return
            end
            u107 = a1
            local v1 = a1 == "Open"
            local v2 = nil
            local v3 = nil
            local v4 = a1
            for i, j in u240, v2, v3 do
                i.LocalTransparencyModifier = if not v1 then 1 else 0
                Collide = if not v1 then false else j.Collide
                i.CanCollide = Collide
                Query = if not v1 then false else j.Query
                i.CanQuery = Query
                Touch = if not v1 then false else j.Touch
                i.CanTouch = Touch
            end
            v2 = nil
            v3 = nil
            for k, n in u226, v2, v3 do
                k.Enabled = if not v1 then false else n
            end
            BillboardGui.Enabled = v1
            local Shop = BillboardGui:FindFirstChild("Shop")
            if Shop and Shop:IsA("TextLabel") then
                Shop.Text = "THE RIFT"
            end
            if v4 == "Locked" then
                if u106 == nil then
                    v1 = ReplicatedStorage.Assets.VFX.RiftTradeIn.LockedPortal:Clone()
                    local Attribute = v1:GetAttribute("RiftPivotOffset")
                    assert(typeof(Attribute) == "CFrame", "LockedPortal needs RiftPivotOffset")
                    v1.Name = "LockedPortal"
                    v1:PivotTo((u234:GetPivot()) * Attribute)
                    u106 = v1
                end
                u106.Parent = OldRiftMachine
            elseif u106 ~= nil then
                u106.Parent = nil
            end
            ProximityPrompt.ActionText = if v4 ~= "Locked" then "The Rift" else "Locked"
            ProximityPrompt.Enabled = v4 ~= "Hidden"
        end

        local function refreshTimer() -- Line: 107
            -- upvalues: RiftMachineSchedule (upval), Workspace (upval), u107 (ref), RiftEligibility (val), Timer (val)
            -- upvalues: Shop (val)
            local v1 = RiftMachineSchedule.GetSwapAt() - Workspace:GetServerTimeNow()
            local v2 = false
            if u107 == "Open" then
                v2 = RiftEligibility.IsFeatureLive() and v1 > 0
            end
            Timer.Enabled = v2
            if v2 then
                local v3 = math.ceil(v1)
                local v4 = math.floor(v3 / 86400)
                local v5 = math.floor(v3 % 86400 / 3600)
                local v6 = math.floor(v3 % 3600 / 60)
                if v4 > 0 then
                    Shop.Text = string.format("Animals Leaving In: %dd %dh", v4, v5)
                    return v1
                end
                if v5 > 0 then
                    Shop.Text = string.format("Animals Leaving In: %dh %dm", v5, v6)
                    return v1
                end
                Shop.Text = string.format("Animals Leaving In: %dm %ds", v6, v3 % 60)
            end
            return v1
        end

        local function refresh() -- Line: 128
            -- upvalues: u109 (ref), OldRiftMachine (val), applyState (val), resolveState (val), refreshTimer (val)
            if u109 and OldRiftMachine.Parent ~= nil then
                applyState((resolveState()))
                refreshTimer()
                return
            end
        end

        table.insert(u108, (ProximityPrompt.Triggered:Connect(function() -- Line: 136
            -- upvalues: u109 (ref), OldRiftMachine (val), u107 (ref), Toast (val), TreadmillUtil (val), RiftFlags (val)
            -- upvalues: RiftEligibility (val), Tabs (val)
            if u109 and OldRiftMachine.Parent ~= nil then
                if u107 == "Locked" then
                    Toast.Show({
                        Seconds = 3,
                        Text = "You need " .. (TreadmillUtil.FormatSpeedPower(RiftFlags.SpeedPowerRequirement:Get())) .. " Speed to use this!",
                        Color = Color3.fromRGB(196, 152, 255),
                    })
                    return
                end
                if u107 == "Open" and RiftEligibility.IsFeatureLive() then
                    Tabs.Activate("RiftTradeIn")
                end
                return
            end
        end)))

        local function watch(a1) -- Line: 153 -- upvalues: u108 (val), refresh (val) -- types: a1: userdata
            table.insert(u108, (a1:Connect(refresh)))
        end

        local u141 = Save.WatchFields("SpeedPower", refresh)
        table.insert(u108, (RiftFlags.SpeedPowerRequirement.Changed:Connect(refresh)))
        table.insert(u108, (RiftFlags.Retired.Changed:Connect(refresh)))
        table.insert(u108, ((Workspace:GetAttributeChangedSignal(RiftEligibility.OpenAttribute)):Connect(refresh)))
        table.insert(u108, ((LocalPlayer:GetAttributeChangedSignal(RiftEligibility.CutsceneSeenAttribute)):Connect(refresh)))
        table.insert(u108, (OldRiftMachine.AncestryChanged:Connect(function() -- Line: 161 -- upvalues: OldRiftMachine (val), u109 (ref), Timer (val), u141 (val), u108 (val)
            if OldRiftMachine.Parent ~= nil then
                return
            end
            u109 = false
            Timer.Enabled = false
            u141:Clean()
            for i, j in u108 do
                j:Disconnect()
            end
        end)))
        if u109 and OldRiftMachine.Parent ~= nil then
            applyState((resolveState()))
            refreshTimer()
        end
        task.spawn(function() -- Line: 174 -- upvalues: u109 (ref), OldRiftMachine (val), refreshTimer (val)
            local v1
            while u109 do
                if OldRiftMachine.Parent == nil then
                    break
                end
                v1 = refreshTimer()
                if v1 <= 0 then
                    break
                end
                task.wait((math.min(1, v1)))
            end
        end)
    end,
}