-- Script path: ReplicatedStorage.Shared.Modules.BatController.Client
-- Decompile time: 20.79 ms

local BatClient = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).BatClient
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Config = require(script.Parent.Config)
require(script.Parent.Types.Interface)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Cooldown = require(ReplicatedStorage.Shared.Utils.Cooldown)
require(ReplicatedStorage.Data.Gears)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local Log = require(ReplicatedStorage.Packages.Log)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local Player = require(ReplicatedStorage.Shared.Player)
local PumpkinBossState = require(ReplicatedStorage.Shared.Util.PumpkinBossState)
local Ragdoll = require(ReplicatedStorage.Shared.Modules.Ragdoll)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local u104 = {}
u104.__index = u104
u104.__class = "BatClientController"
local u107 = Config.MaximumTargetViewAge + 0.1
local u112 = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u117 = Color3.fromRGB(255, 0, 0)
local u122 = Color3.fromRGB(107, 0, 0)
local Inside = HalloweenDimension.PlayerAttributes.Inside
local Trapped = PumpkinBossState.TrapAttributes.Trapped
local u129 = Log.new()
local LocalPlayer = Players.LocalPlayer

function u104.new(a1, a2) -- Line: 88
    -- upvalues: t (val), u104 (val), Config (val), Cooldown (val), BatClient (val), Trove (val)
    t.strict(t.instanceIsA("Tool"))(a1)
    assert(typeof(a2) == "table", "Bat controller data must be a table")
    assert(typeof(a2.Duration) == "number", "Bat controller duration must be a number")
    assert(typeof(a2.Force) == "number", "Bat controller force must be a number")
    assert(typeof(a2.RangeBonus) == "number", "Bat controller range bonus must be a number")
    local v1 = setmetatable({}, u104)
    v1._tool = a1
    v1._highlightAttackerHistory = {}
    v1._targetRange = Config.Range + Config.HitTolerance + a2.RangeBonus
    v1._targetStates = {}
    v1._isEquipped = false
    v1._swingRange = Config.Range + a2.RangeBonus
    v1._lastSwingAt = (-1 / 0)
    v1._nextAutoSwingCheckAt = 0
    v1._traceSequence = 0
    v1._tryActivate = Cooldown(BatClient.CLIENT_COOLDOWN)
    v1._trove = Trove.new()
    v1:_init()
    return v1
end

function u104._cancelTween(a1, a2) -- Line: 123
    local Tween = a2.Tween
    if Tween then
        a2.Tween = nil
        Tween:Cancel()
    end
end

function u104:_destroyHighlight(a2) -- Line: 132
    self:_cancelTween(a2)
    local Highlight = a2.Highlight
    if Highlight then
        Highlight:Destroy()
    end
    a2.Highlight = nil
    a2.Character = nil
    a2.Visible = false
end

function u104:_showHighlight(a2, a3) -- Line: 148
    -- upvalues: u117 (val), u122 (val), TweenService (val), u112 (val)
    if a2.Character ~= a3 then
        self:_destroyHighlight(a2)
    end
    if a2.Visible then
        return
    end
    a2.TransitionVersion = a2.TransitionVersion + 1
    self:_cancelTween(a2)
    local Highlight = a2.Highlight
    if not Highlight then
        local Highlight_2 = Instance.new("Highlight")
        Highlight_2.Name = "BatTargetHighlight"
        Highlight_2.Adornee = a3
        Highlight_2.DepthMode = Enum.HighlightDepthMode.Occluded
        Highlight_2.FillColor = u117
        Highlight_2.OutlineColor = u122
        Highlight_2.FillTransparency = 1
        Highlight_2.OutlineTransparency = 1
        Highlight_2.Parent = a3
        a2.Highlight = Highlight_2
        Highlight = Highlight_2
    end
    a2.Character = a3
    a2.Visible = true
    local v1 = TweenService:Create(
        assert(Highlight, "Bat target Highlight must exist before fade-in"),
        u112,
        {FillTransparency = 0.5, OutlineTransparency = 0.15}
    )
    a2.Tween = v1
    v1:Play()
end

function u104:_hideHighlight(a2) -- Line: 192
    if not a2.Highlight then
        return
    end
    self:_destroyHighlight(a2)
end

