-- Script path: ReplicatedStorage.Client.Notifications.RiftSpawn
-- Decompile time: 4.70 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Areas = require(ReplicatedStorage.Data.Areas)
local Audio = require(ReplicatedStorage.Shared.Audio)
local Lanes = require(script.Parent.Lanes)
local RiftEligibility = require(ReplicatedStorage.Shared.Util.RiftEligibility)
local Save = require(ReplicatedStorage.Shared.Save)
local t = require(ReplicatedStorage.Packages.t)
local RiftNotif = ReplicatedStorage.Assets.UI.Notifs.RiftNotif
local u45 = Color3.fromRGB(57, 255, 90)
local u46 = {0.95, 1.05}
local u72 = t.interface({
    AreaId = t.optional(t.string),
    Seconds = t.optional(t.number),
    Color = t.optional(t.Color3),
    Sound = t.optional(t.union(t.string, t.number)),
    UniqueKey = t.optional(t.string),
    DelayInRound = t.optional(t.boolean),
})
local v1 = {}

local function compose(a1, a2) -- Line: 46 -- upvalues: Areas (val), u45 (val) -- types: a1: string?, a2: userdata?
    local v1
    if (if a1 == nil then nil else if a1 == "" then nil else Areas.Directory[a1]) == nil then
        return "A Rift has spawned!"
    end
    return (("A Rift has spawned in <font color=\"#%*\">%*</font>"):format((a2 or v1.Color or u45):ToHex(), v1.DisplayName))
end

local function playSprites(a1) -- Line: 56 -- types: a1: userdata
    local Main = a1:FindFirstChild("Main")
    if Main == nil then
        return
    end
    local u5 = {}
    for i, j in Main:GetChildren() do
        if j:IsA("ImageLabel") and j.Name == "Sprite" then
            table.insert(u5, j)
        end
    end
    if #u5 == 0 then
        return
    end
    local u25 = u5[1]:GetAttribute("Cells")
    local Attribute = u5[1]:GetAttribute("FPS")
    if typeof(u25) == "Vector2" and typeof(Attribute) == "number" and not (Attribute <= 0) then
        task.spawn(function() -- Line: 78 -- upvalues: a1 (val), u25 (val), u5 (val), Attribute (val)
            local new, v1, v2, v3
            local v4 = 0
            while a1.Parent ~= nil do
                v1 = v4 % u25.X
                v2 = (math.floor(v4 / u25.X)) % u25.Y
                for i, j in u5 do
                    new = Vector2.new
                    v3 = j.ImageRectSize.X * v1
                    j.ImageRectOffset = new(v3, j.ImageRectSize.Y * v2)
                end
                v4 = v4 + 1
                task.wait(1 / Attribute)
            end
        end)
        return
    end
end

local function seesTheRift() -- Line: 93 -- upvalues: Players (val), Save (val), RiftEligibility (val)
    local LocalPlayer = Players.LocalPlayer
    if LocalPlayer == nil then
        return false
    end
    local v1 = Save.Await()
    return RiftEligibility.IsRevealed(LocalPlayer, if v1 == nil then 0 else v1.SpeedPower, if v1 == nil then 0 else v1.LastLogout)
end

function v1.Show(a1) -- Line: 105
    -- upvalues: u72 (val), Players (val), Save (val), RiftEligibility (val), RiftNotif (val), Areas (val), u45 (val)
    -- upvalues: Lanes (val), Audio (val), u46 (val), playSprites (val)
    local v1
    local u2 = a1
    if not u2 then
        u2 = {}
    end
    assert((u72(u2)))
    local LocalPlayer = Players.LocalPlayer
    if LocalPlayer ~= nil then
        local v2 = Save.Await()
        v1 = RiftEligibility.IsRevealed(LocalPlayer, if v2 == nil then 0 else v2.SpeedPower, if v2 == nil then 0 else v2.LastLogout)
    else
        v1 = false
    end
    if not v1 then
        return
    end
    v1 = RiftNotif:Clone()
    local Content = v1:FindFirstChild("Main"):FindFirstChild("Content")
    local AreaId = u2.AreaId
    local Color = u2.Color
    local v3 = if AreaId == nil then nil else if AreaId == "" then nil else Areas.Directory[AreaId]
    Content.Text = if v3 ~= nil then ("A Rift has spawned in <font color=\"#%*\">%*</font>"):format((Color or v3.Color or u45):ToHex(), v3.DisplayName) else "A Rift has spawned!"
    Lanes.Schedule({
        Lane = "Banner",
        Frame = v1,
        Seconds = u2.Seconds or 6,
        UniqueKey = u2.UniqueKey or "RiftSpawn",
        DelayInRound = u2.DelayInRound,
        OnShown = function(a1) -- Line: 124 -- upvalues: Audio (upval), u2 (val), u46 (upval), playSprites (upval) -- types: a1: userdata
            Audio.Play(u2.Sound or "rbxassetid://133842042346471", script, {Volume = 0.7, PlaybackSpeed = u46})
            playSprites(a1)
        end,
    })
end

return table.freeze(v1)