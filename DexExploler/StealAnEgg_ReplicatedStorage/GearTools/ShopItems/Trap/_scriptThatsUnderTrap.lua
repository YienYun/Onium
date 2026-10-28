-- Script path: ReplicatedStorage.GearTools.ShopItems.Trap._scriptThatsUnderTrap
-- Decompile time: 9.60 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local AntiCheatService = require(ServerScriptService.Controllers.AntiCheatService)
local Audio = require(ReplicatedStorage.Shared.Audio)
require(ReplicatedStorage.Shared.Globals.Constants)
local GameplayToolGuard = require(ServerScriptService.Library.Tools.Internal.GameplayToolGuard)
local u38 = require(ReplicatedStorage.Shared.Remotes)
local u39 = {}

function u39:ScaleTo(a2) -- Line: 40 -- types: self: userdata, a2: number
    local Model = Instance.new("Model")
    self.Parent = Model
    Model.PrimaryPart = self
    Model:ScaleTo(a2)
    self.Parent = nil
    Model:Destroy()
end

function u39.Install(a1, a2) -- Line: 49
    -- upvalues: Players (val), u38 (val), GameplayToolGuard (val), AntiCheatService (val), Audio (val)
    -- upvalues: ReplicatedStorage (val), u39 (val)
    local Attribute = a1:GetAttribute("Owner")
    local u6 = false
    local u7 = {}
    local u8 = nil
    local Hitbox = a1:WaitForChild("Hitbox")
    assert(Hitbox:IsA("BasePart"), "Trap Hitbox must be a BasePart")
    a1.CanTouch = true
    Hitbox.CanTouch = true

    local function createTrapBillboard(a1) -- Line: 64 -- types: a1: userdata
        local BillboardGui = Instance.new("BillboardGui")
        BillboardGui.Name = "TrapBillboard"
        BillboardGui.Size = UDim2.fromScale(6, 3)
        BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
        BillboardGui.AlwaysOnTop = true
        BillboardGui.MaxDistance = 50
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.fromScale(1, 1)
        Frame.BackgroundTransparency = 1
        Frame.Parent = BillboardGui
        local TextLabel_2 = Instance.new("TextLabel")
        TextLabel_2.Size = UDim2.fromScale(1, 0.4)
        TextLabel_2.Position = UDim2.new(0, 0, 0, 0)
        TextLabel_2.BackgroundTransparency = 1
        TextLabel_2.Text = "TRAPPED"
        TextLabel_2.TextColor3 = Color3.fromRGB(255, 0, 0)
        TextLabel_2.TextScaled = true
        TextLabel_2.Font = Enum.Font.SourceSansBold
        TextLabel_2.Parent = Frame
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Thickness = 2.5
        UIStroke.Parent = TextLabel_2
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.fromScale(1, 0.5)
        TextLabel.Position = UDim2.fromScale(0, 0.5)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = (tostring(7)) .. "s"
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextScaled = true
        TextLabel.Font = Enum.Font.SourceSansBold
        TextLabel.Parent = Frame
        local v1 = Instance.new("UIStroke")
        v1.Thickness = 2.5
        v1.Parent = TextLabel
        v1 = a1:FindFirstChild("Head")
        if v1 then
            BillboardGui.Parent = v1
            task.spawn(function() -- Line: 115 -- upvalues: BillboardGui (val), TextLabel (val)
                for i = 7, 1, -1 do
                    if not BillboardGui or not BillboardGui.Parent then
                        break
                    end
                    TextLabel.Text = (tostring(i)) .. "s"
                    task.wait(1)
                end
                if BillboardGui and BillboardGui.Parent then
                    BillboardGui:Destroy()
                end
            end)
            return BillboardGui
        end
        if not a1.PrimaryPart then
            BillboardGui:Destroy()
            return nil
        end
        BillboardGui.Parent = a1.PrimaryPart
        task.spawn(function() -- Line: 115 -- upvalues: BillboardGui (val), TextLabel (val)
            for i = 7, 1, -1 do
                if not BillboardGui or not BillboardGui.Parent then
                    break
                end
                TextLabel.Text = (tostring(i)) .. "s"
                task.wait(1)
            end
            if BillboardGui and BillboardGui.Parent then
                BillboardGui:Destroy()
            end
        end)
        return BillboardGui
    end

    local function getModelHeight(a1) -- Line: 132 -- types: a1: userdata
        local BoundingBox_2
        local HumanoidRootPart = a1:FindFirstChild("HumanoidRootPart") or a1.PrimaryPart
        if not HumanoidRootPart then
            error("HumanoidRootPart or PrimaryPart not found")
            return 2
        end
        _, BoundingBox_2 = a1:GetBoundingBox()
        return BoundingBox_2.Y / 2
    end

    local function getCharacterFromPart(a1) -- Line: 143 -- types: a1: userdata
        local Parent = a1
        while Parent do
            if Parent == workspace then
                break
            end
            if Parent:IsA("Model") and Parent:FindFirstChildOfClass("Humanoid") then
                return Parent
            end
            Parent = Parent.Parent
        end
        return nil
    end

    local function positionCloseModel(a1_2) -- Line: 158 -- upvalues: a1 (val) -- types: a1_2: userdata
        if a1_2:IsA("BasePart") then
            a1_2.CFrame = a1.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0)
            a1_2.Anchored = true
            return
        end
        if a1_2:IsA("PVInstance") then
            a1_2:PivotTo(a1.CFrame)
        end
        for i, j in a1_2:GetDescendants() do
            if j:IsA("BasePart") then
                j.Anchored = true
            end
        end
    end

    local function releaseTrappedCharacter(a1) -- Line: 176 -- upvalues: u7 (val) -- types: a1: userdata
        local v1 = u7[a1]
        if not v1 then
            return
        end
        u7[a1] = nil
        local carrierConnection = v1.carrierConnection
        if carrierConnection then
            carrierConnection:Disconnect()
        end
        local trapStateConnection = v1.trapStateConnection
        if trapStateConnection then
            trapStateConnection:Disconnect()
        end
        local billboard = v1.billboard
        if billboard and billboard.Parent then
            billboard:Destroy()
        end
        local rootPart = v1.rootPart
        if rootPart and rootPart.Parent then
            rootPart.Anchored = v1.originalRootAnchored
        end
        local humanoid = v1.humanoid
        if humanoid then
            humanoid.JumpHeight = v1.originalJumpHeight
            humanoid.AutoRotate = v1.originalAutoRotate
            humanoid.PlatformStand = false
        end
        if a1 and a1.Parent then
            a1:SetAttribute("IsTrapped", nil)
        end
    end

    local function notifyTrapOwner(a1) -- Line: 218
        -- upvalues: Attribute (val), Players (upval), u38 (upval)
        if typeof(Attribute) ~= "string" then
            return
        end
        local v1 = Players:FindFirstChild(Attribute)
        if v1 and v1:IsA("Player") then
            u38.Alerts.Raise:FireClient(v1, {
                Type = "Toast",
                Lane = "Feed",
                Seconds = 2,
                Text = ("You <font color=\"#00FF00\">trapped</font> %*!"):format(a1.DisplayName),
                Color = Color3.new(1, 1, 1),
            })
            return
        end
    end

    local function freezeCharacter(a1, a2) -- Line: 237
        -- upvalues: u7 (val), Players (upval), GameplayToolGuard (upval), AntiCheatService (upval)
        -- upvalues: notifyTrapOwner (val), createTrapBillboard (val), Audio (upval), releaseTrappedCharacter (val)
        if not u7[a1] and not a1:GetAttribute("IsTrapped") then
            local Humanoid = a1:FindFirstChildOfClass("Humanoid")
            local HumanoidRootPart = a1:FindFirstChild("HumanoidRootPart") or a1.PrimaryPart
            if Humanoid and HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
                local v1
                local HumanoidRootPart_2 = a1:FindFirstChild("HumanoidRootPart") or a1.PrimaryPart
                if HumanoidRootPart_2 then
                    local BoundingBox_2
                    _, BoundingBox_2 = a1:GetBoundingBox()
                    v1 = BoundingBox_2.Y / 2
                else
                    error("HumanoidRootPart or PrimaryPart not found")
                    v1 = 2
                end
                local v2 = a2 + Vector3.new(0, v1, 0)
                v1 = Players:GetPlayerFromCharacter(a1)
                if v1 and GameplayToolGuard.DropHeldEggFromPlayerHit(v1) then
                    local v3 = CFrame.new(v2)
                    if not AntiCheatService.TeleportCharacter(v1, v3) then
                        return false
                    end
                    local Anchored = HumanoidRootPart.Anchored
                    local JumpHeight = Humanoid.JumpHeight
                    local AutoRotate = Humanoid.AutoRotate
                    HumanoidRootPart.Anchored = true
                    Humanoid:UnequipTools()
                    Humanoid.JumpHeight = 0
                    Humanoid.AutoRotate = false
                    Humanoid.PlatformStand = true
                    a1:SetAttribute("IsTrapped", true)
                    notifyTrapOwner(v1)
                    local u93 = {
                        character = a1,
                        humanoid = Humanoid,
                        rootPart = HumanoidRootPart,
                        originalRootAnchored = Anchored,
                        originalJumpHeight = JumpHeight,
                        originalAutoRotate = AutoRotate,
                    }
                    u7[a1] = u93
                    u93.billboard = createTrapBillboard(a1)
                    Audio.Play(9091607929, HumanoidRootPart.CFrame, {Volume = 1.3, MaxDistance = 70, PlaybackSpeed = {0.9, 1.1}})
                    u93.carrierConnection = (a1:GetAttributeChangedSignal("CarrierUserId")):Connect(function() -- Line: 295 -- upvalues: a1 (val), releaseTrappedCharacter (upval)
                        if a1:GetAttribute("CarrierUserId") ~= nil then
                            releaseTrappedCharacter(a1)
                        end
                    end)
                    u93.trapStateConnection = (a1:GetAttributeChangedSignal("IsTrapped")):Connect(function() -- Line: 304 -- upvalues: a1 (val), releaseTrappedCharacter (upval)
                        if a1:GetAttribute("IsTrapped") ~= true then
                            releaseTrappedCharacter(a1)
                        end
                    end)
                    task.delay(7, function() -- Line: 310 -- upvalues: u7 (upval), a1 (val), u93 (val), releaseTrappedCharacter (upval)
                        if u7[a1] ~= u93 then
                            return
                        end
                        releaseTrappedCharacter(a1)
                    end)
                    return true
                end
                return false
            end
            return false
        end
        return false
    end

    local function activateTrap(a1_2) -- Line: 321
        -- upvalues: u6 (ref), a1 (val), freezeCharacter (val), Hitbox (val), u8 (ref), ReplicatedStorage (upval)
        -- upvalues: a2 (val), u39 (upval), positionCloseModel (val)
        if not u6 and a1.Parent then
            if not freezeCharacter(a1_2, Hitbox.Position - Vector3.new(0, 1, 0) * (Hitbox.Size.Y / 2)) then
                return
            end
            u6 = true
            a1:SetAttribute("TrapActive", true)
            if u8 then
                u8:Disconnect()
                u8 = nil
            end
            local u35 = ReplicatedStorage.Assets.Extra.ClosedTrap:Clone()
            if a2 ~= 1 then
                u39.ScaleTo(u35, a2)
            end
            positionCloseModel(u35)
            u35.Parent = a1
            a1.Transparency = 1
            a1.CanCollide = false
            a1.CanTouch = false
            task.delay(7.5, function() -- Line: 350 -- upvalues: u35 (val), a1 (upval)
                if u35 and u35.Parent then
                    u35:Destroy()
                end
                if a1 and a1.Parent then
                    a1:Destroy()
                end
            end)
            return
        end
    end

    Hitbox.Touched:Connect(function(a1_2) -- Line: 361
        -- upvalues: u6 (ref), a1 (val), getCharacterFromPart (val), Players (upval), Attribute (val)
        -- upvalues: GameplayToolGuard (upval), activateTrap (val)
        if not u6 and a1.Parent then
            if a1_2 and not a1_2:IsDescendantOf(a1) then
                local v1 = getCharacterFromPart(a1_2)
                if not v1 then
                    return
                end
                local PlayerFromCharacter = Players:GetPlayerFromCharacter(v1)
                if PlayerFromCharacter and PlayerFromCharacter.Name == Attribute then
                    return
                end
                if PlayerFromCharacter and GameplayToolGuard.IsPlayerInGameplayArea(PlayerFromCharacter) then
                    if not GameplayToolGuard.IsHoldingEgg(PlayerFromCharacter) then
                        return
                    end
                    local Humanoid = v1:FindFirstChildOfClass("Humanoid")
                    if Humanoid and not (Humanoid.Health <= 0) then
                        activateTrap(v1)
                        return
                    end
                    return
                end
                return
            end
            return
        end
    end)
end

return u39