-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.4.0.topbarplus.Packages.Janitor
-- Decompile time: 9.38 ms

local v1
local Heartbeat = game:GetService("RunService").Heartbeat

local function getPromiseReference() -- Line: 26
    return false
end

local u9 = newproxy(true)
local v2 = getmetatable(u9)

function v2.__tostring() -- Line: 31
    return "IndicesReference"
end

local u16 = newproxy(true)
local v3 = getmetatable(u16)

function v3.__tostring() -- Line: 36
    return "LinkToInstanceIndex"
end

local u21 = {
    IGNORE_MEMORY_DEBUG = true,
    ClassName = "Janitor",
    __index = {CurrentlyCleaning = true, [u9] = nil},
}
local u25 = {["function"] = true, Promise = "cancel", RBXScriptConnection = "Disconnect"}

function u21.new() -- Line: 58 -- upvalues: u9 (val), u21 (val)
    return (setmetatable({CurrentlyCleaning = false, [u9] = nil}, u21))
end

function u21.Is(a1) -- Line: 65 -- upvalues: u21 (val)
    local v1 = false
    if type(a1) == "table" then
        v1 = (getmetatable(a1)) == u21
    end
    return v1
end

u21.is = u21.Is

function u21.__index:Add(a2, a3, a4) -- Line: 71 -- upvalues: u9 (val), u25 (val)
    local v1
    if a4 then
        self:Remove(a4)
        v1 = self[u9]
        if not v1 then
            self[u9] = {}
        end
        v1[a4] = a2
    end
    v1 = typeof(a2)
    if v1 == "table" and string.match(tostring(a2), "Promise") then
        v1 = "Promise"
    end
    local v2 = a3 or u25[v1] or "Destroy"
    if type(a2) ~= "function" and not a2[v2] then
        warn(string.format(
            "Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s",
            tostring(a2),
            tostring(v2),
            debug.traceback(nil, 2)
        ))
    end
    self[a2] = {v2, (debug.traceback(""))}
    return a2
end

u21.__index.Give = u21.__index.Add

function u21.__index.AddPromise(a1, a2) -- Line: 103
    local v1 = false
    if not v1 then
        return a2
    end
    if not v1.is(a2) then
        error(string.format("Invalid argument #1 to 'Janitor:AddPromise' (Promise expected, got %s (%s))", typeof(a2), (tostring(a2))))
    end
    if (a2:getStatus()) ~= v1.Status.Started then
        return a2
    end
    local v2 = newproxy(false)
    local v3 = a1:Add(v1.new(function(a1, a2_2, a3) -- Line: 111 -- upvalues: a2 (val)
        if a3(function() -- Line: 112 -- upvalues: a2 (upval)
            local v0, v1
            a2:cancel()
            return
        end) then
            return
        end
        a1(a2)
    end), "cancel", v2)
    v3:finallyCall(a1.Remove, a1, v2)
    return v3
end

u21.__index.GivePromise = u21.__index.AddPromise

function u21.__index.AddObject(a1, a2) -- Line: 133
    local v1 = newproxy(false)
    local v2 = false
    if v2 and v2.is(a2) then
        if (a2:getStatus()) ~= v2.Status.Started then
            return a2
        end
        local v3 = a1:Add(v2.resolve(a2), "cancel", v1)
        v3:finallyCall(a1.Remove, a1, v1)
        return v3, v1
    end
    return (a1:Add(a2, false, v1)), v1
end

u21.__index.GiveObject = u21.__index.AddObject

function u21.__index:Remove(a2) -- Line: 151 -- upvalues: u9 (val)
    local v1 = self[u9]
    if v1 then
        local v2 = v1[a2]
        if v2 then
            local v3 = self[v2]
            local v4 = v3 and v3[1]
            if v4 then
                if v4 ~= true then
                    v3 = v2[v4]
                    if v3 then
                        v3(v2)
                    end
                else
                    v2()
                end
                self[v2] = nil
            end
            v1[a2] = nil
        end
    end
    return self
end

function u21.__index.Get(a1, a2) -- Line: 180 -- upvalues: u9 (val)
    local v1 = a1[u9]
    if v1 then
        return v1[a2]
    end
    return nil
end

