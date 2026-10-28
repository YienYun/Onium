-- Script path: ReplicatedStorage.UserGenerated.IO.LibDeflate
-- Decompile time: 120.57 ms

local v1, v2, v3, v4, v5, v6
local u1429 = {}
local byte = string.byte
local char = string.char
local find = string.find
local gsub = string.gsub
local sub = string.sub
local concat = table.concat
local sort = table.sort
local u675 = {}
local u1359 = {}
local u757 = {}
local u793 = {}
local u812 = {}
local u801 = {}
local u522 = {}
local u538 = {}
local u540 = {}
local u991 = {
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    13,
    15,
    17,
    19,
    23,
    27,
    31,
    35,
    43,
    51,
    59,
    67,
    83,
    99,
    115,
    131,
    163,
    195,
    227,
    258,
}
local u860 = {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0}
local u1014 = {
    [0] = 1,
    2,
    3,
    4,
    5,
    7,
    9,
    13,
    17,
    25,
    33,
    49,
    65,
    97,
    129,
    193,
    257,
    385,
    513,
    769,
    1025,
    1537,
    2049,
    3073,
    4097,
    6145,
    8193,
    12289,
    16385,
    24577,
}
local u1037 = {
    [0] = 0,
    0,
    0,
    0,
    1,
    1,
    2,
    2,
    3,
    3,
    4,
    4,
    5,
    5,
    6,
    6,
    7,
    7,
    8,
    8,
    9,
    9,
    10,
    10,
    11,
    11,
    12,
    12,
    13,
    13,
}
local u836 = {16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15}
local u909 = {}
local u1085 = {}
local u885 = {}
local u1062 = {}
local u932 = {}
local u1131 = {}
local u1108 = {}
for i = 0, 255 do
    u1359[i] = (char(i))
end
local v7 = 1
for j = 0, 32 do
    u675[j] = v7
    v7 = v7 * 2
end
for k = 1, 9 do
    u757[k] = {}
    v1 = u675[k + 1] - 1
    for n = 0, v1 do
        v2 = 0
        v3 = n
        v4 = k
        for m = 1, v4 do
            v6 = v2 - v2 % 2
            v2 = v6 + (if v2 % 2 == 1 then 1 else if v3 % 2 ~= 1 then 0 else 1)
            v3 = (v3 - v3 % 2) / 2
            v2 = v2 * 2
        end
        u757[k][n] = (v2 - v2 % 2) / 2
    end
end
v7 = 18
local v8 = 16
local v9 = 265
v1 = 1
for i5 = 3, 258 do
    if i5 <= 10 then
        u793[i5] = i5 + 254
        u801[i5] = 0
    elseif i5 ~= 258 then
        if v7 < i5 then
            v7 = v7 + v8
            v8 = v8 * 2
            v9 = v9 + 4
            v1 = v1 + 1
        end
        v3 = i5 - v7 - 1 + v8 / 2
        v5 = v3 - v3 % (v8 / 8)
        u793[i5] = v5 / (v8 / 8) + v9
        u801[i5] = v1
        u812[i5] = v3 % (v8 / 8)
    else
        u793[i5] = 285
        u801[i5] = 0
    end
end
u522[1] = 0
u522[2] = 1
u540[1] = 0
u540[2] = 0
v7 = 3
v8 = 4
v9 = 2
v1 = 0
for i6 = 3, 256 do
    if v8 < i6 then
        v7 = v7 * 2
        v8 = v8 * 2
        v9 = v9 + 2
        v1 = v1 + 1
    end
    v3 = i6 <= v7 and v9 or v9 + 1
    u522[i6] = v3
    v3 = if not (v1 < 0) then v1 else 0
    u540[i6] = v3
    if v8 >= 8 then
        v4 = i6 - v8 / 2 - 1
        u538[i6] = v4 % (v8 / 4)
    end
end

function u1429.Adler32(a1, a2) -- Line: 444 -- upvalues: byte (val) -- types: a1: table, a2: string
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16
    if type(a2) ~= "string" then
        error(("Usage: LibDeflate:Adler32(str): 'str' - string expected got '%s'."):format((type(a2))), 2)
    end
    local v17 = #a2
    local v18 = 1
    local v19 = 1
    local v20 = 0
    while v18 <= v17 - 15 do
        v13, v14, v15, v16, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12 = byte(a2, v18, v18 + 15)
        v20 = (v20 + v19 * 16 + v13 * 16 + 15 * v14 + 14 * v15 + 13 * v16 + 12 * v1 + 11 * v2 + 10 * v3 + 9 * v4 + 8 * v5 + 7 * v6 + 6 * v7 + 5 * v8 + 4 * v9 + 3 * v10 + 2 * v11 + v12) % 65521
        v19 = (v19 + v13 + v14 + v15 + v16 + v1 + v2 + v3 + v4 + v5 + v6 + v7 + v8 + v9 + v10 + v11 + v12) % 65521
        v18 = v18 + 16
    end
    while v18 <= v17 do
        v19 = (v19 + byte(a2, v18, v18)) % 65521
        v20 = (v20 + v19) % 65521
        v18 = v18 + 1
    end
    return (v20 * 65536 + v19) % 4294967296
end

local function IsEqualAdler32(a1, a2) -- Line: 502 -- types: a1: number, a2: number
    return a1 % 4294967296 == a2 % 4294967296
end

