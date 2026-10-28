-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.RedLightGreenLight
-- Decompile time: 12.22 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Cutscene = require(script.Cutscene)
local RedLightGreenLightFlags = require(ReplicatedStorage.Shared.Flags.RedLightGreenLightFlags)
local Fx = require(script.Fx)
local Giant = require(script.Giant)
local Hud = require(script.Hud)
local Laser = require(script.Laser)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Shake = require(ReplicatedStorage.Client.Shake)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u61 = Color3.fromRGB(255, 214, 89)
local u64 = table.freeze({
    Giant = "RLGL_Giant",
    GiantHeight = "RLGL_GiantHeight",
    RiseAt = "RLGL_RiseAt",
    Light = "RLGL_Light",
    FakeAt = "RLGL_FakeAt",
    EggPosition = "RLGL_EggPosition",
    CarrierUserId = "RLGL_CarrierUserId",
    Lives = "RLGL_Lives",
})
local LocalPlayer = Players.LocalPlayer
local u66 = nil
local u67 = nil
local u68 = nil
local u69 = nil
local u70 = 0
local u71 = {}

local function currentLight() -- Line: 56 -- upvalues: Workspace (val), u64 (val)
    local Attribute = Workspace:GetAttribute(u64.Light)
    if type(Attribute) == "string" then
        return Attribute
    end
    return "Rise"
end

local function isRedLight() -- Line: 62 -- upvalues: Workspace (val), u64 (val)
    local Attribute = Workspace:GetAttribute(u64.Light)
    return (if type(Attribute) ~= "string" then "Rise" else Attribute) == "Red"
end

local function buildBeacon(a1) -- Line: 66 -- upvalues: Fx (val), u61 (val)
    local Beam
    local v1 = Fx.Holder(Vector3.new(0, 0, 0), "EggBeacon")
    local v2 = Fx.Holder(Vector3.new(0, 0, 0), "EggBeaconTop")
    local Attachment = Instance.new("Attachment")
    local Attachment_2 = Instance.new("Attachment")
    Attachment.Parent = v1
    Attachment_2.Parent = v2
    local v3 = {7, 18}
    local v4 = nil
    local v5 = nil
    local v6 = a1
    for i, j in v3, v4, v5 do
        Beam = Instance.new("Beam")
        Beam.Attachment0 = Attachment
        Beam.Attachment1 = Attachment_2
        Beam.Texture = "rbxassetid://16288356764"
        Beam.TextureMode = Enum.TextureMode.Stretch
        Beam.TextureSpeed = 0.4
        Beam.LightEmission = 1
        Beam.Brightness = 2
        Beam.FaceCamera = true
        Beam.Color = ColorSequence.new(u61)
        Beam.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, if i ~= 1 then 0.55 else 0.1),
            NumberSequenceKeypoint.new(0.7, if i ~= 1 then 0.8 else 0.5),
            (NumberSequenceKeypoint.new(1, 1)),
        })
        Beam.Width0 = j
        Beam.Width1 = j * 0.4
        Beam.Parent = v1
    end
    local PointLight = Instance.new("PointLight")
    PointLight.Color = u61
    PointLight.Range = 40
    PointLight.Brightness = 3
    PointLight.Parent = v1
    v6:Add(v1)
    v6:Add(v2)
    return v1, v2
end

local function updateBeacon(a1, a2, a3) -- Line: 110
    -- upvalues: Workspace (val), u64 (val), Players (val)
    local v1
    local Attribute = Workspace:GetAttribute(u64.EggPosition)
    if typeof(Attribute) ~= "Vector3" then
        a1.Position = Vector3.new(0, -5000, 0)
        a2.Position = Vector3.new(0, -5000, 0)
        return
    end
    local Attribute_2 = Workspace:GetAttribute(u64.CarrierUserId)
    local PlayerByUserId = if type(Attribute_2) ~= "number" then nil else Players:GetPlayerByUserId(Attribute_2)
    local Character = if PlayerByUserId == nil then nil else PlayerByUserId.Character
    local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
    local Position = if HumanoidRootPart == nil then Attribute else if not HumanoidRootPart:IsA("BasePart") then Attribute else HumanoidRootPart.Position
    a1.Position = if not (a1.Position.Y < -1000) then a1.Position:Lerp(Position, (math.min(a3 * 12, 1))) else Position
    a2.Position = v1 + Vector3.new(0, 900, 0)
end

