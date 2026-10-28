-- Script path: ReplicatedStorage.Client.SpeedLines
-- Decompile time: 5.80 ms

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
require(ReplicatedStorage.Packages.Trove)
local u24 = {0.3333333333333333, 0.6666666666666666, 1}
local u32 = NumberRange.new(0.03, 0.05)
local u36 = NumberRange.new(0.4, 0.7)
local u38 = Random.new()
local u39 = {false, false, false, false}

local function quadrantPoint(a1, a2) -- Line: 40 -- upvalues: u38 (val) -- types: a1: userdata, a2: number
    local AbsoluteSize = a1.AbsoluteSize
    return Vector2.new(
        if a2 == 1 then u38:NextNumber(AbsoluteSize.X / 2, AbsoluteSize.X) else if a2 ~= 2 then u38:NextNumber(1, AbsoluteSize.X / 2) else u38:NextNumber(AbsoluteSize.X / 2, AbsoluteSize.X),
        if a2 == 1 then u38:NextNumber(1, AbsoluteSize.Y / 2) else if a2 ~= 4 then u38:NextNumber(AbsoluteSize.Y / 2, AbsoluteSize.Y) else u38:NextNumber(1, AbsoluteSize.Y / 2)
    )
end

local function nextQuadrant() -- Line: 47 -- upvalues: u38 (val), u39 (ref)
    local v1 = u38:NextInteger(1, 4)
    if not u39[v1] then
        u39[v1] = true
        return v1
    end
    if not u39[1] then
        u39[1] = true
        return 1
    end
    if not u39[2] then
        u39[2] = true
        return 2
    end
    if not u39[3] then
        u39[3] = true
        return 3
    end
    if not u39[4] then
        u39[4] = true
        return 4
    end
    u39 = {false, false, false, false}
    v1 = u38:NextInteger(1, 4)
    u39[v1] = true
    return v1
end

local function edgePosition(a1) -- Line: 66
    -- upvalues: quadrantPoint (val), nextQuadrant (val), u38 (val)
    local AbsoluteSize = a1.AbsoluteSize
    local v1 = (quadrantPoint(a1, (nextQuadrant()))) - Vector2.new(0.001, 0.001)
    local v2 = if u38:NextInteger(0, 1) ~= 0 then 1.07 else -0.07
    if u38:NextInteger(1, 2) == 1 then
        return UDim2.fromScale(v1.X / AbsoluteSize.X, v2)
    end
    return UDim2.fromScale(v2, v1.Y / AbsoluteSize.Y)
end

local function rotationToward(a1) -- Line: 77 -- types: a1: Vector2
    local v1 = a1.X.Scale - 0.5
    local v2 = 0.5 - a1.Y.Scale
    local v3 = math.sqrt(v1 * v1 + v2 * v2)
    local v4 = if not (0.5 < a1.X.Scale) then if not (a1.X.Scale < 0.5) then if not (a1.X.Scale < 0.5) then 2 else if not (0.5 < a1.Y.Scale) then 2 else 3 else if not (a1.Y.Scale < 0.5) then if not (a1.X.Scale < 0.5) then 2 else if not (0.5 < a1.Y.Scale) then 2 else 3 else 4 else if not (a1.Y.Scale < 0.5) then if not (a1.X.Scale < 0.5) then if not (a1.X.Scale < 0.5) then 2 else if not (0.5 < a1.Y.Scale) then 2 else 3 else if not (a1.Y.Scale < 0.5) then if not (a1.X.Scale < 0.5) then 2 else if not (0.5 < a1.Y.Scale) then 2 else 3 else 4 else 1
    local v5 = if v4 == 1 then v1 else if v4 ~= 3 then v2 else v1
    if v4 ~= 1 and v4 ~= 4 then
        return (math.deg(-(math.asin(v5 / v3)))) + (v4 - 1) * 90
    end
    return (math.deg((math.asin(v5 / v3)))) + (v4 - 1) * 90
end

local function spawnLine(a1, a2, a3, a4, a5) -- Line: 92
    -- upvalues: u38 (val), u32 (val), u36 (val), TweenService (val)
    local u7 = a2:Clone()
    u7.Name = "Line"
    u7.Visible = true
    u7.Position = a3
    u7.Rotation = a4
    u7.ImageTransparency = 1
    u7.Size = UDim2.fromScale(u38:NextNumber(u32.Min, u32.Max), u38:NextNumber(u36.Min, u36.Max))
    u7.Parent = a1
    TweenService:Create(u7, TweenInfo.new(0.4), {ImageTransparency = 1 - a5}):Play()
    task.delay(0.2, function() -- Line: 102 -- upvalues: TweenService (upval), u7 (val)
        local v1 = TweenService:Create(u7, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {ImageTransparency = 1})
        v1:Play()
        v1.Completed:Wait()
        u7:Destroy()
    end)
end

return {
    Run = function(a1, a2, a3) -- Line: 115
        -- upvalues: GuiService (val), RunService (val), edgePosition (val), rotationToward (val), spawnLine (val)
        -- upvalues: u24 (val)
        local Template = a2:FindFirstChild("Template")
        local v1 = false
        if Template ~= nil then
            v1 = Template:IsA("ImageLabel")
        end
        assert(v1, (("%* needs an ImageLabel named Template"):format((a2:GetFullName()))))
        local v2 = a2:FindFirstAncestorOfClass("ScreenGui")
        local v3 = ("%* is not in a ScreenGui"):format((a2:GetFullName()))
        assert(v2 ~= nil, v3)
        if not v2.IgnoreGuiInset then
            local function coverInset() -- Line: 122 -- upvalues: GuiService (upval), a2 (val)
                local GuiInset, GuiInset_2 = GuiService:GetGuiInset()
                a2.Position = UDim2.fromOffset(-GuiInset.X, -GuiInset.Y)
                a2.Size = UDim2.new(1, GuiInset.X + GuiInset_2.X, 1, GuiInset.Y + GuiInset_2.Y)
            end

            coverInset()
            a1:Connect(GuiService:GetPropertyChangedSignal("TopbarInset"), coverInset)
        end
        a1:Connect(RunService.Heartbeat, function() -- Line: 130
            -- upvalues: a3 (val), edgePosition (upval), a2 (val), rotationToward (upval), spawnLine (upval)
            -- upvalues: Template (val), u24 (upval)
            local v1 = math.clamp(a3(), 0, 1)
            if v1 <= 0.13333333333333333 then
                return
            end
            local v2 = edgePosition(a2)
            local v3 = rotationToward(v2)
            spawnLine(a2, Template, v2, v3, v1)
            for i, j in u24 do
                if j <= v1 then
                    spawnLine(a2, Template, v2, v3, v1)
                end
            end
        end)
        a1:Add(function() -- Line: 144 -- upvalues: a2 (val)
            for i, j in a2:GetChildren() do
                if j.Name == "Line" then
                    j:Destroy()
                end
            end
        end)
    end,
}