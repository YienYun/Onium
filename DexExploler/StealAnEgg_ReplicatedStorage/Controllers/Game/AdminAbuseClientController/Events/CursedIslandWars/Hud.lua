-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.CursedIslandWars.Hud
-- Decompile time: 25.15 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local ButtonHintStrip = require(ReplicatedStorage.Client.ButtonHintStrip)
local CursedIslandWars = require(ReplicatedStorage.Data.CursedIslandWars)
local CursedIslandWarsFlags = require(ReplicatedStorage.Shared.Flags.CursedIslandWarsFlags)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Input = require(script.Parent.Input)
local State = require(script.Parent.State)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Tuning = CursedIslandWars.Tuning
local UI = CursedIslandWars.Assets.UI
local u71 = {
    Bat = CursedIslandWarsFlags.BatCooldown,
    PumpkinLauncher = CursedIslandWarsFlags.LauncherCooldown,
    WallBuilder = CursedIslandWarsFlags.WallCooldown,
    Landmine = CursedIslandWarsFlags.MineCooldown,
    JumpPad = CursedIslandWarsFlags.PadCooldown,
}
local u81 = Color3.fromRGB(40, 40, 50)
local u86 = Color3.fromRGB(150, 150, 160)
local u91 = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u96 = Color3.fromRGB(255, 60, 60)
local u101 = Color3.fromRGB(255, 30, 30)
local u104 = TweenInfo.new(0.25)
local u106 = Trove.new()
local u107 = nil
local u108 = {}
local u109 = {}
local u110 = {}
local u111 = {}
local u112 = 0
local u113 = 0
local u114 = nil
local u115 = 0
local u116 = nil
local u117 = {}

local function hex(a1) -- Line: 54 -- types: a1: userdata
    return a1:ToHex()
end

local function clock(a1) -- Line: 58 -- types: a1: number
    local v1 = math.max(0, (math.ceil(a1)))
    return string.format("%d:%02d", v1 // 60, v1 % 60)
end

local function pop(a1) -- Line: 63 -- upvalues: TweenService (val), u91 (val) -- types: a1: userdata
    local Pop = a1:FindFirstChild("Pop")
    if Pop then
        Pop.Scale = 0.6
        TweenService:Create(Pop, u91, {Scale = 1}):Play()
    end
end

function u117.Banner(a1, a2, a3, a4) -- Line: 71
    -- upvalues: u107 (ref), u112 (ref), pop (val)
    if u107 == nil then
        return
    end
    u112 = u112 + 1
    local u7 = u112
    local Banner = u107.Banner
    Banner.Title.Text = a1
    Banner.Title.TextColor3 = a3 or Color3.new(1, 1, 1)
    Banner.Sub.Text = a2 or ""
    Banner.Visible = true
    pop(Banner)
    task.delay(a4 or 3, function() -- Line: 83 -- upvalues: u112 (upval), u7 (val), u107 (upval), Banner (val)
        if u112 == u7 and u107 then
            Banner.Visible = false
        end
    end)
end

function u117.Alarm(a1, a2) -- Line: 90 -- upvalues: u114 (ref) -- types: a1: table, a2: number
    local v1 = u114
    local v2 = {Chunks = a1, EndsAt = a2}
    local Shown = false
    if v1 ~= nil then
        Shown = v1.Shown
    end
    v2.Shown = Shown
    u114 = v2
end

function u117.SafeZone(a1) -- Line: 95 -- upvalues: u116 (ref), UI (val), LocalPlayer (val) -- types: a1: userdata?
    local v1 = u116
    if a1 == nil then
        u116 = nil
        if v1 then
            v1:Destroy()
        end
        return
    end
    if v1 == nil then
        local v2 = UI.SafeMarker:Clone()
        v2.Adornee = a1
        v2.Parent = LocalPlayer.PlayerGui
        u116 = v2
    end
end

local function standingOn(a1) -- Line: 112 -- upvalues: LocalPlayer (val), Workspace (val) -- types: a1: table
    local HumanoidRootPart
    local Character = LocalPlayer.Character
    if (if not Character then nil else Character:FindFirstChild("HumanoidRootPart")) == nil then
        return false
    end
    local v1 = RaycastParams.new()
    v1.FilterType = Enum.RaycastFilterType.Include
    v1.FilterDescendantsInstances = a1
    return Workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -14, 0), v1) ~= nil
end

