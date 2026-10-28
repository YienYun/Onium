-- Script path: ReplicatedStorage.Controllers.Game.ButterflyStationController
-- Decompile time: 12.80 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ButterflyCatalog = require(ReplicatedStorage.Shared.Modules.ButterflyCatalog)
local ButterflyFlags = require(ReplicatedStorage.Shared.Flags.ButterflyFlags)
local GUI = require(ReplicatedStorage.Client.GUI)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local u70 = Color3.fromRGB(150, 255, 120)
local u75 = Color3.fromRGB(20, 70, 10)
local LocalPlayer = Players.LocalPlayer
local u80 = TryLock(8)
local v1 = {}

local function netClaimed() -- Line: 49 -- upvalues: Save (val)
    local v1 = if not Save.IsLoaded() then nil else Save.Peek()
    local Butterflies = if not v1 then nil else v1.Butterflies
    local v2 = false
    if typeof(Butterflies) == "table" then
        v2 = Butterflies.NetClaimed == true
    end
    return v2
end

local function promptOf(a1, a2) -- Line: 55 -- types: a1: userdata, a2: string
    local v1 = a1:WaitForChild(a2, 30)
    if v1 == nil then
        warn((("[ButterflyStation] ButterflyStation.%* is missing"):format(a2)))
        return nil
    end
    local ProximityPrompt = v1:FindFirstChildWhichIsA("ProximityPrompt", true)
    if ProximityPrompt == nil then
        warn((("[ButterflyStation] %* needs a ProximityPrompt"):format((v1:GetFullName()))))
    end
    return ProximityPrompt
end

local function openPanel(a1) -- Line: 68 -- upvalues: ButterflyFlags (val), GUI (val), Tabs (val) -- types: a1: string
    if not ButterflyFlags.Enabled:Get() then
        return
    end
    GUI.Get(a1)
    if Tabs.IsActive(a1) then
        return
    end
    Tabs.Activate(a1)
end

local function ownsNetTool() -- Line: 79 -- upvalues: LocalPlayer (val)
    local v1 = {LocalPlayer:FindFirstChildOfClass("Backpack"), LocalPlayer.Character}
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if j ~= nil then
            for k, n in j:GetChildren() do
                if n:IsA("Tool") and n:GetAttribute("ButterflyNet") == true then
                    return true
                end
            end
        end
    end
    return false
end

