-- Script path: ReplicatedStorage.Client.UI.TopText
-- Decompile time: 6.97 ms

local Debris = game:GetService("Debris")
local GamepadService = game:GetService("GamepadService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local u25 = {Response_UI = true, Talk_UI = true}
local u33 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local u41 = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0)
local Talk_UI = ReplicatedStorage.Assets.UI.Npcs.Talk_UI
local Response_UI = ReplicatedStorage.Assets.UI.Npcs.Response_UI
local Option_UI = ReplicatedStorage.Assets.UI.Npcs.Option_UI
local Response_Text = SoundService.Response_Text
local v1 = {}
task.wait(1)

local function jitter(a1) -- Line: 36 -- types: a1: number
    return 1 + math.random(-a1, a1) / 100
end

local function eachScript(a1, a2) -- Line: 38 -- types: a1: userdata, a2: function
    for i, j in a1:GetDescendants() do
        if j:IsA("BaseScript") then
            a2(j)
        end
    end
end

local function switchOn(a1) -- Line: 46 -- types: a1: userdata
    a1.Enabled = true
end

local function discard(a1) -- Line: 48 -- types: a1: userdata
    a1:Destroy()
end

local function revealNpcText(a1, a2) -- Line: 50 -- upvalues: SoundService (val) -- types: a1: userdata, a2: string?
    local v1 = string.len((a1.Text:gsub("<.->", "")))
    local NPC_Text = a2 and SoundService.NPC_SFX:FindFirstChild(a2) or SoundService.NPC_Text
    a1.MaxVisibleGraphemes = 0
    while v1 >= 1 do
        task.wait()
        if 0.07 < NPC_Text.TimePosition or NPC_Text.Playing == false then
            NPC_Text.TimePosition = 0
            NPC_Text.Playing = true
            NPC_Text.PlaybackSpeed = 1 + math.random(-5, 5) / 100
        end
        v1 = v1 - 1
        a1.MaxVisibleGraphemes = a1.MaxVisibleGraphemes + 1
    end
end

local function revealPlayerText(a1) -- Line: 69
    -- upvalues: Response_Text (val), SoundService (val), Debris (val)
    local v1, v2
    local v3 = string.len((a1.Text:gsub("<.->", "")))
    local v4 = v3
    a1.MaxVisibleGraphemes = 0
    while v4 >= 1 do
        task.wait()
        if math.floor(v4 / 3) * 3 == v4 or v4 == v3 then
            v2 = Response_Text:Clone()
            v2.Parent = SoundService
            v2.Name = "SFX"
            v2.PlaybackSpeed = 1 + math.random(-15, 15) / 100
            v2.Playing = true
            Debris:AddItem(v2, v2.TimeLength * v2.PlaybackSpeed)
        end
        v4 = v4 - 1
        v1.MaxVisibleGraphemes = v1.MaxVisibleGraphemes + 1
    end
end

local function restockScripts(a1, a2, a3) -- Line: 91 -- types: a1: userdata, a2: userdata, a3: boolean
    local v1
    local v2, v3 = a2, a3
    for i, j in a1:GetDescendants() do
        if j:IsA("BaseScript") then
            for k, n in v2:GetDescendants() do
                if n.Name == j.Parent.Name then
                    if v3 then
                        j.Enabled = false
                    end
                    v1 = j:Clone()
                    v1.Parent = n
                    v1.Enabled = true
                end
            end
        end
    end
end

local function raiseBubble(a1, a2, a3, a4, a5, a6, a7) -- Line: 113
    -- upvalues: Talk_UI (val), eachScript (val), discard (val), revealNpcText (val), revealPlayerText (val)
    -- upvalues: switchOn (val), restockScripts (val)
    local Head = a2.Head
    local v1 = Head:FindFirstChild(Talk_UI.Name)
    local v2 = v1
    local v3 = a4 == true
    if v2 == nil then
        v2 = a1:Clone()
        v2.Parent = Head
    elseif v3 then
        eachScript(v2, discard)
    end
    v2.TextLabel.Text = a3
    if not a5 then
        revealPlayerText(v2.TextLabel)
    else
        revealNpcText(v2.TextLabel, a6)
    end
    if v3 and v1 == nil then
        eachScript(v2, switchOn)
        return v2
    end
    if v3 then
        restockScripts(a1, v2, a7)
    end
    return v2
end

local function clearSideFrame(a1) -- Line: 150 -- types: a1: userdata
    for i, j in a1.PlayerGui.Billboard_UI:GetChildren() do
        if j.Name ~= "UIListLayout" then
            j:Destroy()
        end
    end
end

function v1.Speak(a1, a2, a3) -- Line: 158
    -- upvalues: raiseBubble (val), Talk_UI (val)
    return (raiseBubble(Talk_UI, a1, a2, a3, true, a1.Name, false))
end

function v1.Reply(a1, a2, a3) -- Line: 162
    -- upvalues: raiseBubble (val), Talk_UI (val)
    return (raiseBubble(Talk_UI, a1, a2, a3, true, nil, true))
end

function v1.Echo(a1, a2, a3) -- Line: 166
    -- upvalues: raiseBubble (val), Response_UI (val)
    if a2 == nil then
        return
    end
    return (raiseBubble(Response_UI, a1, a2, a3, false, nil, true))
end

function v1.OfferChoices(a1, a2) -- Line: 174
    -- upvalues: Option_UI (val), TweenService (val), u33 (val), Debris (val), GamepadService (val)
    local UIPadding, v1, v2
    local v3 = {}
    local v4 = 0
    for k, v in pairs(a2) do
        v4 = v4 + 1
        v2 = Option_UI:Clone()
        v2.Parent = a1.PlayerGui.Billboard_UI
        v2.Frame.Frame.Text_Element.Text = v
        v2.Frame.Frame.TextLabel.Text = (tostring(v4)) .. "."
        UIPadding = v2.Frame.Frame.Text_Element.UIPadding
        UIPadding.PaddingLeft = UDim.new(string.len(v) * 0.001 + 0.04, 0)
        v1 = TweenService:Create(UIPadding, u33, {PaddingLeft = UDim.new(0, 0)})
        v1:Play()
        Debris:AddItem(v1, u33.Time)
        table.insert(v3, v2)
        v2.Frame.Frame.Text_Element:SetAttribute("Text", v)
        task.wait(0.075)
    end
    if v3[1] then
        GamepadService:EnableGamepadCursor(v3[1])
    end
    return v3
end

function v1.FadeOut(a1, a2) -- Line: 203
    -- upvalues: clearSideFrame (val), u25 (val), TweenService (val), u41 (val), Debris (val)
    local Time, v1
    clearSideFrame(a2)
    for i, j in a1.Head:GetChildren() do
        if j:IsA("BillboardGui") and u25[j.Name] then
            for k, n in j:GetChildren() do
                if n:IsA("TextLabel") then
                    TweenService:Create(n, u41, {TextTransparency = 1}):Play()
                elseif n:IsA("ImageLabel") then
                    TweenService:Create(n, u41, {ImageTransparency = 1}):Play()
                end
            end
            v1 = Debris
            Time = u41.Time
            v1:AddItem(j, Time)
        end
    end
end

function v1.ClearChoices(a1) -- Line: 221 -- upvalues: clearSideFrame (val), GamepadService (val) -- types: a1: userdata
    clearSideFrame(a1)
    GamepadService:DisableGamepadCursor()
end

return v1