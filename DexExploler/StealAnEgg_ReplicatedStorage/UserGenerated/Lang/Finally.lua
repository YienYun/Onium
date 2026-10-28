-- Script path: ReplicatedStorage.UserGenerated.Lang.Finally
-- Decompile time: 0.69 ms

local function ErrorHandler(a1) -- Line: 20
    warn((("%*\nStack Begin\n%*Stack End"):format(tostring(a1), (debug.traceback(nil, 3)))))
end

local function Handle(a1, a2, ...) -- Line: 24 -- upvalues: ErrorHandler (val) -- types: a1: function, a2: boolean
    xpcall(a1, ErrorHandler)
    if not a2 then
        error((select(1, ...)))
    end
    return ...
end

return function(a1, a2, ...) -- Line: 32 -- upvalues: Handle (val), ErrorHandler (val) -- types: a1: function, a2: function
    local v1 = Handle
    local success = xpcall(a1, ErrorHandler, ...)
    return v1(a2, success)
end