-- Script path: ReplicatedStorage.Controllers.Game.ManorInteriorController.Unlock
-- Decompile time: 35.74 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Chain = require(script.Chain)
local Doors = require(script.Doors)
local Key = require(script.Key)
local Kit = require(script.Parent.Parent.SewerCaveController.Transition.Kit)
local Overlay = require(script.Overlay)
local Sfx = require(script.Sfx)
local Shot = require(script.Shot)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u54 = Enum.RenderPriority.Camera.Value + 1
local Looks = Shot.Looks
local u60 = table.freeze({1.02, 1.16})
local u75 = table.freeze({{50, 8}, {44, 8}, {56, 10}, {38, 7}})
local u90 = table.freeze({{14, 10}, {10, 9}, {20, 10}, {6, 8}})
local u105 = table.freeze({{14, 8}, {8, 7}, {22, 9}, {0, 6}})
local u110 = Color3.fromRGB(255, 160, 70)
local u115 = Color3.fromRGB(205, 190, 215)
local u120 = Color3.fromRGB(255, 200, 140)
local u121 = {}

local function once(a1, a2, a3, a4) -- Line: 132 -- types: a1: table, a2: string, a3: number, a4: number
    if not (a3 < a4) and not a1.Fired[a2] then
        a1.Fired[a2] = true
        return true
    end
    return false
end

local function part(a1, a2) -- Line: 140 -- types: a1: userdata?, a2: string
    if a1 == nil then
        return nil
    end
    local v1 = a1:FindFirstChild(a2, true)
    if v1 ~= nil and v1:IsA("BasePart") then
        return v1
    end
    return nil
end

local function depthAlong(a1, a2) -- Line: 148 -- types: a1: userdata, a2: vector
    local CFrame = a1.CFrame
    local Size = a1.Size
    return (math.abs((CFrame.RightVector:Dot(a2)))) * Size.X + (math.abs((CFrame.UpVector:Dot(a2)))) * Size.Y + (math.abs((CFrame.LookVector:Dot(a2)))) * Size.Z
end

local function headOf(a1, a2) -- Line: 156 -- types: a1: userdata?, a2: vector
    local Head = a1 and a1:FindFirstChild("Head")
    if Head ~= nil and Head:IsA("BasePart") then
        return Head.Position
    end
    return a2
end

local function ignoreList(a1) -- Line: 164 -- types: a1: table
    local v1 = {a1.Context.Doors}
    local Character = a1.Context.Character
    if Character ~= nil then
        table.insert(v1, Character)
    end
    local Burst = a1.Burst
    if Burst ~= nil then
        table.insert(v1, Burst.Folder)
    end
    local Key = a1.Key
    if Key ~= nil then
        table.insert(v1, Key.Model)
    end
    return v1
end

local function place(a1, a2, a3, a4, a5, a6, a7) -- Line: 181
    -- upvalues: Kit (val)
    local Magnitude, v1, v2, v3, v4
    local v5 = a1 + a2 * a6
    local v6 = -1
    local v7 = nil
    local v8 = nil
    local v9 = a4
    for i, j in a5, v7, v8 do
        for k, n in {v9, -v9} do
            v1 = math.rad(j[1])
            v2 = math.rad(j[2])
            v4 = (v10 * math.cos(v1) + v11 * (n * math.sin(v1))) * math.cos(v2)
            v1 = v12 + (v4 + Vector3.new(0, 1, 0) * math.sin(v2)) * v13
            v3 = Kit.Clamp(v12, v1, v14)
            Magnitude = (v3 - v12).Magnitude
            if v13 * 0.97 <= Magnitude then
                return v3
            end
            if v6 < Magnitude then
                v5 = v3
            end
        end
    end
    return v5
end

