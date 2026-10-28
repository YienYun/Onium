-- Script path: ReplicatedStorage.Shared.Modules.WispProgression
-- Decompile time: 2.38 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local WispQuests = require(ReplicatedStorage.Data.WispQuests)
local WispCompanion = require(ReplicatedStorage.Shared.Types.WispCompanion)
return table.freeze({
    IsReady = function(a1) -- Line: 6 -- upvalues: WispQuests (val)
        local Accepted = a1.Accepted
        if Accepted then
            Accepted = false
            if a1.Stage == WispQuests.StageCount then
                Accepted = not a1.Unlocked
            end
        end
        return Accepted
    end,
    HasClaimable = function(a1) -- Line: 10 -- upvalues: WispQuests (val)
        local v1 = WispQuests.List[a1.Stage]
        local Accepted = a1.Accepted
        if Accepted then
            Accepted = not a1.Unlocked
            if Accepted then
                Accepted = false
                if v1 ~= nil then
                    Accepted = not a1.Claimed[v1.Id] and v1.Target <= (a1.Progress[v1.Id] or 0)
                end
            end
        end
        return Accepted
    end,
    Progress = function(a1, a2, a3, a4) -- Line: 16
        -- upvalues: WispQuests (val), WispCompanion (val)
        local v1 = WispQuests.List[a1.Stage]
        if a1.Accepted and not a1.Unlocked and v1 and not a1.Claimed[v1.Id] and v1.Event == a2 then
            if typeof(a3) ~= "table" then
                return nil
            end
            local v2 = nil
            local v3 = nil
            for i, j in v1.Match, v2, v3 do
                if a3[i] ~= j then
                    return nil
                end
            end
            local v4 = a4 or 1
            if typeof(v4) == "number" and v4 == v4 and v4 ~= (1 / 0) and not (v4 <= 0) then
                v2 = a1.Progress[v1.Id] or 0
                v3 = math.min(v1.Target, v2 + (math.floor(v4)))
                if v3 == v2 then
                    return nil
                end
                v2 = WispCompanion.Copy(a1)
                v2.Progress[v1.Id] = v3
                return v2
            end
            return nil
        end
        return nil
    end,
    Claim = function(a1, a2) -- Line: 43 -- upvalues: WispQuests (val), WispCompanion (val) -- types: a2: string
        local v1 = WispQuests.List[a1.Stage]
        if a1.Accepted and not a1.Unlocked and v1 and v1.Id == a2 then
            if a1.Claimed[a2] then
                return nil, "You already claimed that reward."
            end
            if (a1.Progress[a2] or 0) < v1.Target then
                return nil, "Finish the quest first."
            end
            v1 = WispCompanion.Copy(a1)
            v1.Claimed[a2] = true
            v1.Stage = v1.Stage + 1
            v1.Essence = 0
            return v1
        end
        return nil, "That quest is not active."
    end,
})