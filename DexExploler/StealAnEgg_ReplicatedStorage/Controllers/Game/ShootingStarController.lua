-- Script path: ReplicatedStorage.Controllers.Game.ShootingStarController
-- Decompile time: 20.42 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Buddy = require(script.Buddy)
local Celebrate = require(script.Celebrate)
local Cinematic = require(script.Cinematic)
local Fx = require(script.Fx)
local Hud = require(script.Hud)
local Meteor = require(script.Meteor)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local StarFeed = require(script.StarFeed)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u75 = Color3.fromRGB(255, 225, 0)
local LocalPlayer = Players.LocalPlayer
local u77 = nil
local u78 = nil
local v1 = {}

local function now() -- Line: 80 -- upvalues: Workspace (val)
    return Workspace:GetServerTimeNow()
end

local function folder() -- Line: 84 -- upvalues: Workspace (val)
    local ShootingStarClient = Workspace:FindFirstChild("ShootingStarClient")
    if ShootingStarClient and ShootingStarClient:IsA("Folder") then
        return ShootingStarClient
    end
    local Folder = Instance.new("Folder")
    Folder.Name = "ShootingStarClient"
    Folder.Parent = Workspace
    return Folder
end

local function rootPosition() -- Line: 95 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        return HumanoidRootPart.Position
    end
    return nil
end

local function starPosition(a1) -- Line: 101 -- types: a1: table
    local Buddy = a1.Buddy
    if Buddy then
        return Buddy:Position()
    end
    return a1.Payload.Landing.Position
end

local function endSession(a1) -- Line: 109 -- upvalues: u77 (ref), Hud (val) -- types: a1: table
    if u77 == a1 then
        u77 = nil
    end
    a1.Done = true
    Hud.Waypoint(nil)
    Hud.Objective(false)
    Hud.Border(0)
    a1.Trove:Destroy()
end

local function refreshProgress(a1) -- Line: 120
    -- upvalues: Workspace (val), LocalPlayer (val), Hud (val)
    local Payload = a1.Payload
    local v1 = Payload.ExpiresAt - Workspace:GetServerTimeNow()
    local v2 = math.max(Payload.ExpiresAt - Payload.LandAt, 1)
    local v3 = nil
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    local Position = if not HumanoidRootPart then nil else if not HumanoidRootPart:IsA("BasePart") then nil else HumanoidRootPart.Position
    if a1.Buddy and a1.Noticed and Position then
        local Buddy = a1.Buddy
        if (Position - (if not Buddy then a1.Payload.Landing.Position else Buddy:Position())).Magnitude < 16 then
            v3 = if not a1.HoldStart then "HOLD TO CATCH IT!" else "KEEP HOLDING!"
        end
    end
    Hud.Progress(v1 / v2, v1, v3)
end

local function placeMeteor(a1) -- Line: 137 -- upvalues: Meteor (val), Workspace (val), Fx (val) -- types: a1: table
    local v1
    local Payload = a1.Payload
    local new = Meteor.new
    local Landing = Payload.Landing
    local ShootingStarClient = Workspace:FindFirstChild("ShootingStarClient")
    if not ShootingStarClient or not ShootingStarClient:IsA("Folder") then
        local Folder = Instance.new("Folder")
        Folder.Name = "ShootingStarClient"
        Folder.Parent = Workspace
        v1 = Folder
    else
        v1 = ShootingStarClient
    end
    local u32 = new(Landing, 3, 0, v1)
    a1.Meteor = u32
    a1.Trove:Add(function() -- Line: 141 -- upvalues: a1 (val), u32 (val)
        if a1.Meteor == u32 then
            u32:Destroy()
        end
    end)
    local Position = Payload.Landing.Position
    Fx.Emit("Impact", Position, 1)
    Fx.Sound("StarImpact", Position, 1)
    return u32
end

local function retireMeteor(a1, a2) -- Line: 152 -- types: a1: table, a2: number
    local Meteor = a1.Meteor
    if Meteor == nil then
        return
    end
    a1.Meteor = nil
    task.delay(a2, function() -- Line: 158 -- upvalues: Meteor (val)
        Meteor:LightOff()
        Meteor:Fade()
    end)
