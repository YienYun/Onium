-- Script path: ReplicatedStorage.Packages._Index.sleitnick_trove@0.4.2.trove
-- Decompile time: 4.75 ms

local u1 = newproxy()
local u3 = newproxy()
local RunService = game:GetService("RunService")

local function GetObjectCleanupFunction(a1, a2) -- Line: 10 -- upvalues: u1 (val), u3 (val)
    local v1 = typeof(a1)
    if v1 == "function" then
        return u1
    end
    if v1 == "thread" then
        return u3
    end
    if a2 then
        return a2
    end
    if v1 == "Instance" then
        return "Destroy"
    end
    if v1 == "RBXScriptConnection" then
        return "Disconnect"
    end
    if v1 == "table" then
        if typeof(a1.Destroy) == "function" then
            return "Destroy"
        end
        if typeof(a1.Disconnect) == "function" then
            return "Disconnect"
        end
    end
    error("Failed to get cleanup function for object " .. v1 .. ": " .. tostring(a1), 3)
end

local function AssertPromiseLike(a1) -- Line: 34
    if type(a1) ~= "table"
        or type(a1.getStatus) ~= "function"
        or type(a1.finally) ~= "function"
        or type(a1.cancel) ~= "function" then
        error("Did not receive a Promise as an argument", 3)
    end
end

local u11 = {}
u11.__index = u11

function u11.new() -- Line: 57 -- upvalues: u11 (val)
    local v1 = setmetatable({}, u11)
    v1._objects = {}
    return v1
end

function u11.Extend(a1) -- Line: 82 -- upvalues: u11 (val)
    return a1:Construct(u11)
end

function u11:Clone(a2) -- Line: 90 -- types: self: table, a2: userdata
    return self:Add((a2:Clone()))
end

function u11:Construct(a2, ...) -- Line: 127
    local v1 = nil
    local v2 = type(a2)
    if v2 == "table" then
        v1 = a2.new(...)
    elseif v2 == "function" then
        v1 = a2(...)
    end
    return self:Add(v1)
end

function u11:Connect(a2, a3) -- Line: 153
    return self:Add((a2:Connect(a3)))
end

function u11:BindToRenderStep(a2, a3, a4) -- Line: 170
    -- upvalues: RunService (val)
    RunService:BindToRenderStep(a2, a3, a4)
    self:Add(function() -- Line: 172 -- upvalues: RunService (upval), a2 (val)
        RunService:UnbindFromRenderStep(a2)
    end)
end

function u11.AddPromise(a1, a2) -- Line: 200
    if type(a2) ~= "table"
        or type(a2.getStatus) ~= "function"
        or type(a2.finally) ~= "function"
        or type(a2.cancel) ~= "function" then
        error("Did not receive a Promise as an argument", 3)
    end
    if a2:getStatus() == "Started" then
        a2:finally(function() -- Line: 203 -- upvalues: a1 (val), a2 (val)
            return a1:_findAndRemoveFromObjects(a2, false)
        end)
        a1:Add(a2, "cancel")
    end
    return a2
end

function u11:Add(a2, a3) -- Line: 259 -- upvalues: GetObjectCleanupFunction (val)
    table.insert(self._objects, {a2, (GetObjectCleanupFunction(a2, a3))})
    return a2
end

function u11.Remove(a1, a2, ...) -- Line: 275
    return a1:_findAndRemoveFromObjects(a2, true, ...)
end

function u11:Clean() -- Line: 284
    for i, v in ipairs(self._objects) do
        self:_cleanupObject(v[1], v[2])
    end
    table.clear(self._objects)
end

function u11:_findAndRemoveFromObjects(a2, a3, ...) -- Line: 291 -- types: self: table, a3: boolean
    local v1
    local _objects = self._objects
    for i, v in ipairs(_objects) do
        if v[1] == a2 then
            v1 = #_objects
            _objects[i] = _objects[v1]
            _objects[v1] = nil
            if a3 then
                self:_cleanupObject(v[1], v[2], ...)
            end
            return true
        end
    end
    return false
end

function u11._cleanupObject(a1, a2, a3, ...) -- Line: 307 -- upvalues: u1 (val), u3 (val)
    if a3 == u1 then
        a2()
        return
    end
    if a3 == u3 then
        coroutine.close(a2)
        return
    end
    if typeof(a3) == "function" then
        a3(a2, ...)
        return
    end
    a2[a3](a2)
end

function u11.AttachToInstance(a1, a2) -- Line: 332 -- types: a1: table, a2: userdata
    assert(a2:IsDescendantOf(game), "Instance is not a descendant of the game hierarchy")
    return a1:Connect(a2.Destroying, function() -- Line: 334 -- upvalues: a1 (val)
        a1:Destroy()
    end)
end

function u11:Destroy() -- Line: 342
    self:Clean()
end

return u11