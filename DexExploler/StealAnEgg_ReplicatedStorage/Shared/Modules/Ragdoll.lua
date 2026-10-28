-- Script path: ReplicatedStorage.Shared.Modules.Ragdoll
-- Decompile time: 12.43 ms

local Ragdoll = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).Ragdoll
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local RagdollJoints = require(ReplicatedStorage.Shared.Modules.RagdollJoints)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local t = require(ReplicatedStorage.Packages.t)
local u53 = if not RunService:IsServer() then nil else require(ServerScriptService.Library.Modules.ClientCharacterAction)
local Physics = Enum.HumanoidStateType.Physics
local GettingUp = Enum.HumanoidStateType.GettingUp
local u64 = t.intersection(t.numberMinExclusive((-1 / 0)), t.numberMaxExclusive((1 / 0)))

local function u65(a1) -- Line: 32 -- upvalues: u64 (val)
    local v1 = false
    if typeof(a1) == "Vector3" then
        v1 = u64(a1.X) and u64(a1.Y) and u64(a1.Z)
    end
    return v1
end

local u66 = {}
local u67 = 0
local u68 = nil

local function heldBody(a1) -- Line: 46 -- types: a1: userdata
    return a1:FindFirstChildOfClass("Humanoid")
end

local function isLimp(a1) -- Line: 50 -- upvalues: Physics (val) -- types: a1: userdata
    return (a1:GetState()) == Physics
end

local function goLimp(a1, a2) -- Line: 54 -- upvalues: Physics (val) -- types: a1: userdata, a2: vector?
    local RootPart = a1.RootPart
    if RootPart then
        a1:ChangeState(Physics)
        if a2 and typeof(a2) == "Vector3" then
            RootPart:ApplyImpulse(a2)
        end
    end
end

local function standUp(a1) -- Line: 66 -- upvalues: GettingUp (val) -- types: a1: userdata
    local RootPart = a1.RootPart
    if RootPart then
        a1:ChangeState(GettingUp)
        RootPart.CanCollide = true
    end
end

local function beginFor(a1, a2, a3, a4) -- Line: 77
    -- upvalues: Players (val), u53 (val), Physics (val)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(a1)
    if PlayerFromCharacter then
        assert(u53, "ClientCharacterAction is only available on the server").BeginRagdoll(PlayerFromCharacter, a1, a3, a4)
        return
    end
    local RootPart = a2.RootPart
    if RootPart then
        a2:ChangeState(Physics)
        if a4 and typeof(a4) == "Vector3" then
            RootPart:ApplyImpulse(a4)
        end
    end
end

local function endFor(a1, a2) -- Line: 87
    -- upvalues: Players (val), u53 (val), GettingUp (val)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(a1)
    if PlayerFromCharacter then
        assert(u53, "ClientCharacterAction is only available on the server").EndRagdoll(PlayerFromCharacter, a1)
        return
    end
    if a2 then
        local RootPart = a2.RootPart
        if RootPart then
            a2:ChangeState(GettingUp)
            RootPart.CanCollide = true
        end
    end
end

local function captureRig(a1, a2) -- Line: 98 -- types: a1: userdata, a2: userdata
    local Part1
    local v1 = {}
    local RootPart = a2.RootPart
    if RootPart == nil then
        return v1
    end
    for i, j in a1:GetDescendants() do
        if j:IsA("Motor6D") then
            Part1 = j.Part1
            if Part1 ~= nil and Part1.Parent == a1 then
                v1[Part1] = (Part1.Position - RootPart.Position).Magnitude
            end
        end
    end
    return v1
end

local function reloadIfTorn(a1, a2) -- Line: 116
    -- upvalues: Players (val), Ragdoll (val), u66 (val)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(a1)
    if PlayerFromCharacter == nil then
        return
    end
    task.delay(Ragdoll.RIG_CHECK_DELAY, function() -- Line: 121 -- upvalues: a1 (val), PlayerFromCharacter (val), u66 (upval), a2 (val), Ragdoll (upval)
        local v1 = a1:FindFirstChildOfClass("Humanoid")
        local RootPart = if not v1 then nil else v1.RootPart
        if PlayerFromCharacter.Character == a1
            and v1 ~= nil
            and RootPart ~= nil
            and not (v1.Health <= 0)
            and u66[a1] == nil then
            local Magnitude, v2
            v1 = 0
            for i, j in a2 do
                v1 = math.max(v1, j)
            end
            local v3 = nil
            local v4 = nil
            for k in a2, v3, v4 do
                Magnitude = (k.Position - RootPart.Position).Magnitude
                v2 = v1 * Ragdoll.RIG_TORN_REACH < Magnitude
                if k.Parent == a1 and not v2 then
                    continue
                end
                PlayerFromCharacter:LoadCharacterAsync()
                return
            end
            return
        end
    end)