local function stepAlarm(a1) -- Line: 125
    -- upvalues: u114 (ref), u107 (ref), standingOn (val), u112 (ref), pop (val), u96 (val), u115 (ref), u117 (val)
    local v1 = u114
    if v1 == nil then
        return
    end
    local Banner = u107.Banner
    local v2 = math.ceil(v1.EndsAt - a1)
    local v3 = false
    if v2 > 0 then
        v3 = standingOn(v1.Chunks)
    end
    if v2 <= 0 then
        u114 = nil
    end
    if not v3 then
        if v1.Shown then
            v1.Shown = false
            Banner.Visible = false
        end
        return
    end
    if not v1.Shown then
        v1.Shown = true
        u112 = u112 + 1
        pop(Banner)
    end
    Banner.Visible = true
    Banner.Title.TextColor3 = u96
    Banner.Title.Text = "YOU'RE ON FALLING GROUND!"
    Banner.Sub.Text = ("Run to the centre! %*"):format(v2)
    if u115 <= a1 then
        u115 = a1 + 0.8
        u117.Hurt()
    end
end

local function stepSafeMarker() -- Line: 158 -- upvalues: u116 (ref), LocalPlayer (val)
    local v1 = u116
    local Adornee = if not v1 then nil else v1.Adornee
    local Character = LocalPlayer.Character
    local HumanoidRootPart = if not Character then nil else Character:FindFirstChild("HumanoidRootPart")
    if v1 ~= nil and Adornee ~= nil and HumanoidRootPart ~= nil then
        local Magnitude = ((Vector3.new(Adornee.Position.X, 0, Adornee.Position.Z)) - Vector3.new(HumanoidRootPart.Position.X, 0, HumanoidRootPart.Position.Z)).Magnitude
        v1.Enabled = Magnitude > 28
        v1.Distance.Text = tostring((math.floor(Magnitude)))
        return
    end
end

function u117.TeamCard(a1) -- Line: 171 -- upvalues: u107 (ref), CursedIslandWars (val), pop (val)
    if u107 == nil then
        return
    end
    local TeamCard = u107.TeamCard
    local v1 = CursedIslandWars.Teams[a1]
    TeamCard.Title.Text = ("YOU ARE %*"):format(v1.Name)
    TeamCard.Title.TextColor3 = v1.Color
    TeamCard.Visible = true
    pop(TeamCard)
    task.delay(2.6, function() -- Line: 181 -- upvalues: u107 (upval), TeamCard (val)
        if u107 then
            TeamCard.Visible = false
        end
    end)
end

