-- Script path: ReplicatedStorage.Client.Notifications.CorruptedAnnouncement
-- Decompile time: 8.69 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SammyPortrait = require(script.Parent.SammyPortrait)
local SammyNotif = ReplicatedStorage.Assets.UI.Notifs.SammyNotif
local v1 = {}

local function startsWith(a1, a2) -- Line: 30 -- types: a1: string, a2: string
    return string.sub(a1, 1, #a2) == a2
end

function v1.Create(a1, a2) -- Line: 34
    -- upvalues: SammyNotif (val), SammyPortrait (val), RunService (val)
    local v1 = utf8.len(a1) or #a1
    local v2 = v1 > 56
    local u193 = SammyNotif:Clone()
    local Main = u193.Main
    local Portrait = u193.Portrait
    local SammyName = Main.SammyName
    local Dialogue = Main.Dialogue
    local UIAspectRatioConstraint = u193:FindFirstChildOfClass("UIAspectRatioConstraint")
    if UIAspectRatioConstraint then
        local Attribute = u193:GetAttribute(if not v2 then "AspectShort" else "AspectLong") or UIAspectRatioConstraint.AspectRatio
        UIAspectRatioConstraint.AspectRatio = Attribute
    end
    local Attribute_2 = u193:GetAttribute(if not v2 then "TitleShortY" else "TitleLongY")
    if Attribute_2 then
        SammyName.Position = UDim2.fromScale(SammyName.Position.X.Scale, Attribute_2)
    end
    SammyName.Text = a2
    Dialogue.Text = a1
    local u213 = {}
    local u188 = {}
    local u214 = {}
    local u180 = {}
    local Scan = Main.Scan
    for i, j in Main:GetChildren() do
        if string.sub(j.Name, 1, 9) == "ChargeArc" then
            table.insert(u213, j)
        elseif string.sub(j.Name, 1, 10) == "ChargeGlow" then
            table.insert(u188, j)
        elseif string.sub(j.Name, 1, 10) == "SignalTear" then
            table.insert(u214, {Frame = j, Position = j.Position})
        elseif string.sub(j.Name, 1, 11) == "SignalGhost" then
            j.Text = v3
            table.insert(u180, {Label = j})
        end
    end
    local u98 = nil
    local u99 = nil
    local u100 = nil

    local function stop() -- Line: 78 -- upvalues: u99 (ref), u100 (ref)
        if u99 then
            u99()
            u99 = nil
        end
        if u100 then
            u100()
            u100 = nil
        end
    end

    local u102 = false
    return u193, function() -- Line: 92
        -- upvalues: u102 (ref), u193 (val), u98 (ref), u99 (ref), SammyPortrait (upval), Portrait (val), u100 (ref)
        -- upvalues: stop (val), RunService (upval), u213 (val), u180 (val), SammyName (val), u214 (val), u188 (val)
        -- upvalues: Scan (val), Dialogue (val)
        if not u102 and u193.Parent ~= nil then
            u102 = true
            local v1, v2 = SammyPortrait.Mount(Portrait)
            u98 = v1
            u99 = v2
            local u9 = 0
            local u10 = -1
            local u11 = nil
            local u12 = nil

            function u100() -- Line: 102 -- upvalues: u11 (ref), u12 (ref)
                if u11 then
                    u11:Disconnect()
                    u11 = nil
                end
                if u12 then
                    u12:Disconnect()
                    u12 = nil
                end
            end

            u193.Destroying:Connect(stop)
            RunService.RenderStepped:Connect(function(a1) -- Line: 114
                -- upvalues: u193 (upval), u99 (upval), u100 (upval), u9 (ref), u98 (upval), u10 (ref), u213 (upval)
                -- upvalues: u180 (upval), SammyName (upval), u214 (upval), u188 (upval), Scan (upval), Dialogue (upval)
                local Attribute_2, v1, v2, v3
                if u193.Parent == nil then
                    if u99 then
                        u99()
                        u99 = nil
                    end
                    if u100 then
                        u100()
                        u100 = nil
                    end
                    return
                end
                u9 = u9 + a1
                if u98 then
                    u98(u9)
                end
                local v4 = math.floor(u9 * 14)
                if v4 ~= u10 then
                    local Attribute, Y, new, v5, v6
                    u10 = v4
                    for i, j in u213 do
                        Attribute = j:GetAttribute("Cells")
                        if typeof(Attribute) == "Vector2" and 0 < Attribute.X and 0 < Attribute.Y then
                            v2 = v4 + (j:GetAttribute("Phase") or 0) * 5
                            new = Vector2.new
                            v5 = j.ImageRectSize.X * (v2 % Attribute.X)
                            Y = j.ImageRectSize.Y
                            v6 = math.floor(v2 / Attribute.X)
                            j.ImageRectOffset = new(v5, Y * (v6 % Attribute.Y))
                        end
                    end
                end
                v4 = u9 % 2.9
                local v7 = if not (v4 < 0.23) then 0 else 1 - v4 / 0.23
                v4 = math.sin(u9 * 173) * v7
                for k, n in u180 do
                    v2 = n.Label:GetAttribute("Drift") or 1
                    n.Label.Position = SammyName.Position + UDim2.fromScale(v2 * (math.abs(v4) * 0.007 + 0.004), 0)
                    n.Label.TextTransparency = 1 - v7 * 0.53
                end
                for m, i5 in u214 do
                    v2 = i5.Frame:GetAttribute("Drift") or 1
                    v3 = i5.Frame:GetAttribute("Phase") or 0
                    i5.Frame.Position = i5.Position + UDim2.fromScale(v4 * 0.017 * v2, 0)
                    i5.Frame.BackgroundTransparency = 0.67 - v7 * 0.43 + math.sin(u9 * 2 + v3) * 0.12
                end
                for i6, i7 in u188 do
                    Attribute_2 = i7:GetAttribute("Phase")
                    v1 = u9 * 2.2 + (Attribute_2 or 0)
                    i7.ImageTransparency = math.sin(v1) * 0.035 + 0.9
                end
                Scan.Position = UDim2.fromScale(0.12, u9 * 0.19 % 1 * 0.8 + 0.1)
                Dialogue.TextTransparency = 0
            end)
            return
        end
    end, stop
end

return v1