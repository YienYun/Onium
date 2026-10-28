-- Script path: ReplicatedStorage.CmdrClient.Types.JSON
-- Decompile time: 0.46 ms

local HttpService = game:GetService("HttpService")
return function(a1) -- Line: 3 -- upvalues: HttpService (val)
    a1:RegisterType("json", {
        Validate = function(a1) -- Line: 5 -- upvalues: HttpService (upval)
            local v1 = HttpService
            local success = pcall(HttpService.JSONDecode, v1, a1)
            return success
        end,
        Parse = function(a1) -- Line: 9 -- upvalues: HttpService (upval)
            return HttpService:JSONDecode(a1)
        end,
    })
end