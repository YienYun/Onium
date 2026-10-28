-- Script path: ReplicatedStorage.Shared.Modules.BatController.Server
-- Decompile time: 17.23 ms

local BatServer = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).BatServer
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local AntiCheatService = require(ServerScriptService.Controllers.AntiCheatService)
local Audio = require(ReplicatedStorage.Shared.Audio)
local Config = require(script.Parent.Config)
local BatDamagable = require(ServerScriptService.Library.Tools.Internal.BatDamagable)
require(script.Parent.Types.Interface)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local GameplayToolGuard = require(ServerScriptService.Library.Tools.Internal.GameplayToolGuard)
require(ReplicatedStorage.Data.Gears)
local FromTool = require(ReplicatedStorage.Shared.Util.ToolHolders).FromTool
local Log = require(ReplicatedStorage.Packages.Log)
local Player = require(ReplicatedStorage.Shared.Player)
local Ragdoll = require(ReplicatedStorage.Shared.Modules.Ragdoll)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local SlapShared = require(ServerScriptService.Library.Tools.Internal.SlapShared)
require(ReplicatedStorage.Shared.Types.Tools)
local u105 = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local u110 = {}
u110.__index = u110
u110.__class = "BatServerController"
local u112 = {0, 2, 4, 7, 9, 12}
local u120 = Log.new()
local u123 = Random.new()

function u110.new(a1, a2) -- Line: 82 -- upvalues: t (val), u110 (val), Config (val), u105 (val) -- types: a1: userdata
    t.strict(t.instanceIsA("Tool"))(a1)
    assert(typeof(a2) == "table", "Bat controller data must be a table")
    assert(typeof(a2.Duration) == "number", "Bat controller duration must be a number")
    assert(typeof(a2.Force) == "number", "Bat controller force must be a number")
    assert(typeof(a2.RangeBonus) == "number", "Bat controller range bonus must be a number")
    local Handle = a1.Handle
    assert(Handle:IsA("BasePart"), "Bat.Handle must be a BasePart")
    local v1 = setmetatable({}, u110)
    v1._tool = a1
    v1._handle = Handle
    v1._range = Config.Range + a2.RangeBonus
    v1._slapProfile = table.freeze({BrainrotDamage = 0, MaxBrainrotTargets = 0, Duration = a2.Duration, Force = a2.Force})
    v1._cooldownLockedUntil = 0
    v1._nextDebugLogAt = 0
    v1._processing = false
    v1._idleTrack = nil
    v1._trove = u105.new()
    v1:_init()
    return v1
end

function u110:_setCooldownAttributes(a2) -- Line: 125 -- types: a2: number
    local _tool = self._tool
    local u7 = workspace:GetServerTimeNow() + a2
    _tool:SetAttribute("CooldownDuration", a2)
    _tool:SetAttribute("CooldownEndTime", u7)
    _tool:SetAttribute("CooldownActive", true)
    task.delay(a2, function() -- Line: 133 -- upvalues: _tool (val), u7 (val), self (val)
        if _tool.Parent and (_tool:GetAttribute("CooldownEndTime")) == u7 then
            _tool:SetAttribute("CooldownActive", false)
            _tool:SetAttribute("CooldownDuration", 0)
            _tool:SetAttribute("CooldownEndTime", 0)
            self._cooldownLockedUntil = 0
        end
    end)
end

function u110:_playIdle(a2) -- Line: 143 -- upvalues: Player (val) -- types: a2: userdata
    if self._idleTrack then
        return
    end
    local v1 = Player.FindHumanoid(a2)
    local Animator = v1 and v1:FindFirstChildOfClass("Animator")
    local IdleAnim = self._tool:FindFirstChild("IdleAnim")
    if Animator and IdleAnim then
        return
    end
end

function u110:_stopIdle() -- Line: 159
    local _idleTrack = self._idleTrack
    if not _idleTrack then
        return
    end
    self._idleTrack = nil
    _idleTrack:Stop()
    _idleTrack:Destroy()
