-- Script path: ReplicatedStorage.Controllers.Game.ManorInteriorController.Door
-- Decompile time: 20.59 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Audio = require(ReplicatedStorage.Shared.Audio)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local HalloweenManor = require(ReplicatedStorage.Data.HalloweenManor)
local ManorInterior = require(ReplicatedStorage.Shared.Util.ManorInterior)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u64 = require(script.Parent.Unlock)
local LocalPlayer = Players.LocalPlayer
local Sounds = ManorInterior.Sounds
local Prompt = ManorInterior.Prompt
local Messages = ManorInterior.Messages
local GearId = HalloweenManor.GearId
local Inside = HalloweenDimension.PlayerAttributes.Inside
local u77 = Color3.fromRGB(196, 120, 255)
local u78 = nil
local u79 = false
local u80 = false
local u81 = 0
local u82 = (-1 / 0)
local u83 = false
local u84 = false
local u85 = nil
local u86 = nil
local u87 = false
local u88 = nil
local v1 = {}

local function manorState() -- Line: 73 -- upvalues: Save (val)
    local v1 = Save.Peek()
    local HalloweenDimension = v1 and v1.HalloweenDimension
    return HalloweenDimension and HalloweenDimension.Manor
end

local function isUnlocked() -- Line: 79 -- upvalues: Save (val)
    local v1 = Save.Peek()
    local HalloweenDimension = v1 and v1.HalloweenDimension
    local Manor = HalloweenDimension and HalloweenDimension.Manor
    v1 = false
    if Manor ~= nil then
        v1 = Manor.GateUnlocked == true
    end
    return v1
end

local function hasKey() -- Line: 84 -- upvalues: Save (val), GearId (val)
    local v1 = Save.Peek()
    local GearInventory = v1 and v1.GearInventory
    local v2 = false
    if GearInventory ~= nil then
        v2 = 0 < (GearInventory[GearId] or 0)
    end
    return v2
end

local function lockOf(a1) -- Line: 90 -- upvalues: ManorInterior (val) -- types: a1: userdata
    local v1 = a1:FindFirstChild(ManorInterior.LockName)
    if v1 ~= nil and v1:IsA("Model") then
        return v1
    end
    return nil
end

local function keyTool() -- Line: 95 -- upvalues: LocalPlayer (val), GearId (val)
    local v1 = {LocalPlayer.Character, LocalPlayer:FindFirstChildOfClass("Backpack")}
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        if j ~= nil then
            for k, n in j:GetChildren() do
                if n:IsA("Tool") then
                    if (n:GetAttribute("GearName")) ~= GearId and n.Name ~= GearId then
                        continue
                    end
                    return n
                end
            end
        end
    end
    return nil
end

local function captureKey() -- Line: 112 -- upvalues: keyTool (val), u85 (ref)
    local v1 = keyTool()
    if v1 == nil then
        u85 = nil
        return
    end
    local Archivable = v1.Archivable
    v1.Archivable = true
    local v2 = v1:Clone()
    v1.Archivable = Archivable
    u85 = v2
end

local function soundAt(a1) -- Line: 125 -- upvalues: ManorInterior (val) -- types: a1: userdata
    local v1 = a1:FindFirstChild(ManorInterior.LockName)
    local v2 = if v1 == nil then nil else if not v1:IsA("Model") then nil else v1
    local BoundingBox = if v2 == nil then a1:GetBoundingBox() else v2:GetBoundingBox()
    return BoundingBox.Position
end

local function toast(a1) -- Line: 131 -- upvalues: Toast (val), u77 (val) -- types: a1: string
    Toast.Show({
        Lane = "Feed",
        Seconds = 3,
        UniqueKey = "ManorDoor",
        Text = a1,
        Color = u77,
    })
end

local function shakeLock(a1) -- Line: 141 -- upvalues: u84 (ref), RunService (val) -- types: a1: userdata
    if u84 then
        return
    end
    u84 = true
    local Pivot = a1:GetPivot()
    local u7 = os.clock()
    local u8 = nil
    RunService.RenderStepped:Connect(function() -- Line: 149 -- upvalues: u7 (val), a1 (val), u8 (ref), Pivot (val), u84 (upval)
        local v1 = (os.clock() - u7) / 0.35
        if not (v1 >= 1) and a1.Parent ~= nil then
            a1:PivotTo(Pivot * (CFrame.Angles(0, 0, math.sin(v1 * 3.141592653589793 * 5) * 0.06981317007977318 * (1 - v1))))
            return
        end
        u8:Disconnect()
        if a1.Parent ~= nil then
            a1:PivotTo(Pivot)
        end
        u84 = false
    end)
