-- Script path: ReplicatedStorage.Client.ShrineFusionStatus
-- Decompile time: 14.00 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Data.Assets)
require(ReplicatedStorage.Shared.FusionShrines)
local Billboards = ReplicatedStorage.Assets.Billboards
local u15 = {}

local function child(a1, a2) -- Line: 13 -- types: a1: userdata, a2: string
    local v1 = a1:FindFirstChild(a2)
    assert(v1, (a1:GetFullName()) .. "." .. a2 .. " is missing")
    return v1
end

local function contentOf(a1) -- Line: 19 -- types: a1: userdata
    local Card = a1:FindFirstChild("Card")
    assert(Card, (a1:GetFullName()) .. ".Card is missing")
    local v1 = Card:FindFirstChild("Inner")
    assert(v1, (Card:GetFullName()) .. ".Inner is missing")
    local v2 = v1:FindFirstChild("Content")
    assert(v2, (v1:GetFullName()) .. ".Content is missing")
    return v2
end

local function statusOf(a1, a2) -- Line: 23 -- types: a1: userdata, a2: string
    local v1 = a1:FindFirstChild(a2)
    assert(v1, (a1:GetFullName()) .. "." .. a2 .. " is missing")
    local v2 = v1:FindFirstChild("Status")
    assert(v2, (v1:GetFullName()) .. ".Status is missing")
    assert(v2:IsA("TextLabel"), (v2:GetFullName()) .. " must be a TextLabel")
    return v2
end

local function styleOf(a1) -- Line: 29 -- types: a1: userdata
    local UIGradient = a1:FindFirstChildOfClass("UIGradient")
    return {Text = a1.Text, Color = if not UIGradient then nil else UIGradient.Color}
end

local function templateOf(a1) -- Line: 34 -- upvalues: Billboards (val)
    local v1 = Billboards:WaitForChild(a1.Billboard.Template)
    assert(v1:IsA("BillboardGui"), (v1:GetFullName()) .. " must be a BillboardGui")
    return v1
end

local function stylesOf(a1) -- Line: 40 -- upvalues: u15 (val), Billboards (val)
    local UIGradient, v1, v2, v3
    local v4 = u15[a1.Id]
    if v4 then
        return v4
    end
    local v5 = Billboards:WaitForChild(a1.Billboard.Template)
    assert(v5:IsA("BillboardGui"), (v5:GetFullName()) .. " must be a BillboardGui")
    local Card = v5:FindFirstChild("Card")
    assert(Card, (v5:GetFullName()) .. ".Card is missing")
    local v6 = Card:FindFirstChild("Inner")
    assert(v6, (Card:GetFullName()) .. ".Inner is missing")
    v4 = v6:FindFirstChild("Content")
    assert(v4, (v6:GetFullName()) .. ".Content is missing")
    v5 = {}
    local v7 = nil
    local v8 = nil
    for i, j in a1.Billboard.Styles, v7, v8 do
        v1 = v4:FindFirstChild(j)
        assert(v1, (v4:GetFullName()) .. "." .. j .. " is missing")
        v3 = v1:FindFirstChild("Status")
        assert(v3, (v1:GetFullName()) .. ".Status is missing")
        assert(v3:IsA("TextLabel"), (v3:GetFullName()) .. " must be a TextLabel")
        UIGradient = v3:FindFirstChildOfClass("UIGradient")
        v2 = {Text = v3.Text, Color = if not UIGradient then nil else UIGradient.Color}
        v5[i] = v2
    end
    u15[a1.Id] = v5
    return v5
end

local function apply(a1, a2, a3) -- Line: 54 -- types: a1: userdata, a2: table?, a3: string?
    a1.Text = a3 or (if not a2 then "LOADING" else a2.Text)
    local UIGradient = a1:FindFirstChildOfClass("UIGradient")
    if UIGradient and a2 and a2.Color then
        UIGradient.Color = a2.Color
    end
end