local function frames(a1) -- Line: 213
    -- upvalues: ignoreList (val), Players (val), place (val), u75 (val), u90 (val), Doors (val), u105 (val), Shot (val)
    local v1
    local Rig = a1.Rig
    local v2 = ignoreList(a1)
    for i, j in Players:GetPlayers() do
        if j.Character ~= nil then
            table.insert(v2, j.Character)
        end
    end
    local v3 = -a1.Inward
    local Character = a1.Context.Character
    local v4 = a1.Keyhole + v3 * 12
    local Head = Character and Character:FindFirstChild("Head")
    v4 = (if Head == nil then v4 else if not Head:IsA("BasePart") then v4 else Head.Position) - a1.Keyhole
    v4 = v4:Dot(a1.Across)
    a1.Side = if not (v4 >= 0) then -1 else 1
    local v5 = a1.Keyhole + v3 * 2.5 + Vector3.new(0, 1, 0)
    v4 = place(v5, v3, a1.Across, v1, u75, 22, v2)
    local v6 = place(v5, v3, a1.Across, if not (0 <= ((v4 - v5):Dot(a1.Across))) then -1 else 1, u90, 22, v2)
    local v7 = math.max((v6 - v5).Magnitude, 1)
    a1.CloseLook = v5
    a1.Close = CFrame.lookAt(v4, v5)
    a1.Front = CFrame.lookAt(v6, v5)
    a1.CloseFov = math.clamp(math.deg((math.atan(10.5 / v7))) * 2, 30, a1.Shot.FieldOfView)
    v6 = Doors.Point(Rig, 0, Rig.Height * 0.3, -6)
    a1.WideLook = v6
    a1.Wide = CFrame.lookAt(place(v6, v3, a1.Across, v1, u105, 40, v2), v6)
    a1.Start = a1.Shot.Camera.CFrame
    a1.StartLook = a1.Start.Position + a1.Start.LookVector * 20
    a1.Aim = a1.Start.LookVector
    a1.Reach = Shot.Reach()
end

local function kick(a1, a2, a3, a4, a5, a6) -- Line: 248
    -- upvalues: 
    table.insert(a1.Kicks, {
        At = a1.Clock,
        Strength = a2,
        Seconds = a3,
        Push = a4,
        Roll = a5 or 0,
        Punch = a6 or 0,
    })
end

local function shake(a1, a2) -- Line: 266 -- types: a1: table, a2: number
    local v1, v2, v3
    if a1.Shot.Calm then
        return CFrame.identity, 0
    end
    local v4 = 0
    local v5 = 0
    local v6 = 0
    local v7 = 0
    local v8 = 0
    for i, j in a1.Kicks do
        v1 = a2 - j.At
        if v1 >= 0 and v1 < j.Seconds then
            v2 = (1 - v1 / j.Seconds) ^ 2
            v3 = j.At * 13.1
            v4 = v4 + math.noise(a2 * 38, v3, 0.3) * 2 * j.Strength * v2
            v5 = v5 + math.noise(a2 * 38, v3, 5.7) * 2 * j.Strength * v2
            v7 = v7 + math.noise(a2 * 38 * 0.5, v3, 9.1) * 2 * j.Roll * v2
            v6 = v6 + j.Push * v2
            v8 = v8 + j.Punch * v2
        end
    end
    return (CFrame.new(v4, v5, -v6)) * CFrame.Angles(0, 0, v7), v8
end

local function handBack(a1) -- Line: 286 -- upvalues: Shot (val), ignoreList (val), Kit (val) -- types: a1: table
    local Root = a1.Root
    if Root ~= nil and Root.Parent ~= nil then
        local v1 = Shot.Pose(Root, a1.Aim, a1.Reach)
        local v2 = v1.Position + v1.LookVector * a1.Reach
        return (CFrame.lookAt(Kit.Clamp(v2, v1.Position, (ignoreList(a1))), v2)), v1
    end
    return a1.Start, a1.Start
end

local function blend(a1, a2, a3, a4, a5) -- Line: 297
    -- upvalues: 
    return CFrame.lookAt(a1.Position:Lerp(a3.Position, a5), a2:Lerp(a4, a5))
end

