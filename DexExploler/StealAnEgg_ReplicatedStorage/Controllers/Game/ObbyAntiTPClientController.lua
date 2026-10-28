-- Script path: ReplicatedStorage.Controllers.Game.ObbyAntiTPClientController
-- Decompile time: 18.14 ms

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local LocalPlayer = Players.LocalPlayer
local u30 = nil
local u31 = {}
local u32 = nil
local u33 = nil
local u34 = nil
local u35 = nil
local u36 = false
local u37 = nil
local u38 = 0
local u39 = 16
local u40 = 0
local u41 = 0
local u42 = 0
local u43 = 0
local u44 = nil
local u45 = false
return {
    Start = function() -- Line: 95
        -- upvalues: Workspace (val), u31 (val), u32 (ref), u30 (ref), u41 (ref), u35 (ref), u37 (ref), u38 (ref)
        -- upvalues: u33 (ref), u34 (ref), u36 (ref), u43 (ref), u42 (ref), u45 (ref), u39 (ref), u40 (ref), u44 (ref)
        -- upvalues: Remotes (val), HttpService (val), LocalPlayer (val), RunService (val)
        local function debugEnabled() -- Line: 96 -- upvalues: Workspace (upval)
            return Workspace:GetAttribute("ClientObbyAntiTpDebug") == true
        end

        local function dprint(a1) -- Line: 100 -- upvalues: Workspace (upval) -- types: a1: string
            if Workspace:GetAttribute("ClientObbyAntiTpDebug") == true then
                print("[ObbyAntiTP] " .. a1)
            end
        end

        local function nowClock() -- Line: 106
            return os.clock()
        end

        local function parseRegionAttribute() -- Line: 112 -- upvalues: Workspace (upval)
            local v1
            local Attribute = Workspace:GetAttribute("AnticheatSuspendedRegion")
            if typeof(Attribute) ~= "string" then
                return nil
            end
            local v2 = {}
            for i in string.gmatch(Attribute, "[^,]+") do
                v1 = tonumber(i)
                if v1 == nil then
                    return nil
                end
                table.insert(v2, v1)
            end
            if #v2 ~= 6 then
                return nil
            end
            return {
                Min = Vector3.new(v2[1], v2[2], v2[3]),
                Max = Vector3.new(v2[4], v2[5], v2[6]),
            }
        end

        local function regionFromMap(a1) -- Line: 134 -- types: a1: userdata
            local Position, v1, v2, v3
            local v4 = nil
            local v5 = nil
            for i, j in a1:GetDescendants() do
                if j:IsA("BasePart") then
                    Position = j.Position
                    v3 = j.Size * 0.5
                    v1 = Position - v3
                    v2 = Position + v3
                    v4 = if not v4 then v1 else Vector3.new(math.min(v4.X, v1.X), math.min(v4.Y, v1.Y), (math.min(v4.Z, v1.Z)))
                    v5 = if not v5 then v2 else Vector3.new(math.max(v5.X, v2.X), math.max(v5.Y, v2.Y), (math.max(v5.Z, v2.Z)))
                end
            end
            if v4 ~= nil and v5 ~= nil then
                return {
                    Min = v4 - Vector3.new(25, 25, 25),
                    Max = v5 + Vector3.new(25, 25, 25),
                }
            end
            return nil
        end

        local function collectMapLandmarks(a1) -- Line: 166
            -- upvalues: u31 (upval), u32 (upval)
            table.clear(u31)
            u32 = nil
            if a1 == nil then
                return
            end
            local WinParts = a1:FindFirstChild("WinParts")
            if WinParts ~= nil then
                for i, j in WinParts:GetChildren() do
                    if j:IsA("BasePart") then
                        table.insert(u31, j.Position)
                    end
                end
            end
            local ObbyRespawn = a1:FindFirstChild("ObbyRespawn")
            if ObbyRespawn ~= nil and ObbyRespawn:IsA("BasePart") then
                u32 = ObbyRespawn.Position
            end
        end

        local function refreshRegion() -- Line: 186
            -- upvalues: Workspace (upval), parseRegionAttribute (val), regionFromMap (val), u30 (upval)
            -- upvalues: collectMapLandmarks (val), u31 (upval)
            local MonsterEventMap = Workspace:FindFirstChild("MonsterEventMap")
            local v1 = parseRegionAttribute()
            if v1 == nil and MonsterEventMap ~= nil then
                v1 = regionFromMap(MonsterEventMap)
            end
            u30 = v1
            collectMapLandmarks(MonsterEventMap)
            if u30 == nil then
                if Workspace:GetAttribute("ClientObbyAntiTpDebug") == true then
                    print("[ObbyAntiTP] disarmed: no event region")
                end
                return
            end
            local v2 = ("armed: region %s -> %s, %d win gates"):format(tostring(u30.Min), tostring(u30.Max), #u31)
            if not (Workspace:GetAttribute("ClientObbyAntiTpDebug") == true) then
                return
            end
            print("[ObbyAntiTP] " .. v2)
        end

        local function inRegion(a1) -- Line: 205 -- upvalues: u30 (upval) -- types: a1: vector
            local v1 = u30
            if v1 == nil then
                return false
            end
            local v2 = false
            if v1.Min.X <= a1.X then
                v2 = false
                if a1.X <= v1.Max.X then
                    v2 = false
                    if v1.Min.Y <= a1.Y then
                        v2 = false
                        if a1.Y <= v1.Max.Y then
                            v2 = false
                            if v1.Min.Z <= a1.Z then
                                v2 = a1.Z <= v1.Max.Z
                            end
                        end
                    end
                end
            end
            return v2
        end

        local function isEnabled() -- Line: 218 -- upvalues: Workspace (upval), u30 (upval)
            local v1 = false
            if Workspace:GetAttribute("ClientObbyAntiTp") ~= false then
                v1 = u30 ~= nil
            end
            return v1
        end

        local function horizontal(a1, a2) -- Line: 224 -- types: a1: vector, a2: vector
            return ((a1 - a2) * Vector3.new(1, 0, 1)).Magnitude
        end

        local function grace(a1) -- Line: 228 -- upvalues: u41 (upval) -- types: a1: number
            math.max(u41, (os.clock()) + a1)
        end

        local function rebaseline(a1) -- Line: 232
            -- upvalues: u35 (upval), u37 (upval), u38 (upval)
            local v1 = u35
            if a1 == nil and v1 ~= nil then
                a1 = v1.Position
            end
            u37 = a1
            os.clock()
        end

        local function jumpVelocity(a1) -- Line: 241 -- upvalues: Workspace (upval) -- types: a1: userdata
            if a1.UseJumpPower then
                return (math.max(a1.JumpPower, 0))
            end
            return (math.sqrt(math.max(Workspace.Gravity, 0) * 2 * (math.max(a1.JumpHeight, 0))))
        end

        local function nearWinPart(a1) -- Line: 248 -- upvalues: u31 (upval) -- types: a1: vector
            for i, j in u31 do
                if (a1 - j).Magnitude <= 30 then
                    return true
                end
            end
            return false
        end

        local function nearObbyRespawn(a1) -- Line: 257 -- upvalues: u32 (upval) -- types: a1: vector
            local v1 = u32
            local v2 = false
            if v1 ~= nil then
                v2 = (a1 - v1).Magnitude <= 25
            end
            return v2
        end

        local function lagback(a1) -- Line: 264
            -- upvalues: u33 (upval), u35 (upval), u34 (upval), u37 (upval), u38 (upval), u41 (upval)
            local v1 = u33
            local v2 = u35
            local v3 = u34
            if v1 ~= nil and v2 ~= nil and v3 ~= nil then
                v3.Sit = false
                v2.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                v2.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                v1:PivotTo((CFrame.new(a1)) * v2.CFrame.Rotation)
                local Position = a1
                v3 = u35
                if Position == nil and v3 ~= nil then
                    Position = v3.Position
                end
                u37 = Position
                os.clock()
                math.max(u41, (os.clock()) + 0.3)
                return
            end
        end

        local function kill(a1) -- Line: 277
            -- upvalues: u35 (upval), u34 (upval), u36 (upval), Workspace (upval)
            local v1 = u35
            local v2 = u34
            u36 = true
            local v3 = "KILL: " .. a1
            if Workspace:GetAttribute("ClientObbyAntiTpDebug") == true then
                print("[ObbyAntiTP] " .. v3)
            end
            if v1 ~= nil then
                v1.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                v1.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            end
            if v2 ~= nil then
                v2.Health = 0
                v2:ChangeState(Enum.HumanoidStateType.Dead)
            end
        end

        local function punish(a1, a2, a3, a4, a5) -- Line: 291
            -- upvalues: u43 (upval), u42 (upval), u31 (upval), Workspace (upval), lagback (val), u35 (upval)
            -- upvalues: u34 (upval), u36 (upval)
            local v1, v2, v3, v4, v5
            if 5 < a5 - u43 then
                u42 = 0
            end
            u42 = u42 + 1
            u43 = a5
            local v6 = true
            if not (a3 >= 300) then
                v6 = true
                if not (a4 >= 150) then
                    v6 = true
                    if not (u42 >= 6) then
                        v6 = false
                        if a3 >= 100 then
                            v2 = u31
                            v3 = nil
                            v4 = nil
                            for i, j in v2, v3, v4 do
                                if (a1 - j).Magnitude <= 30 then
                                    v2 = ("flag #%d: moved %.0f (up %.0f)%s"):format(u42, a3, a4, " EXTREME")
                                    if Workspace:GetAttribute("ClientObbyAntiTpDebug") == true then
                                        print("[ObbyAntiTP] " .. v2)
                                    end
                                    lagback(a2)
                                    if v6 then
                                        v2 = u42
                                        u42 = 0
                                        v3 = ("jump %.0f studs (up %.0f), flags %d"):format(a3, a4, v2)
                                        v4 = u35
                                        v5 = u34
                                        u36 = true
                                        v1 = "KILL: " .. v3
                                        if Workspace:GetAttribute("ClientObbyAntiTpDebug") == true then
                                            print("[ObbyAntiTP] " .. v1)
                                        end
                                        if v4 ~= nil then
                                            v4.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                                            v4.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                                        end
                                        if v5 ~= nil then
                                            v5.Health = 0
                                            v5:ChangeState(Enum.HumanoidStateType.Dead)
                                        end
                                    end
                                    return
                                end
                            end
                            v6 = false
                        end
                    end
                end
            end
            v2 = ("flag #%d: moved %.0f (up %.0f)%s"):format(u42, a3, a4, if not v6 then "" else " EXTREME")
            if Workspace:GetAttribute("ClientObbyAntiTpDebug") == true then
                print("[ObbyAntiTP] " .. v2)
            end
            lagback(a2)
            if v6 then
                v2 = u42
                u42 = 0
                v3 = ("jump %.0f studs (up %.0f), flags %d"):format(a3, a4, v2)
                v4 = u35
                v5 = u34
                u36 = true
                v1 = "KILL: " .. v3
                if Workspace:GetAttribute("ClientObbyAntiTpDebug") == true then
                    print("[ObbyAntiTP] " .. v1)
                end
                if v4 ~= nil then
                    v4.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    v4.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                end
                if v5 ~= nil then
                    v5.Health = 0
                    v5:ChangeState(Enum.HumanoidStateType.Dead)
                end
            end
        end

        Remotes.RigSync.Refresh.OnClientEvent:Connect(function(a1) -- Line: 437 -- upvalues: HttpService (upval), u44 (upval), u41 (upval), Workspace (upval)
            if typeof(a1) ~= "string" then
                return
            end
            local success, err = pcall(function() -- Line: 441 -- upvalues: HttpService (upval), a1 (val)
                return HttpService:JSONDecode(a1)
            end)
            if success and typeof(err) == "table" then
                local v1
                local Action = err.Action
                local Arguments = err.Arguments
                if typeof(Arguments) ~= "table" then
                    Arguments = {}
                end
                if Action == "Relocate" then
                    v1 = tonumber(Arguments[1])
                    local v2 = tonumber(Arguments[2])
                    local v3 = tonumber(Arguments[3])
                    if v1 ~= nil and v2 ~= nil and v3 ~= nil then
                        u44 = {
                            Target = Vector3.new(v1, v2, v3),
                            ExpiresAt = os.clock() + 8,
                        }
                    end
                    u41 = math.max(u41, (os.clock()) + 1)
                    if not (Workspace:GetAttribute("ClientObbyAntiTpDebug") == true) then
                        return
                    end
                    print("[ObbyAntiTP] grace: server relocation")
                    return
                end
                if Action ~= "BeginImpulse" and Action ~= "BeginRagdoll" then
                    if Action == "EndRagdoll" then
                        u41 = math.max(u41, (os.clock()) + 1)
                    end
                    return
                end
                v1 = (math.clamp((tonumber(Arguments[1])) or 1, 1, 5)) + 0.5
                math.max(u41, (os.clock()) + v1)
                v1 = "grace: server " .. tostring(Action)
                if not (Workspace:GetAttribute("ClientObbyAntiTpDebug") == true) then
                    return
                end
                print("[ObbyAntiTP] " .. v1)
                return
            end
        end)

        local function onCharacter(a1) -- Line: 473
            -- upvalues: u36 (upval), u42 (upval), u44 (upval), u45 (upval), u33 (upval), u34 (upval), u35 (upval)
            -- upvalues: u37 (upval), LocalPlayer (upval), u39 (upval), u40 (upval), u41 (upval), u38 (upval)
            u36 = false
            u42 = 0
            u44 = nil
            u45 = false
            u33 = a1
            u34 = nil
            u35 = nil
            u37 = nil
            local Humanoid = a1:WaitForChild("Humanoid", 10)
            local HumanoidRootPart = a1:WaitForChild("HumanoidRootPart", 10)
            if Humanoid ~= nil
                and Humanoid:IsA("Humanoid")
                and HumanoidRootPart ~= nil
                and HumanoidRootPart:IsA("BasePart")
                and LocalPlayer.Character == a1 then
                u34 = Humanoid
                math.clamp(Humanoid.WalkSpeed, 2, 1000)
                u40 = 0
                math.max(u41, (os.clock()) + 3)
                local Position = HumanoidRootPart.Position
                local v1 = HumanoidRootPart
                if Position == nil and v1 ~= nil then
                    Position = v1.Position
                end
                u37 = Position
                os.clock()
                Humanoid.Died:Connect(function() -- Line: 501 -- upvalues: u36 (upval)
                    u36 = true
                end)
                return
            end
        end

        LocalPlayer.CharacterAdded:Connect(onCharacter)
        if LocalPlayer.Character ~= nil then
            task.spawn(onCharacter, LocalPlayer.Character)
        end
        ;(Workspace:GetAttributeChangedSignal("AnticheatSuspendedRegion")):Connect(refreshRegion)
        Workspace.ChildAdded:Connect(function(a1) -- Line: 514 -- upvalues: refreshRegion (val)
            if a1.Name == "MonsterEventMap" then
                task.defer(refreshRegion)
            end
        end)
        Workspace.ChildRemoved:Connect(function(a1) -- Line: 520 -- upvalues: refreshRegion (val)
            if a1.Name == "MonsterEventMap" then
                task.defer(refreshRegion)
            end
        end)
        refreshRegion()
        RunService.Heartbeat:Connect(function() -- Line: 323
            -- upvalues: u35 (upval), u34 (upval), u36 (upval), Workspace (upval), u38 (upval), u30 (upval), u37 (upval)
            -- upvalues: u45 (upval), u39 (upval), u40 (upval), inRegion (val), u41 (upval), u44 (upval), u32 (upval)
            -- upvalues: punish (val)
            local v1 = u35
            local v2 = u34
            if v1 ~= nil and v2 ~= nil and not u36 then
                if not (v2.Health <= 0) and v1:IsDescendantOf(Workspace) then
                    local v3 = os.clock()
                    local v4 = v3 - u38
                    if v4 < 0.1 then
                        return
                    end
                    u38 = v3
                    local Position = v1.Position
                    local v5 = false
                    if Workspace:GetAttribute("ClientObbyAntiTp") ~= false then
                        v5 = u30 ~= nil
                    end
                    if not v5 then
                        u37 = Position
                        u45 = false
                        return
                    end
                    v5 = math.clamp(v2.WalkSpeed, 2, 1000)
                    if not (u39 <= v5) then
                        u40 = u40 + math.min(v4, 0.4)
                        if u40 >= 3 then
                            u39 = v5
                        end
                    else
                        u39 = v5
                        u40 = 0
                    end
                    v5 = inRegion(Position)
                    if v5 and u45 then
                        if not v2.Sit and not v2.PlatformStand then
                            v5 = u44
                            if v5 ~= nil then
                                if v5.ExpiresAt <= v3 then
                                    u44 = nil
                                elseif (Position - v5.Target).Magnitude <= 15 then
                                    u44 = nil
                                    u37 = Position
                                    return
                                end
                            end
                            if v3 < u41 then
                                u37 = Position
                                return
                            end
                            if not (v4 > 1) and u37 ~= nil then
                                v4 = math.min(v4, 0.4)
                                v5 = u37
                                local AssemblyLinearVelocity = v1.AssemblyLinearVelocity
                                v1 = math.min((AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude, 400)
                                local v6 = math.clamp(AssemblyLinearVelocity.Y, 0, 400)
                                local v7 = u39 * 1.7000000000000002 * v4 + 14 + v1 * v4
                                local Magnitude_2 = ((Position - v5) * Vector3.new(1, 0, 1)).Magnitude
                                local v8 = if not v2.UseJumpPower then math.sqrt(math.max(Workspace.Gravity, 0) * 2 * (math.max(v2.JumpHeight, 0))) else math.max(v2.JumpPower, 0)
                                local v9 = math.max(v8, v6) * v4 + 14
                                v6 = Position.Y - v5.Y
                                v4 = v7 + 80 < Magnitude_2
                                v7 = v9 + 60 < v6
                                if not v4 and not v7 then
                                    u37 = Position
                                    return
                                end
                                v9 = u32
                                local v10 = false
                                if v9 ~= nil then
                                    v10 = (Position - v9).Magnitude <= 25
                                end
                                if v10 then
                                    u37 = Position
                                    return
                                end
                                punish(Position, v5, Magnitude_2, math.max(v6, 0), v3)
                                return
                            end
                            u37 = Position
                            return
                        end
                        math.max(u41, (os.clock()) + 1.5)
                        u37 = Position
                        return
                    end
                    u45 = v5
                    u37 = Position
                    return
                end
                return
            end
        end)
    end,
}