local function applyLight(a1) -- Line: 134
    -- upvalues: u67 (ref), u68 (ref), u69 (ref), Hud (val), Giant (val), Fx (val), Shake (val)
    local v1 = u67
    local v2 = u68
    local v3 = false
    if u69 ~= nil then
        v3 = not u69.Done
    end
    if v2 ~= nil then
        Hud.SetLight(v2, a1)
    end
    if v1 ~= nil and not v3 then
        if a1 == "Red" then
            Giant.Face(v1, true)
            Giant.SetEyes(v1, 0.75)
            Fx.Sound({"Sounds", "ScrambleBoss", "Swoosh"}, nil, 1.5, 0.75)
            Fx.Sound({"Sounds", "ScrambleBoss", "Stomp"}, nil, 0.7, 0.8)
            Fx.Sound({"Sounds", "ScrambleBoss", "Tick"}, nil, 1.2, 0.6)
            Shake.Play({Seconds = 0.45, Magnitude = 1.1, Shape = "Fade"})
            return
        end
        if a1 == "Green" then
            Giant.Face(v1, false)
            Giant.SetEyes(v1, 0)
            Fx.Sound({"Sounds", "ScrambleBoss", "Swoosh"}, nil, 0.9, 1.1)
            return
        end
        if a1 == "Wait" then
            Giant.Face(v1, false)
            Giant.SetEyes(v1, 0)
        end
        return
    end
end

local function onFake() -- Line: 164 -- upvalues: u67 (ref), Workspace (val), u64 (val), Giant (val), Fx (val)
    local v1 = u67
    if v1 ~= nil then
        local Attribute = Workspace:GetAttribute(u64.Light)
        if (if type(Attribute) ~= "string" then "Rise" else Attribute) == "Green" then
            Giant.TwitchHead(v1, if not (math.random() < 0.5) then 1 else -1)
            Fx.Sound({"Sounds", "ScrambleBoss", "Tick"}, nil, 1, 0.9)
            return
        end
    end
end

local function refreshLives() -- Line: 175
    -- upvalues: u68 (ref), LocalPlayer (val), u64 (val), RedLightGreenLightFlags (val), Hud (val)
    local v1 = u68
    if v1 == nil then
        return
    end
    local Attribute = LocalPlayer:GetAttribute(u64.Lives)
    local v2 = RedLightGreenLightFlags.Lives:Get()
    Hud.SetLives(v1, if type(Attribute) ~= "number" then v2 else Attribute, v2)
end

local function sinkGiant(a1) -- Line: 188 -- upvalues: Fx (val), RunService (val), Giant (val)
    local u2 = os.clock()
    local u3 = nil
    Fx.Sound({"Sounds", "ScrambleBoss", "Rumble"}, a1.Ground.Position, 1, 1, 6000)
    RunService.RenderStepped:Connect(function(a1_2) -- Line: 193 -- upvalues: u2 (val), a1 (val), Giant (upval), u3 (ref)
        local v1 = math.clamp((os.clock() - u2) / 1.8, 0, 1)
        a1.Rise = 1 - v1 * v1
        Giant.Update(a1, a1_2)
        if v1 >= 1 then
            if u3 ~= nil then
                u3:Disconnect()
            end
            Giant.Destroy(a1)
        end
    end)
end

