-- Script path: ReplicatedStorage.Controllers.Game.AreaEggsController.HoverHighlight
-- Decompile time: 1.55 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Packages.Trove)
local v1 = {}

local function showHighlight(a1) -- Line: 19 -- types: a1: userdata
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "AreaEggHover"
    Highlight.FillTransparency = 1
    Highlight.OutlineTransparency = 1
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    Highlight.Adornee = a1
    Highlight.Parent = a1
    return Highlight
end

function v1.Bind(a1, a2, a3) -- Line: 35 -- upvalues: t (val), TweenService (val) -- types: a1: userdata, a2: userdata
    t.strict(t.instanceIsA("Model"))(a1)
    t.strict(t.Instance)(a2)
    local u19 = nil
    a3:Connect(a2.PromptShown, function() -- Line: 40 -- upvalues: u19 (ref), a1 (val), TweenService (upval)
        if u19 ~= nil then
            u19:Destroy()
        end
        local v1 = a1
        local v2 = Instance.new("Highlight")
        v2.Name = "AreaEggHover"
        v2.FillTransparency = 1
        v2.OutlineTransparency = 1
        v2.OutlineColor = Color3.fromRGB(255, 255, 255)
        v2.DepthMode = Enum.HighlightDepthMode.Occluded
        v2.Adornee = v1
        v2.Parent = v1
        TweenService:Create(v2, TweenInfo.new(0.15), {OutlineTransparency = 0}):Play()
    end)
    a3:Connect(a2.PromptHidden, function() -- Line: 47 -- upvalues: u19 (ref), TweenService (upval)
        local u0 = u19
        u19 = nil
        if u0 == nil then
            return
        end
        local v1 = TweenService:Create(u0, TweenInfo.new(0.12), {OutlineTransparency = 1})
        v1.Completed:Once(function() -- Line: 54 -- upvalues: u0 (val)
            u0:Destroy()
        end)
        v1:Play()
    end)
end

return v1