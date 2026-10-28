-- Script path: ReplicatedStorage.Controllers.Game.ManorInteriorController
-- Decompile time: 13.09 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Ambience = require(script.Ambience)
local Door = require(script.Door)
local LightingController = require(script.Parent.LightingController)
local Log = require(ReplicatedStorage.Packages.Log)
local ManorInterior = require(ReplicatedStorage.Shared.Util.ManorInterior)
local MusicDirector = require(ReplicatedStorage.Client.MusicDirector)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Transition = require(script.Transition)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u61 = require(script.Unlock)
local LocalPlayer = Players.LocalPlayer
local Markers = ManorInterior.Markers
local Inside = ManorInterior.Attributes.Inside
local u71 = Log.new():LimitUnderLevel("Warning")
local u74 = Trove.new()
local u75 = nil
local u76 = nil
local u80 = u74:Extend()
local u81 = 0
local u82 = false
local u83 = false
local u84 = 0
local u85 = false
local v1 = {}

local function isInside() -- Line: 57 -- upvalues: LocalPlayer (val), Inside (val)
    return LocalPlayer:GetAttribute(Inside) == true
end

local function lockControls(a1) -- Line: 61 -- upvalues: LocalPlayer (val)
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
            a1:Add(function() -- Line: 74 -- upvalues: u24 (val)
                u24:Enable()
            end)
        end
        return
    end
end

local function applyLighting(a1) -- Line: 80
    -- upvalues: LightingController (val), ManorInterior (val), u85 (ref), u71 (val)
    if LightingController.Presets[ManorInterior.LightingPreset] ~= nil then
        LightingController.SetLayer("ManorInterior", ManorInterior.LightingPreset, 200, 0)
    elseif not u85 then
        u85 = true
        u71:AtWarning():Log("[ManorInterior] no ManorInterior lighting preset found")
    end
    a1:Add(function() -- Line: 92 -- upvalues: LightingController (upval)
        LightingController.ClearLayer("ManorInterior", 0)
    end)
end

local function enterInside() -- Line: 97 -- upvalues: u75 (ref), u74 (val), applyLighting (val), Ambience (val)
    if u75 ~= nil then
        return
    end
    local v1 = u74:Extend()
    u75 = v1
    applyLighting(v1)
    Ambience.Start(v1)
end

local function leaveInside() -- Line: 107 -- upvalues: u75 (ref)
    local v1 = u75
    u75 = nil
    if v1 ~= nil then
        v1:Destroy()
    end
end

local function sync() -- Line: 115
    -- upvalues: LocalPlayer (val), Inside (val), u75 (ref), u74 (val), applyLighting (val), Ambience (val)
    local v1 = LocalPlayer:GetAttribute(Inside) == true
    if not v1 then
        v1 = u75
        u75 = nil
        if v1 ~= nil then
            v1:Destroy()
        end
        return
    end
    if u75 ~= nil then
        return
    end
    v1 = u74:Extend()
    u75 = v1
    applyLighting(v1)
    Ambience.Start(v1)
end

local function markerFrame(a1) -- Line: 123 -- upvalues: ManorInterior (val) -- types: a1: string
    local v1 = ManorInterior.Marker(a1)
    if v1 ~= nil then
        return v1.CFrame
    end
    return nil
end

local function fallbackFrame() -- Line: 128 -- upvalues: Player (val), LocalPlayer (val)
    local v1 = Player.FindRootPart(LocalPlayer)
    if v1 ~= nil then
        return v1.CFrame
    end
    return CFrame.identity
end

