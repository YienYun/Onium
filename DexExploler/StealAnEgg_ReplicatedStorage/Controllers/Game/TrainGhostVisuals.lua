-- Script path: ReplicatedStorage.Controllers.Game.TrainGhostVisuals
-- Decompile time: 15.75 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TrainEventFlags = require(ReplicatedStorage.Shared.Flags.TrainEventFlags)
local Ghosts = require(ReplicatedStorage.Shared.Remotes).TrainEvent.Ghosts
local SuckFX = require(script.SuckFX)
local u35 = {}
local u36 = false
local u37 = false
local u38 = false
local u39 = {}
local u40 = nil
local u41 = {}

local function setGearEffects(a1, a2) -- Line: 21 -- upvalues: u40 (ref), u41 (ref)
    local v1
    if a1 ~= u40 then
        for i, j in u41 do
            if j.Parent then
                j.Enabled = false
            end
        end
        u40 = a1
        u41 = {}
        if a1 then
            for k, n in a1:GetDescendants() do
                if n:IsA("Beam") then
                    if n:GetAttribute("TrainVacuumActiveVFX") == true then
                        table.insert(u41, n)
                    end
                elseif n:IsA("ParticleEmitter") and n:GetAttribute("TrainVacuumActiveVFX") == true then
                    table.insert(u41, n)
                end
            end
        end
    end
    local v2 = nil
    local v3 = nil
    for m, i5 in u41, v2, v3 do
        if i5.Parent then
            v1 = a2 and i5:GetAttribute("TrainVacuumAuthoredEnabled") == true
            if i5.Enabled ~= v1 then
                i5.Enabled = v1
            end
        end
    end
end

function u35.SetInput(a1) -- Line: 45 -- upvalues: u37 (ref)
    u37 = a1 == true
end

function u35.SetYield(a1) -- Line: 49 -- upvalues: u38 (ref)
    u38 = a1 == true
end

