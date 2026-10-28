-- Script path: ReplicatedStorage.Controllers.Game.SewerCaveController
-- Decompile time: 9.09 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Ambience = require(script.Ambience)
local LightingController = require(script.Parent.LightingController)
local Log = require(ReplicatedStorage.Packages.Log)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local SewerCave = require(ReplicatedStorage.Shared.Util.SewerCave)
local Transition = require(script.Transition)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u52 = require(script.Worker)
local LocalPlayer = Players.LocalPlayer
local Markers = SewerCave.Markers
local Inside = SewerCave.Attributes.Inside
local u62 = Log.new():LimitUnderLevel("Warning")
local u63 = nil
local u64 = nil
local u67 = Trove.new()
local u68 = 0
local u69 = false
local u70 = false
local v1 = {}

local function isInside() -- Line: 49 -- upvalues: LocalPlayer (val), Inside (val)
    return LocalPlayer:GetAttribute(Inside) == true
end

local function lockControls(a1) -- Line: 53 -- upvalues: LocalPlayer (val)
    local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
    local PlayerModule = PlayerScripts and PlayerScripts:FindFirstChild("PlayerModule")
    if PlayerModule ~= nil and PlayerModule:IsA("ModuleScript") then
        local success, err = pcall(require, PlayerModule)
        if not success then
            return
        end
        local u24 = err:GetControls()
        if u24 then
            u24:Disable()
            a1:Add(function() -- Line: 66 -- upvalues: u24 (val)
                u24:Enable()
            end)
        end
        return
    end
end

local function applyLighting(a1) -- Line: 72
    -- upvalues: LightingController (val), SewerCave (val), u70 (ref), u62 (val)
    if LightingController.Presets[SewerCave.LightingPreset] == nil then
        local v1 = SewerCave.Cave()
        local v2 = v1 and v1:FindFirstChild(SewerCave.LightingPresetName)
        if v2 ~= nil then
            LightingController.SetAuthoredLayer("SewerCave", v2, 200, 0)
        elseif not u70 then
            u70 = true
            u62:AtWarning():Log("[SewerCave] no SewerCave lighting preset found")
        end
    else
        LightingController.SetLayer("SewerCave", SewerCave.LightingPreset, 200, 0)
    end
    a1:Add(function() -- Line: 95 -- upvalues: LightingController (upval)
        LightingController.ClearLayer("SewerCave", 0)
    end)
end

local function enterInside() -- Line: 100
    -- upvalues: u63 (ref), Trove (val), applyLighting (val), MusicDirector (val), Ambience (val), u52 (val)
    if u63 ~= nil then
        return
    end
    local v1 = Trove.new()
    u63 = v1
    applyLighting(v1)
    v1:Add((MusicDirector.Suppress()))
    Ambience.Start(v1)
    task.spawn(u52.Start, v1)
end

local function leaveInside() -- Line: 112 -- upvalues: u63 (ref)
    local v1 = u63
    u63 = nil
    if v1 ~= nil then
        v1:Destroy()
    end
end

local function sync() -- Line: 120 -- upvalues: LocalPlayer (val), Inside (val), enterInside (val), u63 (ref)
    if LocalPlayer:GetAttribute(Inside) == true then
        enterInside()
        return
    end
    local v1 = u63
    u63 = nil
    if v1 ~= nil then
        v1:Destroy()
    end
end

local function markerFrame(a1) -- Line: 128 -- upvalues: SewerCave (val) -- types: a1: string
    local v1 = SewerCave.Marker(a1)
    if v1 ~= nil then
        return v1.CFrame
    end
    return nil
end

local function fallbackFrame() -- Line: 133 -- upvalues: Player (val), LocalPlayer (val)
    local v1 = Player.FindRootPart(LocalPlayer)
    if v1 ~= nil then
        return v1.CFrame
    end
    return CFrame.identity
end

local function buildContext(a1, a2) -- Line: 138
    -- upvalues: Markers (val), SewerCave (val), Player (val), LocalPlayer (val)
    local Spawn_2, Surface_2, v1
    if typeof((if typeof(a1) ~= "table" then {} else a1).Spawn) ~= "CFrame" then
        local v2 = SewerCave.Marker(Markers.Spawn)
        Spawn_2 = if v2 == nil then nil else v2.CFrame
        if not Spawn_2 then
            local v3 = Player.FindRootPart(LocalPlayer)
            Spawn_2 = if v3 == nil then CFrame.identity else v3.CFrame
        end
    else
        Spawn_2 = v1.Spawn
    end
    if typeof(v1.Surface) ~= "CFrame" then
        local v4 = SewerCave.Marker(Markers.Surface)
        Surface_2 = (if v4 == nil then nil else v4.CFrame) or Spawn_2
    else
        Surface_2 = v1.Surface
    end
    local Whirlpool = v1.Whirlpool
    local Pipe = v1.Pipe
    local Destination = v1.Destination
    local v5 = {
        Whirlpool = if typeof(Whirlpool) ~= "Instance" then nil else if not Whirlpool:IsA("Model") then nil else Whirlpool,
        Spawn = Spawn_2,
        Surface = Surface_2,
    }
    v5.Pipe = if typeof(Pipe) ~= "Instance" then nil else if not Pipe:IsA("BasePart") then nil else Pipe
    v5.Destination = if typeof(Destination) ~= "CFrame" then nil else Destination
    v5.Arrive = a2
    return v5
