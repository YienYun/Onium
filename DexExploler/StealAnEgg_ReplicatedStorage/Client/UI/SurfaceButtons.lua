-- Script path: ReplicatedStorage.Client.UI.SurfaceButtons
-- Decompile time: 1.15 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Packages.t)
local u14 = t.strict(t.instanceIsA("BasePart"))
local u17 = t.strict(t.string)
local v1 = {}

local function buttonWithin(a1, a2) -- Line: 12 -- types: a1: userdata, a2: string
    local v1 = a1:FindFirstChild(a2, true)
    if v1 and v1:IsA("GuiButton") then
        return v1
    end
    return nil
end

function v1.Find(a1, a2) -- Line: 17 -- upvalues: u14 (val), u17 (val) -- types: a1: userdata, a2: string
    local v1, v2
    u14(a1)
    u17(a2)
    local Children = a1:GetChildren()
    local v3 = 1
    local v4 = nil
    while v4 == nil do
        if not (v3 <= #Children) then
            break
        end
        v1 = Children[v3]
        if not v1:IsA("SurfaceGui") then
            v4 = nil
        else
            v2 = v1:FindFirstChild(a2, true)
            v4 = if not v2 then nil else if not v2:IsA("GuiButton") then nil else v2
        end
        v3 = v3 + 1
    end
    return v4
end

return v1