end

function u110:_playHitAnimation(a2) -- Line: 171 -- upvalues: Player (val) -- types: a2: userdata
    local v1 = Player.FindHumanoid(a2)
    local Animator = v1 and v1:FindFirstChildOfClass("Animator")
    v1 = self._tool:FindFirstChild("HitAnim")
    if Animator and v1 then
        local v2 = Animator:LoadAnimation(v1)
        v2.Priority = Enum.AnimationPriority.Action
        v2:Play()
        return
    end
end

function u110:_applyPlayerHit(a2, a3) -- Line: 186
    -- upvalues: Player (val), GameplayToolGuard (val), SlapShared (val), Ragdoll (val)
    local v1 = Player.FindCharacter(a2)
    local v2 = Player.FindRootPart(a2)
    if v1 and v2 and v2:IsA("BasePart") then
        if v1:GetAttribute("IsTrapped") == true or not GameplayToolGuard.IsPlayerInGameplayArea(a2) then
            return
        end
        GameplayToolGuard.DropHeldEggFromPlayerHit(a2)
        local v3, v4 = SlapShared.ComputeImpulse(v2, a3, self._slapProfile)
        a2:SetAttribute("RagdollEndTime", (workspace:GetServerTimeNow()) + v4)
        Ragdoll.TimedRagdollAsync(v1, v4, v3)
        return
    end
end

function u110:_canLogDebugTrace(a2) -- Line: 213 -- upvalues: Constants (val) -- types: a2: number
    if Constants.IS_STUDIO and not (a2 < self._nextDebugLogAt) then
        self._nextDebugLogAt = a2 + 0.1
        return true
    end
    return false
end

function u110:_logDecisionTrace(a2, a3, a4, a5, a6, a7, a8, a9, a10) -- Line: 226
    -- upvalues: Player (val), Config (val), u120 (val), BatServer (val)
    if not self:_canLogDebugTrace(a4) then
        return
    end
    local Target = if not a7 then a6 else if not a7.Target then a6 else a7.Target
    local v1 = if not Target then nil else Player.FindRootPart(Target)
    local v2 = if not v1 then nil else if not v1:IsA("BasePart") then nil else v1
    v1 = Player.FindHumanoid(a2)
    local AssemblyLinearVelocity = if not a5 then Vector3.new(0, 0, 0) else a5.AssemblyLinearVelocity
    local AssemblyLinearVelocity_2 = if not v2 then Vector3.new(0, 0, 0) else v2.AssemblyLinearVelocity
    local v3 = (self._range + Config.HitTolerance) * Config.GetHitboxScalar()
    local CurrentDistance = if not a7 then if not a5 then -1 else if not v2 then -1 else (v2.Position - a5.Position).Magnitude else a7.CurrentDistance
    local v4 = u120:AtInfo()
    local v5 = {
        Stage = "SERVER_DECISION",
        TraceId = a3,
        Decision = a8,
        Explanation = a9,
        Action = a10,
    }
    v5.Accepted = a10 == "HIT_ACTION_DISPATCHED"
    v5.ServerTime = a4
    v5.AttackerName = a2.Name
    v5.AttackerUserId = a2.UserId
    v5.TargetName = if not Target then "None" else Target.Name
    v5.TargetUserId = if not Target then 0 else Target.UserId
    v5.MaximumRange = v3
    v5.ServerCurrentDistance = CurrentDistance
    v5.ServerHistoricalDistance = if not a7 then -1 else a7.HistoricalDistance
    v5.TargetViewAgeSeconds = if not a7 then -1 else a7.TargetViewAge
    v5.HistoricalTimestamp = if not a7 then -1 else a7.HistoricalTimestamp
    v5.HistoricalSampleIntervalSeconds = if not a7 then -1 else a7.HistoricalSampleInterval
    v5.NetworkPingSeconds = a2:GetNetworkPing()
    v5.CooldownRemainingSeconds = math.max(0, self._cooldownLockedUntil - a4)
    v5.CooldownToApplySeconds = if a10 == "HIT_ACTION_DISPATCHED" then BatServer.PLAYER_COOLDOWN else if a10 ~= "MISS_COOLDOWN_APPLIED" then 0 else BatServer.PLAYER_COOLDOWN
    v5.AttackerServerPosition = if not a5 then Vector3.new(0, 0, 0) else a5.Position
    v5.TargetCurrentServerPosition = if not a7 then if not v2 then Vector3.new(0, 0, 0) else v2.Position else a7.TargetServerPosition
    v5.TargetHistoricalServerPosition = if not a7 then Vector3.new(0, 0, 0) else a7.TargetHistoricalServerPosition
    v5.AttackerWalkSpeed = if not v1 then -1 else v1.WalkSpeed
    v5.AttackerHorizontalSpeed = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude
    v5.TargetHorizontalSpeed = Vector3.new(AssemblyLinearVelocity_2.X, 0, AssemblyLinearVelocity_2.Z).Magnitude
    local v6 = false
    if v2 ~= nil then
        v6 = Vector3.new(AssemblyLinearVelocity_2.X, 0, AssemblyLinearVelocity_2.Z).Magnitude <= 1
    end
    v5.TargetServerStationary = v6
    v4:Log("Bat hit validation trace", v5)
