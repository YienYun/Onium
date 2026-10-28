-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.LightVsDarkness.TeamSystem
-- Decompile time: 23.44 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local GUI = require(ReplicatedStorage.Client.GUI)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
require(ReplicatedStorage.Packages.Trove)
local u32 = {LightTeam = "Light", DarkTeam = "Darkness"}
local u33 = {
    ["rbxassetid://90736891527931"] = "ChooseTeam_Hover",
    ["rbxassetid://135310337267680"] = "ChooseTeam_Select",
    ["rbxassetid://91838958509194"] = "ChooseTeam_Deselect",
}
local LocalPlayer = Players.LocalPlayer
local u38 = nil
local u39 = nil
local u40 = {}
local u41 = {}
local u42 = {}
local u43 = nil
local u44 = {}
local u45 = {}
local u46 = nil
local u47 = false
local u48 = 0

local function easeOutBack(a1) -- Line: 104 -- types: a1: number
    local v1 = a1 - 1
    return v1 * 2.70158 * v1 * v1 + 1 + v1 * 1.70158 * v1
end

local function easeOutQuad(a1) -- Line: 111 -- types: a1: number
    local v1 = 1 - a1
    return 1 - v1 * v1
end

local function grown(a1, a2) -- Line: 117 -- types: a1: userdata, a2: number
    return UDim2.new(a1.X.Scale * a2, a1.X.Offset * a2, a1.Y.Scale * a2, a1.Y.Offset * a2)
end

local function raised(a1, a2) -- Line: 124 -- types: a1: userdata, a2: number
    return UDim2.new(a1.X.Scale, a1.X.Offset, a1.Y.Scale + a2, a1.Y.Offset)
end

local function advance(a1, a2, a3, a4) -- Line: 128 -- types: a2: number, a3: number, a4: number
    if not a1.on then
        a1.p = math.max(0, a1.p - a2 / a4)
    else
        a1.p = math.min(1, a1.p + a2 / a3)
    end
    return a1.p
end

local function frame(a1) -- Line: 138 -- upvalues: u45 (val), u46 (ref) -- types: a1: number
    local v1
    if a1 > 0.1 then
        a1 = 0.1
    end
    for i = #u45, 1, -1 do
        v1 = u45[i]
        if v1.dead or not v1.update(v1, a1) then
            v1.running = false
            table.remove(u45, i)
        end
    end
    if #u45 == 0 and u46 then
        u46:Disconnect()
        u46 = nil
    end
end

local function wake(a1) -- Line: 155 -- upvalues: u45 (val), u46 (ref), RunService (val), frame (val)
    if not a1.running and not a1.dead then
        a1.running = true
        table.insert(u45, a1)
        if not u46 then
            RunService.PreRender:Connect(frame)
        end
        return
    end
end

local function play(a1) -- Line: 167 -- upvalues: u44 (val), u33 (val), SoundService (val) -- types: a1: string
    local v1 = u44[a1]
    if v1 == nil then
        v1 = Instance.new("Sound")
        v1.Name = u33[a1] or "ChooseTeam_SFX"
        v1.SoundId = a1
        v1.Volume = 0.5
        v1.Parent = SoundService
        u44[a1] = v1
    end
    v1.TimePosition = 0
    v1:Play()
end

local function restCard(a1) -- Line: 181
    a1.card.Size = a1.cardSize
    a1.card.ZIndex = a1.cardZ
    a1.hover.Visible = false
    a1.hover.Position = a1.idlePos
    a1.hover.Size = a1.idleSize
    a1.hover.ImageTransparency = a1.hoverAlpha
    a1.idle.ImageTransparency = a1.idleAlpha
    for i, j in a1.fx do
        j.ImageTransparency = a1.fxAlpha[i]
    end
    a1.phase = 0
    a1.press = 1
end

