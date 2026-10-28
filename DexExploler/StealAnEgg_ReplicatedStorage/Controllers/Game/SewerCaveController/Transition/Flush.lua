-- Script path: ReplicatedStorage.Controllers.Game.SewerCaveController.Transition.Flush
-- Decompile time: 19.98 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Depths = require(script.Parent.Depths)
local Double = require(script.Parent.Double)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local u26 = require(script.Parent.Hands)
local Kit = require(script.Parent.Kit)
local Overlay = require(script.Parent.Overlay)
local Score = require(script.Parent.Score)
local Splash = require(script.Parent.Splash)
local Stage = require(script.Parent.Stage)
local u56 = CFrame.new(-6200, 30000, 20900)
local Looks = Kit.Looks
local v1 = {}

local function setLook(a1, a2, a3, a4) -- Line: 39 -- upvalues: Kit (val) -- types: a4: number
    Kit.Mix(a1.Grade.Look, a2, a3, a4)
end

local function mouthOf(a1) -- Line: 43 -- upvalues: Stage (val), Kit (val)
    local v1 = Stage.OutletFlange()
    local Position = a1.Root.Position
    if v1 ~= nil then
        local RightVector = v1.CFrame.RightVector
        local v2 = if not (0 < (RightVector:Dot((Kit.FlatUnit(Position - v1.Position, -RightVector))))) then RightVector else -RightVector
        return v1.Position, Kit.FlatUnit(v2, (Vector3.new(1, 0, 0)))
    end
    local Pipe = a1.Context.Pipe
    if Pipe ~= nil then
        local v3 = Kit.FlatUnit(Pipe.Position - Position, (Vector3.new(1, 0, 0)))
        return Pipe.Position + v3 * 8, v3
    end
    v1 = Kit.FlatUnit(a1.Root.CFrame.LookVector, (Vector3.new(0, 0, 1)))
    return Position + v1 * 10, v1
end

