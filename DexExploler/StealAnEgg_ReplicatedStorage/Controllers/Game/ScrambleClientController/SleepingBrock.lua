-- Script path: ReplicatedStorage.Controllers.Game.ScrambleClientController.SleepingBrock
-- Decompile time: 2.67 ms

return {
    new = function() -- Line: 4
        local u0 = nil
        local u1 = nil
        local u2 = false
        local u3 = false
        local u4 = false

        local function clear() -- Line: 10 -- upvalues: u1 (ref), u0 (ref), u2 (ref), u4 (ref)
            if u1 then
                u1:Stop(0)
                u1:Destroy()
                u1 = nil
            end
            u0 = nil
            u2 = false
            u4 = false
        end

        return {
            Tick = function(a1) -- Line: 15 -- upvalues: u0 (ref), u1 (ref), u2 (ref), u4 (ref), u3 (ref) -- types: a1: boolean
                local DrScrambleEvent = workspace:FindFirstChild("DrScrambleEvent")
                local Brock = DrScrambleEvent and DrScrambleEvent:FindFirstChild("Brock")
                if Brock ~= u0 then
                    if u1 then
                        u1:Stop(0)
                        u1:Destroy()
                        u1 = nil
                    end
                    u0 = nil
                    u2 = false
                    u4 = false
                    u0 = if not Brock then nil else if not Brock:IsA("Model") then nil else Brock
                end
                local u35 = u0
                if u35 and u35.PrimaryPart then
                    local v1 = u35:FindFirstChildOfClass("Humanoid")
                    local Animator = v1
                    if Animator then
                        Animator = v1:FindFirstChildOfClass("Animator")
                    end
                    local ScrambleSleeping = v1
                    if ScrambleSleeping then
                        ScrambleSleeping = v1:FindFirstChild("ScrambleSleeping")
                    end
                    if not u1
                        and not u3
                        and not u4
                        and Animator
                        and ScrambleSleeping
                        and ScrambleSleeping:IsA("Animation") then
                        u3 = true
                        task.spawn(function() -- Line: 26
                            -- upvalues: Animator (val), ScrambleSleeping (val), u3 (upval), u4 (upval), u0 (upval)
                            -- upvalues: u35 (val), u1 (upval)
                            local success, err = pcall(Animator.LoadAnimation, Animator, ScrambleSleeping)
                            u3 = false
                            if not success then
                                u4 = u0 == u35
                                warn("[Scramble] Brock sleeping animation failed:", err)
                                return
                            end
                            if u0 == u35 and u35:IsDescendantOf(workspace) then
                                err.Looped = true
                                err.Priority = Enum.AnimationPriority.Action
                                u1 = err
                                return
                            end
                            err:Destroy()
                        end)
                    end
                    local CurrentCamera = workspace.CurrentCamera
                    local v2 = a1
                    if v2 then
                        v2 = false
                        if CurrentCamera ~= nil then
                            v2 = (CurrentCamera.CFrame.Position - u35:GetPivot().Position).Magnitude <= 160
                        end
                    end
                    if u1 and v2 ~= u2 then
                        u2 = v2
                        if v2 then
                            u1:Play(0.2)
                            return
                        end
                        u1:Stop(0.2)
                    end
                    return
                end
            end,
            Destroy = function() -- Line: 43 -- upvalues: u1 (ref), u0 (ref), u2 (ref), u4 (ref)
                if u1 then
                    u1:Stop(0)
                    u1:Destroy()
                    u1 = nil
                end
                u0 = nil
                u2 = false
                u4 = false
            end,
        }
    end,
}