-- Script path: ReplicatedStorage.Controllers.Game.BanjoCricketController.Spores
-- Decompile time: 8.96 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local BanjoCricket = require(ReplicatedStorage.Data.BanjoCricket)
local u24 = require(script.Parent.Mushrooms)
local u29 = Color3.fromRGB(130, 130, 125)
local u33 = setmetatable({}, {__mode = "k"})
local v1 = {}

local function fade(a1) -- Line: 40 -- types: a1: number
    return NumberSequence.new({NumberSequenceKeypoint.new(0, a1), (NumberSequenceKeypoint.new(1, 1))})
end

local function shrink(a1, a2) -- Line: 47 -- types: a1: number, a2: number
    return NumberSequence.new({NumberSequenceKeypoint.new(0, a1), (NumberSequenceKeypoint.new(1, a2))})
end

local function sporeEmitter(a1) -- Line: 54
    -- upvalues: BanjoCricket (val), shrink (val), fade (val)
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "Spores"
    ParticleEmitter.Texture = BanjoCricket.Textures.Spore
    ParticleEmitter.Rate = 0
    ParticleEmitter.Lifetime = NumberRange.new(0.6, 1.1)
    ParticleEmitter.Speed = NumberRange.new(5, 9)
    ParticleEmitter.SpreadAngle = Vector2.new(55, 55)
    ParticleEmitter.EmissionDirection = Enum.NormalId.Top
    ParticleEmitter.Drag = 3
    ParticleEmitter.Acceleration = Vector3.new(0, 2, 0)
    ParticleEmitter.Size = shrink(0.45, 0)
    ParticleEmitter.Transparency = fade(0)
    ParticleEmitter.LightEmission = 1
    ParticleEmitter.Rotation = NumberRange.new(0, 360)
    ParticleEmitter.Parent = a1
    return ParticleEmitter
end

local function wiltEmitter(a1) -- Line: 73
    -- upvalues: BanjoCricket (val), u29 (val), shrink (val), fade (val)
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "Wilt"
    ParticleEmitter.Texture = BanjoCricket.Textures.Spore
    ParticleEmitter.Rate = 0
    ParticleEmitter.Color = ColorSequence.new(u29)
    ParticleEmitter.Lifetime = NumberRange.new(0.7, 1.1)
    ParticleEmitter.Speed = NumberRange.new(2, 4)
    ParticleEmitter.SpreadAngle = Vector2.new(80, 80)
    ParticleEmitter.EmissionDirection = Enum.NormalId.Top
    ParticleEmitter.Drag = 2
    ParticleEmitter.Acceleration = Vector3.new(0, -10, 0)
    ParticleEmitter.Size = shrink(0.35, 0.1)
    ParticleEmitter.Transparency = fade(0.2)
    ParticleEmitter.Rotation = NumberRange.new(0, 360)
    ParticleEmitter.Parent = a1
    return ParticleEmitter
end

local function noteEmitter(a1) -- Line: 92 -- upvalues: BanjoCricket (val) -- types: a1: userdata
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "Note"
    ParticleEmitter.Texture = BanjoCricket.Textures.Note
    ParticleEmitter.Rate = 0
    ParticleEmitter.Lifetime = NumberRange.new(1.2, 1.5)
    ParticleEmitter.Speed = NumberRange.new(3, 4)
    ParticleEmitter.SpreadAngle = Vector2.new(12, 12)
    ParticleEmitter.EmissionDirection = Enum.NormalId.Top
    ParticleEmitter.Drag = 1
    ParticleEmitter.Acceleration = Vector3.new(0, 1, 0)
    ParticleEmitter.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.8),
        NumberSequenceKeypoint.new(0.2, 1.2),
        (NumberSequenceKeypoint.new(1, 1)),
    })
    ParticleEmitter.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.6, 0.1),
        (NumberSequenceKeypoint.new(1, 1)),
    })
    ParticleEmitter.LightEmission = 0.4
    ParticleEmitter.Rotation = NumberRange.new(-15, 15)
    ParticleEmitter.RotSpeed = NumberRange.new(-20, 20)
    ParticleEmitter.Parent = a1
    return ParticleEmitter
end

local function topOf(a1) -- Line: 120 -- types: a1: userdata
    return a1.Position + Vector3.new(0, 1, 0) * a1.Size.Y / 2
end

local function emittersFor(a1) -- Line: 126
    -- upvalues: u33 (val), Workspace (val), sporeEmitter (val), wiltEmitter (val), noteEmitter (val)
    local v1 = u33[a1]
    if v1 then
        v1.Attachment.WorldPosition = a1.Position + Vector3.new(0, 1, 0) * a1.Size.Y / 2
        return v1
    end
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "BanjoCricketSpores"
    Attachment.Parent = Workspace.Terrain
    Attachment.WorldPosition = a1.Position + Vector3.new(0, 1, 0) * a1.Size.Y / 2
    a1.Destroying:Once(function() -- Line: 136 -- upvalues: Attachment (val)
        Attachment:Destroy()
    end)
    local v2 = {
        Attachment = Attachment,
        Spores = sporeEmitter(Attachment),
        Wilt = wiltEmitter(Attachment),
        Note = noteEmitter(Attachment),
    }
    u33[a1] = v2
    return v2
