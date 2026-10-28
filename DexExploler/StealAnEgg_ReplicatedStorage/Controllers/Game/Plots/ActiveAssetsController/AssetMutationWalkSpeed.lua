-- Script path: ReplicatedStorage.Controllers.Game.Plots.ActiveAssetsController.AssetMutationWalkSpeed
-- Decompile time: 1.19 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AssetItem = require(ReplicatedStorage.Shared.Types.AssetItem)
local u17 = require(ReplicatedStorage.Shared.Modules.Mutations).Ids()
local v1 = {}

local function hasMutation(a1, a2) -- Line: 20 -- types: a2: string
    local v1 = true
    if a1.BaseMutation ~= a2 then
        v1 = table.find(a1.Mutations, a2) ~= nil
    end
    return v1
end

function v1.GetMultiplier(a1) -- Line: 28 -- upvalues: AssetItem (val), u17 (val)
    assert(AssetItem.AssetItemData(a1), "Invalid asset item data")
    local Rainbow = u17.Rainbow
    local v1 = true
    if a1.BaseMutation ~= Rainbow then
        v1 = table.find(a1.Mutations, Rainbow) ~= nil
    end
    if v1 then
        return 2
    end
    local Golden = u17.Golden
    v1 = true
    if a1.BaseMutation ~= Golden then
        v1 = table.find(a1.Mutations, Golden) ~= nil
    end
    if v1 then
        return 0.5
    end
    local Silver = u17.Silver
    v1 = true
    if a1.BaseMutation ~= Silver then
        v1 = table.find(a1.Mutations, Silver) ~= nil
    end
    if v1 then
        return 0.7
    end
    return 1
end

return v1