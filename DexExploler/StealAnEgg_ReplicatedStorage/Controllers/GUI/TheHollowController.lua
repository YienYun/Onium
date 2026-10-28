-- Script path: ReplicatedStorage.Controllers.GUI.TheHollowController
-- Decompile time: 11.17 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local BadgeReveal = require(script.BadgeReveal)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local TheHollowFlags = require(ReplicatedStorage.Shared.Flags.TheHollowFlags)
local GUI = require(ReplicatedStorage.Client.GUI)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local Hud = require(ReplicatedStorage.Client.Hud)
local MountRace = require(ReplicatedStorage.Data.MountRace)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local RaceRallyRewards = require(ReplicatedStorage.Shared.Modules.RaceRallyRewards)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local TheHollow = require(ReplicatedStorage.Data.TheHollow)
local TheHollow_2 = require(ReplicatedStorage.Shared.Types.TheHollow)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u93 = Color3.fromRGB(255, 80, 80)
local u98 = Color3.fromRGB(255, 196, 0)
local Inside = HalloweenDimension.PlayerAttributes.Inside

local function clock(a1) -- Line: 42 -- types: a1: number
    local v1 = math.max(math.ceil(a1), 0)
    return string.format("%d:%02d", v1 // 60, v1 % 60)
end

local function winsLabel(a1) -- Line: 47 -- types: a1: number
    if a1 == 1 then
        return "1 Win"
    end
    return (("%* Wins"):format(a1))
end

local function savedState() -- Line: 51 -- upvalues: Save (val), TheHollow_2 (val)
    local v1 = Save.Peek()
    local TheHollow = if v1 == nil then nil else v1.TheHollow
    if TheHollow ~= nil then
        return TheHollow
    end
    return (TheHollow_2.Blank())
end

local function quantityText(a1) -- Line: 58
    if a1.Multiplier ~= nil then
        return (("%* %*"):format(a1.Multiplier, a1.Amount))
    end
    return a1.Amount
end

return {
    Start = function() -- Line: 66
        -- upvalues: GUI (val), TheHollow (val), Hud (val), Trove (val), Save (val), TheHollow_2 (val)
        -- upvalues: RaceRallyRewards (val), TheHollowFlags (val), Remotes (val), Tabs (val), Toast (val), u93 (val)
        -- upvalues: ButtonFX (val), Workspace (val), LocalPlayer (val), MountRace (val), Inside (val), RunService (val)
        -- upvalues: u98 (val), BadgeReveal (val)
        local v1, v2
        local Main = GUI.TheHollow().Main
        local Content = Main.Content
        local ProgressBar = Content.ProgressBar
        local Bar = ProgressBar.Bar
        local CompletedCheckmark = Content.Badge.CompletedCheckmark
        local TeleportToRace = Main.TeleportToRace
        local v3 = TheHollow.OrderedPrizes()
        local u14 = {}
        for i, j in v3 do
            v1 = ProgressBar[("Prize%*"):format(i)]
            v2 = {
                Id = j.Id,
                Prize = j.Config,
                Label = v1.RequirementLabel,
                Check = v1.CompletedCheckmark,
                Icon = v1.Icon,
                Quantity = v1.QuantityLabel,
            }
            u14[i] = v2
        end
        assert(ProgressBar:FindFirstChild((("Prize%*"):format(#v3 + 1))) == nil, "The Hollow UI has more prize cards than prizes")
        local u42 = {
            ProgressBar.MilestoneLine.Position.X.Scale,
            ProgressBar.MilestoneLine2.Position.X.Scale,
            ProgressBar.MilestoneLine3.Position.X.Scale,
            ProgressBar.MilestoneLine4.Position.X.Scale,
        }
        local Id = v3[#v3].Id
        local u68 = Hud.Every("TheHollowButton")
        local v4 = Trove.new()
        local u72 = false
        local u73 = true

        local function refresh() -- Line: 101
            -- upvalues: Save (upval), TheHollow_2 (upval), u14 (val), RaceRallyRewards (upval), TheHollowFlags (upval)
            -- upvalues: CompletedCheckmark (val), u73 (ref), Id (val), u42 (val), Bar (val)
            local Amount_2, Label, Quantity, Wins_2, Wins_3, v1, v2
            local v3 = Save.Peek()
            local TheHollow = if v3 == nil then nil else v3.TheHollow
            local v4 = if TheHollow == nil then TheHollow_2.Blank() else TheHollow
            v3 = 0
            local v5 = nil
            local v6 = nil
            for i, j in u14, v5, v6 do
                v2 = RaceRallyRewards.Present(j.Prize.Rewards[1])
                Label = j.Label
                Wins_2 = j.Prize.Wins
                Label.Text = if Wins_2 ~= 1 then ("%* Wins"):format(Wins_2) else "1 Win"
                j.Icon.Image = v2.Icon
                Quantity = j.Quantity
                Amount_2 = if v2.Multiplier == nil then v2.Amount else ("%* %*"):format(v2.Multiplier, v2.Amount)
                Quantity.Text = Amount_2
                j.Check.Visible = v4.Claimed[j.Id] == true
                Wins_3 = v4.Wins
                if j.Prize.Wins <= Wins_3 then
                    v3 = i
                end
            end
            CompletedCheckmark.Visible = TheHollowFlags.WinsForBadge:Get() <= v4.Wins
            v5 = true
            if Save.Peek() ~= nil then
                v5 = v1 or v4.Claimed[Id] == true
            end
            u73 = v5
            Bar.Size = UDim2.new(if not v1 then if not (v3 > 0) then 0 else u42[v3] else u42[#u42], 0, Bar.Size.Y.Scale, Bar.Size.Y.Offset)
        end

        v4:Add((ButtonFX(TeleportToRace, 1.06, function() -- Line: 121 -- upvalues: u72 (ref), Remotes (upval), Tabs (upval), Toast (upval), u93 (upval)
            if u72 then
                return
            end
            u72 = true
            local success, err, v1 = pcall(function() -- Line: 126 -- upvalues: Remotes (upval)
                return Remotes.TheHollow.AskEnter:InvokeServer()
            end)
            u72 = false
            if success and err then
                Tabs.Deactivate()
                return
            end
            if not success then
                Toast.Show({
                    Text = "Something went wrong, please try again.",
                    Seconds = 2.5,
                    SingleLine = true,
                    Color = u93,
                })
                return
            end
            if v1 ~= nil then
                Toast.Show({Seconds = 2.5, SingleLine = true, Text = v1, Color = u93})
            end
        end)))

        local function syncHud() -- Line: 141
            -- upvalues: TheHollowFlags (upval), Workspace (upval), LocalPlayer (upval), MountRace (upval), u73 (ref)
            -- upvalues: Inside (upval), Tabs (upval), u68 (val)
            local v1
            local v2 = TheHollowFlags.ContentEnabled:Get()
            local Attribute = Workspace:GetAttribute("TheHollowJoinEndsAt")
            local v3 = if type(Attribute) ~= "number" then 0 else Attribute - Workspace:GetServerTimeNow()
            local v4 = v2
            if v4 then
                v4 = false
                if v3 > 0 then
                    v4 = LocalPlayer:GetAttribute(MountRace.PlayerAttributes.RaceId) == nil
                end
            end
            local v5 = v2 and not (u73 and TheHollowFlags.HideBadgeAfterGrandPrize:Get()) and LocalPlayer:GetAttribute(Inside) ~= true
            if v2 and not v5 and Tabs.IsActive("TheHollow") then
                Tabs.Deactivate()
            end
            local v6 = nil
            local v7 = nil
            for i, j in u68, v6, v7 do
                j.Visible = v5
                v2 = j:FindFirstChild("Badge")
                if v2 ~= nil then
                    v2.Visible = v4 and not (u73 and TheHollowFlags.HideBadgeAfterGrandPrize:Get())
                end
                v2 = j:FindFirstChild("RemovalTimer")
                if v2 ~= nil then
                    v2.Visible = v4
                    if v4 then
                        v1 = math.max(math.ceil(v3), 0)
                        v2.Text = string.format("%d:%02d", v1 // 60, v1 % 60)
                    end
                end
            end
        end

        for k, n in u68 do
            v4:Add((ButtonFX(n, 1.08, function() -- Line: 169 -- upvalues: Tabs (upval)
                Tabs.Toggle("TheHollow")
            end)))
        end
        v4:Add((TheHollowFlags.ContentEnabled.Changed:Connect(function() -- Line: 173 -- upvalues: syncHud (val), TheHollowFlags (upval), Tabs (upval)
            syncHud()
            if not TheHollowFlags.ContentEnabled:Get() and Tabs.IsActive("TheHollow") then
                Tabs.Deactivate({instant = true})
            end
        end)))
        local u115 = 0.2
        v4:Connect(RunService.Heartbeat, function(a1) -- Line: 180 -- upvalues: u115 (ref), syncHud (val) -- types: a1: number
            u115 = u115 + a1
            if u115 >= 0.2 then
                u115 = 0
                syncHud()
            end
        end)
        local u122 = nil

        local function toast(a1) -- Line: 190 -- upvalues: Toast (upval), u98 (upval) -- types: a1: string
            Toast.Show({Seconds = 3, SingleLine = true, Text = a1, Color = u98})
        end

        local function badgePrize(a1) -- Line: 194 -- upvalues: u14 (val), RaceRallyRewards (upval) -- types: a1: number
            local v1
            for i, j in u14 do
                if j.Prize.Wins == a1 then
                    v1 = RaceRallyRewards.Present(j.Prize.Rewards[1])
                    return {
                        Text = ("Grand prize: %* (%*)"):format(v1.Title, v1.Amount),
                        Icon = v1.Icon,
                    }
                end
            end
            return {Text = "You earned The Hollow badge!"}
        end

        v4:Add((Save.WatchFields("TheHollow", function() -- Line: 207
            -- upvalues: Save (upval), TheHollow_2 (upval), u122 (ref), TheHollowFlags (upval), BadgeReveal (upval)
            -- upvalues: badgePrize (val), Toast (upval), u98 (upval), u14 (val), RaceRallyRewards (upval)
            -- upvalues: refresh (val)
            local v1 = Save.Peek()
            local TheHollow = if v1 == nil then nil else v1.TheHollow
            local v2 = if TheHollow == nil then TheHollow_2.Blank() else TheHollow
            v1 = u122
            if v1 ~= nil then
                local v3, v4, v5
                local v6 = TheHollowFlags.WinsForBadge:Get()
                local v7 = TheHollowFlags.BadgeReveal:Get()
                if v1.Wins < v2.Wins then
                    if v2.Wins ~= v6 or not v7 then
                        local v8 = if v2.Wins ~= v6 then ("Hollow race won! %*/%* wins"):format(math.min(v2.Wins, v6), v6) else "Grand prize unlocked! You earned The Hollow badge!"
                        Toast.Show({Seconds = 3, SingleLine = true, Text = v8, Color = u98})
                    else
                        BadgeReveal.Show((badgePrize(v6)))
                    end
                end
                local v9 = nil
                local v10 = nil
                for i, j in u14, v9, v10 do
                    v5 = v7
                    if v5 then
                        v5 = false
                        if j.Prize.Wins == v6 then
                            v5 = v6 <= v2.Wins
                        end
                    end
                    if v2.Claimed[j.Id] and not v1.Claimed[j.Id] and not v5 then
                        v3 = RaceRallyRewards.Present(j.Prize.Rewards[1])
                        v4 = ("Prize unlocked: %* (%*)!"):format(v3.Title, v3.Amount)
                        Toast.Show({Seconds = 3, SingleLine = true, Text = v4, Color = u98})
                    end
                end
            end
            u122 = v2
            refresh()
        end)))
        v4:Add((Tabs.Activated:Connect(function(a1) -- Line: 237 -- upvalues: refresh (val) -- types: a1: string
            if a1 == "TheHollow" then
                refresh()
            end
        end)))
        v4:Add((task.spawn(function() -- Line: 243 -- upvalues: Save (upval), u122 (ref), TheHollow_2 (upval), refresh (val)
            Save.Await()
            if u122 == nil then
                local v1 = Save.Peek()
                local TheHollow = if v1 == nil then nil else v1.TheHollow
                u122 = if TheHollow == nil then TheHollow_2.Blank() else TheHollow
            end
            refresh()
        end)))
        syncHud()
        refresh()
        return v4
    end,
}