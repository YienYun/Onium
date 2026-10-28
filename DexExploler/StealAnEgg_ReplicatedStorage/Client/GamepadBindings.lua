-- Script path: ReplicatedStorage.Client.GamepadBindings
-- Decompile time: 22.82 ms

local ownerAbove, showing
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local ConsoleSignals = require(ReplicatedStorage.Client.ConsoleSignals)
local GUI = require(ReplicatedStorage.Client.GUI)
local InputIconsConfig = require(ReplicatedStorage.Client.InputIconsConfig)
local Log = require(ReplicatedStorage.Packages.Log)
local MenuNavigation = require(ReplicatedStorage.Client.MenuNavigation)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local ButtonB = Enum.KeyCode.ButtonB
local v1 = {
    Enum.KeyCode.ButtonA,
    Enum.KeyCode.ButtonB,
    Enum.KeyCode.ButtonX,
    Enum.KeyCode.ButtonY,
    Enum.KeyCode.ButtonL1,
    Enum.KeyCode.ButtonL2,
    Enum.KeyCode.ButtonL3,
    Enum.KeyCode.ButtonR1,
    Enum.KeyCode.ButtonR2,
    Enum.KeyCode.ButtonR3,
    Enum.KeyCode.ButtonSelect,
    Enum.KeyCode.ButtonStart,
    Enum.KeyCode.DPadDown,
    Enum.KeyCode.DPadLeft,
    Enum.KeyCode.DPadRight,
    Enum.KeyCode.DPadUp,
}
local v2 = {[Enum.KeyCode.ButtonStart] = true}
local u65 = {
    [Enum.KeyCode.DPadDown] = true,
    [Enum.KeyCode.DPadLeft] = true,
    [Enum.KeyCode.DPadRight] = true,
    [Enum.KeyCode.DPadUp] = true,
}
local u74 = {}
local u75 = {}
for i, j in v1 do
    u74[j.Name] = j
    u75[j] = true
end
assert(u75[ButtonB], "the close key has to be a routable key")
local u92 = {
    ActivePets = {rank = 900, captionedClose = true},
    BackpackGui = {blocked = true},
    BossMastery = {captionedClose = true},
    BossShop = {captionedClose = true},
    ButterflyMachine = {captionedClose = true},
    EnchantedMutationShrine = {captionedClose = true},
    DogsMemoriesFrame = {captionedClose = true},
    DropHeldEgg = {rank = 200},
    FreeGift = {captionedClose = true},
    GrowingEggs = {rank = 900, captionedClose = true},
    Index = {captionedClose = true},
    LimitedTimePopupsUI = {captionedClose = true},
    Message = {rank = 1000},
    MonsterChestRewards = {captionedClose = true},
    PetFuse = {captionedClose = true},
    PhoneVideoUI = {blocked = true},
    PopupPrompt = {captionedClose = true},
    RescueDragonFTUEQuest = {captionedClose = true},
    RiftTradeIn = {captionedClose = true},
    DrScrambleTradeIn = {captionedClose = true},
    RobuxShop = {captionedClose = true},
    RobuxShopOLD = {blocked = true},
    OldRobuxShop = {blocked = true},
    RunButton = {rank = 100},
    ScrambleBossMastery = {captionedClose = true},
    HalloweenBossMastery = {captionedClose = true},
    SellPrompt = {captionedClose = true},
    Settings = {captionedClose = true},
    SpeedShop = {blocked = true},
    TrailShop = {captionedClose = true},
    Treadmill = {blocked = true},
    TreadmillScreenButtonSwapLeft = {blocked = true},
    TreadmillScreenButtonSwapRight = {blocked = true},
    TreadmillScreenComments = {blocked = true},
    TreadmillUI = {blocked = true},
}
local u130 = table.freeze({})
local u131 = {microsoft = "B", sony = "O"}
local u132 = {}
local u135 = Log.new()
local u139 = GUI.PlayerGui()
local u140 = {}
local u141 = {}
local u142 = {}
local u143 = {}
local u144 = nil
local u145 = nil
local u146 = nil
local u147 = true

local function describe(a1) -- Line: 143 -- types: a1: userdata?
    if a1 ~= nil then
        return (a1:GetFullName())
    end
    return "none"
end

local function policyOf(a1) -- Line: 147 -- upvalues: u92 (val), u130 (val) -- types: a1: string
    return u92[a1] or u130
