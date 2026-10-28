-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.RaceHud
-- Decompile time: 17.44 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local GUI = require(ReplicatedStorage.Client.GUI)
require(script.Parent.MountController)
local MountRace = require(ReplicatedStorage.Data.MountRace)
local MountRaceFlags = require(ReplicatedStorage.Shared.Flags.MountRaceFlags)
require(script.Parent.RaceCamera)
local RaceEffects = require(script.Parent.RaceEffects)
require(script.Parent.RaceMusic)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local SpeedLines = require(ReplicatedStorage.Client.SpeedLines)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local TrackAttributes = MountRace.TrackAttributes
local PlayerAttributes = MountRace.PlayerAttributes
local u92 = Color3.fromRGB(255, 255, 255)
local u97 = Color3.fromRGB(90, 255, 110)
local u101 = UDim2.fromScale(0.5, 0.29)
local u105 = UDim2.fromScale(1.5, 1)
local u109 = UDim2.fromScale(0.5, 1)
local u113 = UDim2.fromScale(0.5, 1.08)
local u117 = UDim2.fromScale(1.3, 0.42)
local u121 = UDim2.fromScale(0.987, 0.21)
local u126 = Color3.fromRGB(255, 255, 255)
local u131 = Color3.fromRGB(0, 0, 0)
local u136 = Color3.fromRGB(255, 72, 72)
local u141 = Color3.fromRGB(70, 0, 0)
local Deny = ReplicatedStorage.Assets.MountRace.PowerUps.Sounds.Deny
local u147 = 0

local function now() -- Line: 78 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow()
end

