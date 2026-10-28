-- Script path: ReplicatedStorage.Controllers.Game.SewerCaveController.Transition.Splash
-- Decompile time: 9.22 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Kit = require(script.Parent.Kit)
require(ReplicatedStorage.Packages.Trove)
local u18 = Color3.fromRGB(190, 250, 240)
local v1 = {
    Build = function(a1, a2, a3) -- Line: 48 -- upvalues: Kit (val), u18 (val) -- types: a2: userdata, a3: boolean
        local v1 = a1:Add((Kit.Part({Name = "SewerDrainSplash", Size = Vector3.new(1, 1, 1), Transparency = 1})))
        local Attachment = Instance.new("Attachment")
        Attachment.Name = "Burst"
        Attachment.Parent = v1
        local v2 = Kit.Emitter({
            Name = "Droplets",
            Texture = "rbxassetid://8084996370",
            LightEmission = 0.3,
            LightInfluence = 0.4,
            Acceleration = Vector3.new(0, -110, 0),
            Drag = 0.6,
            Color = ColorSequence.new(u18),
            Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.7), (NumberSequenceKeypoint.new(1, 0.25))}),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.05),
                NumberSequenceKeypoint.new(0.8, 0.2),
                (NumberSequenceKeypoint.new(1, 1)),
            }),
            Lifetime = NumberRange.new(0.7, 1.1),
            Speed = NumberRange.new(26, 44),
            SpreadAngle = Vector2.new(38, 38),
            EmissionDirection = Enum.NormalId.Top,
            Orientation = Enum.ParticleOrientation.VelocityParallel,
        })
        v2.Parent = Attachment
        local v3 = Kit.Emitter({
            Name = "Mist",
            Texture = "rbxassetid://11799239106",
            LightEmission = 0.1,
            LightInfluence = 0.2,
            Drag = 3,
            Color = ColorSequence.new(Color3.fromRGB(225, 255, 250)),
            Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 3), (NumberSequenceKeypoint.new(1, 9))}),
            Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.55), (NumberSequenceKeypoint.new(1, 1))}),
            Lifetime = NumberRange.new(0.6, 1.1),
            Speed = NumberRange.new(4, 10),
            SpreadAngle = Vector2.new(180, 180),
            Rotation = NumberRange.new(0, 360),
            RotSpeed = NumberRange.new(-40, 40),
        })
        v3.Parent = Attachment
        local v4 = Kit.Emitter({
            Name = "Column",
            Texture = "rbxasset://textures/particles/smoke_main.dds",
            LightEmission = 0.15,
            LightInfluence = 0.15,
            Acceleration = Vector3.new(0, -70, 0),
            Drag = 1.5,
            Color = ColorSequence.new(Color3.fromRGB(200, 245, 238), Color3.fromRGB(110, 200, 190)),
            Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 2.5),
                NumberSequenceKeypoint.new(0.4, 4.5),
                (NumberSequenceKeypoint.new(1, 6)),
            }),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.25),
                NumberSequenceKeypoint.new(0.6, 0.5),
                (NumberSequenceKeypoint.new(1, 1)),
            }),
            Lifetime = NumberRange.new(0.55, 0.85),
            Speed = NumberRange.new(24, 38),
            SpreadAngle = Vector2.new(10, 10),
            EmissionDirection = Enum.NormalId.Top,
            Rotation = NumberRange.new(0, 360),
            RotSpeed = NumberRange.new(-90, 90),
        })
        v4.Parent = Attachment
        local v5 = Kit.Emitter({
            Name = "Core",
            Texture = "rbxasset://textures/particles/explosion01_core_main.dds",
            LightEmission = 0.6,
            LightInfluence = 0,
            Color = ColorSequence.new(Color3.fromRGB(220, 255, 248)),
            Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 3), (NumberSequenceKeypoint.new(1, 8))}),
            Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.55), (NumberSequenceKeypoint.new(1, 1))}),
            Lifetime = NumberRange.new(0.25, 0.35),
            Speed = NumberRange.new(0, 2),
        })
        v5.Parent = Attachment
        local v6 = Kit.Emitter({
            Name = "Ring",
            Texture = "rbxassetid://109600784699514",
            LightEmission = 0.4,
            LightInfluence = 0,
            Color = ColorSequence.new(Color3.fromRGB(160, 240, 225)),
            Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
            EmissionDirection = Enum.NormalId.Top,
            Speed = NumberRange.new(0.01),
            Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2), (NumberSequenceKeypoint.new(1, 24))}),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.35),
                NumberSequenceKeypoint.new(0.7, 0.7),
                (NumberSequenceKeypoint.new(1, 1)),
            }),
            Lifetime = NumberRange.new(0.6),
        })
        v6.Parent = Attachment
        local v7 = Kit.Emitter({
            Name = "Ripples",
            Texture = "rbxassetid://9216446257",
            LightEmission = 0.3,
            LightInfluence = 0.3,
            FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4,
            FlipbookMode = Enum.ParticleFlipbookMode.OneShot,
            Color = ColorSequence.new(Color3.fromRGB(220, 255, 250)),
            Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
            EmissionDirection = Enum.NormalId.Top,
            Speed = NumberRange.new(0.01),
            Size = NumberSequence.new(10, 14),
            Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.2), (NumberSequenceKeypoint.new(1, 1))}),
            Lifetime = NumberRange.new(0.9, 1.3),
            SpreadAngle = Vector2.new(0, 0),
        })
        v7.Parent = Attachment
        local Attachment_2 = Instance.new("Attachment")
        Attachment_2.Name = "JetFrom"
        Attachment_2.Parent = v1
        local Attachment_3 = Instance.new("Attachment")
        Attachment_3.Name = "JetTo"
        Attachment_3.Parent = v1
        local v8 = {
            Kit.Beam({
                Name = "JetShine",
                Texture = "rbxassetid://11799004744",
                TextureLength = 5,
                TextureSpeed = 4,
                LightEmission = 1,
                Width0 = 2.6,
                Width1 = 1.2,
                FaceCamera = true,
                Enabled = false,
                Attachment0 = Attachment_2,
                Attachment1 = Attachment_3,
                TextureMode = Enum.TextureMode.Wrap,
                Color = ColorSequence.new(Color3.new(1, 1, 1)),
                Transparency = NumberSequence.new(0.3, 1),
            }),
        }
        for i, j in v8 do
            j.Parent = v1
        end
        local Attachment_4 = Instance.new("Attachment")
        Attachment_4.Name = "GushAt"
        Attachment_4.Parent = v1
        local v9 = Kit.Emitter({
            Name = "Gush",
            Texture = "rbxasset://textures/particles/smoke_main.dds",
            LightEmission = 0.25,
            LightInfluence = 0.3,
            Acceleration = Vector3.new(0, -60, 0),
            Drag = 1,
            Color = ColorSequence.new(Color3.fromRGB(215, 252, 245), Color3.fromRGB(120, 210, 196)),
            Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1.6),
                NumberSequenceKeypoint.new(0.5, 2.6),
                (NumberSequenceKeypoint.new(1, 3.4)),
            }),
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.3),
                NumberSequenceKeypoint.new(0.7, 0.55),
                (NumberSequenceKeypoint.new(1, 1)),
            }),
            Lifetime = NumberRange.new(0.35, 0.5),
            Speed = NumberRange.new(30, 40),
            SpreadAngle = Vector2.new(7, 7),
            EmissionDirection = Enum.NormalId.Top,
            Rotation = NumberRange.new(0, 360),
            RotSpeed = NumberRange.new(-120, 120),
        })
        v9.Parent = Attachment_4
        local v10 = Kit.Emitter({
            Name = "Spray",
            Texture = "rbxassetid://8084996370",
            LightEmission = 0.3,
            LightInfluence = 0.4,
            Acceleration = Vector3.new(0, -90, 0),
            Color = ColorSequence.new(u18),
            Size = NumberSequence.new(0.5, 0.2),
            Transparency = NumberSequence.new(0.1, 1),
            Lifetime = NumberRange.new(0.4, 0.6),
            Speed = NumberRange.new(28, 42),
            SpreadAngle = Vector2.new(14, 14),
            EmissionDirection = Enum.NormalId.Top,
            Orientation = Enum.ParticleOrientation.VelocityParallel,
        })
        v10.Parent = Attachment_4
        v1.Parent = a2
        return {
            Hub = v1,
            Burst = Attachment,
            Droplets = v2,
            Mist = v3,
            Column = v4,
            Core = v5,
            Ring = v6,
            Ripples = v7,
            JetFrom = Attachment_2,
            JetTo = Attachment_3,
            Jet = v8,
            GushAt = Attachment_4,
            Gush = v9,
            Spray = v10,
            Scale = if not a3 then 1 else 0.6,
        }
    end,
}

