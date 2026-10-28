-- Script path: ReplicatedStorage.Client.UI.AssetChatBubble
-- Decompile time: 8.01 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local EnsureUIScale = require(ReplicatedStorage.Shared.Utils.EnsureUIScale)
local MessageTyper = require(ReplicatedStorage.Client.UI.MessageTyper)
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local u36 = Vector2.new(1084, 144)
local u40 = Vector2.new(251, 72)
local u44 = Vector2.new(213.84, 56.4)
local u49 = TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local u54 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u59 = t.strict(t.instanceIsA("Model"))
local u64 = t.strict(t.instanceIsA("BasePart"))
local u67 = t.strict(t.boolean)
local u70 = t.strict(t.string)
local u71 = {}
u71.__index = u71
u71.__class = "AssetChatBubble"
local ChatBubble = ReplicatedStorage.Assets.Billboards.ChatBubble
local Frame = ChatBubble.Frame
assert(
    ChatBubble:IsA("BillboardGui") and Frame:IsA("Frame") and Frame.TextLabel:IsA("TextLabel"),
    "the chat bubble blueprint has the wrong instance shape"
)
local u95 = true

local function claimAdornee(a1) -- Line: 65
    local v1
    local adornee = a1.adornee
    if adornee ~= nil then
        return adornee
    end
    assert(a1.proxied, "a bubble without an adornee must have been built in proxy mode")
    local Part = Instance.new("Part")
    Part.Name = "AssetBubbleProxy"
    Part.Size = Vector3.new(0.20000000298023224, 0.20000000298023224, 0.20000000298023224)
    Part.Transparency = 1
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Anchored = false
    Part.Massless = true
    Part.CFrame = a1.centre.CFrame + Vector3.new(0, -1, 0)
    Part.Parent = a1.model
    if not a1.centre.Anchored then
        v1 = Instance.new("WeldConstraint")
    else
        local Motor6D = Instance.new("Motor6D")
        Motor6D.C0 = a1.centre.CFrame:ToObjectSpace(Part.CFrame)
        v1 = Motor6D
    end
    v1.Part0 = a1.centre
    v1.Part1 = Part
    v1.Parent = a1.centre
    a1.lifetime:Add(Part)
    a1.adornee = Part
    return Part
end

local function tearDown(a1, a2) -- Line: 101
    local showing = a1.showing
    if showing == nil then
        return
    end
    if a2 ~= nil and showing ~= a2 then
        return
    end
    a1.showing = nil
    showing:Destroy()
end

local function widenToFit(a1, a2, a3) -- Line: 111
    -- upvalues: u44 (val), TextService (val), u40 (val), u36 (val)
    local GetTextBoundsParams = Instance.new("GetTextBoundsParams")
    GetTextBoundsParams.Font = a2.FontFace
    GetTextBoundsParams.Size = u44.Y
    GetTextBoundsParams.Width = 10000
    GetTextBoundsParams.Text = a3
    local TextBoundsAsync = TextService:GetTextBoundsAsync(GetTextBoundsParams)
    GetTextBoundsParams:Destroy()
    assert(0 < TextBoundsAsync.Y, "measured chat bubble text has no height")
    local Size = a1.Size
    local v1 = false
    if Size.X.Offset == 0 then
        v1 = Size.Y.Offset == 0
    end
    assert(v1, "the chat bubble frame must be sized purely in scale")
    a1.Size = UDim2.fromScale((math.max(u40.X, TextBoundsAsync.X + (u40.X - u44.X))) / u36.X, Size.Y.Scale)
end

function u71.new(a1, a2, a3) -- Line: 132
    -- upvalues: u59 (val), u64 (val), u67 (val), u71 (val), Trove (val)
    u59(a1)
    u64(a2)
    u67(a3)
    local v1 = setmetatable({}, u71)
    v1.lifetime = Trove.new()
    v1.showing = nil
    v1.model = a1
    v1.centre = a2
    v1.adornee = if not a3 then a2 else nil
    v1.sizeFactor = math.max(a2.Size.X / 0.49799999594688416, a2.Size.Y / 0.4440000057220459)
    v1.proxied = a3
    v1.muted = false
    return v1
