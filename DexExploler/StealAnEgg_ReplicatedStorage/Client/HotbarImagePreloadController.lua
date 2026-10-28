-- Script path: ReplicatedStorage.Client.HotbarImagePreloadController
-- Decompile time: 13.62 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Types.AreaEggs)
local Areas = require(ReplicatedStorage.Data.Areas)
local AssetIconShape = require(ReplicatedStorage.Client.UI.AssetIconShape)
local Assets = require(ReplicatedStorage.Data.Assets)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggState = require(ReplicatedStorage.Client.EggState)
require(ReplicatedStorage.Shared.Types.Eggs)
local GuardChasePolicy = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardChasePolicy)
local GuardEscape = require(ReplicatedStorage.Shared.Utils.GuardEscape)
local GuardEscapePrediction = require(ReplicatedStorage.Shared.Modules.GuardAreas.GuardEscapePrediction)
local Guards = require(ReplicatedStorage.Data.Guards)
local HotbarImagePreloadPolicy = require(ReplicatedStorage.Client.HotbarImagePreloadPolicy)
local ImagePreloader = require(ReplicatedStorage.Client.ImagePreloader)
local Log = require(ReplicatedStorage.Packages.Log)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Player = require(ReplicatedStorage.Shared.Player)
local SpeedPowerProjection = require(ReplicatedStorage.Client.SpeedPowerProjection)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u101 = {[10650210095] = true, [10737944401] = true}
local LocalPlayer = Players.LocalPlayer
local u109 = Log.new()
local v1 = Workspace:WaitForChild("World"):WaitForChild("Areas")
local u124 = v1:WaitForChild("GuardAreas")
local SeparationLine = v1:WaitForChild("SeparationLine")
assert(u124:IsA("Folder"), "Workspace.World.Areas.GuardAreas must be a Folder")
assert(SeparationLine:IsA("BasePart"), "Workspace.World.Areas.SeparationLine must be a BasePart")

local function showDebugNotification(a1) -- Line: 73 -- upvalues: u101 (val), Toast (val) -- types: a1: string
    if not u101[game.GameId] then
        return
    end
    Toast.Show({
        Seconds = 1.5,
        Unique = true,
        Text = ("[DEBUG]: %*"):format(a1),
        Color = Color3.fromRGB(100, 200, 255),
    })
end

local function getAreaModel(a1) -- Line: 86 -- upvalues: u124 (val) -- types: a1: string
    local v1 = u124:FindFirstChild(a1)
    if v1 ~= nil and v1:IsA("Model") then
        return v1
    end
    return nil
end

local function getGuardRoot(a1) -- Line: 91 -- types: a1: userdata
    local Guard = a1:FindFirstChild("Guard")
    if Guard ~= nil and Guard:IsA("Model") then
        local HumanoidRootPart = Guard:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
            return HumanoidRootPart
        end
        return nil
    end
    return nil
end

local function resolveRequiredSpeedPower(a1) -- Line: 101
    -- upvalues: getGuardRoot (val), Areas (val), Guards (val), SeparationLine (val), GuardEscape (val)
    -- upvalues: GuardEscapePrediction (val), GuardChasePolicy (val), u109 (val)
    local u3 = getGuardRoot(a1)
    if u3 == nil then
        return nil
    end
    local success, err = pcall(function() -- Line: 107
        -- upvalues: Areas (upval), a1 (val), Guards (upval), SeparationLine (upval), GuardEscape (upval)
        -- upvalues: GuardEscapePrediction (upval), u3 (val), GuardChasePolicy (upval)
        local v1 = Areas.Directory[a1.Name]
        local v2 = Guards.Directory[v1.GuardId]
        v1 = a1:FindFirstChild("Bounds")
        local ClosestExitPoint = a1:FindFirstChild("ClosestExitPoint")
        local v3 = false
        if v1 ~= nil then
            v3 = v1:IsA("BasePart")
        end
        assert(v3, (("%*.Bounds must be a BasePart"):format((a1:GetFullName()))))
        v3 = false
        if ClosestExitPoint ~= nil then
            v3 = ClosestExitPoint:IsA("BasePart")
        end
        assert(v3, (("%*.ClosestExitPoint must be a BasePart"):format((a1:GetFullName()))))
        local v4 = -SeparationLine.CFrame.LookVector
        return GuardEscape.RequiredSpeedPower({
            BaseGuardWalkSpeed = v2.WalkSpeed,
            ExitDirection = v4,
            ExitDistance = GuardEscapePrediction.ResolveExitDistance(v1.CFrame, v1.Size, ClosestExitPoint.Position, v4),
            FlatRadius = v2.FlatRadius,
            GuardStartPosition = u3.Position,
            HitDistance = GuardChasePolicy.ResolveHitDistance(v2.HitDistance),
            PlayerStartPosition = ClosestExitPoint.Position,
        })
    end)
    if success then
        return err
    end
    ;(u109:AtWarning()):Log((("Unable to resolve guard escape requirement for %*: %*"):format(a1.Name, err)))
    return nil
