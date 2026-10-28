-- Script path: ReplicatedStorage.UserGenerated.Lang.WCall
-- Decompile time: 0.37 ms

local function ErrorHandler(a1) -- Line: 20
    warn((("%*\nStack Begin\n%*Stack End"):format(tostring(a1), (debug.traceback(nil, 3)))))
end

return function(a1, ...) -- Line: 24 -- upvalues: ErrorHandler (val) -- types: a1: function
    local success = xpcall(a1, ErrorHandler, ...)
    return success
end