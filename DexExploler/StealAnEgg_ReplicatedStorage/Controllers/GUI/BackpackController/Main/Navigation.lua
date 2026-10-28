-- Script path: ReplicatedStorage.Controllers.GUI.BackpackController.Main.Navigation
-- Decompile time: 8.40 ms

local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local function available(a1, a2) -- Line: 5
    if not a1.Selectable then
        return false
    end
    local Parent = a1
    local v1 = a2
    while Parent do
        if Parent == v1 then
            break
        end
        if Parent:IsA("GuiObject") and not Parent.Visible then
            return false
        end
        Parent = Parent.Parent
    end
    return Parent == v1
end

local function nearest(a1, a2, a3) -- Line: 15
    local v1
    local v2 = nil
    local v3 = nil
    local v4 = a2.AbsolutePosition + a2.AbsoluteSize / 2
    local v5 = nil
    local v6 = nil
    local v7 = a3
    for i, j in a1, v5, v6 do
        v1 = math.abs((j.AbsolutePosition + j.AbsoluteSize / 2)[v7] - v4[v7])
        if not v3 or v1 < v3 then
            v2 = j
        end
    end
    return v2
end

local function readingOrder(a1, a2) -- Line: 26
    local AbsolutePosition = a1.AbsolutePosition
    local AbsolutePosition_2 = a2.AbsolutePosition
    local v1 = math.abs(AbsolutePosition.Y - AbsolutePosition_2.Y)
    if math.min(a1.AbsoluteSize.Y, a2.AbsoluteSize.Y) / 2 < v1 then
        return AbsolutePosition.Y < AbsolutePosition_2.Y
    end
    return AbsolutePosition.X < AbsolutePosition_2.X
end

