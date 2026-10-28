-- Script path: ReplicatedStorage.Client.SmartProximityPrompt.SurfaceTracker
-- Decompile time: 3.43 ms

local u0 = {}
u0.__index = u0
u0.__class = "SurfaceTracker"

local function clampToBox(a1, a2) -- Line: 19 -- types: a1: userdata, a2: vector
    local CFrame = a1.CFrame
    local v1 = a1.Size * 0.5
    return CFrame:PointToWorldSpace((((CFrame:PointToObjectSpace(a2)):Max(-v1)):Min(v1)))
end

function u0.new(a1, a2) -- Line: 25 -- upvalues: u0 (val) -- types: a1: userdata, a2: userdata?
    local u5 = setmetatable({}, u0)
    u5.model = a1
    u5.skip = a2
    u5.solids = {}
    u5.links = {}
    u5.disposed = false
    u5:Rescan()
    u5.links = {
        a1.DescendantAdded:Connect(function(a1) -- Line: 37 -- upvalues: u5 (val) -- types: a1: userdata
            if a1:IsA("BasePart") and a1 ~= u5.skip and table.find(u5.solids, a1) == nil then
                table.insert(u5.solids, a1)
            end
        end),
        (a1.DescendantRemoving:Connect(function(a1) -- Line: 42 -- upvalues: u5 (val) -- types: a1: userdata
            local v1 = table.find(u5.solids, a1)
            if v1 ~= nil then
                table.remove(u5.solids, v1)
            end
        end)),
    }
    return u5
end

function u0.Destroy(a1) -- Line: 53
    if not a1.disposed then
        a1.disposed = true
        for i, j in a1.links do
            j:Disconnect()
        end
        table.clear(a1.links)
        table.clear(a1.solids)
    end
end

function u0:Rescan() -- Line: 66
    local v1
    local solids = self.solids
    table.clear(solids)
    for i, j in self.model:GetDescendants() do
        v1 = j:IsA("BasePart")
        if v1 then
            v1 = false
            if j ~= self.skip then
                v1 = j.Parent ~= nil
            end
        end
        if v1 then
            solids[#solids + 1] = j
        end
    end
end

function u0.GetClosestSurfacePoint(a1, a2, a3, a4) -- Line: 78 -- types: a2: vector, a3: number?, a4: number?
    local CFrame, Magnitude, model, v1, v2, v3, v4, v5
    if a1.disposed then
        return nil, nil
    end
    if a4 ~= nil then
        local BoundingBox, BoundingBox_2 = a1.model:GetBoundingBox()
        v4 = ((BoundingBox:PointToObjectSpace(a2):Abs()) - BoundingBox_2 * 0.5):Max((Vector3.new(0, 0, 0)))
        v3 = math.max(a4, 0) + 0.01
        v5 = v4:Dot(v4)
        if v3 * v3 < v5 then
            return nil, nil
        end
    end
    local v6 = nil
    v3 = (1 / 0)
    local solids = a1.solids
    v5 = nil
    local v7 = nil
    local v8, v9 = a2, a1
    for i, j in solids, v5, v7 do
        model = v9.model
        if not j:IsDescendantOf(model) then
            v1 = nil
        else
            CFrame = j.CFrame
            v2 = j.Size * 0.5
            v1 = CFrame:PointToWorldSpace((((CFrame:PointToObjectSpace(v8)):Max(-v2)):Min(v2)))
        end
        Magnitude = if not v1 then (1 / 0) else (v8 - v1).Magnitude
        if Magnitude < v3 then
            v6 = v1
            v3 = Magnitude
        end
    end
    v4 = if not v6 then Vector3.new(0, 0, 0) else v8 - v6
    local Unit = if not (v4.Magnitude < 0.0001) then v4.Unit else Vector3.new(0, 1, 0)
    v4 = if not v6 then nil else v6 + Unit * (v10 or 0)
    return v4, v4 and v3
end

return u0