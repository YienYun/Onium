-- Script path: ReplicatedStorage.Controllers.Game.Tools.GravityDisruptorUnplacePromptController
-- Decompile time: 5.67 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Constants_2 = require(ReplicatedStorage.Shared.Globals.Constants)
local LocalPlayer = Players.LocalPlayer
local UNPLACE_PROMPT = Constants_2.TAGS_MAP.GravityDisruptors.UNPLACE_PROMPT
local u24 = {}
return {
    Start = function() -- Line: 28 -- upvalues: u24 (val), LocalPlayer (val), CollectionService (val), UNPLACE_PROMPT (val)
        local function cleanupPromptConnections(a1) -- Line: 30 -- upvalues: u24 (upval) -- types: a1: userdata
            local v1 = u24[a1]
            if not v1 then
                return
            end
            local Owner = v1.Owner
            if Owner then
                Owner:Disconnect()
            end
            local Active = v1.Active
            if Active then
                Active:Disconnect()
            end
            u24[a1] = nil
        end

        local function updatePromptEnabled(a1) -- Line: 49 -- upvalues: LocalPlayer (upval) -- types: a1: userdata
            local Parent = a1.Parent
            if Parent and Parent:IsA("BasePart") then
                local Attribute = Parent:GetAttribute("Owner")
                local Attribute_2 = Parent:GetAttribute("GravityDisruptorActive")
                local v1 = false
                if Attribute == LocalPlayer.Name then
                    v1 = Attribute_2 ~= true
                end
                a1.Enabled = v1
                return
            end
            a1.Enabled = false
        end

        local function bindPromptConnections(a1) -- Line: 61
            -- upvalues: u24 (upval), LocalPlayer (upval)
            local v1 = u24[a1]
            if v1 then
                local Owner = v1.Owner
                if Owner then
                    Owner:Disconnect()
                end
                local Active = v1.Active
                if Active then
                    Active:Disconnect()
                end
                u24[a1] = nil
            end
            local Parent = a1.Parent
            if Parent and Parent:IsA("BasePart") then
                u24[a1] = {
                    Owner = (Parent:GetAttributeChangedSignal("Owner")):Connect(function() -- Line: 72 -- upvalues: a1 (val), LocalPlayer (upval)
                        local v1 = a1
                        local Parent = v1.Parent
                        if Parent and Parent:IsA("BasePart") then
                            local Attribute = Parent:GetAttribute("Owner")
                            local Attribute_2 = Parent:GetAttribute("GravityDisruptorActive")
                            local v2 = false
                            if Attribute == LocalPlayer.Name then
                                v2 = Attribute_2 ~= true
                            end
                            v1.Enabled = v2
                            return
                        end
                        v1.Enabled = false
                    end),
                    Active = (Parent:GetAttributeChangedSignal("GravityDisruptorActive")):Connect(function() -- Line: 75 -- upvalues: a1 (val), LocalPlayer (upval)
                        local v1 = a1
                        local Parent = v1.Parent
                        if Parent and Parent:IsA("BasePart") then
                            local Attribute = Parent:GetAttribute("Owner")
                            local Attribute_2 = Parent:GetAttribute("GravityDisruptorActive")
                            local v2 = false
                            if Attribute == LocalPlayer.Name then
                                v2 = Attribute_2 ~= true
                            end
                            v1.Enabled = v2
                            return
                        end
                        v1.Enabled = false
                    end),
                }
                return
            end
        end

        local function refreshPrompt(a1) -- Line: 79
            -- upvalues: bindPromptConnections (val), LocalPlayer (upval)
            bindPromptConnections(a1)
            local Parent = a1.Parent
            if Parent and Parent:IsA("BasePart") then
                local Attribute = Parent:GetAttribute("Owner")
                local Attribute_2 = Parent:GetAttribute("GravityDisruptorActive")
                local v1 = false
                if Attribute == LocalPlayer.Name then
                    v1 = Attribute_2 ~= true
                end
                a1.Enabled = v1
                return
            end
            a1.Enabled = false
        end

        local function trackPrompt(a1) -- Line: 84
            -- upvalues: bindPromptConnections (val), LocalPlayer (upval), u24 (upval)
            bindPromptConnections(a1)
            local Parent = a1.Parent
            if not Parent then
                a1.Enabled = false
            elseif Parent:IsA("BasePart") then
                local Attribute = Parent:GetAttribute("Owner")
                local Attribute_2 = Parent:GetAttribute("GravityDisruptorActive")
                local v1 = false
                if Attribute == LocalPlayer.Name then
                    v1 = Attribute_2 ~= true
                end
                a1.Enabled = v1
            else
                a1.Enabled = false
            end
            a1.AncestryChanged:Connect(function(a1_2, a2) -- Line: 87 -- upvalues: a1 (val), u24 (upval), bindPromptConnections (upval), LocalPlayer (upval)
                local v1
                if not a2 then
                    v1 = a1
                    local v2 = u24[v1]
                    if not v2 then
                        return
                    end
                    local Owner = v2.Owner
                    if Owner then
                        Owner:Disconnect()
                    end
                    local Active = v2.Active
                    if Active then
                        Active:Disconnect()
                    end
                    u24[v1] = nil
                    return
                end
                v1 = a1
                bindPromptConnections(v1)
                local Parent = v1.Parent
                if Parent and Parent:IsA("BasePart") then
                    local Attribute = Parent:GetAttribute("Owner")
                    local Attribute_2 = Parent:GetAttribute("GravityDisruptorActive")
                    local v3 = false
                    if Attribute == LocalPlayer.Name then
                        v3 = Attribute_2 ~= true
                    end
                    v1.Enabled = v3
                    return
                end
                v1.Enabled = false
            end)
            a1.Destroying:Connect(function() -- Line: 96 -- upvalues: a1 (val), u24 (upval)
                local v1 = a1
                local v2 = u24[v1]
                if not v2 then
                    return
                end
                local Owner = v2.Owner
                if Owner then
                    Owner:Disconnect()
                end
                local Active = v2.Active
                if Active then
                    Active:Disconnect()
                end
                u24[v1] = nil
            end)
        end

        for i, v in ipairs(CollectionService:GetTagged(UNPLACE_PROMPT)) do
            if v:IsA("ProximityPrompt") then
                trackPrompt(v)
            end
        end
        ;(CollectionService:GetInstanceAddedSignal(UNPLACE_PROMPT)):Connect(function(a1) -- Line: 99 -- upvalues: trackPrompt (val) -- types: a1: userdata
            if not a1:IsA("ProximityPrompt") then
                return
            end
            trackPrompt(a1)
        end)
        ;(CollectionService:GetInstanceRemovedSignal(UNPLACE_PROMPT)):Connect(function(a1) -- Line: 107 -- upvalues: u24 (upval) -- types: a1: userdata
            if not a1:IsA("ProximityPrompt") then
                return
            end
            local v1 = u24[a1]
            if not v1 then
                return
            end
            local Owner = v1.Owner
            if Owner then
                Owner:Disconnect()
            end
            local Active = v1.Active
            if Active then
                Active:Disconnect()
            end
            u24[a1] = nil
        end)
    end,
}