-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.Cutscenes.MoonScene
-- Decompile time: 14.47 ms

local ContentProvider = game:GetService("ContentProvider")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local CutsceneHelperFunctions = require(ReplicatedStorage.Controllers.Game.AdminAbuseClientController.CutsceneHelperFunctions)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Parent.Parent.Scenes)
local u76 = require(script.Parent.Parent.Transition)
local u81 = Color3.new(0, 0, 0)

local function settle(a1, a2) -- Line: 75 -- upvalues: TweenService (val) -- types: a1: userdata, a2: table
    TweenService:Create(a1, TweenInfo.new(0), a2):Play()
    for i, j in a2 do
        a1[i] = j
    end
end

local function setEmitting(a1, a2) -- Line: 82 -- types: a1: userdata, a2: boolean
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") or j:IsA("Trail") or j:IsA("Beam") then
            j.Enabled = a2
        end
    end
end

local function emit(a1) -- Line: 91 -- types: a1: userdata
    local Attribute_3
    for i, j in a1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            local Attribute = j:GetAttribute("EmitCount")
            local Attribute_2 = j:GetAttribute("EmitDuration")
            Attribute_3 = j:GetAttribute("EmitDelay")
            task.delay(if type(Attribute_3) ~= "number" then 0 else Attribute_3, function() -- Line: 100 -- upvalues: Attribute (val), j (val), Attribute_2 (val)
                if type(Attribute) == "number" and Attribute > 0 then
                    j:Emit(Attribute)
                end
                if type(Attribute_2) == "number" and Attribute_2 > 0 then
                    j.Enabled = true
                    task.delay(Attribute_2, function() -- Line: 106 -- upvalues: j (upval)
                        j.Enabled = false
                    end)
                end
            end)
        end
    end
end

local function hidePlayers(a1, a2) -- Line: 115 -- upvalues: Players (val), RunService (val) -- types: a2: string
    local u6 = ("PumpkinBossMoonSceneHide%*"):format(a2)
    local u7 = {}
    local u8 = {}
    local u9 = {}

    local function hide() -- Line: 121 -- upvalues: Players (upval), u7 (val), u8 (val), u9 (val)
        local Character
        for i, j in Players:GetPlayers() do
            Character = j.Character
            if Character ~= nil then
                for k, n in Character:GetDescendants() do
                    if n:IsA("BasePart") or n:IsA("Decal") then
                        if u7[n] == nil then
                            u7[n] = n.LocalTransparencyModifier
                        end
                        n.LocalTransparencyModifier = 1
                    elseif not n:IsA("BillboardGui") then
                        if n:IsA("Humanoid") and u9[n] == nil then
                            u9[n] = n.DisplayDistanceType
                            n.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                        end
                    elseif u8[n] == nil then
                        u8[n] = n.Enabled
                        n.Enabled = false
                    elseif n:IsA("Humanoid") and u9[n] == nil then
                        u9[n] = n.DisplayDistanceType
                        n.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                    end
                end
            end
        end
    end

    hide()
    RunService:BindToRenderStep(u6, Enum.RenderPriority.Camera.Value + 1, hide)
    a1:Add(function() -- Line: 146 -- upvalues: RunService (upval), u6 (val), u7 (val), u8 (val), u9 (val)
        RunService:UnbindFromRenderStep(u6)
        for i, j in u7 do
            i.LocalTransparencyModifier = j
        end
        for k, n in u8 do
            k.Enabled = n
        end
        for m, i5 in u9 do
            m.DisplayDistanceType = i5
        end
    end)
end