local function updateCard(a1, a2) -- Line: 196 -- upvalues: restCard (val) -- types: a2: number
    local v1, v2
    if not a1.on then
        a1.p = math.max(0, a1.p - a2 / 0.16)
    else
        a1.p = math.min(1, a1.p + a2 / 0.22)
    end
    local p = a1.p
    a1.press = a1.press + ((if not a1.pressed then 1 else 0.95) - a1.press) * (1 - math.exp(-a2 / 0.09))
    if not (0.001 < (math.abs(a1.press - 1))) then
        a1.press = 1
    end
    if p <= 0 and not a1.on and not v1 then
        restCard(a1)
        return false
    end
    if not a1.on then
        v2 = 1 - p
        v1 = 1 - v2 * v2
    else
        v2 = p - 1
        v1 = v2 * 2.70158 * v2 * v2 + 1 + v2 * 1.70158 * v2
    end
    local card = a1.card
    local cardSize = a1.cardSize
    local v3 = (v1 * 0.050000000000000044 + 1) * a1.press
    card.Size = UDim2.new(cardSize.X.Scale * v3, cardSize.X.Offset * v3, cardSize.Y.Scale * v3, cardSize.Y.Offset * v3)
    a1.phase = (a1.phase + a2 * 0.9 * 6.283185307179586) % 6.283185307179586
    v2 = math.sin(a1.phase)
    local hover = a1.hover
    v3 = a1.idlePos:Lerp(a1.hoverPos, v1)
    hover.Position = UDim2.new(v3.X.Scale, v3.X.Offset, v3.Y.Scale + v2 * 0.014 * v1, v3.Y.Offset)
    local hover_2 = a1.hover
    v3 = a1.idleSize:Lerp(a1.hoverSize, v1)
    local v4 = v2 * 0.012 * v1 + 1
    hover_2.Size = UDim2.new(v3.X.Scale * v4, v3.X.Offset * v4, v3.Y.Scale * v4, v3.Y.Offset * v4)
    v2 = math.min(1, p * 1.35)
    a1.hover.ImageTransparency = a1.hoverAlpha + (1 - a1.hoverAlpha) * (1 - v2)
    a1.idle.ImageTransparency = a1.idleAlpha + (1 - a1.idleAlpha) * v2
    for i, j in a1.fx do
        v1 = a1.fxAlpha[i]
        j.ImageTransparency = v1 + (1 - v1) * (1 - v2)
    end
    return true
end

local function panelShown() -- Line: 232 -- upvalues: u39 (ref)
    local v1 = u39
    local Visible = false
    if v1 ~= nil then
        Visible = v1.Visible
    end
    return Visible
end

local function refreshCard(a1) -- Line: 238
    -- upvalues: u39 (ref), updateCard (val), u45 (val), u46 (ref), RunService (val), frame (val)
    local selected, v1
    if a1.hovered then
        v1 = u39
        selected = false
        if v1 ~= nil then
            selected = v1.Visible
        end
    else
        selected = a1.selected
        if selected then
            v1 = u39
            selected = false
            if v1 ~= nil then
                selected = v1.Visible
            end
        end
    end
    if a1.on ~= selected then
        a1.on = selected
        if selected then
            updateCard(a1, 0)
            a1.hover.Visible = true
            a1.card.ZIndex = 100
        end
    end
    if not a1.running then
        if a1.dead then
            return
        end
        a1.running = true
        table.insert(u45, a1)
        if not u46 then
            RunService.PreRender:Connect(frame)
        end
    end
end

local function updateStroke(a1, a2) -- Line: 255 -- types: a2: number
    local v1, v2
    if not a1.on then
        a1.p = math.max(0, a1.p - a2 / 0.18)
    else
        a1.p = math.min(1, a1.p + a2 / 0.26)
    end
    local p = a1.p
    if p <= 0 and not a1.on then
        a1.stroke.Enabled = false
        a1.stroke.Thickness = a1.thickness
        a1.stroke.Transparency = a1.transparency
        return false
    end
    if not a1.on then
        v2 = 1 - p
        v1 = 1 - v2 * v2
    else
        v2 = p - 1
        v1 = v2 * 2.70158 * v2 * v2 + 1 + v2 * 1.70158 * v2
    end
    a1.stroke.Enabled = true
    a1.stroke.Thickness = math.max(0, a1.thickness * v1)
    a1.stroke.Transparency = a1.transparency + (1 - a1.transparency) * (1 - p)
    return true
end