end

function u71:Destroy() -- Line: 151
    local showing = self.showing
    if showing ~= nil then
        self.showing = nil
        showing:Destroy()
    end
    self.lifetime:Destroy()
end

function u71.PinAbove(a1) -- Line: 156 -- upvalues: u67 (val), u95 (ref) -- types: a1: boolean
    u67(a1)
    u95 = a1
end

function u71.Mute(a1, a2) -- Line: 161 -- upvalues: u67 (val) -- types: a2: boolean
    u67(a2)
    if a1.muted == a2 then
        return
    end
    a1.muted = a2
    if a2 then
        local showing = a1.showing
        if showing ~= nil then
            a1.showing = nil
            showing:Destroy()
        end
    end
end

function u71.Say(a1, a2, a3) -- Line: 173
    -- upvalues: u70 (val), ChatBubble (val), claimAdornee (val), u95 (ref), Trove (val), widenToFit (val)
    -- upvalues: EnsureUIScale (val), MessageTyper (val), TweenService (val), u49 (val), u54 (val)
    u70(a2)
    if a1.muted then
        if a3 ~= nil then
            a3()
        end
        return
    end
    local showing = a1.showing
    if showing ~= nil then
        a1.showing = nil
        showing:Destroy()
    end
    local v1 = ChatBubble:Clone()
    local Frame = v1.Frame
    local TextLabel = Frame.TextLabel
    assert(Frame:IsA("Frame"), "the cloned chat bubble lost its Frame")
    assert(TextLabel:IsA("TextLabel"), "the cloned chat bubble lost its TextLabel")
    local Size = v1.Size
    v1.Size = UDim2.new(Size.X.Scale * a1.sizeFactor, Size.X.Offset * a1.sizeFactor, Size.Y.Scale * a1.sizeFactor, Size.Y.Offset * a1.sizeFactor)
    Frame.AutomaticSize = Enum.AutomaticSize.None
    v1.Adornee = claimAdornee(a1)
    v1.AlwaysOnTop = u95
    v1.Parent = a1.model
    v1.Enabled = true
    TextLabel.Text = ""
    local u64 = Trove.new()
    a1.showing = u64
    u64:Add(v1)
    u64:Add((task.spawn(function() -- Line: 208
        -- upvalues: a1 (val), u64 (val), widenToFit (upval), Frame (val), TextLabel (val), a2 (val)
        -- upvalues: EnsureUIScale (upval), MessageTyper (upval), TweenService (upval), u49 (upval), u54 (upval)
        -- upvalues: a3 (val)
        if a1.showing ~= u64 then
            return
        end
        widenToFit(Frame, TextLabel, a2)
        if a1.showing ~= u64 then
            return
        end
        local u13 = EnsureUIScale(Frame)
        u13.Scale = 0
        local u21 = MessageTyper.new(TextLabel, nil, nil, false)
        u64:Add(function() -- Line: 221 -- upvalues: u21 (val)
            u21:Halt()
        end)
        local v1 = TweenService:Create(u13, u49, {Scale = 1})
        u64:Add(v1)
        u64:Add((task.delay(4, function() -- Line: 225 -- upvalues: a1 (upval), u64 (upval), TweenService (upval), u13 (val), u54 (upval), a3 (upval)
            if a1.showing ~= u64 then
                return
            end
            local v1 = TweenService:Create(u13, u54, {Scale = 0})
            u64:Add(v1)
            u64:Add((v1.Completed:Connect(function() -- Line: 232 -- upvalues: a1 (upval), u64 (upval), a3 (upval)
                local v1 = a1
                local v2 = u64
                local showing = v1.showing
                if showing ~= nil then
                    if v2 == nil or showing == v2 then
                        v1.showing = nil
                        showing:Destroy()
                    end
                end
                if a3 ~= nil then
                    a3()
                end
            end)))
            v1:Play()
        end)))
        task.delay(0.2, function() -- Line: 241 -- upvalues: u21 (val), a2 (upval), TextLabel (upval)
            u21:Type(a2, TextLabel.TextColor3)
        end)
        v1:Play()
    end)))
end

return u71