end

local function screenOf(a1) -- Line: 151 -- types: a1: userdata
    if a1:IsA("ScreenGui") then
        return a1
    end
    return (a1:FindFirstAncestorOfClass("ScreenGui"))
end

local function blocked(a1) -- Line: 155 -- upvalues: u92 (val), u130 (val) -- types: a1: userdata
    local v1 = if not a1:IsA("LayerCollector") then a1:FindFirstAncestorWhichIsA("LayerCollector") else a1
    local v2 = false
    if v1 ~= nil then
        local v3 = u92[v1.Name] or u130
        v2 = v3.blocked == true
    end
    return v2
end

function showing(a1) -- Line: 164 -- upvalues: showing (val) -- types: a1: userdata
    if a1:IsA("LayerCollector") then
        return a1.Enabled
    end
    if a1:IsA("GuiObject") and not a1.Visible then
        return false
    end
    local Parent = a1.Parent
    local v1 = false
    if Parent ~= nil then
        v1 = showing(Parent)
    end
    return v1
end

function ownerAbove(a1) -- Line: 177 -- upvalues: ownerAbove (val) -- types: a1: userdata
    local Parent = a1.Parent
    if Parent ~= nil and not Parent:IsA("ScreenGui") then
        if Parent:IsA("GuiButton") then
            return Parent
        end
        return (ownerAbove(Parent))
    end
    return nil
end

local function rankOf(a1) -- Line: 185 -- upvalues: u92 (val), u130 (val) -- types: a1: userdata
    local v1 = u92[a1.Name] or u130
    return v1.rank or a1.DisplayOrder
end

local function keyFrom(a1) -- Line: 189 -- upvalues: u74 (val), u75 (val)
    local v1 = if typeof(a1) ~= "EnumItem" then u74[a1] else a1
    if v1 == nil or not u75[v1] then
        error(("%* is not a key this router knows"):format((tostring(a1))), 3)
    end
    return v1
end

local function closeCaption() -- Line: 199 -- upvalues: u131 (val), u146 (ref), InputIconsConfig (val)
    return u131[u146 or InputIconsConfig.Vendor()]
end

local function artFor(a1) -- Line: 203 -- upvalues: u142 (val), InputIconsConfig (val)
    local v1 = u142[a1]
    if v1 ~= nil then
        return v1
    end
    v1 = InputIconsConfig.Image(a1) or ""
    u142[a1] = v1
    return v1
end

local function applyLook(a1) -- Line: 213
    -- upvalues: u141 (val), PlatformController (val), InputIconsConfig (val), ButtonB (val), u131 (val), u146 (ref)
    local v1 = u141[a1]
    if v1 == nil then
        return
    end
    local v2 = PlatformController.IsConsole()
    local image = v1.image
    local caption = v1.caption
    if image == nil then
        if caption ~= nil and a1:IsA("TextLabel") then
            a1.Text = if not v2 then caption else u131[u146 or InputIconsConfig.Vendor()]
        end
    elseif a1:IsA("ImageLabel") then
        a1.Image = v2 and InputIconsConfig.Image(ButtonB) or image
    elseif caption ~= nil and a1:IsA("TextLabel") then
        a1.Text = if not v2 then caption else u131[u146 or InputIconsConfig.Vendor()]
    end
    a1.Visible = v2 or v1.visible
end

local function remember(a1, a2) -- Line: 228 -- upvalues: u141 (val), applyLook (val) -- types: a1: userdata, a2: table
    if u141[a1] == nil then
        u141[a1] = a2
        a1.Destroying:Once(function() -- Line: 231 -- upvalues: u141 (upval), a1 (val)
            u141[a1] = nil
        end)
    end
    applyLook(a1)
end

local function rememberCaption(a1) -- Line: 238 -- upvalues: u141 (val), applyLook (val) -- types: a1: userdata?
    if a1 ~= nil and a1:IsA("TextLabel") then
        local v1 = {visible = a1.Visible, caption = a1.Text}
        if u141[a1] == nil then
            u141[a1] = v1
            a1.Destroying:Once(function() -- Line: 231 -- upvalues: u141 (upval), a1 (val)
                u141[a1] = nil
            end)
        end
        applyLook(a1)
    end
end

