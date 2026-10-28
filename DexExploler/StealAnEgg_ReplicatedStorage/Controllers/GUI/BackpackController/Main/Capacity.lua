-- Script path: ReplicatedStorage.Controllers.GUI.BackpackController.Main.Capacity
-- Decompile time: 6.65 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local HoverCard = require(ReplicatedStorage.Client.HoverCard)
local Save = require(ReplicatedStorage.Shared.Save)
local Trove = require(ReplicatedStorage.Packages.Trove)

local function count(a1) -- Line: 12
    local v1 = 0
    for i in a1 or {} do
        v1 = v1 + 1
    end
    return v1
end

return function(a1, a2) -- Line: 18
    -- upvalues: Trove (val), Constants (val), Save (val), Eggs (val), HoverCard (val), RunService (val)
    -- upvalues: TweenService (val)
    local u4 = Trove.new()
    local TextButton = Instance.new("TextButton")
    TextButton.Name = "Capacity"
    TextButton.BackgroundTransparency = 1
    TextButton.AutoButtonColor = false
    TextButton.TextXAlignment = Enum.TextXAlignment.Left
    TextButton.Font = Enum.Font.GothamBold
    TextButton.TextScaled = true
    local u17 = UDim2.fromScale(0.015, 0.1)
    TextButton.Position = u17
    TextButton.Size = UDim2.fromScale(0.3, 0.06)
    TextButton.TextColor3 = Color3.fromRGB(225, 225, 235)
    TextButton.TextStrokeColor3 = Color3.fromRGB(20, 20, 25)
    TextButton.TextStrokeTransparency = 0.3
    TextButton.Selectable = true
    TextButton.ZIndex = 3
    TextButton.Parent = a1
    u4:Add(TextButton)
    local u39 = "Pets"
    local u40 = 0
    local LIMIT = Constants.BACKPACK.LIMIT
    local u44 = false
    local u45 = 0
    local u46 = nil
    local u47 = 0
    local u51 = a1:FindFirstAncestorOfClass("ScreenGui")

    local function isOpen() -- Line: 44 -- upvalues: TextButton (val), a1 (val), a2 (val), u51 (val)
        local Visible = TextButton.Visible
        if Visible then
            Visible = a1.Visible
            if Visible then
                Visible = a2.Visible
                if Visible then
                    Visible = false
                    if u51 ~= nil then
                        Visible = u51.Enabled
                    end
                end
            end
        end
        return Visible
    end

    local function refresh() -- Line: 53
        -- upvalues: u39 (ref), a1 (val), TextButton (val), u44 (ref), u47 (ref), u46 (ref), u17 (val), u45 (ref)
        -- upvalues: Save (upval), u40 (ref), LIMIT (ref), Constants (upval), Eggs (upval)
        u39 = a1:GetAttribute("CapacityCategory") or "Pets"
        local v1 = true
        if u39 ~= "Pets" then
            v1 = u39 == "Eggs"
        end
        TextButton.Visible = v1
        if not TextButton.Visible then
            u44 = false
            u47 = u47 + 1
            if u46 then
                u46:Cancel()
                u46 = nil
            end
            TextButton.Position = u17
            u45 = 0
            return
        end
        local v2 = Save.Await()
        if not v2 then
            TextButton.Text = "Capacity loading..."
            return
        end
        local Inventory = if u39 ~= "Pets" then v2.EggInventory else v2.Inventory
        v1 = 0
        for i in Inventory or {} do
            v1 = v1 + 1
        end
        u40 = v1
        LIMIT = if u39 ~= "Pets" then Eggs.MAX_INVENTORY else Constants.BACKPACK.LIMIT
        TextButton.Text = ("%*: %*/%*"):format(u39, u40, LIMIT)
        v2 = u40 / LIMIT
        u44 = v2 >= 1
        local v3 = if not (v2 >= 0.9) then Color3.fromRGB(225, 225, 235) else Color3.fromRGB(255, 80, 85)
        TextButton.TextColor3 = v3
        if not u44 then
            u47 = u47 + 1
            if u46 then
                u46:Cancel()
                u46 = nil
            end
            TextButton.Position = u17
            u45 = 0
        end
    end

    local function tooltipRows() -- Line: 75 -- upvalues: TextButton (val), u39 (ref), u40 (ref), LIMIT (ref)
        if not TextButton.Visible then
            return nil
        end
        local v1 = {{kind = "heading", text = ("%*: %* / %*"):format(u39, u40, LIMIT)}}
        if LIMIT < u40 then
            table.insert(v1, {kind = "rule"})
            table.insert(v1, {
                kind = "body",
                text = ("Overflow: +%*. Purchases or special grants can exceed the limit."):format(u40 - LIMIT),
            })
        end
        return v1
    end

    local u60 = HoverCard.Attach(TextButton, tooltipRows)
    u4:Add(function() -- Line: 85 -- upvalues: u60 (ref)
        u60()
    end)
    u4:Add(((a1:GetAttributeChangedSignal("CapacityCategory")):Connect(function() -- Line: 86
        -- upvalues: u60 (ref), u47 (ref), u46 (ref), TextButton (val), u17 (val), u45 (ref), refresh (val)
        -- upvalues: HoverCard (upval), tooltipRows (val)
        u60()
        u47 = u47 + 1
        if u46 then
            u46:Cancel()
            u46 = nil
        end
        TextButton.Position = u17
        u45 = 0
        refresh()
        HoverCard.Attach(TextButton, tooltipRows)
    end)))
    u4:Add((Save.Watch("Inventory"):Connect(refresh)))
    u4:Add((Save.Watch("EggInventory"):Connect(refresh)))
    u4:Add((Save.Loaded:Connect(refresh)))
    u4:Add((RunService.Heartbeat:Connect(function(a1_2) -- Line: 95
        -- upvalues: u44 (ref), TextButton (val), a1 (val), a2 (val), u51 (val), u45 (ref), u46 (ref), u47 (ref)
        -- upvalues: u17 (val), TweenService (upval)
        if u44 then
            local Visible = TextButton.Visible
            if Visible then
                Visible = a1.Visible
                if Visible then
                    Visible = a2.Visible
                    if Visible then
                        Visible = false
                        if u51 ~= nil then
                            Visible = u51.Enabled
                        end
                    end
                end
            end
            if Visible then
                u45 = u45 + a1_2
                if u45 < 8 then
                    return
                end
                u45 = 0
                u47 = u47 + 1
                local u21 = u47
                task.spawn(function() -- Line: 105
                    -- upvalues: u21 (val), u47 (upval), TextButton (upval), a1 (upval), a2 (upval), u51 (upval)
                    -- upvalues: TweenService (upval), u17 (upval), u46 (upval)
                    local Visible, v1
                    local v2 = {-2, 2, -1, 0}
                    local v3 = nil
                    local v4 = nil
                    for i, j in v2, v3, v4 do
                        if u21 == u47 and TextButton.Parent then
                            Visible = TextButton.Visible
                            if Visible then
                                Visible = a1.Visible
                                if Visible then
                                    Visible = a2.Visible
                                    if Visible then
                                        Visible = false
                                        if u51 ~= nil then
                                            Visible = u51.Enabled
                                        end
                                    end
                                end
                            end
                            if Visible then
                                v1 = TweenService:Create(TextButton, TweenInfo.new(0.09), {Position = u17 + UDim2.fromOffset(j, 0)})
                                u46 = v1
                                v1:Play()
                                v1.Completed:Wait()
                                continue
                            end
                        end
                        return
                    end
                    if u21 == u47 then
                        u46 = nil
                    end
                end)
                return
            end
        end
        if u45 > 0 or u46 then
            u47 = u47 + 1
            if u46 then
                u46:Cancel()
                u46 = nil
            end
            TextButton.Position = u17
            u45 = 0
        end
    end)))
    u4:Add(function() -- Line: 47 -- upvalues: u47 (ref), u46 (ref), TextButton (val), u17 (val), u45 (ref)
        u47 = u47 + 1
        if u46 then
            u46:Cancel()
            u46 = nil
        end
        TextButton.Position = u17
        u45 = 0
    end)
    a1.Destroying:Once(function() -- Line: 119 -- upvalues: u4 (val)
        u4:Destroy()
    end)
    refresh()
end