-- Script path: ReplicatedStorage.Client.UI.VFX.ParticleStage
-- Decompile time: 5.47 ms

local Workspace = game:GetService("Workspace")
local u5 = {
    Anchored = true,
    CanCollide = false,
    CanQuery = false,
    CanTouch = false,
    CastShadow = false,
    Name = "ParticleStage",
    Transparency = 1,
}
local u6 = {}
u6.__index = u6

local function sortedKeys(a1) -- Line: 32 -- types: a1: table
    local v1 = {}
    for i in a1 do
        table.insert(v1, i)
    end
    table.sort(v1)
    return v1
end

local function write(a1, a2) -- Line: 41 -- types: a1: userdata, a2: table
    local v1 = {}
    for i in a2 do
        table.insert(v1, i)
    end
    table.sort(v1)
    for j, k in v1 do
        a1[k] = a2[k]
    end
end

function u6.Emitter(a1, a2) -- Line: 48 -- types: a1: table, a2: table?
    local ParticleEmitter = Instance.new("ParticleEmitter")
    local v1 = {}
    for i in a1 do
        table.insert(v1, i)
    end
    table.sort(v1)
    for j, k in v1 do
        ParticleEmitter[k] = a1[k]
    end
    if a2 ~= nil then
        v1 = {}
        for n in a2 do
            table.insert(v1, n)
        end
        table.sort(v1)
        for m, i5 in v1 do
            ParticleEmitter[i5] = a2[i5]
        end
    end
    return ParticleEmitter
end

function u6.Scale(a1, a2) -- Line: 57 -- upvalues: u6 (val) -- types: a1: userdata, a2: number
    local v1 = {
        Acceleration = a1.Acceleration * a2,
        Size = u6.ScaleSequence(a1.Size, a2),
        Speed = NumberRange.new(a1.Speed.Min * a2, a1.Speed.Max * a2),
        ZOffset = a1.ZOffset * a2,
    }
    local v2 = {}
    for i in v1 do
        table.insert(v2, i)
    end
    table.sort(v2)
    for j, k in v2 do
        a1[k] = v1[k]
    end
end

function u6.ScaleSequence(a1, a2) -- Line: 66 -- types: a1: userdata, a2: number
    local Time, new, v1
    local v2 = table.create(#a1.Keypoints)
    for i, j in a1.Keypoints do
        new = NumberSequenceKeypoint.new
        Time = j.Time
        v1 = j.Value * a2
        v2[i] = (new(Time, v1, j.Envelope * a2))
    end
    return NumberSequence.new(v2)
end

function u6.QualityBudget() -- Line: 74
    local Value = UserSettings().GameSettings.SavedQualityLevel.Value
    if Value <= 0 then
        return 1
    end
    return (Value / 10) ^ 1.25
end

function u6.SetEnabled(a1, a2) -- Line: 82 -- types: a1: table, a2: boolean
    for i, j in a1 do
        j.Enabled = a2
    end
end

function u6.new(a1, a2) -- Line: 88 -- upvalues: u6 (val), u5 (val) -- types: a1: number, a2: number
    local v1 = setmetatable({}, u6)
    v1.depth = a1
    v1.thickness = a2
    v1.watchers = {}
    local Part = Instance.new("Part")
    local v2 = u5
    local v3 = {}
    for i in v2 do
        table.insert(v3, i)
    end
    table.sort(v3)
    for j, k in v3 do
        Part[k] = v2[k]
    end
    v1.Part = Part
    v1:Follow()
    return v1
end

function u6:Fit() -- Line: 100 -- upvalues: Workspace (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return
    end
    local CFrame = CurrentCamera.CFrame
    local LookVector = CFrame.LookVector
    local u8 = self.depth + self.thickness * 0.5
    local ViewportSize = CurrentCamera.ViewportSize

    local function onFarPlane(a1, a2) -- Line: 110
        -- upvalues: CurrentCamera (val), CFrame (val), u8 (val), LookVector (val)
        local Direction = CurrentCamera:ViewportPointToRay(a1, a2).Direction
        return CFrame.Position + Direction * (u8 / Direction:Dot(LookVector))
    end

    local Direction = CurrentCamera:ViewportPointToRay(0, 0).Direction
    local v1 = CFrame.Position + Direction * (u8 / Direction:Dot(LookVector))
    local Direction_2 = CurrentCamera:ViewportPointToRay(ViewportSize.X, ViewportSize.Y).Direction
    local v2 = CFrame.Position + Direction_2 * (u8 / Direction_2:Dot(LookVector))
    local v3 = v2 - v1
    local v4 = (v1 + v2) * 0.5 - LookVector * (self.thickness * 0.5)
    self.Part.Size = Vector3.new(math.abs((v3:Dot(CFrame.RightVector))), math.abs((v3:Dot(CFrame.UpVector))), self.thickness)
    self.Part.CFrame = CFrame.Rotation + v4
end

function u6:Follow() -- Line: 124 -- upvalues: Workspace (val)
    for i, j in self.watchers do
        j:Disconnect()
    end
    table.clear(self.watchers)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera == nil then
        return
    end
    self:Fit()
    self.Part.Parent = CurrentCamera

    local function refit() -- Line: 135 -- upvalues: self (val)
        self:Fit()
    end

    table.insert(self.watchers, ((CurrentCamera:GetPropertyChangedSignal("CFrame")):Connect(refit)))
    table.insert(self.watchers, ((CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(refit)))
    table.insert(self.watchers, ((CurrentCamera:GetPropertyChangedSignal("FieldOfView")):Connect(refit)))
    table.insert(self.watchers, ((Workspace:GetPropertyChangedSignal("CurrentCamera")):Once(function() -- Line: 141 -- upvalues: self (val)
        self:Follow()
    end)))
end

function u6.Adopt(a1, a2) -- Line: 146 -- types: a2: userdata
    a2.Parent = a1.Part
end

function u6.Dispose(a1) -- Line: 150
    for i, j in a1.watchers do
        j:Disconnect()
    end
    table.clear(a1.watchers)
    a1.Part:Destroy()
end

return table.freeze(u6)