end

local function setHolding(a1, a2) -- Line: 164
    -- upvalues: Hud (val), Workspace (val), TweenService (val), RunService (val), Fx (val)
    if not a2 then
        a1.HoldStart = nil
        Hud.Border(0)
        if a1.Buddy then
            a1.Buddy:Release(false)
        end
        return
    end
    local CurrentCamera = Workspace.CurrentCamera
    local u16 = os.clock()
    a1.HoldStart = u16
    local FieldOfView = CurrentCamera.FieldOfView
    local u18 = 0
    local u19 = false
    local u23 = a1.Trove:Extend()
    u23:Add(function() -- Line: 180 -- upvalues: u19 (ref), TweenService (upval), CurrentCamera (val), FieldOfView (val)
        u19 = true
        TweenService:Create(CurrentCamera, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {FieldOfView = FieldOfView}):Play()
    end)
    u23:Connect(RunService.RenderStepped, function() -- Line: 188
        -- upvalues: u19 (ref), a1 (val), u16 (val), u23 (val), Hud (upval), Fx (upval), CurrentCamera (val)
        -- upvalues: FieldOfView (val), u18 (ref)
        if u19 then
            return
        end
        if a1.HoldStart ~= u16 then
            u19 = true
            task.defer(function() -- Line: 194 -- upvalues: u23 (upval)
                u23:Destroy()
            end)
            return
        end
        local v1 = math.clamp((os.clock() - u16) / a1.Payload.HoldSeconds, 0, 1)
        local v2 = v1 * v1 * (3 - v1 * 2)
        if a1.Buddy then
            a1.Buddy:Charge(v2)
        end
        Hud.Border(v2)
        if not Fx.ReducedMotion() then
            CurrentCamera.FieldOfView = FieldOfView - v2 * 6
        end
        v1 = os.clock()
        if 0.1 < v1 - u18 then
            u18 = v1
            Fx.Shake(0.14, v2 * 0.32 + 0.06, nil)
        end
    end)
end

local function spawnBuddy(a1, a2) -- Line: 216
    -- upvalues: Buddy (val), Workspace (val), Remotes (val), setHolding (val), Hud (val)
    local v1
    local Payload = a1.Payload
    local new = Buddy.new
    local ShootingStarClient = Workspace:FindFirstChild("ShootingStarClient")
    if not ShootingStarClient or not ShootingStarClient:IsA("Folder") then
        local Folder = Instance.new("Folder")
        Folder.Name = "ShootingStarClient"
        Folder.Parent = Workspace
        v1 = Folder
    else
        v1 = ShootingStarClient
    end
    local u35 = new(v1, a1.Leg, a1.Noticed, Payload.HoldSeconds, {
        HoldBegan = function() -- Line: 219 -- upvalues: a1 (val), Remotes (upval), Payload (val), setHolding (upval)
            if not a1.Done and not a1.Caught then
                Remotes.ShootingStar.Hold:FireServer(Payload.Id, true)
                setHolding(a1, true)
                return
            end
        end,
        HoldEnded = function() -- Line: 226 -- upvalues: a1 (val), Remotes (upval), Payload (val), Hud (upval)
            local HoldStart = a1.HoldStart
            task.delay(0.15, function() -- Line: 228 -- upvalues: a1 (upval), HoldStart (val), Remotes (upval), Payload (upval), Hud (upval)
                if not a1.Done and not a1.Caught and a1.HoldStart == HoldStart then
                    Remotes.ShootingStar.Hold:FireServer(Payload.Id, false)
                    local v1 = a1
                    v1.HoldStart = nil
                    Hud.Border(0)
                    if v1.Buddy then
                        v1.Buddy:Release(false)
                    end
                    return
                end
            end)
        end,
        Triggered = function() -- Line: 236 -- upvalues: a1 (val), Remotes (upval), Payload (val), Hud (upval)
            if not a1.Done and not a1.Caught then
                a1.Caught = true
                Remotes.ShootingStar.Catch:FireServer(Payload.Id)
                task.delay(1.5, function() -- Line: 242 -- upvalues: a1 (upval), Hud (upval)
                    if not a1.Done and a1.Caught then
                        a1.Caught = false
                        local v1 = a1
                        v1.HoldStart = nil
                        Hud.Border(0)
                        if v1.Buddy then
                            v1.Buddy:Release(false)
                        end
                    end
                end)
                return
            end
        end,
    })
    a1.Buddy = u35
    a1.Trove:Add(function() -- Line: 251 -- upvalues: a1 (val), u35 (val)
        if a1.Buddy == u35 then
            u35:Destroy()
        end
    end)
    if a2 then
        u35:PopOut()
    end
    return u35
