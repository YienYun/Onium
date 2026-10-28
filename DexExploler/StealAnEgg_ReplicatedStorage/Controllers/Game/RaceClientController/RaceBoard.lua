-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.RaceBoard
-- Decompile time: 11.69 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local GUI = require(ReplicatedStorage.Client.GUI)
local MountRace = require(ReplicatedStorage.Data.MountRace)
local RacePowerUps = require(ReplicatedStorage.Data.RacePowerUps)
local TheHollowFlags = require(ReplicatedStorage.Shared.Flags.TheHollowFlags)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local PlayerAttributes = MountRace.PlayerAttributes
local BoardPlace = RacePowerUps.Attributes.BoardPlace
local BotAvatar = RacePowerUps.Attributes.BotAvatar
local u57 = ("player:%*"):format(LocalPlayer.UserId)
local TrackAttributes = MountRace.TrackAttributes
local u59 = {"First", "Second", "Third"}
local u63 = {
    "rbxassetid://110020507589632",
    "rbxassetid://138453357586829",
    "rbxassetid://98134965629376",
    "rbxassetid://133624868976164",
    "rbxassetid://107870451775346",
    "rbxassetid://129253971737893",
    "rbxassetid://99903302571729",
}
local u74 = UDim2.fromScale(0.5, 0.5)
local u78 = UDim2.fromScale(0.5, 0.1)

