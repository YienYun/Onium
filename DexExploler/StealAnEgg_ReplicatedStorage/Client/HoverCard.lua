-- Script path: ReplicatedStorage.Client.HoverCard
-- Decompile time: 34.44 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local Rarity = require(ReplicatedStorage.Data.Rarity)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
local ViewportSize = require(ReplicatedStorage.Client.ViewportSize)
local HoverCard = ReplicatedStorage.Assets.UI.Misc.HoverCard
local Card = HoverCard.Card
local Rows = HoverCard.Rows
local RarityGradients = ReplicatedStorage.Assets.UI.RarityGradients
local Rarities = Rarity.Rarities
local u69 = {
    ClipToDeviceSafeArea = false,
    DisplayOrder = 16384,
    Name = "HoverCardLayer",
    ResetOnSpawn = false,
    ScreenInsets = Enum.ScreenInsets.None,
    ZIndexBehavior = Enum.ZIndexBehavior.Global,
}
local u76 = Color3.new(1, 1, 1)
local u77 = {body = "Body", heading = "Heading", rule = "Rule", tier = "Tier"}
local u78 = {body = 190, heading = 240, tier = 280}
local u79 = {}
local u80 = nil
local u81 = nil

local function child(a1, a2) -- Line: 89 -- types: a1: userdata, a2: string
    local v1 = a1:FindFirstChild(a2)
    assert(v1, (("%* is missing %*"):format(a1:GetFullName(), a2)))
    return v1
end

local function layer() -- Line: 95 -- upvalues: u80 (ref), u69 (val), Players (val)
    local v1 = u80
    if v1 then
        return v1
    end
    local ScreenGui = Instance.new("ScreenGui")
    for i, j in u69 do
        ScreenGui[i] = j
    end
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    u80 = ScreenGui
    return ScreenGui
end

local function origin() -- Line: 111 -- upvalues: u80 (ref), u69 (val), Players (val)
    local v1
    local v2 = u80
    if not v2 then
        local ScreenGui = Instance.new("ScreenGui")
        for i, j in u69 do
            ScreenGui[i] = j
        end
        ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        u80 = ScreenGui
        v1 = ScreenGui
    else
        v1 = v2
    end
    return v1.AbsolutePosition
end

local function room() -- Line: 115 -- upvalues: u80 (ref), u69 (val), Players (val), Workspace (val)
    local v1
    local v2 = u80
    if not v2 then
        local ScreenGui = Instance.new("ScreenGui")
        for i, j in u69 do
            ScreenGui[i] = j
        end
        ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        u80 = ScreenGui
        v1 = ScreenGui
    else
        v1 = v2
    end
    local AbsoluteSize = v1.AbsoluteSize
    if 0 < AbsoluteSize.X and 0 < AbsoluteSize.Y then
        return AbsoluteSize
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        return CurrentCamera.ViewportSize
    end
    return Vector2.one
end

local function rectOf(a1) -- Line: 124 -- upvalues: u80 (ref), u69 (val), Players (val) -- types: a1: userdata
    local v1
    local v2 = {}
    local AbsolutePosition = a1.AbsolutePosition
    local v3 = u80
    if not v3 then
        local ScreenGui = Instance.new("ScreenGui")
        for i, j in u69 do
            ScreenGui[i] = j
        end
        ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        u80 = ScreenGui
        v1 = ScreenGui
    else
        v1 = v3
    end
    v2.origin = AbsolutePosition - v1.AbsolutePosition
    v2.size = a1.AbsoluteSize
    return v2
end

local function pointer() -- Line: 128 -- upvalues: UserInputService (val), u80 (ref), u69 (val), Players (val)
    local v1
    local MouseLocation = UserInputService:GetMouseLocation()
    local v2 = u80
    if not v2 then
        local ScreenGui = Instance.new("ScreenGui")
        for i, j in u69 do
            ScreenGui[i] = j
        end
        ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        u80 = ScreenGui
        v1 = ScreenGui
    else
        v1 = v2
    end
    return MouseLocation - v1.AbsolutePosition
end

