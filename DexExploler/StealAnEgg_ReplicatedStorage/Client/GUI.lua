-- Script path: ReplicatedStorage.Client.GUI
-- Decompile time: 12.56 ms

local conform
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ConsoleSignals = require(ReplicatedStorage.Client.ConsoleSignals)
require(ReplicatedStorage.Client.Types.GUI)
require(ReplicatedStorage.Packages.Signal)
local u32 = if not RunService:IsStudio() then nil else 20
local u33 = {
    ActivePets = true,
    ApplyStarPopupConfirmationScreen = true,
    AreaGui = true,
    AssetEggData = true,
    AssetHoverData = true,
    AutoSell = true,
    Backpack = "BackpackGui",
    BeanstalkEventUI = true,
    BossMastery = true,
    BossShop = true,
    ButterflyMachine = true,
    SoulsTradeInMachine = true,
    EnchantedMutationShrine = true,
    WispCompanion = "GrowWispProgressUI",
    CaptureTheEggUI = true,
    DrScrambleEvent = "DrScrambleEventUI",
    DropHeldEgg = true,
    Fade = true,
    GetMoreSpeedOnHit = true,
    GreatBloomBanner = true,
    GroupReward = "FreeGift",
    GrowingEggs = true,
    HalloweenBossMastery = true,
    HalloweenDimensionEggUI = true,
    HalloweenEventTutorialFrame = true,
    HUD = true,
    Index = true,
    LightVsDarknessUI = true,
    Message = true,
    MonsterCharge = "MonsterChargeUI",
    MonsterChestRewards = true,
    MonsterEventTutorialFrame = true,
    MountRaceBoardUI = true,
    MountRaceUI = true,
    Notifications = true,
    OfflineMoneyInPlot = true,
    PetFuse = true,
    PopupPrompt = true,
    RaceRally = "RaceRallyUI",
    RescueDragonFTUEQuest = true,
    ResetStartTimer = true,
    RiftTradeIn = true,
    DrScrambleTradeIn = true,
    DogsMemoriesFrame = true,
    RollbackReward = "RollbackRewardUI",
    SakuraCrystalCounter = true,
    SakuraEggCharge = true,
    SakuraEventTutorialFrame = true,
    SammyEventUI = true,
    ScrambleBossMastery = true,
    SellPrompt = true,
    Settings = true,
    Shop = "RobuxShop",
    SpeedGainAnimation = true,
    StarBundles = true,
    StaticTreadmillImageSurfaceGui = true,
    StolenVaultEvent = "StolenVaultEventUI",
    TheHollow = "TheHollowEventUI",
    TopBarStandard = "TopbarStandard",
    TrailShop = true,
    TreadmillScreenButtonShare = true,
    TreadmillScreenButtonSwapLeft = true,
    TreadmillScreenButtonSwapRight = true,
    TreadmillScreenComments = true,
    TreadmillScreenFriendLikes = true,
    TreadmillScreenSideButtons = true,
    TreadmillVideoSurfaceGui = true,
    TutorialInstructions = true,
}
local u102 = {AssetHoverData = "ScreenGui", GetMoreSpeedOnHit = "ScreenGui", MonsterCharge = "ScreenGui"}

local function shape(a1, a2) -- Line: 102 -- types: a1: string, a2: table?
    return {class = a1, children = a2}
end

local v1 = {class = "Frame", children = {Icon = {class = "ImageButton"}, Timer = {class = "TextLabel"}}}
local u124 = {
    class = "ScreenGui",
    children = {
        BottomFrame = {
            class = "Frame",
            children = {
                Holder = {
                    class = "Frame",
                    children = {
                        List = {
                            class = "Frame",
                            children = {
                                Luck = {
                                    class = "Frame",
                                    children = {
                                        Button = {
                                            class = "ImageButton",
                                            children = {
                                                Content = {class = "Frame", children = {Value = {class = "Frame", children = {TextLabel = {class = "TextLabel"}}}}},
                                            },
                                        },
                                    },
                                },
                                x2Growth = v1,
                                x2Luck = v1,
                            },
                        },
                    },
                },
            },
        },
    },
}

