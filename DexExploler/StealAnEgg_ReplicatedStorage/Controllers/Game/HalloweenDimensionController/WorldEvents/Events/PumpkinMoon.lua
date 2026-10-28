-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.WorldEvents.Events.PumpkinMoon
-- Decompile time: 8.05 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local PumpkinDeposit = require(script.Parent.Parent.PumpkinDeposit)
local PumpkinHud = require(script.Parent.Parent.PumpkinHud)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
require(ReplicatedStorage.Packages.Trove)
local TutorialBeam = require(ReplicatedStorage.Client.WorldFX.TutorialBeam)
require(script.Parent.Parent.Types)
local LocalPlayer = Players.LocalPlayer
local u68 = ((ReplicatedStorage:WaitForChild("Assets")):WaitForChild("HalloweenDimension")):WaitForChild("Sounds"):WaitForChild("PumpkinPickup")
local Attributes = HalloweenDimension.Attributes
local PlayerAttributes = HalloweenDimension.PlayerAttributes
local u75 = Color3.fromRGB(255, 160, 50)
local u80 = Color3.fromRGB(80, 35, 5)

local function child(a1, a2, a3) -- Line: 38 -- types: a1: userdata, a2: string, a3: string
    local v1 = a1:FindFirstChild(a2)
    local v2 = false
    if v1 ~= nil then
        v2 = v1:IsA(a3)
    end
    assert(v2, (("%* is missing %* %*"):format(a1:GetFullName(), a3, a2)))
    return v1
end

local function targetOf(a1, a2) -- Line: 44 -- types: a1: userdata
    local Target = a1:FindFirstChild("Target")
    if Target ~= nil and Target:IsA("Attachment") then
        return Target
    end
    local v1 = a2:Add((Instance.new("Attachment")))
    v1.Name = "LocalTarget"
    v1.Position = Vector3.new(0, -a1.Size.Y * 0.5, 0)
    v1.Parent = a1
    return v1
end

local function altarOf(a1, a2) -- Line: 56 -- upvalues: targetOf (val) -- types: a1: userdata
    local Glow = a1:FindFirstChild("Glow")
    local Value = if Glow == nil then nil else if not Glow:IsA("ObjectValue") then nil else Glow.Value
    local v1 = {Target = targetOf(a1, a2)}
    v1.Plate = if Value == nil then nil else if not Value:IsA("BasePart") then nil else Value
    return v1
end

local function departure(a1) -- Line: 65 -- upvalues: PlayerAttributes (val) -- types: a1: userdata
    local Attribute = a1:GetAttribute(PlayerAttributes.PumpkinDepositFrom)
    if typeof(Attribute) == "CFrame" then
        return Attribute
    end
    local Character = a1.Character
    local HumanoidRootPart = if Character == nil then nil else Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
    end
    return nil
end

local function toastDeposit(a1) -- Line: 78 -- upvalues: Toast (val), u75 (val), u80 (val) -- types: a1: number
    Toast.Show({
        Lane = "Feed",
        Seconds = 2.5,
        Text = if a1 ~= 1 then ("+%* Pumpkins Deposited!"):format(a1) else "+1 Pumpkin Deposited!",
        Color = u75,
        StrokeColor = u80,
    })
end

