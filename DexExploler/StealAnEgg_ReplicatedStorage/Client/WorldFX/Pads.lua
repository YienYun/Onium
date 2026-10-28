-- Script path: ReplicatedStorage.Client.WorldFX.Pads
-- Decompile time: 5.69 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local GameFlags = require(ReplicatedStorage.Shared.Flags.GameFlags)
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local PointInBox = require(ReplicatedStorage.Shared.Utils.PointInBox)
local Player = require(ReplicatedStorage.Shared.Player)
local Signal = require(ReplicatedStorage.Packages.Signal)
local u40 = TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local u41 = {}
u41.Changed = Signal.new()
local u44 = {}
local u45 = nil
local u46 = false

local function padBox(a1) -- Line: 47 -- upvalues: ModelBounds (val) -- types: a1: userdata
    if a1:IsA("BasePart") then
        return a1.CFrame, a1.Size
    end
    if a1:IsA("Model") then
        return ModelBounds(a1)
    end
    return (a1:GetPivot()), (Vector3.new(0, 0, 0))
end

local function topUnderFoot(a1, a2) -- Line: 59
    -- upvalues: ModelBounds (val), PointInBox (val)
    local CFrame_2, Size
    local Surface = a1.Surface
    if Surface:IsA("BasePart") then
        CFrame_2 = Surface.CFrame
        Size = Surface.Size
    elseif not Surface:IsA("Model") then
        CFrame_2 = Surface:GetPivot()
        Size = Vector3.new(0, 0, 0)
    else
        local v1, v2 = ModelBounds(Surface)
        CFrame_2 = v1
        Size = v2
    end
    if not PointInBox(CFrame_2 * CFrame.new((Vector3.new(0, 6, 0))), Size + Vector3.new(0, 12, 0), a2) then
        return nil
    end
    return (CFrame_2 * CFrame.new(0, Size.Y / 2, 0)).Position.Y
end

local function padBeneath(a1) -- Line: 69 -- upvalues: u44 (val), topUnderFoot (val) -- types: a1: vector
    local v1
    local v2 = nil
    local v3 = (-1 / 0)
    for i, j in u44 do
        v1 = topUnderFoot(j, a1)
        if v1 ~= nil and v3 < v1 then
            v2 = j
        end
    end
    return v2
end

local function transition(a1) -- Line: 81 -- upvalues: u45 (ref), u41 (val) -- types: a1: table?
    local v1 = u45
    if a1 == v1 then
        return
    end
    u45 = a1
    u41.Changed:Fire(a1, v1)
end

u41.Changed:Connect(function(a1, a2) -- Line: 92 -- types: a1: table?, a2: table?
    local Entered = if a1 == nil then nil else a1.Hooks.Entered
    if Entered ~= nil then
        task.spawn(Entered)
    end
    local Left = if a2 == nil then nil else a2.Hooks.Left
    if Left ~= nil then
        task.spawn(Left)
    end
end)

local function poll() -- Line: 103
    -- upvalues: u44 (val), Player (val), padBeneath (val), u45 (ref), u41 (val), u46 (ref)
    local v1, v2, v3
    while true do
        if not (#u44 > 0) then
            break
        end
        v1 = Player.FindRootPart()
        v2 = if v1 == nil then nil else padBeneath(v1.Position)
        v3 = u45
        if v2 ~= v3 then
            u45 = v2
            u41.Changed:Fire(v2, v3)
        end
        task.wait(0.15)
    end
    v1 = u45
    if v1 ~= nil then
        u45 = nil
        u41.Changed:Fire(nil, v1)
    end
    u46 = false
end

local function startBob(a1) -- Line: 113
    -- upvalues: TweenService (val), u40 (val), GameFlags (val)
    local Pivot = a1:GetPivot()
    local NumberValue = Instance.new("NumberValue")
    NumberValue.Name = "PadMarkerLift"
    NumberValue.Value = -0.4
    local v1 = NumberValue.Changed:Connect(function(a1_2) -- Line: 118 -- upvalues: a1 (val), Pivot (val) -- types: a1_2: number
        a1:PivotTo(Pivot + (Vector3.new(0, a1_2, 0)))
    end)
    NumberValue.Parent = a1
    local v2 = TweenService:Create(NumberValue, u40, {Value = 0.4})
    if not GameFlags.WorldOverlaysHidden:Get() then
        v2:Play()
    end
    return {Height = NumberValue, Motion = v2, Follow = v1}
end

local function stopBob(a1) -- Line: 130 -- types: a1: table
    a1.Motion:Cancel()
    a1.Follow:Disconnect()
    a1.Height:Destroy()
end

GameFlags.WorldOverlaysHidden.Changed:Connect(function(a1) -- Line: 136 -- upvalues: u44 (val) -- types: a1: boolean
    local Bob
    for i, j in u44 do
        Bob = j.Bob
        if Bob ~= nil then
            if not a1 then
                Bob.Motion:Play()
            else
                Bob.Motion:Pause()
            end
        end
    end
end)

function u41.Track(a1, a2) -- Line: 152
    -- upvalues: u44 (val), u45 (ref), startBob (val), u46 (ref), poll (val)
    local v1 = false
    if typeof(a1) == "Instance" then
        v1 = a1:IsA("PVInstance")
    end
    assert(v1, "Pads.Track needs a PVInstance surface")
    local u14 = nil

    local function untrack() -- Line: 156 -- upvalues: u44 (upval), u14 (ref), u45 (upval)
        local v1 = table.find(u44, u14)
        if v1 == nil then
            return
        end
        table.remove(u44, v1)
        u14.Gone:Disconnect()
        local Bob = u14.Bob
        if Bob ~= nil then
            Bob.Motion:Cancel()
            Bob.Follow:Disconnect()
            Bob.Height:Destroy()
        end
        if u45 == u14 then
            u45 = nil
        end
    end

    local Parent = a1.Parent
    local PadMarker = if Parent == nil then nil else Parent:FindFirstChild("PadMarker")
    local v2 = {Surface = a1}
    v2.Hooks = a2 or {}
    v2.Bob = if PadMarker == nil then nil else if not PadMarker:IsA("PVInstance") then nil else startBob(PadMarker)
    v2.Gone = a1.Destroying:Once(untrack)
    table.insert(u44, v2)
    if not u46 then
        u46 = true
        task.spawn(poll)
    end
    return untrack
end

return (table.freeze(u41))