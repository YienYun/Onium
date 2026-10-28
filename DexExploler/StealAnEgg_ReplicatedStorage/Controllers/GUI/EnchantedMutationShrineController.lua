-- Script path: ReplicatedStorage.Controllers.GUI.EnchantedMutationShrineController
-- Decompile time: 7.88 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ButterflyCatalog = require(ReplicatedStorage.Shared.Modules.ButterflyCatalog)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Flash = require(ReplicatedStorage.Client.UI.VFX.Flash)
local GUI = require(ReplicatedStorage.Client.GUI)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local u62 = Color3.fromRGB(124, 255, 107)
local u67 = Color3.fromRGB(255, 255, 255)
local u72 = Color3.fromRGB(255, 120, 120)
local u77 = Color3.fromRGB(110, 255, 190)
local u82 = Color3.fromRGB(10, 60, 40)
local u87 = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u90 = TryLock(8)
local v1 = {}

local function child(a1, a2) -- Line: 41 -- types: a1: userdata, a2: string
    local v1 = a1:FindFirstChild(a2)
    assert(v1, (("%* needs a child named %*"):format(a1:GetFullName(), a2)))
    return v1
end

local function counts() -- Line: 47 -- upvalues: Save (val)
    local Butterflies
    local v1 = if not Save.IsLoaded() then nil else Save.Peek()
    if typeof(if not v1 then nil else v1.Butterflies) ~= "table" then
        return {Green = 0, Blue = 0, Purple = 0, Golden = 0}
    end
    return Butterflies.Counts
end

local function setText(a1, a2, a3) -- Line: 56 -- types: a1: userdata?, a2: string, a3: userdata?
    if a1 and a1:IsA("TextLabel") then
        a1.Text = a2
        if a3 then
            a1.TextColor3 = a3
        end
    end
end

local function pop(a1) -- Line: 65 -- upvalues: TweenService (val), u87 (val) -- types: a1: userdata
    local PopScale = a1:FindFirstChild("PopScale")
    if PopScale == nil then
        local UIScale = Instance.new("UIScale")
        UIScale.Name = "PopScale"
        UIScale.Parent = a1
        PopScale = UIScale
    end
    local v1 = PopScale
    v1.Scale = 1.12
    TweenService:Create(v1, u87, {Scale = 1}):Play()
end

local function deny(a1) -- Line: 78
    -- upvalues: Audio (val), ButterflyCatalog (val), Toast (val), u72 (val)
    Audio.Play(ButterflyCatalog.Sounds.Deny, script, {Volume = 0.6})
    if a1 then
        Toast.Show({Lane = "Feed", Seconds = 2.5, Text = a1, Color = u72})
    end
end