local function select(a1) -- Line: 271
    -- upvalues: u43 (ref), u44 (val), u33 (val), SoundService (val), u42 (val), u45 (val), u46 (ref), RunService (val)
    -- upvalues: frame (val), u41 (val), u39 (ref), updateCard (val)
    local selected, v1, v2
    u43 = if u43 ~= a1 then a1 else nil
    local v3 = u44[if not u43 then "rbxassetid://91838958509194" else "rbxassetid://135310337267680"]
    if v3 == nil then
        local v4
        v3 = Instance.new("Sound")
        v3.Name = u33[v4] or "ChooseTeam_SFX"
        v3.SoundId = v4
        v3.Volume = 0.5
        v3.Parent = SoundService
        u44[v4] = v3
    end
    v3.TimePosition = 0
    v3:Play()
    v3 = nil
    local v5 = nil
    for i, j in u42, v3, v5 do
        v1 = i == u43
        if j.on ~= v1 then
            j.on = v1
            if not j.running and not j.dead then
                j.running = true
                table.insert(u45, j)
                if not u46 then
                    u46 = RunService.PreRender:Connect(frame)
                end
            end
        end
    end
    v3 = nil
    v5 = nil
    for k, n in u41, v3, v5 do
        v1 = k == u43
        n.selected = v1
        if n.hovered then
            v2 = u39
            selected = false
            if v2 ~= nil then
                selected = v2.Visible
            end
        else
            selected = n.selected
            if selected then
                v2 = u39
                selected = false
                if v2 ~= nil then
                    selected = v2.Visible
                end
            end
        end
        if n.on ~= selected then
            n.on = selected
            if selected then
                updateCard(n, 0)
                n.hover.Visible = true
                n.card.ZIndex = 100
            end
        end
        if not n.running and not n.dead then
            n.running = true
            table.insert(u45, n)
            if not u46 then
                RunService.PreRender:Connect(frame)
            end
        end
    end
end

local function cardParts(a1) -- Line: 287 -- types: a1: userdata
    local IdleIcon = a1:FindFirstChild("IdleIcon")
    local HoverIcon = a1:FindFirstChild("HoverIcon")
    local v1 = ("%* needs an IdleIcon and a HoverIcon"):format((a1:GetFullName()))
    assert(IdleIcon and IdleIcon:IsA("ImageLabel") and HoverIcon and HoverIcon:IsA("ImageLabel"), v1)
    local StrokeHolder = a1:FindFirstChild("StrokeHolder")
    local SelectedUIStroke = if not StrokeHolder then nil else StrokeHolder:FindFirstChild("SelectedUIStroke")
    local v2 = ("%* needs a StrokeHolder.SelectedUIStroke"):format((a1:GetFullName()))
    assert(SelectedUIStroke and SelectedUIStroke:IsA("UIStroke"), v2)
    return IdleIcon, HoverIcon, SelectedUIStroke
end

local function authoredFor(a1) -- Line: 300 -- upvalues: u40 (val), cardParts (val) -- types: a1: userdata
    local v1 = u40[a1]
    if v1 then
        return v1
    end
    local v2, v3, v4 = cardParts(a1)
    v1 = {}
    for i, j in v3:GetDescendants() do
        if j:IsA("ImageLabel") then
            v1[j] = j.ImageTransparency
        end
    end
    local v5 = {
        CardSize = a1.Size,
        CardZ = a1.ZIndex,
        IdleAlpha = v2.ImageTransparency,
        IdlePos = v2.Position,
        IdleSize = v2.Size,
        HoverAlpha = v3.ImageTransparency,
        HoverPos = v3.Position,
        HoverSize = v3.Size,
        FxAlpha = v1,
        StrokeThickness = v4.Thickness,
        StrokeTransparency = v4.Transparency,
    }
    u40[a1] = v5
    return v5
end

