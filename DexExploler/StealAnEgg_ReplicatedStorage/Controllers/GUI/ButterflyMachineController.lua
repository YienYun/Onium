-- Script path: ReplicatedStorage.Controllers.GUI.ButterflyMachineController
-- Decompile time: 10.06 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ButterflyCatalog = require(ReplicatedStorage.Shared.Modules.ButterflyCatalog)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GUI = require(ReplicatedStorage.Client.GUI)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local u51 = {
    {Button = "Recipe1", From = "Green"},
    {Button = "Recipe2", From = "Blue"},
    {Button = "Recipe3", From = "Purple"},
}
local u59 = Color3.fromRGB(255, 120, 120)
local u64 = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u65 = {"SunburstBack", "StarDecor"}
local u70 = TryLock(8)
local v1 = {}

local function child(a1, a2) -- Line: 44 -- types: a1: userdata, a2: string
    local v1 = a1:FindFirstChild(a2)
    assert(v1, (("%* needs a child named %*"):format(a1:GetFullName(), a2)))
    return v1
end

local function counts() -- Line: 50 -- upvalues: Save (val)
    local Butterflies
    local v1 = if not Save.IsLoaded() then nil else Save.Peek()
    if typeof(if not v1 then nil else v1.Butterflies) ~= "table" then
        return {Green = 0, Blue = 0, Purple = 0, Golden = 0}
    end
    return Butterflies.Counts
end

local function plural(a1) -- Line: 59 -- types: a1: string
    return (string.gsub(a1, "Butterfly$", "Butterflies"))
end

local function setText(a1, a2) -- Line: 63 -- types: a1: userdata?, a2: string
    if a1 and a1:IsA("TextLabel") then
        a1.Text = a2
    end
end

local function setEnabled(a1, a2) -- Line: 69 -- types: a1: userdata, a2: boolean
    a1.Active = a2
    a1.AutoButtonColor = false
    a1:SetAttribute("Disabled", not a2)
    local v1, v2 = a2, a1
    for i, j in a1:GetDescendants() do
        if j:IsA("TextLabel") then
            j.TextTransparency = if not v1 then 0.45 else 0
        end
    end
    v2.BackgroundTransparency = if not v1 then 0.45 else 0
end

local function pop(a1) -- Line: 81 -- upvalues: TweenService (val), u64 (val) -- types: a1: userdata
    local PopScale = a1:FindFirstChild("PopScale")
    if PopScale == nil then
        local UIScale = Instance.new("UIScale")
        UIScale.Name = "PopScale"
        UIScale.Parent = a1
        PopScale = UIScale
    end
    local v1 = PopScale
    v1.Scale = 1.12
    TweenService:Create(v1, u64, {Scale = 1}):Play()
end

local function deny(a1) -- Line: 94
    -- upvalues: Audio (val), ButterflyCatalog (val), Toast (val), u59 (val)
    Audio.Play(ButterflyCatalog.Sounds.Deny, script, {Volume = 0.6})
    if a1 then
        Toast.Show({Lane = "Feed", Seconds = 2.5, Text = a1, Color = u59})
    end
end

local function request(a1, ...) -- Line: 101 -- upvalues: u70 (val) -- types: a1: userdata
    local u3 = table.pack(...)
    local v1, v2, v3, v4 = u70(function() -- Line: 103 -- upvalues: a1 (val), u3 (val)
        local success = pcall(function() -- Line: 104 -- upvalues: a1 (upval), u3 (upval)
            return a1:InvokeServer((table.unpack(u3, 1, u3.n)))
        end)
        return success
    end)
    if v1 and v2 then
        local v5 = v3 == true
        if typeof(v4) == "string" then
            return v5, v4
        end
        return v5, nil
    end
    return false, nil
end

