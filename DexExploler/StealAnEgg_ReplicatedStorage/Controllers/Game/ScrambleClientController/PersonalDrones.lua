-- Script path: ReplicatedStorage.Controllers.Game.ScrambleClientController.PersonalDrones
-- Decompile time: 5.47 ms

local Players = game:GetService("Players")
return {
    new = function(a1, a2, a3) -- Line: 5 -- upvalues: Players (val) -- types: a1: userdata, a2: function, a3: function
        local u3 = {}
        local u4 = {}
        local u5 = {}
        local u6 = -1
        local u7 = false
        local u8 = {}

        local function discard(a1) -- Line: 10 -- upvalues: u5 (val), a3 (val) -- types: a1: string
            local v1 = u5[a1]
            if v1 then
                a3(v1)
                v1:Destroy()
                u5[a1] = nil
            end
        end

        local function update(a1, a2) -- Line: 14 -- types: a1: userdata
            for i, j in a2.Attributes do
                a1:SetAttribute(i, j)
            end
            local Hitbox = a1.Hitbox
            local Hitbox_2 = a1.Hitbox
            local CFrame = a2.CFrame
            local Size = a2.Size
            Hitbox.CFrame = CFrame
            Hitbox_2.Size = Size
            a1.Hitbox:SetAttribute("MaxHealth", a2.MaxHealth)
            a1.Hitbox:SetAttribute("Health", a2.Health)
        end

        function u3.Apply(a1) -- Line: 20
            -- upvalues: Players (upval), u6 (ref), u7 (ref), u8 (val), u4 (val), u5 (val), a3 (val), update (val)
            -- upvalues: u3 (val)
            if type(a1) == "table"
                and a1.OwnerUserId == Players.LocalPlayer.UserId
                and type(a1.Revision) == "number"
                and not (a1.Revision <= u6) then
                local v1, v2, v3, v4
                if not u7 and not a1.Full then
                    u8[a1.Revision] = a1
                    return
                end
                u7 = true
                u6 = a1.Revision
                if not a1.Full then
                    v1 = a1
                else
                    local v5
                    v2 = {}
                    for i, j in a1.Upserts do
                        v2[j.Id] = true
                    end
                    v3 = nil
                    local v6 = nil
                    v1 = a1
                    for k in u4, v3, v6 do
                        if not v2[k] then
                            v5 = u5[k]
                            if v5 then
                                a3(v5)
                                v5:Destroy()
                                u5[k] = nil
                            end
                            u4[k] = nil
                        end
                    end
                end
                local Removed = v1.Removed or {}
                local v7 = nil
                v3 = nil
                for n, m in Removed, v7, v3 do
                    v4 = u5[m]
                    if v4 then
                        a3(v4)
                        v4:Destroy()
                        u5[m] = nil
                    end
                    u4[m] = nil
                end
                for i5, i6 in v1.Upserts or {} do
                    if i6.OwnerUserId == Players.LocalPlayer.UserId then
                        u4[i6.Id] = i6
                        if u5[i6.Id] then
                            update(u5[i6.Id], i6)
                        end
                    end
                end
                if next(u8) then
                    v2 = {}
                    for i7, i8 in u8 do
                        table.insert(v2, i8)
                    end
                    table.clear(u8)
                    table.sort(v2, function(a1, a2) -- Line: 45
                        return a1.Revision < a2.Revision
                    end)
                    for i9, i10 in v2 do
                        u3.Apply(i10)
                    end
                end
                return
            end
        end

        function u3.Tick() -- Line: 49 -- upvalues: u4 (val), u5 (val), a3 (val), update (val), a1 (val), a2 (val)
            local Magnitude, Model, Part, v1, v2
            local CurrentCamera = workspace.CurrentCamera
            if not CurrentCamera then
                return
            end
            local v3 = workspace:GetServerTimeNow()
            local v4 = {}
            local v5 = nil
            local v6 = nil
            for i, j in u4, v5, v6 do
                if not j.ExpiresAt or not (j.ExpiresAt <= v3) then
                    Magnitude = (CurrentCamera.CFrame.Position - j.CFrame.Position).Magnitude
                    if Magnitude <= 180 then
                        table.insert(v4, {Id = i, Distance = Magnitude})
                    end
                else
                    v2 = u5[i]
                    if v2 then
                        a3(v2)
                        v2:Destroy()
                        u5[i] = nil
                    end
                    u4[i] = nil
                end
            end
            table.sort(v4, function(a1, a2) -- Line: 60
                return a1.Distance < a2.Distance
            end)
            v3 = {}
            for k = 1, (math.min(32, #v4)) do
                v3[v4[k].Id] = true
            end
            for n in u5 do
                if not v3[n] then
                    v4 = u5[n]
                    if v4 then
                        a3(v4)
                        v4:Destroy()
                        u5[n] = nil
                    end
                end
            end
            for m in v3 do
                if not u5[m] then
                    v1 = u4[m]
                    Model = Instance.new("Model")
                    Model.Name = "PersonalDrone_" .. m
                    Part = Instance.new("Part")
                    Part.Name = "Hitbox"
                    Part.Anchored = true
                    Part.Transparency = 1
                    Part.CanCollide = false
                    Part.CanTouch = false
                    Part.CanQuery = false
                    Part.Parent = Model
                    Model.PrimaryPart = Part
                    update(Model, v1)
                    Model.Parent = a1
                    u5[m] = Model
                    a2(Model)
                end
            end
        end

        function u3.Ready() -- Line: 81 -- upvalues: u7 (ref)
            return u7
        end

        function u3.Destroy() -- Line: 82 -- upvalues: u5 (val), a3 (val), u4 (val)
            local v1
            for i in u5 do
                v1 = u5[i]
                if v1 then
                    a3(v1)
                    v1:Destroy()
                    u5[i] = nil
                end
            end
            table.clear(u4)
        end

        return u3
    end,
}