local function setupCard(a1, a2) -- Line: 329
    -- upvalues: cardParts (val), authoredFor (val), updateCard (val), restCard (val), u44 (val), u33 (val)
    -- upvalues: SoundService (val), u39 (ref), u45 (val), u46 (ref), RunService (val), frame (val), select (val)
    local v1, v2 = cardParts(a1)
    local v3 = authoredFor(a1)
    local v4 = {}
    local v5 = {}
    local v6 = a2
    for i, j in v2:GetDescendants() do
        if j:IsA("ImageLabel") then
            table.insert(v4, j)
            table.insert(v5, v3.FxAlpha[j] or j.ImageTransparency)
        end
    end
    local u23 = {
        p = 0,
        phase = 0,
        press = 1,
        on = false,
        hovered = false,
        selected = false,
        pressed = false,
        running = false,
        dead = false,
        card = a1,
        idle = v1,
        hover = v2,
        fx = v4,
        fxAlpha = v5,
        idleAlpha = v3.IdleAlpha,
        hoverAlpha = v3.HoverAlpha,
        cardSize = v3.CardSize,
        cardZ = v3.CardZ,
        idlePos = v3.IdlePos,
        idleSize = v3.IdleSize,
        hoverPos = v3.HoverPos,
        hoverSize = v3.HoverSize,
        update = updateCard,
    }
    v2.ZIndex = 999
    v2.Active = false
    restCard(u23)
    v6:Connect(a1.MouseEnter, function() -- Line: 373
        -- upvalues: u23 (val), u44 (upval), u33 (upval), SoundService (upval), u39 (upval), updateCard (upval)
        -- upvalues: u45 (upval), u46 (upval), RunService (upval), frame (upval)
        local selected, v1
        u23.hovered = true
        local v2 = u44["rbxassetid://90736891527931"]
        if v2 == nil then
            v2 = Instance.new("Sound")
            v2.Name = u33["rbxassetid://90736891527931"] or "ChooseTeam_SFX"
            v2.SoundId = "rbxassetid://90736891527931"
            v2.Volume = 0.5
            v2.Parent = SoundService
            u44["rbxassetid://90736891527931"] = v2
        end
        v2.TimePosition = 0
        v2:Play()
        v2 = u23
        if v2.hovered then
            v1 = u39
            selected = false
            if v1 ~= nil then
                selected = v1.Visible
            end
        else
            selected = v2.selected
            if selected then
                v1 = u39
                selected = false
                if v1 ~= nil then
                    selected = v1.Visible
                end
            end
        end
        if v2.on ~= selected then
            v2.on = selected
            if selected then
                updateCard(v2, 0)
                v2.hover.Visible = true
                v2.card.ZIndex = 100
            end
        end
        if not v2.running then
            if v2.dead then
                return
            end
            v2.running = true
            table.insert(u45, v2)
            if not u46 then
                local v3 = frame
                RunService.PreRender:Connect(v3)
            end
        end
    end)
    v6:Connect(a1.MouseLeave, function() -- Line: 378
        -- upvalues: u23 (val), u39 (upval), updateCard (upval), u45 (upval), u46 (upval), RunService (upval)
        -- upvalues: frame (upval)
        local selected, v1
        u23.hovered = false
        u23.pressed = false
        local v2 = u23
        if v2.hovered then
            v1 = u39
            selected = false
            if v1 ~= nil then
                selected = v1.Visible
            end
        else
            selected = v2.selected
            if selected then
                v1 = u39
                selected = false
                if v1 ~= nil then
                    selected = v1.Visible
                end
            end
        end
        if v2.on ~= selected then
            v2.on = selected
            if selected then
                updateCard(v2, 0)
                v2.hover.Visible = true
                v2.card.ZIndex = 100
            end
        end
        if not v2.running then
            if v2.dead then
                return
            end
            v2.running = true
            table.insert(u45, v2)
            if not u46 then
                local v3 = frame
                RunService.PreRender:Connect(v3)
            end
        end
    end)
    v6:Connect(a1.MouseButton1Down, function() -- Line: 383 -- upvalues: u23 (val), u45 (upval), u46 (upval), RunService (upval), frame (upval)
        u23.pressed = true
        local v1 = u23
        if not v1.running then
            if v1.dead then
                return
            end
            v1.running = true
            table.insert(u45, v1)
            if not u46 then
                local v2 = frame
                RunService.PreRender:Connect(v2)
            end
        end
    end)
    v6:Connect(a1.MouseButton1Up, function() -- Line: 387 -- upvalues: u23 (val), u45 (upval), u46 (upval), RunService (upval), frame (upval)
        u23.pressed = false
        local v1 = u23
        if not v1.running then
            if v1.dead then
                return
            end
            v1.running = true
            table.insert(u45, v1)
            if not u46 then
                local v2 = frame
                RunService.PreRender:Connect(v2)
            end
        end
    end)
    v6:Connect(a1.TouchTap, function() -- Line: 391 -- upvalues: u23 (val), u45 (upval), u46 (upval), RunService (upval), frame (upval)
        u23.pressed = false
        local v1 = u23
        if not v1.running then
            if v1.dead then
                return
            end
            v1.running = true
            table.insert(u45, v1)
            if not u46 then
                local v2 = frame
                RunService.PreRender:Connect(v2)
            end
        end
    end)
    a1.Active = true
    v6:Connect(a1.Activated, function() -- Line: 397 -- upvalues: select (upval), a1 (val)
        select(a1)
    end)
    return u23
