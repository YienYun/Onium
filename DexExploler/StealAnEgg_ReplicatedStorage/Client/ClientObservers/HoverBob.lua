-- Script path: ReplicatedStorage.Client.ClientObservers.HoverBob
-- Decompile time: 2.00 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ObserveUITag = require(ReplicatedStorage.Client.ObserveUITag)
require(ReplicatedStorage.Packages.Trove)
local Sine = Enum.EasingStyle.Sine

local function GetBasePosition(a1) -- Line: 21 -- types: a1: userdata
    local Attribute = a1:GetAttribute("HoverBobBasePosition")
    if typeof(Attribute) == "UDim2" then
        return Attribute
    end
    a1:SetAttribute("HoverBobBasePosition", a1.Position)
    return a1.Position
end

local function StartHover(a1, a2) -- Line: 30 -- upvalues: TweenService (val), Sine (val) -- types: a1: userdata
    local Position
    local Attribute = a1:GetAttribute("HoverBobBasePosition")
    if typeof(Attribute) ~= "UDim2" then
        a1:SetAttribute("HoverBobBasePosition", a1.Position)
        Position = a1.Position
    else
        Position = Attribute
    end
    local u16 = {}
    local u17 = true
    a2:Add(function() -- Line: 35 -- upvalues: u17 (ref), u16 (val), a1 (val), Position (val)
        u17 = false
        for i, j in u16 do
            j:Cancel()
            j:Destroy()
        end
        a1.Position = Position
    end)
    local v1 = TweenService:Create(a1, TweenInfo.new(0.7, Sine, Enum.EasingDirection.Out), {Position = Position - UDim2.fromOffset(0, 6)})
    table.insert(u16, v1)
    a2:Connect(v1.Completed, function(a1_2) -- Line: 51
        -- upvalues: u17 (ref), TweenService (upval), a1 (val), Sine (upval), Position (val), u16 (val)
        if u17 and a1_2 == Enum.PlaybackState.Completed then
            local v1 = TweenService:Create(
                a1,
                TweenInfo.new(1.4, Sine, Enum.EasingDirection.InOut, -1, true),
                {Position = Position + UDim2.fromOffset(0, 6)}
            )
            table.insert(u16, v1)
            v1:Play()
            return
        end
    end)
    v1:Play()
end

ObserveUITag("HoverBob", function(a1, a2) -- Line: 66 -- upvalues: StartHover (val) -- types: a1: userdata
    if a1:IsA("GuiObject") then
        StartHover(a1, a2)
        return
    end
    warn((("HoverBob tag on %* needs a GuiObject"):format((a1:GetFullName()))))
end)
return nil