local function headshot(a1) -- Line: 74 -- types: a1: number
    return (("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(a1))
end

local function standingsFor(a1, a2) -- Line: 78
    -- upvalues: Players (val), MountRace (val), PlayerAttributes (val), BoardPlace (val), Workspace (val)
    -- upvalues: BotAvatar (val)
    local Attribute_3, Attribute_4, FinishPlace, Place, RaceId_2
    local v1 = {}
    local v2, v3 = a1, a2
    for i, j in Players:GetPlayers() do
        if MountRace.HeatOf(j) == v3 then
            RaceId_2 = PlayerAttributes.RaceId
            if j:GetAttribute(RaceId_2) ~= v2 then
                FinishPlace = PlayerAttributes.FinishPlace
                Attribute_3 = j:GetAttribute(FinishPlace)
            else
                Place = PlayerAttributes.Place
                Attribute_3 = j:GetAttribute(Place)
            end
            if type(Attribute_3) == "number" then
                Attribute_4 = j:GetAttribute(BoardPlace)
                table.insert(v1, {
                    Key = ("player:%*"):format(j.UserId),
                    UserId = j.UserId,
                    Place = if type(Attribute_4) ~= "number" then Attribute_3 else Attribute_4,
                })
            end
        end
    end
    local RaceBots = Workspace:FindFirstChild("RaceBots")
    if RaceBots ~= nil then
        local Attribute, Attribute_2, RaceId
        for k, n in RaceBots:GetChildren() do
            Attribute = n:GetAttribute(BoardPlace)
            Attribute_2 = n:GetAttribute(BotAvatar)
            RaceId = PlayerAttributes.RaceId
            if n:GetAttribute(RaceId) == v2
                and MountRace.HeatOf(n) == v3
                and type(Attribute) == "number"
                and type(Attribute_2) == "number" then
                table.insert(v1, {Key = ("bot:%*"):format(n.Name), UserId = Attribute_2, Place = Attribute})
            end
        end
    end
    table.sort(v1, function(a1, a2) -- Line: 112 -- types: a1: table, a2: table
        if a1.Place ~= a2.Place then
            return a1.Place < a2.Place
        end
        return a1.Key < a2.Key
    end)
    return v1
end

local function pop(a1, a2, a3, a4) -- Line: 121
    -- upvalues: TweenService (val)
    a1.Scale = a2
    TweenService:Create(a1, TweenInfo.new(a3, a4), {Scale = 1}):Play()
end

local function showCard(a1, a2) -- Line: 126 -- upvalues: TweenService (val) -- types: a1: table, a2: userdata
    if a1.Position == a2 then
        return
    end
    a1.Position = a2
    if not a1.Frame.Visible then
        a1.Frame.Position = a2 + UDim2.fromScale(0, -0.32)
        a1.Frame.Visible = true
        TweenService:Create(a1.Scale, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Scale = 1}):Play()
    end
    TweenService:Create(a1.Frame, TweenInfo.new(0.42, Enum.EasingStyle.Quint), {Position = a2}):Play()
end

local function hideCard(a1) -- Line: 140 -- types: a1: table
    a1.Key = nil
    a1.Position = nil
    a1.Frame.Visible = false
    a1.Scale.Scale = 0.72
end

local function setCard(a1, a2) -- Line: 147
    -- upvalues: TweenService (val), MountRace (val), u57 (val)
    if a1.Key ~= a2.Key then
        a1.Key = a2.Key
        a1.Avatar.Image = ("rbxthumb://type=AvatarHeadShot&id=%*&w=150&h=150"):format(a2.UserId)
        a1.Avatar.ImageTransparency = 0.5
        TweenService:Create(a1.Avatar, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
    end
    a1.Place.Text = string.upper(MountRace.FormatPlace(a2.Place))
    a1.YouStroke.Enabled = a2.Key == u57
end

local function showPlacement(a1, a2, a3, a4) -- Line: 159
    -- upvalues: u63 (val), pop (val), TweenService (val)
    local v1 = u63[a3]
    a1.Visible = v1 ~= nil
    if v1 == nil then
        return
    end
    a1.Image = v1
    a1.Rotation = if a4 == nil then -14 else if not (a4 < a3) then -14 else 14
    pop(a2, 1.5, 0.5, Enum.EasingStyle.Back)
    TweenService:Create(a1, TweenInfo.new(0.7, Enum.EasingStyle.Elastic), {Rotation = 0}):Play()
end

return {
    Run = function(a1, a2, a3, a4) -- Line: 175
        -- upvalues: MountRace (val), LocalPlayer (val), GUI (val), TheHollowFlags (val), u78 (val), TweenService (val)
        -- upvalues: u74 (val), TrackAttributes (val), PlayerAttributes (val), pop (val), standingsFor (val), u59 (val)
        -- upvalues: u57 (val), showPlacement (val), setCard (val), showCard (val)
        local Avatar, UIScale, v1, v2
        local u7 = MountRace.HeatOf(LocalPlayer)
        local Main = GUI.MountRaceBoardUI().Main
        local Leaderboard = Main.Leaderboard
        local Lap = Main.Lap
        local PlacementImage = Main.PlacementImage
        local Attribute = a2:GetAttribute(MountRace.RaceNameAttribute)
        local v3 = ("%* has no %* attribute"):format(a2:GetFullName(), MountRace.RaceNameAttribute)
        assert(type(Attribute) == "string", v3)
        Main.Title.Text = Attribute
        local Fallback = Leaderboard.First.Crown.Fallback
        local Image = Fallback.Image
        local Attribute_2 = a2:GetAttribute("CrownImage")
        if type(Attribute_2) == "string" and Attribute_2 ~= "" then
            v3 = TheHollowFlags.CrownImage:Get()
            if v3 ~= "" then
                Fallback.Image = v3
            end
        end
        local UIListLayout = Leaderboard:FindFirstChildOfClass("UIListLayout")
        if UIListLayout ~= nil then
            UIListLayout:Destroy()
        end
        local u66 = {}
        for i, j in {"First", "Second", "Third", "You"} do
            v1 = Leaderboard:FindFirstChild(j)
            Avatar = v1:FindFirstChild("Avatar")
            UIScale = Instance.new("UIScale")
            UIScale.Parent = v1
            a1:Add(UIScale)
            v1.AnchorPoint = Vector2.new(0.5, 0.5)
            v2 = {
                Frame = v1,
                Avatar = Avatar,
                Place = v1:FindFirstChild("Place"),
                YouStroke = Avatar:FindFirstChild("YouStroke"),
                Scale = UIScale,
            }
            u66[j] = v2
            v2 = u66[j]
            v2.Key = nil
            v2.Position = nil
            v2.Frame.Visible = false
            v2.Scale.Scale = 0.72
        end
        local u84 = Instance.new("UIScale")
        u84.Parent = PlacementImage
        a1:Add(u84)
        PlacementImage.Visible = false
        Main.Position = u78
        Main.Visible = false
        local u95 = false
        local u96 = nil
        local u97 = nil
        a1:Add(function() -- Line: 232 -- upvalues: Main (val), PlacementImage (val), Lap (val), Fallback (val), Image (val), u66 (val)
            Main.Visible = false
            PlacementImage.Visible = false
            Lap.Text = ""
            Fallback.Image = Image
            for i, j in u66 do
                j.Key = nil
                j.Position = nil
                j.Frame.Visible = false
                j.Scale.Scale = 0.72
            end
        end)

        local function setShown(a1) -- Line: 242
            -- upvalues: u95 (ref), Main (val), TweenService (upval), u74 (upval), u78 (upval)
            if a1 == u95 then
                return
            end
            u95 = a1
            if a1 then
                Main.Visible = true
                TweenService:Create(Main, TweenInfo.new(0.42, Enum.EasingStyle.Back), {Position = u74}):Play()
                return
            end
            local v1 = TweenService:Create(Main, TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = u78})
            v1:Play()
            v1.Completed:Once(function() -- Line: 257 -- upvalues: u95 (upval), Main (upval)
                if not u95 then
                    Main.Visible = false
                end
            end)
        end

        local function refresh() -- Line: 265
            -- upvalues: a3 (val), TrackAttributes (upval), setShown (val), MountRace (upval), LocalPlayer (upval)
            -- upvalues: PlayerAttributes (upval), Lap (val), pop (upval), standingsFor (upval), a4 (val), u7 (val)
            -- upvalues: u59 (upval), u57 (upval), u66 (val), u97 (ref), showPlacement (upval), PlacementImage (val)
            -- upvalues: u84 (val), setCard (upval), showCard (upval), u96 (ref)
            local Scale, v1
            local Attribute = a3:GetAttribute(TrackAttributes.Phase)
            local v2 = true
            if Attribute ~= MountRace.Phase.Racing then
                v2 = Attribute == MountRace.Phase.Results
            end
            setShown(v2)
            local Attribute_2 = LocalPlayer:GetAttribute(PlayerAttributes.Lap)
            local Attribute_3 = a3:GetAttribute(TrackAttributes.Laps)
            v2 = if type((LocalPlayer:GetAttribute(PlayerAttributes.FinishTime))) == "number" then "FINISHED!" else if type(Attribute_3) ~= "number" then "" else ("LAP %*/%*"):format(if type(Attribute_2) ~= "number" then 1 else Attribute_2, Attribute_3)
            if v2 ~= Lap.Text then
                Lap.Text = v2
                pop(Lap.PopScale, 1.35, 0.45, Enum.EasingStyle.Back)
            end
            v2 = standingsFor(a4, u7)
            local v3 = {}
            local v4 = false
            for i = 1, (math.min(#v2, #u59)) do
                v1 = v2[i]
                v4 = v4 or v1.Key == u57
                table.insert(v3, {Card = u66[u59[i]], Standing = v1})
            end
            local v5 = nil
            local v6 = nil
            for j, k in v2, v5, v6 do
                if k.Key == u57 then
                    if not v4 then
                        table.insert(v3, {Card = u66.You, Standing = k})
                    end
                    if k.Place ~= u97 then
                        showPlacement(PlacementImage, u84, k.Place, u97)
                        u97 = k.Place
                    end
                end
            end
            v4 = math.max(#v3 - 1, 0) * 0.05
            for n, m in v3 do
                v4 = v4 + m.Card.Frame.Size.X.Scale
            end
            local v7 = 0.5 - v4 / 2
            v4 = {}
            for i5, i6 in v3 do
                Scale = i6.Card.Frame.Size.X.Scale
                v4[i6.Card] = true
                setCard(i6.Card, i6.Standing)
                showCard(i6.Card, UDim2.fromScale(v7 + Scale / 2, 0.5))
                v7 = v7 + (Scale + 0.05)
            end
            for i7, i8 in u66 do
                if not v4[i8] and i8.Frame.Visible then
                    i8.Key = nil
                    i8.Position = nil
                    i8.Frame.Visible = false
                    i8.Scale.Scale = 0.72
                end
            end
            local Key = if not (#v2 > 0) then nil else v2[1].Key
            if u96 ~= nil and Key ~= nil and Key ~= u96 then
                pop(u66.First.Scale, 1.16, 0.62, Enum.EasingStyle.Elastic)
            end
            u96 = Key
        end

        a1:Add((task.spawn(function() -- Line: 326 -- upvalues: refresh (val)
            while true do
                refresh()
                task.wait(0.25)
            end
        end)))
    end,
}