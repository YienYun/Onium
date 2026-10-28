-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.Components.Jump
-- Decompile time: 4.41 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local MountRaceFlags = require(ReplicatedStorage.Shared.Flags.MountRaceFlags)
require(script.Parent.Parent.MountController)
local MountRace = require(ReplicatedStorage.Data.MountRace)
require(script.Parent.Parent.RaceCamera)
local RaceEffects = require(script.Parent.Parent.RaceEffects)
require(ReplicatedStorage.Packages.Trove)
return {
    Bind = function(a1, a2, a3, a4) -- Line: 41
        -- upvalues: MountRace (val), MountRaceFlags (val), Workspace (val), SoundService (val), RaceEffects (val)
        -- upvalues: RunService (val)
        local Start = a2:FindFirstChild("Start")
        local End = a2:FindFirstChild("End")
        local v1 = false
        if Start ~= nil then
            v1 = Start:IsA("BasePart")
        end
        assert(v1, (("%* needs a Start part"):format((a2:GetFullName()))))
        v1 = false
        if End ~= nil then
            v1 = End:IsA("BasePart")
        end
        assert(v1, (("%* needs an End part"):format((a2:GetFullName()))))
        local Rig = a3.Rig
        local Y = MountRace.RiderFrame(Rig.Mount, CFrame.identity).Position.Y
        local Attribute = a2:GetAttribute("LaunchSpeedMultiplier")
        local u63 = if type(Attribute) ~= "number" then 1 else Attribute
        local u71 = MountRace.NumberAttribute(a2, "MaxLandingFallSpeed", 0)
        local u72 = 0
        local u73 = false

        local function launch() -- Line: 59
            -- upvalues: Rig (val), End (val), Y (val), a3 (val), MountRaceFlags (upval), u63 (val), Workspace (upval)
            -- upvalues: SoundService (upval), MountRace (upval), u72 (ref), a1 (val), RaceEffects (upval), a4 (val)
            -- upvalues: u71 (val), RunService (upval)
            local Root = Rig.Root
            local v1 = End.Position + Vector3.new(0, 1, 0) * Y - Root.Position
            local v2 = Vector3.new(v1.X, 0, v1.Z)
            if (v2.Unit:Dot(a3.TravelDirection)) < 0.3 then
                return
            end
            local v3 = (math.max((Root.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude, (MountRaceFlags.TopSpeed:Get()) * 0.8)) * u63
            local v4 = v2.Magnitude / v3
            local v5 = (v1.Y + 0.5 * Workspace.Gravity * v4 * v4) / v4
            a3:Launch(v2.Unit * v3 + Vector3.new(0, 1, 0) * v5)
            a3:PlayJumpAnimation()
            a3.Heading = v2.Unit
            SoundService:PlayLocalSound(MountRace.Sounds.HitJump)
            u72 = u72 + 1
            local u72_2 = u72
            a1:Add((a3.Landed:Once(function() -- Line: 77 -- upvalues: u72_2 (val), u72 (upval), a3 (upval), RaceEffects (upval), a4 (upval)
                if u72_2 == u72 then
                    a3:ApplyBoost(1.15, 0.6)
                    RaceEffects.Boost(a3, a4)
                end
            end)))
            task.delay(v4 + 1.5, function() -- Line: 83 -- upvalues: u72_2 (val), u72 (upval), a3 (upval)
                if u72_2 == u72 then
                    a3.Launched = false
                end
            end)
            if u71 > 0 then
                local Hitbox = Rig.Mount.Hitbox
                local u92 = nil
                a1:Connect(RunService.Heartbeat, function(a1_2) -- Line: 92
                    -- upvalues: u72_2 (val), u72 (upval), a3 (upval), a1 (upval), u92 (ref), Root (val), u71 (upval)
                    -- upvalues: Hitbox (val), Workspace (upval)
                    if u72_2 == u72 and a3.Launched then
                        local AssemblyLinearVelocity = Root.AssemblyLinearVelocity
                        local Y = AssemblyLinearVelocity.Y
                        if -u71 <= Y then
                            return
                        end
                        local v1 = Hitbox.Size.Y / 2 - AssemblyLinearVelocity.Y * a1_2 * 2 + 2
                        if Workspace:Raycast(Hitbox.Position, Vector3.new(0, 1, 0) * -v1, a3.Params) ~= nil then
                            Root.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, -u71, AssemblyLinearVelocity.Z)
                        end
                        return
                    end
                    a1:Remove(u92)
                end)
            end
        end

        a1:Connect(RunService.Heartbeat, function() -- Line: 111 -- upvalues: MountRace (upval), Start (val), Rig (val), u73 (ref), a3 (val), launch (val)
            local v1 = MountRace.IsInsidePart(Start, Rig.Mount.Hitbox.Position, (Vector3.new(0, 6, 0)))
            if v1 and not u73 and 0 < a3.Speed then
                launch()
            end
            u73 = v1
        end)
    end,
}