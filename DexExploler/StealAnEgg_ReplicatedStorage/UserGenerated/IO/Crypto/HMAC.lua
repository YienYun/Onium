-- Script path: ReplicatedStorage.UserGenerated.IO.Crypto.HMAC
-- Decompile time: 1.74 ms

require(game.ReplicatedStorage.UserGenerated.IO.Crypto.Hash)

local function Derive(a1, a2) -- Line: 46 -- types: a2: buffer
    local v1, v2
    local BlockSize = a1.BlockSize
    local v3 = a2
    if BlockSize < buffer.len(v3) then
        v3 = a1.DigestBuffer(v3)
    end
    local v4 = buffer.create(BlockSize)
    buffer.copy(v4, 0, v3)
    local u24 = buffer.create(BlockSize)
    local u27 = buffer.create(BlockSize)
    local v5 = BlockSize - 1
    for i = 0, v5 do
        v2 = buffer.readu8(v4, i)
        v1 = bit32.bxor(v2, 92)
        buffer.writeu8(u24, i, v1)
        v1 = bit32.bxor(v2, 54)
        buffer.writeu8(u27, i, v1)
    end

    local function ComputeHmac(a1_2) -- Line: 69
        -- upvalues: BlockSize (val), u27 (val), a1 (val), u24 (val)
        local v1 = buffer.create(BlockSize + buffer.len(a1_2))
        buffer.copy(v1, 0, u27)
        buffer.copy(v1, BlockSize, a1_2)
        local v2 = a1.DigestBuffer(v1)
        v1 = buffer.create(BlockSize + buffer.len(v2))
        buffer.copy(v1, 0, u24)
        buffer.copy(v1, BlockSize, v2)
        return a1.DigestBuffer(v1)
    end

    return {
        Name = "HMAC-" .. a1.Name,
        BlockSize = a1.BlockSize,
        OutputSize = a1.OutputSize,
        Digest = function(a1) -- Line: 89 -- upvalues: ComputeHmac (val)
            return buffer.tostring(ComputeHmac(buffer.fromstring(a1)))
        end,
        DigestBuffer = ComputeHmac,
        DigestToBuffer = function(a1) -- Line: 93 -- upvalues: ComputeHmac (val)
            return ComputeHmac(buffer.fromstring(a1))
        end,
    }
end

return {
    Derive = Derive,
    DeriveString = function(a1, a2) -- Line: 108 -- upvalues: Derive (val) -- types: a2: string
        return (Derive(a1, buffer.fromstring(a2)))
    end,
}