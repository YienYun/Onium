-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ScrambleBoss.Presentation
-- Decompile time: 25.38 ms

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local Notifications = require(ReplicatedStorage.Client.Notifications)
local CorruptedPlate = require(ReplicatedStorage.Client.Notifications.CorruptedPlate)
local TutorialBeam = require(ReplicatedStorage.Client.WorldFX.TutorialBeam)
local u59 = require(script.Parent.Kit)
local Vfx = require(script.Parent.Vfx)
local u69 = Color3.fromRGB(10, 60, 10)
local u74 = Color3.fromRGB(120, 120, 120)
local u78 = u59.Green:ToHex()
local u79 = {
    Waiting = "DR. SCRAMBLE'S MECH",
    Mech = "DR. SCRAMBLE'S MECH",
    Ejecting = "DR. SCRAMBLE'S MECH",
    Ball = "DR. SCRAMBLE",
    Human = "DR. SCRAMBLE",
    Final = "DR. SCRAMBLE",
    Defeated = "DR. SCRAMBLE",
}
local LocalPlayer = Players.LocalPlayer
local u84 = setmetatable({}, {__mode = "k"})

local function now() -- Line: 53 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow()
end

local function struggleHint() -- Line: 57 -- upvalues: UserInputService (val)
    local LastInputType = UserInputService:GetLastInputType()
    if LastInputType == Enum.UserInputType.Touch then
        return "Tap fast to break free!"
    end
    if string.find(LastInputType.Name, "Gamepad") then
        return "Mash A to break free!"
    end
    return "Mash click or Space to break free!"
end

local function remember(a1, a2, a3) -- Line: 68 -- types: a1: userdata, a2: string
    local Attribute = a1:GetAttribute(a2)
    if Attribute ~= nil then
        return Attribute
    end
    a1:SetAttribute(a2, a3)
    return a3
end

local function tintCoil(a1, a2) -- Line: 79
    -- upvalues: u84 (val), u59 (val), u74 (val)
    local Attribute, Attribute_2, Attribute_3, Attribute_4, Brightness, Color, Color_2, Enabled, v1, v2, v3
    if u84[a1] == a2 then
        return
    end
    u84[a1] = a2
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            Color = j.Color
            Attribute = j:GetAttribute("CoilBaseColor")
            if Attribute == nil then
                j:SetAttribute("CoilBaseColor", Color)
                v1 = Color
            else
                v1 = Attribute
            end
            Brightness = j.Brightness
            Attribute_2 = j:GetAttribute("CoilBaseBrightness")
            if Attribute_2 == nil then
                j:SetAttribute("CoilBaseBrightness", Brightness)
                v2 = Brightness
            else
                v2 = Attribute_2
            end
            v3 = if v4 ~= "Lit" then if v4 ~= "Spent" then v1 else ColorSequence.new(u74) else ColorSequence.new(u59.Green)
            j.Color = v3
            v3 = if v4 ~= "Spent" then v2 else v2 * 0.35
            j.Brightness = v3
        elseif not j:IsA("BasePart") then
            if j:IsA("Light") then
                Enabled = j.Enabled
                Attribute_4 = j:GetAttribute("CoilBaseEnabled")
                if Attribute_4 == nil then
                    j:SetAttribute("CoilBaseEnabled", Enabled)
                    v1 = Enabled
                else
                    v1 = Attribute_4
                end
                v2 = v1 and v4 ~= "Spent"
                j.Enabled = v2
            end
        elseif j.Material == Enum.Material.Neon then
            Color_2 = j.Color
            Attribute_3 = j:GetAttribute("CoilBaseColor")
            if Attribute_3 == nil then
                j:SetAttribute("CoilBaseColor", Color_2)
                v1 = Color_2
            else
                v1 = Attribute_3
            end
            v2 = if v4 ~= "Spent" then v1 else u74
            j.Color = v2
        elseif j:IsA("Light") then
            Enabled = j.Enabled
            Attribute_4 = j:GetAttribute("CoilBaseEnabled")
            if Attribute_4 == nil then
                j:SetAttribute("CoilBaseEnabled", Enabled)
                v1 = Enabled
            else
                v1 = Attribute_4
            end
            v2 = v1 and v4 ~= "Spent"
            j.Enabled = v2
        end
    end
