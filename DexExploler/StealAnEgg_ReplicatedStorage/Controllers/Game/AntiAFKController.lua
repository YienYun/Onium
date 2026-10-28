-- Script path: ReplicatedStorage.Controllers.Game.AntiAFKController
-- Decompile time: 6.48 ms

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local AfkProtection = require(ReplicatedStorage.Shared.Types.AfkProtection)
local AfkTreadmillTest = require(ReplicatedStorage.Shared.Modules.AfkTreadmillTest)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local LocalPlayer = Players.LocalPlayer
local u40 = false
return {
    Start = function() -- Line: 26
        -- upvalues: UserInputService (val), Remotes (val), LocalPlayer (val), Constants (val), TeleportService (val)
        -- upvalues: AfkProtection (val), u40 (ref), AfkTreadmillTest (val)
        local function connectActivityInputs(a1) -- Line: 31
            -- upvalues: UserInputService (upval)
            UserInputService.InputBegan:Connect(function() -- Line: 32 -- upvalues: a1 (val)
                a1()
            end)
            UserInputService.InputChanged:Connect(function(a1_2) -- Line: 35 -- upvalues: a1 (val) -- types: a1_2: userdata
                if a1_2.UserInputType == Enum.UserInputType.MouseMovement
                    or a1_2.UserInputType == Enum.UserInputType.Touch then
                    a1()
                    return
                end
                if string.find(a1_2.UserInputType.Name, "Gamepad") ~= nil then
                    a1()
                end
            end)
        end

        local function startControlBehaviour() -- Line: 52
            -- upvalues: Remotes (upval), LocalPlayer (upval), Constants (upval), TeleportService (upval)
            -- upvalues: connectActivityInputs (val)
            local u0 = false

            local function reportAfkState(a1) -- Line: 55 -- upvalues: u0 (ref), Remotes (upval) -- types: a1: boolean
                if u0 == a1 then
                    return
                end
                u0 = a1
                Remotes.Telemetry.SubmitIdleState:FireServer(a1)
            end

            LocalPlayer.Idled:Connect(function(a1) -- Line: 72
                -- upvalues: u0 (ref), Remotes (upval), Constants (upval), TeleportService (upval), LocalPlayer (upval)
                if a1 >= 60 and u0 ~= true then
                    u0 = true
                    Remotes.Telemetry.SubmitIdleState:FireServer(true)
                end
                if a1 > 1080 and not Constants.IS_STUDIO then
                    pcall(function() -- Line: 78 -- upvalues: Remotes (upval)
                        Remotes.Telemetry.AskIdleHopFlush:InvokeServer()
                    end)
                    TeleportService:Teleport(game.PlaceId, LocalPlayer)
                end
            end)
            connectActivityInputs(function() -- Line: 64 -- upvalues: u0 (ref), Remotes (upval)
                if not u0 or u0 == false then
                    return
                end
                u0 = false
                Remotes.Telemetry.SubmitIdleState:FireServer(false)
            end)
        end

        local function startVariantBehaviour() -- Line: 88
            -- upvalues: AfkProtection (upval), Remotes (upval), Constants (upval), TeleportService (upval)
            -- upvalues: LocalPlayer (upval), connectActivityInputs (val)
            local TELEPORT_IDLE_THRESHOLD_SECONDS = AfkProtection.TELEPORT_IDLE_THRESHOLD_SECONDS
            local CLIENT_FALLBACK_IDLE_THRESHOLD_SECONDS = AfkProtection.CLIENT_FALLBACK_IDLE_THRESHOLD_SECONDS
            local IDLE_POLL_INTERVAL_SECONDS = AfkProtection.IDLE_POLL_INTERVAL_SECONDS
            local TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS = AfkProtection.TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS
            local TELEPORT_DATA_KEY = AfkProtection.TELEPORT_DATA_KEY
            local u11 = os.clock()
            local u12 = 0
            local u13 = false
            local u14 = 0
            local u15 = false

            local function resolveIdleSeconds() -- Line: 101 -- upvalues: u11 (ref), u12 (ref)
                return (math.max(os.clock() - u11, u12))
            end

            local function reportIdleState(a1) -- Line: 105
                -- upvalues: u13 (ref), Remotes (upval)
                if u13 == a1 then
                    return
                end
                u13 = a1
                Remotes.Telemetry.SubmitIdleState:FireServer(a1)
                Remotes.IdleRescue.SubmitIdleFlag:FireServer(a1)
            end

            local function requestTeleport() -- Line: 123
                -- upvalues: u14 (ref), TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS (val), Remotes (upval)
                local v1 = os.clock()
                if v1 < u14 then
                    return
                end
                u14 = v1 + TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS
                Remotes.IdleRescue.AskRescueHop:FireServer()
            end

            local function fallbackTeleport() -- Line: 133
                -- upvalues: u15 (ref), Constants (upval), Remotes (upval), TeleportService (upval), LocalPlayer (upval)
                -- upvalues: TELEPORT_DATA_KEY (val)
                if not u15 and not Constants.IS_STUDIO and not Constants.IS_PRIVATE_SERVER then
                    u15 = true
                    pcall(function() -- Line: 139 -- upvalues: Remotes (upval)
                        Remotes.Telemetry.AskIdleHopFlush:InvokeServer()
                    end)
                    TeleportService:Teleport(game.PlaceId, LocalPlayer, {[TELEPORT_DATA_KEY] = true})
                    return
                end
            end

            local function step() -- Line: 145
                -- upvalues: u11 (ref), u12 (ref), u13 (ref), Remotes (upval), TELEPORT_IDLE_THRESHOLD_SECONDS (val)
                -- upvalues: u14 (ref), TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS (val)
                -- upvalues: CLIENT_FALLBACK_IDLE_THRESHOLD_SECONDS (val), fallbackTeleport (val)
                local v1 = math.max(os.clock() - u11, u12)
                if v1 < 60 then
                    return
                end
                if u13 ~= true then
                    u13 = true
                    Remotes.Telemetry.SubmitIdleState:FireServer(true)
                    Remotes.IdleRescue.SubmitIdleFlag:FireServer(true)
                end
                if TELEPORT_IDLE_THRESHOLD_SECONDS <= v1 then
                    local v2 = os.clock()
                    if not (v2 < u14) then
                        u14 = v2 + TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS
                        Remotes.IdleRescue.AskRescueHop:FireServer()
                    end
                end
                if CLIENT_FALLBACK_IDLE_THRESHOLD_SECONDS <= v1 then
                    fallbackTeleport()
                end
            end

            LocalPlayer.Idled:Connect(function(a1) -- Line: 162 -- upvalues: u12 (ref) -- types: a1: number
                u12 = a1
            end)
            connectActivityInputs(function() -- Line: 115 -- upvalues: u11 (ref), u12 (ref), u14 (ref), u15 (ref), u13 (ref), Remotes (upval)
                os.clock()
                u12 = 0
                u14 = 0
                u15 = false
                if u13 == false then
                    return
                end
                u13 = false
                Remotes.Telemetry.SubmitIdleState:FireServer(false)
                Remotes.IdleRescue.SubmitIdleFlag:FireServer(false)
            end)
            task.spawn(function() -- Line: 168
                -- upvalues: IDLE_POLL_INTERVAL_SECONDS (val), u11 (ref), u12 (ref), u13 (ref), Remotes (upval)
                -- upvalues: TELEPORT_IDLE_THRESHOLD_SECONDS (val), u14 (ref)
                -- upvalues: TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS (val), CLIENT_FALLBACK_IDLE_THRESHOLD_SECONDS (val)
                -- upvalues: fallbackTeleport (val)
                local v1, v2
                while true do
                    task.wait(IDLE_POLL_INTERVAL_SECONDS)
                    v1 = math.max(os.clock() - u11, u12)
                    if not (v1 < 60) then
                        if u13 ~= true then
                            u13 = true
                            Remotes.Telemetry.SubmitIdleState:FireServer(true)
                            Remotes.IdleRescue.SubmitIdleFlag:FireServer(true)
                        end
                        if TELEPORT_IDLE_THRESHOLD_SECONDS <= v1 then
                            v2 = os.clock()
                            if not (v2 < u14) then
                                u14 = v2 + TELEPORT_REQUEST_RETRY_INTERVAL_SECONDS
                                Remotes.IdleRescue.AskRescueHop:FireServer()
                            end
                        end
                        if CLIENT_FALLBACK_IDLE_THRESHOLD_SECONDS <= v1 then
                            fallbackTeleport()
                        end
                    end
                end
            end)
        end

        local function startBehaviourOnce(a1) -- Line: 176
            -- upvalues: u40 (upval), AfkTreadmillTest (upval), startVariantBehaviour (val), startControlBehaviour (val)
            if u40 then
                return
            end
            u40 = true
            if a1 == AfkTreadmillTest.Groups.Variant then
                startVariantBehaviour()
                return
            end
            startControlBehaviour()
        end

        task.spawn(function() -- Line: 193
            -- upvalues: AfkTreadmillTest (upval), LocalPlayer (upval), u40 (upval), startVariantBehaviour (val)
            -- upvalues: startControlBehaviour (val)
            local v1 = AfkTreadmillTest.GetGroupAsync(LocalPlayer)
            if u40 then
                return
            end
            u40 = true
            if v1 == AfkTreadmillTest.Groups.Variant then
                startVariantBehaviour()
                return
            end
            startControlBehaviour()
        end)
        task.delay(30, function() -- Line: 197
            -- upvalues: AfkTreadmillTest (upval), u40 (upval), startVariantBehaviour (val), startControlBehaviour (val)
            local Control = AfkTreadmillTest.Groups.Control
            if u40 then
                return
            end
            u40 = true
            if Control == AfkTreadmillTest.Groups.Variant then
                startVariantBehaviour()
                return
            end
            startControlBehaviour()
        end)
    end,
}