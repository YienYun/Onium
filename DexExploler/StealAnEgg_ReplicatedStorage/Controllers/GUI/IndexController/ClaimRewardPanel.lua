-- Script path: ReplicatedStorage.Controllers.GUI.IndexController.ClaimRewardPanel
-- Decompile time: 3.83 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
require(script.Parent.Types.Interface)
local u31 = Color3.fromRGB(60, 255, 0)
local u36 = Color3.fromRGB(136, 255, 0)
local u41 = Color3.fromRGB(190, 255, 180)
local v1 = {}
local u43 = nil
local u44 = nil

local function applyClaimableLook(a1, a2) -- Line: 31
    -- upvalues: u43 (ref), u31 (val), u36 (val), u44 (ref), u41 (val)
    local UIGradient = a1:FindFirstChildOfClass("UIGradient")
    if UIGradient ~= nil then
        if u43 == nil then
            u43 = UIGradient.Color
        end
        if not a2 then
            UIGradient.Color = u43
        else
            local Attribute = a1:GetAttribute("ClaimableColorStart")
            local Attribute_2 = a1:GetAttribute("ClaimableColorEnd")
            UIGradient.Color = ColorSequence.new(Attribute or u31, Attribute_2 or u36)
        end
    end
    local UIStrokeClr = a1:FindFirstChild("UIStrokeClr")
    if UIStrokeClr ~= nil and UIStrokeClr:IsA("UIStroke") then
        if u44 == nil then
            u44 = UIStrokeClr.Color
        end
        if a2 then
            UIStrokeClr.Color = a1:GetAttribute("ClaimableStrokeColor") or u41
            return
        end
        UIStrokeClr.Color = u44
        return
    end
end

function v1.Render(a1, a2, a3, a4) -- Line: 68
    -- upvalues: t (val), u43 (ref), u44 (ref), Simple (val), AssetItems (val), applyClaimableLook (val)
    t.strict(t.boolean)(a3)
    t.strict(t.boolean)(a4)
    local Claim = a1.Claim
    Claim.Active = a4
    if a2 ~= nil then
        a1.Rewards.SpeedReward.TextLabel.Text = "+" .. Simple.FormatCompact(AssetItems.IndexSpeedReward(a2.Category), ".#")
        a1.Rewards.MoneyReward.TextLabel.Text = "$" .. Simple.FormatCompact(AssetItems.IndexMoneyReward(a2.Category), ".#")
        local v1 = if not a3 then "CLAIM!" else "CLAIMED!"
        Claim.TextLabel.Text = v1
        applyClaimableLook(Claim, a4)
        return
    end
    Claim.TextLabel.Text = "CLAIM!"
    local UIGradient = Claim:FindFirstChildOfClass("UIGradient")
    if UIGradient ~= nil then
        if u43 == nil then
            u43 = UIGradient.Color
        end
        UIGradient.Color = u43
    end
    local UIStrokeClr = Claim:FindFirstChild("UIStrokeClr")
    if UIStrokeClr ~= nil then
        if not UIStrokeClr:IsA("UIStroke") then
            return
        end
        if u44 == nil then
            u44 = UIStrokeClr.Color
        end
        UIStrokeClr.Color = u44
    end
end

return v1