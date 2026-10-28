-- Script path: ReplicatedStorage.Packages._Index.pyseph_objectcache@1.4.6.objectcache
-- Decompile time: 10.12 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local QueueLock = require(ReplicatedStorage.Shared.Modules.QueueLock)
local u20 = require(ReplicatedStorage.Packages.Log).new()
local v1 = (workspace:WaitForChild("World")):WaitForChild("InvisibleRenderSpace")
local v2 = v1.Size * 0.5
local u34 = v1.Position - v2
local u36 = v1.Position + v2
local u39 = if not Constants.IS_MOBILE then 0.004 else 0.006
local u43 = table.create(10000)
local u46 = table.create(10000)
local u50 = if not Constants.IS_CLIENT then nil else {}
local u51 = false
local u57 = coroutine.create(function() -- Line: 27 -- upvalues: u43 (val), u46 (val), u51 (ref)
    while true do
        workspace:BulkMoveTo(u43, u46, Enum.BulkMoveMode.FireCFrameChanged)
        table.clear(u43)
        table.clear(u46)
        u51 = false
        coroutine.yield()
    end
end)
local u58 = {}
u58.__index = u58

local function randFloat(a1, a2) -- Line: 60 -- types: a1: number, a2: number
    return math.random() * (a2 - a1) + a1
end

local function hiddenCFrame() -- Line: 64 -- upvalues: u34 (ref), u36 (ref)
    local new = CFrame.new
    local X = u34.X
    local X_2 = u36.X
    local v1 = math.random() * (X_2 - X) + X
    local Y = u34.Y
    local Y_2 = u36.Y
    local v2 = math.random() * (Y_2 - Y) + Y
    local Z = u34.Z
    return new(v1, v2, math.random() * (u36.Z - Z) + Z)
end

function u58:_GetNew(a2, a3) -- Line: 72 -- upvalues: u34 (ref), u36 (ref), u39 (val) -- types: a2: number, a3: boolean
    local PrimaryPart, X, X_2, Y, Y_2, Z, new, v1, v2, v3
    if a3 then
        warn((("ObjectCache: Cache retrieval exceeded preallocated amount! expanding by %*..."):format(a2)))
    end
    local _FreeObjects = self._FreeObjects
    local v4 = #self._FreeObjects
    local CacheHolder = self.CacheHolder
    local _IsTemplateModel = self._IsTemplateModel
    local _Template = self._Template
    local v5 = table.create(a2)
    local v6 = table.create(a2)
    local v7 = os.clock()
    local v8 = v4 + 1
    local v9 = v4 + a2
    for i = v8, v9 do
        v1 = _Template:Clone()
        PrimaryPart = if not _IsTemplateModel then v1 else v1.PrimaryPart
        _FreeObjects[i] = PrimaryPart
        v10._DesiredAnchored[PrimaryPart] = PrimaryPart.Anchored
        PrimaryPart.Anchored = true
        v1.Parent = CacheHolder
        v1 = i - v4
        v5[v1] = PrimaryPart
        new = CFrame.new
        X = u34.X
        X_2 = u36.X
        v2 = math.random() * (X_2 - X) + X
        Y = u34.Y
        Y_2 = u36.Y
        v3 = math.random() * (Y_2 - Y) + Y
        Z = u34.Z
        v6[v1] = (new(v2, v3, math.random() * (u36.Z - Z) + Z))
        if u39 <= os.clock() - v7 then
            task.wait()
            os.clock()
        end
    end
    workspace:BulkMoveTo(v5, v6, Enum.BulkMoveMode.FireCFrameChanged)
    return table.remove(_FreeObjects)
end

