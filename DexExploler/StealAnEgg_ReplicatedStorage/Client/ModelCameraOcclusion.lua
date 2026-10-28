-- Script path: ReplicatedStorage.Client.ModelCameraOcclusion
-- Decompile time: 12.91 ms

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ModelBounds = require(ReplicatedStorage.Shared.Utils.ModelBounds)
local Log = require(ReplicatedStorage.Packages.Log)
local Player = require(ReplicatedStorage.Shared.Player)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local u48 = Enum.RenderPriority.Camera.Value + 3
local u49 = {
    sweeping = false,
    blocked = {},
    faceOwner = {},
    probeFrom = {},
    probeSkip = {},
    roster = {},
    shelved = {},
}
local u58 = Log.new()
local LocalPlayer = Players.LocalPlayer
local u65 = t.strict(t.instanceIsA("Model"))
local u69 = t.strict(t.number)
local u72 = t.strict(t.boolean)
local v1 = {}

local function repaint(a1, a2) -- Line: 58 -- upvalues: u49 (val) -- types: a1: userdata, a2: number?
    local shelved = u49.shelved
    if a2 == nil then
        local v1 = shelved[a1]
        if v1 ~= nil then
            shelved[a1] = nil
            if a1.Parent then
                a1.Transparency = v1
                return
            end
        end
        return
    end
    if a1.Transparency < 1 then
        local Transparency = a1.Transparency
        local v2 = shelved[a1]
        if v2 == nil and Transparency < a2 then
            v2 = Transparency
            shelved[a1] = Transparency
        end
        if v2 ~= nil then
            a1.Transparency = math.max(v2, a2)
        end
    end
end

local function repaintEntry(a1, a2) -- Line: 83 -- upvalues: u49 (val) -- types: a1: table, a2: boolean
    local Transparency, shelved, v1, v2
    a1.Faded = a2
    local Target = if not a2 then nil else a1.Target
    local v3 = nil
    local v4 = nil
    for i in a1.Faces, v3, v4 do
        shelved = u49.shelved
        if Target == nil then
            v2 = shelved[i]
            if v2 ~= nil then
                shelved[i] = nil
                if i.Parent then
                    i.Transparency = v2
                end
            end
        elseif i.Transparency < 1 then
            Transparency = i.Transparency
            v1 = shelved[i]
            if v1 == nil and Transparency < Target then
                v1 = Transparency
                shelved[i] = Transparency
            end
            if v1 ~= nil then
                i.Transparency = math.max(v1, Target)
            end
        end
    end
end

local function releaseEverything() -- Line: 92 -- upvalues: u49 (val)
    local shelved, v1
    local v2 = nil
    local v3 = nil
    for i, j in u49.roster, v2, v3 do
        j.UnfadeAt = 0
        j.Faded = false
        for k in j.Faces do
            shelved = u49.shelved
            v1 = shelved[k]
            if v1 ~= nil then
                shelved[k] = nil
                if k.Parent then
                    k.Transparency = v1
                end
            end
        end
    end
    table.clear(u49.blocked)
end

local function demand(a1) -- Line: 101 -- upvalues: u49 (val) -- types: a1: userdata
    return assert(u49.roster[a1], (("%* is not registered for occlusion"):format(a1.Name)))
end

local function isUnderfoot(a1, a2, a3) -- Line: 107 -- types: a1: userdata, a2: table, a3: vector
    local v1 = (a1:GetScale()) / a2.RegisteredScale
    local Bounds = a2.Bounds
    local v2 = a2.Pivot.CFrame * ((CFrame.new(Bounds.Position * v1)) * Bounds.Rotation)
    local v3 = v2:PointToObjectSpace(a3)
    local v4 = a2.Extents * v1 * 0.5
    local v5 = v2:PointToWorldSpace((Vector3.new(math.clamp(v3.X, -v4.X, v4.X), -v4.Y, (math.clamp(v3.Z, -v4.Z, v4.Z))))) - a3
    return v5.X * v5.X + v5.Z * v5.Z <= 625
end

local function advance(a1, a2, a3) -- Line: 121
    -- upvalues: repaintEntry (val), u49 (val)
    if a2 then
        a1.UnfadeAt = 0
        return repaintEntry(a1, true)
    end
    if not a1.Faded then
        a1.UnfadeAt = 0
        return
    end
    if a1.UnfadeAt == 0 then
        a1.UnfadeAt = a3 + 1
        return
    end
    if a1.UnfadeAt <= a3 then
        local shelved, v1
        a1.UnfadeAt = 0
        a1.Faded = false
        for i in a1.Faces do
            shelved = u49.shelved
            v1 = shelved[i]
            if v1 ~= nil then
                shelved[i] = nil
                if i.Parent then
                    i.Transparency = v1
                end
            end
        end
    end
