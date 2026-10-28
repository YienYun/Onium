-- Script path: ReplicatedStorage.UserGenerated.Observability.Relevance
-- Decompile time: 8.33 ms

local result
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Styles = require(ReplicatedStorage.UserGenerated.Observability.Styles)
_, result = xpcall(function() -- Line: 27
    return workspace[nil]
end, function() -- Line: 29
    return debug.info(2, "f")
end)
local v1 = result
if type(v1) ~= "function" then
    function result(a1, a2) -- Line: 33
        return a1[a2]
    end
end
local Get = Styles.Get
local u21 = {}
u21.ShownBy = table.freeze({Visible = true, Enabled = true, Adornee = true})
local u28 = table.freeze({Position = true, AnchorPoint = true})
local u31 = table.freeze({Position = true, AnchorPoint = true, Size = true})
local u34 = table.freeze({LayoutOrder = true})
local u37 = table.freeze({BackgroundColor3 = true, BorderColor3 = true, BorderMode = true, BorderSizePixel = true})
local u40 = table.freeze({BorderColor3 = true, BorderMode = true})
local u43 = table.freeze({TextSize = true})
local u46 = table.freeze({TextColor3 = true, TextStrokeColor3 = true, TextStrokeTransparency = true})
local u49 = table.freeze({
    IsLoaded = true,
    ImageColor3 = true,
    ImageRectOffset = true,
    ImageRectSize = true,
    ScaleType = true,
    SliceCenter = true,
    SliceScale = true,
    TileSize = true,
    ResampleMode = true,
})
local u52 = table.freeze({Color = true, Offset = true, Rotation = true, Transparency = true})
local u55 = table.freeze({
    ApplyStrokeMode = true,
    BorderOffset = true,
    BorderStrokePosition = true,
    Color = true,
    LineJoinMode = true,
    StrokeSizingMode = true,
    Transparency = true,
    ZIndex = true,
})
local u56 = {}

local function kindOf(a1) -- Line: 103 -- upvalues: result (ref), u56 (val), u31 (val), u28 (val) -- types: a1: userdata
    local v1 = result(a1, "ClassName")
    local v2 = u56[v1]
    if v2 then
        return v2
    end
    local v3 = 0
    if a1:IsA("ScreenGui") then
        v3 = 1
    elseif a1:IsA("BillboardGui") or a1:IsA("SurfaceGui") then
        v3 = 2
    elseif a1:IsA("LayerCollector") then
        v3 = 3
    end
    local v4 = false
    if a1:IsA("UIGridLayout") or a1:IsA("UITableLayout") then
        v4 = u31
    elseif a1:IsA("UIListLayout") then
        v4 = u28
    end
    local freeze = table.freeze
    local v5 = {Collector = v3, Gui = a1:IsA("GuiObject")}
    v5.Text = if not a1:IsA("TextBox") then if a1:IsA("TextLabel") then 1 else if not a1:IsA("TextButton") then 0 else 1 else 2
    local v6 = a1:IsA("ImageLabel") or a1:IsA("ImageButton")
    v5.Image = v6
    v5.Gradient = a1:IsA("UIGradient")
    v5.Stroke = a1:IsA("UIStroke")
    v5.Layout = v4
    v5.IsLayout = a1:IsA("UIGridStyleLayout")
    v2 = freeze(v5)
    u56[v1] = v2
    return v2
end

local function collectorHides(a1, a2) -- Line: 139
    -- upvalues: Get (val), result (ref)
    if a2 == 1 then
        return not Get(a1, "Enabled")
    end
    if a2 ~= 2 or not Get(a1, "Enabled") then
        return true
    end
    if result(a1, "Adornee") ~= nil then
        return false
    end
    local v1 = result(a1, "Parent")
    return not (v1 and (v1:IsA("BasePart") or v1:IsA("Attachment") or v1:IsA("Model")))
end

function u21.HidesSubtree(a1) -- Line: 157
    -- upvalues: kindOf (val), collectorHides (val), Get (val)
    local v1 = kindOf(a1)
    if v1.Collector ~= 0 then
        return (collectorHides(a1, v1.Collector))
    end
    return v1.Gui and not Get(a1, "Visible")
end

function u21.NewMemo() -- Line: 173
    return {Hidden = {}, Layout = {}}
end

local u62 = {}

function u21.IsHidden(a1, a2, a3) -- Line: 182
    -- upvalues: kindOf (val), collectorHides (val), u62 (val), Get (val), result (ref)
    local v1
    local Hidden = a3 and a3.Hidden
    local v2 = a1
    local v3 = 0
    local v4 = true
    while v2 do
        if v2 == a2 then
            break
        end
        if Hidden then
            v1 = Hidden[v2]
            if v1 ~= nil then
                v4 = v1
                break
            end
        end
        v1 = kindOf(v2)
        if v1.Collector ~= 0 then
            v4 = collectorHides(v2, v1.Collector)
            v3 = v3 + 1
            u62[v3] = v2
            break
        end
        if v1.Gui and not Get(v2, "Visible") then
            v4 = true
            v3 = v3 + 1
            u62[v3] = v2
            break
        end
        if Hidden then
            v3 = v3 + 1
            u62[v3] = v2
        end
        result(v2, "Parent")
    end
    if Hidden then
        for i = 1, v3 do
            Hidden[u62[i]] = v4
        end
    end
    table.clear(u62)
    return v4
