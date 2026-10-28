-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.4.0.topbarplus.Features.Overflow
-- Decompile time: 10.94 ms

local u0 = {}
local u1 = {}
local u2 = {}
local u3 = nil
local CurrentCamera = workspace.CurrentCamera
local u6 = {}
local u7 = {}
local Utility = require(script.Parent.Parent.Utility)
local u14 = false
local u15 = false
local u16 = nil

function u0.start(a1) -- Line: 25
    -- upvalues: u16 (ref), u3 (ref), u1 (val), Utility (val), u0 (val), u14 (ref), CurrentCamera (val)
    u16 = a1
    u3 = u16.iconsDictionary
    local v1 = nil
    for k, v in pairs(u16.container) do
        if v1 == nil and v.ScreenInsets == Enum.ScreenInsets.TopbarSafeInsets then
            v1 = v
        end
        for k2, i in pairs(v.Holders:GetChildren()) do
            if i:GetAttribute("IsAHolder") then
                u1[i.Name] = i
            end
        end
    end
    local u17 = false
    local u22 = Utility.createStagger(0.1, function(a1) -- Line: 43 -- upvalues: u17 (ref), u0 (upval)
        if not u17 then
            return
        end
        if not a1 then
            u0.updateAvailableIcons("Center")
        end
        u0.updateBoundary("Left")
        u0.updateBoundary("Right")
    end)
    task.delay(0.5, function() -- Line: 53 -- upvalues: u17 (ref), u22 (val)
        u17 = true
        u22()
    end)
    task.delay(2, function() -- Line: 57 -- upvalues: u14 (upval), u22 (val)
        u14 = true
        u22()
    end)
    u16.iconAdded:Connect(u22)
    u16.iconRemoved:Connect(u22)
    u16.iconChanged:Connect(u22)
    ;(CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(function() -- Line: 67 -- upvalues: u22 (val)
        u22(true)
    end)
    ;(v1:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 70 -- upvalues: u22 (val)
        u22(true)
    end)
end

function u0.getWidth(a1, a2) -- Line: 75
    local widget = a1.widget
    return widget:GetAttribute("TargetWidth") or widget.AbsoluteSize.X
end

function u0.getAvailableIcons(a1) -- Line: 80 -- upvalues: u2 (val), u0 (val)
    return u2[a1] or u0.updateAvailableIcons(a1)
end

function u0.updateAvailableIcons(a1) -- Line: 88 -- upvalues: u3 (ref), u7 (val), u2 (val)
    local parentIconUID, v1, v2
    local v3 = 0
    local v4 = {}
    local v5 = a1
    for k, v in pairs(u3) do
        parentIconUID = v.parentIconUID
        v2 = not parentIconUID or u7[parentIconUID]
        v1 = u7[v.UID]
        if v2 and v.alignment == v5 and not v1 and v.isEnabled then
            table.insert(v4, v)
            v3 = v3 + 1
        end
    end
    if v3 <= 0 then
        return {}
    end
    table.sort(v4, function(a1, a2) -- Line: 110
        local LayoutOrder = a1.widget.LayoutOrder
        local LayoutOrder_2 = a2.widget.LayoutOrder
        local parentIconUID = a1.parentIconUID
        local parentIconUID_2 = a2.parentIconUID
        if parentIconUID == parentIconUID_2 then
            if LayoutOrder < LayoutOrder_2 then
                return true
            end
            if LayoutOrder_2 < LayoutOrder then
                return false
            end
            return a1.widget.AbsolutePosition.X < a2.widget.AbsolutePosition.X
        end
        if parentIconUID_2 then
            return false
        end
        if parentIconUID then
            return true
        end
        return nil
    end)
    u2[v5] = v4
    return v4
end

function u0.getRealXPositions(a1, a2) -- Line: 137 -- upvalues: u1 (val), Utility (val), u0 (val)
    local v1, v2
    local v3 = a1 == "Left"
    local v4 = u1[a1]
    local X = v4.AbsolutePosition.X
    local X_2 = v4.AbsoluteSize.X
    local Offset = v4.UIListLayout.Padding.Offset
    local v5 = v3 and X or X + X_2
    local v6 = {}
    if v3 then
        Utility.reverseTable(a2)
    end
    for i = #a2, 1, -1 do
        v2 = a2[i]
        v1 = u0.getWidth(v2)
        if not v3 then
            v5 = v5 - v1
        end
        v6[v2.UID] = v5
        if v3 then
            v5 = v5 + v1
        end
        v5 = v5 + (v3 and Offset or -Offset)
    end
    return v6
end

function u0.updateBoundary(a1) -- Line: 166
    -- upvalues: u1 (val), u0 (val), u6 (val), u16 (ref), u7 (val), u15 (ref), u14 (ref), Utility (val)
    local checkToShiftCentralIcon, v1, v2, v3, v4, v5
    local v6 = u1[a1]
    local UIListLayout = v6.UIListLayout
    local X = v6.AbsolutePosition.X
    local X_2 = v6.AbsoluteSize.X
    local Offset = UIListLayout.Padding.Offset
    local Offset_2 = UIListLayout.Padding.Offset
    local u499 = u0.updateAvailableIcons(a1)
    local v7 = 0
    local v8 = 0
    for k, v in pairs(u499) do
        v7 = v7 + (u0.getWidth(v) + Offset_2)
        v8 = v8 + 1
    end
    if v8 <= 0 then
        return
    end
    v8 = a1 == "Center"
    local u449 = a1 == "Left"
    local u441 = not u449
    local v9 = u6[a1]
    if not v9 and not v8 and #u499 > 0 then
        v9 = u16.new()
        v9:setImage(6069276526, "Deselected")
        v9:setName("Overflow" .. a1)
        v9:setOrder(if not u449 then 9999999 else -9999999)
        v9:setAlignment(a1)
        v9:autoDeselect(false)
        v9.isAnOverflow = true
        v9:select("OverflowStart", v9)
        v9:setEnabled(false)
        u6[a1] = v9
        u7[v9.UID] = true
        if not u16.closeableOverflowMenus then
            v5 = v9:getInstance("IconSpot")
            v5.Visible = false
        end
    end
    v8 = if a1 ~= "Left" then "Left" else "Right"
    v5 = u0.updateAvailableIcons(v8)
    local v10 = u449 and v5[1] or u441 and v5[#v5]
    local v11 = u6[v8]
    local v12 = u449 and X + X_2 or X
    if v10 then
        v1 = (u0.getRealXPositions(v8, v5))[v10.UID]
        local v13 = u0.getWidth(v10)
        v12 = u449 and v1 - Offset or v1 + v13 + Offset
    end
    local u188 = 0

    function checkToShiftCentralIcon() -- Line: 233
        -- upvalues: u0 (upval), u449 (val), u15 (upval), a1 (val), u499 (val), u441 (val), Offset (val), u14 (upval)
        -- upvalues: u188 (ref), checkToShiftCentralIcon (val)
        local Center = u0.getAvailableIcons("Center")
        local v1 = Center[if not u449 then #Center else 1]

        local function secondaryCheck() -- Line: 237 -- upvalues: u15 (upval), u0 (upval), a1 (upval)
            if not u15 then
                u15 = true
                task.delay(3, u0.updateBoundary, a1)
            end
        end

        if v1 and not v1.hasRelocatedInOverflow then
            local v2 = u449 and u499[#u499] or u441 and u499[1]
            local X = v1.widget.AbsolutePosition.X
            local X_2 = v2.widget.AbsolutePosition.X
            local v3 = u0.getWidth(v2)
            v2 = u449 and X - Offset or X + u0.getWidth(v1) + Offset
            local v4 = u449 and X_2 + v3 or X_2
            v3 = false
            if not u449 then
                if u441 and v4 < v2 then
                    if u14 and not (v4 < 0) then
                        v1:align("Right")
                        v1.hasRelocatedInOverflow = true
                        if true then
                            u188 = u188 + 1
                            if u188 <= 4 then
                                u0.updateAvailableIcons("Center")
                                checkToShiftCentralIcon()
                            end
                        end
                        return
                    end
                    if not u15 then
                        u15 = true
                        task.delay(3, u0.updateBoundary, a1)
                    end
                    return
                end
            elseif v2 < v4 then
                if not u14 then
                    if not u15 then
                        u15 = true
                        task.delay(3, u0.updateBoundary, a1)
                    end
                    return
                end
                v1:align("Left")
                v1.hasRelocatedInOverflow = true
                v3 = true
            end
            if v3 then
                u188 = u188 + 1
                if u188 <= 4 then
                    u0.updateAvailableIcons("Center")
                    checkToShiftCentralIcon()
                end
            end
        end
    end

    checkToShiftCentralIcon()
    if v9 then
        v8 = v9:getInstance("Menu")
        v1 = X + X_2
        local v14 = X_2
        if v8 and v11 then
            local X_3 = v11.widget.AbsolutePosition.X
            local v15 = u0.getWidth(v11)
            v3 = u449 and X_3 - Offset or X_3 + v15 + Offset
            v15 = (v11:getInstance("Menu")).AbsoluteCanvasSize.X <= v8.AbsoluteCanvasSize.X
            v2 = X + X_2 / 2
            v5 = u449 and v2 - Offset / 2 or v2 + Offset / 2
            if v15 then
                v5 = v3
            end
            v14 = u449 and v5 - X or v1 - v5
        end
        v1 = v8 and v8:GetAttribute("MaxWidth")
        v14 = Utility.round(v14)
        if v8 and v1 ~= v14 then
            v8:SetAttribute("MaxWidth", v14)
        end
    end
    v11 = false
    local v16 = u0.getRealXPositions(a1, u499)
    for i = #u499, 1, -1 do
        v4 = u499[i]
        v2 = u0.getWidth(v4)
        v3 = v16[v4.UID]
        if not u449 then
            if u441 and v3 <= v12 then
                v11 = true
            end
        elseif v12 <= v3 + v2 or u441 and v3 <= v12 then
            v11 = true
        end
    end
    for j = #u499, 1, -1 do
        v12 = u499[j]
        if not u7[v12.UID] then
            if not v11 then
                if not v11 and v12.parentIconUID then
                    v12:leave()
                end
            elseif not v12.parentIconUID then
                v12:joinMenu(v9)
            elseif not v11 and v12.parentIconUID then
                v12:leave()
            end
        end
    end
    if v9.isEnabled ~= v11 then
        v9:setEnabled(v11)
    end
    if v9.isEnabled and not v9.overflowAlreadyOpened then
        v9.overflowAlreadyOpened = true
        v9:select()
    end
end

return u0