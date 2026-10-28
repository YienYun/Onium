-- Script path: ReplicatedStorage.Controllers.Game.GhostDogQuestController.Memories
-- Decompile time: 9.18 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fx = require(script.Parent.Fx)
local GhostDogQuest = require(ReplicatedStorage.Data.GhostDogQuest)
local GUI = require(ReplicatedStorage.Client.GUI)
local SurfaceButton = require(ReplicatedStorage.Client.UI.VFX.SurfaceButton)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local CollectSecretRing = ReplicatedStorage.Assets.Sounds.LightVsDarknessSounds.CollectSecretRing
local u45 = Color3.fromHex("FFE15A")
local u46 = nil
local u47 = {}
local u48 = nil
local u50 = Trove.new()
local u51 = {}

local function screenOf() -- Line: 33 -- upvalues: u46 (ref), GUI (val)
    local v1 = u46
    if v1 and v1.Parent then
        return v1
    end
    local success, err = pcall(GUI.Get, "DogsMemoriesFrame")
    if success and err ~= nil then
        return err
    end
    return nil
end

local function mainOf(a1) -- Line: 46 -- types: a1: userdata
    return a1.Frame.Main
end

local function slotOf(a1, a2) -- Line: 50 -- types: a1: userdata, a2: number
    local v1 = a1.Frame.Main.Slots:FindFirstChild((("Slot%*"):format(a2)))
    if v1 and v1:IsA("Frame") then
        return v1
    end
    return nil
end

local function selectedStrokeOf(a1) -- Line: 55 -- upvalues: u45 (val) -- types: a1: userdata
    local SelectedStroke = a1:FindFirstChild("SelectedStroke")
    if SelectedStroke and SelectedStroke:IsA("UIStroke") then
        return SelectedStroke
    end
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Name = "SelectedStroke"
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Color = u45
    UIStroke.Thickness = 3
    UIStroke.Transparency = 1
    UIStroke.Parent = a1
    return UIStroke
end

local function lineFor(a1) -- Line: 70 -- upvalues: u47 (ref)
    if u47[a1.Id] == true then
        return (("\"%*\""):format(a1.Found))
    end
    return (("\"%*\""):format(a1.Hint))
end

local function render(a1) -- Line: 77
    -- upvalues: GhostDogQuest (val), u47 (ref), u45 (val), u48 (ref)
    local CompletedCheckmark, Hint, Unknown, v1, v2, v3
    local v4 = nil
    local v5 = nil
    local v6 = a1
    for i, j in GhostDogQuest.Artifacts, v4, v5 do
        v2 = v6.Frame.Main.Slots:FindFirstChild((("Slot%*"):format(i)))
        v1 = if not v2 then nil else if not v2:IsA("Frame") then nil else v2
        if v1 ~= nil then
            v2 = u47[j.Id] == true
            Unknown = v1:FindFirstChild("Unknown")
            CompletedCheckmark = v1:FindFirstChild("CompletedCheckmark")
            if Unknown and Unknown:IsA("GuiObject") then
                Unknown.Visible = not v2
            end
            if CompletedCheckmark and CompletedCheckmark:IsA("GuiObject") then
                CompletedCheckmark.Visible = v2
            end
            v3 = v1:FindFirstChild("SelectedStroke")
            if not v3 or not v3:IsA("UIStroke") then
                v3 = Instance.new("UIStroke")
                v3.Name = "SelectedStroke"
                v3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                v3.Color = u45
                v3.Thickness = 3
                v3.Transparency = 1
                v3.Parent = v1
            end
            v3.Transparency = if j.Id ~= u48 then 1 else 0
        end
    end
    for k, n in GhostDogQuest.Artifacts do
        if n.Id == u48 then
            Hint = v6.Frame.Main:FindFirstChild("Hint")
            if Hint and Hint:IsA("TextLabel") then
                v2 = if u47[n.Id] ~= true then ("\"%*\""):format(n.Hint) else ("\"%*\""):format(n.Found)
                Hint.Text = v2
            end
            return
        end
    end
end

local function select(a1) -- Line: 105
    -- upvalues: u46 (ref), GUI (val), u48 (ref), render (val), Fx (val)
    local v1
    local v2 = u46
    if not v2 or not v2.Parent then
        local success, err = pcall(GUI.Get, "DogsMemoriesFrame")
        v1 = if not success then nil else if err ~= nil then err else nil
    else
        v1 = v2
    end
    if v1 == nil then
        return
    end
    v2 = u48 ~= a1
    u48 = a1
    render(v1)
    local Hint = v1.Frame.Main:FindFirstChild("Hint")
    if v2 and Hint and Hint:IsA("TextLabel") then
        Hint.TextTransparency = 1
        Fx.Tween(Hint, 0.3, {TextTransparency = 0})
    end
end

local function defaultSelection() -- Line: 120 -- upvalues: u48 (ref), u47 (ref), GhostDogQuest (val)
    if u48 and u47[u48] ~= true then
        return u48
    end
    for i, j in GhostDogQuest.Artifacts do
        if u47[j.Id] ~= true then
            return j.Id
        end
    end
    local v1 = GhostDogQuest.Artifacts[1]
    return v1 and v1.Id
end

