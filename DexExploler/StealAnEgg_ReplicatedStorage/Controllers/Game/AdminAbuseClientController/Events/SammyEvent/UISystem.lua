-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.SammyEvent.UISystem
-- Decompile time: 36.57 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local GUI = require(ReplicatedStorage.Client.GUI)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local SammyEvent = require(ReplicatedStorage.Data.SammyEvent)
require(ReplicatedStorage.Packages.Trove)
local u36 = {0.04, 0.05, 0.035}
local u40 = {0.06, 0.04, 0.05, 0.05, 0.035, 0.07, 0.09}
local u52 = Color3.fromRGB(0, 170, 255)
local u57 = Color3.fromRGB(200, 250, 255)
local u62 = Color3.fromRGB(70, 210, 255)
local u64 = Random.new()
local u65 = nil
local u66 = false
local u67 = false
local u68 = false
local u69 = 0
local u70 = 0
local u71 = 0
local u72 = true
local u73 = -1
local u74 = ""
local u75 = ""
local u76 = ""
local u77 = 0
local u78 = 0
local u79 = 0
local u80 = 0
local u81 = -1
local u82 = nil
local u83 = 0
local u84 = 0
local u85 = false
local u86 = -1
local u87 = 0
local u88 = 0
local u89 = -1
local u90 = -1
local u91 = -1
local u92 = nil
local u93 = false
local u94 = 0
local u95 = 1
local u96 = -1

local function makeSheet(a1) -- Line: 170 -- types: a1: userdata
    local Attribute = a1:GetAttribute("Cells")
    local Attribute_2 = a1:GetAttribute("FPS")
    local v1 = false
    if typeof(Attribute) == "Vector2" then
        v1 = type(Attribute_2) == "number"
    end
    assert(v1, (("%* needs Cells and FPS attributes"):format((a1:GetFullName()))))
    local Attribute_3 = a1:GetAttribute("StartAt")
    a1.Visible = false
    a1.ImageRectOffset = Vector2.zero
    return {
        Frame = 1,
        Acc = 0,
        On = false,
        Image = a1,
        Cells = Attribute,
        Frames = math.max(1, Attribute.X * Attribute.Y),
        FrameTime = 1 / Attribute_2,
        StartAt = if type(Attribute_3) ~= "number" then 30 else Attribute_3,
    }
end

local function resolveUi() -- Line: 190
    -- upvalues: u65 (ref), GUI (val), makeSheet (val), u52 (val), u57 (val), u62 (val)
    local v1 = u65
    if v1 then
        return v1
    end
    v1 = GUI.SammyEventUI()
    local EMPChargeBar = v1.EMPChargeBar
    local BarHolder = EMPChargeBar.BarHolder
    local Icon = BarHolder.Icon
    local GlowImage = Icon.GlowImage
    local BarBG = BarHolder.BarBG
    local Bar = BarBG.Bar
    local v2 = {}
    for i, j in EMPChargeBar:QueryDescendants("ImageLabel[$Cells][$FPS]") do
        if j:IsA("ImageLabel") and j ~= Bar.BarCharge and j ~= Icon.ChargeLine then
            table.insert(v2, (makeSheet(j)))
        end
    end
    local v3 = makeSheet(Bar.BarCharge)
    local v4 = makeSheet(Icon.ChargeLine)
    local v5 = table.clone(v2)
    table.insert(v5, v3)
    table.insert(v5, v4)
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Rotation = -90
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, u52),
        ColorSequenceKeypoint.new(0.44, u52),
        ColorSequenceKeypoint.new(0.49, u57),
        (ColorSequenceKeypoint.new(1, u57)),
    })
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.72),
        NumberSequenceKeypoint.new(0.44, 0.72),
        NumberSequenceKeypoint.new(0.485, 0.2),
        NumberSequenceKeypoint.new(0.52, 1),
        (NumberSequenceKeypoint.new(1, 1)),
    })
    UIGradient.Parent = GlowImage
    GlowImage.ImageColor3 = Color3.new(1, 1, 1)
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Name = "EnergyHalo"
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = GlowImage.Image
    ImageLabel.ScaleType = GlowImage.ScaleType
    ImageLabel.ImageColor3 = u62
    ImageLabel.ImageTransparency = 1
    ImageLabel.AnchorPoint = Icon.AnchorPoint
    ImageLabel.Position = Icon.Position
    ImageLabel.Size = UDim2.new(Icon.Size.X.Scale * 1.16, Icon.Size.X.Offset * 1.16, Icon.Size.Y.Scale * 1.16, Icon.Size.Y.Offset * 1.16)
    ImageLabel.ZIndex = Icon.ZIndex - 1
    ImageLabel.Visible = false
    ImageLabel.Parent = BarHolder
    local v6 = {
        Gui = v1,
        Holder = BarHolder,
        Icon = Icon,
        Glow = GlowImage,
        Halo = ImageLabel,
        EnergyGradient = UIGradient,
        Percent = BarHolder.ProgressHolder,
        Title = EMPChargeBar.TitleHolder.BossName,
        TitleText = EMPChargeBar.TitleHolder.BossName.Text,
        Timer = EMPChargeBar.TimeLeftHolder.TimeLeft,
        BarBG = BarBG,
        Bar = Bar,
        Phantom = BarBG.PhantomBar,
        Decor = BarBG.Decor,
        BaseHolderRotation = BarHolder.Rotation,
        BaseIconPosition = Icon.Position,
        BaseIconRotation = Icon.Rotation,
        BarSizeY = Bar.Size.Y,
        PhantomSizeY = BarBG.PhantomBar.Size.Y,
        LineBaseX = Icon.ChargeLine.Position.X,
        FillSheet = v3,
        LineSheet = v4,
        LightningSheets = v2,
        AllSheets = v5,
    }
    u65 = v6
    return v6
