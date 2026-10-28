-- Script path: ReplicatedStorage.Controllers.Game.GhostDogQuestController.Swim
-- Decompile time: 2.93 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Trove)
local u9 = {Swim = "swim", Idle = "swimidle"}
local u10 = {Swim = "rbxassetid://507784897", Idle = "rbxassetid://507785072"}
local u11 = nil
local u12 = {}

local function animationId(a1, a2) -- Line: 34 -- upvalues: u9 (val), u10 (val) -- types: a1: userdata, a2: string
    local Animate = a1:FindFirstChild("Animate")
    local v1 = Animate and Animate:FindFirstChild(u9[a2])
    local v2 = v1 and v1:FindFirstChildWhichIsA("Animation")
    if v2 and v2.AnimationId ~= "" then
        return v2.AnimationId
    end
    return u10[a2]
end

function u12.Start(a1, a2, a3) -- Line: 44
    -- upvalues: u12 (val), u9 (val), u10 (val), u11 (ref)
    u12.Stop()
    local Humanoid = a2:FindFirstChildOfClass("Humanoid")
    local Animator = Humanoid and Humanoid:FindFirstChildOfClass("Animator")
    if Humanoid ~= nil and Animator ~= nil and Humanoid.RigType == Enum.HumanoidRigType.R15 then
        local Animate, Animation, AnimationId, err, success, v1, v2
        local u95 = {}
        local v3 = nil
        local v4 = nil
        local v5, v6, v7 = a1, a3, a2
        for i in u9, v3, v4 do
            Animation = Instance.new("Animation")
            Animate = v7:FindFirstChild("Animate")
            v2 = Animate and Animate:FindFirstChild(u9[i])
            v1 = v2 and v2:FindFirstChildWhichIsA("Animation")
            AnimationId = if not v1 then u10[i] else if v1.AnimationId == "" then u10[i] else v1.AnimationId
            Animation.AnimationId = AnimationId
            success, err = pcall(Animator.LoadAnimation, Animator, Animation)
            if success and err then
                err.Priority = Enum.AnimationPriority.Action
                err.Looped = true
                u95[i] = err
            end
        end
        local u29 = nil
        local u30 = false
        local u31 = nil
        u31 = {
            Set = function(a1, a2) -- Line: 66 -- upvalues: u30 (ref), u95 (val), u29 (ref) -- types: a1: string, a2: number?
                if u30 then
                    return
                end
                local v1 = u95[a1]
                if v1 == nil then
                    return
                end
                if u29 == v1 then
                    if a2 then
                        v1:AdjustSpeed(a2)
                    end
                    return
                end
                if u29 then
                    u29:Stop(0.25)
                end
                v1:Play(0.25, 1, a2 or 1)
                u29 = v1
            end,
            Stop = function() -- Line: 84 -- upvalues: u30 (ref), u95 (val), u11 (upval), u31 (ref)
                if u30 then
                    return
                end
                u30 = true
                for i, j in u95 do
                    j:Stop(0.25)
                end
                if u11 == u31 then
                    u11 = nil
                end
            end,
        }
        u11 = u31
        v5:Add(u31.Stop)
        u31.Set(v6)
        return u31
    end
    return nil
end

function u12.Stop() -- Line: 103 -- upvalues: u11 (ref)
    local v1 = u11
    u11 = nil
    if v1 then
        v1.Stop()
    end
end

return (table.freeze(u12))