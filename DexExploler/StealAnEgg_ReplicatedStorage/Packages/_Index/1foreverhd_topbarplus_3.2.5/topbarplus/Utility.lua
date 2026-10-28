-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.2.5.topbarplus.Utility
-- Decompile time: 17.26 ms

local u0 = {}
local LocalPlayer = game:GetService("Players").LocalPlayer

function u0.createStagger(a1, a2, a3) -- Line: 9
    local staggeredCallback
    local u3 = false
    local u4 = false
    if not a1 or a1 == 0 then
        a1 = 0.01
    end

    function staggeredCallback(...) -- Line: 25
        -- upvalues: u3 (ref), u4 (ref), a3 (val), a1 (ref), a2 (val), staggeredCallback (val)
        if u3 then
            u4 = true
            return
        end
        local u4_2 = table.pack(...)
        u3 = true
        u4 = false
        task.spawn(function() -- Line: 33 -- upvalues: a3 (upval), a1 (upval), a2 (upval), u4_2 (val)
            if a3 then
                task.wait(a1)
            end
            a2(table.unpack(u4_2))
        end)
        task.delay(a1, function() -- Line: 39 -- upvalues: u3 (upval), u4 (upval), staggeredCallback (upval), u4_2 (val)
            u3 = false
            if u4 then
                staggeredCallback(table.unpack(u4_2))
            end
        end)
    end

    return staggeredCallback
end

function u0.round(a1) -- Line: 51
    return (math.floor(a1 + 0.5))
end