end

local function onFrame() -- Line: 137
    -- upvalues: Workspace (val), Player (val), LocalPlayer (val), u49 (val), releaseEverything (val), isUnderfoot (val)
    local CurrentCamera = Workspace.CurrentCamera
    local v1 = Player.FindCharacter(LocalPlayer)
    local v2 = Player.FindHead(LocalPlayer)
    local v3 = Player.FindRootPart(LocalPlayer)
    if u49.sweeping and CurrentCamera and v1 and v2 and v3 then
        local Target, Transparency, shelved, shelved_2, v4, v5, v6, v7
        local blocked = u49.blocked
        local faceOwner = u49.faceOwner
        u49.probeFrom[1] = v2.Position
        u49.probeSkip[1] = v1
        table.clear(blocked)
        for i, j in CurrentCamera:GetPartsObscuringTarget(u49.probeFrom, u49.probeSkip) do
            v2 = faceOwner[j]
            if v2 then
                blocked[v2] = true
            end
        end
        local Position = v3.Position
        local ServerTimeNow = Workspace:GetServerTimeNow()
        local v8 = nil
        local v9 = nil
        for k, n in u49.roster, v8, v9 do
            if not n.Muted then
                v4 = true
                if blocked[k] ~= true then
                    v4 = isUnderfoot(k, n, Position)
                end
                if v4 then
                    n.UnfadeAt = 0
                    n.Faded = true
                    Target = n.Target
                    v5 = nil
                    v6 = nil
                    for i5 in n.Faces, v5, v6 do
                        shelved = u49.shelved
                        if Target == nil then
                            v1 = shelved[i5]
                            if v1 ~= nil then
                                shelved[i5] = nil
                                if i5.Parent then
                                    i5.Transparency = v1
                                end
                            end
                        elseif i5.Transparency < 1 then
                            Transparency = i5.Transparency
                            v7 = shelved[i5]
                            if v7 == nil and Transparency < Target then
                                v7 = Transparency
                                shelved[i5] = Transparency
                            end
                            if v7 ~= nil then
                                i5.Transparency = math.max(v7, Target)
                            end
                        end
                    end
                elseif not n.Faded then
                    n.UnfadeAt = 0
                elseif n.UnfadeAt == 0 then
                    n.UnfadeAt = ServerTimeNow + 1
                elseif n.UnfadeAt <= ServerTimeNow then
                    n.UnfadeAt = 0
                    n.Faded = false
                    for m in n.Faces do
                        shelved_2 = u49.shelved
                        v7 = shelved_2[m]
                        if v7 ~= nil then
                            shelved_2[m] = nil
                            if m.Parent then
                                m.Transparency = v7
                            end
                        end
                    end
                end
            end
        end
        return
    end
    return releaseEverything()
end

function v1.Register(a1, a2) -- Line: 165
    -- upvalues: u65 (val), u69 (val), u49 (val), ModelBounds (val), Trove (val)
    u65(a1)
    u69(a2)
    local v1 = false
    if a2 >= 0 then
        v1 = a2 <= 1
    end
    assert(v1, "an occlusion fade target has to land between 0 and 1")
    assert(u49.roster[a1] == nil, (("%* is being registered for occlusion twice"):format(a1.Name)))
    local v2 = assert(a1.PrimaryPart, (("%* has no PrimaryPart to measure against"):format(a1.Name)))
    local Scale = a1:GetScale()
    local v3 = ("%* reports a scale of %*, which cannot be normalised"):format(a1.Name, Scale)
    assert(Scale > 0, v3)
    local v4, v5 = ModelBounds(a1)
    local u61 = {Faded = false, Muted = false, UnfadeAt = 0}
    u61.Bounds = v2.CFrame:ToObjectSpace(v4)
    u61.Extents = v5
    u61.Faces = {}
    u61.Lifetime = Trove.new()
    u61.Pivot = v2
    u61.RegisteredScale = Scale
    u61.Target = a2
    u49.roster[a1] = u61

    local function adopt(a1_2) -- Line: 193 -- upvalues: u49 (upval), u61 (val), a1 (val) -- types: a1_2: userdata
        if a1_2:IsA("BasePart") then
            assert(u49.faceOwner[a1_2] == nil, (("%* is claimed by two occlusion models"):format((a1_2:GetFullName()))))
            u61.Faces[a1_2] = true
            u49.faceOwner[a1_2] = a1
            if u61.Faded then
                local Target = u61.Target
                local shelved = u49.shelved
                if Target == nil then
                    local v1 = shelved[a1_2]
                    if v1 ~= nil then
                        shelved[a1_2] = nil
                        if a1_2.Parent then
                            a1_2.Transparency = v1
                            return
                        end
                    end
                elseif a1_2.Transparency < 1 then
                    local Transparency = a1_2.Transparency
                    local v2 = shelved[a1_2]
                    if v2 == nil and Transparency < Target then
                        v2 = Transparency
                        shelved[a1_2] = Transparency
                    end
                    if v2 ~= nil then
                        a1_2.Transparency = math.max(v2, Target)
                    end
                end
            end
        end
    end

    for i, j in a1:GetDescendants() do
        adopt(j)
    end
    u61.Lifetime:Connect(a1.DescendantAdded, adopt)
    u61.Lifetime:Connect(a1.DescendantRemoving, function(a1) -- Line: 207 -- upvalues: u61 (val), u49 (upval) -- types: a1: userdata
        if a1:IsA("BasePart") and u61.Faces[a1] then
            local shelved = u49.shelved
            local v1 = shelved[a1]
            if v1 ~= nil then
                shelved[a1] = nil
                if a1.Parent then
                    a1.Transparency = v1
                end
            end
            u61.Faces[a1] = nil
            u49.faceOwner[a1] = nil
        end
    end)