local function bind(a1) -- Line: 133
    -- upvalues: GhostDogQuest (val), SurfaceButton (val), select (val)
    local v1, v2
    if a1:GetAttribute("GhostDogBound") == true then
        return
    end
    a1:SetAttribute("GhostDogBound", true)
    local v3 = nil
    local v4 = nil
    for i, j in GhostDogQuest.Artifacts, v3, v4 do
        v2 = a1.Frame.Main.Slots:FindFirstChild((("Slot%*"):format(i)))
        v1 = if not v2 then nil else if not v2:IsA("Frame") then nil else v2
        if v1 ~= nil then
            SurfaceButton(v1, nil, function() -- Line: 143 -- upvalues: select (upval), j (val)
                select(j.Id)
            end)
        end
    end
end

function u51.IsOpen() -- Line: 149 -- upvalues: Tabs (val)
    return Tabs.IsActive("DogsMemoriesFrame")
end

function u51.Open(a1) -- Line: 153
    -- upvalues: u46 (ref), GUI (val), bind (val), u48 (ref), u47 (ref), GhostDogQuest (val), render (val), Tabs (val)
    -- upvalues: u50 (val), u51 (val), LocalPlayer (val)
    local Id, v1, v2
    local v3 = u46
    if not v3 or not v3.Parent then
        local success, err = pcall(GUI.Get, "DogsMemoriesFrame")
        v1 = if not success then nil else if err ~= nil then err else nil
    else
        v1 = v3
    end
    if v1 == nil then
        return
    end
    bind(v1)
    if not u48 then
        for i, j in GhostDogQuest.Artifacts do
            if u47[j.Id] ~= true then
                u48 = j.Id
                render(v1)
                Tabs.Activate("DogsMemoriesFrame")
                u50:Clean()
                u50:Add((task.spawn(function() -- Line: 163 -- upvalues: u51 (upval), LocalPlayer (upval), a1 (val), Tabs (upval)
                    local Character, HumanoidRootPart
                    while u51.IsOpen() do
                        task.wait(0.25)
                        Character = LocalPlayer.Character
                        HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                        if a1
                            and HumanoidRootPart
                            and HumanoidRootPart:IsA("BasePart")
                            and 40 < (HumanoidRootPart.Position - a1.Position).Magnitude then
                            Tabs.Deactivate()
                            return
                        end
                    end
                end)))
                return
            end
        end
        v2 = GhostDogQuest.Artifacts[1]
        Id = v2 and v2.Id
    elseif u47[u48] == true then
        for k, n in GhostDogQuest.Artifacts do
            if u47[n.Id] ~= true then
                u48 = n.Id
                render(v1)
                Tabs.Activate("DogsMemoriesFrame")
                u50:Clean()
                u50:Add((task.spawn(function() -- Line: 163 -- upvalues: u51 (upval), LocalPlayer (upval), a1 (val), Tabs (upval)
                    local Character, HumanoidRootPart
                    while u51.IsOpen() do
                        task.wait(0.25)
                        Character = LocalPlayer.Character
                        HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                        if a1
                            and HumanoidRootPart
                            and HumanoidRootPart:IsA("BasePart")
                            and 40 < (HumanoidRootPart.Position - a1.Position).Magnitude then
                            Tabs.Deactivate()
                            return
                        end
                    end
                end)))
                return
            end
        end
        v2 = GhostDogQuest.Artifacts[1]
        Id = v2 and v2.Id
    else
        Id = u48
    end
    u48 = Id
    render(v1)
    Tabs.Activate("DogsMemoriesFrame")
    u50:Clean()
    u50:Add((task.spawn(function() -- Line: 163 -- upvalues: u51 (upval), LocalPlayer (upval), a1 (val), Tabs (upval)
        local Character, HumanoidRootPart
        while u51.IsOpen() do
            task.wait(0.25)
            Character = LocalPlayer.Character
            HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            if a1
                and HumanoidRootPart
                and HumanoidRootPart:IsA("BasePart")
                and 40 < (HumanoidRootPart.Position - a1.Position).Magnitude then
                Tabs.Deactivate()
                return
            end
        end
    end)))
end

function u51.Close() -- Line: 181 -- upvalues: u50 (val), u51 (val), Tabs (val)
    u50:Clean()
    if u51.IsOpen() then
        Tabs.Deactivate()
    end
end

function u51.Sync(a1, a2) -- Line: 188
    -- upvalues: u47 (ref), u51 (val), u46 (ref), render (val)
    table.clone(a1)
    if not a2 then
        u51.Close()
        return
    end
    local v1 = u46
    if v1 and u51.IsOpen() then
        render(v1)
    end
end

function u51.Celebrate(a1) -- Line: 200
    -- upvalues: u47 (ref), Fx (val), CollectSecretRing (val), u46 (ref), u51 (val), render (val)
    u47[a1] = true
    Fx.Play(CollectSecretRing, {Volume = 0.6})
    local v1 = u46
    if v1 and u51.IsOpen() then
        render(v1)
    end
end

function u51.Reset() -- Line: 209 -- upvalues: u51 (val), u48 (ref), u47 (ref)
    u51.Close()
    u48 = nil
    table.clear(u47)
end

return (table.freeze(u51))