local function suction(a1, a2) -- Line: 62
    -- upvalues: Kit (val), Double (val), Splash (val), Looks (val)
    local State = a1.State
    local Double_2 = a1.Double
    local Mouth = State.Mouth
    local Inward = State.Inward
    local Start = State.Start
    local v1 = Kit.Span(a2, 0, 0.55)
    local v2 = Kit.Ease(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local v3 = Mouth + Inward * 8
    local v4 = (Start.Position:Lerp(v3, v2)) + Vector3.new(0, math.sin((math.min(v1 * 2, 1)) * 3.141592653589793 / 2) * -1.2, 0)
    v2 = Kit.Smooth(Kit.Span(a2, 0, 0.35))
    v1 = Kit.FlatUnit(v3 - Start.Position, Inward)
    v3 = (CFrame.lookAt(v4, v4 + v1)) * CFrame.Angles(-1.4835298641951802 * v2, 0, 0)
    if Double_2 then
        Double.Pose(Double_2, Double.Blend(Double.Poses.Rest, Double.Poses.Slide, v2))
        Double.Place(Double_2, v3)
    end
    Splash.Jet(a1.Splash, Start.Position - v1 * 4 + Vector3.new(0, -2, 0), Mouth + Inward * 4, 1 - Kit.Span(a2, 0.35, 0.55))
    Kit.Mix(a1.Grade.Look, Looks.Clear, Looks.MoonTeal, (Kit.Smooth(a2 / 0.3)))
    if a2 >= 0.49000000000000005 then
        Kit.Mix(a1.Grade.Look, Looks.MoonTeal, Looks.Flash, (Kit.Span(a2, 0.49000000000000005, 0.55)))
    end
    Kit.Apply(a1.Grade, 0)
    if not a1.OwnsCamera then
        return
    end
    v1 = State.StartCamera.Position:Lerp(Start.Position - v1 * 11 + Vector3.new(0, 3.5, 0), (Kit.Smooth(a2 / 0.3)))
    v3 = Kit.Ease(Kit.Span(a2, 0.35, 0.55), Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    v1 = v1:Lerp(Mouth - Inward * 3, v3 * 0.7)
    v2 = Kit.Clamp(v4 + Vector3.new(0, 2, 0), v1, {a1.Character, a1.Folder})
    a1.Camera.CFrame = CFrame.lookAt(v2, v4:Lerp(Mouth + Inward * 6, 0.5 + 0.5 * v3))
    v4 = math.lerp(a1.FieldOfView, a1.FieldOfView + 10, (Kit.Smooth(a2 / 0.35)))
    a1.Camera.FieldOfView = math.lerp(v4, 40, v3)
end

local function enterPipe(a1) -- Line: 110 -- upvalues: Stage (val), Splash (val), Flash (val), Score (val), Depths (val)
    local State = a1.State
    local Depths_2 = State.Depths
    Stage.Phase(a1, "Ride")
    Splash.Jet(a1.Splash, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), 0)
    Flash.Play({Attack = 0.03, Decay = 0.14, Opacity = 0.9, Tint = Color3.fromRGB(215, 255, 225)})
    Stage.Arrive(a1)
    Score.Under(a1.Score, true, 0.05)
    Score.Stop(a1.Score, "Pour")
    Score.Play(a1.Score, "Swoosh", 0.6, 0.9)
    Score.Loop(a1.Score, "Hole", 0.45, 0.8)
    Depths_2.Model.Parent = a1.Folder
    Depths.Light(Depths_2, 3)
    State.Clanked = false
    State.Waved = false
end

local function ride(a1, a2, a3) -- Line: 127
    -- upvalues: Kit (val), Depths (val), Stage (val), Double (val), u26 (val), Score (val), Looks (val), Overlay (val)
    local v1
    local State = a1.State
    local Depths_2 = State.Depths
    local Origin = Depths_2.Origin
    local v2 = (1 - (math.exp(-a2 / 0.7))) * 52
    local v3 = Depths_2.Floor - 4 - v2
    v2 = v3 - 9
    local Double_2 = a1.Double
    local v4 = Kit.Ease(a2 / 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    Depths.Step(Depths_2, Stage.Elapsed(a1), a3, 0.4)
    local v5 = Kit.Span(a2, 0.4, 1.2)
    Depths_2.EndCap.Color = Kit.CaveGreen:Lerp(Kit.Moon, v5)
    Depths_2.Glow.Color = Depths_2.EndCap.Color
    if Double_2 then
        v1 = math.sin(a2 * 9) * 0.17453292519943295
        Double.Pose(Double_2, Double.Poses.Slide)
        Double.Place(Double_2, Origin * CFrame.new(0, v2, 0) * CFrame.Angles(3.141592653589793, a2 * 2, v1))
    end
    local Crew = State.Crew
    if Crew ~= nil and a2 >= 0.4 then
        v2 = Crew.Hands[1]
        if not State.Waved then
            State.Waved = true
            u26.Visible(v2, true)
            u26.Show(v2, "Wave")
            u26.Puff(v2, 5)
            Score.Play(a1.Score, "Giggle", 0.3, 1.1)
        end
        v1 = Depths_2.Floor - 30
        local v6 = Origin * Vector3.new(Depths_2.PipeRadius - 3.2 * (Kit.Ease((a2 - 0.4) / 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)), v1, 0)
        local v7 = math.sin(a2 * 22) * 0.4886921905584123
        u26.Place(v2, (CFrame.lookAt(v6, a1.Camera.CFrame.Position, (Vector3.new(0, 1, 0)))) * CFrame.Angles(0, 0, v7))
        Crew.LightPart.CFrame = CFrame.new(v6)
    end
    if not State.Clanked and a2 >= 0.3 then
        State.Clanked = true
        Score.Play(a1.Score, "Clank", 0.5, 0.9)
    end
    Kit.Mix(a1.Grade.Look, Looks.Flash, Looks.Pipe, v4)
    if v5 > 0 then
        Kit.Mix(a1.Grade.Look, Looks.Pipe, Looks.Haze, v5 * 0.5)
    end
    Kit.Apply(a1.Grade, 0)
    Overlay.Vignette(a1.Overlay, 0.5 * v4)
    if not a1.OwnsCamera then
        return
    end
    v5 = Kit.Ease((a2 - 0.3) / 0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local v8 = Origin * Vector3.new(0, v3, 1.5)
    a1.Camera.CFrame = (CFrame.lookAt(v8, Origin * Vector3.new(0, v3 - 30, 0))) * CFrame.Angles(0, 0, 0.6981317007977318 * v5 + math.sin(a2 * 1.3) * 0.06981317007977318)
    a1.Camera.FieldOfView = math.lerp(40, 100, v4)
end

local function enterSpit(a1) -- Line: 186 -- upvalues: Stage (val), Kit (val), Score (val), Splash (val), Overlay (val)
    local State = a1.State
    Stage.Phase(a1, "Spit")
    State.Depths.Model.Parent = nil
    local Crew = State.Crew
    if Crew ~= nil then
        Crew.Model.Parent = nil
    end
    local CFrame = a1.Root.CFrame
    local v1 = Kit.FlatUnit(CFrame.LookVector, (Vector3.new(0, 0, 1)))
    local v2 = Stage.Ground(CFrame.Position - v1 * 7, {a1.Character, a1.Folder})
    State.Geyser = v2
    local v3 = Vector3.new(v1.Z, 0, -v1.X)
    local v4 = CFrame.Position + (v1 * 0.85 + v3 * 0.5).Unit * 15 + Vector3.new(0, 4, 0)
    State.SpitCamera = Kit.Clamp(CFrame.Position + Vector3.new(0, 2, 0), v4, {a1.Character, a1.Folder})
    Score.StopAll(a1.Score)
    Score.Under(a1.Score, false, 0.05)
    Score.Play(a1.Score, "Whoosh", 0.55, 1.15)
    Score.Play(a1.Score, "Crash", 0.45, 1.2)
    Splash.Big(a1.Splash, v2)
    Overlay.Vignette(a1.Overlay, 0)
end

local function spit(a1, a2) -- Line: 212
    -- upvalues: Kit (val), Splash (val), Double (val), Looks (val)
    local State = a1.State
    local Double_2 = a1.Double
    local Geyser = State.Geyser
    local CFrame_2 = a1.Root.CFrame
    local Position = CFrame_2.Position
    local v1 = math.clamp(a2 / 0.45, 0, 1)
    local v2 = if not (v1 < 0.5) then math.max(1 - (v1 - 0.5) / 0.4, 0) else Kit.Smooth(v1 / 0.3)
    Splash.Jet(a1.Splash, Geyser, Geyser + Vector3.new(0, 12, 0), v2)
    if Double_2 then
        v2 = ((Geyser + Vector3.new(0, Double_2.Stance, 0)):Lerp(Position, v1)) + Vector3.new(0, v1 * 36 * (1 - v1), 0)
        local v3 = Kit.FlatUnit(CFrame_2.LookVector, (Vector3.new(0, 0, 1)))
        local v4 = CFrame.Angles(-6.283185307179586 * Kit.Ease(v1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), 0, 0)
        Double.Pose(Double_2, Double.Blend(Double.Poses.Cannonball, Double.Poses.Squash, Kit.Span(v1, 0.55, 1)))
        Double.Place(Double_2, CFrame.lookAt(v2, v2 + v3) * v4)
    end
    Kit.Mix(a1.Grade.Look, Looks.Haze, Looks.Clear, (Kit.Smooth(v1)))
    Kit.Apply(a1.Grade, 0)
    if not a1.OwnsCamera then
        return
    end
    local SpitCamera = State.SpitCamera
    local v5 = (Geyser:Lerp(Position, 0.5)) + Vector3.new(0, 2, 0)
    a1.Camera.CFrame = CFrame.lookAt(SpitCamera, v5)
    a1.Camera.FieldOfView = 80
end

local function land(a1) -- Line: 248 -- upvalues: Stage (val), Splash (val), Score (val), Overlay (val)
    local State = a1.State
    Stage.Phase(a1, "Settle")
    Stage.Swap(a1)
    Splash.Jet(a1.Splash, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), 0)
    Splash.Land(a1.Splash, a1.Root.Position - Vector3.new(0, 2.5, 0))
    Score.Play(a1.Score, "Pop", 0.55, 0.9)
    Score.Play(a1.Score, "ScoopShort", 0.4, 1.2)
    local Head = a1.Character:FindFirstChild("Head")
    if Head ~= nil and Head:IsA("BasePart") then
        Splash.Drips(a1.ScoreTrove, Head, 2)
    end
    Overlay.Drops(a1.Overlay, a1.Scenery, if not a1.Low then 4 else 2)
    State.SettleFrom = a1.Camera.CFrame
end

local function settle(a1, a2) -- Line: 264 -- upvalues: Stage (val), Looks (val), Kit (val) -- types: a2: number
    local State = a1.State
    local v1 = math.clamp(a2 / 0.85, 0, 1)
    local v2 = Stage.Landing(a1, a1.Zoom)
    Kit.Mix(a1.Grade.Look, Looks.Haze, Looks.Clear, 1)
    Kit.Apply(a1.Grade, 0)
    if v1 >= 1 then
        Stage.HandBack(a1, v2)
        return
    end
    if not a1.OwnsCamera then
        return
    end
    local SettleFrom = State.SettleFrom
    local v3 = Kit.Ease(v1, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    a1.Camera.CFrame = Stage.SwingFrame(a1, SettleFrom, v2, (math.clamp(v3, 0, 1.05)))
    a1.Camera.FieldOfView = math.lerp(80, a1.FieldOfView, (Kit.Smooth(v1)))
end

local function calm(a1, a2) -- Line: 283
    -- upvalues: Overlay (val), Kit (val), Looks (val), Stage (val), Score (val)
    local State = a1.State
    local Camera = a1.Camera
    local Mouth = State.Mouth
    if a1.Phase == "Calm" then
        Overlay.Waterline(a1.Overlay, Kit.Smooth(a2 / 0.7))
        Overlay.Iris(a1.Overlay, Kit.Projected(Camera, Mouth), 1 - Kit.Smooth((a2 - 0.5) / 0.5))
        Kit.Mix(a1.Grade.Look, Looks.Clear, Looks.Haze, (Kit.Smooth(a2 / 0.8)))
        Kit.Apply(a1.Grade, 0)
        if a2 >= 1 then
            Stage.Phase(a1, "CalmHold")
            Stage.Scriptable(a1)
            Stage.Arrive(a1)
            Score.Play(a1.Score, "Flush", 0.5)
        end
        return
    end
    if a1.Phase ~= "CalmHold" then
        local v1 = math.clamp(a2 / 0.9, 0, 1)
        local v2 = Stage.Landing(a1, a1.Zoom)
        if a1.OwnsCamera then
            Camera.CFrame = v2
            Camera.FieldOfView = a1.FieldOfView
        end
        Overlay.Iris(a1.Overlay, Kit.Projected(Camera, a1.Root.Position), Kit.Smooth(v1))
        Overlay.Waterline(a1.Overlay, 1 - Kit.Smooth(v1 * 1.4))
        Kit.Mix(a1.Grade.Look, Looks.Haze, Looks.Clear, (Kit.Smooth(v1)))
        Kit.Apply(a1.Grade, 0)
        if v1 >= 1 then
            if State.Failed then
                Stage.Finish(a1, false)
                return
            end
            Stage.HandBack(a1, v2)
        end
        return
    end
    Overlay.Iris(a1.Overlay, Vector2.new(0.5, 0.5), 0)
    local v3 = a1.ArriveState == "Failed"
    if v3 then
        State.Failed = v3
        Stage.Phase(a1, "CalmBack")
        if not v3 then
            Stage.Swap(a1)
        end
    elseif not (a2 >= 0.5) then
        if 8 < (Stage.Elapsed(a1)) then
            State.Failed = v3
            Stage.Phase(a1, "CalmBack")
            if not v3 then
                Stage.Swap(a1)
            end
        end
    elseif Stage.Settled(a1) or 8 < (Stage.Elapsed(a1)) then
        State.Failed = v3
        Stage.Phase(a1, "CalmBack")
        if not v3 then
            Stage.Swap(a1)
        end
    end
end

local function step(a1, a2) -- Line: 331
    -- upvalues: Stage (val), calm (val), suction (val), enterPipe (val), ride (val), enterSpit (val), spit (val)
    -- upvalues: Score (val), Double (val), land (val), settle (val)
    local v1 = Stage.Since(a1)
    if a1.Calm then
        calm(a1, v1)
        return
    end
    if a1.Phase == "Suction" then
        suction(a1, v1)
        if v1 >= 0.55 then
            enterPipe(a1)
            ride(a1, 0, a2)
        end
        return
    end
    if a1.Phase ~= "Ride" then
        if a1.Phase == "Spit" then
            spit(a1, v1)
            if v1 >= 0.45 then
                land(a1)
                settle(a1, 0)
            end
            return
        end
        if a1.Phase == "Settle" then
            settle(a1, v1)
        end
        return
    end
    if a1.ArriveState == "Failed" then
        Stage.Bail(a1)
        return
    end
    ride(a1, v1, a2)
    if v1 >= 0.85 and Stage.Settled(a1) then
        enterSpit(a1)
        spit(a1, 0)
        return
    end
    if 6.55 < (Stage.Elapsed(a1)) then
        a1.State.Failed = a1.ArriveState ~= "Arrived"
        a1.Calm = true
        Stage.Phase(a1, "CalmBack")
        Score.StopAll(a1.Score)
        a1.State.Depths.Model.Parent = nil
        if a1.Double then
            Double.Visible(a1.Double, false)
        end
    end
end

local function prepare(a1) -- Line: 380 -- upvalues: mouthOf (val), u26 (val), Depths (val), u56 (val), Stage (val)
    local State = a1.State
    local v1, v2 = mouthOf(a1)
    State.Mouth = v1
    State.Inward = v2
    State.StartCamera = a1.Camera.CFrame
    local Double = a1.Double
    local CFrame = if not Double then a1.Root.CFrame else Double.Root.CFrame
    State.Start = CFrame
    State.Crew = u26.Build(a1.Scenery, a1.Folder, 1, 4.6)
    if not a1.Calm then
        v2 = Depths.Build(a1.Scenery, a1.Folder, u56, true)
        v2.Model.Parent = nil
        State.Depths = v2
        Stage.Scriptable(a1)
    end
end

function v1.Run(a1) -- Line: 401 -- upvalues: Stage (val), prepare (val), Score (val), step (val)
    local v1 = Stage.Begin("Exit", a1)
    if v1 == nil or not Stage.Prepare(v1, prepare) then
        return Stage.Fallback(a1)
    end
    Stage.Phase(v1, if not v1.Calm then "Suction" else "Calm")
    Score.Duck(v1.Score, true, 0.3)
    Score.Play(v1.Score, "Flush", 0.55)
    Score.Play(v1.Score, "Suck", 0.3, 1.1)
    if not v1.Calm then
        Score.Loop(v1.Score, "Pour", 0.4, 0.7)
    end
    Stage.Bind(v1, step)
    return Stage.Wait(v1)
end

return table.freeze(v1)