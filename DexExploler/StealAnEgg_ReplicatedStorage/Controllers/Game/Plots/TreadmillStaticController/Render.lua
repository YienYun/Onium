-- Script path: ReplicatedStorage.Controllers.Game.Plots.TreadmillStaticController.Render
-- Decompile time: 4.13 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local t = require(ReplicatedStorage.Packages.t)
require(ReplicatedStorage.Shared.Modules.ProfileDefaults.Types.Interface)
local TreadmillStaticCover = require(ReplicatedStorage.Client.UI.TreadmillStaticCover)
local TreadmillVideoGate = require(ReplicatedStorage.Client.TreadmillVideoGate)
local TreadmillStaticRateSign = require(ReplicatedStorage.Client.UI.TreadmillStaticRateSign)
local TreadmillUtil = require(ReplicatedStorage.Shared.Util.TreadmillUtil)
require(ReplicatedStorage.Shared.TreadmillVideoController.Types.Interface)
local Treadmills = require(ReplicatedStorage.Data.Treadmills)
require(script.Parent.Types.Interface)
local Treadmills_2 = ReplicatedStorage.Assets.Models.Treadmills
local u64 = {}

function u64.SetGroundedScale(a1, a2) -- Line: 34 -- upvalues: t (val), TreadmillUtil (val) -- types: a2: number
    t.strict(t.table)(a1)
    t.strict(t.number)(a2)
    a1.Model:ScaleTo(a2)
    local Root = a1.Model.Root
    assert(Root:IsA("BasePart"), (("Treadmill \"%*\" Root must be a BasePart"):format(a1.TreadmillId)))
    local v1 = (a1.Model:GetPivot()):ToObjectSpace(Root.CFrame)
    a1.Model:PivotTo((TreadmillUtil.ResolveGroundedToolRootCFrameAtLocation(a1.Bottom, a1.Model)) * (v1:Inverse()))
end

function u64.Build(a1, a2, a3, a4, a5, a6) -- Line: 46
    -- upvalues: t (val), Workspace (val), Players (val), Treadmills (val), Treadmills_2 (val), TreadmillVideoGate (val)
    -- upvalues: TreadmillUtil (val), TreadmillStaticRateSign (val), TreadmillStaticCover (val), u64 (val)
    local v1
    t.strict(t.number)(a1)
    t.strict(t.number)(a2)
    t.strict(t.table)(a3)
    t.strict(t.number)(a4)
    t.strict(t.boolean)(a5)
    t.strict(t.instanceIsA("Folder"))(a6)
    local Plots = Workspace.Plots
    assert(Plots:IsA("Folder"), "Treadmill rendering requires the plots folder")
    local v2 = Plots[tostring(a1)]
    assert(v2:IsA("Model"), (("Plot \"%*\" must be a Model"):format(a1)))
    local TreadmillBottom = v2.TreadmillBottom
    assert(TreadmillBottom:IsA("BasePart"), (("Plot \"%*\" TreadmillBottom must be a BasePart"):format(a1)))
    local PlayerByUserId = Players:GetPlayerByUserId(a2)
    local v3 = ("Invalid treadmill upgrade level %*"):format(a3.TreadmillUpgradeLevel)
    assert(
        (if PlayerByUserId ~= nil then Treadmills.ResolveForPlayer(PlayerByUserId, a3.TreadmillUpgradeLevel) else Treadmills.GetByUpgradeLevel(a3.TreadmillUpgradeLevel)) ~= nil,
        v3
    )
    v2 = Treadmills_2[v1._id]
    assert(v2:IsA("Tool"), (("Treadmill render template \"%*\" must be a Tool"):format(v1._id)))
    local v4 = v2:Clone()
    v4.Name = ("TreadmillRender_%*"):format(a1)
    if TreadmillVideoGate.IsVideoPlayerDisabled() then
        v2 = TreadmillUtil.FindVideoPlayerFolder(v4)
        if v2 ~= nil then
            v2:Destroy()
        end
    end
    v4.Parent = a6
    for i, v in ipairs(v4:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Anchored = true
            v.CanCollide = false
            v.CanQuery = false
            v.CanTouch = false
        elseif v:IsA("BaseScript") then
            v:Destroy()
        end
    end
    local v5 = TreadmillStaticRateSign.Apply(v4, v1.Rarity.Color, v1.SpeedMultiplier)
    v3 = TreadmillUtil.FindVideoFeedScreenPart(v4)
    local v6 = nil
    if a5 and v3 ~= nil then
        local v7 = TreadmillStaticCover.Create(("StaticTreadmillCover_%*"):format(a1), v3)
        TreadmillStaticCover.ApplyFeed(v7, a3.TreadmillMediaFeedState)
        v6 = v7
    end
    v3 = {
        Bottom = TreadmillBottom,
        Cover = v6,
        Model = v4,
        OwnerUserId = a2,
        RateSign = v5,
        Slot = a1,
        TreadmillId = v1._id,
    }
    u64.SetGroundedScale(v3, v4:GetScale() * a4)
    return v3
end

return u64