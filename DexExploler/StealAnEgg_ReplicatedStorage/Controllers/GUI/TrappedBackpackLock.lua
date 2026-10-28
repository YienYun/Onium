-- Script path: ReplicatedStorage.Controllers.GUI.TrappedBackpackLock
-- Decompile time: 1.41 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local u19 = require(script.Parent.BackpackController.Main)
local u21 = GUI.Backpack()
local u22 = false
local u23 = nil
return {
    SetLocked = function(a1) -- Line: 32
        -- upvalues: u22 (ref), u23 (ref), u19 (val), u21 (val), HiddenUIHandler (val)
        if u22 == a1 then
            return
        end
        u22 = a1
        if a1 then
            u23 = u19:GetBackpackEnabled()
            u19:SetBackpackEnabled(false)
            u21.Enabled = false
            return
        end
        local v1 = u23
        u23 = nil
        if v1 == nil then
            return
        end
        u19:SetBackpackEnabled(v1)
        if v1 and not HiddenUIHandler.IsHidden() then
            u21.Enabled = true
        end
    end,
}