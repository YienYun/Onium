-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.Components.PowerUpSpawn
-- Decompile time: 7.24 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
require(script.Parent.Parent.MountController)
local MountRace = require(ReplicatedStorage.Data.MountRace)
local PowerUpVisuals = require(script.Parent.Parent.PowerUpVisuals)
require(script.Parent.Parent.RaceCamera)
local RacePowerUps = require(ReplicatedStorage.Data.RacePowerUps)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Attributes = RacePowerUps.Attributes
return {
    Bind = function(a1, a2, a3, a4) -- Line: 29
        -- upvalues: Workspace (val), MountRace (val), LocalPlayer (val), RacePowerUps (val), RunService (val)
        -- upvalues: Attributes (val), TweenService (val), PowerUpVisuals (val), Remotes (val)
        local Pad = a2:FindFirstChild("Pad")
        local v1 = false
        if Pad ~= nil then
            v1 = Pad:IsA("BasePart")
        end
        assert(v1, (("%* needs a Pad part"):format((a2:GetFullName()))))
        local u35 = a2:FindFirstAncestorWhichIsA("Folder")
        while u35 ~= nil do
            if u35.Parent == Workspace then
                break
            end
            u35 = u35:FindFirstAncestorWhichIsA("Folder")
        end
        local u39 = MountRace.HeatOf(LocalPlayer)
        local u42 = if u35 == nil then nil else if u39 ~= nil then nil else u35
        local u48 = RacePowerUps.BoxAttribute(u39)
        if u35 ~= nil and u39 ~= nil then
            a1:Add((task.spawn(function() -- Line: 45 -- upvalues: u42 (ref), MountRace (upval), u35 (ref), u39 (val)
                MountRace.StateOf(u35, u39)
            end)))
        end
        local u73 = a1:Add((RacePowerUps.Assets.Models.Cube:Clone()))
        local PrimaryPart = u73.PrimaryPart
        local Inner = u73:FindFirstChild("Inner")
        local PointLight = PrimaryPart:FindFirstChildOfClass("PointLight")
        local u83 = {}
        for i, j in PrimaryPart:GetChildren() do
            if j:IsA("Decal") then
                table.insert(u83, j)
            end
        end
        local Scale = u73:GetScale()
        u73.Parent = Workspace
        local u107 = (Pad.Position.X + Pad.Position.Z) * 0.05
        local u108 = 0
        local u109 = (-1 / 0)
        local u110 = false
        local u111 = true
        local u112 = nil

        local function crossed(a1) -- Line: 68
            -- upvalues: MountRace (upval), Pad (val), u112 (ref)
            if MountRace.IsInsidePart(Pad, a1, (Vector3.new(4.5, 4, 4.5))) then
                return true
            end
            local v1 = u112
            if v1 == nil then
                return false
            end
            local Magnitude = (a1 - v1).Magnitude
            if not (Magnitude <= 2) and not (Magnitude > 60) then
                local v2 = math.ceil(Magnitude / 2)
                local v3 = v2 - 1
                for i = 1, v3 do
                    if MountRace.IsInsidePart(Pad, v1:Lerp(a1, i / v2), (Vector3.new(4.5, 4, 4.5))) then
                        return true
                    end
                end
                return false
            end
            return false
        end

        local function setVisible(a1) -- Line: 89
            -- upvalues: u111 (ref), PrimaryPart (val), Inner (val), PointLight (val), u83 (val), u108 (ref)
            if a1 == u111 then
                return
            end
            u111 = a1
            PrimaryPart.Transparency = if not a1 then 1 else 0.3
            Inner.Transparency = if not a1 then 1 else 0.35
            PointLight.Enabled = a1
            local v1 = nil
            local v2 = nil
            local v3 = a1
            for i, j in u83, v1, v2 do
                j.Transparency = if not v3 then 1 else 0
            end
            for k, n in PrimaryPart:GetChildren() do
                if n:IsA("ParticleEmitter") then
                    n.Enabled = v3
                end
            end
            if v3 then
                os.clock()
            end
        end

        a1:Connect(RunService.RenderStepped, function() -- Line: 111
            -- upvalues: u42 (ref), Attributes (upval), a2 (val), u48 (val), Workspace (upval), u109 (ref), a3 (val)
            -- upvalues: Pad (val), setVisible (val), u111 (ref), u110 (ref), u112 (ref), u107 (val), PrimaryPart (val)
            -- upvalues: Inner (val), PointLight (val), u83 (val), u108 (ref), TweenService (upval), u73 (val)
            -- upvalues: Scale (val), crossed (val), LocalPlayer (upval), MountRace (upval), PowerUpVisuals (upval)
            -- upvalues: a4 (val), Remotes (upval)
            local fromHSV_2, v1
            local v2 = false
            if u42 ~= nil then
                v2 = u42:GetAttribute(Attributes.Enabled) == true
            end
            local Attribute = a2:GetAttribute(u48)
            local v3 = v2
            if v3 then
                if type(Attribute) ~= "number" then
                    v3 = 0.6 < os.clock() - u109
                else
                    v3 = false
                    if Attribute <= Workspace:GetServerTimeNow() then
                        v3 = 0.6 < os.clock() - u109
                    end
                end
            end
            local Position = a3.Rig.Mount.Hitbox.Position
            local v4 = (Position - Pad.Position).Magnitude < 320
            setVisible(v3 and v4)
            if not u111 then
                u110 = false
                u112 = Position
                return
            end
            v3 = os.clock()
            v4 = (v3 * 0.18 + u107) % 1
            PrimaryPart.Color = Color3.fromHSV(v4, 0.7, 1)
            Inner.Color = Color3.fromHSV((v4 + 0.5) % 1, 0.25, 1)
            PointLight.Color = PrimaryPart.Color
            for i, j in u83 do
                fromHSV_2 = Color3.fromHSV
                v1 = (v4 + 0.08) % 1
                j.Color3 = fromHSV_2(v1, 0.15, 1)
            end
            v4 = math.min((v3 - u108) / 0.45, 1)
            u73:ScaleTo((math.max(
                Scale * (TweenService:GetValue(v4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)) * (math.sin(v3 * 5 + u107) * 0.04 + 1),
                0.01
            )))
            u73:PivotTo((CFrame.new(Pad.Position + Pad.CFrame.UpVector * (math.sin(v3 * 2.6 + u107) * 0.5 + 4.2))) * (CFrame.Angles(0.35, v3 * 1.4 + u107, 0.35)))
            local v5 = crossed(Position)
            u112 = Position
            if v5 and not u110 and LocalPlayer:GetAttribute(MountRace.PlayerAttributes.RaceId) ~= nil then
                os.clock()
                setVisible(false)
                PowerUpVisuals.Emit(Workspace, "Shatter", PrimaryPart.CFrame, 0.8)
                PowerUpVisuals.Sound("Pickup", nil)
                a4:PunchFov(8)
                a4:Shake(0.8)
                Remotes.MountRace.PowerUp:FireServer("Pickup", a2)
            end
            u110 = v5
        end)
    end,
}