local function cameraStep(a1, a2) -- Line: 307
    -- upvalues: Kit (val), handBack (val), shake (val), Shot (val)
    local v1, v2, v3
    local Shot_2 = a1.Shot
    local FieldOfView = Shot_2.FieldOfView
    local v4 = a1.Close.Position - a1.CloseLook
    local v5 = a1.Front.Position - a1.CloseLook
    local v6 = Kit.Ease(Kit.Span(a2, 0.86, 1.3), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    local v7 = (v4.Unit:Lerp(v5.Unit, v6)).Unit * math.lerp(v4.Magnitude, v5.Magnitude, v6)
    v6 = CFrame.lookAt(a1.CloseLook + v7 - v7.Unit * (1.4 * Kit.Smooth(Kit.Span(a2, 0.5, 1.58))), a1.CloseLook)
    v5 = CFrame.lookAt(a1.Wide.Position + (a1.WideLook - a1.Wide.Position).Unit * (3 * Kit.Smooth(Kit.Span(a2, 1.58, 2.88))), a1.WideLook)
    if a2 < 0.5 then
        v7 = Kit.Ease(a2 / 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)
        local Start = a1.Start
        local StartLook = a1.StartLook
        local Close = a1.Close
        local CloseLook = a1.CloseLook
        v2 = CFrame.lookAt(Start.Position:Lerp(Close.Position, v7), StartLook:Lerp(CloseLook, v7))
        FieldOfView = math.lerp(Shot_2.FieldOfView, a1.CloseFov, v7)
    elseif a2 < 1.58 then
        v2 = v6
        FieldOfView = a1.CloseFov
    elseif a2 < 2.45 then
        v4 = Kit.Ease(Kit.Span(a2, 1.58, 2.45), Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)
        local CloseLook_2 = a1.CloseLook
        local WideLook_2 = a1.WideLook
        v2 = CFrame.lookAt(v6.Position:Lerp(v5.Position, v4), CloseLook_2:Lerp(WideLook_2, v4))
        FieldOfView = math.lerp(a1.CloseFov, Shot_2.FieldOfView, v4)
    elseif not (a2 < 2.88) then
        v3 = Kit.Ease(Kit.Span(a2, 2.88, 3.45), Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)
        v1 = handBack(a1)
        local v8 = v1.Position + v1.LookVector * a1.Reach
        local WideLook_3 = a1.WideLook
        v2 = CFrame.lookAt(v5.Position:Lerp(v1.Position, v3), WideLook_3:Lerp(v8, v3))
    else
        v2 = v5
    end
    v3, v1 = shake(a1, a2)
    Shot.Place(Shot_2, v2 * v3, FieldOfView + v1)
end

local function lookStep(a1, a2) -- Line: 363
    -- upvalues: Shot (val), Looks (val), Kit (val), Overlay (val)
    local Shot_2 = a1.Shot
    local Overlay_2 = a1.Overlay
    if a2 < 1.46 then
        Shot.Look(Shot_2, Looks.Clear, Looks.Keyhole, Kit.Span(a2, 0, 0.5))
        Overlay.Vignette(Overlay_2, 0.55 * Kit.Span(a2, 0, 0.5))
    elseif a2 < 1.88 then
        Shot.Look(Shot_2, Looks.Keyhole, Looks.Clear, Kit.Span(a2, 1.53, 1.88))
        Overlay.Vignette(Overlay_2, 0.55 * (1 - Kit.Span(a2, 1.46, 2.45)))
    elseif not (a2 < 2.88) then
        Shot.Look(Shot_2, Looks.Spill, Looks.Clear, Kit.Span(a2, 2.88, 3.45))
        Overlay.Vignette(Overlay_2, 0)
    else
        Shot.Look(Shot_2, Looks.Clear, Looks.Spill, Kit.Span(a2, 1.88, 2.6799999999999997))
        Overlay.Vignette(Overlay_2, 0.55 * (1 - Kit.Span(a2, 1.46, 2.45)))
    end
    if Shot_2.Calm then
        Overlay.Ring(Overlay_2, Vector2.new(0.5, 0.5), 0)
        Overlay.Wash(Overlay_2, Shot.White, 0)
        return
    end
    Overlay.Ring(Overlay_2, Kit.Projected(Shot_2.Camera, a1.Keyhole), Kit.Span(a2, 1.46, 1.76))
    Overlay.Wash(Overlay_2, Color3.fromRGB(255, 240, 220), if not (a2 >= 1.46) then 0 else if not (a2 < 1.49) then 0 else 0.12)
end

local function keyStep(a1, a2) -- Line: 395 -- upvalues: Key (val), Kit (val), u60 (val) -- types: a1: table, a2: number
    local Key_2 = a1.Key
    if Key_2 ~= nil and not (a2 >= 1.46) then
        local v1 = Key.Seat(Key_2, a1.Keyhole, a1.Inward, 0.3)
        local v2 = -a1.Inward
        Key.Show(Key_2, Kit.Span(a2, 0.3, 0.42))
        if a2 < 0.9 then
            Key.Place(Key_2, v1 + v2 * (5.5 * (1 - (Kit.Ease(Kit.Span(a2, 0.56, 0.9), Enum.EasingStyle.Cubic, Enum.EasingDirection.In)))))
            return
        end
        v2 = 0
        for i, j in u60 do
            v2 = v2 + Kit.Ease(Kit.Span(a2, j, j + 0.1), Enum.EasingStyle.Back, Enum.EasingDirection.Out) * 0.7853981633974483
        end
        Key.Place(Key_2, (v1 + a1.Inward * (if not (a2 < 0.98) then 0 else (1 - Kit.Span(a2, 0.9, 0.98)) * 0.25)) * CFrame.Angles(0, v2, 0))
        return
    end
end

local function lockStep(a1, a2) -- Line: 426
    -- upvalues: Kit (val), Chain (val), u60 (val)
    local Burst = a1.Burst
    if Burst ~= nil and not Burst.Snapped then
        local v1
        local Inward = a1.Inward
        if not (a2 >= 0.9) then
            if a2 >= 1 then
                Chain.Nudge(Burst, Burst.PadlockSource, (Vector3.new(0, 0, 0)))
            end
        elseif a2 < 1 then
            v1 = (1 - Kit.Span(a2, 0.9, 1)) * 0.3
            Chain.Nudge(Burst, Burst.PadlockSource, Inward * v1)
            Chain.Nudge(Burst, Burst.ShackleSource, Inward * v1)
        elseif a2 >= 1 then
            Chain.Nudge(Burst, Burst.PadlockSource, (Vector3.new(0, 0, 0)))
        end
        v1 = 0
        local v2 = u60
        local v3 = nil
        for i, j in v2, v3 do
            if j <= a2 and a2 < j + 0.12 then
                v1 = 1 - Kit.Span(a2, j, j + 0.12)
            end
        end
        Chain.Rattle(Burst, if not a1.Shot.Calm then v1 else 0, a2)
        local ShackleSource = Burst.ShackleSource
        if ShackleSource ~= nil and a2 >= 1.36 then
            v2 = Burst.Rest[ShackleSource]
            if v2 ~= nil then
                v3 = Kit.Ease(Kit.Span(a2, 1.36, 1.4400000000000002), Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                local v4 = v2.Position - a1.Across * (ShackleSource.Size.X * 0.3) - Vector3.new(0, 1, 0) * (ShackleSource.Size.Y * 0.15)
                ShackleSource.CFrame = (CFrame.new(v4)) * CFrame.fromAxisAngle(Inward, 0.4188790204786391 * v3) * CFrame.new(-v4) * v2 + Vector3.new(0, 1, 0) * (1.4 * v3)
            end
        end
        a1.Glow.Brightness = if not (a2 < u60[1]) then 4 * Kit.Span(a2, u60[1], 1.36) else 0
        return
    end
end

local function swing(a1) -- Line: 468 -- types: a1: number
    local v1
    if a1 <= 0.68 then
        v1 = a1 / 0.68
        return v1 * 0.3 + v1 * 0.7 * v1
    end
    v1 = (a1 - 0.68) / 0.31999999999999995
    return 1 - math.sin(v1 * 3.141592653589793) * 0.1 * (1 - v1)
end

local function doorStep(a1, a2) -- Line: 477
    -- upvalues: Kit (val), Doors (val), Chain (val)
    local v1, v2, v3, v4
    if a2 < 1.88 then
        return
    end
    local Calm = a1.Shot.Calm
    local Swings = a1.Rig.Swings
    local v5 = nil
    local v6 = nil
    local v7, v8 = a1, a2
    for i in Swings, v5, v6 do
        v3 = 1.88 + (i - 1) * 0.09
        if v3 <= v8 then
            v4 = Kit.Span(v8, v3, v3 + 0.8)
            if Calm then
                v1 = Kit.Ease(v4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
            elseif not (v4 <= 0.68) then
                v2 = (v4 - 0.68) / 0.31999999999999995
                v1 = 1 - math.sin(v2 * 3.141592653589793) * 0.1 * (1 - v2)
            else
                v2 = v4 / 0.68
                v1 = v2 * 0.3 + v2 * 0.7 * v2
            end
            Doors.PoseSwing(v7.Rig, i, v1)
        end
    end
    local Burst = v7.Burst
    if Burst ~= nil and Burst.Snapped then
        local v9 = {}
        for j in v7.Rig.Swings do
            v4, v1, v2 = Doors.Leaf(v7.Rig, j)
            if v4 ~= nil and v1 ~= nil then
                table.insert(v9, {Hinge = v4, Along = v1, Reach = v2})
            end
        end
        Chain.Plow(Burst, v9, -v7.Inward)
    end
    local Foyer = v7.Foyer
    if Foyer ~= nil then
        Foyer.Lit = Kit.Smooth(Kit.Span(v8, 1.88, 2.6799999999999997))
    end
end

local function cues(a1, a2) -- Line: 509
    -- upvalues: Sfx (val), u60 (val), Chain (val), Key (val), Doors (val)
    local v1, v2, v3, v4
    local Calm = a1.Shot.Calm
    local Burst = a1.Burst
    local Key_2 = a1.Key
    if a2 < 0.3 then
        v4 = false
    elseif not a1.Fired.Glint then
        a1.Fired.Glint = true
        v4 = true
    else
        v4 = false
    end
    if v4 then
        Sfx.Play("Shimmer", 0.4, 1.2)
        if Key_2 ~= nil then
            Key_2.Sparkle:Emit(10)
        end
    end
    if a2 < 0.9 then
        v4 = false
    elseif not a1.Fired.Thunk then
        a1.Fired.Thunk = true
        v4 = true
    else
        v4 = false
    end
    if v4 then
        Sfx.At("KeyThunk", a1.Keyhole, 1)
        table.insert(a1.Kicks, {
            Strength = 0.12,
            Seconds = 0.22,
            Push = 0.35,
            Roll = 0,
            Punch = 0,
            At = a1.Clock,
        })
        if Burst ~= nil then
            Burst.Sparks.WorldPosition = a1.Keyhole - a1.Inward * 0.5
            Burst.Dust:Emit(4)
        end
    end
    v4 = u60
    local v5 = nil
    local v6 = nil
    for i, j in v4, v5, v6 do
        v2 = ("Turn%*"):format(i)
        if a2 < j then
            v1 = false
        elseif not a1.Fired[v2] then
            a1.Fired[v2] = true
            v1 = true
        else
            v1 = false
        end
        if v1 then
            if not (i < #u60) then
                Sfx.At("KeyThunk", a1.Keyhole, 1, 0.72)
                Sfx.At("PadlockClunk", a1.Keyhole, 0.9, 0.85)
                table.insert(a1.Kicks, {
                    Strength = 0.16,
                    Seconds = 0.25,
                    Push = 0.3,
                    Roll = 0,
                    Punch = 0,
                    At = a1.Clock,
                })
            else
                Sfx.At("Ratchet", a1.Keyhole, 0.9, 1 + i * 0.08)
                Sfx.At("ChainRattle", a1.Keyhole, 0.35, 1.1)
                table.insert(a1.Kicks, {
                    Strength = 0.04,
                    Seconds = 0.1,
                    Push = 0.08,
                    Roll = 0,
                    Punch = 0,
                    At = a1.Clock,
                })
            end
        end
    end
    if a2 < 1.36 then
        v4 = false
    elseif not a1.Fired.Pop then
        a1.Fired.Pop = true
        v4 = true
    else
        v4 = false
    end
    if v4 then
        Sfx.At("KeyTurn", a1.Keyhole, 0.8, 0.75)
        table.insert(a1.Kicks, {
            Strength = 0.08,
            Seconds = 0.15,
            Push = 0,
            Roll = 0,
            Punch = 0,
            At = a1.Clock,
        })
    end
    if a2 < 1.46 then
        v4 = false
    elseif not a1.Fired.Snap then
        a1.Fired.Snap = true
        v4 = true
    else
        v4 = false
    end
    if v4 then
        a1.Frozen = 0.07
        if Burst ~= nil then
            Chain.Snap(Burst, -a1.Inward, Calm, 0.07, a1.Across * -a1.Side)
            if Key_2 ~= nil and Burst.Padlock ~= nil then
                Key.Weld(Key_2, Burst.Padlock)
            end
        end
        if Key_2 ~= nil then
            Key.Fade(Key_2)
        end
        Sfx.Play("ChainSnap", 0.85)
        Sfx.At("ChainSnap", a1.Keyhole, 0.6, 0.9)
        if not Calm then
            Sfx.Play("Boom", 0.22)
        end
        table.insert(a1.Kicks, {
            Strength = 0.4,
            Seconds = 0.4,
            Push = 0.6,
            Roll = 0,
            Punch = 4,
            At = a1.Clock,
        })
    end
    if a2 < 1.8299999999999998 then
        v4 = false
    elseif not a1.Fired.Foyer then
        a1.Fired.Foyer = true
        v4 = true
    else
        v4 = false
    end
    if v4 then
        local v7 = Doors.SetFoyer(a1.Rig, true)
        if v7 ~= nil then
            v7.Lit = 0
        end
        a1.Foyer = v7
    end
    if a2 < 1.88 then
        v4 = false
    elseif not a1.Fired.Creak then
        a1.Fired.Creak = true
        v4 = true
    else
        v4 = false
    end
    if v4 then
        Sfx.At("Creak", Doors.Point(a1.Rig, 0, a1.Rig.Height * 0.3, 0), 1, 0.85)
    end
    v5 = nil
    v6 = nil
    for k in a1.Rig.Swings, v5, v6 do
        v1 = 1.88 + (k - 1) * 0.09 + 0.544
        v3 = ("Stop%*"):format(k)
        if a2 < v1 then
            v2 = false
        elseif not a1.Fired[v3] then
            a1.Fired[v3] = true
            v2 = true
        else
            v2 = false
        end
        if v2 then
            v2 = Doors.Tip(a1.Rig, k)
            if v2 ~= nil then
                Sfx.At("DoorSlam", v2, 0.55, 0.7 + k * 0.06)
                if not Calm then
                    v3 = Doors.Point(a1.Rig, 0, 1, 0)
                    a1.Thud.Parent.WorldPosition = Vector3.new(v2.X, v3.Y, v2.Z)
                    a1.Thud:Emit(10)
                end
            end
            table.insert(a1.Kicks, {
                Strength = 0.3,
                Seconds = 0.32,
                Push = -0.25,
                Roll = 0.015,
                Punch = 2,
                At = a1.Clock,
            })
        end
    end
    if a2 < 2.88 then
        v4 = false
    elseif not a1.Fired.Tidy then
        a1.Fired.Tidy = true
        v4 = true
    else
        v4 = false
    end
    if v4 and Burst ~= nil and Burst.Snapped then
        Chain.Tidy(Burst, a1.Keyhole, a1.Across, 5)
    end
    if a2 < 2.13 then
        v4 = false
    elseif not a1.Fired.Breath then
        a1.Fired.Breath = true
        v4 = true
    else
        v4 = false
    end
    if v4 then
        Sfx.Play("Draft", 0.3, 1.1)
        if not Calm then
            a1.Puff:Emit(14)
            a1.Wisps:Emit(6)
        end
    end
end

local function finish(a1) -- Line: 601 -- upvalues: Doors (val), Chain (val), Key (val) -- types: a1: table
    if a1.Done then
        return
    end
    a1.Done = true
    Doors.Pose(a1.Rig, 1)
    local v1 = Doors.SetFoyer(a1.Rig, true)
    if v1 ~= nil then
        v1.Lit = 1
    end
    local Burst = a1.Burst
    if Burst ~= nil then
        if not Burst.Snapped then
            Chain.Snap(Burst, -a1.Inward, true, 0)
            if a1.Key ~= nil then
                Key.Fade(a1.Key)
            end
        end
        Chain.Tidy(Burst, a1.Keyhole, a1.Across, 5)
        Chain.Keep(Burst)
    elseif a1.Context.Lock ~= nil then
        Chain.Hide(a1.Context.Lock, true)
    end
    a1.Trove:Destroy()
end

local function step(a1, a2) -- Line: 627
    -- upvalues: cameraStep (val), cues (val), keyStep (val), lockStep (val), doorStep (val), lookStep (val)
    if 0 < a1.Frozen then
        a1.Frozen = a1.Frozen - a2
        cameraStep(a1, a1.Clock)
        return
    end
    a1.Clock = a1.Clock + a2
    local Clock = a1.Clock
    cues(a1, Clock)
    keyStep(a1, Clock)
    lockStep(a1, Clock)
    doorStep(a1, Clock)
    lookStep(a1, Clock)
    cameraStep(a1, Clock)
end

local function stepAside(a1) -- Line: 643 -- upvalues: Doors (val) -- types: a1: table
    local Root = a1.Root
    local Humanoid = a1.Humanoid
    if Root ~= nil and Humanoid ~= nil and not (Humanoid.Health <= 0) then
        local v1 = Doors.Clearing(a1.Rig, Root.Position, 2.5)
        if v1 == nil then
            return
        end
        local AutoRotate = Humanoid.AutoRotate
        Humanoid.AutoRotate = false
        Humanoid:MoveTo(v1)
        a1.Trove:Add(function() -- Line: 656 -- upvalues: Humanoid (val), AutoRotate (val)
            if Humanoid.Parent ~= nil then
                Humanoid.AutoRotate = AutoRotate
            end
        end)
        return
    end
end

local function thud(a1) -- Line: 663 -- upvalues: Workspace (val), u115 (val)
    local v1 = a1:Add((Instance.new("Attachment")))
    v1.Name = "ManorDoorThud"
    v1.Parent = Workspace.Terrain
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "Dust"
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds"
    ParticleEmitter.Rate = 0
    ParticleEmitter.Shape = Enum.ParticleEmitterShape.Sphere
    ParticleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
    ParticleEmitter.EmissionDirection = Enum.NormalId.Top
    ParticleEmitter.LightInfluence = 0.6
    ParticleEmitter.Color = ColorSequence.new(u115)
    ParticleEmitter.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.15, 0.55),
        (NumberSequenceKeypoint.new(1, 1)),
    })
    ParticleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2), (NumberSequenceKeypoint.new(1, 7))})
    ParticleEmitter.Lifetime = NumberRange.new(0.6, 1.1)
    ParticleEmitter.Speed = NumberRange.new(4, 9)
    ParticleEmitter.SpreadAngle = Vector2.new(70, 70)
    ParticleEmitter.Drag = 3
    ParticleEmitter.Rotation = NumberRange.new(0, 360)
    ParticleEmitter.RotSpeed = NumberRange.new(-60, 60)
    ParticleEmitter.Acceleration = Vector3.new(0, -1, 0)
    ParticleEmitter.Parent = v1
    return ParticleEmitter