end

local function isRaiding() -- Line: 287 -- upvalues: Workspace (val)
    local Attribute = Workspace:GetAttribute("SammyWeaponRequired")
    local v1 = false
    if type(Attribute) == "number" then
        v1 = Attribute > 0
    end
    return v1
end

local function isSavingBen() -- Line: 293 -- upvalues: Workspace (val)
    return Workspace:GetAttribute("SammyPhase") == "SaveBen"
end

local function readCharge() -- Line: 298 -- upvalues: Workspace (val), SammyEvent (val)
    local Attribute = Workspace:GetAttribute("SammyEmpCharge")
    if type(Attribute) ~= "number" then
        return 0
    end
    return (math.clamp(Attribute / SammyEvent.ChargeMax, 0, 1))
end

local function writeFill(a1, a2) -- Line: 306 -- upvalues: u71 (ref), u73 (ref) -- types: a1: table, a2: boolean
    local v1 = math.round(u71 * a1.BarBG.AbsoluteSize.X)
    if a2 or v1 ~= u73 then
        u73 = v1
        a1.Bar.Size = UDim2.new(u71, 0, a1.BarSizeY.Scale, a1.BarSizeY.Offset)
    end
end

local function writePhantom(a1) -- Line: 314 -- upvalues: u70 (ref) -- types: a1: table
    a1.Phantom.Size = UDim2.new(u70, 0, a1.PhantomSizeY.Scale, a1.PhantomSizeY.Offset)
end

local function writeText(a1) -- Line: 318 -- upvalues: u71 (ref), u74 (ref) -- types: a1: table
    local v1 = string.format("%.2f%%", u71 * 100)
    if v1 ~= u74 then
        u74 = v1
        a1.Percent.Text = v1
    end
end

local function writeTitle(a1) -- Line: 326 -- upvalues: Workspace (val), u75 (ref) -- types: a1: table
    local TitleText
    local v1 = Workspace:GetAttribute("SammyPhase") == "SaveBen"
    if not v1 then
        local Attribute = Workspace:GetAttribute("SammyWeaponRequired")
        v1 = false
        if type(Attribute) == "number" then
            v1 = Attribute > 0
        end
        TitleText = if not v1 then a1.TitleText else "Bring Brainrots to the Laser Gun!"
    else
        TitleText = "Save Ben from Mind Controlled Sammy!"
    end
    if TitleText ~= u75 then
        u75 = TitleText
        a1.Title.Text = TitleText
    end
end

