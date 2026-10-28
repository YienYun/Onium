-- Script path: ReplicatedStorage.Shared.Eggs.GrowingEggListRow
-- Decompile time: 4.28 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
require(ReplicatedStorage.Shared.Eggs.Types)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u24 = Color3.fromRGB(166, 255, 111)
local u31 = TweenInfo.new(0.55, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local v1 = {}

local function stopPulse(a1) -- Line: 29
    local PulseTween = a1.PulseTween
    a1.PulseTween = nil
    if PulseTween ~= nil then
        PulseTween:Cancel()
        PulseTween:Destroy()
    end
    a1.HatchButton.BackgroundColor3 = a1.OriginalHatchColor
end

local function startPulse(a1) -- Line: 40 -- upvalues: TweenService (val), u31 (val), u24 (val)
    if a1.PulseTween ~= nil then
        return
    end
    local v1 = TweenService:Create(a1.HatchButton, u31, {BackgroundColor3 = u24})
    a1.PulseTween = v1
    v1:Play()
end

local function updateButtonState(a1, a2, a3) -- Line: 52
    -- upvalues: TweenService (val), u31 (val), u24 (val)
    if a1.HatchButton ~= a1.GrowButton then
        a1.GrowButton.Visible = not a2 and a3
        a1.GrowButton.Active = not a2 and a3
        a1.HatchButton.Visible = a2
        a1.HatchButton.Active = a2
    else
        local GrowButton = a1.GrowButton
        GrowButton.Visible = a2 or a3
        GrowButton.Active = a2 or a3
    end
    a1.Ready = a2
    if a2 then
        if a1.PulseTween ~= nil then
            return
        end
        local v1 = TweenService:Create(a1.HatchButton, u31, {BackgroundColor3 = u24})
        a1.PulseTween = v1
        v1:Play()
        return
    end
    local PulseTween = a1.PulseTween
    a1.PulseTween = nil
    if PulseTween ~= nil then
        PulseTween:Cancel()
        PulseTween:Destroy()
    end
    a1.HatchButton.BackgroundColor3 = a1.OriginalHatchColor
end

function v1.Mount(a1, a2, a3, a4, a5) -- Line: 76
    -- upvalues: Trove (val)
    local v1 = a1:Clone()
    v1.Name = a3
    v1.Visible = true
    v1.Parent = a2
    local Skip = v1.Spacer.Skip
    local v2 = v1.Spacer:FindFirstChild("Open") or Skip
    Skip.Selectable = true
    v2.Selectable = true
    if v2 ~= Skip then
        v2.Visible = false
    end
    local v3 = Trove.new()
    local u23 = {
        Ready = false,
        Uid = a3,
        Root = v1,
        GrowButton = Skip,
        HatchButton = v2,
        OriginalHatchColor = v2.BackgroundColor3,
        Trove = v3,
    }
    v3:Add(v1)
    v3:Add(function() -- Line: 110 -- upvalues: u23 (val)
        local v1 = u23
        local PulseTween = v1.PulseTween
        v1.PulseTween = nil
        if PulseTween ~= nil then
            PulseTween:Cancel()
            PulseTween:Destroy()
        end
        v1.HatchButton.BackgroundColor3 = v1.OriginalHatchColor
    end)
    if v2 == Skip then
        v3:Connect(Skip.Activated, function() -- Line: 112 -- upvalues: u23 (val), a5 (val), a3 (val), a4 (val)
            if u23.Ready then
                a5(a3)
                return
            end
            a4(a3)
        end)
        return u23
    end
    v3:Connect(Skip.Activated, function() -- Line: 120 -- upvalues: a4 (val), a3 (val)
        a4(a3)
    end)
    v3:Connect(v2.Activated, function() -- Line: 121 -- upvalues: a5 (val), a3 (val)
        a5(a3)
    end)
    return u23
end

function v1.Update(a1, a2, a3, a4, a5, a6) -- Line: 127
    -- upvalues: updateButtonState (val)
    local Spacer = a1.Root.Spacer
    Spacer.Icon.Image = a2
    Spacer.Progress.Fill.Size = UDim2.fromScale(a3, 1)
    Spacer.Progress.TextLabel.Text = a4
    Spacer.Progress.Visible = not a5
    updateButtonState(a1, a5, a6)
end

function v1:Destroy() -- Line: 144
    self.Trove:Destroy()
end

return v1