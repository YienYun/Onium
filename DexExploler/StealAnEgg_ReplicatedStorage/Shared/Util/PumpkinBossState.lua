-- Script path: ReplicatedStorage.Shared.Util.PumpkinBossState
-- Decompile time: 3.36 ms

local u0 = {
    ArenaName = "PumpkinArena",
    MemberAttribute = "InPumpkinArena",
    CannonFolder = "Cannons",
    MinionFolder = "Minions",
    VineFolder = "Vines",
}
u0.MinionAnims = table.freeze({Idle = 88399787339165, Walk = 102905279892441})
u0.ExitTag = "PumpkinBossExit"
u0.ReturnTag = "PumpkinBossReturn"
u0.Phases = table.freeze({
    Waiting = "Waiting",
    BruteIntro = "BruteIntro",
    Brute = "Brute",
    BruteDown = "BruteDown",
    KingIntro = "KingIntro",
    King = "King",
    Shield = "Shield",
    Stunned = "Stunned",
    Defeated = "Defeated",
})
u0.Attributes = table.freeze({
    Phase = "Phase",
    Boss = "Boss",
    BossName = "BossName",
    Health = "Health",
    MaxHealth = "MaxHealth",
    SpawnsAt = "SpawnsAt",
    EndsAt = "EndsAt",
    SkipCutscenes = "SkipCutscenes",
    FloorY = "FloorY",
    Center = "Center",
    ShieldActive = "ShieldActive",
    ShieldHealth = "ShieldHealth",
    ShieldMax = "ShieldMax",
    StunEnds = "StunEnds",
    Scene = "Scene",
    SceneAt = "SceneAt",
    SceneEnds = "SceneEnds",
})
u0.ModelAttributes = table.freeze({Anim = "Anim", AnimAt = "AnimAt", Decaying = "Decaying", Stunned = "Stunned"})
u0.TrapAttributes = table.freeze({Trapped = "IsTrapped", TrapEnds = "PumpkinTrapEnds", TrapUserId = "PumpkinTrapUserId"})
u0.CannonAttributes = table.freeze({
    OwnerUserId = "OwnerUserId",
    Ready = "Ready",
    CannonId = "CannonId",
    Base = "CannonBase",
    Hinge = "CannonHinge",
    Barrel = "CannonBarrel",
})
u0.CannonAim = table.freeze({
    MaxPitch = 1.0471975511965976,
    MinDistance = 12,
    TurnRate = 3.141592653589793,
    PitchRate = 2.0943951023931953,
})
u0.Fx = table.freeze({
    Callout = "Callout",
    Scene = "Scene",
    BossHit = "BossHit",
    BossSpawn = "BossSpawn",
    Stomp = "Stomp",
    Swipe = "Swipe",
    Charge = "Charge",
    BruteDown = "BruteDown",
    BruteHead = "BruteHead",
    KingRise = "KingRise",
    ShadowDash = "ShadowDash",
    VineTrap = "VineTrap",
    VineHit = "VineHit",
    VineBreak = "VineBreak",
    MinionSpawn = "MinionSpawn",
    MinionHit = "MinionHit",
    MinionPop = "MinionPop",
    MinionBoom = "MinionBoom",
    MinionArm = "MinionArm",
    ShieldUp = "ShieldUp",
    ShieldHit = "ShieldHit",
    ShieldBreak = "ShieldBreak",
    RootHit = "RootHit",
    RootBreak = "RootBreak",
    CannonShot = "CannonShot",
    CannonImpact = "CannonImpact",
    Stun = "Stun",
    Defeated = "Defeated",
    Currency = "Currency",
})
u0.SceneSeconds = table.freeze({
    AdminIntro = 51,
    BruteRise = 17.2,
    BruteDecay = 0.6,
    KingEmerge = 0,
    ShieldUp = 2,
    ShieldBreak = 2,
    KingDefeat = 4,
    AdminOutro = 18.4,
    AdminOutro2 = 27.4,
})
u0.Callouts = table.freeze({
    BruteBegin = "",
    BruteRoots = "",
    BruteDash = "",
    BruteBombs = "",
    BruteFalls = "",
    KingStart = "",
    KingRoots = "",
    KingBarrage = "",
    KingSummon = "",
    KingDash = "",
    ShieldUp = "",
    ShieldDown = "",
    TimeUp = "TIME'S UP!",
    SceneBruteRise = "",
    SceneBruteDecay = "",
    SceneKingEmerge = "",
    SceneShieldUp = "",
    SceneShieldBreak = "",
    SceneKingDefeat = "",
})
u0.Clips = table.freeze({
    Brute = table.freeze({
        Idle = table.freeze({Id = 75442270908318, Length = 10}),
        Walk = table.freeze({Id = 120204162676218, Length = 3.2}),
        Death = table.freeze({Id = 127252928509264, Length = 4.667}),
        LeftSwipe = table.freeze({Id = 97068697457453, Length = 4.4}),
        RightSwipe = table.freeze({Id = 100968401290711, Length = 4.4}),
        Charge = table.freeze({Id = 79468673225508, Length = 7.233}),
        RootSummon = table.freeze({Id = 119974702599805, Length = 4.8}),
        Slam = table.freeze({Id = 117792582730583, Length = 4.9}),
        Throw = table.freeze({Id = 94916143697941, Length = 3.667}),
    }),
    King = table.freeze({
        Idle = table.freeze({Id = 133032796882176, Length = 12}),
        Death = table.freeze({Id = 102873057827511, Length = 4.6}),
        Walk = table.freeze({Id = 96596796653355, Length = 3}),
        SummonMinions = table.freeze({Id = 112177597531265, Length = 5}),
        SummonVines = table.freeze({Id = 127715894828384, Length = 4.5}),
        Barrage = table.freeze({Id = 81018978118733, Length = 3.667}),
        ShadowDash = table.freeze({Id = 105710255538920, Length = 2.6}),
        ShieldCast = table.freeze({Id = 79759495045913, Length = 4.617}),
        ShieldBreak = table.freeze({Id = 90740255794265, Length = 2.4}),
        Stunned = table.freeze({Id = 101846677332327, Length = 3.6}),
    }),
})
local u129 = {}
u129.Brute = table.freeze({
    Idle = {Clip = "Idle", Loop = true},
    Walk = {Clip = "Walk", Loop = true},
    Rise = {Clip = "Idle"},
    SwipeLeft = {Clip = "LeftSwipe", Speed = 1, Windup = 2.25},
    SwipeRight = {Clip = "RightSwipe", Speed = 1, Windup = 2.25},
    Stomp = {Clip = "Slam", Speed = 1.15, Windup = 1.35},
    Slam = {Clip = "Slam", Speed = 0.65, Windup = 1.4},
    Summon = {Clip = "RootSummon", Speed = 1},
    Throw = {Clip = "Throw", Speed = 1, Windup = 1.2},
    Charge = {Clip = "Charge", Speed = 1, Windup = 1.2},
    ChargeEnd = {Clip = "Charge", From = 5, Speed = 1},
    Kneel = {Clip = "Death", Hold = true},
})
u129.King = table.freeze({
    Idle = {Clip = "Idle", Loop = true},
    Rise = {Clip = "Idle", Loop = true},
    Walk = {Clip = "Walk", Loop = true},
    SummonMinions = {Clip = "SummonMinions", Speed = 1},
    SummonVines = {Clip = "SummonVines", Speed = 1},
    Barrage = {Clip = "Barrage", Speed = 1},
    ShadowDash = {Clip = "ShadowDash", Speed = 1, Windup = 0.65},
    Shield = {Clip = "ShieldCast", Speed = 1},
    ShieldBreak = {Clip = "ShieldBreak", Speed = 1},
    Stunned = {Clip = "Stunned", Loop = true},
    Defeat = {Clip = "Death", Hold = true},
})
u0.Anims = table.freeze(u129)

