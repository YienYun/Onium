-- Script path: ReplicatedStorage.Controllers.Game.WorkspaceRainbowPartsController
-- Decompile time: 8.03 ms

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local u20 = require(ReplicatedStorage.Packages.Log).new()
return {
    Start = function() -- Line: 32 -- upvalues: u20 (val), CollectionService (val), ReplicatedStorage (val), RunService (val)
        local v1, v2, v3, v4
        local u0 = {}
        local u125 = {}
        local u2 = {}
        local u3 = 1
        local u4 = 0
        local u5 = false
        local u6 = 0
        local u7 = 1
        local u9 = os.clock()

        local function getTargetColor(a1) -- Line: 44 -- types: a1: userdata
            if a1:IsA("BasePart") then
                return a1.Color
            end
            return a1.Color
        end

        local function setTargetColor(a1, a2) -- Line: 51 -- types: a1: userdata, a2: userdata
            if a1:IsA("BasePart") then
                a1.Color = a2
                return
            end
            a1.Color = a2
        end

        local function getOriginalHsv(a1) -- Line: 59 -- types: a1: userdata
            local Attribute = a1:GetAttribute("OriginalColor")
            if typeof(Attribute) == "Vector3" then
                return Attribute
            end
            local v1, v2, v3 = Color3.toHSV(if not a1:IsA("BasePart") then a1.Color else a1.Color)
            local v4 = Vector3.new(v1, v2, v3)
            a1:SetAttribute("OriginalColor", v4)
            return v4
        end

        local function addTarget(a1) -- Line: 71 -- upvalues: u125 (val), u0 (val) -- types: a1: userdata
            if u125[a1] ~= nil then
                return
            end
            if typeof((a1:GetAttribute("OriginalColor"))) ~= "Vector3" then
                local v1, v2, v3 = Color3.toHSV(if not a1:IsA("BasePart") then a1.Color else a1.Color)
                a1:SetAttribute("OriginalColor", (Vector3.new(v1, v2, v3)))
            end
            table.insert(u0, a1)
            u125[a1] = #u0
        end

        local function removeTarget(a1) -- Line: 81
            -- upvalues: u125 (val), u20 (upval), u0 (val), u7 (ref)
            local v1
            local v2 = u125[a1]
            if v2 == nil then
                (u20:AtWarning()):Log((("Rainbow target %* not found in active targets."):format((a1:GetFullName()))))
                return
            end
            local Attribute = a1:GetAttribute("OriginalColor")
            if typeof(Attribute) == "Vector3" then
                v1 = Color3.fromHSV(Attribute.X, Attribute.Y, Attribute.Z)
                if not a1:IsA("BasePart") then end
                a1.Color = v1
            end
            v1 = u0[#u0]
            u0[v2] = v1
            u125[v1] = v2
            table.remove(u0)
            u125[a1] = nil
            local v3 = u7
            if #u0 < v3 then
                u7 = 1
            end
        end

        local function drainQueue() -- Line: 105
            -- upvalues: u3 (ref), u4 (ref), u2 (val), u125 (val), u0 (val), removeTarget (val), u5 (ref)
            local Target, v1, v2, v3, v4
            while u3 <= u4 do
                v1 = u2[u3]
                u3 = u3 + 1
                if not v1.Add then
                    removeTarget(v1.Target)
                else
                    Target = v1.Target
                    if u125[Target] == nil then
                        if typeof((Target:GetAttribute("OriginalColor"))) ~= "Vector3" then
                            v2, v3, v4 = Color3.toHSV(if not Target:IsA("BasePart") then Target.Color else Target.Color)
                            Target:SetAttribute("OriginalColor", (Vector3.new(v2, v3, v4)))
                        end
                        table.insert(u0, Target)
                        u125[Target] = #u0
                    end
                end
            end
            table.clear(u2)
            u3 = 1
            u4 = 0
            u5 = false
        end

        local function enqueue(a1, a2) -- Line: 122
            -- upvalues: u4 (ref), u2 (val), u5 (ref), drainQueue (val)
            u4 = u4 + 1
            local v1 = u4
            u2[v1] = {Target = a1, Add = a2}
            if u5 then
                return
            end
            u5 = true
            task.defer(drainQueue)
        end

        local function requireRainbowTarget(a1) -- Line: 136 -- types: a1: userdata
            local v1 = ("RainbowPart tag requires a BasePart or SurfaceAppearance, got %*"):format(a1.ClassName)
            assert(a1:IsA("BasePart") or a1:IsA("SurfaceAppearance"), v1)
            return a1
        end

        local function preRender(a1) -- Line: 144
            -- upvalues: u6 (ref), u0 (val), u9 (val), u7 (ref)
            local Attribute, Y, Z, v1, v2, v3, v4, v5, v6
            u6 = math.min(u6 + math.min(a1, 0.06666666666666667), 0.25)
            if u6 < 0.05 then
                return
            end
            u6 = u6 - 0.05
            local v7 = #u0
            if v7 == 0 then
                return
            end
            debug.profilebegin("WorkspaceRainbowParts :: PreRender")
            local v8 = (os.clock() - u9) * 0.5 % 1
            local v9 = math.min(u7 + 50 - 1, v7)
            for i = u7, v9 do
                v4 = u0[i]
                if v4.Parent ~= nil then
                    Attribute = v4:GetAttribute("OriginalColor")
                    if typeof(Attribute) ~= "Vector3" then
                        v1, v2, v3 = Color3.toHSV(if not v4:IsA("BasePart") then v4.Color else v4.Color)
                        v6 = Vector3.new(v1, v2, v3)
                        v4:SetAttribute("OriginalColor", v6)
                        v5 = v6
                    else
                        v5 = Attribute
                    end
                    Y = v5.Y
                    Z = v5.Z
                    if Y <= 0.05 then
                        Y = 1
                        if Z >= 0.9725490196078431 then
                            Z = 1
                        end
                    end
                    v5 = v4:GetAttribute("RainbowOffset")
                    v3 = Color3.fromHSV(if type(v5) ~= "number" then v8 else (v8 + v5) % 1, Y, Z)
                    if not v4:IsA("BasePart") then end
                    v4.Color = v3
                end
            end
            u7 = v9 + 1
            if v7 < u7 then
                u7 = 1
            end
            debug.profileend()
        end

        ;(CollectionService:GetInstanceAddedSignal("RainbowPart")):Connect(function(a1) -- Line: 187
            -- upvalues: ReplicatedStorage (upval), u4 (ref), u2 (val), u5 (ref), drainQueue (val)
            if a1:IsDescendantOf(ReplicatedStorage) then
                return
            end
            local v1 = ("RainbowPart tag requires a BasePart or SurfaceAppearance, got %*"):format(a1.ClassName)
            assert(a1:IsA("BasePart") or a1:IsA("SurfaceAppearance"), v1)
            u4 = u4 + 1
            local v2 = u4
            u2[v2] = {Add = true, Target = a1}
            if u5 then
                return
            end
            u5 = true
            task.defer(drainQueue)
        end)
        ;(CollectionService:GetInstanceRemovedSignal("RainbowPart")):Connect(function(a1) -- Line: 194
            -- upvalues: ReplicatedStorage (upval), u4 (ref), u2 (val), u5 (ref), drainQueue (val)
            if a1:IsDescendantOf(ReplicatedStorage) then
                return
            end
            local v1 = ("RainbowPart tag requires a BasePart or SurfaceAppearance, got %*"):format(a1.ClassName)
            assert(a1:IsA("BasePart") or a1:IsA("SurfaceAppearance"), v1)
            u4 = u4 + 1
            local v2 = u4
            u2[v2] = {Add = false, Target = a1}
            if u5 then
                return
            end
            u5 = true
            task.defer(drainQueue)
        end)
        for i, j in CollectionService:GetTagged("RainbowPart") do
            v2 = ReplicatedStorage
            if not j:IsDescendantOf(v2) then
                v2 = j:IsA("BasePart") or j:IsA("SurfaceAppearance")
                assert(v2, (("RainbowPart tag requires a BasePart or SurfaceAppearance, got %*"):format(j.ClassName)))
                v1 = j
                if u125[v1] == nil then
                    if typeof((v1:GetAttribute("OriginalColor"))) ~= "Vector3" then
                        v2, v3, v4 = Color3.toHSV(if not v1:IsA("BasePart") then v1.Color else v1.Color)
                        v1:SetAttribute("OriginalColor", (Vector3.new(v2, v3, v4)))
                    end
                    table.insert(u0, v1)
                    u125[v1] = #u0
                end
            end
        end
        RunService.PreRender:Connect(preRender)
    end,
}