end

local function lockedFeedback(a1) -- Line: 164
    -- upvalues: ManorInterior (val), Audio (val), Sounds (val), u84 (ref), RunService (val), Messages (val)
    -- upvalues: Toast (val), u77 (val)
    local v1 = a1:FindFirstChild(ManorInterior.LockName)
    local v2 = if v1 == nil then nil else if not v1:IsA("Model") then nil else v1
    local BoundingBox = if v2 == nil then a1:GetBoundingBox() else v2:GetBoundingBox()
    local Position = BoundingBox.Position
    Audio.Play(Sounds.ChainRattle, Position, {Volume = 0.9, MaxDistance = 120, PlaybackSpeed = {0.95, 1.08}})
    Audio.Play(Sounds.PadlockClunk, Position, {Volume = 0.8, MaxDistance = 120})
    v2 = a1:FindFirstChild(ManorInterior.LockName)
    local u51 = if v2 == nil then nil else if not v2:IsA("Model") then nil else v2
    if u51 ~= nil and not u84 then
        u84 = true
        local Pivot = u51:GetPivot()
        local u59 = os.clock()
        local u60 = nil
        RunService.RenderStepped:Connect(function() -- Line: 149 -- upvalues: u59 (val), u51 (val), u60 (ref), Pivot (val), u84 (upval)
            local v1 = (os.clock() - u59) / 0.35
            if not (v1 >= 1) and u51.Parent ~= nil then
                u51:PivotTo(Pivot * (CFrame.Angles(0, 0, math.sin(v1 * 3.141592653589793 * 5) * 0.06981317007977318 * (1 - v1))))
                return
            end
            u60:Disconnect()
            if u51.Parent ~= nil then
                u51:PivotTo(Pivot)
            end
            u84 = false
        end)
    end
    Toast.Show({
        Lane = "Feed",
        Seconds = 3,
        UniqueKey = "ManorDoor",
        Text = Messages.Locked,
        Color = u77,
    })
end

local function refreshPrompt(a1) -- Line: 179
    -- upvalues: Save (val), GearId (val), Prompt (val), u79 (ref), LocalPlayer (val), Inside (val)
    local v1 = Save.Peek()
    local GearInventory = v1 and v1.GearInventory
    local v2 = false
    if GearInventory ~= nil then
        v2 = 0 < (GearInventory[GearId] or 0)
    end
    local Unlock = if not v2 then Prompt.Locked else Prompt.Unlock
    if a1.Prompt.ActionText ~= Unlock then
        a1.Prompt.ActionText = Unlock
    end
    local Prompt_2 = a1.Prompt
    v1 = not u79
    if v1 then
        local v3 = Save.Peek()
        local HalloweenDimension = v3 and v3.HalloweenDimension
        local Manor = HalloweenDimension and HalloweenDimension.Manor
        local v4 = false
        if Manor ~= nil then
            v4 = Manor.GateUnlocked == true
        end
        v1 = not v4 and LocalPlayer:GetAttribute(Inside) == true
    end
    Prompt_2.Enabled = v1
end

local function applyOpen(a1, a2) -- Line: 189
    -- upvalues: Save (val), u81 (ref), u64 (val), ManorInterior (val), LocalPlayer (val)
    local v1 = Save.Peek()
    local HalloweenDimension = v1 and v1.HalloweenDimension
    local Manor = HalloweenDimension and HalloweenDimension.Manor
    local v2 = false
    if Manor ~= nil then
        v2 = Manor.GateUnlocked == true
    end
    if v2 == a1.Open then
        return
    end
    if not v2 and os.clock() < u81 then
        return
    end
    a1.Open = v2
    if a2 then
        return
    end
    local SetOpen = u64.SetOpen
    v1 = {Doors = a1.Doors}
    local v3 = a1.Doors:FindFirstChild(ManorInterior.LockName)
    v1.Lock = if v3 == nil then nil else if not v3:IsA("Model") then nil else v3
    v1.Character = LocalPlayer.Character
    SetOpen(v1, v2)
end