end

local function setupStroke(a1) -- Line: 403
    -- upvalues: cardParts (val), authoredFor (val), updateStroke (val)
    local v1
    _, _, v1 = cardParts(a1)
    local v2 = authoredFor(a1)
    local v3 = {
        p = 0,
        on = false,
        running = false,
        dead = false,
        stroke = v1,
        thickness = v2.StrokeThickness,
        transparency = v2.StrokeTransparency,
        update = updateStroke,
    }
    v1.Enabled = false
    return v3
end

local function hasTeam() -- Line: 420 -- upvalues: LocalPlayer (val)
    return type((LocalPlayer:GetAttribute("LvdTeam"))) == "string"
end

local function autoPick(a1) -- Line: 426
    -- upvalues: u43 (ref), u48 (ref), u47 (ref), u39 (ref), LocalPlayer (val), Remotes (val), u32 (val)
    local v1 = u43
    if a1 == u48 and u47 then
        local v2 = u39
        local Visible = false
        if v2 ~= nil then
            Visible = v2.Visible
        end
        if Visible and not (type((LocalPlayer:GetAttribute("LvdTeam"))) == "string") then
            Remotes.LightVsDarkness.AskSelectTeam:FireServer(if not v1 then "Random" else u32[v1.Name])
            return
        end
    end
end

local function setPanelShown(a1) -- Line: 435
    -- upvalues: u39 (ref), u48 (ref), autoPick (val), u41 (val), updateCard (val), u45 (val), u46 (ref)
    -- upvalues: RunService (val), frame (val)
    local v1 = u39
    if v1 ~= nil and v1.Visible ~= a1 then
        local selected, v2
        v1.Visible = a1
        u48 = u48 + 1
        if a1 then
            task.delay(20, autoPick, u48)
        end
        local v3 = nil
        local v4 = nil
        for i, j in u41, v3, v4 do
            if not a1 then
                j.hovered = false
                j.pressed = false
            end
            if j.hovered then
                v2 = u39
                selected = false
                if v2 ~= nil then
                    selected = v2.Visible
                end
            else
                selected = j.selected
                if selected then
                    v2 = u39
                    selected = false
                    if v2 ~= nil then
                        selected = v2.Visible
                    end
                end
            end
            if j.on ~= selected then
                j.on = selected
                if selected then
                    updateCard(j, 0)
                    j.hover.Visible = true
                    j.card.ZIndex = 100
                end
            end
            if not j.running and not j.dead then
                j.running = true
                table.insert(u45, j)
                if not u46 then
                    RunService.PreRender:Connect(frame)
                end
            end
        end
        return
    end
end

local function confirm() -- Line: 454 -- upvalues: u43 (ref), u47 (ref), LocalPlayer (val), Remotes (val), u32 (val)
    local v1 = u43
    if u47 and v1 ~= nil and not (type((LocalPlayer:GetAttribute("LvdTeam"))) == "string") then
        Remotes.LightVsDarkness.AskSelectTeam:FireServer(u32[v1.Name])
        return
    end
end

local function refresh() -- Line: 464 -- upvalues: setPanelShown (val), u47 (ref), LocalPlayer (val)
    setPanelShown(u47 and not (type((LocalPlayer:GetAttribute("LvdTeam"))) == "string"))
end