end

local function startHud(a1) -- Line: 262
    -- upvalues: Hud (val), refreshProgress (val), RunService (val)
    Hud.Objective(true)
    refreshProgress(a1)
    Hud.Waypoint(function() -- Line: 265 -- upvalues: a1 (val)
        if a1.Done then
            return nil
        end
        local v1 = a1
        local Buddy = v1.Buddy
        if Buddy then
            return (Buddy:Position())
        end
        return v1.Payload.Landing.Position
    end)
    local u12 = 0
    a1.Trove:Connect(RunService.Heartbeat, function(a1_2) -- Line: 269 -- upvalues: u12 (ref), refreshProgress (upval), a1 (val) -- types: a1_2: number
        u12 = u12 + a1_2
        if u12 >= 0.2 then
            u12 = 0
            refreshProgress(a1)
        end
    end)
end

local function reveal(a1) -- Line: 278
    -- upvalues: Cinematic (val), Workspace (val), spawnBuddy (val)
    if not a1.Done and not a1.Buddy then
        if a1.Meteor then
            a1.Meteor:Open()
            local v1 = math.max(a1.Payload.LandAt + Cinematic.Seconds() - Workspace:GetServerTimeNow(), 1.5)
            local Meteor = a1.Meteor
            if Meteor ~= nil then
                a1.Meteor = nil
                task.delay(v1, function() -- Line: 158 -- upvalues: Meteor (val)
                    Meteor:LightOff()
                    Meteor:Fade()
                end)
            end
        end
        task.delay(0.45, function() -- Line: 287 -- upvalues: a1 (val), spawnBuddy (upval)
            if not a1.Done and a1.Buddy == nil then
                spawnBuddy(a1, true)
            end
        end)
        return
    end
end

local function runFall(a1, a2) -- Line: 294
    -- upvalues: Fx (val), Workspace (val), placeMeteor (val), reveal (val), startHud (val), RunService (val)
    -- upvalues: Cinematic (val), now (val)
    local v1
    local Payload = a1.Payload
    local u4 = Payload.FallAt + 1
    local u14 = Fx.Kit():FindFirstChild("FallingStar"):Clone()
    local ShootingStarClient = Workspace:FindFirstChild("ShootingStarClient")
    if not ShootingStarClient or not ShootingStarClient:IsA("Folder") then
        local Folder = Instance.new("Folder")
        Folder.Name = "ShootingStarClient"
        Folder.Parent = Workspace
        v1 = Folder
    else
        v1 = ShootingStarClient
    end
    u14.Parent = v1
    a1.Trove:Add(u14)
    local u41 = false
    local u42 = false
    local u46 = nil
    a1.Trove:Connect(RunService.RenderStepped, function() -- Line: 317
        -- upvalues: Workspace (upval), u4 (val), Payload (val), u14 (val), Cinematic (upval), u41 (ref), Fx (upval)
        -- upvalues: u46 (ref), u42 (ref), a1 (val), placeMeteor (upval), a2 (val), reveal (upval), startHud (upval)
        local ServerTimeNow = Workspace:GetServerTimeNow()
        local v1 = math.clamp((ServerTimeNow - u4) / (Payload.LandAt - u4), 0, 1)
        if ServerTimeNow < u4 then
            u14:PivotTo((CFrame.new((Cinematic.StarAt(Payload.Landing, 0)))))
            return
        end
        if not u41 then
            u41 = true
            Fx.Sound("StarFall", nil, 0.85)
        end
        local v2 = Cinematic.StarAt(Payload.Landing, v1)
        local v3 = Cinematic.StarAt(Payload.Landing, (math.min(v1 + 0.02, 1)))
        u14:PivotTo((CFrame.lookAt(v2, if not (0.001 < (v3 - v2).Magnitude) then v2 + Vector3.new(0, -1, 0) else v3)) * (CFrame.Angles(0, 0, ServerTimeNow * 6)))
        if v1 >= 1 then
            u46:Disconnect()
            if not u42 then
                if a1.Done then
                    return
                end
                u42 = true
                u14:Destroy()
                placeMeteor(a1)
                if not a2 then
                    task.delay(0.85, reveal, a1)
                    startHud(a1)
                end
            end
        end
    end)
    if a2 then
        Cinematic.Play(Payload, now, {
            Land = function() -- Line: 303
                -- upvalues: u42 (ref), a1 (val), u14 (val), placeMeteor (upval), a2 (val), reveal (upval)
                -- upvalues: startHud (upval)
                if not u42 and not a1.Done then
                    u42 = true
                    u14:Destroy()
                    placeMeteor(a1)
                    if not a2 then
                        task.delay(0.85, reveal, a1)
                        startHud(a1)
                    end
                    return
                end
            end,
            Rise = function() -- Line: 343 -- upvalues: reveal (upval), a1 (val)
                reveal(a1)
            end,
        })
        task.delay(math.max(Payload.LandAt + Cinematic.Seconds() + 0.6 - Workspace:GetServerTimeNow(), 0), function() -- Line: 347 -- upvalues: a1 (val), startHud (upval)
            if not a1.Done then
                startHud(a1)
            end
        end)
    end