function u117.Feed(a1) -- Line: 188 -- upvalues: u107 (ref), TweenService (val) -- types: a1: string
    if u107 == nil then
        return
    end
    local Feed = u107.Feed
    local u9 = u107.Templates.FeedLine:Clone()
    u9.Text = a1
    u9.LayoutOrder = -os.clock() * 1000
    u9.Parent = Feed
    local v1 = {}
    for i, j in Feed:GetChildren() do
        if j:IsA("TextLabel") then
            table.insert(v1, j)
        end
    end
    table.sort(v1, function(a1, a2) -- Line: 203
        return a1.LayoutOrder < a2.LayoutOrder
    end)
    local v2 = #v1
    for k = 6, v2 do
        v1[k]:Destroy()
    end
    task.delay(5, function() -- Line: 209 -- upvalues: u9 (val), TweenService (upval)
        if u9.Parent then
            TweenService:Create(u9, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
            task.delay(0.4, function() -- Line: 212 -- upvalues: u9 (upval)
                u9:Destroy()
            end)
        end
    end)
end

function u117.Knockout(a1, a2, a3) -- Line: 219
    -- upvalues: State (val), CursedIslandWars (val), u117 (val)
    local v1 = State.Entry(a1)
    if v1 == nil then
        return
    end
    local v2 = ("<font color=\"#%*\">%*</font>"):format(CursedIslandWars.Teams[v1.Team].Color:ToHex(), v1.Name)
    v1 = State.Entry(a2)
    local v3 = if not v1 then ("%* fell into the void"):format(v2) else ("<font color=\"#%*\">%*</font>  🎃  %*"):format(CursedIslandWars.Teams[v1.Team].Color:ToHex(), v1.Name, v2)
    if a3 then
        v3 = v3 .. "  ☠ ELIMINATED"
    end
    u117.Feed(v3)
end

function u117.Hurt() -- Line: 235 -- upvalues: u107 (ref), TweenService (val)
    if u107 == nil then
        return
    end
    local Vignette = u107.Vignette
    Vignette.GroupTransparency = 0.25
    TweenService:Create(Vignette, TweenInfo.new(0.5), {GroupTransparency = 1}):Play()
end

function u117.HitMarker(a1, a2) -- Line: 244
    -- upvalues: u107 (ref), u113 (ref), TweenService (val), u104 (val), UI (val), LocalPlayer (val)
    local v1
    if u107 == nil then
        return
    end
    local HitMarker = u107.HitMarker
    local UIStroke = HitMarker:FindFirstChildOfClass("UIStroke")
    u113 = u113 + 1
    local u11 = u113
    HitMarker.Visible = true
    HitMarker.TextTransparency = 0
    UIStroke.Transparency = 0
    TweenService:Create(HitMarker, u104, {TextTransparency = 1}):Play()
    TweenService:Create(UIStroke, u104, {Transparency = 1}):Play()
    task.delay(u104.Time, function() -- Line: 257 -- upvalues: u113 (upval), u11 (val), u107 (upval), HitMarker (val)
        if u113 == u11 and u107 then
            HitMarker.Visible = false
        end
    end)
    if (if not a1 then nil else a1:FindFirstChild("HumanoidRootPart")) == nil then
        return
    end
    local u51 = UI.DamageNumber:Clone()
    u51.Adornee = v1
    u51.Amount.Text = ("-%*"):format(a2)
    u51.Parent = LocalPlayer.PlayerGui
    TweenService:Create(u51, TweenInfo.new(0.7, Enum.EasingStyle.Quad), {StudsOffset = u51.StudsOffset + Vector3.new(0, 3, 0)}):Play()
    TweenService:Create(u51.Amount, TweenInfo.new(0.7), {TextTransparency = 1}):Play()
    task.delay(0.7, function() -- Line: 274 -- upvalues: u51 (val)
        u51:Destroy()
    end)
end

function u117.Win(a1, a2) -- Line: 279 -- upvalues: u107 (ref), CursedIslandWars (val), pop (val) -- types: a2: table
    if u107 == nil then
        return
    end
    local Win = u107.Win
    local v1 = CursedIslandWars.Teams[a1]
    Win.Title.Text = ("%* TEAM WINS!"):format(v1.Name)
    Win.Title.TextColor3 = v1.Color
    for i, j in Win.Names:GetChildren() do
        if j:IsA("TextLabel") then
            j:Destroy()
        end
    end
    Win.Visible = true
    pop(Win)
    for k, n in a2 do
        task.delay(k * 0.25, function() -- Line: 295 -- upvalues: u107 (upval), n (val), k (val), Win (val), pop (upval)
            local v1 = u107.Templates.WinName:Clone()
            v1.Text = n
            v1.LayoutOrder = k
            v1.Parent = Win.Names
            pop(v1)
        end)
    end
end

function u117.WallsOpen() -- Line: 305 -- upvalues: u107 (ref), u108 (val), u117 (val)
    if u107 == nil then
        return
    end
    for i, j in u108 do
        j:Destroy()
        u108[i] = nil
    end
    u117.Banner("FIGHT!", nil, Color3.fromRGB(255, 170, 0), 1.6)
end

local function setIcon(a1, a2) -- Line: 316 -- upvalues: u111 (val), u107 (ref) -- types: a1: number, a2: userdata
    local v1
    if u111[a1] then
        return
    end
    u111[a1] = true
    if a2.ToolTip ~= "" then
        u107.Bar[("Slot%*"):format(a1)].Label.Text = a2.ToolTip
    end
    local Model = u107.Bar[("Slot%*"):format(a1)].Icon.Model
    local Model_2 = Instance.new("Model")
    for i, j in a2:GetDescendants() do
        if j:IsA("BasePart") then
            v1 = j:Clone()
            v1:ClearAllChildren()
            v1.Anchored = true
            v1.Parent = Model_2
        end
    end
    Model_2.Parent = Model
    local BoundingBox, BoundingBox_2 = Model_2:GetBoundingBox()
    local v2 = Instance.new("Camera")
    v2.FieldOfView = 30
    local v3 = BoundingBox_2.Magnitude / 0.5358983848622454 * 0.9
    v2.CFrame = CFrame.lookAt(BoundingBox.Position + Vector3.new(-1, 0.6000000238418579, -1).Unit * v3, BoundingBox.Position)
    v2.Parent = Model
    Model.CurrentCamera = v2
    Model.Visible = true
end

local function refreshIcons() -- Line: 345 -- upvalues: LocalPlayer (val), CursedIslandWars (val), setIcon (val)
    local v1, v2, v3
    local v4 = {LocalPlayer:FindFirstChildOfClass("Backpack"), LocalPlayer.Character}
    local v5 = nil
    local v6 = nil
    for i, j in CursedIslandWars.Tools, v5, v6 do
        v2 = nil
        v3 = nil
        for k, n in v4, v2, v3 do
            v1 = if not n then nil else n:FindFirstChild(j)
            if v1 and v1:IsA("Tool") then
                setIcon(i, v1)
                break
            end
        end
    end
end

local function refreshTeams(a1) -- Line: 358
    -- upvalues: State (val), CursedIslandWars (val), u107 (ref), u81 (val), u86 (val)
    local TeamSize, You, v1, v2, v3, v4, v5
    local v6 = State.Me()
    local v7 = nil
    local v8 = nil
    for i, j in CursedIslandWars.TeamIds, v7, v8 do
        v3 = u107.Teams[j]
        You = v3.You
        v5 = false
        if v6 ~= nil then
            v5 = v6.Team == j
        end
        You.Visible = v5
        v4 = v1.Crystals[j]
        v5 = if not v4 then 0 else v4.Health / v4.MaxHealth
        v3.Bar.Fill.Size = UDim2.fromScale(v5, 1)
        v3.Health.Text = if not (v5 > 0) then "SHATTERED" else ("%*%%"):format((math.ceil(v5 * 100)))
        v5 = {}
        for k, n in v1.Entries do
            if n.Team == j then
                table.insert(v5, n)
            end
        end
        table.sort(v5, function(a1, a2) -- Line: 373
            return a1.Id < a2.Id
        end)
        TeamSize = CursedIslandWars.TeamSize
        for m = 1, TeamSize do
            v4 = v3.Pips[("Pip%*"):format(m)]
            v2 = v5[m]
            v4.BackgroundColor3 = if v2 == nil then u81 else if v2.State ~= "Out" then if v2.State ~= "Down" then CursedIslandWars.Teams[j].Color else u86 else u81
        end
    end
end

local function refreshPlates(a1) -- Line: 387
    -- upvalues: State (val), LocalPlayer (val), u109 (val), UI (val), u101 (val), u110 (val), CursedIslandWars (val)
    -- upvalues: CursedIslandWarsFlags (val)
    local Color, Head, Highlight, Humanoid, Model, v1, v2, v3, v4, v5
    local v6 = State.Me()
    local v7 = {}
    local v8 = nil
    local v9 = nil
    for i, j in a1.Entries, v8, v9 do
        Model = j.Model
        if Model ~= nil and Model ~= LocalPlayer.Character then
            v7[Model] = true
            Head = Model:FindFirstChild("Head")
            Humanoid = Model:FindFirstChildOfClass("Humanoid")
            if Head ~= nil then
                v1 = u109[Model]
                if v1 == nil then
                    v1 = UI.Nameplate:Clone()
                    v1.Adornee = Head
                    v1.Parent = LocalPlayer.PlayerGui
                    u109[Model] = v1
                    Highlight = Instance.new("Highlight")
                    Highlight.FillTransparency = 1
                    Highlight.OutlineColor = u101
                    Highlight.OutlineTransparency = 0.2
                    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
                    Highlight.Parent = Model
                    u110[Model] = Highlight
                    if Humanoid then
                        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                    end
                end
                Color = CursedIslandWars.Teams[j.Team].Color
                v5 = j.State == "Alive"
                v2 = false
                if v6 ~= nil then
                    v2 = j.Team == v6.Team
                end
                v1.Enabled = v5 and not v2
                v1.Label.Text = j.Name
                v1.Label.TextColor3 = Color
                v1.Bar.Fill.Size = UDim2.fromScale(math.clamp(j.Health / CursedIslandWarsFlags.PlayerHealth:Get(), 0, 1), 1)
                v1.Bar.Fill.BackgroundColor3 = Color
                v3 = u110[Model]
                v4 = v5
                if v4 then
                    v4 = false
                    if v6 ~= nil then
                        v4 = not v2
                    end
                end
                v3.Enabled = v4
            end
        end
    end
    for k, n in u109 do
        if not v7[k] then
            n:Destroy()
            u109[k] = nil
            v6 = u110[k]
            u110[k] = nil
            if v6 then
                v6:Destroy()
            end
        end
    end
end

local function refreshBoards(a1) -- Line: 442 -- upvalues: u108 (val), UI (val), LocalPlayer (val)
    local v1
    local Island = a1.Island
    if Island == nil then
        return
    end
    if a1.Phase ~= "Reveal" and a1.Phase ~= "Prep" and a1.Phase ~= "Intro" then
        return
    end
    local BoardSurface = Island.RulesBarrier.BoardSurface
    for i, j in {Enum.NormalId.Left, Enum.NormalId.Right} do
        if u108[j] == nil then
            v1 = UI.RulesBoard:Clone()
            v1.Adornee = BoardSurface
            v1.Face = j
            v1.Parent = LocalPlayer.PlayerGui
            u108[j] = v1
        end
    end
end

local function refresh(a1) -- Line: 459
    -- upvalues: u107 (ref), refreshTeams (val), refreshPlates (val), refreshBoards (val), refreshIcons (val)
    -- upvalues: State (val)
    if a1 ~= nil and u107 ~= nil then
        refreshTeams(a1)
        refreshPlates(a1)
        refreshBoards(a1)
        refreshIcons()
        local Phase = a1.Phase
        local Teams = u107.Teams
        local v1 = false
        if Phase ~= "Intro" then
            v1 = false
            if Phase ~= "Reveal" then
                v1 = Phase ~= "Outro"
            end
        end
        Teams.Visible = v1
        local v2 = State.Me()
        local Bar = u107.Bar
        local v3 = false
        if Phase ~= "Intro" then
            v3 = false
            if Phase ~= "Win" then
                v3 = false
                if Phase ~= "Outro" then
                    v3 = false
                    if v2 ~= nil then
                        v3 = v2.State == "Alive"
                    end
                end
            end
        end
        Bar.Visible = v3
        if Phase ~= "Win" then
            u107.Win.Visible = false
        end
        return
    end
end

local function step() -- Line: 477
    -- upvalues: State (val), u107 (ref), u108 (val), CursedIslandWarsFlags (val), Input (val), CursedIslandWars (val)
    -- upvalues: u71 (val), stepAlarm (val), stepSafeMarker (val)
    local Snapshot = State.Snapshot
    if Snapshot ~= nil and u107 ~= nil then
        local v1, v2, v3, v4, v5, v6, v7
        local v8 = State.Now()
        local v9 = Snapshot.PhaseEndsAt - v8
        local Phase = Snapshot.Phase
        local Timer = u107.Timer
        local v10 = true
        if Phase ~= "Prep" then
            v10 = true
            if Phase ~= "Match" then
                v10 = Phase == "SuddenDeath"
            end
        end
        Timer.Visible = v10
        if Timer.Visible then
            v10 = true
            for i, j in Snapshot.Crystals do
                if 0 < j.Health then
                    v10 = false
                end
            end
            Timer.Title.Text = if Phase ~= "Prep" then if Phase ~= "SuddenDeath" then if not v10 then "" else "SUDDEN DEATH IN" else "SUDDEN DEATH" else "MATCH STARTS IN"
            v6 = math.max(0, (math.ceil(v9)))
            v10 = string.format("%d:%02d", v6 // 60, v6 % 60)
            Timer.Time.Text = v10
            Timer.Shadow.Text = v10
            local Time = Timer.Time
            v7 = if Phase == "SuddenDeath" then Color3.fromRGB(255, 60, 60) else if not (v9 <= 10) then Color3.new(1, 1, 1) else Color3.fromRGB(255, 60, 60)
            Time.TextColor3 = v7
        end
        if next(u108) then
            local v11 = v9 + (if Phase == "Prep" then 0 else if Phase ~= "Reveal" then (CursedIslandWarsFlags.RevealSeconds:Get()) + CursedIslandWarsFlags.PrepSeconds:Get() else CursedIslandWarsFlags.PrepSeconds:Get())
            for k, n in u108 do
                n.Main.TimerLabel.Text = ("%*s"):format((math.max(0, (math.ceil(v11)))))
            end
        end
        v9 = State.Me()
        local Respawn = u107.Respawn
        v6 = false
        if v9 ~= nil then
            v6 = false
            if v9.State == "Down" then
                v6 = v9.RespawnAt ~= nil
            end
        end
        Respawn.Visible = v6
        if v9 and v9.State == "Down" and v9.RespawnAt then
            u107.Respawn.Count.Text = tostring((math.max(1, (math.ceil(v9.RespawnAt - v8)))))
        end
        if v9 == nil then
            v1 = false
            if Phase ~= "Intro" then
                v1 = false
                if Phase ~= "Win" then
                    v1 = Phase ~= "Outro"
                end
            end
        else
            v1 = false
            if v9.State == "Out" then
                v1 = false
                if Phase ~= "Intro" then
                    v1 = false
                    if Phase ~= "Win" then
                        v1 = Phase ~= "Outro"
                    end
                end
            end
        end
        u107.Status.Visible = v1
        v6 = if not v9 then "SPECTATING" else "ELIMINATED - SPECTATING"
        u107.Status.Text = v6
        local v12 = Input.Equipped()
        v1 = State.Armed()
        v6 = nil
        v7 = nil
        for m, i5 in CursedIslandWars.Tools, v6, v7 do
            v2 = u107.Bar[("Slot%*"):format(m)]
            v4 = Input.Cooldown(i5) - v8
            v3 = if not v1 then 1 else if not (v4 > 0) then 0 else math.clamp(v4 / u71[i5]:Get(), 0, 1)
            v2.Cooldown.Size = UDim2.fromScale(1, v3)
            v2.Time.Text = if not v1 or not (v4 > 0) then "" else tostring((math.ceil(v4)))
            v5 = if not (v12 == i5) then 1 else 0.2
            v2.Glow.ImageTransparency = v5
            v2.Ring.Visible = v4
            if table.find(CursedIslandWars.Pickups, i5) then
                v2.Visible = 0 < (v9 and v9.Ammo[i5] or 0)
                v2.Count.Visible = v4 > 0
                v2.Count.Text = ("x%*"):format(v4)
            end
        end
        stepAlarm(v8)
        stepSafeMarker()
        return
    end
end

function u117.Start(a1) -- Line: 544
    -- upvalues: u106 (ref), LocalPlayer (val), u107 (ref), u111 (val), CursedIslandWars (val), ButtonFX (val)
    -- upvalues: Input (val), HiddenUIHandler (val), ButtonHintStrip (val), StarterGui (val), u114 (ref), u117 (val)
    -- upvalues: u108 (val), u109 (val), u110 (val), State (val), refresh (val), RunService (val), step (val)
    local v1
    u106 = a1:Extend()
    local CursedIslandWarsUI = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("CursedIslandWarsUI")
    u107 = CursedIslandWarsUI
    table.clear(u111)
    CursedIslandWarsUI.Win.Visible = false
    CursedIslandWarsUI.Banner.Visible = false
    CursedIslandWarsUI.TeamCard.Visible = false
    CursedIslandWarsUI.Respawn.Visible = false
    CursedIslandWarsUI.Status.Visible = false
    CursedIslandWarsUI.HitMarker.Visible = false
    CursedIslandWarsUI.Vignette.GroupTransparency = 1
    for i, j in CursedIslandWarsUI.Feed:GetChildren() do
        if j:IsA("TextLabel") then
            j:Destroy()
        end
    end
    local v2 = #CursedIslandWars.Tools
    for k = 1, v2 do
        v1 = CursedIslandWarsUI.Bar[("Slot%*"):format(k)]
        v1.Icon.Model:ClearAllChildren()
        u106:Add((ButtonFX(v1, nil, function() -- Line: 564 -- upvalues: Input (upval), k (val)
            Input.Equip(k)
        end)))
    end
    CursedIslandWarsUI.Enabled = true
    u106:Add((HiddenUIHandler.Acquire()))
    u106:Add((ButtonHintStrip.Hide()))
    pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.Health, false)
    u106:Add(function() -- Line: 572
        -- upvalues: StarterGui (upval), CursedIslandWarsUI (val), u107 (upval), u114 (upval), u117 (upval)
        -- upvalues: u108 (upval), u109 (upval), u110 (upval)
        local Humanoid
        pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.Health, true)
        CursedIslandWarsUI.Enabled = false
        u107 = nil
        u114 = nil
        u117.SafeZone(nil)
        for i, j in u108 do
            j:Destroy()
            u108[i] = nil
        end
        for k, n in u109 do
            n:Destroy()
            Humanoid = k:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
            end
        end
        table.clear(u109)
        for m, i5 in u110 do
            i5:Destroy()
        end
        table.clear(u110)
    end)
    u106:Add((State.Changed:Connect(refresh)))
    u106:Add((RunService.RenderStepped:Connect(step)))
    refresh(State.Snapshot)
end

function u117.Hide() -- Line: 600 -- upvalues: u107 (ref)
    if u107 then
        u107.Enabled = false
    end
end

return u117