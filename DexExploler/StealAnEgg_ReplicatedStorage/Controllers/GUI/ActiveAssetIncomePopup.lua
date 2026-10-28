-- Script path: ReplicatedStorage.Controllers.GUI.ActiveAssetIncomePopup
-- Decompile time: 7.48 ms

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VisibleBounds = require(ReplicatedStorage.Shared.Utils.VisibleBounds)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Cash = ReplicatedStorage.Assets.Extra.Cash
assert(Cash:IsA("BillboardGui"), "Assets.Extra.Cash must be a BillboardGui")
local v1 = {}

local function playOnce(a1, a2, a3) -- Line: 37
    -- upvalues: TweenService (val)
    local u9 = TweenService:Create(a1, a2, a3)
    u9.Completed:Once(function() -- Line: 39 -- upvalues: u9 (val)
        u9:Destroy()
    end)
    u9:Play()
end

local function scaleBillboardSize(a1, a2) -- Line: 45 -- types: a1: CFrame, a2: number
    return UDim2.new(a1.X.Scale * a2, a1.X.Offset * a2, a1.Y.Scale * a2, a1.Y.Offset * a2)
end

local function getBillboardScale(a1) -- Line: 54 -- types: a1: vector
    local v1 = math.min(a1.X / 2, a1.Y / 5.72646427154541, a1.Z / 5.299603462219238)
    if v1 <= 0 then
        return 0.9
    end
    return (math.clamp(v1, 0.9, 5))
end

local function fadeTextLabel(a1, a2, a3, a4) -- Line: 67
    -- upvalues: TweenService (val)
    a1.Text = a2
    a1.TextTransparency = 1
    local u12 = TweenService:Create(a1, a3, {TextTransparency = 0})
    u12.Completed:Once(function() -- Line: 39 -- upvalues: u12 (val)
        u12:Destroy()
    end)
    u12:Play()
    task.delay(0.8499999999999999, function() -- Line: 78 -- upvalues: a1 (val), a4 (val), TweenService (upval)
        if a1.Parent then
            local u11 = TweenService:Create(a1, a4, {TextTransparency = 1})
            u11.Completed:Once(function() -- Line: 39 -- upvalues: u11 (val)
                u11:Destroy()
            end)
            u11:Play()
        end
    end)
end

local function fadeTextButton(a1, a2, a3, a4) -- Line: 87
    -- upvalues: TweenService (val)
    a1.Text = a2
    a1.TextTransparency = 1
    local u12 = TweenService:Create(a1, a3, {TextTransparency = 0})
    u12.Completed:Once(function() -- Line: 39 -- upvalues: u12 (val)
        u12:Destroy()
    end)
    u12:Play()
    task.delay(0.8499999999999999, function() -- Line: 98 -- upvalues: a1 (val), a4 (val), TweenService (upval)
        if a1.Parent then
            local u11 = TweenService:Create(a1, a4, {TextTransparency = 1})
            u11.Completed:Once(function() -- Line: 39 -- upvalues: u11 (val)
                u11:Destroy()
            end)
            u11:Play()
        end
    end)
end

local function fadeTextBox(a1, a2, a3, a4) -- Line: 107
    -- upvalues: TweenService (val)
    a1.Text = a2
    a1.TextTransparency = 1
    local u12 = TweenService:Create(a1, a3, {TextTransparency = 0})
    u12.Completed:Once(function() -- Line: 39 -- upvalues: u12 (val)
        u12:Destroy()
    end)
    u12:Play()
    task.delay(0.8499999999999999, function() -- Line: 118 -- upvalues: a1 (val), a4 (val), TweenService (upval)
        if a1.Parent then
            local u11 = TweenService:Create(a1, a4, {TextTransparency = 1})
            u11.Completed:Once(function() -- Line: 39 -- upvalues: u11 (val)
                u11:Destroy()
            end)
            u11:Play()
        end
    end)
end

