-- Script path: ReplicatedStorage.Shared.Util.ScrambleVaultPresentation
-- Decompile time: 1.03 ms

return table.freeze({
    CameraIn = 0.75,
    DoorStart = 0.5,
    DoorSeconds = 1.3,
    RevealAt = 1.8,
    DisplayScale = 0.35,
    FlyAt = 2.5,
    Duration = 4.2,
    Assets = function(a1) -- Line: 12 -- types: a1: userdata
        local Door = a1:FindFirstChild("Door")
        local Prompt = a1:FindFirstChild("Prompt")
        local BatSpawn = a1:FindFirstChild("BatSpawn")
        if Door
            and Door:IsA("Model")
            and Door:FindFirstChildWhichIsA("BasePart", true)
            and Prompt
            and Prompt:IsA("BasePart")
            and BatSpawn
            and BatSpawn:IsA("BasePart") then
            return Door, Prompt, BatSpawn
        end
        return nil, nil, nil
    end,
    DoorPose = function(a1, a2, a3) -- Line: 23 -- types: a1: userdata, a2: number, a3: number?
        return (CFrame.new(a1.Position)) * CFrame.Angles(
            0,
            (math.rad(if type(a3) ~= "number" then 105 else if a3 ~= a3 then 105 else math.clamp(a3, -170, 170))) * math.clamp(a2, 0, 1),
            0
        ) * a1.Rotation
    end,
})