local function decorateClose(a1, a2) -- Line: 246
    -- upvalues: u141 (val), applyLook (val)
    local v1
    local TextButton = if not a2 then a1:FindFirstChild("TextButton") else nil
    if TextButton ~= nil and TextButton:IsA("ImageLabel") then
        v1 = {visible = TextButton.Visible, image = TextButton.Image}
        if u141[TextButton] == nil then
            u141[TextButton] = v1
            TextButton.Destroying:Once(function() -- Line: 231 -- upvalues: u141 (upval), TextButton (val)
                u141[TextButton] = nil
            end)
        end
        applyLook(TextButton)
        return
    end
    local TextLabel = a1:FindFirstChild("TextLabel")
    if TextLabel ~= nil and TextLabel:IsA("TextLabel") then
        v1 = {visible = TextLabel.Visible, caption = TextLabel.Text}
        if u141[TextLabel] == nil then
            u141[TextLabel] = v1
            TextLabel.Destroying:Once(function() -- Line: 231 -- upvalues: u141 (upval), TextLabel (val)
                u141[TextLabel] = nil
            end)
        end
        applyLook(TextLabel)
    end
    if a2 and TextLabel ~= nil then
        local TextLabel_2 = TextLabel:FindFirstChild("TextLabel")
        if TextLabel_2 ~= nil and TextLabel_2:IsA("TextLabel") then
            local v2 = {visible = TextLabel_2.Visible, caption = TextLabel_2.Text}
            if u141[TextLabel_2] == nil then
                u141[TextLabel_2] = v2
                TextLabel_2.Destroying:Once(function() -- Line: 231 -- upvalues: u141 (upval), TextLabel_2 (val)
                    u141[TextLabel_2] = nil
                end)
            end
            applyLook(TextLabel_2)
        end
    end
end

local function paintGlyph(a1, a2) -- Line: 259
    -- upvalues: PlatformController (val), u142 (val), InputIconsConfig (val)
    local v1 = PlatformController.IsConsole()
    a1.Visible = v1 and a1:GetAttribute("ManualVisibility") ~= true
    if v1 then
        if a1:IsA("ImageLabel") or a1:IsA("ImageButton") then
            local v2 = u142[a2]
            if v2 == nil then
                u142[a2] = InputIconsConfig.Image(a2) or ""
            end
            a1.Image = v2
        end
    end
end

local function releaseClaimsOn(a1) -- Line: 269 -- upvalues: u143 (val) -- types: a1: userdata
    for i, j in u143 do
        if j == a1 then
            u143[i] = nil
        end
    end
end

local function bind(a1, a2, a3, a4) -- Line: 277
    -- upvalues: u140 (val), u143 (val)
    local v1 = ("%* needs a ScreenGui above it to take gamepad input"):format(if a1 == nil then "none" else a1:GetFullName())
    local v2 = assert(if not a1:IsA("ScreenGui") then a1:FindFirstAncestorOfClass("ScreenGui") else a1, v1)
    if u140[a1] == nil then
        a1.Destroying:Once(function() -- Line: 283 -- upvalues: u140 (upval), a1 (val), u143 (upval)
            u140[a1] = nil
            for i, j in u143 do
                if j == a1 then
                    u143[i] = nil
                end
            end
        end)
    end
    u140[a1] = {
        key = a2,
        closes = a4,
        glyph = a3,
        owner = a1,
        screen = v2,
    }
end

local function adoptGlyph(a1) -- Line: 297
    -- upvalues: u74 (val), ownerAbove (val), bind (val), paintGlyph (val)
    local Attribute = a1:GetAttribute("GamepadKey")
    local v1 = ("%* needs a string GamepadKey attribute"):format(if a1 == nil then "none" else a1:GetFullName())
    assert(typeof(Attribute) == "string", v1)
    local v2 = u74[Attribute]
    local v3 = ("%*: %* is not a key this router knows"):format(if a1 == nil then "none" else a1:GetFullName(), Attribute)
    assert(v2 ~= nil, v3)
    local Parent = a1.Parent
    v3 = ("%* has to sit under a GuiButton"):format(if a1 == nil then "none" else a1:GetFullName())
    bind(assert(
        if Parent == nil then nil else if not Parent:IsA("ScreenGui") then if not Parent:IsA("GuiButton") then ownerAbove(Parent) else Parent else nil,
        v3
    ), v2, a1, false)
    paintGlyph(a1, v2)
end

