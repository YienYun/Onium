-- Script path: ReplicatedStorage.Client.ClientObservers.PlaySprite
-- Decompile time: 3.65 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ObserveUITag = require(ReplicatedStorage.Client.ObserveUITag)
require(ReplicatedStorage.Packages.Trove)
local u18 = {}
local u19 = {}
local u20 = nil

local function DrawFrame(a1, a2) -- Line: 34 -- types: a1: table, a2: number
    local Image = a1.Image
    local ImageRectSize = Image.ImageRectSize
    Image.ImageRectOffset = Vector2.new(ImageRectSize.X * (a2 % a1.Columns), ImageRectSize.Y * (a2 // a1.Columns))
end

local function StepSprites(a1) -- Line: 41 -- upvalues: u18 (val), u20 (ref) -- types: a1: number
    local Image, ImageRectSize, NextFrame, NextFrame_2
    for i in u18 do
        i.Remaining = i.Remaining - a1
        if not (0 < i.Remaining) then
            NextFrame = i.NextFrame
            if not (i.FrameCount <= NextFrame) then
                NextFrame_2 = i.NextFrame
                Image = i.Image
                ImageRectSize = Image.ImageRectSize
                Image.ImageRectOffset = Vector2.new(ImageRectSize.X * (NextFrame_2 % i.Columns), ImageRectSize.Y * (NextFrame_2 // i.Columns))
                i.NextFrame = i.NextFrame + 1
                i.Remaining = i.SecondsPerFrame
            elseif i.Loops then
                i.NextFrame = 0
                i.Remaining = 0
            else
                i.IsFinished = true
                u18[i] = nil
            end
        end
    end
    if next(u18) == nil and u20 ~= nil then
        u20:Disconnect()
        u20 = nil
    end
end

local function CreateSprite(a1) -- Line: 69 -- types: a1: userdata
    local Attribute = a1:GetAttribute("Cells")
    local Attribute_2 = a1:GetAttribute("FPS")
    if typeof(Attribute) == "Vector2"
        and not (Attribute.X < 1)
        and not (Attribute.Y < 1)
        and Attribute.X % 1 == 0
        and Attribute.Y % 1 == 0 then
        if type(Attribute_2) == "number" and Attribute_2 > 0 and Attribute_2 ~= (1 / 0) then
            return {
                NextFrame = 0,
                Remaining = 0,
                IsFinished = false,
                Image = a1,
                Columns = Attribute.X,
                FrameCount = Attribute.X * Attribute.Y,
                SecondsPerFrame = 1 / Attribute_2,
                Loops = a1:GetAttribute("Loop") ~= false,
            }
        end
        warn((("%* needs a positive FPS to play its sprite sheet"):format((a1:GetFullName()))))
        return nil
    end
    warn((("%* needs a whole number Cells grid to play its sprite sheet"):format((a1:GetFullName()))))
    return nil
end

local function GetSprite(a1, a2) -- Line: 98
    -- upvalues: u19 (val), CreateSprite (val), u18 (val)
    local v1 = u19[a1]
    if v1 ~= nil then
        return v1
    end
    local u6 = CreateSprite(a1)
    if u6 == nil then
        return nil
    end
    u19[a1] = u6
    a2:Add(function() -- Line: 108 -- upvalues: u19 (upval), a1 (val), u18 (upval), u6 (val)
        u19[a1] = nil
        u18[u6] = nil
    end)
    return u6
end

local function StartSprite(a1, a2, a3) -- Line: 115
    -- upvalues: u19 (val), CreateSprite (val), u18 (val), u20 (ref), RunService (val), StepSprites (val)
    local u15
    local v1 = u19[a1]
    if v1 == nil then
        local u8 = CreateSprite(a1)
        if u8 ~= nil then
            u19[a1] = u8
            a3:Add(function() -- Line: 108 -- upvalues: u19 (upval), a1 (val), u18 (upval), u8 (val)
                u19[a1] = nil
                u18[u8] = nil
            end)
            u15 = u8
        else
            u15 = nil
        end
    else
        u15 = v1
    end
    if u15 ~= nil and not u15.IsFinished then
        u18[u15] = true
        if u20 == nil then
            RunService.Heartbeat:Connect(StepSprites)
        end
        a2:Add(function() -- Line: 124 -- upvalues: u18 (upval), u15 (val)
            u18[u15] = nil
        end)
        return
    end
end

ObserveUITag("PlaySprite", function(a1, a2, a3) -- Line: 129 -- upvalues: StartSprite (val) -- types: a1: userdata
    if a1:IsA("ImageLabel") then
        StartSprite(a1, a2, a3)
        return
    end
    warn((("PlaySprite tag on %* needs an ImageLabel"):format((a1:GetFullName()))))
end)
return nil