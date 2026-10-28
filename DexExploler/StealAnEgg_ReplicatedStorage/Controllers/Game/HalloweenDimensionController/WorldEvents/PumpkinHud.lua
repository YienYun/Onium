-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.WorldEvents.PumpkinHud
-- Decompile time: 7.47 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Attributes = HalloweenDimension.Attributes
local PlayerAttributes = HalloweenDimension.PlayerAttributes
local v1 = {}

local function child(a1, a2, a3) -- Line: 44 -- types: a1: userdata, a2: string, a3: string
    local v1 = a1:FindFirstChild(a2)
    local v2 = false
    if v1 ~= nil then
        v2 = v1:IsA(a3)
    end
    assert(v2, (("%* is missing %* %*"):format(a1:GetFullName(), a3, a2)))
    return v1
end

local function bindSlot(a1) -- Line: 50 -- types: a1: userdata
    local Avatar = a1:FindFirstChild("Avatar")
    local v1 = false
    if Avatar ~= nil then
        v1 = Avatar:IsA("ImageLabel")
    end
    assert(v1, (("%* is missing ImageLabel Avatar"):format((a1:GetFullName()))))
    local v2 = {Frame = a1, Avatar = Avatar}
    local YouStroke = Avatar:FindFirstChild("YouStroke")
    local v3 = false
    if YouStroke ~= nil then
        v3 = YouStroke:IsA("UIStroke")
    end
    assert(v3, (("%* is missing UIStroke YouStroke"):format((Avatar:GetFullName()))))
    v2.You = YouStroke
    local CounterHolder = a1:FindFirstChild("CounterHolder")
    local v4 = false
    if CounterHolder ~= nil then
        v4 = CounterHolder:IsA("GuiObject")
    end
    assert(v4, (("%* is missing GuiObject CounterHolder"):format((a1:GetFullName()))))
    v1 = CounterHolder:FindFirstChild("CounterLabel")
    v4 = false
    if v1 ~= nil then
        v4 = v1:IsA("TextLabel")
    end
    assert(v4, (("%* is missing TextLabel CounterLabel"):format((CounterHolder:GetFullName()))))
    v2.Counter = v1
    return v2
end

local function numberAttribute(a1, a2) -- Line: 61 -- types: a1: userdata, a2: string
    local Attribute = a1:GetAttribute(a2)
    if type(Attribute) == "number" then
        return Attribute
    end
    return nil
end

local function ranked() -- Line: 66 -- upvalues: Players (val), PlayerAttributes (val)
    local Attribute, Attribute_2, Inside, Pumpkins, PumpkinsAt, v1, v2
    local v3 = {}
    for i, j in Players:GetPlayers() do
        Pumpkins = PlayerAttributes.Pumpkins
        Attribute = j:GetAttribute(Pumpkins)
        v1 = (if type(Attribute) ~= "number" then nil else Attribute) or 0
        if v1 > 0 then
            v2 = {Player = j, Count = v1}
            PumpkinsAt = PlayerAttributes.PumpkinsAt
            Attribute_2 = j:GetAttribute(PumpkinsAt)
            v2.ReachedAt = (if type(Attribute_2) ~= "number" then nil else Attribute_2) or (1 / 0)
            table.insert(v3, v2)
        else
            Inside = PlayerAttributes.Inside
            if j:GetAttribute(Inside) == true then
                v2 = {Player = j, Count = v1}
                PumpkinsAt = PlayerAttributes.PumpkinsAt
                Attribute_2 = j:GetAttribute(PumpkinsAt)
                v2.ReachedAt = (if type(Attribute_2) ~= "number" then nil else Attribute_2) or (1 / 0)
                table.insert(v3, v2)
            end
        end
    end
    table.sort(v3, function(a1, a2) -- Line: 78 -- types: a1: table, a2: table
        if a1.Count ~= a2.Count then
            return a2.Count < a1.Count
        end
        if a1.ReachedAt ~= a2.ReachedAt then
            return a1.ReachedAt < a2.ReachedAt
        end
        return a1.Player.UserId < a2.Player.UserId
    end)
    return v3
end

