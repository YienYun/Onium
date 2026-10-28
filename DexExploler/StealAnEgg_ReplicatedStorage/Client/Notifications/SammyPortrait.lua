-- Script path: ReplicatedStorage.Client.Notifications.SammyPortrait
-- Decompile time: 5.49 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = {}
local u6 = nil

local function build(a1) -- Line: 6 -- upvalues: ReplicatedStorage (val), u6 (ref) -- types: a1: userdata
    local SammyPortraitRig = ReplicatedStorage.Assets.UI.Notifs:FindFirstChild("SammyPortraitRig")
    if not SammyPortraitRig then
        return nil
    end
    local ViewportFrame = Instance.new("ViewportFrame")
    ViewportFrame.Name = "SammyViewport"
    ViewportFrame.BackgroundTransparency = 1
    ViewportFrame.Size = UDim2.fromScale(1, 1)
    ViewportFrame.Ambient = Color3.fromRGB(180, 205, 180)
    ViewportFrame.LightColor = Color3.fromRGB(217, 255, 212)
    ViewportFrame.LightDirection = Vector3.new(-1, -0.4000000059604645, -1)
    ViewportFrame.ZIndex = 6
    ViewportFrame.Parent = a1
    local WorldModel = Instance.new("WorldModel")
    WorldModel.Parent = ViewportFrame
    local v1 = SammyPortraitRig:Clone()
    v1.Parent = WorldModel
    v1:PivotTo(CFrame.identity)
    local v2 = v1:FindFirstChild("Head")
    local v3 = Vector3.new(0, if not v2 then 6.2 else v2.Position.Y + 0.2, 0)
    v2 = Instance.new("Camera")
    v2.FieldOfView = 24
    v2.CFrame = CFrame.lookAt(v3 + Vector3.new(0, 2.4000000953674316, -32), v3)
    v2.Parent = ViewportFrame
    ViewportFrame.CurrentCamera = v2
    v2 = nil
    v3 = v1:FindFirstChildOfClass("Humanoid")
    local Animator = if not v3 then nil else v3:FindFirstChildOfClass("Animator")
    local u85 = v1:FindFirstChild("Idle")
    if Animator and u85 and u85:IsA("Animation") then
        local success, err = pcall(function() -- Line: 40 -- upvalues: Animator (val), u85 (val)
            return Animator:LoadAnimation(u85)
        end)
        if success then
            v2 = err
            v2.Looped = true
            v2.Priority = Enum.AnimationPriority.Idle
        end
    end
    ViewportFrame.Destroying:Connect(function() -- Line: 50 -- upvalues: u6 (upval), ViewportFrame (val)
        if u6 and u6.Viewport == ViewportFrame then
            u6 = nil
        end
    end)
    return {Viewport = ViewportFrame, Model = v1, Track = v2, Owner = a1}
end

function v1.Mount(a1) -- Line: 59 -- upvalues: u6 (ref), build (val) -- types: a1: userdata
    if not u6 then
        u6 = build(a1)
    end
    local u5 = u6
    if not u5 then
        return function() end, function() end
    end
    u5.Owner = a1
    u5.Viewport.Parent = a1
    u5.Viewport.Visible = true
    u5.Model:PivotTo((CFrame.Angles(0, -1.7453292519943295, 0)))
    if u5.Track then
        u5.Track:Play(0.15, 1, 0.8)
    end
    local u29 = false
    return function(a1_2) -- Line: 77 -- upvalues: u29 (ref), u5 (val), a1 (val) -- types: a1_2: number
        if not u29 and u5.Owner == a1 then
            local v1 = math.clamp(a1_2 / 0.62, 0, 1)
            local v2 = v1 - 1
            v2 = (1 - (v2 * 2.15 * v2 * v2 + 1 + v2 * 1.15 * v2)) * -100
            if v1 >= 1 then
                v2 = math.sin((a1_2 - 0.62) * 0.8) * 2
            end
            u5.Model:PivotTo((CFrame.Angles(0, math.rad(v2), 0)))
            return
        end
    end, function() -- Line: 91 -- upvalues: u29 (ref), u5 (val), a1 (val)
        if u29 then
            return
        end
        u29 = true
        if u5.Owner ~= a1 then
            return
        end
        if u5.Track then
            u5.Track:Stop(0)
        end
        u5.Viewport.Visible = false
        u5.Viewport.Parent = nil
        u5.Owner = nil
    end
end

return v1