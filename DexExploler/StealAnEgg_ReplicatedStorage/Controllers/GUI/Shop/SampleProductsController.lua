-- Script path: ReplicatedStorage.Controllers.GUI.Shop.SampleProductsController
-- Decompile time: 1.07 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
require(ReplicatedStorage.Client.Types.GUI)
return {
    Start = function() -- Line: 10 -- upvalues: GUI (val)
        local v1 = GUI.Shop()
        local Samples = v1.Frame.ScrollingFrame.Samples
        local Samples_2 = v1.Frame.ButtonsHolder.Samples
        Samples.Visible = false
        Samples_2.Visible = false
        Samples_2.Active = false
        Samples_2.Selectable = false
        Samples_2.Interactable = false
        for i, j in Samples:GetDescendants() do
            if j:IsA("GuiButton") then
                j.Active = false
                j.Selectable = false
                j.Interactable = false
            end
        end
    end,
}