return function(a1, a2, a3, a4, a5) -- Line: 34
    -- upvalues: available (val), readingOrder (val), nearest (val), GuiService (val), RunService (val)
    local v1
    a1.SelectionGroup = true
    a1.SelectionBehaviorUp = Enum.SelectionBehavior.Stop
    a1.SelectionBehaviorDown = Enum.SelectionBehavior.Stop
    a1.SelectionBehaviorLeft = Enum.SelectionBehavior.Stop
    a1.SelectionBehaviorRight = Enum.SelectionBehavior.Stop
    local u127 = true
    local u128 = {}
    local u129 = {}
    local u130 = {}

    local function invalidate() -- Line: 42 -- upvalues: u127 (ref)
        u127 = true
    end

    local function connect(a1, a2) -- Line: 43 -- upvalues: u128 (val)
        table.insert(u128, (a1:Connect(a2)))
    end

    local function watch(a1) -- Line: 46 -- upvalues: u129 (val), invalidate (val), u127 (ref)
        if a1:IsA("GuiObject") and not u129[a1] then
            local v1 = {}
            for i, j in {"Visible", "Selectable", "AbsolutePosition", "AbsoluteSize", "LayoutOrder"} do
                table.insert(v1, ((a1:GetPropertyChangedSignal(j)):Connect(invalidate)))
            end
            u129[a1] = v1
            u127 = true
            return
        end
    end

    local function relevant(a1) -- Line: 55 -- upvalues: a3 (val), a4 (val), a5 (val)
        local v1 = true
        if a1.Parent ~= a3 then
            v1 = true
            if a1.Parent ~= a4 then
                v1 = true
                if a1.Parent ~= a5 then
                    v1 = a1:IsA("GuiButton") and a1:IsDescendantOf(a5)
                end
            end
        end
        return v1
    end

    for i, j in a1:GetDescendants() do
        v1 = true
        if j.Parent ~= a3 then
            v1 = true
            if j.Parent ~= a4 then
                v1 = true
                if j.Parent ~= a5 then
                    v1 = j:IsA("GuiButton") and j:IsDescendantOf(a5)
                end
            end
        end
        if v1 then
            watch(j)
        end
    end
    table.insert(u128, (a1.DescendantAdded:Connect(function(a1) -- Line: 62 -- upvalues: a3 (val), a4 (val), a5 (val), watch (val)
        local v1 = true
        if a1.Parent ~= a3 then
            v1 = true
            if a1.Parent ~= a4 then
                v1 = true
                if a1.Parent ~= a5 then
                    v1 = a1:IsA("GuiButton") and a1:IsDescendantOf(a5)
                end
            end
        end
        if v1 then
            watch(a1)
        end
    end)))
    table.insert(u128, (a1.DescendantRemoving:Connect(function(a1) -- Line: 65 -- upvalues: u129 (val), u127 (ref)
        if u129[a1] then
            for i, j in u129[a1] do
                j:Disconnect()
            end
            u129[a1] = nil
            u127 = true
        end
    end)))
    table.insert(u128, ((a2:GetPropertyChangedSignal("Visible")):Connect(invalidate)))
    table.insert(u128, ((a1:GetPropertyChangedSignal("Visible")):Connect(invalidate)))

    local function collect(a1_2, a2) -- Line: 74 -- upvalues: available (upval), a1 (val), readingOrder (upval)
        local v1 = {}
        local v2 = if not a2 then a1_2:GetChildren() else a1_2:GetDescendants()
        local v3 = nil
        local v4 = nil
        for i, j in v2, v3, v4 do
            if j:IsA("GuiButton") and available(j, a1) then
                if a2 or j:GetAttribute("IsInventorySlot") ~= nil then
                    table.insert(v1, j)
                end
            end
        end
        table.sort(v1, readingOrder)
        return v1
    end

    local function rebuild() -- Line: 85
        -- upvalues: collect (val), a3 (val), a4 (val), a5 (val), u130 (ref), nearest (upval), GuiService (upval)
        local v1, v2, v3, v4, v5, v6, v7, v8
        local v9 = collect(a3, false)
        local v10 = collect(a4, false)
        local v11 = collect(a5, true)
        local v12 = {}
        local v13 = nil
        local v14 = nil
        for i, j in v9, v13, v14 do
            v8 = v12[#v12]
            if not v8 then
                table.insert(v12, {})
            else
                v1 = math.abs(j.AbsolutePosition.Y - v8[1].AbsolutePosition.Y)
                if j.AbsoluteSize.Y / 2 < v1 then
                    table.insert(v12, {})
                end
            end
            table.insert(v8, j)
        end
        local v15 = u130
        u130 = {}
        v13 = 0
        local v16 = nil
        local v17 = nil
        for k, n in v12, v16, v17 do
            v3 = nil
            v4 = nil
            for m, i5 in n, v3, v4 do
                v13 = v13 + 1
                u130[i5] = true
                v5 = v9[v13 + 1] or v10[1] or i5
                i5.NextSelectionRight = v5
                v5 = n[m - 1] or nearest(v11, i5, "Y") or v9[v13 - 1] or i5
                i5.NextSelectionLeft = v5
                v5 = if not (k > 1) then nil else nearest(v12[k - 1], i5, "X")
                i5.NextSelectionUp = v5
                v6 = nearest
                v7 = v12[k + 1] or v10
                i5.NextSelectionDown = v6(v7, i5, "X") or i5
            end
        end
        v16 = nil
        v17 = nil
        for i6, i7 in v10, v16, v17 do
            u130[i7] = true
            v2 = v10[i6 + 1] or v9[1] or i7
            i7.NextSelectionRight = v2
            v2 = v10[i6 - 1] or nearest(v11, i7, "Y") or i7
            i7.NextSelectionLeft = v2
            v3 = nearest
            v4 = v12[#v12] or v11
            i7.NextSelectionUp = v3(v4, i7, "X") or i7
            i7.NextSelectionDown = nil
        end
        v14 = v11
        v16 = nil
        v17 = nil
        for i8, i9 in v14, v16, v17 do
            u130[i9] = true
            i9.NextSelectionUp = v11[i8 - 1] or i9
            v2 = v11[i8 + 1] or v10[1] or i9
            i9.NextSelectionDown = v2
            i9.NextSelectionLeft = i9
            v3 = nearest
            v4 = v12[1] or v10
            i9.NextSelectionRight = v3(v4, i9, "Y") or i9
        end
        local SelectedObject = GuiService.SelectedObject
        if SelectedObject and v15[SelectedObject] and not u130[SelectedObject] then
            v14 = GuiService
            v16 = v11[1] or v9[1] or v10[1]
            v14.SelectedObject = v16
        end
    end

    table.insert(u128, (RunService.RenderStepped:Connect(function() -- Line: 130 -- upvalues: u127 (ref), a2 (val), a1 (val), rebuild (val)
        if u127 and a2.Visible and a1.Visible then
            u127 = false
            rebuild()
        end
    end)))
    table.insert(u128, (a1.Destroying:Connect(function() -- Line: 136 -- upvalues: u128 (val), u129 (val)
        for i, j in u128 do
            j:Disconnect()
        end
        local v1 = nil
        local v2 = nil
        for k, n in u129, v1, v2 do
            for m, i5 in n do
                i5:Disconnect()
            end
        end
    end)))
end