-- Script path: ReplicatedStorage.Client.UI.TreadmillStaticRateSign
-- Decompile time: 0.89 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local AddCommas = require(ReplicatedStorage.Shared.Utils.Numbers).AddCommas
local t = require(ReplicatedStorage.Packages.t)
return {
    Apply = function(a1, a2, a3) -- Line: 30 -- upvalues: t (val), AddCommas (val) -- types: a1: userdata, a2: userdata, a3: number
        t.strict(t.Instance)(a1)
        t.strict(t.Color3)(a2)
        t.strict(t.number)(a3)
        local SpeedPerSecond = a1.SpeedPerSecond
        assert(SpeedPerSecond:IsA("BasePart"), (("Treadmill \"%*\" SpeedPerSecond must be a BasePart"):format(a1.Name)))
        local BillboardGui = SpeedPerSecond.BillboardGui
        assert(BillboardGui:IsA("BillboardGui"), (("Treadmill \"%*\" SpeedPerSecond.BillboardGui must be a BillboardGui"):format(a1.Name)))
        local TextLabel = BillboardGui.Frame.TextLabel
        assert(
            TextLabel:IsA("TextLabel"),
            (("Treadmill \"%*\" SpeedPerSecond.BillboardGui.Frame.TextLabel must be a TextLabel"):format(a1.Name))
        )
        TextLabel.TextColor3 = a2
        TextLabel.Text = ("+%*/step"):format((AddCommas(a3)))
        return BillboardGui
    end,
}