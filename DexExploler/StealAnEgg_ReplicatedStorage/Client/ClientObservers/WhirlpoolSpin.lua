-- Script path: ReplicatedStorage.Client.ClientObservers.WhirlpoolSpin
-- Decompile time: 3.03 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Observers = require(ReplicatedStorage.Packages.Observers)
local SewerCave = require(ReplicatedStorage.Shared.Util.SewerCave)
local u25 = table.freeze({["1"] = 90, ["2"] = 70, ["3"] = 55})

local function GetRings(a1, a2) -- Line: 30 -- upvalues: u25 (val) -- types: a1: userdata, a2: userdata
    local v1
    local v2 = {}
    local v3 = nil
    local v4 = nil
    local v5, v6 = a1, a2
    for i, j in u25, v3, v4 do
        v1 = v5:FindFirstChild(i)
        if v1 ~= nil then
            for k, n in v1:GetDescendants() do
                if n:IsA("BasePart") then
                    table.insert(v2, {
                        Part = n,
                        Offset = v6:ToObjectSpace(n.CFrame),
                        Speed = math.rad(j),
                    })
                end
            end
        else
            warn((("%* is missing ring folder %*"):format(v5:GetFullName(), i)))
        end
    end
    return v2
end

local function SpinWhirlpool(a1) -- Line: 52 -- upvalues: GetRings (val), RunService (val) -- types: a1: userdata
    local u6 = CFrame.new(a1:GetBoundingBox().Position)
    local Position = u6.Position
    local u11 = GetRings(a1, u6)
    if #u11 == 0 then
        return nil
    end
    local u16 = table.create(#u11)
    local u19 = table.create(#u11)
    for i, j in u11 do
        u16[i] = j.Part
        u19[i] = j.Part.CFrame
    end
    local u31 = os.clock()
    local u42 = RunService.PreRender:Connect(function() -- Line: 68 -- upvalues: Position (val), u31 (val), u11 (val), u19 (val), u6 (val), u16 (val)
        local v1, v2
        local CurrentCamera = workspace.CurrentCamera
        if CurrentCamera == nil or 1000 < (CurrentCamera.CFrame.Position - Position).Magnitude then
            return
        end
        local v3 = os.clock() - u31
        for i, j in u11 do
            v1 = u19
            v2 = u6 * CFrame.Angles(0, j.Speed * v3, 0)
            v1[i] = v2 * j.Offset
        end
        workspace:BulkMoveTo(u16, u19, Enum.BulkMoveMode.FireCFrameChanged)
    end)
    return function() -- Line: 83 -- upvalues: u42 (val)
        u42:Disconnect()
    end
end

local observeTag = Observers.observeTag
local WhirlpoolTag = SewerCave.WhirlpoolTag
local v1 = {workspace}
observeTag(WhirlpoolTag, function(a1) -- Line: 88 -- upvalues: SewerCave (val), SpinWhirlpool (val) -- types: a1: userdata
    if a1:IsA("Model") then
        return (SpinWhirlpool(a1))
    end
    warn((("%* tag on %* needs a Model"):format(SewerCave.WhirlpoolTag, (a1:GetFullName()))))
    return nil
end, v1)
return nil