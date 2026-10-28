-- Script path: ReplicatedStorage.Controllers.Game.TrainTownLighting
-- Decompile time: 5.28 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LightingController = require(script.Parent.LightingController)
local LocalPlayer = Players.LocalPlayer
local v1 = {}
local u17 = false
local u18 = false
local u19 = nil
local u20 = {}

local function clear() -- Line: 14 -- upvalues: u18 (ref), LightingController (val), u19 (ref)
    if u18 then
        LightingController.ClearLayer("TrainForgottenTown", 0)
    end
    u18 = false
    u19 = nil
end

local function config() -- Line: 18 -- upvalues: ReplicatedStorage (val)
    local TrainEvent = ReplicatedStorage.Assets:FindFirstChild("TrainEvent")
    return TrainEvent and TrainEvent:FindFirstChild("LightingSettings")
end

local function sync() -- Line: 22
    -- upvalues: LocalPlayer (val), u18 (ref), LightingController (val), u19 (ref), ReplicatedStorage (val)
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    if Character
        and Humanoid
        and not (Humanoid.Health <= 0)
        and Character:GetAttribute("TrainEventInForgottenTown") == true then
        local v1 = ReplicatedStorage.Assets:FindFirstChild("TrainEvent")
        local LightingSettings = v1 and v1:FindFirstChild("LightingSettings")
        if not LightingSettings then
            if u18 then
                LightingController.ClearLayer("TrainForgottenTown", 0)
            end
            u18 = false
            u19 = nil
            return
        end
        if u18 and u19 == LightingSettings then
            return
        end
        local success, err = pcall(LightingController.SetAuthoredLayer, "TrainForgottenTown", LightingSettings, 160, 0)
        if success then
            u18 = true
            u19 = LightingSettings
            return
        end
        if u18 then
            LightingController.ClearLayer("TrainForgottenTown", 0)
        end
        u18 = false
        u19 = nil
        warn("[TrainEvent] Invalid town lighting:", err)
        return
    end
    if u18 then
        LightingController.ClearLayer("TrainForgottenTown", 0)
    end
    u18 = false
    u19 = nil
end

local function watch(a1) -- Line: 32
    -- upvalues: u20 (val), u18 (ref), LightingController (val), u19 (ref), sync (val), clear (val), LocalPlayer (val)
    for i, j in u20 do
        j:Disconnect()
    end
    table.clear(u20)
    if u18 then
        LightingController.ClearLayer("TrainForgottenTown", 0)
    end
    u18 = false
    u19 = nil
    table.insert(u20, ((a1:GetAttributeChangedSignal("TrainEventInForgottenTown")):Connect(sync)))

    local function attachHumanoid(a1) -- Line: 37 -- upvalues: u20 (upval), clear (upval), sync (upval)
        table.insert(u20, (a1.Died:Connect(clear)))
        sync()
    end

    local Humanoid = a1:FindFirstChildOfClass("Humanoid")
    if not Humanoid then
        task.spawn(function() -- Line: 42 -- upvalues: a1 (val), LocalPlayer (upval), u20 (upval), clear (upval), sync (upval)
            local Humanoid = a1:WaitForChild("Humanoid", 10)
            if Humanoid and LocalPlayer.Character == a1 then
                table.insert(u20, (Humanoid.Died:Connect(clear)))
                sync()
            end
        end)
    else
        table.insert(u20, (Humanoid.Died:Connect(clear)))
        sync()
    end
    sync()
end

function v1.Start() -- Line: 49
    -- upvalues: u17 (ref), LocalPlayer (val), watch (val), u20 (val), u18 (ref), LightingController (val), u19 (ref)
    -- upvalues: ReplicatedStorage (val), sync (val), clear (val)
    if u17 then
        return
    end
    u17 = true
    LocalPlayer.CharacterAdded:Connect(watch)
    LocalPlayer.CharacterRemoving:Connect(function() -- Line: 52 -- upvalues: u20 (upval), u18 (upval), LightingController (upval), u19 (upval)
        for i, j in u20 do
            j:Disconnect()
        end
        table.clear(u20)
        if u18 then
            LightingController.ClearLayer("TrainForgottenTown", 0)
        end
        u18 = false
        u19 = nil
    end)
    ReplicatedStorage.Assets.DescendantAdded:Connect(function(a1) -- Line: 56 -- upvalues: sync (upval)
        if a1.Name == "LightingSettings" then
            task.defer(sync)
        end
    end)
    ReplicatedStorage.Assets.DescendantRemoving:Connect(function(a1) -- Line: 59 -- upvalues: u19 (upval), sync (upval)
        if a1 == u19 then
            task.defer(function() -- Line: 60 -- upvalues: u19 (upval), sync (upval)
                u19 = nil
                sync()
            end)
        end
    end)
    script.Destroying:Connect(clear)
    if LocalPlayer.Character then
        watch(LocalPlayer.Character)
    end
end

return v1