local function contains(a1, a2) -- Line: 132 -- types: a1: table, a2: userdata
    local v1 = a2 - a1.origin
    local v2 = false
    if 0 <= v1.X then
        v2 = false
        if 0 <= v1.Y then
            v2 = false
            if v1.X <= a1.size.X then
                v2 = v1.Y <= a1.size.Y
            end
        end
    end
    return v2
end

local function overlaps(a1, a2) -- Line: 137 -- types: a1: table, a2: table
    local v1 = false
    if a1.origin.X < a2.origin.X + a2.size.X then
        v1 = false
        if a2.origin.X < a1.origin.X + a1.size.X then
            v1 = false
            if a1.origin.Y < a2.origin.Y + a2.size.Y then
                v1 = a2.origin.Y < a1.origin.Y + a1.size.Y
            end
        end
    end
    return v1
end

local function fitInside(a1, a2, a3) -- Line: 144 -- types: a1: userdata, a2: userdata, a3: userdata
    local v1 = (a3 - a2):Max(Vector2.zero)
    return (a1:Max(Vector2.zero)):Min(v1)
end

local function sideFacingCentre(a1) -- Line: 151
    -- upvalues: u80 (ref), u69 (val), Players (val), Workspace (val)
    local ViewportSize, v1
    local v2 = u80
    if not v2 then
        local ScreenGui = Instance.new("ScreenGui")
        for i, j in u69 do
            ScreenGui[i] = j
        end
        ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        u80 = ScreenGui
        v1 = ScreenGui
    else
        v1 = v2
    end
    local AbsoluteSize = v1.AbsoluteSize
    if not (0 < AbsoluteSize.X) or not (0 < AbsoluteSize.Y) then
        local CurrentCamera = Workspace.CurrentCamera
        ViewportSize = if not CurrentCamera then Vector2.one else CurrentCamera.ViewportSize
    else
        ViewportSize = AbsoluteSize
    end
    return Vector2.new(if not (a1.X <= ViewportSize.X / 2) then -1 else 1, if not (a1.Y <= ViewportSize.Y / 2) then -1 else 1)
end

local function settle(a1, a2, a3) -- Line: 156
    -- upvalues: u80 (ref), u69 (val), Players (val), Workspace (val)
    local ViewportSize, v1
    local v2 = u80
    if not v2 then
        local ScreenGui = Instance.new("ScreenGui")
        for i, j in u69 do
            ScreenGui[i] = j
        end
        ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        u80 = ScreenGui
        v1 = ScreenGui
    else
        v1 = v2
    end
    local AbsoluteSize = v1.AbsoluteSize
    if not (0 < AbsoluteSize.X) or not (0 < AbsoluteSize.Y) then
        local CurrentCamera = Workspace.CurrentCamera
        ViewportSize = if not CurrentCamera then Vector2.one else CurrentCamera.ViewportSize
    else
        ViewportSize = AbsoluteSize
    end
    v1 = (ViewportSize - a3):Max(Vector2.zero)
    local v3 = (a2:Max(Vector2.zero)):Min(v1)
    a1.AnchorPoint = Vector2.zero
    a1.Position = UDim2.fromOffset(v3.X, v3.Y)
end

local function placeAtPointer(a1, a2, a3) -- Line: 162
    -- upvalues: u80 (ref), u69 (val), Players (val), Workspace (val)
    local ViewportSize, v1
    local side = a1.side
    local clearance = a1.clearance
    local card = a1.card
    local v2 = Vector2.new(
        if not (0 < side.X) then a2.X - clearance - a3.X else a2.X + clearance,
        if not (0 < side.Y) then a2.Y - clearance - a3.Y else a2.Y + clearance
    )
    local v3 = u80
    if not v3 then
        local ScreenGui = Instance.new("ScreenGui")
        for i, j in u69 do
            ScreenGui[i] = j
        end
        ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        u80 = ScreenGui
        v1 = ScreenGui
    else
        v1 = v3
    end
    local AbsoluteSize = v1.AbsoluteSize
    if not (0 < AbsoluteSize.X) or not (0 < AbsoluteSize.Y) then
        local CurrentCamera = Workspace.CurrentCamera
        ViewportSize = if not CurrentCamera then Vector2.one else CurrentCamera.ViewportSize
    else
        ViewportSize = AbsoluteSize
    end
    v1 = (ViewportSize - a3):Max(Vector2.zero)
    local v4 = (v2:Max(Vector2.zero)):Min(v1)
    card.AnchorPoint = Vector2.zero
    card.Position = UDim2.fromOffset(v4.X, v4.Y)
