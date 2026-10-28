-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.BeanstalkEvent.WhaleHearts
-- Decompile time: 15.54 ms

local Debris = game:GetService("Debris")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local GUI = require(ReplicatedStorage.Client.GUI)
require(ReplicatedStorage.Packages.Trove)
local BeanstalkEvent = ReplicatedStorage.Assets.Sounds.BeanstalkEvent
local u50 = Color3.fromRGB(255, 60, 80)
local u55 = Color3.fromRGB(70, 70, 82)
local u60 = Color3.new(1, 1, 1)
local u61 = {}
local u62 = 0
local u63 = 0
local u64 = 0
local u65 = nil
local u66 = nil

local function card() -- Line: 53 -- upvalues: u65 (ref), GUI (val)
    if u65 then
        return u65
    end
    return GUI.BeanstalkEventUI().WhaleProgress
end

local function tween(a1, a2, a3, a4, a5) -- Line: 61
    -- upvalues: TweenService (val)
    local v1 = TweenService:Create(a1, TweenInfo.new(a2, a4 or Enum.EasingStyle.Quad, a5 or Enum.EasingDirection.Out), a3)
    v1:Play()
    return v1
end

local function scaleOf(a1) -- Line: 81 -- types: a1: userdata
    local UIScale = a1:FindFirstChildOfClass("UIScale")
    if not UIScale then
        UIScale = Instance.new("UIScale")
        UIScale.Parent = a1
    end
    return UIScale
end

local function play(a1, a2) -- Line: 90
    -- upvalues: u65 (ref), Audio (val), SoundService (val), u66 (ref), Debris (val)
    local v1
    if u65 then
        v1 = Audio.Play(a1, SoundService, {SoundGroup = "SFX", PlaybackSpeed = a2 or a1.PlaybackSpeed})
        if v1 and u66 then
            u66:Add(v1)
        end
        return
    end
    if a2 == nil then
        SoundService:PlayLocalSound(a1)
        return
    end
    v1 = a1:Clone()
    v1.PlaybackSpeed = a2
    v1.Parent = SoundService
    v1:Play()
    Debris:AddItem(v1, v1.TimeLength / a2 + 0.5)
end

local function setFull(a1, a2) -- Line: 109 -- upvalues: u50 (val), u55 (val) -- types: a1: userdata, a2: boolean
    a1.ImageColor3 = if not a2 then u55 else u50
    a1.ImageTransparency = if not a2 then 0.25 else 0
end

local function stopPulse() -- Line: 114 -- upvalues: u63 (ref), u61 (val)
    local UIScale
    u63 = u63 + 1
    for i, j in u61 do
        UIScale = j:FindFirstChildOfClass("UIScale")
        if UIScale then
            UIScale.Scale = 1
        end
    end
end

