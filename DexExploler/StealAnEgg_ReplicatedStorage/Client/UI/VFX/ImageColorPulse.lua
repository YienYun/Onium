-- Script path: ReplicatedStorage.Client.UI.VFX.ImageColorPulse
-- Decompile time: 1.42 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Log = require(ReplicatedStorage.Packages.Log)
local t = require(ReplicatedStorage.Packages.t)
local u20 = Log.new()
return {
    Start = function(a1, a2, a3) -- Line: 18
        -- upvalues: t (val), TweenService (val), u20 (val)
        t.strict(t.instanceIsA("GuiButton"))(a1)
        t.strict(t.Color3)(a2)
        t.strict(t.TweenInfo)(a3)
        local ImageColor3 = a1.ImageColor3
        local UIScale = Instance.new("UIScale")
        UIScale.Parent = a1
        UIScale.Scale = 0.9
        local u31 = {}
        local v1 = TweenService:Create(UIScale, a3, {Scale = 1.15})
        local v2 = TweenService
        u31[1] = v1
        u31[2] = v2:Create(a1, a3, {ImageColor3 = a2})
        for i, j in u31 do
            j:Play()
        end
        u20:AtTrace():Log("image pulse running")
        local u64 = false
        return function() -- Line: 40 -- upvalues: u64 (ref), u31 (val), a1 (val), ImageColor3 (val), UIScale (val), u20 (upval)
            if not u64 then
                u64 = true
                for i, j in u31 do
                    j:Cancel()
                end
                a1.ImageColor3 = ImageColor3
                UIScale.Scale = 1
                if not UIScale:GetAttribute("PressScaleOwner") then
                    UIScale:Destroy()
                end
                u20:AtTrace():Log("image pulse stopped")
            end
        end
    end,
}