local function adoptClose(a1) -- Line: 310
    -- upvalues: decorateClose (val), u92 (val), u130 (val), bind (val), ButtonB (val)
    local v1 = ("close button %* needs a ScreenGui above it"):format(if a1 == nil then "none" else a1:GetFullName())
    decorateClose(
        a1,
        (u92[(assert(if not a1:IsA("ScreenGui") then a1:FindFirstAncestorOfClass("ScreenGui") else a1, v1)).Name] or u130).captionedClose == true
    )
    bind(a1, ButtonB, nil, true)
end

local function eligible(a1, a2) -- Line: 319 -- upvalues: showing (val), u144 (ref), u145 (ref) -- types: a1: table
    if a1.key == a2 then
        local Enabled
        local owner = a1.owner
        if owner:IsA("LayerCollector") then
            Enabled = owner.Enabled
        elseif not owner:IsA("GuiObject") or owner.Visible then
            local Parent = owner.Parent
            Enabled = false
            if Parent ~= nil then
                Enabled = showing(Parent)
            end
        else
            Enabled = false
        end
        if Enabled then
            local glyph = a1.glyph
            if glyph ~= nil and not glyph.Visible then
                return false
            end
            if u144 ~= nil and a1.screen ~= u144 then
                return false
            end
            local v1 = true
            if u145 ~= nil then
                v1 = a1.owner:IsDescendantOf(u145)
            end
            return v1
        end
    end
    return false
end

local function score(a1) -- Line: 334 -- upvalues: u92 (val), u130 (val) -- types: a1: table
    local screen = a1.screen
    local v1 = u92[screen.Name] or u130
    local rank = v1.rank or screen.DisplayOrder
    local v2 = rank * 2
    return v2 + (if not a1.closes then 1 else 0)
end

local function claimantFor(a1) -- Line: 338 -- upvalues: u140 (val), eligible (val), u92 (val), u130 (val)
    local rank, screen, v1, v2, v3
    local v4 = nil
    local v5 = (-1 / 0)
    local v6 = nil
    local v7 = nil
    for i, j in u140, v6, v7 do
        if eligible(j, a1) then
            screen = j.screen
            v1 = u92[screen.Name] or u130
            rank = v1.rank or screen.DisplayOrder
            v3 = rank * 2
            v2 = v3 + (if not j.closes then 1 else 0)
            if v5 < v2 then
                v4 = i
            end
        end
    end
    return v4
end

local function selectionTakesA() -- Line: 352 -- upvalues: GuiService (val), showing (val)
    local SelectedObject = GuiService.SelectedObject
    local v1 = false
    if SelectedObject ~= nil then
        if SelectedObject:IsA("LayerCollector") then
            return SelectedObject.Enabled
        end
        if SelectedObject:IsA("GuiObject") and not SelectedObject.Visible then
            return false
        end
        local Parent = SelectedObject.Parent
        v1 = false
        if Parent ~= nil then
            v1 = showing(Parent)
        end
    end
    return v1
end

local function routes(a1) -- Line: 357
    -- upvalues: u75 (val), u147 (ref), PlatformController (val), MenuNavigation (val), GuiService (val), showing (val)
    if u75[a1] and u147 and PlatformController.IsConsole() and not MenuNavigation.IsSuspended() then
        if a1 ~= Enum.KeyCode.ButtonA then
            return true
        end
        local SelectedObject = GuiService.SelectedObject
        local Enabled = false
        if SelectedObject ~= nil then
            if SelectedObject:IsA("LayerCollector") then
                Enabled = SelectedObject.Enabled
            elseif not SelectedObject:IsA("GuiObject") or SelectedObject.Visible then
                local Parent = SelectedObject.Parent
                Enabled = false
                if Parent ~= nil then
                    Enabled = showing(Parent)
                end
            else
                Enabled = false
            end
        end
        if not Enabled and not MenuNavigation.IsCursorActive() then
            return true
        end
        return false
    end
    return false
end

local function press(a1) -- Line: 373
    -- upvalues: u143 (val), routes (val), claimantFor (val), u135 (val), u144 (ref), GuiService (val)
    -- upvalues: ConsoleSignals (val)
    if u143[a1] ~= nil then
        return true
    end
    if not routes(a1) then
        return false
    end
    local v1 = claimantFor(a1)
    if v1 ~= nil then
        u143[a1] = v1
        ConsoleSignals.ButtonDown:Fire(v1, a1)
        return true
    end
    local v2 = u135:AtDebug()
    local Name = a1.Name
    local v3 = u144
    local SelectedObject = GuiService.SelectedObject
    v2:Log((("%*: no button answered (focus %*, selection %*)"):format(
        Name,
        if v3 == nil then "none" else v3:GetFullName(),
        if SelectedObject == nil then "none" else SelectedObject:GetFullName()
    )))
    return false
