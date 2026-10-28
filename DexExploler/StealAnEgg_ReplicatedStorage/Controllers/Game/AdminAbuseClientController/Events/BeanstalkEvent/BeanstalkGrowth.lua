-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.BeanstalkGrowth
-- Decompile time: 10.09 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local BeanstalkEvent = require(ReplicatedStorage.Data.BeanstalkEvent)
require(ReplicatedStorage.Packages.Trove)
local Stage = BeanstalkEvent.Stage
local BeanstalkTileableSegment = ReplicatedStorage.Assets.BeanstalkEventAssets.BeanstalkTileableSegment
local PrimaryPart = BeanstalkTileableSegment.PrimaryPart
local Attribute = BeanstalkTileableSegment:GetAttribute("TileHeight")
assert(typeof(Attribute) == "number", "BeanstalkTileableSegment needs a numeric TileHeight attribute")
local u50 = Color3.fromRGB(150, 115, 60)
local u51 = nil
local u52 = nil
local u53 = {}
local u54 = {}
local u55 = 0
local identity = CFrame.identity
local u57 = 0
local u58 = Vector3.new(0, 0, 0)
local identity_2 = CFrame.identity
local u60 = 1
local u61 = 1
local u62 = 0

local function map() -- Line: 54 -- upvalues: u51 (ref)
    local v1 = u51
    assert(v1 ~= nil, "BeanstalkGrowth.Start has not run")
    return v1
end

local function floorTop(a1) -- Line: 60 -- types: a1: userdata
    return a1.Position.Y + a1.Size.Y * 0.5
end

local function tileBottom(a1) -- Line: 64 -- upvalues: u55 (ref), Attribute (val) -- types: a1: number
    return u55 - 10 + (a1 - 1) * Attribute
end

local function topY() -- Line: 68 -- upvalues: u53 (val), u55 (ref), Attribute (val), PrimaryPart (val)
    if #u53 == 0 then
        return u55
    end
    local v1 = #u53
    return u55 - 10 + (v1 - 1) * Attribute + PrimaryPart.Size.Y
end

local function restingPivot(a1) -- Line: 75
    -- upvalues: identity (ref), u55 (ref), Attribute (val), u57 (ref)
    return identity + Vector3.new(0, u55 - 10 + (a1 - 1) * Attribute - u57, 0)
end

local function addTile() -- Line: 79
    -- upvalues: u52 (ref), BeanstalkTileableSegment (val), u53 (val), identity (ref), u55 (ref), Attribute (val)
    -- upvalues: u57 (ref), u54 (val)
    local v1 = u52
    assert(v1 ~= nil, "BeanstalkGrowth.Start has not run")
    local v2 = BeanstalkTileableSegment:Clone()
    local v3 = #u53 + 1
    v2:PivotTo(identity + (Vector3.new(0, u55 - 10 + (v3 - 1) * Attribute - u57, 0)))
    for i, j in v2:GetDescendants() do
        if j:IsA("BasePart") then
            u54[j] = j.Color
        end
    end
    v2.Parent = v1
    table.insert(u53, v2)
    return v2
end

local function poseBase(a1) -- Line: 94
    -- upvalues: u51 (ref), u60 (ref), identity_2 (ref), u61 (ref)
    local v1 = u51
    assert(v1 ~= nil, "BeanstalkGrowth.Start has not run")
    local Beanstalk = v1.Beanstalk
    Beanstalk:ScaleTo(u60 * (a1 * 0.5 + 0.5))
    Beanstalk:PivotTo(identity_2 * (CFrame.Angles(0, (1 - a1) * 6.283185307179586, 0)))
    u61 = a1
end

local v1 = {
    Start = function(a1, a2) -- Line: 105
        -- upvalues: u51 (ref), u55 (ref), identity_2 (ref), u60 (ref), u61 (ref), BeanstalkEvent (val)
        -- upvalues: PrimaryPart (val), identity (ref), BeanstalkTileableSegment (val), u57 (ref), u58 (ref)
        -- upvalues: Workspace (val), u52 (ref), u62 (ref), u53 (val), u54 (val)
        u51 = a2
        local BoundingBox, BoundingBox_2 = a2:WaitForChild("Beanstalk"):GetBoundingBox()
        u55 = BoundingBox.Position.Y + BoundingBox_2.Y * 0.5
        identity_2 = a2.Beanstalk:GetPivot()
        u60 = a2.Beanstalk:GetScale()
        u61 = 1
        local v1 = BeanstalkEvent.MapShift(a2.Beanstalk)
        local v2 = v1 * PrimaryPart.CFrame
        identity = v1 * BeanstalkTileableSegment:GetPivot()
        u57 = v2.Position.Y - PrimaryPart.Size.Y * 0.5
        u58 = v2.Position
        local Folder = Instance.new("Folder")
        Folder.Name = "BeanstalkGrowth"
        Folder.Parent = Workspace
        u52 = Folder
        a1:Add(function() -- Line: 123
            -- upvalues: u62 (upval), a2 (val), u51 (upval), u60 (upval), identity_2 (upval), u61 (upval), Folder (val)
            -- upvalues: u52 (upval), u53 (upval), u54 (upval)
            u62 = u62 + 1
            if a2.Beanstalk.Parent ~= nil then
                local v1 = u51
                assert(v1 ~= nil, "BeanstalkGrowth.Start has not run")
                local Beanstalk = v1.Beanstalk
                Beanstalk:ScaleTo(u60 * 1)
                Beanstalk:PivotTo(identity_2 * (CFrame.Angles(0, 0, 0)))
                u61 = 1
            end
            Folder:Destroy()
            u52 = nil
            u51 = nil
            table.clear(u53)
            table.clear(u54)
        end)
    end,
    Axis = function(a1) -- Line: 137 -- upvalues: u58 (ref) -- types: a1: number
        return (Vector3.new(u58.X, a1, u58.Z))
    end,
    HeightFor = function(a1) -- Line: 142 -- upvalues: u51 (ref), Stage (val), u55 (ref) -- types: a1: number
        local v1 = u51
        assert(v1 ~= nil, "BeanstalkGrowth.Start has not run")
        local Sections = v1.Sections
        if a1 <= Stage.Fireflies then
            return u55
        end
        if a1 == Stage.Watering then
            local Floor = Sections.Stage2.Floor
            return Floor.Position.Y + Floor.Size.Y * 0.5 + 60
        end
        local Floor_2 = Sections.Stage4.Floor
        return Floor_2.Position.Y + Floor_2.Size.Y * 0.5
    end,
}