function u0.Windup(a1, a2, a3) -- Line: 246 -- upvalues: u129 (val) -- types: a1: string, a2: string, a3: number
    local v1 = u129[a1]
    local v2 = v1 and v1[a2]
    if v2 ~= nil and v2.Windup ~= nil then
        return v2.Windup / (v2.Speed or 1)
    end
    return a3
end

function u0.Duration(a1, a2, a3) -- Line: 256
    -- upvalues: u129 (val), u0 (val)
    local v1 = u129[a1]
    local v2 = v1 and v1[a2]
    v1 = u0.Clips[a1]
    local v3 = v2 and v1 and v1[v2.Clip]
    if v2 ~= nil and v3 ~= nil then
        return (math.max(v3.Length - (v2.From or 0), 0)) / (v2.Speed or 1)
    end
    return a3
end

u0.ProjectileGravity = 80

function u0.LaunchVelocity(a1, a2, a3) -- Line: 270 -- types: a1: vector, a2: vector, a3: number
    local v1 = math.max(a3, 0.05)
    return (a2 - a1) / v1 + Vector3.new(0, v1 * 40, 0)
end

function u0.Arc(a1, a2, a3) -- Line: 275 -- types: a1: vector, a2: vector, a3: number
    return a1 + a2 * a3 - Vector3.new(0, a3 * 40 * a3, 0)
end

function u0.ShotFlight(a1, a2) -- Line: 281 -- types: a1: vector, a2: vector
    return (math.clamp((a2 - a1).Magnitude / 120, 0.6, 1.6))
end

function u0.ShotKey(a1, a2) -- Line: 285 -- types: a1: number, a2: number
    return (("%*:%*"):format(a1, a2))
end

return table.freeze(u0)