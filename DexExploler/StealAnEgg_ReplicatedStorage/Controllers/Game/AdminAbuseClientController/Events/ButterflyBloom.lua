-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ButterflyBloom
-- Decompile time: 20.12 ms

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ButterflyCatalog = require(ReplicatedStorage.Shared.Modules.ButterflyCatalog)
local ButterflyFlags = require(ReplicatedStorage.Shared.Flags.ButterflyFlags)
local CatchFX = require(script.CatchFX)
local Net = require(script.Net)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Swarm = require(script.Swarm)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u85 = ((ReplicatedStorage:WaitForChild("Assets")):WaitForChild("VFX")):WaitForChild("Butterflies")
local u88 = Trove.new()
local u90 = Trove.new()
local u91 = false
local u92 = 0
local u93 = false
local u94 = false
local u95 = false
local u96 = 0
local v1 = {}

local function isEligible() -- Line: 56 -- upvalues: ButterflyFlags (val), Save (val)
    if ButterflyFlags.Enabled:Get() and Save.IsLoaded() then
        local v1 = Save.Peek()
        local Butterflies = if not v1 then nil else v1.Butterflies
        local v2 = false
        if typeof(Butterflies) == "table" then
            v2 = Butterflies.NetClaimed == true
        end
        return v2
    end
    return false
end

local function findBounds() -- Line: 65 -- upvalues: Workspace (val)
    local World = Workspace:FindFirstChild("World")
    local Areas = World and World:FindFirstChild("Areas")
    local v1 = Areas and Areas:FindFirstChild("ButterflyBloom")
    local Bounds = v1 and v1:FindFirstChild("Bounds")
    if Bounds and Bounds:IsA("BasePart") then
        return Bounds
    end
    return nil
end

local function distanceOutside(a1, a2) -- Line: 76 -- types: a1: userdata, a2: vector
    local v1 = a1.CFrame:PointToObjectSpace(a2)
    local v2 = a1.Size / 2
    return Vector3.new(math.max((math.abs(v1.X)) - v2.X, 0), 0, (math.max((math.abs(v1.Z)) - v2.Z, 0))).Magnitude
end

local function buildGrade() -- Line: 87 -- upvalues: u85 (val), Lighting (val)
    local Grade = u85:FindFirstChild("Grade")
    local ColorCorrectionEffect = if not Grade then Instance.new("ColorCorrectionEffect") else if not Grade:IsA("ColorCorrectionEffect") then Instance.new("ColorCorrectionEffect") else Grade:Clone()
    ColorCorrectionEffect.Name = "ButterflyBloomGrade"
    ColorCorrectionEffect.Enabled = true
    ColorCorrectionEffect.Parent = Lighting
    return ColorCorrectionEffect
end

local function distanceFromForest(a1, a2) -- Line: 98 -- types: a1: table, a2: vector
    local v1, v2
    local v3 = (1 / 0)
    for i, j in a1 do
        v1 = j.CFrame:PointToObjectSpace(a2)
        v2 = j.Size / 2
        v3 = math.min(
            v3,
            (Vector3.new(math.max((math.abs(v1.X)) - v2.X, 0), math.max((math.abs(v1.Y)) - v2.Y, 0), (math.max((math.abs(v1.Z)) - v2.Z, 0)))).Magnitude
        )
    end
    return v3
end

local function fadeForest(a1, a2) -- Line: 113 -- types: a1: table, a2: number
    local v1
    local v2 = nil
    local v3 = nil
    for i, j in a1, v2, v3 do
        v1 = {}
        for k, n in j.Keypoints do
            table.insert(v1, (NumberSequenceKeypoint.new(n.Time, 1 - (1 - n.Value) * v4, n.Envelope * v4)))
        end
        i.Transparency = NumberSequence.new(v1)
    end
end

