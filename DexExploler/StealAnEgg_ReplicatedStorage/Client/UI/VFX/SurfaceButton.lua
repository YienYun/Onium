-- Script path: ReplicatedStorage.Client.UI.VFX.SurfaceButton
-- Decompile time: 0.73 ms

local ButtonFX = require(script.Parent.ButtonFX)

local function hitAreaOf(a1) -- Line: 15 -- types: a1: userdata
    if a1:IsA("GuiButton") then
        return a1, false
    end
    local PressSurface = a1:FindFirstChild("PressSurface")
    if PressSurface and PressSurface:IsA("GuiButton") then
        return PressSurface, false
    end
    local TextButton = Instance.new("TextButton")
    TextButton.Name = "PressSurface"
    TextButton.Text = ""
    TextButton.AutoButtonColor = false
    TextButton.BackgroundTransparency = 1
    TextButton.ZIndex = a1.ZIndex + 64
    TextButton.Size = UDim2.fromScale(1, 1)
    TextButton.Parent = a1
    return TextButton, true
end

return function(a1, a2, a3) -- Line: 36
    -- upvalues: hitAreaOf (val), ButtonFX (val)
    a1.Active = true
    local v1, v2 = hitAreaOf(a1)
    return ButtonFX({
        pressedScale = 0.965,
        cueGain = 1.75,
        host = a1,
        input = v1,
        ownsInput = v2,
        peakScale = a2 or 1.045,
        onActivate = a3,
    })
end