function u1429.CreateDictionary(a1, a2, a3, a4) -- Line: 548
    -- upvalues: byte (val)
    if type(a2) ~= "string" then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): 'str' - string expected got '%s'."):format((type(a2))), 2)
    end
    if type(a3) ~= "number" then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): 'strlen' - number expected got '%s'."):format((type(a3))), 2)
    end
    if type(a4) ~= "number" then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): 'adler32' - number expected got '%s'."):format((type(a4))), 2)
    end
    if a3 ~= #a2 then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): 'strlen' does not match the actual length of 'str'. 'strlen': %u, '#str': %u . Please check if 'str' is modified unintentionally."):format(
            a3,
            #a2
        ))
    end
    if a3 == 0 then
        error("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): 'str' - Empty string is not allowed.", 2)
    end
    if a3 > 32768 then
        error(
            ("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): 'str' - string longer than 32768 bytes is not allowed. Got %d bytes."):format(a3),
            2
        )
    end
    local v1 = a1:Adler32(a2)
    if not (a4 % 4294967296 == v1 % 4294967296) then
        error(("Usage: LibDeflate:CreateDictionary(str, strlen, adler32): 'adler32' does not match the actual adler32 of 'str'. 'adler32': %u, 'Adler32(str)': %u . Please check if 'str' is modified unintentionally."):format(
            a4,
            v1
        ))
    end
    v1 = {adler32 = a4}
    v1.hash_tables = {}
    v1.string_table = {}
    v1.strlen = a3
    local string_table = v1.string_table
    local hash_tables = v1.hash_tables
    string_table[1] = (byte(a2, 1, 1))
    string_table[2] = (byte(a2, 2, 2))
    if a3 >= 3 then
        local v2, v3, v4, v5
        local v6 = 1
        local v7 = string_table[1] * 256 + string_table[2]
        local v8, v9 = a3, a2
        while v6 <= v8 - 2 - 3 do
            v5, v2, v3, v4 = byte(v9, v6 + 2, v6 + 5)
            string_table[v6 + 2] = v5
            string_table[v6 + 3] = v2
            string_table[v6 + 4] = v3
            string_table[v6 + 5] = v4
            v7 = (v7 * 256 + v5) % 16777216
            v5 = hash_tables[v7]
            if not v5 then
                hash_tables[v7] = {}
            end
            v5[#v5 + 1] = v6 - v8
            v6 = v6 + 1
            v7 = (v7 * 256 + v2) % 16777216
            v5 = hash_tables[v7]
            if not v5 then
                hash_tables[v7] = {}
            end
            v5[#v5 + 1] = v6 - v8
            v6 = v6 + 1
            v7 = (v7 * 256 + v3) % 16777216
            v5 = hash_tables[v7]
            if not v5 then
                hash_tables[v7] = {}
            end
            v5[#v5 + 1] = v6 - v8
            v6 = v6 + 1
            v7 = (v7 * 256 + v4) % 16777216
            v5 = hash_tables[v7]
            if not v5 then
                hash_tables[v7] = {}
            end
            v5[#v5 + 1] = v6 - v8
            v6 = v6 + 1
        end
        while v6 <= v8 - 2 do
            v5 = byte(v9, v6 + 2)
            string_table[v6 + 2] = v5
            v7 = (v7 * 256 + v5) % 16777216
            v5 = hash_tables[v7]
            if not v5 then
                hash_tables[v7] = {}
            end
            v5[#v5 + 1] = v6 - v8
            v6 = v6 + 1
        end
    end
    return v1
end

local function IsValidDictionary(a1) -- Line: 674 -- types: a1: table?
    if a1 ~= nil and type(a1) == "table" then
        if type(a1.adler32) == "number"
            and type(a1.string_table) == "table"
            and type(a1.strlen) == "number"
            and not (a1.strlen <= 0)
            and not (32768 < a1.strlen)
            and a1.strlen == #a1.string_table
            and type(a1.hash_tables) == "table" then
            return true, ""
        end
        return false, ("'%s' - corrupted dictionary."):format((type(a1)))
    end
    return false, ("'dictionary' - table expected got '%s'."):format((type(a1)))
end

local u601 = {
    [0] = {false, nil, 0, 0, 0},
    {false, nil, 4, 8, 4},
    {false, nil, 5, 18, 8},
    {false, nil, 6, 32, 32},
    {true, 4, 4, 16, 16},
    {true, 8, 16, 32, 32},
    {true, 8, 16, 128, 128},
    {true, 8, 32, 128, 256},
    {true, 32, 128, 258, 1024},
    {true, 32, 258, 258, 4096},
}

local function IsValidArguments(a1, a2, a3, a4, a5) -- Line: 754
    -- upvalues: IsValidDictionary (val), u601 (val)
    local v1
    if type(a1) ~= "string" then
        return false, ("'str' - string expected got '%s'."):format((type(a1)))
    end
    if a2 then
        local v2
        v1, v2 = IsValidDictionary(a3)
        if not v1 then
            return false, v2
        end
    end
    if a4 then
        v1 = type(a5)
        if v1 ~= "nil" and v1 ~= "table" then
            return false, ("'configs' - nil or table expected got '%s'."):format((type(a5)))
        end
        if v1 == "table" then
            assert(a5)
            for k, v in pairs(a5) do
                if k ~= "level" and k ~= "strategy" then
                    return false, ("'configs' - unsupported table key in the configs: '%s'."):format(k)
                end
                if k == "level" and not u601[v] then
                    return false, ("'configs' - unsupported 'level': %s."):format((tostring(v)))
                end
                if k == "strategy" and v ~= "fixed" and v ~= "huffman_only" and v ~= "dynamic" then
                    return false, ("'configs' - unsupported 'strategy': '%s'."):format((tostring(v)))
                end
            end
        end
    end
    return true, ""
end

local function CreateWriter() -- Line: 817 -- upvalues: u675 (val), u1359 (val), char (val), concat (val)
    local u0 = 0
    local u1 = 0
    local u2 = 0
    local u3 = 0
    local u4 = {}
    local u5 = {}
    return function(a1, a2) -- Line: 830
        -- upvalues: u1 (ref), u675 (upval), u2 (ref), u3 (ref), u0 (ref), u4 (ref), u1359 (upval)
        u1 = u1 + a1 * u675[u2]
        u2 = u2 + a2
        u3 = u3 + a2
        if u2 >= 32 then
            u0 = u0 + 1
            local v1 = u0
            u4[v1] = u1359[u1 % 256] .. u1359[(u1 - u1 % 256) / 256 % 256] .. u1359[(u1 - u1 % 65536) / 65536 % 256] .. u1359[(u1 - u1 % 16777216) / 16777216 % 256]
            local v2 = u675[32 - u2 + a2]
            u1 = (a1 - a1 % v2) / v2
            u2 = u2 - 32
        end
    end, function(a1) -- Line: 850
        -- upvalues: u2 (ref), u0 (ref), u4 (ref), u1 (ref), char (upval), u3 (ref)
        local v1, v2, v3
        local v4 = u2
        for i = 1, v4, 8 do
            u0 = u0 + 1
            v1 = u4
            v2 = u0
            v3 = u1 % 256
            v1[v2] = (char(v3))
            u1 = (u1 - u1 % 256) / 256
        end
        u2 = 0
        u0 = u0 + 1
        u4[u0] = a1
        u3 = u3 + #a1 * 8
    end, function(a1) -- Line: 869
        -- upvalues: u3 (ref), u2 (ref), u1 (ref), u675 (upval), u0 (ref), u4 (ref), u1359 (upval), concat (upval)
        -- upvalues: u5 (val)
        local v1
        if a1 == 3 then
            return u3, nil
        end
        if a1 ~= 1 and a1 ~= 2 then
            v1 = concat(u4)
            u4 = {}
            u0 = 0
            u5[#u5 + 1] = v1
            if a1 == 0 then
                return u3, nil
            end
            return u3, concat(u5)
        end
        v1 = (8 - u2 % 8) % 8
        if u2 > 0 then
            u1 = u1 - u675[u2] + u675[u2 + v1]
            local v2 = u2
            for i = 1, v2, 8 do
                u0 = u0 + 1
                u4[u0] = u1359[u1 % 256]
                u1 = (u1 - u1 % 256) / 256
            end
            u1 = 0
            u2 = 0
        end
        if a1 == 2 then
            u3 = u3 + v1
            return u3, nil
        end
        v1 = concat(u4)
        u4 = {}
        u0 = 0
        u5[#u5 + 1] = v1
        if a1 == 0 then
            return u3, nil
        end
        return u3, concat(u5)
    end
end

local function MinHeapPush(a1, a2, a3) -- Line: 922 -- types: a1: table, a2: table, a3: number
    local v1
    local v2 = a3 + 1
    a1[v2] = a2
    local v3 = a2[1]
    local v4 = v2
    local v5 = (v4 - v4 % 2) / 2
    while v5 >= 1 do
        if not (v3 < a1[v5][1]) then
            break
        end
        v1 = a1[v5]
        a1[v5] = a2
        a1[v4] = v1
        v5 = (v5 - v5 % 2) / 2
    end
end

local function MinHeapPop(a1, a2) -- Line: 943 -- types: a1: table, a2: number
    local v1, v2
    local v3 = a1[1]
    local v4 = a1[a2]
    local v5 = v4[1]
    a1[1] = v4
    a1[a2] = v3
    local v6 = a2 - 1
    local v7 = 1
    local v8 = v7 * 2
    local v9 = v8 + 1
    local v10 = a1
    while v8 <= v6 do
        v1 = v10[v8]
        if v9 <= v6 then
            v2 = v10[v9][1]
            if v2 < v1[1] then
                v2 = v10[v9]
                if not (v2[1] < v5) then
                    break
                end
                v10[v9] = v4
                v10[v7] = v2
                v8 = v9 * 2
                v9 = v8 + 1
                continue
            end
        end
        if not (v1[1] < v5) then
            break
        end
        v10[v8] = v4
        v10[v7] = v1
        v8 = v8 * 2
        v9 = v8 + 1
    end
    return v3
end

local function GetHuffmanCodeFromBitlen(a1, a2, a3, a4) -- Line: 992
    -- upvalues: u757 (val)
    local v1, v2, v3
    local v4 = 0
    local v5 = {}
    local v6 = {}
    for i = 1, a4 do
        v4 = (v4 + (a1[i - 1] or 0)) * 2
        v5[i] = v4
    end
    for j = 0, a3 do
        v1 = a2[j]
        if v1 then
            v4 = v5[v1]
            v5[v1] = v4 + 1
            if not (v1 <= 9) then
                v2 = 0
                for k = 1, v1 do
                    v3 = v2 - v2 % 2
                    v2 = v3 + (if v2 % 2 == 1 then 1 else if v4 % 2 ~= 1 then 0 else 1)
                    v4 = (v4 - v4 % 2) / 2
                    v2 = v2 * 2
                end
                v6[j] = (v2 - v2 % 2) / 2
            else
                v6[j] = u757[v1][v4]
            end
        end
    end
    return v6
end

local function SortByFirstThenSecond(a1, a2) -- Line: 1034 -- types: a1: table, a2: table
    local v1 = true
    if not (a1[1] < a2[1]) then
        v1 = false
        if a1[1] == a2[1] then
            v1 = a1[2] < a2[2]
        end
    end
    return v1
end

local function GetHuffmanBitlenAndCode(a1, a2, a3) -- Line: 1049
    -- upvalues: sort (val), SortByFirstThenSecond (val), MinHeapPop (val), MinHeapPush (val)
    -- upvalues: GetHuffmanCodeFromBitlen (val)
    local v1, v2, v3, v4, v5, v6, v7
    local v8 = -1
    local v9 = {}
    local v10 = {}
    local v11 = {}
    local v12 = {}
    local v13 = {}
    local v14 = 0
    for k, v in pairs(a1) do
        v14 = v14 + 1
        v9[v14] = {v, k}
    end
    if v14 == 0 then
        return {}, {}, -1
    end
    if v14 == 1 then
        v1 = v9[1][2]
        v11[v1] = 1
        v12[v1] = 0
        return v11, v12, v1
    end
    sort(v9, SortByFirstThenSecond)
    local v15 = v14
    v1 = v15
    for i = 1, v1 do
        v10[i] = v9[i]
    end
    while v15 > 1 do
        v1 = MinHeapPop(v10, v15)
        v15 = v15 - 1
        v2 = MinHeapPop(v10, v15)
        v15 = v15 - 1
        MinHeapPush(v10, {v1[1] + v2[1], -1, v1, v2}, v15)
        v15 = v15 + 1
    end
    v1 = 0
    v2 = {}
    v2[1] = v10[1]
    v2[2] = {}
    v2[3] = {}
    v2[4] = {}
    local v16 = 1
    local v17 = 1
    v10[1][1] = 0
    local v18, v19 = a2, a3
    while v17 <= v16 do
        v3 = v2[v17]
        v4 = v3[1]
        v5 = v3[2]
        v6 = v3[3]
        v7 = v3[4]
        if v6 then
            v16 = v16 + 1
            v2[v16] = v6
            v6[1] = v4 + 1
        end
        if v7 then
            v16 = v16 + 1
            v2[v16] = v7
            v7[1] = v4 + 1
        end
        v17 = v17 + 1
        if v18 < v4 then
            v1 = v1 + 1
            v4 = v18
        end
        if v5 >= 0 then
            v11[v5] = v4
            v8 = v8 < v5 and v5 or v8
            v13[v4] = (v13[v4] or 0) + 1
        end
    end
    if v1 > 0 then
        repeat
            v16 = v18 - 1
            while (v13[v16] or 0) == 0 do
                v16 = v16 - 1
            end
            v13[v16] = v13[v16] - 1
            v13[v16 + 1] = (v13[v16 + 1] or 0) + 2
            v13[v18] = v13[v18] - 1
            v1 = v1 - 2
        until v1 <= 0
        v17 = 1
        for j = v18, 1, -1 do
            v2 = v13[j] or 0
            while v2 > 0 do
                v11[v9[v17][2]] = j
                v2 = v2 - 1
                v17 = v17 + 1
            end
        end
    end
    return v11, (GetHuffmanCodeFromBitlen(v13, v11, v19, v18)), v8
end

local function RunLengthEncodeHuffmanBitlen(a1, a2, a3, a4) -- Line: 1187
    -- upvalues: 
    local v1, v2, v3
    local v4 = 0
    local v5 = {}
    local v6 = {}
    local v7 = 0
    local v8 = {}
    local v9 = nil
    local v10 = 0
    local v11 = a2 + (if not (a4 < 0) then a4 else 0) + 1
    local v12 = v11 + 1
    local v13, v14, v15 = a2, a1, a3
    for i = 0, v12 do
        v1 = if not (i <= v13) then if not (i <= v11) then nil else v15[i - v13 - 1] or 0 else v14[i] or 0
        if v1 ~= v9 then
            if v10 == 1 then
                assert(v9)
                v4 = v4 + 1
                v5[v4] = v9
                v6[v9] = (v6[v9] or 0) + 1
            elseif v10 == 2 then
                assert(v9)
                v4 = v4 + 1
                v5[v4] = v9
                v4 = v4 + 1
                v5[v4] = v9
                v6[v9] = (v6[v9] or 0) + 2
            elseif v10 >= 3 then
                v4 = v4 + 1
                v5[v4] = if v9 == 0 then if not (v10 <= 10) then 18 else 17 else 16
                v6[v2] = (v6[v2] or 0) + 1
                v7 = v7 + 1
                v3 = v10 <= 10 and v10 - 3 or v10 - 11
                v8[v7] = v3
            end
            if v1 and v1 ~= 0 then
                v4 = v4 + 1
                v5[v4] = v1
                v6[v1] = (v6[v1] or 0) + 1
            end
        else
            v10 = v10 + 1
            if v1 == 0 then
                if v1 == 0 and v10 == 138 then
                    v4 = v4 + 1
                    v5[v4] = 18
                    v7 = v7 + 1
                    v8[v7] = 127
                    v6[18] = (v6[18] or 0) + 1
                end
            elseif v10 == 6 then
                v4 = v4 + 1
                v5[v4] = 16
                v7 = v7 + 1
                v8[v7] = 3
                v6[16] = (v6[16] or 0) + 1
            elseif v1 == 0 and v10 == 138 then
                v4 = v4 + 1
                v5[v4] = 18
                v7 = v7 + 1
                v8[v7] = 127
                v6[18] = (v6[18] or 0) + 1
            end
        end
    end
    return v5, v8, v6
end

local function LoadStringToTable(a1, a2, a3, a4, a5) -- Line: 1272
    -- upvalues: byte (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31
    local v32 = a3 - a5
    while v32 <= a4 - 15 - a5 do
        v28 = v32 + 1
        v29 = v32 + 2
        v30 = v32 + 3
        v31 = v32 + 4
        v1 = v32 + 5
        v2 = v32 + 6
        v3 = v32 + 7
        v4 = v32 + 8
        v5 = v32 + 9
        v6 = v32 + 10
        v7 = v32 + 11
        v8 = v32 + 12
        v9 = v32 + 13
        v10 = v32 + 14
        v11 = v32 + 15
        v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27 = byte(a1, v32 + a5, v32 + 15 + a5)
        a2[v32] = v12
        a2[v28] = v13
        a2[v29] = v14
        a2[v30] = v15
        a2[v31] = v16
        a2[v1] = v17
        a2[v2] = v18
        a2[v3] = v19
        a2[v4] = v20
        a2[v5] = v21
        a2[v6] = v22
        a2[v7] = v23
        a2[v8] = v24
        a2[v9] = v25
        a2[v10] = v26
        a2[v11] = v27
        v32 = v32 + 16
    end
    while v32 <= a4 - a5 do
        a2[v32] = (byte(a1, v32 + a5, v32 + a5))
        v32 = v32 + 1
    end
    return a2
end

local function GetBlockLZ77Result(a1, a2, a3, a4, a5, a6, a7) -- Line: 1328
    -- upvalues: u601 (val), u793 (val), u801 (val), u522 (val), u538 (val), u540 (val), u812 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17
    local v18 = u601[a1]
    local v19 = v18[1]
    local v20 = v18[2]
    local v21 = v18[3]
    local v22 = v18[4]
    local v23 = v18[5]
    v18 = not v19 and v21 or 2147483646
    local v24 = v23 - v23 % 4 / 4
    local hash_tables = {}
    local string_table = {}
    local strlen = 0
    if a7 then
        hash_tables = a7.hash_tables
        string_table = a7.string_table
        strlen = a7.strlen
        assert(a4 == 1)
        if a4 <= a5 and strlen >= 2 then
            v1 = string_table[strlen - 1] * 65536 + string_table[strlen] * 256 + a2[1]
            v2 = a3[v1]
            if not v2 then
                a3[v1] = {}
            end
            v2[#v2 + 1] = -1
        end
        if a4 + 1 <= a5 and strlen >= 1 then
            v1 = string_table[strlen] * 65536 + a2[1] * 256 + a2[2]
            v2 = a3[v1]
            if not v2 then
                a3[v1] = {}
            end
            v2[#v2 + 1] = 0
        end
    end
    v2 = strlen + 3
    v1 = (a2[a4 - a6] or 0) * 256 + (a2[a4 + 1 - a6] or 0)
    local v25 = {}
    local v26 = 0
    local v27 = {}
    local v28 = {}
    local v29 = 0
    local v30 = {}
    local v31 = {}
    local v32 = 0
    local v33 = {}
    local v34 = 0
    local v35 = false
    local v36 = 0
    local v37 = 0
    local v38 = a4
    local v39 = a5 + (if not v19 then 0 else 1)
    while v38 <= v39 do
        v5 = v38 - a6
        v6 = a6 - 3
        v3 = v36
        v4 = v37
        v36 = 0
        v1 = (v1 * 256 + (a2[v5 + 2] or 0)) % 16777216
        v8 = nil
        v9 = a3[v1]
        if v9 then
            v10 = #v9
            v8 = v9
            v7 = v10
        else
            v10 = 0
            a3[v1] = {}
            if not hash_tables then
                v7 = 0
            else
                v8 = hash_tables[v1]
                v7 = v8 and #v8 or 0
            end
        end
        if v38 <= a5 then
            v9[v10 + 1] = v38
        end
        if v7 > 0 and v38 + 2 <= a5 then
            if not v19 or v3 < v21 then
                v10 = v19 and v20 <= v3 and v24 or v23
                v11 = a5 - v38
                v11 = (if not (v11 >= 257) then v11 else 257) + v5
                v12 = v5 + 3
                while v7 >= 1 do
                    if not (v10 > 0) then
                        break
                    end
                    v13 = v8[v7]
                    if 32768 < v38 - v13 then
                        break
                    end
                    if v13 < v38 then
                        v14 = v12
                        if not (v13 >= -257) then
                            v15 = v2 + v13
                            while v14 <= v11 do
                                if string_table[v15] ~= a2[v14] then
                                    break
                                end
                                v14 = v14 + 1
                                v15 = v15 + 1
                            end
                        else
                            v15 = v13 - v6
                            while v14 <= v11 do
                                if a2[v15] ~= a2[v14] then
                                    break
                                end
                                v14 = v14 + 1
                                v15 = v15 + 1
                            end
                        end
                        v15 = v14 - v5
                        if v36 < v15 then
                            v36 = v15
                            v37 = v38 - v13
                        end
                        if v22 <= v36 then
                            break
                        end
                    end
                    v7 = v7 - 1
                    v10 = v10 - 1
                    if v7 == 0 and v13 > 0 and hash_tables then
                        v8 = hash_tables[v1]
                        v7 = v8 and #v8 or 0
                    end
                end
            end
        end
        if not v19 then
            v3 = v36
            v4 = v37
        end
        if not v19 then
            if v3 > 3 then
                if v36 <= v3 then
                    v8 = u793[v3]
                    v7 = u801[v3]
                    if not (v4 <= 256) then
                        v11 = 16
                        v12 = 7
                        v6 = 384
                        v14 = 512
                        while not (v4 <= v6) do
                            if not (v4 <= v14) then
                                v11 = v11 + 2
                                v12 = v12 + 1
                                v6 = v6 * 2
                                v14 = v14 * 2
                                continue
                            else
                                v13 = (v4 - v14 / 2 - 1) % (v14 / 4)
                                v11 = v11 + 1
                            end
                            v26 = v26 + 1
                            v25[v26] = v8
                            v27[v8] = (v27[v8] or 0) + 1
                            v29 = v29 + 1
                            v28[v29] = v11
                            v30[v11] = (v30[v11] or 0) + 1
                            if v7 > 0 then
                                v11 = u812[v3]
                                v32 = v32 + 1
                                v31[v32] = v11
                            end
                            if v12 > 0 then
                                v34 = v34 + 1
                                v33[v34] = v13
                            end
                            v16 = v38 + 1
                            v17 = v38 + v3
                            v14 = v17 - (if not v19 then 1 else 2)
                            for m = v16, v14 do
                                v1 = (v1 * 256 + (a2[m - a6 + 2] or 0)) % 16777216
                                if v3 <= v18 then
                                    v9 = a3[v1]
                                    if not v9 then
                                        a3[v1] = {}
                                    end
                                    v9[#v9 + 1] = m
                                end
                            end
                            v14 = v38 + v3
                            v38 = v14 - (if not v19 then 0 else 1)
                            break
                        end
                        v13 = (v4 - v14 / 2 - 1) % (v14 / 4)
                    else
                        v11 = u522[v4]
                        v13 = u538[v4]
                        v12 = u540[v4]
                    end
                    v26 = v26 + 1
                    v25[v26] = v8
                    v27[v8] = (v27[v8] or 0) + 1
                    v29 = v29 + 1
                    v28[v29] = v11
                    v30[v11] = (v30[v11] or 0) + 1
                    if v7 > 0 then
                        v11 = u812[v3]
                        v32 = v32 + 1
                        v31[v32] = v11
                    end
                    if v12 > 0 then
                        v34 = v34 + 1
                        v33[v34] = v13
                    end
                    v16 = v38 + 1
                    v17 = v38 + v3
                    v14 = v17 - (if not v19 then 1 else 2)
                    for i5 = v16, v14 do
                        v1 = (v1 * 256 + (a2[i5 - a6 + 2] or 0)) % 16777216
                        if v3 <= v18 then
                            v9 = a3[v1]
                            if not v9 then
                                a3[v1] = {}
                            end
                            v9[#v9 + 1] = i5
                        end
                    end
                    v14 = v38 + v3
                    v38 = v14 - (if not v19 then 0 else 1)
                else
                    if not v19 or v35 then
                        v11 = a2[v19 and v5 - 1 or v5]
                        v26 = v26 + 1
                        v25[v26] = v11
                        v27[v11] = (v27[v11] or 0) + 1
                    end
                    v38 = v38 + 1
                end
            elseif v3 ~= 3 or not (v4 < 4096) then
                if not v19 or v35 then
                    v11 = a2[v19 and v5 - 1 or v5]
                    v26 = v26 + 1
                    v25[v26] = v11
                    v27[v11] = (v27[v11] or 0) + 1
                end
                v38 = v38 + 1
            elseif v36 <= v3 then
                v8 = u793[v3]
                v7 = u801[v3]
                if not (v4 <= 256) then
                    v11 = 16
                    v12 = 7
                    v6 = 384
                    v14 = 512
                    while not (v4 <= v6) do
                        if not (v4 <= v14) then
                            v11 = v11 + 2
                            v12 = v12 + 1
                            v6 = v6 * 2
                            v14 = v14 * 2
                            continue
                        else
                            v13 = (v4 - v14 / 2 - 1) % (v14 / 4)
                            v11 = v11 + 1
                        end
                        v26 = v26 + 1
                        v25[v26] = v8
                        v27[v8] = (v27[v8] or 0) + 1
                        v29 = v29 + 1
                        v28[v29] = v11
                        v30[v11] = (v30[v11] or 0) + 1
                        if v7 > 0 then
                            v11 = u812[v3]
                            v32 = v32 + 1
                            v31[v32] = v11
                        end
                        if v12 > 0 then
                            v34 = v34 + 1
                            v33[v34] = v13
                        end
                        v16 = v38 + 1
                        v17 = v38 + v3
                        v14 = v17 - (if not v19 then 1 else 2)
                        for i6 = v16, v14 do
                            v1 = (v1 * 256 + (a2[i6 - a6 + 2] or 0)) % 16777216
                            if v3 <= v18 then
                                v9 = a3[v1]
                                if not v9 then
                                    a3[v1] = {}
                                end
                                v9[#v9 + 1] = i6
                            end
                        end
                        v14 = v38 + v3
                        v38 = v14 - (if not v19 then 0 else 1)
                        break
                    end
                    v13 = (v4 - v14 / 2 - 1) % (v14 / 4)
                else
                    v11 = u522[v4]
                    v13 = u538[v4]
                    v12 = u540[v4]
                end
                v26 = v26 + 1
                v25[v26] = v8
                v27[v8] = (v27[v8] or 0) + 1
                v29 = v29 + 1
                v28[v29] = v11
                v30[v11] = (v30[v11] or 0) + 1
                if v7 > 0 then
                    v11 = u812[v3]
                    v32 = v32 + 1
                    v31[v32] = v11
                end
                if v12 > 0 then
                    v34 = v34 + 1
                    v33[v34] = v13
                end
                v16 = v38 + 1
                v17 = v38 + v3
                v14 = v17 - (if not v19 then 1 else 2)
                for i7 = v16, v14 do
                    v1 = (v1 * 256 + (a2[i7 - a6 + 2] or 0)) % 16777216
                    if v3 <= v18 then
                        v9 = a3[v1]
                        if not v9 then
                            a3[v1] = {}
                        end
                        v9[#v9 + 1] = i7
                    end
                end
                v14 = v38 + v3
                v38 = v14 - (if not v19 then 0 else 1)
            else
                if not v19 or v35 then
                    v11 = a2[v19 and v5 - 1 or v5]
                    v26 = v26 + 1
                    v25[v26] = v11
                    v27[v11] = (v27[v11] or 0) + 1
                end
                v38 = v38 + 1
            end
        elseif not v35 then
            if not v19 or v35 then
                v11 = a2[v19 and v5 - 1 or v5]
                v26 = v26 + 1
                v25[v26] = v11
                v27[v11] = (v27[v11] or 0) + 1
            end
            v38 = v38 + 1
        elseif v3 > 3 then
            if v36 <= v3 then
                v8 = u793[v3]
                v7 = u801[v3]
                if not (v4 <= 256) then
                    v11 = 16
                    v12 = 7
                    v6 = 384
                    v14 = 512
                    while not (v4 <= v6) do
                        if not (v4 <= v14) then
                            v11 = v11 + 2
                            v12 = v12 + 1
                            v6 = v6 * 2
                            v14 = v14 * 2
                            continue
                        else
                            v13 = (v4 - v14 / 2 - 1) % (v14 / 4)
                            v11 = v11 + 1
                        end
                        v26 = v26 + 1
                        v25[v26] = v8
                        v27[v8] = (v27[v8] or 0) + 1
                        v29 = v29 + 1
                        v28[v29] = v11
                        v30[v11] = (v30[v11] or 0) + 1
                        if v7 > 0 then
                            v11 = u812[v3]
                            v32 = v32 + 1
                            v31[v32] = v11
                        end
                        if v12 > 0 then
                            v34 = v34 + 1
                            v33[v34] = v13
                        end
                        v16 = v38 + 1
                        v17 = v38 + v3
                        v14 = v17 - (if not v19 then 1 else 2)
                        for i8 = v16, v14 do
                            v1 = (v1 * 256 + (a2[i8 - a6 + 2] or 0)) % 16777216
                            if v3 <= v18 then
                                v9 = a3[v1]
                                if not v9 then
                                    a3[v1] = {}
                                end
                                v9[#v9 + 1] = i8
                            end
                        end
                        v14 = v38 + v3
                        v38 = v14 - (if not v19 then 0 else 1)
                        break
                    end
                    v13 = (v4 - v14 / 2 - 1) % (v14 / 4)
                else
                    v11 = u522[v4]
                    v13 = u538[v4]
                    v12 = u540[v4]
                end
                v26 = v26 + 1
                v25[v26] = v8
                v27[v8] = (v27[v8] or 0) + 1
                v29 = v29 + 1
                v28[v29] = v11
                v30[v11] = (v30[v11] or 0) + 1
                if v7 > 0 then
                    v11 = u812[v3]
                    v32 = v32 + 1
                    v31[v32] = v11
                end
                if v12 > 0 then
                    v34 = v34 + 1
                    v33[v34] = v13
                end
                v16 = v38 + 1
                v17 = v38 + v3
                v14 = v17 - (if not v19 then 1 else 2)
                for i9 = v16, v14 do
                    v1 = (v1 * 256 + (a2[i9 - a6 + 2] or 0)) % 16777216
                    if v3 <= v18 then
                        v9 = a3[v1]
                        if not v9 then
                            a3[v1] = {}
                        end
                        v9[#v9 + 1] = i9
                    end
                end
                v14 = v38 + v3
                v38 = v14 - (if not v19 then 0 else 1)
            else
                if not v19 or v35 then
                    v11 = a2[v19 and v5 - 1 or v5]
                    v26 = v26 + 1
                    v25[v26] = v11
                    v27[v11] = (v27[v11] or 0) + 1
                end
                v38 = v38 + 1
            end
        elseif v3 ~= 3 or not (v4 < 4096) then
            if not v19 or v35 then
                v11 = a2[v19 and v5 - 1 or v5]
                v26 = v26 + 1
                v25[v26] = v11
                v27[v11] = (v27[v11] or 0) + 1
            end
            v38 = v38 + 1
        elseif v36 <= v3 then
            v8 = u793[v3]
            v7 = u801[v3]
            if not (v4 <= 256) then
                v11 = 16
                v12 = 7
                v6 = 384
                v14 = 512
                while not (v4 <= v6) do
                    if not (v4 <= v14) then
                        v11 = v11 + 2
                        v12 = v12 + 1
                        v6 = v6 * 2
                        v14 = v14 * 2
                        continue
                    else
                        v13 = (v4 - v14 / 2 - 1) % (v14 / 4)
                        v11 = v11 + 1
                    end
                    v26 = v26 + 1
                    v25[v26] = v8
                    v27[v8] = (v27[v8] or 0) + 1
                    v29 = v29 + 1
                    v28[v29] = v11
                    v30[v11] = (v30[v11] or 0) + 1
                    if v7 > 0 then
                        v11 = u812[v3]
                        v32 = v32 + 1
                        v31[v32] = v11
                    end
                    if v12 > 0 then
                        v34 = v34 + 1
                        v33[v34] = v13
                    end
                    v16 = v38 + 1
                    v17 = v38 + v3
                    v14 = v17 - (if not v19 then 1 else 2)
                    for i10 = v16, v14 do
                        v1 = (v1 * 256 + (a2[i10 - a6 + 2] or 0)) % 16777216
                        if v3 <= v18 then
                            v9 = a3[v1]
                            if not v9 then
                                a3[v1] = {}
                            end
                            v9[#v9 + 1] = i10
                        end
                    end
                    v14 = v38 + v3
                    v38 = v14 - (if not v19 then 0 else 1)
                    break
                end
                v13 = (v4 - v14 / 2 - 1) % (v14 / 4)
            else
                v11 = u522[v4]
                v13 = u538[v4]
                v12 = u540[v4]
            end
            v26 = v26 + 1
            v25[v26] = v8
            v27[v8] = (v27[v8] or 0) + 1
            v29 = v29 + 1
            v28[v29] = v11
            v30[v11] = (v30[v11] or 0) + 1
            if v7 > 0 then
                v11 = u812[v3]
                v32 = v32 + 1
                v31[v32] = v11
            end
            if v12 > 0 then
                v34 = v34 + 1
                v33[v34] = v13
            end
            v16 = v38 + 1
            v17 = v38 + v3
            v14 = v17 - (if not v19 then 1 else 2)
            for i11 = v16, v14 do
                v1 = (v1 * 256 + (a2[i11 - a6 + 2] or 0)) % 16777216
                if v3 <= v18 then
                    v9 = a3[v1]
                    if not v9 then
                        a3[v1] = {}
                    end
                    v9[#v9 + 1] = i11
                end
            end
            v14 = v38 + v3
            v38 = v14 - (if not v19 then 0 else 1)
        else
            if not v19 or v35 then
                v11 = a2[v19 and v5 - 1 or v5]
                v26 = v26 + 1
                v25[v26] = v11
                v27[v11] = (v27[v11] or 0) + 1
            end
            v38 = v38 + 1
        end
    end
    v25[v26 + 1] = 256
    v27[256] = (v27[256] or 0) + 1
    return v25, v31, v27, v28, v33, v30
end

local function GetBlockDynamicHuffmanHeader(a1, a2) -- Line: 1582
    -- upvalues: GetHuffmanBitlenAndCode (val), RunLengthEncodeHuffmanBitlen (val), u836 (val)
    local v1, v2, v3 = GetHuffmanBitlenAndCode(a1, 15, 285)
    local v4, v5, v6 = GetHuffmanBitlenAndCode(a2, 15, 29)
    local v7, v8, v9 = RunLengthEncodeHuffmanBitlen(v1, v3, v4, v6)
    local v10, v11 = GetHuffmanBitlenAndCode(v9, 7, 18)
    v9 = 0
    for i = 1, 19 do
        if (v10[u836[i]] or 0) ~= 0 then
            v9 = i
        end
    end
    v9 = v9 - 4
    local v12 = v3 + 1 - 257
    v3 = v6 + 1 - 1
    if v3 < 0 then
        v3 = 0
    end
    return v12, v3, v9, v10, v11, v7, v8, v1, v2, v4, v5
end

local function GetDynamicHuffmanBlockSize(a1, a2, a3, a4, a5, a6, a7) -- Line: 1644
    -- upvalues: u860 (val)
    local v1, v2, v3
    local v4 = 17 + (a3 + 4) * 3
    local v5 = #a5
    local v6, v7 = a5, a4
    for i = 1, v5 do
        v1 = v6[i]
        v4 = v4 + v7[v1]
        if v1 >= 16 then
            v4 = v4 + (if v1 ~= 16 then if v1 ~= 17 then 7 else 3 else 2)
        end
    end
    v5 = 0
    local v8 = #a1
    for j = 1, v8 do
        v2 = a1[j]
        v4 = v4 + a6[v2]
        if v2 > 256 then
            v5 = v5 + 1
            if v2 > 264 and v2 < 285 then
                v4 = v4 + u860[v2 - 256]
            end
            v3 = a2[v5]
            v4 = v4 + a7[v3]
            if v3 > 3 then
                v4 = v4 + ((v3 - v3 % 2) / 2 - 1)
            end
        end
    end
    return v4
end

local function CompressDynamicHuffmanBlock(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17) -- Line: 1690
    -- upvalues: u836 (val), u860 (val)
    local v1, v2, v3
    a1(if not a2 then 0 else 1, 1)
    a1(2, 2)
    a1(a7, 5)
    a1(a8, 5)
    a1(a9, 4)
    local v4 = a9 + 4
    for i = 1, v4 do
        a1(a10[u836[i]] or 0, 3)
    end
    v4 = 1
    local v5 = #a12
    local v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18 = a12, a1, a11, a10, a13, a3, a4, a5, a6, a14, a15, a16, a17
    for j = 1, v5 do
        v1 = v6[j]
        v7(v8[v1], v9[v1])
        if v1 >= 16 then
            v7(v10[v4], if v1 ~= 16 then if v1 ~= 17 then 7 else 3 else 2)
            v4 = v4 + 1
        end
    end
    v4 = 0
    v5 = 0
    local v19 = 0
    local v20 = #v11
    for k = 1, v20 do
        v2 = v11[k]
        v7(v16[v2], v15[v2])
        if v2 > 256 then
            v4 = v4 + 1
            if v2 > 264 and v2 < 285 then
                v5 = v5 + 1
                v7(v12[v5], u860[v2 - 256])
            end
            v3 = v13[v4]
            v7(v18[v3], v17[v3])
            if v3 > 3 then
                v19 = v19 + 1
                v7(v14[v19], (v3 - v3 % 2) / 2 - 1)
            end
        end
    end
end

local function GetFixedHuffmanBlockSize(a1, a2) -- Line: 1771
    -- upvalues: u885 (ref), u860 (val)
    local v1, v2
    local v3 = 3
    local v4 = 0
    local v5 = #a1
    local v6, v7 = a1, a2
    for i = 1, v5 do
        v1 = v6[i]
        v3 = v3 + u885[v1]
        if v1 > 256 then
            v4 = v4 + 1
            if v1 > 264 and v1 < 285 then
                v3 = v3 + u860[v1 - 256]
            end
            v2 = v7[v4]
            v3 = v3 + 5
            if v2 > 3 then
                v3 = v3 + ((v2 - v2 % 2) / 2 - 1)
            end
        end
    end
    return v3
end

local function CompressFixedHuffmanBlock(a1, a2, a3, a4, a5, a6) -- Line: 1799
    -- upvalues: u909 (ref), u885 (ref), u860 (val), u932 (ref)
    local v1, v2
    a1(if not a2 then 0 else 1, 1)
    a1(1, 2)
    local v3 = 0
    local v4 = 0
    local v5 = 0
    local v6 = #a3
    local v7, v8, v9, v10, v11 = a3, a1, a4, a5, a6
    for i = 1, v6 do
        v1 = v7[i]
        v8(u909[v1], u885[v1])
        if v1 > 256 then
            v3 = v3 + 1
            if v1 > 264 and v1 < 285 then
                v4 = v4 + 1
                v8(v9[v4], u860[v1 - 256])
            end
            v2 = v10[v3]
            v8(u932[v2], 5)
            if v2 > 3 then
                v5 = v5 + 1
                v8(v11[v5], (v2 - v2 % 2) / 2 - 1)
            end
        end
    end
end

local function GetStoreBlockSize(a1, a2, a3) -- Line: 1847 -- types: a1: number, a2: number, a3: number
    assert(a2 - a1 + 1 <= 65535)
    return 3 + (8 - (a3 + 3) % 8) % 8 + 32 + (a2 - a1 + 1) * 8
end

local function CompressStoreBlock(a1, a2, a3, a4, a5, a6, a7) -- Line: 1861
    -- upvalues: u675 (val)
    assert(a6 - a5 + 1 <= 65535)
    a1(if not a3 then 0 else 1, 1)
    a1(0, 2)
    local v1 = (8 - (a7 + 3) % 8) % 8
    if v1 > 0 then
        a1(u675[v1] - 1, v1)
    end
    v1 = a6 - a5 + 1
    a1(v1, 16)
    a1(255 - v1 % 256 + (255 - (v1 - v1 % 256) / 256) * 256, 16)
    a2(a4:sub(a5, a6))
end

local function Deflate(a1, a2, a3, a4, a5, a6) -- Line: 1899
    -- upvalues: LoadStringToTable (val), GetBlockLZ77Result (val), GetBlockDynamicHuffmanHeader (val)
    -- upvalues: GetDynamicHuffmanBlockSize (val), GetFixedHuffmanBlockSize (val), CompressStoreBlock (val)
    -- upvalues: CompressFixedHuffmanBlock (val), CompressDynamicHuffmanBlock (val)
    local string_table, strlen, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31
    local v32 = {}
    local v33 = {}
    local v34 = nil
    local v35 = 0
    local v36 = 0
    local v37 = a4(3)
    local v38 = #a5
    local level = nil
    local strategy = nil
    if a1 then
        if a1.level then
            level = a1.level
        end
        if a1.strategy then
            strategy = a1.strategy
        end
    end
    if not level then
        level = if not (v38 < 2048) then if not (v38 > 65536) then 5 else 3 else 7
    end
    while not v34 do
        if v35 ~= 0 then
            v35 = v36 + 1
            v36 = v36 + 32768
            v1 = v35 - 32768 - 1
        else
            v35 = 1
            v36 = 65535
            v1 = 0
        end
        if not (v38 <= v36) then
            v34 = false
        else
            v36 = v38
            v34 = true
        end
        v2 = {}
        v3 = {}
        v5 = {}
        v6 = {}
        v8 = nil
        v9 = nil
        v10 = nil
        v11 = {}
        v12 = {}
        v13 = {}
        v14 = {}
        v15 = {}
        v16 = {}
        v17 = {}
        v18 = {}
        v19 = nil
        v20 = nil
        if level ~= 0 then
            LoadStringToTable(a5, v32, v35, v36 + 3, v1)
            if v35 == 1 and a6 then
                string_table = a6.string_table
                strlen = a6.strlen
                for i = 0, if not (-strlen + 1 < -257) then -strlen + 1 else -257, -1 do
                    v32[i] = string_table[strlen + i]
                end
            end
            if strategy ~= "huffman_only" then
                v21, v22, v23, v24, v25, v26 = GetBlockLZ77Result(level, v32, v33, v35, v36, v1, a6)
                v2 = v21
                v3 = v22
                v4 = v23
                v5 = v24
                v6 = v25
                v7 = v26
            else
                v2 = {}
                LoadStringToTable(a5, v2, v35, v36, v35 - 1)
                v3 = {}
                v4 = {}
                v2[v36 - v35 + 2] = 256
                v21 = v36 - v35 + 2
                for j = 1, v21 do
                    v24 = v2[j]
                    v4[v24] = (v4[v24] or 0) + 1
                end
                v5 = {}
                v6 = {}
                v7 = {}
            end
            v21, v22, v23, v24, v25, v26, v27, v28, v29, v30, v31 = GetBlockDynamicHuffmanHeader(v4, v7)
            v8 = v21
            v9 = v22
            v12 = v25
            v14 = v27
            v16 = v29
            v18 = v31
            v19 = GetDynamicHuffmanBlockSize(v2, v5, v23, v24, v26, v28, v30)
            v20 = GetFixedHuffmanBlockSize(v2, v5)
        end
        assert(v36 - v35 + 1 <= 65535)
        v7 = 3 + (8 - (v37 + 3) % 8) % 8 + 32 + (v36 - v35 + 1) * 8
        v21 = v7
        v21 = v20 and v20 < v21 and v20 or v21
        v22 = v19 and v19 < v21 and v19 or v21
        v21 = v22
        if level == 0 then
            CompressStoreBlock(a2, a3, v34, a5, v35, v36, v37)
            v37 = v37 + v7
        elseif strategy == "fixed" or strategy == "dynamic" then
            if strategy == "dynamic" then
                if strategy == "dynamic" or v19 == v21 then
                    CompressDynamicHuffmanBlock(a2, v34, v2, v3, v5, v6, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18)
                    v37 = v37 + assert(v19)
                end
            elseif strategy == "fixed" or v20 == v21 then
                CompressFixedHuffmanBlock(a2, v34, v2, v3, v5, v6)
                v37 = v37 + assert(v20)
            elseif strategy == "dynamic" or v19 == v21 then
                CompressDynamicHuffmanBlock(a2, v34, v2, v3, v5, v6, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18)
                v37 = v37 + assert(v19)
            end
        elseif v7 == v21 then
            CompressStoreBlock(a2, a3, v34, a5, v35, v36, v37)
            v37 = v37 + v7
        elseif strategy == "dynamic" then
            if strategy == "dynamic" or v19 == v21 then
                CompressDynamicHuffmanBlock(a2, v34, v2, v3, v5, v6, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18)
                v37 = v37 + assert(v19)
            end
        elseif strategy == "fixed" or v20 == v21 then
            CompressFixedHuffmanBlock(a2, v34, v2, v3, v5, v6)
            v37 = v37 + assert(v20)
        elseif strategy == "dynamic" or v19 == v21 then
            CompressDynamicHuffmanBlock(a2, v34, v2, v3, v5, v6, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18)
            v37 = v37 + assert(v19)
        end
        assert((if not v34 then a4(0) else a4(3)) == v37)
        if not v34 then
            if a6 and v35 == 1 then
                v22 = 0
                while v32[v22] do
                    v32[v22] = nil
                    v22 = v22 - 1
                end
            end
            v22 = 1
            for k = v36 - 32767, v36 do
                v32[v22] = v32[k - v1]
                v22 = v22 + 1
            end
            for k2, v in pairs(v33) do
                v21 = #v
                if v21 > 0 and 32768 < v36 + 1 - v[1] then
                    if v21 ~= 1 then
                        v20 = {}
                        v19 = 0
                        for n = 2, v21 do
                            v22 = v[n]
                            if v36 + 1 - v22 <= 32768 then
                                v19 = v19 + 1
                                v20[v19] = v22
                            end
                        end
                        v33[k2] = v20
                    else
                        v33[k2] = nil
                    end
                end
            end
        end
    end
end

local function CompressDeflateInternal(a1, a2, a3) -- Line: 2123
    -- upvalues: CreateWriter (val), Deflate (val)
    local v1, v2, v3 = CreateWriter()
    Deflate(a3, v1, v2, v3, a1, a2)
    local v4, v5 = v3(1)
    assert(v5)
    return v5, (8 - v4 % 8) % 8
end

local function CompressZlibInternal(a1, a2, a3) -- Line: 2134
    -- upvalues: CreateWriter (val), Deflate (val), u1429 (val)
    local v1, v2, v3
    local v4, v5, v6 = CreateWriter()
    v4(120, 8)
    local v7 = 128 + (if not a2 then 0 else 1) * 32
    v4(v7 + (31 - (30720 + v7) % 31), 8)
    if v2 == 1 then
        assert(a2)
        local adler32 = a2.adler32
        v7 = adler32 % 256
        local v8 = (adler32 - v7) / 256
        v3 = v8 % 256
        v8 = (v8 - v3) / 256
        v1 = v8 % 256
        v4((v8 - v1) / 256 % 256, 8)
        v4(v1, 8)
        v4(v3, 8)
        v4(v7, 8)
    end
    Deflate(a3, v4, v5, v6, a1, a2)
    v6(2)
    v2 = u1429:Adler32(a1)
    v5 = v2 % 256
    v2 = (v2 - v5) / 256
    v3 = v2 % 256
    v2 = (v2 - v3) / 256
    v1 = v2 % 256
    v4((v2 - v1) / 256 % 256, 8)
    v4(v1, 8)
    v4(v3, 8)
    v4(v5, 8)
    local v9, v10 = v6(1)
    assert(v10)
    return v10, (8 - v9 % 8) % 8
end

function u1429.CompressDeflate(a1, a2, a3) -- Line: 2205
    -- upvalues: IsValidArguments (val), CompressDeflateInternal (val)
    local v1, v2 = IsValidArguments(a2, false, nil, true, a3)
    if not v1 then
        error("Usage: LibDeflate:CompressDeflate(str, configs): " .. v2, 2)
    end
    return CompressDeflateInternal(a2, nil, a3)
end

function u1429.CompressDeflateWithDict(a1, a2, a3, a4) -- Line: 2229
    -- upvalues: IsValidArguments (val), CompressDeflateInternal (val)
    local v1, v2 = IsValidArguments(a2, true, a3, true, a4)
    if not v1 then
        error("Usage: LibDeflate:CompressDeflateWithDict" .. "(str, dictionary, configs): " .. v2, 2)
    end
    return CompressDeflateInternal(a2, a3, a4)
end

function u1429.CompressZlib(a1, a2, a3) -- Line: 2247 -- upvalues: IsValidArguments (val), CompressZlibInternal (val)
    local v1, v2 = IsValidArguments(a2, false, nil, true, a3)
    if not v1 then
        error("Usage: LibDeflate:CompressZlib(str, configs): " .. v2, 2)
    end
    return CompressZlibInternal(a2, nil, a3)
end

function u1429.CompressZlibWithDict(a1, a2, a3, a4) -- Line: 2268
    -- upvalues: IsValidArguments (val), CompressZlibInternal (val)
    local v1, v2 = IsValidArguments(a2, true, a3, true, a4)
    if not v1 then
        error("Usage: LibDeflate:CompressZlibWithDict" .. "(str, dictionary, configs): " .. v2, 2)
    end
    return CompressZlibInternal(a2, a3, a4)
end

local function CreateReader(a1) -- Line: 2296
    -- upvalues: u675 (val), byte (val), char (val), sub (val), u757 (val)
    local u1 = #a1
    local u2 = 1
    local u3 = 0
    local u4 = 0
    return function(a1_2) -- Line: 2309
        -- upvalues: u675 (upval), u3 (ref), u4 (ref), a1 (val), u2 (ref), byte (upval)
        local v1, v2
        local v3 = u675[a1_2]
        if a1_2 <= u3 then
            v1 = u4 % v3
            u4 = (u4 - v1) / v3
            u3 = u3 - a1_2
            return v1
        end
        local v4 = u675[u3]
        local v5 = a1
        local v6 = u2
        local v7 = u2 + 3
        v2, v5, v6, v7 = byte(v5, v6, v7)
        u4 = u4 + ((v2 or 0) + (v5 or 0) * 256 + (v6 or 0) * 65536 + (v7 or 0) * 16777216) * v4
        u2 = u2 + 4
        u3 = u3 + 32 - a1_2
        v1 = u4 % v3
        u4 = (u4 - v1) / v3
        return v1
    end, function(a1_2, a2, a3) -- Line: 2337
        -- upvalues: u3 (ref), u4 (ref), char (upval), u1 (val), u2 (ref), a1 (val), sub (upval)
        local v1
        assert(u3 % 8 == 0)
        local v2 = u3 / 8 < a1_2 and u3 / 8 or a1_2
        local v3 = a3
        for i = 1, v2 do
            v1 = u4 % 256
            v3 = v3 + 1
            a2[v3] = (char(v1))
            u4 = (u4 - v1) / 256
        end
        u3 = u3 - v2 * 8
        local v4 = a1_2 - v2
        if (u1 - u2 - v4 + 1) * 8 + u3 < 0 then
            return -1
        end
        local v5 = u2
        local v6 = u2 + v4 - 1
        for j = v5, v6 do
            v3 = v3 + 1
            a2[v3] = (sub(a1, j, j))
        end
        u2 = u2 + v4
        return v3
    end, function(a1_2, a2, a3) -- Line: 2372
        -- upvalues: u3 (ref), a1 (val), u675 (upval), u2 (ref), byte (upval), u4 (ref), u757 (upval)
        local v1, v2
        local v3 = 0
        local v4 = 0
        local v5 = 0
        if a3 > 0 then
            local v6
            if u3 < 15 and a1 then
                local v7
                v6 = u675[u3]
                local v8 = a1
                v1 = u2
                local v9 = u2 + 3
                v7, v8, v1, v9 = byte(v8, v1, v9)
                u4 = u4 + ((v7 or 0) + (v8 or 0) * 256 + (v1 or 0) * 65536 + (v9 or 0) * 16777216) * v6
                u2 = u2 + 4
                u3 = u3 + 32
            end
            v6 = u675[a3]
            u3 = u3 - a3
            v3 = u4 % v6
            u4 = (u4 - v3) / v6
            v3 = u757[a3][v3]
            v2 = a1_2[a3]
            if v3 < v2 then
                return a2[v3]
            end
            v5 = v2
            v4 = v2 * 2
            v3 = v3 * 2
        end
        for i = a3 + 1, 15 do
            v1 = u4 % 2
            u4 = (u4 - v1) / 2
            u3 = u3 - 1
            v3 = not (v1 ~= 1) and v3 + 1 - v3 % 2 or v3
            v2 = a1_2[i] or 0
            v1 = v3 - v4
            if v1 < v2 then
                return a2[v5 + v1]
            end
            v5 = v5 + v2
            v4 = (v4 + v2) * 2
            v3 = v3 * 2
        end
        return -10
    end, function() -- Line: 2431 -- upvalues: u1 (val), u2 (ref), u3 (ref)
        return (u1 - u2 + 1) * 8 + u3
    end, function() -- Line: 2435 -- upvalues: u3 (ref), u675 (upval), u4 (ref)
        local v1 = u3 % 8
        local v2 = u675[v1]
        u3 = u3 - v1
        u4 = (u4 - u4 % v2) / v2
    end
end

local function CreateDecompressState(a1, a2) -- Line: 2450
    -- upvalues: CreateReader (val)
    local v1, v2, v3, v4, v5 = CreateReader(a1)
    return {
        buffer_size = 0,
        ReadBits = v1,
        ReadBytes = v2,
        Decode = v3,
        ReaderBitlenLeft = v4,
        SkipToByteBoundary = v5,
        buffer = {},
        result_buffer = {},
        dictionary = a2,
    }
end

local function GetHuffmanForDecode(a1, a2, a3) -- Line: 2475 -- types: a1: table, a2: number, a3: number
    local v1, v2
    local v3 = {}
    local v4 = a3
    for i = 0, a2 do
        v2 = a1[i] or 0
        v4 = v2 > 0 and v2 < v4 and v2 or v4
        v3[v2] = (v3[v2] or 0) + 1
    end
    if v3[0] == a2 + 1 then
        return 0, v3, {}, 0
    end
    local v5 = 1
    for j = 1, a3 do
        v5 = v5 * 2 - (v3[j] or 0)
        if v5 < 0 then
            return v5, {}, {}, 0
        end
    end
    local v6 = {0}
    local v7 = a3 - 1
    for k = 1, v7 do
        v6[k + 1] = v6[k] + (v3[k] or 0)
    end
    v7 = {}
    for n = 0, a2 do
        v1 = a1[n] or 0
        if v1 ~= 0 then
            v7[v6[v1]] = n
            v6[v1] = v6[v1] + 1
        end
    end
    return v5, v3, v7, v4
end

local function DecodeUntilEndOfBlock(a1, a2, a3, a4, a5, a6, a7) -- Line: 2541
    -- upvalues: u1359 (val), u991 (val), u860 (val), u1014 (val), u1037 (val), concat (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
    local buffer = a1.buffer
    local buffer_size = a1.buffer_size
    local ReadBits = a1.ReadBits
    local Decode = a1.Decode
    local ReaderBitlenLeft = a1.ReaderBitlenLeft
    local result_buffer = a1.result_buffer
    local dictionary = a1.dictionary
    local string_table = {}
    local strlen = nil
    local v12 = 1
    if not dictionary or buffer[0] then
        v2, v7, v8, v9, v10, v11, v1 = a2, a3, a4, a5, a6, a7, a1
    else
        string_table = dictionary.string_table
        strlen = dictionary.strlen
        v12 = -strlen + 1
        for i = 0, if not (-strlen + 1 < -257) then -strlen + 1 else -257, -1 do
            buffer[i] = u1359[string_table[strlen + i]]
        end
    end
    while true do
        v3 = Decode(v2, v7, v8)
        if v3 < 0 or v3 > 285 then
            break
        end
        if not (v3 < 256) then
            if v3 > 256 then
                v3 = v3 - 256
                v4 = u991[v3]
                v5 = v3 >= 8 and v4 + ReadBits(u860[v3]) or v4
                v4 = v5
                v3 = Decode(v9, v10, v11)
                if not (v3 < 0) and not (v3 > 29) then
                    v5 = u1014[v3]
                    v6 = buffer_size - (v5 > 4 and v5 + ReadBits(u1037[v3]) or v5) + 1
                    if v6 < v12 then
                        return -11
                    end
                    if not (v6 >= -257) then
                        v6 = strlen + v6
                        for j = 1, v4 do
                            buffer_size = buffer_size + 1
                            buffer[buffer_size] = u1359[string_table[v6]]
                            v6 = v6 + 1
                        end
                    else
                        for k = 1, v4 do
                            buffer_size = buffer_size + 1
                            buffer[buffer_size] = buffer[v6]
                            v6 = v6 + 1
                        end
                    end
                    if ReaderBitlenLeft() < 0 then
                        return 2
                    end
                    if buffer_size >= 65536 then
                        result_buffer[#result_buffer + 1] = (concat(buffer, "", 1, 32768))
                        for n = 32769, buffer_size do
                            buffer[n - 32768] = buffer[n]
                        end
                        buffer_size = buffer_size - 32768
                        buffer[buffer_size + 1] = nil
                    end
                    if v3 ~= 256 then
                        continue
                    end
                    v1.buffer_size = buffer_size
                    return 0
                end
                return -10
            end
            if ReaderBitlenLeft() < 0 then
                return 2
            end
            if buffer_size >= 65536 then
                result_buffer[#result_buffer + 1] = (concat(buffer, "", 1, 32768))
                for m = 32769, buffer_size do
                    buffer[m - 32768] = buffer[m]
                end
                buffer_size = buffer_size - 32768
                buffer[buffer_size + 1] = nil
            end
        else
            buffer_size = buffer_size + 1
            buffer[buffer_size] = u1359[v3]
            if ReaderBitlenLeft() < 0 then
                return 2
            end
            if buffer_size >= 65536 then
                result_buffer[#result_buffer + 1] = (concat(buffer, "", 1, 32768))
                for i5 = 32769, buffer_size do
                    buffer[i5 - 32768] = buffer[i5]
                end
                buffer_size = buffer_size - 32768
                buffer[buffer_size + 1] = nil
            end
        end
        if v3 == 256 then
            v1.buffer_size = buffer_size
            return 0
        end
    end
    return -10
end

local function DecompressStoreBlock(a1) -- Line: 2634 -- upvalues: concat (val) -- types: a1: table
    local buffer = a1.buffer
    local buffer_size = a1.buffer_size
    local ReadBits = a1.ReadBits
    local ReadBytes = a1.ReadBytes
    local ReaderBitlenLeft = a1.ReaderBitlenLeft
    local SkipToByteBoundary = a1.SkipToByteBoundary
    local result_buffer = a1.result_buffer
    SkipToByteBoundary()
    local v1 = ReadBits(16)
    if ReaderBitlenLeft() < 0 then
        return 2
    end
    local v2 = ReadBits(16)
    if ReaderBitlenLeft() < 0 then
        return 2
    end
    if v1 % 256 + v2 % 256 ~= 255 or (v1 - v1 % 256) / 256 + (v2 - v2 % 256) / 256 ~= 255 then
        return -2
    end
    local v3 = ReadBytes(v1, buffer, buffer_size)
    if v3 < 0 then
        return 2
    end
    if v3 >= 65536 then
        result_buffer[#result_buffer + 1] = (concat(buffer, "", 1, 32768))
        for i = 32769, v3 do
            buffer[i - 32768] = buffer[i]
        end
        v3 = v3 - 32768
        buffer[v3 + 1] = nil
    end
    a1.buffer_size = v3
    return 0
end

local function DecompressFixBlock(a1) -- Line: 2683
    -- upvalues: DecodeUntilEndOfBlock (val), u1062 (ref), u1085 (ref), u1108 (ref), u1131 (ref)
    return (DecodeUntilEndOfBlock(a1, u1062, u1085, 7, u1108, u1131, 5))
end

local function DecompressDynamicBlock(a1) -- Line: 2698
    -- upvalues: u836 (val), GetHuffmanForDecode (val), DecodeUntilEndOfBlock (val)
    local ReadBits = a1.ReadBits
    local Decode = a1.Decode
    local v1 = ReadBits(5) + 257
    local v2 = ReadBits(5) + 1
    local v3 = ReadBits(4) + 4
    if not (v1 > 286) and not (v2 > 30) then
        local v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15
        local v16 = {}
        for i = 1, v3 do
            v4 = u836[i]
            v16[v4] = (ReadBits(3))
        end
        v13, v14, v15, v4 = GetHuffmanForDecode(v16, 18, 7)
        if v13 ~= 0 then
            return -4
        end
        v13 = {}
        v16 = {}
        v3 = 0
        while v3 < v1 + v2 do
            v5 = Decode(v14, v15, v4)
            if v5 < 0 then
                return v5
            end
            if not (v5 < 16) then
                v6 = 0
                if v5 ~= 16 then
                    v5 = if v5 ~= 17 then 11 + ReadBits(7) else 3 + ReadBits(3)
                else
                    if v3 == 0 then
                        return -5
                    end
                    v6 = if not (v3 - 1 < v1) then v16[v3 - v1 - 1] else v13[v3 - 1]
                    v5 = 3 + ReadBits(2)
                end
                v7 = v3 + v5
                if v1 + v2 < v7 then
                    return -6
                end
                while v5 > 0 do
                    v5 = v5 - 1
                    if not (v3 < v1) then
                        v16[v3 - v1] = v6
                    else
                        v13[v3] = v6
                    end
                    v3 = v3 + 1
                end
            else
                if not (v3 < v1) then
                    v16[v3 - v1] = v5
                else
                    v13[v3] = v5
                end
                v3 = v3 + 1
            end
        end
        if (v13[256] or 0) == 0 then
            return -9
        end
        v5, v6, v7, v8 = GetHuffmanForDecode(v13, v1 - 1, 15)
        if v5 == 0 then
            v9, v10, v11, v12 = GetHuffmanForDecode(v16, v2 - 1, 15)
            if v9 ~= 0 then
                if not (v9 < 0) and v2 == (v10[0] or 0) + (v10[1] or 0) then
                    return (DecodeUntilEndOfBlock(a1, v6, v7, v8, v10, v11, v12))
                end
                return -8
            end
            return (DecodeUntilEndOfBlock(a1, v6, v7, v8, v10, v11, v12))
        end
        if not (v5 < 0) then
            v10 = v6[0] or 0
            if v1 == v10 + (v6[1] or 0) then
                v9, v10, v11, v12 = GetHuffmanForDecode(v16, v2 - 1, 15)
                if v9 == 0 then
                    return (DecodeUntilEndOfBlock(a1, v6, v7, v8, v10, v11, v12))
                end
                if not (v9 < 0) and v2 == (v10[0] or 0) + (v10[1] or 0) then
                    return (DecodeUntilEndOfBlock(a1, v6, v7, v8, v10, v11, v12))
                end
                return -8
            end
        end
        return -7
    end
    return -3
end

local function Inflate(a1) -- Line: 2818
    -- upvalues: DecompressStoreBlock (val), DecodeUntilEndOfBlock (val), u1062 (ref), u1085 (ref), u1108 (ref)
    -- upvalues: u1131 (ref), DecompressDynamicBlock (val), concat (val)
    local v1, v2
    local ReadBits = a1.ReadBits
    local v3 = nil
    local v4 = a1
    while not v3 do
        v3 = ReadBits(1) == 1
        v1 = ReadBits(2)
        if v1 == 0 then
            v2 = DecompressStoreBlock(v4)
            if v2 ~= 0 then
                return nil, v2
            end
        elseif v1 == 1 then
            v2 = DecodeUntilEndOfBlock(v4, u1062, u1085, 7, u1108, u1131, 5)
            if v2 ~= 0 then
                return nil, v2
            end
        elseif v1 ~= 2 then
            return nil, -1
        else
            v2 = DecompressDynamicBlock(v4)
            if v2 ~= 0 then
                return nil, v2
            end
        end
    end
    local result_buffer = v4.result_buffer
    v2 = #v4.result_buffer + 1
    result_buffer[v2] = (concat(v4.buffer, "", 1, v4.buffer_size))
    return concat(v4.result_buffer), 0
end

local function DecompressDeflateInternal(a1, a2) -- Line: 2847
    -- upvalues: CreateDecompressState (val), Inflate (val)
    local v1 = CreateDecompressState(a1, a2)
    local v2, v3 = Inflate(v1)
    if not v2 then
        return nil, v3
    end
    v3 = v1.ReaderBitlenLeft()
    return v2, (v3 - v3 % 8) / 8
end

local function DecompressZlibInternal(a1, a2) -- Line: 2861
    -- upvalues: CreateDecompressState (val), Inflate (val), u1429 (val)
    local v1, v2, v3
    local v4 = CreateDecompressState(a1, a2)
    local ReadBits = v4.ReadBits
    local v5 = ReadBits(8)
    if v4.ReaderBitlenLeft() < 0 then
        return nil, 2
    end
    local v6 = v5 % 16
    local v7 = (v5 - v6) / 16
    if v6 ~= 8 then
        return nil, -12
    end
    if v7 > 7 then
        return nil, -13
    end
    v7 = ReadBits(8)
    if v4.ReaderBitlenLeft() < 0 then
        return nil, 2
    end
    if (v5 * 256 + v7) % 31 ~= 0 then
        return nil, -14
    end
    v6 = (v7 - v7 % 32) / 32 % 2
    v5 = (v7 - v7 % 64) / 64 % 4
    if v6 == 1 then
        if not a2 then
            return nil, -16
        end
        v7 = ReadBits(8)
        v5 = ReadBits(8)
        v1 = ReadBits(8)
        v2 = ReadBits(8)
        v3 = v7 * 16777216 + v5 * 65536 + v1 * 256 + v2
        if v4.ReaderBitlenLeft() < 0 then
            return nil, 2
        end
        local adler32 = a2.adler32
        if not (v3 % 4294967296 == adler32 % 4294967296) then
            return nil, -17
        end
    end
    v1, v2 = Inflate(v4)
    if not v1 then
        return nil, v2
    end
    v4.SkipToByteBoundary()
    v2 = ReadBits(8)
    v6 = ReadBits(8)
    v3 = ReadBits(8)
    local v8 = ReadBits(8)
    if v4.ReaderBitlenLeft() < 0 then
        return nil, 2
    end
    local v9 = v2 * 16777216 + v6 * 65536 + v3 * 256 + v8
    v8 = u1429:Adler32(v1)
    if not (v9 % 4294967296 == v8 % 4294967296) then
        return nil, -15
    end
    v8 = v4.ReaderBitlenLeft()
    return v1, (v8 - v8 % 8) / 8
end

function u1429.DecompressDeflate(a1, a2) -- Line: 2943
    -- upvalues: DecompressDeflateInternal (val)
    local v1, v2
    if type(a2) == "string" then
        v1 = true
        v2 = ""
    else
        v1 = false
        v2 = ("'str' - string expected got '%s'."):format((type(a2)))
    end
    if not v1 then
        error("Usage: LibDeflate:DecompressDeflate(str): " .. v2, 2)
    end
    return DecompressDeflateInternal(a2)
end

function u1429.DecompressDeflateWithDict(a1, a2, a3) -- Line: 2969
    -- upvalues: IsValidDictionary (val), DecompressDeflateInternal (val)
    local v1, v2
    if type(a2) == "string" then
        local v3, v4 = IsValidDictionary(a3)
        if v3 then
            v1 = true
            v2 = ""
        else
            v1 = false
            v2 = v4
        end
    else
        v1 = false
        v2 = ("'str' - string expected got '%s'."):format((type(a2)))
    end
    if not v1 then
        error("Usage: LibDeflate:DecompressDeflateWithDict(str, dictionary): " .. v2, 2)
    end
    return DecompressDeflateInternal(a2, a3)
end

function u1429.DecompressZlib(a1, a2) -- Line: 2990
    -- upvalues: DecompressZlibInternal (val)
    local v1, v2
    if type(a2) == "string" then
        v1 = true
        v2 = ""
    else
        v1 = false
        v2 = ("'str' - string expected got '%s'."):format((type(a2)))
    end
    if not v1 then
        error("Usage: LibDeflate:DecompressZlib(str): " .. v2, 2)
    end
    return DecompressZlibInternal(a2)
end

function u1429.DecompressZlibWithDict(a1, a2, a3) -- Line: 3016
    -- upvalues: IsValidDictionary (val), DecompressZlibInternal (val)
    local v1, v2
    if type(a2) == "string" then
        local v3, v4 = IsValidDictionary(a3)
        if v3 then
            v1 = true
            v2 = ""
        else
            v1 = false
            v2 = v4
        end
    else
        v1 = false
        v2 = ("'str' - string expected got '%s'."):format((type(a2)))
    end
    if not v1 then
        error("Usage: LibDeflate:DecompressZlibWithDict(str, dictionary): " .. v2, 2)
    end
    return DecompressZlibInternal(a2, a3)
end

u885 = {}
for i7 = 0, 143 do
    u885[i7] = 8
end
for i8 = 144, 255 do
    u885[i8] = 9
end
u885[256] = 7
u885[257] = 7
u885[258] = 7
u885[259] = 7
u885[260] = 7
u885[261] = 7
u885[262] = 7
u885[263] = 7
u885[264] = 7
u885[265] = 7
u885[266] = 7
u885[267] = 7
u885[268] = 7
u885[269] = 7
u885[270] = 7
u885[271] = 7
u885[272] = 7
u885[273] = 7
u885[274] = 7
u885[275] = 7
u885[276] = 7
u885[277] = 7
u885[278] = 7
u885[279] = 7
u885[280] = 8
u885[281] = 8
u885[282] = 8
u885[283] = 8
u885[284] = 8
u885[285] = 8
u885[286] = 8
u885[287] = 8
local v10 = {}
for i9 = 0, 31 do
    v10[i9] = 5
end
local v11, v12, v13 = GetHuffmanForDecode(u885, 287, 9)
u1062 = v12
assert(v11 == 0)
v11, v12, v13 = GetHuffmanForDecode(v10, 31, 5)
assert(v11 == 0)
GetHuffmanCodeFromBitlen(u1062, u885, 287, 9)
GetHuffmanCodeFromBitlen(v12, v10, 31, 5)
local u1314 = {
    ["\000"] = "%z",
    ["("] = "%(",
    [")"] = "%)",
    ["."] = "%.",
    ["%"] = "%%",
    ["+"] = "%+",
    ["-"] = "%-",
    ["*"] = "%*",
    ["?"] = "%?",
    ["["] = "%[",
    ["]"] = "%]",
    ["^"] = "%^",
    ["$"] = "%$",
}

local function escape_for_gsub(a1) -- Line: 3084 -- upvalues: u1314 (val) -- types: a1: string
    return (a1:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u1314))
end

function u1429.CreateCodec(a1, a2, a3, a4) -- Line: 3129
    -- upvalues: byte (val), sub (val), concat (val), u1314 (val), u1359 (val), gsub (val), find (val)
    local v1, v2, v3, v4, v5, v6, v7
    if type(a2) ~= "string" or type(a3) ~= "string" or type(a4) ~= "string" then
        error("Usage: LibDeflate:CreateCodec(reserved_chars, escape_chars, map_chars): All arguments must be string.", 2)
    end
    if a3 == "" then
        return nil, "No escape characters supplied."
    end
    if #a2 < #a4 then
        return nil, "The number of reserved characters must be at least as many as the number of mapped chars."
    end
    if a2 == "" then
        return nil, "No characters to encode."
    end
    local v8 = a2 .. a3 .. a4
    local v9 = {}
    local v10 = #v8
    for i = 1, v10 do
        v7 = byte(v8, i, i)
        if v9[v7] then
            return nil, "There must be no duplicate characters in the concatenation of reserved_chars, escape_chars and map_chars."
        end
        v9[v7] = true
    end
    local u313 = {}
    local u315 = {}
    local v11 = {}
    local u323 = {}
    if #a4 > 0 then
        local v12
        v1 = {}
        v2 = {}
        v3 = #a4
        for j = 1, v3 do
            v4 = sub(a2, j, j)
            v12 = sub(a4, j, j)
            u323[v4] = v12
            v11[#v11 + 1] = v4
            v2[v12] = v4
            v1[#v1 + 1] = v12
        end
        u313[#u313 + 1] = "([" .. ((concat(v1)):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u1314)) .. "])"
        u315[#u315 + 1] = v2
    end
    v1 = 1
    v2 = sub(a3, v1, v1)
    v3 = 0
    local v13 = {}
    local v14 = {}
    v4 = #v8
    for k = 1, v4 do
        v5 = sub(v8, k, k)
        if not u323[v5] then
            while true do
                if not (v3 >= 256) then
                    if not v9[v3] then
                        break
                    end
                end
                v3 = v3 + 1
                if v3 > 255 then
                    u313[#u313 + 1] = (v2:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u1314)) .. "([" .. ((concat(v13)):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u1314)) .. "])"
                    u315[#u315 + 1] = v14
                    v1 = v1 + 1
                    v2 = sub(a3, v1, v1)
                    v3 = 0
                    v13 = {}
                    v14 = {}
                    if v2 and v2 ~= "" then
                        continue
                    end
                    return nil, "Out of escape characters."
                end
            end
            v6 = u1359[v3]
            u323[v5] = v2 .. v6
            v11[#v11 + 1] = v5
            v14[v6] = v5
            v13[#v13 + 1] = v6
            v3 = v3 + 1
        end
        if k == #v8 then
            u313[#u313 + 1] = (v2:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u1314)) .. "([" .. ((concat(v13)):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u1314)) .. "])"
            u315[#u315 + 1] = v14
        end
    end
    v14 = {}
    local u345 = "([" .. ((concat(v11)):gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u1314)) .. "])"

    function v14.Encode(a1, a2) -- Line: 3243
        -- upvalues: gsub (upval), u345 (val), u323 (val)
        if type(a2) ~= "string" then
            error(("Usage: codec:Encode(str): 'str' - string expected got '%s'."):format((type(a2))), 2)
        end
        return (gsub(a2, u345, u323))
    end

    local u349 = #u313
    local u368 = "([" .. (a2:gsub("([%z%(%)%.%%%+%-%*%?%[%]%^%$])", u1314)) .. "])"

    function v14.Decode(a1, a2) -- Line: 3254
        -- upvalues: find (upval), u368 (val), u349 (val), gsub (upval), u313 (val), u315 (val)
        if type(a2) ~= "string" then
            error(("Usage: codec:Decode(str): 'str' - string expected got '%s'."):format((type(a2))), 2)
        end
        if find(a2, u368) then
            return nil
        end
        local v1 = a2
        for i = 1, u349 do
            v1 = gsub(v1, u313[i], u315[i])
        end
        return v1
    end

    return v14, ""
end

u1429.internals = {
    LoadStringToTable = LoadStringToTable,
    IsValidDictionary = IsValidDictionary,
    IsEqualAdler32 = IsEqualAdler32,
}
return (table.freeze(u1429))