-- Script path: ReplicatedStorage.Client.Notifications.CorruptedPlate
-- Decompile time: 7.69 ms

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Trove = require(ReplicatedStorage.Packages.Trove)
local CorruptedPlate = ReplicatedStorage.Assets.UI.Notifs.CorruptedPlate
local u23 = {}
local v1 = {Drift = -1, Color = Color3.fromRGB(115, 255, 77)}
local v2 = {Drift = 1, Color = Color3.fromRGB(179, 58, 255)}
u23[1] = v1
u23[2] = v2
v1 = {}

local function startsWith(a1, a2) -- Line: 47 -- types: a1: string, a2: string
    return string.sub(a1, 1, #a2) == a2
end

local function makeGhost(a1, a2, a3, a4) -- Line: 51 -- types: a2: userdata, a3: UDim2, a4: number
    local v1
    local v2 = a1:Clone(a2)
    v2.Name = "SignalGhost"
    v2.ZIndex = a2.ZIndex - 1
    for i, j in v2:GetDescendants() do
        if j:IsA("UIStroke") then
            j.Enabled = false
        elseif j:IsA("ImageLabel") then
            j.ImageTransparency = 1
        end
    end
    local v3 = {}
    for k, n in a2:GetChildren() do
        v1 = v2:FindFirstChild(n.Name)
        if n:IsA("TextLabel") and v1 ~= nil and v1:IsA("TextLabel") then
            v1.RichText = false
            v1.Text = n.ContentText
            v1.TextColor3 = a3
            v1.TextStrokeTransparency = 1
            v1.TextTransparency = 1
            v3[n] = v1
        end
    end
    v2.Parent = a2.Parent
    return {Row = v2, Drift = a4, Labels = v3}
end

function v1.Attach(a1, a2) -- Line: 82
    -- upvalues: Trove (val), CorruptedPlate (val), GuiService (val), RunService (val), u23 (val), makeGhost (val)
    local u186 = Trove.new()
    u186:AttachToInstance(a1)
    local u191 = u186:Clone(CorruptedPlate)
    u191.ZIndex = a2.ZIndex - 2
    u191.Parent = a1

    local function stop() -- Line: 90 -- upvalues: u186 (val)
        u186:Clean()
    end

    local Scale = u191.Size.Y.Scale

    local function fitWidth() -- Line: 95 -- upvalues: a1 (val), a2 (val), u191 (val), Scale (val)
        local X = a1.AbsoluteSize.X
        if X <= 0 then
            return
        end
        local v1 = 0
        for i, j in a2:GetChildren() do
            if j:IsA("TextLabel") and j.Visible then
                v1 = v1 + j.AbsoluteSize.X
            end
        end
        u191.Size = UDim2.fromScale(math.clamp(v1 / X + 0.2, 0.3, 1), Scale)
    end

    fitWidth()
    if GuiService.ReducedMotionEnabled then
        u186:Connect(RunService.RenderStepped, fitWidth)
        return stop
    end
    local u205 = {}
    local u207 = {}
    local u172 = {}
    for i, j in u191:GetChildren() do
        if not (string.sub(j.Name, 1, 9) == "ChargeArc") then
            if not (string.sub(j.Name, 1, 10) == "ChargeGlow") then
                if string.sub(j.Name, 1, 10) == "SignalTear" and j:IsA("GuiObject") then
                    table.insert(u172, {Frame = j, Position = j.Position})
                end
            elseif j:IsA("ImageLabel") then
                table.insert(u207, j)
            elseif string.sub(j.Name, 1, 10) == "SignalTear" and j:IsA("GuiObject") then
                table.insert(u172, {Frame = j, Position = j.Position})
            end
        elseif j:IsA("ImageLabel") then
            table.insert(u205, j)
        elseif not (string.sub(j.Name, 1, 10) == "ChargeGlow") then
            if string.sub(j.Name, 1, 10) == "SignalTear" and j:IsA("GuiObject") then
                table.insert(u172, {Frame = j, Position = j.Position})
            end
        elseif j:IsA("ImageLabel") then
            table.insert(u207, j)
        elseif string.sub(j.Name, 1, 10) == "SignalTear" and j:IsA("GuiObject") then
            table.insert(u172, {Frame = j, Position = j.Position})
        end
    end
    local u45 = {}
    for k, n in u23 do
        table.insert(u45, (makeGhost(u186, a2, n.Color, n.Drift)))
    end
    local Scan = u191:FindFirstChild("Scan")
    local Scale_2 = if Scan == nil then 0 else Scan.Position.Y.Scale
    local u67 = 1 - Scale_2 * 2
    local Position = a2.Position
    local u71 = 0
    local u72 = -1
    u186:Connect(RunService.RenderStepped, function(a1) -- Line: 144
        -- upvalues: u71 (ref), fitWidth (val), u72 (ref), u205 (val), u45 (val), Position (val), u172 (val), u207 (val)
        -- upvalues: Scan (val), Scale_2 (val), u67 (val)
        local Attribute_2, v1, v2, v3, v4
        u71 = u71 + a1
        fitWidth()
        local v5 = math.floor(u71 * 14)
        if v5 ~= u72 then
            local Attribute, Y, new, v6
            u72 = v5
            for i, j in u205 do
                Attribute = j:GetAttribute("Cells")
                if typeof(Attribute) == "Vector2" and 0 < Attribute.X and 0 < Attribute.Y then
                    v3 = v5 + (j:GetAttribute("Phase") or 0) * 5
                    new = Vector2.new
                    v1 = j.ImageRectSize.X * (v3 % Attribute.X)
                    Y = j.ImageRectSize.Y
                    v6 = math.floor(v3 / Attribute.X)
                    j.ImageRectOffset = new(v1, Y * (v6 % Attribute.Y))
                end
            end
        end
        v5 = u71 % 1.45
        local v7 = if not (v5 < 0.23) then 0 else 1 - v5 / 0.23
        v5 = math.sin(u71 * 173) * v7
        local v8 = nil
        local v9 = nil
        for k, n in u45, v8, v9 do
            v3 = n.Drift * (math.abs(v5) * 0.007 + 0.004)
            n.Row.Position = Position + UDim2.fromScale(v3, 0)
            v1 = nil
            v2 = nil
            for m, i5 in n.Labels, v1, v2 do
                if i5.Text ~= m.ContentText then
                    i5.Text = m.ContentText
                end
                i5.TextSize = m.TextSize
                i5.TextScaled = m.TextScaled
                i5.TextWrapped = m.TextWrapped
                i5.TextTransparency = 1 - v7 * 0.53
            end
        end
        for i6, i7 in u172 do
            v3 = i7.Frame:GetAttribute("Drift") or 1
            v4 = i7.Frame:GetAttribute("Phase") or 0
            i7.Frame.Position = i7.Position + UDim2.fromScale(v5 * 0.017 * v3, 0)
            i7.Frame.BackgroundTransparency = 0.67 - v7 * 0.43 + math.sin(u71 * 2 + v4) * 0.12
        end
        for i8, i9 in u207 do
            Attribute_2 = i9:GetAttribute("Phase")
            v2 = u71 * 2.2 + (Attribute_2 or 0)
            i9.ImageTransparency = math.sin(v2) * 0.035 + 0.9
        end
        if Scan ~= nil then
            Scan.Position = UDim2.fromScale(Scan.Position.X.Scale, Scale_2 + u71 * 0.45 % 1 * u67)
        end
    end)
    return stop
end

return table.freeze(v1)