local function sendRequest(a1) -- Line: 206
    -- upvalues: u79 (ref), u83 (ref), u82 (ref), Remotes (val), lockedFeedback (val), u86 (ref), Toast (val), u77 (val)
    local v1 = os.clock()
    if not u79 and not u83 then
        local v2 = v1 - u82
        if not (v2 < 1.5) then
            u82 = v1
            u83 = true
            local success, err, v3 = pcall(function() -- Line: 213 -- upvalues: Remotes (upval)
                return Remotes.ManorInterior.Request:InvokeServer()
            end)
            u83 = false
            if success and err ~= "Outside" and err ~= "Busy" then
                if err == "Locked" then
                    lockedFeedback(a1)
                    return
                end
                if err ~= "Unlocked" then
                    if type(v3) == "string" and err ~= "Enter" then
                        Toast.Show({
                            Lane = "Feed",
                            Seconds = 3,
                            UniqueKey = "ManorDoor",
                            Text = v3,
                            Color = u77,
                        })
                    end
                    return
                end
                v2 = u86
                if v2 ~= nil then
                    v2(a1)
                end
                if type(v3) ~= "string" then
                    return
                end
                Toast.Show({
                    Lane = "Feed",
                    Seconds = 3,
                    UniqueKey = "ManorDoor",
                    Text = v3,
                    Color = u77,
                })
                return
            end
            u82 = os.clock() - 1.5 + 0.3
            return
        end
    end
end

local function triggered(a1) -- Line: 236
    -- upvalues: u79 (ref), Save (val), GearId (val), keyTool (val), u85 (ref), Audio (val), Sounds (val)
    -- upvalues: ManorInterior (val), u80 (ref), sendRequest (val), lockedFeedback (val)
    if not u79 then
        local v1 = Save.Peek()
        local HalloweenDimension = v1 and v1.HalloweenDimension
        local Manor = HalloweenDimension and HalloweenDimension.Manor
        local v2 = false
        if Manor ~= nil then
            v2 = Manor.GateUnlocked == true
        end
        if not v2 then
            local Doors = a1.Doors
            v1 = Save.Peek()
            local GearInventory = v1 and v1.GearInventory
            local v3 = false
            if GearInventory ~= nil then
                v3 = 0 < (GearInventory[GearId] or 0)
            end
            if not v3 then
                lockedFeedback(Doors)
                return
            end
            v3 = keyTool()
            if v3 ~= nil then
                local Archivable = v3.Archivable
                v3.Archivable = true
                local v4 = v3:Clone()
                v3.Archivable = Archivable
                u85 = v4
            else
                u85 = nil
            end
            local Play = Audio.Play
            local PadlockClunk = Sounds.PadlockClunk
            local v5 = Doors:FindFirstChild(ManorInterior.LockName)
            local v6 = if v5 == nil then nil else if not v5:IsA("Model") then nil else v5
            Play(
                PadlockClunk,
                (if v6 == nil then Doors:GetBoundingBox() else v6:GetBoundingBox()).Position,
                {Volume = 1, MaxDistance = 120}
            )
            u80 = true
            task.spawn(function() -- Line: 245 -- upvalues: sendRequest (upval), Doors (val), u80 (upval)
                sendRequest(Doors)
                u80 = false
            end)
            return
        end
    end
end

local function bind(a1) -- Line: 254
    -- upvalues: u78 (ref), Trove (val), Workspace (val), Prompt (val), triggered (val), applyOpen (val)
    -- upvalues: refreshPrompt (val)
    local Unit
    local v1 = u78
    if v1 ~= nil then
        if v1.Doors == a1 then
            return
        end
        u78 = nil
        v1.Trove:Destroy()
    end
    local u10 = Trove.new()
    local BoundingBox, BoundingBox_2 = a1:GetBoundingBox()
    local v2 = Vector3.new(-BoundingBox.LookVector.X, 0, -BoundingBox.LookVector.Z)
    local v3 = BoundingBox.Position + (if not (0.01 < v2.Magnitude) then Vector3.new(-0, -0, -1) else v2.Unit) * (BoundingBox_2.Z / 2 + 3) - Vector3.new(0, BoundingBox_2.Y / 2 - 6, 0)
    local v4 = u10:Add((Instance.new("Part")))
    v4.Name = "ManorDoorPrompt"
    v4.Anchored = true
    v4.CanCollide = false
    v4.CanQuery = false
    v4.CanTouch = false
    v4.Transparency = 1
    v4.Size = Vector3.new(1, 1, 1)
    v4.CFrame = CFrame.new(v3)
    v4.Parent = Workspace
    v3 = u10:Add((Instance.new("Attachment")))
    v3.Name = "ManorDoorPrompt"
    v3.Parent = v4
    v4 = u10:Add((Instance.new("ProximityPrompt")))
    v4.Name = "ManorDoorPrompt"
    v4.ObjectText = Prompt.Object
    v4.ActionText = Prompt.Locked
    v4.Style = Enum.ProximityPromptStyle.Custom
    v4.HoldDuration = 0
    v4.RequiresLineOfSight = false
    v4.MaxActivationDistance = 16
    v4.Parent = v3
    local u88 = {
        Open = false,
        Doors = a1,
        Trove = u10,
        Prompt = v4,
        Center = BoundingBox.Position,
        Outward = Unit,
    }
    u78 = u88
    u10:Connect(v4.Triggered, function() -- Line: 301 -- upvalues: triggered (upval), u88 (val)
        triggered(u88)
    end)
    u10:Connect(a1.AncestryChanged, function() -- Line: 304 -- upvalues: a1 (val), u78 (upval), u88 (val), u10 (val)
        if not a1:IsDescendantOf(game) and u78 == u88 then
            u78 = nil
            u10:Destroy()
        end
    end)
    u10:Add(function() -- Line: 310 -- upvalues: u88 (val)
        u88.Open = false
    end)
    applyOpen(u88, false)
    refreshPrompt(u88)
