-- Script path: ReplicatedStorage.Shared.Modules.NightFangHeight
-- Decompile time: 1.81 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u5 = {}
local u23 = {
    ["rbxassetid://138755573007016"] = 0.2715822764466176,
    ["rbxassetid://133536318506183"] = 0.629364013671875 * ReplicatedStorage.AssetModels["Halloween Terrorbird"].Model:GetScale() / (2.7933807373046875 * ReplicatedStorage.AssetModels["Zombified Halloween Terrorbird"].Model:GetScale()),
}

function u5.New(a1) -- Line: 11 -- types: a1: userdata
    if a1.Name ~= "Zombified Halloween Terrorbird" and a1:GetAttribute("PreparedSourceName") ~= "Zombified Bat" then
        return nil
    end
    local Control = a1:FindFirstChild("Control", true)
    if Control and Control:IsA("Bone") then
        return {Applied = 0, Ratio = 0.2715822764466176, Model = a1, Control = Control}
    end
    return nil
end

function u5.Reset(a1) -- Line: 17
    if not a1 then
        return
    end
    if a1.Control.Parent then
        local Control = a1.Control
        Control.Transform = Control.Transform + Vector3.new(0, a1.Applied, 0)
    end
    a1.Applied = 0
end

function u5.Apply(a1) -- Line: 22 -- upvalues: u5 (val), u23 (val)
    if a1 and a1.Control.Parent then
        u5.Reset(a1)
        local Animator = a1.Model:FindFirstChildWhichIsA("Animator", true)
        local v1 = 0
        local v2 = 0
        if Animator then
            local v3
            for i, j in Animator:GetPlayingAnimationTracks() do
                v3 = u23[j.Animation.AnimationId]
                if v3 then
                    v1 = v1 + v3 * j.WeightCurrent
                    v2 = v2 + j.WeightCurrent
                end
            end
        end
        if v2 > 0 then
            a1.Ratio = v1 / v2
        end
        a1.Applied = (math.max(0, a1.Control.Transform.Position.Y)) * (1 - a1.Ratio)
        local Control_2 = a1.Control
        Control_2.Transform = Control_2.Transform - Vector3.new(0, a1.Applied, 0)
        return
    end
end

return u5