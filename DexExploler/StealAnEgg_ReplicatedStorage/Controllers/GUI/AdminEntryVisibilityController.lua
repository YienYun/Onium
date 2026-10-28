-- Script path: ReplicatedStorage.Controllers.GUI.AdminEntryVisibilityController
-- Decompile time: 0.92 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AdminPanelEntry = require(ReplicatedStorage.Client.AdminPanelEntry)
local GUI = require(ReplicatedStorage.Client.GUI)
return {
    Start = function() -- Line: 20 -- upvalues: GUI (val), AdminPanelEntry (val)
        local v1 = GUI.PlayerGui()

        local function bindAdminPanelEntry(a1) -- Line: 28 -- upvalues: AdminPanelEntry (upval) -- types: a1: userdata
            if a1.Name ~= "AdminPanel" then
                return
            end
            assert(a1:IsA("ScreenGui"), "PlayerGui.AdminPanel must be a ScreenGui")
            local Toggle = a1.Toggle
            assert(Toggle:IsA("TextButton"), "PlayerGui.AdminPanel.Toggle must be a TextButton")
            Toggle.Visible = AdminPanelEntry.CanShowPanel()
            AdminPanelEntry.Changed:Connect(function(a1) -- Line: 36 -- upvalues: Toggle (val) -- types: a1: boolean
                if Toggle.Parent ~= nil then
                    Toggle.Visible = a1
                end
            end)
        end

        for i, j in v1:GetChildren() do
            bindAdminPanelEntry(j)
        end
        v1.ChildAdded:Connect(bindAdminPanelEntry)
    end,
}