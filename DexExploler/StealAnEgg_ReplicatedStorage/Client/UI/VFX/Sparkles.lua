-- Script path: ReplicatedStorage.Client.UI.VFX.Sparkles
-- Decompile time: 5.97 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local u18 = NumberRange.new(0.14, 0.21)
local u22 = NumberRange.new(0.55, 0.85)
local u26 = NumberRange.new(1.4, 2.1)
local u30 = NumberRange.new(0.8, 2)
local Back = Enum.EasingStyle.Back
local Cubic = Enum.EasingStyle.Cubic
local u36 = UDim2.fromScale(0, 0)
local u38 = Random.new()

local function glintTemplate() -- Line: 39 -- upvalues: Assets (val)
    return Assets.UI.Misc.Effects.Glint
end

local function draw(a1, a2) -- Line: 44 -- upvalues: u38 (val) -- types: a1: UDim2, a2: number
    return u38:NextNumber(a1.Min, a1.Max) * a2
end

local function layerAbove(a1) -- Line: 48 -- types: a1: userdata
    local ZIndex = a1.ZIndex
    for i, j in a1:GetChildren() do
        if j:IsA("GuiObject") then
            ZIndex = math.max(ZIndex, j.ZIndex)
        end
    end
    return ZIndex + 2
end

local function newLane(a1, a2) -- Line: 58 -- upvalues: Assets (val), u36 (val) -- types: a1: userdata, a2: number
    local v1 = Assets.UI.Misc.Effects.Glint:Clone()
    v1.Visible = false
    v1.Size = u36
    v1.ZIndex = a2
    v1.Parent = a1
    return {readyAt = 0, retired = false, glint = v1}
end

local function tweenSize(a1, a2, a3, a4, a5) -- Line: 67
    -- upvalues: TweenService (val)
    return TweenService:Create(a1, TweenInfo.new(a2, a3, a4), {Size = a5})
end

local function finish(a1) -- Line: 77 -- types: a1: table
    a1.inFlight = nil
    if a1.retired then
        a1.glint:Destroy()
        return
    end
    a1.glint.Visible = false
end

local function twinkle(a1, a2, a3) -- Line: 87
    -- upvalues: u18 (val), u38 (val), u22 (val), u26 (val), u36 (val), Back (val), TweenService (val), Cubic (val)
    local glint = a1.glint
    local v1 = u18
    local v2 = u38:NextNumber(v1.Min, v1.Max) * a2
    local v3 = u22
    v1 = u38:NextNumber(v3.Min, v3.Max) * 1 / a3
    local v4 = u26
    local u29 = u38:NextNumber(v4.Min, v4.Max) * 1 / a3
    glint.Position = UDim2.fromScale(u38:NextNumber(), u38:NextNumber())
    glint.Size = u36
    glint.Visible = true
    v4 = Back
    local Out = Enum.EasingDirection.Out
    local v5 = UDim2.fromScale(v2, v2)
    v3 = TweenService:Create(glint, TweenInfo.new(v1, v4, Out), {Size = v5})
    v3.Completed:Once(function(a1_2) -- Line: 98
        -- upvalues: a1 (val), glint (val), u29 (val), Cubic (upval), u36 (upval), TweenService (upval)
        local v1
        if a1_2 ~= Enum.PlaybackState.Completed then
            v1 = a1
            v1.inFlight = nil
            if v1.retired then
                v1.glint:Destroy()
                return
            end
            v1.glint.Visible = false
            return
        end
        local v2 = glint
        local v3 = u29
        local v4 = Cubic
        local InOut = Enum.EasingDirection.InOut
        local v5 = u36
        v1 = TweenService:Create(v2, TweenInfo.new(v3, v4, InOut), {Size = v5})
        v1.Completed:Once(function() -- Line: 104 -- upvalues: a1 (upval)
            local v1 = a1
            v1.inFlight = nil
            if v1.retired then
                v1.glint:Destroy()
                return
            end
            v1.glint.Visible = false
        end)
        a1.inFlight = v1
        v1:Play()
    end)
    a1.inFlight = v3
    v3:Play()
    return v1 + u29
end

return function(a1, a2) -- Line: 117
    -- upvalues: layerAbove (val), Assets (val), u36 (val), twinkle (val), u30 (val), u38 (val)
    local v1
    local u5 = a1:FindFirstAncestorWhichIsA("LayerCollector")
    if u5 == nil then
        return function() end
    end
    local v2 = a2 or {}
    local u11 = v2.Size or 1
    local u13 = v2.Pace or 1
    local v3 = v2.Lanes or 1
    local v4 = false
    if type(v3) == "number" then
        v4 = v3 >= 1
    end
    assert(v4, "a sparkle field needs at least one lane")
    v2 = layerAbove(a1)
    local u33 = {}
    for i = 1, v3 do
        v1 = Assets.UI.Misc.Effects.Glint:Clone()
        v1.Visible = false
        v1.Size = u36
        v1.ZIndex = v2
        v1.Parent = a1
        table.insert(u33, {readyAt = 0, retired = false, glint = v1})
    end
    local u62 = true

    local function retireLanes() -- Line: 138 -- upvalues: u33 (val)
        for i, j in u33 do
            j.retired = true
            if j.inFlight == nil then
                j.glint:Destroy()
            end
        end
    end

    task.spawn(function() -- Line: 149
        -- upvalues: u62 (ref), a1 (val), u33 (val), u5 (val), twinkle (upval), u11 (val), u13 (val), u30 (upval)
        -- upvalues: u38 (upval), retireLanes (val)
        local v1, v2, v3, v4, v5, v6
        while u62 do
            if a1.Parent == nil then
                break
            end
            v1 = os.clock()
            v2 = (1 / 0)
            v4 = nil
            v5 = nil
            for i, j in u33, v4, v5 do
                if not (v1 < j.readyAt) then
                    if not u5.Enabled then
                        j.readyAt = v1 + 0.4
                    else
                        v6 = v1 + twinkle(j, u11, u13)
                        v3 = u30
                        j.readyAt = v6 + u38:NextNumber(v3.Min, v3.Max) * 1
                    end
                end
                v2 = math.min(v2, j.readyAt)
            end
            task.wait((math.clamp(v2 - os.clock(), 0.05, 0.3)))
        end
        retireLanes()
    end)
    return function() -- Line: 170 -- upvalues: u62 (ref)
        u62 = false
    end
end