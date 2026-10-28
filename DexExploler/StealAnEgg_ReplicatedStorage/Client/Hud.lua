-- Script path: ReplicatedStorage.Client.Hud
-- Decompile time: 5.82 ms

local walk
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local u9 = {Game = "GameHUD", Treadmill = "TradmilHud"}
local u10 = {
    EggsButton = {"RightButtons", "EggsButton"},
    HalloweenMasteryButton = {"RightButtons", "HalloweenMasteryButton"},
    ExperimentTimer = {"BottomRight", "ExperimentTimer"},
    ExperimentTimerValue = {"BottomRight", "ExperimentTimer", "Value"},
    IndexButton = {"LeftControls", "IndexBTN"},
    IndexNotificationBadge = {"LeftControls", "IndexBTN", "NotificationBadge"},
    Money = {"BottomLeft", "Money"},
    MoneyIcon = {"BottomLeft", "Money", "Icon"},
    MoneyValue = {"BottomLeft", "Money", "Value"},
    NightTimer = {"BottomRight", "NightTimer"},
    NightTimerIcon = {"BottomRight", "NightTimer", "ImageLabel"},
    NightTimerValue = {"BottomRight", "NightTimer", "Value"},
    PetsButton = {"RightButtons", "PetsButton"},
    QuestlineBadge = {"RightButtons", "QuestlineButton", "Badge"},
    QuestlineButton = {"RightButtons", "QuestlineButton"},
    RaceRallyButton = {"RightButtons", "RaceRallyButton"},
    RaceTimer = {"BottomRight", "RaceTimer"},
    RaceTimerValue = {"BottomRight", "RaceTimer", "Value"},
    RiftButton = {"RightButtons", "RiftButton"},
    ShopButton = {"LeftControls", "ShopBTN"},
    SlowToggle = {"LeftControls", "Slowmode"},
    SlowToggleHitbox = {"LeftControls", "Slowmode", "Hitbox"},
    SlowToggleKnob = {"LeftControls", "Slowmode", "Btn"},
    SlowToggleLabel = {"LeftControls", "Slowmode", "txt"},
    Speed = {"BottomLeft", "Speed"},
    SpeedMultiButton = {"LeftControls", "SpeedMulti"},
    SpeedMultiShine = {"LeftControls", "SpeedMulti", "Glow"},
    SpeedShopButton = {"BottomLeft", "Speed", "ShopBTN"},
    SpeedValue = {"BottomLeft", "Speed", "Value"},
    TheHollowButton = {"RightButtons", "TheHollowButton"},
    WorldEventNotification = {"WorldEventNotification"},
    FriendBoost = {"BottomLeft", "FriendBoost"},
    TemporarySpeedBoost = {"BottomLeft", "TemporarySpeedBoost"},
}
local u124 = GUI.HUD()
u124.ResetOnSpawn = false
local u126 = {}
local u127 = {}
local u128 = {}

function walk(a1, a2, a3) -- Line: 78 -- upvalues: walk (val) -- types: a1: userdata, a2: table, a3: number
    local v1
    local v2 = a2[a3]
    if v2 == nil then
        return a1
    end
    for i, j in a1:GetChildren() do
        if j.Name == v2 then
            v1 = walk(j, a2, a3 + 1)
            if v1 ~= nil then
                return v1
            end
        end
    end
    return nil
end

local function variantFrame(a1) -- Line: 96 -- upvalues: u126 (val), u9 (val), u124 (val) -- types: a1: string
    local v1 = u126[a1]
    if v1 then
        return v1
    end
    v1 = u9[a1]
    local v2 = ("no HUD variant named %*"):format(a1)
    assert(v1 ~= nil, v2)
    local v3 = u124:FindFirstChild(v1)
    v2 = false
    if v3 ~= nil then
        v2 = v3:IsA("Frame")
    end
    assert(v2, (("HUD.%* must be a Frame"):format(v1)))
    u126[a1] = v3
    return v3
end

local function chainFor(a1) -- Line: 111 -- upvalues: u10 (val) -- types: a1: string
    local v1 = u10[a1]
    local v2 = ("no HUD role is registered under %*"):format(a1)
    assert(v1 ~= nil, v2)
    return v1
