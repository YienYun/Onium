-- Script path: ReplicatedStorage.Controllers.Game.TrainEventController.TicketFlight
-- Decompile time: 12.22 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TrainEvent = require(ReplicatedStorage.Shared.Remotes).TrainEvent
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u38 = Color3.fromRGB(150, 255, 120)
local u43 = Color3.fromRGB(20, 70, 10)
local LocalPlayer = Players.LocalPlayer
local u47 = Trove.new()
local u48 = false
local v1 = {}

local function heldTicket() -- Line: 37 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    if Character == nil then
        return nil
    end
    for i, j in Character:GetChildren() do
        if j:IsA("Tool") and j:GetAttribute("ConductorTicket") == true then
            return j
        end
    end
    return nil
end

local function gripFrame() -- Line: 50 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    if Character == nil then
        return nil
    end
    local RightGripAttachment = Character:FindFirstChild("RightGripAttachment", true)
    if RightGripAttachment ~= nil and RightGripAttachment:IsA("Attachment") then
        return RightGripAttachment.WorldCFrame
    end
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart ~= nil and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart.CFrame * CFrame.new(1, 0, -1)
    end
    return nil
end

local function buildTicket() -- Line: 66 -- upvalues: ReplicatedStorage (val)
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local GhostDogQuest = Assets and Assets:FindFirstChild("GhostDogQuest")
    local v1 = GhostDogQuest and GhostDogQuest:FindFirstChild("Ticket")
    if v1 ~= nil and v1:IsA("Model") then
        local BoundingBox_2
        local v2 = v1:Clone()
        v2.Name = "ConductorTicketFlight"
        for i, j in v2:GetDescendants() do
            if j:IsA("BasePart") then
                j.Anchored = true
                j.CanCollide = false
                j.CanTouch = false
                j.CanQuery = false
                j.CastShadow = false
            elseif j:IsA("LuaSourceContainer") then
                j:Destroy()
            end
        end
        _, BoundingBox_2 = v2:GetBoundingBox()
        local v3 = math.max(BoundingBox_2.X, BoundingBox_2.Y, BoundingBox_2.Z)
        if v3 > 0 then
            v2:ScaleTo((v2:GetScale()) * 1.8 / v3)
        end
        return v2
    end
    return nil
end

local function bezier(a1, a2, a3, a4) -- Line: 94 -- types: a1: vector, a2: vector, a3: vector, a4: number
    local v1 = 1 - a4
    return a1 * (v1 * v1) + a2 * (v1 * 2 * a4) + a3 * (a4 * a4)
end

local function ease(a1) -- Line: 99 -- types: a1: number
    return a1 * a1 * (3 - a1 * 2)
end

local function fly(a1, a2, a3, a4, a5) -- Line: 103
    -- upvalues: buildTicket (val), u47 (val), Workspace (val), RunService (val)
    local u6 = buildTicket()
    if u6 == nil then
        return
    end
    local u10 = u47:Extend()
    u10:Add(u6)
    local Scale = u6:GetScale()
    local u18 = 0

    local function step(a1_2) -- Line: 119
        -- upvalues: u18 (ref), a4 (val), a3 (val), u47 (upval), u10 (val), a1 (val), a5 (val), u6 (val), Scale (val)
        -- upvalues: a2 (val)
        u18 = u18 + a1_2
        local v1 = math.clamp(u18 / a4, 0, 1)
        local v2 = a3()
        if v2 ~= nil and not (v1 >= 1) then
            local v3 = v1 * v1 * (3 - v1 * 2)
            local v4 = math.sin(v1 * 3.141592653589793)
            local v5 = math.clamp((v2 - a1).Magnitude * 0.35, 3, 12)
            v5 = (a1 + v2) / 2 + Vector3.new(0, v5, 0)
            u6:ScaleTo(Scale * (math.max((if not a5 then v3 * 0.65 + 0.35 else 1 - v3 * 0.65) + v4 * 0.3, 0.05)))
            local v6 = u6
            local new = CFrame.new
            local v7 = a1
            v1 = 1 - v3
            v6:PivotTo((new(v7 * (v1 * v1) + v5 * (v1 * 2 * v3) + v2 * (v3 * v3))) * a2 * (CFrame.Angles(v4 * 0.6, v3 * 3.141592653589793 * 2 * 2, 0)))
            return true
        end
        u47:Remove(u10)
        return false
    end

    if not step(0) then
        return
    end
    u6.Parent = Workspace
    u10:Connect(RunService.RenderStepped, step)
end

local function secondsOf(a1) -- Line: 148 -- types: a1: table
    local Seconds = a1.Seconds
    if type(Seconds) == "number" and Seconds > 0 and Seconds <= 3 then
        return Seconds
    end
    return 0.65
