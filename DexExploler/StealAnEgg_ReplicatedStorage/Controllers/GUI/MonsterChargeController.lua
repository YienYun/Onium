-- Script path: ReplicatedStorage.Controllers.GUI.MonsterChargeController
-- Decompile time: 17.58 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local MonsterParasiteEligibility = require(ReplicatedStorage.Shared.Util.MonsterParasiteEligibility)
local MonsterParasite_2 = require(ReplicatedStorage.Shared.Types.MonsterParasite)
require(ReplicatedStorage.Packages.Networking)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
return {
    Start = function() -- Line: 76
        -- upvalues: Remotes (val), Players (val), Trove (val), MonsterParasite (val), Workspace (val)
        -- upvalues: ReplicatedStorage (val), Save (val), MonsterParasiteEligibility (val), MonsterParasite_2 (val)
        -- upvalues: RunService (val), Timer (val)
        local MonsterParasite_3 = Remotes.MonsterParasite
        local LocalPlayer = Players.LocalPlayer
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
        local v1 = Trove.new()
        local u11 = {Active = false}
        u11.EndsAt = MonsterParasite.EndsAt
        u11.ServerTime = os.time()
        local u16 = 0
        local u17 = nil
        local u18 = nil
        local u19 = nil
        local u20 = nil
        local u21 = nil
        local u22 = false
        local u23 = {}
        local u24 = nil
        local u25 = true
        local u26 = 0
        local u27 = 0
        local u28 = nil
        local u29 = 0
        local u30 = nil
        local u31 = false
        local u32 = 0
        local u33 = nil
        local u34 = nil
        local u35 = {}
        local u36 = nil

        local function formatRemaining(a1) -- Line: 122 -- types: a1: number
            local v1 = math.max(math.floor(a1), 0)
            local v2 = v1 // 86400
            local v3 = v1 % 86400 // 3600
            local v4 = v1 % 3600 // 60
            if v2 > 0 then
                return (("%*d %*h"):format(v2, v3))
            end
            return (("%*h %*m"):format(v3, v4))
        end

        local function getOwnedMonster() -- Line: 133
            -- upvalues: Workspace (upval), MonsterParasite (upval), LocalPlayer (val)
            local v1 = Workspace:FindFirstChild(MonsterParasite.WorldFolderName)
            if v1 ~= nil and v1:IsA("Folder") then
                for i, j in v1:GetChildren() do
                    if j:IsA("Model") and (j:GetAttribute("OwnerUserId")) == LocalPlayer.UserId then
                        return j
                    end
                end
                return nil
            end
            return nil
        end

        local function resolveTemplate() -- Line: 146 -- upvalues: ReplicatedStorage (upval), u22 (ref)
            local Assets = ReplicatedStorage:FindFirstChild("Assets")
            local Extra = if not Assets then nil else Assets:FindFirstChild("Extra")
            local v1 = if not Extra then nil else Extra:FindFirstChild("MonsterBillboardAttachment")
            if v1 ~= nil and v1:IsA("Attachment") then
                return v1
            end
            if not u22 then
                u22 = true
                warn("[MonsterCharge] Missing ReplicatedStorage.Assets.Extra.MonsterBillboardAttachment; the monster billboard is skipped")
            end
            return nil
        end

        local function resolveMonsterTemplate(a1) -- Line: 162
            -- upvalues: ReplicatedStorage (upval), MonsterParasite (upval)
            local Assets = ReplicatedStorage:FindFirstChild("Assets")
            local Models = if not Assets then nil else Assets:FindFirstChild("Models")
            local v1 = if not Models then nil else Models:FindFirstChild(MonsterParasite.AssetsFolderName)
            local v2 = MonsterParasite.MonsterModelNames[a1]
            local v3 = if not v1 then nil else if not v2 then nil else v1:FindFirstChild(v2)
            if v3 and v3:IsA("Model") and v3.PrimaryPart then
                return v3
            end
            return nil
        end

        local function measureHeadHeight(a1) -- Line: 177 -- types: a1: userdata
            local PrimaryPart = a1.PrimaryPart
            if PrimaryPart == nil then
                return nil
            end
            local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
            return PrimaryPart.CFrame:PointToObjectSpace(BoundingBox.Position + Vector3.new(0, 1, 0) * (BoundingBox_2.Y * 0.5)).Y
        end

        local function resolveBillboardHeight(a1, a2) -- Line: 192
            -- upvalues: MonsterParasite (upval), u23 (val), resolveMonsterTemplate (val)
            local Attribute = a1:GetAttribute(MonsterParasite.MonsterModelIndexAttributeName)
            local v1 = if typeof(Attribute) ~= "number" then nil else Attribute
            local v2 = if not v1 then nil else u23[v1]
            if v2 == nil then
                local Y
                local v3 = if not v1 then nil else resolveMonsterTemplate(v1)
                if not v3 then
                    Y = nil
                else
                    local PrimaryPart = v3.PrimaryPart
                    if PrimaryPart ~= nil then
                        local BoundingBox, BoundingBox_2 = v3:GetBoundingBox()
                        Y = PrimaryPart.CFrame:PointToObjectSpace(BoundingBox.Position + Vector3.new(0, 1, 0) * (BoundingBox_2.Y * 0.5)).Y
                    else
                        Y = nil
                    end
                end
                if not Y then
                    local PrimaryPart_2 = a1.PrimaryPart
                    if PrimaryPart_2 ~= nil then
                        local BoundingBox_3, BoundingBox_4 = a1:GetBoundingBox()
                        Y = PrimaryPart_2.CFrame:PointToObjectSpace(BoundingBox_3.Position + Vector3.new(0, 1, 0) * (BoundingBox_4.Y * 0.5)).Y
                    else
                        Y = nil
                    end
                end
                v2 = Y
                if v2 ~= nil and v1 ~= nil then
                    u23[v1] = v2
                end
            end
            if v2 == nil then
                return 8.5
            end
            return v2 + (if not a2 then 2 else a2.Size.Y.Scale * 0.5) + 0.75
        end

        local function setLabelText(a1, a2, a3) -- Line: 214 -- types: a1: userdata, a2: string, a3: string
            local v1 = a1:FindFirstChild(a2, true)
            if v1 ~= nil and v1:IsA("TextLabel") then
                v1.Text = a3
            end
        end

        local function resolveDebrisFolder() -- Line: 221 -- upvalues: Workspace (upval)
            local Transient = Workspace:FindFirstChild("Transient")
            if Transient ~= nil then
                return Transient
            end
            return Workspace
        end

        local function createAnchor() -- Line: 230 -- upvalues: Workspace (upval)
            local Part = Instance.new("Part")
            Part.Name = "MonsterBillboardAnchor"
            Part.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
            Part.Transparency = 1
            Part.Anchored = true
            Part.CanCollide = false
            Part.CanQuery = false
            Part.CanTouch = false
            Part.CastShadow = false
            Part.Massless = true
            Part.Locked = true
            Part.Archivable = false
            local Transient = Workspace:FindFirstChild("Transient")
            Part.Parent = if Transient == nil then Workspace else Transient
            return Part
        end

        local function destroyBillboard() -- Line: 247
            -- upvalues: u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), u24 (ref), u25 (ref)
            if u17 ~= nil then
                u17:Destroy()
                u17 = nil
            end
            u18 = nil
            u19 = nil
            u20 = nil
            u21 = nil
            u24 = nil
            u25 = true
        end

        local function ensureBillboard(a1) -- Line: 261
            -- upvalues: u17 (ref), u18 (ref), u19 (ref), u20 (ref), u21 (ref), u24 (ref), u25 (ref)
            -- upvalues: resolveTemplate (val), Workspace (upval), MonsterParasite (upval), resolveBillboardHeight (val)
            local PrimaryPart = a1.PrimaryPart
            if PrimaryPart == nil then
                if u17 ~= nil then
                    u17:Destroy()
                    u17 = nil
                end
                u18 = nil
                u19 = nil
                u20 = nil
                u21 = nil
                u24 = nil
                u25 = true
                return nil
            end
            local v1 = resolveTemplate()
            if v1 == nil then
                if u17 ~= nil then
                    u17:Destroy()
                    u17 = nil
                end
                u18 = nil
                u19 = nil
                u20 = nil
                u21 = nil
                u24 = nil
                u25 = true
                return nil
            end
            local v2 = u17
            if v2 ~= nil and v2.Parent == nil then
                if u17 ~= nil then
                    u17:Destroy()
                    u17 = nil
                end
                u18 = nil
                u19 = nil
                u20 = nil
                u21 = nil
                u24 = nil
                u25 = true
                v2 = nil
            end
            local v3 = u18
            if v2 == nil or v3 == nil then
                if u17 ~= nil then
                    u17:Destroy()
                    u17 = nil
                end
                u18 = nil
                u19 = nil
                u20 = nil
                u21 = nil
                u24 = nil
                u25 = true
                v2 = Instance.new("Part")
                v2.Name = "MonsterBillboardAnchor"
                v2.Size = Vector3.new(0.10000000149011612, 0.10000000149011612, 0.10000000149011612)
                v2.Transparency = 1
                v2.Anchored = true
                v2.CanCollide = false
                v2.CanQuery = false
                v2.CanTouch = false
                v2.CastShadow = false
                v2.Massless = true
                v2.Locked = true
                v2.Archivable = false
                local Transient = Workspace:FindFirstChild("Transient")
                v2.Parent = if Transient == nil then Workspace else Transient
                v3 = v1:Clone()
                v3.Parent = v2
                u17 = v2
                u18 = v3
                local MonsterDisplayName = MonsterParasite.MonsterDisplayName
                local MonsterName = v3:FindFirstChild("MonsterName", true)
                if MonsterName ~= nil and MonsterName:IsA("TextLabel") then
                    MonsterName.Text = MonsterDisplayName
                end
                local Progress = v3:FindFirstChild("Progress", true)
                local Fill = if not Progress then nil else Progress:FindFirstChild("Fill")
                local Progress_2 = if not Progress then nil else Progress:FindFirstChild("Progress", true)
                u19 = if not Fill then nil else if not Fill:IsA("GuiObject") then nil else Fill
                u20 = if not Progress_2 then nil else if not Progress_2:IsA("TextLabel") then nil else Progress_2
            end
            if v2.CFrame ~= PrimaryPart.CFrame then
                v2.CFrame = PrimaryPart.CFrame
            end
            v1 = resolveBillboardHeight(a1, (v3:FindFirstChildWhichIsA("BillboardGui")))
            u24 = v1
            if u25 then
                u25 = false
                v3.Position = Vector3.new(0, v1, 0)
            end
            u21 = a1
            return v3
        end

        local function refreshTargetAlpha() -- Line: 325
            -- upvalues: u26 (ref), u31 (ref), u34 (ref), MonsterParasite (upval)
            u26 = if not u31 then math.clamp((u34 or 0) / MonsterParasite.MaxCharge, 0, 1) else 1
        end

        local function render() -- Line: 335
            -- upvalues: Save (upval), MonsterParasiteEligibility (upval), getOwnedMonster (val), u11 (ref), u17 (ref)
            -- upvalues: u18 (ref), u19 (ref), u20 (ref), u21 (ref), u24 (ref), u25 (ref), u33 (ref), u34 (ref)
            -- upvalues: u35 (val), u31 (ref), u28 (ref), u27 (ref), u26 (ref), ensureBillboard (val)
            -- upvalues: MonsterParasite (upval), u16 (ref)
            local v1 = Save.Await()
            local v2 = false
            if v1 ~= nil then
                v2 = MonsterParasiteEligibility.IsEligible(v1.SpeedPower)
            end
            local v3 = getOwnedMonster()
            if v1 ~= nil and v2 and u11.Active and v3 ~= nil then
                v2 = ensureBillboard(v3)
                if v2 == nil then
                    return
                end
                local MonsterParasite_2 = v1.MonsterParasite
                v1 = u33
                u33 = MonsterParasite_2.Charge
                if u34 == nil then
                    u34 = MonsterParasite_2.Charge
                elseif v1 ~= nil and MonsterParasite_2.Charge ~= v1 then
                    table.insert(u35, {Wrap = MonsterParasite_2.Charge < v1, Since = os.clock()})
                end
                u26 = if not u31 then math.clamp((u34 or 0) / MonsterParasite.MaxCharge, 0, 1) else 1
                v3 = os.time() + u16
                v1 = math.max(math.floor(u11.EndsAt - v3), 0)
                local v4 = v1 // 86400
                local v5 = v1 % 86400 // 3600
                local v6 = v1 % 3600 // 60
                local v7 = ("Leaves in %*"):format(if not (v4 > 0) then ("%*h %*m"):format(v5, v6) else ("%*d %*h"):format(v4, v5))
                local Timer = v2:FindFirstChild("Timer", true)
                if Timer ~= nil and Timer:IsA("TextLabel") then
                    Timer.Text = v7
                end
                return
            end
            if u17 ~= nil then
                u17:Destroy()
                u17 = nil
            end
            u18 = nil
            u19 = nil
            u20 = nil
            u21 = nil
            u24 = nil
            u25 = true
            u33 = nil
            u34 = nil
            table.clear(u35)
            u31 = false
            u28 = nil
            u27 = 0
            u26 = 0
        end

        local function startDrain() -- Line: 386
            -- upvalues: u31 (ref), u28 (ref), u27 (ref), u26 (ref), u29 (ref), u34 (ref), u33 (ref)
            -- upvalues: MonsterParasite (upval)
            u31 = false
            math.max(u27, u26)
            os.clock()
            u34 = u33
            u26 = if not u31 then math.clamp((u34 or 0) / MonsterParasite.MaxCharge, 0, 1) else 1
        end

        local function releaseGain() -- Line: 399
            -- upvalues: u35 (val), u34 (ref), MonsterParasite (upval), u31 (ref), u32 (ref), u26 (ref), u33 (ref)
            local v1 = table.remove(u35, 1)
            if v1 == nil then
                return
            end
            if v1.Wrap then
                u34 = MonsterParasite.MaxCharge
                u31 = true
                os.clock()
                u26 = if not u31 then math.clamp((u34 or 0) / MonsterParasite.MaxCharge, 0, 1) else 1
                return
            end
            u34 = math.clamp((u34 or 0) + MonsterParasite.ChargePerFeed, 0, MonsterParasite.MaxCharge)
            if #u35 == 0 then
                u34 = u33
            end
            u26 = if not u31 then math.clamp((u34 or 0) / MonsterParasite.MaxCharge, 0, 1) else 1
        end

        local function stepAnchor(a1) -- Line: 427
            -- upvalues: u17 (ref), u18 (ref), u24 (ref), u21 (ref)
            local v1 = u17
            local v2 = u18
            local v3 = u24
            if v1 ~= nil and v2 ~= nil and v3 ~= nil then
                local v4 = u21
                local PrimaryPart = if v4 == nil then nil else v4.PrimaryPart
                if PrimaryPart ~= nil and v1.CFrame ~= PrimaryPart.CFrame then
                    v1.CFrame = PrimaryPart.CFrame
                end
                local Y = v2.Position.Y
                if not ((math.abs(v3 - Y)) < 0.001) then
                    v2.Position = Vector3.new(0, Y + (v3 - Y) * (math.min(a1 * 9, 1)), 0)
                    return
                end
                if Y ~= v3 then
                    v2.Position = Vector3.new(0, v3, 0)
                end
                return
            end
        end

        local function setEventState(a1) -- Line: 526 -- upvalues: u11 (ref), u16 (ref), render (val)
            u11 = a1
            u16 = a1.ServerTime - os.time()
            render()
        end

        v1:Connect(PlayerGui.ChildAdded, function(a1) -- Line: 532 -- upvalues: PlayerGui (val), MonsterParasite (upval) -- types: a1: userdata?
            local v1 = if a1 == nil then PlayerGui:FindFirstChild(MonsterParasite.HudName) else a1
            if v1 ~= nil and v1.Name == MonsterParasite.HudName and v1:IsA("ScreenGui") then
                v1.Enabled = false
            end
        end)
        local v2 = PlayerGui:FindFirstChild(MonsterParasite.HudName)
        if v2 ~= nil and v2.Name == MonsterParasite.HudName and v2:IsA("ScreenGui") then
            v2.Enabled = false
        end
        v1:Connect(Save.Watch("MonsterParasite"), render)
        v1:Connect(Save.Watch("SpeedPower"), render)
        v1:Connect(MonsterParasite_3.EventStateShifted.OnClientEvent, function(a1) -- Line: 550 -- upvalues: MonsterParasite_2 (upval), u11 (ref), u16 (ref), render (val)
            if MonsterParasite_2.EventStateSchema(a1) then
                u11 = a1
                u16 = a1.ServerTime - os.time()
                render()
            end
        end)
        v1:Connect(RunService.RenderStepped, function(a1) -- Line: 455
            -- upvalues: stepAnchor (val), u19 (ref), LocalPlayer (val), MonsterParasite_2 (upval), u36 (ref)
            -- upvalues: releaseGain (val), u35 (val), u21 (ref), u30 (ref), u31 (ref), u28 (ref), u27 (ref), u26 (ref)
            -- upvalues: u29 (ref), u34 (ref), u33 (ref), MonsterParasite (upval), u32 (ref), u20 (ref)
            local v1
            stepAnchor(a1)
            local v2 = u19
            if v2 == nil then
                return
            end
            local Attribute = LocalPlayer:GetAttribute(MonsterParasite_2.ChargeGainAttributeName)
            if typeof(Attribute) == "number" and Attribute ~= u36 then
                u36 = Attribute
                releaseGain()
            end
            local v3 = u35[1]
            if v3 ~= nil then
                v1 = os.clock() - v3.Since
                if MonsterParasite_2.ChargeGainCueTimeout < v1 then
                    releaseGain()
                end
            end
            v3 = u21
            local Attribute_2 = if not v3 then nil else v3:GetAttribute(MonsterParasite_2.ChargeDrainAttributeName)
            if typeof(Attribute_2) ~= "number" then
                if u31 then
                    if os.clock() - u32 > 6 then
                        u31 = false
                        u28 = math.max(u27, u26)
                        u29 = os.clock()
                        u34 = u33
                        u26 = if not u31 then math.clamp((u34 or 0) / MonsterParasite.MaxCharge, 0, 1) else 1
                    end
                end
            elseif Attribute_2 ~= u30 then
                u30 = Attribute_2
                u31 = false
                u28 = math.max(u27, u26)
                u29 = os.clock()
                u34 = u33
                u26 = if not u31 then math.clamp((u34 or 0) / MonsterParasite.MaxCharge, 0, 1) else 1
            elseif u31 then
                if os.clock() - u32 > 6 then
                    u31 = false
                    u28 = math.max(u27, u26)
                    u29 = os.clock()
                    u34 = u33
                    u26 = if not u31 then math.clamp((u34 or 0) / MonsterParasite.MaxCharge, 0, 1) else 1
                end
            end
            v1 = u28
            if v1 == nil then
                u27 = u27 + (u26 - u27) * math.min(a1 * 14, 1)
                if (math.abs(u26 - u27)) < 0.001 then
                    u27 = u26
                end
            else
                v3 = math.clamp((os.clock() - u29) / MonsterParasite_2.ChargeDrainDuration, 0, 1)
                u27 = v1 * (1 - v3 * v3 * (3 - v3 * 2))
                if v3 >= 1 then
                    u28 = nil
                    u27 = 0
                end
            end
            v1 = math.clamp(u27, 0, 1)
            v2.Size = UDim2.fromScale(v1, 1)
            v2 = u20
            if v2 ~= nil then
                v2.Text = ("%*%%"):format((math.round(v1 * 100)))
            end
        end)
        local v3 = Timer.new(0.15)
        v1:Add(v3)
        v1:Connect(v3.Tick, render)
        v3:Start()
        task.spawn(function() -- Line: 563
            -- upvalues: MonsterParasite_3 (val), MonsterParasite_2 (upval), u11 (ref), u16 (ref), render (val)
            local success, err = pcall(function() -- Line: 564 -- upvalues: MonsterParasite_3 (upval)
                return MonsterParasite_3.AskSnapshot:InvokeServer()
            end)
            if success and MonsterParasite_2.SnapshotSchema(err) then
                local Event = err.Event
                u11 = Event
                u16 = Event.ServerTime - os.time()
                render()
                return
            end
        end)
    end,
}