local function start() -- Line: 468
    -- upvalues: u38 (ref), GUI (val), u39 (ref), u47 (ref), u43 (ref), u41 (val), u42 (val), u32 (val), setupCard (val)
    -- upvalues: setupStroke (val), confirm (val), LocalPlayer (val), refresh (val), u48 (ref), updateCard (val)
    -- upvalues: u45 (val), u46 (ref), RunService (val), frame (val), restCard (val), u44 (val), setPanelShown (val)
    local AssetTrove = u38.AssetTrove
    local TeamSelection = GUI.LightVsDarknessUI():FindFirstChild("TeamSelection")
    assert(TeamSelection and TeamSelection:IsA("Frame"), "LightVsDarknessUI.TeamSelection must be a Frame")
    u39 = TeamSelection
    u47 = true
    u43 = nil
    table.clear(u41)
    table.clear(u42)
    local v1 = TeamSelection:FindFirstChild("TeamHolder")
    assert(v1, "TeamSelection.TeamHolder is missing")
    for i, j in v1:GetChildren() do
        if j:IsA("ImageButton") and u32[j.Name] ~= nil then
            u41[j] = (setupCard(j, AssetTrove))
            u42[j] = (setupStroke(j))
        end
    end
    v1 = TeamSelection:FindFirstChild("ConfirmBTN")
    assert(v1 and v1:IsA("ImageButton"), "TeamSelection.ConfirmBTN must be an ImageButton")
    GUI.OnActivated(v1, confirm)
    AssetTrove:Connect(LocalPlayer:GetAttributeChangedSignal("LvdTeam"), refresh)
    AssetTrove:Add(function() -- Line: 493
        -- upvalues: u47 (upval), u39 (upval), u48 (upval), u41 (upval), updateCard (upval), u45 (upval), u46 (upval)
        -- upvalues: RunService (upval), frame (upval), restCard (upval), u42 (upval), u43 (upval), u44 (upval)
        u47 = false
        local v1 = u39
        if v1 ~= nil and v1.Visible ~= false then
            local selected, v2, v3
            v1.Visible = false
            u48 = u48 + 1
            local v4 = nil
            local v5 = nil
            for i, j in u41, v4, v5 do
                j.hovered = false
                j.pressed = false
                if j.hovered then
                    v2 = u39
                    selected = false
                    if v2 ~= nil then
                        selected = v2.Visible
                    end
                else
                    selected = j.selected
                    if selected then
                        v2 = u39
                        selected = false
                        if v2 ~= nil then
                            selected = v2.Visible
                        end
                    end
                end
                if j.on ~= selected then
                    j.on = selected
                    if selected then
                        updateCard(j, 0)
                        j.hover.Visible = true
                        j.card.ZIndex = 100
                    end
                end
                if not j.running and not j.dead then
                    j.running = true
                    table.insert(u45, j)
                    if not u46 then
                        v3 = frame
                        u46 = RunService.PreRender:Connect(v3)
                    end
                end
            end
        end
        for k, n in u41 do
            n.dead = true
            restCard(n)
        end
        for m, i5 in u42 do
            i5.dead = true
            i5.stroke.Enabled = false
            i5.stroke.Thickness = i5.thickness
            i5.stroke.Transparency = i5.transparency
        end
        table.clear(u41)
        table.clear(u42)
        u43 = nil
        if u46 then
            u46:Disconnect()
            u46 = nil
        end
        table.clear(u45)
        for i6, i7 in u44 do
            i7:Destroy()
        end
        table.clear(u44)
    end)
    setPanelShown(u47 and not (type((LocalPlayer:GetAttribute("LvdTeam"))) == "string"))
end

local function stop() -- Line: 524
    -- upvalues: u47 (ref), u39 (ref), u48 (ref), u41 (val), updateCard (val), u45 (val), u46 (ref), RunService (val)
    -- upvalues: frame (val)
    u47 = false
    local v1 = u39
    if v1 ~= nil then
        local selected, v2
        if v1.Visible == false then
            return
        end
        v1.Visible = false
        u48 = u48 + 1
        local v3 = nil
        local v4 = nil
        for i, j in u41, v3, v4 do
            j.hovered = false
            j.pressed = false
            if j.hovered then
                v2 = u39
                selected = false
                if v2 ~= nil then
                    selected = v2.Visible
                end
            else
                selected = j.selected
                if selected then
                    v2 = u39
                    selected = false
                    if v2 ~= nil then
                        selected = v2.Visible
                    end
                end
            end
            if j.on ~= selected then
                j.on = selected
                if selected then
                    updateCard(j, 0)
                    j.hover.Visible = true
                    j.card.ZIndex = 100
                end
            end
            if not j.running and not j.dead then
                j.running = true
                table.insert(u45, j)
                if not u46 then
                    RunService.PreRender:Connect(frame)
                end
            end
        end
    end
end

return function(a1) -- Line: 531 -- upvalues: u38 (ref), start (val), stop (val) -- types: a1: table
    u38 = a1
    return {Start = start, Stop = stop}
end