end

local function find(a1, a2) -- Line: 106 -- types: a1: userdata, a2: table
    local v1 = a1
    for i, j in a2 do
        v1 = v1:WaitForChild(j, 10)
        assert(v1, (("ScrambleBossUI is missing %*"):format((table.concat(a2, ".")))))
    end
    return v1
end

local u90 = {}
u90.__index = u90

function u90.new(a1, a2) -- Line: 119
    -- upvalues: LocalPlayer (val), find (val), u90 (val), LightingController (val), RunService (val)
    local ScrambleBossUI = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScrambleBossUI", 20)
    local v1 = {
        Trove = a1,
        Arena = a2,
        Gui = ScrambleBossUI,
        BossName = find(ScrambleBossUI, {"BossHPBar", "BossName"}),
        HealthText = find(ScrambleBossUI, {"BossHPBar", "BarHolder", "HealthAmount"}),
        HealthHolder = find(ScrambleBossUI, {"BossHPBar", "BarHolder"}),
        Bar = find(ScrambleBossUI, {"BossHPBar", "BarHolder", "BarBG", "Bar"}),
        Phantom = find(ScrambleBossUI, {"BossHPBar", "BarHolder", "BarBG", "PhantomBar"}),
        PhaseSegments = find(ScrambleBossUI, {"BossHPBar", "BarHolder", "ShieldBarHolder"}),
        BossScale = find(ScrambleBossUI, {"BossHPBar", "JuiceScale"}),
        TimerLabel = find(ScrambleBossUI, {"BossHPBar", "Frame", "TimerLabel"}),
        TimerTitle = find(ScrambleBossUI, {"BossHPBar", "Frame", "Title"}),
        TimerFrame = find(ScrambleBossUI, {"BossHPBar", "Frame"}),
        Countdown = find(ScrambleBossUI, {"BossHPBar", "Countdown"}),
        CountdownPlate = find(ScrambleBossUI, {"BossHPBar", "Countdown", "Plate"}),
        CountdownBody = find(ScrambleBossUI, {"BossHPBar", "Countdown", "Plate", "Body"}),
        CountdownText = "",
        StopCountdownGlitch = nil,
        Target = find(ScrambleBossUI, {"Target"}),
        TargetTitle = find(ScrambleBossUI, {"Target", "Title"}),
        TargetSub = find(ScrambleBossUI, {"Target", "Sub"}),
        TargetCountdown = find(ScrambleBossUI, {"Target", "Countdown"}),
        Flash = find(ScrambleBossUI, {"Flash"}),
        DisplayedHealth = 1,
        LastHealthFraction = 1,
        LastPhase = "",
        HealthJuice = a1:Extend(),
        PhantomValue = 1,
        CrocTargetUntil = 0,
        Arrow = nil,
        ArrowKey = "",
        ArrowTarget = nil,
        Reticles = {},
        Lit = false,
        HumanFade = 0,
    }
    local u149 = setmetatable(v1, u90)
    u149.Segments = {}
    for i, j in u149.PhaseSegments:GetChildren() do
        if j:IsA("Frame") then
            table.insert(u149.Segments, j)
        end
    end
    table.sort(u149.Segments, function(a1, a2) -- Line: 166 -- types: a1: userdata, a2: userdata
        return a1.LayoutOrder < a2.LayoutOrder
    end)
    u149.Target.Visible = false
    u149.Flash.BackgroundTransparency = 1
    u149.Countdown.Visible = false
    a1:Add(function() -- Line: 174 -- upvalues: ScrambleBossUI (val), u149 (val), LightingController (upval)
        ScrambleBossUI.Enabled = false
        u149:SetCountdown(nil)
        u149:SetArrow("", nil)
        for i, j in u149.Reticles do
            j:Destroy()
        end
        if u149.Lit then
            LightingController.ClearLayer("ScrambleBoss", 2)
        end
    end)
    a1:Connect(RunService.RenderStepped, function(a1) -- Line: 186 -- upvalues: u149 (val) -- types: a1: number
        u149:Step(a1)
    end)
    return u149
end