local function fadeImageObject(a1, a2, a3) -- Line: 127
    -- upvalues: TweenService (val)
    a1.ImageTransparency = 1
    local u11 = TweenService:Create(a1, a2, {ImageTransparency = 0})
    u11.Completed:Once(function() -- Line: 39 -- upvalues: u11 (val)
        u11:Destroy()
    end)
    u11:Play()
    task.delay(0.8499999999999999, function() -- Line: 137 -- upvalues: a1 (val), a3 (val), TweenService (upval)
        if a1.Parent then
            local u11 = TweenService:Create(a1, a3, {ImageTransparency = 1})
            u11.Completed:Once(function() -- Line: 39 -- upvalues: u11 (val)
                u11:Destroy()
            end)
            u11:Play()
        end
    end)
end

local function fadePopupDescendants(a1, a2, a3, a4) -- Line: 146
    -- upvalues: fadeTextLabel (val), fadeTextButton (val), fadeTextBox (val), TweenService (val), fadeImageObject (val)
    local v1, v2 = a2, a3
    for i, v in ipairs(a1:GetDescendants()) do
        if v:IsA("TextLabel") then
            fadeTextLabel(v, v1, v2, a4)
        elseif v:IsA("TextButton") then
            fadeTextButton(v, v1, v2, a4)
        elseif v:IsA("TextBox") then
            fadeTextBox(v, v1, v2, a4)
        elseif v:IsA("UIStroke") then
            v.Transparency = 1
            local u63 = TweenService:Create(v, v2, {Transparency = 0})
            u63.Completed:Once(function() -- Line: 39 -- upvalues: u63 (val)
                u63:Destroy()
            end)
            u63:Play()
            task.delay(0.8499999999999999, function() -- Line: 164 -- upvalues: v (val), a4 (val), TweenService (upval)
                if v.Parent then
                    local u11 = TweenService:Create(v, a4, {Transparency = 1})
                    u11.Completed:Once(function() -- Line: 39 -- upvalues: u11 (val)
                        u11:Destroy()
                    end)
                    u11:Play()
                end
            end)
        elseif v:IsA("ImageLabel") or v:IsA("ImageButton") then
            fadeImageObject(v, v2, a4)
        end
    end
end

local function showAtCFrame(a1, a2, a3, a4, a5) -- Line: 177
    -- upvalues: Cash (val), fadePopupDescendants (val), Simple (val), TweenService (val), Debris (val)
    local Attachment = Instance.new("Attachment")
    Attachment.Name = "SyncedIncomeCashAttachment"
    Attachment.WorldCFrame = a1
    Attachment.Parent = workspace.Terrain
    local v1 = Cash:Clone()
    v1.Name = "SyncedIncomeCash"
    v1.Adornee = Attachment
    v1.Parent = Attachment
    v1.AlwaysOnTop = if not a3 then true else if a3.alwaysOnTop == nil then true else a3.alwaysOnTop
    local Size = v1.Size
    v1.Size = UDim2.new(Size.X.Scale * a5, Size.X.Offset * a5, Size.Y.Scale * a5, Size.Y.Offset * a5)
    fadePopupDescendants(
        v1,
        ("+$%*"):format((Simple.FormatCompact((math.round(a2))))),
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    )
    local u90 = TweenService:Create(
        Attachment,
        TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {WorldPosition = a1.Position + Vector3.new(0, a4, 0)}
    )
    u90.Completed:Once(function() -- Line: 39 -- upvalues: u90 (val)
        u90:Destroy()
    end)
    u90:Play()
    Debris:AddItem(v1, 1.4)
    Debris:AddItem(Attachment, 1.4)
end

function v1.Show(a1, a2, a3) -- Line: 219
    -- upvalues: VisibleBounds (val), Cash (val), showAtCFrame (val)
    local v1, v2 = VisibleBounds(a1)
    local v3 = v1 - Vector3.new(0, v2.Y / 1.5, 0)
    v1 = assert(workspace.CurrentCamera, "Active asset income popup requires Workspace.CurrentCamera")
    local MaxDistance = Cash.MaxDistance
    if MaxDistance > 0 and MaxDistance < (v1.CFrame.Position - v3.Position).Magnitude then
        return
    end
    local v4 = v2.Y - v2.Y * 0.25
    local v5 = math.min(v2.X / 2, v2.Y / 5.72646427154541, v2.Z / 5.299603462219238)
    showAtCFrame(v3, a2, a3, v4, if not (v5 <= 0) then math.clamp(v5, 0.9, 5) else 0.9)
end

return v1