end

function v1.Forget(a1) -- Line: 223 -- upvalues: u65 (val), u49 (val) -- types: a1: userdata
    local shelved, v1
    u65(a1)
    local v2 = assert(u49.roster[a1], (("%* is not registered for occlusion"):format(a1.Name)))
    v2.UnfadeAt = 0
    v2.Faded = false
    for i in v2.Faces do
        shelved = u49.shelved
        v1 = shelved[i]
        if v1 ~= nil then
            shelved[i] = nil
            if i.Parent then
                i.Transparency = v1
            end
        end
    end
    for j in v2.Faces do
        u49.faceOwner[j] = nil
    end
    v2.Lifetime:Destroy()
    table.clear(v2.Faces)
    u49.roster[a1] = nil
    u49.blocked[a1] = nil
end

function v1.SetIgnored(a1, a2) -- Line: 240
    -- upvalues: u65 (val), u72 (val), u49 (val)
    u65(a1)
    u72(a2)
    local v1 = assert(u49.roster[a1], (("%* is not registered for occlusion"):format(a1.Name)))
    if v1.Muted ~= a2 then
        v1.Muted = a2
        if a2 then
            local shelved, v2
            v1.UnfadeAt = 0
            v1.Faded = false
            for i in v1.Faces do
                shelved = u49.shelved
                v2 = shelved[i]
                if v2 ~= nil then
                    shelved[i] = nil
                    if i.Parent then
                        i.Transparency = v2
                    end
                end
            end
            u49.blocked[a1] = nil
        end
    end
end

local function standDown() -- Line: 255 -- upvalues: u49 (val), RunService (val), releaseEverything (val), u58 (val)
    local sweeping = u49.sweeping
    u49.sweeping = false
    local sweep = u49.sweep
    u49.sweep = nil
    if sweep then
        task.defer(RunService.UnbindFromRenderStep, RunService, sweep)
    end
    releaseEverything()
    if sweeping then
        u58:AtDebug():Log("Occlusion sweep released the camera")
    end
end

function v1.SetEnabled(a1) -- Line: 271
    -- upvalues: u72 (val), u49 (val), HttpService (val), RunService (val), u48 (val), onFrame (val), u58 (val)
    -- upvalues: releaseEverything (val)
    u72(a1)
    if a1 and not u49.sweeping then
        assert(u49.sweep == nil, "an occlusion sweep is bound while the system reads as idle")
        u49.sweeping = true
        local v1 = ("ModelCameraOcclusion.%*"):format((HttpService:GenerateGUID(false)))
        RunService:BindToRenderStep(v1, u48, onFrame)
        u49.sweep = v1
        u58:AtDebug():Log("Occlusion sweep took the camera")
        return
    end
    if not a1 then
        local sweeping = u49.sweeping
        u49.sweeping = false
        local sweep = u49.sweep
        u49.sweep = nil
        if sweep then
            task.defer(RunService.UnbindFromRenderStep, RunService, sweep)
        end
        releaseEverything()
        if sweeping then
            u58:AtDebug():Log("Occlusion sweep released the camera")
        end
    end
end

return v1