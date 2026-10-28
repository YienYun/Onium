-- Script path: ReplicatedStorage.Controllers.Game.AreaEggsController.NestResolver
-- Decompile time: 0.95 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local AreaEggSlotIdentity = require(ReplicatedStorage.Shared.Util.AreaEggSlotIdentity)
require(ReplicatedStorage.Shared.Types.AreaEggs)
local t = require(ReplicatedStorage.Packages.t)
local World = Workspace.World
assert(World:IsA("Folder"), "Workspace.World must be a Folder")
local Areas = World.Areas
assert(Areas:IsA("Folder"), "Workspace.World.Areas must be a Folder")
local GuardAreas = Areas.GuardAreas
assert(GuardAreas:IsA("Folder"), "Workspace.World.Areas.GuardAreas must be a Folder")
return {
    Resolve = function(a1) -- Line: 42 -- upvalues: t (val), GuardAreas (val), AreaEggSlotIdentity (val)
        t.strict(t.string)(a1.AreaId)
        t.strict(t.string)(a1.NestId)
        local v1 = GuardAreas[a1.AreaId]
        assert(v1:IsA("Model"), (("Guard area %* must be a Model"):format(a1.AreaId)))
        return AreaEggSlotIdentity.NestFor(v1, a1.NestId)
    end,
}