end

local function breath(a1, a2) -- Line: 696 -- upvalues: Doors (val), Workspace (val), u115 (val), u120 (val)
    local v1 = a1:Add((Instance.new("Attachment")))
    v1.Name = "ManorDoorBreath"
    v1.WorldCFrame = CFrame.lookAt(Doors.Point(a2, 0, a2.Height * 0.2, 2), Doors.Point(a2, 0, a2.Height * 0.2, -10))
    v1.Parent = Workspace.Terrain
    local ParticleEmitter = Instance.new("ParticleEmitter")
    ParticleEmitter.Name = "Mist"
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds"
    ParticleEmitter.Rate = 0
    ParticleEmitter.EmissionDirection = Enum.NormalId.Front
    ParticleEmitter.Shape = Enum.ParticleEmitterShape.Box
    ParticleEmitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume
    ParticleEmitter.LightInfluence = 0.5
    ParticleEmitter.Color = ColorSequence.new(u115)
    ParticleEmitter.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.2, 0.6),
        (NumberSequenceKeypoint.new(1, 1)),
    })
    ParticleEmitter.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 5), (NumberSequenceKeypoint.new(1, 14))})
    ParticleEmitter.Lifetime = NumberRange.new(1, 1.6)
    ParticleEmitter.Speed = NumberRange.new(10, 18)
    ParticleEmitter.SpreadAngle = Vector2.new(35, 15)
    ParticleEmitter.Drag = 2.5
    ParticleEmitter.Rotation = NumberRange.new(0, 360)
    ParticleEmitter.RotSpeed = NumberRange.new(-40, 40)
    ParticleEmitter.Acceleration = Vector3.new(0, -2, 0)
    ParticleEmitter.Parent = v1
    local ParticleEmitter_2 = Instance.new("ParticleEmitter")
    ParticleEmitter_2.Name = "Wisps"
    ParticleEmitter_2.Texture = "rbxassetid://84182473776460"
    ParticleEmitter_2.Rate = 0
    ParticleEmitter_2.EmissionDirection = Enum.NormalId.Front
    ParticleEmitter_2.LightEmission = 1
    ParticleEmitter_2.LightInfluence = 0
    ParticleEmitter_2.Color = ColorSequence.new(u120, Color3.new(1, 1, 1))
    ParticleEmitter_2.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.15, 0.25),
        (NumberSequenceKeypoint.new(1, 1)),
    })
    ParticleEmitter_2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.6), (NumberSequenceKeypoint.new(1, 3.4))})
    ParticleEmitter_2.Lifetime = NumberRange.new(0.9, 1.4)
    ParticleEmitter_2.Speed = NumberRange.new(14, 22)
    ParticleEmitter_2.SpreadAngle = Vector2.new(40, 25)
    ParticleEmitter_2.Drag = 1.5
    ParticleEmitter_2.Rotation = NumberRange.new(0, 360)
    ParticleEmitter_2.RotSpeed = NumberRange.new(-120, 120)
    ParticleEmitter_2.Acceleration = Vector3.new(0, 6, 0)
    ParticleEmitter_2.Parent = v1
    return ParticleEmitter, ParticleEmitter_2