end

local function hintsFrameFor(a1) -- Line: 170 -- types: a1: userdata
    local GamepadHintsFrame
    local v1 = a1:FindFirstAncestorOfClass("ScreenGui")
    local Parent = a1.Parent
    while Parent ~= nil do
        if Parent == v1 then
            break
        end
        GamepadHintsFrame = Parent:FindFirstChild("GamepadHintsFrame")
        if GamepadHintsFrame and GamepadHintsFrame:IsA("GuiObject") and GamepadHintsFrame.Visible then
            return GamepadHintsFrame
        end
        Parent = Parent.Parent
    end
    return nil
end

local function placeBeside(a1, a2) -- Line: 183
    -- upvalues: u80 (ref), u69 (val), Players (val), Workspace (val), hintsFrameFor (val), overlaps (val)
    local AbsoluteSize_3, CurrentCamera_3, ScreenGui_4, ViewportSize, ViewportSize_2, ViewportSize_3, card_2, v1, v2, v3, v4, v5, v6, v7, zero_4, zero_6
    local side = a1.side
    local clearance = a1.clearance
    local source = a1.source
    local v8 = {}
    local AbsolutePosition = source.AbsolutePosition
    local v9 = u80
    if not v9 then
        local ScreenGui = Instance.new("ScreenGui")
        for i, j in u69 do
            ScreenGui[i] = j
        end
        ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        u80 = ScreenGui
        v7 = ScreenGui
    else
        v7 = v9
    end
    v8.origin = AbsolutePosition - v7.AbsolutePosition
    v8.size = source.AbsoluteSize
    local v10 = u80
    if not v10 then
        local ScreenGui_2 = Instance.new("ScreenGui")
        for k, n in u69 do
            ScreenGui_2[k] = n
        end
        ScreenGui_2.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        u80 = ScreenGui_2
        v6 = ScreenGui_2
    else
        v6 = v10
    end
    local AbsoluteSize = v6.AbsoluteSize
    if not (0 < AbsoluteSize.X) or not (0 < AbsoluteSize.Y) then
        local CurrentCamera = Workspace.CurrentCamera
        ViewportSize = if not CurrentCamera then Vector2.one else CurrentCamera.ViewportSize
    else
        ViewportSize = AbsoluteSize
    end
    v6 = v8.origin + (v8.size - a2) / 2
    v10 = v8.origin.Y + v8.size.Y + clearance
    v7 = v8.origin.Y - clearance - a2.Y
    v9 = v8.origin.X + v8.size.X + clearance
    local v11 = v8.origin.X - clearance - a2.X
    v8 = {
        Vector2.new(v6.X, if not (0 < side.Y) then v7 else v10),
        Vector2.new(v6.X, if not (0 < side.Y) then v10 else v7),
        Vector2.new(if not (0 < side.X) then v11 else v9, v6.Y),
        (Vector2.new(if not (0 < side.X) then v9 else v11, v6.Y)),
    }
    v11 = hintsFrameFor(a1.source)
    if not v11 then
        v9 = nil
    else
        v9 = {}
        local AbsolutePosition_2 = v11.AbsolutePosition
        v7 = u80
        if not v7 then
            v7 = Instance.new("ScreenGui")
            for m, i5 in u69 do
                v7[m] = i5
            end
            v7.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
            u80 = v7
        end
        v9.origin = AbsolutePosition_2 - v7.AbsolutePosition
        v9.size = v11.AbsoluteSize
    end
    local v12 = nil
    local v13 = nil
    for i6, i7 in v8, v12, v13 do
        v10 = (ViewportSize - a2):Max(Vector2.zero)
        zero_4 = Vector2.zero
        v1 = i7:Max(zero_4)
        v11 = i7 == v1:Min(v10)
        v6 = true
        if v9 ~= nil then
            v6 = not overlaps({origin = i7, size = a2}, v9)
        end
        if v11 and v6 then
            card_2 = a1.card
            v2 = u80
            if not v2 then
                ScreenGui_4 = Instance.new("ScreenGui")
                for i8, i9 in u69 do
                    ScreenGui_4[i8] = i9
                end
                ScreenGui_4.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
                u80 = ScreenGui_4
                v3 = ScreenGui_4
            else
                v3 = v2
            end
            AbsoluteSize_3 = v3.AbsoluteSize
            if not (0 < AbsoluteSize_3.X) or not (0 < AbsoluteSize_3.Y) then
                CurrentCamera_3 = Workspace.CurrentCamera
                ViewportSize_3 = if not CurrentCamera_3 then Vector2.one else CurrentCamera_3.ViewportSize
            else
                ViewportSize_3 = AbsoluteSize_3
            end
            v2 = (ViewportSize_3 - a2):Max(Vector2.zero)
            zero_6 = Vector2.zero
            v4 = (i7:Max(zero_6)):Min(v2)
            card_2.AnchorPoint = Vector2.zero
            card_2.Position = UDim2.fromOffset(v4.X, v4.Y)
            return
        end
    end
    local card = a1.card
    v12 = v8[1]
    local v14 = u80
    if not v14 then
        local ScreenGui_3 = Instance.new("ScreenGui")
        for i10, i11 in u69 do
            ScreenGui_3[i10] = i11
        end
        ScreenGui_3.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        u80 = ScreenGui_3
        v5 = ScreenGui_3
    else
        v5 = v14
    end
    local AbsoluteSize_2 = v5.AbsoluteSize
    if not (0 < AbsoluteSize_2.X) or not (0 < AbsoluteSize_2.Y) then
        local CurrentCamera_2 = Workspace.CurrentCamera
        ViewportSize_2 = if not CurrentCamera_2 then Vector2.one else CurrentCamera_2.ViewportSize
    else
        ViewportSize_2 = AbsoluteSize_2
    end
    v14 = (ViewportSize_2 - a2):Max(Vector2.zero)
    v9 = (v12:Max(Vector2.zero)):Min(v14)
    card.AnchorPoint = Vector2.zero
    card.Position = UDim2.fromOffset(v9.X, v9.Y)
