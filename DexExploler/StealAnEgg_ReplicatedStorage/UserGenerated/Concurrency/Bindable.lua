-- Script path: ReplicatedStorage.UserGenerated.Concurrency.Bindable
-- Decompile time: 7.65 ms

local function ErrorHandler(a1) -- Line: 96
    warn((("%*\nStack Begin\n%*Stack End"):format(tostring(a1), (debug.traceback(nil, 3)))))
end

local function WCall(a1, ...) -- Line: 100 -- upvalues: ErrorHandler (val) -- types: a1: function
    local success = xpcall(a1, ErrorHandler, ...)
    return success
end

local function FindRight(a1, a2) -- Line: 108 -- types: a1: table
    local v1, v2
    local v3 = false
    local v4 = 1
    local v5 = #a1
    local v6, v7 = a1, a2
    while v4 <= v5 do
        v1 = v4 + (v5 - v4) // 2
        v2 = v6[v1].Pr - v7.Pr
        if v2 > 0 then
            v5 = v1 - 1
        else
            if not (v2 < 0) then
                v3 = true
            end
            v4 = v1 + 1
        end
    end
    return v3 and v4 or -v4
end

local function FindLeft(a1, a2) -- Line: 132 -- types: a1: table
    local v1, v2
    local v3 = false
    local v4 = 1
    local v5 = #a1
    local v6, v7 = a1, a2
    while v4 <= v5 do
        v1 = v4 + (v5 - v4) // 2
        v2 = v6[v1].Pr - v7.Pr
        if v2 > 0 then
            v5 = v1 - 1
        elseif not (v2 < 0) then
            v3 = true
            v5 = v1 - 1
        else
            v4 = v1 + 1
        end
    end
    return v3 and v4 or -v4
end

local function InsertRight(a1, a2) -- Line: 155 -- upvalues: FindRight (val) -- types: a1: table
    local v1 = math.abs((FindRight(a1, a2)))
    table.insert(a1, v1, a2)
    return v1
end

local function Remove(a1, a2) -- Line: 165 -- upvalues: FindLeft (val) -- types: a1: table
    local v1 = FindLeft(a1, a2)
    if v1 > 0 then
        local v2 = #a1
        for i = v1, v2 do
            if a1[i] == a2 then
                table.remove(a1, i)
                return true
            end
        end
    end
    return false
end

local function Connection_Disconnect(a1) -- Line: 183 -- upvalues: Remove (val)
    local Ow = a1.Ow
    if Ow ~= nil then
        a1.Ow = nil
        if not Remove(Ow.Cs, a1) then
            warn("BindableConnectionDisconnect")
        end
        for i, v in ipairs(a1.Wt) do
            task.spawn(v)
        end
        table.clear(a1.Wt)
    end
end

local u15 = table.freeze({
    __index = table.freeze({
        IsConnected = function(a1) -- Line: 179
            return a1.Ow ~= nil
        end,
        Disconnect = Connection_Disconnect,
        GetPriority = function(a1) -- Line: 197
            return a1.Pr
        end,
    }),
})

local function Connection_new(a1, a2, a3) -- Line: 208 -- upvalues: u15 (val) -- types: a2: function, a3: number
    return (setmetatable({Ow = a1, Cb = a2, Pr = a3, Wt = {}}, u15))
end