end

local function begin(a1) -- Line: 758
    -- upvalues: Doors (val), Shot (val), Trove (val), depthAlong (val), Chain (val), Workspace (val), u110 (val)
    -- upvalues: breath (val), Overlay (val), thud (val), Key (val), LocalPlayer (val), frames (val), stepAside (val)
    local v1, v2
    local v3 = Doors.Rig(a1.Doors, a1.Lock)
    if v3 == nil then
        return nil
    end
    local v4 = Shot.Take()
    if v4 == nil then
        return nil
    end
    local v5 = Trove.new()
    local v6 = Doors.Inward(v3)
    local Unit = Vector3.new(0, 1, 0):Cross(v6).Unit
    local Lock = a1.Lock
    if Lock ~= nil then
        v2 = Lock:FindFirstChild("Cube.003", true)
        v1 = if v2 == nil then nil else if not v2:IsA("BasePart") then nil else v2
    else
        v1 = nil
    end
    v2 = if v1 == nil then Doors.Point(v3, 0, v3.Height * 0.23, -v3.Depth) else v1.Position - v6 * (depthAlong(v1, v6) / 2) - Vector3.new(0, 0.4000000059604645, 0)
    v1 = nil
    if Lock ~= nil then
        v1 = Chain.Prepare(Trove.new(), Lock)
        v1.Ground = Doors.Point(v3, 0, 0, 0).Y
    end
    local v7 = v5:Add((Instance.new("Attachment")))
    v7.Name = "ManorKeyhole"
    v7.WorldPosition = v2 - v6 * 0.8
    v7.Parent = Workspace.Terrain
    local PointLight = Instance.new("PointLight")
    PointLight.Brightness = 0
    PointLight.Range = 10
    PointLight.Color = u110
    PointLight.Shadows = false
    PointLight.Parent = v7
    local v8, v9 = breath(v5, v3)
    v7 = {
        Context = a1,
        Trove = v5,
        Rig = v3,
        Shot = v4,
        Overlay = Overlay.Build(v5),
        Burst = v1,
        Key = nil,
        Foyer = nil,
        Keyhole = v2,
        Inward = v6,
        Across = Unit,
        Side = 1,
        Start = v4.Camera.CFrame,
        StartLook = v2,
        Close = v4.Camera.CFrame,
        Front = v4.Camera.CFrame,
        CloseLook = v2,
        CloseFov = v4.FieldOfView,
        Wide = v4.Camera.CFrame,
        WideLook = v2,
        Aim = v4.Camera.CFrame.LookVector,
        Reach = 12,
        Root = nil,
        Humanoid = nil,
        Glow = PointLight,
        Puff = v8,
        Wisps = v9,
        Thud = thud(v5),
    }
    v7.Kicks = {}
    v7.Clock = 0
    v7.Frozen = 0
    v7.Done = false
    v7.Fired = {}
    local v10 = if v1 == nil then Key.Build(v5, Workspace) else Key.Build(v1.Trove, v1.Folder)
    v7.Key = v10
    local Character = a1.Character or LocalPlayer.Character
    v8 = Character and Character:FindFirstChild("HumanoidRootPart")
    local v11 = Character and Character:FindFirstChildOfClass("Humanoid")
    v7.Root = if v8 == nil then nil else if not v8:IsA("BasePart") then nil else v8
    v7.Humanoid = v11
    frames(v7)
    stepAside(v7)
    return v7