local function displayName(a1) -- Line: 62 -- upvalues: Assets (val)
    local v1 = if type(a1) ~= "string" then nil else Assets.Directory[a1]
    if v1 and type(v1.DisplayName) == "string" then
        return (string.upper(v1.DisplayName))
    end
    return nil
end

local u24 = {}

function u24.Tiers(a1, a2) -- Line: 70
    local Status, UIGradient, v1, v2
    local Columns = a1.Columns
    local v3 = nil
    local v4 = nil
    local v5, v6 = a2, a1
    for i, j in Columns, v3, v4 do
        v1 = if not v5.Ready then nil else if not v5.Status then nil else v5.Status[i]
        Status = j.Status
        v2 = v6.Styles[v1]
        Status.Text = if not v2 then "LOADING" else v2.Text
        UIGradient = Status:FindFirstChildOfClass("UIGradient")
        if UIGradient and v2 and v2.Color then
            UIGradient.Color = v2.Color
        end
    end
end

function u24.Sides(a1, a2) -- Line: 76 -- upvalues: Assets (val)
    local MISSING, Status, Status_2, Status_3, UIGradient, UIGradient_2, v1, v2, v3
    local v4 = a1.Kind.Tiers[1]
    local v5 = if not a2.Ready then nil else if not a2.Recipes then nil else a2.Recipes[v4]
    local Ready = a2.Ready and a2.Status and a2.Status[v4] == "COMPLETED"
    local READY = a1.Styles.READY
    local v6 = nil
    local v7 = nil
    for i, j in a1.Columns, v6, v7 do
        v2 = v5 and v5[j.Side]
        v3 = if type(v2) ~= "string" then nil else Assets.Directory[v2]
        v1 = if not v3 then nil else if type(v3.DisplayName) ~= "string" then nil else string.upper(v3.DisplayName)
        if v1 and j.Label then
            j.Label.Text = v1
        end
        if not a2.Ready then
            Status = j.Status
            Status.Text = "LOADING"
            if not Status:FindFirstChildOfClass("UIGradient") then end
        elseif not Ready then
            v2 = false
            if j.Pad ~= nil then
                v2 = j.Pad:GetAttribute("FusionActive") == true
            end
            Status_3 = j.Status
            MISSING = if not v2 then a1.Styles.MISSING else READY
            Status_3.Text = if not MISSING then "LOADING" else MISSING.Text
            UIGradient_2 = Status_3:FindFirstChildOfClass("UIGradient")
            if UIGradient_2 and MISSING and MISSING.Color then
                UIGradient_2.Color = MISSING.Color
            end
        else
            Status_2 = j.Status
            Status_2.Text = string.gsub(READY.Text, "READY", "COMPLETED") or (if not READY then "LOADING" else READY.Text)
            UIGradient = Status_2:FindFirstChildOfClass("UIGradient")
            if UIGradient and READY and READY.Color then
                UIGradient.Color = READY.Color
            end
        end
    end
end

local u27 = {}
u27.__index = u27

function u27:Update(a2) -- Line: 101 -- upvalues: u24 (val)
    u24[self.Kind.Billboard.Mode](self, a2)
end

function u27:Destroy() -- Line: 105
    for i, j in self.Guis do
        j:Destroy()
    end
    for k, n in self.Anchors do
        n:Destroy()
    end
end

local v1 = {}

local function place(a1, a2, a3, a4) -- Line: 116 -- types: a1: userdata, a2: userdata, a3: number?, a4: userdata
    a1.Name = "PersonalFusionStatus"
    a1.Adornee = a2
    a1.ResetOnSpawn = false
    a1.Enabled = true
    if a3 then
        a1.StudsOffsetWorldSpace = Vector3.new(0, a3, 0)
    end
    a1.Parent = a4
end

