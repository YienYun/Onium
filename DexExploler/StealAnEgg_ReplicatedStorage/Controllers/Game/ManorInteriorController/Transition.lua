-- Script path: ReplicatedStorage.Controllers.Game.ManorInteriorController.Transition
-- Decompile time: 7.88 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Doors = require(script.Parent.Unlock.Doors)
local Iris = require(script.Iris)
local Sfx = require(script.Parent.Unlock.Sfx)
local Shot = require(script.Parent.Unlock.Shot)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u37 = nil
local v1 = {}

local function close(a1) -- Line: 49 -- upvalues: u37 (ref) -- types: a1: table
    if a1.Done then
        return
    end
    a1.Done = true
    if u37 == a1 then
        u37 = nil
    end
    a1.Trove:Destroy()
end

local function begin() -- Line: 60 -- upvalues: u37 (ref), Shot (val), Trove (val), LocalPlayer (val)
    local v1 = u37
    if v1 ~= nil and not v1.Done then
        v1.Done = true
        if u37 == v1 then
            u37 = nil
        end
        v1.Trove:Destroy()
    end
    Shot.Drop()
    v1 = Trove.new()
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local u23 = {Done = false, Broken = false, Trove = v1}
    if Humanoid ~= nil then
        v1:Connect(Humanoid.Died, function() -- Line: 75 -- upvalues: u23 (val)
            u23.Broken = true
        end)
    end
    v1:Connect(LocalPlayer.CharacterAdded, function() -- Line: 79 -- upvalues: u23 (val)
        u23.Broken = true
    end)
    u37 = u23
    return u23
end

local function waitClosed(a1) -- Line: 86 -- upvalues: Iris (val) -- types: a1: table
    local v1 = os.clock()
    while not Iris.Closed() do
        if a1.Done or a1.Broken or 6 < os.clock() - v1 then
            break
        end
        task.wait()
    end
    return not a1.Done and not a1.Broken
end

local function hold(a1) -- Line: 97 -- types: a1: number
    local v1 = 0
    while v1 < a1 do
        v1 = v1 + task.wait()
    end
end

local function settle(a1) -- Line: 104 -- upvalues: LocalPlayer (val), Shot (val) -- types: a1: vector?
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        Shot.Face(HumanoidRootPart, a1 or HumanoidRootPart.CFrame.LookVector)
    end
end

local function doorPoint(a1) -- Line: 112 -- upvalues: Doors (val) -- types: a1: table
    local Doors_2 = a1.Doors
    local v1 = if Doors_2 == nil then nil else Doors.Rig(Doors_2, nil)
    if v1 ~= nil then
        return (Doors.Point(v1, 0, v1.Height * 0.2, 0))
    end
    return a1.DoorOutside.Position
end

local function closeSounds(a1, a2) -- Line: 120 -- upvalues: Sfx (val), Doors (val) -- types: a1: table, a2: string
    if a2 == "Exit" then
        Sfx.At("Creak", a1.DoorInside.Position, 0.55, 1.1)
        Sfx.Play("Draft", 0.25, 1.2)
        return
    end
    local At = Sfx.At
    local Doors_2 = a1.Doors
    local v1 = if Doors_2 == nil then nil else Doors.Rig(Doors_2, nil)
    At("Creak", if v1 == nil then a1.DoorOutside.Position else Doors.Point(v1, 0, v1.Height * 0.2, 0), 0.5, 1.05)
    Sfx.Play("Draft", 0.3, 0.9)
end

local function shutSounds() -- Line: 130 -- upvalues: Sfx (val)
    Sfx.Play("DoorSlam", 0.45, 0.72)
    Sfx.Play("Boom", 0.16, 0.8)
end

local function travel(a1, a2) -- Line: 135
    -- upvalues: begin (val), closeSounds (val), Iris (val), u37 (ref), waitClosed (val), Sfx (val), LocalPlayer (val)
    -- upvalues: Shot (val)
    local u3 = begin()
    closeSounds(a1, a2)
    Iris.Close(0.42)
    task.delay(20, function() -- Line: 139 -- upvalues: u37 (upval), u3 (val), Iris (upval)
        if u37 == u3 then
            local v1 = u3
            if not v1.Done then
                v1.Done = true
                if u37 == v1 then
                    u37 = nil
                end
                v1.Trove:Destroy()
            end
            Iris.Open(0.45)
        end
    end)
    if not waitClosed(u3) then
        if not u3.Done then
            u3.Done = true
            if u37 == u3 then
                u37 = nil
            end
            u3.Trove:Destroy()
        end
        Iris.Open(0.45)
        return false
    end
    Sfx.Play("DoorSlam", 0.45, 0.72)
    Sfx.Play("Boom", 0.16, 0.8)
    local success, err = pcall(a1.Arrive)
    local v1 = success
    if v1 then
        v1 = false
        if err == true then
            v1 = not u3.Broken
        end
    end
    if v1 then
        local Destination = a1.Destination
        if a2 == "Enter" then
            local LookVector = a1.Spawn.LookVector
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
                Shot.Face(HumanoidRootPart, LookVector or HumanoidRootPart.CFrame.LookVector)
            end
        elseif Destination == nil then
            local Character_3 = LocalPlayer.Character
            local HumanoidRootPart_3 = Character_3 and Character_3:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart_3 ~= nil and HumanoidRootPart_3:IsA("BasePart") then
                Shot.Face(HumanoidRootPart_3, HumanoidRootPart_3.CFrame.LookVector)
            end
        else
            local LookVector_3 = Destination.LookVector
            local Character_2 = LocalPlayer.Character
            local HumanoidRootPart_2 = Character_2 and Character_2:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart_2 ~= nil and HumanoidRootPart_2:IsA("BasePart") then
                Shot.Face(HumanoidRootPart_2, LookVector_3 or HumanoidRootPart_2.CFrame.LookVector)
            end
        end
        local v2 = 0
        while v2 < 0.12 do
            v2 = v2 + task.wait()
        end
        Sfx.Play("Shimmer", 0.35, if a2 ~= "Enter" then 1 else 0.8)
    end
    if not u3.Done then
        u3.Done = true
        if u37 == u3 then
            u37 = nil
        end
        u3.Trove:Destroy()
    end
    Iris.Open(0.45)
    return v1
end

function v1.Enter(a1) -- Line: 174 -- upvalues: Sfx (val), travel (val) -- types: a1: table
    Sfx.Warm()
    return (travel(a1, "Enter"))
end

function v1.Exit(a1) -- Line: 179 -- upvalues: travel (val) -- types: a1: table
    return (travel(a1, "Exit"))
end

function v1.Abort() -- Line: 183 -- upvalues: u37 (ref), Shot (val), Iris (val)
    local v1 = u37
    if v1 ~= nil and not v1.Done then
        v1.Done = true
        if u37 == v1 then
            u37 = nil
        end
        v1.Trove:Destroy()
    end
    Shot.Drop()
    Iris.Open(0.45)
end

function v1.Cover() -- Line: 192 -- upvalues: Iris (val)
    Iris.Shut()
end

function v1.Reveal() -- Line: 196 -- upvalues: Iris (val)
    Iris.Open(0.45)
end

return (table.freeze(v1))