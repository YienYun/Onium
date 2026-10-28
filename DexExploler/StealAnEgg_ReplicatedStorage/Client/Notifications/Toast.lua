-- Script path: ReplicatedStorage.Client.Notifications.Toast
-- Decompile time: 20.26 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local CorruptedAnnouncement = require(script.Parent.CorruptedAnnouncement)
local CorruptedPlate = require(script.Parent.CorruptedPlate)
local Lanes = require(script.Parent.Lanes)
local RareSpawnText = require(script.Parent.RareSpawnText)
local MsgNotif = ReplicatedStorage.Assets.UI.Notifs.MsgNotif
local u43 = {Feed = true, Banner = true}
local u44 = {0.85, 1.15}
local u47 = {0.92, 1.08}
local u54 = TweenInfo.new(2.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v1 = {}

local function expectKind(a1, a2, a3) -- Line: 91 -- types: a2: string, a3: string
    if a1 ~= nil and typeof(a1) ~= a2 then
        error(("toast field %* expects a %*, got %*"):format(a3, a2, (typeof(a1))), 3)
    end
end

local function validate(a1) -- Line: 97 -- upvalues: u43 (val) -- types: a1: table
    if typeof(a1) ~= "table" then
        error(("Toast.Show expects a request table, got %*"):format((typeof(a1))), 3)
    end
    if typeof(a1.Text) ~= "string" then
        error("a toast needs a string Text", 3)
    end
    if typeof(a1.Seconds) ~= "number" then
        error("a toast needs a numeric Seconds", 3)
    end
    local Lane = a1.Lane
    if Lane ~= nil then
        if typeof(Lane) ~= "string" or u43[Lane] ~= true then
            error(("toast field Lane expects \"Feed\" or \"Banner\", got %*"):format((tostring(Lane))), 3)
        end
    end
    local Color = a1.Color
    if Color ~= nil and typeof(Color) ~= "Color3" then
        error(("toast field Color expects a Color3, got %*"):format((typeof(Color))), 3)
    end
    local StrokeColor = a1.StrokeColor
    if StrokeColor ~= nil and typeof(StrokeColor) ~= "Color3" then
        error(("toast field StrokeColor expects a Color3, got %*"):format((typeof(StrokeColor))), 3)
    end
    local Image = a1.Image
    if Image ~= nil and typeof(Image) ~= "string" then
        error(("toast field Image expects a string, got %*"):format((typeof(Image))), 3)
    end
    local WrapText = a1.WrapText
    if WrapText ~= nil and typeof(WrapText) ~= "boolean" then
        error(("toast field WrapText expects a boolean, got %*"):format((typeof(WrapText))), 3)
    end
    local SingleLine = a1.SingleLine
    if SingleLine ~= nil and typeof(SingleLine) ~= "boolean" then
        error(("toast field SingleLine expects a boolean, got %*"):format((typeof(SingleLine))), 3)
    end
    local DelayInRound = a1.DelayInRound
    if DelayInRound ~= nil and typeof(DelayInRound) ~= "boolean" then
        error(("toast field DelayInRound expects a boolean, got %*"):format((typeof(DelayInRound))), 3)
    end
    local Unique = a1.Unique
    if Unique ~= nil and typeof(Unique) ~= "boolean" then
        error(("toast field Unique expects a boolean, got %*"):format((typeof(Unique))), 3)
    end
    local UniqueKey = a1.UniqueKey
    if UniqueKey ~= nil and typeof(UniqueKey) ~= "string" then
        error(("toast field UniqueKey expects a string, got %*"):format((typeof(UniqueKey))), 3)
    end
    local Corrupted = a1.Corrupted
    if Corrupted ~= nil and typeof(Corrupted) ~= "boolean" then
        error(("toast field Corrupted expects a boolean, got %*"):format((typeof(Corrupted))), 3)
    end
    local Sound = a1.Sound
    if Sound ~= nil and typeof(Sound) ~= "string" and typeof(Sound) ~= "number" then
        error(("toast field Sound expects an asset id, got %*"):format((typeof(Sound))), 3)
    end
    local Gradient = a1.Gradient
    if Gradient ~= nil then
        if typeof(Gradient) ~= "Instance" or not Gradient:IsA("UIGradient") then
            error("toast field Gradient expects a UIGradient", 3)
        end
    end
    local PreText = a1.PreText
    if PreText ~= nil then
        if PreText ~= nil and typeof(PreText) ~= "table" then
            error(("toast field PreText expects a table, got %*"):format((typeof(PreText))), 3)
        end
        local Text_2 = PreText.Text
        if Text_2 ~= nil and typeof(Text_2) ~= "string" then
            error(("toast field PreText.Text expects a string, got %*"):format((typeof(Text_2))), 3)
        end
        local Color_2 = PreText.Color
        if Color_2 ~= nil and typeof(Color_2) ~= "Color3" then
            error(("toast field PreText.Color expects a Color3, got %*"):format((typeof(Color_2))), 3)
        end
        local StrokeColor_2 = PreText.StrokeColor
        if StrokeColor_2 ~= nil and typeof(StrokeColor_2) ~= "Color3" then
            error(("toast field PreText.StrokeColor expects a Color3, got %*"):format((typeof(StrokeColor_2))), 3)
        end
    end
end

local function outlined(a1, a2) -- Line: 140 -- types: a1: string, a2: UDim2
    return (("<stroke color=\"#%*\" thickness=\"%*\" joins=\"round\">%*</stroke>"):format(a2:ToHex(), 2, a1))
end

local function tinted(a1, a2) -- Line: 144 -- types: a1: string, a2: UDim2
    return (("<font color=\"#%*\">%*</font>"):format(a2:ToHex(), a1))
end

local function compose(a1, a2, a3) -- Line: 148 -- types: a1: string, a2: UDim2?, a3: UDim2?
    local v1 = ("<stroke color=\"#%*\" thickness=\"%*\" joins=\"round\">%*</stroke>"):format((a3 or Color3.new()):ToHex(), 2, a1)
    if a2 ~= nil then
        return (("<font color=\"#%*\">%*</font>"):format(a2:ToHex(), v1))
    end
    return v1
end

local function isAlertTint(a1) -- Line: 153 -- types: a1: UDim2
    local v1 = false
    if 0.999 <= a1.R then
        v1 = false
        if a1.G <= 0.001 then
            v1 = a1.B <= 0.001
        end
    end
    return v1
end

local function playCue(a1, a2) -- Line: 157
    -- upvalues: Audio (val), u47 (val), u44 (val)
    local Sound = a1.Sound
    if Sound ~= nil then
        Audio.Play(Sound, script, {PlaybackSpeed = u47})
        return
    end
    if a2 ~= nil then
        local v1 = false
        if 0.999 <= a2.R then
            v1 = false
            if a2.G <= 0.001 then
                v1 = a2.B <= 0.001
            end
        end
        if v1 then
            Audio.Play(17208372272, script)
            return
        end
    end
    Audio.Play("rbxassetid://133842042346471", script, {Volume = 0.55, PlaybackSpeed = u44})
end

local function scaleFactor(a1) -- Line: 173 -- types: a1: userdata
    local UIScale = a1:FindFirstChildOfClass("UIScale")
    if UIScale ~= nil and 0 < UIScale.Scale then
        return UIScale.Scale
    end
    return 1
end

local function plateRoom(a1, a2, a3) -- Line: 178 -- types: a1: userdata, a2: userdata, a3: table
    local UIScale = a1:FindFirstChildOfClass("UIScale")
    local Scale = if UIScale == nil then 1 else if not (0 < UIScale.Scale) then 1 else UIScale.Scale
    local UIListLayout = a2:FindFirstChildOfClass("UIListLayout")
    local Offset = if UIListLayout == nil then 0 else UIListLayout.Padding.Offset
    local v1 = a2.AbsoluteSize.X / Scale
    for i, j in a2:GetChildren() do
        if j:IsA("GuiObject") and j.Visible and table.find(a3, j) == nil then
            v1 = v1 - (j.AbsoluteSize.X / Scale + Offset)
        end
    end
    return v1, a2.AbsoluteSize.Y / Scale
end

local function lineWidth(a1, a2) -- Line: 191 -- upvalues: TextService (val) -- types: a1: userdata, a2: number
    local GetTextBoundsParams = Instance.new("GetTextBoundsParams")
    GetTextBoundsParams.Font = a1.FontFace
    GetTextBoundsParams.Size = a2
    GetTextBoundsParams.Text = a1.ContentText
    GetTextBoundsParams.Width = 0
    local success, err = pcall(TextService.GetTextBoundsAsync, TextService, GetTextBoundsParams)
    if success and typeof(err) == "Vector2" and 0 < err.X then
        return err.X
    end
    return nil
end

local function fitOneLine(a1, a2, a3) -- Line: 206
    -- upvalues: lineWidth (val)
    if not (a2 <= 0) and not (a3 <= 0) then
        local v1
        local v2 = 0
        for i, j in a1 do
            if j.Visible then
                v1 = lineWidth(j, a3)
                if v1 == nil then
                    for k, n in a1 do
                        n.TextWrapped = true
                        n.TextScaled = true
                    end
                    return true
                end
                v2 = v2 + v1
            end
        end
        v2 = math.max(math.floor((math.min(a3, if not (v2 > 0) then a3 else a3 * (a2 * 0.96) / v2))), 12)
        for m, i5 in a1 do
            i5.TextSize = v2
        end
        return true
    end
    return false
end

local function iconSlot(a1) -- Line: 235 -- types: a1: userdata
    local IconSlot = a1:FindFirstChild("IconSlot")
    if IconSlot ~= nil and IconSlot:IsA("Frame") then
        return IconSlot
    end
    local Frame = Instance.new("Frame")
    Frame.Name = "IconSlot"
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
    UIAspectRatioConstraint.Parent = Frame
    Frame.Parent = a1
    return Frame
end

local function seatIcon(a1, a2, a3, a4) -- Line: 254
    -- upvalues: iconSlot (val)
    local v1 = a4 or 1
    if a3 ~= nil and not (a3 < 2) then
        local UIAspectRatioConstraint = a2:FindFirstChildOfClass("UIAspectRatioConstraint")
        local AspectRatio = if UIAspectRatioConstraint == nil then 1 else UIAspectRatioConstraint.AspectRatio
        local v2 = 1.125 * v1 / a3
        v1 = iconSlot(a1)
        local UIAspectRatioConstraint_2 = v1:FindFirstChildOfClass("UIAspectRatioConstraint")
        if UIAspectRatioConstraint_2 ~= nil then
            UIAspectRatioConstraint_2.AspectRatio = AspectRatio * v2
        end
        v1.LayoutOrder = a2.LayoutOrder
        v1.Size = UDim2.fromScale(1, 1)
        v1.ZIndex = a2.ZIndex
        a2.Parent = v1
        a2.AnchorPoint = Vector2.new(0.5, 1)
        a2.Position = UDim2.fromScale(0.5, 1)
        a2.Size = UDim2.fromScale(1, v2)
        return
    end
    if v1 ~= 1 then
        a2.Size = UDim2.fromScale(a2.Size.X.Scale * v1, a2.Size.Y.Scale * v1)
    end
end

local function prefixLabel(a1, a2) -- Line: 283 -- types: a1: userdata, a2: userdata
    local PreText = a1:FindFirstChild("PreText")
    if PreText ~= nil and PreText:IsA("TextLabel") then
        return PreText
    end
    local v1 = a2:Clone()
    v1.Name = "PreText"
    v1.Parent = a1
    return v1
end

local function applyFont(a1, a2) -- Line: 295 -- types: a1: userdata
    if typeof(a2) == "Font" then
        a1.FontFace = a2
        return
    end
    if typeof(a2) == "table" and typeof(a2.Family) == "string" then
        local success, err = pcall(Font.new, a2.Family, a2.Weight or Enum.FontWeight.Regular)
        if success then
            a1.FontFace = err
        end
    end
end

local function speaksAsSammy(a1) -- Line: 306 -- types: a1: table
    local PreText = a1.PreText
    local Text = if PreText == nil then nil else PreText.Text
    local v1 = false
    if Text ~= nil then
        v1 = string.sub(Text, 1, 21) == "Mind Controlled Sammy"
    end
    return v1
end

local function settleText(a1, a2, a3, a4, a5) -- Line: 312
    -- upvalues: plateRoom (val), fitOneLine (val)
    if not a1.SingleLine then
        if a1.WrapText then
            task.delay(0, function() -- Line: 333 -- upvalues: a2 (val), plateRoom (upval), a3 (val), a4 (val)
                if a2.Parent == nil then
                    return
                end
                local v1 = plateRoom(a2, a3, {a4})
                local UISizeConstraint = Instance.new("UISizeConstraint")
                UISizeConstraint.MaxSize = Vector2.new(math.max(v1, 128), (1 / 0))
                UISizeConstraint.Parent = a4
            end)
        end
        return
    end
    local u6 = {a4, a5}

    local function attempt() -- Line: 321
        -- upvalues: plateRoom (upval), a2 (val), a3 (val), u6 (val), fitOneLine (upval)
        local v1, v2 = plateRoom(a2, a3, u6)
        return (fitOneLine(u6, v1, v2))
    end

    local v1, v2 = plateRoom(a2, a3, u6)
    if fitOneLine(u6, v1, v2) then
        return
    end
    task.delay(0, function() -- Line: 326 -- upvalues: a2 (val), plateRoom (upval), a3 (val), u6 (val), fitOneLine (upval)
        if a2.Parent ~= nil then
            local v1, v2 = plateRoom(a2, a3, u6)
            fitOneLine(u6, v1, v2)
        end
    end)
end

local function buildSammy(a1) -- Line: 345 -- upvalues: CorruptedAnnouncement (val), playCue (val) -- types: a1: table
    local v1, u6, v2 = CorruptedAnnouncement.Create(a1.Text, "Mind Controlled Sammy:")
    return {
        banner = v1,
        begin = function() -- Line: 349 -- upvalues: playCue (upval), a1 (val), u6 (val)
            playCue(a1, a1.Color)
            u6()
        end,
        finish = v2,
    }
end

local function buildPlate(a1) -- Line: 357
    -- upvalues: MsgNotif (val), RareSpawnText (val), applyFont (val), seatIcon (val), playCue (val), settleText (val)
    -- upvalues: CorruptedPlate (val), TweenService (val), u54 (val)
    local u32, v1
    local u4 = MsgNotif:Clone()
    local Backdrop = u4:FindFirstChild("Backdrop")
    local Plate = u4:FindFirstChild("Plate")
    local Body = Plate:FindFirstChild("Body")
    local PreText = Plate:FindFirstChild("PreText")
    if PreText == nil or not PreText:IsA("TextLabel") then
        local v2 = Body:Clone()
        v2.Name = "PreText"
        v2.Parent = Plate
        u32 = v2
    else
        u32 = PreText
    end
    local Color = a1.Color
    if not Color then
        Color = Color3.new(1, 1, 1)
    end
    local u45 = RareSpawnText.Parse(a1.Text)
    local u46 = nil
    local u47 = nil
    if u45 then
        Body.AutoLocalize = false
    end
    local Text = a1.Text
    local v3 = ("<stroke color=\"#%*\" thickness=\"%*\" joins=\"round\">%*</stroke>"):format((a1.StrokeColor or Color3.new()):ToHex(), 2, Text)
    Body.Text = if Color == nil then v3 else ("<font color=\"#%*\">%*</font>"):format(Color:ToHex(), v3)
    Body.TextColor3 = Color
    local UIStroke = Body:FindFirstChild("UIStroke")
    if UIStroke ~= nil and UIStroke:IsA("UIStroke") and a1.StrokeColor ~= nil then
        UIStroke.Color = a1.StrokeColor
    end
    u32.LayoutOrder = math.max(Body.LayoutOrder - 1, 0)
    u32.TextColor3 = Color
    u32.ZIndex = Body.ZIndex
    local PreText_2 = a1.PreText
    local Text_2 = if PreText_2 == nil then "" else if PreText_2.Text == nil then "" else PreText_2.Text
    if PreText_2 == nil or Text_2 == "" then
        v1 = ""
    else
        local Color_2 = PreText_2.Color
        local v4 = ("<stroke color=\"#%*\" thickness=\"%*\" joins=\"round\">%*</stroke>"):format(
            (PreText_2.StrokeColor or Color3.new()):ToHex(),
            2,
            Text_2
        )
        v1 = if Color_2 == nil then v4 else ("<font color=\"#%*\">%*</font>"):format(Color_2:ToHex(), v4)
    end
    u32.Text = v1
    u32.Visible = Text_2 ~= ""
    if a1.Size ~= nil then
        u4.Size = a1.Size
    end
    if a1.Corrupted == true then
        u4.Size = UDim2.fromScale(u4.Size.X.Scale, u4.Size.Y.Scale * 1.22)
        Plate.Size = UDim2.fromScale(Plate.Size.X.Scale, Plate.Size.Y.Scale / 1.22)
    end
    if a1.Gradient ~= nil then
        a1.Gradient:Clone().Parent = Body
    end
    if a1.Font ~= nil then
        applyFont(Body, a1.Font)
    end
    Backdrop.Visible = a1.ShowShadow == true
    if a1.SingleLine then
        for i, j in {Body, u32} do
            j.TextScaled = false
            j.TextWrapped = false
        end
    end
    if a1.Image ~= nil then
        local Icon = Plate:FindFirstChild("Icon")
        if Icon ~= nil and Icon:IsA("ImageLabel") then
            Icon.Image = a1.Image
            Icon.Visible = true
            seatIcon(Plate, Icon, a1.IconLines, a1.IconScale)
        end
    end
    return {
        banner = u4,
        begin = function() -- Line: 424
            -- upvalues: playCue (upval), a1 (val), Color (val), settleText (upval), u4 (val), Plate (val), Body (val)
            -- upvalues: u32 (val), u47 (ref), CorruptedPlate (upval), u45 (val), u46 (ref), RareSpawnText (upval)
            -- upvalues: TweenService (upval), Backdrop (val), u54 (upval)
            playCue(a1, Color)
            settleText(a1, u4, Plate, Body, u32)
            if a1.Corrupted == true then
                CorruptedPlate.Attach(u4, Plate)
            end
            if u45 then
                local v1 = Body
                RareSpawnText.Localize(u45, v1, function(a1_2) -- Line: 434
                    -- upvalues: u4 (upval), Body (upval), Color (upval), a1 (upval), settleText (upval), Plate (upval)
                    -- upvalues: u32 (upval)
                    if u4.Parent == nil then
                        return
                    end
                    local v1 = Body
                    local v2 = Color
                    local v3 = ("<stroke color=\"#%*\" thickness=\"%*\" joins=\"round\">%*</stroke>"):format(
                        (a1.StrokeColor or Color3.new()):ToHex(),
                        2,
                        a1_2
                    )
                    v1.Text = if v2 == nil then v3 else ("<font color=\"#%*\">%*</font>"):format(v2:ToHex(), v3)
                    settleText(a1, u4, Plate, Body, u32)
                end)
            end
            task.delay(0.8, function() -- Line: 443 -- upvalues: u4 (upval), TweenService (upval), Backdrop (upval), u54 (upval)
                if u4.Parent ~= nil then
                    TweenService:Create(Backdrop, u54, {ImageTransparency = 1}):Play()
                end
            end)
        end,
        finish = function() -- Line: 449 -- upvalues: u46 (ref), u47 (ref)
            if u46 then
                u46()
            end
            if u47 then
                u47()
            end
        end,
    }
end

function v1.Show(a1) -- Line: 462
    -- upvalues: validate (val), buildSammy (val), buildPlate (val), Lanes (val)
    validate(a1)
    local PreText = a1.PreText
    local Text = if PreText == nil then nil else PreText.Text
    local v1 = false
    if Text ~= nil then
        v1 = string.sub(Text, 1, 21) == "Mind Controlled Sammy"
    end
    local v2 = if not v1 then buildPlate(a1) else buildSammy(a1)
    local Text_2 = if a1.Unique ~= true then a1.UniqueKey else a1.Text
    Lanes.Schedule({
        Lane = a1.Lane or "Feed",
        Frame = v2.banner,
        Seconds = a1.Seconds,
        UniqueKey = Text_2,
        DelayInRound = a1.DelayInRound,
        OnShown = v2.begin,
        OnRetired = v2.finish,
    })
end

return table.freeze(v1)