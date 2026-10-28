-- Script path: ReplicatedStorage.Controllers.GUI.TreadmillUIController.Visibility
-- Decompile time: 2.26 ms

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Hud = require(ReplicatedStorage.Client.Hud)
local Player = require(ReplicatedStorage.Shared.Player)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u37 = require(script.Parent.Parent.BackpackController.Main)
local TopBar = GUI.OfflineMoneyInPlot().TopBar
local u42 = GUI.TopBarStandard()
local u44 = GUI.Backpack()
local u45 = nil
local u48 = Trove.new()
local v1 = {}

local function IsBackpackVisibilityAllowed() -- Line: 45 -- upvalues: u37 (val), HiddenUIHandler (val)
    return u37:GetBackpackEnabled() and not HiddenUIHandler.IsHidden()
end

local function UnequipTools() -- Line: 50 -- upvalues: Player (val)
    local v1 = Player.FindHumanoid()
    if v1 ~= nil then
        v1:UnequipTools()
    end
end

function v1.Apply(a1) -- Line: 61
    -- upvalues: u45 (ref), TopBar (val), u42 (val), Player (val), u48 (val), CollectionService (val), u37 (val)
    -- upvalues: Hud (val), u44 (val), HiddenUIHandler (val)
    local v1
    if a1 then
        if u45 == nil then
            u45 = {OfflineMoneyInPlotVisible = TopBar.Visible, TopBarEnabled = u42.Enabled}
            v1 = Player.FindCharacter()
            if v1 ~= nil then
                u48:Add((v1.ChildAdded:Connect(function(a1) -- Line: 71 -- upvalues: CollectionService (upval), Player (upval) -- types: a1: userdata
                    if a1:IsA("Tool") and not CollectionService:HasTag(a1, "PhoneTool") then
                        local v1 = Player.FindHumanoid()
                        if v1 ~= nil then
                            v1:UnequipTools()
                        end
                    end
                end)))
            end
        end
        u37:SetTreadmillPhoneOnlyMode(true)
        Hud.SetTreadmillActive(true)
        TopBar.Visible = false
        u42.Enabled = false
        v1 = Player.FindHumanoid()
        if v1 ~= nil then
            v1:UnequipTools()
        end
        return
    end
    Hud.SetTreadmillActive(false)
    u37:SetTreadmillPhoneOnlyMode(false)
    v1 = u45
    if v1 == nil then
        u48:Clean()
        return
    end
    u48:Clean()
    u42.Enabled = v1.TopBarEnabled
    TopBar.Visible = v1.OfflineMoneyInPlotVisible
    local BackpackEnabled = u37:GetBackpackEnabled() and not HiddenUIHandler.IsHidden()
    u44.Enabled = BackpackEnabled
    u45 = nil
end

return v1