end

local function stripMarkup(a1) -- Line: 214 -- types: a1: string
    return (string.gsub(a1, "<[^<>]*>", ""))
end

local function looksMarkedUp(a1) -- Line: 218 -- types: a1: string
    return string.find(a1, "<%a[^<>]*>") ~= nil
end

local function measure(a1, a2, a3) -- Line: 222
    -- upvalues: TextService (val)
    local GetTextBoundsParams = Instance.new("GetTextBoundsParams")
    GetTextBoundsParams.Font = a1.FontFace
    GetTextBoundsParams.Size = a1.TextSize
    GetTextBoundsParams.Text = string.gsub(a2, "<[^<>]*>", "")
    GetTextBoundsParams.Width = a3
    local success, err = pcall(function() -- Line: 228 -- upvalues: TextService (upval), GetTextBoundsParams (val)
        return TextService:GetTextBoundsAsync(GetTextBoundsParams)
    end)
    if success and typeof(err) == "Vector2" then
        return err
    end
    return Vector2.new(a3, a1.TextSize)
end

local function cardScale() -- Line: 237 -- upvalues: ViewportSize (val)
    return (math.sqrt((math.min(ViewportSize.ReadScale(), 1))))
end

local function labelInset(a1) -- Line: 241 -- types: a1: userdata
    local UIStroke = a1:FindFirstChildOfClass("UIStroke")
    local Thickness = if not UIStroke then 0 else UIStroke.Thickness
    return Vector2.new(math.round(a1.TextSize / 4), 0) * 2 + Vector2.one * (Thickness * 2)
end