end

local function begin(a1) -- Line: 355
    -- upvalues: u77 (ref), Hud (val), Workspace (val), Fx (val), Trove (val), spawnBuddy (val), startHud (val)
    -- upvalues: runFall (val)
    if u77 then
        local v1 = u77
        if u77 == v1 then
            u77 = nil
        end
        v1.Done = true
        Hud.Waypoint(nil)
        Hud.Objective(false)
        Hud.Border(0)
        v1.Trove:Destroy()
    end
    if a1.ExpiresAt <= (Workspace:GetServerTimeNow()) then
        return
    end
    if Fx.KitReady() and Fx.Kit():FindFirstChild("Buddy") ~= nil then
        local Position = a1.Landing.Position
        local v2 = {Caught = false, Done = false, Payload = a1, Trove = Trove.new()}
        local Leg = a1.Leg or {From = Position, To = Position, StartAt = a1.LandAt, ArriveAt = a1.LandAt}
        v2.Leg = Leg
        v2.Noticed = a1.Noticed == true
        u77 = v2
        if a1.LandAt <= (Workspace:GetServerTimeNow()) then
            spawnBuddy(v2, (Workspace:GetServerTimeNow()) < a1.LandAt + 3.6)
            startHud(v2)
            return
        end
        runFall(v2, a1.Cinematic and (Workspace:GetServerTimeNow()) <= a1.FallAt + 0.6)
        return
    end
    warn("[ShootingStar] ReplicatedStorage.Assets.ShootingStar is missing, skipping the star")
end

local function onWander(a1, a2, a3) -- Line: 390
    -- upvalues: u77 (ref), refreshProgress (val)
    local v1 = u77
    if v1 ~= nil and v1.Payload.Id == a1 and typeof(a2) == "table" then
        v1.Leg = a2
        v1.Noticed = a3 == true
        if v1.Buddy then
            v1.Buddy:SetLeg(a2, v1.Noticed)
        end
        refreshProgress(v1)
        return
    end
end

local function onSlipped(a1) -- Line: 403 -- upvalues: u77 (ref), Hud (val) -- types: a1: string
    local v1 = u77
    if v1 ~= nil and v1.Payload.Id == a1 then
        v1.Caught = false
        v1.HoldStart = nil
        Hud.Border(0)
        if v1.Buddy then
            v1.Buddy:Release(false)
        end
        return
    end
end