local function buildContext(a1, a2) -- Line: 133
    -- upvalues: ManorInterior (val), Markers (val), Player (val), LocalPlayer (val)
    local DoorInside_2, DoorOutside_2, Spawn_2
    local Doors = a1.Doors
    local v1 = if typeof(Doors) ~= "Instance" then ManorInterior.Doors() else if not Doors:IsA("Model") then ManorInterior.Doors() else Doors
    if typeof(a1.Spawn) ~= "CFrame" then
        local v2 = ManorInterior.Marker(Markers.Spawn)
        Spawn_2 = if v2 == nil then nil else v2.CFrame
        if not Spawn_2 then
            local v3 = Player.FindRootPart(LocalPlayer)
            Spawn_2 = if v3 == nil then CFrame.identity else v3.CFrame
        end
    else
        Spawn_2 = a1.Spawn
    end
    if typeof(a1.DoorInside) ~= "CFrame" then
        local v4 = ManorInterior.Marker(Markers.DoorInside)
        DoorInside_2 = (if v4 == nil then nil else v4.CFrame) or Spawn_2
    else
        DoorInside_2 = a1.DoorInside
    end
    if typeof(a1.DoorOutside) == "CFrame" then
        DoorOutside_2 = a1.DoorOutside
    elseif v1 == nil then
        local v5 = Player.FindRootPart(LocalPlayer)
        DoorOutside_2 = if v5 == nil then CFrame.identity else v5.CFrame
    else
        DoorOutside_2 = ManorInterior.DoorOutside(v1)
    end
    local Interior = a1.Interior
    local Destination = a1.Destination
    local v6 = {Doors = v1, DoorOutside = DoorOutside_2, DoorInside = DoorInside_2, Spawn = Spawn_2}
    v6.Destination = if typeof(Destination) ~= "CFrame" then nil else Destination
    v6.Interior = if typeof(Interior) ~= "Instance" then ManorInterior.Interior() else if not Interior:IsA("Model") then ManorInterior.Interior() else Interior
    v6.Arrive = a2
    return v6
end

local function invoke(a1, a2) -- Line: 163 -- upvalues: u81 (ref) -- types: a2: number
    if u81 ~= a2 then
        return false
    end
    local success, err = pcall(function() -- Line: 167 -- upvalues: a1 (val), a2 (val)
        return a1:InvokeServer(a2)
    end)
    local v1 = success
    if v1 then
        v1 = false
        if err == true then
            v1 = u81 == a2
        end
    end
    return v1
end

local function playUnlock(a1) -- Line: 173
    -- upvalues: ManorInterior (val), Door (val), u61 (val), LocalPlayer (val), u71 (val)
    local v1 = a1:FindFirstChild(ManorInterior.LockName)
    Door.MarkOpen()
    local Play = u61.Play
    local v2 = {Doors = a1}
    v2.Lock = if v1 == nil then nil else if not v1:IsA("Model") then nil else v1
    v2.Character = LocalPlayer.Character
    v2.Key = Door.TakeKey()
    local success, err = pcall(Play, v2)
    if not success then
        (u71:AtWarning()):Log((("[ManorInterior] unlock animation failed: %*"):format(err)))
        local SetOpen = u61.SetOpen
        local v3 = {Doors = a1}
        v3.Lock = if v1 == nil then nil else if not v1:IsA("Model") then nil else v1
        v3.Character = LocalPlayer.Character
        pcall(SetOpen, v3, true)
    end
end

local function unlockDoors(a1) -- Line: 193
    -- upvalues: u74 (val), Door (val), lockControls (val), playUnlock (val)
    local v1 = u74:Extend()
    Door.SetBusy(true)
    v1:Add(function() -- Line: 196 -- upvalues: Door (upval)
        Door.SetBusy(false)
    end)
    lockControls(v1)
    playUnlock(a1)
    v1:Destroy()
end

local function travel(a1, a2, a3) -- Line: 204
    -- upvalues: u76 (ref), u74 (val), u81 (ref), Door (val), lockControls (val), MusicDirector (val), Remotes (val)
    -- upvalues: buildContext (val), Transition (val), u71 (val)
    local v1 = u76
    if v1 ~= nil then
        v1:Destroy()
    end
    local u10 = u74:Extend()
    u76 = u10
    u81 = a2
    Door.SetBusy(true)
    u10:Add(function() -- Line: 213 -- upvalues: Door (upval)
        Door.SetBusy(false)
    end)
    lockControls(u10)
    if a1 == "Enter" then
        u10:Add((MusicDirector.Suppress()))
    end
    local Arrive = if a1 ~= "Enter" then Remotes.ManorInterior.Leave else Remotes.ManorInterior.Arrive
    local u54 = buildContext(if typeof(a3) ~= "table" then {} else a3, function() -- Line: 224 -- upvalues: Arrive (val), a2 (val), u81 (upval)
        local u0 = Arrive
        local u1 = a2
        if u81 ~= u1 then
            return false
        end
        local success, err = pcall(function() -- Line: 167 -- upvalues: u0 (val), u1 (val)
            return u0:InvokeServer(u1)
        end)
        local v1 = success
        if v1 then
            v1 = false
            if err == true then
                v1 = u81 == u1
            end
        end
        return v1
    end)
    task.spawn(function() -- Line: 227 -- upvalues: a1 (val), Transition (upval), u54 (val), u71 (upval), u76 (upval), u10 (val)
        local success, err = pcall(function() -- Line: 228 -- upvalues: a1 (upval), Transition (upval), u54 (upval)
            if a1 == "Enter" then
                Transition.Enter(u54)
                return
            end
            Transition.Exit(u54)
        end)
        if not success then
            (u71:AtWarning()):Log((("[ManorInterior] %* transition failed: %*"):format(a1, err)))
            Transition.Abort()
        end
        if u76 == u10 then
            u76 = nil
            u10:Destroy()
        end
    end)
