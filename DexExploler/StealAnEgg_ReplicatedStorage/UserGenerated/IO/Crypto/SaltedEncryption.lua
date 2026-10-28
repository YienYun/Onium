-- Script path: ReplicatedStorage.UserGenerated.IO.Crypto.SaltedEncryption
-- Decompile time: 8.66 ms

local AES = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.AES)
local Base64 = require(game.ReplicatedStorage.UserGenerated.IO.Base64)
local HMAC = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.HMAC)
local ISAAC = require(game.ReplicatedStorage.UserGenerated.Randoms.ISAAC)
local SHA256 = require(game.ReplicatedStorage.UserGenerated.IO.Crypto.SHA256)
require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)
local u47 = ISAAC.Unique()

local function GetRandomBytes(a1) -- Line: 44 -- upvalues: u47 (val) -- types: a1: number
    local v1
    local v2 = buffer.create(a1)
    local v3 = a1 - 1
    for i = 0, v3 do
        v1 = u47:NextInteger(0, 255)
        buffer.writeu8(v2, i, v1)
    end
    return v2
end

local function PBKDF2(a1, a2, a3, a4, a5) -- Line: 62
    -- upvalues: HMAC (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = HMAC.Derive(a5, a1)
    local OutputSize = a5.OutputSize
    local v8 = math.ceil(a3 / OutputSize)
    local v9 = buffer.create(a3)
    local v10 = 0
    local v11, v12, v13 = a2, a4, a3
    for i = 1, v8 do
        v1 = buffer.create(buffer.len(v11) + 4)
        buffer.copy(v1, 0, v11)
        v3 = buffer.len(v11)
        v4 = bit32.byteswap(i)
        buffer.writeu32(v1, v3, v4)
        v2 = v7.DigestBuffer(v1)
        v1 = buffer.create(buffer.len(v2))
        buffer.copy(v1, 0, v2)
        for j = 2, v12 do
            v2 = v7.DigestBuffer(v2)
            v5 = buffer.len(v2) - 1
            for k = 0, v5 do
                v6 = bit32.bxor(buffer.readu8(v1, k), (buffer.readu8(v2, k)))
                buffer.writeu8(v1, k, v6)
            end
        end
        v2 = math.min(OutputSize, v13 - v10)
        buffer.copy(v9, v10, v1, 0, v2)
        v10 = v10 + v2
    end
    return v9
end

local function ApplyPKCS7Padding(a1) -- Line: 109 -- types: a1: buffer
    local v1 = buffer.len(a1)
    local v2 = 16 - v1 % 16
    local v3 = v1 + v2
    local v4 = buffer.create(v3)
    buffer.copy(v4, 0, a1)
    local v5 = v3 - 1
    for i = v1, v5 do
        buffer.writeu8(v4, i, v2)
    end
    return v4
end

local function RemovePKCS7Padding(a1) -- Line: 131 -- types: a1: buffer
    local v1 = buffer.len(a1)
    if v1 == 0 then
        error("Invalid padding: empty input")
    end
    local v2 = v1 - 1
    local v3 = buffer.readu8(a1, v2)
    if v3 < 1 or v3 > 16 then
        error("Invalid padding length: " .. v3)
    end
    local v4 = v1 - v3
    local v5 = v1 - 1
    local v6 = a1
    for i = v4, v5 do
        if buffer.readu8(v6, i) ~= v3 then
            error("Invalid padding")
        end
    end
    v5 = v1 - v3
    v3 = buffer.create(v5)
    buffer.copy(v3, 0, v6, 0, v5)
    return v3
end

local function Encrypt(a1, a2, a3) -- Line: 166
    -- upvalues: SHA256 (val), GetRandomBytes (val), PBKDF2 (val), ApplyPKCS7Padding (val), AES (val), Base64 (val)
    local v1 = buffer.fromstring(a1)
    local v2 = GetRandomBytes(8)
    local v3 = PBKDF2(a2, v2, 48, 10000, a3 or SHA256)
    local v4 = buffer.create(32)
    buffer.copy(v4, 0, v3, 0, 32)
    local v5 = buffer.create(16)
    buffer.copy(v5, 0, v3, 32, 16)
    v3 = ApplyPKCS7Padding(v1)
    v4 = AES.new(buffer.tostring(v4), AES.modes.CBC, AES.pads.None):Encrypt(v3, nil, v5)
    v5 = 16 + buffer.len(v4)
    v3 = buffer.create(v5)
    buffer.writestring(v3, 0, "Salted__")
    buffer.copy(v3, 8, v2)
    buffer.copy(v3, 16, v4)
    return buffer.tostring(Base64.EncodeBuffer(v3))
end

local function Decrypt(a1, a2, a3) -- Line: 220
    -- upvalues: SHA256 (val), Base64 (val), PBKDF2 (val), AES (val), RemovePKCS7Padding (val)
    local v1 = Base64.DecodeBuffer(buffer.fromstring(a1))
    if (buffer.len(v1)) < 16 then
        error("Invalid data: too short")
    end
    local v2 = buffer.create(8)
    buffer.copy(v2, 0, v1, 0, 8)
    if buffer.tostring(v2) ~= "Salted__" then
        error("Invalid data: Missing 'Salted__' header")
    end
    local v3 = buffer.create(8)
    buffer.copy(v3, 0, v1, 8, 8)
    v2 = buffer.len(v1) - 16
    local v4 = buffer.create(v2)
    buffer.copy(v4, 0, v1, 16, v2)
    v2 = PBKDF2(a2, v3, 48, 10000, a3 or SHA256)
    v3 = buffer.create(32)
    buffer.copy(v3, 0, v2, 0, 32)
    v1 = buffer.create(16)
    buffer.copy(v1, 0, v2, 32, 16)
    v4 = RemovePKCS7Padding((AES.new(buffer.tostring(v3), AES.modes.CBC, AES.pads.None):Decrypt(v4, nil, v1)))
    return buffer.tostring(v4)
end

local v1 = {
    Encrypt = Encrypt,
    Decrypt = Decrypt,
    EncryptString = function(a1, a2, a3) -- Line: 281 -- upvalues: Encrypt (val) -- types: a1: string, a2: string
        return Encrypt(a1, buffer.fromstring(a2), a3)
    end,
    DecryptString = function(a1, a2, a3) -- Line: 294 -- upvalues: Decrypt (val) -- types: a1: string, a2: string
        return Decrypt(a1, buffer.fromstring(a2), a3)
    end,
    PBKDF2 = PBKDF2,
    GetRandomBytes = GetRandomBytes,
}
table.freeze(v1)
return v1