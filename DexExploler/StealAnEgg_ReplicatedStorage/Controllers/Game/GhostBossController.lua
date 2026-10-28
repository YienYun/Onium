-- Script path: ReplicatedStorage.Controllers.Game.GhostBossController
-- Decompile time: 24.29 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Boss = require(script.Boss)
local Drop = require(script.Drop)
local GhostBoss = require(ReplicatedStorage.Shared.Util.GhostBoss)
local GhostBoss_2 = require(ReplicatedStorage.Client.Notifications.GhostBoss)
local GhostBoss_3 = require(ReplicatedStorage.Shared.Remotes).GhostBoss
local Sfx = require(script.Sfx)
local SoulsHud = require(script.SoulsHud)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local TrainGhostVisuals = require(ReplicatedStorage.Controllers.Game.TrainGhostVisuals)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Attributes = GhostBoss.Attributes
local Phases = GhostBoss.Phases
local u77 = Color3.fromRGB(125, 255, 210)
local u82 = Color3.fromRGB(8, 63, 52)
local u83 = false
local v1 = {}

local function toast(a1, a2) -- Line: 45
    -- upvalues: Toast (val), u77 (val), u82 (val)
    Toast.Show({
        Lane = "Feed",
        Text = a1,
        Seconds = a2 or 3,
        Color = u77,
        StrokeColor = u82,
    })
end

local function isBossVacuum(a1) -- Line: 55 -- upvalues: GhostBoss (val) -- types: a1: userdata
    return a1:IsA("Tool") and a1:GetAttribute(GhostBoss.ToolAttribute) ~= nil
end

local function cameraLook() -- Line: 59 -- upvalues: Workspace (val)
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        return CurrentCamera.CFrame.LookVector
    end
    return nil
end

local function nameOf(a1) -- Line: 64 -- upvalues: Players (val) -- types: a1: number
    local PlayerByUserId = Players:GetPlayerByUserId(a1)
    if PlayerByUserId then
        return PlayerByUserId.DisplayName
    end
    return "Someone"
end

