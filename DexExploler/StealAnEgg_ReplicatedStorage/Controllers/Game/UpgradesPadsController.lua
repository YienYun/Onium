-- Script path: ReplicatedStorage.Controllers.Game.UpgradesPadsController
-- Decompile time: 1.14 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local Pads = require(ReplicatedStorage.Client.WorldFX.Pads)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Trove = require(ReplicatedStorage.Packages.Trove)
return {
    Start = function() -- Line: 15 -- upvalues: Workspace (val), Pads (val), Tabs (val), MonsterParasite (val), Trove (val)
        local Pads_2 = (Workspace:WaitForChild("Stands")):WaitForChild("Pads")

        local function bindPad(a1, a2, a3) -- Line: 20
            -- upvalues: Pads (upval), Tabs (upval)
            a1:Add((Pads.Track(a2, {
                Entered = function() -- Line: 22 -- upvalues: Tabs (upval), a3 (val)
                    Tabs.Activate(a3)
                end,
                Left = function() -- Line: 25 -- upvalues: Tabs (upval), a3 (val)
                    if Tabs.Active() == a3 then
                        Tabs.Deactivate({instant = true})
                    end
                end,
            })))
        end

        for i, j in Pads_2:GetChildren() do
            if j:IsA("BasePart") and j.Name ~= MonsterParasite.PadName then
                bindPad(Trove.new(), j, j.Name)
            end
        end
    end,
}