local function startForest() -- Line: 130
    -- upvalues: u85 (val), u94 (ref), fadeForest (val), Workspace (val), TweenService (val), u90 (val)
    -- upvalues: distanceFromForest (val)
    local Forest = u85:FindFirstChild("Forest")
    if not u94 and Forest ~= nil then
        u94 = true
        local u9 = Forest:Clone()
        local u10 = {}
        local u11 = {}
        local u12 = {}
        local u94_2 = 1.5
        for i, j in u9:GetDescendants() do
            if j:IsA("BasePart") then
                table.insert(u12, j)
            elseif j:IsA("Beam") then
                u10[j] = j.Transparency
            elseif j:IsA("ParticleEmitter") then
                table.insert(u11, j)
                u94_2 = math.max(u94_2, j.Lifetime.Max)
            end
        end
        local NumberValue = Instance.new("NumberValue")
        NumberValue.Changed:Connect(function(a1) -- Line: 152 -- upvalues: fadeForest (upval), u10 (val) -- types: a1: number
            fadeForest(u10, a1)
        end)
        fadeForest(u10, 0)
        u9.Parent = Workspace
        TweenService:Create(NumberValue, TweenInfo.new(1.5), {Value = 1}):Play()
        u90:Add((task.spawn(function() -- Line: 158 -- upvalues: Workspace (upval), distanceFromForest (upval), u12 (val), u11 (val)
            local CurrentCamera, v1
            local v2 = nil
            while true do
                CurrentCamera = Workspace.CurrentCamera
                v1 = true
                if CurrentCamera == nil then
                    if v1 ~= v2 then
                        for i, j in u11 do
                            j.Enabled = v1
                        end
                    end
                else
                    v1 = (distanceFromForest(u12, CurrentCamera.CFrame.Position)) <= 350
                    if v1 ~= v2 then
                        for k, n in u11 do
                            n.Enabled = v1
                        end
                    end
                end
                task.wait(0.5)
            end
        end)))
        u90:Add(function() -- Line: 173 -- upvalues: u11 (val), TweenService (upval), NumberValue (val), u94_2 (ref), u9 (val)
            for i, j in u11 do
                j.Enabled = false
            end
            TweenService:Create(NumberValue, TweenInfo.new(1.5), {Value = 0}):Play()
            task.delay(u94_2, function() -- Line: 178 -- upvalues: NumberValue (upval), u9 (upval)
                NumberValue:Destroy()
                u9:Destroy()
            end)
        end)
        return
    end
end

local function stopForest() -- Line: 185 -- upvalues: u94 (ref), u90 (val)
    if not u94 then
        return
    end
    u94 = false
    u90:Clean()
end

local function fetchSwarm() -- Line: 199 -- upvalues: u96 (ref), Remotes (val), u93 (ref), Swarm (val)
    u96 = u96 + 1
    local u2 = u96
    task.spawn(function() -- Line: 202 -- upvalues: Remotes (upval), u2 (val), u96 (upval), u93 (upval), Swarm (upval)
        local success, err = pcall(function() -- Line: 203 -- upvalues: Remotes (upval)
            return Remotes.Butterflies.AskSwarm:InvokeServer()
        end)
        if success and u2 == u96 and u93 and typeof(err) == "table" then
            for i, j in err do
                if u93 then
                    Swarm.Add(j)
                end
            end
            return
        end
    end)
end

local function stopPresentation() -- Line: 215 -- upvalues: u93 (ref), Net (val), u88 (val), Swarm (val)
    if not u93 then
        return
    end
    u93 = false
    Net.SetPresenting(false)
    u88:Clean()
    Swarm.Clear(false)
end