function u104:_trackPlayer(a2) -- Line: 203 -- upvalues: LocalPlayer (val) -- types: a2: userdata
    if a2 ~= LocalPlayer and not self._targetStates[a2] then
        self._targetStates[a2] = {TransitionVersion = 0, Visible = false}
        return
    end
end

function u104:_untrackPlayer(a2) -- Line: 217 -- types: a2: userdata
    local v1 = self._targetStates[a2]
    if not v1 then
        return
    end
    self:_destroyHighlight(v1)
    self._targetStates[a2] = nil
end

local function riderRise(a1) -- Line: 228 -- types: a1: userdata
    local PetMountSession = a1:FindFirstChild("PetMountSession")
    local Attribute = PetMountSession and PetMountSession:GetAttribute("HeightIncrease")
    if typeof(Attribute) == "number" and Attribute > 0 then
        return Attribute
    end
    return 0
end

local function reachDistance(a1, a2, a3) -- Line: 234 -- types: a1: vector, a2: vector, a3: number
    local Magnitude = (a2 - a1).Magnitude
    if a3 <= 0 then
        return Magnitude
    end
    return (math.min(Magnitude, (a2 - (Vector3.new(0, a3, 0)) - a1).Magnitude))
end

function u104._isTargetEligible(a1, a2, a3, a4) -- Line: 242
    -- upvalues: Player (val), Ragdoll (val), ToolGameplayGuard (val), LocalPlayer (val)
    local v1 = Player.FindCharacter(a2)
    local v2 = Player.FindRootPart(a2)
    local v3 = Player.FindHumanoid(a2)
    if v1 and v2 and v2:IsA("BasePart") and v3 and not (v3.Health <= 0) then
        if Ragdoll.IsRagdolled(v1) or not ToolGameplayGuard.IsInsideArena(a2) then
            return false, (1 / 0)
        end
        if not LocalPlayer:GetAttribute("InBossArena")
            and not a2:GetAttribute("InBossArena")
            and not LocalPlayer:GetAttribute("InScrambleArena")
            and not a2:GetAttribute("InScrambleArena")
            and not LocalPlayer:GetAttribute("InPumpkinArena")
            and not a2:GetAttribute("InPumpkinArena") then
            if workspace:GetAttribute("PvPDisabled") == true then
                return false, (1 / 0)
            end
            local Position = a3.Position
            local Position_2 = v2.Position
            local PetMountSession = v1:FindFirstChild("PetMountSession")
            local Attribute = PetMountSession and PetMountSession:GetAttribute("HeightIncrease")
            local v4 = if typeof(Attribute) ~= "number" then 0 else if not (Attribute > 0) then 0 else Attribute
            local Magnitude = (Position_2 - Position).Magnitude
            v3 = if not (v4 <= 0) then math.min(Magnitude, (Position_2 - (Vector3.new(0, v4, 0)) - Position).Magnitude) else Magnitude
            return v3 <= a4, v3
        end
        return false, (1 / 0)
    end
    return false, (1 / 0)
end

