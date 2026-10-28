-- Script path: ReplicatedStorage.Controllers.GUI.PurchaseNotificationsController
-- Decompile time: 5.37 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Confetti = require(ReplicatedStorage.Client.UI.VFX.Confetti)
local Message = require(ReplicatedStorage.Client.Message)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local u32 = {ProductSettled = 0.8, Rejected = 90}
local u33 = {
    Bounced = "Your gift couldn't reach its recipient, so it was added to your account instead.",
    Failed = "That purchase didn't go through. If any Robux were taken, Roblox refunds them automatically. Let us know if this keeps happening. 🙏",
    GiftDelivered = "Your gift has been delivered! 🎁",
    Thanks = "Thanks for your support! Your purchase is on its way. 🎉",
}
local u34 = {}
local u35 = {}
local v1 = {}

local function profileLoaded() -- Line: 42 -- upvalues: Save (val)
    return Save.Await() ~= nil
end

local function firstSighting(a1) -- Line: 46 -- upvalues: u34 (val) -- types: a1: string
    if u34[a1] then
        return false
    end
    u34[a1] = true
    return true
end

local function report(a1, a2) -- Line: 54
    -- upvalues: Confetti (val), Audio (val), Message (val)
    local u3 = a2
    if not u3 then
        u3 = {}
    end
    if u3.After ~= nil then
        task.delay(u3.After, function() -- Line: 56 -- upvalues: u3 (val), Confetti (upval), Audio (upval), Message (upval), a1 (val)
            if u3.Celebrate then
                Confetti.Burst()
                Audio.Play(98002834893313, script)
            end
            Message.Notice(a1)
        end)
        return
    end
    if u3.Celebrate then
        Confetti.Burst()
        Audio.Play(98002834893313, script)
    end
    Message.Notice(a1)
end

local function productIdOf(a1) -- Line: 70
    local ProductId = if type(a1) ~= "table" then nil else a1.ProductId
    if type(ProductId) == "number" then
        return ProductId
    end
    return nil
end

local function holdFailureNotice(a1) -- Line: 77 -- upvalues: report (val), u35 (val) -- types: a1: number?
    if a1 == nil then
        report(
            "That purchase didn't go through. If any Robux were taken, Roblox refunds them automatically. Let us know if this keeps happening. 🙏",
            {After = 90}
        )
        return
    end
    if u35[a1] ~= nil then
        return
    end
    u35[a1] = (task.delay(90, function() -- Line: 85 -- upvalues: u35 (upval), a1 (val), report (upval)
        u35[a1] = nil
        report("That purchase didn't go through. If any Robux were taken, Roblox refunds them automatically. Let us know if this keeps happening. 🙏")
    end))
end

local function withdrawFailureNotice(a1) -- Line: 91 -- upvalues: u35 (val) -- types: a1: number
    local v1 = u35[a1]
    if v1 ~= nil then
        u35[a1] = nil
        task.cancel(v1)
    end
end

local function giftLine(a1) -- Line: 99 -- upvalues: Players (val) -- types: a1: number
    if a1 == Players.LocalPlayer.UserId then
        return "Your gift couldn't reach its recipient, so it was added to your account instead."
    end
    local PlayerByUserId = Players:GetPlayerByUserId(a1)
    if PlayerByUserId then
        return (("Your gift is on its way to %*! 🎁"):format(PlayerByUserId.DisplayName))
    end
    return "Your gift has been delivered! 🎁"
end

function v1.Start() -- Line: 107
    -- upvalues: Remotes (val), Save (val), report (val), u35 (val), u33 (val), u32 (val), holdFailureNotice (val)
    -- upvalues: u34 (val), Players (val)
    Remotes.PassGrants.Awarded.OnClientEvent:Connect(function(a1, a2) -- Line: 108 -- upvalues: Save (upval), report (upval) -- types: a2: boolean?
        if not a2 and Save.Await() ~= nil then
            report("Thanks for your support! Your purchase is on its way. 🎉", {Celebrate = true})
        end
    end)

    local function onReceiptSettled(a1, a2) -- Line: 114
        -- upvalues: u35 (upval), Save (upval), report (upval)
        if a1 ~= nil then
            local v1 = u35[a1]
            if v1 ~= nil then
                u35[a1] = nil
                task.cancel(v1)
            end
        end
        if a2 and Save.Await() ~= nil then
            report("Thanks for your support! Your purchase is on its way. 🎉", {Celebrate = true, After = 0.8})
        end
    end

    Remotes.Storefront.PurchaseSettled.OnClientEvent:Connect(function(a1, a2) -- Line: 122 -- upvalues: u35 (upval), Save (upval), report (upval), u33 (upval), u32 (upval)
        local ProductId = if type(a2) ~= "table" then nil else a2.ProductId
        local v1 = if type(ProductId) ~= "number" then nil else ProductId
        if v1 ~= nil then
            local v2 = u35[v1]
            if v2 ~= nil then
                u35[v1] = nil
                task.cancel(v2)
            end
        end
        if Save.Await() ~= nil then
            report(u33.Thanks, {Celebrate = true, After = u32.ProductSettled})
        end
    end)
    Remotes.Storefront.ReceiptCleared.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 125
        -- upvalues: u35 (upval), Save (upval), report (upval), u33 (upval), u32 (upval)
        local v1 = if type(a1) ~= "number" then nil else a1
        if v1 ~= nil then
            local v2 = u35[v1]
            if v2 ~= nil then
                u35[v1] = nil
                task.cancel(v2)
            end
        end
        if not a3 and Save.Await() ~= nil then
            report(u33.Thanks, {Celebrate = true, After = u32.ProductSettled})
        end
    end)
    Remotes.Storefront.PurchaseRejected.OnClientEvent:Connect(function(a1) -- Line: 129 -- upvalues: holdFailureNotice (upval)
        local v1 = holdFailureNotice
        local ProductId = if type(a1) ~= "table" then nil else a1.ProductId
        v1(if type(ProductId) ~= "number" then nil else ProductId)
    end)
    Remotes.Gifting.Received.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 133 -- upvalues: u34 (upval), report (upval) -- types: a1: string, a2: string, a3: string
        local v1
        if not u34[a2] then
            u34[a2] = true
            v1 = true
        else
            v1 = false
        end
        if v1 then
            report(("%* sent you a gift: %*! 🎁"):format(a1, a3), {Celebrate = true})
        end
    end)
    Remotes.Gifting.Completed.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 138
        -- upvalues: u34 (upval), report (upval), Players (upval), u33 (upval)
        local v1
        if not u34[a3] then
            u34[a3] = true
            v1 = true
        else
            v1 = false
        end
        if v1 then
            local Bounced
            v1 = report
            if a2 ~= Players.LocalPlayer.UserId then
                local PlayerByUserId = Players:GetPlayerByUserId(a2)
                Bounced = if not PlayerByUserId then u33.GiftDelivered else ("Your gift is on its way to %*! 🎁"):format(PlayerByUserId.DisplayName)
            else
                Bounced = u33.Bounced
            end
            v1(Bounced, {Celebrate = true})
        end
    end)
end

return v1