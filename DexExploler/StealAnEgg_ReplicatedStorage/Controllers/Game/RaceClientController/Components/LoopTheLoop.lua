-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.Components.LoopTheLoop
-- Decompile time: 2.21 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local MountRaceFlags = require(ReplicatedStorage.Shared.Flags.MountRaceFlags)
require(script.Parent.Parent.MountController)
local MountRace = require(ReplicatedStorage.Data.MountRace)
require(script.Parent.Parent.RaceCamera)
require(ReplicatedStorage.Packages.Trove)
return {
    Bind = function(a1, a2, a3, a4) -- Line: 29
        -- upvalues: RunService (val), MountRace (val), MountRaceFlags (val)
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
        local u45 = nil
        local u46 = false

        local function release() -- Line: 42 -- upvalues: u45 (ref), a3 (val)
            u45 = nil
            a3:SetStickMode(nil)
        end

        a1:Add(function() -- Line: 46 -- upvalues: u45 (ref), a3 (val)
            if u45 ~= nil then
                u45 = nil
                a3:SetStickMode(nil)
            end
        end)
        a1:Connect(RunService.Heartbeat, function() -- Line: 52
            -- upvalues: a3 (val), MountRace (upval), Start (val), u45 (ref), u46 (ref), a2 (val)
            -- upvalues: MountRaceFlags (upval), End (val)
            local Position = a3.Rig.Mount.Hitbox.Position
            local v1 = MountRace.IsInsidePart(Start, Position, (Vector3.new(2, 6, 2)))
            local v2 = u45
            if v2 ~= nil then
                local v3 = os.clock() - v2
                if a3.StickMinRatio == nil then
                    u45 = nil
                    a3:SetStickMode(nil)
                elseif not (v3 > 0.5) then
                    if v3 > 10 then
                        u45 = nil
                        a3:SetStickMode(nil)
                    end
                elseif MountRace.IsInsidePart(End, Position, (Vector3.new(2, 6, 2))) or v3 > 10 then
                    u45 = nil
                    a3:SetStickMode(nil)
                end
            elseif v1 and not u46 and 0 < a3.Speed then
                os.clock()
                a3:SetStickMode((MountRace.NumberAttribute(a2, "MinSpeedRatio", (MountRaceFlags.LoopMinSpeedRatio:Get()))))
            end
            u46 = v1
        end)
    end,
}