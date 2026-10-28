-- Script path: ReplicatedStorage.Controllers.Game.ShootingStarController.MountControls
-- Decompile time: 14.37 ms

local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Assets = require(ReplicatedStorage.Data.Assets)
local ConsoleSignals = require(ReplicatedStorage.Client.ConsoleSignals)
local GUI = require(ReplicatedStorage.Client.GUI)
local InputIconsConfig = require(ReplicatedStorage.Client.InputIconsConfig)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local LocalPlayer = Players.LocalPlayer
local ButtonB = Enum.KeyCode.ButtonB
local u70 = {}
local u71 = nil
local u72 = nil
local u73 = nil
local u74 = nil
local u75 = nil
local u76 = nil
local u77 = nil
local u78 = nil
local u79 = nil
local u80 = false
local u81 = false
local u82 = nil
local u83 = nil
local u84 = nil

local function session() -- Line: 40 -- upvalues: LocalPlayer (val)
    local Character = LocalPlayer.Character
    local PetMountSession = Character and Character:FindFirstChild("PetMountSession")
    if PetMountSession and PetMountSession:IsA("Model") then
        return PetMountSession
    end
    return nil
end

local function available() -- Line: 46 -- upvalues: Tabs (val), GuiService (val), UserInputService (val)
    local v1 = false
    if Tabs.Active() == nil then
        v1 = not GuiService.MenuIsOpen and UserInputService:GetFocusedTextBox() == nil
    end
    return v1
end

local function petName(a1) -- Line: 50 -- upvalues: Save (val), Assets (val) -- types: a1: string?
    local v1 = Save.Peek()
    local v2 = v1 and a1 and v1.Inventory[a1]
    v1 = v2 and Assets.Directory[v2.Category]
    local DisplayName = if not v1 then "Your mount" else v1.DisplayName or v2.Category
    if v2 and DisplayName == v2.Category then
        DisplayName = ((DisplayName:gsub("(%l)(%u)", "%1 %2")):gsub("(%u)(%u%l)", "%1 %2")):gsub("_", " ")
    end
    return DisplayName
end

local function nearest() -- Line: 62
    -- upvalues: u82 (ref), u83 (ref), Tabs (val), GuiService (val), UserInputService (val), LocalPlayer (val)
    if u82 and u83() == "Ride" then
        local v1 = false
        if Tabs.Active() == nil then
            v1 = not GuiService.MenuIsOpen and UserInputService:GetFocusedTextBox() == nil
        end
        if v1 then
            local Character = LocalPlayer.Character
            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
                local Magnitude, Parent, Prompt
                local v2 = nil
                local v3 = (1 / 0)
                for i, j in u82() do
                    Prompt = j.Prompt
                    Parent = Prompt.Parent
                    if j.Mode == "Ride" and Prompt.Enabled and Parent and Parent:IsA("BasePart") then
                        Magnitude = (HumanoidRootPart.Position - Parent.Position).Magnitude
                        if Magnitude <= Prompt.MaxActivationDistance then
                            if Magnitude < v3 then
                                v2 = i
                            elseif Magnitude == v3 then
                                if v2 == nil or i < v2 then
                                    v2 = i
                                end
                            end
                        end
                    end
                end
                return v2
            end
            return nil
        end
    end
    return nil
end

local function dismount() -- Line: 81
    -- upvalues: u81 (ref), LocalPlayer (val), Tabs (val), GuiService (val), UserInputService (val), Remotes (val)
    if not u81 then
        local Character = LocalPlayer.Character
        local PetMountSession = Character and Character:FindFirstChild("PetMountSession")
        local v1 = if not PetMountSession then nil else if not PetMountSession:IsA("Model") then nil else PetMountSession
        if v1 then
            v1 = false
            if Tabs.Active() == nil then
                v1 = not GuiService.MenuIsOpen and UserInputService:GetFocusedTextBox() == nil
            end
            if v1 then
                u81 = true
                task.spawn(function() -- Line: 84 -- upvalues: Remotes (upval), u81 (upval)
                    pcall(function() -- Line: 85 -- upvalues: Remotes (upval)
                        Remotes.PetMount.Request:InvokeServer("dismount")
                    end)
                    u81 = false
                end)
                return
            end
        end
    end
end

local function setText(a1, a2) -- Line: 90 -- types: a1: userdata?, a2: string
    if a1 and a1.Text ~= a2 then
        a1.Text = a2
    end
end

local function dismountCaption() -- Line: 96
    -- upvalues: PlatformController (val), InputIconsConfig (val), ButtonB (val)
    if PlatformController.IsConsole() then
        if InputIconsConfig.Image(ButtonB) then
            return "Dismount"
        end
        return (if InputIconsConfig.Vendor() ~= "sony" then "[B]" else "[O]") .. " Dismount"
    end
    if PlatformController.IsMobile() then
        return "Dismount"
    end
    return "[F] Dismount"
end

