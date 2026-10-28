-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.Drops
-- Decompile time: 8.07 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local HalloweenTokens = require(ReplicatedStorage.Data.Currency.Configs.HalloweenTokens)
local Notifications = require(ReplicatedStorage.Client.Notifications)
local ScramblePickupMotion = require(ReplicatedStorage.Shared.Util.ScramblePickupMotion)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local u44 = require(script.Parent.Kit)
local DisplayName = HalloweenTokens.DisplayName
local LocalPlayer = Players.LocalPlayer

local function now() -- Line: 54 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow()
end

local function rootOf(a1) -- Line: 58 -- types: a1: userdata?
    local Character = a1 and a1.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart
    end
    return nil
end

local function build(a1) -- Line: 64 -- upvalues: u44 (val) -- types: a1: userdata
    local v1 = u44.Part({
        Name = "PumpkinPickup",
        Size = Vector3.new(2.1600000858306885, 1.7999999523162842, 2.1600000858306885),
        Shape = Enum.PartType.Ball,
        Material = Enum.Material.SmoothPlastic,
        Color = u44.Orange,
    })
    local v2 = u44.Part({
        Name = "Stem",
        Size = Vector3.new(0.30000001192092896, 0.6000000238418579, 0.30000001192092896),
        Material = Enum.Material.SmoothPlastic,
        Color = Color3.fromRGB(70, 130, 30),
        CFrame = v1.CFrame * CFrame.new(0, 1.1, 0),
    })
    local WeldConstraint = Instance.new("WeldConstraint")
    WeldConstraint.Part0 = v1
    WeldConstraint.Part1 = v2
    WeldConstraint.Parent = v2
    v2.Anchored = false
    v2.Parent = v1
    v1.Parent = a1
    return v1
end

local function valid(a1) -- Line: 89
    local v1 = false
    if type(a1) == "table" then
        v1 = false
        if type(a1.Id) == "string" then
            v1 = false
            if type(a1.OwnerUserId) == "number" then
                v1 = false
                if type(a1.Amount) == "number" then
                    v1 = false
                    if typeof(a1.Origin) == "Vector3" then
                        v1 = false
                        if typeof(a1.Position) == "Vector3" then
                            v1 = false
                            if type(a1.CreatedAt) == "number" then
                                v1 = false
                                if type(a1.CollectAfter) == "number" then
                                    v1 = false
                                    if type(a1.ExpiresAt) == "number" then
                                        v1 = type(a1.Radius) == "number"
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return v1
end

local u51 = {}
u51.__index = u51

function u51.new(a1) -- Line: 105 -- upvalues: u44 (val), u51 (val), Remotes (val), RunService (val)
    local Folder = Instance.new("Folder")
    Folder.Name = "PumpkinPickups"
    Folder.Parent = u44.Debris()
    a1:Add(Folder)
    local v1 = {NextSend = 0, Folder = Folder, Drops = {}, Pending = {}}
    local u17 = setmetatable(v1, u51)
    a1:Connect(Remotes.PumpkinBoss.Drops.OnClientEvent, function(a1) -- Line: 118 -- upvalues: u17 (val)
        u17:Add(a1)
    end)
    a1:Connect(Remotes.PumpkinBoss.RemoveDrops.OnClientEvent, function(a1) -- Line: 121 -- upvalues: u17 (val)
        u17:Remove(a1)
    end)
    a1:Connect(RunService.RenderStepped, function() -- Line: 124 -- upvalues: u17 (val)
        u17:Step()
    end)
    return u17
end

function u51:Add(a2) -- Line: 131 -- upvalues: valid (val), build (val)
    local v1
    if type(a2) ~= "table" then
        return
    end
    local v2 = nil
    local v3 = nil
    local v4 = self
    for i, j in a2, v2, v3 do
        if valid(j) and v4.Drops[j.Id] == nil then
            v1 = {
                Id = j.Id,
                OwnerUserId = j.OwnerUserId,
                Amount = j.Amount,
                Origin = j.Origin,
                Position = j.Position,
                CreatedAt = j.CreatedAt,
                MagnetAt = if type(j.MagnetAt) ~= "number" then nil else j.MagnetAt,
                CollectAfter = j.CollectAfter,
                ExpiresAt = j.ExpiresAt,
                Radius = j.Radius,
                Part = build(v4.Folder),
            }
            v1.Part.CFrame = CFrame.new(v1.Origin)
            v4.Drops[v1.Id] = v1
        end
    end