end

local function cancelTravel(a1) -- Line: 246 -- upvalues: u81 (ref), Transition (val), u76 (ref)
    if a1 ~= u81 then
        return
    end
    u81 = 0
    Transition.Abort()
    local v1 = u76
    u76 = nil
    if v1 ~= nil then
        v1:Destroy()
    end
end

local function coverRespawn() -- Line: 259
    -- upvalues: LocalPlayer (val), Inside (val), u80 (val), Transition (val), ManorInterior (val), Markers (val)
    -- upvalues: Player (val)
    if not (LocalPlayer:GetAttribute(Inside) == true) then
        return
    end
    u80:Clean()
    Transition.Cover()
    local u16 = os.clock()
    u80:Add((task.spawn(function() -- Line: 266
        -- upvalues: u16 (val), LocalPlayer (upval), Inside (upval), ManorInterior (upval), Markers (upval)
        -- upvalues: Player (upval), Transition (upval)
        local v1, v2, v3
        while true do
            if not (os.clock() - u16 < 20) then
                break
            end
            task.wait(0.1)
            if not (LocalPlayer:GetAttribute(Inside) == true) then
                break
            end
            v1 = ManorInterior.Marker(Markers.Spawn)
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

local function requestExit() -- Line: 290 -- upvalues: Remotes (val), u84 (ref), u83 (ref)
    pcall(function() -- Line: 291 -- upvalues: Remotes (upval)
        Remotes.ManorInterior.Request:InvokeServer()
    end)
    u84 = os.clock() + 0.6
    u83 = false
end

local function watchExit() -- Line: 298
    -- upvalues: LocalPlayer (val), Inside (val), u76 (ref), u83 (ref), u84 (ref), ManorInterior (val), Markers (val)
    -- upvalues: Player (val), requestExit (val)
    local v1 = LocalPlayer:GetAttribute(Inside) == true
    if v1 and u76 == nil and not u83 and not (os.clock() < u84) then
        v1 = ManorInterior.Marker(Markers.Exit)
        local v2 = Player.FindRootPart(LocalPlayer)
        local v3 = Player.FindHumanoid(LocalPlayer)
        if v1 ~= nil and v2 ~= nil and v3 ~= nil and not (v3.Health <= 0) then
            if ManorInterior.Within(v1, v2.Position, 0.5) then
                u83 = true
                task.spawn(requestExit)
            end
            return
        end
        return
    end
end

function v1.Start() -- Line: 318
    -- upvalues: u82 (ref), u74 (val), Remotes (val), u81 (ref), Transition (val), u76 (ref), travel (val)
    -- upvalues: LocalPlayer (val), Inside (val), sync (val), coverRespawn (val), Door (val), unlockDoors (val)
    -- upvalues: RunService (val), watchExit (val), u75 (ref), applyLighting (val), Ambience (val)
    if u82 then
        return
    end
    u82 = true
    u74:Connect(Remotes.ManorInterior.Travel.OnClientEvent, function(a1, a2, a3) -- Line: 325 -- upvalues: u81 (upval), Transition (upval), u76 (upval), travel (upval)
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
        if a2 ~= u81 then
            return
        end
        u81 = 0
        Transition.Abort()
        local v1 = u76
        u76 = nil
        if v1 == nil then
            return
        end
        v1:Destroy()
    end)
    u74:Connect(LocalPlayer:GetAttributeChangedSignal(Inside), sync)
    u74:Connect(LocalPlayer.CharacterRemoving, coverRespawn)
    Door.Start(u74, unlockDoors)
    local u33 = 0
    u74:Connect(RunService.Heartbeat, function(a1) -- Line: 337 -- upvalues: u33 (ref), watchExit (upval) -- types: a1: number
        u33 = u33 + a1
        if u33 < 0.05 then
            return
        end
        u33 = 0
        watchExit()
    end)
    local v1 = LocalPlayer:GetAttribute(Inside) == true
    if not v1 then
        v1 = u75
        u75 = nil
        if v1 ~= nil then
            v1:Destroy()
        end
    elseif u75 == nil then
        v1 = u74:Extend()
        u75 = v1
        applyLighting(v1)
        Ambience.Start(v1)
    end
end

return v1