local function isolate(a1, a2, a3) -- Line: 127 -- types: a1: userdata, a3: string
    local v1
    local Card = a1:FindFirstChild("Card")
    assert(Card, (a1:GetFullName()) .. ".Card is missing")
    local v2 = Card:FindFirstChild("Inner")
    assert(v2, (Card:GetFullName()) .. ".Inner is missing")
    local v3 = v2:FindFirstChild("Content")
    assert(v3, (v2:GetFullName()) .. ".Content is missing")
    local v4 = a2.Billboard.Columns[a3]
    v2 = v3:FindFirstChild(v4)
    assert(v2, (v3:GetFullName()) .. "." .. v4 .. " is missing")
    for i, j in a2.Billboard.Columns do
        if i ~= a3 then
            v1 = v3:FindFirstChild(j)
            assert(v1, (v3:GetFullName()) .. "." .. j .. " is missing")
            v1.Visible = false
        end
    end
    local Scale = v2.Size.X.Scale
    v2.Size = UDim2.new(1, 0, v2.Size.Y.Scale, v2.Size.Y.Offset)
    v2 = v3:FindFirstChildOfClass("UIListLayout")
    if v2 then
        v2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    end
    v2 = math.clamp(Scale * 1.15, 0.2, 1)
    a1.Size = UDim2.new(a1.Size.X.Scale * v2, 0, a1.Size.Y.Scale, 0)
    local Card_2 = a1:FindFirstChild("Card")
    assert(Card_2, (a1:GetFullName()) .. ".Card is missing")
    v3 = Card_2:FindFirstChildOfClass("UIAspectRatioConstraint")
    if v3 then
        v3.AspectRatio = v3.AspectRatio * v2
    end
end

local function sideAnchor(a1) -- Line: 150 -- types: a1: userdata
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "FusionSideStatusAnchor"
    Attachment.Position = Vector3.new(0, a1.Size.Y / 2, 0)
    Attachment.Parent = a1
    return Attachment
end

