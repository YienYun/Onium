-- Script path: ReplicatedStorage.Controllers.Game.ParasiteFeedArrowClientController
-- Decompile time: 6.24 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local ArrowPointer3D = require(ReplicatedStorage.Client.WorldFX.ArrowPointer3D)
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local Save = require(ReplicatedStorage.Shared.Save)
local LocalPlayer = Players.LocalPlayer
local u29 = nil
local u30 = nil
local u31 = 0
local u32 = false
return {
    Start = function() -- Line: 25
        -- upvalues: LocalPlayer (val), Workspace (val), MonsterParasite (val), Save (val), u29 (ref), u30 (ref)
        -- upvalues: ArrowPointer3D (val), u31 (ref), u32 (ref)
        local function resolveTargetPart(a1) -- Line: 26 -- types: a1: userdata
            if a1:IsA("BasePart") then
                return a1
            end
            if not a1:IsA("Model") then
                return nil
            end
            if a1.PrimaryPart ~= nil then
                return a1.PrimaryPart
            end
            return a1:FindFirstChildWhichIsA("BasePart", true)
        end

        local function getCharacterRoot() -- Line: 39 -- upvalues: LocalPlayer (upval)
            local Character = LocalPlayer.Character
            if Character == nil then
                return nil
            end
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
                return HumanoidRootPart
            end
            return nil
        end

        local function findNearestMonsterPart(a1) -- Line: 48
            -- upvalues: Workspace (upval), MonsterParasite (upval)
            local Magnitude, PrimaryPart
            local v1 = Workspace:FindFirstChild(MonsterParasite.WorldFolderName)
            if v1 == nil then
                return nil
            end
            local v2 = nil
            local v3 = (1 / 0)
            for i, j in v1:GetChildren() do
                PrimaryPart = if not j:IsA("BasePart") then if not j:IsA("Model") then nil else if j.PrimaryPart == nil then j:FindFirstChildWhichIsA("BasePart", true) else j.PrimaryPart else j
                if PrimaryPart ~= nil then
                    Magnitude = (PrimaryPart.Position - v4.Position).Magnitude
                    if Magnitude < v3 then
                        v2 = PrimaryPart
                    end
                end
            end
            return v2
        end

        local function holdsParasiteEgg() -- Line: 69 -- upvalues: Save (upval)
            local EggInventory
            local v1 = Save.Await()
            if typeof(if v1 == nil then nil else v1.EggInventory) ~= "table" then
                return false
            end
            for i, j in EggInventory do
                if typeof(j) == "table" and j.HasParasite == true then
                    return true
                end
            end
            return false
        end

        local function hasNeverFed() -- Line: 83 -- upvalues: Save (upval)
            local MonsterParasite
            local v1 = Save.Await()
            if typeof(if v1 == nil then nil else v1.MonsterParasite) ~= "table" then
                return false
            end
            return (MonsterParasite.TotalFeeds or 0) <= 0
        end

        local function shouldGuide() -- Line: 92 -- upvalues: Save (upval), holdsParasiteEgg (val)
            local v1 = Save.IsLoaded()
            if v1 then
                local v2 = Save.Await()
                local MonsterParasite = if v2 == nil then nil else v2.MonsterParasite
                v1 = (if typeof(MonsterParasite) == "table" then (MonsterParasite.TotalFeeds or 0) <= 0 else false) and holdsParasiteEgg()
            end
            return v1
        end

        local function destroyArrow() -- Line: 96 -- upvalues: u29 (upval), u30 (upval)
            if u29 ~= nil then
                u29:Destroy()
                u29 = nil
            end
            u30 = nil
        end

        local function pointArrowAt(a1, a2) -- Line: 104
            -- upvalues: u29 (upval), u30 (upval), ArrowPointer3D (upval)
            if u29 ~= nil and u30 == a1 then
                u29:PointFrom(a2)
                return
            end
            if u29 ~= nil then
                u29:Destroy()
                u29 = nil
            end
            u30 = nil
            local v1 = ArrowPointer3D.new(a1, a2)
            v1:Start()
            u29 = v1
            u30 = a1
        end

        local function runGuideLoop(a1) -- Line: 117
            -- upvalues: u31 (upval), Save (upval), holdsParasiteEgg (val), LocalPlayer (upval)
            -- upvalues: findNearestMonsterPart (val), u29 (upval), u30 (upval), ArrowPointer3D (upval), u32 (upval)
            local Character, HumanoidRootPart, MonsterParasite, v1, v2, v3
            while u31 == a1 do
                v1 = Save.IsLoaded()
                if v1 then
                    v2 = Save.Await()
                    MonsterParasite = if v2 == nil then nil else v2.MonsterParasite
                    v1 = (if typeof(MonsterParasite) == "table" then (MonsterParasite.TotalFeeds or 0) <= 0 else false) and holdsParasiteEgg()
                end
                if not v1 then
                    break
                end
                Character = LocalPlayer.Character
                if Character ~= nil then
                    HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    v1 = if HumanoidRootPart == nil then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
                else
                    v1 = nil
                end
                v2 = if v1 == nil then nil else findNearestMonsterPart(v1)
                if v1 == nil or v2 == nil then
                    if u29 ~= nil then
                        u29:Destroy()
                        u29 = nil
                    end
                    u30 = nil
                elseif u29 == nil or u30 ~= v2 then
                    if u29 ~= nil then
                        u29:Destroy()
                        u29 = nil
                    end
                    u30 = nil
                    v3 = ArrowPointer3D.new(v2, v1)
                    v3:Start()
                    u29 = v3
                    u30 = v2
                else
                    u29:PointFrom(v1)
                end
                task.wait(0.25)
            end
            if u31 == a1 then
                u32 = false
                if u29 ~= nil then
                    u29:Destroy()
                    u29 = nil
                end
                u30 = nil
            end
        end

        local v1 = {"EggInventory", "MonsterParasite"}
        Save.WatchFields(v1, function() -- Line: 135
            -- upvalues: Save (upval), holdsParasiteEgg (val), u31 (upval), u32 (upval), u29 (upval), u30 (upval)
            -- upvalues: runGuideLoop (val)
            local v1 = Save.IsLoaded()
            if v1 then
                local v2 = Save.Await()
                local MonsterParasite = if v2 == nil then nil else v2.MonsterParasite
                v1 = (if typeof(MonsterParasite) == "table" then (MonsterParasite.TotalFeeds or 0) <= 0 else false) and holdsParasiteEgg()
            end
            if v1 then
                if u32 then
                    return
                end
                u31 = u31 + 1
                u32 = true
                task.spawn(runGuideLoop, u31)
                return
            end
            u31 = u31 + 1
            u32 = false
            if u29 ~= nil then
                u29:Destroy()
                u29 = nil
            end
            u30 = nil
        end)
        local v2 = Save.IsLoaded()
        if v2 then
            v1 = Save.Await()
            local MonsterParasite_2 = if v1 == nil then nil else v1.MonsterParasite
            v2 = (if typeof(MonsterParasite_2) == "table" then (MonsterParasite_2.TotalFeeds or 0) <= 0 else false) and holdsParasiteEgg()
        end
        if v2 then
            if u32 then
                return
            end
            u31 = u31 + 1
            u32 = true
            task.spawn(runGuideLoop, u31)
            return
        end
        u31 = u31 + 1
        u32 = false
        if u29 ~= nil then
            u29:Destroy()
            u29 = nil
        end
        u30 = nil
    end,
}