local function count(a1, a2) -- Line: 278 -- types: a1: table, a2: number
    return (math.max(math.floor(a2 * a1.Scale + 0.5), 1))
end

function v1.Big(a1, a2) -- Line: 282 -- types: a1: table, a2: vector
    a1.Burst.WorldCFrame = CFrame.new(a2)
    a1.Droplets:Emit((math.max(math.floor(a1.Scale * 30 + 0.5), 1)))
    a1.Column:Emit((math.max(math.floor(a1.Scale * 14 + 0.5), 1)))
    a1.Core:Emit(2)
    a1.Mist:Emit((math.max(math.floor(a1.Scale * 6 + 0.5), 1)))
    a1.Ring:Emit(1)
    a1.Ripples:Emit(2)
end

function v1.Small(a1, a2) -- Line: 292 -- types: a1: table, a2: vector
    a1.Burst.WorldCFrame = CFrame.new(a2)
    a1.Droplets:Emit((math.max(math.floor(a1.Scale * 12 + 0.5), 1)))
    a1.Ripples:Emit(1)
end

function v1.Land(a1, a2) -- Line: 298 -- types: a1: table, a2: vector
    a1.Burst.WorldCFrame = CFrame.new(a2)
    a1.Droplets:Emit((math.max(math.floor(a1.Scale * 10 + 0.5), 1)))
    a1.Mist:Emit((math.max(math.floor(a1.Scale * 2 + 0.5), 1)))
