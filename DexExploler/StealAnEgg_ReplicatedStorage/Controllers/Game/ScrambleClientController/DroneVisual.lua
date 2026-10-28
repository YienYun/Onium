-- Script path: ReplicatedStorage.Controllers.Game.ScrambleClientController.DroneVisual
-- Decompile time: 10.29 ms

local ScrambleDroneMotion = require(game.ReplicatedStorage.Shared.Util.ScrambleDroneMotion)
return {
    new = function(a1, a2, a3) -- Line: 6
        -- upvalues: ScrambleDroneMotion (val)
        local err, success, v1, v2
        local v3 = a2:Clone()
        local u167 = {}
        local Hitbox_2 = v3:FindFirstChild("Hitbox")
        if Hitbox_2 then
            Hitbox_2:Destroy()
        end
        v3.Name = "DroneVisual_" .. tostring((a1:GetAttribute("ScrambleDroneId")))
        for i, j in v3:GetDescendants() do
            if j:IsA("BasePart") then
                v1 = j == v3.PrimaryPart
                j.Anchored = v1
                j.CanCollide = false
                j.CanTouch = false
                j.CanQuery = false
                j.Massless = true
                j.LocalTransparencyModifier = 1
                table.insert(u167, j)
            end
        end
        local v4 = ScrambleDroneMotion.Read(a1)
        if v4 then
            v3:PivotTo(v4.From)
        end
        v3.Parent = a3
        local u149 = {Visible = false, Transparency = 1, Rig = v3, Root = v3.PrimaryPart}
        u149.Tracks = {}
        u149.State = ScrambleDroneMotion.Read(a1)
        local Animator = v3.AnimationController.Animator
        for k, n in v3.Animations:GetChildren() do
            if n:IsA("Animation") then
                success, err = pcall(Animator.LoadAnimation, Animator, n)
                if not success then
                    warn("[Scramble] animation failed", n.AnimationId, err)
                else
                    v2 = true
                    if n.Name ~= "Idle" then
                        v2 = n.Name == "Walk"
                    end
                    err.Looped = v2
                    err.Priority = if n.Name ~= "Death" then if n.Name ~= "Attack" then Enum.AnimationPriority.Movement else Enum.AnimationPriority.Action else Enum.AnimationPriority.Action4
                    u149.Tracks[n.Name] = err
                end
            end
        end
        local Hitbox = a1:FindFirstChild("Hitbox")

        local function latchDeath(a1) -- Line: 54 -- upvalues: u149 (val), a2 (val)
            if u149.Dead then
                return
            end
            u149.Dead = true
            u149.Velocity = Vector3.new(0, 0, 0)
            local v1 = u149
            u149.Recoil = Vector3.new(0, 0, 0)
            v1.RecoilVelocity = Vector3.new(0, 0, 0)
            local AnimationAt = if not a1 then workspace:GetServerTimeNow() else if a1.Name ~= "Death" then workspace:GetServerTimeNow() else a1.AnimationAt
            local CFrame = u149.Root.CFrame
            u149.State = {
                Name = "Death",
                At = AnimationAt,
                AnimationAt = AnimationAt,
                Duration = a2.Animations.Death:GetAttribute("Duration") or 3,
                From = CFrame,
                To = CFrame,
            }
        end

        local function acceptState(a1_2) -- Line: 72 -- upvalues: a1 (val), Hitbox (val), latchDeath (val), u149 (val)
            local v1
            if not a1_2 then
                v1 = true
                if a1:GetAttribute("DroneState") ~= "Death" then
                    v1 = Hitbox and (Hitbox:GetAttribute("Health") or 1) <= 0
                end
            else
                v1 = true
                if a1_2.Name ~= "Death" then
                    v1 = true
                    if a1:GetAttribute("DroneState") ~= "Death" then
                        v1 = Hitbox and (Hitbox:GetAttribute("Health") or 1) <= 0
                    end
                end
            end
            if v1 then
                latchDeath(a1_2)
                return
            end
            if not u149.Dead and a1_2 then
                if not u149.State or u149.State.At <= a1_2.At then
                    u149.State = a1_2
                end
            end
        end

        local function readState() -- Line: 82 -- upvalues: acceptState (val), ScrambleDroneMotion (upval), a1 (val)
            acceptState(ScrambleDroneMotion.Read(a1))
        end

        function u149.ReceiveHit(a1, a2) -- Line: 83 -- upvalues: ScrambleDroneMotion (upval), acceptState (val)
            local v1 = ScrambleDroneMotion.Decode(a2)
            acceptState(v1)
            if not a1.Dead and v1 then
                if a1.State and v1.At < a1.State.At then
                    return
                end
                if v1.Name == "Knockback" and v1.At ~= a1.LastImpactAt then
                    a1.LastImpactAt = v1.At
                    local v2 = v1.To.Position - v1.From.Position
                    v2 = Vector3.new(v2.X, 0, v2.Z)
                    if 0.01 < v2.Magnitude then
                        local Unit = v2.Unit
                        local v3 = Vector3.new(0, 1, 0):Cross(Unit)
                        local v4 = (a1.RecoilVelocity or Vector3.new(0, 0, 0)) + v3 * 3.3
                        a1.RecoilVelocity = if not (4.8 < v4.Magnitude) then v4 else v4.Unit * 4.8
                    end
                end
                return
            end
        end

        u149.Connection = (a1:GetAttributeChangedSignal("DroneMotion")):Connect(readState)
        u149.DeathConnection = (a1:GetAttributeChangedSignal("DroneState")):Connect(readState)
        local v5 = Hitbox and (Hitbox:GetAttributeChangedSignal("Health")):Connect(readState)
        u149.HealthConnection = v5
        acceptState(ScrambleDroneMotion.Read(a1))

        function u149.Step(a1, a2, a3, a4) -- Line: 106
            -- upvalues: ScrambleDroneMotion (upval), u167 (val)
            local v1, v2, v3, v4, v5, v6, v7
            local State = a1.State
            local v8 = if not a4 then 1 else 0
            if a4 and State and State.Name == "Death" then
                v4 = math.clamp((a3 - State.AnimationAt - State.Duration) / ScrambleDroneMotion.DeathFadeSeconds, 0, 1)
                v8 = v4 * v4 * (3 - v4 * 2)
            end
            if a1.Transparency ~= v8 then
                a1.Transparency = v8
                for i, j in u167 do
                    j.LocalTransparencyModifier = v8
                end
            end
            local Presented_2 = ScrambleDroneMotion.Pose(State, a2, a3)
            v4 = math.max(0, a3 - (a1.LastStepAt or a3))
            a1.LastStepAt = a3
            if not State then
                if not a4 or not a1.Visible or not a1.Presented then
                    a1.Presented = Presented_2
                    a1.Velocity = Vector3.new(0, 0, 0)
                elseif not (v4 > 0.25) then
                    v5 = a1.Presented.Position - Presented_2.Position
                    v6 = a1.Velocity or Vector3.new(0, 0, 0)
                    v7 = v6 + v5 * 12
                    v1 = math.exp(v4 * -12)
                    v2 = Presented_2.Position + (v5 + v7 * v4) * v1
                    a1.Velocity = (v6 - v7 * 12 * v4) * v1
                    v3 = a1.Presented.Rotation:Lerp(Presented_2.Rotation, 1 - v1)
                    a1.Presented = CFrame.new(v2) * v3
                    Presented_2 = a1.Presented
                else
                    a1.Presented = Presented_2
                    a1.Velocity = Vector3.new(0, 0, 0)
                end
            elseif State.Name == "Death" or not a4 or not a1.Visible or not a1.Presented then
                a1.Presented = Presented_2
                a1.Velocity = Vector3.new(0, 0, 0)
            elseif not (v4 > 0.25) then
                v5 = a1.Presented.Position - Presented_2.Position
                v6 = a1.Velocity or Vector3.new(0, 0, 0)
                v7 = v6 + v5 * 12
                v1 = math.exp(v4 * -12)
                v2 = Presented_2.Position + (v5 + v7 * v4) * v1
                a1.Velocity = (v6 - v7 * 12 * v4) * v1
                v3 = a1.Presented.Rotation:Lerp(Presented_2.Rotation, 1 - v1)
                a1.Presented = CFrame.new(v2) * v3
                Presented_2 = a1.Presented
            else
                a1.Presented = Presented_2
                a1.Velocity = Vector3.new(0, 0, 0)
            end
            if a1.Dead or not a4 or not (v4 <= 0.25) then
                a1.Recoil = Vector3.new(0, 0, 0)
                a1.RecoilVelocity = Vector3.new(0, 0, 0)
            else
                v5 = a1.Recoil or Vector3.new(0, 0, 0)
                v6 = a1.RecoilVelocity or Vector3.new(0, 0, 0)
                v7 = v6 + v5 * 11
                v1 = math.exp(v4 * -11)
                v5 = (v5 + v7 * v4) * v1
                a1.RecoilVelocity = (v6 - v7 * 11 * v4) * v1
                a1.Recoil = v5
                local Magnitude = v5.Magnitude
                if Magnitude > 0.0001 then
                    Presented_2 = (CFrame.new(Presented_2.Position)) * CFrame.fromAxisAngle(v5.Unit, (math.min(Magnitude, 0.20943951023931956))) * Presented_2.Rotation
                end
            end
            local Name = if State then if State.Name ~= "Knockback" then if State.Name == "Chase" then "Walk" else if State.Name ~= "Return" then State.Name else "Walk" else "Idle" else "Idle"
            v5 = if Name == "Idle" then Name else if Name ~= "Walk" then Name .. ":" .. tostring(State and State.AnimationAt or 0) else Name
            if a4 then
                if a1.LastAnimation ~= v5 then
                    v7 = nil
                    v1 = nil
                    for k, n in a1.Tracks, v7, v1 do
                        if k ~= Name then
                            n:Stop(0.12)
                        end
                    end
                    v6 = a1.Tracks[Name]
                    if v6 then
                        v6:Play(0.12, 1, 1)
                        a1.SyncTrack = v6
                        v1 = 0
                        v7 = math.max(v1, a3 - (State and State.AnimationAt or a3))
                        if 0 < v6.Length then
                            a1.SyncTrack = nil
                            v1 = if not v6.Looped then math.min(v7, (math.max(0, v6.Length - 0.02))) else v7 % v6.Length
                            v6.TimePosition = v1
                        end
                    end
                    a1.LastAnimation = v5
                end
            elseif a1.Visible then
                for m, i5 in a1.Tracks do
                    i5:Stop(0)
                end
                a1.LastAnimation = nil
            end
            local SyncTrack = a1.SyncTrack
            if a4 and SyncTrack and 0 < SyncTrack.Length then
                v6 = math.max(0, a3 - (State and State.AnimationAt or a3))
                v7 = if not SyncTrack.Looped then math.min(v6, (math.max(0, SyncTrack.Length - 0.02))) else v6 % SyncTrack.Length
                SyncTrack.TimePosition = v7
                a1.SyncTrack = nil
            end
            a1.Visible = a4
            local Death = a1.Tracks.Death
            if a4 and Name == "Death" and Death and 0 < Death.Length then
                v6 = a3 - State.AnimationAt
                if Death.Length - 0.08 <= v6 then
                    if not Death.IsPlaying then
                        Death:Play(0, 1, 1)
                    end
                    Death.TimePosition = math.max(0, Death.Length - 0.03)
                    Death:AdjustSpeed(0)
                end
            end
            return Presented_2
        end

        function u149:Destroy() -- Line: 219
            self.Connection:Disconnect()
            self.DeathConnection:Disconnect()
            if self.HealthConnection then
                self.HealthConnection:Disconnect()
            end
            for i, j in self.Tracks do
                j:Stop(0)
                j:Destroy()
            end
            self.Rig:Destroy()
        end

        return u149
    end,
}