-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.2.5.topbarplus.Features.Overflow
-- Decompile time: 11.88 ms

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

function u0.start(a1) -- Line: 21
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
    local u22 = Utility.createStagger(0.1, function(a1) -- Line: 39 -- upvalues: u17 (ref), u0 (upval)
        if not u17 then
            return
        end
        if not a1 then
            u0.updateAvailableIcons("Center")
        end
        u0.updateBoundary("Left")
        u0.updateBoundary("Right")
    end)
    task.delay(0.5, function() -- Line: 49 -- upvalues: u17 (ref), u22 (val)
        u17 = true
        u22()
    end)
    task.delay(2, function() -- Line: 53 -- upvalues: u14 (upval), u22 (val)
        u14 = true
        u22()
    end)
    u16.iconAdded:Connect(u22)
    u16.iconRemoved:Connect(u22)
    u16.iconChanged:Connect(u22)
    ;(CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(function() -- Line: 63 -- upvalues: u22 (val)
        u22(true)
    end)
    ;(v1:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 66 -- upvalues: u22 (val)
        u22(true)
    end)
end

function u0.getWidth(a1, a2) -- Line: 71
    local widget = a1.widget
    return widget:GetAttribute("TargetWidth") or widget.AbsoluteSize.X
end

function u0.getAvailableIcons(a1) -- Line: 76 -- upvalues: u2 (val), u0 (val)
    return u2[a1] or u0.updateAvailableIcons(a1)
end

function u0.updateAvailableIcons(a1) -- Line: 84 -- upvalues: u3 (ref), u7 (val), u2 (val)
    local parentIconUID, v1, v2
    local v3 = 0
    local v4 = {}
    local v5 = a1
    for k, v in pairs(u3) do
        parentIconUID = v.parentIconUID
        v2 = not parentIconUID or u7[parentIconUID]
        v1 = u7[v.UID]
        if v2 and v.alignment == v5 and not v1 then
            table.insert(v4, v)
            v3 = v3 + 1
        end
    end
    if v3 <= 0 then
        return {}
    end
    table.sort(v4, function(a1, a2) -- Line: 105
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

function u0.getRealXPositions(a1, a2) -- Line: 131 -- upvalues: u1 (val), Utility (val), u0 (val)
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

function u0.updateBoundary(a1) -- Line: 160
    -- upvalues: u1 (val), u0 (val), u6 (val), u16 (ref), u7 (val), u15 (ref), u14 (ref), Utility (val)
    local checkToShiftCentralIcon, v1, v2, v3, v4
    local v5 = u1[a1]
    local UIListLayout = v5.UIListLayout
    local X = v5.AbsolutePosition.X
    local X_2 = v5.AbsoluteSize.X
    local Offset = UIListLayout.Padding.Offset
    local Offset_2 = UIListLayout.Padding.Offset
    local u492 = u0.updateAvailableIcons(a1)
    local v6 = 0
    local v7 = 0
    for k, v in pairs(u492) do
        v6 = v6 + (u0.getWidth(v) + Offset_2)
        v7 = v7 + 1
    end
    if v7 <= 0 then
        return
    end
    v7 = a1 == "Center"
    local u442 = a1 == "Left"
    local u434 = not u442
    local v8 = u6[a1]
    if not v8 and not v7 and #u492 > 0 then
        v8 = u16.new()
        v8:setImage(6069276526, "Deselected")
        v8:setName("Overflow" .. a1)
        v8:setOrder(if not u442 then 9999999 else -9999999)
        v8:setAlignment(a1)
        v8:autoDeselect(false)
        v8.isAnOverflow = true
        v8:select("OverflowStart", v8)
        v8:setEnabled(false)
        u6[a1] = v8
        u7[v8.UID] = true
    end
    v7 = if a1 ~= "Left" then "Left" else "Right"
    local v9 = u0.updateAvailableIcons(v7)
    local v10 = u442 and v9[1] or u434 and v9[#v9]
    local v11 = u6[v7]
    local v12 = u442 and X + X_2 or X
    if v10 then
        v1 = (u0.getRealXPositions(v7, v9))[v10.UID]
        local v13 = u0.getWidth(v10)
        v12 = u442 and v1 - Offset or v1 + v13 + Offset
    end
    local u181 = 0

    function checkToShiftCentralIcon() -- Line: 223
        -- upvalues: u0 (upval), u442 (val), u15 (upval), a1 (val), u492 (val), u434 (val), Offset (val), u14 (upval)
        -- upvalues: u181 (ref), checkToShiftCentralIcon (val)
        local Center = u0.getAvailableIcons("Center")
        local v1 = Center[if not u442 then #Center else 1]

        local function secondaryCheck() -- Line: 227 -- upvalues: u15 (upval), u0 (upval), a1 (upval)
            if not u15 then
                u15 = true
                task.delay(3, u0.updateBoundary, a1)
            end
        end

        if v1 and not v1.hasRelocatedInOverflow then
            local v2 = u442 and u492[#u492] or u434 and u492[1]
            local X = v1.widget.AbsolutePosition.X
            local X_2 = v2.widget.AbsolutePosition.X
            local v3 = u0.getWidth(v2)
            v2 = u442 and X - Offset or X + u0.getWidth(v1) + Offset
            local v4 = u442 and X_2 + v3 or X_2
            v3 = false
            if not u442 then
                if u434 and v4 < v2 then
                    if u14 and not (v4 < 0) then
                        v1:align("Right")
                        v1.hasRelocatedInOverflow = true
                        if true then
                            u181 = u181 + 1
                            if u181 <= 4 then
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
                u181 = u181 + 1
                if u181 <= 4 then
                    u0.updateAvailableIcons("Center")
                    checkToShiftCentralIcon()
                end
            end
        end
    end

    checkToShiftCentralIcon()
    if v8 then
        v7 = v8:getInstance("Menu")
        v1 = X + X_2
        local v14 = X_2
        if v7 and v11 then
            local X_3 = v11.widget.AbsolutePosition.X
            local v15 = u0.getWidth(v11)
            v3 = u442 and X_3 - Offset or X_3 + v15 + Offset
            v15 = (v11:getInstance("Menu")).AbsoluteCanvasSize.X <= v7.AbsoluteCanvasSize.X
            v2 = X + X_2 / 2
            v9 = u442 and v2 - Offset / 2 or v2 + Offset / 2
            if v15 then
                v9 = v3
            end
            v14 = u442 and v9 - X or v1 - v9
        end
        v1 = v7 and v7:GetAttribute("MaxWidth")
        v14 = Utility.round(v14)
        if v7 and v1 ~= v14 then
            v7:SetAttribute("MaxWidth", v14)
        end
    end
    v11 = false
    local v16 = u0.getRealXPositions(a1, u492)
    for i = #u492, 1, -1 do
        v4 = u492[i]
        v2 = u0.getWidth(v4)
        v3 = v16[v4.UID]
        if not u442 then
            if u434 and v3 <= v12 then
                v11 = true
            end
        elseif v12 <= v3 + v2 or u434 and v3 <= v12 then
            v11 = true
        end
    end
    for j = #u492, 1, -1 do
        v12 = u492[j]
        if not u7[v12.UID] then
            if not v11 then
                if not v11 and v12.parentIconUID then
                    v12:leave()
                end
            elseif not v12.parentIconUID then
                v12:joinMenu(v8)
            elseif not v11 and v12.parentIconUID then
                v12:leave()
            end
        end
    end
    if v8.isEnabled ~= v11 then
        v8:setEnabled(v11)
    end
    if v8.isEnabled and not v8.overflowAlreadyOpened then
        v8.overflowAlreadyOpened = true
        v8:select()
    end
end

return u0