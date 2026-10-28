-- Script path: ReplicatedStorage.Controllers.GUI.TreadmillUpgradeController.Client
-- Decompile time: 2.44 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Shared.Globals.Constants)
local Log = require(ReplicatedStorage.Packages.Log)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
require(ReplicatedStorage.Data.Treadmills)
local Treadmills = require(ReplicatedStorage.Data.Treadmills)
local u49 = Color3.fromRGB(255, 64, 64)
local u51 = Log.new()
local u52 = {}

function u52.GetNextConfig(a1) -- Line: 31 -- upvalues: t (val), Treadmills (val)
    t.strict(t.intersection(t.integer, t.numberMin(0)))(a1.TreadmillUpgradeLevel)
    local v1 = a1.TreadmillUpgradeLevel + 1
    return v1, Treadmills.GetByUpgradeLevel(v1)
end

function u52.CanAffordNext(a1) -- Line: 41 -- upvalues: u52 (val)
    local v1
    _, v1 = u52.GetNextConfig(a1)
    local v2 = false
    if v1 ~= nil then
        v2 = v1.Price <= a1.Money
    end
    return v2
end

function u52.RequestCashUpgrade() -- Line: 46
    -- upvalues: Save (val), u52 (val), Toast (val), u49 (val), Remotes (val), u51 (val)
    local v1
    local v2 = Save.Await()
    assert(v2 ~= nil, "Treadmill cash upgrade requires loaded data")
    _, v1 = u52.GetNextConfig(v2)
    if v1 == nil then
        Toast.Show({Text = "Max treadmill upgrade reached", Seconds = 2})
        return false
    end
    if v2.Money < v1.Price then
        Toast.Show({Text = "Not enough money", Seconds = 2, Color = u49})
        return false
    end
    local v3, v4 = Remotes.Treadmill.AskTierRaise:InvokeServer(v1._id)
    if v3 == true then
        return true
    end
    v1 = v4 or "Treadmill upgrade failed"
    u51:AtWarning():Log(v1)
    Toast.Show({Seconds = 2, Text = v1, Color = u49})
    return false
end

function u52.PromptRobuxUpgrade() -- Line: 71
    -- upvalues: Save (val), u52 (val), Toast (val), u51 (val), Storefront (val)
    local v1
    local v2 = Save.Await()
    assert(v2 ~= nil, "Treadmill Robux upgrade requires loaded data")
    _, v1 = u52.GetNextConfig(v2)
    if v1 == nil then
        Toast.Show({Text = "Max treadmill upgrade reached", Seconds = 2})
        return false
    end
    local ProductId = v1.ProductId
    if ProductId == nil then
        (u51:AtWarning()):Log((("Treadmill \"%*\" has no Robux upgrade product"):format(v1._id)))
        return false
    end
    Storefront.Prompt(ProductId, true)
    return true
end

return u52