local function onClaimed(a1, a2, a3) -- Line: 412
    -- upvalues: u77 (ref), u78 (ref), Hud (val), Fx (val)
    local v1 = u77
    if v1 ~= nil and v1.Payload.Id == a1 then
        v1.HoldStart = nil
        local Buddy = v1.Buddy
        v1.Buddy = nil
        u78 = if not Buddy then {Amount = a2} else {Model = Buddy:Detach(), Amount = a2}
        local Meteor = v1.Meteor
        if Meteor ~= nil then
            v1.Meteor = nil
            task.delay(2, function() -- Line: 158 -- upvalues: Meteor (val)
                Meteor:LightOff()
                Meteor:Fade()
            end)
        end
        Hud.BorderFade()
        if u77 == v1 then
            u77 = nil
        end
        v1.Done = true
        Hud.Waypoint(nil)
        Hud.Objective(false)
        Hud.Border(0)
        v1.Trove:Destroy()
        Fx.FovPunch(4, 0.6)
        return
    end
end

local function onCelebrate(a1, a2, a3, a4) -- Line: 431
    -- upvalues: LocalPlayer (val), Celebrate (val), Tabs (val), u78 (ref), Fx (val), Hud (val)
    if typeof(a1) == "Instance" and a1:IsA("Player") then
        if a1 ~= LocalPlayer then
            Celebrate.Play(a1, {Kind = a2, From = a3, Count = a4})
            return
        end
        if a2 == "Gift" and Tabs.IsActive("Shop") then
            Tabs.Deactivate()
        end
        local v1 = u78
        u78 = nil
        local Amount = if type(a4) ~= "number" then if not v1 then 1 else v1.Amount else a4
        Celebrate.Play(a1, {
            Kind = a2,
            From = a3,
            Model = if not v1 then nil else v1.Model,
            Count = Amount,
            OnRaised = function() -- Line: 450 -- upvalues: Fx (upval), Hud (upval), Amount (val)
                Fx.Sound("StarReward", nil, 0.8)
                Hud.Reward(Amount)
            end,
        })
        return
    end
end

local function onExpired(a1) -- Line: 457 -- upvalues: u77 (ref), Toast (val), u75 (val), Hud (val) -- types: a1: string
    local v1 = u77
    if v1 ~= nil and v1.Payload.Id == a1 then
        local Buddy = v1.Buddy
        v1.Buddy = nil
        if Buddy then
            Buddy:Leave()
        end
        local Meteor = v1.Meteor
        if Meteor ~= nil then
            v1.Meteor = nil
            task.delay(0, function() -- Line: 158 -- upvalues: Meteor (val)
                Meteor:LightOff()
                Meteor:Fade()
            end)
        end
        Toast.Show({Text = "The little star went home to the sky...", Seconds = 4, Color = u75})
        if u77 == v1 then
            u77 = nil
        end
        v1.Done = true
        Hud.Waypoint(nil)
        Hud.Objective(false)
        Hud.Border(0)
        v1.Trove:Destroy()
        return
    end
end

function v1.Start() -- Line: 476
    -- upvalues: Remotes (val), begin (val), onWander (val), onSlipped (val), onClaimed (val), onCelebrate (val)
    -- upvalues: onExpired (val), StarFeed (val), u77 (ref)
    local v1 = begin
    Remotes.ShootingStar.Fall.OnClientEvent:Connect(v1)
    Remotes.ShootingStar.Wander.OnClientEvent:Connect(onWander)
    Remotes.ShootingStar.Slipped.OnClientEvent:Connect(onSlipped)
    Remotes.ShootingStar.Claimed.OnClientEvent:Connect(onClaimed)
    Remotes.ShootingStar.Celebrate.OnClientEvent:Connect(onCelebrate)
    Remotes.ShootingStar.Expired.OnClientEvent:Connect(onExpired)
    StarFeed.Start()
    task.spawn(function() -- Line: 484 -- upvalues: Remotes (upval), u77 (upval), begin (upval)
        local success, err = pcall(function() -- Line: 485 -- upvalues: Remotes (upval)
            return Remotes.ShootingStar.AskState:InvokeServer()
        end)
        if success and typeof(err) == "table" and u77 == nil then
            begin(err)
        end
    end)
end

return v1