end

function u21.SubtreeHidden(a1, a2) -- Line: 226
    -- upvalues: kindOf (val), collectorHides (val), Get (val), result (ref)
    local v1
    local v2 = a1
    while v2 do
        if v2 == a2 then
            break
        end
        v1 = kindOf(v2)
        if v1.Collector ~= 0 then
            return (collectorHides(v2, v1.Collector))
        end
        if v1.Gui and not Get(v2, "Visible") then
            return true
        end
        result(v2, "Parent")
    end
    return false
end

local u68 = table.freeze({"Visible"})
local u72 = table.freeze({"Enabled"})
local u78 = table.freeze({"Enabled", "Adornee", "Parent"})
local u81 = table.freeze({})

function u21.ShownByOf(a1) -- Line: 247
    -- upvalues: kindOf (val), u78 (val), u72 (val), u68 (val), u81 (val)
    local v1 = kindOf(a1)
    if v1.Collector == 2 then
        return u78
    end
    if v1.Collector ~= 0 then
        return u72
    end
    if v1.Gui then
        return u68
    end
    return u81
end

local function noImage(a1) -- Line: 260 -- upvalues: Get (val) -- types: a1: userdata
    local v1 = true
    if Get(a1, "Image") ~= "" then
        v1 = 1 <= (Get(a1, "ImageTransparency"))
    end
    return v1
end

function u21.PolledUnseen(a1, a2, a3) -- Line: 266
    -- upvalues: u21 (val), kindOf (val), Get (val)
    if u21.IsHidden(a1, a2, a3) then
        return true
    end
    local Image = kindOf(a1).Image
    if Image then
        Image = true
        if Get(a1, "Image") ~= "" then
            Image = 1 <= (Get(a1, "ImageTransparency"))
        end
    end
    return Image
end

local u85 = {}

local function union(a1, a2) -- Line: 276 -- upvalues: u85 (val) -- types: a1: table?, a2: table
    if not a1 then
        return a2
    end
    local v1 = u85[a1]
    if not v1 then
        u85[a1] = {}
    end
    local v2 = v1[a2]
    if not v2 then
        local v3 = table.clone(a1)
        for i in a2 do
            v3[i] = true
        end
        v1[a2] = (table.freeze(v3))
    end
    return v2
end

local function layoutSet(a1) -- Line: 298
    -- upvalues: u34 (val), kindOf (val), Get (val), union (val)
    local UIGridStyleLayout = a1:FindFirstChildWhichIsA("UIGridStyleLayout")
    if not UIGridStyleLayout then
        return u34
    end
    local v1 = kindOf(UIGridStyleLayout).Layout or nil
    if (Get(UIGridStyleLayout, "SortOrder")) ~= Enum.SortOrder.LayoutOrder then
        v1 = union(v1, u34)
    end
    return v1 or false
end

function u21.Suppressed(a1, a2) -- Line: 313
    -- upvalues: kindOf (val), result (ref), layoutSet (val), Get (val), union (val), u37 (val), u40 (val), u43 (val)
    -- upvalues: u46 (val), u49 (val), u52 (val), u55 (val)
    local v1 = kindOf(a1)
    local v2 = nil
    if not v1.Gui then
        if v1.Gradient then
            if not Get(a1, "Enabled") then
                return u52
            end
            return v2
        end
        if v1.Stroke then
            if not Get(a1, "Enabled") or (Get(a1, "Thickness")) <= 0 then
                v2 = u55
            end
        end
        return v2
    end
    local v3 = result(a1, "Parent")
    if v3 then
        local Layout = a2 and a2.Layout
        local v4 = Layout and Layout[v3]
        if v4 == nil then
            v4 = layoutSet(v3)
            if Layout then
                Layout[v3] = v4
            end
        end
        v2 = v4 or nil
    end
    if 1 <= (Get(a1, "BackgroundTransparency")) then
        v2 = union(v2, u37)
    elseif Get(a1, "BorderSizePixel") == 0 then
        v2 = union(v2, u40)
    end
    local Text = v1.Text
    if Text == 0 then
        if v1.Image then
            local v5 = true
            if Get(a1, "Image") ~= "" then
                v5 = 1 <= (Get(a1, "ImageTransparency"))
            end
            if v5 then
                return (union(v2, u49))
            end
        end
        return v2
    end
    if Get(a1, "TextScaled") then
        v2 = union(v2, u43)
    end
    if 1 <= (Get(a1, "TextTransparency")) then
        return (union(v2, u46))
    end
    if Text == 1 and Get(a1, "Text") == "" then
        return (union(v2, u46))
    end
    return v2
end

function u21.IsLayout(a1) -- Line: 363 -- upvalues: kindOf (val) -- types: a1: userdata
    return kindOf(a1).IsLayout
end

return (table.freeze(u21))