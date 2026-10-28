-- Script path: ReplicatedStorage.Client.Modules.ShakePresets
-- Decompile time: 3.20 ms

local v1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Shake = require(ReplicatedStorage.Packages.Shake)
local v2 = {
    {
        "Bump",
        2.5,
        0.25,
        0.1,
        0.75,
        Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448),
        (Vector3.new(1, 1, 1)),
    },
    {
        "BumpS",
        1.5,
        0.25,
        0.1,
        0.75,
        Vector3.new(0.15000000596046448, 0.15000000596046448, 0.15000000596046448),
        (Vector3.new(1, 1, 1)),
    },
    {"Explosion", 5, 0.1, 0, 1.5, Vector3.new(0.25, 0.25, 0.25), (Vector3.new(4, 1, 1))},
    {
        "Earthquake",
        0.6,
        0.2857142857142857,
        2,
        10,
        Vector3.new(0.25, 0.25, 0.25),
        (Vector3.new(1, 1, 4)),
    },
    {
        "BadTrip",
        10,
        6.666666666666667,
        5,
        10,
        Vector3.new(0, 0, 0.15000000596046448),
        (Vector3.new(2, 1, 4)),
    },
    {"HandheldCamera", 1, 0.25, 5, 10, Vector3.new(0, 0, 0), (Vector3.new(1, 0.5, 0.5))},
    {
        "Vibration",
        0.4,
        0.05,
        2,
        2,
        Vector3.new(0, 0.15000000596046448, 0),
        (Vector3.new(1.25, 0, 4)),
    },
    {"RoughDriving", 1, 0.5, 1, 1, Vector3.new(0, 0, 0), (Vector3.new(1, 1, 1))},
}
local v3 = {}
for i, j in v2 do
    v1 = Shake.new()
    v1.Amplitude = j[2]
    v1.Frequency = j[3]
    v1.FadeInTime = j[4]
    v1.FadeOutTime = j[5]
    v1.PositionInfluence = j[6]
    v1.RotationInfluence = j[7]
    v3[j[1]] = v1
end

function v3.DriveCamera(a1, a2) -- Line: 104 -- upvalues: Shake (val), RunService (val)
    local CurrentCamera = a2
    if not CurrentCamera then
        CurrentCamera = workspace.CurrentCamera
    end
    assert(CurrentCamera, "no camera to attach a shake to")
    local u10 = nil
    local u29 = nil
    local u12 = true
    a1:BindToRenderStep(Shake.NextRenderName(), Enum.RenderPriority.Last.Value, function(a1, a2, a3) -- Line: 115 -- upvalues: u10 (ref), CurrentCamera (val), u12 (ref), u29 (ref)
        u10 = CurrentCamera.CFrame
        CurrentCamera.CFrame = CurrentCamera.CFrame * ((CFrame.new(a1)) * CFrame.Angles(0, math.rad(a2.Y), 0) * CFrame.Angles(math.rad(a2.X), 0, (math.rad(a2.Z))))
        if a3 then
            u12 = false
            if u29 then
                u29:Disconnect()
                u29 = nil
            end
        end
    end)
    if u12 then
        u29 = RunService.PostSimulation:Connect(function() -- Line: 135 -- upvalues: u10 (ref), CurrentCamera (val)
            if u10 then
                CurrentCamera.CFrame = u10
            end
        end)
    end
    return function() -- Line: 142 -- upvalues: u29 (ref), a1 (val)
        if u29 then
            u29:Disconnect()
            u29 = nil
        end
        a1:Destroy()
    end
end

return v3