-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.TrexRun
-- Decompile time: 16.05 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Cutscene = require(script.Cutscene)
local Fx = require(script.Fx)
local Herd = require(script.Herd)
local Hud = require(script.Hud)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Shake = require(ReplicatedStorage.Client.Shake)
local TrexRunHerd = require(ReplicatedStorage.Shared.Modules.TrexRunHerd)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u57 = Color3.fromRGB(255, 214, 89)
local Attributes = TrexRunHerd.Attributes
local LocalPlayer = Players.LocalPlayer
local u60 = nil
local u61 = nil
local u62 = nil
local u63 = nil
local u64 = 0
local u65 = {}

local function attribute(a1) -- Line: 46 -- upvalues: Workspace (val) -- types: a1: string
    return Workspace:GetAttribute(a1)
end

local function buildBeacon(a1) -- Line: 50 -- upvalues: Fx (val), u57 (val)
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
        Beam.Color = ColorSequence.new(u57)
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
    PointLight.Color = u57
    PointLight.Range = 40
    PointLight.Brightness = 3
    PointLight.Parent = v1
    v6:Add(v1)
    v6:Add(v2)
    return v1, v2
end

local function updateBeacon(a1, a2, a3) -- Line: 94
    -- upvalues: Attributes (val), Workspace (val), Players (val), LocalPlayer (val)
    local PlayerByUserId, v1
    local v2 = Workspace:GetAttribute(Attributes.EggPosition)
    if typeof(v2) ~= "Vector3" then
        a1.Position = Vector3.new(0, -5000, 0)
        a2.Position = Vector3.new(0, -5000, 0)
        return
    end
    local v3 = Workspace:GetAttribute(Attributes.CarrierUserId)
    if (if type(v3) ~= "number" then nil else Players:GetPlayerByUserId(v3)) == LocalPlayer then
        a1.Position = Vector3.new(0, -5000, 0)
        a2.Position = Vector3.new(0, -5000, 0)
        return
    end
    local Character = if PlayerByUserId == nil then nil else PlayerByUserId.Character
    local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
    local Position = if HumanoidRootPart == nil then v2 else if not HumanoidRootPart:IsA("BasePart") then v2 else HumanoidRootPart.Position
    a1.Position = if not (a1.Position.Y < -1000) then a1.Position:Lerp(Position, (math.min(a3 * 12, 1))) else Position
    a2.Position = v1 + Vector3.new(0, 900, 0)
end

local function buildCarrierHighlight(a1) -- Line: 125 -- upvalues: u57 (val), Fx (val)
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "TrexCarrierHighlight"
    Highlight.FillColor = u57
    Highlight.OutlineColor = u57
    Highlight.FillTransparency = 0.85
    Highlight.OutlineTransparency = 0.4
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Enabled = false
    Highlight.Parent = Fx.Folder()
    a1:Add(Highlight)
    return Highlight
end

local function updateCarrierHighlight(a1) -- Line: 141
    -- upvalues: Attributes (val), Workspace (val), Players (val)
    local Character
    local v1 = Workspace:GetAttribute(Attributes.CarrierUserId)
    local PlayerByUserId = if type(v1) ~= "number" then nil else Players:GetPlayerByUserId(v1)
    if (if PlayerByUserId == nil then nil else PlayerByUserId.Character) == nil then
        a1.Enabled = false
        a1.Adornee = nil
        return
    end
    if a1.Adornee ~= Character then
        a1.Adornee = Character
    end
    a1.Enabled = true
end

local function carrierPlayer() -- Line: 161 -- upvalues: Attributes (val), Workspace (val), Players (val)
    local v1 = Workspace:GetAttribute(Attributes.CarrierUserId)
    if type(v1) == "number" then
        return (Players:GetPlayerByUserId(v1))
    end
    return nil
end

