-- Script path: ReplicatedStorage.Controllers.Game.BanjoCricketController.Band
-- Decompile time: 2.72 ms

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local AnimationAssets = require(ReplicatedStorage.Shared.Utils.AnimationAssets)
local BanjoCricket = require(ReplicatedStorage.Data.BanjoCricket)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u28 = {}
local v1 = {}

local function unbind(a1) -- Line: 17 -- upvalues: u28 (val) -- types: a1: userdata
    local v1 = u28[a1]
    if v1 then
        u28[a1] = nil
        v1:Destroy()
    end
end

local function bind(a1) -- Line: 25
    -- upvalues: u28 (val), Workspace (val), Trove (val), BanjoCricket (val), AnimationAssets (val)
    if not u28[a1] and a1:IsA("Model") then
        local v1 = Workspace
        if a1:IsDescendantOf(v1) then
            local Animator = a1:FindFirstChildWhichIsA("Animator", true)
            if Animator == nil then
                return
            end
            local v2 = Trove.new()
            u28[a1] = v2
            v2:Connect(a1.Destroying, function() -- Line: 39 -- upvalues: a1 (val), u28 (upval)
                local v1 = a1
                local v2 = u28[v1]
                if v2 then
                    u28[v1] = nil
                    v2:Destroy()
                end
            end)
            v1 = BanjoCricket.PerformerAnimations[a1.Name]
            local v3 = ("No Banjo Cricket performer animation for %*"):format(a1.Name)
            assert(v1 ~= nil, v3)
            local u44 = AnimationAssets.Get(v1)
            local success, err = pcall(function() -- Line: 45 -- upvalues: Animator (val), u44 (val)
                return Animator:LoadAnimation(u44)
            end)
            if not success then
                v1 = u28[a1]
                if v1 then
                    u28[a1] = nil
                    v1:Destroy()
                end
                warn((("Could not load %*'s animation: %*"):format(a1.Name, err)))
                return
            end
            if u28[a1] ~= v2 then
                err:Destroy()
                return
            end
            v2:Add(err)
            err.Looped = true
            err.Priority = Enum.AnimationPriority.Idle
            err:Play(0.15)
            return
        end
    end
end

function v1.Start() -- Line: 63 -- upvalues: BanjoCricket (val), CollectionService (val), bind (val), unbind (val)
    local Performer = BanjoCricket.Tags.Performer
    ;(CollectionService:GetInstanceAddedSignal(Performer)):Connect(bind)
    ;(CollectionService:GetInstanceRemovedSignal(Performer)):Connect(unbind)
    for i, j in CollectionService:GetTagged(Performer) do
        bind(j)
    end
end

return table.freeze(v1)