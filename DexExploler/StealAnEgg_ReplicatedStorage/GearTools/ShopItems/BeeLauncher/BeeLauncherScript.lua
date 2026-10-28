-- Script path: ReplicatedStorage.GearTools.ShopItems.BeeLauncher.BeeLauncherScript
-- Decompile time: 4.41 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
local LocalPlayer = Players.LocalPlayer
LocalPlayer:GetMouse()
local Parent = script.Parent
local u25 = 0
local BeeLauncherRemote = script.Parent:WaitForChild("BeeLauncherRemote")
local u32 = nil
local u33 = {}

local function removePlayerHighlights(a1) -- Line: 21 -- upvalues: u33 (ref)
    if u33[a1] then
        for k, v in pairs(u33[a1]) do
            if v and v.Parent then
                v:Destroy()
            end
        end
        u33[a1] = nil
    end
end

local function addPlayerHighlights(a1) -- Line: 32 -- upvalues: removePlayerHighlights (val), u33 (ref)
    local Character = a1.Character
    if not Character then
        return
    end
    removePlayerHighlights(a1)
    local v1 = {}
    local Highlight = Instance.new("Highlight")
    Highlight.OutlineColor = Color3.new(1, 0.933333, 0)
    Highlight.Parent = Character
    table.insert(v1, Highlight)
    u33[a1] = v1
end

local function onUnequipped() -- Line: 50 -- upvalues: u32 (ref), u33 (ref)
    if u32 then
        u32:Disconnect()
        u32 = nil
    end
    for k, v in pairs(u33) do
        for k2, i in pairs(v) do
            if i and i.Parent then
                i:Destroy()
            end
        end
    end
    u33 = {}
end

Parent.Equipped:Connect(function() -- Line: 66
    -- upvalues: u32 (ref), RunService (val), LocalPlayer (val), onUnequipped (val), Players (val), u33 (ref)
    -- upvalues: addPlayerHighlights (val), removePlayerHighlights (val)
    if u32 then
        u32:Disconnect()
    end
    RunService.Heartbeat:Connect(function() -- Line: 71
        -- upvalues: LocalPlayer (upval), onUnequipped (upval), Players (upval), u33 (upval)
        -- upvalues: addPlayerHighlights (upval), removePlayerHighlights (upval)
        if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
            local v1 = {}
            for k, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character.PrimaryPart then
                    if not ((v.Character.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude <= 30) then
                        removePlayerHighlights(v)
                    else
                        table.insert(v1, v)
                        if not u33[v] then
                            addPlayerHighlights(v)
                        end
                    end
                end
            end
            for k2, i in pairs(u33) do
                if not table.find(v1, k2) and k2 ~= LocalPlayer then
                    removePlayerHighlights(k2)
                end
            end
            return
        end
        onUnequipped()
    end)
end)
Parent.Unequipped:Connect(onUnequipped)
Parent.Activated:Connect(function() -- Line: 103
    -- upvalues: ToolGameplayGuard (val), Parent (val), LocalPlayer (val), u25 (ref), Players (val)
    -- upvalues: BeeLauncherRemote (val)
    if not ToolGameplayGuard.AllowsLocalUse(Parent) then
        return
    end
    if LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
        local Position = LocalPlayer.Character.PrimaryPart.Position
        local v1 = tick()
        if v1 - u25 < 60 then
            return
        end
        u25 = v1
        for k, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and not v.Character.PrimaryPart then end
        end
        BeeLauncherRemote:FireServer(Position)
        return
    end
end)
LocalPlayer.CharacterRemoving:Connect(function() -- Line: 137 -- upvalues: onUnequipped (val)
    onUnequipped()
end)