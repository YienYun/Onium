-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.WorldEvents
-- Decompile time: 9.96 ms

local v1, v2
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local Hud = require(ReplicatedStorage.Client.Hud)
local LightingController = require(ReplicatedStorage.Controllers.Game.LightingController)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Types)
local LocalPlayer = Players.LocalPlayer
local v3 = (ReplicatedStorage:WaitForChild("Assets")):WaitForChild("HalloweenDimension")
local u187 = v3:WaitForChild("Sounds")
local WorldEventVFX = v3:WaitForChild("WorldEventVFX")
local Attributes = HalloweenDimension.Attributes
local PlayerAttributes = HalloweenDimension.PlayerAttributes
local u67 = {"Game", "Treadmill"}
local u70 = {}
local v4 = {}

local function dimensionMap() -- Line: 46 -- upvalues: Workspace (val), HalloweenDimension (val)
    local v1 = Workspace:FindFirstChild(HalloweenDimension.MapName)
    if v1 ~= nil and v1:IsA("Model") then
        return v1
    end
    return nil
end

local function child(a1, a2, a3) -- Line: 51 -- types: a1: userdata, a2: string, a3: string
    local v1 = a1:FindFirstChild(a2)
    local v2 = false
    if v1 ~= nil then
        v2 = v1:IsA(a3)
    end
    assert(v2, (("%* is missing %* %*"):format(a1:GetFullName(), a3, a2)))
    return v1
end

