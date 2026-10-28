-- Script path: ReplicatedStorage.Controllers.Game.ScrambleClientController.Interface
-- Decompile time: 13.59 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local AssetViewport = require(ReplicatedStorage.Client.AssetViewport)
local Trove = require(ReplicatedStorage.Packages.Trove)
local ScrambleRules = require(ReplicatedStorage.Shared.Util.ScrambleRules)
local Parts = ReplicatedStorage.Assets.Models.Scramble.Parts
local v1 = {}
local u39 = Color3.new()
local u44 = Color3.new(1, 1, 1)

local function countdown(a1) -- Line: 16 -- types: a1: number
    local v1 = math.max(0, (math.ceil(a1)))
    local v2 = v1 // 86400
    local v3 = v1 % 86400 // 3600
    local v4 = v1 % 3600 // 60
    if v2 > 0 then
        return string.format("%dd %dhr %dm", v2, v3, v4)
    end
    if v3 > 0 then
        return string.format("%dhr %dm", v3, v4)
    end
    if v4 > 0 then
        return string.format("%dm %ds", v4, v1 % 60)
    end
    return (tostring(v1)) .. "s"
end

function v1.new(a1) -- Line: 31
    -- upvalues: Trove (val), GUI (val), ScrambleRules (val), AssetViewport (val), Parts (val), u39 (val), u44 (val)
    -- upvalues: ButtonFX (val), Tabs (val), countdown (val)
    local u1 = {}
    local u4 = Trove.new()
    local StolenVaultEvent = GUI.Get("StolenVaultEvent")
    local StolenVaultEventUIMain = StolenVaultEvent:WaitForChild("StolenVaultEventUIMain")
    local ContentFrame = StolenVaultEventUIMain.ContentFrame
    local RequirementsHolder = ContentFrame.RequirementsHolder
    local Template_Unlocked = RequirementsHolder.Template_Unlocked
    local Template_Locked = RequirementsHolder.Template_Locked
    local Claim = ContentFrame.Claim
    local VaultInComplete = ContentFrame.VaultInComplete
    local u19 = {}
    local u20 = nil
    local u21 = false
    local u22 = true
    local u23 = nil
    StolenVaultEvent:SetAttribute("ImmediateClose", true)
    StolenVaultEvent.Enabled = false
    for i, j in RequirementsHolder:GetChildren() do
        if j:IsA("GuiObject") then
            j.Visible = false
        end
    end
    local Position = Claim.Position
    local Size = Claim.Size
    VaultInComplete.Position = Position
    VaultInComplete.Size = Size
    VaultInComplete.Active = false
    VaultInComplete.Interactable = false
    VaultInComplete.Selectable = false

    local function buildCards() -- Line: 54
        -- upvalues: u19 (val), ScrambleRules (upval), Template_Unlocked (val), RequirementsHolder (val), u4 (val)
        -- upvalues: AssetViewport (upval), Parts (upval)
        local AnchorPoint, Icon, Position, Size, ZIndex, v1, v2, v3
        if #u19 > 0 then
            return
        end
        local v4 = nil
        local v5 = nil
        for i, j in ScrambleRules.PART_IDS, v4, v5 do
            v1 = Template_Unlocked:Clone()
            v1.Name = j
            v1.LayoutOrder = i
            v1.Visible = true
            v1.Parent = RequirementsHolder
            u4:Add(v1)
            Icon = v1.Icon
            v3 = AssetViewport.Mount(v1)
            ZIndex = Icon.ZIndex
            v3.Name = "PartViewport"
            v3.ZIndex = ZIndex
            Position = Icon.Position
            Size = Icon.Size
            AnchorPoint = Icon.AnchorPoint
            v3.Position = Position
            v3.Size = Size
            v3.AnchorPoint = AnchorPoint
            Icon:Destroy()
            v2 = Parts:FindFirstChild(j)
            if not v2 or not v2:IsA("Model") then
                warn("[Scramble UI] Missing part viewport model: " .. j)
            else
                u4:Add((AssetViewport.ShowModel(v2, v3)))
            end
            table.insert(u19, {
                Id = j,
                Index = i,
                Card = v1,
                View = v3,
                Ambient = v3.Ambient,
                LightColor = v3.LightColor,
            })
        end
    end

    local function paintCard(a1, a2) -- Line: 87
        -- upvalues: Template_Unlocked (val), Template_Locked (val), u39 (upval), u44 (upval)
        if a1.Owned == a2 then
            return
        end
        a1.Owned = a2
        local Card = a1.Card
        local View = a1.View
        local v1 = if not a2 then Template_Locked else Template_Unlocked
        View.Ambient = if not a2 then u39 else a1.Ambient
        View.LightColor = if not a2 then u39 else a1.LightColor
        View.ImageColor3 = if not a2 then u39 else u44
        Card.InnerUIStroke.Color = v1.InnerUIStroke.Color
        Card.UIShadow.Color = v1.UIShadow.Color
        local UIGradient = Card.InnerUIStroke:FindFirstChildOfClass("UIGradient")
        if UIGradient then
            UIGradient.Enabled = a2
        end
        Card.CompletedCheckmark.Visible = a2
        Card.ItemName.Text = if a2 then if not (a1.Index <= 2) then "Drone Part " .. a1.Index - 2 else "Lost Part " .. a1.Index else "???"
    end

    local function available(a1) -- Line: 111 -- upvalues: u20 (ref) -- types: a1: number
        local Ready = false
        if u20 ~= nil then
            Ready = u20.Ready
            if Ready then
                Ready = u20.Enabled
                if Ready then
                    Ready = false
                    if u20.WorldReady == true then
                        Ready = false
                        if type(u20.EventEndsAt) == "number" then
                            Ready = a1 < u20.EventEndsAt
                        end
                    end
                end
            end
        end
        return Ready
    end

    local function canClaim() -- Line: 120 -- upvalues: u20 (ref), u21 (ref)
        local ServerTimeNow = workspace:GetServerTimeNow()
        local Ready = false
        if u20 ~= nil then
            Ready = u20.Ready
            if Ready then
                Ready = u20.Enabled
                if Ready then
                    Ready = false
                    if u20.WorldReady == true then
                        Ready = false
                        if type(u20.EventEndsAt) == "number" then
                            Ready = ServerTimeNow < u20.EventEndsAt
                        end
                    end
                end
            end
        end
        if Ready then
            Ready = u20.State.Discovered
            if Ready then
                Ready = not u20.State.Completed
                if Ready then
                    Ready = false
                    if u20.State.TotalParts == 5 then
                        Ready = u20.VaultRewardReady and not u21
                    end
                end
            end
        end
        return Ready
    end

    local function send(a1_2, a2) -- Line: 128
        -- upvalues: u21 (ref), u23 (ref), a1 (val), u22 (ref)
        if u21 then
            return nil
        end
        u21 = true
        u23()
        local success, err = pcall(a1, a1_2, a2)
        u21 = false
        if u22 then
            u23()
        end
        if success then
            return err
        end
        warn("[Scramble UI] Request failed: " .. tostring(err))
        return nil
    end

    u4:Add((ButtonFX(Claim, nil, function() -- Line: 145 -- upvalues: u20 (ref), u21 (ref), u1 (val), u23 (ref), a1 (val), u22 (ref)
        local ServerTimeNow = workspace:GetServerTimeNow()
        local Ready = false
        if u20 ~= nil then
            Ready = u20.Ready
            if Ready then
                Ready = u20.Enabled
                if Ready then
                    Ready = false
                    if u20.WorldReady == true then
                        Ready = false
                        if type(u20.EventEndsAt) == "number" then
                            Ready = ServerTimeNow < u20.EventEndsAt
                        end
                    end
                end
            end
        end
        if Ready then
            Ready = u20.State.Discovered
            if Ready then
                Ready = not u20.State.Completed
                if Ready then
                    Ready = false
                    if u20.State.TotalParts == 5 then
                        Ready = u20.VaultRewardReady and not u21
                    end
                end
            end
        end
        if Ready then
            local v1
            u1.Close()
            if not u21 then
                u21 = true
                u23()
                local success, err = pcall(a1, "Vault", nil)
                u21 = false
                if u22 then
                    u23()
                end
                if success then
                    v1 = err
                else
                    warn("[Scramble UI] Request failed: " .. tostring(err))
                    v1 = nil
                end
            else
                v1 = nil
            end
            if u22 then
                if not v1 or not v1.Ok then
                    u1.ShowVault()
                end
            end
        end
    end)))
    u4:Add((Tabs.Activated:Connect(function(a1) -- Line: 155 -- upvalues: u23 (ref)
        if a1 == "StolenVaultEvent" then
            u23()
        end
    end)))

    local function u83() -- Line: 161 -- upvalues: StolenVaultEventUIMain (val)
        local CurrentCamera = workspace.CurrentCamera
        if not CurrentCamera then
            return
        end
        local ViewportSize = CurrentCamera.ViewportSize
        local AspectRatio = StolenVaultEventUIMain.UIAspectRatioConstraint.AspectRatio
        local v1 = math.max(1, (math.min(
            math.max(477, (math.min(ViewportSize.X * 0.62, ViewportSize.Y * 0.75 * AspectRatio))),
            ViewportSize.X - 32,
            ViewportSize.Y * 0.78 * AspectRatio
        )))
        StolenVaultEventUIMain.UISizeConstraint.MinSize = Vector2.zero
        StolenVaultEventUIMain.Size = UDim2.fromOffset(v1, v1 / AspectRatio)
    end

    function u23() -- Line: 173
        -- upvalues: u22 (ref), u83 (ref), u20 (ref), ContentFrame (val), StolenVaultEventUIMain (val), Claim (val)
        -- upvalues: VaultInComplete (val), u21 (ref), StolenVaultEvent (val), buildCards (val), u19 (val)
        -- upvalues: paintCard (val), u1 (val)
        if not u22 then
            return
        end
        u83()
        if u20 and u20.Ready and u20.State then
            local State = u20.State
            ContentFrame.LostParts.ProgressLabel.Text = (tostring((if not State.LostParts.LostPart1 then 0 else 1) + (if not State.LostParts.LostPart2 then 0 else 1))) .. " / 2"
            ContentFrame.DroneParts.ProgressLabel.Text = (tostring(State.DroneParts)) .. " / 3"
            local v1 = math.max(0, 5 - State.TotalParts)
            StolenVaultEventUIMain.SubTitle.Text = if State.Completed then "The vault is repaired. Your reward has been claimed!" else if v1 ~= 0 then "The vault is damaged and missing <font color=\"#FFD83D\">" .. v1 .. (if v1 ~= 1 then " parts" else " part") .. "</font>" else "All <font color=\"#FFD83D\">5 parts</font> found! Repair the vault and claim your reward."
            local ServerTimeNow = workspace:GetServerTimeNow()
            local Ready = false
            if u20 ~= nil then
                Ready = u20.Ready
                if Ready then
                    Ready = u20.Enabled
                    if Ready then
                        Ready = false
                        if u20.WorldReady == true then
                            Ready = false
                            if type(u20.EventEndsAt) == "number" then
                                Ready = ServerTimeNow < u20.EventEndsAt
                            end
                        end
                    end
                end
            end
            if Ready then
                Ready = State.Discovered
                if Ready then
                    Ready = not State.Completed
                    if Ready then
                        Ready = false
                        if v1 == 0 then
                            Ready = u20.VaultRewardReady
                        end
                    end
                end
            end
            local v2 = VaultInComplete
            Claim.Visible = Ready
            v2.Visible = not Ready
            Claim.Active = Ready and not u21
            Claim.Interactable = Ready and not u21
            Claim.Selectable = Ready and not u21
            v2 = if not u21 then "Claim" else "Claiming..."
            Claim.txt.Text = v2
            local txt_2 = VaultInComplete.txt
            if not State.Completed then
                local ServerTimeNow_2 = workspace:GetServerTimeNow()
                local Ready_2 = false
                if u20 ~= nil then
                    Ready_2 = u20.Ready
                    if Ready_2 then
                        Ready_2 = u20.Enabled
                        if Ready_2 then
                            Ready_2 = false
                            if u20.WorldReady == true then
                                Ready_2 = false
                                if type(u20.EventEndsAt) == "number" then
                                    Ready_2 = ServerTimeNow_2 < u20.EventEndsAt
                                end
                            end
                        end
                    end
                end
                v2 = if Ready_2 then if u20.VaultRewardReady then "Vault incomplete" else "Reward unavailable" else "Event ended"
            else
                v2 = "Claimed"
            end
            txt_2.Text = v2
            if StolenVaultEvent.Enabled then
                local DroneParts_3, v3
                buildCards()
                v2 = nil
                local v4 = nil
                for i, j in u19, v2, v4 do
                    if not (j.Index <= 2) then
                        DroneParts_3 = State.DroneParts
                        v3 = j.Index - 2 <= DroneParts_3
                    else
                        v3 = State.LostParts[j.Id] == true
                    end
                    paintCard(j, v3)
                end
            end
            u1.Tick(workspace:GetServerTimeNow())
            return
        end
    end

    function u1.Update(a1) -- Line: 220 -- upvalues: u20 (ref), u1 (val), u23 (ref)
        u20 = a1
        local ServerTimeNow = workspace:GetServerTimeNow()
        local Ready = false
        if u20 ~= nil then
            Ready = u20.Ready
            if Ready then
                Ready = u20.Enabled
                if Ready then
                    Ready = false
                    if u20.WorldReady == true then
                        Ready = false
                        if type(u20.EventEndsAt) == "number" then
                            Ready = ServerTimeNow < u20.EventEndsAt
                        end
                    end
                end
            end
        end
        if not Ready then
            u1.Close()
        end
        u23()
    end

    function u1.ShowVault() -- Line: 227 -- upvalues: u20 (ref), Tabs (upval), u23 (ref)
        local ServerTimeNow = workspace:GetServerTimeNow()
        local Ready = false
        if u20 ~= nil then
            Ready = u20.Ready
            if Ready then
                Ready = u20.Enabled
                if Ready then
                    Ready = false
                    if u20.WorldReady == true then
                        Ready = false
                        if type(u20.EventEndsAt) == "number" then
                            Ready = ServerTimeNow < u20.EventEndsAt
                        end
                    end
                end
            end
        end
        if Ready and u20.State.Discovered then
            Tabs.Activate("StolenVaultEvent")
            u23()
            return
        end
    end

    function u1.Close() -- Line: 234 -- upvalues: Tabs (upval)
        if Tabs.IsActive("StolenVaultEvent") then
            Tabs.Deactivate()
        end
    end

    function u1.Tick(a1) -- Line: 239
        -- upvalues: u20 (ref), StolenVaultEvent (val), countdown (upval), ContentFrame (val), u1 (val)
        if u20 and StolenVaultEvent.Enabled then
            local v1 = math.max(0, (u20.EventEndsAt or 0) - a1)
            local v2 = if not (v1 > 0) then "Event ended" else countdown(v1)
            if ContentFrame.Timer.Text ~= v2 then
                ContentFrame.Timer.Text = v2
            end
            if v1 <= 0 then
                u1.Close()
            end
            return
        end
    end

    if workspace.CurrentCamera then
        local v1 = u83
        u4:Add(((workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(v1)))
    end
    u83()

    function u1.Destroy() -- Line: 256 -- upvalues: u22 (ref), u4 (val)
        u22 = false
        u4:Destroy()
    end

    return u1
end

return v1