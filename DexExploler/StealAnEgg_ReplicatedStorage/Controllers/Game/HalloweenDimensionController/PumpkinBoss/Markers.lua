-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.Markers
-- Decompile time: 3.08 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local PumpkinBossState = require(ReplicatedStorage.Shared.Util.PumpkinBossState)
local u30 = require(script.Parent.Kit)
local TrapAttributes = PumpkinBossState.TrapAttributes

local function build(a1) -- Line: 25 -- upvalues: u30 (val) -- types: a1: userdata
    local BillboardGui = Instance.new("BillboardGui")
    BillboardGui.Name = "PumpkinTrapMarker"
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Size = UDim2.fromOffset(48, 48)
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
    BillboardGui.MaxDistance = 250
    BillboardGui.Adornee = a1
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.fromScale(1, 1)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Font = Enum.Font.FredokaOne
    TextLabel.Text = "!"
    TextLabel.TextScaled = true
    TextLabel.TextColor3 = u30.Red
    TextLabel.TextStrokeTransparency = 0
    TextLabel.Parent = BillboardGui
    BillboardGui.Parent = u30.Debris()
    return BillboardGui
end

return {
    Start = function(a1) -- Line: 50
        -- upvalues: RunService (val), Workspace (val), Players (val), TrapAttributes (val), build (val)
        local u1 = {}
        local u2 = 0
        a1:Add(function() -- Line: 54 -- upvalues: u1 (val)
            for i, j in u1 do
                j:Destroy()
            end
            table.clear(u1)
        end)
        a1:Connect(RunService.Heartbeat, function() -- Line: 61
            -- upvalues: u1 (val), u2 (ref), Workspace (upval), Players (upval), TrapAttributes (upval), build (upval)
            local Attribute, Character, Head, TrapEnds, v1, v2, v3
            local v4 = os.clock()
            for i, j in u1 do
                v2 = math.sin(v4 * 6) * 0.4 + 3
                j.StudsOffsetWorldSpace = Vector3.new(0, v2, 0)
            end
            if v4 < u2 then
                return
            end
            u2 = v4 + 0.2
            local ServerTimeNow = Workspace:GetServerTimeNow()
            for k, n in Players:GetPlayers() do
                TrapEnds = TrapAttributes.TrapEnds
                Attribute = n:GetAttribute(TrapEnds)
                Character = n.Character
                Head = Character and Character:FindFirstChild("Head")
                v3 = false
                if typeof(Attribute) == "number" then
                    v3 = false
                    if ServerTimeNow < Attribute then
                        v3 = false
                        if Character ~= nil then
                            v3 = false
                            if Character:GetAttribute(TrapAttributes.Trapped) == true then
                                v3 = false
                                if Head ~= nil then
                                    v3 = Head:IsA("BasePart")
                                end
                            end
                        end
                    end
                end
                v1 = u1[n]
                if not v3 then
                    if not v3 and v1 then
                        v1:Destroy()
                        u1[n] = nil
                    end
                elseif not v1 or v1.Adornee ~= Head then
                    if v1 then
                        v1:Destroy()
                    end
                    u1[n] = (build(Head))
                elseif not v3 and v1 then
                    v1:Destroy()
                    u1[n] = nil
                end
            end
            for m, i5 in u1 do
                if m.Parent ~= Players then
                    i5:Destroy()
                    u1[m] = nil
                end
            end
        end)
    end,
}