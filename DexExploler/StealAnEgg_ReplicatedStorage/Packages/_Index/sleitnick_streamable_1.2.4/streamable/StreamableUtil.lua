-- Script path: ReplicatedStorage.Packages._Index.sleitnick_streamable@1.2.4.streamable.StreamableUtil
-- Decompile time: 1.37 ms

local Trove = require(script.Parent.Parent.Trove)
require(script.Parent.Streamable)
return {
    Compound = function(a1, a2) -- Line: 47 -- upvalues: Trove (val) -- types: a1: table, a2: function
        local v1 = Trove.new()
        local u7 = Trove.new()
        local u8 = false

        local function Check() -- Line: 51 -- upvalues: u8 (ref), a1 (val), a2 (val), u7 (val)
            if u8 then
                return
            end
            for k, v in pairs(a1) do
                if not v.Instance then
                    return
                end
            end
            u8 = true
            a2(a1, u7)
        end

        local function Cleanup() -- Line: 63 -- upvalues: u8 (ref), u7 (val)
            if not u8 then
                return
            end
            u8 = false
            u7:Clean()
        end

        for k, v in pairs(a1) do
            v1:Add((v:Observe(function(a1_2, a2_2) -- Line: 71 -- upvalues: u8 (ref), a1 (val), a2 (val), u7 (val), Cleanup (val)
                if not u8 then
                    for k, v in pairs(a1) do
                        if not v.Instance then
                            a2_2:Add(Cleanup)
                            return
                        end
                    end
                    u8 = true
                    a2(a1, u7)
                end
                a2_2:Add(Cleanup)
            end)))
        end
        v1:Add(Cleanup)
        return v1
    end,
}