-- Script path: ReplicatedStorage.Controllers.GUI.BackpackController.Main.MutationHint
-- Decompile time: 8.75 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Save = require(ReplicatedStorage.Shared.Save)
local Trove = require(ReplicatedStorage.Packages.Trove)
return function(a1, a2) -- Line: 9
    -- upvalues: Players (val), Trove (val), Workspace (val), UserInputService (val), Save (val)
    local LocalPlayer = Players.LocalPlayer
    local u6 = Trove.new()
    local u9 = Trove.new()
    u6:Add(u9)
    local u14 = nil
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "MutationHint"
    TextLabel.AnchorPoint = Vector2.new(0.5, 1)
    TextLabel.Position = UDim2.new(0.5, 0, 0, -8)
    TextLabel.Size = UDim2.new(1, 0, 0, 52.5)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.TextColor3 = Color3.new(1, 1, 1)
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    TextLabel.TextStrokeTransparency = 0.25
    TextLabel.Text = "Click on an egg to apply the mutation"
    TextLabel.TextSize = 25
    TextLabel.TextScaled = true
    TextLabel.TextWrapped = false
    TextLabel.Active = false
    TextLabel.ZIndex = 10
    TextLabel.Visible = false
    local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
    UITextSizeConstraint.MaxTextSize = 25
    UITextSizeConstraint.Parent = TextLabel
    TextLabel.Parent = a1
    u6:Add(TextLabel)
    local u65 = Trove.new()
    u6:Add(u65)

    local function updateLayout() -- Line: 41
        -- upvalues: Workspace (upval), a1 (val), UserInputService (upval), TextLabel (val), UITextSizeConstraint (val)
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera and not (a1.Size.X.Offset <= 0) and not (a1.AbsoluteSize.X <= 0) then
            local ViewportSize = CurrentCamera.ViewportSize
            local v1 = a1.AbsoluteSize.X / a1.Size.X.Offset
            local TouchEnabled = UserInputService.TouchEnabled
            local v2 = math.max(
                if not TouchEnabled then ViewportSize.Y * 0.03148148148148148 else math.min(ViewportSize.X, ViewportSize.Y) * 0.052,
                14
            )
            local v3 = ViewportSize.X * (if not TouchEnabled then 0.7 else 0.76)
            local v4 = v2 / v1
            TextLabel.Size = UDim2.fromOffset(v3 / v1, v4 * 1.3)
            TextLabel.Position = UDim2.new(0.5, 0, 0, -math.max(8, ViewportSize.Y * 0.012) / v1)
            UITextSizeConstraint.MinTextSize = 1
            UITextSizeConstraint.MaxTextSize = math.max(1, (math.floor(v4 + 0.5)))
            TextLabel.TextSize = UITextSizeConstraint.MaxTextSize
            return
        end
    end

    u6:Connect(Workspace:GetPropertyChangedSignal("CurrentCamera"), function() -- Line: 62 -- upvalues: u65 (val), Workspace (upval), updateLayout (val)
        u65:Clean()
        local CurrentCamera = Workspace.CurrentCamera
        if CurrentCamera then
            u65:Connect(CurrentCamera:GetPropertyChangedSignal("ViewportSize"), updateLayout)
        end
        updateLayout()
    end)
    u6:Connect(a1:GetPropertyChangedSignal("AbsoluteSize"), updateLayout)
    u6:Connect(UserInputService:GetPropertyChangedSignal("TouchEnabled"), updateLayout)
    u65:Clean()
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        u65:Connect(CurrentCamera:GetPropertyChangedSignal("ViewportSize"), updateLayout)
    end
    updateLayout()

    local function refresh() -- Line: 75 -- upvalues: TextLabel (val), Save (upval), a2 (val), u14 (ref)
        TextLabel.Visible = false
        TextLabel.Text = "Click on an egg to apply the mutation"
        local v1 = Save.Peek()
        if not a2.Visible and u14 and v1 ~= nil then
            if v1.BossMastery and not v1.BossMastery.HasUsedMutationConsumable then
                local Humanoid = u14:FindFirstChildOfClass("Humanoid")
                if Humanoid and not (Humanoid.Health <= 0) then
                    for i, j in u14:GetChildren() do
                        if j:IsA("Tool") and j:GetAttribute("ItemType") == "MutationConsumable" then
                            v1 = j:GetAttribute("MutationId") or "Boss"
                            if v1 ~= "Boss" and v1 ~= "Scrambled" and v1 ~= "Nitro" and v1 ~= "Spectral" then
                                continue
                            end
                            TextLabel.Visible = true
                            return
                        end
                    end
                    return
                end
                return
            end
            return
        end
    end

    local function bindCharacter(a1) -- Line: 100
        -- upvalues: u9 (val), u14 (ref), refresh (val)
        u9:Clean()
        u14 = a1
        if a1 then
            local v1

            local function watchChild(a1) -- Line: 104 -- upvalues: u9 (upval), refresh (upval) -- types: a1: userdata
                if a1:IsA("Humanoid") then
                    u9:Connect(a1.Died, refresh)
                end
            end

            for i, j in a1:GetChildren() do
                if j:IsA("Humanoid") then
                    v1 = refresh
                    u9:Connect(j.Died, v1)
                end
            end
            u9:Connect(a1.ChildAdded, function(a1) -- Line: 112 -- upvalues: u9 (upval), refresh (upval)
                if a1:IsA("Humanoid") then
                    u9:Connect(a1.Died, refresh)
                end
                refresh()
            end)
            u9:Connect(a1.ChildRemoved, refresh)
        end
        refresh()
    end

    u6:Connect(LocalPlayer.CharacterAdded, bindCharacter)
    u6:Connect(LocalPlayer.CharacterRemoving, function() -- Line: 122 -- upvalues: u9 (val), u14 (ref), refresh (val)
        u9:Clean()
        u14 = nil
        refresh()
    end)
    u6:Connect(a2:GetPropertyChangedSignal("Visible"), refresh)
    u6:Add((task.spawn(function() -- Line: 126 -- upvalues: Save (upval), refresh (val)
        if Save.Await() ~= nil then
            refresh()
        end
    end)))
    u6:Add((Save.WatchFields("BossMastery", refresh)))
    u6:Connect(a1.Destroying, function() -- Line: 132 -- upvalues: u6 (val)
        u6:Destroy()
    end)
    bindCharacter(LocalPlayer.Character)
end