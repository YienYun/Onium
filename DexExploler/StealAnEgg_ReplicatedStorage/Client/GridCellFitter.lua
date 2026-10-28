-- Script path: ReplicatedStorage.Client.GridCellFitter
-- Decompile time: 2.51 ms

local v1 = {}

local function renderScale(a1) -- Line: 13 -- types: a1: userdata
    local UIScale
    local v1 = 1
    local Parent = a1
    while Parent ~= nil do
        if Parent:IsA("LayerCollector") then
            break
        end
        UIScale = Parent:FindFirstChildWhichIsA("UIScale")
        if UIScale ~= nil then
            v1 = v1 * UIScale.Scale
        end
        Parent = Parent.Parent
    end
    if v1 > 0 then
        return v1
    end
    return 1
end

local function wholePixels(a1, a2) -- Line: 26 -- types: a1: UDim2, a2: number
    return (math.floor(a1.Scale * a2 + a1.Offset))
end

function v1.Fit(a1, a2, a3) -- Line: 34 -- upvalues: renderScale (val) -- types: a1: userdata, a2: number, a3: userdata?
    local Parent = a1.Parent
    local v1 = false
    if Parent ~= nil then
        v1 = Parent:IsA("GuiObject")
    end
    assert(v1, (("%* needs a GuiObject parent"):format((a1:GetFullName()))))
    local u23 = a3
    if not u23 then
        u23 = UDim2.new()
    end
    local u26 = a2

    local function refit(a1_2) -- Line: 41
        -- upvalues: u26 (ref), a1 (val), renderScale (upval), Parent (val), u23 (val)
        if a1_2 ~= nil then
            u26 = a1_2
        end
        local v1 = ("%* cannot fit %* columns"):format(a1:GetFullName(), u26)
        assert(u26 >= 1, v1)
        local v2 = renderScale(Parent)
        local v3 = if not Parent:IsA("ScrollingFrame") then nil else Parent
        local AbsoluteWindowSize = if v3 == nil then Parent.AbsoluteSize else v3.AbsoluteWindowSize
        v1 = AbsoluteWindowSize / v2
        local X = u23.X
        local v4 = math.floor(X.Scale * v1.X + X.Offset)
        local Y = u23.Y
        local v5 = math.floor(Y.Scale * v1.Y + Y.Offset)
        v1 = Parent.AbsoluteSize.X / v2
        if v3 ~= nil then
            v1 = v1 - v3.ScrollBarThickness
        end
        v3 = math.max(math.floor(v1 / u26) - v4, 0)
        a1.CellPadding = UDim2.fromOffset(v4, v5)
        a1.CellSize = UDim2.fromOffset(v3, v3)
    end

    local u39 = (Parent:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 63 -- upvalues: refit (val)
        refit()
    end)
    a1.Destroying:Once(function() -- Line: 66 -- upvalues: u39 (val)
        u39:Disconnect()
    end)
    refit()
    return refit
end

return table.freeze(v1)