function u90:PunchHealth(a2) -- Line: 193 -- upvalues: GuiService (val), TweenService (val) -- types: a2: boolean
    self.HealthJuice:Clean()
    if GuiService.ReducedMotionEnabled then
        self.BossScale.Scale = 1
        self.HealthHolder.Rotation = 0
        return
    end
    local v1 = self.Gui.BossHPBar:GetAttribute("HealthPunchScale") or 1.06
    self.BossScale.Scale = if not a2 then v1 else v1 + 0.04
    self.HealthHolder.Rotation = if not (math.random() < 0.5) then 1.5 else -1.5
    v1 = TweenService:Create(self.BossScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
    local v2 = TweenService:Create(self.HealthHolder, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0})
    self.HealthJuice:Add(v1)
    self.HealthJuice:Add(v2)
    v1:Play()
    v2:Play()
end

function u90:SetPhaseSegments(a2) -- Line: 220 -- types: a2: number
    local Fill, v1
    local Segments = self.Segments
    local v2 = nil
    local v3 = nil
    local v4, v5 = self, a2
    for i, j in Segments, v2, v3 do
        Fill = j:FindFirstChild("Fill")
        if Fill then
            v1 = math.clamp(v5 * #v4.Segments - (i - 1), 0, 1)
            Fill.Visible = v1 > 0
            Fill.Size = UDim2.fromScale(v1, 1)
        end
    end
end

function u90:FadeHuman(a2, a3) -- Line: 231 -- types: a2: userdata?, a3: boolean
    local v1 = if not a3 then 0 else if math.floor((os.clock()) * 12) % 2 ~= 0 then 0 else 0.6
    if a2 ~= nil and v1 ~= self.HumanFade then
        self.HumanFade = v1
        for i, j in a2:GetDescendants() do
            if j:IsA("BasePart") or j:IsA("Decal") then
                j.LocalTransparencyModifier = v1
            end
        end
        return
    end
end

function u90.InArena(a1) -- Line: 247 -- upvalues: LocalPlayer (val)
    return LocalPlayer:GetAttribute("InScrambleArena") == true
end

function u90:SetArrow(a2, a3) -- Line: 251 -- upvalues: LocalPlayer (val), TutorialBeam (val) -- types: a2: string
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if a3 ~= nil and HumanoidRootPart ~= nil then
        local Position
        local v1 = Vector3.new((if typeof(a3) ~= "Vector3" then a3.Position else a3).X, HumanoidRootPart.Position.Y, Position.Z)
        self.ArrowKey = a2
        self.ArrowTarget = a3
        if self.Arrow then
            TutorialBeam.Retarget(self.Arrow, v1)
            return
        end
        self.Arrow = TutorialBeam.Attach(v1)
        return
    end
    if self.Arrow then
        TutorialBeam.Destroy(self.Arrow)
        self.Arrow = nil
    end
    self.ArrowKey = if a3 ~= nil then "" else a2
    self.ArrowTarget = nil
end

function u90.Say(a1, a2, a3, a4) -- Line: 275
    -- upvalues: Notifications (val), u59 (val), u69 (val)
    if not a1:InArena() then
        return
    end
    local v1 = false
    if a3 ~= nil then
        v1 = a3 ~= ""
    end
    Notifications.Toast.Show({
        Lane = "Banner",
        SingleLine = true,
        Unique = true,
        Corrupted = true,
        Text = a2,
        Seconds = a4 or 2.5,
        PreText = if not v1 then nil else {Text = ("%*:"):format(a3), Color = u59.Green, StrokeColor = u69},
    })
end

function u90:SetCountdown(a2) -- Line: 294 -- upvalues: CorruptedPlate (val) -- types: a2: string?
    if a2 == nil then
        if self.StopCountdownGlitch then
            self.StopCountdownGlitch()
            self.StopCountdownGlitch = nil
        end
        self.Countdown.Visible = false
        self.TimerFrame.Visible = true
        self.CountdownText = ""
        return
    end
    local CountdownBody = self.CountdownBody
    if a2 ~= self.CountdownText then
        self.CountdownText = a2
        CountdownBody.Text = a2
    end
    local v1 = math.floor(self.CountdownPlate.AbsoluteSize.Y / (math.max(self.BossScale.Scale, 0.01)))
    if v1 > 0 and CountdownBody.TextSize ~= v1 then
        CountdownBody.TextSize = v1
    end
    self.TimerFrame.Visible = false
    self.Countdown.Visible = true
    if self.StopCountdownGlitch == nil then
        self.StopCountdownGlitch = CorruptedPlate.Attach(self.Countdown, self.CountdownPlate)
    end
end

function u90:FlashScreen(a2, a3, a4) -- Line: 325
    -- upvalues: TweenService (val)
    self.Flash.BackgroundColor3 = a2
    self.Flash.BackgroundTransparency = 1 - (a4 or 0.6)
    TweenService:Create(self.Flash, TweenInfo.new(a3), {BackgroundTransparency = 1}):Play()
end

function u90.CrocTarget(a1, a2, a3) -- Line: 331
    -- upvalues: Players (val), Vfx (val), LocalPlayer (val), u59 (val)
    for i, j in a1.Reticles do
        j:Destroy()
        a1.Reticles[i] = nil
    end
    local PlayerByUserId = Players:GetPlayerByUserId(a2)
    local Character = PlayerByUserId and PlayerByUserId.Character and PlayerByUserId.Character:FindFirstChild("HumanoidRootPart")
    local u36 = Character
    if u36 then
        u36 = Vfx.Stamp("CrocTarget", Character, a3, true)
    end
    if PlayerByUserId and u36 then
        a1.Reticles[PlayerByUserId] = u36
        task.delay(a3, function() -- Line: 344 -- upvalues: a1 (val), PlayerByUserId (val), u36 (val)
            if a1.Reticles[PlayerByUserId] == u36 then
                u36:Destroy()
                a1.Reticles[PlayerByUserId] = nil
            end
        end)
    end
    if a2 == LocalPlayer.UserId then
        a1.CrocTargetUntil = os.clock() + a3
        u59.Sound("Tick", nil, 1, 1.4)
        a1:FlashScreen(u59.Red, 0.5, 0.35)
    end
end

function u90:Step(a2) -- Line: 359
    -- upvalues: LightingController (val), u79 (val), Workspace (val), u78 (val), GuiService (val), LocalPlayer (val)
    -- upvalues: u59 (val), UserInputService (val), Players (val), tintCoil (val), u74 (val)
    local v1, v2, v3
    local Arena = self.Arena
    local v4 = self:InArena()
    self.Gui.Enabled = v4
    if v4 ~= self.Lit then
        self.Lit = v4
        if not v4 or not LightingController.Presets.DrScramble then
            LightingController.ClearLayer("ScrambleBoss", 2)
        else
            LightingController.SetLayer("ScrambleBoss", "DrScramble", 160, 2)
        end
    end
    if not v4 then
        self:SetArrow("", nil)
        self:SetCountdown(nil)
        return
    end
    v4 = Arena:GetAttribute("Phase") or "Waiting"
    self.BossName.Text = u79[v4] or "DR. SCRAMBLE"
    local v5 = 1
    local v6 = ""
    local v7 = nil
    if v4 == "Waiting" then
        v1 = Arena:GetAttribute("SpawnsAt") or 0
        v2 = math.ceil((math.max(0, v1 - (Workspace:GetServerTimeNow()))))
        v6 = if not (v1 > 0) then "WAITING FOR CHALLENGERS" else ("ARRIVING IN %*"):format(v2)
        v3 = if v2 ~= 1 then "seconds" else "second"
        v7 = if not (v1 > 0) then "Waiting for challengers" else ("The battle will begin in <font color=\"#%*\">%*</font> %*"):format(u78, v2, v3)
    elseif v4 == "Mech" or v4 == "Ejecting" then
        v1 = Arena:GetAttribute("Health") or 0
        v2 = math.max(Arena:GetAttribute("MaxHealth") or 1, 1)
        v5 = v1 / v2
        v6 = ("%* / %* HP"):format(math.floor(v1), (math.floor(v2)))
        local Mech = Arena:FindFirstChild("Mech")
        v1 = Mech and Mech:GetAttribute("Overheated")
        self.TimerTitle.Text = "Phase"
        self.TimerLabel.Text = if not v1 then if not Arena:GetAttribute("PhaseTwo") then "1/3" else "2/3" else "OVERHEAT"
    elseif v4 == "Ball" then
        v1 = Arena:GetAttribute("CoreStage") or 0
        if not Arena:GetAttribute("BallStunned") then
            v5 = 1 - v1 / 3
            v6 = ("CORE DAMAGE %* / 3"):format(v1)
        else
            v2 = Arena:GetAttribute("CoreHealth") or 0
            v3 = math.max(Arena:GetAttribute("CoreMax") or 1, 1)
            v5 = v2 / v3
            v6 = ("CORE %* / %*"):format(v2, v3)
        end
        self.TimerTitle.Text = "Phase"
        self.TimerLabel.Text = "3/3"
    elseif v4 == "Human" or v4 == "Final" then
        v1 = Arena:GetAttribute("HumanHits") or 0
        v2 = math.max(Arena:GetAttribute("HumanNeeded") or 3, 1)
        v5 = 1 - v1 / v2
        v6 = ("HIT HIM! %* / %*"):format(v1, v2)
        self.TimerTitle.Text = "Phase"
        self.TimerLabel.Text = "FINAL"
    elseif v4 == "Defeated" then
        v5 = 0
        v6 = "DEFEATED!"
        self.TimerTitle.Text = "Phase"
        self.TimerLabel.Text = "WIN"
    end
    self:SetCountdown(v7)
    v5 = math.clamp(v5, 0, 1)
    self.HealthText.Text = v6
    v7 = v4 ~= self.LastPhase
    v6 = v5 < self.LastHealthFraction - 0.001
    if v7 or v6 then
        self:PunchHealth(v7)
    end
    self.LastPhase = v4
    self.LastHealthFraction = v5
    v7 = self.Gui.BossHPBar:GetAttribute("HealthTweenSpeed") or 14
    v6 = self.Gui.BossHPBar:GetAttribute("PhantomTweenSpeed") or 2.5
    v1 = if not GuiService.ReducedMotionEnabled then math.min(1, a2 * v7) else 1
    v7 = if not GuiService.ReducedMotionEnabled then math.min(1, a2 * v6) else 1
    self.DisplayedHealth = self.DisplayedHealth + (v5 - self.DisplayedHealth) * v1
    self.PhantomValue = self.PhantomValue + (v5 - self.PhantomValue) * v7
    self.Bar.Size = UDim2.fromScale(self.DisplayedHealth, 1)
    self.Phantom.Size = UDim2.fromScale(math.max(self.PhantomValue, self.DisplayedHealth), 1)
    self:SetPhaseSegments(v5)
    v1 = Arena:GetAttribute("BallTarget") or 0
    v7 = Arena:GetAttribute("BallCoil") or ""
    v6 = Arena:GetAttribute("SpentCoil") or ""
    v5 = Arena:FindFirstChild("Coils")
    v2 = false
    if v1 == LocalPlayer.UserId then
        v2 = v4 == "Ball"
    end
    v1 = not (v4 ~= "Mech") and Arena:GetAttribute("GrabVictim") or 0
    v3 = false
    if v1 ~= 0 then
        v3 = v1 == LocalPlayer.UserId
    end
    local v8 = math.clamp((Arena:GetAttribute("GrabFree") or 0) / math.max(Arena:GetAttribute("GrabNeeded") or 1, 1), 0, 1)
    if v2 then
        local v9 = math.max(0, (Arena:GetAttribute("BallTargetEnds") or 0) - (Workspace:GetServerTimeNow()))
        self.Target.Visible = true
        self.TargetTitle.Text = "YOU'RE TARGETED!"
        self.TargetSub.Text = if not (v9 > 0) then "HE'S SPEEDING UP! GET TO THE COIL!" else "Lead him into the glowing coil!"
        self.TargetCountdown.Text = string.format("%.2f", v9)
        local TargetCountdown = self.TargetCountdown
        local Red = if not (v9 > 1.5) then u59.Red else Color3.fromRGB(255, 255, 255)
        TargetCountdown.TextColor3 = Red
    elseif v3 then
        self.Target.Visible = true
        self.TargetTitle.Text = "GRABBED!"
        local TargetSub_2 = self.TargetSub
        local LastInputType = UserInputService:GetLastInputType()
        TargetSub_2.Text = if LastInputType ~= Enum.UserInputType.Touch then if not string.find(LastInputType.Name, "Gamepad") then "Mash click or Space to break free!" else "Mash A to break free!" else "Tap fast to break free!"
        self.TargetCountdown.Text = ("%*%%"):format((math.floor(v8 * 100)))
        self.TargetCountdown.TextColor3 = (Color3.new(1, 1, 1)):Lerp(u59.Green, v8)
    elseif os.clock() < self.CrocTargetUntil then
        self.Target.Visible = true
        self.TargetTitle.Text = "TARGETED!"
        self.TargetSub.Text = "The croc is coming for you. RUN!"
        self.TargetCountdown.Text = string.format("%.1f", self.CrocTargetUntil - os.clock())
        self.TargetCountdown.TextColor3 = u59.Red
    elseif v1 == 0 then
        self.Target.Visible = false
    else
        local PlayerByUserId = Players:GetPlayerByUserId(v1)
        self.Target.Visible = true
        self.TargetTitle.Text = ("SAVE %*!"):format((string.upper(PlayerByUserId and PlayerByUserId.DisplayName or "THEM")))
        self.TargetSub.Text = "Get under the claw and hit it!"
        self.TargetCountdown.Text = ("%*%%"):format((math.floor(v8 * 100)))
        self.TargetCountdown.TextColor3 = (Color3.new(1, 1, 1)):Lerp(u59.Green, v8)
    end
    if v5 then
        local ZoneRing, v10, v11, v12
        for i, j in v5:GetChildren() do
            v8 = j:FindFirstChild("Zone")
            ZoneRing = j:FindFirstChild("ZoneRing")
            v10 = false
            if j.Name == v7 then
                v10 = v4 == "Ball"
            end
            v11 = not v10
            if v11 then
                v11 = false
                if j.Name == v6 then
                    v11 = v4 == "Ball"
                end
            end
            v12 = (math.sin((os.clock()) * 6) + 1) / 2
            tintCoil(j, if not v10 then if not v11 then "Idle" else "Spent" else "Lit")
            if v8 then
                v8.Transparency = if not v10 then 0.8 else v12 * 0.3 + 0.35
                v8.Color = if not v10 then if not v11 then Color3.fromRGB(90, 220, 255) else u74 else u59.Green
            end
            if ZoneRing then
                ZoneRing.Transparency = if not v10 then 0.4 else 0
                ZoneRing.Color = if not v10 then if not v11 then Color3.fromRGB(200, 250, 255) else u74 else u59.Green
            end
        end
    end
    v6 = Arena:FindFirstChild("ScrambleHuman")
    local v13 = false
    if v4 == "Human" then
        v13 = false
        if v6 ~= nil then
            v13 = v6:GetAttribute("Immune") == true
        end
    end
    self:FadeHuman(v6, v13)
    v6 = Arena:FindFirstChild("Mech")
    local GrabRescue = v6 and v6:FindFirstChild("GrabRescue")
    if v2 and v5 and v5:FindFirstChild(v7) then
        local v14 = v5:FindFirstChild(v7)
        local Top = v14:FindFirstChild("Top")
        if Top and Top:IsA("BasePart") then
            self:SetArrow(("coil:%*"):format(v7), Top)
            return
        end
        local BoundingBox, BoundingBox_2 = v14:GetBoundingBox()
        self:SetArrow(("coil:%*"):format(v7), BoundingBox.Position + (Vector3.new(0, BoundingBox_2.Y / 2, 0)))
        return
    end
    if v1 ~= 0 and not v3 and GrabRescue then
        self:SetArrow("rescue", GrabRescue)
        return
    end
    if v6 and v6:GetAttribute("Overheated") and v4 == "Mech" then
        self:SetArrow("mech", (v6:FindFirstChild("Torso")))
        return
    end
    if v4 == "Ball" and Arena:GetAttribute("BallStunned") then
        local Ball = Arena:FindFirstChild("Ball")
        self:SetArrow("ball", Ball and Ball.PrimaryPart or nil)
        return
    end
    if v4 ~= "Human" then
        self:SetArrow("", nil)
        return
    end
    local ScrambleHuman = Arena:FindFirstChild("ScrambleHuman")
    self:SetArrow("human", ScrambleHuman and ScrambleHuman.PrimaryPart or nil)
end

return u90