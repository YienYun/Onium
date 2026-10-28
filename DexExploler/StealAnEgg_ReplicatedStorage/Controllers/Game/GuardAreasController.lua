-- Script path: ReplicatedStorage.Controllers.Game.GuardAreasController
-- Decompile time: 4.48 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local ForestGuardRuntime = require(script.ForestGuardRuntime)
local GuardComponent = require(script.GuardComponent)
local GuardEscapeSignController = require(script.GuardEscapeSignController)
local GuardTutorialController = require(script.GuardTutorialController)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Promise = require(ReplicatedStorage.Packages.Promise)
local u34 = {}
local u35 = {}
local u36 = {}
return {
    Start = function() -- Line: 32
        -- upvalues: GuardTutorialController (val), Workspace (val), u35 (val), u34 (val)
        -- upvalues: GuardEscapeSignController (val), ForestGuardRuntime (val), GuardComponent (val), u36 (val)
        -- upvalues: Remotes (val), Promise (val)
        local u2 = GuardTutorialController.new()
        task.spawn(function() -- Line: 34 -- upvalues: u2 (val)
            u2:Start()
        end)
        local u6 = true
        local u7 = -1
        local World = Workspace:WaitForChild("World")
        assert(World:IsA("Folder"), "Workspace.World must be a Folder")
        local Areas = World:WaitForChild("Areas")
        assert(Areas:IsA("Folder"), "Workspace.World.Areas must be a Folder")
        local u35_2 = Areas:WaitForChild("GuardAreas")
        assert(u35_2:IsA("Folder"), "Workspace.World.Areas.GuardAreas must be a Folder")

        local function applyGuardsEnabled(a1, a2) -- Line: 47
            -- upvalues: u7 (ref), u6 (ref), u35 (upval)
            if a2 < u7 then
                return
            end
            u6 = a1
            u7 = a2
            for k, v in pairs(u35) do
                if v ~= nil and v.ForestRuntime ~= nil then
                    v.ForestRuntime:SetEnabled(a1)
                end
            end
        end

        local function setupAreaModel(a1) -- Line: 64
            -- upvalues: u34 (upval), GuardEscapeSignController (upval), u35 (upval), ForestGuardRuntime (upval)
            -- upvalues: GuardComponent (upval), u35_2 (val), u36 (upval), u6 (ref)
            local u32
            if u34[a1] == nil then
                u34[a1] = (GuardEscapeSignController.new(a1))
            end
            if u35[a1] ~= nil then
                return
            end
            local v1 = nil
            if a1.Name ~= "Forest" then
                u32 = GuardComponent.new(a1)
            else
                local v2 = ForestGuardRuntime.new(a1)
                v1 = v2
                u32 = GuardComponent.new(a1)
                v2:SetWakeHandler(function(a1) -- Line: 79 -- upvalues: u32 (ref) -- types: a1: userdata
                    u32:PlayWakeUp()
                end)
            end
            if a1.Parent ~= u35_2 then
                u32:Destroy()
                if v1 ~= nil then
                    v1:Destroy()
                end
                return
            end
            u35[a1] = {ForestRuntime = v1, Guard = u32}
            u36[u32:GetGuardModel()] = u32
            if v1 ~= nil then
                v1:SetEnabled(u6)
                v1:Start()
            end
        end

        local function cleanupAreaModel(a1) -- Line: 105
            -- upvalues: u34 (upval), u35 (upval), u36 (upval)
            local v1 = u34[a1]
            if v1 ~= nil then
                u34[a1] = nil
                v1:Destroy()
            end
            v1 = u35[a1]
            if v1 == nil then
                return
            end
            u35[a1] = nil
            u36[(v1.Guard:GetGuardModel())] = nil
            v1.Guard:Destroy()
            if v1.ForestRuntime ~= nil then
                v1.ForestRuntime:Destroy()
            end
        end

        u35_2.ChildAdded:Connect(function(a1) -- Line: 128 -- upvalues: setupAreaModel (val) -- types: a1: userdata
            assert(a1:IsA("Model"), (("%* must be a guard area Model"):format((a1:GetFullName()))))
            setupAreaModel(a1)
        end)
        u35_2.ChildRemoved:Connect(function(a1) -- Line: 136 -- upvalues: cleanupAreaModel (val) -- types: a1: userdata
            assert(a1:IsA("Model"), (("%* must be a guard area Model"):format((a1:GetFullName()))))
            cleanupAreaModel(a1)
        end)
        for i, v in ipairs(u35_2:GetChildren()) do
            assert(v:IsA("Model"), (("%* must be a guard area Model"):format((v:GetFullName()))))
            task.spawn(setupAreaModel, v)
        end
        Remotes.GuardPatrol.Rouse.OnClientEvent:Connect(function(a1) -- Line: 152 -- upvalues: u36 (upval) -- types: a1: userdata
            local v1 = u36[a1]
            if v1 == nil then
                return
            end
            v1:PlayWakeUp()
        end)
        Remotes.GuardPatrol.EnabledShifted.OnClientEvent:Connect(applyGuardsEnabled)
        task.spawn(function() -- Line: 162 -- upvalues: u7 (ref), Promise (upval), Remotes (upval), applyGuardsEnabled (val)
            local v1, v2, v3
            while u7 < 0 do
                v1, v2, v3 = Promise.try(function() -- Line: 164 -- upvalues: Remotes (upval)
                    return Remotes.GuardPatrol.AskEnabled:InvokeServer()
                end):timeout(30):await()
                if v1 and typeof(v2) == "boolean" and typeof(v3) == "number" then
                    applyGuardsEnabled(v2, v3)
                    return
                end
                task.wait(1)
            end
        end)
    end,
}