local function awaitChild(a1, a2) -- Line: 128 -- upvalues: u32 (val) -- types: a1: userdata, a2: string
    local v1 = if u32 == nil then a1:WaitForChild(a2) else a1:WaitForChild(a2, u32)
    return v1 or error(("%* has no child named %*"):format(a1:GetFullName(), a2), 2)
end

local LocalPlayer = Players.LocalPlayer
local u151 = if u32 == nil then LocalPlayer:WaitForChild("PlayerGui") else LocalPlayer:WaitForChild("PlayerGui", u32)
if not u151 then
    u151 = error(("%* has no child named PlayerGui"):format((LocalPlayer:GetFullName())), 2)
end

local function descend(a1, a2) -- Line: 137 -- upvalues: u32 (val) -- types: a1: userdata, a2: table
    local v1, v2
    local v3 = a1
    local v4 = nil
    local v5 = nil
    for i, j in a2, v4, v5 do
        v1 = v3
        v2 = if u32 == nil then v1:WaitForChild(j) else v1:WaitForChild(j, u32)
        v3 = v2 or error(("%* has no child named %*"):format(v1:GetFullName(), j), 2)
    end
    return v3
end

function conform(a1, a2, a3) -- Line: 145
    -- upvalues: conform (val), u32 (val)
    assert(a1:IsA(a2.class), (("%* is a %*, not the expected %*"):format(a3, a1.ClassName, a2.class)))
    local children = a2.children or {}
    local v1 = nil
    local v2 = nil
    local v3 = a1
    for i, j in children, v1, v2 do
        conform(
            (if u32 == nil then v3:WaitForChild(i) else v3:WaitForChild(i, u32)) or error(("%* has no child named %*"):format(v3:GetFullName(), i), 2),
            j,
            (("%*.%*"):format(v4, i))
        )
    end
end

local function screenNamed(a1) -- Line: 152
    -- upvalues: u33 (val), u151 (val), u32 (val), u102 (val)
    local v1 = u33[a1]
    local v2 = if v1 ~= true then v1 else a1
    local v3 = u151
    local v4 = if u32 == nil then v3:WaitForChild(v2) else v3:WaitForChild(v2, u32)
    v1 = v4 or error(("%* has no child named %*"):format(v3:GetFullName(), v2), 2)
    v3 = u102[a1]
    if v3 ~= nil then
        assert(v1:IsA(v3), (("%* is a %*, not the %* that GUI.%* promises"):format(v2, v1.ClassName, v3, a1)))
    end
    return v1
end

local function adoptScale(a1) -- Line: 166 -- types: a1: userdata
    local UIScale = a1:FindFirstChildOfClass("UIScale")
    if UIScale ~= nil then
        return UIScale
    end
    local UIScale_2 = Instance.new("UIScale")
    UIScale_2.Scale = 0
    UIScale_2.Parent = a1
    return UIScale_2
end

local u164 = {}

function u164.BottomUI() -- Line: 183 -- upvalues: u151 (val), u32 (val), conform (val), u124 (val)
    local v1 = u151
    local BottomUI = if u32 == nil then v1:WaitForChild("BottomUI") else v1:WaitForChild("BottomUI", u32)
    local v2 = BottomUI or error(("%* has no child named BottomUI"):format((v1:GetFullName())), 2)
    conform(v2, u124, "BottomUI")
    return v2
end

function u164.FadeFrame() -- Line: 188 -- upvalues: u33 (val), u151 (val), u32 (val), u102 (val)
    local v1, v2
    local Fade = u33.Fade
    local v3 = if Fade ~= true then Fade else "Fade"
    local v4 = u151
    local v5 = (if u32 == nil then v4:WaitForChild(v3) else v4:WaitForChild(v3, u32)) or error(("%* has no child named %*"):format(v4:GetFullName(), v3), 2)
    local Fade_2 = u102.Fade
    if Fade_2 ~= nil then
        assert(v5:IsA(Fade_2), (("%* is a %*, not the %* that GUI.Fade promises"):format(v3, v5.ClassName, Fade_2)))
    end
    local v6 = v5
    v3 = {"Fade"}
    v4 = nil
    local v7 = nil
    for i, j in v3, v4, v7 do
        v1 = v6
        v2 = if u32 == nil then v1:WaitForChild(j) else v1:WaitForChild(j, u32)
        v6 = v2 or error(("%* has no child named %*"):format(v1:GetFullName(), j), 2)
    end
    return v6