end

local function invoke(a1, a2) -- Line: 161 -- upvalues: u68 (ref) -- types: a2: number
    if u68 ~= a2 then
        return false
    end
    local success, err = pcall(function() -- Line: 165 -- upvalues: a1 (val), a2 (val)
        return a1:InvokeServer(a2)
    end)
    local v1 = success
    if v1 then
        v1 = false
        if err == true then
            v1 = u68 == a2
        end
    end
    return v1
end

local function travel(a1, a2, a3) -- Line: 171
    -- upvalues: u64 (ref), Trove (val), u68 (ref), lockControls (val), MusicDirector (val), Remotes (val)
    -- upvalues: buildContext (val), Transition (val), u62 (val)
    local v1 = u64
    if v1 ~= nil then
        v1:Destroy()
    end
    local u9 = Trove.new()
    u64 = u9
    u68 = a2
    lockControls(u9)
    if a1 == "Enter" then
        u9:Add((MusicDirector.Suppress()))
    end
    local Arrive = if a1 ~= "Enter" then Remotes.SewerCave.Leave else Remotes.SewerCave.Arrive
    local u37 = buildContext(a3, function() -- Line: 184 -- upvalues: Arrive (val), a2 (val), u68 (upval)
        local u0 = Arrive
        local u1 = a2
        if u68 ~= u1 then
            return false
        end
        local success, err = pcall(function() -- Line: 165 -- upvalues: u0 (val), u1 (val)
            return u0:InvokeServer(u1)
        end)
        local v1 = success
        if v1 then
            v1 = false
            if err == true then
                v1 = u68 == u1
            end
        end
        return v1
    end)
    task.spawn(function() -- Line: 187 -- upvalues: a1 (val), Transition (upval), u37 (val), u62 (upval), u64 (upval), u9 (val)
        local success, err = pcall(function() -- Line: 188 -- upvalues: a1 (upval), Transition (upval), u37 (upval)
            if a1 == "Enter" then
                Transition.Enter(u37)
                return
            end
            Transition.Exit(u37)
        end)
        if not success then
            (u62:AtWarning()):Log((("[SewerCave] %* transition failed: %*"):format(a1, err)))
            Transition.Abort()
        end
        if u64 == u9 then
            u64 = nil
            u9:Destroy()
        end
    end)
end

local function cancelTravel(a1) -- Line: 206 -- upvalues: u68 (ref), Transition (val), u64 (ref)
    if a1 ~= u68 then
        return
    end
    u68 = 0
    Transition.Abort()
    local v1 = u64
    u64 = nil
    if v1 ~= nil then
        v1:Destroy()
    end
end

local function coverRespawn() -- Line: 219
    -- upvalues: LocalPlayer (val), Inside (val), u67 (val), Transition (val), SewerCave (val), Markers (val)
    -- upvalues: Player (val)
    if not (LocalPlayer:GetAttribute(Inside) == true) then
        return
    end
    u67:Clean()
    Transition.Cover()
    local u16 = os.clock()
    u67:Add((task.spawn(function() -- Line: 226
        -- upvalues: u16 (val), LocalPlayer (upval), Inside (upval), SewerCave (upval), Markers (upval), Player (upval)
        -- upvalues: Transition (upval)
        local v1, v2, v3
        while true do
            if not (os.clock() - u16 < 20) then
                break
            end
            task.wait(0.1)
            if not (LocalPlayer:GetAttribute(Inside) == true) then
                break
            end
            v1 = SewerCave.Marker(Markers.Spawn)
            v2 = Player.FindRootPart(LocalPlayer)
            v3 = Player.FindHumanoid(LocalPlayer)
            if v1 ~= nil
                and v2 ~= nil
                and v3 ~= nil
                and 0 < v3.Health
                and (v2.Position - v1.Position).Magnitude <= 30 then
                task.wait(0.2)
                break
            end
        end
        Transition.Reveal()
    end)))
end

function v1.Start() -- Line: 254
    -- upvalues: u69 (ref), Remotes (val), u68 (ref), Transition (val), u64 (ref), travel (val), LocalPlayer (val)
    -- upvalues: Inside (val), sync (val), coverRespawn (val), enterInside (val), u63 (ref)
    if u69 then
        return
    end
    u69 = true
    Remotes.SewerCave.Travel.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 260 -- upvalues: u68 (upval), Transition (upval), u64 (upval), travel (upval)
        if a1 ~= "Cancel" then
            if a1 == "Enter" then
                if type(a2) == "number" then
                    travel(a1, a2, a3)
                end
            elseif a1 == "Exit" and type(a2) == "number" then
                travel(a1, a2, a3)
            end
            return
        end
        if a2 ~= u68 then
            return
        end
        u68 = 0
        Transition.Abort()
        local v1 = u64
        u64 = nil
        if v1 == nil then
            return
        end
        v1:Destroy()
    end)
    ;(LocalPlayer:GetAttributeChangedSignal(Inside)):Connect(sync)
    LocalPlayer.CharacterRemoving:Connect(coverRespawn)
    if LocalPlayer:GetAttribute(Inside) == true then
        enterInside()
        return
    end
    local v1 = u63
    u63 = nil
    if v1 ~= nil then
        v1:Destroy()
    end
end

return v1