function u70.Refresh() -- Line: 104
    -- upvalues: u71 (ref), u72 (ref), u73 (ref), u74 (ref), u75 (ref), LocalPlayer (val), u80 (ref)
    -- upvalues: ContextActionService (val), Tabs (val), GuiService (val), UserInputService (val), u81 (ref)
    -- upvalues: Remotes (val), ButtonB (val), u79 (ref), nearest (val), PlatformController (val), petName (val)
    -- upvalues: u76 (ref), u77 (ref), InputIconsConfig (val), u78 (ref)
    if u71 and u72 and u73 and u74 and u75 then
        local v1
        local Character = LocalPlayer.Character
        local PetMountSession = Character and Character:FindFirstChild("PetMountSession")
        local v2 = (if not PetMountSession then nil else if not PetMountSession:IsA("Model") then nil else PetMountSession) ~= nil
        if v2 ~= u80 then
            u80 = v1 ~= nil
            ContextActionService:UnbindAction("StarMountDismount")
            if u80 then
                v2 = ContextActionService
                local F = Enum.KeyCode.F
                v2:BindAction("StarMountDismount", function(a1, a2) -- Line: 111
                    -- upvalues: Tabs (upval), GuiService (upval), UserInputService (upval), u81 (upval)
                    -- upvalues: LocalPlayer (upval), Remotes (upval)
                    if a2 == Enum.UserInputState.Begin then
                        local v1 = false
                        if Tabs.Active() == nil then
                            v1 = not GuiService.MenuIsOpen and UserInputService:GetFocusedTextBox() == nil
                        end
                        if v1 then
                            if not u81 then
                                local Character = LocalPlayer.Character
                                local PetMountSession = Character and Character:FindFirstChild("PetMountSession")
                                v1 = if not PetMountSession then nil else if not PetMountSession:IsA("Model") then nil else PetMountSession
                                if v1 then
                                    v1 = false
                                    if Tabs.Active() == nil then
                                        v1 = not GuiService.MenuIsOpen and UserInputService:GetFocusedTextBox() == nil
                                    end
                                    if v1 then
                                        u81 = true
                                        task.spawn(function() -- Line: 84 -- upvalues: Remotes (upval), u81 (upval)
                                            pcall(function() -- Line: 85 -- upvalues: Remotes (upval)
                                                Remotes.PetMount.Request:InvokeServer("dismount")
                                            end)
                                            u81 = false
                                        end)
                                    end
                                end
                            end
                            return Enum.ContextActionResult.Sink
                        end
                    end
                    return Enum.ContextActionResult.Pass
                end, false, F, ButtonB)
            end
        end
        u79 = nearest()
        v2 = false
        if Tabs.Active() == nil then
            v2 = not GuiService.MenuIsOpen and UserInputService:GetFocusedTextBox() == nil
        end
        if v2 then
            v2 = true
            if v1 == nil then
                v2 = PlatformController.IsMobile() and u79 ~= nil
            end
        end
        u73.Visible = v2
        u71.Visible = v2 and v1 == nil
        local v3 = u72
        local v4 = v2 and v1 ~= nil
        v3.Visible = v4
        u74.Visible = v2
        if v2 then
            v3 = u75
            v4 = petName(if not v1 then u79 else v1:GetAttribute("UID"))
            if v3 and v3.Text ~= v4 then
                v3.Text = v4
            end
        end
        v3 = u76
        if v3 and v3.Text ~= "Mount" then
            v3.Text = "Mount"
        end
        v3 = u77
        v4 = if not PlatformController.IsConsole() then if not PlatformController.IsMobile() then "[F] Dismount" else "Dismount" else if not InputIconsConfig.Image(ButtonB) then (if InputIconsConfig.Vendor() ~= "sony" then "[B]" else "[O]") .. " Dismount" else "Dismount"
        if v3 and v3.Text ~= v4 then
            v3.Text = v4
        end
        if u78 then
            u78.Scale = if not PlatformController.IsConsole() then 1 else 0.8
        end
        return
    end
end