end

local function cacheRequiredSpeedPower(a1, a2) -- Line: 144
    -- upvalues: resolveRequiredSpeedPower (val)
    local v1 = resolveRequiredSpeedPower(a2)
    if v1 ~= nil then
        a1.RequiredSpeedPowerByAreaId[a2.Name] = v1
    end
end

local function getRequiredSpeedPower(a1, a2) -- Line: 151
    -- upvalues: u124 (val), resolveRequiredSpeedPower (val)
    local v1 = a1.RequiredSpeedPowerByAreaId[a2]
    if v1 ~= nil then
        return v1
    end
    local v2 = u124:FindFirstChild(a2)
    if (if v2 == nil then nil else if not v2:IsA("Model") then nil else v2) == nil then
        return nil
    end
    v2 = resolveRequiredSpeedPower(v1)
    if v2 ~= nil then
        a1.RequiredSpeedPowerByAreaId[v1.Name] = v2
    end
    return a1.RequiredSpeedPowerByAreaId[a2]
end

local function getDistanceToClaimLine() -- Line: 165
    -- upvalues: Player (val), LocalPlayer (val), HotbarImagePreloadPolicy (val), SeparationLine (val)
    local v1 = Player.FindRootPart(LocalPlayer)
    if v1 ~= nil and v1:IsA("BasePart") then
        return HotbarImagePreloadPolicy.GetShortestDistanceToClaimLine(SeparationLine, v1.Position)
    end
    return nil
end

local function requestEggIcon(a1) -- Line: 173
    -- upvalues: Assets (val), ImagePreloader (val), showDebugNotification (val)
    local v1 = Assets.Directory[a1]
    if ImagePreloader.Request(v1.Egg.Icon) then
        showDebugNotification((("Preloading image for %* egg"):format(v1.DisplayName)))
    end
end