function u21.__index:Cleanup() -- Line: 188 -- upvalues: u9 (val)
    if not self.CurrentlyCleaning then
        local err, err_2, success, success_2, v1, v2, v3, v4, v5, warnUser
        self.CurrentlyCleaning = nil
        local v6 = next
        local v7 = nil
        local v8 = self
        for k, v in v6, self, v7 do
            if k ~= u9 then
                v4 = type(k)
                if v4 ~= "string" then
                    if v4 ~= "number" then
                        v4 = v[1]
                        local u37 = v[2]

                        function warnUser(a1) -- Line: 205 -- upvalues: u37 (val)
                            local v1 = debug.traceback("", 3)
                            warn("-------- Janitor Error --------" .. "\n" .. (tostring(a1)) .. "\n" .. v1 .. "" .. u37)
                        end

                        if v4 ~= true then
                            v5 = k[v4]
                            if v5 then
                                success_2, err_2 = pcall(v5, k)
                                v2 = false
                                if typeof(k) == "Instance" then
                                    v2 = v5 == "Destroy"
                                end
                                if not success_2 and not v2 then
                                    v3 = debug.traceback("", 3)
                                    warn("-------- Janitor Error --------" .. "\n" .. (tostring(err_2)) .. "\n" .. v3 .. "" .. u37)
                                end
                            end
                        else
                            success, err = pcall(k)
                            if not success then
                                v1 = debug.traceback("", 3)
                                warn("-------- Janitor Error --------" .. "\n" .. (tostring(err)) .. "\n" .. v1 .. "" .. u37)
                            end
                        end
                    end
                end
                v8[k] = nil
            end
        end
        v6 = v8[u9]
        if v6 then
            for k2 in next, v6 do
                v6[k2] = nil
            end
            v8[u9] = {}
        end
        v8.CurrentlyCleaning = false
    end
end

u21.__index.Clean = u21.__index.Cleanup

function u21.__index.Destroy(a1) -- Line: 244
    a1:Cleanup()
end

u21.__call = u21.__index.Cleanup
local u60 = {Connected = true}
u60.__index = u60

function u60:Disconnect() -- Line: 254
    if self.Connected then
        self.Connected = false
        self.Connection:Disconnect()
    end
end

function u60.__tostring(a1) -- Line: 261
    return "Disconnect<" .. (tostring(a1.Connected)) .. ">"
end

function u21.__index:LinkToInstance(a2, a3) -- Line: 265 -- upvalues: u16 (val), u60 (val), Heartbeat (val)
    local u3 = nil
    local u12 = a2.Parent == nil
    local u16_2 = setmetatable({}, u60)
    u3 = a2.AncestryChanged:Connect(function(a1, a2) -- Line: 271 -- upvalues: u16_2 (val), u12 (ref), Heartbeat (upval), u3 (ref), self (val)
        if u16_2.Connected then
            u12 = a2 == nil
            if u12 then
                coroutine.wrap(function() -- Line: 277 -- upvalues: Heartbeat (upval), u16_2 (upval), u3 (upval), self (upval), u12 (upval)
                    Heartbeat:Wait()
                    if not u16_2.Connected then
                        return
                    end
                    if not u3.Connected then
                        self:Cleanup()
                        return
                    end
                    while u12 do
                        if not u3.Connected or not u16_2.Connected then
                            break
                        end
                        Heartbeat:Wait()
                    end
                    if u16_2.Connected and u12 then
                        self:Cleanup()
                    end
                end)()
            end
        end
    end)
    u16_2.Connection = u3
    if u12 then
        local Parent = a2.Parent
        if u16_2.Connected then
            u12 = Parent == nil
            if u12 then
                coroutine.wrap(function() -- Line: 277 -- upvalues: Heartbeat (upval), u16_2 (val), u3 (ref), self (val), u12 (ref)
                    Heartbeat:Wait()
                    if not u16_2.Connected then
                        return
                    end
                    if not u3.Connected then
                        self:Cleanup()
                        return
                    end
                    while u12 do
                        if not u3.Connected or not u16_2.Connected then
                            break
                        end
                        Heartbeat:Wait()
                    end
                    if u16_2.Connected and u12 then
                        self:Cleanup()
                    end
                end)()
            end
        end
    end
    return (self:Add(u16_2, "Disconnect", a3 and newproxy(false) or u16))
end

function u21.__index.LinkToInstances(a1, ...) -- Line: 308 -- upvalues: u21 (val)
    local v1 = u21.new()
    for i, v in ipairs({...}) do
        v1:Add(a1:LinkToInstance(v, true), "Disconnect")
    end
    return v1
end

for k, v in next, u21.__index do
    v1 = (string.sub(string.lower(k), 1, 1)) .. string.sub(k, 2)
    u21.__index[v1] = v
end
return u21