-- Script path: ReplicatedStorage.Controllers.Game.SubBiomesController
-- Decompile time: 7.35 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local AreaEggCycle = require(ReplicatedStorage.Shared.Util.AreaEggCycle)
local SubBiomeCycle = require(ReplicatedStorage.Shared.Util.SubBiomeCycle)
local u25 = {Waterfalls = 10, Lavafalls = 4}
local u26 = {Water = 2, Lava = 0.8}
return {
    Start = function() -- Line: 29
        -- upvalues: Workspace (val), ReplicatedStorage (val), u25 (val), u26 (val), SubBiomeCycle (val)
        -- upvalues: RunService (val), AreaEggCycle (val)
        local World = Workspace:WaitForChild("World", 30)
        assert(World ~= nil, "Workspace.World is required")
        local Areas = World:WaitForChild("Areas", 30)
        assert(Areas ~= nil, "Workspace.World.Areas is required")
        local LightDark = Areas:WaitForChild("LightDark", 30)
        assert(LightDark ~= nil, "Workspace.World.Areas.LightDark is required")
        local u187 = LightDark:WaitForChild("Bounds", 30)
        local v1 = false
        if u187 ~= nil then
            v1 = u187:IsA("BasePart")
        end
        assert(v1, "LightDark.Bounds must be a BasePart")
        local SubBiomes = ReplicatedStorage.Assets.VFX:WaitForChild("SubBiomes", 30)
        assert(SubBiomes ~= nil, "ReplicatedStorage.Assets.VFX.SubBiomes is required")
        local Build = World:WaitForChild("Build", 30)
        assert(Build ~= nil, "Workspace.World.Build is required")
        local u181 = (Build:WaitForChild("Props", 30)):WaitForChild("Zone12Props", 30)
        assert(u181 ~= nil, "Workspace.World.Build.Props.Zone12Props is required")
        local SubBiomeBuilds = ReplicatedStorage.Assets:WaitForChild("SubBiomeBuilds", 30)
        assert(SubBiomeBuilds ~= nil, "ReplicatedStorage.Assets.SubBiomeBuilds is required")

        local function zoneFloorParts() -- Line: 53 -- upvalues: Build (val)
            local v1
            local LightDarkZone = Build:FindFirstChild("LightDarkZone")
            local v2 = if LightDarkZone == nil then nil else LightDarkZone:FindFirstChild("1")
            if (if v2 == nil then nil else v2:FindFirstChild("BOTTOMS")) == nil then
                return nil
            end
            v2 = {}
            for i, j in v1:GetChildren() do
                assert(j:IsA("BasePart"), (("LightDarkZone.1.BOTTOMS.%* must be a BasePart"):format(j.Name)))
                table.insert(v2, j)
            end
            if #v2 > 0 then
                return v2
            end
            return nil
        end

        local Folder = Instance.new("Folder")
        Folder.Name = "LightDarkSubBiomeVfx"
        Folder.Parent = Workspace
        local u196 = {}
        local v2 = {u181, SubBiomeBuilds}
        local v3 = nil
        local v4 = nil
        for i, j in v2, v3, v4 do
            for k, n in j:GetChildren() do
                u196[n.Name] = n
            end
        end
        local u136 = nil
        local u137 = {}

        local function emitterPoints() -- Line: 90 -- upvalues: u187 (val)
            local Position, v1
            local v2 = math.max(u187.Size.X - 110, 1)
            local v3 = u187.CFrame.Position.Y + u187.Size.Y * 0.5 + 14
            local v4 = {}
            for i = 1, 9 do
                v1 = (i - 0.5) / 9
                Position = (u187.CFrame * CFrame.new((Vector3.new(-v2 * 0.5 + v2 * v1, 0, 0)))).Position
                v4[i] = (Vector3.new(Position.X, v3, Position.Z))
            end
            return v4
        end

        local function collectScrollingTextures(a1) -- Line: 105
            -- upvalues: u137 (val), u25 (upval), u26 (upval)
            local v1, v2, v3, v4
            table.clear(u137)
            if a1 == nil then
                return
            end
            for i, j in a1:GetDescendants() do
                if j:IsA("BasePart") then
                    v2 = u25[j.Name]
                    v3 = u26[j.Name]
                    if v2 ~= nil then
                        v4 = 0
                        for k, n in j:GetChildren() do
                            if n:IsA("Texture") then
                                if v2 == nil then
                                    v4 = v4 + 1
                                    v1 = v3 * (if v4 ~= 1 then 0.55 else 1)
                                else
                                    v1 = v2 * (if not (n.Transparency <= 0.5) then 0.55 else 1)
                                end
                                table.insert(u137, {texture = n, speed = v1})
                            end
                        end
                    elseif v3 ~= nil then
                        v4 = 0
                        for m, i5 in j:GetChildren() do
                            if i5:IsA("Texture") then
                                if v2 == nil then
                                    v4 = v4 + 1
                                    v1 = v3 * (if v4 ~= 1 then 0.55 else 1)
                                else
                                    v1 = v2 * (if not (i5.Transparency <= 0.5) then 0.55 else 1)
                                end
                                table.insert(u137, {texture = i5, speed = v1})
                            end
                        end
                    end
                end
            end
        end

        local function rebuildVfx(a1) -- Line: 144 -- upvalues: Folder (val), SubBiomes (val), emitterPoints (val)
            local v1
            Folder:ClearAllChildren()
            local Vfx = a1.Vfx
            if Vfx == nil then
                return
            end
            local v2 = SubBiomes:FindFirstChild(Vfx)
            local v3 = ("No sub-biome VFX named \"%*\" in ReplicatedStorage.Assets.VFX.SubBiomes"):format(Vfx)
            assert(v2 ~= nil, v3)
            for i, j in emitterPoints() do
                v1 = v2:Clone()
                v1:PivotTo((CFrame.new(j)))
                v1.Parent = Folder
            end
        end

        local function showProps(a1) -- Line: 164
            -- upvalues: zoneFloorParts (val), u137 (val), u196 (val), u181 (val), SubBiomeBuilds (val)
            -- upvalues: collectScrollingTextures (val)
            local v1
            local v2 = zoneFloorParts()
            if v2 == nil then
                return false
            end
            local v3 = a1.HidesZoneFloor == true
            local v4 = nil
            local v5 = nil
            for i, j in v2, v4, v5 do
                j.LocalTransparencyModifier = if not v3 then 0 else 1
            end
            local Props = a1.Props
            if Props == nil then
                table.clear(u137)
                return true
            end
            assert(
                u196[Props] ~= nil,
                (("No biome build named \"%*\" under Build.Props.Zone12Props or Assets.SubBiomeBuilds"):format(Props))
            )
            v4 = nil
            v5 = nil
            for k, n in u196, v4, v5 do
                v1 = if k ~= Props then SubBiomeBuilds else u181
                n.Parent = v1
            end
            collectScrollingTextures(u196[Props])
            return true
        end

        local function parkAll() -- Line: 193 -- upvalues: u196 (val), SubBiomeBuilds (val), Folder (val), u137 (val)
            for i, j in u196 do
                j.Parent = SubBiomeBuilds
            end
            Folder:ClearAllChildren()
            table.clear(u137)
        end

        local function step() -- Line: 201
            -- upvalues: Workspace (upval), SubBiomeCycle (upval), u136 (ref), u196 (val), SubBiomeBuilds (val)
            -- upvalues: Folder (val), u137 (val), showProps (val), rebuildVfx (val)
            local ServerTimeNow = Workspace:GetServerTimeNow()
            if SubBiomeCycle.RevealPhaseAt("Light Dark", ServerTimeNow) == "Sealed" then
                u136 = nil
                for i, j in u196 do
                    j.Parent = SubBiomeBuilds
                end
                Folder:ClearAllChildren()
                table.clear(u137)
                return
            end
            local v1 = SubBiomeCycle.ActiveAt("Light Dark", ServerTimeNow)
            if v1 == nil then
                return
            end
            if v1.Id ~= u136 then
                if not showProps(v1) then
                    return
                end
                u136 = v1.Id
                rebuildVfx(v1)
            end
        end

        if not SubBiomeCycle.IsRotating("Light Dark") then
            return
        else
            RunService.RenderStepped:Connect(function() -- Line: 136 -- upvalues: Workspace (upval), u137 (val)
                local ServerTimeNow = Workspace:GetServerTimeNow()
                for i, j in u137 do
                    j.texture.OffsetStudsV = -(ServerTimeNow * j.speed) % j.texture.StudsPerTileV
                end
            end)
            while true do
                step()
                task.wait(AreaEggCycle.SchedulePollSeconds)
            end
        end
    end,
}