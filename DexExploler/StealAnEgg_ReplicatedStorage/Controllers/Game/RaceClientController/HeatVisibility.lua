-- Script path: ReplicatedStorage.Controllers.Game.RaceClientController.HeatVisibility
-- Decompile time: 9.08 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local MountRace = require(ReplicatedStorage.Data.MountRace)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u29 = {"BasePart", "Decal", "Texture", "ParticleEmitter", "Beam", "Trail", "Fire", "Smoke", "Sparkles"}
local u39 = {"LayerCollector", "Highlight", "Light", "ProximityPrompt"}
local u44 = {"BillboardGui", "SurfaceGui", "Highlight"}

local function isAny(a1, a2) -- Line: 50 -- types: a1: userdata, a2: table
    for i, j in a2 do
        if a1:IsA(j) then
            return true
        end
    end
    return false
end

return {
    Run = function(a1, a2, a3) -- Line: 61
        -- upvalues: u29 (val), u39 (val), Players (val), LocalPlayer (val), MountRace (val), Workspace (val), u44 (val)
        -- upvalues: RunService (val)
        local u3 = {}
        local u4 = {}
        local u5 = {}
        local u6 = {}

        local function force(a1, a2, a3) -- Line: 67 -- upvalues: u4 (val) -- types: a1: userdata, a2: string
            if u4[a1] ~= nil then
                if a1[a2] ~= a3 then
                    a1[a2] = a3
                end
                return
            end
            local u6 = nil
            u6 = {
                Property = a2,
                Original = a1[a2],
                Value = a3,
                Connection = (a1:GetPropertyChangedSignal(a2)):Connect(function() -- Line: 80 -- upvalues: a1 (val), a2 (val), a3 (val), u6 (ref)
                    local v1 = a1[a2]
                    if v1 ~= a3 then
                        u6.Original = v1
                        a1[a2] = a3
                    end
                end),
            }
            u4[a1] = u6
            a1[a2] = a3
        end

        local function release(a1) -- Line: 92 -- upvalues: u4 (val), u3 (val) -- types: a1: userdata
            local v1 = u4[a1]
            if v1 ~= nil then
                u4[a1] = nil
                v1.Connection:Disconnect()
                if a1[v1.Property] == v1.Value then
                    a1[v1.Property] = v1.Original
                end
            end
            v1 = u3[a1]
            if v1 ~= nil then
                u3[a1] = nil
                if a1.LocalTransparencyModifier == 1 then
                    a1.LocalTransparencyModifier = v1
                end
            end
        end

        local function conceal(a1) -- Line: 112
            -- upvalues: u29 (upval), u3 (val), u39 (upval), force (val)
            for i, j in u29 do
                if a1:IsA(j) then
                    if true then
                        if u3[a1] == nil then
                            u3[a1] = a1.LocalTransparencyModifier
                        end
                        if a1.LocalTransparencyModifier ~= 1 then
                            a1.LocalTransparencyModifier = 1
                        end
                        return true
                    end
                    for k, n in u39 do
                        if a1:IsA(n) then
                            if true then
                                force(a1, "Enabled", false)
                                return true
                            end
                            if a1:IsA("Sound") then
                                force(a1, "Volume", 0)
                                return true
                            end
                            if not a1:IsA("Humanoid") then
                                return false
                            end
                            force(a1, "DisplayDistanceType", Enum.HumanoidDisplayDistanceType.None)
                            return true
                        end
                    end
                    if false then
                        force(a1, "Enabled", false)
                        return true
                    end
                    if a1:IsA("Sound") then
                        force(a1, "Volume", 0)
                        return true
                    end
                    if not a1:IsA("Humanoid") then
                        return false
                    end
                    force(a1, "DisplayDistanceType", Enum.HumanoidDisplayDistanceType.None)
                    return true
                end
            end
            if false then
                if u3[a1] == nil then
                    u3[a1] = a1.LocalTransparencyModifier
                end
                if a1.LocalTransparencyModifier ~= 1 then
                    a1.LocalTransparencyModifier = 1
                end
                return true
            end
            for m, i5 in u39 do
                if a1:IsA(i5) then
                    if true then
                        force(a1, "Enabled", false)
                        return true
                    end
                    if a1:IsA("Sound") then
                        force(a1, "Volume", 0)
                        return true
                    end
                    if not a1:IsA("Humanoid") then
                        return false
                    end
                    force(a1, "DisplayDistanceType", Enum.HumanoidDisplayDistanceType.None)
                    return true
                end
            end
            if false then
                force(a1, "Enabled", false)
                return true
            end
            if a1:IsA("Sound") then
                force(a1, "Volume", 0)
                return true
            end
            if not a1:IsA("Humanoid") then
                return false
            end
            force(a1, "DisplayDistanceType", Enum.HumanoidDisplayDistanceType.None)
            return true
        end

        local function concealInto(a1, a2) -- Line: 135 -- upvalues: conceal (val) -- types: a1: table, a2: userdata
            local success, err = pcall(conceal, a2)
            if success and err then
                a1.Items[a2] = true
            end
        end

        local function hide(a1) -- Line: 142 -- upvalues: u5 (val), conceal (val) -- types: a1: userdata
            local err, success, v1
            if u5[a1] ~= nil then
                return
            end
            local u3 = nil
            u3 = {
                Items = {},
                Connection = a1.DescendantAdded:Connect(function(a1) -- Line: 149 -- upvalues: u3 (ref), conceal (upval) -- types: a1: userdata
                    local v1 = u3
                    local success, err = pcall(conceal, a1)
                    if success and err then
                        v1.Items[a1] = true
                    end
                end),
            }
            u5[a1] = u3
            for i, j in a1:GetDescendants() do
                v1 = u3
                success, err = pcall(conceal, j)
                if success and err then
                    v1.Items[j] = true
                end
            end
        end

        local function show(a1) -- Line: 159 -- upvalues: u5 (val), release (val) -- types: a1: userdata
            local v1 = u5[a1]
            if v1 == nil then
                return
            end
            u5[a1] = nil
            v1.Connection:Disconnect()
            for i in v1.Items do
                pcall(release, i)
            end
        end

        local function refresh(a1, a2) -- Line: 171
            -- upvalues: release (val), conceal (val)
            local err, success
            for i in a2.Items do
                if not i:IsDescendantOf(a1) then
                    a2.Items[i] = nil
                    pcall(release, i)
                end
            end
            for j, k in a1:GetDescendants() do
                success, err = pcall(conceal, k)
                if success and err then
                    a2.Items[k] = true
                end
            end
        end

        local function wanted() -- Line: 183
            -- upvalues: Players (upval), LocalPlayer (upval), MountRace (upval), a2 (val), a3 (val), Workspace (upval)
            local Character
            local v1 = {}
            for i, j in Players:GetPlayers() do
                Character = j.Character
                if j ~= LocalPlayer
                    and Character ~= nil
                    and Character.Parent ~= nil
                    and MountRace.InOtherHeat(j, a2, a3) then
                    v1[Character] = true
                end
            end
            local RaceBots = Workspace:FindFirstChild("RaceBots")
            if RaceBots ~= nil then
                for k, n in RaceBots:GetChildren() do
                    if MountRace.InOtherHeat(n, a2, a3) then
                        v1[n] = true
                    end
                end
            end
            return v1
        end

        local function adornedRoot(a1) -- Line: 207 -- upvalues: u5 (val) -- types: a1: userdata
            local Adornee = a1.Adornee
            if typeof(Adornee) ~= "Instance" then
                return nil
            end
            for i in u5 do
                if Adornee ~= i and not Adornee:IsDescendantOf(i) then
                    continue
                end
                return i
            end
            return nil
        end

        local function syncAdorned() -- Line: 220
            -- upvalues: u6 (val), release (val), adornedRoot (val), force (val), u4 (val)
            for i in u6 do
                if i.Parent == nil then
                    u6[i] = nil
                    pcall(release, i)
                elseif adornedRoot(i) ~= nil then
                    pcall(force, i, "Enabled", false)
                elseif u4[i] ~= nil then
                    pcall(release, i)
                end
            end
        end

        local function watchAdorned(a1_2) -- Line: 233
            -- upvalues: u44 (upval), u6 (val), a1 (val)
            if a1_2 == nil then
                return
            end
            for i, j in a1_2:GetDescendants() do
                for k, n in u44 do
                    if j:IsA(n) then
                        if true then
                            u6[j] = true
                        end
                        break
                    end
                end
                if false then
                    u6[j] = true
                end
            end
            a1:Connect(a1_2.DescendantAdded, function(a1) -- Line: 242 -- upvalues: u44 (upval), u6 (upval) -- types: a1: userdata
                for i, j in u44 do
                    if a1:IsA(j) then
                        if true then
                            u6[a1] = true
                        end
                        return
                    end
                end
                if false then
                    u6[a1] = true
                end
            end)
        end

        local function sync(a1) -- Line: 249
            -- upvalues: wanted (val), u5 (val), show (val), hide (val), refresh (val), syncAdorned (val)
            local v1
            local v2 = wanted()
            for i in u5 do
                if not v2[i] then
                    show(i)
                end
            end
            for j in v2 do
                v1 = u5[j]
                if v1 == nil then
                    hide(j)
                elseif a1 then
                    refresh(j, v1)
                end
            end
            syncAdorned()
        end

        a1:Add(function() -- Line: 267 -- upvalues: u5 (val), show (val), u4 (val), release (val), u3 (val), u6 (val)
            for i in u5 do
                show(i)
            end
            for j in u4 do
                pcall(release, j)
            end
            for k in u3 do
                pcall(release, k)
            end
            table.clear(u6)
        end)
        watchAdorned(LocalPlayer:FindFirstChildOfClass("PlayerGui"))
        watchAdorned(Workspace.CurrentCamera)
        local u34 = 0
        local u35 = 0
        a1:Connect(RunService.Heartbeat, function(a1) -- Line: 284 -- upvalues: u34 (ref), u35 (ref), sync (val) -- types: a1: number
            local v1
            u34 = u34 + a1
            u35 = u35 + a1
            if u34 < 0.1 then
                return
            end
            u34 = 0
            if u35 >= 1 then
                u35 = 0
            end
            local success, err = pcall(sync, v1)
            if not success then
                warn((("[HeatVisibility] %*"):format(err)))
            end
        end)
        pcall(sync, false)
    end,
}