function u0.reverseTable(a1) -- Line: 56
    local v1, v2, v3
    for i = 1, (math.floor(#a1 / 2)) do
        v1 = #a1 - i + 1
        v2 = a1[v1]
        v3 = a1[i]
        a1[i] = v2
        a1[v1] = v3
    end
end

function u0.copyTable(a1) -- Line: 63 -- upvalues: u0 (val)
    assert(type(a1) == "table", "First argument must be a table")
    local v1 = table.create(#a1)
    for k, v in pairs(a1) do
        if type(v) ~= "table" then
            v1[k] = v
        else
            v1[k] = (u0.copyTable(v))
        end
    end
    return v1
end

local u11 = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
    "<",
    ">",
    "?",
    "@",
    "{",
    "}",
    "[",
    "]",
    "!",
    "(",
    ")",
    "=",
    "+",
    "~",
    "#",
}

function u0.generateUID(a1) -- Line: 156 -- upvalues: u11 (val)
    local v1 = ""
    local v2 = u11
    local v3 = #v2
    for i = 1, a1 or 8 do
        v1 = v1 .. v2[math.random(1, v3)]
    end
    return v1
end

local u90 = {}

function u0.setVisible(a1, a2, a3) -- Line: 169 -- upvalues: u90 (val)
    local v1 = u90[a1]
    if not v1 then
        u90[a1] = {}
        a1.Destroying:Once(function() -- Line: 178 -- upvalues: u90 (upval), a1 (val)
            u90[a1] = nil
        end)
    end
    if a2 then
        v1[a3] = nil
    else
        v1[a3] = true
    end
    local v2 = a2
    if a2 then
        for k, v in pairs(v1) do
            v2 = false
            break
        end
    end
    a1.Visible = v2
end

function u0.formatStateName(a1) -- Line: 197
    return (string.upper((string.sub(a1, 1, 1)))) .. string.lower((string.sub(a1, 2)))
end

function u0.localPlayerRespawned(a1) -- Line: 201 -- upvalues: LocalPlayer (val)
    LocalPlayer.CharacterRemoving:Connect(a1)
end

function u0.getClippedContainer(a1) -- Line: 211
    local ClippedContainer = a1:FindFirstChild("ClippedContainer")
    if not ClippedContainer then
        ClippedContainer = Instance.new("Folder")
        ClippedContainer.Name = "ClippedContainer"
        ClippedContainer.Parent = a1
    end
    return ClippedContainer
end

local Janitor = require(script.Parent.Packages.Janitor)
local GuiService = game:GetService("GuiService")

function u0.clipOutside(a1, a2) -- Line: 225 -- upvalues: Janitor (val), u0 (val), GuiService (val)
    local checkIfOutsideParentXBounds
    local u8 = a1.janitor:add((Janitor.new()))
    a2.Destroying:Once(function() -- Line: 227 -- upvalues: u8 (val)
        u8:Destroy()
    end)
    a1.janitor:add(a2)
    local Parent = a2.Parent
    local u25 = u8:add((Instance.new("Frame")))
    u25:SetAttribute("IsAClippedClone", true)
    u25.Name = a2.Name
    u25.AnchorPoint = a2.AnchorPoint
    u25.Size = a2.Size
    u25.Position = a2.Position
    u25.BackgroundTransparency = 1
    u25.LayoutOrder = a2.LayoutOrder
    u25.Parent = Parent
    local ObjectValue = Instance.new("ObjectValue")
    ObjectValue.Name = "OriginalInstance"
    ObjectValue.Value = a2
    ObjectValue.Parent = u25
    local v1 = ObjectValue:Clone()
    a2:SetAttribute("HasAClippedClone", true)
    v1.Name = "ClippedClone"
    v1.Value = u25
    v1.Parent = a2
    local u50 = nil
    local u54 = require(a1.iconModule)
    local container = u54.container

    local function updateScreenGui() -- Line: 257
        -- upvalues: Parent (val), u50 (ref), container (val), a2 (val), u0 (upval)
        local v1 = Parent:FindFirstAncestorWhichIsA("ScreenGui")
        u50 = if not string.match(v1.Name, "Clipped") then container[v1.Name .. "Clipped"] else v1
        a2.AnchorPoint = Vector2.new(0, 0)
        a2.Parent = u0.getClippedContainer(u50)
    end

    u8:add((a1.alignmentChanged:Connect(updateScreenGui)))
    updateScreenGui()
    for k, v in pairs(a2:GetChildren()) do
        if v:IsA("UIAspectRatioConstraint") then
            v:Clone().Parent = u25
        end
    end
    local widget = a1.widget
    local u83 = false
    local Attribute = a2:GetAttribute("IgnoreVisibilityUpdater")
    u8:add(((widget:GetPropertyChangedSignal("Visible")):Connect(function() -- Line: 281 -- upvalues: Attribute (val), widget (val), u83 (ref), u0 (upval), a2 (val)
        if Attribute then
            return
        end
        local Visible = widget.Visible
        if u83 then
            Visible = false
        end
        u0.setVisible(a2, Visible, "ClipHandler")
    end)))
    local u102 = nil

    function checkIfOutsideParentXBounds() -- Line: 294
        -- upvalues: a1 (val), a2 (val), u54 (val), u83 (ref), Attribute (val), widget (val), u0 (upval), u102 (ref)
        -- upvalues: checkIfOutsideParentXBounds (val), u8 (val)
        task.defer(function() -- Line: 296
            -- upvalues: a1 (upval), a2 (upval), u54 (upval), u83 (upval), Attribute (upval), widget (upval), u0 (upval)
            -- upvalues: u102 (upval), checkIfOutsideParentXBounds (upval), u8 (upval)
            local v1
            local v2 = nil
            local UID = a1.UID
            local parentIconUID = UID
            if a2:GetAttribute("ClipToJoinedParent") then
                local joinedFrame
                for i = 1, 10 do
                    v1 = u54.getIconByUID(parentIconUID)
                    if not v1 then
                        break
                    end
                    joinedFrame = v1.joinedFrame
                    parentIconUID = v1.parentIconUID
                    if not joinedFrame then
                        break
                    end
                    v2 = joinedFrame
                    if v2 and v2.Name == "DropdownScroller" then
                        break
                    end
                end
            end
            if not v2 then
                u83 = false
                if Attribute then
                    return
                end
                local Visible = widget.Visible
                if u83 then
                    Visible = false
                end
                u0.setVisible(a2, Visible, "ClipHandler")
                return
            end
            local AbsolutePosition = a2.AbsolutePosition
            local v3 = a2.AbsoluteSize / 2
            local AbsolutePosition_2 = v2.AbsolutePosition
            local AbsoluteSize = v2.AbsoluteSize
            v1 = AbsolutePosition + v3
            v3 = v1.X < AbsolutePosition_2.X
            local X = v1.X
            local v4 = AbsolutePosition_2.X + AbsoluteSize.X < X
            local v5 = v1.Y < AbsolutePosition_2.Y
            local Y = v1.Y
            local v6 = AbsolutePosition_2.Y + AbsoluteSize.Y < Y
            v1 = v3 or v4 or v5 or v6
            if v1 ~= u83 and not Attribute then
                local Visible_2 = widget.Visible
                if v1 then
                    Visible_2 = false
                end
                u0.setVisible(a2, Visible_2, "ClipHandler")
            end
            if v2:IsA("ScrollingFrame") and u102 ~= v2 then
                u102 = v2
                v5 = (v2:GetPropertyChangedSignal("AbsoluteWindowSize")):Connect(function() -- Line: 341 -- upvalues: checkIfOutsideParentXBounds (upval)
                    checkIfOutsideParentXBounds()
                end)
                u8:add(v5, "Disconnect", "TrackUtilityScroller-" .. UID)
            end
        end)
    end

    local CurrentCamera = workspace.CurrentCamera
    local u111 = a2:GetAttribute("AdditionalOffsetX") or 0

    local function trackProperty(a1_2) -- Line: 351
        -- upvalues: u25 (val), CurrentCamera (val), a2 (val), GuiService (upval), u50 (ref), u54 (val), u111 (val)
        -- upvalues: a1 (val), u83 (ref), Attribute (val), widget (val), u0 (upval), u102 (ref)
        -- upvalues: checkIfOutsideParentXBounds (val), u8 (val)
        local u3 = "Absolute" .. a1_2

        local function updateProperty() -- Line: 353
            -- upvalues: u25 (upval), u3 (val), a1_2 (val), CurrentCamera (upval), a2 (upval), GuiService (upval)
            -- upvalues: u50 (upval), u54 (upval), u111 (upval), a1 (upval), u83 (upval), Attribute (upval)
            -- upvalues: widget (upval), u0 (upval), u102 (upval), checkIfOutsideParentXBounds (upval), u8 (upval)
            local v1 = u25[u3]
            local v2 = UDim2.fromOffset(v1.X, v1.Y)
            if a1_2 == "Position" then
                v1 = CurrentCamera.ViewportSize.X - a2.AbsoluteSize.X - 4
                local Offset = v2.X.Offset
                if Offset < 4 then
                    Offset = 4
                elseif v1 < Offset then
                    Offset = v1
                end
                v2 = UDim2.fromOffset(Offset, v2.Y.Offset)
                local TopbarInset = GuiService.TopbarInset
                local X = workspace.CurrentCamera.ViewportSize.X
                local X_2 = u50.AbsoluteSize.X
                local X_3 = u50.AbsolutePosition.X
                v2 = v2 + UDim2.fromOffset(-((if not u54.isOldTopbar then X - X_2 - 0 else X_3) - u111), TopbarInset.Height)
                task.defer(function() -- Line: 296
                    -- upvalues: a1 (upval), a2 (upval), u54 (upval), u83 (upval), Attribute (upval), widget (upval)
                    -- upvalues: u0 (upval), u102 (upval), checkIfOutsideParentXBounds (upval), u8 (upval)
                    local v1
                    local v2 = nil
                    local UID = a1.UID
                    local parentIconUID = UID
                    if a2:GetAttribute("ClipToJoinedParent") then
                        local joinedFrame
                        for i = 1, 10 do
                            v1 = u54.getIconByUID(parentIconUID)
                            if not v1 then
                                break
                            end
                            joinedFrame = v1.joinedFrame
                            parentIconUID = v1.parentIconUID
                            if not joinedFrame then
                                break
                            end
                            v2 = joinedFrame
                            if v2 and v2.Name == "DropdownScroller" then
                                break
                            end
                        end
                    end
                    if not v2 then
                        u83 = false
                        if Attribute then
                            return
                        end
                        local Visible = widget.Visible
                        if u83 then
                            Visible = false
                        end
                        u0.setVisible(a2, Visible, "ClipHandler")
                        return
                    end
                    local AbsolutePosition = a2.AbsolutePosition
                    local v3 = a2.AbsoluteSize / 2
                    local AbsolutePosition_2 = v2.AbsolutePosition
                    local AbsoluteSize = v2.AbsoluteSize
                    v1 = AbsolutePosition + v3
                    v3 = v1.X < AbsolutePosition_2.X
                    local X = v1.X
                    local v4 = AbsolutePosition_2.X + AbsoluteSize.X < X
                    local v5 = v1.Y < AbsolutePosition_2.Y
                    local Y = v1.Y
                    local v6 = AbsolutePosition_2.Y + AbsoluteSize.Y < Y
                    v1 = v3 or v4 or v5 or v6
                    if v1 ~= u83 and not Attribute then
                        local Visible_2 = widget.Visible
                        if v1 then
                            Visible_2 = false
                        end
                        u0.setVisible(a2, Visible_2, "ClipHandler")
                    end
                    if v2:IsA("ScrollingFrame") and u102 ~= v2 then
                        u102 = v2
                        v5 = (v2:GetPropertyChangedSignal("AbsoluteWindowSize")):Connect(function() -- Line: 341 -- upvalues: checkIfOutsideParentXBounds (upval)
                            checkIfOutsideParentXBounds()
                        end)
                        u8:add(v5, "Disconnect", "TrackUtilityScroller-" .. UID)
                    end
                end)
            end
            a2[a1_2] = v2
        end

        local u9 = u0.createStagger(0.01, updateProperty)
        u8:add(((u25:GetPropertyChangedSignal(u3)):Connect(u9)))
        u8:add(((u25:GetAttributeChangedSignal("ForceUpdate")):Connect(function() -- Line: 391 -- upvalues: u9 (val)
            u9()
        end)))
        local v1 = u0.createStagger(0.5, updateProperty, true)
        u8:add(((u25:GetPropertyChangedSignal(u3)):Connect(v1)))
        if a1_2 == "Position" then
            u8:add(((u50:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 410 -- upvalues: u9 (val)
                u9()
            end)))
        end
    end

    task.delay(0.1, checkIfOutsideParentXBounds)
    task.defer(function() -- Line: 296
        -- upvalues: a1 (val), a2 (val), u54 (val), u83 (ref), Attribute (val), widget (val), u0 (upval), u102 (ref)
        -- upvalues: checkIfOutsideParentXBounds (val), u8 (val)
        local v1
        local v2 = nil
        local UID = a1.UID
        local parentIconUID = UID
        if a2:GetAttribute("ClipToJoinedParent") then
            local joinedFrame
            for i = 1, 10 do
                v1 = u54.getIconByUID(parentIconUID)
                if not v1 then
                    break
                end
                joinedFrame = v1.joinedFrame
                parentIconUID = v1.parentIconUID
                if not joinedFrame then
                    break
                end
                v2 = joinedFrame
                if v2 and v2.Name == "DropdownScroller" then
                    break
                end
            end
        end
        if not v2 then
            u83 = false
            if Attribute then
                return
            end
            local Visible = widget.Visible
            if u83 then
                Visible = false
            end
            u0.setVisible(a2, Visible, "ClipHandler")
            return
        end
        local AbsolutePosition = a2.AbsolutePosition
        local v3 = a2.AbsoluteSize / 2
        local AbsolutePosition_2 = v2.AbsolutePosition
        local AbsoluteSize = v2.AbsoluteSize
        v1 = AbsolutePosition + v3
        v3 = v1.X < AbsolutePosition_2.X
        local X = v1.X
        local v4 = AbsolutePosition_2.X + AbsoluteSize.X < X
        local v5 = v1.Y < AbsolutePosition_2.Y
        local Y = v1.Y
        local v6 = AbsolutePosition_2.Y + AbsoluteSize.Y < Y
        v1 = v3 or v4 or v5 or v6
        if v1 ~= u83 and not Attribute then
            local Visible_2 = widget.Visible
            if v1 then
                Visible_2 = false
            end
            u0.setVisible(a2, Visible_2, "ClipHandler")
        end
        if v2:IsA("ScrollingFrame") and u102 ~= v2 then
            u102 = v2
            u8:add((v2:GetPropertyChangedSignal("AbsoluteWindowSize")):Connect(function() -- Line: 341 -- upvalues: checkIfOutsideParentXBounds (upval)
                checkIfOutsideParentXBounds()
            end), "Disconnect", "TrackUtilityScroller-" .. UID)
        end
    end)
    if not Attribute then
        local Visible = widget.Visible
        if u83 then
            Visible = false
        end
        u0.setVisible(a2, Visible, "ClipHandler")
    end
    trackProperty("Position")
    u8:add(((a2:GetPropertyChangedSignal("Visible")):Connect(function() end)))
    if not a2:GetAttribute("TrackCloneSize") then
        u8:add(((a2:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 431 -- upvalues: a2 (val), u25 (val)
            local AbsoluteSize = a2.AbsoluteSize
            u25.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
        end)))
    else
        trackProperty("Size")
    end
    return u25
end

function u0.joinFeature(a1, a2, a3, a4) -- Line: 440
    local joinJanitor = a1.joinJanitor
    joinJanitor:clean()
    if not a4 then
        a1:leave()
        return
    end
    a1.parentIconUID = a2.UID
    a1.joinedFrame = a4
    joinJanitor:add((a2.alignmentChanged:Connect(function() -- Line: 450 -- upvalues: a2 (val), a1 (val)
        local alignment = a2.alignment
        if alignment == "Center" then
            alignment = "Left"
        end
        a1:setAlignment(alignment, true)
    end)))
    local alignment = a2.alignment
    if alignment == "Center" then
        alignment = "Left"
    end
    a1:setAlignment(alignment, true)
    a1:modifyTheme({"IconButton", "BackgroundTransparency", 1}, "JoinModification")
    a1:modifyTheme({"ClickRegion", "Active", false}, "JoinModification")
    if a2.childModifications then
        task.defer(function() -- Line: 465 -- upvalues: a1 (val), a2 (val)
            a1:modifyTheme(a2.childModifications, a2.childModificationsUID)
        end)
    end
    local u55 = a1:getInstance("ClickRegion")

    local function makeSelectable() -- Line: 471 -- upvalues: u55 (val), a2 (val)
        u55.Selectable = a2.isSelected
    end

    joinJanitor:add((a2.toggled:Connect(makeSelectable)))
    task.defer(makeSelectable)
    joinJanitor:add(function() -- Line: 476 -- upvalues: u55 (val)
        u55.Selectable = true
    end)
    local UID = a1.UID
    table.insert(a3, UID)
    a2:autoDeselect(false)
    a2.childIconsDict[UID] = true
    if not a2.isEnabled then
        a2:setEnabled(true)
    end
    a1.joinedParent:Fire(a2)
    joinJanitor:add(function() -- Line: 494 -- upvalues: a1 (val), a3 (val), UID (val), a2 (val)
        if not a1.joinedFrame then
            return
        end
        for k, v in pairs(a3) do
            if v == UID then
                table.remove(a3, k)
                break
            end
        end
        local v1 = require(a1.iconModule).getIconByUID(a1.parentIconUID)
        if not v1 then
            return
        end
        a1:setAlignment(a1.originalAlignment)
        a1.parentIconUID = false
        a1.joinedFrame = false
        a1:removeModification("JoinModification")
        local v2 = true
        local childIconsDict = v1.childIconsDict
        childIconsDict[UID] = nil
        for k2, i in pairs(childIconsDict) do
            v2 = false
            break
        end
        if v2 and not v1.isAnOverflow then
            v1:setEnabled(false)
        end
        local alignment = a2.alignment
        if alignment == "Center" then
            alignment = "Left"
        end
        a1:setAlignment(alignment, true)
    end)
end

return u0