function v1.Start() -- Line: 73
    -- upvalues: u83 (ref), Trove (val), ReplicatedStorage (val), GhostBoss (val), Workspace (val), LocalPlayer (val)
    -- upvalues: Attributes (val), GhostBoss_3 (val), TrainGhostVisuals (val), Phases (val), Drop (val), Players (val)
    -- upvalues: Toast (val), u77 (val), u82 (val), Boss (val), Sfx (val), GhostBoss_2 (val), UserInputService (val)
    -- upvalues: RunService (val), SoulsHud (val)
    if u83 then
        return
    end
    u83 = true
    local u4 = Trove.new()
    local u10 = ReplicatedStorage:WaitForChild(GhostBoss.StateName)
    local Boss_2 = ReplicatedStorage:WaitForChild(GhostBoss.AssetsName):WaitForChild("Boss")
    local u27 = u4:Add((Instance.new("Folder")))
    u27.Name = "GhostBossVisuals"
    u27.Parent = Workspace
    local u30 = nil
    local u31 = nil
    local u32 = ""
    local u33 = {}
    local u34 = {}
    local u35 = {}
    local u36 = {}
    local u64 = false
    local u65 = false
    local u81 = nil
    local u66 = 0
    local u41 = nil
    local u42 = (-1 / 0)
    local u43 = {}

    local function forMe() -- Line: 102
        -- upvalues: GhostBoss (upval), LocalPlayer (upval), u10 (val), Attributes (upval)
        return (GhostBoss.RealmOf(LocalPlayer)) == GhostBoss.RealmNamed(u10:GetAttribute(Attributes.Realm))
    end

    local function setSucking(a1) -- Line: 107
        -- upvalues: u65 (ref), u66 (ref), GhostBoss_3 (upval), u30 (ref), TrainGhostVisuals (upval), u81 (ref)
        -- upvalues: GhostBoss (upval)
        if u65 == a1 then
            return
        end
        u65 = a1
        u66 = 0
        if not a1 then
            GhostBoss_3.Suction:FireServer(false)
        end
        if u30 then
            u30:SetLocalSucking(a1)
        end
        local SetYield = TrainGhostVisuals.SetYield
        local v1 = a1
        if v1 then
            v1 = false
            if u81 ~= nil then
                local v2 = u81
                v1 = not (v2:IsA("Tool") and v2:GetAttribute(GhostBoss.ToolAttribute) ~= nil)
            end
        end
        SetYield(v1)
    end

    local function setHolding(a1) -- Line: 122
        -- upvalues: u81 (ref), LocalPlayer (upval), u64 (ref), u65 (ref), u66 (ref), GhostBoss_3 (upval), u30 (ref)
        -- upvalues: TrainGhostVisuals (upval)
        local v1 = a1
        if v1 then
            v1 = false
            if u81 ~= nil then
                v1 = u81.Parent == LocalPlayer.Character
            end
        end
        if u64 == v1 then
            return
        end
        if not v1 then
            if u65 == false then
                return
            end
            u65 = false
            u66 = 0
            GhostBoss_3.Suction:FireServer(false)
            if u30 then
                u30:SetLocalSucking(false)
            end
            TrainGhostVisuals.SetYield(false)
        end
    end

    local function wantsBoss(a1) -- Line: 133
        -- upvalues: u81 (ref), LocalPlayer (upval), GhostBoss (upval), u10 (val), Attributes (upval), Phases (upval)
        -- upvalues: u65 (ref), Workspace (upval), u64 (ref)
        if a1 ~= nil and u81 ~= nil and u81.Parent == LocalPlayer.Character then
            local v1 = (GhostBoss.RealmOf(LocalPlayer)) == GhostBoss.RealmNamed(u10:GetAttribute(Attributes.Realm))
            if v1 then
                local Phase = a1:GetPhase()
                if Phase ~= Phases.Alive and Phase ~= Phases.Spawning then
                    return false
                end
                v1 = u65
                if v1 then
                    v1 = false
                    if LocalPlayer:GetAttribute(GhostBoss.SuckingAttribute) == true then
                        v1 = a1:InReach(1.15)
                    end
                end
                local v2 = v1
                if not v2 then
                    v2 = a1:InReach()
                    if v2 then
                        local CurrentCamera = Workspace.CurrentCamera
                        v2 = a1:InCone(if not CurrentCamera then nil else CurrentCamera.CFrame.LookVector)
                    end
                end
                local v3 = u81
                if v3:IsA("Tool") and v3:GetAttribute(GhostBoss.ToolAttribute) ~= nil then
                    return u64 or v2
                end
                return v2
            end
        end
        return false
    end

    local function startDrop(a1) -- Line: 156
        -- upvalues: u34 (val), u10 (val), Attributes (upval), Drop (upval), u27 (val), u33 (val), u36 (val)
        if u34[a1] then
            return
        end
        local Attribute = u10:GetAttribute(Attributes.ExplodePosition)
        local Attribute_2 = u10:GetAttribute(Attributes.DropPosition)
        if typeof(Attribute) == "Vector3" and typeof(Attribute_2) == "Vector3" then
            local v1 = Drop.new(Attribute, Attribute_2, u27)
            u34[a1] = v1
            table.insert(u33, v1)
            local v2 = u36[a1]
            if v2 then
                u36[a1] = nil
                v1:AddSouls(v2)
            end
            return
        end
    end

    local function onPhase(a1, a2) -- Line: 175
        -- upvalues: u30 (ref), Phases (upval), u64 (ref), u65 (ref), u66 (ref), GhostBoss_3 (upval)
        -- upvalues: TrainGhostVisuals (upval), u10 (val), Attributes (upval), GhostBoss (upval), LocalPlayer (upval)
        -- upvalues: Players (upval), Toast (upval), u77 (upval), u82 (upval), startDrop (val)
        local v1 = u30
        if v1 == nil then
            return
        end
        local Phase = v1:GetPhase()
        v1:SetPhase(a1)
        if a1 == Phase then
            return
        end
        if a1 ~= Phases.Capturing then
            if a1 == Phases.Defeated then
                startDrop(a2)
                return
            end
            if a1 == Phases.Escaped and Phase ~= Phases.Defeated then
                if u64 ~= false then
                    u64 = false
                    if not u64 and u65 ~= false then
                        u65 = false
                        u66 = 0
                        GhostBoss_3.Suction:FireServer(false)
                        if u30 then
                            u30:SetLocalSucking(false)
                        end
                        TrainGhostVisuals.SetYield(false)
                    end
                end
                if (GhostBoss.RealmOf(LocalPlayer)) == GhostBoss.RealmNamed(u10:GetAttribute(Attributes.Realm)) then
                    Toast.Show({
                        Lane = "Feed",
                        Text = "Ghouler got away...",
                        Seconds = 4,
                        Color = u77,
                        StrokeColor = u82,
                    })
                end
            end
            return
        end
        if u64 ~= false then
            u64 = false
            if not u64 and u65 ~= false then
                u65 = false
                u66 = 0
                GhostBoss_3.Suction:FireServer(false)
                if u30 then
                    u30:SetLocalSucking(false)
                end
                TrainGhostVisuals.SetYield(false)
            end
        end
        v1 = u10:GetAttribute(Attributes.CaptureUserId)
        if type(v1) == "number" and v1 > 0 then
            local v2 = (GhostBoss.RealmOf(LocalPlayer)) == GhostBoss.RealmNamed(u10:GetAttribute(Attributes.Realm))
            if v2 then
                if v1 ~= LocalPlayer.UserId then
                    local PlayerByUserId = Players:GetPlayerByUserId(v1)
                    v2 = ("%* is sucking in Ghouler!"):format(if not PlayerByUserId then "Someone" else PlayerByUserId.DisplayName)
                else
                    v2 = "You're sucking in Ghouler!"
                end
                Toast.Show({
                    Lane = "Feed",
                    Seconds = 3,
                    Text = v2,
                    Color = u77,
                    StrokeColor = u82,
                })
                return
            end
        end
    end

    local function sync() -- Line: 205
        -- upvalues: u10 (val), Attributes (upval), u32 (ref), u65 (ref), u66 (ref), GhostBoss_3 (upval), u30 (ref)
        -- upvalues: TrainGhostVisuals (upval), Phases (upval), Boss (upval), Boss_2 (val), u27 (val), u31 (ref)
        -- upvalues: Sfx (upval), u35 (val), GhostBoss (upval), LocalPlayer (upval), Workspace (upval)
        -- upvalues: GhostBoss_2 (upval), onPhase (val)
        local Attribute = u10:GetAttribute(Attributes.BossId)
        local Attribute_2 = u10:GetAttribute(Attributes.Phase)
        if type(Attribute) == "string" and type(Attribute_2) == "string" then
            if Attribute ~= u32 then
                if u65 ~= false then
                    u65 = false
                    u66 = 0
                    GhostBoss_3.Suction:FireServer(false)
                    if u30 then
                        u30:SetLocalSucking(false)
                    end
                    TrainGhostVisuals.SetYield(false)
                end
                local v1 = u30
                if v1 then
                    if (v1:GetPhase()) ~= Phases.Escaped or v1:IsFinished() then
                        v1:Destroy()
                        u30 = nil
                    end
                end
                u32 = Attribute
                if Attribute ~= "" then
                    if u30 then
                        u30:Destroy()
                    end
                    v1 = Boss.new(u10, Boss_2, u27)
                    u30 = v1
                    if u31 then
                        u31:Destroy()
                    end
                    u31 = Sfx.new(u10, v1.Root, Attribute_2)
                end
            end
            if Attribute ~= "" and not u35[Attribute] then
                local v2 = GhostBoss.RealmOf(LocalPlayer)
                if v2 == GhostBoss.RealmNamed(u10:GetAttribute(Attributes.Realm)) then
                    local Attribute_3 = u10:GetAttribute(Attributes.SpawnedAt)
                    v2 = false
                    if type(Attribute_3) == "number" then
                        v2 = Workspace:GetServerTimeNow() - Attribute_3 < 15
                    end
                    if v2 and Attribute_2 ~= Phases.Defeated then
                        u35[Attribute] = true
                        GhostBoss_2.Show()
                        if Attribute_2 == Phases.Spawning and u31 then
                            u31:Spawn()
                        end
                    end
                end
            end
            if Attribute ~= "" and Attribute_2 ~= Phases.None then
                onPhase(Attribute_2, Attribute)
            end
            return
        end
    end

    local function bindTool(a1) -- Line: 248
        -- upvalues: GhostBoss (upval), u43 (val), u4 (val), LocalPlayer (upval), u81 (ref), u64 (ref), u65 (ref)
        -- upvalues: u66 (ref), GhostBoss_3 (upval), u30 (ref), TrainGhostVisuals (upval)
        if GhostBoss.IsVacuum(a1) and not u43[a1] then
            local u10 = u4:Extend()
            u43[a1] = u10
            u10:Connect(a1.Equipped, function() -- Line: 255
                -- upvalues: a1 (val), LocalPlayer (upval), u81 (upval), u64 (upval), u65 (upval), u66 (upval)
                -- upvalues: GhostBoss_3 (upval), u30 (upval), TrainGhostVisuals (upval)
                if a1.Parent == LocalPlayer.Character then
                    u81 = a1
                    return
                end
                if u81 == a1 then
                    if u64 ~= false then
                        u64 = false
                        if not u64 and u65 ~= false then
                            u65 = false
                            u66 = 0
                            GhostBoss_3.Suction:FireServer(false)
                            if u30 then
                                u30:SetLocalSucking(false)
                            end
                            TrainGhostVisuals.SetYield(false)
                        end
                    end
                    u81 = nil
                end
            end)
            u10:Connect(a1.Unequipped, function() -- Line: 264
                -- upvalues: u81 (upval), a1 (val), u64 (upval), u65 (upval), u66 (upval), GhostBoss_3 (upval)
                -- upvalues: u30 (upval), TrainGhostVisuals (upval)
                if u81 == a1 then
                    if u64 ~= false then
                        u64 = false
                        if not u64 and u65 ~= false then
                            u65 = false
                            u66 = 0
                            GhostBoss_3.Suction:FireServer(false)
                            if u30 then
                                u30:SetLocalSucking(false)
                            end
                            TrainGhostVisuals.SetYield(false)
                        end
                    end
                    u81 = nil
                end
            end)
            u10:Connect(a1.Activated, function() -- Line: 270
                -- upvalues: u81 (upval), a1 (val), LocalPlayer (upval), u64 (upval), u65 (upval), u66 (upval)
                -- upvalues: GhostBoss_3 (upval), u30 (upval), TrainGhostVisuals (upval)
                u81 = a1
                local v1 = false
                if u81 ~= nil then
                    v1 = u81.Parent == LocalPlayer.Character
                end
                if u64 == v1 then
                    return
                end
                if not v1 then
                    if u65 == false then
                        return
                    end
                    u65 = false
                    u66 = 0
                    GhostBoss_3.Suction:FireServer(false)
                    if u30 then
                        u30:SetLocalSucking(false)
                    end
                    TrainGhostVisuals.SetYield(false)
                end
            end)
            u10:Connect(a1.Deactivated, function() -- Line: 274
                -- upvalues: u64 (upval), u65 (upval), u66 (upval), GhostBoss_3 (upval), u30 (upval)
                -- upvalues: TrainGhostVisuals (upval)
                if u64 == false then
                    return
                end
                u64 = false
                if not u64 then
                    if u65 == false then
                        return
                    end
                    u65 = false
                    u66 = 0
                    GhostBoss_3.Suction:FireServer(false)
                    if u30 then
                        u30:SetLocalSucking(false)
                    end
                    TrainGhostVisuals.SetYield(false)
                end
            end)
            u10:Connect(a1.AncestryChanged, function() -- Line: 277
                -- upvalues: a1 (val), LocalPlayer (upval), u81 (upval), u64 (upval), u65 (upval), u66 (upval)
                -- upvalues: GhostBoss_3 (upval), u30 (upval), TrainGhostVisuals (upval), u43 (upval), u4 (upval)
                -- upvalues: u10 (val)
                if a1.Parent == LocalPlayer.Character then
                    u81 = a1
                elseif u81 == a1 then
                    if u64 ~= false then
                        u64 = false
                        if not u64 and u65 ~= false then
                            u65 = false
                            u66 = 0
                            GhostBoss_3.Suction:FireServer(false)
                            if u30 then
                                u30:SetLocalSucking(false)
                            end
                            TrainGhostVisuals.SetYield(false)
                        end
                    end
                    u81 = nil
                end
                if not a1:IsDescendantOf(game) then
                    u43[a1] = nil
                    u4:Remove(u10)
                end
            end)
            if a1.Parent == LocalPlayer.Character then
                u81 = a1
                return
            end
            if u81 == a1 then
                if u64 ~= false then
                    u64 = false
                    if not u64 and u65 ~= false then
                        u65 = false
                        u66 = 0
                        GhostBoss_3.Suction:FireServer(false)
                        if u30 then
                            u30:SetLocalSucking(false)
                        end
                        TrainGhostVisuals.SetYield(false)
                    end
                end
                u81 = nil
            end
            return
        end
    end

    local function watchContainer(a1) -- Line: 287
        -- upvalues: bindTool (val), u4 (val), GhostBoss (upval), u43 (val), Toast (upval), u77 (upval), u82 (upval)
        for i, j in a1:GetChildren() do
            bindTool(j)
        end
        u4:Connect(a1.ChildAdded, function(a1_2) -- Line: 291
            -- upvalues: GhostBoss (upval), u43 (upval), bindTool (upval), a1 (val), Toast (upval), u77 (upval)
            -- upvalues: u82 (upval)
            local v1 = a1_2:IsA("Tool") and a1_2:GetAttribute(GhostBoss.ToolAttribute) ~= nil and not u43[a1_2]
            bindTool(a1_2)
            if v1 and a1:IsA("Backpack") then
                Toast.Show({
                    Lane = "Feed",
                    Text = "You got a Ghost Vacuum! Equip it and hold to suck in Ghouler!",
                    Seconds = 4,
                    Color = u77,
                    StrokeColor = u82,
                })
            end
        end)
    end

    u4:Connect(LocalPlayer.CharacterAdded, function(a1) -- Line: 300
        -- upvalues: u64 (ref), u65 (ref), u66 (ref), GhostBoss_3 (upval), u30 (ref), TrainGhostVisuals (upval)
        -- upvalues: u81 (ref), watchContainer (val)
        if u64 ~= false then
            u64 = false
            if not u64 and u65 ~= false then
                u65 = false
                u66 = 0
                GhostBoss_3.Suction:FireServer(false)
                if u30 then
                    u30:SetLocalSucking(false)
                end
                TrainGhostVisuals.SetYield(false)
            end
        end
        u81 = nil
        watchContainer(a1)
    end)
    if LocalPlayer.Character then
        local Character = LocalPlayer.Character
        if u64 then
            u64 = false
            if not u64 and u65 then
                u65 = false
                u66 = 0
                GhostBoss_3.Suction:FireServer(false)
                if u30 then
                    u30:SetLocalSucking(false)
                end
                TrainGhostVisuals.SetYield(false)
            end
        end
        u81 = nil
        watchContainer(Character)
    end
    task.spawn(function() -- Line: 310 -- upvalues: watchContainer (val), LocalPlayer (upval)
        watchContainer(LocalPlayer:WaitForChild("Backpack"))
    end)
    u4:Connect(LocalPlayer.ChildAdded, function(a1) -- Line: 313 -- upvalues: watchContainer (val) -- types: a1: userdata
        if a1:IsA("Backpack") then
            watchContainer(a1)
        end
    end)
    u4:Connect(UserInputService.InputEnded, function(a1) -- Line: 319
        -- upvalues: u64 (ref), u65 (ref), u66 (ref), GhostBoss_3 (upval), u30 (ref), TrainGhostVisuals (upval)
        if a1.UserInputType ~= Enum.UserInputType.MouseButton1 and a1.UserInputType ~= Enum.UserInputType.Touch then
            return
        end
        if u64 == false then
            return
        end
        u64 = false
        if not u64 then
            if u65 == false then
                return
            end
            u65 = false
            u66 = 0
            GhostBoss_3.Suction:FireServer(false)
            if u30 then
                u30:SetLocalSucking(false)
            end
            TrainGhostVisuals.SetYield(false)
        end
    end)
    u4:Connect(UserInputService.WindowFocusReleased, function() -- Line: 327
        -- upvalues: u64 (ref), u65 (ref), u66 (ref), GhostBoss_3 (upval), u30 (ref), TrainGhostVisuals (upval)
        if u64 == false then
            return
        end
        u64 = false
        if not u64 then
            if u65 == false then
                return
            end
            u65 = false
            u66 = 0
            GhostBoss_3.Suction:FireServer(false)
            if u30 then
                u30:SetLocalSucking(false)
            end
            TrainGhostVisuals.SetYield(false)
        end
    end)
    u4:Connect(GhostBoss_3.Defeated.OnClientEvent, function(a1) -- Line: 331 -- upvalues: Toast (upval), u77 (upval), u82 (upval), u34 (val), u36 (val), startDrop (val)
        if typeof(a1) == "table"
            and type(a1.BossId) == "string"
            and type(a1.Souls) == "number"
            and type(a1.Balance) == "number" then
            local v1 = {
                BossId = a1.BossId,
                Souls = math.max(math.floor(a1.Souls), 0),
                Damage = if type(a1.Damage) ~= "number" then 0 else a1.Damage,
                Balance = a1.Balance,
                Rank = if type(a1.Rank) ~= "number" then 0 else a1.Rank,
                Participants = if type(a1.Participants) ~= "number" then 0 else a1.Participants,
            }
            if v1.Rank == 1 and 1 < v1.Participants then
                Toast.Show({
                    Lane = "Feed",
                    Text = "You dealt the most damage to Ghouler!",
                    Seconds = 4,
                    Color = u77,
                    StrokeColor = u82,
                })
            end
            local v2 = u34[v1.BossId]
            if not v2 then
                u36[v1.BossId] = v1
                startDrop(v1.BossId)
            else
                v2:AddSouls(v1)
            end
            if 0 < v1.Souls then
                Toast.Show({
                    Lane = "Feed",
                    Seconds = 3,
                    Image = "rbxassetid://83798853441239",
                    Text = ("+%* Souls"):format(v1.Souls),
                    Color = u77,
                    StrokeColor = u82,
                })
            end
            return
        end
    end)
    u4:Connect(u10.AttributeChanged, sync)
    sync()
    u4:Connect(RunService.RenderStepped, function(a1) -- Line: 373
        -- upvalues: u64 (ref), u81 (ref), LocalPlayer (upval), u65 (ref), u66 (ref), GhostBoss_3 (upval), u30 (ref)
        -- upvalues: TrainGhostVisuals (upval), setSucking (val), wantsBoss (val), Workspace (upval), GhostBoss (upval)
        -- upvalues: u10 (val), Attributes (upval), Phases (upval), u41 (ref), u42 (ref), Toast (upval), u77 (upval)
        -- upvalues: u82 (upval), u31 (ref), u32 (ref), u33 (val), u34 (val)
        local v1, v2
        if u64 then
            if u81 == nil then
                if u64 ~= false then
                    u64 = false
                    if not u64 and u65 ~= false then
                        u65 = false
                        u66 = 0
                        GhostBoss_3.Suction:FireServer(false)
                        if u30 then
                            u30:SetLocalSucking(false)
                        end
                        TrainGhostVisuals.SetYield(false)
                    end
                end
            elseif u81.Parent ~= LocalPlayer.Character and u64 ~= false then
                u64 = false
                if not u64 and u65 ~= false then
                    u65 = false
                    u66 = 0
                    GhostBoss_3.Suction:FireServer(false)
                    if u30 then
                        u30:SetLocalSucking(false)
                    end
                    TrainGhostVisuals.SetYield(false)
                end
            end
        end
        local v3 = u30
        setSucking((wantsBoss(v3)))
        if u65 then
            v1 = os.clock()
            if u66 <= v1 then
                u66 = os.clock() + 0.25
                local Suction = GhostBoss_3.Suction
                local CurrentCamera = Workspace.CurrentCamera
                Suction:FireServer(true, if not CurrentCamera then nil else CurrentCamera.CFrame.LookVector)
            end
        end
        v1 = false
        if v3 ~= nil then
            v1 = false
            if u81 ~= nil then
                v2 = u81
                v1 = v2:IsA("Tool") and v2:GetAttribute(GhostBoss.ToolAttribute) ~= nil
                if not v1 then
                    local CurrentCamera_2 = Workspace.CurrentCamera
                    v1 = v3:InCone(if not CurrentCamera_2 then nil else CurrentCamera_2.CFrame.LookVector)
                end
            end
        end
        if not u64 or not v3 or not v1 then
            u41 = nil
        else
            v2 = (GhostBoss.RealmOf(LocalPlayer)) == GhostBoss.RealmNamed(u10:GetAttribute(Attributes.Realm))
            if not v2 or (v3:GetPhase()) ~= Phases.Alive or v3:InReach() then
                u41 = nil
            else
                v2 = u41 or os.clock()
                u41 = v2
                if 0.8 <= os.clock() - v2 and 5 <= os.clock() - u42 then
                    os.clock()
                    Toast.Show({
                        Lane = "Feed",
                        Text = "Get closer to Ghouler!",
                        Seconds = 2,
                        Color = u77,
                        StrokeColor = u82,
                    })
                end
            end
        end
        if v3 then
            v3:Step(a1)
            if u31 then
                u31:Step((v3:GetPhase()))
            end
            if v3:IsFinished() and u32 == "" then
                v3:Destroy()
                u30 = nil
            end
        end
        for i = #u33, 1, -1 do
            v1 = u33[i]
            v1:Step(a1)
            if v1:IsDone() then
                v1:Destroy()
                table.remove(u33, i)
                for j, k in u34 do
                    if k == v1 then
                        u34[j] = nil
                    end
                end
            end
        end
    end)
    u4:Add(function() -- Line: 431 -- upvalues: TrainGhostVisuals (upval), u31 (ref), u30 (ref), u33 (val), SoulsHud (upval)
        TrainGhostVisuals.SetYield(false)
        if u31 then
            u31:Destroy()
        end
        if u30 then
            u30:Destroy()
        end
        for i, j in u33 do
            j:Destroy()
        end
        SoulsHud.Reset()
    end)
end

return v1