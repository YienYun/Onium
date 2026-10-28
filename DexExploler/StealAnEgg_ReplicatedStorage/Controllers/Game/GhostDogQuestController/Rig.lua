-- Script path: ReplicatedStorage.Controllers.Game.GhostDogQuestController.Rig
-- Decompile time: 6.73 ms

local v1 = {}

local function rot(a1, a2, a3) -- Line: 44 -- types: a1: number, a2: number, a3: number
    return CFrame.Angles(math.rad(a1), math.rad(a2), (math.rad(a3)))
end

local function clip(a1, a2, a3) -- Line: 48 -- types: a1: string, a2: number?, a3: boolean?
    return {Animation = a1, Speed = a2 or 1, Looped = if a3 ~= nil then a3 else true}
end

local function animatorOf(a1) -- Line: 56 -- types: a1: userdata
    local AnimationController = a1:FindFirstChildOfClass("Humanoid") or a1:FindFirstChildOfClass("AnimationController")
    if AnimationController == nil then
        return nil
    end
    local v1 = AnimationController:FindFirstChildOfClass("Animator")
    if v1 == nil then
        v1 = Instance.new("Animator")
        v1.Parent = AnimationController
    end
    return v1
end

local function loadTracks(a1) -- Line: 70 -- types: a1: userdata
    local v1
    local v2 = {}
    local AnimationController = a1:FindFirstChildOfClass("Humanoid") or a1:FindFirstChildOfClass("AnimationController")
    if AnimationController ~= nil then
        local v3 = AnimationController:FindFirstChildOfClass("Animator")
        if v3 == nil then
            v3 = Instance.new("Animator")
            v3.Parent = AnimationController
        end
        v1 = v3
    else
        v1 = nil
    end
    local Animations = a1:FindFirstChild("Animations")
    if v1 ~= nil and Animations ~= nil then
        local err, success
        for i, j in Animations:GetChildren() do
            if j:IsA("Animation") then
                success, err = pcall(v1.LoadAnimation, v1, j)
                if success and err then
                    err.Priority = Enum.AnimationPriority.Core
                    v2[j.Name] = err
                end
            end
        end
        return v2
    end
    return v2
end

local function step(a1, a2) -- Line: 89 -- types: a1: table, a2: number
    local v1, v2, v3, v4
    a1.Time = a1.Time + a2
    local v5 = nil
    local v6 = nil
    local v7 = a1
    for i, j in a1.Blend, v5, v6 do
        v1 = (if i ~= v7.Mood then 0 else 1) - j
        v2 = v8 * 6
        v4 = j + v1 * math.min(v2, 1)
        if not (v4 < 0.001) or v3 ~= 0 then
            v7.Blend[i] = v4
        else
            v7.Blend[i] = nil
        end
    end
    if v7.Blend[v7.Mood] == nil then
        v7.Blend[v7.Mood] = 0
    end
    local v9 = v7.Profile.Body(v7, v7.Time)
    v7.Primary.CFrame = v7.Root * CFrame.new(0, v7.Feet, 0) * v9
end

local function applyMood(a1) -- Line: 107 -- types: a1: table
    local Idle = a1.Profile.Clips[a1.Mood] or a1.Profile.Clips.Idle
    local v1 = Idle and a1.Tracks[Idle.Animation]
    if v1 == nil then
        return
    end
    local Speed = Idle.Speed
    local StrideStuds = a1.Profile.StrideStuds
    if StrideStuds and a1.Mood == "Run" then
        Speed = math.clamp(a1.Pace / StrideStuds, 0.6, 2.4)
    end
    if a1.Current == v1 then
        v1:AdjustSpeed(Speed)
        return
    end
    if a1.Current then
        a1.Current:Stop(0.3)
    end
    v1.Looped = Idle.Looped
    v1:Play(0.3, 1, Speed)
    a1.Current = v1
end