end

local function notify(a1) -- Line: 157 -- upvalues: Toast (val), u38 (val), u43 (val) -- types: a1: string
    Toast.Show({
        Lane = "Feed",
        Seconds = 3,
        Text = a1,
        Color = u38,
        StrokeColor = u43,
    })
end

local function setHidden(a1, a2) -- Line: 167 -- types: a1: userdata, a2: boolean
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.LocalTransparencyModifier = if not a2 then 0 else 1
        end
    end
end

local function hideUntilStowed(a1) -- Line: 175 -- upvalues: LocalPlayer (val) -- types: a1: userdata
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            j.LocalTransparencyModifier = 1
        end
    end
    local u13 = nil
    a1.AncestryChanged:Connect(function() -- Line: 178 -- upvalues: a1 (val), LocalPlayer (upval), u13 (ref)
        if a1.Parent == LocalPlayer.Character then
            return
        end
        if u13 ~= nil then
            u13:Disconnect()
        end
        for i, j in a1:GetDescendants() do
            if j:IsA("BasePart") then
                j.LocalTransparencyModifier = 0
            end
        end
    end)
end

local function onTicketIn(a1) -- Line: 189
    -- upvalues: heldTicket (val), LocalPlayer (val), gripFrame (val), fly (val), Toast (val), u38 (val), u43 (val)
    local u2 = heldTicket()
    if u2 ~= nil then
        for i, j in u2:GetDescendants() do
            if j:IsA("BasePart") then
                j.LocalTransparencyModifier = 1
            end
        end
        local u15 = nil
        u2.AncestryChanged:Connect(function() -- Line: 178 -- upvalues: u2 (val), LocalPlayer (upval), u15 (ref)
            if u2.Parent == LocalPlayer.Character then
                return
            end
            if u15 ~= nil then
                u15:Disconnect()
            end
            for i, j in u2:GetDescendants() do
                if j:IsA("BasePart") then
                    j.LocalTransparencyModifier = 0
                end
            end
        end)
    end
    local From_2 = gripFrame()
    if From_2 == nil and typeof(a1.From) == "CFrame" then
        From_2 = a1.From
    end
    local To = a1.To
    if From_2 ~= nil and typeof(To) == "Vector3" and (To - From_2.Position).Magnitude <= 160 then
        local Position = From_2.Position
        local Rotation = From_2.Rotation

        local function v1() -- Line: 204 -- upvalues: To (val)
            return To
        end

        local Seconds = a1.Seconds
        fly(
            Position,
            Rotation,
            v1,
            if type(Seconds) ~= "number" then 0.65 else if not (Seconds > 0) then 0.65 else if not (Seconds <= 3) then 0.65 else Seconds,
            true
        )
    end
    Toast.Show({
        Lane = "Feed",
        Text = "Pass punched! All aboard!",
        Seconds = 3,
        Color = u38,
        StrokeColor = u43,
    })
end

local function onTicketOut(a1) -- Line: 211
    -- upvalues: gripFrame (val), fly (val), Toast (val), u38 (val), u43 (val)
    local From = a1.From
    local v1 = gripFrame()
    if v1 ~= nil and typeof(From) == "Vector3" and (v1.Position - From).Magnitude <= 160 then
        local Rotation = v1.Rotation

        local function v2() -- Line: 219 -- upvalues: gripFrame (upval)
            local v1 = gripFrame()
            if v1 ~= nil then
                return v1.Position
            end
            return nil
        end

        local Seconds = a1.Seconds
        fly(
            From,
            Rotation,
            v2,
            if type(Seconds) ~= "number" then 0.65 else if not (Seconds > 0) then 0.65 else if not (Seconds <= 3) then 0.65 else Seconds,
            false
        )
    end
    Toast.Show({
        Lane = "Feed",
        Text = "Boarding cancelled. Pass returned!",
        Seconds = 3,
        Color = u38,
        StrokeColor = u43,
    })
end

function v1.Start() -- Line: 231 -- upvalues: u48 (ref), TrainEvent (val), onTicketIn (val), onTicketOut (val)
    if u48 then
        return
    end
    u48 = true
    TrainEvent.Travel.OnClientEvent:Connect(function(a1, a2) -- Line: 236 -- upvalues: onTicketIn (upval), onTicketOut (upval)
        local v1 = if typeof(a2) ~= "table" then {} else a2
        if a1 == "TicketIn" then
            onTicketIn(v1)
            return
        end
        if a1 == "TicketOut" then
            onTicketOut(v1)
        end
    end)
end

return v1