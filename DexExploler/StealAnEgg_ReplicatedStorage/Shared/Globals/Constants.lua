-- Script path: ReplicatedStorage.Shared.Globals.Constants
-- Decompile time: 2.54 ms

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local v1 = RunService:IsServer()
local v2 = RunService:IsStudio()
local v3 = not v1 and UserInputService.PreferredInput == Enum.PreferredInput.Touch
local v4 = {
    TARGET_RADIUS = 300,
    DELETE_COUNT_BUFFER = 50,
    DELETE_COUNT_BUFFER_FAST = 75,
    INSERT_DELETE_COUNT_BUFFER = 550,
    CREATE_INSTANCE_COUNT_BUFFER = 550,
    STREAM_DIR_STACKING_WEIGHT_BUFFER = 950,
    STREAM_DIR_REPLICATION_WEIGHT_BUFFER = 950,
}
local v5 = v4.TARGET_RADIUS * 2.4
v4.COLLECTABLES_RANGE_BY_TYPE = {
    Star = {NormalMode = v5 * 2, PerfMode = v5 * 2},
    Default = {NormalMode = v5, PerfMode = v5 * 0.85},
}
return require(game:GetService("ReplicatedStorage").Shared.Flags.BalanceConfig).Bind("Game.Balance.Player", {
    IS_SERVER = v1,
    IS_CLIENT = not v1,
    IS_STUDIO = v2,
    IS_MOBILE = v3,
    IS_PRIVATE_SERVER = v1 and game.PrivateServerId ~= "",
    TAGS_MAP = {
        Traps = {PLACED_TRAP = "PlacedTrap", UNPLACE_PROMPT = "TrapUnplacePrompt"},
        GravityDisruptors = {PLACED_DISRUPTOR = "PlacedGravityDisruptor", UNPLACE_PROMPT = "GravityDisruptorUnplacePrompt"},
        Gameplay = {COLLISION_PART = "CollisionPart", SAFE_ZONE = "SafeZone"},
    },
    STREAMING = v4,
    BUTTON_FX = {BUTTON_MOUSE_DOWN_SOUND = "rbxassetid://100671636189844"},
    BACKPACK = {LIMIT = 250, HARD_LIMIT = 250, MAX_POWDERS = 120},
    OFFLINE_ASSETS = {MAX_DURATION_SECONDS = 36000, MONEY_RATE_MULTIPLIER = 0.1, MIN_CLAIM_MONEY = 5},
    BASE_FRAME_RATE = 60,
    STUDIO_YIELD_TIMEOUT = if not v2 then 9999999 else 60,
    STUDIO_RESET_PLAYER_DATA_ON_UNLOAD = false,
    GROUP_ID = 825735094,
    MAIN_DEV_ID = 4035869470,
    OWNER_ID = 1065906907,
    TEST_PLACE_ID = 98345564489939,
    JOIN_BADGE = 2590480615884365,
    MIN_PLACE_GRID_SIZE = 3,
    CLIENT_OVERLAP_MARGIN = 0.95,
    SERVER_REDUCTION_FACTOR = 0.75,
    SERVER_MIN_GRID_SIZE = 2.25,
    MAX_PET_EXTRA_SLOTS = 5,
    MAX_INVENTORY_SLOTS_PURCHASE = 5,
    INVENTORY_SLOT_PURCHASE_INCREMENT = 5,
    BRAINROT_MAX_HATCH_PER_REQUEST = 24,
    ASSET_BALANCING_PROGRESS_INCREMENT_PERCENT = 13,
    ASSET_BALANCING_GIGA_MULTIPLIER = 1,
    BLOODLIT_EVENT_WEIGHT_REQ = 5,
    BLOODLIT_BACKPACK_BONUS = 50,
    BASE_ASSETS_WALK_SPEED = 13,
    BASE_WALK_SPEED = 16,
    BASE_JUMP_HEIGHT = 7,
    BASE_CARRY_POWER = 1,
    DEFAULT_BASE_LOCK_DURATION = 120,
    LUCKY_BLOCK_TOOL_NAME = "LuckyBlockTool",
    ROBUX_ICON_STR = "",
    UPDATE_LIVE_AT = if not RunService:IsStudio() then if game.PlaceId ~= 121856883734174 then 1790434800 else 1790344800 else os.time() - 500,
}, {BACKPACK = true, OFFLINE_ASSETS = true, BASE_WALK_SPEED = true, BASE_JUMP_HEIGHT = true}, false, function(a1) -- Line: 121
    local v1 = false
    if 0 < a1.BASE_WALK_SPEED then
        v1 = a1.BASE_WALK_SPEED < 300
    end
    assert(v1)
    v1 = nil
    local v2 = nil
    for i, j in a1.BACKPACK, v1, v2 do
        assert(j % 1 == 0)
    end
end)