end

local function walkIn(a1) -- Line: 317
    -- upvalues: ManorInterior (val), Player (val), LocalPlayer (val), u79 (ref), u80 (ref), Save (val), Inside (val)
    -- upvalues: u87 (ref), u88 (ref), sendRequest (val)
    local v1 = ManorInterior.Doorway()
    local v2 = Player.FindRootPart(LocalPlayer)
    if v1 ~= nil and v2 ~= nil then
        local Position = v2.Position
        v2 = (Position - a1.Center):Dot(a1.Outward)
        local Open = not u79
        if Open then
            Open = not u80
            if Open then
                Open = a1.Open
                if Open then
                    local v3 = Save.Peek()
                    local HalloweenDimension = v3 and v3.HalloweenDimension
                    local Manor = HalloweenDimension and HalloweenDimension.Manor
                    Open = false
                    if Manor ~= nil then
                        Open = Manor.GateUnlocked == true
                    end
                    if Open then
                        Open = LocalPlayer:GetAttribute(Inside) == true
                    end
                end
            end
        end
        if not ManorInterior.Within(v1, Position, 0) then
            u87 = Open
            u88 = nil
            return
        end
        if not Open then
            u87 = false
            u88 = v2
            return
        end
        if not u87 then
            local v4 = math.max(u88 or v2, v2)
            u88 = v4
            if v4 - v2 < 3 then
                return
            end
            u87 = true
            u88 = nil
        end
        task.spawn(sendRequest, a1.Doors)
        return
    end
end

local function step() -- Line: 352
    -- upvalues: ManorInterior (val), u78 (ref), bind (val), applyOpen (val), u79 (ref), u80 (ref), refreshPrompt (val)
    -- upvalues: walkIn (val)
    local v1 = ManorInterior.Doors()
    if v1 == nil then
        local v2 = u78
        if v2 ~= nil then
            u78 = nil
            v2.Trove:Destroy()
        end
        return
    end
    if u78 == nil or u78.Doors ~= v1 then
        bind(v1)
    end
    v1 = u78
    if v1 == nil then
        return
    end
    applyOpen(v1, u79 or u80)
    refreshPrompt(v1)
    walkIn(v1)
end

function v1.SetBusy(a1) -- Line: 378 -- upvalues: u79 (ref), u78 (ref), refreshPrompt (val) -- types: a1: boolean
    u79 = a1
    local v1 = u78
    if v1 ~= nil then
        refreshPrompt(v1)
    end
end

function v1.TakeKey() -- Line: 386 -- upvalues: u85 (ref)
    local v1 = u85
    u85 = nil
    return v1
end

function v1.MarkOpen() -- Line: 392 -- upvalues: u81 (ref), u78 (ref)
    u81 = os.clock() + 15
    local v1 = u78
    if v1 ~= nil then
        v1.Open = true
    end
end

function v1.Start(a1, a2) -- Line: 400
    -- upvalues: u86 (ref), RunService (val), step (val), u78 (ref)
    u86 = a2
    local u2 = 0.05
    a1:Connect(RunService.Heartbeat, function(a1) -- Line: 403 -- upvalues: u2 (ref), step (upval) -- types: a1: number
        u2 = u2 + a1
        if u2 < 0.05 then
            return
        end
        u2 = 0
        step()
    end)
    a1:Add(function() -- Line: 411 -- upvalues: u78 (upval), u86 (upval)
        local v1 = u78
        u78 = nil
        u86 = nil
        if v1 ~= nil then
            v1.Trove:Destroy()
        end
    end)
end

return (table.freeze(v1))