local function paintGradient(a1, a2) -- Line: 250 -- types: a1: userdata, a2: userdata
    local UIGradient = a1:FindFirstChildOfClass("UIGradient")
    if UIGradient == nil then
        a2:Clone().Parent = a1
        return
    end
    UIGradient.Color = a2.Color
    UIGradient.Enabled = a2.Enabled
    UIGradient.Offset = a2.Offset
    UIGradient.Rotation = a2.Rotation
    UIGradient.Transparency = a2.Transparency
end

local function gradientNamed(a1) -- Line: 263 -- upvalues: RarityGradients (val)
    if type(a1) ~= "string" then
        return nil
    end
    local v1 = RarityGradients:FindFirstChild(a1)
    if v1 and v1:IsA("UIGradient") then
        return v1
    end
    return nil
end

local function styleText(a1, a2) -- Line: 271
    -- upvalues: RarityGradients (val), u76 (val)
    local v1
    local v2 = tostring(a2.text or "")
    a1.RichText = string.find(v2, "<%a[^<>]*>") ~= nil
    a1.Text = v2
    if typeof(a2.tint) == "Color3" then
        a1.TextColor3 = a2.tint
    end
    local gradient = a2.gradient
    if type(gradient) == "string" then
        local v3 = RarityGradients:FindFirstChild(gradient)
        v1 = if not v3 then nil else if not v3:IsA("UIGradient") then nil else v3
    else
        v1 = nil
    end
    if v1 then
        a1.TextColor3 = u76
        local UIGradient = a1:FindFirstChildOfClass("UIGradient")
        if UIGradient == nil then
            v1:Clone().Parent = a1
            return v2
        end
        UIGradient.Color = v1.Color
        UIGradient.Enabled = v1.Enabled
        UIGradient.Offset = v1.Offset
        UIGradient.Rotation = v1.Rotation
        UIGradient.Transparency = v1.Transparency
    end
    return v2
end

local function rarityConfig(a1) -- Line: 286 -- upvalues: Rarities (val)
    local v1
    assert(if type(a1) ~= "table" then Rarities[a1] else a1, (("Unknown rarity: %*"):format((tostring(a1)))))
    return v1
end

local u106 = {body = styleText, heading = styleText}

function u106.tier(a1, a2) -- Line: 292 -- upvalues: Rarities (val) -- types: a1: userdata, a2: table
    local v1
    local rarity = a2.rarity
    assert(if type(rarity) ~= "table" then Rarities[rarity] else rarity, (("Unknown rarity: %*"):format((tostring(rarity)))))
    a1.Text = v1.DisplayName
    local RarityGradient = v1.RarityGradient
    local UIGradient = a1:FindFirstChildOfClass("UIGradient")
    if UIGradient ~= nil then
        UIGradient.Color = RarityGradient.Color
        UIGradient.Enabled = RarityGradient.Enabled
        UIGradient.Offset = RarityGradient.Offset
        UIGradient.Rotation = RarityGradient.Rotation
        UIGradient.Transparency = RarityGradient.Transparency
    else
        RarityGradient:Clone().Parent = a1
    end
    local UIStroke = a1:FindFirstChildOfClass("UIStroke")
    if UIStroke then
        local RarityGradient_2 = v1.RarityGradient
        local UIGradient_2 = UIStroke:FindFirstChildOfClass("UIGradient")
        if UIGradient_2 ~= nil then
            UIGradient_2.Color = RarityGradient_2.Color
            UIGradient_2.Enabled = RarityGradient_2.Enabled
            UIGradient_2.Offset = RarityGradient_2.Offset
            UIGradient_2.Rotation = RarityGradient_2.Rotation
            UIGradient_2.Transparency = RarityGradient_2.Transparency
        else
            RarityGradient_2:Clone().Parent = UIStroke
        end
    end
    return v1.DisplayName
end