return table.freeze({
    Play = function(self, a2) -- Line: 160
        -- upvalues: Trove (val), CutsceneHelperFunctions (val), Workspace (val), HiddenUIHandler (val)
        -- upvalues: MusicDirector (val), hidePlayers (val), u81 (val), TweenService (val), emit (val)
        -- upvalues: setEmitting (val), RunService (val), u76 (val), LightingController (val), Lighting (val)
        -- upvalues: SoundService (val), ContentProvider (val)
        local Assets = a2.Assets
        local u5 = Trove.new()
        local u9 = CutsceneHelperFunctions.GetHelperFunctions(u5)
        local CurrentCamera = Workspace.CurrentCamera
        local CutsceneUI = self.Player.PlayerGui.CutsceneUI
        local Black = CutsceneUI.Black
        local Vignette = CutsceneUI.Vignette
        local u17 = false
        u5:Add((HiddenUIHandler.Acquire()))
        local u27 = MusicDirector.Suppress()
        u5:Add(function() -- Line: 180 -- upvalues: a2 (val), u27 (val)
            if a2.HoldBlack then
                task.delay(3, u27)
                return
            end
            u27()
        end)
        hidePlayers(u5, self.Name)
        CutsceneUI.Enabled = true
        Black.BackgroundColor3 = u81
        Black.Visible = true
        Vignette.ImageTransparency = 1
        Vignette.Visible = true
        local v1 = self.At + 0.5 - Workspace:GetServerTimeNow()
        TweenService:Create(Black, TweenInfo.new((math.max(v1, 0))), {BackgroundTransparency = 0}):Play()
        u5:Add(function() -- Line: 196 -- upvalues: Black (val), u81 (upval), TweenService (upval), Vignette (val)
            local v1 = Black
            local v2 = {BackgroundTransparency = 1, BackgroundColor3 = u81}
            TweenService:Create(v1, TweenInfo.new(0), v2):Play()
            for i, j in v2 do
                v1[i] = j
            end
            Black.Visible = false
            v1 = Vignette
            v2 = {ImageTransparency = 1, ImageColor3 = u81}
            TweenService:Create(v1, TweenInfo.new(0), v2):Play()
            for k, n in v2 do
                v1[k] = n
            end
            Vignette.Visible = false
        end)
        local u76_2 = u5:Clone(Assets[("%*Rigs"):format(a2.Prefix)])
        local u85 = u5:Clone(Assets[("%*VFX"):format(a2.Prefix)])
        local u94 = u5:Clone(Assets[("%*Set"):format(a2.Prefix)])
        local u98 = Assets.CutsceneMusic:Clone()
        u5:Add(function() -- Line: 207 -- upvalues: u98 (val), TweenService (upval)
            if not u98.IsPlaying then
                u98:Destroy()
                return
            end
            local v1 = TweenService:Create(u98, TweenInfo.new(0.4), {Volume = 0})
            v1.Completed:Once(function() -- Line: 213 -- upvalues: u98 (upval)
                u98:Destroy()
            end)
            v1:Play()
        end)
        local u105 = u76_2.CameraRig[a2.CameraPart]
        local u112 = a2.Build({
            Rigs = u76_2,
            Vfx = u85,
            Set = u94,
            SetProperty = u9.SetProperty,
            TweenProperty = u9.TweenProperty,
            Emit = emit,
            SetEmitting = setEmitting,
        })
        local u113 = {}
        for i in u112 do
            table.insert(u113, i)
        end
        table.sort(u113)
        local FieldOfView = CurrentCamera.FieldOfView
        u5:Add(function() -- Line: 235
            -- upvalues: RunService (upval), CurrentCamera (val), FieldOfView (val), TweenService (upval), self (val)
            RunService:UnbindFromRenderStep("PumpkinBossMoonScene")
            local v1 = CurrentCamera
            local v2 = {FieldOfView = FieldOfView}
            TweenService:Create(v1, TweenInfo.new(0), v2):Play()
            for i, j in v2 do
                v1[i] = j
            end
            CurrentCamera.CameraType = Enum.CameraType.Custom
            local Character = self.Player.Character
            CurrentCamera.CameraSubject = if not Character then nil else Character:FindFirstChildOfClass("Humanoid")
        end)

        local function finish() -- Line: 245 -- upvalues: u17 (ref), u76 (upval), u5 (val), a2 (val)
            if u17 then
                return
            end
            u76.Cover(true, 3)
            if not u17 then
                u17 = true
                u5:Destroy()
            end
            if not a2.HoldBlack then
                u76.Reveal(0.5)
            end
        end

        local function begin() -- Line: 256
            -- upvalues: self (val), LightingController (upval), Assets (val), u5 (val), Lighting (upval), a2 (val)
            -- upvalues: u76_2 (val), u9 (val), Workspace (upval), u98 (val), SoundService (upval), RunService (upval)
            -- upvalues: u105 (val), CurrentCamera (val), u113 (val), u112 (val), finish (val)
            local Animation, v1, v2
            local u5_2 = ("PumpkinBoss%*"):format(self.Name)
            LightingController.SetAuthoredLayer(u5_2, Assets.SceneLighting, 999, 0)
            u5:Add(function() -- Line: 259 -- upvalues: LightingController (upval), u5_2 (val)
                LightingController.ClearLayer(u5_2, 0)
            end)
            for i, j in Assets.LightingAssets:GetChildren() do
                v1 = Lighting
                if v1:FindFirstChild(j.Name) == nil then
                    v1 = u5:Clone(j)
                    v1.Parent = Lighting
                end
            end
            if a2.Setup then
                a2.Setup(u5)
            end
            local u39 = {}
            local u145 = nil
            for k, n in u76_2:GetChildren() do
                Animation = n:FindFirstChild("Animation")
                v2 = u9.LoadAnimationIntoRig(n, Animation.AnimationId)
                table.insert(u39, v2)
                if n.Name == "CameraRig" then
                    u145 = v2
                end
            end
            assert(u145, (("%* has no CameraRig"):format(self.Name)))
            local v3 = math.max((Workspace:GetServerTimeNow()) - self.At - 0.5, 0)
            local u77 = os.clock() - v3
            for m, i5 in u39 do
                i5:Play(0)
                i5.TimePosition = v3
            end
            u98.Parent = SoundService
            u98.TimePosition = v3
            u98:Play()
            RunService:BindToRenderStep("PumpkinBossMoonScene", Enum.RenderPriority.Camera.Value + 1, function() -- Line: 294 -- upvalues: u145 (ref), u105 (upval), CurrentCamera (upval)
                if u145.Length <= 0 then
                    return
                end
                local CFrame = u105.CFrame
                CurrentCamera.CameraType = Enum.CameraType.Scriptable
                CurrentCamera.CFrame = CFrame
                CurrentCamera.Focus = CFrame
            end)
            local u107 = 1
            u5:Connect(RunService.Heartbeat, function() -- Line: 305 -- upvalues: u77 (val), u39 (val), u98 (upval), u107 (ref), u113 (upval), u112 (upval)
                local v1
                local v2 = os.clock() - u77
                for i, j in u39 do
                    if not (j.Length <= 0) and j.Speed ~= 0 then
                        v1 = j.Length - 0.05
                        if v1 <= v2 then
                            j.TimePosition = v1
                            j:AdjustSpeed(0)
                        elseif 0.4 < (math.abs(j.TimePosition - v2)) then
                            j.TimePosition = v2
                        end
                    end
                end
                if u98.IsPlaying and 0.4 < (math.abs(u98.TimePosition - v2)) then
                    u98.TimePosition = v2
                end
                local v3 = v2 * 60
                while u107 <= #u113 do
                    if not (u113[u107] <= v3) then
                        break
                    end
                    for k, n in u112[u113[u107]] do
                        task.spawn(n)
                    end
                    u107 = u107 + 1
                end
            end)
            task.delay(math.max(a2.Frames / 60 - v3, 0), finish)
        end

        u5:Add((task.spawn(function() -- Line: 336
            -- upvalues: u76_2 (val), Workspace (upval), u85 (val), u94 (val), ContentProvider (upval), self (val)
            -- upvalues: begin (val)
            u76_2.Parent = Workspace
            u85.Parent = Workspace
            u94.Parent = Workspace
            local v1 = {}
            for i, j in u76_2:GetChildren() do
                table.insert(v1, (j:FindFirstChild("Animation")))
            end
            ContentProvider:PreloadAsync(v1)
            v1 = self.At + 0.5 - Workspace:GetServerTimeNow()
            if v1 > 0 then
                task.wait(v1)
            end
            begin()
        end)))
        return {
            Stop = function() -- Line: 170 -- upvalues: u17 (ref), u5 (val)
                if u17 then
                    return
                end
                u17 = true
                u5:Destroy()
            end,
        }
    end,
    HidePlayers = hidePlayers,
})