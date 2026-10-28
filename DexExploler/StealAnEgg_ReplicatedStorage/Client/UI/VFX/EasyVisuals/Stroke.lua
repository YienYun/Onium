-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.Stroke
-- Decompile time: 4.77 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local t = require(ReplicatedStorage.Packages.t)
local Heartbeat = RunService.Heartbeat
local ScaledSize = Enum.StrokeSizingMode.ScaledSize
local u20 = Color3.new(1, 1, 1)
local u21 = {TextLabel = true, TextBox = true, TextButton = true}
local u22 = {}
u22.__index = u22
local u32 = t.strict(t.union(t.instanceIsA("GuiObject"), t.instanceIsA("UIStroke")))
local u35 = t.strict(t.number)
local u38 = t.strict(t.Color3)

local function track(a1) -- Line: 49
    return {response = 1, now = a1, goal = a1}
end

local function aim(a1, a2, a3) -- Line: 53 -- types: a1: table, a3: number
    a1.goal = a2
    a1.response = math.clamp(a3, 0, 1)
end

local function stepNumber(a1, a2) -- Line: 58 -- types: a1: table, a2: number
    a1.now = a1.now + (a1.goal - a1.now) * a1.response * a2
    return a1.now
end

local function stepColor(a1, a2) -- Line: 63 -- types: a1: table, a2: number
    a1.now = a1.now:Lerp(a1.goal, a1.response * a2)
    return a1.now
end

local function borrowOutline(a1) -- Line: 68 -- types: a1: userdata
    local UIStroke = a1:FindFirstChildWhichIsA("UIStroke")
    if UIStroke then
        return UIStroke
    end
    return Instance.new("UIStroke")
end

local function release(a1) -- Line: 76
    a1.driver:Disconnect()
    if a1.outline then
        a1.outline:Destroy()
        a1.outline = nil
    end
end

local function advance(a1, a2) -- Line: 85 -- upvalues: ScaledSize (val) -- types: a2: number
    local outline = a1.outline
    local tint = a1.tint
    tint.now = tint.now:Lerp(tint.goal, tint.response * a2)
    outline.Color = tint.now
    local alpha = a1.alpha
    alpha.now = alpha.now + (alpha.goal - alpha.now) * alpha.response * a2
    outline.Transparency = alpha.now
    local width = a1.width
    width.now = width.now + (width.goal - width.now) * width.response * a2
    local now_4 = width.now
    if outline.StrokeSizingMode ~= ScaledSize then
        outline.Thickness = now_4
    end
end

function u22.new(a1, a2, a3, a4) -- Line: 97
    -- upvalues: u32 (val), u35 (val), u38 (val), u21 (val), u20 (val), u22 (val), Heartbeat (val), ScaledSize (val)
    u32(a1)
    u35(a2)
    if a3 then
        u38(a3)
    end
    if a4 then
        u35(a4)
    end
    local v1 = {isPaused = false, host = a1}
    local UIStroke = a1:FindFirstChildWhichIsA("UIStroke")
    v1.outline = if not UIStroke then Instance.new("UIStroke") else UIStroke
    v1.isTextHost = u21[a1.ClassName] == true
    local v2 = a3 or u20
    v1.tint = {response = 1, now = v2, goal = v2}
    v2 = a4 or 0
    v1.alpha = {response = 1, now = v2, goal = v2}
    v1.width = {response = 1, now = a2, goal = a2}
    local u62 = setmetatable(v1, u22)
    u62.outline.Parent = u62.host
    u62.driver = Heartbeat:Connect(function(a1) -- Line: 128 -- upvalues: u62 (val), ScaledSize (upval) -- types: a1: number
        local v1
        debug.profilebegin("EasyVisuals/outline")
        if u62.isPaused then
            return
        end
        if u62.host and u62.host.Parent ~= nil then
            v1 = u62
            local outline = v1.outline
            local tint = v1.tint
            tint.now = tint.now:Lerp(tint.goal, tint.response * a1)
            outline.Color = tint.now
            local alpha = v1.alpha
            alpha.now = alpha.now + (alpha.goal - alpha.now) * alpha.response * a1
            outline.Transparency = alpha.now
            local width = v1.width
            width.now = width.now + (width.goal - width.now) * width.response * a1
            local now_4 = width.now
            if outline.StrokeSizingMode ~= ScaledSize then
                outline.Thickness = now_4
            end
            debug.profileend()
            return
        end
        v1 = u62
        v1.driver:Disconnect()
        if v1.outline then
            v1.outline:Destroy()
            v1.outline = nil
        end
    end)
    return u62
end

function u22:Destroy() -- Line: 148
    self.driver:Disconnect()
    if self.outline then
        self.outline:Destroy()
        self.outline = nil
    end
end

function u22.Suspend(a1) -- Line: 150
    a1.isPaused = true
end

function u22.Wake(a1) -- Line: 152
    a1.isPaused = false
end

function u22.EaseWidth(a1, a2, a3) -- Line: 154 -- upvalues: u35 (val) -- types: a2: number, a3: number
    u35(a2)
    u35(a3)
    local width = a1.width
    width.goal = a2
    width.response = math.clamp(a3, 0, 1)
end

function u22.EaseAlpha(a1, a2, a3) -- Line: 160 -- upvalues: u35 (val) -- types: a2: number, a3: number
    u35(a2)
    u35(a3)
    local alpha = a1.alpha
    alpha.goal = a2
    alpha.response = math.clamp(a3, 0, 1)
end

function u22.EaseTint(a1, a2, a3) -- Line: 166 -- upvalues: u38 (val), u35 (val) -- types: a2: userdata, a3: number
    u38(a2)
    u35(a3)
    local tint = a1.tint
    tint.goal = a2
    tint.response = math.clamp(a3, 0, 1)
end

return table.freeze(u22)