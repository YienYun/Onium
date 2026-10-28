-- Script path: ReplicatedStorage.Client.UI.VFX.EasyVisuals.VisibilityGate
-- Decompile time: 2.14 ms

local u0 = {ScreenGui = "Enabled", BillboardGui = "Enabled", SurfaceGui = "Enabled"}
return table.freeze({
    Watch = function(a1, a2, a3) -- Line: 26 -- upvalues: u0 (val) -- types: a1: userdata, a2: function, a3: function
        if typeof(a1) == "Instance" and a1:IsA("GuiBase") then
            local u82 = {}
            local u11 = nil

            local function shiftHidden(a1) -- Line: 34 -- upvalues: u11 (ref), a2 (val), a3 (val) -- types: a1: number
                local v1 = u11
                v1.hidden = v1.hidden + a1
                if 0 < u11.hidden and not u11.isMuted then
                    u11.isMuted = true
                    a2()
                    return
                end
                if u11.hidden == 0 and u11.isMuted then
                    u11.isMuted = false
                    a3()
                end
            end

            u11 = {
                hidden = 0,
                isMuted = false,
                links = u82,
                Destroy = function() -- Line: 50 -- upvalues: u82 (val), u11 (ref)
                    for i, v in ipairs(u82) do
                        v:Disconnect()
                    end
                    table.clear(u11)
                end,
            }
            local Parent = a1
            while Parent do
                if not Parent:IsA("GuiBase") then
                    break
                end
                local u22 = Parent
                local u31 = u0[u22.ClassName]
                if not u31 then
                    u31 = if not u22:IsA("GuiObject") then nil else "Visible"
                end
                if u31 then
                    if not u22[u31] then
                        u11.hidden = u11.hidden + 1
                        if not (0 < u11.hidden) then
                            if u11.hidden == 0 and u11.isMuted then
                                u11.isMuted = false
                                a3()
                            end
                        elseif not u11.isMuted then
                            u11.isMuted = true
                            a2()
                        elseif u11.hidden == 0 and u11.isMuted then
                            u11.isMuted = false
                            a3()
                        end
                    end
                    u82[#u82 + 1] = ((u22:GetPropertyChangedSignal(u31)):Connect(function() -- Line: 70 -- upvalues: u22 (val), u31 (val), u11 (ref), a2 (val), a3 (val)
                        local v1 = if not u22[u31] then 1 else -1
                        local v2 = u11
                        v2.hidden = v2.hidden + v1
                        if 0 < u11.hidden and not u11.isMuted then
                            u11.isMuted = true
                            a2()
                            return
                        end
                        if u11.hidden == 0 and u11.isMuted then
                            u11.isMuted = false
                            a3()
                        end
                    end))
                end
                Parent = u22.Parent
            end
            return u11
        end
        return nil
    end,
})