end

local function release(a1, a2) -- Line: 396
    -- upvalues: u143 (val), u75 (val), PlatformController (val), showing (val), ConsoleSignals (val)
    local v1 = u143[a1]
    u143[a1] = nil
    if v1 == nil then
        return false
    end
    if a2 and u75[a1] and PlatformController.IsConsole() and v1.Active then
        local Enabled
        if v1:IsA("LayerCollector") then
            Enabled = v1.Enabled
        elseif not v1:IsA("GuiObject") or v1.Visible then
            local Parent = v1.Parent
            Enabled = false
            if Parent ~= nil then
                Enabled = showing(Parent)
            end
        else
            Enabled = false
        end
        if Enabled then
            ConsoleSignals.ButtonUp:Fire(v1, a1)
        end
    end
    return true
end

local function repaint() -- Line: 436 -- upvalues: u141 (val), applyLook (val), u140 (val), paintGlyph (val)
    local glyph
    for i in u141 do
        if i.Parent ~= nil then
            applyLook(i)
        end
    end
    for j, k in u140 do
        glyph = k.glyph
        if glyph ~= nil then
            paintGlyph(glyph, k.key)
        end
    end
end

function u132.GlyphFor(a1) -- Line: 452 -- upvalues: u74 (val), u75 (val), u142 (val), InputIconsConfig (val)
    local v1 = if typeof(a1) ~= "EnumItem" then u74[a1] else a1
    if v1 == nil or not u75[v1] then
        error(("%* is not a key this router knows"):format((tostring(a1))), 3)
    end
    local v2 = u142[v1]
    if v2 ~= nil then
        return v2
    end
    v2 = InputIconsConfig.Image(v1) or ""
    u142[v1] = v2
    return v2
end

function u132.IsOnScreen(a1) -- Line: 456 -- upvalues: showing (val) -- types: a1: userdata
    if a1:IsA("LayerCollector") then
        return a1.Enabled
    end
    if a1:IsA("GuiObject") and not a1.Visible then
        return false
    end
    local Parent = a1.Parent
    local v1 = false
    if Parent ~= nil then
        v1 = showing(Parent)
    end
    return v1
end

function u132.TrackCloseButton(a1) -- Line: 460
    -- upvalues: u92 (val), u130 (val), adoptClose (val)
    local v1 = if not a1:IsA("LayerCollector") then a1:FindFirstAncestorWhichIsA("LayerCollector") else a1
    local v2 = false
    if v1 ~= nil then
        local v3 = u92[v1.Name] or u130
        v2 = v3.blocked == true
    end
    if not v2 then
        adoptClose(a1)
    end
end

function u132.Inspect(a1) -- Line: 466
    -- upvalues: u92 (val), u130 (val), adoptGlyph (val), adoptClose (val)
    local v1 = if not a1:IsA("LayerCollector") then a1:FindFirstAncestorWhichIsA("LayerCollector") else a1
    local v2 = false
    if v1 ~= nil then
        local v3 = u92[v1.Name] or u130
        v2 = v3.blocked == true
    end
    if v2 then
        return
    end
    if a1.Name == "GamepadGlyph" and a1:IsA("GuiObject") then
        adoptGlyph(a1)
        return
    end
    if a1.Name == "Close"
        and a1:IsA("GuiButton")
        and (if not a1:IsA("ScreenGui") then a1:FindFirstAncestorOfClass("ScreenGui") else a1) ~= nil then
        adoptClose(a1)
    end
end

function u132.FocusScreen(a1, a2) -- Line: 477
    -- upvalues: u139 (val), u144 (ref), u145 (ref), u143 (val)
    local v1 = true
    if a1 ~= nil then
        v1 = a1:IsDescendantOf(u139)
    end
    assert(v1, "only a screen inside the local PlayerGui can take focus")
    if u144 == a1 and u145 == a2 then
        return
    end
    u144 = a1
    u145 = a2
    table.clear(u143)
end