local function begin(a1, a2) -- Line: 209
    -- upvalues: Workspace (val), u64 (val), u70 (ref), ReplicatedStorage (val), u66 (ref), Hud (val), u68 (ref)
    -- upvalues: u67 (ref), Giant (val), u69 (ref), Cutscene (val), applyLight (val), LocalPlayer (val)
    -- upvalues: RedLightGreenLightFlags (val), buildBeacon (val), onFake (val), refreshLives (val), Remotes (val)
    -- upvalues: Laser (val), isRedLight (val), RunService (val), updateBeacon (val)
    while true do
        if Workspace:GetAttribute(u64.Giant) ~= nil or a1 ~= u70 then
            break
        end
        task.wait(0.1)
    end
    if a1 ~= u70 then
        return
    end
    local RedLightGreenLightPersona = ReplicatedStorage:FindFirstChild("RedLightGreenLightPersona") or ReplicatedStorage:WaitForChild("RedLightGreenLightPersona", 3)
    if a1 ~= u70 then
        return
    end
    local v1 = u66
    local Attribute = Workspace:GetAttribute(u64.Giant)
    local Attribute_2 = Workspace:GetAttribute(u64.GiantHeight)
    local v2 = if RedLightGreenLightPersona == nil then nil else if not RedLightGreenLightPersona:IsA("Model") then nil else RedLightGreenLightPersona
    local v3 = Hud.Mount(v2)
    u68 = v3
    if v2 ~= nil then
        u67 = Giant.new(v2, Attribute, if type(Attribute_2) ~= "number" then 520 else Attribute_2)
    end
    v2 = u67
    local v4 = Workspace:GetAttribute(u64.RiseAt)
    local v5 = false
    if type(a2) == "table" then
        v5 = a2.WasInProgress == true
    end
    local v6 = not v5
    if v6 then
        v6 = false
        if type(v4) == "number" then
            v6 = Workspace:GetServerTimeNow() - v4 < 6
        end
    end
    if v2 == nil or v3 == nil or not v6 then
        if v2 ~= nil then
            local Face = Giant.Face
            v5 = Workspace:GetAttribute(u64.Light)
            Face(v2, (if type(v5) ~= "string" then "Rise" else v5) == "Red", true)
        end
        if v3 ~= nil then
            Hud.SetBoardShown(v3, true)
        end
    else
        u69 = Cutscene.Play(v2, v3, v4)
    end
    local v7 = applyLight
    v6 = Workspace:GetAttribute(u64.Light)
    v7(if type(v6) ~= "string" then "Rise" else v6)
    v2 = u68
    if v2 ~= nil then
        v4 = LocalPlayer:GetAttribute(u64.Lives)
        v3 = RedLightGreenLightFlags.Lives:Get()
        Hud.SetLives(v2, if type(v4) ~= "number" then v3 else v4, v3)
    end
    local u216, u217 = buildBeacon(v1)
    v1:Connect(Workspace:GetAttributeChangedSignal(u64.Light), function() -- Line: 262 -- upvalues: applyLight (upval), Workspace (upval), u64 (upval)
        local v1 = applyLight
        local Attribute = Workspace:GetAttribute(u64.Light)
        v1(if type(Attribute) ~= "string" then "Rise" else Attribute)
    end)
    v1:Connect(Workspace:GetAttributeChangedSignal(u64.FakeAt), onFake)
    v1:Connect(LocalPlayer:GetAttributeChangedSignal(u64.Lives), refreshLives)
    v1:Connect(Remotes.RedLightGreenLight.Caught.OnClientEvent, function(a1, a2, a3, a4, a5) -- Line: 269
        -- upvalues: u67 (upval), Laser (upval), isRedLight (upval)
        local v1 = u67
        if v1 ~= nil and type(a1) == "number" and typeof(a2) == "Vector3" and type(a5) == "number" then
            Laser.Fire(v1, a1, a2, a5, a4 == true, isRedLight)
            return
        end
    end)
    v1:Connect(Remotes.RedLightGreenLight.Cover.OnClientEvent, function(a1) -- Line: 290 -- upvalues: u68 (upval), Hud (upval) -- types: a1: number
        if u68 ~= nil and type(a1) == "number" then
            Hud.Cover(u68, (math.clamp(a1, 0.1, 2)))
        end
    end)
    v1:Connect(RunService.RenderStepped, function(a1) -- Line: 295
        -- upvalues: u67 (upval), u69 (upval), Giant (upval), u68 (upval), Hud (upval), updateBeacon (upval), u216 (val)
        -- upvalues: u217 (val)
        local v1 = u67
        local v2 = u69
        if v1 ~= nil then
            if v2 == nil or v2.Done then
                v1.Rise = 1
            end
        end
        if v1 ~= nil then
            Giant.Update(v1, a1)
        end
        if u68 ~= nil then
            Hud.Update(u68, a1, v1)
        end
        updateBeacon(u216, u217, a1)
    end)
end

function u71.StartEvent(a1, a2, a3) -- Line: 319
    -- upvalues: u71 (val), u70 (ref), u66 (ref), Trove (val), begin (val)
    u71:StopEvent()
    u70 = u70 + 1
    Trove.new()
    task.spawn(begin, u70, a3)
end

function u71.StopEvent(a1) -- Line: 329
    -- upvalues: u70 (ref), u69 (ref), u66 (ref), u67 (ref), sinkGiant (val), u68 (ref), Hud (val)
    u70 = u70 + 1
    local v1 = u69
    u69 = nil
    if v1 ~= nil then
        v1.Stop()
    end
    if u66 ~= nil then
        u66:Clean()
        u66 = nil
    end
    v1 = u67
    u67 = nil
    if v1 ~= nil then
        sinkGiant(v1)
    end
    v1 = u68
    u68 = nil
    if v1 ~= nil then
        Hud.Unmount(v1)
    end
end

return u71