end

function v1.Crown(a1, a2) -- Line: 304 -- types: a1: table, a2: userdata
    a1.Burst.WorldCFrame = a2
    a1.Droplets:Emit((math.max(math.floor(a1.Scale * 20 + 0.5), 1)))
end

function v1.Jet(a1, a2, a3, a4) -- Line: 309 -- types: a1: table, a2: vector, a3: vector, a4: number
    local v1 = a4 > 0.001
    a1.JetFrom.WorldPosition = a2
    a1.JetTo.WorldPosition = a2:Lerp(a3, (math.clamp(a4, 0, 1)))
    for i, j in a1.Jet do
        j.Enabled = v1
    end
    if 0.01 < (a3 - a2).Magnitude then
        a1.GushAt.WorldCFrame = (CFrame.lookAt(a2, a3)) * CFrame.Angles(-1.5707963267948966, 0, 0)
    end
    local v2 = if not v1 then 0 else a1.Scale * 70 * math.clamp(a4, 0, 1)
    a1.Gush.Rate = v2
    a1.Spray.Rate = v2 * 0.6
end

function v1.Drips(a1, a2, a3) -- Line: 325 -- upvalues: Kit (val) -- types: a2: userdata, a3: number
    local v1 = a1:Add((Instance.new("Attachment")))
    v1.Name = "SewerDrainDrips"
    v1.Position = Vector3.new(0, a2.Size.Y * 0.3, 0)
    v1.Parent = a2
    local u49 = Kit.Emitter({
        Name = "Drips",
        Texture = "rbxassetid://7027357365",
        LightEmission = 0.25,
        LightInfluence = 0.6,
        Acceleration = Vector3.new(0, -60, 0),
        Rate = 9,
        Color = ColorSequence.new(Color3.fromRGB(205, 250, 245)),
        Size = NumberSequence.new(0.22, 0.12),
        Transparency = NumberSequence.new(0.15, 0.6),
        Lifetime = NumberRange.new(0.5, 0.7),
        Speed = NumberRange.new(0, 1),
        SpreadAngle = Vector2.new(60, 60),
        EmissionDirection = Enum.NormalId.Bottom,
        Orientation = Enum.ParticleOrientation.VelocityParallel,
    })
    u49.Parent = v1
    a1:Add((task.delay(a3, function() -- Line: 347 -- upvalues: u49 (val)
        u49.Enabled = false
    end)))
end

return table.freeze(v1)