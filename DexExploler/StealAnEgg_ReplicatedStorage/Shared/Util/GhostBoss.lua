-- Script path: ReplicatedStorage.Shared.Util.GhostBoss
-- Decompile time: 3.53 ms

local v1 = table.freeze({
    BossId = "BossId",
    Phase = "Phase",
    Ground = "Ground",
    Velocity = "Velocity",
    MovedAt = "MovedAt",
    Yaw = "Yaw",
    Health = "Health",
    MaxHealth = "MaxHealth",
    SpawnedAt = "SpawnedAt",
    SpawnSeconds = "SpawnSeconds",
    EndsAt = "EndsAt",
    CaptureUserId = "CaptureUserId",
    CaptureAt = "CaptureAt",
    CaptureSeconds = "CaptureSeconds",
    DefeatAt = "DefeatAt",
    ExplodePosition = "ExplodePosition",
    DropPosition = "DropPosition",
    Suckers = "Suckers",
    AttackSerial = "AttackSerial",
    AttackPhase = "AttackPhase",
    AttackTarget = "AttackTarget",
    AttackHits = "AttackHits",
    EscapedAt = "EscapedAt",
    Realm = "Realm",
})
local v2 = table.freeze({None = "", Windup = "Windup", Charge = "Charge"})
local u8 = table.freeze({World = "World", Town = "Town"})
return table.freeze({
    DisplayName = "Ghouler",
    StateName = "GhostBossState",
    AssetsName = "GhostBossAssets",
    ToolAttribute = "GhostBossVacuum",
    TrainVacuumAttribute = "GhostVacuum",
    SuckingAttribute = "GhostBossSucking",
    Attributes = v1,
    Phases = table.freeze({
        None = "None",
        Spawning = "Spawning",
        Alive = "Alive",
        Capturing = "Capturing",
        Defeated = "Defeated",
        Escaped = "Escaped",
    }),
    AttackPhases = v2,
    Realms = u8,
    ScaleFor = function(a1, a2, a3) -- Line: 94 -- types: a1: number, a2: number, a3: number
        local v1 = math.max(1 - a2, 0.001)
        local v2 = math.clamp((a1 - a2) / v1, 0, 1)
        return (a3 - 1) * v2 + 1
    end,
    CaptureProgress = function(a1, a2) -- Line: 100 -- types: a1: number, a2: number
        local v1 = math.max(1 - a2, 0.001)
        return 1 - math.clamp((a1 - a2) / v1, 0, 1)
    end,
    Center = function(a1, a2, a3, a4) -- Line: 105 -- types: a1: vector, a2: number, a3: number, a4: number
        return a1 + Vector3.new(0, a4 + a3 * a2, 0)
    end,
    EncodeSuckers = function(a1) -- Line: 114 -- types: a1: table
        table.sort(a1)
        local v1 = table.create(#a1)
        for i, j in a1 do
            v1[i] = (tostring(j))
        end
        return table.concat(v1, ",")
    end,
    DecodeSuckers = function(a1) -- Line: 123
        local v1
        local v2 = {}
        if type(a1) ~= "string" then
            return v2
        end
        for i in string.gmatch(a1, "[^,]+") do
            v1 = tonumber(i)
            if v1 then
                table.insert(v2, v1)
            end
        end
        return v2
    end,
    IsVacuum = function(a1) -- Line: 137 -- types: a1: userdata
        local v1 = a1:IsA("Tool")
        if v1 then
            v1 = true
            if a1:GetAttribute("GhostBossVacuum") == nil then
                v1 = a1:GetAttribute("GhostVacuum") == true
            end
        end
        return v1
    end,
    IsTrainVacuum = function(a1) -- Line: 145 -- types: a1: userdata
        return a1:IsA("Tool") and a1:GetAttribute("GhostVacuum") == true
    end,
    RealmOf = function(a1) -- Line: 149 -- upvalues: u8 (val) -- types: a1: userdata
        local Attribute = a1:GetAttribute("TrainEventPhase")
        if Attribute == "Town" then
            return u8.Town
        end
        if Attribute ~= nil and Attribute ~= "Home" then
            return nil
        end
        if a1:GetAttribute("InHalloweenDimension") == true then
            return nil
        end
        return u8.World
    end,
    RealmNamed = function(a1) -- Line: 163 -- upvalues: u8 (val)
        if a1 == u8.Town then
            return u8.Town
        end
        return u8.World
    end,
    TemplateHalfHeight = function(a1) -- Line: 167 -- types: a1: userdata
        return a1:GetExtentsSize().Y / 2 / a1:GetScale()
    end,
})