end

local function riderRise(a1) -- Line: 300 -- types: a1: userdata
    local PetMountSession = a1:FindFirstChild("PetMountSession")
    local Attribute = PetMountSession and PetMountSession:GetAttribute("HeightIncrease")
    if typeof(Attribute) == "number" and Attribute > 0 then
        return Attribute
    end
    return 0
end

local function reachDistance(a1, a2, a3) -- Line: 306 -- types: a1: vector, a2: vector, a3: number
    local Magnitude = (a2 - a1).Magnitude
    if a3 <= 0 then
        return Magnitude
    end
    return (math.min(Magnitude, (a2 - (Vector3.new(0, a3, 0)) - a1).Magnitude))
end

function u110:_resolveValidTarget(a2, a3, a4, a5) -- Line: 314
    -- upvalues: Players (val), Player (val), Ragdoll (val), GameplayToolGuard (val), Config (val)
    -- upvalues: AntiCheatService (val)
    local v1 = {
        Decision = "CLIENT_NO_TARGET",
        Explanation = "The client did not nominate a player inside its rendered selection range.",
        CurrentDistance = -1,
        HistoricalDistance = -1,
        TargetViewAge = -1,
        HistoricalTimestamp = -1,
        HistoricalSampleInterval = -1,
        TargetServerPosition = Vector3.new(0, 0, 0),
        TargetHistoricalServerPosition = Vector3.new(0, 0, 0),
    }
    v1.Target = a3
    if a3 == nil then
        return v1
    end
    if a3 == a2 then
        v1.Decision = "SELF_TARGET_REJECTED"
        v1.Explanation = "The nominated target was the attacker."
        return v1
    end
    if a3.Parent ~= Players then
        v1.Decision = "TARGET_NOT_IN_SERVER"
        v1.Explanation = "The nominated player was no longer in this server."
        return v1
    end
    if not a2:GetAttribute("InBossArena")
        and not a3:GetAttribute("InBossArena")
        and not a2:GetAttribute("InScrambleArena")
        and not a3:GetAttribute("InScrambleArena")
        and not a2:GetAttribute("InPumpkinArena")
        and not a3:GetAttribute("InPumpkinArena") then
        if workspace:GetAttribute("PvPDisabled") == true then
            v1.Decision = "EVENT_PVP_DISABLED"
            v1.Explanation = "A running event has turned player hits off."
            return v1
        end
        local v2 = Player.FindCharacter(a3)
        local v3 = Player.FindRootPart(a3)
        local v4 = Player.FindHumanoid(a3)
        if v2 and v3 and v3:IsA("BasePart") and v4 then
            v1.TargetServerPosition = v3.Position
            if v4.Health <= 0 then
                v1.Decision = "TARGET_DEAD"
                v1.Explanation = "The nominated target was dead when the server handled the swing."
                return v1
            end
            if Ragdoll.IsRagdolled(v2) then
                v1.Decision = "TARGET_ALREADY_RAGDOLLED"
                v1.Explanation = "The nominated target was already ragdolled and is not eligible for another Bat hit."
                return v1
            end
            if not GameplayToolGuard.IsPlayerInGameplayArea(a3) then
                v1.Decision = "TARGET_IN_SAFE_ZONE"
                v1.Explanation = "The nominated target was in the safe zone and is not eligible for a Bat hit."
                return v1
            end
            v4 = v3.Position - a4.Position
            local PetMountSession = v2:FindFirstChild("PetMountSession")
            local Attribute = PetMountSession and PetMountSession:GetAttribute("HeightIncrease")
            local v5 = if typeof(Attribute) ~= "number" then 0 else if not (Attribute > 0) then 0 else Attribute
            v2 = (self._range + Config.HitTolerance) * Config.GetHitboxScalar()
            local Position = a4.Position
            local Position_2 = v3.Position
            local Magnitude = (Position_2 - Position).Magnitude
            v1.CurrentDistance = if not (v5 <= 0) then math.min(Magnitude, (Position_2 - (Vector3.new(0, v5, 0)) - Position).Magnitude) else Magnitude
            if v1.CurrentDistance <= v2 then
                v1.Target = a3
                v1.Delta = v4
                v1.Decision = "CURRENT_RANGE_ACCEPTED"
                v1.Explanation = "The server currently sees the target inside MaximumRange; history compensation was not needed."
                return v1
            end
            v3 = math.clamp((a2:GetNetworkPing()) + Config.TargetViewSamplePadding, Config.TargetViewSamplePadding, Config.MaximumTargetViewAge)
            local v6 = a5 - v3
            v1.TargetViewAge = v3
            v1.HistoricalTimestamp = v6
            v3 = AntiCheatService.GetHistoricalPosition(a3, v6)
            if v3 == nil then
                v1.Decision = "HISTORY_UNAVAILABLE"
                v1.Explanation = "Current distance exceeded MaximumRange and the server could not reconstruct the target at HistoricalTimestamp."
                return v1
            end
            v1.HistoricalSampleInterval = v3.SampleInterval
            v1.TargetHistoricalServerPosition = v3.Position
            local Position_3 = a4.Position
            local Position_4 = v3.Position
            local Magnitude_3 = (Position_4 - Position_3).Magnitude
            v1.HistoricalDistance = if not (v5 <= 0) then math.min(Magnitude_3, (Position_4 - (Vector3.new(0, v5, 0)) - Position_3).Magnitude) else Magnitude_3
            if v2 < v1.HistoricalDistance then
                v1.Decision = "CURRENT_AND_HISTORY_OUT_OF_RANGE"
                v1.Explanation = "Both ServerCurrentDistance and ServerHistoricalDistance exceeded MaximumRange."
                return v1
            end
            v1.Target = a3
            v1.Delta = v4
            v1.Decision = "HISTORICAL_RANGE_ACCEPTED"
            v1.Explanation = "Current distance exceeded MaximumRange, but server-owned history proves the target was inside range in the estimated client view."
            return v1
        end
        v1.Decision = "TARGET_CHARACTER_UNAVAILABLE"
        v1.Explanation = "The server could not resolve the nominated target's live character, root, or Humanoid."
        return v1
    end
    v1.Decision = "BOSS_ARENA_PVP_DISABLED"
    v1.Explanation = "Players inside the boss arena cannot hit or be hit by bats."
    return v1
