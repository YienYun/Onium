-- Script path: ReplicatedStorage.Controllers.Game.ScrambleClientController.HitFeedback
-- Decompile time: 6.27 ms

local v1 = {}
local u5 = Color3.fromRGB(255, 111, 102)

function v1.new(a1, a2) -- Line: 7 -- upvalues: u5 (val) -- types: a1: userdata, a2: userdata
    local v1 = {}
    local u3 = {}
    local u4 = {}
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ScrambleDamageFeedback"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 5
    ScreenGui.Parent = a1
    local u15 = setmetatable({}, {__mode = "k"})

    local function remove(a1) -- Line: 16 -- upvalues: u3 (val) -- types: a1: number
        u3[a1].Text:Destroy()
        table.remove(u3, a1)
    end

    function v1.Hit(a1, a2_2, a3) -- Line: 20
        -- upvalues: u4 (val), u3 (val), a2 (val), ScreenGui (val), u15 (val)
        if a1.Parent and not (a3 <= 0) then
            local v1
            local v2 = u4[a1]
            if not v2 then
                local Highlight = Instance.new("Highlight")
                Highlight.Name = "ScrambleDamageFlash"
                Highlight.Adornee = a1
                Highlight.FillColor = Color3.fromRGB(255, 70, 63)
                Highlight.OutlineColor = Color3.fromRGB(255, 166, 142)
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
                Highlight.Parent = a1
                u4[a1] = {Age = 0, Highlight = Highlight}
            end
            v2.Age = 0
            v2.Highlight.FillTransparency = 0.62
            v2.Highlight.OutlineTransparency = 0.15
            while true do
                if not (#u3 >= 20) then
                    break
                end
                u3[1].Text:Destroy()
                table.remove(u3, 1)
            end
            v2 = a2:Clone()
            v2.Name = "Amount"
            v2.AnchorPoint = Vector2.new(0.5, 0.5)
            local v3 = UDim2.fromScale(0.5, 0.5)
            local v4 = UDim2.fromOffset(150, 64)
            v2.Position = v3
            v2.Size = v4
            v2.AutomaticSize = Enum.AutomaticSize.None
            v2.TextScaled = false
            v2.TextWrapped = false
            v2.RichText = false
            v2.TextSize = 48
            v2.Text = "-" .. tostring((math.round(a3)))
            v2.TextColor3 = Color3.fromRGB(255, 243, 226)
            v2.TextTransparency = 0
            v2.BackgroundTransparency = 1
            v2.TextStrokeTransparency = 1
            v2.Visible = true
            v2.Parent = ScreenGui
            local UIScale = v2:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
            UIScale.Scale = 0.78
            UIScale.Parent = v2
            v4 = {}
            for i, j in v2:GetDescendants() do
                if j:IsA("UIStroke") then
                    j.StrokeSizingMode = Enum.StrokeSizingMode.FixedSize
                    j.Thickness = 2.5
                    j.Color = Color3.fromRGB(30, 13, 16)
                    j.Transparency = 0
                    table.insert(v4, j)
                elseif j:IsA("UITextSizeConstraint") then
                    j:Destroy()
                end
            end
            local v5 = -(u15[a1] or -1)
            u15[a1] = v5
            local CurrentCamera = workspace.CurrentCamera
            local v6 = Vector3.new(0, 0, 0)
            local v7 = false
            if CurrentCamera then
                local v8
                v1, v8 = CurrentCamera:WorldToViewportPoint(a2_2)
                v6 = v1
                v7 = v8
            end
            v2.Position = UDim2.fromOffset(v6.X + v5 * 14, v6.Y - 5)
            v1 = false
            if CurrentCamera ~= nil then
                v1 = v7 and (CurrentCamera.CFrame.Position - a2_2).Magnitude <= 120
            end
            v2.Visible = v1
            table.insert(u3, {
                Age = 0,
                Origin = a2_2,
                Text = v2,
                Scale = UIScale,
                Strokes = v4,
                Side = v5,
            })
            return
        end
    end

    function v1.Step(a1) -- Line: 76 -- upvalues: u4 (val), u3 (val), u5 (upval) -- types: a1: number
        local Age, CurrentCamera, Text, v1, v2, v3, v4, v5, v6, v7
        local v8 = nil
        local v9 = nil
        local v10 = a1
        for i, j in u4, v8, v9 do
            j.Age = j.Age + v10
            if not i.Parent then
                j.Highlight:Destroy()
                u4[i] = nil
            elseif not (0.6 <= j.Age) then
                v4 = math.clamp((j.Age - 0.08) / 0.52, 0, 1)
                v5 = v4 * v4 * (3 - v4 * 2)
                j.Highlight.FillTransparency = v5 * 0.38 + 0.62
                j.Highlight.OutlineTransparency = v5 * 0.85 + 0.15
            else
                j.Highlight:Destroy()
                u4[i] = nil
            end
        end
        for k = #u3, 1, -1 do
            v3 = u3[k]
            v3.Age = v3.Age + v10
            Age = v3.Age
            if not (Age >= 0.95) then
                v4 = 1 - math.exp(-4 * Age)
                CurrentCamera = workspace.CurrentCamera
                v6 = Vector3.new(0, 0, 0)
                v7 = false
                if CurrentCamera then
                    v1, v2 = CurrentCamera:WorldToViewportPoint(v3.Origin)
                    v6 = v1
                    v7 = v2
                end
                Text = v3.Text
                v2 = false
                if CurrentCamera ~= nil then
                    v2 = v7 and (CurrentCamera.CFrame.Position - v3.Origin).Magnitude <= 120
                end
                Text.Visible = v2
                v3.Text.Position = UDim2.fromOffset(v6.X + v3.Side * (v4 * 38 + 14), v6.Y - 5 - 76 * Age + 28 * Age * Age)
                v3.Scale.Scale = 1 - math.exp(-14 * Age) * 0.22 * math.cos(24 * Age)
                v3.Text.Rotation = v3.Side * 12 * math.sin((math.min(Age / 0.7, 1)) * 3.141592653589793 / 2)
                v3.Text.TextColor3 = (Color3.fromRGB(255, 243, 226)):Lerp(u5, (math.clamp(Age / 0.16, 0, 1)))
                v7 = math.clamp((Age - 0.55) / 0.4, 0, 1)
                v3.Text.TextTransparency = v7
                for n, m in v3.Strokes do
                    m.Transparency = v7
                end
            else
                u3[k].Text:Destroy()
                table.remove(u3, k)
            end
        end
    end

    function v1.Destroy() -- Line: 109 -- upvalues: u3 (val), u4 (val), ScreenGui (val)
        for i = #u3, 1, -1 do
            u3[i].Text:Destroy()
            table.remove(u3, i)
        end
        for j, k in u4 do
            k.Highlight:Destroy()
            u4[j] = nil
        end
        ScreenGui:Destroy()
    end

    return v1
end

return v1