-- Script path: ReplicatedStorage.Shared.Types.GhostDogQuest
-- Decompile time: 1.02 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local u9 = {}
u9.Artifacts = t.strictInterface({Collar = t.boolean, Bone = t.boolean, Toy = t.boolean, Photo = t.boolean})
u9.State = t.strictInterface({
    Stage = t.intersection(t.integer, t.numberConstrained(0, 4)),
    Artifacts = u9.Artifacts,
    Ticket = t.boolean,
})

function u9.BlankArtifacts() -- Line: 39
    return {Collar = false, Bone = false, Toy = false, Photo = false}
end

function u9.Blank() -- Line: 43 -- upvalues: u9 (val)
    return {Stage = 0, Ticket = false, Artifacts = u9.BlankArtifacts()}
end

function u9.Copy(a1) -- Line: 51 -- types: a1: table
    return {
        Stage = a1.Stage,
        Artifacts = table.clone(a1.Artifacts),
        Ticket = a1.Ticket,
    }
end

function u9.CountFound(a1) -- Line: 59 -- types: a1: table
    local v1 = 0
    for i, j in a1.Artifacts do
        if j then
            v1 = v1 + 1
        end
    end
    return v1
end

return table.freeze(u9)