end

local function isVisible(a1) -- Line: 149 -- upvalues: Workspace (val) -- types: a1: vector
    local CurrentCamera = Workspace.CurrentCamera
    local v1 = false
    if CurrentCamera ~= nil then
        v1 = (CurrentCamera.CFrame.Position - a1).Magnitude <= 160
    end
    return v1
end

function v1.Puff(a1) -- Line: 155
    -- upvalues: u24 (val), BanjoCricket (val), Workspace (val), emittersFor (val)
    local v1 = u24.Anchor(a1)
    local v2 = BanjoCricket.Mushrooms[a1]
    if v1 ~= nil and v2 ~= nil then
        local Position = v1.Position
        local CurrentCamera = Workspace.CurrentCamera
        local v3 = false
        if CurrentCamera ~= nil then
            v3 = (CurrentCamera.CFrame.Position - Position).Magnitude <= 160
        end
        if v3 then
            v3 = emittersFor(v1)
            v1 = ColorSequence.new(v2.Color)
            v3.Spores.Color = v1
            v3.Spores:Emit(14)
            v3.Note.Color = v1
            v3.Note:Emit(1)
            return
        end
    end
end

function v1.Wilt() -- Line: 169 -- upvalues: BanjoCricket (val), u24 (val), Workspace (val), emittersFor (val)
    local CurrentCamera, Position, v1, v2
    local v3 = nil
    local v4 = nil
    for i in BanjoCricket.Mushrooms, v3, v4 do
        v1 = u24.Anchor(i)
        if v1 then
            Position = v1.Position
            CurrentCamera = Workspace.CurrentCamera
            v2 = false
            if CurrentCamera ~= nil then
                v2 = (CurrentCamera.CFrame.Position - Position).Magnitude <= 160
            end
            if v2 then
                emittersFor(v1).Wilt:Emit(10)
            end
        end
    end
end

function v1.Spiral() -- Line: 179
    -- upvalues: BanjoCricket (val), u24 (val), Workspace (val), sporeEmitter (val), RunService (val)
    local Position, Y, v1
    local u0 = {}
    local u1 = {}
    local v2 = nil
    for i, j in BanjoCricket.Mushrooms, v2 do
        v1 = u24.Anchor(i)
        if v1 then
            Position = v1.Position
            Y = v1.Size.Y
            table.insert(u0, Position + Vector3.new(0, 1, 0) * Y / 2)
            table.insert(u1, j.Color)
        end
    end
    if not (#u0 < 2) then
        v2 = u0[1]
        local CurrentCamera = Workspace.CurrentCamera
        local v3 = false
        if CurrentCamera ~= nil then
            v3 = (CurrentCamera.CFrame.Position - v2).Magnitude <= 160
        end
        if v3 then
            local Part = Instance.new("Part")
            Part.Name = "BanjoCricketSpiral"
            Part.Anchored = true
            Part.CanCollide = false
            Part.CanQuery = false
            Part.CanTouch = false
            Part.Transparency = 1
            Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
            Part.CFrame = CFrame.new(u0[1])
            local Attachment = Instance.new("Attachment")
            Attachment.Parent = Part
            local u47 = sporeEmitter(Attachment)
            u47.Rate = 90
            u47.Speed = NumberRange.new(0.5, 1.5)
            u47.Lifetime = NumberRange.new(0.5, 0.8)
            Part.Parent = Workspace
            local u60 = os.clock()
            local u61 = nil
            RunService.PreRender:Connect(function() -- Line: 210 -- upvalues: u60 (val), u0 (val), Part (val), u47 (val), u1 (val), u61 (ref)
                local v1 = math.min((os.clock() - u60) / 1.1, 1)
                local v2 = v1 * (#u0 - 1)
                local v3 = math.min(math.floor(v2) + 1, #u0 - 1)
                local v4 = v2 - (v3 - 1)
                v2 = v1 * 5 * 3.141592653589793 * 2
                local v5 = u0[v3]:Lerp(u0[v3 + 1], v4)
                Part.CFrame = CFrame.new(v5 + Vector3.new(math.cos(v2) * 1.6, math.sin(v1 * 3.141592653589793) * 3, (math.sin(v2)) * 1.6))
                u47.Color = ColorSequence.new(u1[v3]:Lerp(u1[v3 + 1], v4))
                if v1 >= 1 then
                    u61:Disconnect()
                    u47.Enabled = false
                    task.delay(1, function() -- Line: 230 -- upvalues: Part (upval)
                        Part:Destroy()
                    end)
                end
            end)
            return
        end
    end
end

return table.freeze(v1)