local function startPresentation() -- Line: 225
    -- upvalues: u93 (ref), Net (val), findBounds (val), u85 (val), Lighting (val), u88 (val), TweenService (val)
    -- upvalues: Audio (val), ButterflyCatalog (val), RunService (val), Workspace (val), Swarm (val), Player (val)
    -- upvalues: LocalPlayer (val), u95 (ref), u92 (ref), CatchFX (val), u96 (ref), Remotes (val)
    if u93 then
        return
    end
    u93 = true
    Net.SetPresenting(true)
    local u7 = findBounds()
    local Grade = u85:FindFirstChild("Grade")
    local u24 = if not Grade then Instance.new("ColorCorrectionEffect") else if not Grade:IsA("ColorCorrectionEffect") then Instance.new("ColorCorrectionEffect") else Grade:Clone()
    u24.Name = "ButterflyBloomGrade"
    u24.Enabled = true
    u24.Parent = Lighting
    local TintColor = u24.TintColor
    local Saturation = u24.Saturation
    local Brightness = u24.Brightness
    local Contrast = u24.Contrast
    local u33 = 0
    u24.TintColor = Color3.new(1, 1, 1)
    u24.Saturation = 0
    u24.Brightness = 0
    u24.Contrast = 0
    u88:Add(function() -- Line: 242 -- upvalues: TweenService (upval), u24 (val)
        local v1 = TweenService:Create(u24, TweenInfo.new(1.2), {Saturation = 0, Brightness = 0, Contrast = 0, TintColor = Color3.new(1, 1, 1)})
        v1:Play()
        v1.Completed:Once(function() -- Line: 250 -- upvalues: u24 (upval)
            u24:Destroy()
        end)
    end)
    local u54 = Audio.Play(ButterflyCatalog.Sounds.Ambience, script, {Looped = true, Volume = 0})
    if u54 then
        u88:Add(function() -- Line: 259 -- upvalues: TweenService (upval), u54 (val)
            local v1 = TweenService:Create(u54, TweenInfo.new(1), {Volume = 0})
            v1:Play()
            v1.Completed:Once(function() -- Line: 262 -- upvalues: u54 (upval)
                u54:Destroy()
            end)
        end)
    end
    local u60 = -1
    u88:Connect(RunService.RenderStepped, function() -- Line: 268
        -- upvalues: Workspace (upval), Swarm (upval), Net (upval), Player (upval), LocalPlayer (upval), u7 (val)
        -- upvalues: u33 (ref), u60 (ref), u24 (val), TintColor (val), Saturation (val), Brightness (val)
        -- upvalues: Contrast (val), u54 (val), u95 (upval), u92 (upval), CatchFX (upval)
        local v1 = os.clock()
        local ServerTimeNow = Workspace:GetServerTimeNow()
        Swarm.Step(ServerTimeNow, v1)
        Net.Step(v1)
        v1 = Player.FindRootPart(LocalPlayer)
        local v2 = 0
        if u7 and v1 then
            local v3 = u7
            local v4 = v3.CFrame:PointToObjectSpace(v1.Position)
            local v5 = v3.Size / 2
            v2 = 1 - math.clamp(Vector3.new(math.max((math.abs(v4.X)) - v5.X, 0), 0, (math.max((math.abs(v4.Z)) - v5.Z, 0))).Magnitude / 45, 0, 1)
        end
        u33 = u33 + (v2 - u33) * 0.06
        if (math.abs(v2 - u33)) < 0.001 then
            u33 = v2
        end
        if u33 ~= u60 then
            u60 = u33
            u24.TintColor = (Color3.new(1, 1, 1)):Lerp(TintColor, u33)
            u24.Saturation = Saturation * u33
            u24.Brightness = Brightness * u33
            u24.Contrast = Contrast * u33
            if u54 then
                u54.Volume = u33 * 1
            end
        end
        if not u95 and u92 - ServerTimeNow <= 30 then
            u95 = true
            CatchFX.Announce("Ending")
        end
    end)
    u96 = u96 + 1
    local u80 = u96
    task.spawn(function() -- Line: 202 -- upvalues: Remotes (upval), u80 (val), u96 (upval), u93 (upval), Swarm (upval)
        local success, err = pcall(function() -- Line: 203 -- upvalues: Remotes (upval)
            return Remotes.Butterflies.AskSwarm:InvokeServer()
        end)
        if success and u80 == u96 and u93 and typeof(err) == "table" then
            for i, j in err do
                if u93 then
                    Swarm.Add(j)
                end
            end
            return
        end
    end)
end

local function refresh() -- Line: 301
    -- upvalues: u91 (ref), ButterflyFlags (val), Save (val), startPresentation (val), u93 (ref), Net (val), u88 (val)
    -- upvalues: Swarm (val)
    if u91 then
        local v1
        if not ButterflyFlags.Enabled:Get() then
            v1 = false
        elseif Save.IsLoaded() then
            local v2 = Save.Peek()
            local Butterflies = if not v2 then nil else v2.Butterflies
            v1 = false
            if typeof(Butterflies) == "table" then
                v1 = Butterflies.NetClaimed == true
            end
        else
            v1 = false
        end
        if v1 then
            startPresentation()
            return
        end
    end
    if not u93 then
        return
    end
    u93 = false
    Net.SetPresenting(false)
    u88:Clean()
    Swarm.Clear(false)