local function refreshStatus() -- Line: 167
    -- upvalues: u62 (ref), Attributes (val), Workspace (val), Players (val), Hud (val), LocalPlayer (val)
    local v1 = u62
    if v1 == nil then
        return
    end
    local v2 = Workspace:GetAttribute(Attributes.CarrierUserId)
    local v3 = if type(v2) ~= "number" then nil else Players:GetPlayerByUserId(v2)
    if Workspace:GetAttribute(Attributes.Phase) == "Wait" then
        Hud.SetObjective(v1, "Starts at sunrise")
        return
    end
    if v3 == LocalPlayer then
        Hud.SetObjective(v1, "Run it home!")
        return
    end
    if v3 ~= nil then
        Hud.SetObjective(v1, (("%* has the egg!"):format(v3.DisplayName)))
        return
    end
    Hud.SetObjective(v1, "Steal the TRex Egg!")
end

local function updateProgress(a1, a2, a3) -- Line: 187
    -- upvalues: Attributes (val), Workspace (val), Players (val), TrexRunHerd (val), Hud (val)
    local Position
    local v1 = Workspace:GetAttribute(Attributes.CarrierUserId)
    local v2 = if type(v1) ~= "number" then nil else Players:GetPlayerByUserId(v1)
    local Character = if v2 == nil then nil else v2.Character
    v2 = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
    if typeof(if v2 == nil or not v2:IsA("BasePart") then Workspace:GetAttribute(Attributes.EggPosition) else v2.Position) ~= "Vector3" then
        return
    end
    v2 = math.max(TrexRunHerd.Locate(a2, Position), 0)
    Hud.SetProgress(a1, 1 - v2 / math.max(a3, 1), (("%* studs"):format((math.floor(v2 / 10)) * 10)))
end

local function onHerdTurned(a1) -- Line: 204
    -- upvalues: u61 (ref), Attributes (val), Workspace (val), Herd (val), Fx (val), Shake (val)
    local v1 = u61
    local Attribute = Workspace:GetAttribute(Attributes.Herd)
    if v1 ~= nil and a1 ~= nil and a1 ~= Attribute then
        Herd.Roar(v1, 1)
        Fx.Sound({"Sounds", "ScrambleBoss", "Rumble"}, nil, 1.1, 0.9)
        Shake.Play({Seconds = 0.8, Magnitude = 1.4, Shape = "Fade"})
        return
    end
end

local function onTrampled(a1, a2, a3) -- Line: 217
    -- upvalues: Herd (val), LocalPlayer (val), u62 (ref), Hud (val), Fx (val), Shake (val)
    if type(a1) == "number" and typeof(a2) == "Vector3" then
        Herd.Dust(a2, 1)
        if a1 ~= LocalPlayer.UserId then
            Fx.Sound({"Sounds", "ScrambleBoss", "HeavyLand"}, a2, 1, 1.1, 300)
            return
        end
        if u62 ~= nil then
            Hud.Flash(u62)
        end
        Fx.Sound({"Sounds", "ScrambleBoss", "HeavyLand"}, nil, 1.3, 1.1)
        Shake.Play({Seconds = 0.6, Magnitude = 2.4, Shape = "Fade"})
        return
    end
end