local function bindAltar(a1, a2, a3) -- Line: 88
    -- upvalues: altarOf (val), Attributes (val), PumpkinDeposit (val), TutorialBeam (val), LocalPlayer (val)
    -- upvalues: PlayerAttributes (val), Audio (val), u68 (val), Toast (val), u75 (val), u80 (val), departure (val)
    -- upvalues: Players (val)
    local u6 = altarOf(a2, a3)
    local u7 = nil

    local function syncOpen() -- Line: 92
        -- upvalues: a2 (val), Attributes (upval), u7 (ref), a3 (val), PumpkinDeposit (upval), u6 (val)
        local v1 = a2:GetAttribute(Attributes.GateOpen) == true
        local v2 = u7
        if v1 == (v2 ~= nil) then
            return
        end
        if v2 ~= nil then
            u7 = nil
            a3:Remove(v2)
            return
        end
        v2 = a3:Extend()
        u7 = v2
        PumpkinDeposit.Beacon(v2, u6)
    end

    a3:Connect(a2:GetAttributeChangedSignal(Attributes.GateOpen), syncOpen)
    syncOpen()
    local u20 = true
    a3:Add(function() -- Line: 111 -- upvalues: u20 (ref)
        u20 = false
    end)
    local u25 = nil

    local function syncBeam(a1) -- Line: 116
        -- upvalues: u25 (ref), a3 (val), TutorialBeam (upval), u6 (val), u20 (ref)
        local v1 = u25
        if a1 == (v1 ~= nil) then
            return
        end
        if v1 ~= nil then
            u25 = nil
            a3:Remove(v1)
            return
        end
        local u16 = a3:Extend()
        u25 = u16
        task.spawn(function() -- Line: 128 -- upvalues: TutorialBeam (upval), u6 (upval), u20 (upval), u25 (upval), u16 (val)
            local u7 = TutorialBeam.Attach(u6.Target.WorldPosition + Vector3.new(0, 2, 0))
            if u20 and u25 == u16 then
                u16:Add(function() -- Line: 132 -- upvalues: TutorialBeam (upval), u7 (val)
                    TutorialBeam.Destroy(u7)
                end)
                return
            end
            TutorialBeam.Destroy(u7)
        end)
    end

    a3:Connect(LocalPlayer:GetAttributeChangedSignal(PlayerAttributes.PumpkinCarrying), function() -- Line: 143
        -- upvalues: LocalPlayer (upval), PlayerAttributes (upval), Audio (upval), u68 (upval), syncBeam (val)
        local v1
        if LocalPlayer:GetAttribute(PlayerAttributes.PumpkinCarrying) == true then
            Audio.Play(u68, script)
        end
        syncBeam(v1)
    end)
    syncBeam(LocalPlayer:GetAttribute(PlayerAttributes.PumpkinCarrying) == true)
    local u49 = {}

    local function count(a1) -- Line: 154 -- upvalues: PlayerAttributes (upval) -- types: a1: userdata
        local Attribute = a1:GetAttribute(PlayerAttributes.Pumpkins)
        if type(Attribute) == "number" then
            return Attribute
        end
        return nil
    end

    local function watch(a1_2) -- Line: 159
        -- upvalues: u49 (val), a3 (val), PlayerAttributes (upval), LocalPlayer (upval), Toast (upval), u75 (upval)
        -- upvalues: u80 (upval), departure (upval), PumpkinDeposit (upval), u6 (val), a1 (val)
        if u49[a1_2] ~= nil then
            return
        end
        local v1 = a3:Extend()
        u49[a1_2] = v1
        local Attribute = a1_2:GetAttribute(PlayerAttributes.Pumpkins)
        local u17 = if type(Attribute) ~= "number" then nil else Attribute
        v1:Connect(a1_2:GetAttributeChangedSignal(PlayerAttributes.Pumpkins), function() -- Line: 166
            -- upvalues: a1_2 (val), PlayerAttributes (upval), u17 (ref), LocalPlayer (upval), Toast (upval)
            -- upvalues: u75 (upval), u80 (upval), departure (upval), PumpkinDeposit (upval), a3 (upval), u6 (upval)
            -- upvalues: a1 (upval)
            local Attribute = a1_2:GetAttribute(PlayerAttributes.Pumpkins)
            local v1 = if type(Attribute) ~= "number" then nil else Attribute
            local v2 = u17
            u17 = v1
            if v1 ~= nil and not (v1 <= (v2 or 0)) then
                local u15 = v1 - (v2 or 0)
                v2 = if a1_2 ~= LocalPlayer then nil else function() -- Line: 175 -- upvalues: u15 (val), Toast (upval), u75 (upval), u80 (upval)
                    local v1 = u15
                    Toast.Show({
                        Lane = "Feed",
                        Seconds = 2.5,
                        Text = if v1 ~= 1 then ("+%* Pumpkins Deposited!"):format(v1) else "+1 Pumpkin Deposited!",
                        Color = u75,
                        StrokeColor = u80,
                    })
                end
                v1 = departure(a1_2)
                if v1 ~= nil then
                    PumpkinDeposit.Play(a3, v1, u6, a1:FindFirstChild("RunawayPumpkins"), v2)
                    return
                end
                if v2 ~= nil then
                    v2()
                end
                return
            end
        end)
    end

    for i, j in Players:GetPlayers() do
        watch(j)
    end
    a3:Connect(Players.PlayerAdded, watch)
    a3:Connect(Players.PlayerRemoving, function(a1) -- Line: 192 -- upvalues: u49 (val), a3 (val) -- types: a1: userdata
        local v1 = u49[a1]
        if v1 ~= nil then
            u49[a1] = nil
            a3:Remove(v1)
        end
    end)
end

return table.freeze({
    Preset = "HalloweenPumpkinMoon",
    Id = HalloweenDimension.WorldEvents.PumpkinMoon,
    MoonColor = Color3.fromRGB(255, 140, 30),
    Bind = function(a1, a2) -- Line: 201 -- upvalues: bindAltar (val), PumpkinHud (val) -- types: a1: userdata
        local Altar = a1:FindFirstChild("Altar")
        local v1 = false
        if Altar ~= nil then
            v1 = Altar:IsA("Model")
        end
        assert(v1, (("%* is missing Model Altar"):format((a1:GetFullName()))))
        local PumpkinDeposit = Altar:FindFirstChild("PumpkinDeposit")
        if PumpkinDeposit == nil or not PumpkinDeposit:IsA("BasePart") then
            local u40 = a2:Extend()
            u40:Connect(Altar.ChildAdded, function(a1_2) -- Line: 208 -- upvalues: a2 (val), u40 (val), bindAltar (upval), a1 (val) -- types: a1_2: userdata
                if a1_2.Name == "PumpkinDeposit" and a1_2:IsA("BasePart") then
                    a2:Remove(u40)
                    bindAltar(a1, a1_2, a2)
                end
            end)
        else
            bindAltar(a1, PumpkinDeposit, a2)
        end
        PumpkinHud.Bind(a2)
    end,
})