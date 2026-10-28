-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.PumpkinBoss.Transition
-- Decompile time: 5.59 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local u29 = require(script.Parent.Parent.Transition)
local u34 = Color3.fromRGB(20, 8, 0)
local u35 = {}
u35.Core = Color3.fromRGB(196, 84, 10)
u35.Edge = Color3.fromRGB(46, 16, 2)
u35.Shade = Color3.fromRGB(255, 170, 70)
u35.Embers = {
    Color3.fromRGB(255, 200, 110),
    Color3.fromRGB(255, 140, 30),
    (Color3.fromRGB(255, 230, 170)),
}
u35.Veil = Color3.fromRGB(46, 16, 2)
u35.VeilTint = ColorSequence.new(Color3.fromRGB(214, 100, 18), Color3.new(1, 1, 1))
u35.PuffTint = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(190, 150, 120))
local LocalPlayer = Players.LocalPlayer
local u97 = nil
local u98 = nil
local u99 = nil
local u100 = 0
local u101 = false
local u102 = nil
local u103 = false
local u104 = false

local function ensureGui() -- Line: 59 -- upvalues: u97 (ref), u98 (ref), u34 (val), LocalPlayer (val)
    if u97 and u97.Parent and u98 then
        return u98
    end
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PumpkinTransition"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 1000
    ScreenGui.Enabled = false
    local Frame = Instance.new("Frame")
    Frame.Name = "Cover"
    Frame.Size = UDim2.fromScale(1, 1)
    Frame.BackgroundColor3 = u34
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    u97 = ScreenGui
    u98 = Frame
    return Frame
end

local function fadeTo(a1, a2, a3) -- Line: 85
    -- upvalues: ensureGui (val), u99 (ref), u97 (ref), TweenService (val)
    local v1 = ensureGui()
    if u99 then
        u99:Cancel()
    end
    u97.Enabled = true
    local u23 = TweenService:Create(v1, TweenInfo.new(a2), {BackgroundTransparency = a1})
    u99 = u23
    u23.Completed:Connect(function(a1) -- Line: 95 -- upvalues: u99 (upval), u23 (val), a3 (val)
        if a1 == Enum.PlaybackState.Completed and u99 == u23 and a3 then
            a3()
        end
    end)
    u23:Play()
end

local function rootPosition() -- Line: 103 -- upvalues: Player (val), LocalPlayer (val)
    local v1 = Player.FindRootPart(LocalPlayer)
    if v1 then
        return v1.Position
    end
    return nil
end

local u108 = {}

function u108.Cover(a1, a2, a3) -- Line: 110
    -- upvalues: u100 (ref), u102 (ref), Player (val), LocalPlayer (val), u101 (ref), u108 (val), u99 (ref)
    -- upvalues: ensureGui (val), u97 (ref), fadeTo (val)
    u100 = u100 + 1
    local u5 = u100
    local v1 = Player.FindRootPart(LocalPlayer)
    u102 = if not v1 then nil else v1.Position
    u101 = true
    task.delay(math.max(a2 or 0, 5), function() -- Line: 116 -- upvalues: u100 (upval), u5 (val), u101 (upval), u108 (upval)
        if u100 == u5 and u101 then
            u108.Reveal()
        end
    end)
    if not a1 then
        fadeTo(0, a3 or 0.18)
        return
    end
    if u99 then
        u99:Cancel()
        u99 = nil
    end
    ensureGui().BackgroundTransparency = 0
    u97.Enabled = true
end

function u108.Reveal(a1) -- Line: 137 -- upvalues: u101 (ref), fadeTo (val), u97 (ref) -- types: a1: number?
    if not u101 then
        return
    end
    u101 = false
    fadeTo(1, a1 or 0.3, function() -- Line: 143 -- upvalues: u97 (upval), u101 (upval)
        if u97 and not u101 then
            u97.Enabled = false
        end
    end)
end

function u108.RevealAfterMove() -- Line: 150
    -- upvalues: u100 (ref), u102 (ref), Player (val), LocalPlayer (val), u108 (val)
    local u0 = u100
    local u1 = u102
    local u3 = os.clock()
    task.spawn(function() -- Line: 155
        -- upvalues: u3 (val), u100 (upval), u0 (val), Player (upval), LocalPlayer (upval), u1 (val), u108 (upval)
        local Position, v1
        while true do
            if not (os.clock() - u3 < 0.75) then
                break
            end
            if u100 ~= u0 then
                return
            end
            v1 = Player.FindRootPart(LocalPlayer)
            Position = if not v1 then nil else v1.Position
            if u1 == nil then
                break
            end
            if Position and 12 < (Position - u1).Magnitude then
                break
            end
            task.wait()
        end
        task.wait(0.08)
        if u100 == u0 then
            u108.Reveal()
        end
    end)
end

function u108.Listen() -- Line: 175 -- upvalues: u103 (ref), Remotes (val), u104 (ref), u29 (val), u35 (val), u108 (val)
    if u103 then
        return
    end
    u103 = true
    Remotes.PumpkinBoss.Transition.OnClientEvent:Connect(function(a1, a2, a3, a4) -- Line: 182 -- upvalues: u104 (upval), u29 (upval), u35 (upval), u108 (upval)
        local v1 = if type(a3) ~= "number" then nil else a3
        if a1 == "Cover" and a4 == "Clouds" then
            u104 = true
            u29.Cover(u35, (v1 or 0) + 8)
            return
        end
        if a1 == "Cover" then
            if u104 and u29.IsCovering() then
                return
            end
            u104 = false
            u108.Cover(a2 == true, v1)
            return
        end
        if a1 == "Reveal" then
            if u104 then
                u104 = false
                u29.RevealAfterMove()
                return
            end
            u108.RevealAfterMove()
        end
    end)
end

return u108