local u35 = table.freeze({
    __index = table.freeze({
        Fire = function(a1, ...) -- Line: 250
            local v1
            local Cs = a1.Cs
            local v2 = 1
            while v2 <= #Cs do
                v1 = Cs[v2]
                task.spawn(v1.Cb, ...)
                if Cs[v2] == v1 then
                    v2 = v2 + 1
                end
            end
        end,
        FireAndWait = function(a1, ...) -- Line: 264 -- upvalues: WCall (val)
            local v1
            local Cs = a1.Cs
            if #Cs == 0 then
                return
            end
            local u13 = 1
            local u5 = coroutine.running()

            local function executor(a1, ...) -- Line: 271
                -- upvalues: WCall (upval), u13 (ref), u5 (val)
                WCall(a1, ...)
                u13 = u13 - 1
                if u13 == 0 then
                    task.spawn(u5)
                end
            end

            local v2 = 1
            while v2 <= #Cs do
                v1 = Cs[v2]
                u13 = u13 + 1
                task.spawn(executor, v1.Cb, ...)
                if Cs[v2] == v1 then
                    v2 = v2 + 1
                end
            end
            u13 = u13 - 1
            if u13 > 0 then
                coroutine.yield()
            end
        end,
        FireSync = function(a1, ...) -- Line: 293 -- upvalues: WCall (val)
            local v1
            local Cs = a1.Cs
            local v2 = 1
            while v2 <= #Cs do
                v1 = Cs[v2]
                WCall(v1.Cb, ...)
                if Cs[v2] == v1 then
                    v2 = v2 + 1
                end
            end
        end,
        Invoke = function(a1, ...) -- Line: 305
            local Cs = a1.Cs
            if #Cs >= 1 then
                return Cs[1].Cb(...)
            end
            error("Invoke")
        end,
        Connect = function(a1, a2, a3) -- Line: 234 -- upvalues: u15 (val), FindRight (val) -- types: a2: function, a3: number?
            local v1 = true
            if a3 ~= nil then
                v1 = false
                if type(a3) == "number" then
                    v1 = a3 == a3
                end
            end
            assert(v1)
            local v2 = a3 or (1 / 0)
            local v3 = {Ow = a1, Cb = a2, Pr = v2, Wt = {}}
            v1 = setmetatable(v3, u15)
            if v2 == (1 / 0) then
                table.insert(a1.Cs, v1)
                return v1
            end
            local Cs_2 = a1.Cs
            table.insert(Cs_2, math.abs((FindRight(Cs_2, v1))), v1)
            return v1
        end,
        Wait = function(a1) -- Line: 316 -- upvalues: Connection_Disconnect (val), u15 (val)
            local u2 = coroutine.running()
            local u3 = true
            local u4 = nil
            assert(true)
            local v1 = {
                Pr = (1 / 0),
                Ow = a1,
                Cb = function(...) -- Line: 320 -- upvalues: u4 (ref), u2 (val), u3 (ref), Connection_Disconnect (upval)
                    local v1 = table.find(u4.Wt, u2)
                    if v1 then
                        table.remove(u4.Wt, v1)
                    end
                    u3 = false
                    Connection_Disconnect(u4)
                    task.spawn(u2, ...)
                end,
                Wt = {},
            }
            local v2 = setmetatable(v1, u15)
            table.insert(a1.Cs, v2)
            table.insert(v2.Wt, u2)
            local v3 = table.pack(coroutine.yield())
            if u3 then
                error("Disconnected")
            end
            return (table.unpack(v3))
        end,
        Once = function(a1, a2, a3) -- Line: 337
            -- upvalues: Connection_Disconnect (val), u15 (val), FindRight (val)
            local u3 = nil
            local v1 = true
            if a3 ~= nil then
                v1 = false
                if type(a3) == "number" then
                    v1 = a3 == a3
                end
            end
            assert(v1)
            local v2 = a3 or (1 / 0)
            local v3 = {
                Ow = a1,
                Cb = function(...) -- Line: 343 -- upvalues: Connection_Disconnect (upval), u3 (ref), a2 (val)
                    Connection_Disconnect(u3)
                    return a2(...)
                end,
                Pr = v2,
                Wt = {},
            }
            v1 = setmetatable(v3, u15)
            if v2 ~= (1 / 0) then
                local Cs_2 = a1.Cs
                table.insert(Cs_2, math.abs((FindRight(Cs_2, v1))), v1)
            else
                table.insert(a1.Cs, v1)
            end
            return v1
        end,
        DisconnectAll = function(a1) -- Line: 350 -- upvalues: Connection_Disconnect (val)
            local Cs = a1.Cs
            for i = #Cs, 1, -1 do
                Connection_Disconnect(Cs[i])
            end
        end,
        GetSize = function(a1) -- Line: 357
            return #a1.Cs
        end,
        IsEmpty = function(a1) -- Line: 361
            return #a1.Cs == 0
        end,
    }),
})
return table.freeze({
    new = function(a1) -- Line: 379 -- upvalues: u35 (val) -- types: a1: function?
        return (table.freeze((setmetatable({Cs = {}}, u35))))
    end,
    IsA = function(a1) -- Line: 386 -- upvalues: u35 (val)
        local v1 = false
        if type(a1) == "table" then
            v1 = (getmetatable(a1)) == u35
        end
        return v1
    end,
    Assert = function(a1) -- Line: 390 -- upvalues: u35 (val)
        local v1 = false
        if type(a1) == "table" then
            v1 = (getmetatable(a1)) == u35
        end
        if not v1 then
            error("Bindable", 2)
        end
        return a1
    end,
    IsAConnection = function(a1) -- Line: 222 -- upvalues: u15 (val)
        local v1 = false
        if type(a1) == "table" then
            v1 = (getmetatable(a1)) == u15
        end
        return v1
    end,
    AssertConnection = function(a1) -- Line: 226 -- upvalues: u15 (val)
        local v1 = false
        if type(a1) == "table" then
            v1 = (getmetatable(a1)) == u15
        end
        if not v1 then
            error("Connection", 2)
        end
        return a1
    end,
})