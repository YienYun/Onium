-- Script path: ReplicatedStorage.Packages._Index.sleitnick_trove@1.5.0.trove
-- Decompile time: 5.18 ms

local RunService = game:GetService("RunService")
local u6 = newproxy()
local u8 = newproxy()
local u15 = table.freeze({"Destroy", "Disconnect", "destroy", "disconnect"})

local function GetObjectCleanupFunction(a1, a2) -- Line: 128 -- upvalues: u6 (val), u8 (val), u15 (val)
    local v1 = typeof(a1)
    if v1 == "function" then
        return u6
    end
    if v1 == "thread" then
        return u8
    end
    if a2 then
        return a2
    end
    if v1 ~= "Instance" and v1 ~= "Object" then
        if v1 == "RBXScriptConnection" then
            return "Disconnect"
        end
        if v1 == "table" then
            for i, j in u15 do
                if typeof(a1[j]) == "function" then
                    return j
                end
            end
        end
        error(("failed to get cleanup function for object %*: %*"):format(v1, a1), 3)
        return
    end
    return "Destroy"
end

local function AssertPromiseLike(a1) -- Line: 156
    if typeof(a1) ~= "table"
        or typeof(a1.getStatus) ~= "function"
        or typeof(a1.finally) ~= "function"
        or typeof(a1.cancel) ~= "function" then
        error("did not receive a promise as an argument", 3)
    end
end

local u18 = {}
u18.__index = u18

function u18.new() -- Line: 183 -- upvalues: u18 (val)
    local v1 = setmetatable({}, u18)
    v1._objects = {}
    v1._cleaning = false
    return v1
end

function u18.is(a1) -- Line: 197 -- upvalues: u18 (val)
    if typeof(a1) ~= "table" then
        return false
    end
    return (getmetatable(a1)) == u18
end

function u18:Add(a2, a3) -- Line: 254 -- upvalues: GetObjectCleanupFunction (val)
    if self._cleaning then
        error("cannot call trove:Add() while cleaning", 2)
    end
    table.insert(self._objects, {a2, (GetObjectCleanupFunction(a2, a3))})
    return a2
end

function u18:Clone(a2) -- Line: 276 -- types: a2: userdata
    if self._cleaning then
        error("cannot call trove:Clone() while cleaning", 2)
    end
    return self:Add((a2:Clone()))
end

function u18:Construct(a2, ...) -- Line: 319
    if self._cleaning then
        error("Cannot call trove:Construct() while cleaning", 2)
    end
    local v1 = nil
    local v2 = type(a2)
    if v2 == "table" then
        v1 = a2.new(...)
    elseif v2 == "function" then
        v1 = a2(...)
    end
    return self:Add(v1)
end

function u18:Connect(a2, a3) -- Line: 352 -- types: a2: table, a3: function
    if self._cleaning then
        error("Cannot call trove:Connect() while cleaning", 2)
    end
    return self:Add((a2:Connect(a3)))
end

function u18:BindToRenderStep(a2, a3, a4) -- Line: 375
    -- upvalues: RunService (val)
    if self._cleaning then
        error("cannot call trove:BindToRenderStep() while cleaning", 2)
    end
    RunService:BindToRenderStep(a2, a3, a4)
    self:Add(function() -- Line: 382 -- upvalues: RunService (upval), a2 (val)
        RunService:UnbindFromRenderStep(a2)
    end)
end

function u18.AddPromise(a1, a2) -- Line: 412 -- types: a2: table
    if a1._cleaning then
        error("cannot call trove:AddPromise() while cleaning", 2)
    end
    if typeof(a2) ~= "table"
        or typeof(a2.getStatus) ~= "function"
        or typeof(a2.finally) ~= "function"
        or typeof(a2.cancel) ~= "function" then
        error("did not receive a promise as an argument", 3)
    end
    if a2:getStatus() == "Started" then
        a2:finally(function() -- Line: 419 -- upvalues: a1 (val), a2 (val)
            if a1._cleaning then
                return
            end
            a1:_findAndRemoveFromObjects(a2, false)
        end)
        a1:Add(a2, "cancel")
    end
    return a2
end

function u18.Remove(a1, a2, ...) -- Line: 444
    if a1._cleaning then
        error("cannot call trove:Remove() while cleaning", 2)
    end
    return a1:_findAndRemoveFromObjects(a2, true, ...)
end

function u18.Extend(a1) -- Line: 473 -- upvalues: u18 (val)
    if a1._cleaning then
        error("cannot call trove:Extend() while cleaning", 2)
    end
    return a1:Construct(u18)
end

function u18:Clean() -- Line: 493
    if self._cleaning then
        return
    end
    self._cleaning = true
    for i, j in self._objects do
        self:_cleanupObject(j[1], j[2])
    end
    table.clear(self._objects)
    self._cleaning = false
end

function u18.WrapClean(a1) -- Line: 535
    return function() -- Line: 536 -- upvalues: a1 (val)
        a1:Clean()
    end
end

function u18:_findAndRemoveFromObjects(a2, a3, ...) -- Line: 541 -- types: a3: boolean
    local v1
    local _objects = self._objects
    for i, j in _objects do
        if j[1] == a2 then
            v1 = #_objects
            _objects[i] = _objects[v1]
            _objects[v1] = nil
            if a3 then
                self:_cleanupObject(j[1], j[2], ...)
            end
            return true
        end
    end
    return false
end

function u18._cleanupObject(a1, a2, a3, ...) -- Line: 561 -- upvalues: u6 (val), u8 (val) -- types: a3: string?
    if a3 == u6 then
        task.spawn(a2)
        return
    end
    if a3 == u8 then
        pcall(task.cancel, a2)
        return
    end
    if typeof(a3) == "function" then
        a3(a2, ...)
        return
    end
    a2[a3](a2)
end

function u18.AttachToInstance(a1, a2) -- Line: 603 -- types: a2: userdata
    if a1._cleaning then
        error("cannot call trove:AttachToInstance() while cleaning", 2)
    elseif not a2:IsDescendantOf(game) then
        error("instance is not a descendant of the game hierarchy", 2)
    end
    return a1:Connect(a2.Destroying, function() -- Line: 610 -- upvalues: a1 (val)
        a1:Destroy()
    end)
end

function u18:Destroy() -- Line: 624
    self:Clean()
end

return {new = u18.new, is = u18.is}