local function writeTimer(a1) -- Line: 334 -- upvalues: u69 (ref), Workspace (val), u76 (ref) -- types: a1: table
    local v1 = math.max(0, (math.floor(u69 - (Workspace:GetServerTimeNow()))))
    local v2 = string.format("%02d:%02d", v1 // 60, v1 % 60)
    if v2 ~= u76 then
        u76 = v2
        a1.Timer.Text = v2
    end
end

local function setSheet(a1, a2) -- Line: 343 -- types: a1: table, a2: boolean
    if a1.On == a2 then
        return
    end
    a1.On = a2
    a1.Image.Visible = a2
    if not a2 then
        return
    end
    local Offsets = a1.Offsets
    if Offsets == nil then
        local v1
        local v2 = table.create(a1.Frames)
        local ImageRectSize = a1.Image.ImageRectSize
        local v3 = a1.Frames - 1
        for i = 0, v3 do
            v1 = i + 1
            v2[v1] = (Vector2.new(ImageRectSize.X * (i % a1.Cells.X), ImageRectSize.Y * (i // a1.Cells.X)))
        end
        a1.Offsets = v2
        Offsets = v2
    end
    a1.Frame = 1
    a1.Acc = 0
    a1.Image.ImageRectOffset = Offsets[1]
end

local function setDecorOff(a1, a2) -- Line: 367 -- upvalues: u85 (ref) -- types: a1: table, a2: boolean
    if a2 == u85 then
        return
    end
    u85 = a2
    a1.Decor.Visible = not a2
end

local function writeEnergy(a1, a2) -- Line: 375
    -- upvalues: u71 (ref), u89 (ref), setSheet (val), u93 (ref), u88 (ref), u87 (ref), u90 (ref), u91 (ref)
    local v1 = u71 * 0.9800000000000001 + 0.1
    if a2 or 0.002 <= (math.abs(v1 - u89)) then
        u89 = v1
        a1.EnergyGradient.Offset = Vector2.new(0, 0.5 - v1)
        a1.LineSheet.Image.Position = UDim2.new(a1.LineBaseX.Scale, a1.LineBaseX.Offset, 1 - math.min(v1, 0.92), 0)
    end
    local LineSheet_2 = a1.LineSheet
    local v2 = false
    if u71 > 0 then
        v2 = u71 < 1
    end
    setSheet(LineSheet_2, v2)
    v1 = if not u93 then 0 else math.sin(u88 * 1.6 * 3.141592653589793 * 2) * 0.06
    local v3 = math.clamp((1 - u87) * 0.15 + v1, 0, 1)
    if a2 or 0.01 <= (math.abs(v3 - u90)) then
        u90 = v3
        a1.Glow.ImageTransparency = v3
    end
    v3 = u71 * -0.52 + 0.92
    v3 = math.clamp(v3 - u87 * (v3 - 0.1) + v1, 0, 1)
    if a2 or 0.01 <= (math.abs(v3 - u91)) then
        u91 = v3
        a1.Halo.ImageTransparency = v3
    end
    v3 = u71 > 0
    if a2 or a1.Glow.Visible ~= v3 then
        a1.Glow.Visible = v3
        a1.Halo.Visible = v3
    end
end

local function buildTremble(a1, a2) -- Line: 407 -- upvalues: u64 (val) -- types: a1: table, a2: number
    local BaseIconPosition, fromOffset, v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = {}
    local v10 = {}
    local v11 = a1
    for i = 1, 4 do
        v6 = (i - 1) / 3
        v7 = a2 * (v6 * 2.5 + 1) / 100
        v8 = v6 * 4 + 2
        v6 = {}
        v1 = {}
        for j = 1, 12 do
            v2 = j / 12 * 3.141592653589793 * 2 + u64:NextNumber(-0.4, 0.4)
            v3 = v7 * u64:NextNumber(0.45, 1)
            BaseIconPosition = v11.BaseIconPosition
            fromOffset = UDim2.fromOffset
            v4 = math.round((math.cos(v2)) * v3)
            v5 = (math.sin(v2)) * v3
            v6[j] = BaseIconPosition + fromOffset(v4, (math.round(v5)))
            v1[j] = v11.BaseIconRotation + v8 * u64:NextNumber(-1, 1)
        end
        v9[i] = v6
        v10[i] = v1
    end
    return {Positions = v9, Rotations = v10, Width = a2}
end

local function setTremble(a1, a2) -- Line: 429 -- upvalues: u93 (ref), u94 (ref) -- types: a1: table, a2: boolean
    if u93 == a2 then
        return
    end
    u93 = a2
    u94 = 0
    if not a2 then
        a1.Icon.Position = a1.BaseIconPosition
        a1.Icon.Rotation = a1.BaseIconRotation
    end
end

local function rest(a1) -- Line: 442
    -- upvalues: u78 (ref), u79 (ref), u80 (ref), u82 (ref), u85 (ref), u87 (ref), u88 (ref), u93 (ref), u94 (ref)
    -- upvalues: u92 (ref), u96 (ref), u89 (ref), u90 (ref), u91 (ref), u73 (ref), u74 (ref), u75 (ref), u76 (ref)
    u78 = 0
    u79 = 0
    u80 = 0
    a1.Holder.Rotation = a1.BaseHolderRotation
    u82 = nil
    if u85 ~= false then
        u85 = false
        a1.Decor.Visible = true
    end
    u87 = 0
    u88 = 0
    if u93 ~= false then
        u93 = false
        u94 = 0
        a1.Icon.Position = a1.BaseIconPosition
        a1.Icon.Rotation = a1.BaseIconRotation
    end
    local v1 = nil
    local v2 = nil
    local v3 = a1
    for i, j in a1.AllSheets, v1, v2 do
        if j.On ~= false then
            j.On = false
            j.Image.Visible = false
        end
        j.Offsets = nil
    end
    v3.Glow.Visible = false
    v3.Halo.Visible = false
    u92 = nil
    u96 = -1
    u89 = -1
    u90 = -1
    u91 = -1
    u73 = -1
    u74 = ""
    u75 = ""
    u76 = ""
end

local function kick(a1) -- Line: 462 -- upvalues: u64 (val), u79 (ref) -- types: a1: number
    local v1 = if not ((u64:NextNumber()) < 0.5) then 1 else -1
    math.clamp(u79 + v1 * a1 * u64:NextNumber(0.8, 1) * 40.840704496667314 / 0.7, -291.719317833338, 291.719317833338)
end

local function flicker(a1, a2) -- Line: 469
    -- upvalues: u82 (ref), u83 (ref), u84 (ref), u85 (ref)
    u82 = a2
    u83 = 1
    u84 = a2[1]
    if u85 == true then
        return
    end
    u85 = true
    a1.Decor.Visible = false
end

local function beat(a1, a2) -- Line: 476
    -- upvalues: u81 (ref), u86 (ref), u64 (val), u79 (ref), u40 (val), u82 (ref), u83 (ref), u84 (ref), u85 (ref)
    -- upvalues: u87 (ref), u36 (val)
    local v1
    local v2 = os.clock()
    if a2 then
        u81 = v2
        u86 = v2
        v1 = if not ((u64:NextNumber()) < 0.5) then 1 else -1
        u79 = math.clamp(u79 + v1 * 4 * u64:NextNumber(0.8, 1) * 40.840704496667314 / 0.7, -291.719317833338, 291.719317833338)
        v1 = u40
        u82 = v1
        u83 = 1
        u84 = v1[1]
        if u85 ~= true then
            u85 = true
            a1.Decor.Visible = false
        end
        u87 = 0.7
        return
    end
    v1 = v2 - u81
    if v1 >= 0.08 then
        u81 = v2
        v1 = if not ((u64:NextNumber()) < 0.5) then 1 else -1
        math.clamp(u79 + v1 * 1.6 * u64:NextNumber(0.8, 1) * 40.840704496667314 / 0.7, -291.719317833338, 291.719317833338)
    end
    math.max(u87, 0.35)
    if u82 == nil then
        v1 = v2 - u86
        if v1 >= 0.22 then
            u86 = v2
            v1 = u36
            u82 = v1
            u83 = 1
            u84 = v1[1]
            if u85 == true then
                return
            end
            u85 = true
            a1.Decor.Visible = false
        end
    end
end

local function updateTarget(a1) -- Line: 496
    -- upvalues: Workspace (val), SammyEvent (val), u70 (ref), u72 (ref), u81 (ref), u86 (ref), u64 (val), u79 (ref)
    -- upvalues: u40 (val), u82 (ref), u83 (ref), u84 (ref), u85 (ref), u87 (ref)
    local v1
    local Attribute = Workspace:GetAttribute("SammyEmpCharge")
    if (if type(Attribute) == "number" then math.clamp(Attribute / SammyEvent.ChargeMax, 0, 1) else 0) == u70 then
        return
    end
    if v1 < 0.99 then
        u72 = true
    elseif u72 and v1 >= 1 then
        u72 = false
        local v2 = os.clock()
        u81 = v2
        u86 = v2
        local v3 = if not ((u64:NextNumber()) < 0.5) then 1 else -1
        math.clamp(u79 + v3 * 4 * u64:NextNumber(0.8, 1) * 40.840704496667314 / 0.7, -291.719317833338, 291.719317833338)
        v3 = u40
        u82 = v3
        u83 = 1
        u84 = v3[1]
        if u85 ~= true then
            u85 = true
            a1.Decor.Visible = false
        end
        u87 = 0.7
    end
    a1.Phantom.Size = UDim2.new(v1, 0, a1.PhantomSizeY.Scale, a1.PhantomSizeY.Offset)
end

local function snapBar(a1) -- Line: 512
    -- upvalues: u70 (ref), Workspace (val), SammyEvent (val), u71 (ref), u73 (ref), u74 (ref), writeEnergy (val)
    local Attribute = Workspace:GetAttribute("SammyEmpCharge")
    u70 = if type(Attribute) == "number" then math.clamp(Attribute / SammyEvent.ChargeMax, 0, 1) else 0
    u71 = u70
    math.round(u71 * a1.BarBG.AbsoluteSize.X)
    a1.Bar.Size = UDim2.new(u71, 0, a1.BarSizeY.Scale, a1.BarSizeY.Offset)
    a1.Phantom.Size = UDim2.new(u70, 0, a1.PhantomSizeY.Scale, a1.PhantomSizeY.Offset)
    local v1 = string.format("%.2f%%", u71 * 100)
    if v1 ~= u74 then
        u74 = v1
        a1.Percent.Text = v1
    end
    writeEnergy(a1, true)
end

local function show(a1) -- Line: 521
    -- upvalues: u67 (ref), u70 (ref), Workspace (val), SammyEvent (val), u71 (ref), u73 (ref), u74 (ref)
    -- upvalues: writeEnergy (val), u75 (ref), u69 (ref), u76 (ref)
    local TitleText
    u67 = true
    a1.Gui.Enabled = true
    local Attribute = Workspace:GetAttribute("SammyEmpCharge")
    u70 = if type(Attribute) == "number" then math.clamp(Attribute / SammyEvent.ChargeMax, 0, 1) else 0
    u71 = u70
    math.round(u71 * a1.BarBG.AbsoluteSize.X)
    a1.Bar.Size = UDim2.new(u71, 0, a1.BarSizeY.Scale, a1.BarSizeY.Offset)
    a1.Phantom.Size = UDim2.new(u70, 0, a1.PhantomSizeY.Scale, a1.PhantomSizeY.Offset)
    local v1 = string.format("%.2f%%", u71 * 100)
    if v1 ~= u74 then
        u74 = v1
        a1.Percent.Text = v1
    end
    writeEnergy(a1, true)
    local v2 = Workspace:GetAttribute("SammyPhase") == "SaveBen"
    if not v2 then
        local Attribute_2 = Workspace:GetAttribute("SammyWeaponRequired")
        v2 = false
        if type(Attribute_2) == "number" then
            v2 = Attribute_2 > 0
        end
        TitleText = if not v2 then a1.TitleText else "Bring Brainrots to the Laser Gun!"
    else
        TitleText = "Save Ben from Mind Controlled Sammy!"
    end
    if TitleText ~= u75 then
        u75 = TitleText
        a1.Title.Text = TitleText
    end
    v1 = math.max(0, (math.floor(u69 - (Workspace:GetServerTimeNow()))))
    v2 = string.format("%02d:%02d", v1 // 60, v1 % 60)
    if v2 ~= u76 then
        u76 = v2
        a1.Timer.Text = v2
    end
end

local function setBarShown(a1, a2) -- Line: 530
    -- upvalues: u68 (ref), u70 (ref), Workspace (val), SammyEvent (val), u71 (ref), u73 (ref), u74 (ref)
    -- upvalues: writeEnergy (val), rest (val)
    if u68 == a2 then
        return
    end
    u68 = a2
    if not a2 then
        rest(a1)
    else
        local Attribute = Workspace:GetAttribute("SammyEmpCharge")
        u70 = if type(Attribute) == "number" then math.clamp(Attribute / SammyEvent.ChargeMax, 0, 1) else 0
        u71 = u70
        math.round(u71 * a1.BarBG.AbsoluteSize.X)
        a1.Bar.Size = UDim2.new(u71, 0, a1.BarSizeY.Scale, a1.BarSizeY.Offset)
        a1.Phantom.Size = UDim2.new(u70, 0, a1.PhantomSizeY.Scale, a1.PhantomSizeY.Offset)
        local v1 = string.format("%.2f%%", u71 * 100)
        if v1 ~= u74 then
            u74 = v1
            a1.Percent.Text = v1
        end
        writeEnergy(a1, true)
    end
    a1.Holder.Visible = a2
end

local function stepBar(a1, a2) -- Line: 543
    -- upvalues: Workspace (val), SammyEvent (val), u70 (ref), u72 (ref), u81 (ref), u86 (ref), u64 (val), u79 (ref)
    -- upvalues: u40 (val), u82 (ref), u83 (ref), u84 (ref), u85 (ref), u87 (ref), u71 (ref), u73 (ref), u77 (ref)
    -- upvalues: u74 (ref), u78 (ref), u80 (ref), u96 (ref), u93 (ref), u94 (ref), setSheet (val), u88 (ref)
    -- upvalues: writeEnergy (val), u92 (ref), buildTremble (val), u95 (ref)
    local Offsets, v1, v2, v3, v4, v5, v6, v7, v8
    local Attribute = Workspace:GetAttribute("SammyEmpCharge")
    local v9 = if type(Attribute) == "number" then math.clamp(Attribute / SammyEvent.ChargeMax, 0, 1) else 0
    if v9 ~= u70 then
        if v9 < 0.99 then
            u72 = true
        elseif u72 and v9 >= 1 then
            u72 = false
            v4 = os.clock()
            u81 = v4
            u86 = v4
            v5 = if not ((u64:NextNumber()) < 0.5) then 1 else -1
            u79 = math.clamp(u79 + v5 * 4 * u64:NextNumber(0.8, 1) * 40.840704496667314 / 0.7, -291.719317833338, 291.719317833338)
            v5 = u40
            u82 = v5
            u83 = 1
            u84 = v5[1]
            if u85 ~= true then
                u85 = true
                a1.Decor.Visible = false
            end
            u87 = 0.7
        end
        a1.Phantom.Size = UDim2.new(v9, 0, a1.PhantomSizeY.Scale, a1.PhantomSizeY.Offset)
    end
    if u71 ~= u70 then
        u71 = u71 + (u70 - u71) * (1 - math.exp(a2 * -9))
        if (math.abs(u70 - u71)) < 0.0004 then
            u71 = u70
        end
        v9 = math.round(u71 * a1.BarBG.AbsoluteSize.X)
        if v9 ~= u73 then
            u73 = v9
            a1.Bar.Size = UDim2.new(u71, 0, a1.BarSizeY.Scale, a1.BarSizeY.Offset)
        end
        u77 = u77 + a2
        if u71 == u70 or u77 >= 0.05 then
            u77 = 0
            v9 = string.format("%.2f%%", u71 * 100)
            if v9 ~= u74 then
                u74 = v9
                a1.Percent.Text = v9
            end
        end
    end
    if u78 ~= 0 then
        v9 = math.max(math.ceil(a2 * 120), 1)
        v4 = a2 / v9
        for i = 1, v9 do
            u79 = u79 + (-1667.9631437841017 * u78 - 24.504422698000386 * u79) * v4
            u78 = u78 + u79 * v4
        end
        if (math.abs(u78)) < 0.02 and (math.abs(u79)) < 0.3 then
            u78 = 0
            u79 = 0
        end
        if 0.02 <= (math.abs(u78 - u80)) or u78 == 0 then
            u80 = u78
            a1.Holder.Rotation = a1.BaseHolderRotation + u78
        end
    elseif u79 ~= 0 then
        v9 = math.max(math.ceil(a2 * 120), 1)
        v4 = a2 / v9
        for j = 1, v9 do
            u79 = u79 + (-1667.9631437841017 * u78 - 24.504422698000386 * u79) * v4
            u78 = u78 + u79 * v4
        end
        if (math.abs(u78)) < 0.02 and (math.abs(u79)) < 0.3 then
            u78 = 0
            u79 = 0
        end
        if 0.02 <= (math.abs(u78 - u80)) or u78 == 0 then
            u80 = u78
            a1.Holder.Rotation = a1.BaseHolderRotation + u78
        end
    end
    v9 = u82
    if not v9 then
        v1, v2 = a1, a2
    else
        u84 = u84 - a2
        v1, v2 = a1, a2
        while u84 <= 0 do
            u83 = u83 + 1
            v4 = v9[u83]
            if v4 == nil then
                u82 = nil
                if u85 == false then
                    break
                end
                u85 = false
                v1.Decor.Visible = true
                break
            end
            u84 = u84 + v4
            v5 = u83 % 2 == 1
            if v5 ~= u85 then
                u85 = v5
                v1.Decor.Visible = not v5
            end
        end
    end
    v9 = u71 * 100
    if v9 ~= u96 then
        local v10
        u96 = v9
        v4 = v9 >= 30
        if u93 ~= v4 then
            u93 = v4
            u94 = 0
            if not v4 then
                v1.Icon.Position = v1.BaseIconPosition
                v1.Icon.Rotation = v1.BaseIconRotation
            end
        end
        v5 = nil
        v6 = nil
        for k, n in v1.LightningSheets, v5, v6 do
            v10 = n.StartAt <= v9
            setSheet(n, v10)
        end
        setSheet(v1.FillSheet, u71 > 0)
    end
    if u87 > 0 then
        u87 = u87 * math.exp(v2 * -5)
        if u87 < 0.01 then
            u87 = 0
        end
    end
    u88 = if not u93 then 0 else u88 + v2
    writeEnergy(v1, false)
    if u93 then
        local X_2 = v1.Icon.AbsoluteSize.X
        v5 = u92
        if v5 == nil or v5.Width ~= X_2 then
            buildTremble(v1, X_2)
        end
        u94 = u94 + v2
        if u94 >= 0.03333333333333333 then
            u94 = u94 % 0.03333333333333333
            v6 = math.clamp(math.floor((v9 - 30) / 70 * 3 + 0.5) + 1, 1, 4)
            u95 = (u95 + u64:NextInteger(3, 9) - 1) % 12 + 1
            v1.Icon.Position = v5.Positions[v6][u95]
            v1.Icon.Rotation = v5.Rotations[v6][u95]
        end
    end
    v5 = nil
    v6 = nil
    for m, i5 in v1.AllSheets, v5, v6 do
        Offsets = i5.Offsets
        if i5.On and Offsets ~= nil then
            v7 = i5.Acc + v2
            if i5.FrameTime <= v7 then
                v8 = v7 // i5.FrameTime
                v7 = v7 - v8 * i5.FrameTime
                v3 = i5.Frame - 1 + v8
                i5.Frame = v3 % i5.Frames + 1
                i5.Image.ImageRectOffset = Offsets[i5.Frame]
            end
            i5.Acc = v7
        end
    end
end

local function step(a1) -- Line: 645
    -- upvalues: u65 (ref), u66 (ref), HiddenUIHandler (val), u67 (ref), u68 (ref), rest (val), u70 (ref)
    -- upvalues: Workspace (val), SammyEvent (val), u71 (ref), u73 (ref), u74 (ref), writeEnergy (val), u75 (ref)
    -- upvalues: u69 (ref), u76 (ref), stepBar (val)
    local v1 = u65
    if u66 and v1 ~= nil then
        local TitleText_2, v2, v3
        if HiddenUIHandler.IsHidden() then
            if u67 then
                u67 = false
                u68 = false
                rest(v1)
                v1.Gui.Enabled = false
            end
            return
        end
        if not u67 then
            local TitleText
            u67 = true
            v1.Gui.Enabled = true
            local Attribute = Workspace:GetAttribute("SammyEmpCharge")
            u70 = if type(Attribute) == "number" then math.clamp(Attribute / SammyEvent.ChargeMax, 0, 1) else 0
            u71 = u70
            math.round(u71 * v1.BarBG.AbsoluteSize.X)
            v1.Bar.Size = UDim2.new(u71, 0, v1.BarSizeY.Scale, v1.BarSizeY.Offset)
            v1.Phantom.Size = UDim2.new(u70, 0, v1.PhantomSizeY.Scale, v1.PhantomSizeY.Offset)
            v2 = string.format("%.2f%%", u71 * 100)
            if v2 ~= u74 then
                u74 = v2
                v1.Percent.Text = v2
            end
            writeEnergy(v1, true)
            v3 = Workspace:GetAttribute("SammyPhase") == "SaveBen"
            if not v3 then
                local Attribute_2 = Workspace:GetAttribute("SammyWeaponRequired")
                v3 = false
                if type(Attribute_2) == "number" then
                    v3 = Attribute_2 > 0
                end
                TitleText = if not v3 then v1.TitleText else "Bring Brainrots to the Laser Gun!"
            else
                TitleText = "Save Ben from Mind Controlled Sammy!"
            end
            if TitleText ~= u75 then
                u75 = TitleText
                v1.Title.Text = TitleText
            end
            v2 = math.max(0, (math.floor(u69 - (Workspace:GetServerTimeNow()))))
            v3 = string.format("%02d:%02d", v2 // 60, v2 % 60)
            if v3 ~= u76 then
                u76 = v3
                v1.Timer.Text = v3
            end
        end
        local v4 = math.min(a1, 0.1)
        local Attribute_3 = Workspace:GetAttribute("SammyWeaponRequired")
        v3 = false
        if type(Attribute_3) == "number" then
            v3 = Attribute_3 > 0
        end
        v2 = not v3 and not (Workspace:GetAttribute("SammyPhase") == "SaveBen")
        if u68 ~= v2 then
            u68 = v2
            if not v2 then
                rest(v1)
            else
                local Attribute_4 = Workspace:GetAttribute("SammyEmpCharge")
                u70 = if type(Attribute_4) == "number" then math.clamp(Attribute_4 / SammyEvent.ChargeMax, 0, 1) else 0
                u71 = u70
                math.round(u71 * v1.BarBG.AbsoluteSize.X)
                v1.Bar.Size = UDim2.new(u71, 0, v1.BarSizeY.Scale, v1.BarSizeY.Offset)
                v1.Phantom.Size = UDim2.new(u70, 0, v1.PhantomSizeY.Scale, v1.PhantomSizeY.Offset)
                v3 = string.format("%.2f%%", u71 * 100)
                if v3 ~= u74 then
                    u74 = v3
                    v1.Percent.Text = v3
                end
                writeEnergy(v1, true)
            end
            v1.Holder.Visible = v2
        end
        if u68 then
            stepBar(v1, v4)
        end
        v3 = Workspace:GetAttribute("SammyPhase") == "SaveBen"
        if not v3 then
            local Attribute_5 = Workspace:GetAttribute("SammyWeaponRequired")
            v3 = false
            if type(Attribute_5) == "number" then
                v3 = Attribute_5 > 0
            end
            TitleText_2 = if not v3 then v1.TitleText else "Bring Brainrots to the Laser Gun!"
        else
            TitleText_2 = "Save Ben from Mind Controlled Sammy!"
        end
        if TitleText_2 ~= u75 then
            u75 = TitleText_2
            v1.Title.Text = TitleText_2
        end
        v2 = math.max(0, (math.floor(u69 - (Workspace:GetServerTimeNow()))))
        v3 = string.format("%02d:%02d", v2 // 60, v2 % 60)
        if v3 ~= u76 then
            u76 = v3
            v1.Timer.Text = v3
        end
        return
    end
end

local function stop() -- Line: 672 -- upvalues: u66 (ref), u67 (ref), u68 (ref), u65 (ref), rest (val)
    if not u66 then
        return
    end
    u66 = false
    u67 = false
    u68 = false
    local v1 = u65
    if v1 == nil then
        return
    end
    rest(v1)
    v1.Gui.Enabled = false
end

return {
    Start = function(a1, a2) -- Line: 695
        -- upvalues: resolveUi (val), u66 (ref), u67 (ref), u68 (ref), u69 (ref), u70 (ref), Workspace (val)
        -- upvalues: SammyEvent (val), u71 (ref), u72 (ref), RunService (val), step (val), stop (val)
        resolveUi()
        u66 = true
        u67 = false
        u68 = false
        u69 = a2
        local Attribute = Workspace:GetAttribute("SammyEmpCharge")
        u70 = if type(Attribute) == "number" then math.clamp(Attribute / SammyEvent.ChargeMax, 0, 1) else 0
        u71 = u70
        u72 = u70 < 0.99
        a1:Connect(RunService.PreRender, step)
        a1:Add(stop)
    end,
    Stop = stop,
    PickupArrived = function(a1) -- Line: 688
        -- upvalues: u65 (ref), u66 (ref), u67 (ref), u81 (ref), u64 (val), u79 (ref), u87 (ref), u82 (ref), u86 (ref)
        -- upvalues: u36 (val), u83 (ref), u84 (ref), u85 (ref)
        local v1 = u65
        if u66 and u67 and v1 ~= nil then
            local v2 = os.clock()
            local v3 = v2 - u81
            if v3 >= 0.08 then
                u81 = v2
                v3 = if not ((u64:NextNumber()) < 0.5) then 1 else -1
                math.clamp(u79 + v3 * 1.6 * u64:NextNumber(0.8, 1) * 40.840704496667314 / 0.7, -291.719317833338, 291.719317833338)
            end
            math.max(u87, 0.35)
            if u82 == nil then
                v3 = v2 - u86
                if v3 >= 0.22 then
                    u86 = v2
                    v3 = u36
                    u82 = v3
                    u83 = 1
                    u84 = v3[1]
                    if u85 == true then
                        return
                    end
                    u85 = true
                    v1.Decor.Visible = false
                end
            end
        end
    end,
}