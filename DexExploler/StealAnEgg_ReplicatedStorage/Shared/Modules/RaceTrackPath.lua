-- Script path: ReplicatedStorage.Shared.Modules.RaceTrackPath
-- Decompile time: 4.63 ms

local u0 = {}
u0.__index = u0

function u0.new(a1) -- Line: 28 -- upvalues: u0 (val) -- types: a1: userdata
    local Magnitude, v1, v2, v3, v4
    local v5 = #a1:GetChildren()
    local v6 = ("%* needs at least 3 attachments"):format((a1:GetFullName()))
    assert(v5 >= 3, v6)
    local v7 = table.create(v5)
    local v8 = table.create(v5)
    v6 = table.create(v5)
    local v9 = a1
    for i = 1, v5 do
        v3 = v9:FindFirstChild((tostring(i)))
        v1 = false
        if v3 ~= nil then
            v1 = v3:IsA("Attachment")
        end
        assert(v1, (("%* needs Attachments named 1..%*; %* is missing"):format(v9:GetFullName(), v5, i)))
        v7[i] = v3.WorldPosition
        v8[i] = v3.WorldCFrame.UpVector
        v4 = v3:GetAttribute("NoRespawn") ~= true
        v6[i] = v4
    end
    local v10 = ("%* has no respawnable attachment"):format((v9:GetFullName()))
    assert(table.find(v6, true) ~= nil, v10)
    local v11 = table.create(v5)
    local v12 = table.create(v5)
    v10 = 0
    for j = 1, v5 do
        Magnitude = (v7[j % v5 + 1] - v7[j]).Magnitude
        v2 = ("%* segment %* is shorter than a stud"):format(v9:GetFullName(), j)
        assert(Magnitude >= 1, v2)
        v11[j] = v10
        v12[j] = Magnitude
        v10 = v10 + Magnitude
    end
    return (setmetatable({
        Count = v5,
        Length = v10,
        Points = v7,
        Ups = v8,
        Starts = v11,
        Lengths = v12,
        Respawnable = v6,
    }, u0))
end

function u0:Locate(a2) -- Line: 70 -- types: a2: number
    local v1
    local v2 = (math.floor(a2 / self.Length)) * self.Length
    local v3 = a2 - v2
    local v4 = 1
    local Count = self.Count
    while v4 < Count do
        v1 = (v4 + Count + 1) // 2
        if not (self.Starts[v1] <= v3) then
            Count = v1 - 1
        else
            v4 = v1
        end
    end
    return v4, v2
end

function u0:FrameAt(a2) -- Line: 86 -- types: a2: number
    local v1, v2 = self:Locate(a2)
    local v3 = v1 % self.Count + 1
    local v4 = math.clamp((a2 - v2 - self.Starts[v1]) / self.Lengths[v1], 0, 1)
    local v5 = self.Points[v1]
    local v6 = self.Points[v3]
    v2 = v5:Lerp(v6, v4)
    return CFrame.lookAt(v2, v2 + (v6 - v5), self.Ups[v1]:Lerp(self.Ups[v3], v4))
end

function u0.Project(a1, a2, a3, a4, a5) -- Line: 96 -- types: a2: vector, a3: number, a4: number, a5: number
    local Magnitude, v1, v2, v3, v4
    local v5 = a3 - a4
    local v6 = a3 + a5
    local v7, v8 = a1:Locate(v5)
    local v9 = v5
    local v10 = (1 / 0)
    local v11, v12 = a1, a2
    while v8 + v11.Starts[v7] <= v6 do
        v1 = v11.Points[v7]
        v2 = v11.Points[v7 % v11.Count + 1] - v1
        v3 = v11.Lengths[v7]
        v4 = math.clamp(((v12 - v1):Dot(v2)) / (v3 * v3), 0, 1)
        Magnitude = (v1 + v2 * v4 - v12).Magnitude
        if Magnitude < v10 then
            v10 = Magnitude
            v9 = v8 + v11.Starts[v7] + v4 * v3
        end
        v7 = v7 + 1
        if v11.Count < v7 then
            v7 = 1
            v8 = v8 + v11.Length
        end
    end
    return (math.clamp(v9, v5, v6)), v10
end

function u0.RespawnAt(a1, a2) -- Line: 126 -- types: a2: number
    local v1
    local Count_2, v2 = a1:Locate(a2)
    local v3 = a1
    for i = 1, a1.Count do
        if v3.Respawnable[Count_2] then
            v1 = v2 + v3.Starts[Count_2]
            return (v3:FrameAt(v1)), v1
        end
        Count_2 = Count_2 - 1
        if Count_2 < 1 then
            Count_2 = v3.Count
            v2 = v2 - v3.Length
        end
    end
    error("unreachable: RaceTrackPath.new asserts a respawnable point")
end

return table.freeze(u0)