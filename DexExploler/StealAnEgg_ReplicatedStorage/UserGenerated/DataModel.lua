-- Script path: ReplicatedStorage.UserGenerated.DataModel
-- Decompile time: 9.53 ms

local result
local RunService = game:GetService("RunService")
local Encode = require(script.Encode)
local Reflection = require(script.Reflection)
_, result = xpcall(function() -- Line: 49
    return workspace[nil]
end, function() -- Line: 51
    return debug.info(2, "f")
end)
local v1 = result
if type(v1) ~= "function" then
    function result(a1, a2) -- Line: 55
        return a1[a2]
    end
end
local u22 = {
    "Workspace",
    "Players",
    "Lighting",
    "MaterialService",
    "ReplicatedFirst",
    "ReplicatedStorage",
    "SoundService",
    "StarterGui",
    "StarterPack",
    "StarterPlayer",
    "Teams",
    "TextChatService",
}
local u35 = {"ServerScriptService", "ServerStorage"}

local function encodeId(a1) -- Line: 92 -- types: a1: number
    local v1 = {}
    local v2 = a1
    repeat
        v1[#v1 + 1] = (string.char(v2 % 256))
        v2 = v2 // 256
    until v2 == 0
    return table.concat(v1)
end

return {
    capture = function(a1, a2) -- Line: 103
        -- upvalues: encodeId (val), u22 (val), RunService (val), u35 (val), Encode (val), result (ref)
        -- upvalues: Reflection (val)
        local err_2, err_3, err_4, err_5, err_6, len, success, success_2, success_3, success_4, success_5, success_6, v1, v2, v3, v4, v5, v6, v7
        local v8 = a1 or {}
        local v9 = v8.properties == true
        local v10 = v8.yielding ~= false
        local v11 = (if not a2 then 0.016666666666666666 else if not (a2 > 0) then 0.016666666666666666 else a2) * 0.33
        local v12 = os.clock() + 30
        local u450 = {}
        local u351 = {}

        local function classIdx(a1) -- Line: 114 -- upvalues: u351 (val), u450 (val) -- types: a1: string
            local v1 = u351[a1]
            if v1 then
                return v1
            end
            v1 = #u450
            u450[v1 + 1] = a1
            u351[a1] = v1
            return v1
        end

        local u460 = {}
        local u465 = {}

        local function propIdx(a1) -- Line: 127 -- upvalues: u465 (val), u460 (val) -- types: a1: string
            local v1 = u465[a1]
            if v1 then
                return v1
            end
            v1 = #u460
            u460[v1 + 1] = a1
            u465[a1] = v1
            return v1
        end

        local u362 = {}
        local u488 = 0
        local u480 = {}

        local function assign(a1) -- Line: 144
            -- upvalues: u362 (val), u488 (ref), encodeId (upval), u480 (val)
            local v1 = u362[a1]
            if v1 then
                return v1
            end
            u488 = u488 + 1
            v1 = encodeId(u488)
            u362[a1] = v1
            u480[#u480 + 1] = a1
            return v1
        end

        local v13 = game
        if not u362[v13] then
            u488 = u488 + 1
            u362[v13] = (encodeId(u488))
            u480[#u480 + 1] = v13
        end
        v13 = table.clone(u22)
        if RunService:IsServer() then
            for i, j in u35 do
                table.insert(v13, j)
            end
        end
        local v14 = nil
        local v15 = nil
        for k, n in v13, v14, v15 do
            success_5, err = pcall(function() -- Line: 165 -- upvalues: n (val)
                return game:GetService(n)
            end)
            if success_5 and err then
                if not u362[err] then
                    u488 = u488 + 1
                    u362[err] = (encodeId(u488))
                    u480[#u480 + 1] = err
                end
                success_6, err_6 = pcall(function() -- Line: 172 -- upvalues: err (val)
                    return err:GetDescendants()
                end)
                if success_6 and err_6 then
                    for m, i5 in err_6 do
                        if not u362[i5] then
                            u488 = u488 + 1
                            u362[i5] = (encodeId(u488))
                            u480[#u480 + 1] = i5
                        end
                    end
                end
            end
        end
        v13 = Encode.newWriter(262144)
        v13:u8(68)
        v13:u8(1)
        v13:u8(if not v9 then 0 else 1)
        local v16 = 0
        local v17 = os.clock()
        v14 = false
        local v18 = nil
        local v19 = nil
        for i6, i7 in u480, v18, v19 do
            v1 = ""
            if i7 ~= game then
                success, err_2 = pcall(result, i7, "Parent")
                if success and err_2 ~= nil then
                    v1 = u362[err_2] or ""
                    if v1 ~= "" then
                        success_2, err_3 = pcall(result, i7, "ClassName")
                        if success_2 and type(err_3) == "string" then
                            success_3, err_4 = pcall(result, i7, "Name")
                            if not success_3 or type(err_4) ~= "string" then
                                err_4 = err_3
                            end
                            v13:strU8(u362[i7])
                            v13:strU8(v1)
                            v6 = u351[err_3]
                            if not v6 then
                                v6 = #u450
                                u450[v6 + 1] = err_3
                                u351[err_3] = v6
                            end
                            v13:u16(v6)
                            v13:strU16(err_4)
                            if v9 then
                                v4 = Reflection.getReadProperties(err_3)
                                len = v13.len
                                v13:u16(0)
                                v2 = 0
                                v5 = nil
                                v6 = nil
                                for i8, i9 in v4, v5, v6 do
                                    success_4, err_5 = pcall(result, i7, i9)
                                    if success_4 then
                                        v7 = u465[i9]
                                        if not v7 then
                                            v7 = #u460
                                            u460[v7 + 1] = i9
                                            u465[i9] = v7
                                        end
                                        v13:u16(v7)
                                        Encode.writeValue(v13, err_5)
                                        v2 = v2 + 1
                                    end
                                end
                                v13:patchU16(len, v2)
                            end
                            v16 = v16 + 1
                            if 50331648 <= v13.len then
                                v14 = true
                                break
                            end
                            if v10 and v16 >= 20 then
                                v3 = os.clock()
                                if v12 <= v3 then
                                    return {TimedOut = true}
                                end
                                if v11 <= v3 - v17 then
                                    task.wait()
                                    v17 = os.clock()
                                    v16 = 0
                                end
                            end
                        end
                    end
                end
                continue
            end
            success_2, err_3 = pcall(result, i7, "ClassName")
            if success_2 and type(err_3) == "string" then
                success_3, err_4 = pcall(result, i7, "Name")
                if not success_3 or type(err_4) ~= "string" then
                    err_4 = err_3
                end
                v13:strU8(u362[i7])
                v13:strU8(v1)
                v6 = u351[err_3]
                if not v6 then
                    v6 = #u450
                    u450[v6 + 1] = err_3
                    u351[err_3] = v6
                end
                v13:u16(v6)
                v13:strU16(err_4)
                if v9 then
                    v4 = Reflection.getReadProperties(err_3)
                    len = v13.len
                    v13:u16(0)
                    v2 = 0
                    v5 = nil
                    v6 = nil
                    for i10, i11 in v4, v5, v6 do
                        success_4, err_5 = pcall(result, i7, i11)
                        if success_4 then
                            v7 = u465[i11]
                            if not v7 then
                                v7 = #u460
                                u460[v7 + 1] = i11
                                u465[i11] = v7
                            end
                            v13:u16(v7)
                            Encode.writeValue(v13, err_5)
                            v2 = v2 + 1
                        end
                    end
                    v13:patchU16(len, v2)
                end
                v16 = v16 + 1
                if 50331648 <= v13.len then
                    v14 = true
                    break
                end
                if v10 and v16 >= 20 then
                    v3 = os.clock()
                    if v12 <= v3 then
                        return {TimedOut = true}
                    end
                    if v11 <= v3 - v17 then
                        task.wait()
                        os.clock()
                    end
                end
            end
        end
        return {Buffer = v13:finish(), Classes = u450, Props = u460, Truncated = v14}
    end,
}