end

function u110:_playSwingNote() -- Line: 465 -- upvalues: u123 (val), u112 (val), Audio (val)
    local SwingNote = self._handle:FindFirstChild("SwingNote")
    if SwingNote and SwingNote:IsA("Sound") then
        Audio.Play(SwingNote, self._handle, {
            MaxDistance = SwingNote.RollOffMaxDistance,
            PlaybackSpeed = SwingNote.PlaybackSpeed * 2 ^ (u112[(u123:NextInteger(1, #u112))] / 12),
        })
        return
    end
end

function u110:_beginActivation(a2) -- Line: 481
    -- upvalues: Player (val), Ragdoll (val), GameplayToolGuard (val)
    local v1 = Player.FindCharacter(a2)
    if not v1 then
        return nil, "ATTACKER_CHARACTER_UNAVAILABLE", "The server could not resolve the attacker's character."
    end
    local v2 = Player.FindHumanoid(a2)
    if v2 and not (v2.Health <= 0) then
        if Ragdoll.IsRagdolled(v1) then
            return nil, "ATTACKER_RAGDOLLED", "The server rejected the swing because the attacker was ragdolled."
        end
        if not GameplayToolGuard.CanActivate(a2) then
            return nil, "GAMEPLAY_GUARD_REJECTED", "The gameplay tool guard rejected the swing before target validation."
        end
        self:_playHitAnimation(a2)
        self:_playSwingNote()
        v2 = Player.FindRootPart(a2)
        if v2 and v2:IsA("BasePart") then
            return v2, "ACTIVATION_ACCEPTED", "The swing passed attacker and gameplay activation guards."
        end
        return nil, "ATTACKER_ROOT_UNAVAILABLE", "The server could not resolve the attacker's HumanoidRootPart."
    end
    return nil, "ATTACKER_DEAD", "The server rejected the swing because the attacker was dead."
end

function u110:_finishMiss() -- Line: 526 -- upvalues: BatServer (val)
    local Slash = self._handle:FindFirstChild("Slash")
    if Slash then
        Slash:Play()
    end
    return BatServer.PLAYER_COOLDOWN
end

function u110:_applyHits(a2, a3) -- Line: 536 -- upvalues: BatServer (val) -- types: a2: userdata, a3: table
    if #a3 == 0 then
        return self:_finishMiss()
    end
    local Hit = self._handle:FindFirstChild("Hit")
    if Hit then
        Hit:Play()
    end
    for i, v in ipairs(a3) do
        self:_applyPlayerHit(v.target, v.delta)
    end
    return BatServer.PLAYER_COOLDOWN
end

function u110:_activate(a2, a3, a4, a5) -- Line: 558
    -- upvalues: BatDamagable (val), BatServer (val)
    local v1, v2, v3 = self:_beginActivation(a2)
    if not v1 then
        self:_logDecisionTrace(a2, a5, a4, nil, a3, nil, v2, v3, "NO_ACTION")
        return nil
    end
    v3 = self:_resolveValidTarget(a2, a3, v1, a4)
    local Target = v3.Target
    local Delta = v3.Delta
    local v4 = BatDamagable.HitWithinRange(a2, v1.Position, self._range)
    if Target and Delta then
        v4 = self:_applyHits(v1, {{target = Target, delta = Delta}})
        self:_logDecisionTrace(a2, a5, a4, v1, a3, v3, v3.Decision, v3.Explanation, "HIT_ACTION_DISPATCHED")
        return v4
    end
    if not (v4 > 0) then
        local v5 = self:_finishMiss()
        self:_logDecisionTrace(a2, a5, a4, v1, a3, v3, v3.Decision, v3.Explanation, "MISS_COOLDOWN_APPLIED")
        return v5
    end
    local Hit = self._handle:FindFirstChild("Hit")
    if Hit then
        Hit:Play()
    end
    self:_logDecisionTrace(
        a2,
        a5,
        a4,
        v1,
        a3,
        v3,
        "DAMAGABLE_HIT",
        ("The swing landed on %* BatDamagable hitbox(es)."):format(v4),
        "DAMAGABLE_HIT_DISPATCHED"
    )
    return BatServer.PLAYER_COOLDOWN
end

function u110:_canProcessRequest(a2) -- Line: 645
    -- upvalues: Player (val), FromTool (val), Ragdoll (val)
    local v1 = Player.FindCharacter(a2)
    if not v1 then
        return false, "REQUEST_CHARACTER_UNAVAILABLE", "The request arrived without a live attacker character."
    end
    if self._tool.Parent == v1 and FromTool(self._tool) == a2 then
        if Ragdoll.IsRagdolled(v1) then
            return false, "REQUEST_ATTACKER_RAGDOLLED", "The server rejected the request because the attacker was ragdolled."
        end
        if self._processing then
            return false, "REQUEST_ALREADY_PROCESSING", "The previous Bat request is still being processed."
        end
        if (workspace:GetServerTimeNow()) < self._cooldownLockedUntil then
            return false, "REQUEST_COOLDOWN_ACTIVE", "The request arrived before the server Bat cooldown ended."
        end
        return true, "REQUEST_ACCEPTED", "The request passed equip, ownership, ragdoll, processing, and cooldown guards."
    end
    return false, "REQUEST_TOOL_NOT_EQUIPPED", "The server rejected the request because this Bat was not equipped and owned by the attacker."
end

function u110:_runActivation(a2, a3) -- Line: 686 -- types: a2: userdata, a3: function
    local v1, v2, v3 = self:_canProcessRequest(a2)
    if not v1 then
        return false, v2, v3
    end
    self._processing = true
    v3 = a3(self, a2)
    self._processing = false
    if v3 then
        self._cooldownLockedUntil = workspace:GetServerTimeNow() + v3
        self:_setCooldownAttributes(v3)
    end
    return true, "REQUEST_PROCESSED", "The server completed the Bat activation callback."
end

function u110:_handleActivation(a2, a3, a4) -- Line: 710
    -- upvalues: t (val), Player (val)
    t.strict(t.instanceIsA("Player"))(a2)
    t.strict(t.optional(t.instanceIsA("Player")))(a3)
    t.strict(t.string)(a4)
    local ServerTimeNow = workspace:GetServerTimeNow()
    local v1, v2, v3 = self:_runActivation(a2, function(a1, a2) -- Line: 722 -- upvalues: a3 (val), ServerTimeNow (val), a4 (val) -- types: a2: userdata
        return a1:_activate(a2, a3, ServerTimeNow, a4)
    end)
    if not v1 then
        self:_logDecisionTrace(a2, a4, ServerTimeNow, Player.FindRootPart(a2), a3, nil, v2, v3, "NO_ACTION")
    end
end

function u110:Destroy() -- Line: 746 -- upvalues: u120 (val)
    self:_stopIdle()
    self._trove:Destroy()
    u120:AtDebug():Log("Bat server controller destroyed")
end

function u110:_init() -- Line: 756 -- upvalues: Remotes (val), FromTool (val)
    local _tool = self._tool
    _tool:SetAttribute("CooldownEndTime", 0)
    _tool:SetAttribute("CooldownDuration", 0)
    _tool:SetAttribute("CooldownActive", false)
    _tool:SetAttribute("IsBat", true)
    self._trove:Connect(Remotes.BatSwing.Trigger.OnServerEvent, function(a1, a2, a3) -- Line: 766 -- upvalues: self (val) -- types: a1: userdata, a2: userdata?, a3: string
        self:_handleActivation(a1, a2, a3)
    end)
    self._trove:Connect(_tool.Equipped, function() -- Line: 770 -- upvalues: FromTool (upval), _tool (val), self (val)
        local v1 = FromTool(_tool)
        if v1 then
            self:_playIdle(v1)
        end
    end)
    self._trove:Connect(_tool.Unequipped, function() -- Line: 778 -- upvalues: self (val)
        self:_stopIdle()
    end)
    self._trove:Connect(_tool.Destroying, function() -- Line: 782 -- upvalues: self (val)
        self:Destroy()
    end)
end

return u110