function u132.EnableMarkers(a1) -- Line: 489 -- upvalues: u147 (ref), u143 (val) -- types: a1: boolean
    u147 = a1
    if not a1 then
        table.clear(u143)
    end
end

function u132.Rescan(a1) -- Line: 496
    -- upvalues: u146 (ref), PlatformController (val), InputIconsConfig (val), u142 (val), u139 (val), u132 (val)
    -- upvalues: repaint (val)
    u146 = if (a1 or PlatformController.Platform()) ~= "Console" then nil else InputIconsConfig.Vendor()
    table.clear(u142)
    for i, j in u139:GetDescendants() do
        u132.Inspect(j)
    end
    repaint()
end

MenuNavigation.CursorChanged:Connect(function() -- Line: 509 -- upvalues: u143 (val)
    table.clear(u143)
end)
PlatformController.Changed:Connect(function(a1) -- Line: 512 -- upvalues: u143 (val), u132 (val) -- types: a1: string
    table.clear(u143)
    u132.Rescan(a1)
end)
InputIconsConfig.Changed:Connect(function() -- Line: 516 -- upvalues: u132 (val)
    u132.Rescan()
end)
local v3 = {}
for k, n in v1 do
    if not v2[n] then
        table.insert(v3, n)
    end
end
local Value = Enum.ContextActionPriority.High.Value
local v4 = table.unpack(v3)
ContextActionService:BindActionAtPriority("GamepadGlyphRouting", function(a1, a2, a3) -- Line: 417
    -- upvalues: u75 (val), u143 (val), press (val), PlatformController (val), showing (val), ConsoleSignals (val)
    local v1
    local KeyCode = a3.KeyCode
    if a2 == Enum.UserInputState.Cancel and not u75[KeyCode] then
        v1 = next(u143) ~= nil
        table.clear(u143)
        if v1 then
            return Enum.ContextActionResult.Sink
        end
        return Enum.ContextActionResult.Pass
    end
    if a2 == Enum.UserInputState.Begin then
        v1 = press(KeyCode)
    elseif a2 ~= Enum.UserInputState.Change then
        local v2 = a2 ~= Enum.UserInputState.Cancel
        local v3 = u143[KeyCode]
        u143[KeyCode] = nil
        if v3 ~= nil then
            if v2 and u75[KeyCode] and PlatformController.IsConsole() and v3.Active then
                local Enabled
                if v3:IsA("LayerCollector") then
                    Enabled = v3.Enabled
                elseif not v3:IsA("GuiObject") or v3.Visible then
                    local Parent = v3.Parent
                    Enabled = false
                    if Parent ~= nil then
                        Enabled = showing(Parent)
                    end
                else
                    Enabled = false
                end
                if Enabled then
                    ConsoleSignals.ButtonUp:Fire(v3, KeyCode)
                end
            end
            v1 = true
        else
            v1 = false
        end
    else
        v1 = u143[KeyCode] ~= nil
    end
    if v1 then
        return Enum.ContextActionResult.Sink
    end
    return Enum.ContextActionResult.Pass
end, false, Value, v4)
UserInputService.InputBegan:Connect(function(a1) -- Line: 534 -- upvalues: u144 (ref), u65 (val), press (val) -- types: a1: userdata
    if u144 ~= nil and u65[a1.KeyCode] then
        press(a1.KeyCode)
    end
end)
UserInputService.InputEnded:Connect(function(a1) -- Line: 539
    -- upvalues: u144 (ref), u65 (val), u143 (val), u75 (val), PlatformController (val), showing (val)
    -- upvalues: ConsoleSignals (val)
    if u144 ~= nil and u65[a1.KeyCode] then
        local KeyCode = a1.KeyCode
        local v1 = u143[KeyCode]
        u143[KeyCode] = nil
        if v1 == nil then
            return
        end
        if u75[KeyCode] and PlatformController.IsConsole() and v1.Active then
            local Enabled
            if v1:IsA("LayerCollector") then
                Enabled = v1.Enabled
            elseif not v1:IsA("GuiObject") or v1.Visible then
                local Parent = v1.Parent
                Enabled = false
                if Parent ~= nil then
                    Enabled = showing(Parent)
                end
            else
                Enabled = false
            end
            if Enabled then
                ConsoleSignals.ButtonUp:Fire(v1, KeyCode)
            end
        end
    end
end)
u135:AtInfo():Log("gamepad routing online")
return u132