-- Script path: ReplicatedStorage.Shared.Util.ScrambleTradeInEligibility
-- Decompile time: 2.51 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local GuardEscapeRequirement = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardEscapeRequirement)
local ScrambleTradeInFlags = require(ReplicatedStorage.Shared.Flags.ScrambleTradeInFlags)
local u25 = {}
u25.Changed = require(ReplicatedStorage.Packages.Signal).new()

local function cosmicArea() -- Line: 10 -- upvalues: Workspace (val)
    local World = Workspace:FindFirstChild("World")
    local Areas = World and World:FindFirstChild("Areas")
    local v1 = Areas and Areas:FindFirstChild("GuardAreas")
    local Cosmic = v1 and v1:FindFirstChild("Cosmic")
    if Cosmic and Cosmic:IsA("Model") then
        return Cosmic
    end
    return nil
end

function u25.RequiredSpeedPower() -- Line: 18
    -- upvalues: cosmicArea (val), GuardEscapeRequirement (val), ScrambleTradeInFlags (val)
    local v1 = cosmicArea()
    local Attribute = v1 and v1:GetAttribute(GuardEscapeRequirement.SIGN_SPEEDS_ATTRIBUTE)
    if typeof(Attribute) == "Vector2"
        and not (Attribute.X <= 0)
        and not ((1 / 0) <= Attribute.X)
        and Attribute.X == Attribute.X then
        return (math.max(Attribute.X, (ScrambleTradeInFlags.SpeedPowerRequirement:Get())))
    end
    return nil
end

function u25.IsEligible(a1) -- Line: 27 -- upvalues: u25 (val) -- types: a1: number
    local v1 = u25.RequiredSpeedPower()
    local v2 = false
    if v1 ~= nil then
        v2 = v1 <= a1
    end
    return v2
end

task.spawn(function() -- Line: 32 -- upvalues: Workspace (val), cosmicArea (val), GuardEscapeRequirement (val), u25 (val)
    local GuardAreas = ((Workspace:WaitForChild("World")):WaitForChild("Areas")):WaitForChild("GuardAreas")
    local u13 = nil
    local u14 = nil

    local function bind() -- Line: 36
        -- upvalues: cosmicArea (upval), u13 (ref), u14 (ref), GuardEscapeRequirement (upval), u25 (upval)
        local v1 = cosmicArea()
        if v1 == u13 then
            return
        end
        if u14 then
            u14:Disconnect()
            u14 = nil
        end
        u13 = v1
        if v1 then
            (v1:GetAttributeChangedSignal(GuardEscapeRequirement.SIGN_SPEEDS_ATTRIBUTE)):Connect(function() -- Line: 47 -- upvalues: u25 (upval)
                u25.Changed:Fire()
            end)
        end
        u25.Changed:Fire()
    end

    GuardAreas.ChildAdded:Connect(function(a1) -- Line: 53 -- upvalues: bind (val)
        if a1.Name == "Cosmic" then
            bind()
        end
    end)
    GuardAreas.ChildRemoved:Connect(function(a1) -- Line: 58 -- upvalues: bind (val)
        if a1.Name == "Cosmic" then
            bind()
        end
    end)
    bind()
end)
return table.freeze(u25)