local function request(a1) -- Line: 85 -- upvalues: u90 (val) -- types: a1: userdata
    local v1, v2, v3, v4 = u90(function() -- Line: 86 -- upvalues: a1 (val)
        local success = pcall(function() -- Line: 87 -- upvalues: a1 (upval)
            return a1:InvokeServer()
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

function v1.Start() -- Line: 101
    -- upvalues: GUI (val), ButterflyCatalog (val), counts (val), u62 (val), u67 (val), ButtonFX (val), Remotes (val)
    -- upvalues: u90 (val), deny (val), Audio (val), Flash (val), u77 (val), pop (val), Toast (val), u82 (val)
    -- upvalues: Save (val), Tabs (val)
    local DisplayName, ItemName_2
    local EnchantedMutationShrine = GUI.Get("EnchantedMutationShrine")
    local Frame = EnchantedMutationShrine:FindFirstChild("Frame")
    assert(Frame, (("%* needs a child named Frame"):format((EnchantedMutationShrine:GetFullName()))))
    local v1 = Frame:FindFirstChild("ContentFrame")
    assert(v1, (("%* needs a child named ContentFrame"):format((Frame:GetFullName()))))
    local RequirementsHolder = v1:FindFirstChild("RequirementsHolder")
    assert(RequirementsHolder, (("%* needs a child named RequirementsHolder"):format((v1:GetFullName()))))
    local Result = RequirementsHolder:FindFirstChild("Result")
    assert(Result, (("%* needs a child named Result"):format((RequirementsHolder:GetFullName()))))
    local Claim = v1:FindFirstChild("Claim")
    assert(Claim, (("%* needs a child named Claim"):format((v1:GetFullName()))))
    local VaultInComplete = v1:FindFirstChild("VaultInComplete")
    local ItemName = Result:FindFirstChild("ItemName")
    local EssenceName = ButterflyCatalog.EssenceName
    if ItemName and ItemName:IsA("TextLabel") then
        ItemName.Text = EssenceName
    end
    if VaultInComplete then
        local txt = VaultInComplete:FindFirstChild("txt")
        if txt and txt:IsA("TextLabel") then
            txt.Text = "Need More Butterflies"
        end
    end
    for i, j in ButterflyCatalog.Order do
        v1 = RequirementsHolder:FindFirstChild(j)
        if v1 then
            ItemName_2 = v1:FindFirstChild("ItemName")
            DisplayName = (ButterflyCatalog.Get(j)).DisplayName
            if ItemName_2 and ItemName_2:IsA("TextLabel") then
                ItemName_2.Text = DisplayName
            end
        end
    end

    local function render() -- Line: 121
        -- upvalues: counts (upval), ButterflyCatalog (upval), RequirementsHolder (val), u62 (upval), u67 (upval)
        -- upvalues: Claim (val), VaultInComplete (val)
        local Quantity, v1, v2, v3, v4, v5, v6
        local v7 = counts()
        local v8 = ButterflyCatalog.EssenceRecipe()
        local v9 = true
        local v10 = nil
        local v11 = nil
        for i, j in ButterflyCatalog.Order, v10, v11 do
            v5 = v7[j] or 0
            v6 = v8[j]
            v1 = v6 <= v5
            v9 = v9 and v1
            v2 = RequirementsHolder:FindFirstChild(j)
            if v2 then
                Quantity = v2:FindFirstChild("Quantity")
                v3 = ("%*/%*"):format(math.min(v5, v6), v6)
                v4 = if not v1 then u67 else u62
                if Quantity and Quantity:IsA("TextLabel") then
                    Quantity.Text = v3
                    if v4 then
                        Quantity.TextColor3 = v4
                    end
                end
            end
        end
        Claim.Visible = v9 or VaultInComplete == nil
        if VaultInComplete then
            VaultInComplete.Visible = not v9
        end
    end

    ButtonFX(Claim)
    GUI.OnActivated(Claim, function() -- Line: 146
        -- upvalues: Remotes (upval), u90 (upval), deny (upval), Audio (upval), ButterflyCatalog (upval), Flash (upval)
        -- upvalues: u77 (upval), pop (upval), Result (val), Toast (upval), u82 (upval)
        local v1, v2
        local AskCraftEssence = Remotes.Butterflies.AskCraftEssence
        local v3, v4, v5, v6 = u90(function() -- Line: 86 -- upvalues: AskCraftEssence (val)
            local success = pcall(function() -- Line: 87 -- upvalues: AskCraftEssence (upval)
                return AskCraftEssence:InvokeServer()
            end)
            return success
        end)
        if not v3 then
            v1 = false
            v2 = nil
        elseif v4 then
            v1 = v5 == true
            v2 = if typeof(v6) ~= "string" then nil else v6
        else
            v1 = false
            v2 = nil
        end
        if not v1 then
            deny(v2)
            return
        end
        Audio.Play(ButterflyCatalog.Sounds.Craft, script, {Volume = 0.85})
        Flash.Play({Attack = 0.05, Decay = 0.5, Opacity = 0.35, Tint = u77})
        pop(Result)
        Toast.Show({
            Lane = "Banner",
            Seconds = 3.5,
            ShowShadow = true,
            Text = ("You made an %*!"):format(ButterflyCatalog.EssenceName),
            Color = u77,
            StrokeColor = u82,
            Image = ButterflyCatalog.Icons.Essence,
        })
    end)
    if VaultInComplete then
        ButtonFX(VaultInComplete)
        GUI.OnActivated(VaultInComplete, function() -- Line: 167 -- upvalues: deny (upval)
            deny("The altar needs more butterflies.")
        end)
    end
    Save.WatchFields("Butterflies", render)
    Tabs.Activated:Connect(function(a1) -- Line: 173 -- upvalues: render (val) -- types: a1: string
        if a1 == "EnchantedMutationShrine" then
            render()
        end
    end)
    render()
end

return v1