local function requestPetIcons(a1) -- Line: 180
    -- upvalues: EggRecords (val), AssetIconShape (val), ImagePreloader (val), Assets (val), showDebugNotification (val)
    local v1 = AssetIconShape.ResolveImages((EggRecords.ToAssetItemData(a1)))
    local v2 = {v1.Icon}
    if v1.RainbowOverlay ~= nil then
        v2[#v2 + 1] = v1.RainbowOverlay
    end
    if 0 < (ImagePreloader.RequestAll(v2)) then
        showDebugNotification((("Preloading image for %* pet"):format(Assets.Directory[a1.AssetCategory].DisplayName)))
    end
end

local function scanReadyEggs(a1) -- Line: 193 -- upvalues: EggState (val), LocalPlayer (val), requestPetIcons (val)
    if a1.Destroyed then
        return
    end
    local v1 = EggState.ReadOwnerEggs(LocalPlayer.UserId)
    for i, j in v1 do
        if not a1.ReadyPreloadedByUid[i] and j.Placement ~= nil and EggState.IsReadyToHatch(i) then
            a1.ReadyPreloadedByUid[i] = true
            requestPetIcons(j)
        end
    end
    for k in a1.ReadyPreloadedByUid do
        if v1[k] == nil then
            a1.ReadyPreloadedByUid[k] = nil
        end
    end
end

local function handleCarryState(a1, a2) -- Line: 219
    -- upvalues: u124 (val), resolveRequiredSpeedPower (val), SpeedPowerProjection (val), Player (val)
    -- upvalues: LocalPlayer (val), HotbarImagePreloadPolicy (val), SeparationLine (val), Assets (val)
    -- upvalues: ImagePreloader (val), showDebugNotification (val), Timer (val)
    a1.CarryGeneration = a1.CarryGeneration + 1
    a1.CarryTrove:Clean()
    if a2.IsCarrying and a2.AreaId ~= nil and a2.AssetCategory ~= nil then
        local v1, v2
        local CarryGeneration = a1.CarryGeneration
        local AreaId = a2.AreaId
        local AssetCategory = a2.AssetCategory
        local v3 = a1.RequiredSpeedPowerByAreaId[AreaId]
        if v3 == nil then
            v2 = u124:FindFirstChild(AreaId)
            v3 = if v2 == nil then nil else if not v2:IsA("Model") then nil else v2
            if v3 ~= nil then
                v2 = resolveRequiredSpeedPower(v3)
                if v2 ~= nil then
                    a1.RequiredSpeedPowerByAreaId[v3.Name] = v2
                end
                v1 = a1.RequiredSpeedPowerByAreaId[AreaId]
            else
                v1 = nil
            end
        else
            v1 = v3
        end
        local v4 = SpeedPowerProjection.ReadProjected()
        v2 = Player.FindRootPart(LocalPlayer)
        v3 = if v2 == nil then nil else if v2:IsA("BasePart") then HotbarImagePreloadPolicy.GetShortestDistanceToClaimLine(SeparationLine, v2.Position) else nil
        if not HotbarImagePreloadPolicy.ShouldPreloadCarriedEgg(v4, v1, v3) then
            a1.CarryTrove:Add((Timer.Simple(0.1, function() -- Line: 237
                -- upvalues: a1 (val), CarryGeneration (val), Player (upval), LocalPlayer (upval)
                -- upvalues: HotbarImagePreloadPolicy (upval), SeparationLine (upval), AssetCategory (val)
                -- upvalues: Assets (upval), ImagePreloader (upval), showDebugNotification (upval)
                if not a1.Destroyed and a1.CarryGeneration == CarryGeneration then
                    local v1 = Player.FindRootPart(LocalPlayer)
                    local v2 = if v1 == nil then nil else if v1:IsA("BasePart") then HotbarImagePreloadPolicy.GetShortestDistanceToClaimLine(SeparationLine, v1.Position) else nil
                    if v2 ~= nil and HotbarImagePreloadPolicy.IsWithinClaimPreloadDistance(v2) then
                        v2 = Assets.Directory[AssetCategory]
                        if ImagePreloader.Request(v2.Egg.Icon) then
                            showDebugNotification((("Preloading image for %* egg"):format(v2.DisplayName)))
                        end
                        a1.CarryTrove:Clean()
                        return
                    end
                    return
                end
            end)))
            return
        end
        v2 = Assets.Directory[AssetCategory]
        if ImagePreloader.Request(v2.Egg.Icon) then
            showDebugNotification((("Preloading image for %* egg"):format(v2.DisplayName)))
        end
        return
    end
end

local u162 = table.freeze({
    __index = table.freeze({
        Start = function(a1) -- Line: 259
            -- upvalues: u124 (val), resolveRequiredSpeedPower (val), EggState (val), handleCarryState (val)
            -- upvalues: LocalPlayer (val), scanReadyEggs (val), Timer (val)
            local v1
            assert(not a1.Started, "HotbarImagePreloadController already started")
            assert(not a1.Destroyed, "HotbarImagePreloadController is destroyed")
            a1.Started = true
            for i, j in u124:GetChildren() do
                if j:IsA("Model") then
                    v1 = resolveRequiredSpeedPower(j)
                    if v1 ~= nil then
                        a1.RequiredSpeedPowerByAreaId[j.Name] = v1
                    end
                end
            end
            a1.Trove:Connect(u124.ChildAdded, function(a1_2) -- Line: 270 -- upvalues: a1 (val), resolveRequiredSpeedPower (upval) -- types: a1_2: userdata
                if a1_2:IsA("Model") then
                    local v1 = resolveRequiredSpeedPower(a1_2)
                    if v1 ~= nil then
                        a1.RequiredSpeedPowerByAreaId[a1_2.Name] = v1
                    end
                end
            end)
            a1.Trove:Connect(u124.ChildRemoved, function(a1_2) -- Line: 275 -- upvalues: a1 (val) -- types: a1_2: userdata
                a1.RequiredSpeedPowerByAreaId[a1_2.Name] = nil
            end)
            a1.Trove:Add((EggState.CarryChanged:Connect(function(a1_2) -- Line: 278 -- upvalues: handleCarryState (upval), a1 (val)
                handleCarryState(a1, a1_2)
            end)))
            a1.Trove:Add((EggState.OwnerRefreshed:Connect(function(a1_2) -- Line: 281 -- upvalues: LocalPlayer (upval), scanReadyEggs (upval), a1 (val) -- types: a1_2: number
                if a1_2 == LocalPlayer.UserId then
                    scanReadyEggs(a1)
                end
            end)))
            a1.Trove:Add((Timer.Simple(0.25, function() -- Line: 286 -- upvalues: scanReadyEggs (upval), a1 (val)
                scanReadyEggs(a1)
            end)))
            scanReadyEggs(a1)
        end,
        Destroy = function(self) -- Line: 292
            if self.Destroyed then
                return
            end
            self.Destroyed = true
            self.CarryGeneration = self.CarryGeneration + 1
            self.Trove:Destroy()
        end,
    }),
})
return table.freeze({
    new = function() -- Line: 322 -- upvalues: Trove (val), u162 (val)
        local v1 = Trove.new()
        return (setmetatable({
            CarryGeneration = 0,
            Destroyed = false,
            Started = false,
            CarryTrove = v1:Extend(),
            ReadyPreloadedByUid = {},
            RequiredSpeedPowerByAreaId = {},
            Trove = v1,
        }, u162))
    end,
    IsA = function(a1) -- Line: 311 -- upvalues: u162 (val)
        local v1 = false
        if type(a1) == "table" then
            v1 = (getmetatable(a1)) == u162
        end
        return v1
    end,
    Assert = function(a1) -- Line: 315 -- upvalues: u162 (val)
        local v1 = false
        if type(a1) == "table" then
            v1 = (getmetatable(a1)) == u162
        end
        assert(v1, "Expected HotbarImagePreloadController")
        return a1
    end,
})