local function startPulse(a1) -- Line: 124
    -- upvalues: u63 (ref), GuiService (val), TweenService (val)
    u63 = u63 + 1
    local u3 = u63
    if GuiService.ReducedMotionEnabled then
        return
    end
    task.spawn(function() -- Line: 130 -- upvalues: u63 (upval), u3 (val), a1 (val), TweenService (upval)
        if u63 == u3 and a1.Parent ~= nil then
            local Back, Quad, new, new_2, v1
            local v2 = a1
            local v3 = v2:FindFirstChildOfClass("UIScale")
            if not v3 then
                v3 = Instance.new("UIScale")
                v3.Parent = v2
            end
            while u63 == u3 do
                if not a1.Parent then
                    break
                end
                Quad = Enum.EasingStyle.Quad
                v1 = TweenService
                new = TweenInfo.new
                v1:Create(v3, new(0.11200000000000002, Quad or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1.2}):Play()
                task.wait(0.11200000000000002)
                if u63 ~= u3 then
                    break
                end
                Back = Enum.EasingStyle.Back
                v1 = TweenService
                new_2 = TweenInfo.new
                v1:Create(v3, new_2(0.168, Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
                task.wait(0.388)
            end
            return
        end
    end)
end

local function shatter(a1) -- Line: 145
    -- upvalues: u65 (ref), GUI (val), u66 (ref), u60 (val), u50 (val), TweenService (val), Debris (val)
    local HeartsFx = (if not u65 then GUI.BeanstalkEventUI().WhaleProgress else u65).HeartsFx
    local HeartBreak = HeartsFx.HeartBreak
    local AbsolutePosition = HeartsFx.AbsolutePosition
    local AbsoluteSize = HeartsFx.AbsoluteSize
    if not (AbsoluteSize.X <= 0) and not (AbsoluteSize.Y <= 0) then
        local In, Position, Quad, Quad_3, v1, v2, v3, v4, v5, v6, v7, v8
        local v9 = HeartBreak:Clone()
        v9.Visible = true
        v9.AnchorPoint = Vector2.new(0.5, 0.5)
        local v10 = a1.AbsolutePosition + a1.AbsoluteSize * 0.5 - AbsolutePosition
        v9.Position = UDim2.fromScale(v10.X / AbsoluteSize.X, v10.Y / AbsoluteSize.Y)
        v9.Size = UDim2.fromScale(a1.AbsoluteSize.X / AbsoluteSize.X, a1.AbsoluteSize.Y / AbsoluteSize.Y)
        v9.Parent = HeartsFx
        if u66 then
            u66:Add(v9)
        end
        local v11 = {v9.Left, v9.Right}
        local v12 = nil
        local v13 = nil
        for i, j in v11, v12, v13 do
            v8 = if j ~= v9.Left then 1 else -1
            v7 = j:FindFirstChildOfClass("ImageLabel")
            v7.ImageColor3 = u60
            TweenService:Create(v7, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = u50}):Play()
            Position = j.Position
            v1 = UDim2.fromScale(Position.X.Scale + v8 * 0.55, Position.Y.Scale)
            v2 = {Position = v1, Rotation = v8 * 48}
            Quad = Enum.EasingStyle.Quad
            v5 = TweenInfo.new(0.65, Quad or Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(j, v5, v2):Play()
            v2 = TweenService
            v3 = TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            v4 = {
                Position = UDim2.fromScale(v1.X.Scale, Position.Y.Scale + 1.6),
            }
            local u157 = v2:Create(j, v3, v4)
            task.delay(0.1625, function() -- Line: 181 -- upvalues: j (val), u157 (val)
                if j.Parent then
                    u157:Play()
                end
            end)
            Quad_3 = Enum.EasingStyle.Quad
            In = Enum.EasingDirection.In
            v6 = TweenInfo.new(0.65, Quad_3 or Enum.EasingStyle.Quad, In or Enum.EasingDirection.Out)
            TweenService:Create(j, v6, {GroupTransparency = 1}):Play()
        end
        Debris:AddItem(v9, 0.8450000000000001)
        return
    end
end

return {
    Show = function(a1, a2, a3) -- Line: 199
        -- upvalues: u64 (ref), u65 (ref), u66 (ref), GUI (val), u63 (ref), u61 (val), u50 (val), TweenService (val)
        -- upvalues: u62 (ref)
        local UIScale, UIScale_2, v1, v2
        u64 = u64 + 1
        local u5 = u64
        u65 = a3
        u66 = a1
        local Hearts = (if not u65 then GUI.BeanstalkEventUI().WhaleProgress else u65).Hearts
        local Heart = Hearts.Heart
        Heart.Visible = false
        u63 = u63 + 1
        for i, j in u61 do
            UIScale_2 = j:FindFirstChildOfClass("UIScale")
            if UIScale_2 then
                UIScale_2.Scale = 1
            end
        end
        for k, n in u61 do
            n:Destroy()
        end
        table.clear(u61)
        for m = 1, a2 do
            local u50_2 = Heart:Clone()
            u50_2.Name = ("Heart%*"):format(m)
            u50_2.LayoutOrder = m
            u50_2.Visible = true
            u50_2.ImageColor3 = u50
            u50_2.ImageTransparency = 0
            UIScale = u50_2:FindFirstChildOfClass("UIScale")
            if not UIScale then
                UIScale = Instance.new("UIScale")
                UIScale.Parent = u50_2
            end
            UIScale.Scale = 0
            u50_2.Parent = Hearts
            table.insert(u61, u50_2)
            task.delay((m - 1) * 0.16 * 0.6, function() -- Line: 221 -- upvalues: u5 (val), u64 (upval), u50_2 (val), TweenService (upval)
                if u5 == u64 and u50_2.Parent ~= nil then
                    local v1 = u50_2
                    local v2 = v1:FindFirstChildOfClass("UIScale")
                    if not v2 then
                        v2 = Instance.new("UIScale")
                        v2.Parent = v1
                    end
                    local Back = Enum.EasingStyle.Back
                    local v3 = TweenService
                    local new = TweenInfo.new
                    v3:Create(v2, new(0.35, Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
                    return
                end
            end)
        end
        u62 = v2
        v1:Add(function() -- Line: 227
            -- upvalues: u5 (val), u64 (upval), u65 (upval), u66 (upval), u63 (upval), u61 (upval), u62 (upval)
            local UIScale
            if u5 ~= u64 then
                return
            end
            u64 = u64 + 1
            u65 = nil
            u66 = nil
            u63 = u63 + 1
            for i, j in u61 do
                UIScale = j:FindFirstChildOfClass("UIScale")
                if UIScale then
                    UIScale.Scale = 1
                end
            end
            for k, n in u61 do
                n:Destroy()
            end
            table.clear(u61)
            u62 = 0
        end)
    end,
    Lose = function(a1) -- Line: 241
        -- upvalues: u64 (ref), u61 (val), u62 (ref), BeanstalkEvent (val), u65 (ref), Audio (val), SoundService (val)
        -- upvalues: u66 (ref), u63 (ref), GuiService (val), u60 (val), shatter (val), u55 (val), TweenService (val)
        -- upvalues: u50 (val)
        local Elastic, UIScale_2, new, v1, v2
        local u172 = u64
        local u4 = u61[a1 + 1]
        u62 = a1
        local WhaleHeartBreak = BeanstalkEvent.WhaleHeartBreak
        if not u65 then
            SoundService:PlayLocalSound(WhaleHeartBreak)
        else
            local v3 = Audio.Play(WhaleHeartBreak, SoundService, {SoundGroup = "SFX", PlaybackSpeed = WhaleHeartBreak.PlaybackSpeed})
            if v3 and u66 then
                u66:Add(v3)
            end
        end
        if u4 == nil then
            return
        end
        u63 = u63 + 1
        for i, j in u61 do
            UIScale_2 = j:FindFirstChildOfClass("UIScale")
            if UIScale_2 then
                UIScale_2.Scale = 1
            end
        end
        local ReducedMotionEnabled = GuiService.ReducedMotionEnabled
        local UIScale = u4:FindFirstChildOfClass("UIScale")
        if not UIScale then
            UIScale = Instance.new("UIScale")
            UIScale.Parent = u4
        end
        u4.ImageColor3 = u60
        u4.Rotation = if not ReducedMotionEnabled then (if not (math.random() < 0.5) then 1 else -1) * 12 else 0
        UIScale.Scale = if not ReducedMotionEnabled then 1.7 else 1
        task.delay(0.07, function() -- Line: 255
            -- upvalues: u172 (val), u64 (upval), u4 (val), ReducedMotionEnabled (val), shatter (upval), u55 (upval)
            -- upvalues: UIScale (val), TweenService (upval)
            if u172 == u64 and u4.Parent ~= nil then
                if not ReducedMotionEnabled then
                    shatter(u4)
                end
                local v1 = u4
                v1.ImageColor3 = u55
                v1.ImageTransparency = 0.25
                u4.Rotation = 0
                UIScale.Scale = 0.55
                v1 = UIScale
                local Back = Enum.EasingStyle.Back
                local v2 = TweenService
                local new = TweenInfo.new
                v2:Create(v1, new(0.4, Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
                return
            end
        end)
        for k = 1, a1 do
            v2 = u61[k]
            if not ReducedMotionEnabled then
                v2.ImageColor3 = u60
                TweenService:Create(v2, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = u50}):Play()
                v2.Rotation = (if k % 2 ~= 0 then -1 else 1) * 14
                Elastic = Enum.EasingStyle.Elastic
                v1 = TweenService
                new = TweenInfo.new
                v1:Create(v2, new(0.55, Elastic or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
            end
        end
        if a1 == 1 then
            task.delay(0.4, function() -- Line: 276
                -- upvalues: u172 (val), u64 (upval), u62 (upval), u61 (upval), u63 (upval), GuiService (upval)
                -- upvalues: TweenService (upval)
                if u172 == u64 and u62 == 1 and u61[1] then
                    local u6 = u61[1]
                    u63 = u63 + 1
                    local u9 = u63
                    if GuiService.ReducedMotionEnabled then
                        return
                    end
                    task.spawn(function() -- Line: 130 -- upvalues: u63 (upval), u9 (val), u6 (val), TweenService (upval)
                        if u63 == u9 and u6.Parent ~= nil then
                            local Back, Quad, new, new_2, v1
                            local v2 = u6
                            local v3 = v2:FindFirstChildOfClass("UIScale")
                            if not v3 then
                                v3 = Instance.new("UIScale")
                                v3.Parent = v2
                            end
                            while u63 == u9 do
                                if not u6.Parent then
                                    break
                                end
                                Quad = Enum.EasingStyle.Quad
                                v1 = TweenService
                                new = TweenInfo.new
                                v1:Create(
                                    v3,
                                    new(0.11200000000000002, Quad or Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                    {Scale = 1.2}
                                ):Play()
                                task.wait(0.11200000000000002)
                                if u63 ~= u9 then
                                    break
                                end
                                Back = Enum.EasingStyle.Back
                                v1 = TweenService
                                new_2 = TweenInfo.new
                                v1:Create(v3, new_2(0.168, Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
                                task.wait(0.388)
                            end
                            return
                        end
                    end)
                end
            end)
        end
    end,
    Refill = function(a1) -- Line: 284
        -- upvalues: u64 (ref), u63 (ref), u61 (val), u62 (ref), u50 (val), u60 (val), TweenService (val), play (val)
        -- upvalues: BeanstalkEvent (val)
        local UIScale
        local u1 = u64
        u63 = u63 + 1
        for i, j in u61 do
            UIScale = j:FindFirstChildOfClass("UIScale")
            if UIScale then
                UIScale.Scale = 1
            end
        end
        u62 = a1
        for k, n in u61 do
            if not (a1 < k) then
                task.delay((k - 1) * 0.16, function() -- Line: 292
                    -- upvalues: u1 (val), u64 (upval), n (val), u50 (upval), u60 (upval), TweenService (upval)
                    -- upvalues: play (upval), BeanstalkEvent (upval), k (val)
                    if u1 == u64 and n.Parent ~= nil then
                        local v1 = n
                        v1.ImageColor3 = u50
                        v1.ImageTransparency = 0
                        n.ImageColor3 = u60
                        TweenService:Create(n, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = u50}):Play()
                        local v2 = n
                        v1 = v2:FindFirstChildOfClass("UIScale")
                        if not v1 then
                            v1 = Instance.new("UIScale")
                            v1.Parent = v2
                        end
                        v1.Scale = 0.2
                        n.Rotation = -20
                        local Back = Enum.EasingStyle.Back
                        local v3 = TweenService
                        local new = TweenInfo.new
                        v3:Create(v1, new(0.4, Back or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()
                        v2 = n
                        local Elastic = Enum.EasingStyle.Elastic
                        local v4 = TweenService
                        local new_2 = TweenInfo.new
                        v4:Create(v2, new_2(0.6, Elastic or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                        play(BeanstalkEvent.WhaleHeartRefill, (k - 1) * 0.12 + 1)
                        return
                    end
                end)
            end
        end
    end,
}