local function notify(a1, a2) -- Line: 58
    -- upvalues: Workspace (val), Attributes (val), u67 (val), Hud (val), RunService (val)
    local Icon, TimerHolder, txt, v1, v2
    local Attribute = Workspace:GetAttribute(Attributes.WorldEventText)
    local u137 = {}
    local v3 = nil
    local v4 = nil
    local v5 = a2
    for i, j in u67, v3, v4 do
        local u35 = Hud.Get("WorldEventNotification", j)
        Icon = u35:FindFirstChild("Icon")
        v1 = false
        if Icon ~= nil then
            v1 = Icon:IsA("ImageLabel")
        end
        assert(v1, (("%* is missing ImageLabel Icon"):format((u35:GetFullName()))))
        Icon.Image = v6
        txt = u35:FindFirstChild("txt")
        v1 = false
        if txt ~= nil then
            v1 = txt:IsA("TextLabel")
        end
        assert(v1, (("%* is missing TextLabel txt"):format((u35:GetFullName()))))
        txt.Text = if type(Attribute) ~= "string" then "" else Attribute
        TimerHolder = u35:FindFirstChild("TimerHolder")
        v2 = false
        if TimerHolder ~= nil then
            v2 = TimerHolder:IsA("GuiObject")
        end
        assert(v2, (("%* is missing GuiObject TimerHolder"):format((u35:GetFullName()))))
        v1 = TimerHolder:FindFirstChild("TimerLabel")
        v2 = false
        if v1 ~= nil then
            v2 = v1:IsA("TextLabel")
        end
        assert(v2, (("%* is missing TextLabel TimerLabel"):format((TimerHolder:GetFullName()))))
        table.insert(u137, v1)
        u35.Visible = true
        v5:Add(function() -- Line: 67 -- upvalues: u35 (val)
            u35.Visible = false
        end)
    end

    local function refresh() -- Line: 72 -- upvalues: Workspace (upval), Attributes (upval), u137 (val)
        local Attribute = Workspace:GetAttribute(Attributes.WorldEventEndsAt)
        local v1 = math.max(0, (math.ceil(if type(Attribute) ~= "number" then 0 else Attribute - Workspace:GetServerTimeNow())))
        for i, j in u137 do
            j.Text = string.format("Ends In %d:%02d", v1 // 60, v1 % 60)
        end
    end

    local u21 = 0
    v5:Connect(RunService.Heartbeat, function(a1) -- Line: 84 -- upvalues: u21 (ref), refresh (val) -- types: a1: number
        u21 = u21 + a1
        if u21 >= 0.2 then
            u21 = 0
            refresh()
        end
    end)
    refresh()
end

local function begin(a1, a2) -- Line: 94
    -- upvalues: Trove (val), LightingController (val), WorldEventVFX (val), notify (val)
    local v1 = Trove.new()
    LightingController.SetLayer("HalloweenWorldEvent", a1.Preset, 160, 2)
    v1:Add(function() -- Line: 97 -- upvalues: LightingController (upval)
        LightingController.ClearLayer("HalloweenWorldEvent", 2)
    end)
    local Sky = a2:FindFirstChild("Sky")
    local v2 = false
    if Sky ~= nil then
        v2 = Sky:IsA("Folder")
    end
    assert(v2, (("%* is missing Folder Sky"):format((a2:GetFullName()))))
    local u41 = Sky:FindFirstChild("Moon")
    v2 = false
    if u41 ~= nil then
        v2 = u41:IsA("BasePart")
    end
    assert(v2, (("%* is missing BasePart Moon"):format((Sky:GetFullName()))))
    local Color = u41.Color
    u41.Color = a1.MoonColor
    v1:Add(function() -- Line: 104 -- upvalues: u41 (val), Color (val)
        if u41.Parent ~= nil then
            u41.Color = Color
        end
    end)
    local v3 = WorldEventVFX[a1.Id]
    v1:Clone(v3).Parent = a2
    local Icon = a1.Icon
    if Icon ~= nil then
        notify(Icon, v1)
    end
    if a1.Bind ~= nil then
        a1.Bind(a2, v1)
    end
    return v1
end

local function eventKey() -- Line: 124 -- upvalues: Workspace (val), Attributes (val), u70 (val)
    local Attribute = Workspace:GetAttribute(Attributes.WorldEvent)
    local v1 = if type(Attribute) ~= "string" then nil else u70[Attribute]
    if v1 ~= nil then
        return (("%*:%*"):format(v1.Id, (Workspace:GetAttribute(Attributes.WorldEventEndsAt))))
    end
    return nil
end

local function playStinger(a1) -- Line: 132 -- upvalues: u187 (val), Audio (val)
    local v1 = u187:FindFirstChild(a1.Id .. "Start")
    if v1 ~= nil and v1:IsA("Sound") then
        Audio.Play(v1, script)
    end
end

function v4.Start(a1) -- Line: 143
    -- upvalues: Workspace (val), Attributes (val), u70 (val), LocalPlayer (val), PlayerAttributes (val)
    -- upvalues: HalloweenDimension (val), begin (val), u187 (val), Audio (val)
    local u1 = nil
    local u2 = nil
    local Attribute = Workspace:GetAttribute(Attributes.WorldEvent)
    local v1 = if type(Attribute) ~= "string" then nil else u70[Attribute]
    local u28 = if v1 == nil then nil else ("%*:%*"):format(v1.Id, (Workspace:GetAttribute(Attributes.WorldEventEndsAt)))

    local function sync() -- Line: 157
        -- upvalues: LocalPlayer (upval), PlayerAttributes (upval), Workspace (upval), Attributes (upval), u70 (upval)
        -- upvalues: HalloweenDimension (upval), u28 (ref), u2 (ref), u1 (ref), begin (upval), u187 (upval)
        -- upvalues: Audio (upval)
        local v1 = LocalPlayer:GetAttribute(PlayerAttributes.Inside) == true
        local Attribute = Workspace:GetAttribute(Attributes.WorldEvent)
        local v2 = if type(Attribute) ~= "string" then nil else u70[Attribute]
        local v3 = Workspace:FindFirstChild(HalloweenDimension.MapName)
        local v4 = if v3 == nil then nil else if not v3:IsA("Model") then nil else v3
        local Attribute_2 = Workspace:GetAttribute(Attributes.WorldEvent)
        local v5 = if type(Attribute_2) ~= "string" then nil else u70[Attribute_2]
        v3 = if v5 == nil then nil else ("%*:%*"):format(v5.Id, (Workspace:GetAttribute(Attributes.WorldEventEndsAt)))
        local v6 = false
        if v3 ~= nil then
            v6 = v3 ~= u28
        end
        u28 = v3
        if (if not v1 then nil else if v2 == nil then nil else if v4 == nil then nil else v3) == u2 then
            return
        end
        u2 = nil
        v3 = u1
        u1 = nil
        if v3 ~= nil then
            v3:Destroy()
        end
        if v5 ~= nil and v2 ~= nil and v4 ~= nil then
            u2 = v5
            begin(v2, v4)
            if v6 then
                v1 = u187:FindFirstChild(v2.Id .. "Start")
                if v1 ~= nil and v1:IsA("Sound") then
                    Audio.Play(v1, script)
                end
            end
        end
    end

    a1:Connect(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.Inside), sync)
    a1:Connect(Workspace:GetAttributeChangedSignal(Attributes.WorldEvent), sync)
    a1:Connect(Workspace:GetAttributeChangedSignal(Attributes.WorldEventEndsAt), sync)
    a1:Add(function() -- Line: 148 -- upvalues: u2 (ref), u1 (ref)
        u2 = nil
        local v1 = u1
        u1 = nil
        if v1 ~= nil then
            v1:Destroy()
        end
    end)
    sync()
end

for i, j in script.Events:GetChildren() do
    assert(j:IsA("ModuleScript"), (("%* must be a ModuleScript"):format((j:GetFullName()))))
    v1 = require(j)
    assert(v1.Id == j.Name, (("%* declares Id %*"):format(j:GetFullName(), v1.Id)))
    assert(LightingController.Presets[v1.Preset] ~= nil, (("Lighting preset %* is missing"):format(v1.Preset)))
    v2 = ("HalloweenDimension sound %* is missing"):format(v1.Id)
    assert(u187:FindFirstChild(v1.Id) ~= nil, v2)
    v2 = ("HalloweenDimension world event VFX %* is missing"):format(v1.Id)
    assert(WorldEventVFX:FindFirstChild(v1.Id) ~= nil, v2)
    u70[v1.Id] = v1
end
return v4