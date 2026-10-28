-- Script path: ReplicatedStorage.Controllers.Game.Eggs.EggToolDisplayController
-- Decompile time: 5.90 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EggState = require(ReplicatedStorage.Client.EggState)
local EggToolDisplay = require(ReplicatedStorage.Shared.Eggs.EggToolDisplay)
local Log = require(ReplicatedStorage.Packages.Log)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u29 = Log.new()
local u30 = {}
return {
    Start = function() -- Line: 29
        -- upvalues: EggToolDisplay (val), u29 (val), EggState (val), Players (val), Trove (val), u30 (val)
        local function destroyActiveDisplay(a1) -- Line: 34 -- types: a1: table
            a1.ActiveDisplayVersion = a1.ActiveDisplayVersion + 1
            if a1.ActiveDisplay ~= nil then
                a1.ActiveDisplay:Destroy()
                a1.ActiveDisplay = nil
            end
            a1.ActiveTool = nil
        end

        local function attachTool(a1, a2) -- Line: 43
            -- upvalues: EggToolDisplay (upval), u29 (upval), EggState (upval), Players (upval)
            if a1.ActiveTool == a2 then
                return
            end
            a1.ActiveDisplayVersion = a1.ActiveDisplayVersion + 1
            if a1.ActiveDisplay ~= nil then
                a1.ActiveDisplay:Destroy()
                a1.ActiveDisplay = nil
            end
            a1.ActiveTool = nil
            local v1 = EggToolDisplay.GetToolUid(a2)
            if v1 == nil then
                (u29:AtError()):Log((("Egg tool %* is missing an egg UID"):format((a2:GetFullName()))))
                return
            end
            local v2 = EggState.ReadOwnedEgg(a1.Owner.UserId, v1)
            if v2 == nil and a1.Owner == Players.LocalPlayer then
                v2 = EggState.FetchEggRecord(v1)
            end
            if v2 == nil then
                (u29:AtDebug()):Log((("Egg tool %* has no record for owner %*"):format(a2:GetFullName(), a1.Owner.UserId)))
                return
            end
            a1.ActiveTool = a2
            a1.ActiveDisplayVersion = a1.ActiveDisplayVersion + 1
            local ActiveDisplayVersion = a1.ActiveDisplayVersion
            local v3 = EggToolDisplay.new(a2, {
                OwnerUserId = a1.Owner.UserId,
                UID = v1,
                ModelName = ("%*_%*"):format(a1.Owner.UserId, v1),
                Record = v2,
            })
            if a1.ActiveTool == a2 and a1.ActiveDisplayVersion == ActiveDisplayVersion and a2.Parent ~= nil then
                a1.ActiveDisplay = v3
                return
            end
            v3:Destroy()
        end

        local function refreshActiveTool(a1) -- Line: 88
            -- upvalues: EggToolDisplay (upval), attachTool (val)
            local Character = a1.Owner.Character
            if Character == nil then
                return
            end
            for i, v in ipairs(Character:GetChildren()) do
                if v.ClassName == "Tool" and EggToolDisplay.IsEggTool(v) then
                    attachTool(a1, v)
                    return
                end
            end
        end

        local function bindCharacter(a1, a2) -- Line: 105
            -- upvalues: Trove (upval), EggToolDisplay (upval), attachTool (val), refreshActiveTool (val)
            if a1.CharacterTrove ~= nil then
                a1.CharacterTrove:Destroy()
            end
            a1.ActiveDisplayVersion = a1.ActiveDisplayVersion + 1
            if a1.ActiveDisplay ~= nil then
                a1.ActiveDisplay:Destroy()
                a1.ActiveDisplay = nil
            end
            a1.ActiveTool = nil
            local v1 = Trove.new()
            a1.CharacterTrove = v1
            v1:Connect(a2.ChildAdded, function(a1_2) -- Line: 113 -- upvalues: EggToolDisplay (upval), attachTool (upval), a1 (val) -- types: a1_2: userdata
                if a1_2.ClassName == "Tool" and EggToolDisplay.IsEggTool(a1_2) then
                    attachTool(a1, a1_2)
                end
            end)
            v1:Connect(a2.ChildRemoved, function(a1_2) -- Line: 118 -- upvalues: a1 (val) -- types: a1_2: userdata
                if a1_2 == a1.ActiveTool then
                    local v1 = a1
                    v1.ActiveDisplayVersion = v1.ActiveDisplayVersion + 1
                    if v1.ActiveDisplay ~= nil then
                        v1.ActiveDisplay:Destroy()
                        v1.ActiveDisplay = nil
                    end
                    v1.ActiveTool = nil
                end
            end)
            refreshActiveTool(a1)
        end

        local function syncActiveParasite(a1) -- Line: 126
            -- upvalues: EggToolDisplay (upval), EggState (upval)
            local ActiveTool = a1.ActiveTool
            local ActiveDisplay = a1.ActiveDisplay
            if ActiveTool ~= nil and ActiveDisplay ~= nil then
                local v1 = EggToolDisplay.GetToolUid(ActiveTool)
                if v1 == nil then
                    return
                end
                local v2 = EggState.ReadOwnedEgg(a1.Owner.UserId, v1)
                if v2 == nil then
                    return
                end
                ActiveDisplay:SyncParasite(v2.HasParasite)
                return
            end
        end

        local function trackPlayer(a1) -- Line: 156
            -- upvalues: u30 (upval), Trove (upval), bindCharacter (val)
            local v1 = u30[a1]
            if v1 ~= nil then
                v1.ActiveDisplayVersion = v1.ActiveDisplayVersion + 1
                if v1.ActiveDisplay ~= nil then
                    v1.ActiveDisplay:Destroy()
                    v1.ActiveDisplay = nil
                end
                v1.ActiveTool = nil
                if v1.CharacterTrove ~= nil then
                    v1.CharacterTrove:Destroy()
                end
                v1.Trove:Destroy()
                u30[a1] = nil
            end
            local u27 = {ActiveDisplayVersion = 0, Owner = a1}
            u27.Trove = Trove.new()
            u30[a1] = u27
            u27.Trove:Connect(a1.CharacterAdded, function(a1) -- Line: 171 -- upvalues: bindCharacter (upval), u27 (val) -- types: a1: userdata
                bindCharacter(u27, a1)
            end)
            u27.Trove:Connect(a1.CharacterRemoving, function() -- Line: 173 -- upvalues: u27 (val)
                local v1 = u27
                v1.ActiveDisplayVersion = v1.ActiveDisplayVersion + 1
                if v1.ActiveDisplay ~= nil then
                    v1.ActiveDisplay:Destroy()
                    v1.ActiveDisplay = nil
                end
                v1.ActiveTool = nil
                if u27.CharacterTrove ~= nil then
                    u27.CharacterTrove:Destroy()
                    u27.CharacterTrove = nil
                end
            end)
            if a1.Character ~= nil then
                bindCharacter(u27, a1.Character)
            end
        end

        Players.PlayerAdded:Connect(function(a1) -- Line: 189 -- upvalues: trackPlayer (val) -- types: a1: userdata
            task.defer(trackPlayer, a1)
        end)
        Players.PlayerRemoving:Connect(function(a1) -- Line: 143 -- upvalues: u30 (upval) -- types: a1: userdata
            local v1 = u30[a1]
            if v1 == nil then
                return
            end
            v1.ActiveDisplayVersion = v1.ActiveDisplayVersion + 1
            if v1.ActiveDisplay ~= nil then
                v1.ActiveDisplay:Destroy()
                v1.ActiveDisplay = nil
            end
            v1.ActiveTool = nil
            if v1.CharacterTrove ~= nil then
                v1.CharacterTrove:Destroy()
            end
            v1.Trove:Destroy()
            u30[a1] = nil
        end)
        for i, v in ipairs(Players:GetPlayers()) do
            task.defer(trackPlayer, v)
        end
        EggState.OwnerRefreshed:Connect(function(a1) -- Line: 199
            -- upvalues: u30 (upval), Players (upval), syncActiveParasite (val), EggToolDisplay (upval)
            -- upvalues: EggState (upval)
            local ActiveDisplay, ActiveTool, v1, v2
            for i, j in u30 do
                if j.Owner.UserId == a1 then
                    if j.Owner ~= Players.LocalPlayer then
                        ActiveTool = j.ActiveTool
                        ActiveDisplay = j.ActiveDisplay
                        if ActiveTool ~= nil and ActiveDisplay ~= nil then
                            v2 = EggToolDisplay.GetToolUid(ActiveTool)
                            if v2 ~= nil then
                                v1 = EggState.ReadOwnedEgg(j.Owner.UserId, v2)
                                if v1 ~= nil then
                                    ActiveDisplay:SyncParasite(v1.HasParasite)
                                end
                            end
                        end
                    else
                        task.defer(syncActiveParasite, j)
                    end
                end
            end
        end)
    end,
}