local function flyInto(a1) -- Line: 93
    -- upvalues: LocalPlayer (val), Workspace (val), RunService (val), TweenService (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character
    if HumanoidRootPart then
        HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    end
    if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        local u17 = a1:Clone()
        local Pivot = a1:GetPivot()
        local Scale = u17:GetScale()
        u17.Parent = Workspace
        local u26 = os.clock()
        local u27 = nil
        RunService.RenderStepped:Connect(function() -- Line: 105
            -- upvalues: u26 (val), TweenService (upval), HumanoidRootPart (val), Pivot (val), u17 (val), Scale (val)
            -- upvalues: u27 (ref)
            local v1 = math.clamp((os.clock() - u26) / 0.55, 0, 1)
            local Value = TweenService:GetValue(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            local v2 = Pivot.Position:Lerp(HumanoidRootPart.Position + Vector3.new(0, 0.6000000238418579, 0), Value)
            local v3 = CFrame.Angles(0, v1 * 3.141592653589793 * 3, 0)
            u17:ScaleTo(Scale * (1 - 0.92 * Value))
            u17:PivotTo((CFrame.new(v2)) * Pivot.Rotation * v3)
            if v1 >= 1 then
                if u27 then
                    u27:Disconnect()
                end
                u17:Destroy()
            end
        end)
        return
    end
end

local function claimNet(a1) -- Line: 122
    -- upvalues: u80 (val), Remotes (val), Audio (val), ButterflyCatalog (val), Toast (val), u70 (val), u75 (val)
    u80(function() -- Line: 123
        -- upvalues: Remotes (upval), a1 (val), Audio (upval), ButterflyCatalog (upval), Toast (upval), u70 (upval)
        -- upvalues: u75 (upval)
        local success, err, v1 = pcall(function() -- Line: 124 -- upvalues: Remotes (upval)
            return Remotes.Butterflies.AskClaimNet:InvokeServer()
        end)
        if not success then
            return
        end
        if err then
            a1()
            Audio.Play(ButterflyCatalog.Sounds.Craft, script, {Volume = 0.7})
            Toast.Show({
                Lane = "Banner",
                Text = "You got a Butterfly Net!\nEquip it and swing at butterflies during the Butterfly Bloom!",
                Seconds = 4.5,
                ShowShadow = true,
                Color = u70,
                StrokeColor = u75,
                Image = ButterflyCatalog.Icons.Net,
                Size = UDim2.fromScale(1.5, 0.45),
            })
            return
        end
        if typeof(v1) == "string" then
            Audio.Play(ButterflyCatalog.Sounds.Deny, script, {Volume = 0.6})
            Toast.Show({Lane = "Feed", Seconds = 2.5, Text = v1, Color = Color3.fromRGB(255, 120, 120)})
        end
    end)
end

local function bindNetStand(a1, a2) -- Line: 155
    -- upvalues: RunService (val), Save (val), ownsNetTool (val), LocalPlayer (val), flyInto (val), u80 (val)
    -- upvalues: Remotes (val), Audio (val), ButterflyCatalog (val), Toast (val), u70 (val), u75 (val)
    local Float = a1:FindFirstChild("Float")
    local Ring = a1:FindFirstChild("Ring")
    local Pivot = if not Float then nil else if not Float:IsA("Model") then nil else Float:GetPivot()
    local Spin = if not Ring then nil else Ring:FindFirstChild("Spin", true)
    local u26 = false
    local u27 = nil
    local u28 = nil

    local function step() -- Line: 164 -- upvalues: Float (val), Pivot (val), Spin (val)
        local v1 = os.clock()
        if Float and Float:IsA("Model") and Pivot then
            Float:PivotTo(Pivot * CFrame.new(0, math.sin(v1 * 1.8) * 0.45, 0) * (CFrame.Angles(0, v1 * 0.7, 0)))
        end
        if Spin and Spin:IsA("GuiObject") then
            Spin.Rotation = v1 * 30 % 360
        end
    end

    local function setShown(a1_2) -- Line: 175
        -- upvalues: u27 (ref), Float (val), Ring (val), a1 (val), a2 (val), u28 (ref), RunService (upval), step (val)
        if u27 == a1_2 then
            return
        end
        u27 = a1_2
        local v1 = {Float, Ring}
        local v2 = nil
        local v3 = nil
        local v4 = a1_2
        for i, j in v1, v2, v3 do
            if j then
                j.Parent = if not v4 then nil else a1
            end
        end
        a2.ActionText = "Claim Net"
        a2.Enabled = v4
        if v4 and u28 == nil then
            u28 = RunService.RenderStepped:Connect(step)
            return
        end
        if not v4 and u28 then
            u28:Disconnect()
            u28 = nil
        end
    end

    local function refresh() -- Line: 195 -- upvalues: setShown (val), u26 (ref), Save (upval), ownsNetTool (upval)
        local v1 = u26
        if not v1 then
            local v2 = if not Save.IsLoaded() then nil else Save.Peek()
            local Butterflies = if not v2 then nil else v2.Butterflies
            v1 = false
            if typeof(Butterflies) == "table" then
                v1 = Butterflies.NetClaimed == true
            end
            if not v1 then
                v1 = ownsNetTool()
            end
        end
        setShown(not v1)
    end

    local function watchBackpack() -- Line: 199
        -- upvalues: LocalPlayer (upval), refresh (val), setShown (val), u26 (ref), Save (upval), ownsNetTool (upval)
        local Backpack = LocalPlayer:WaitForChild("Backpack", 10)
        if Backpack then
            Backpack.ChildAdded:Connect(refresh)
        end
        local v1 = u26
        if not v1 then
            local v2 = if not Save.IsLoaded() then nil else Save.Peek()
            local Butterflies = if not v2 then nil else v2.Butterflies
            v1 = false
            if typeof(Butterflies) == "table" then
                v1 = Butterflies.NetClaimed == true
            end
            if not v1 then
                v1 = ownsNetTool()
            end
        end
        setShown(not v1)
    end

    a2.Triggered:Connect(function() -- Line: 207
        -- upvalues: u26 (ref), Float (val), u27 (ref), flyInto (upval), Ring (val), a2 (val), u28 (ref), u80 (upval)
        -- upvalues: Remotes (upval), Audio (upval), ButterflyCatalog (upval), Toast (upval), u70 (upval), u75 (upval)
        local function u0() -- Line: 208
            -- upvalues: u26 (upval), Float (upval), u27 (upval), flyInto (upval), Ring (upval), a2 (upval), u28 (upval)
            u26 = true
            if Float and Float:IsA("Model") and u27 then
                flyInto(Float)
            end
            if u27 == false then
                return
            end
            u27 = false
            for i, j in {Float, Ring} do
                if j then
                    j.Parent = nil
                end
            end
            a2.ActionText = "Claim Net"
            a2.Enabled = false
            if u28 then
                u28:Disconnect()
                u28 = nil
            end
        end

        u80(function() -- Line: 123
            -- upvalues: Remotes (upval), u0 (val), Audio (upval), ButterflyCatalog (upval), Toast (upval), u70 (upval)
            -- upvalues: u75 (upval)
            local success, err, v1 = pcall(function() -- Line: 124 -- upvalues: Remotes (upval)
                return Remotes.Butterflies.AskClaimNet:InvokeServer()
            end)
            if not success then
                return
            end
            if err then
                u0()
                Audio.Play(ButterflyCatalog.Sounds.Craft, script, {Volume = 0.7})
                Toast.Show({
                    Lane = "Banner",
                    Text = "You got a Butterfly Net!\nEquip it and swing at butterflies during the Butterfly Bloom!",
                    Seconds = 4.5,
                    ShowShadow = true,
                    Color = u70,
                    StrokeColor = u75,
                    Image = ButterflyCatalog.Icons.Net,
                    Size = UDim2.fromScale(1.5, 0.45),
                })
                return
            end
            if typeof(v1) == "string" then
                Audio.Play(ButterflyCatalog.Sounds.Deny, script, {Volume = 0.6})
                Toast.Show({
                    Lane = "Feed",
                    Seconds = 2.5,
                    Text = v1,
                    Color = Color3.fromRGB(255, 120, 120),
                })
            end
        end)
    end)
    Save.WatchFields("Butterflies", refresh)
    Remotes.Butterflies.NetClaimed.OnClientEvent:Connect(function() -- Line: 217 -- upvalues: u26 (ref), setShown (val), Save (upval), ownsNetTool (upval)
        u26 = true
        local v1 = u26
        if not v1 then
            local v2 = if not Save.IsLoaded() then nil else Save.Peek()
            local Butterflies = if not v2 then nil else v2.Butterflies
            v1 = false
            if typeof(Butterflies) == "table" then
                v1 = Butterflies.NetClaimed == true
            end
            if not v1 then
                v1 = ownsNetTool()
            end
        end
        setShown(not v1)
    end)
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 221 -- upvalues: watchBackpack (val)
        task.defer(watchBackpack)
    end)
    task.spawn(watchBackpack)
end

local function bindStation(a1) -- Line: 227
    -- upvalues: promptOf (val), bindNetStand (val), ButterflyFlags (val), GUI (val), Tabs (val)
    local v1 = promptOf(a1, "NetStand")
    local v2 = promptOf(a1, "ButterflyMachine")
    local v3 = promptOf(a1, "MutationShrine")
    if v1 then
        bindNetStand(a1:FindFirstChild("NetStand"), v1)
    end
    if v2 then
        v2.Triggered:Connect(function() -- Line: 235 -- upvalues: ButterflyFlags (upval), GUI (upval), Tabs (upval)
            if not ButterflyFlags.Enabled:Get() then
                return
            end
            GUI.Get("ButterflyMachine")
            if Tabs.IsActive("ButterflyMachine") then
                return
            end
            Tabs.Activate("ButterflyMachine")
        end)
    end
    if v3 then
        v3.Triggered:Connect(function() -- Line: 240 -- upvalues: ButterflyFlags (upval), GUI (upval), Tabs (upval)
            if not ButterflyFlags.Enabled:Get() then
                return
            end
            GUI.Get("EnchantedMutationShrine")
            if Tabs.IsActive("EnchantedMutationShrine") then
                return
            end
            Tabs.Activate("EnchantedMutationShrine")
        end)
    end
end

function v1.Start() -- Line: 250 -- upvalues: Workspace (val), bindStation (val), LocalPlayer (val), Tabs (val)
    task.spawn(function() -- Line: 251 -- upvalues: Workspace (upval), bindStation (upval)
        local v1 = Workspace:WaitForChild("World"):WaitForChild("Machines"):WaitForChild("ButterflyStation", 60)
        if v1 == nil then
            warn("[ButterflyStation] Workspace.World.Machines.ButterflyStation is missing")
            return
        end
        bindStation(v1)
    end)
    LocalPlayer.CharacterAdded:Connect(function() -- Line: 261 -- upvalues: Tabs (upval)
        if Tabs.IsActive("ButterflyMachine") or Tabs.IsActive("EnchantedMutationShrine") then
            Tabs.Deactivate({instant = true})
        end
    end)
end

return v1