function v1.Start() -- Line: 118
    -- upvalues: GUI (val), u65 (val), counts (val), ButterflyCatalog (val), u51 (val), setEnabled (val), ButtonFX (val)
    -- upvalues: deny (val), request (val), Remotes (val), Audio (val), pop (val), Toast (val), Save (val), Tabs (val)
    local ButterflyMachine = GUI.Get("ButterflyMachine")
    local Frame = ButterflyMachine:FindFirstChild("Frame")
    assert(Frame, (("%* needs a child named Frame"):format((ButterflyMachine:GetFullName()))))
    local Collection = Frame:FindFirstChild("Collection")
    assert(Collection, (("%* needs a child named Collection"):format((Frame:GetFullName()))))
    local v1 = Collection:FindFirstChild("TradeUp")
    assert(v1, (("%* needs a child named TradeUp"):format((Collection:GetFullName()))))
    local Recipes = v1:FindFirstChild("Recipes")
    assert(Recipes, (("%* needs a child named Recipes"):format((v1:GetFullName()))))
    local TradeButton = v1:FindFirstChild("TradeButton")
    assert(TradeButton, (("%* needs a child named TradeButton"):format((v1:GetFullName()))))
    local SlotTemplates = ButterflyMachine:FindFirstChild("SlotTemplates")
    assert(SlotTemplates, (("%* needs a child named SlotTemplates"):format((ButterflyMachine:GetFullName()))))
    local v2 = v1:FindFirstChild("InputSlot")
    assert(v2, (("%* needs a child named InputSlot"):format((v1:GetFullName()))))
    local OutputSlot = v1:FindFirstChild("OutputSlot")
    assert(OutputSlot, (("%* needs a child named OutputSlot"):format((v1:GetFullName()))))
    local Position = v2.Position
    local Position_2 = OutputSlot.Position
    local u210 = nil
    for i, j in Collection:GetChildren() do
        if j.Name == "Hint" and j:IsA("TextLabel") and string.find(j.Text, "Uses") then
            u210 = j
        end
    end
    local u133 = "Green"
    local u134 = nil
    local u135 = nil
    local u137 = v2
    local u139 = OutputSlot

    local function placeSlot(a1, a2, a3, a4, a5) -- Line: 143
        -- upvalues: SlotTemplates (val), u65 (upval)
        local v1 = SlotTemplates:FindFirstChild(a2)
        if v1 ~= nil and v1:IsA("GuiObject") then
            local v2 = v1:Clone()
            v2.Name = a3
            v2.Position = a4
            v2.Visible = true
            local v3 = nil
            local v4 = nil
            local v5 = a1
            for i, j in u65, v3, v4 do
                for k, n in v2:GetChildren() do
                    if n.Name == j and n:IsA("GuiObject") then
                        n.Visible = v6
                    end
                end
            end
            v2.Parent = v5.Parent
            v5:Destroy()
            return v2
        end
        return a1
    end

    local function render() -- Line: 170
        -- upvalues: counts (upval), ButterflyCatalog (upval), u133 (ref), u134 (ref), u137 (ref), placeSlot (val)
        -- upvalues: Position (val), u135 (ref), u139 (ref), Position_2 (val), u210 (ref), u51 (upval), Recipes (val)
        -- upvalues: setEnabled (upval), TradeButton (val)
        local v1
        local v2 = counts()
        local v3 = ButterflyCatalog.Get(u133)
        local Next = v3.Next
        local v4 = ButterflyCatalog.Get(Next)
        local v5 = ButterflyCatalog.TradeUpCost(u133) or 0
        local v6 = v2[u133] or 0
        if u134 ~= u133 then
            u137 = placeSlot(u137, u133, "InputSlot", Position, false)
            u134 = u133
        end
        if u135 ~= Next then
            u139 = placeSlot(u139, Next, "OutputSlot", Position_2, true)
            u135 = Next
        end
        local Quantity = u137:FindFirstChild("Quantity")
        local v7 = ("<font color=\"%*\">%*</font> / %*"):format(if not (v5 <= v6) then "#FF6B6B" else "#7CFF6B", v6, v5)
        if Quantity and Quantity:IsA("TextLabel") then
            Quantity.Text = v7
        end
        local Quantity_2 = u139:FindFirstChild("Quantity")
        if Quantity_2 and Quantity_2:IsA("TextLabel") then
            Quantity_2.Text = "x1"
        end
        if u210 then
            u210.Text = ("Uses %* %* to make 1 %*"):format(v5, string.gsub(v3.DisplayName, "Butterfly$", "Butterflies"), v4.DisplayName)
        end
        v7 = nil
        local v8 = nil
        for i, j in u51, v7, v8 do
            v4 = Recipes:FindFirstChild(j.Button)
            if v4 ~= nil then
                v1 = ButterflyCatalog.TradeUpCost(j.From) or 0
                v3 = v4:FindFirstChild("Amount")
                if v3 and v3:IsA("TextLabel") then
                    v3.Text = string.gsub(v3.Text, "^%d+", (tostring(v1)))
                end
                v1 = v4:FindFirstChild("SelectStroke")
                if v1 and v1:IsA("UIStroke") then
                    v1.Enabled = j.From == u133
                end
            end
        end
        local v9 = setEnabled
        v8 = false
        if v5 <= v6 then
            v8 = v5 > 0
        end
        v9(TradeButton, v8)
    end

    for k, n in u51 do
        v2 = Recipes:FindFirstChild(n.Button)
        if v2 ~= nil and v2:IsA("GuiButton") then
            ButtonFX(v2)
            GUI.OnActivated(v2, function() -- Line: 220 -- upvalues: u133 (ref), n (val), render (val)
                if u133 == n.From then
                    return
                end
                u133 = n.From
                render()
            end)
        end
    end
    ButtonFX(TradeButton)
    GUI.OnActivated(TradeButton, function() -- Line: 230
        -- upvalues: ButterflyCatalog (upval), u133 (ref), TradeButton (val), deny (upval), request (upval)
        -- upvalues: Remotes (upval), Audio (upval), pop (upval), u139 (ref), Toast (upval)
        local v1 = ButterflyCatalog.TradeUpCost(u133) or 0
        local v2 = ButterflyCatalog.Get(u133)
        if TradeButton:GetAttribute("Disabled") == true then
            deny((("Collect %* %* to trade up!"):format(v1, (string.gsub(v2.DisplayName, "Butterfly$", "Butterflies")))))
            return
        end
        local v3, v4 = request(Remotes.Butterflies.AskTradeUp, u133)
        if not v3 then
            deny(v4)
            return
        end
        v4 = ButterflyCatalog.Get(v2.Next)
        Audio.Play(ButterflyCatalog.Sounds.Craft, script, {Volume = 0.7})
        pop(u139)
        Toast.Show({
            Lane = "Feed",
            Seconds = 2.5,
            Text = ("Traded up for a %*!"):format(v4.DisplayName),
            Color = v4.Color,
            StrokeColor = v4.StrokeColor,
            Image = v4.Icon,
        })
    end)
    Save.WatchFields("Butterflies", render)
    Tabs.Activated:Connect(function(a1) -- Line: 256 -- upvalues: render (val) -- types: a1: string
        if a1 == "ButterflyMachine" then
            render()
        end
    end)
    render()
end

return v1