local function begin(a1, a2) -- Line: 237
    -- upvalues: TrexRunHerd (val), Workspace (val), u64 (ref), ReplicatedStorage (val), u60 (ref), Herd (val)
    -- upvalues: u61 (ref), Hud (val), Attributes (val), u62 (ref), Remotes (val), onTrampled (val), u63 (ref)
    -- upvalues: Cutscene (val), refreshStatus (val), buildBeacon (val), u57 (val), Fx (val), onHerdTurned (val)
    -- upvalues: RunService (val), Shake (val), LocalPlayer (val), updateProgress (val), updateBeacon (val)
    -- upvalues: Players (val)
    local v1 = os.clock() + 10
    while TrexRunHerd.ReadCourse(Workspace) == nil do
        if not (os.clock() < v1) or a1 ~= u64 then
            break
        end
        task.wait(0.1)
    end
    local u20 = TrexRunHerd.ReadCourse(Workspace)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local TrexRunVisuals = if Assets == nil then nil else Assets:WaitForChild("TrexRunVisuals", 10)
    if a1 == u64 and u20 ~= nil and TrexRunVisuals ~= nil then
        local v2 = u60
        local v3 = Herd.new(u20, TrexRunVisuals)
        if v3 == nil then
            return
        end
        u61 = v3
        local v4 = Hud.Mount()
        local Alpha = Attributes.Alpha
        local v5 = Workspace:GetAttribute(Alpha)
        u62 = v4
        if typeof(v5) == "CFrame" then
            Herd.MountAlpha(v3, v5)
        end
        v2:Connect(Remotes.TrexRun.Wave.OnClientEvent, function(a1) -- Line: 276 -- upvalues: u61 (upval), Herd (upval), Workspace (upval)
            local v1 = u61
            if v1 ~= nil and type(a1) == "table" then
                Herd.Add(v1, a1)
                if type(a1.Depth) == "number" then
                    Herd.RowDust(v1, a1, a1.Depth, Workspace.CurrentCamera.CFrame.Position)
                end
                return
            end
        end)
        v2:Connect(Remotes.TrexRun.Herd.OnClientEvent, function(a1) -- Line: 289 -- upvalues: u61 (upval), Herd (upval) -- types: a1: table
            if u61 ~= nil and type(a1) == "table" then
                Herd.Set(u61, a1)
            end
        end)
        v2:Connect(Remotes.TrexRun.Trampled.OnClientEvent, onTrampled)
        local success, err = pcall(function() -- Line: 296 -- upvalues: Remotes (upval)
            return Remotes.TrexRun.FetchHerd:InvokeServer()
        end)
        if a1 ~= u64 then
            return
        end
        if success and type(err) == "table" then
            Herd.Set(v3, err)
        end
        local IntroAt = Attributes.IntroAt
        local v6 = Workspace:GetAttribute(IntroAt)
        local EggPosition = Attributes.EggPosition
        local v7 = Workspace:GetAttribute(EggPosition)
        v5 = false
        if type(a2) == "table" then
            v5 = a2.WasInProgress == true
        end
        local v8 = not v5
        if v8 then
            v8 = false
            if v4 ~= nil then
                v8 = false
                if type(v6) == "number" then
                    v8 = false
                    if typeof(v7) == "Vector3" then
                        v8 = Workspace:GetServerTimeNow() - v6 < 4
                    end
                end
            end
        end
        if v8 then
            Cutscene.Play(v3, v4, v6, v7)
        elseif v4 ~= nil then
            Hud.SetBoardShown(v4, true)
        end
        refreshStatus()
        local u183 = Workspace:GetAttribute(Attributes.Herd)
        local ServerTimeNow = Workspace:GetServerTimeNow()
        local StartAt = Attributes.StartAt
        local u198 = (Workspace:GetAttribute(StartAt) or 0) <= ServerTimeNow
        local u201 = os.clock() + 7
        local u209, u210 = buildBeacon(v2)
        local EggPosition_2 = Attributes.EggPosition
        v8 = Workspace:GetAttribute(EggPosition_2)
        local Far = if typeof(v8) ~= "Vector3" then u20.Far else TrexRunHerd.Locate(u20, v8)
        local u238 = Instance.new("Highlight")
        u238.Name = "TrexCarrierHighlight"
        u238.FillColor = u57
        u238.OutlineColor = u57
        u238.FillTransparency = 0.85
        u238.OutlineTransparency = 0.4
        u238.DepthMode = Enum.HighlightDepthMode.Occluded
        u238.Enabled = false
        u238.Parent = Fx.Folder()
        v2:Add(u238)
        v2:Connect(Workspace:GetAttributeChangedSignal(Attributes.Herd), function() -- Line: 336
            -- upvalues: onHerdTurned (upval), u183 (ref), Attributes (upval), Workspace (upval), refreshStatus (upval)
            onHerdTurned(u183)
            local Herd = Attributes.Herd
            Workspace:GetAttribute(Herd)
            refreshStatus()
        end)
        v2:Connect(Workspace:GetAttributeChangedSignal(Attributes.Phase), refreshStatus)
        v2:Connect(Workspace:GetAttributeChangedSignal(Attributes.CarrierUserId), refreshStatus)
        v2:Connect(RunService.RenderStepped, function(a1) -- Line: 343
            -- upvalues: u61 (upval), Workspace (upval), Herd (upval), Attributes (upval), u198 (ref), Fx (upval)
            -- upvalues: Shake (upval), u201 (ref), u62 (upval), LocalPlayer (upval), Hud (upval)
            -- upvalues: updateProgress (upval), u20 (val), Far (val), updateBeacon (upval), u209 (val), u210 (val)
            -- upvalues: u238 (val), Players (upval)
            local Character_2, v1
            local v2 = u61
            if v2 == nil then
                return
            end
            local ServerTimeNow = Workspace:GetServerTimeNow()
            local CurrentCamera = Workspace.CurrentCamera
            Herd.Update(v2, a1, ServerTimeNow, CurrentCamera.CFrame.Position)
            local StartAt = Attributes.StartAt
            local v3 = Workspace:GetAttribute(StartAt)
            if not u198 and type(v3) == "number" and v3 <= ServerTimeNow then
                u198 = true
                Herd.Roar(v2, 1.2)
                Fx.Sound({"Sounds", "ScrambleBoss", "Rumble"}, nil, 1.3, 0.85)
                Shake.Play({Seconds = 1, Magnitude = 1.6, Shape = "Fade"})
            end
            if u198 then
                v1 = os.clock()
                if u201 <= v1 then
                    u201 = os.clock() + 7 * (0.8 + math.random() * 0.4)
                    Herd.Roar(v2, 0.6)
                end
            end
            v3 = u62
            if v3 ~= nil then
                local Character = LocalPlayer.Character
                local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
                v1 = if not u198 then 0 else if HumanoidRootPart == nil then 0 else if not HumanoidRootPart:IsA("BasePart") then 0 else Herd.Danger(v2, ServerTimeNow, HumanoidRootPart.Position, 170)
                Hud.SetDanger(v3, v1)
                Hud.Update(v3, a1)
                updateProgress(v3, u20, Far)
            end
            updateBeacon(u209, u210, a1)
            v1 = u238
            local CarrierUserId = Attributes.CarrierUserId
            v3 = Workspace:GetAttribute(CarrierUserId)
            local v4 = if type(v3) ~= "number" then nil else Players:GetPlayerByUserId(v3)
            if (if v4 == nil then nil else v4.Character) == nil then
                v1.Enabled = false
                v1.Adornee = nil
                return
            end
            if v1.Adornee ~= Character_2 then
                v1.Adornee = Character_2
            end
            v1.Enabled = true
        end)
        return
    end
end

function u65.StartEvent(a1, a2, a3) -- Line: 396
    -- upvalues: u65 (val), u64 (ref), u60 (ref), Trove (val), begin (val)
    u65:StopEvent()
    u64 = u64 + 1
    Trove.new()
    task.spawn(begin, u64, a3)
end

function u65.StopEvent(a1) -- Line: 404
    -- upvalues: u64 (ref), u63 (ref), u60 (ref), u61 (ref), Herd (val), u62 (ref), Hud (val)
    u64 = u64 + 1
    local v1 = u63
    u63 = nil
    if v1 ~= nil then
        v1.Stop()
    end
    if u60 ~= nil then
        u60:Clean()
        u60 = nil
    end
    v1 = u61
    u61 = nil
    if v1 ~= nil then
        Herd.Destroy(v1)
    end
    v1 = u62
    u62 = nil
    if v1 ~= nil then
        Hud.Unmount(v1)
    end
end

return u65