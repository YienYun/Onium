-- Script path: ReplicatedStorage.Shared.Modules.RiftZoneLadder
-- Decompile time: 3.80 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Areas = require(ReplicatedStorage.Data.Areas)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GuardEscapeRequirement = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardEscapeRequirement)
local Log = require(ReplicatedStorage.Packages.Log)
local RiftFlags = require(ReplicatedStorage.Shared.Flags.RiftFlags)
local t = require(ReplicatedStorage.Packages.t)
local u40 = Log.new()
local u41 = nil

local function resolveSpeed(a1, a2) -- Line: 28
    -- upvalues: GuardEscapeRequirement (val), u40 (val)
    local Guard = a1:FindFirstChild("Guard")
    local HumanoidRootPart = if Guard == nil then nil else Guard:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        local success, err = pcall(GuardEscapeRequirement.ResolveSpeedPower, a1, HumanoidRootPart.Position, a2)
        if success then
            return err
        end
        ;(u40:AtWarning()):Log((("Zone ladder could not resolve %*: %*"):format(a1.Name, err)))
        return nil
    end
    return nil
end

local function computeSpeeds() -- Line: 47
    -- upvalues: Workspace (val), Areas (val), Constants (val), u40 (val), resolveSpeed (val)
    local Areas_2, v1, v2
    local World = Workspace:WaitForChild("World", 30)
    assert((if World == nil then nil else World:WaitForChild("Areas", 30)) ~= nil, "Workspace.World.Areas is required for the zone ladder")
    local v3 = Areas_2:WaitForChild("GuardAreas", 30)
    local SeparationLine = Areas_2:WaitForChild("SeparationLine", 30)
    assert(v3 ~= nil, "Workspace.World.Areas.GuardAreas is required for the zone ladder")
    local v4 = false
    if SeparationLine ~= nil then
        v4 = SeparationLine:IsA("BasePart")
    end
    assert(v4, "Workspace.World.Areas.SeparationLine must be a BasePart")
    local v5 = {}
    v4 = nil
    local v6 = nil
    for i in Areas.Directory, v4, v6 do
        v1 = if not Constants.IS_CLIENT then v3:FindFirstChild(i) else v3:WaitForChild(i, 30)
        if v1 == nil then
            (u40:AtWarning()):Log((("Zone ladder skipped %*: no guard area model"):format(i)))
        elseif v1:IsA("Model") then
            v2 = resolveSpeed(v1, SeparationLine)
            if v2 ~= nil then
                v5[i] = v2
            end
        else
            (u40:AtWarning()):Log((("Zone ladder skipped %*: no guard area model"):format(i)))
        end
    end
    return v5
end

local function speeds() -- Line: 76 -- upvalues: u41 (ref), computeSpeeds (val)
    local v1 = u41
    if v1 == nil then
        computeSpeeds()
    end
    return v1
end

local u45 = {}

function u45.Get() -- Line: 87 -- upvalues: u41 (ref), computeSpeeds (val), RiftFlags (val), Areas (val)
    local v1 = u41
    if v1 == nil then
        computeSpeeds()
    end
    local v2 = {}
    local v3 = RiftFlags.ZoneLadderOverride:Get()
    if #v3 > 0 then
        for k, n in v3 do
            if Areas.Directory[n] ~= nil then
                table.insert(v2, {Id = n, SpeedPower = v1[n] or 0})
            end
        end
        return v2
    end
    for i, j in v1 do
        table.insert(v2, {Id = i, SpeedPower = j})
    end
    table.sort(v2, function(a1, a2) -- Line: 104 -- types: a1: table, a2: table
        if a1.SpeedPower == a2.SpeedPower then
            return a1.Id < a2.Id
        end
        return a1.SpeedPower < a2.SpeedPower
    end)
    return v2
end

function u45.IndexOf(a1) -- Line: 113 -- upvalues: t (val), u45 (val) -- types: a1: string
    t.strict(t.string)(a1)
    for i, j in u45.Get() do
        if j.Id == a1 then
            return i
        end
    end
    return nil
end

function u45.SpeedPowerFor(a1) -- Line: 123 -- upvalues: t (val), u41 (ref), computeSpeeds (val) -- types: a1: string
    t.strict(t.string)(a1)
    local v1 = u41
    if v1 == nil then
        computeSpeeds()
    end
    return v1[a1]
end

function u45.Invalidate() -- Line: 128 -- upvalues: u41 (ref)
    u41 = nil
end

return u45