-- Script path: ReplicatedStorage.Shared.Player
-- Decompile time: 3.00 ms

local Players = game:GetService("Players")
local u5 = {}

local function resolvePlayer(a1) -- Line: 11 -- upvalues: Players (val) -- types: a1: userdata?
    local LocalPlayer = a1 or Players.LocalPlayer
    assert(LocalPlayer ~= nil, "Rig lookups need an explicit Player when there is no LocalPlayer")
    return LocalPlayer
end

local function pickPart(a1) -- Line: 17 -- types: a1: string
    return function(a1_2) -- Line: 18 -- upvalues: a1 (val) -- types: a1_2: userdata
        local v1 = a1_2:FindFirstChild(a1)
        if v1 and v1:IsA("BasePart") then
            return v1
        end
        return nil
    end
end

local function pickHumanoid(a1) -- Line: 24 -- types: a1: userdata
    return (a1:FindFirstChildOfClass("Humanoid"))
end

local u9 = "HumanoidRootPart"

local function u10(a1) -- Line: 18 -- upvalues: u9 (val) -- types: a1: userdata
    local v1 = a1:FindFirstChild(u9)
    if v1 and v1:IsA("BasePart") then
        return v1
    end
    return nil
end

local u11 = "Head"

local function u12(a1) -- Line: 18 -- upvalues: u11 (val) -- types: a1: userdata
    local v1 = a1:FindFirstChild(u11)
    if v1 and v1:IsA("BasePart") then
        return v1
    end
    return nil
end

local function awaitPiece(a1, a2) -- Line: 31 -- types: a1: userdata, a2: function
    local v1 = a2(a1)
    while v1 == nil do
        a1.ChildAdded:Wait()
        v1 = a2(a1)
    end
    return v1
end

function u5.FindCharacter(a1) -- Line: 40 -- upvalues: Players (val) -- types: a1: userdata?
    local LocalPlayer = a1 or Players.LocalPlayer
    assert(LocalPlayer ~= nil, "Rig lookups need an explicit Player when there is no LocalPlayer")
    return LocalPlayer.Character
end

function u5.WaitForCharacter(a1) -- Line: 44 -- upvalues: Players (val) -- types: a1: userdata?
    local LocalPlayer = a1 or Players.LocalPlayer
    assert(LocalPlayer ~= nil, "Rig lookups need an explicit Player when there is no LocalPlayer")
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

function u5.FindHumanoid(a1) -- Line: 49 -- upvalues: u5 (val) -- types: a1: userdata?
    local v1 = u5.FindCharacter(a1)
    if v1 then
        return (v1:FindFirstChildOfClass("Humanoid"))
    end
    return nil
end

function u5.WaitForHumanoid(a1) -- Line: 54
    -- upvalues: awaitPiece (val), u5 (val), pickHumanoid (val)
    return (awaitPiece(u5.WaitForCharacter(a1), pickHumanoid))
end

function u5.FindRootPart(a1) -- Line: 58 -- upvalues: u5 (val), u10 (val) -- types: a1: userdata?
    local v1 = u5.FindCharacter(a1)
    if v1 then
        return (u10(v1))
    end
    return nil
end

function u5.WaitForRootPart(a1) -- Line: 63 -- upvalues: awaitPiece (val), u5 (val), u10 (val) -- types: a1: userdata?
    return (awaitPiece(u5.WaitForCharacter(a1), u10))
end

function u5.FindPrimaryPart(a1) -- Line: 67 -- upvalues: u5 (val) -- types: a1: userdata?
    local v1 = u5.FindCharacter(a1)
    if v1 then
        return v1.PrimaryPart
    end
    return nil
end

function u5.FindHead(a1) -- Line: 72 -- upvalues: u5 (val), u12 (val) -- types: a1: userdata?
    local v1 = u5.FindCharacter(a1)
    if v1 then
        return (u12(v1))
    end
    return nil
end

function u5.FindAnimator(a1) -- Line: 77 -- upvalues: u5 (val) -- types: a1: userdata?
    local v1 = u5.FindHumanoid(a1)
    if v1 then
        return (v1:FindFirstChildOfClass("Animator"))
    end
    return nil
end

function u5.FindFeetCFrame(a1) -- Line: 83 -- upvalues: u5 (val) -- types: a1: userdata?
    local v1 = u5.FindCharacter(a1)
    local PrimaryPart = if not v1 then nil else v1.PrimaryPart
    local Humanoid = if not v1 then nil else v1:FindFirstChildOfClass("Humanoid")
    if PrimaryPart ~= nil and Humanoid ~= nil then
        return PrimaryPart.CFrame * CFrame.new(0, -(Humanoid.HipHeight + PrimaryPart.Size.Y / 2), 0)
    end
    return nil
end

return u5