end

function v1.StartEvent(a1, a2, a3) -- Line: 313
    -- upvalues: u91 (ref), u92 (ref), Workspace (val), u95 (ref), startForest (val), ButterflyFlags (val), Save (val)
    -- upvalues: startPresentation (val), u93 (ref), Net (val), u88 (val), Swarm (val)
    u91 = true
    u92 = Workspace:GetServerTimeNow() + a2
    u95 = a2 <= 30
    startForest()
    if u91 then
        local v1
        if not ButterflyFlags.Enabled:Get() then
            v1 = false
        elseif Save.IsLoaded() then
            local v2 = Save.Peek()
            local Butterflies = if not v2 then nil else v2.Butterflies
            v1 = false
            if typeof(Butterflies) == "table" then
                v1 = Butterflies.NetClaimed == true
            end
        else
            v1 = false
        end
        if v1 then
            startPresentation()
            return
        end
    end
    if not u93 then
        return
    end
    u93 = false
    Net.SetPresenting(false)
    u88:Clean()
    Swarm.Clear(false)
end

function v1.StopEvent(a1) -- Line: 321
    -- upvalues: u91 (ref), u94 (ref), u90 (val), u93 (ref), Net (val), u88 (val), Swarm (val)
    u91 = false
    if u94 then
        u94 = false
        u90:Clean()
    end
    if not u93 then
        return
    end
    u93 = false
    Net.SetPresenting(false)
    u88:Clean()
    Swarm.Clear(false)
end

Net.Start()
Remotes.Butterflies.Spawned.OnClientEvent:Connect(function(a1) -- Line: 193 -- upvalues: u93 (ref), Swarm (val)
    if u93 then
        Swarm.Add(a1)
    end
end)
Remotes.Butterflies.Escaped.OnClientEvent:Connect(function(a1) -- Line: 335 -- upvalues: u93 (ref), Swarm (val)
    if u93 then
        Swarm.Update(a1)
    end
end)
Remotes.Butterflies.Removed.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 342
    -- upvalues: LocalPlayer (val), Swarm (val)
    if a3 == LocalPlayer.UserId and a2 == "Caught" then
        return
    end
    Swarm.Remove(a1)
end)
Remotes.Butterflies.Announce.OnClientEvent:Connect(function(a1) -- Line: 350 -- upvalues: ButterflyFlags (val), Save (val), CatchFX (val) -- types: a1: string
    if a1 == "Start" or a1 == "End" or a1 == "Golden" then
        local v1
        if not ButterflyFlags.Enabled:Get() then
            v1 = false
        elseif Save.IsLoaded() then
            local v2 = Save.Peek()
            local Butterflies = if not v2 then nil else v2.Butterflies
            v1 = false
            if typeof(Butterflies) == "table" then
                v1 = Butterflies.NetClaimed == true
            end
        else
            v1 = false
        end
        if v1 then
            CatchFX.Announce(a1)
        end
    end
end)
Remotes.Butterflies.NetClaimed.OnClientEvent:Connect(function() -- Line: 358 -- upvalues: refresh (val)
    task.defer(refresh)
end)
Save.WatchFields("Butterflies", refresh)
Save.Loaded:Connect(function(a1) -- Line: 363
    -- upvalues: LocalPlayer (val), u91 (ref), ButterflyFlags (val), Save (val), startPresentation (val), u93 (ref)
    -- upvalues: Net (val), u88 (val), Swarm (val)
    if a1 == LocalPlayer then
        if u91 then
            local v1
            if not ButterflyFlags.Enabled:Get() then
                v1 = false
            elseif Save.IsLoaded() then
                local v2 = Save.Peek()
                local Butterflies = if not v2 then nil else v2.Butterflies
                v1 = false
                if typeof(Butterflies) == "table" then
                    v1 = Butterflies.NetClaimed == true
                end
            else
                v1 = false
            end
            if v1 then
                startPresentation()
                return
            end
        end
        if not u93 then
            return
        end
        u93 = false
        Net.SetPresenting(false)
        u88:Clean()
        Swarm.Clear(false)
    end
end)
return v1