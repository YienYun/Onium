-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ScrambleBoss.Rider
-- Decompile time: 1.61 ms

local RunService = game:GetService("RunService")
return {
    Mount = function(a1, a2) -- Line: 14 -- upvalues: RunService (val) -- types: a2: userdata
        local u2 = true
        a1:Add(function() -- Line: 16 -- upvalues: u2 (ref)
            u2 = false
        end)
        task.spawn(function() -- Line: 20 -- upvalues: a2 (val), u2 (ref), a1 (val), RunService (upval)
            local PrimaryPart = a2.PrimaryPart
            if not PrimaryPart then
                PrimaryPart = a2:WaitForChild("RootPart", 5)
            end
            local RiderFollow = PrimaryPart
            if RiderFollow then
                RiderFollow = PrimaryPart:WaitForChild("RiderFollow", 5)
            end
            if u2 and PrimaryPart ~= nil and RiderFollow ~= nil then
                local Attribute = RiderFollow:GetAttribute("FollowBone")
                local u30 = if typeof(Attribute) ~= "string" then nil else PrimaryPart:FindFirstChild(Attribute, true)
                if u30 == nil then
                    return
                end
                local u48 = (PrimaryPart.CFrame:ToObjectSpace(u30.WorldCFrame):Inverse()) * RiderFollow.C0 * RiderFollow.C1:Inverse()
                a1:Connect(RunService.PreSimulation, function() -- Line: 39 -- upvalues: a2 (upval), RiderFollow (val), PrimaryPart (val), u30 (val), u48 (val)
                    if a2.Parent ~= nil and RiderFollow.Parent == PrimaryPart then
                        local v1 = u30.TransformedWorldCFrame * u48
                        RiderFollow.Transform = (RiderFollow.C0:Inverse()) * PrimaryPart.CFrame:ToObjectSpace(v1) * RiderFollow.C1
                        return
                    end
                end)
                return
            end
        end)
    end,
}