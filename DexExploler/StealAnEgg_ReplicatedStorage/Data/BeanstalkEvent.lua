-- Script path: ReplicatedStorage.Data.BeanstalkEvent
-- Decompile time: 2.00 ms

local Attribute = game:GetService("ReplicatedStorage").Assets.BeanstalkEventAssets:GetAttribute("AuthoredMapPivot")
assert(typeof(Attribute) == "CFrame", "BeanstalkEventAssets needs an AuthoredMapPivot CFrame attribute")
local u20 = {}
u20.Stage = table.freeze({
    Fireflies = 1,
    Watering = 2,
    WhaleFlight = 3,
    EggEscape = 4,
    Complete = 5,
})
u20.StageAttribute = "BeanstalkStage"
u20.ProgressAttribute = "BeanstalkProgress"
u20.ClaimedAttribute = "BeanstalkClaimed"
u20.ParticipatingAttribute = "BeanstalkParticipating"
u20.StartedAtAttribute = "BeanstalkStartedAt"
u20.FinishedAtAttribute = "BeanstalkFinishedAt"
u20.RewardTitle = "Beanstalk Conquered!"
u20.PlaceAttribute = "BeanstalkPlace"
u20.MapFolderName = "BeanstalkEventMap"
u20.SlideExtraHeight = 750
u20.LaunchSeconds = 3
u20.EndingCutsceneSeconds = 38.55
u20.EndingHandBackSeconds = 0.5
u20.PlaceRewards = table.freeze({
    table.freeze({
        AssetId = "Amethyst Runebear OP",
        Mutations = {"Rainbow"},
        ScaleRange = NumberRange.new(1.8, 2.2),
    }),
    table.freeze({
        AssetId = "Amethyst Runebear OP",
        Mutations = {"Golden"},
        ScaleRange = NumberRange.new(1.8, 2.2),
    }),
    (table.freeze({AssetId = "Amethyst Runebear OP", ScaleRange = NumberRange.new(1.8, 2.2)})),
})
u20.FinisherReward = table.freeze({AssetId = "Amethyst Runebear"})

function u20.RewardFor(a1) -- Line: 115 -- upvalues: u20 (val) -- types: a1: number
    return u20.PlaceRewards[a1] or u20.FinisherReward
end

function u20.MapShift(a1) -- Line: 120 -- upvalues: Attribute (val) -- types: a1: userdata
    return (a1:GetPivot()) * Attribute:Inverse()
end

function u20.IsInsideBox(a1, a2, a3) -- Line: 124 -- types: a1: userdata, a2: vector, a3: number?
    local v1 = a1.CFrame:PointToObjectSpace(a2)
    local v2 = a1.Size * 0.5 + Vector3.new(1, 1, 1) * (a3 or 0)
    local v3 = false
    if (math.abs(v1.X)) <= v2.X then
        v3 = false
        if (math.abs(v1.Y)) <= v2.Y then
            v3 = (math.abs(v1.Z)) <= v2.Z
        end
    end
    return v3
end

function u20.IsOverFloor(a1, a2, a3) -- Line: 133 -- types: a1: userdata, a2: vector, a3: number
    local v1 = a1.CFrame:PointToObjectSpace(a2)
    local v2 = a1.Size * 0.5
    local v3 = false
    if (math.abs(v1.X)) <= v2.X then
        v3 = false
        if (math.abs(v1.Z)) <= v2.Z then
            v3 = false
            local Y = v1.Y
            if v2.Y - 2 <= Y then
                v3 = v1.Y <= v2.Y + a3
            end
        end
    end
    return v3
end

return table.freeze(u20)