function u58.GetPart(a1, a2) -- Line: 116
    -- upvalues: u20 (val), u43 (val), u46 (val), u51 (ref), u57 (val)
    local u4 = table.remove(a1._FreeObjects)
    if not u4 then
        a1._ExpandMutex:WithLock(function() -- Line: 119 -- upvalues: u20 (upval), a1 (val), u4 (ref)
            (u20:AtTrace()):Log("free objects at creation:", a1._FreeObjects, "SELF", a1)
            u4 = a1:_GetNew(a1._ExpandAmount, true)
            ;(u20:AtTrace()):Log("part found after expanding cache:", u4, "self:", a1)
        end)
    end
    assert(u4, "ObjectCache: failed to allocate part")
    a1._Objects[u4] = nil
    if a2 then
        table.insert(u43, u4)
        table.insert(u46, a2)
        if not u51 then
            u51 = true
            task.defer(u57)
        end
    end
    local u35 = a1._DesiredAnchored[u4]
    if u35 ~= nil then
        a1._DesiredAnchored[u4] = nil
        task.defer(function() -- Line: 146 -- upvalues: u4 (ref), u35 (val)
            u4.Anchored = u35
        end)
    end
    return u4
end

function u58.ReturnPart(a1, a2) -- Line: 154
    -- upvalues: u43 (val), u46 (val), hiddenCFrame (val), u51 (ref), u57 (val)
    if a1._Objects[a2] then
        return
    end
    a1._Objects[a2] = true
    a1._DesiredAnchored[a2] = a2.Anchored
    a2.Anchored = true
    table.insert(a1._FreeObjects, a2)
    table.insert(u43, a2)
    table.insert(u46, (hiddenCFrame()))
    if not u51 then
        u51 = true
        task.defer(u57)
    end
end

function u58.Update(a1) -- Line: 174 -- upvalues: u57 (val)
    task.spawn(u57)
end

function u58.ExpandCache(a1, a2) -- Line: 178 -- types: a2: number
    local v1 = true
    if typeof(a2) == "number" then
        v1 = a2 >= 0
    end
    assert(v1, (("Invalid argument #1 to 'ObjectCache:ExpandCache' (positive number expected, got %*)"):format((typeof(a2)))))
    a1._ExpandMutex:WithLock(function() -- Line: 184 -- upvalues: a1 (val), a2 (val)
        a1:_GetNew(a2, false)
    end)
    return a1
end

function u58.SetExpandAmount(a1, a2) -- Line: 190 -- types: a2: number
    local v1 = true
    if typeof(a2) == "number" then
        v1 = a2 > 0
    end
    assert(v1, (("Invalid argument #1 to 'ObjectCache:SetExpandAmount' (positive number expected, got %*)"):format((typeof(a2)))))
    a1._ExpandAmount = a2
    return a1
end

function u58.IsInUse(a1, a2) -- Line: 200 -- types: a2: userdata
    return a1._Objects[a2] == nil
end

local function CollectFlush(a1, a2, a3) -- Line: 204 -- upvalues: u43 (val), u46 (val) -- types: a2: vector, a3: vector
    local X, X_2, Y, Y_2, Z, Z_2, new, v1, v2, v3
    debug.profilebegin("ObjectCache :: CollectFlush")
    for i, v in ipairs(a1._FreeObjects) do
        table.insert(u43, v)
        v3 = u46
        new = CFrame.new
        X = a2.X
        X_2 = a3.X
        v1 = math.random() * (X_2 - X) + X
        Y = a2.Y
        Y_2 = a3.Y
        v2 = math.random() * (Y_2 - Y) + Y
        Z = a2.Z
        Z_2 = a3.Z
        table.insert(v3, (new(v1, v2, (math.random()) * (Z_2 - Z) + Z)))
    end
    debug.profileend()
end

function u58.FlushToBounds(a1, a2, a3) -- Line: 218
    -- upvalues: CollectFlush (val), u51 (ref), u57 (val)
    CollectFlush(a1, a2, a3)
    if not u51 then
        u51 = true
        task.defer(u57)
    end
end

function u58:Destroy() -- Line: 227 -- upvalues: u50 (val)
    debug.profilebegin("ObjectCache :: Destroy")
    if u50 then
        u50[self] = nil
    end
    self.CacheHolder:Destroy()
    debug.profileend()
