-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.Respawner
-- Decompile time: 6.21 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local EmitOnce = require(ReplicatedStorage.UserGenerated.VFX.EmitOnce)
local MountRaceFlags = require(ReplicatedStorage.Shared.Flags.MountRaceFlags)
local GUI = require(ReplicatedStorage.Client.GUI)
require(script.Parent.MountController)
local MountRace = require(ReplicatedStorage.Data.MountRace)
require(ReplicatedStorage.Shared.Modules.RaceTrackPath)
require(ReplicatedStorage.Packages.Trove)

local function fade(a1, a2, a3) -- Line: 33
    -- upvalues: TweenService (val)
    local v1 = TweenService:Create(a1, TweenInfo.new(a3, Enum.EasingStyle.Quad), {BackgroundTransparency = a2})
    v1:Play()
    v1.Completed:Wait()
end

local function sparkle(a1) -- Line: 43 -- upvalues: MountRace (val), EmitOnce (val) -- types: a1: userdata
    local v1 = MountRace.Effects.RespawnSparkle:Clone()
    v1.CFrame = a1
    v1.Parent = workspace
    for i, j in v1:GetDescendants() do
        if j:IsA("ParticleEmitter") then
            EmitOnce(j)
        end
    end
    task.delay(2, v1.Destroy, v1)
end

local function isUnderFloor(a1, a2) -- Line: 56 -- types: a1: table, a2: vector
    local v1, v2
    for i, j in a1 do
        v1 = j.CFrame:PointToObjectSpace(a2)
        v2 = j.Size / 2
        if v1.Y < v2.Y and (math.abs(v1.X)) <= v2.X and (math.abs(v1.Z)) <= v2.Z then
            return true
        end
    end
    return false
end

return {
    Run = function(a1, a2, a3, a4, a5) -- Line: 71
        -- upvalues: GUI (val), fade (val), MountRaceFlags (val), MountRace (val), RunService (val), TweenService (val)
        -- upvalues: sparkle (val), SoundService (val), isUnderFloor (val)
        local u5 = {}
        for i, j in a4.FallOffFloors:GetChildren() do
            assert(j:IsA("BasePart"), (("%* is not a BasePart"):format((j:GetFullName()))))
            table.insert(u5, j)
        end
        assert(#u5 > 0, (("%* has no floors"):format((a4.FallOffFloors:GetFullName()))))
        local u39 = GUI.FadeFrame()
        local u51 = a5:Project(a3.Root.Position, 0, a5.Length, a5.Length)
        local u52 = u51
        local u53 = false

        local function respawn() -- Line: 89
            -- upvalues: u53 (ref), a2 (val), fade (upval), u39 (val), MountRaceFlags (upval), a5 (val), u52 (ref)
            -- upvalues: u51 (ref), MountRace (upval), a3 (val), a1 (val), RunService (upval), TweenService (upval)
            -- upvalues: sparkle (upval), SoundService (upval)
            u53 = true
            a2:SetHold("Respawn", true)
            fade(u39, 0, MountRaceFlags.RespawnFadeSeconds:Get())
            local v1, v2 = a5:RespawnAt(u52)
            u51 = v2
            u52 = v2
            local u27 = MountRace.RiderFrame(a3.Mount, v1)
            a2:Place(u27 + u27.UpVector * 30)
            task.spawn(fade, u39, 1, MountRaceFlags.RespawnFadeSeconds:Get())
            local u47 = os.clock()
            local v3 = a1:Extend()
            v3:Connect(RunService.Heartbeat, function() -- Line: 103 -- upvalues: u47 (val), TweenService (upval), a2 (upval), u27 (val)
                local v1 = math.min((os.clock() - u47) / 0.6, 1)
                local Value = TweenService:GetValue(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                v1 = CFrame.Angles(0, (1 - Value) * 1 * 3.141592653589793 * 2, 0)
                a2:Place(u27 * (CFrame.new(0, (1 - Value) * 30, 0)) * v1)
            end)
            task.wait(0.6)
            v3:Destroy()
            a2:Place(u27)
            sparkle(u27)
            SoundService:PlayLocalSound(MountRace.Sounds.Respawn)
            a2:SetHold("Respawn", false)
            u53 = false
        end

        a1:Add(function() -- Line: 118 -- upvalues: u39 (val)
            u39.BackgroundTransparency = 1
        end)
        a1:Connect(RunService.Heartbeat, function() -- Line: 121
            -- upvalues: u53 (ref), u51 (ref), a5 (val), a3 (val), a2 (val), u52 (ref), isUnderFloor (upval), u5 (val)
            -- upvalues: MountRaceFlags (upval), a1 (val), respawn (val)
            if u53 then
                return
            end
            u51 = a5:Project(a3.Root.Position, u51, 30, 80)
            if a2.Grounded then
                u52 = u51
            end
            local v1 = isUnderFloor(u5, a3.Root.Position)
            if not v1 then
                v1 = false
                local AirSeconds = a2.AirSeconds
                if MountRaceFlags.AirFallSeconds:Get() < AirSeconds then
                    v1 = not a2.Launched
                end
            end
            if v1 then
                a1:Add((task.spawn(respawn)))
            end
        end)
    end,
}