local function clock(a1) -- Line: 90 -- types: a1: number
    local v1 = math.max(0, (math.ceil(a1)))
    return string.format("%02d:%02d", v1 // 60, v1 % 60)
end

local function show(a1, a2) -- Line: 95
    -- upvalues: LocalPlayer (val), bindSlot (val), Workspace (val), Attributes (val), ranked (val), RunService (val)
    local v1, v2, v3, v4
    local HUD = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("HUD")
    assert(HUD:IsA("ScreenGui"), "HUD must be a ScreenGui")
    a1.ScreenInsets = HUD.ScreenInsets
    a1.ClipToDeviceSafeArea = HUD.ClipToDeviceSafeArea
    local Timer = a1:FindFirstChild("Timer")
    local v5 = false
    if Timer ~= nil then
        v5 = Timer:IsA("GuiObject")
    end
    assert(v5, (("%* is missing GuiObject Timer"):format((a1:GetFullName()))))
    local u141 = Timer:FindFirstChild("TimerLabel")
    v5 = false
    if u141 ~= nil then
        v5 = u141:IsA("TextLabel")
    end
    assert(v5, (("%* is missing TextLabel TimerLabel"):format((Timer:GetFullName()))))
    local ProfileShowcase = a1:FindFirstChild("ProfileShowcase")
    v5 = false
    if ProfileShowcase ~= nil then
        v5 = ProfileShowcase:IsA("GuiObject")
    end
    assert(v5, (("%* is missing GuiObject ProfileShowcase"):format((a1:GetFullName()))))
    local u83 = {}
    for i = 1, 4 do
        v3 = ("Slot%*"):format(i)
        v2 = ProfileShowcase:FindFirstChild(v3)
        v4 = false
        if v2 ~= nil then
            v4 = v2:IsA("GuiObject")
        end
        assert(v4, (("%* is missing GuiObject %*"):format(ProfileShowcase:GetFullName(), v3)))
        table.insert(u83, (bindSlot(v2)))
    end

    local function refresh() -- Line: 109
        -- upvalues: Workspace (upval), Attributes (upval), u141 (val), ranked (upval), u83 (val), LocalPlayer (upval)
        local UserId, v1
        local Attribute = Workspace:GetAttribute(Attributes.WorldEventEndsAt)
        local v2 = math.max(0, (math.ceil(if type(Attribute) ~= "number" then 0 else Attribute - Workspace:GetServerTimeNow())))
        u141.Text = string.format("%02d:%02d", v2 // 60, v2 % 60)
        local v3 = ranked()
        local v4 = nil
        local v5 = nil
        for i, j in u83, v4, v5 do
            v1 = v3[i]
            j.Frame.Visible = v1 ~= nil
            if v1 ~= nil then
                UserId = v1.Player.UserId
                if j.UserId ~= UserId then
                    j.UserId = UserId
                    j.Avatar.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=420&h=420", UserId)
                end
                j.Counter.Text = tostring(v1.Count)
                j.You.Enabled = v1.Player == LocalPlayer
            else
                j.You.Enabled = false
            end
        end
    end

    local u143 = 0
    v1:Connect(RunService.Heartbeat, function(a1) -- Line: 132 -- upvalues: u143 (ref), refresh (val) -- types: a1: number
        u143 = u143 + a1
        if u143 >= 0.2 then
            u143 = 0
            refresh()
        end
    end)
    v1:Add(function() -- Line: 139 -- upvalues: a1 (val), u83 (val)
        a1.Enabled = false
        for i, j in u83 do
            j.You.Enabled = false
        end
    end)
    refresh()
    a1.Enabled = true
end

function v1.Bind(a1) -- Line: 153 -- upvalues: LocalPlayer (val), show (val)
    a1:Add((task.spawn(function() -- Line: 154 -- upvalues: LocalPlayer (upval), show (upval), a1 (val)
        local ReturnPumpkinsHUDTimer = (LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("ReturnPumpkinsHUDTimer")
        assert(ReturnPumpkinsHUDTimer:IsA("ScreenGui"), (("%* must be a ScreenGui"):format((ReturnPumpkinsHUDTimer:GetFullName()))))
        show(ReturnPumpkinsHUDTimer, a1)
    end)))
end

return v1