end

function u164.PlayerGui() -- Line: 191 -- upvalues: u151 (val)
    return u151
end

function u164.ResetStartTimerLabel() -- Line: 177 -- upvalues: u33 (val), u151 (val), u32 (val), u102 (val)
    local v1, v2
    local ResetStartTimer = u33.ResetStartTimer
    local v3 = if ResetStartTimer ~= true then ResetStartTimer else "ResetStartTimer"
    local v4 = u151
    local v5 = (if u32 == nil then v4:WaitForChild(v3) else v4:WaitForChild(v3, u32)) or error(("%* has no child named %*"):format(v4:GetFullName(), v3), 2)
    local ResetStartTimer_2 = u102.ResetStartTimer
    if ResetStartTimer_2 ~= nil then
        assert(
            v5:IsA(ResetStartTimer_2),
            (("%* is a %*, not the %* that GUI.ResetStartTimer promises"):format(v3, v5.ClassName, ResetStartTimer_2))
        )
    end
    local v6 = v5
    v3 = {"Frame", "TextLabel"}
    v4 = nil
    local v7 = nil
    for i, j in v3, v4, v7 do
        v1 = v6
        v2 = if u32 == nil then v1:WaitForChild(j) else v1:WaitForChild(j, u32)
        v6 = v2 or error(("%* has no child named %*"):format(v1:GetFullName(), j), 2)
    end
    return v6
end

function u164.ResetStartTimerLabelScale() -- Line: 195 -- upvalues: u33 (val), u151 (val), u32 (val), u102 (val)
    local v1, v2
    local ResetStartTimer = u33.ResetStartTimer
    local v3 = if ResetStartTimer ~= true then ResetStartTimer else "ResetStartTimer"
    local v4 = u151
    local v5 = (if u32 == nil then v4:WaitForChild(v3) else v4:WaitForChild(v3, u32)) or error(("%* has no child named %*"):format(v4:GetFullName(), v3), 2)
    local ResetStartTimer_2 = u102.ResetStartTimer
    if ResetStartTimer_2 ~= nil then
        assert(
            v5:IsA(ResetStartTimer_2),
            (("%* is a %*, not the %* that GUI.ResetStartTimer promises"):format(v3, v5.ClassName, ResetStartTimer_2))
        )
    end
    local v6 = v5
    v3 = {"Frame", "TextLabel"}
    v4 = nil
    local v7 = nil
    for i, j in v3, v4, v7 do
        v2 = v6
        v1 = if u32 == nil then v2:WaitForChild(j) else v2:WaitForChild(j, u32)
        v6 = v1 or error(("%* has no child named %*"):format(v2:GetFullName(), j), 2)
    end
    local UIScale = v6:FindFirstChildOfClass("UIScale")
    if UIScale ~= nil then
        return UIScale
    end
    local UIScale_2 = Instance.new("UIScale")
    UIScale_2.Scale = 0
    UIScale_2.Parent = v6
    return UIScale_2
end

local u171 = {}

local function accessorNamed(a1) -- Line: 202
    -- upvalues: u171 (val), u164 (val), u33 (val), u151 (val), u32 (val), u102 (val)
    local v1 = u171[a1]
    if v1 ~= nil then
        return v1
    end
    v1 = u164[a1]
    if v1 == nil and u33[a1] ~= nil then
        function v1() -- Line: 210 -- upvalues: a1 (val), u33 (upval), u151 (upval), u32 (upval), u102 (upval)
            local v1 = a1
            local v2 = u33[v1]
            local v3 = if v2 ~= true then v2 else v1
            local v4 = u151
            local v5 = (if u32 == nil then v4:WaitForChild(v3) else v4:WaitForChild(v3, u32)) or error(("%* has no child named %*"):format(v4:GetFullName(), v3), 2)
            v4 = u102[v1]
            if v4 ~= nil then
                assert(v5:IsA(v4), (("%* is a %*, not the %* that GUI.%* promises"):format(v3, v5.ClassName, v4, v1)))
            end
            return v5
        end
    end
    u171[a1] = v1
    return v1
