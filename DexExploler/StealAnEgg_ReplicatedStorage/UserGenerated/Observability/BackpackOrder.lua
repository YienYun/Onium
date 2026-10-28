-- Script path: ReplicatedStorage.UserGenerated.Observability.BackpackOrder
-- Decompile time: 1.27 ms

local u0 = {}
u0.__index = u0

function u0.new(a1) -- Line: 6 -- upvalues: u0 (val)
    return (setmetatable({Guessed = true, Count = a1, Slots = table.create(a1, 0)}, u0))
end

function u0.Add(a1, a2) -- Line: 10
    if not a1.Guessed then
        return
    end
    local Count = a1.Count
    for i = 1, Count do
        if a1.Slots[i] == 0 then
            a1.Slots[i] = a2
            return
        end
    end
end

function u0:Remove(a2) -- Line: 17
    local Slots, v1
    local Count = self.Count
    local v2, v3 = self, a2
    for i = 1, Count do
        if v2.Slots[i] == v3 then
            Slots = v2.Slots
            v1 = if not v2.Guessed then -1 else 0
            Slots[i] = v1
        end
    end
end

function u0:Invalidate() -- Line: 25
    self.Guessed = false
    local Count = self.Count
    for i = 1, Count do
        self.Slots[i] = -1
    end
end

function u0.Recover(a1, a2, a3) -- Line: 30
    if not (a2 < 1) and not (a1.Count < a2) then
        if a1.Guessed and a1.Slots[a2] ~= a3 then
            a1:Invalidate()
        end
        a1:Remove(a3)
        a1.Slots[a2] = a3
        return
    end
end

return u0