function u35.Sample(a1, a2) -- Line: 53
    local Frame, Frame_2, v1, v2, v3
    if #a1 == 0 then
        return nil
    end
    if a2 <= a1[1].Time then
        return a1[1].Frame
    end
    local v4 = #a1
    for i = 2, v4 do
        v1 = a1[i]
        v2 = a1[i - 1]
        if a2 <= v1.Time then
            v3 = v1.Time - v2.Time
            Frame_2 = v2.Frame
            Frame = v1.Frame
            return Frame_2:Lerp(Frame, if not (v3 > 0) then 1 else math.clamp((a2 - v2.Time) / v3, 0, 1))
        end
    end
    return a1[#a1].Frame
end

local function nozzleOf(a1) -- Line: 75
    local Character = a1.Character
    if Character then
        local Nozzle
        for i, j in Character:GetChildren() do
            if j:IsA("Tool") and j:GetAttribute("GhostVacuum") then
                Nozzle = j:FindFirstChild("Nozzle", true)
                if Nozzle and Nozzle:IsA("Attachment") then
                    return Nozzle
                end
            end
        end
    end
    return nil
end

local function loadTracks(a1) -- Line: 90
    local AnimationController = a1.Model:FindFirstChildWhichIsA("AnimationController", true)
    local Animator = AnimationController
    if Animator then
        Animator = AnimationController:FindFirstChildOfClass("Animator")
    end
    local v1 = a1.Model:FindFirstChild("GhostAnimations")
    a1.Tracks = {}
    if Animator and v1 then
        local err, success
        local v2 = {"Idle", "Walk", "Attack"}
        local v3 = nil
        local v4 = nil
        local v5 = a1
        for i, j in v2, v3, v4 do
            local u38 = v1:FindFirstChild(j)
            if u38 then
                success, err = pcall(function() -- Line: 99 -- upvalues: Animator (val), u38 (val)
                    return Animator:LoadAnimation(u38)
                end)
                if not success then
                    warn("[TrainGhostVisuals] " .. v5.Tier .. " " .. j .. ": " .. tostring(err))
                else
                    err.Looped = j ~= "Attack"
                    err.Priority = if j ~= "Attack" then if j ~= "Walk" then Enum.AnimationPriority.Idle else Enum.AnimationPriority.Movement else Enum.AnimationPriority.Action
                    v5.Tracks[j] = err
                end
            end
        end
    end
end

local function stopTracks(a1) -- Line: 124
    if a1.Tracks then
        for i, j in a1.Tracks do
            j:Stop(0)
            j:Destroy()
        end
        a1.Tracks = nil
    end
    if a1.FX then
        a1.FX:Destroy()
        a1.FX = nil
    end
end

local function animate(a1) -- Line: 138 -- upvalues: TrainEventFlags (val)
    local v1 = if not a1.Moving then "Idle" else if a1.Selected then "Idle" else "Walk"
    if v1 ~= a1.Animation then
        if a1.Animation and a1.Tracks[a1.Animation] then
            a1.Tracks[a1.Animation]:Stop(0.15)
        end
        if a1.Tracks[v1] then
            a1.Tracks[v1]:Play(0.15)
        end
        a1.Animation = v1
        a1.Model:SetAttribute("GhostAnimation", v1)
    end
    local AttackSerial = a1.AttackSerial
    if (a1.PlayedAttack or 0) < AttackSerial then
        a1.PlayedAttack = a1.AttackSerial
        if a1.Tracks.Attack then
            a1.Tracks.Attack:Play(0.08, 1, (TrainEventFlags.GhostSwipeSpeed:Get()))
        end
    end
end

local function suctionFX(a1) -- Line: 158 -- upvalues: SuckFX (val)
    a1.FX = SuckFX.new(a1.Model)
end

function u35.GetAimTarget(a1) -- Line: 162 -- upvalues: u39 (val)
    local Model, v1, v2, v3
    local v4 = nil
    local v5 = (1 / 0)
    for i, j in u39 do
        Model = j.Model
        if Model and Model.PrimaryPart then
            v1 = Model:GetPivot().Position - a1.Origin
            v3 = v1:Dot(a1.Direction.Unit)
            v2 = math.clamp(Model:GetExtentsSize().Magnitude * 0.35, 2, 7)
            if v3 > 0 and v3 < v5 and (v1 - a1.Direction.Unit * v3).Magnitude <= v2 then
                v4 = i
            end
        end
    end
    return v4
end

function u35.Start() -- Line: 185
    -- upvalues: u36 (ref), Players (val), Workspace (val), stopTracks (val), TrainEventFlags (val), u39 (val)
    -- upvalues: SuckFX (val), nozzleOf (val), Ghosts (val), RunService (val), setGearEffects (val), u37 (ref)
    -- upvalues: u38 (ref), ReplicatedStorage (val), loadTracks (val), u35 (val), animate (val)
    if u36 then
        return
    end
    u36 = true
    local LocalPlayer = Players.LocalPlayer
    local Folder = Instance.new("Folder")
    Folder.Name = "TrainGhostVisuals"
    Folder.Parent = Workspace
    local u9 = {}

    local function fade(a1) -- Line: 195 -- upvalues: stopTracks (upval), u9 (val), TrainEventFlags (upval)
        stopTracks(a1)
        if not a1.Model then
            return
        end
        local v1 = {}
        local v2 = a1
        for i, j in a1.Model:GetDescendants() do
            if j:IsA("BasePart") or j:IsA("Decal") then
                v1[j] = j.Transparency
            end
        end
        table.insert(u9, {
            Fade = true,
            Model = v2.Model,
            From = v2.Model:GetPivot(),
            Born = os.clock(),
            Parts = v1,
            Duration = TrainEventFlags.GhostFadeSeconds:Get(),
        })
    end

    local u11 = u39
    local u12 = nil
    local u13 = 0
    local u14 = {}

    local function clear() -- Line: 219 -- upvalues: u11 (val), stopTracks (upval), u9 (val)
        local v1 = nil
        local v2 = nil
        for i, j in u11, v1, v2 do
            stopTracks(j)
            if j.Model then
                j.Model:Destroy()
            end
            u11[i] = nil
        end
        for k = #u9, 1, -1 do
            u9[k].Model:Destroy()
            table.remove(u9, k)
        end
    end

    Ghosts.OnClientEvent:Connect(function(a1) -- Line: 232
        -- upvalues: u14 (val), u12 (ref), clear (val), u13 (ref), u11 (val), fade (val), stopTracks (upval)
        -- upvalues: SuckFX (upval), nozzleOf (upval), LocalPlayer (val), u9 (val)
        if typeof(a1) == "table"
            and typeof(a1.VisitId) == "string"
            and typeof(a1.Sequence) == "number"
            and typeof(a1.Time) == "number"
            and typeof(a1.Ghosts) == "table" then
            local v1, v2
            if u14[a1.VisitId] then
                return
            end
            if u12 ~= a1.VisitId then
                clear()
                u12 = a1.VisitId
                u13 = 0
            end
            if a1.Sequence <= u13 then
                return
            end
            u13 = a1.Sequence
            if a1.Closed then
                u14[u12] = true
                for m, i5 in u11 do
                    fade(i5)
                    u11[m] = nil
                end
                return
            end
            local v3 = {}
            local v4 = nil
            local v5 = nil
            local v6 = a1
            for i, j in a1.Ghosts, v4, v5 do
                if typeof(j.Id) == "string" and typeof(j.Frame) == "CFrame" then
                    v2 = {LostSpirit = true, HauntedSpirit = true, VengefulSpirit = true}
                    if v2[j.Tier] then
                        v3[j.Id] = true
                        v1 = u11[j.Id]
                        if not v1 then
                            v1 = {DisplayProgress = 0, Tier = j.Tier, Samples = {}}
                            u11[j.Id] = v1
                        end
                        v1.Progress = math.clamp(j.Progress or 0, 0, 1)
                        v1.Selected = j.Selected == true
                        v1.Moving = j.Moving == true
                        v1.AttackSerial = j.AttackSerial or 0
                        table.insert(v1.Samples, {Time = v6.Time, Frame = j.Frame})
                        while true do
                            if not (#v1.Samples > 6) then
                                break
                            end
                            table.remove(v1.Samples, 1)
                        end
                    end
                end
            end
            v4 = nil
            v5 = nil
            for k, n in u11, v4, v5 do
                if not v3[k] then
                    if n.Model then
                        if k ~= v6.CapturedId then
                            fade(n)
                        else
                            stopTracks(n)
                            SuckFX.Captured(n.Model, (nozzleOf(LocalPlayer)))
                            table.insert(u9, {
                                Model = n.Model,
                                From = n.Model:GetPivot(),
                                Scale = n.Model:GetScale(),
                                Born = os.clock(),
                            })
                        end
                    end
                    u11[k] = nil
                end
            end
            return
        end
    end)
    RunService.RenderStepped:Connect(function(a1) -- Line: 307
        -- upvalues: nozzleOf (upval), LocalPlayer (val), setGearEffects (upval), u37 (upval), u38 (upval)
        -- upvalues: SuckFX (upval), u9 (val), ReplicatedStorage (upval), Workspace (upval), TrainEventFlags (upval)
        -- upvalues: u11 (val), Folder (val), loadTracks (upval), u35 (upval), animate (upval)
        local DisplayProgress, DisplayProgress_2, Progress, Selected, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
        local v11 = nozzleOf(LocalPlayer)
        local v12 = v11 and v11:FindFirstAncestorOfClass("Tool")
        setGearEffects(v12, u37 and not u38 and v12 ~= nil)
        SuckFX.Step(a1)
        local v13 = a1
        for i = #u9, 1, -1 do
            v12 = u9[i]
            v9 = math.clamp((os.clock() - v12.Born) / (v12.Duration or 0.45), 0, 1)
            if v12.Fade then
                for j, k in v12.Parts do
                    j.Transparency = k + (1 - k) * v9
                end
                v12.Model:PivotTo(v12.From + (Vector3.new(0, v9 * 1.5, 0)))
                if v9 >= 1 then
                    v12.Model:Destroy()
                    table.remove(u9, i)
                end
            elseif v9 >= 1 or not v11 then
                if v9 >= 1 and v11 then
                    SuckFX.Burst(v11, true)
                end
                v12.Model:Destroy()
                table.remove(u9, i)
            elseif v11:IsA("Attachment") then
                v10 = v9 * v9
                v12.Model:ScaleTo(v12.Scale * (1 - v10 * 0.9))
                v12.Model:PivotTo((CFrame.new(v12.From.Position:Lerp(v11.WorldPosition, v10))) * v12.From.Rotation * (CFrame.Angles(0, SuckFX.CaptureSpin(v9), 0)))
            else
                if v9 >= 1 and v11 then
                    SuckFX.Burst(v11, true)
                end
                v12.Model:Destroy()
                table.remove(u9, i)
            end
        end
        local TrainGhostTemplates = ReplicatedStorage:FindFirstChild("TrainGhostTemplates")
        local v14 = (Workspace:GetServerTimeNow()) - TrainEventFlags.GhostInterpolationSeconds:Get()
        v9 = nil
        v10 = nil
        for n, m in u11, v9, v10 do
            if not m.Model and TrainGhostTemplates then
                v1 = TrainGhostTemplates:FindFirstChild(m.Tier)
                if v1 and v1:IsA("Model") and v1.PrimaryPart then
                    v2 = v1:Clone()
                    v2.Name = n
                    v2:SetAttribute("TrainGhost", true)
                    v2:SetAttribute("OwnerUserId", LocalPlayer.UserId)
                    for i5, i6 in v2:GetDescendants() do
                        if i6:IsA("BasePart") then
                            v7 = i6 == v2.PrimaryPart
                            i6.Anchored = v7
                            i6.Massless = true
                            i6.CanCollide = false
                            i6.CanTouch = false
                            i6.CanQuery = false
                        end
                    end
                    v2:PivotTo(m.Samples[#m.Samples].Frame)
                    v2.Parent = Folder
                    m.Model = v2
                    m.Scale = v2:GetScale()
                    loadTracks(m)
                    m.FX = SuckFX.new(m.Model)
                end
            end
            v1 = u35.Sample(m.Samples, v14)
            if m.Model and v1 then
                Selected = m.Selected and u37 and not u38
                Progress = if not Selected then 0 else m.Progress
                DisplayProgress = m.DisplayProgress
                v5 = Progress - m.DisplayProgress
                v8 = -10 * v13
                m.DisplayProgress = DisplayProgress + v5 * (1 - math.exp(v8))
                DisplayProgress_2 = m.DisplayProgress
                m.Model:ScaleTo(m.Scale * (m.FX:Scale(DisplayProgress_2)))
                v3 = Selected and v11 ~= nil
                v7 = if not v3 then nil else v11
                v2 = m.FX:Pose(v1, v7, DisplayProgress_2, v13)
                v4 = if not m.Pose then v2 else m.Pose:Lerp(v2, 1 - (math.exp(-24 * v13)))
                m.Pose = v4
                m.Model:PivotTo(m.Pose)
                animate(m)
                m.Model:SetAttribute("ServerCaptureProgress", m.Progress)
                v6 = if not v3 then nil else v11
                m.FX:Update(v6, DisplayProgress_2, v13)
            end
        end
    end)
end

return u35