end

function u128.Screen() -- Line: 121 -- upvalues: u124 (val)
    return u124
end

function u128.Frame(a1) -- Line: 125 -- upvalues: u126 (val), u9 (val), u124 (val) -- types: a1: string?
    local v1 = a1 or "Game"
    local v2 = u126[v1]
    if v2 then
        return v2
    end
    v2 = u9[v1]
    local v3 = ("no HUD variant named %*"):format(v1)
    assert(v2 ~= nil, v3)
    local v4 = u124:FindFirstChild(v2)
    v3 = false
    if v4 ~= nil then
        v3 = v4:IsA("Frame")
    end
    assert(v3, (("HUD.%* must be a Frame"):format(v2)))
    u126[v1] = v4
    return v4
end

function u128.Find(a1, a2) -- Line: 131
    -- upvalues: u127 (val), walk (val), u126 (val), u9 (val), u124 (val), u10 (val)
    local v1 = a2 or "Game"
    local v2 = u127[v1]
    if v2 == nil then
        u127[v1] = {}
    end
    if v2[a1] == nil then
        local v3, v4
        local v5 = u126[v1]
        if not v5 then
            v5 = u9[v1]
            v4 = ("no HUD variant named %*"):format(v1)
            assert(v5 ~= nil, v4)
            local v6 = u124:FindFirstChild(v5)
            v4 = false
            if v6 ~= nil then
                v4 = v6:IsA("Frame")
            end
            assert(v4, (("HUD.%* must be a Frame"):format(v5)))
            u126[v1] = v6
            v3 = v6
        else
            v3 = v5
        end
        v5 = u10[a1]
        v4 = ("no HUD role is registered under %*"):format(a1)
        assert(v5 ~= nil, v4)
        v2[a1] = (walk(v3, v5, 1))
    end
    return v2[a1]
end

function u128.Get(a1, a2) -- Line: 146 -- upvalues: u128 (val), u9 (val), u10 (val) -- types: a1: string, a2: string?
    local v1 = u128.Find(a1, a2)
    local v2 = u9[a2 or "Game"]
    local concat = table.concat
    local v3 = u10[a1]
    local v4 = ("no HUD role is registered under %*"):format(a1)
    assert(v3 ~= nil, v4)
    local v5 = ("HUD.%*.%* is missing"):format(v2, (concat(v3, ".")))
    assert(v1 ~= nil, v5)
    return v1
end

function u128.Every(a1) -- Line: 154 -- upvalues: u9 (val), u128 (val) -- types: a1: string
    local v1
    local v2 = {}
    for i in u9 do
        v1 = u128.Find(a1, i)
        if v1 ~= nil then
            table.insert(v2, v1)
        end
    end
    return v2
end

function u128.SetTreadmillActive(a1) -- Line: 165 -- upvalues: u126 (val), u9 (val), u124 (val) -- types: a1: boolean
    local v1, v2, v3
    local Game = u126.Game
    if not Game then
        local Game_2 = u9.Game
        assert(Game_2 ~= nil, "no HUD variant named Game")
        v2 = u124:FindFirstChild(Game_2)
        v3 = false
        if v2 ~= nil then
            v3 = v2:IsA("Frame")
        end
        assert(v3, (("HUD.%* must be a Frame"):format(Game_2)))
        u126.Game = v2
        v1 = v2
    else
        v1 = Game
    end
    v1.Visible = not a1
    local Treadmill = u126.Treadmill
    if not Treadmill then
        local Treadmill_2 = u9.Treadmill
        assert(Treadmill_2 ~= nil, "no HUD variant named Treadmill")
        v2 = u124:FindFirstChild(Treadmill_2)
        v3 = false
        if v2 ~= nil then
            v3 = v2:IsA("Frame")
        end
        assert(v3, (("HUD.%* must be a Frame"):format(Treadmill_2)))
        u126.Treadmill = v2
        v1 = v2
    else
        v1 = Treadmill
    end
    v1.Visible = a1
end

return table.freeze(u128)