end

u68 = {
    ClientRagdollRemote = Remotes.Limpness.WriteLimpness,
    IsRagdolled = function(a1) -- Line: 150 -- upvalues: t (val), u66 (val), Physics (val) -- types: a1: userdata
        t.strict(t.instanceIsA("Model"))(a1)
        local Humanoid = a1:FindFirstChildOfClass("Humanoid")
        local v1 = true
        if u66[a1] == nil then
            v1 = false
            if Humanoid ~= nil then
                v1 = (Humanoid:GetState()) == Physics
            end
        end
        return v1
    end,
    Ragdoll = function(a1) -- Line: 158
        -- upvalues: Physics (val), Ragdoll (val), Players (val), u53 (val), RagdollJoints (val)
        local Humanoid = a1:WaitForChild("Humanoid")
        if not ((Humanoid:GetState()) == Physics) then
            Humanoid.BreakJointsOnDeath = false
            local PLAYER_RAGDOLL_SECONDS = Ragdoll.PLAYER_RAGDOLL_SECONDS
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(a1)
            if PlayerFromCharacter then
                assert(u53, "ClientCharacterAction is only available on the server").BeginRagdoll(
                    PlayerFromCharacter,
                    a1,
                    PLAYER_RAGDOLL_SECONDS,
                    nil
                )
            elseif Humanoid.RootPart then
                Humanoid:ChangeState(Physics)
            end
            RagdollJoints.Bind(a1)
        end
    end,
    NpcRagdoll = function(a1, a2) -- Line: 169
        -- upvalues: Physics (val), RagdollJoints (val), GettingUp (val)
        local Humanoid = a1:FindFirstChild("Humanoid")
        if Humanoid then
            Humanoid.BreakJointsOnDeath = false
        end
        if Humanoid and not ((Humanoid:GetState()) == Physics) then
            Humanoid.PlatformStand = true
            Humanoid:ChangeState(Physics)
            RagdollJoints.Bind(a1)
            task.wait(a2)
            if a1 and a1.Parent then
                Humanoid.PlatformStand = false
                Humanoid:ChangeState(GettingUp)
                RagdollJoints.Release(a1)
            end
            return
        end
    end,
    TimedRagdoll = function(a1, a2, a3) -- Line: 194
        -- upvalues: t (val), u64 (val), u65 (val), Physics (val), u66 (val), u67 (ref), captureRig (val), Players (val)
        -- upvalues: u53 (val), Ragdoll (val), RagdollJoints (val), GettingUp (val)
        t.strict(u64)(a2)
        assert(a2 >= 0, "Ragdoll duration must be non-negative")
        t.strict(t.optional(u65))(a3)
        local Humanoid = a1:WaitForChild("Humanoid")
        Humanoid.BreakJointsOnDeath = false
        local v1 = (Humanoid:GetState()) == Physics
        local v2 = u66[a1]
        u67 = u67 + 1
        local v3 = u67
        local OwnsConstraints = if not v2 then not v1 else v2.OwnsConstraints
        local v4 = u66
        local v5 = {
            Token = v3,
            OwnsConstraints = OwnsConstraints,
            Bound = if not v2 then v1 else v2.Bound,
        }
        local Rig_2 = if not v2 then captureRig(a1, Humanoid) else v2.Rig
        v5.Rig = Rig_2
        v4[a1] = v5
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(a1)
        if not PlayerFromCharacter then
            local RootPart = Humanoid.RootPart
            if RootPart then
                Humanoid:ChangeState(Physics)
                if a3 and typeof(a3) == "Vector3" then
                    RootPart:ApplyImpulse(a3)
                end
            end
        else
            assert(u53, "ClientCharacterAction is only available on the server").BeginRagdoll(PlayerFromCharacter, a1, a2, a3)
        end
        v1 = math.min(Ragdoll.IMPULSE_LEAD, a2)
        task.wait(v1)
        v4 = u66[a1]
        if v4 and v4.Token == v3 and v4.OwnsConstraints and not v4.Bound then
            v4.Bound = true
            RagdollJoints.Bind(a1)
        end
        task.wait(a2 - v1)
        v4 = u66[a1]
        if v4 and v4.Token == v3 then
            u66[a1] = nil
            v3 = Players:GetPlayerFromCharacter(a1)
            if v3 then
                assert(u53, "ClientCharacterAction is only available on the server").EndRagdoll(v3, a1)
            elseif Humanoid then
                local RootPart_2 = Humanoid.RootPart
                if RootPart_2 then
                    Humanoid:ChangeState(GettingUp)
                    RootPart_2.CanCollide = true
                end
            end
            if v4.OwnsConstraints then
                RagdollJoints.Release(a1)
            end
            local Rig = v4.Rig
            local u183 = Players:GetPlayerFromCharacter(a1)
            if u183 == nil then
                return
            end
            task.delay(Ragdoll.RIG_CHECK_DELAY, function() -- Line: 121 -- upvalues: a1 (val), u183 (val), u66 (upval), Rig (val), Ragdoll (upval)
                local v1 = a1:FindFirstChildOfClass("Humanoid")
                local RootPart = if not v1 then nil else v1.RootPart
                if u183.Character == a1
                    and v1 ~= nil
                    and RootPart ~= nil
                    and not (v1.Health <= 0)
                    and u66[a1] == nil then
                    local Magnitude, v2
                    v1 = 0
                    for i, j in Rig do
                        v1 = math.max(v1, j)
                    end
                    local v3 = nil
                    local v4 = nil
                    for k in Rig, v3, v4 do
                        Magnitude = (k.Position - RootPart.Position).Magnitude
                        v2 = v1 * Ragdoll.RIG_TORN_REACH < Magnitude
                        if k.Parent == a1 and not v2 then
                            continue
                        end
                        u183:LoadCharacterAsync()
                        return
                    end
                    return
                end
            end)
            return
        end
    end,
    TimedRagdollAsync = function(a1, a2, a3) -- Line: 251 -- upvalues: u68 (ref) -- types: a1: userdata, a2: number, a3: vector?
        task.spawn(u68.TimedRagdoll, a1, a2, a3)
    end,
    ApplyClientRagdoll = function(a1, a2) -- Line: 255 -- upvalues: Physics (val), RagdollJoints (val) -- types: a1: userdata, a2: vector?
        local Humanoid = a1:FindFirstChildOfClass("Humanoid")
        local v1 = ("%* has no Humanoid to ragdoll"):format((a1:GetFullName()))
        assert(Humanoid ~= nil, v1)
        Humanoid.BreakJointsOnDeath = false
        local v2 = (Humanoid:GetState()) == Physics
        local RootPart = Humanoid.RootPart
        if RootPart then
            Humanoid:ChangeState(Physics)
            if a2 and typeof(a2) == "Vector3" then
                RootPart:ApplyImpulse(a2)
            end
        end
        if not v2 then
            RagdollJoints.Bind(a1)
        end
    end,
    ClearClientRagdoll = function(a1) -- Line: 270 -- upvalues: GettingUp (val), RagdollJoints (val) -- types: a1: userdata
        local Humanoid = a1:FindFirstChildOfClass("Humanoid")
        local v1 = ("%* has no Humanoid to stand up"):format((a1:GetFullName()))
        assert(Humanoid ~= nil, v1)
        local RootPart = Humanoid.RootPart
        if RootPart then
            Humanoid:ChangeState(GettingUp)
            RootPart.CanCollide = true
        end
        RagdollJoints.Release(a1)
    end,
    Unragdoll = function(a1) -- Line: 278
        -- upvalues: u66 (val), Players (val), u53 (val), GettingUp (val), RagdollJoints (val), Ragdoll (val)
        local v1 = u66[a1]
        u66[a1] = nil
        local Humanoid = a1:FindFirstChildOfClass("Humanoid")
        local PlayerFromCharacter_2 = Players:GetPlayerFromCharacter(a1)
        if PlayerFromCharacter_2 then
            assert(u53, "ClientCharacterAction is only available on the server").EndRagdoll(PlayerFromCharacter_2, a1)
        elseif Humanoid then
            local RootPart = Humanoid.RootPart
            if RootPart then
                Humanoid:ChangeState(GettingUp)
                RootPart.CanCollide = true
            end
        end
        RagdollJoints.Release(a1)
        if v1 then
            local Rig = v1.Rig
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(a1)
            if PlayerFromCharacter == nil then
                return
            end
            task.delay(Ragdoll.RIG_CHECK_DELAY, function() -- Line: 121 -- upvalues: a1 (val), PlayerFromCharacter (val), u66 (upval), Rig (val), Ragdoll (upval)
                local v1 = a1:FindFirstChildOfClass("Humanoid")
                local RootPart = if not v1 then nil else v1.RootPart
                if PlayerFromCharacter.Character == a1
                    and v1 ~= nil
                    and RootPart ~= nil
                    and not (v1.Health <= 0)
                    and u66[a1] == nil then
                    local Magnitude, v2
                    v1 = 0
                    for i, j in Rig do
                        v1 = math.max(v1, j)
                    end
                    local v3 = nil
                    local v4 = nil
                    for k in Rig, v3, v4 do
                        Magnitude = (k.Position - RootPart.Position).Magnitude
                        v2 = v1 * Ragdoll.RIG_TORN_REACH < Magnitude
                        if k.Parent == a1 and not v2 then
                            continue
                        end
                        PlayerFromCharacter:LoadCharacterAsync()
                        return
                    end
                    return
                end
            end)
        end
    end,
}
return u68