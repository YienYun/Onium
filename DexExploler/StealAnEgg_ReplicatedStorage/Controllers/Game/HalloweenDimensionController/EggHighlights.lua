-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.EggHighlights
-- Decompile time: 2.62 ms

return {
    new = function() -- Line: 3
        local u0 = {}

        local function clear(a1) -- Line: 5 -- upvalues: u0 (val) -- types: a1: userdata
            local v1 = u0[a1]
            u0[a1] = nil
            if v1 ~= nil then
                v1:Destroy()
            end
        end

        return {
            Step = function(a1, a2, a3) -- Line: 17 -- upvalues: u0 (val) -- types: a1: userdata?, a2: boolean, a3: vector?
                local v1
                local WorldEggs = if a1 == nil then nil else a1:FindFirstChild("WorldEggs")
                if a2 and a3 ~= nil and WorldEggs ~= nil then
                    local Highlight, Magnitude, StealPrompt, v2
                    local v3 = {}
                    for i, j in WorldEggs:GetChildren() do
                        if j:IsA("Model") and type((j:GetAttribute("HalloweenEggUid"))) == "string" then
                            StealPrompt = j:FindFirstChild("StealPrompt", true)
                            Magnitude = (j:GetPivot().Position - a3).Magnitude
                            if StealPrompt ~= nil
                                and StealPrompt:IsA("ProximityPrompt")
                                and StealPrompt.Enabled
                                and not (Magnitude <= StealPrompt.MaxActivationDistance)
                                and not (Magnitude > 250) then
                                v3[j] = true
                                if u0[j] == nil then
                                    Highlight = Instance.new("Highlight")
                                    Highlight.Name = "HalloweenEggDistanceHighlight"
                                    Highlight.Adornee = j
                                    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                                    Highlight.FillTransparency = 1
                                    Highlight.OutlineTransparency = 0.15
                                    Highlight.OutlineColor = Color3.new(1, 1, 1)
                                    Highlight.Parent = j
                                    u0[j] = Highlight
                                end
                            end
                        end
                    end
                    for k in u0 do
                        if not v3[k] then
                            v2 = u0[k]
                            u0[k] = nil
                            if v2 ~= nil then
                                v2:Destroy()
                            end
                        end
                    end
                    return
                end
                for n in u0 do
                    v1 = u0[n]
                    u0[n] = nil
                    if v1 ~= nil then
                        v1:Destroy()
                    end
                end
            end,
            Destroy = function() -- Line: 12 -- upvalues: u0 (val)
                local v1
                for i in u0 do
                    v1 = u0[i]
                    u0[i] = nil
                    if v1 ~= nil then
                        v1:Destroy()
                    end
                end
            end,
        }
    end,
}