local function riseInto(a1, a2, a3) -- Line: 153
    -- upvalues: Attribute (val), TweenService (val)
    local CFrameValue = Instance.new("CFrameValue")
    CFrameValue.Value = a2 - Vector3.new(0, Attribute, 0)
    a1:PivotTo(CFrameValue.Value)
    local v1 = CFrameValue.Changed:Connect(function(a1_2) -- Line: 157 -- upvalues: a1 (val) -- types: a1_2: userdata
        a1:PivotTo(a1_2)
    end)
    local v2 = TweenService:Create(CFrameValue, TweenInfo.new(a3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Value = a2})
    v2:Play()
    v2.Completed:Wait()
    v1:Disconnect()
    CFrameValue:Destroy()
    a1:PivotTo(a2)
end

function v1.GrowTo(a1, a2) -- Line: 171
    -- upvalues: u53 (val), u55 (ref), Attribute (val), PrimaryPart (val), addTile (val), riseInto (val), identity (ref)
    -- upvalues: u57 (ref)
    local v1, v2
    local u2 = {}
    while true do
        if #u53 ~= 0 then
            v2 = #u53
            v1 = u55 - 10 + (v2 - 1) * Attribute + PrimaryPart.Size.Y
        else
            v1 = u55
        end
        if not (v1 < v3) then
            break
        end
        table.insert(u2, (addTile()))
    end
    if v4 ~= nil and #u2 ~= 0 then
        local v5
        local u32 = v4 / #u2
        for i, j in u2 do
            v5 = (j:GetPivot()) - (Vector3.new(0, Attribute, 0))
            j:PivotTo(v5)
        end
        task.spawn(function() -- Line: 183
            -- upvalues: u2 (val), riseInto (upval), u53 (upval), identity (upval), u55 (upval), Attribute (upval)
            -- upvalues: u57 (upval), u32 (val)
            local v1, v2, v3, v4
            for i, j in u2 do
                v2 = riseInto
                v3 = table.find(u53, j) or i
                v4 = identity
                v1 = u55 - 10 + (v3 - 1) * Attribute - u57
                v2(j, v4 + Vector3.new(0, v1, 0), u32)
            end
        end)
        return
    end
end

function v1.SetBaseGrowth(a1, a2) -- Line: 193
    -- upvalues: u62 (ref), u51 (ref), u60 (ref), identity_2 (ref), u61 (ref), RunService (val)
    u62 = u62 + 1
    local u4 = u62
    local u9 = math.clamp(a1, 0, 1)
    if a2 ~= nil then
        local u38 = u61
        task.spawn(function() -- Line: 202
            -- upvalues: u4 (val), u62 (upval), u51 (upval), a2 (val), u38 (val), u9 (val), u60 (upval)
            -- upvalues: identity_2 (upval), u61 (upval), RunService (upval)
            local Beanstalk, v1, v2, v3
            local v4 = os.clock()
            while u4 == u62 do
                if u51 == nil then
                    break
                end
                v1 = math.min((os.clock() - v4) / a2, 1)
                v2 = u38 + (u9 - u38) * (1 - (1 - v1) ^ 3)
                v3 = u51
                assert(v3 ~= nil, "BeanstalkGrowth.Start has not run")
                Beanstalk = v3.Beanstalk
                Beanstalk:ScaleTo(u60 * (v2 * 0.5 + 0.5))
                Beanstalk:PivotTo(identity_2 * (CFrame.Angles(0, (1 - v2) * 6.283185307179586, 0)))
                u61 = v2
                if v1 >= 1 then
                    return
                end
                RunService.Heartbeat:Wait()
            end
        end)
        return
    end
    local v1 = u51
    assert(v1 ~= nil, "BeanstalkGrowth.Start has not run")
    local Beanstalk = v1.Beanstalk
    Beanstalk:ScaleTo(u60 * (u9 * 0.5 + 0.5))
    Beanstalk:PivotTo(identity_2 * (CFrame.Angles(0, (1 - u9) * 6.283185307179586, 0)))
    u61 = u9
end

function v1.SetWilted(a1) -- Line: 216 -- upvalues: u54 (val), TweenService (val), u50 (val) -- types: a1: number
    local v1, v2, v3, v4, v5
    for i, j in u54 do
        v4 = TweenService
        v5 = TweenInfo.new(0.25)
        v1 = {}
        v2 = u50
        v3 = math.clamp(a1, 0, 1)
        v1.Color = j:Lerp(v2, v3)
        v4:Create(i, v5, v1):Play()
    end
end

return v1