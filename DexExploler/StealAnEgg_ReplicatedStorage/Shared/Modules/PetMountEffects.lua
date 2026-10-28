-- Script path: ReplicatedStorage.Shared.Modules.PetMountEffects
-- Decompile time: 4.56 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local EmitOnce = require(ReplicatedStorage.UserGenerated.VFX.EmitOnce)
local u20 = nil
local v1 = {}

local function findTemplate() -- Line: 21 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local VFX = Assets and Assets:FindFirstChild("VFX")
    local v1 = VFX and VFX:FindFirstChild("MonsterParasite")
    return v1 and v1:FindFirstChild("SwapPoof")
end

local function scaleSize(a1, a2) -- Line: 28 -- types: a1: userdata, a2: number
    local v1 = {}
    for i, j in a1.Keypoints do
        table.insert(v1, (NumberSequenceKeypoint.new(j.Time, j.Value * a2, j.Envelope * a2)))
    end
    return NumberSequence.new(v1)
end

local function playSound(a1, a2) -- Line: 36
    -- upvalues: u20 (ref), ReplicatedStorage (val)
    task.spawn(function() -- Line: 37 -- upvalues: u20 (upval), ReplicatedStorage (upval), a1 (val), a2 (val)
        pcall(function() -- Line: 38 -- upvalues: u20 (upval), ReplicatedStorage (upval), a1 (upval), a2 (upval)
            if u20 == nil then
                u20 = require(ReplicatedStorage.Shared.Audio)
            end
            if a1.Parent then
                u20.Play("rbxassetid://102267539121951", a1, {Volume = 0.5, Looped = false, MaxDistance = a2})
            end
        end)
    end)
end

function v1.Play(a1, a2, a3, a4) -- Line: 48
    -- upvalues: RunService (val), ReplicatedStorage (val), Debris (val), scaleSize (val), EmitOnce (val), u20 (ref)
    if not RunService:IsClient() then
        return false
    end
    local CurrentCamera = workspace.CurrentCamera
    if CurrentCamera and not (a3 < (CurrentCamera.CFrame.Position - a1.Position).Magnitude) then
        local u20_2 = math.max(a2.X, a2.Y, a2.Z)
        if not (u20_2 <= 0) and u20_2 == u20_2 and u20_2 ~= (1 / 0) then
            local Assets = ReplicatedStorage:FindFirstChild("Assets")
            local VFX = Assets and Assets:FindFirstChild("VFX")
            local v1 = VFX and VFX:FindFirstChild("MonsterParasite")
            local u45 = v1
            if u45 then
                u45 = v1:FindFirstChild("SwapPoof")
            end
            if not u45 then
                return false
            end
            local Part = Instance.new("Part")
            Part.Name = "PetMountPoof"
            Part.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
            Part.Transparency = 1
            Part.Anchored = true
            Part.CanCollide = false
            Part.CanTouch = false
            Part.CanQuery = false
            Part.CastShadow = false
            Part.CFrame = a1
            local Transient = workspace:FindFirstChild("Transient") or workspace
            Part.Parent = Transient
            Debris:AddItem(Part, 2)
            local success, err = pcall(function() -- Line: 70 -- upvalues: Part (val), u20_2 (val), u45 (val), scaleSize (upval), EmitOnce (upval)
                local v1
                local Attachment = Instance.new("Attachment")
                Attachment.Parent = Part
                local v2 = math.clamp(u20_2 / 8.4, 0.7, 2.2)
                local v3 = 0
                for i, j in u45:GetDescendants() do
                    if j:IsA("ParticleEmitter") then
                        v1 = j:GetAttribute("EmitDelay") or 0
                        if not (j.TimeScale <= 0)
                            and typeof(v1) == "number"
                            and not (v1 < 0)
                            and not (1.9 < v1 + j.Lifetime.Max / j.TimeScale) then
                            v1 = j:Clone()
                            v1.Enabled = false
                            v1.Size = scaleSize(v1.Size, v2)
                            v1.Speed = NumberRange.new(v1.Speed.Min * v2, v1.Speed.Max * v2)
                            v1.Acceleration = v1.Acceleration * v2
                            v1.ZOffset = v1.ZOffset * v2
                            v1.Parent = Attachment
                            if 0 < (EmitOnce(v1)) then
                                v3 = v3 + 1
                            end
                        end
                    end
                end
                return v3 > 0
            end)
            if success and err then
                if a4 then
                    task.spawn(function() -- Line: 37 -- upvalues: u20 (upval), ReplicatedStorage (upval), Part (val), a3 (val)
                        pcall(function() -- Line: 38 -- upvalues: u20 (upval), ReplicatedStorage (upval), Part (upval), a3 (upval)
                            if u20 == nil then
                                u20 = require(ReplicatedStorage.Shared.Audio)
                            end
                            if Part.Parent then
                                u20.Play("rbxassetid://102267539121951", Part, {Volume = 0.5, Looped = false, MaxDistance = a3})
                            end
                        end)
                    end)
                end
                return true
            end
            Part:Destroy()
            return false
        end
        return false
    end
    return false
end

return v1