function u104:_recordHighlightAttackerSample(a2, a3) -- Line: 291
    -- upvalues: u107 (val)
    local _highlightAttackerHistory = self._highlightAttackerHistory
    _highlightAttackerHistory[#_highlightAttackerHistory + 1] = {Position = a3, Timestamp = a2}
    local v1 = a2 - u107
    while #_highlightAttackerHistory > 2 do
        if not (_highlightAttackerHistory[2].Timestamp < v1) then
            break
        end
        table.remove(_highlightAttackerHistory, 1)
    end
end

function u104:_getHighlightAttackerPositionAt(a2) -- Line: 310 -- types: a2: number
    local _highlightAttackerHistory = self._highlightAttackerHistory
    local v1 = _highlightAttackerHistory[1]
    local v2 = _highlightAttackerHistory[#_highlightAttackerHistory]
    if v1 and v2 and not (a2 < v1.Timestamp) and not (v2.Timestamp < a2) then
        local v3
        local v4 = #_highlightAttackerHistory
        for i = 2, v4 do
            v2 = _highlightAttackerHistory[i]
            if a2 <= v2.Timestamp then
                v1 = _highlightAttackerHistory[i - 1]
                v3 = v2.Timestamp - v1.Timestamp
                if v3 <= 0 then
                    return v2.Position
                end
                return v1.Position:Lerp(v2.Position, (math.clamp((a2 - v1.Timestamp) / v3, 0, 1)))
            end
        end
        return nil
    end
    return nil
end

function u104:_predictServerAcceptsHighlightTarget(a2, a3, a4) -- Line: 347
    -- upvalues: Config (val), Player (val), LocalPlayer (val)
    local v1 = self._targetRange * Config.GetHitboxScalar()
    if not self:_isTargetEligible(a2, a3, v1) then
        return false
    end
    local v2 = Player.FindRootPart(a2)
    if v2 and v2:IsA("BasePart") then
        local NetworkPing = LocalPlayer:GetNetworkPing()
        local v3 = self:_getHighlightAttackerPositionAt(a4 - (math.clamp(0.14 + NetworkPing, 0.14, Config.MaximumTargetViewAge)))
        if not v3 then
            return false
        end
        local v4 = math.clamp(NetworkPing + Config.TargetViewSamplePadding, Config.TargetViewSamplePadding, Config.MaximumTargetViewAge)
        local Position = v2.Position
        v4 = Position + v2.AssemblyLinearVelocity * v4
        local v5 = Player.FindCharacter(a2)
        if not v5 then
            v2 = 0
        else
            local PetMountSession = v5:FindFirstChild("PetMountSession")
            local Attribute = PetMountSession and PetMountSession:GetAttribute("HeightIncrease")
            v2 = if typeof(Attribute) ~= "number" then 0 else if not (Attribute > 0) then 0 else Attribute
        end
        local Magnitude = (Position - v3).Magnitude
        v5 = if not (v2 <= 0) then math.min(Magnitude, (Position - (Vector3.new(0, v2, 0)) - v3).Magnitude) else Magnitude
        local Magnitude_3 = (v4 - v3).Magnitude
        local v6 = if not (v2 <= 0) then math.min(Magnitude_3, (v4 - (Vector3.new(0, v2, 0)) - v3).Magnitude) else Magnitude_3
        local v7 = true
        if not (v5 <= v1) then
            v7 = v6 <= v1
        end
        return v7
    end
    return false
end

function u104:_updateHighlights() -- Line: 396 -- upvalues: Player (val), LocalPlayer (val), Ragdoll (val)
    local v1, v2
    local v3 = Player.FindCharacter(LocalPlayer)
    local v4 = Player.FindRootPart(LocalPlayer)
    local _isEquipped = self._isEquipped
    if _isEquipped then
        _isEquipped = false
        if v3 ~= nil then
            _isEquipped = false
            if v4 ~= nil then
                _isEquipped = v4:IsA("BasePart") and not Ragdoll.IsRagdolled(v3)
            end
        end
    end
    v3 = nil
    if not _isEquipped then
        table.clear(self._highlightAttackerHistory)
    else
        local ServerTimeNow = workspace:GetServerTimeNow()
        self:_recordHighlightAttackerSample(ServerTimeNow, v4.Position)
        v2 = self:_selectClosestTarget()
        if v2 and self:_predictServerAcceptsHighlightTarget(v2, v4, ServerTimeNow) then
            v3 = v2
        end
    end
    v2 = nil
    local v5 = nil
    for i, j in self._targetStates, v2, v5 do
        v1 = if i ~= v3 then nil else Player.FindCharacter(i)
        if not v1 then
            v6:_hideHighlight(j)
        else
            v6:_showHighlight(j, v1)
        end
    end
end

function u104:_selectClosestTarget() -- Line: 440
    -- upvalues: Player (val), LocalPlayer (val), Ragdoll (val), Config (val)
    local v1 = Player.FindCharacter(LocalPlayer)
    local v2 = Player.FindRootPart(LocalPlayer)
    if v1 and v2 and v2:IsA("BasePart") and not Ragdoll.IsRagdolled(v1) then
        local v3, v4
        v1 = nil
        local v5 = (1 / 0)
        local v6 = self._targetRange * Config.GetHitboxScalar()
        for i in self._targetStates do
            v3, v4 = self:_isTargetEligible(i, v2, v6)
            if v3 and v4 < v5 then
                v1 = i
            end
        end
        return v1
    end
    return nil
end

function u104:_logActivationTrace(a2, a3, a4) -- Line: 469
    -- upvalues: Constants (val), Player (val), LocalPlayer (val), u129 (val), Config (val)
    if not Constants.IS_STUDIO then
        return
    end
    local v1 = Player.FindHumanoid(LocalPlayer)
    local v2 = if not a3 then nil else Player.FindRootPart(a3)
    local v3 = if not v2 then nil else if not v2:IsA("BasePart") then nil else v2
    local AssemblyLinearVelocity = if not v3 then Vector3.new(0, 0, 0) else v3.AssemblyLinearVelocity
    local AssemblyLinearVelocity_2 = a4.AssemblyLinearVelocity
    local Magnitude = if not v3 then -1 else (v3.Position - a4.Position).Magnitude
    local v4 = if a3 ~= nil then if v3 ~= nil then "CLIENT_TARGET_NOMINATED: this is the player and distance your PC rendered at the swing moment." else "CLIENT_TARGET_ROOT_MISSING: the nominated player's rendered root disappeared before the swing was sent." else "CLIENT_NO_TARGET: your PC did not nominate an eligible player inside ClientSelectionRange at the swing moment."
    local v5 = u129:AtInfo()
    local v6 = {
        Stage = "CLIENT_SWING",
        TraceId = a2,
        Interpretation = v4,
        ClientServerTime = workspace:GetServerTimeNow(),
        AttackerName = LocalPlayer.Name,
        AttackerUserId = LocalPlayer.UserId,
        TargetName = if not a3 then "None" else a3.Name,
        TargetUserId = if not a3 then 0 else a3.UserId,
        TargetNominated = a3 ~= nil,
        ClientSelectionRange = self._targetRange * Config.GetHitboxScalar(),
        ClientVisibleDistance = Magnitude,
        AttackerPosition = a4.Position,
        TargetPosition = if not v3 then Vector3.new(0, 0, 0) else v3.Position,
        AttackerWalkSpeed = if not v1 then -1 else v1.WalkSpeed,
        AttackerHorizontalSpeed = Vector3.new(AssemblyLinearVelocity_2.X, 0, AssemblyLinearVelocity_2.Z).Magnitude,
        TargetHorizontalSpeed = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude,
    }
    local v7 = false
    if v3 ~= nil then
        v7 = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude <= 1
    end
    v6.TargetAppearsStationary = v7
    v5:Log("Bat hit validation trace", v6)
end

function u104._logLocalRejection(a1, a2, a3, a4) -- Line: 518
    -- upvalues: Constants (val), Player (val), LocalPlayer (val), u129 (val), BatClient (val)
    if not Constants.IS_STUDIO then
        return
    end
    local v1 = Player.FindRootPart(LocalPlayer)
    local v2 = Player.FindHumanoid(LocalPlayer)
    local AssemblyLinearVelocity = if not v1 then Vector3.new(0, 0, 0) else if not v1:IsA("BasePart") then Vector3.new(0, 0, 0) else v1.AssemblyLinearVelocity
    local v3 = u129:AtInfo()
    local v4 = {
        Stage = "CLIENT_LOCAL_REJECTED",
        TraceId = a2,
        Decision = a3,
        Explanation = a4,
        ClientServerTime = workspace:GetServerTimeNow(),
        AttackerName = LocalPlayer.Name,
        AttackerUserId = LocalPlayer.UserId,
    }
    v4.AttackerPosition = if not v1 then Vector3.new(0, 0, 0) else if not v1:IsA("BasePart") then Vector3.new(0, 0, 0) else v1.Position
    v4.AttackerWalkSpeed = if not v2 then -1 else v2.WalkSpeed
    v4.AttackerHorizontalSpeed = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude
    v4.ClientCooldownSeconds = BatClient.CLIENT_COOLDOWN
    v3:Log("Bat hit validation trace", v4)
end

function u104:_onActivated(a2) -- Line: 548
    -- upvalues: LocalPlayer (val), ToolGameplayGuard (val), Player (val), Ragdoll (val), Remotes (val)
    self._traceSequence = self._traceSequence + 1
    local u17 = ("%*:%*:%*"):format(LocalPlayer.UserId, self._traceSequence, (math.floor((workspace:GetServerTimeNow()) * 1000)))
    if not self._isEquipped then
        self:_logLocalRejection(
            u17,
            "CLIENT_TOOL_NOT_EQUIPPED",
            "The Bat Activated signal fired while this client controller did not consider the tool equipped."
        )
        return
    end
    if not ToolGameplayGuard.AllowsLocalUse(self._tool) then
        self:_logLocalRejection(
            u17,
            "CLIENT_GAMEPLAY_GUARD_REJECTED",
            "The local gameplay-area guard rejected the swing before any server request was sent."
        )
        return
    end
    if not self._tryActivate(function() -- Line: 572
        -- upvalues: Player (upval), LocalPlayer (upval), Ragdoll (upval), self (val), u17 (val), a2 (val)
        -- upvalues: Remotes (upval)
        local BatSwing, BatSwing_2, Trigger, Trigger_2, v0, v1, v2, v3, v4, v5, v6
        v0 = Player.FindCharacter(LocalPlayer)
        v1 = Player.FindRootPart(LocalPlayer)
        v2 = Player.FindHumanoid(LocalPlayer)
        if v0 then
            if v1 then
                if v1:IsA("BasePart") then
                    if v2 then
                        if not (v2.Health <= 0) then
                            if not Ragdoll.IsRagdolled(v0) then
                                self._lastSwingAt = os.clock()
                                if not a2 then
                                    v2 = self:_selectClosestTarget()
                                    v3 = self
                                    v5 = u17
                                    v3:_logActivationTrace(v5, v2, v1)
                                    v3 = Remotes
                                    BatSwing_2 = v3.BatSwing
                                    Trigger_2 = BatSwing_2.Trigger
                                    v6 = u17
                                    Trigger_2:FireServer(v2, v6)
                                    return
                                else
                                    v3 = Remotes
                                    BatSwing = v3.BatSwing
                                    Trigger = BatSwing.Trigger
                                    v6 = u17
                                    Trigger:FireServer(nil, v6)
                                    return
                                end
                            end
                        end
                    end
                end
            end
        end
        v3 = self
        v5 = u17
        v3:_logLocalRejection(
            v5,
            "CLIENT_CHARACTER_STATE_REJECTED",
            "The client had no usable character/root, was dead or was ragdolled when the debounced swing executed."
        )
        return
    end) then
        self:_logLocalRejection(
            u17,
            "CLIENT_COOLDOWN_ACTIVE",
            "The client Bat cooldown rejected this click, so no server request was sent."
        )
    end
end

local function distanceToBox(a1, a2) -- Line: 615 -- types: a1: userdata, a2: vector
    local v1 = a1.CFrame:PointToObjectSpace(a2)
    local v2 = a1.Size * 0.5
    return (v1 - Vector3.new(math.clamp(v1.X, -v2.X, v2.X), math.clamp(v1.Y, -v2.Y, v2.Y), (math.clamp(v1.Z, -v2.Z, v2.Z)))).Magnitude
end

function u104:_hasAutoSwingTarget(a2) -- Line: 627
    -- upvalues: CollectionService (val), distanceToBox (val)
    local Attribute, v1
    for i, j in CollectionService:GetTagged("BatDamagable") do
        if j:IsA("BasePart") then
            v1 = workspace
            if j:IsDescendantOf(v1) then
                Attribute = j:GetAttribute("Health")
                if typeof(Attribute) == "number"
                    and not (Attribute <= 0)
                    and (distanceToBox(j, a2.Position)) <= self._swingRange then
                    return true
                end
            end
        end
    end
    return false
end

function u104:_autoSwing() -- Line: 647
    -- upvalues: LocalPlayer (val), PlatformController (val), Inside (val), BatClient (val), Player (val), Ragdoll (val)
    -- upvalues: Trapped (val), ToolGameplayGuard (val)
    local v1 = os.clock()
    if self._isEquipped and not (v1 < self._nextAutoSwingCheckAt) then
        local v2, v3, v4
        self._nextAutoSwingCheckAt = v1 + 0.1
        local v5 = LocalPlayer:GetAttribute("InPumpkinArena") == true
        if v5 then
            if not PlatformController.IsMobile() then
                return
            end
            v2 = self
            if v1 - v2._lastSwingAt < BatClient.CLIENT_COOLDOWN then
                return
            end
            v1 = v2._tool:GetAttribute("CooldownEndTime")
            if typeof(v1) == "number" and workspace:GetServerTimeNow() < v1 then
                return
            end
            v1 = Player.FindCharacter(LocalPlayer)
            v3 = Player.FindRootPart(LocalPlayer)
            v4 = Player.FindHumanoid(LocalPlayer)
            if v1 and v3 and v3:IsA("BasePart") and v4 and not (v4.Health <= 0) and not Ragdoll.IsRagdolled(v1) then
                if v5 and v1:GetAttribute(Trapped) == true then
                    return
                end
                if v5 then
                    if not v2:_hasAutoSwingTarget(v3) then
                        return
                    end
                    v2:_onActivated(true)
                    return
                end
                if ToolGameplayGuard.IsLocalInsideArena() and not ToolGameplayGuard.IsInsideSafeZone(LocalPlayer) then
                    if not v2:_hasAutoSwingTarget(v3) then
                        return
                    end
                    v2:_onActivated(true)
                    return
                end
                return
            end
            return
        end
        if LocalPlayer:GetAttribute(Inside) ~= true then
            return
        end
        v2 = self
        if v1 - v2._lastSwingAt < BatClient.CLIENT_COOLDOWN then
            return
        end
        v1 = v2._tool:GetAttribute("CooldownEndTime")
        if typeof(v1) == "number" and workspace:GetServerTimeNow() < v1 then
            return
        end
        v1 = Player.FindCharacter(LocalPlayer)
        v3 = Player.FindRootPart(LocalPlayer)
        v4 = Player.FindHumanoid(LocalPlayer)
        if v1 and v3 and v3:IsA("BasePart") and v4 and not (v4.Health <= 0) and not Ragdoll.IsRagdolled(v1) then
            if v5 and v1:GetAttribute(Trapped) == true then
                return
            end
            if v5 then
                if not v2:_hasAutoSwingTarget(v3) then
                    return
                end
                v2:_onActivated(true)
                return
            end
            if ToolGameplayGuard.IsLocalInsideArena() and not ToolGameplayGuard.IsInsideSafeZone(LocalPlayer) then
                if not v2:_hasAutoSwingTarget(v3) then
                    return
                end
                v2:_onActivated(true)
                return
            end
            return
        end
        return
    end
end

function u104:_onEquipped() -- Line: 709
    self._isEquipped = true
end

function u104:Destroy() -- Line: 717 -- upvalues: u129 (val)
    self._trove:Destroy()
    for i in self._targetStates do
        self:_untrackPlayer(i)
    end
    u129:AtDebug():Log("Bat client controller destroyed")
end

function u104:_init() -- Line: 731
    -- upvalues: Players (val), RunService (val), Constants (val), Player (val), LocalPlayer (val)
    for i, v in ipairs(Players:GetPlayers()) do
        task.defer(function() -- Line: 733 -- upvalues: self (val), v (val)
            self:_trackPlayer(v)
        end)
    end
    self._trove:Connect(Players.PlayerAdded, function(a1) -- Line: 738 -- upvalues: self (val) -- types: a1: userdata
        self:_trackPlayer(a1)
    end)
    self._trove:Connect(Players.PlayerRemoving, function(a1) -- Line: 742 -- upvalues: self (val) -- types: a1: userdata
        self:_untrackPlayer(a1)
    end)
    self._trove:Connect(self._tool.Equipped, function() -- Line: 746 -- upvalues: self (val)
        self:_onEquipped()
    end)
    self._trove:Connect(self._tool.Unequipped, function() -- Line: 750 -- upvalues: self (val)
        self._isEquipped = false
        self:_updateHighlights()
    end)
    self._trove:Connect(self._tool.Activated, function() -- Line: 755 -- upvalues: self (val)
        self:_onActivated()
    end)
    self._trove:Connect(RunService.Heartbeat, function() -- Line: 759 -- upvalues: self (val)
        self:_autoSwing()
    end)
    if Constants.IS_MOBILE then
        self._trove:Connect(RunService.PreRender, function() -- Line: 764 -- upvalues: self (val)
            self:_updateHighlights()
        end)
    end
    self._trove:Connect(self._tool.Destroying, function() -- Line: 769 -- upvalues: self (val)
        self:Destroy()
    end)
    local v1 = Player.FindCharacter(LocalPlayer)
    if v1 and self._tool.Parent == v1 then
        self:_onEquipped()
    end
end

return u104