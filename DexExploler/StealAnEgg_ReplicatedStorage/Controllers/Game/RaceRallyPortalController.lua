-- Script path: ReplicatedStorage.Controllers.Game.RaceRallyPortalController
-- Decompile time: 10.68 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local RaceRallyFlags = require(ReplicatedStorage.Shared.Flags.RaceRallyFlags)
local Hud = require(ReplicatedStorage.Client.Hud)
local MountRace = require(ReplicatedStorage.Data.MountRace)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local RaceRally = require(ReplicatedStorage.Data.RaceRally)
local RaceRallyEligibility = require(ReplicatedStorage.Shared.Util.RaceRallyEligibility)
local RaceRallySchedule = require(ReplicatedStorage.Shared.Util.RaceRallySchedule)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u70 = Color3.fromRGB(255, 196, 0)
local Attributes = RaceRally.Attributes
local PlayerAttributes = RaceRally.PlayerAttributes

local function clock(a1) -- Line: 50 -- types: a1: number
    local v1 = math.max(math.ceil(a1), 0)
    return string.format("%d:%02d", v1 // 60, v1 % 60)
end

local function racedThisWindow(a1) -- Line: 55 -- upvalues: RaceRallyFlags (val), Workspace (val), Attributes (val)
    if not RaceRallyFlags.OneRacePerWindow:Get() then
        return false
    end
    local Attribute = Workspace:GetAttribute(Attributes.Window)
    if type(Attribute) ~= "number" then
        return false
    end
    local RaceRally = if a1 == nil then nil else a1.RaceRally
    return (if RaceRally == nil then nil else RaceRally.LastRacedWindow) == Attribute
end

return {
    Start = function() -- Line: 70
        -- upvalues: Workspace (val), Hud (val), Trove (val), Tabs (val), RaceRallyFlags (val), Attributes (val)
        -- upvalues: LocalPlayer (val), PlayerAttributes (val), MountRace (val), RaceRallySchedule (val), Save (val)
        -- upvalues: RaceRallyEligibility (val), RunService (val), Toast (val), u70 (val)
        local World = Workspace.World
        local RaceTimer = Hud.Every("RaceTimer")
        local RaceTimerValue = Hud.Every("RaceTimerValue")
        local v1 = Trove.new()
        local u13 = nil
        local u14 = ""
        local u15 = nil
        local u16 = nil
        local update = nil

        local function bind(a1) -- Line: 90
            -- upvalues: u13 (ref), Trove (upval), Tabs (upval), u14 (ref), u15 (ref), u16 (ref), update (ref)
            local v1
            local v2 = u13
            if v2 ~= nil then
                u13 = nil
                v2.Lifetime:Destroy()
            end
            local Hitbox = a1.Hitbox
            local Sign = Hitbox.SignAnchor.Sign
            local Title = Sign.Title
            local Prompt = Hitbox.PromptAnchor.Prompt
            local v3 = a1.Gate:QueryDescendants("ParticleEmitter")
            local v4 = {}
            local v5 = {}
            for i, j in a1:GetDescendants() do
                if j:IsA("BasePart") then
                    v1 = {
                        CanCollide = j.CanCollide,
                        CanQuery = j.CanQuery,
                        CanTouch = j.CanTouch,
                    }
                    v4[j] = v1
                elseif j:IsA("ParticleEmitter") or j:IsA("Beam") then
                    if table.find(v3, j) == nil then
                        v5[j] = j.Enabled
                    end
                elseif j:IsA("Light") and table.find(v3, j) == nil then
                    v5[j] = j.Enabled
                end
            end
            local v6 = {
                Model = a1,
                Hitbox = Hitbox,
                GateEffects = v3,
                Parts = v4,
                Effects = v5,
                Sign = Sign,
                Title = Title,
                TitleText = Title.Text,
                Prompt = Prompt,
                Status = Sign.Status,
                Lifetime = Trove.new(),
            }
            v6.Lifetime:Connect(Prompt.Triggered, function() -- Line: 129 -- upvalues: Tabs (upval)
                Tabs.Activate("RaceRally")
            end)
            u14 = ""
            u15 = nil
            u16 = nil
            u13 = v6
            update()
        end

        function update() -- Line: 140
            -- upvalues: Workspace (upval), RaceRallyFlags (upval), Attributes (upval), LocalPlayer (upval)
            -- upvalues: PlayerAttributes (upval), MountRace (upval), RaceRallySchedule (upval), Save (upval)
            -- upvalues: RaceRallyEligibility (upval), u13 (ref), u16 (ref), u14 (ref), u15 (ref), RaceTimer (val)
            -- upvalues: RaceTimerValue (val)
            local ServerTimeNow = Workspace:GetServerTimeNow()
            local v1 = RaceRallyFlags.ContentEnabled:Get()
            local Attribute = Workspace:GetAttribute(Attributes.JoinEndsAt)
            local Attribute_2 = Workspace:GetAttribute(Attributes.HeatJoinEndsAt)
            local v2 = Workspace:GetAttribute(Attributes.Running) == true
            local v3 = false
            if type(Attribute) == "number" then
                v3 = ServerTimeNow < Attribute
            end
            local v4 = false
            if type(Attribute_2) == "number" then
                v4 = ServerTimeNow < Attribute_2
            end
            local v5 = LocalPlayer:GetAttribute(PlayerAttributes.Queued) == true
            local v6 = LocalPlayer:GetAttribute(MountRace.PlayerAttributes.RaceId) ~= nil
            local v7 = RaceRallySchedule.NextOpening(ServerTimeNow)
            local v8 = Save.Peek()
            local v9 = false
            if v8 ~= nil then
                v9 = RaceRallyEligibility.IsEligible(v8.SpeedPower)
            end
            local v10 = v3
            if v10 then
                if RaceRallyFlags.OneRacePerWindow:Get() then
                    local Attribute_3 = Workspace:GetAttribute(Attributes.Window)
                    if type(Attribute_3) == "number" then
                        local RaceRally = if v8 == nil then nil else v8.RaceRally
                        v10 = (if RaceRally == nil then nil else RaceRally.LastRacedWindow) == Attribute_3
                    else
                        v10 = false
                    end
                else
                    v10 = false
                end
            end
            v8 = v1 and v9 and not v10
            local v11 = u13
            if v11 ~= nil then
                local v12, v13
                if v8 ~= u16 then
                    u16 = v8
                    local v14 = nil
                    v13 = nil
                    for i, j in v11.Parts, v14, v13 do
                        i.LocalTransparencyModifier = if not v8 then 1 else 0
                        i.CanCollide = v8 and j.CanCollide
                        i.CanQuery = v8 and j.CanQuery
                        i.CanTouch = v8 and j.CanTouch
                    end
                    for k, n in v11.Effects do
                        k.Enabled = v8 and n
                    end
                    v11.Sign.Enabled = v8
                    v11.Prompt.Enabled = v8
                end
                local TitleText = if not v4 then v11.TitleText else "A RACE IS STARTING"
                if v11.Title.Text ~= TitleText then
                    v11.Title.Text = TitleText
                end
                if v5 then
                    v12 = "IN LINE"
                elseif not v4 then
                    v12 = if not v3 then string.format("%d:%02d", 0, 0) else "OPEN"
                else
                    v13 = math.max(math.ceil(Attribute_2 - ServerTimeNow), 0)
                    v12 = string.format("%d:%02d", v13 // 60, v13 % 60)
                end
                if v12 ~= u14 then
                    u14 = v12
                    v11.Status.Text = v12
                end
                v12 = v3 and v8
                if v12 ~= u15 then
                    u15 = v12
                    for m, i5 in v11.GateEffects do
                        i5.Enabled = v12
                    end
                end
            end
            v11 = RaceRallySchedule.IsScheduled() and not v2 and v7 - ServerTimeNow <= RaceRallyFlags.TimerLeadSeconds:Get()
            v8 = v1 and v9 and not v6 and (v3 and not v10 or v11)
            if v5 then
                v11 = "You're in line for the next race!"
            elseif not v3 then
                v9 = math.max(math.ceil(v7 - ServerTimeNow), 0)
                v11 = ("Race in %*"):format((string.format("%d:%02d", v9 // 60, v9 % 60)))
            else
                v10 = math.max(math.ceil(Attribute - ServerTimeNow), 0)
                v11 = ("Race open! %*"):format((string.format("%d:%02d", v10 // 60, v10 % 60)))
            end
            for i6, i7 in RaceTimer do
                i7.Visible = v8
            end
            for i8, i9 in RaceTimerValue do
                if i9.Text ~= v11 then
                    i9.Text = v11
                end
            end
        end

        v1:Connect(World.ChildAdded, function(a1) -- Line: 213 -- upvalues: bind (val) -- types: a1: userdata
            if a1.Name == "RaceRallyPortal" and a1:IsA("Model") then
                bind(a1)
            end
        end)
        v1:Connect(World.ChildRemoved, function(a1) -- Line: 218 -- upvalues: u13 (ref) -- types: a1: userdata
            local v1 = u13
            if v1 ~= nil and a1 == v1.Model then
                local v2 = u13
                if v2 == nil then
                    return
                end
                u13 = nil
                v2.Lifetime:Destroy()
            end
        end)
        local RaceRallyPortal = World:FindFirstChild("RaceRallyPortal")
        if RaceRallyPortal ~= nil then
            bind(RaceRallyPortal)
        end
        local u38 = 0.2
        v1:Connect(RunService.Heartbeat, function(a1) -- Line: 230 -- upvalues: u38 (ref), update (ref) -- types: a1: number
            u38 = u38 + a1
            if u38 >= 0.2 then
                u38 = 0
                update()
            end
        end)
        local v2 = update
        v1:Connect(RaceRallyFlags.ContentEnabled.Changed, v2)
        v1:Add(function() -- Line: 81 -- upvalues: u13 (ref)
            local v1 = u13
            if v1 == nil then
                return
            end
            u13 = nil
            v1.Lifetime:Destroy()
        end)
        local u59 = nil
        v1:Add((Save.WatchFields("RaceRally", function() -- Line: 242 -- upvalues: Save (upval), u59 (ref), Toast (upval), u70 (upval)
            local RaceRally
            local v1 = Save.Peek()
            if (if v1 == nil then nil else v1.RaceRally) == nil then
                return
            end
            if u59 ~= nil then
                local Wins_2 = RaceRally.Wins
                if u59 < Wins_2 then
                    Toast.Show({
                        Seconds = 3,
                        SingleLine = true,
                        Text = ("1st place! Race wins: %*"):format(RaceRally.Wins),
                        Color = u70,
                    })
                end
            end
            u59 = RaceRally.Wins
        end)))
        v1:Add((task.spawn(function() -- Line: 259 -- upvalues: Save (upval), u59 (ref)
            local v1 = Save.Await()
            local RaceRally = if v1 == nil then nil else v1.RaceRally
            if RaceRally ~= nil and u59 == nil then
                u59 = RaceRally.Wins
            end
        end)))
        update()
        return v1
    end,
}