end

function u51:Remove(a2) -- Line: 158 -- upvalues: LocalPlayer (val), u44 (val)
    local v1
    if type(a2) ~= "table" then
        return
    end
    local v2 = nil
    local v3 = nil
    local v4 = self
    for i, j in a2, v2, v3 do
        v1 = if type(j) ~= "string" then nil else v4.Drops[j]
        if v1 then
            if v1.OwnerUserId == LocalPlayer.UserId and v1.RequestedAt then
                u44.Sound("Pickup", nil, 0.5, 1 + math.random() * 0.15)
            end
            v1.Part:Destroy()
            v4.Drops[j] = nil
        end
    end
end

function u51:Request(a2, a3) -- Line: 175 -- types: a2: table, a3: number
    if a2.RequestedAt and a3 - a2.RequestedAt < 2 then
        return
    end
    a2.RequestedAt = a3
    table.insert(self.Pending, a2.Id)
end

function u51:Flush(a2) -- Line: 183 -- upvalues: Remotes (val) -- types: a2: number
    if #self.Pending ~= 0 and not (a2 < self.NextSend) then
        self.NextSend = a2 + 0.2
        local v1 = {}
        while #v1 < 8 do
            if not (#self.Pending > 0) then
                break
            end
            table.insert(v1, (table.remove(self.Pending, 1)))
        end
        Remotes.PumpkinBoss.Collect:FireServer(v1)
        return
    end
end

function u51:Step() -- Line: 196
    -- upvalues: Workspace (val), LocalPlayer (val), ScramblePickupMotion (val), Players (val)
    local Character_2, HumanoidRootPart_2, MagnetAt, PlayerByUserId, v1, v2, v3, v4, v5, v6
    local ServerTimeNow = Workspace:GetServerTimeNow()
    local v7 = LocalPlayer
    local Character = v7 and v7.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local v8 = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart
    v7 = CFrame.Angles(0, os.clock() * 2.5, 0)
    local v9 = nil
    local v10 = nil
    local v11 = self
    for i, j in self.Drops, v9, v10 do
        if not (j.ExpiresAt < ServerTimeNow) then
            v6 = j.OwnerUserId == LocalPlayer.UserId
            v1 = ServerTimeNow - j.CreatedAt
            v2 = ScramblePickupMotion.GroundPosition(j.Origin, j.Position, v1)
            MagnetAt = j.MagnetAt
            if MagnetAt and MagnetAt <= ServerTimeNow then
                PlayerByUserId = Players:GetPlayerByUserId(j.OwnerUserId)
                Character_2 = PlayerByUserId and PlayerByUserId.Character
                HumanoidRootPart_2 = Character_2 and Character_2:FindFirstChild("HumanoidRootPart")
                v4 = if not HumanoidRootPart_2 then nil else if not HumanoidRootPart_2:IsA("BasePart") then nil else HumanoidRootPart_2
                if v4 then
                    v3 = (ServerTimeNow - MagnetAt) / ScramblePickupMotion.MagnetSeconds
                    v2 = ScramblePickupMotion.MagnetPosition(j.Position, v4.Position, v3)
                    if v3 >= 1 then
                        j.Part.Transparency = 1
                    end
                end
            end
            v3 = false
            if v8 ~= nil then
                v3 = 300 < (v2 - v8.Position).Magnitude
            end
            v5 = if not v3 then 0 else 1
            j.Part.LocalTransparencyModifier = v5
            j.Part.CFrame = CFrame.new(v2) * v7
            if v6 and v8 and j.CollectAfter <= ServerTimeNow then
                if MagnetAt or (v8.Position - j.Position).Magnitude <= j.Radius then
                    v11:Request(j, ServerTimeNow)
                end
            end
        else
            j.Part:Destroy()
            v11.Drops[i] = nil
        end
    end
    v11:Flush(ServerTimeNow)
end

function u51.ShowCurrency(a1) -- Line: 238
    -- upvalues: Notifications (val), DisplayName (val), u44 (val)
    Notifications.Toast.Show({Lane = "Feed", Seconds = 1.6, Text = ("+%* %*"):format(a1, DisplayName)})
    u44.Sound("Pickup", nil, 0.6, 1.1)
end

return u51