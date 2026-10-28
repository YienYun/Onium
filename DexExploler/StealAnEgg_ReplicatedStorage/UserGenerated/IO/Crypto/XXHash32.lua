-- Script path: ReplicatedStorage.UserGenerated.IO.Crypto.XXHash32
-- Decompile time: 6.74 ms

local function mult(a1, a2) -- Line: 37 -- types: a1: number, a2: number
    return bit32.band(a1, 65535) * a2 + bit32.lshift(bit32.band(bit32.rshift(a1, 16) * a2, 65535), 16)
end

return function(a1, a2) -- Line: 50 -- types: a1: string, a2: number?
    local v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = if a2 ~= nil then bit32.bor(a2, 0) else 0
    local v10 = #a1
    local v11 = 1
    local v12 = 1
    if not (v10 >= 16) then
        v7 = bit32.bor(v9 + 374761393, 0)
    else
        local v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26, v27, v28
        v8 = v9 + 2654435761 + 2246822519
        local v29 = v9 + 2246822519
        local v30 = v9
        v1 = v9 - 2654435761
        v2 = v10 - 16
        for i = 0, v2, 16 do
            v5, v6, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25, v26 = string.byte(a1, v12, v12 + 15)
            v28 = bit32.bor(bit32.lshift(v14, 24), bit32.lshift(v13, 16), bit32.lshift(v6, 8), v5)
            v27 = bit32.lrotate(
                v8 + (bit32.band(v28, 65535) * 2246822519 + bit32.lshift(bit32.band(bit32.rshift(v28, 16) * 2246822519, 65535), 16)),
                13
            )
            v8 = bit32.band(v27, 65535) * 2654435761 + bit32.lshift(bit32.band(bit32.rshift(v27, 16) * 2654435761, 65535), 16)
            v28 = bit32.bor(bit32.lshift(v18, 24), bit32.lshift(v17, 16), bit32.lshift(v16, 8), v15)
            v27 = bit32.lrotate(
                v29 + (bit32.band(v28, 65535) * 2246822519 + bit32.lshift(bit32.band(bit32.rshift(v28, 16) * 2246822519, 65535), 16)),
                13
            )
            v29 = bit32.band(v27, 65535) * 2654435761 + bit32.lshift(bit32.band(bit32.rshift(v27, 16) * 2654435761, 65535), 16)
            v28 = bit32.bor(bit32.lshift(v22, 24), bit32.lshift(v21, 16), bit32.lshift(v20, 8), v19)
            v27 = bit32.lrotate(
                v30 + (bit32.band(v28, 65535) * 2246822519 + bit32.lshift(bit32.band(bit32.rshift(v28, 16) * 2246822519, 65535), 16)),
                13
            )
            v30 = bit32.band(v27, 65535) * 2654435761 + bit32.lshift(bit32.band(bit32.rshift(v27, 16) * 2654435761, 65535), 16)
            v28 = bit32.bor(bit32.lshift(v26, 24), bit32.lshift(v25, 16), bit32.lshift(v24, 8), v23)
            v27 = bit32.lrotate(
                v1 + (bit32.band(v28, 65535) * 2246822519 + bit32.lshift(bit32.band(bit32.rshift(v28, 16) * 2246822519, 65535), 16)),
                13
            )
            v1 = bit32.band(v27, 65535) * 2654435761 + bit32.lshift(bit32.band(bit32.rshift(v27, 16) * 2654435761, 65535), 16)
            v11 = v11 + 4
            v12 = v12 + 16
        end
        v7 = (bit32.lrotate(v8, 1)) + bit32.lrotate(v29, 7) + bit32.lrotate(v30, 12) + bit32.lrotate(v1, 18)
    end
    v7 = bit32.bor(v7 + v10, 0)
    v8 = v10 // 4
    for j = v11, v8 do
        v1, v2, v3, v4 = string.byte(a1, v12, v12 + 3)
        v6 = bit32.bor(bit32.lshift(v4, 24), bit32.lshift(v3, 16), bit32.lshift(v2, 8), v1)
        v7 = v7 + (bit32.band(v6, 65535) * 3266489917 + (bit32.lshift(bit32.band(bit32.rshift(v6, 16) * 3266489917, 65535), 16)))
        v5 = bit32.lrotate(v7, 17)
        v7 = bit32.band(v5, 65535) * 668265263 + bit32.lshift(bit32.band(bit32.rshift(v5, 16) * 668265263, 65535), 16)
        v11 = v11 + 1
        v12 = v12 + 4
    end
    for k = -(v10 % 4), -1 do
        v2 = string.byte(a1, k)
        v7 = v7 + (bit32.band(v2, 65535) * 374761393 + (bit32.lshift(bit32.band(bit32.rshift(v2, 16) * 374761393, 65535), 16)))
        v1 = bit32.lrotate(v7, 11)
        v7 = bit32.band(v1, 65535) * 2654435761 + bit32.lshift(bit32.band(bit32.rshift(v1, 16) * 2654435761, 65535), 16)
    end
    v8 = bit32.bxor(v7, (bit32.rshift(v7, 15)))
    v7 = bit32.band(v8, 65535) * 2246822519 + bit32.lshift(bit32.band(bit32.rshift(v8, 16) * 2246822519, 65535), 16)
    v8 = bit32.bxor(v7, (bit32.rshift(v7, 13)))
    v7 = bit32.band(v8, 65535) * 3266489917 + bit32.lshift(bit32.band(bit32.rshift(v8, 16) * 3266489917, 65535), 16)
    return (bit32.bxor(v7, (bit32.rshift(v7, 16))))
end