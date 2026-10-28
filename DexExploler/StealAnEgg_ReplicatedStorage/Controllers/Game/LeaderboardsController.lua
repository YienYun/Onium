-- Script path: ReplicatedStorage.Controllers.Game.LeaderboardsController
-- Decompile time: 9.47 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Leaderboards = require(ReplicatedStorage.Shared.Types.Leaderboards)
local Log = require(ReplicatedStorage.Packages.Log)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u42 = Log.new()
local LocalPlayer = Players.LocalPlayer
return {
    Start = function() -- Line: 40
        -- upvalues: LocalPlayer (val), ReplicatedStorage (val), u42 (val), Trove (val), Player (val), Remotes (val)
        -- upvalues: Leaderboards (val), CollectionService (val), RunService (val)
        local requestLeaderboards
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        local Leaderboards_2 = ReplicatedStorage.Assets.UI.Leaderboards
        local u9 = {}
        local u10 = {}
        local u11 = 0

        local function getLeaderboardPart(a1) -- Line: 48 -- types: a1: userdata
            local Adornee = a1.Adornee
            if Adornee and Adornee:IsA("BasePart") then
                return Adornee
            end
            local Parent = a1.Parent
            if Parent and Parent:IsA("BasePart") then
                return Parent
            end
            return nil
        end

        local function getRowTemplate(a1) -- Line: 62 -- upvalues: Leaderboards_2 (val) -- types: a1: string
            local v1 = Leaderboards_2:FindFirstChild(a1)
            if v1 ~= nil and v1:IsA("Frame") then
                return v1
            end
            return nil
        end

        local function getHeadshotUrl(a1) -- Line: 71 -- types: a1: number
            return (("rbxthumb://type=AvatarHeadShot&id=%*&w=48&h=48"):format(a1))
        end

        local function createRow(a1, a2) -- Line: 75 -- types: a1: table
            local v1 = a1.Template:Clone()
            v1.Name = ("Player_%*"):format(a2.UserId)
            v1.Holder_Thumbnail.ImageLabel_PlayerThumb.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=48&h=48"):format(a2.UserId)
            v1.Parent = a1.Container
            a1.Rows[a2.UserId] = v1
            return v1
        end

        local function renderLeaderboard(a1, a2) -- Line: 85 -- types: a1: table
            local v1
            local v2 = {}
            local v3 = nil
            local v4 = nil
            local v5 = a1
            for i, j in a2, v3, v4 do
                v1 = v5.Rows[j.UserId]
                if not v1 then
                    v1 = v5.Template:Clone()
                    v1.Name = ("Player_%*"):format(j.UserId)
                    v1.Holder_Thumbnail.ImageLabel_PlayerThumb.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=48&h=48"):format(j.UserId)
                    v1.Parent = v5.Container
                    v5.Rows[j.UserId] = v1
                end
                v1.LayoutOrder = i
                v1.Holder_PlayerName.Display.TextLabel_PlayerName.Text = j.Name
                v1.Holder_Value.Holder.TextLabel_Value.Text = j.ValueText
                v2[j.UserId] = true
            end
            for k, n in v5.Rows do
                if not v2[k] then
                    v5.Rows[k] = nil
                    n:Destroy()
                end
            end
        end

        local function updateLeaderboard(a1, a2) -- Line: 109
            -- upvalues: u9 (val)
            local v1 = u9[a1]
            if not v1 then
                return
            end
            local v2 = true
            local MaxDistance = v1.Gui.MaxDistance
            if not a2 then
                v2 = false
            elseif MaxDistance > 0 then
                v2 = (a2.Position - v1.Part.Position).Magnitude <= MaxDistance
            end
            if v1.Gui.Enabled ~= v2 then
                v1.Gui.Enabled = v2
            end
        end

        local function cleanupLeaderboard(a1) -- Line: 130 -- upvalues: u9 (val) -- types: a1: userdata
            local v1 = u9[a1]
            if not v1 then
                return
            end
            v1.Trove:Clean()
            for i, j in v1.Rows do
                v1.Rows[i] = nil
                j:Destroy()
            end
            if v1.Gui.Parent then
                v1.Gui.Enabled = true
            end
            u9[a1] = nil
        end

        local function trackLeaderboard(a1) -- Line: 148
            -- upvalues: cleanupLeaderboard (val), u42 (upval), Leaderboards_2 (val), PlayerGui (val), Trove (upval)
            -- upvalues: u9 (val), u10 (val), renderLeaderboard (val), Player (upval), LocalPlayer (upval)
            if not a1:IsA("ScrollingFrame") then
                return
            end
            cleanupLeaderboard(a1)
            local Attribute = a1:GetAttribute("Key")
            if type(Attribute) ~= "string" then
                (u42:AtWarning()):Log((("leaderboard %* has no Key attribute"):format((a1:GetFullName()))))
                return
            end
            local v1 = Leaderboards_2:FindFirstChild(Attribute)
            if not (if v1 == nil then nil else if v1:IsA("Frame") then v1 else nil) then
                (u42:AtWarning()):Log((("leaderboard key \"%*\" has no row template"):format(Attribute)))
                return
            end
            local Parent = a1.Parent
            if Parent and Parent:IsA("Frame") then
                local Parent_2 = Parent.Parent
                if Parent_2 and Parent_2:IsA("SurfaceGui") then
                    local v2
                    local Adornee = Parent_2.Adornee
                    if not Adornee or not Adornee:IsA("BasePart") then
                        local Parent_3 = Parent_2.Parent
                        v1 = if not Parent_3 then nil else if not Parent_3:IsA("BasePart") then nil else Parent_3
                    else
                        v1 = Adornee
                    end
                    if not v1 then
                        return
                    end
                    Parent_2.Adornee = v1
                    Parent_2.Parent = PlayerGui
                    local v3 = Trove.new()
                    local v4 = {
                        Key = Attribute,
                        Part = v1,
                        Gui = Parent_2,
                        Container = a1,
                        Template = v2,
                        Rows = {},
                        Trove = v3,
                    }
                    u9[a1] = v4
                    v3:Add((a1.Destroying:Connect(function() -- Line: 197 -- upvalues: cleanupLeaderboard (upval), a1 (val)
                        cleanupLeaderboard(a1)
                    end)))
                    v3:Add((Parent_2.Destroying:Connect(function() -- Line: 199 -- upvalues: cleanupLeaderboard (upval), a1 (val)
                        cleanupLeaderboard(a1)
                    end)))
                    v3 = u10[Attribute]
                    if v3 then
                        renderLeaderboard(v4, v3)
                    end
                    local v5 = Player.FindRootPart(LocalPlayer)
                    v4 = u9[a1]
                    if not v4 then
                        return
                    end
                    v3 = true
                    local MaxDistance = v4.Gui.MaxDistance
                    if not v5 then
                        v3 = false
                    elseif MaxDistance > 0 then
                        v3 = (v5.Position - v4.Part.Position).Magnitude <= MaxDistance
                    end
                    if v4.Gui.Enabled ~= v3 then
                        v4.Gui.Enabled = v3
                    end
                    return
                end
                return
            end
        end

        local function updateLeaderboards() -- Line: 209 -- upvalues: Player (upval), LocalPlayer (upval), u9 (val)
            local MaxDistance, v1, v2
            local v3 = Player.FindRootPart(LocalPlayer)
            local v4 = nil
            local v5 = nil
            for i in u9, v4, v5 do
                v1 = u9[i]
                if v1 then
                    v2 = true
                    MaxDistance = v1.Gui.MaxDistance
                    if not v3 then
                        v2 = false
                    elseif MaxDistance > 0 then
                        v2 = (v3.Position - v1.Part.Position).Magnitude <= MaxDistance
                    end
                    if v1.Gui.Enabled ~= v2 then
                        v1.Gui.Enabled = v2
                    end
                end
            end
        end

        local function setLeaderboardEntries(a1, a2) -- Line: 226
            -- upvalues: u10 (val), u9 (val), renderLeaderboard (val)
            local v1
            u10[a1] = a2
            for i in u9 do
                v1 = u9[i]
                if v1.Key == a1 then
                    renderLeaderboard(v1, a2)
                end
            end
        end

        function requestLeaderboards() -- Line: 236
            -- upvalues: Remotes (upval), Leaderboards (upval), u42 (upval), requestLeaderboards (val), u10 (val)
            -- upvalues: setLeaderboardEntries (val)
            local success, err = pcall(function() -- Line: 237 -- upvalues: Remotes (upval)
                return Remotes.Leaderboards.Fetch:InvokeServer()
            end)
            local v1 = if not success then false else Leaderboards.SchemaValidation.LeaderboardsByKey(err)
            local v2 = tostring(err)
            if not v1 then
                (u42:AtError()):Log((("leaderboard request failed, retrying: %*"):format(v2)))
                task.delay(5, requestLeaderboards)
                return
            end
            for i, j in err do
                if u10[i] == nil then
                    setLeaderboardEntries(i, j)
                end
            end
        end

        for i, j in CollectionService:GetTagged("Leaderboard") do
            trackLeaderboard(j)
        end
        ;(CollectionService:GetInstanceAddedSignal("Leaderboard")):Connect(trackLeaderboard)
        ;(CollectionService:GetInstanceRemovedSignal("Leaderboard")):Connect(cleanupLeaderboard)
        RunService.Heartbeat:Connect(function(a1) -- Line: 216 -- upvalues: u11 (ref), Player (upval), LocalPlayer (upval), u9 (val) -- types: a1: number
            local MaxDistance, v1, v2
            u11 = u11 + a1
            if u11 < 0.2 then
                return
            end
            u11 = 0
            local v3 = Player.FindRootPart(LocalPlayer)
            local v4 = nil
            local v5 = nil
            for i in u9, v4, v5 do
                v1 = u9[i]
                if v1 then
                    v2 = true
                    MaxDistance = v1.Gui.MaxDistance
                    if not v3 then
                        v2 = false
                    elseif MaxDistance > 0 then
                        v2 = (v3.Position - v1.Part.Position).Magnitude <= MaxDistance
                    end
                    if v1.Gui.Enabled ~= v2 then
                        v1.Gui.Enabled = v2
                    end
                end
            end
        end)
        Remotes.Leaderboards.Updated.OnClientEvent:Connect(function(a1, a2) -- Line: 255 -- upvalues: u42 (upval), Leaderboards (upval), setLeaderboardEntries (val)
            if type(a1) ~= "string" then
                (u42:AtError()):Log((("leaderboard update had a non-string key: %*"):format((tostring(a1)))))
                return
            end
            local v1, v2 = Leaderboards.SchemaValidation.Leaderboard(a2)
            if not v1 then
                (u42:AtError()):Log((("leaderboard update for \"%*\" failed validation: %*"):format(a1, v2)))
                return
            end
            setLeaderboardEntries(a1, a2)
        end)
        task.spawn(requestLeaderboards)
    end,
}