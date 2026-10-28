-- Script path: ReplicatedStorage.Shared.Modules.Staff
-- Decompile time: 3.07 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StaffTagFlags = require(ReplicatedStorage.Shared.Flags.StaffTagFlags)
local u10 = {"Assets", "Billboards", "StaffTag"}
local u14 = {Owner = "OwnerLabel", Admin = "AdminLabel", Developer = "DeveloperLabel"}
local u15 = {Owner = "OwnerChatLabel", Admin = "AdminChatLabel", Developer = "DeveloperChatLabel"}
local u16 = {Owner = "OwnerColor", Admin = "AdminColor", Developer = "DeveloperColor"}
local u17 = {Owner = "OwnerLightColor", Admin = "AdminLightColor", Developer = "DeveloperLightColor"}
local u18 = {Owner = "OWNER", Admin = "ADMIN", Developer = "DEVELOPER"}
local u19 = {Owner = "OWNER", Admin = "ADMIN", Developer = "DEV"}
local u20 = {}
u20.Owner = Color3.fromRGB(255, 68, 68)
u20.Admin = Color3.fromRGB(255, 68, 68)
u20.Developer = Color3.fromRGB(64, 156, 255)
local u36 = {}
u36.Owner = Color3.fromRGB(255, 176, 176)
u36.Admin = Color3.fromRGB(255, 176, 176)
u36.Developer = Color3.fromRGB(168, 220, 255)
local u52 = {Changed = StaffTagFlags.Changed}

local function template() -- Line: 80 -- upvalues: ReplicatedStorage (val), u10 (val)
    local v1 = ReplicatedStorage
    for i, j in u10 do
        v1 = if not v1 then nil else v1:FindFirstChild(j)
    end
    if v1 and v1:IsA("BillboardGui") then
        return v1
    end
    return nil
end

local function chatBadge(a1, a2) -- Line: 92 -- types: a1: string, a2: userdata
    return table.concat({"<font color=\"#", a2:ToHex(), "\">[", a1, "]</font>"})
end

function u52.RoleOf(a1) -- Line: 96 -- upvalues: StaffTagFlags (val)
    if not StaffTagFlags.Enabled:Get() then
        return nil
    end
    return (StaffTagFlags.Roles:Get())[tostring(a1)]
end

function u52.LabelOf(a1) -- Line: 104 -- upvalues: template (val), u14 (val), u18 (val)
    local v1 = template()
    local Attribute = if not v1 then nil else v1:GetAttribute(u14[a1])
    if typeof(Attribute) == "string" and Attribute ~= "" then
        return Attribute
    end
    return u18[a1]
end

function u52.ChatLabelOf(a1) -- Line: 111 -- upvalues: template (val), u15 (val), u19 (val)
    local v1 = template()
    local Attribute = if not v1 then nil else v1:GetAttribute(u15[a1])
    if typeof(Attribute) == "string" and Attribute ~= "" then
        return Attribute
    end
    return u19[a1]
end

function u52.OverheadLabel(a1) -- Line: 118 -- upvalues: u52 (val)
    return string.format("[%s]", u52.LabelOf(a1))
end

function u52.ColorOf(a1) -- Line: 122 -- upvalues: template (val), u16 (val), u20 (val)
    local v1 = template()
    local Attribute = if not v1 then nil else v1:GetAttribute(u16[a1])
    if typeof(Attribute) == "Color3" then
        return Attribute
    end
    return u20[a1]
end

function u52.LightColorOf(a1) -- Line: 129 -- upvalues: template (val), u17 (val), u36 (val)
    local v1 = template()
    local Attribute = if not v1 then nil else v1:GetAttribute(u17[a1])
    if typeof(Attribute) == "Color3" then
        return Attribute
    end
    return u36[a1]
end

function u52.GradientOf(a1) -- Line: 136 -- upvalues: u52 (val)
    local v1 = u52.ColorOf(a1)
    return ColorSequence.new({
        ColorSequenceKeypoint.new(0, v1),
        ColorSequenceKeypoint.new(0.5, u52.LightColorOf(a1)),
        (ColorSequenceKeypoint.new(1, v1)),
    })
end

function u52.ChatTag(a1) -- Line: 146 -- upvalues: u52 (val), chatBadge (val)
    local v1 = u52.RoleOf(a1)
    if v1 == nil then
        return nil
    end
    return chatBadge(u52.ChatLabelOf(v1), u52.ColorOf(v1))
end

return u52