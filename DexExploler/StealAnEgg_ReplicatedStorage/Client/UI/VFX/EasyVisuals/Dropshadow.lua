-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Dropshadow
-- Decompile time: 4.48 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local t = require(ReplicatedStorage.Packages.t)
local Heartbeat = RunService.Heartbeat
local u17 = Color3.new()
local u23 = UDim2.new(1, 0, 1, 0)
local u27 = Vector2.new(-4, 4)
local u29 = Vector2.new()
local u30 = {TextLabel = true, TextBox = true, TextButton = true}
local u31 = {}
u31.__index = u31
local u41 = t.strict(t.union(t.instanceIsA("GuiObject"), t.instanceIsA("UIStroke")))
local u44 = t.strict(t.number)
local u47 = t.strict(t.Color3)
local u50 = t.strict(t.Vector2)

local function aim(a1, a2, a3) -- Line: 53 -- types: a1: table, a3: number
    a1.goal = a2
    a1.response = math.clamp(a3, 0, 1)
end

local function stepLerpable(a1) -- Line: 60 -- types: a1: table
    a1.now = a1.now:Lerp(a1.goal, a1.response)
    return a1.now
end

local function stepNumber(a1) -- Line: 65 -- types: a1: table
    a1.now = a1.now + (a1.goal - a1.now) * a1.response
    return a1.now
end

local function asPlacement(a1) -- Line: 70 -- types: a1: userdata
    return UDim2.new(0, a1.X, 0, a1.Y)
end

local function release(a1) -- Line: 72
    a1.driver:Disconnect()
    if a1.shadow then
        a1.shadow:Destroy()
        a1.shadow = nil
    end
end

local function advance(a1) -- Line: 81
    local tint = a1.tint
    tint.now = tint.now:Lerp(tint.goal, tint.response)
    local now = tint.now
    local offset = a1.offset
    offset.now = offset.now:Lerp(offset.goal, offset.response)
    local now_4 = offset.now
    local v1 = UDim2.new(0, now_4.X, 0, now_4.Y)
    local alpha = a1.alpha
    alpha.now = alpha.now + (alpha.goal - alpha.now) * alpha.response
    local now_6 = alpha.now
    local shadow = a1.shadow
    shadow.Position = v1
    if a1.isTextHost then
        shadow.Text = a1.host.Text
        shadow.TextTransparency = now_6
        shadow.TextColor3 = now
    end
    shadow.ZIndex = a1.host.ZIndex - 1
end

function u31.new(a1, a2, a3, a4) -- Line: 99
    -- upvalues: u41 (val), u47 (val), u44 (val), u50 (val), u30 (val), u17 (val), u27 (val), u29 (val), u31 (val)
    -- upvalues: u23 (val), Heartbeat (val), advance (val)
    u41(a1)
    if a2 then
        u47(a2)
    end
    if a3 then
        u44(a3)
    end
    if a4 then
        u50(a4)
    end
    local v1 = {
        isPaused = false,
        host = a1,
        shadow = a1:Clone(),
        isTextHost = u30[a1.ClassName] == true,
        tint = {response = 1, now = a2 or u17, goal = a2 or u17},
        alpha = {response = 1, now = a3 or 0, goal = a3 or 0},
        offset = {response = 1, now = a4 or u27, goal = a4 or u29},
    }
    local u75 = setmetatable(v1, u31)
    local shadow = u75.shadow
    shadow.Size = u23
    shadow:ClearAllChildren()
    local now = u75.offset.now
    shadow.Position = UDim2.new(0, now.X, 0, now.Y)
    if u75.isTextHost then
        shadow.TextColor3 = u75.tint.now
    end
    shadow.Parent = u75.host
    u75.driver = Heartbeat:Connect(function() -- Line: 145 -- upvalues: u75 (val), advance (upval)
        debug.profilebegin("EasyVisuals/shadow")
        if u75.isPaused then
            return
        end
        if u75.host and u75.host.Parent ~= nil then
            advance(u75)
            debug.profileend()
            return
        end
        local v1 = u75
        v1.driver:Disconnect()
        if v1.shadow then
            v1.shadow:Destroy()
            v1.shadow = nil
        end
    end)
    return u75
end

function u31:Destroy() -- Line: 165
    self.driver:Disconnect()
    if self.shadow then
        self.shadow:Destroy()
        self.shadow = nil
    end
end

function u31.Suspend(a1) -- Line: 167
    a1.isPaused = true
end

function u31.Wake(a1) -- Line: 169
    a1.isPaused = false
end

function u31.EaseOffset(a1, a2, a3) -- Line: 171 -- upvalues: u50 (val), u44 (val) -- types: a2: userdata, a3: number
    u50(a2)
    u44(a3)
    local offset = a1.offset
    offset.goal = a2
    offset.response = math.clamp(a3, 0, 1)
end

function u31.EaseAlpha(a1, a2, a3) -- Line: 177 -- upvalues: u44 (val) -- types: a2: number, a3: number
    u44(a2)
    u44(a3)
    local alpha = a1.alpha
    alpha.goal = a2
    alpha.response = math.clamp(a3, 0, 1)
end

function u31.EaseTint(a1, a2, a3) -- Line: 183 -- upvalues: u47 (val), u44 (val) -- types: a2: UDim2, a3: number
    u47(a2)
    u44(a3)
    local tint = a1.tint
    tint.goal = a2
    tint.response = math.clamp(a3, 0, 1)
end

return table.freeze(u31)