function v1.new(a1, a2) -- Line: 130
    -- upvalues: loadTracks (val), step (val), applyMood (val)
    local PrimaryPart = a1.PrimaryPart
    local Attribute = a1:GetAttribute("FeetOffset")
    local v1 = {Mood = "", Pace = 0, Model = a1}
    local CFrame_2 = PrimaryPart.CFrame
    local new = CFrame.new
    v1.Root = CFrame_2 * new(0, -(if typeof(Attribute) ~= "number" then 0 else Attribute), 0)
    v1.Time = math.random() * 10
    v1.Feet = if typeof(Attribute) ~= "number" then 0 else Attribute
    v1.Blend = {Idle = 1}
    v1.Profile = a2
    v1.Tracks = loadTracks(a1)
    v1.Primary = PrimaryPart
    v1.Step = step

    function v1.SetRoot(a1, a2) -- Line: 147 -- types: a1: table, a2: userdata
        a1.Root = a2
        a1.Primary.CFrame = a2 * CFrame.new(0, a1.Feet, 0)
    end

    function v1:SetMood(a2) -- Line: 151 -- upvalues: applyMood (upval) -- types: self: table, a2: string
        if self.Mood == a2 then
            return
        end
        self.Mood = a2
        if self.Blend[a2] == nil then
            self.Blend[a2] = 0
        end
        applyMood(self)
    end

    function v1.SetPace(a1, a2) -- Line: 161 -- upvalues: applyMood (upval) -- types: a1: table, a2: number
        a1.Pace = a2
        if a1.Mood == "Run" then
            applyMood(a1)
        end
    end

    function v1:Weight(a2) -- Line: 167 -- types: self: table, a2: string
        return self.Blend[a2] or 0
    end

    function v1:Play(a2, a3, a4) -- Line: 170 -- types: self: table, a2: string, a3: number?, a4: number?
        local v1 = self.Tracks[a2]
        if v1 == nil then
            return nil
        end
        v1.Priority = Enum.AnimationPriority.Action
        v1.Looped = false
        v1:Play(a3 or 0.2, 1, a4 or 1)
        return v1
    end

    function v1:Destroy() -- Line: 180 -- types: self: table
        for i, j in self.Tracks do
            j:Stop(0)
            j:Destroy()
        end
        table.clear(self.Tracks)
        self.Current = nil
    end

    v1:SetMood("Idle")
    return v1
end

local function weighted(a1, a2) -- Line: 192 -- types: a1: table, a2: table
    local v1
    local v2 = 0
    for i in a1.Blend do
        v2 = v2 + a1:Weight(i)
    end
    local identity = CFrame.identity
    if v2 <= 0 then
        return identity
    end
    for j, k in a2 do
        v1 = a1:Weight(j) / v2
        if v1 > 0 then
            identity = identity:Lerp(identity * k, v1)
        end
    end
    return identity
end

v1.Dog = table.freeze({
    StrideStuds = 9,
    Clips = {
        Idle = {Animation = "Idle", Speed = 1, Looped = true},
        Sad = {Animation = "Idle", Speed = 0.7, Looped = true},
        Happy = {Animation = "Idle", Speed = 1.3, Looped = true},
        Talk = {Animation = "Idle", Speed = 1.1, Looped = true},
        Run = {Animation = "Walk", Speed = 1, Looped = true},
        Spin = {Animation = "Idle", Speed = 1.5, Looped = true},
    },
    Body = function(a1, a2) -- Line: 220 -- upvalues: weighted (val) -- types: a1: table, a2: number
        return (weighted(a1, {
            Sad = (CFrame.new(0, -0.1, 0)) * CFrame.Angles(-0.05235987755982989, 0, 0),
            Happy = CFrame.new(0, math.abs((math.sin(a2 * 7))) * 0.5, 0),
            Spin = (CFrame.new(0, math.abs((math.sin(a2 * 9))) * 1.1, 0)) * CFrame.Angles(0, math.rad(a2 * 540 % 360), 0),
        }))
    end,
})
v1.Fisherman = table.freeze({
    Clips = {
        Idle = {Animation = "Idle", Speed = 1, Looped = true},
        Talk = {Animation = "Look", Speed = 1, Looped = true},
        Pet = {Animation = "Idle", Speed = 0.8, Looped = true},
        Reel = {Animation = "Hold", Speed = 1, Looped = true},
        Cheer = {Animation = "Cheer", Speed = 1, Looped = true},
        Give = {Animation = "Point", Speed = 1, Looped = false},
    },
    Body = function(a1, a2) -- Line: 238 -- upvalues: weighted (val) -- types: a1: table, a2: number
        return (weighted(a1, {
            Reel = CFrame.Angles(math.rad(math.sin(a2 * 10) * 3 + -6), 0, 0),
            Pet = (CFrame.new(0, -0.15, 0)) * CFrame.Angles(-0.13962634015954636, 0, 0),
        }))
    end,
})
return table.freeze(v1)