end

local u173 = {}
u173.__index = u173
local u174 = {}
local u175 = {}

function u173:Disconnect() -- Line: 236 -- upvalues: u174 (val)
    for i, j in self.links do
        j:Disconnect()
    end
    table.clear(self.links)
    if u174[self.button] == self then
        u174[self.button] = nil
    end
end

return (setmetatable({
    OnActivated = function(a1, a2) -- Line: 250
        -- upvalues: u174 (val), u173 (val), ConsoleSignals (val)
        local v1 = u174[a1]
        if v1 ~= nil then
            v1:Disconnect()
        end
        local v2 = {button = a1, links = {}}
        local u12 = setmetatable(v2, u173)
        table.insert(u12.links, (a1.Activated:Connect(a2)))
        table.insert(u12.links, (ConsoleSignals.ButtonUp:Connect(function(a1_2) -- Line: 263 -- upvalues: a1 (val), a2 (val) -- types: a1_2: userdata
            if a1_2 == a1 then
                a2()
            end
        end)))
        u174[a1] = u12
        a1.Destroying:Once(function() -- Line: 270 -- upvalues: u174 (upval), a1 (val), u12 (val)
            if u174[a1] == u12 then
                u12:Disconnect()
            end
        end)
        return u12
    end,
    Get = function(a1) -- Line: 278
        -- upvalues: u175 (val), u171 (val), u164 (val), u33 (val), u151 (val), u32 (val), u102 (val)
        local v1 = u175[a1]
        if v1 ~= nil and v1.Parent ~= nil then
            return v1
        end
        local v2 = u171[a1]
        if v2 == nil then
            v2 = u164[a1]
            if v2 == nil and u33[a1] ~= nil then
                function v2() -- Line: 210 -- upvalues: a1 (val), u33 (upval), u151 (upval), u32 (upval), u102 (upval)
                    local v1 = a1
                    local v2 = u33[v1]
                    local v3 = if v2 ~= true then v2 else v1
                    local v4 = u151
                    local v5 = (if u32 == nil then v4:WaitForChild(v3) else v4:WaitForChild(v3, u32)) or error(("%* has no child named %*"):format(v4:GetFullName(), v3), 2)
                    v4 = u102[v1]
                    if v4 ~= nil then
                        assert(v5:IsA(v4), (("%* is a %*, not the %* that GUI.%* promises"):format(v3, v5.ClassName, v4, v1)))
                    end
                    return v5
                end
            end
            u171[a1] = v2
        end
        if v2 == nil then
            error(("GUI.Get: nothing is registered under %*"):format(a1), 2)
        end
        v2 = v1()
        u175[a1] = v2
        return v2
    end,
}, {
    __index = function(a1, a2) -- Line: 295
        -- upvalues: u171 (val), u164 (val), u33 (val), u151 (val), u32 (val), u102 (val)
        local v1 = u171[a2]
        if v1 == nil then
            v1 = u164[a2]
            if v1 == nil and u33[a2] ~= nil then
                function v1() -- Line: 210 -- upvalues: a2 (val), u33 (upval), u151 (upval), u32 (upval), u102 (upval)
                    local v1 = a2
                    local v2 = u33[v1]
                    local v3 = if v2 ~= true then v2 else v1
                    local v4 = u151
                    local v5 = (if u32 == nil then v4:WaitForChild(v3) else v4:WaitForChild(v3, u32)) or error(("%* has no child named %*"):format(v4:GetFullName(), v3), 2)
                    v4 = u102[v1]
                    if v4 ~= nil then
                        assert(v5:IsA(v4), (("%* is a %*, not the %* that GUI.%* promises"):format(v3, v5.ClassName, v4, v1)))
                    end
                    return v5
                end
            end
            u171[a2] = v1
        end
        return v1 or error(("GUI has no accessor named %*"):format(a2), 2)
    end,
}))