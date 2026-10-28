-- Script path: ReplicatedStorage.Client.Modules.BulkFade
-- Decompile time: 3.80 ms

local TweenService = game:GetService("TweenService")
local u8 = TweenInfo.new(1, Enum.EasingStyle.Cubic)
local u9 = {ImageButton = true, ImageLabel = true}
local u12 = {TextLabel = true, TextButton = true, TextBox = true}
local u16 = {ScrollingFrame = true}

local function GetTransparencyProperties(a1) -- Line: 46 -- upvalues: u9 (val), u12 (val), u16 (val)
    local u1 = {}
    pcall(function() -- Line: 48 -- upvalues: a1 (val), u1 (val)
        if a1.Transparency and type(a1.Transparency) ~= "userdata" and not a1:IsA("GuiBase") then
            u1.Transparency = a1.Transparency
        end
    end)
    pcall(function() -- Line: 53 -- upvalues: a1 (val), u1 (val)
        if a1.BackgroundTransparency and type(a1.BackgroundTransparency) ~= "userdata" then
            u1.BackgroundTransparency = a1.BackgroundTransparency
        end
    end)
    if u9[a1.ClassName] then
        u1.ImageTransparency = a1.ImageTransparency
    end
    if u12[a1.ClassName] then
        u1.TextTransparency = a1.TextTransparency
        u1.TextStrokeTransparency = a1.TextStrokeTransparency
    end
    if u16[a1.ClassName] then
        u1.ScrollBarImageTransparency = a1.ScrollBarImageTransparency
    end
    if u1 ~= {} then
        return u1
    end
end

local function ReturnPropertiesAtValue(a1, a2) -- Line: 80 -- types: a1: table, a2: number
    local v1
    local v2, v3 = a1, a2
    for k, v in pairs(a1) do
        v1 = if v2[k] ~= 1 then v3 else 1
        v2[k] = v1
    end
    return v2
end

local u20 = {}
u20.__index = u20

function u20.new(a1, a2, a3) -- Line: 104 -- upvalues: u20 (val), u8 (val) -- types: a2: userdata, a3: number?
    local v1
    local v2 = setmetatable({}, u20)
    v2.TweenInfo = a2 or u8
    v2.AppearTweens = {}
    v2.DisappearTweens = {}
    v2.Elements = {}
    v2.GoalTransparency = a3 or 1
    v2.new = nil
    if type(a1) == "table" then
        v1 = a1
    else
        local v3 = {}
        local Descendants = a1:GetDescendants()
        v3[1] = a1
        v3[2] = table.unpack(Descendants)
        v1 = v3
    end
    v2:AddObject(v1)
    return v2
end

function u20:AddObject(a2) -- Line: 127 -- upvalues: GetTransparencyProperties (val), TweenService (val)
    if type(a2) == "table" then
        for i, i2 in ipairs(a2) do
            self:AddObject(i2)
        end
        return
    end
    local v1 = GetTransparencyProperties(a2)
    if v1 then
        local v2
        table.insert(self.Elements, a2)
        self.AppearTweens[a2] = (TweenService:Create(a2, self.TweenInfo, v1))
        local DisappearTweens = self.DisappearTweens
        local TweenInfo_2 = self.TweenInfo
        for k, v in pairs(v1) do
            v2 = if v1[k] ~= 1 then self.GoalTransparency else 1
            v1[k] = v2
        end
        DisappearTweens[a2] = (TweenService:Create(a2, TweenInfo_2, v1))
    end
end

function u20:RemoveObject(a2) -- Line: 147
    if type(a2) == "table" then
        for i, v in ipairs(a2) do
            self:RemoveObject(v)
        end
        return
    end
    self.AppearTweens[a2] = nil
    self.DisappearTweens[a2] = nil
    local v1 = table.find(self.Elements, a2)
    if v1 then
        table.remove(self.Elements, v1)
    end
end

function u20.FadeOut(a1) -- Line: 163
    for k, v in pairs(a1.DisappearTweens) do
        v:Play()
    end
    return a1.DisappearTweens[a1.Elements[1]].Completed
end

function u20.FadeOutInstant(a1) -- Line: 170 -- upvalues: GetTransparencyProperties (val)
    local v1 = nil
    local v2 = nil
    for i, j in a1.Elements, v1, v2 do
        for k in (GetTransparencyProperties(j)) do
            j[k] = 1
        end
    end
end

function u20.FadeIn(a1) -- Line: 179
    for k, v in pairs(a1.AppearTweens) do
        v:Play()
    end
    return a1.AppearTweens[a1.Elements[1]].Completed
end

return (setmetatable(u20, {__call = u20.new}))