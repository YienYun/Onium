-- Script path: ReplicatedStorage.Client.WorldFX.HoverHighlight
-- Decompile time: 2.75 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
local Completed = Enum.PlaybackState.Completed
local u15 = {
    fadeSeconds = 0.2,
    easing = Enum.EasingStyle.Quad,
    direction = Enum.EasingDirection.Out,
}
u15.shown = {OutlineTransparency = 0}
u15.hidden = {OutlineTransparency = 1}
u15.restingLook = {
    FillTransparency = 1,
    OutlineTransparency = 1,
    DepthMode = Enum.HighlightDepthMode.Occluded,
    FillColor = Color3.fromRGB(255, 255, 255),
    OutlineColor = Color3.fromRGB(255, 255, 255),
}

local function glide(a1, a2, a3) -- Line: 25
    -- upvalues: u15 (val), TweenService (val)
    local v1 = TweenService:Create(a1, TweenInfo.new(a3 or u15.fadeSeconds, u15.easing, u15.direction), a2)
    v1:Play()
    return v1
end

return {
    FadeIn = function(a1, a2, a3) -- Line: 33
        -- upvalues: t (val), u15 (val), TweenService (val)
        t.strict(t.instanceIsA("Model"))(a1)
        t.strict(t.string)(a2)
        t.strict(t.optional(t.number))(a3)
        local restingLook = u15.restingLook
        local Highlight = Instance.new("Highlight")
        for i, j in restingLook do
            Highlight[i] = j
        end
        Highlight.Adornee = a1
        Highlight.Name = a2
        Highlight.Parent = a1
        local shown = u15.shown
        local new = TweenInfo.new
        TweenService:Create(Highlight, new(a3 or u15.fadeSeconds, u15.easing, u15.direction), shown):Play()
        return Highlight
    end,
    FadeOut = function(a1, a2) -- Line: 51
        -- upvalues: t (val), Completed (val), u15 (val), TweenService (val)
        assert(a1:IsA("Highlight"), "fade-out was handed something that is not a Highlight")
        t.strict(t.optional(t.number))(a2)
        local hidden = u15.hidden
        local v1 = TweenService:Create(a1, TweenInfo.new(a2 or u15.fadeSeconds, u15.easing, u15.direction), hidden)
        v1:Play()
        v1.Completed:Once(function(a1_2) -- Line: 55 -- upvalues: Completed (upval), a1 (val)
            if a1_2 == Completed then
                a1:Destroy()
            end
        end)
    end,
}