function u70.Bind(a1, a2, a3) -- Line: 136
    -- upvalues: u71 (ref), u82 (ref), u83 (ref), u84 (ref), GUI (val), u73 (ref), u72 (ref), u74 (ref), u75 (ref)
    -- upvalues: u76 (ref), u77 (ref), u78 (ref), ButtonFX (val), dismount (val), ConsoleSignals (val), u81 (ref)
    -- upvalues: LocalPlayer (val), Tabs (val), GuiService (val), UserInputService (val), Remotes (val), nearest (val)
    -- upvalues: u79 (ref), u70 (val), RunService (val), PlatformController (val), InputIconsConfig (val)
    if u71 then
        return
    end
    u82 = a1
    u83 = a2
    u84 = a3
    local HUD = GUI.Get("HUD")
    local GameHUD = HUD and HUD:FindFirstChild("GameHUD")
    local v1 = GameHUD and GameHUD:FindFirstChild("DismountHUD")
    local Mount = v1 and v1:FindFirstChild("Mount")
    local Dismount = v1
    if Dismount then
        Dismount = v1:FindFirstChild("Dismount")
    end
    local AnimalNameHolder = v1 and v1:FindFirstChild("AnimalNameHolder")
    local NameLabel = AnimalNameHolder and AnimalNameHolder:FindFirstChild("NameLabel")
    if v1
        and v1:IsA("Frame")
        and Mount
        and Mount:IsA("ImageButton")
        and Dismount
        and Dismount:IsA("ImageButton")
        and AnimalNameHolder
        and AnimalNameHolder:IsA("GuiObject")
        and NameLabel
        and NameLabel:IsA("TextLabel") then
        u73 = v1
        u71 = Mount
        u72 = Dismount
        u74 = AnimalNameHolder
        u75 = NameLabel
        local txt = Mount:FindFirstChild("txt")
        u76 = if not txt then nil else if not txt:IsA("TextLabel") then nil else txt
        local txt_2 = Dismount:FindFirstChild("txt")
        u77 = if not txt_2 then nil else if not txt_2:IsA("TextLabel") then nil else txt_2
        local UIScale = Instance.new("UIScale")
        UIScale.Parent = v1
        u78 = UIScale
        ButtonFX(Dismount, nil, dismount)
        ConsoleSignals.ButtonUp:Connect(function(a1) -- Line: 167
            -- upvalues: Dismount (val), u81 (upval), LocalPlayer (upval), Tabs (upval), GuiService (upval)
            -- upvalues: UserInputService (upval), Remotes (upval)
            if a1 == Dismount and not u81 then
                local Character = LocalPlayer.Character
                local PetMountSession = Character and Character:FindFirstChild("PetMountSession")
                local v1 = if not PetMountSession then nil else if not PetMountSession:IsA("Model") then nil else PetMountSession
                if v1 then
                    v1 = false
                    if Tabs.Active() == nil then
                        v1 = not GuiService.MenuIsOpen and UserInputService:GetFocusedTextBox() == nil
                    end
                    if not v1 then
                        return
                    end
                    u81 = true
                    task.spawn(function() -- Line: 84 -- upvalues: Remotes (upval), u81 (upval)
                        pcall(function() -- Line: 85 -- upvalues: Remotes (upval)
                            Remotes.PetMount.Request:InvokeServer("dismount")
                        end)
                        u81 = false
                    end)
                end
            end
        end)
        ButtonFX(Mount, nil, function() -- Line: 170
            -- upvalues: u81 (upval), Tabs (upval), GuiService (upval), UserInputService (upval), LocalPlayer (upval)
            -- upvalues: Remotes (upval), nearest (upval), u79 (upval), u70 (upval), u84 (upval)
            if not u81 then
                local v1 = false
                if Tabs.Active() == nil then
                    v1 = not GuiService.MenuIsOpen and UserInputService:GetFocusedTextBox() == nil
                end
                if v1 then
                    local Character = LocalPlayer.Character
                    local PetMountSession = Character and Character:FindFirstChild("PetMountSession")
                    v1 = if not PetMountSession then nil else if not PetMountSession:IsA("Model") then nil else PetMountSession
                    if not v1 then
                        v1 = nearest()
                        if v1 ~= nil and v1 == u79 then
                            u81 = true
                            local success, err = pcall(u84, v1)
                            u81 = false
                            if not success then
                                warn("Mount request failed: " .. tostring(err))
                            end
                            return
                        end
                        u70.Refresh()
                        return
                    end
                    if not u81 then
                        local Character_2 = LocalPlayer.Character
                        local PetMountSession_2 = Character_2 and Character_2:FindFirstChild("PetMountSession")
                        v1 = if not PetMountSession_2 then nil else if not PetMountSession_2:IsA("Model") then nil else PetMountSession_2
                        if v1 then
                            v1 = false
                            if Tabs.Active() == nil then
                                v1 = not GuiService.MenuIsOpen and UserInputService:GetFocusedTextBox() == nil
                            end
                            if not v1 then
                                return
                            end
                            u81 = true
                            task.spawn(function() -- Line: 84 -- upvalues: Remotes (upval), u81 (upval)
                                pcall(function() -- Line: 85 -- upvalues: Remotes (upval)
                                    Remotes.PetMount.Request:InvokeServer("dismount")
                                end)
                                u81 = false
                            end)
                        end
                    end
                    return
                end
            end
        end)
        local u128 = 0
        RunService.Heartbeat:Connect(function(a1) -- Line: 181 -- upvalues: u128 (ref), u70 (upval)
            u128 = u128 + a1
            if u128 < 0.1 then
                return
            end
            u128 = 0
            u70.Refresh()
        end)
        PlatformController.Changed:Connect(u70.Refresh)
        InputIconsConfig.Changed:Connect(u70.Refresh)
        u70.Refresh()
        return
    end
    warn("Mount controls require HUD.GameHUD.DismountHUD")
end

return u70