local function formatClock(a1) -- Line: 82 -- types: a1: number
    local v1 = math.max(math.ceil(a1), 0)
    return string.format("%d:%02d", v1 // 60, v1 % 60)
end

local function punch(a1) -- Line: 87 -- upvalues: TweenService (val) -- types: a1: userdata
    a1.Scale = 1.4
    TweenService:Create(a1, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
end

local function paintBanner(a1, a2, a3) -- Line: 94 -- types: a2: userdata, a3: userdata
    local Place = a1.FinishBanner.Place
    Place.TextColor3 = a2
    local UIStroke = Place:FindFirstChildOfClass("UIStroke")
    if UIStroke ~= nil then
        UIStroke.Color = a3
    end
end

local function shake(a1) -- Line: 103 -- types: a1: userdata
    local Position = a1.Position
    local u3 = os.clock()
    task.spawn(function() -- Line: 106 -- upvalues: u3 (val), a1 (val), Position (val)
        local v1
        while true do
            if not (os.clock() - u3 < 0.45) then
                break
            end
            v1 = os.clock() - u3
            a1.Position = Position + UDim2.fromScale(math.sin(v1 * 55) * 0.012 * (1 - v1 / 0.45), 0)
            task.wait()
        end
        a1.Position = Position
    end)
end

local function showFinish(a1, a2, a3) -- Line: 116
    -- upvalues: u126 (val), u131 (val), MountRace (val), punch (val)
    local FinishBanner = a1.FinishBanner
    local v1 = u126
    local Place = a1.FinishBanner.Place
    Place.TextColor3 = v1
    local UIStroke = Place:FindFirstChildOfClass("UIStroke")
    if UIStroke ~= nil then
        UIStroke.Color = u131
    end
    FinishBanner.Place.Text = ("%*!"):format((MountRace.FormatPlace(a2)))
    FinishBanner.Time.Text = if a3 == nil then "RACE OVER" else MountRace.FormatTime(a3)
    FinishBanner.LeaveButton.Visible = a3 ~= nil
    FinishBanner.Visible = true
    punch(FinishBanner.Punch)
end

local function showFailed(a1, a2) -- Line: 126
    -- upvalues: u136 (val), u141 (val), MountRace (val), punch (val), SoundService (val), Deny (val)
    local FinishBanner = a1.FinishBanner
    local v1 = u136
    local Place = a1.FinishBanner.Place
    Place.TextColor3 = v1
    local UIStroke = Place:FindFirstChildOfClass("UIStroke")
    if UIStroke ~= nil then
        UIStroke.Color = u141
    end
    FinishBanner.Place.Text = "DID NOT FINISH"
    FinishBanner.Time.Text = ("%* - OUT OF TIME"):format((MountRace.FormatPlace(a2)))
    FinishBanner.LeaveButton.Visible = false
    if not FinishBanner.Visible then
        local Position = FinishBanner.Position
        local u29 = os.clock()
        task.spawn(function() -- Line: 106 -- upvalues: u29 (val), FinishBanner (val), Position (val)
            local v1
            while true do
                if not (os.clock() - u29 < 0.45) then
                    break
                end
                v1 = os.clock() - u29
                FinishBanner.Position = Position + UDim2.fromScale(math.sin(v1 * 55) * 0.012 * (1 - v1 / 0.45), 0)
                task.wait()
            end
            FinishBanner.Position = Position
        end)
    end
    FinishBanner.Visible = true
    punch(FinishBanner.Punch)
    SoundService:PlayLocalSound(Deny)
end

return {
    Run = function(a1, a2, a3, a4, a5, a6) -- Line: 144
        -- upvalues: GUI (val), u121 (val), u113 (val), u117 (val), u147 (ref), RunService (val), TrackAttributes (val)
        -- upvalues: MountRace (val), LocalPlayer (val), PlayerAttributes (val), Workspace (val), u105 (val), u109 (val)
        -- upvalues: u101 (val), MountRaceFlags (val), u97 (val), u92 (val), punch (val), SoundService (val)
        -- upvalues: showFailed (val), showFinish (val), RaceEffects (val), Remotes (val), SpeedLines (val)
        -- upvalues: UserInputService (val)
        local u8 = GUI.MountRaceUI()
        local Main = GUI.MountRaceBoardUI().Main
        local Timer = u8.Timer
        local Countdown = u8.Countdown
        local LapBanner = u8.LapBanner
        local FinishBanner = u8.FinishBanner
        local Position = Timer.Position
        local Size = Timer.Title.Size
        local Position_2 = Timer.Title.Position
        local u28 = a1:Add((Main.Lap:Clone()))
        u28.Name = "RaceClock"
        u28.Position = u121
        u28.Text = ""
        u28.Parent = Main
        local u38 = a1:Add((Timer.Title:Clone()))
        u38.Name = "Waiting"
        u38.AnchorPoint = Vector2.new(0.5, 0)
        u38.Position = u113
        u38.Size = u117
        u38.RichText = true
        u38.Text = "Waiting for players"
        u38.Visible = false
        u38.Parent = Timer
        u147 = u147 + 1
        a1:Add(function() -- Line: 175
            -- upvalues: Timer (val), Position (val), Size (val), Position_2 (val), Countdown (val), LapBanner (val)
            -- upvalues: FinishBanner (val), u8 (val)
            Timer.Visible = false
            Timer.Position = Position
            Timer.Title.Size = Size
            Timer.Title.Position = Position_2
            Timer.Time.Visible = true
            Timer.Shadow.Visible = true
            Countdown.Visible = false
            LapBanner.Visible = false
            FinishBanner.Visible = false
            u8.Handbrake.Visible = false
        end)
        local u55 = nil
        local u56 = false
        a1:Connect(RunService.RenderStepped, function() -- Line: 191
            -- upvalues: a3 (val), TrackAttributes (upval), MountRace (upval), LocalPlayer (upval)
            -- upvalues: PlayerAttributes (upval), Timer (val), Workspace (upval), u38 (val), u105 (upval), Size (val)
            -- upvalues: u109 (upval), Position_2 (val), Main (val), u101 (upval), Position (val)
            -- upvalues: MountRaceFlags (upval), u56 (ref), a6 (val), Countdown (val), u55 (ref), u97 (upval)
            -- upvalues: u92 (upval), punch (upval), SoundService (upval), u28 (val)
            local Time_2, v1, v2
            local Attribute = a3:GetAttribute(TrackAttributes.Phase)
            local Attribute_2 = a3:GetAttribute(TrackAttributes.JoinEndsAt)
            local Attribute_3 = a3:GetAttribute(TrackAttributes.EndsAt)
            local v3 = false
            if Attribute == MountRace.Phase.Racing then
                v3 = false
                if type(Attribute_3) == "number" then
                    v3 = false
                    if a3:GetAttribute(TrackAttributes.WaitForOthers) == true then
                        v3 = type((LocalPlayer:GetAttribute(PlayerAttributes.FinishTime))) == "number"
                    end
                end
            end
            if Attribute ~= MountRace.Phase.Joining then
                if Attribute ~= MountRace.Phase.Racing or type(Attribute_3) ~= "number" then
                    Timer.Visible = false
                else
                    Timer.Title.Text = if not v3 then "RACE ENDS IN" else string.format(
                        "Waiting for others to finish the race... (%d)",
                        (math.max(math.ceil(Attribute_3 - (Workspace:GetServerTimeNow())), 0))
                    )
                    Time_2 = Timer.Time
                    v2 = math.max(math.ceil(Attribute_3 - (Workspace:GetServerTimeNow())), 0)
                    Time_2.Text = string.format("%d:%02d", v2 // 60, v2 % 60)
                    Timer.Visible = true
                end
            elseif type(Attribute_2) == "number" then
                Timer.Title.Text = "RACE STARTS IN"
                local Time = Timer.Time
                v2 = math.max(math.ceil(Attribute_2 - (Workspace:GetServerTimeNow())), 0)
                Time.Text = string.format("%d:%02d", v2 // 60, v2 % 60)
                Timer.Visible = true
                v1 = math.floor((os.clock()) / 0.45) % 4
                u38.Text = ("Waiting for players%*<font transparency=\"1\">%*</font>"):format(string.rep(".", v1), (string.rep(".", 3 - v1)))
                u38.TextTransparency = math.sin((os.clock()) * 3) * 0.15 + 0.15
                u38.Visible = true
            elseif Attribute ~= MountRace.Phase.Racing or type(Attribute_3) ~= "number" then
                Timer.Visible = false
            else
                Timer.Title.Text = if not v3 then "RACE ENDS IN" else string.format(
                    "Waiting for others to finish the race... (%d)",
                    (math.max(math.ceil(Attribute_3 - (Workspace:GetServerTimeNow())), 0))
                )
                Time_2 = Timer.Time
                v2 = math.max(math.ceil(Attribute_3 - (Workspace:GetServerTimeNow())), 0)
                Time_2.Text = string.format("%d:%02d", v2 // 60, v2 % 60)
                Timer.Visible = true
            end
            Timer.Time.Visible = not v3
            Timer.Shadow.Visible = not v3
            local v4 = if not v3 then Size else u105
            Timer.Title.Size = v4
            v4 = if not v3 then Position_2 else u109
            Timer.Title.Position = v4
            if Attribute ~= MountRace.Phase.Joining then
                u38.Visible = false
            end
            Timer.Shadow.Text = Timer.Time.Text
            Timer.Position = if not Main.Visible then Position else u101
            local Attribute_5 = a3:GetAttribute(TrackAttributes.GoAt)
            local v5 = if type(Attribute_5) ~= "number" then (1 / 0) else Attribute_5 - Workspace:GetServerTimeNow()
            v1 = if type(Attribute_5) ~= "number" then if Attribute ~= MountRace.Phase.Joining then nil else if type(Attribute_2) ~= "number" then nil else Attribute_2 + MountRaceFlags.CountdownSeconds:Get() else Attribute_5
            if not u56 and v1 ~= nil then
                local v6 = v1 - Workspace:GetServerTimeNow()
                if v6 <= 0 then
                    u56 = true
                elseif v6 <= 7.5 then
                    u56 = true
                    a6:Play("PreRace", 7.5 - v6)
                end
            end
            Countdown.Visible = (if v5 == (1 / 0) or v5 <= -0.9 then nil else if not (v5 > 0) then "GO!" else tostring((math.ceil(v5)))) ~= nil
            if v1 ~= nil and v1 ~= u55 then
                Countdown.Text = v1
                Countdown.TextColor3 = if v1 ~= "GO!" then u92 else u97
                punch(Countdown.Punch)
                SoundService:PlayLocalSound(if v1 ~= "GO!" then MountRace.Sounds.CountdownTick else MountRace.Sounds.CountdownGo)
                if v1 == "GO!" and a6.Wanted == "PreRace" then
                    a6:Play("Race")
                end
            end
            u55 = v1
            local Attribute_6 = LocalPlayer:GetAttribute(PlayerAttributes.FinishTime)
            if type(Attribute_6) == "number" then
                u28.Text = MountRace.FormatTime(Attribute_6)
                return
            end
            if Attribute == MountRace.Phase.Racing and type(Attribute_5) == "number" then
                u28.Text = MountRace.FormatTime((math.max(Workspace:GetServerTimeNow() - Attribute_5, 0)))
                return
            end
            if Attribute == MountRace.Phase.Countdown then
                u28.Text = MountRace.FormatTime(0)
                return
            end
            if Attribute ~= MountRace.Phase.Results then
                u28.Text = ""
            end
        end)
        local Attribute = LocalPlayer:GetAttribute(PlayerAttributes.Lap)
        local u69 = 0
        a1:Connect(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.Lap), function() -- Line: 278
            -- upvalues: LocalPlayer (upval), PlayerAttributes (upval), a3 (val), TrackAttributes (upval)
            -- upvalues: Attribute (ref), LapBanner (val), punch (upval), SoundService (upval), MountRace (upval)
            -- upvalues: a6 (val), u69 (ref)
            local Attribute_2 = LocalPlayer:GetAttribute(PlayerAttributes.Lap)
            local Attribute_3 = a3:GetAttribute(TrackAttributes.Laps)
            local v1 = Attribute
            Attribute = Attribute_2
            if type(Attribute_2) == "number"
                and type(Attribute_3) == "number"
                and type(v1) == "number"
                and not (Attribute_2 <= v1) then
                v1 = Attribute_2 == Attribute_3
                LapBanner.Text = if not v1 then ("LAP %*/%*"):format(Attribute_2, Attribute_3) else "FINAL LAP!"
                LapBanner.Visible = true
                punch(LapBanner.Punch)
                SoundService:PlayLocalSound(if not v1 then MountRace.Sounds.LapChime else MountRace.Sounds.FinalLap)
                if v1 then
                    a6:Play("FinalLap")
                end
                u69 = u69 + 1
                local u64 = u69
                task.delay(1.8, function() -- Line: 296 -- upvalues: u64 (val), u69 (upval), LapBanner (upval)
                    if u64 == u69 then
                        LapBanner.Visible = false
                    end
                end)
                return
            end
        end)
        local Attribute_2 = LocalPlayer:GetAttribute(PlayerAttributes.Place)
        local u86 = 0
        a1:Connect(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.Place), function() -- Line: 306
            -- upvalues: LocalPlayer (upval), PlayerAttributes (upval), Attribute_2 (ref), a3 (val)
            -- upvalues: TrackAttributes (upval), MountRace (upval), u86 (ref), SoundService (upval)
            local Attribute = LocalPlayer:GetAttribute(PlayerAttributes.Place)
            local v1 = Attribute_2
            Attribute_2 = Attribute
            if type(Attribute) == "number" and type(v1) == "number" and Attribute ~= v1 then
                if (a3:GetAttribute(TrackAttributes.Phase)) == MountRace.Phase.Racing
                    and LocalPlayer:GetAttribute(PlayerAttributes.FinishPlace) == nil
                    and not (os.clock() < u86) then
                    u86 = os.clock() + 0.6
                    SoundService:PlayLocalSound(if not (Attribute < v1) then MountRace.Sounds.Overtaken else MountRace.Sounds.Overtake)
                    return
                end
                return
            end
        end)

        local function onFinishPlace() -- Line: 322
            -- upvalues: LocalPlayer (upval), PlayerAttributes (upval), LapBanner (val), showFailed (upval), u8 (val)
            -- upvalues: showFinish (upval), RaceEffects (upval), a2 (val), a5 (val), a6 (val)
            local Attribute = LocalPlayer:GetAttribute(PlayerAttributes.FinishPlace)
            if type(Attribute) ~= "number" then
                return
            end
            local Attribute_2 = LocalPlayer:GetAttribute(PlayerAttributes.FinishTime)
            local v1 = if type(Attribute_2) ~= "number" then nil else Attribute_2
            LapBanner.Visible = false
            if v1 == nil then
                showFailed(u8, Attribute)
                return
            end
            showFinish(u8, Attribute, v1)
            RaceEffects.Finish(a2, a5)
            a6:Play("Victory")
        end

        a1:Connect(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.FinishPlace), onFinishPlace)
        onFinishPlace()
        a1:Add((GUI.OnActivated(FinishBanner.LeaveButton, function() -- Line: 340 -- upvalues: Remotes (upval)
            Remotes.MountRace.AskLeave:FireServer()
        end)))
        SpeedLines.Run(a1, u8.SpeedLines, function() -- Line: 344 -- upvalues: a4 (val)
            return (a4:SpeedRatio() - 0.6) / 0.6
        end)
        local Handbrake = u8.Handbrake
        Handbrake.Visible = UserInputService.TouchEnabled
        a1:Connect(Handbrake.InputBegan, function(a1) -- Line: 350 -- upvalues: a4 (val) -- types: a1: userdata
            if a1.UserInputType == Enum.UserInputType.Touch
                or a1.UserInputType == Enum.UserInputType.MouseButton1 then
                a4.Handbrake = true
            end
        end)
        a1:Connect(Handbrake.InputEnded, function(a1) -- Line: 358 -- upvalues: a4 (val) -- types: a1: userdata
            if a1.UserInputType == Enum.UserInputType.Touch
                or a1.UserInputType == Enum.UserInputType.MouseButton1 then
                a4.Handbrake = false
            end
        end)
    end,
    ShowCompleted = function(a1) -- Line: 369
        -- upvalues: GUI (val), LocalPlayer (val), PlayerAttributes (val), u126 (val), u131 (val), MountRace (val)
        -- upvalues: punch (val), showFailed (val), u147 (ref)
        local u3 = GUI.MountRaceUI()
        local v1 = LocalPlayer
        if type((v1:GetAttribute(PlayerAttributes.FinishTime))) ~= "number" then
            showFailed(u3, a1)
        else
            local FinishBanner = u3.FinishBanner
            v1 = u126
            local Place = u3.FinishBanner.Place
            Place.TextColor3 = v1
            local UIStroke = Place:FindFirstChildOfClass("UIStroke")
            if UIStroke ~= nil then
                UIStroke.Color = u131
            end
            FinishBanner.Place.Text = ("%*!"):format((MountRace.FormatPlace(a1)))
            FinishBanner.Time.Text = "RACE OVER"
            FinishBanner.LeaveButton.Visible = false
            FinishBanner.Visible = true
            punch(FinishBanner.Punch)
            u3.FinishBanner.Time.Text = "RACE COMPLETED"
        end
        u147 = u147 + 1
        local u50 = u147
        task.delay(4, function() -- Line: 379 -- upvalues: u50 (val), u147 (upval), u3 (val)
            if u50 == u147 then
                u3.FinishBanner.Visible = false
            end
        end)
    end,
}