local function buildBlock(a1, a2) -- Line: 309
    -- upvalues: u77 (val), Rows (val), u106 (val), u78 (val), measure (val)
    local v1 = tostring(a1.kind)
    local v2 = u77[v1]
    local v3 = ("Unknown hover card row kind: %*"):format(v1)
    assert(v2 ~= nil, v3)
    local v4 = Rows:FindFirstChild(v2)
    local v5 = ("Missing hover card row template: %*"):format(v2)
    assert(v4 and v4:IsA("GuiObject"), v5)
    local v6 = v4:Clone()
    v6.LayoutOrder = a2
    v4 = u106[v1]
    if v4 == nil then
        return {width = 72, frame = v6, height = v6.Size.Y.Offset}
    end
    local title = v6:FindFirstChild("title")
    local v7 = ("Hover card row template %* needs a title label"):format(v2)
    assert(title and title:IsA("TextLabel"), v7)
    v2 = v4(title, a1)
    v4 = u78[v1]
    v5 = measure(title, v2, v4)
    local UIStroke = title:FindFirstChildOfClass("UIStroke")
    local Thickness = if not UIStroke then 0 else UIStroke.Thickness
    v1 = v5 + (Vector2.new(math.round(title.TextSize / 4), 0) * 2 + Vector2.one * (Thickness * 2))
    v2 = math.max(math.ceil(v1.Y), title.TextSize)
    v6.Size = UDim2.new(1, 0, 0, v2)
    return {
        frame = v6,
        height = v2,
        width = math.clamp(math.ceil(v1.X), 72, v4),
    }
end

local function follow(a1, a2) -- Line: 339
    -- upvalues: GamepadBindings (val), u79 (val), placeBeside (val), placeAtPointer (val), UserInputService (val)
    -- upvalues: u80 (ref), u69 (val), Players (val)
    local v1
    if not GamepadBindings.IsOnScreen(a1.source) then
        u79.Dismiss()
        return
    end
    local AbsoluteSize = a2 or a1.card.AbsoluteSize
    if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
        AbsoluteSize = a1.footprint
    end
    if a1.viaSelection then
        placeBeside(a1, AbsoluteSize)
        return
    end
    local MouseLocation = UserInputService:GetMouseLocation()
    local v2 = u80
    if not v2 then
        local ScreenGui = Instance.new("ScreenGui")
        for i, j in u69 do
            ScreenGui[i] = j
        end
        ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        u80 = ScreenGui
        v1 = ScreenGui
    else
        v1 = v2
    end
    placeAtPointer(a1, MouseLocation - v1.AbsolutePosition, AbsoluteSize)
end

local function stillHovered(a1) -- Line: 356
    -- upvalues: GuiService (val), u80 (ref), u69 (val), Players (val), UserInputService (val)
    local v1, v2
    if a1.viaSelection then
        return GuiService.SelectedObject == a1.source
    end
    local source = a1.source
    local v3 = {}
    local AbsolutePosition = source.AbsolutePosition
    local v4 = u80
    if not v4 then
        local ScreenGui = Instance.new("ScreenGui")
        for i, j in u69 do
            ScreenGui[i] = j
        end
        ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        u80 = ScreenGui
        v2 = ScreenGui
    else
        v2 = v4
    end
    v3.origin = AbsolutePosition - v2.AbsolutePosition
    v3.size = source.AbsoluteSize
    local MouseLocation = UserInputService:GetMouseLocation()
    v2 = u80
    if not v2 then
        local ScreenGui_2 = Instance.new("ScreenGui")
        for k, n in u69 do
            ScreenGui_2[k] = n
        end
        ScreenGui_2.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        u80 = ScreenGui_2
        v1 = ScreenGui_2
    else
        v1 = v2
    end
    local v5 = MouseLocation - v1.AbsolutePosition - v3.origin
    local v6 = false
    if 0 <= v5.X then
        v6 = false
        if 0 <= v5.Y then
            v6 = false
            if v5.X <= v3.size.X then
                v6 = v5.Y <= v3.size.Y
            end
        end
    end
    return v6
end

local function dismissWhenLeft(a1) -- Line: 363 -- upvalues: u79 (val), GuiService (val) -- types: a1: table
    local source = a1.source
    local links = a1.links
    links:Connect(if not a1.viaSelection then source.MouseLeave else source.SelectionLost, u79.Dismiss)
    links:Connect(source.Destroying, u79.Dismiss)
    if a1.viaSelection then
        links:Connect(GuiService:GetPropertyChangedSignal("SelectedObject"), function() -- Line: 370 -- upvalues: GuiService (upval), source (val), u79 (upval)
            if GuiService.SelectedObject ~= source then
                u79.Dismiss()
            end
        end)
    end