function v1.new(a1, a2, a3, a4, a5) -- Line: 158
    -- upvalues: Billboards (val), isolate (val), stylesOf (val), u27 (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = Billboards:WaitForChild(a1.Billboard.Template)
    assert(v7:IsA("BillboardGui"), (v7:GetFullName()) .. " must be a BillboardGui")
    local StatusHeight = a1.PadVfx.StatusHeight
    local v8 = {}
    local v9 = {}
    local u263 = {}

    local function bind(a1_2, a2_2, a3) -- Line: 170
        -- upvalues: a1 (val), u263 (val), a2 (val)
        local Label, Name, Pad, v1, v2, v3, v4, v5
        local Card = a1_2:FindFirstChild("Card")
        assert(Card, (a1_2:GetFullName()) .. ".Card is missing")
        local v6 = Card:FindFirstChild("Inner")
        assert(v6, (Card:GetFullName()) .. ".Inner is missing")
        local v7 = v6:FindFirstChild("Content")
        assert(v7, (v6:GetFullName()) .. ".Content is missing")
        local v8 = nil
        local v9 = nil
        local v10 = a3
        for i, j in a2_2, v8, v9 do
            v5 = a1.Billboard.Columns[j]
            v1 = v7:FindFirstChild(v5)
            assert(v1, (v7:GetFullName()) .. "." .. v5 .. " is missing")
            Label = v1:FindFirstChild("Label")
            Name = if not v10 then j else v10.Name
            v2 = {}
            v4 = v7:FindFirstChild(v5)
            assert(v4, (v7:GetFullName()) .. "." .. v5 .. " is missing")
            v3 = v4:FindFirstChild("Status")
            assert(v3, (v4:GetFullName()) .. ".Status is missing")
            assert(v3:IsA("TextLabel"), (v3:GetFullName()) .. " must be a TextLabel")
            v2.Status = v3
            v2.Label = if not Label then nil else if not Label:IsA("TextLabel") then nil else Label
            v2.Side = j
            Pad = if not v10 then a2[j] else v10.Pad
            v2.Pad = Pad
            u263[Name] = v2
        end
    end

    if not a1.Billboard.PerSide then
        if not a1.Billboard.PerSide then
            v1 = v7:Clone()
            v1.Name = "PersonalFusionStatus"
            v1.Adornee = a3
            v1.ResetOnSpawn = false
            v1.Enabled = true
            if StatusHeight then
                v1.StudsOffsetWorldSpace = Vector3.new(0, StatusHeight, 0)
            end
            v1.Parent = a4
            v2 = {}
            for i in a1.Billboard.Columns do
                table.insert(v2, i)
            end
            bind(v1, v2)
            table.insert(v8, v1)
        else
            v2 = nil
            v3 = nil
            for j in a1.Billboard.Columns, v2, v3 do
                v4 = v7:Clone()
                isolate(v4, a1, j)
                v6 = a2[j]
                v5 = Instance.new("Attachment")
                v5.Name = "FusionSideStatusAnchor"
                v5.Position = Vector3.new(0, v6.Size.Y / 2, 0)
                v5.Parent = v6
                table.insert(v9, v5)
                v4.Name = "PersonalFusionStatus"
                v4.Adornee = v5
                v4.ResetOnSpawn = false
                v4.Enabled = true
                if StatusHeight then
                    v4.StudsOffsetWorldSpace = Vector3.new(0, StatusHeight, 0)
                end
                v4.Parent = v10
                bind(v4, {j})
                table.insert(v8, v4)
            end
        end
    elseif a5 then
        local Pad, v11
        local Placement = a1.Placement
        v3 = nil
        local v12 = nil
        for m, i5 in a5, v3, v12 do
            v5 = v7:Clone()
            isolate(v5, a1, i5.Side)
            Pad = i5.Pad
            v6 = Instance.new("Attachment")
            v6.Name = "FusionSideStatusAnchor"
            v6.Position = Vector3.new(0, Pad.Size.Y / 2, 0)
            v6.Parent = Pad
            table.insert(v9, v6)
            v11 = (if not Placement then nil else Placement.StatusHeights[i5.Side]) or StatusHeight
            v5.Name = "PersonalFusionStatus"
            v5.Adornee = v6
            v5.ResetOnSpawn = false
            v5.Enabled = true
            if v11 then
                v5.StudsOffsetWorldSpace = Vector3.new(0, v11, 0)
            end
            v5.Parent = v10
            bind(v5, {i5.Side}, i5)
            table.insert(v8, v5)
        end
    elseif not a1.Billboard.PerSide then
        v1 = v7:Clone()
        v1.Name = "PersonalFusionStatus"
        v1.Adornee = a3
        v1.ResetOnSpawn = false
        v1.Enabled = true
        if StatusHeight then
            v1.StudsOffsetWorldSpace = Vector3.new(0, StatusHeight, 0)
        end
        v1.Parent = a4
        v2 = {}
        for k in a1.Billboard.Columns do
            table.insert(v2, k)
        end
        bind(v1, v2)
        table.insert(v8, v1)
    else
        v2 = nil
        v3 = nil
        for n in a1.Billboard.Columns, v2, v3 do
            v4 = v7:Clone()
            isolate(v4, a1, n)
            v6 = a2[n]
            v5 = Instance.new("Attachment")
            v5.Name = "FusionSideStatusAnchor"
            v5.Position = Vector3.new(0, v6.Size.Y / 2, 0)
            v5.Parent = v6
            table.insert(v9, v5)
            v4.Name = "PersonalFusionStatus"
            v4.Adornee = v5
            v4.ResetOnSpawn = false
            v4.Enabled = true
            if StatusHeight then
                v4.StudsOffsetWorldSpace = Vector3.new(0, StatusHeight, 0)
            end
            v4.Parent = v10
            bind(v4, {n})
            table.insert(v8, v4)
        end
    end
    v1 = {
        Guis = v8,
        Anchors = v9,
        Kind = a1,
        Pads = a2,
        Columns = u263,
        Styles = stylesOf(a1),
    }
    local v13 = setmetatable(v1, u27)
    v13:Update({Ready = false})
    return v13
end

return table.freeze(v1)