end

function u121.Play(a1) -- Line: 848
    -- upvalues: Sfx (val), begin (val), u121 (val), LocalPlayer (val), u54 (val), step (val), handBack (val)
    -- upvalues: finish (val), Shot (val)
    Sfx.Warm()
    local u6 = begin(a1)
    if u6 == nil then
        u121.SetOpen(a1, true)
        return
    end
    local Character = a1.Character or LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local u21 = false
    if Humanoid ~= nil then
        u6.Trove:Connect(Humanoid.Died, function() -- Line: 859 -- upvalues: u21 (ref)
            u21 = true
        end)
    end
    u6.Trove:Connect(LocalPlayer.CharacterAdded, function() -- Line: 863 -- upvalues: u21 (ref)
        u21 = true
    end)
    local u40 = false
    u6.Trove:BindToRenderStep("ManorDoorUnlock", u54, function(a1) -- Line: 867 -- upvalues: u6 (val), u40 (ref), u21 (ref), step (upval) -- types: a1: number
        if not u6.Done and not u40 and not u21 then
            local success, err = pcall(step, u6, a1)
            if not success then
                u40 = true
                warn((("[ManorInterior] unlock step stopped: %*"):format(err)))
            end
            return
        end
    end)
    while not u6.Done do
        if u40 or u21 or u6.Shot.Done or not (u6.Clock < 3.45) then
            break
        end
        task.wait()
    end
    local v1 = nil
    local v2 = nil
    if not u21 and not u40 and not u6.Shot.Done then
        local v3, v4 = handBack(u6)
        v1 = v3
        v2 = v4
    end
    finish(u6)
    Shot.Release(u6.Shot, v1, v2)
end

function u121.SetOpen(a1, a2) -- Line: 894 -- upvalues: Doors (val), Chain (val) -- types: a1: table, a2: boolean
    local v1 = Doors.Rig(a1.Doors, a1.Lock)
    local Lock = a1.Lock
    if a2 then
        if Lock ~= nil then
            Chain.Hide(Lock, true)
        end
        if v1 == nil then
            return
        end
        Doors.Pose(v1, 1)
        Doors.SetFoyer(v1, true)
        return
    end
    Chain.Clear()
    if Lock ~= nil then
        Chain.Hide(Lock, false)
    end
    if v1 ~= nil then
        Doors.Pose(v1, 0)
        Doors.SetFoyer(v1, false)
    end
end

return u121