end

local function present(a1, a2, a3) -- Line: 378
    -- upvalues: u79 (val), Card (val), Trove (val), GuiService (val), u81 (ref), dismissWhenLeft (val)
    -- upvalues: buildBlock (val), u80 (ref), u69 (val), Players (val), ViewportSize (val), UserInputService (val)
    -- upvalues: Workspace (val), Audio (val), follow (val), RunService (val)
    local ViewportSize_2, v1
    u79.Dismiss()
    if #a2 == 0 then
        return
    end
    local v2 = Card:Clone()
    v2.Visible = false
    local Frame = v2:FindFirstChild("Frame")
    assert(Frame, (("%* is missing Frame"):format((v2:GetFullName()))))
    local v3 = Frame:FindFirstChild("Rows")
    assert(v3, (("%* is missing Rows"):format((Frame:GetFullName()))))
    local v4 = assert(v3:FindFirstChildOfClass("UIListLayout"), "Hover card template needs a UIListLayout under Rows")
    local v5 = assert(v3:FindFirstChildOfClass("UIPadding"), "Hover card template needs a UIPadding under Rows")
    local u55 = {clearance = 12, card = v2, footprint = Vector2.zero}
    u55.links = Trove.new()
    u55.side = Vector2.one
    u55.source = a1
    u55.viaSelection = if a3 ~= nil then a3 else GuiService.SelectedObject == a1
    u81 = u55
    u55.links:Add(v2)
    dismissWhenLeft(u55)
    local v6 = 72
    local v7 = v4.Padding.Offset * (#a2 - 1)
    local v8 = nil
    local v9 = nil
    for i, j in a2, v8, v9 do
        v1 = buildBlock(j, i)
        if u81 ~= u55 then
            return
        end
        v6 = math.max(v6, v1.width)
        v7 = v7 + v1.height
        v1.frame.Parent = v3
    end
    v3 = u80
    if not v3 then
        v3 = Instance.new("ScreenGui")
        for k, n in u69 do
            v3[k] = n
        end
        v3.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        u80 = v3
    end
    v2.Parent = v3
    task.wait()
    if u81 ~= u55 then
        return
    end
    local AbsoluteContentSize = v4.AbsoluteContentSize
    v4 = v6 + v5.PaddingLeft.Offset + v5.PaddingRight.Offset
    v6 = (if not (0 < AbsoluteContentSize.Y) then v7 else AbsoluteContentSize.Y) + v5.PaddingTop.Offset + v5.PaddingBottom.Offset
    local v10 = math.sqrt((math.min(ViewportSize.ReadScale(), 1)))
    v7 = v2:FindFirstChild("UIScale")
    assert(v7, (("%* is missing UIScale"):format((v2:GetFullName()))))
    v7.Scale = v10
    v2.Size = UDim2.fromOffset(v4, v6)
    u55.clearance = v10 * 12
    u55.footprint = Vector2.new(v4, v6) * v10
    if not u55.viaSelection then
        v10 = nil
    else
        v10 = {}
        local AbsolutePosition = a1.AbsolutePosition
        v7 = u80
        if not v7 then
            v7 = Instance.new("ScreenGui")
            for m, i5 in u69 do
                v7[m] = i5
            end
            v7.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
            u80 = v7
        end
        v10.origin = AbsolutePosition - v7.AbsolutePosition
        v10.size = a1.AbsoluteSize
    end
    if not v10 then
        local MouseLocation = UserInputService:GetMouseLocation()
        v6 = u80
        if not v6 then
            v6 = Instance.new("ScreenGui")
            for i6, i7 in u69 do
                v6[i6] = i7
            end
            v6.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
            u80 = v6
        end
        v9 = MouseLocation - v6.AbsolutePosition
    else
        v9 = v10.origin + v10.size / 2
    end
    local v11 = u80
    if not v11 then
        local ScreenGui = Instance.new("ScreenGui")
        for i8, i9 in u69 do
            ScreenGui[i8] = i9
        end
        ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
        u80 = ScreenGui
        v4 = ScreenGui
    else
        v4 = v11
    end
    local AbsoluteSize = v4.AbsoluteSize
    if not (0 < AbsoluteSize.X) or not (0 < AbsoluteSize.Y) then
        local CurrentCamera = Workspace.CurrentCamera
        ViewportSize_2 = if not CurrentCamera then Vector2.one else CurrentCamera.ViewportSize
    else
        ViewportSize_2 = AbsoluteSize
    end
    u55.side = Vector2.new(if not (v9.X <= ViewportSize_2.X / 2) then -1 else 1, if not (v9.Y <= ViewportSize_2.Y / 2) then -1 else 1)
    if not u55.viaSelection then
        local source = u55.source
        v9 = {}
        local AbsolutePosition_2 = source.AbsolutePosition
        v10 = u80
        if not v10 then
            v10 = Instance.new("ScreenGui")
            for i10, i11 in u69 do
                v10[i10] = i11
            end
            v10.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
            u80 = v10
        end
        v9.origin = AbsolutePosition_2 - v10.AbsolutePosition
        v9.size = source.AbsoluteSize
        local MouseLocation_2 = UserInputService:GetMouseLocation()
        local v12 = u80
        if not v12 then
            local ScreenGui_2 = Instance.new("ScreenGui")
            for i12, i13 in u69 do
                ScreenGui_2[i12] = i13
            end
            ScreenGui_2.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
            u80 = ScreenGui_2
            v1 = ScreenGui_2
        else
            v1 = v12
        end
        local v13 = MouseLocation_2 - v1.AbsolutePosition - v9.origin
        v8 = false
        if 0 <= v13.X then
            v8 = false
            if 0 <= v13.Y then
                v8 = false
                if v13.X <= v9.size.X then
                    v8 = v13.Y <= v9.size.Y
                end
            end
        end
    else
        v8 = GuiService.SelectedObject == u55.source
    end
    if not v8 then
        u79.Dismiss()
        return
    end
    Audio.Play("rbxassetid://89944486811970", script, {Volume = 0.3})
    follow(u55, u55.footprint)
    if u81 ~= u55 then
        return
    end
    v2.Visible = true
    u55.links:Connect(RunService.RenderStepped, function() -- Line: 444 -- upvalues: follow (upval), u55 (val)
        follow(u55)
    end)
end

function u79.Show(a1, a2) -- Line: 451 -- upvalues: present (val) -- types: a1: userdata, a2: table
    present(a1, a2, nil)
end

function u79.Attach(a1, a2) -- Line: 458
    -- upvalues: present (val), Trove (val), u81 (ref), u79 (val)
    local function reveal(a1_2) -- Line: 459 -- upvalues: a2 (val), present (upval), a1 (val) -- types: a1_2: boolean
        local v1 = if type(a2) ~= "function" then a2 else a2()
        if v1 then
            present(a1, v1, a1_2)
        end
    end

    local u5 = Trove.new()
    u5:Connect(a1.MouseEnter, function() -- Line: 467 -- upvalues: a2 (val), present (upval), a1 (val)
        local v1 = if type(a2) ~= "function" then a2 else a2()
        if v1 then
            present(a1, v1, false)
        end
    end)
    u5:Connect(a1.SelectionGained, function() -- Line: 470 -- upvalues: a2 (val), present (upval), a1 (val)
        local v1 = if type(a2) ~= "function" then a2 else a2()
        if v1 then
            present(a1, v1, true)
        end
    end)
    u5:Add(function() -- Line: 473 -- upvalues: u81 (upval), a1 (val), u79 (upval)
        local v1 = u81
        if v1 and v1.source == a1 then
            u79.Dismiss()
        end
    end)
    return function() -- Line: 480 -- upvalues: u5 (val)
        u5:Destroy()
    end
end

function u79.Dismiss() -- Line: 485 -- upvalues: u81 (ref)
    local v1 = u81
    if v1 == nil then
        return
    end
    u81 = nil
    v1.links:Destroy()
end

Tabs.Deactivated:Connect(function() -- Line: 494 -- upvalues: u79 (val)
    u79.Dismiss()
end)
return u79