end

local function GetCacheContainer() -- Line: 238
    local Folder = Instance.new("Folder")
    Folder.Name = "ObjectCache"
    return Folder
end

return {
    new = function(a1, a2, a3) -- Line: 246
        -- upvalues: QueueLock (val), u58 (val), u34 (ref), u36 (ref), u39 (val), u50 (val)
        local PrimaryPart, X, X_2, Y, Y_2, Z, new, v1, v2, v3
        local v4 = typeof(a1)
        local v5 = ("Invalid argument #1 to 'ObjectCache.new' (BasePart expected, got %*)"):format(v4)
        assert(v4 == "Instance", v5)
        v5 = ("Invalid argument #1 to 'ObjectCache.new' (BasePart or Model expected, got %*)"):format(a1.ClassName)
        assert(a1:IsA("BasePart") or a1:IsA("Model"), v5)
        assert(a1.Archivable, "ObjectCache: Cannot use template object provided, as it has Archivable set to false.")
        if a1:IsA("Model") then
            assert(a1.PrimaryPart ~= nil, "Invalid Template provided to 'ObjectCache.new': Model has no PrimaryPart set!")
        end
        v4 = typeof(a2)
        local v6 = true
        if a2 ~= nil then
            v6 = v4 == "number"
        end
        assert(v6, (("Invalid argument #2 to 'ObjectCache.new' (number expected, got %*)"):format(v4)))
        v6 = true
        if a2 ~= nil then
            v6 = a2 >= 0
        end
        assert(v6, (("Invalid argument #2 to 'ObjectCache.new' (positive number expected, got %*)"):format(a2)))
        v4 = typeof(a3)
        v6 = true
        if a3 ~= nil then
            v6 = v4 == "Instance"
        end
        assert(v6, (("Invalid argument #3 to 'ObjectCache.new' (Instance expected, got %*)"):format(v4)))
        v4 = a2 or 1
        local Folder = Instance.new("Folder")
        Folder.Name = "ObjectCache"
        v5 = table.create(v4)
        local v7 = {}
        local v8 = a1:IsA("Model")
        local v9 = {
            CacheHolder = Folder,
            _ExpandAmount = a2 or 1,
            _Template = a1,
            _FreeObjects = v5,
            _Objects = {},
            _IsTemplateModel = v8,
            _PreallocatedAmount = v4,
            _DesiredAnchored = v7,
            _ExpandMutex = QueueLock.new(),
        }
        local v10 = setmetatable(v9, u58)
        if not a3 then
            Folder.Parent = workspace
        else
            Folder.Parent = a3
        end
        v6 = os.clock()
        for i = 1, v4 do
            v1 = a1:Clone()
            PrimaryPart = if not v8 then v1 else v1.PrimaryPart
            v5[i] = PrimaryPart
            v7[PrimaryPart] = PrimaryPart.Anchored
            PrimaryPart.Anchored = true
            v1.Parent = Folder
            new = CFrame.new
            X = u34.X
            X_2 = u36.X
            v2 = math.random() * (X_2 - X) + X
            Y = u34.Y
            Y_2 = u36.Y
            v3 = math.random() * (Y_2 - Y) + Y
            Z = u34.Z
            PrimaryPart.CFrame = new(v2, v3, math.random() * (u36.Z - Z) + Z)
            if u39 <= os.clock() - v6 then
                task.wait()
                os.clock()
            end
        end
        if u50 then
            u50[v10] = true
        end
        return v10
    end,
    SetInvisibleBounds = function(a1, a2) -- Line: 338 -- upvalues: u34 (ref), u36 (ref) -- types: a1: vector, a2: vector
        u34 = a1
        u36 = a2
    end,
    is = function(a1) -- Line: 343 -- upvalues: u58 (val)
        if typeof(a1) ~= "table" then
            return false
        end
        return (getmetatable(a1)) == u58
    end,
    GetRandomHiddenCFrame = hiddenCFrame,
}