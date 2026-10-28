-- Script path: ReplicatedStorage.Controllers.Game.HalloweenDimensionController.Tutorial
-- Decompile time: 9.90 ms

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GUI = require(ReplicatedStorage.Client.GUI)
local HalloweenDimension = require(ReplicatedStorage.Shared.Util.HalloweenDimension)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local MenuNavigation = require(ReplicatedStorage.Client.MenuNavigation)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local Transition = require(script.Parent.Transition)
require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local Inside = HalloweenDimension.PlayerAttributes.Inside
local v1 = {}

local function isInside() -- Line: 36 -- upvalues: LocalPlayer (val), Inside (val)
    return LocalPlayer:GetAttribute(Inside) == true
end

local function hasSeen() -- Line: 40 -- upvalues: Save (val)
    local v1 = Save.Await()
    local v2 = true
    if v1 ~= nil then
        v2 = v1.HalloweenDimension.TutorialSeen == true
    end
    return v2
end

local function peekSeen() -- Line: 45 -- upvalues: Save (val)
    local v1 = Save.Peek()
    local v2 = false
    if v1 ~= nil then
        v2 = v1.HalloweenDimension.TutorialSeen == true
    end
    return v2
end

function v1.Start(a1) -- Line: 54
    -- upvalues: Save (val), MenuNavigation (val), GuiService (val), Remotes (val), GUI (val), ButtonFX (val)
    -- upvalues: Tabs (val), HiddenUIHandler (val), Transition (val), LocalPlayer (val), Inside (val)
    local u1 = nil
    local u2 = nil
    local u3 = nil
    local u4 = nil
    local u5 = false
    local u6 = 0
    local v1 = Save.Peek()
    local u14 = false
    if v1 ~= nil then
        u14 = v1.HalloweenDimension.TutorialSeen == true
    end

    local function hide() -- Line: 63 -- upvalues: u1 (ref), MenuNavigation (upval), GuiService (upval), u4 (ref)
        local v1 = u1
        if v1 ~= nil and v1.Enabled then
            v1.Enabled = false
            MenuNavigation.SetOverride("HalloweenTutorial", nil)
            local SelectedObject = GuiService.SelectedObject
            if SelectedObject ~= nil and SelectedObject:IsDescendantOf(v1) then
                GuiService.SelectedObject = nil
            end
            local v2 = u4
            u4 = nil
            if v2 ~= nil then
                v2()
            end
            return
        end
    end

    local function acknowledge() -- Line: 81 -- upvalues: u1 (ref), u5 (ref), hide (val), Remotes (upval)
        local v1 = u1
        if v1 ~= nil and v1.Enabled then
            u5 = true
            hide()
            task.spawn(function() -- Line: 88 -- upvalues: Remotes (upval)
                pcall(function() -- Line: 89 -- upvalues: Remotes (upval)
                    Remotes.HalloweenDimension.AskTutorialSeen:InvokeServer()
                end)
            end)
            return
        end
    end

    local function bind() -- Line: 95
        -- upvalues: u1 (ref), GUI (upval), a1 (val), acknowledge (val), ButtonFX (upval), u2 (ref), u3 (ref)
        local v1 = u1
        if v1 ~= nil then
            return v1
        end
        v1 = GUI.HalloweenEventTutorialFrame()
        assert(v1:IsA("ScreenGui"), "HalloweenEventTutorialFrame must be a ScreenGui")
        local HalloweenEventTutorialFrame = v1:FindFirstChild("HalloweenEventTutorialFrame")
        local v2 = false
        if HalloweenEventTutorialFrame ~= nil then
            v2 = HalloweenEventTutorialFrame:IsA("Frame")
        end
        assert(v2, "HalloweenEventTutorialFrame.HalloweenEventTutorialFrame must be a Frame")
        local Ok = HalloweenEventTutorialFrame:FindFirstChild("Ok")
        local v3 = false
        if Ok ~= nil then
            v3 = Ok:IsA("ImageButton")
        end
        assert(v3, "HalloweenEventTutorialFrame.Ok must be an ImageButton")
        a1:Add(GUI.OnActivated(Ok, acknowledge), "Disconnect")
        a1:Add((ButtonFX(Ok)))
        u2 = HalloweenEventTutorialFrame
        u3 = Ok
        u1 = v1
        return v1
    end

    local function show() -- Line: 114
        -- upvalues: bind (val), Tabs (upval), u4 (ref), HiddenUIHandler (upval), MenuNavigation (upval), u2 (ref)
        -- upvalues: u3 (ref), acknowledge (val)
        local v1 = bind()
        if v1.Enabled then
            return
        end
        Tabs.Deactivate({instant = true})
        HiddenUIHandler.Acquire()
        v1.Enabled = true
        MenuNavigation.SetOverride("HalloweenTutorial", u2, u3, acknowledge, 1000, true, true)
    end

    local function arrive() -- Line: 133
        -- upvalues: u6 (ref), u5 (ref), Save (upval), Transition (upval), LocalPlayer (upval), Inside (upval)
        -- upvalues: show (val)
        u6 = u6 + 1
        local u2 = u6
        task.spawn(function() -- Line: 136
            -- upvalues: u5 (upval), Save (upval), Transition (upval), u2 (val), u6 (upval), LocalPlayer (upval)
            -- upvalues: Inside (upval), show (upval)
            if not u5 then
                local v1 = Save.Await()
                local v2 = true
                if v1 ~= nil then
                    v2 = v1.HalloweenDimension.TutorialSeen == true
                end
                if not v2 then
                    v2 = os.clock()
                    while Transition.IsCovering() do
                        if not (os.clock() - v2 < 30) then
                            break
                        end
                        task.wait()
                    end
                    task.wait(0.9)
                    if u2 == u6 and not u5 then
                        v1 = LocalPlayer:GetAttribute(Inside) == true
                        if v1 then
                            v2 = Save.Await()
                            v1 = true
                            if v2 ~= nil then
                                v1 = v2.HalloweenDimension.TutorialSeen == true
                            end
                            if not v1 then
                                show()
                                return
                            end
                        end
                    end
                    return
                end
            end
        end)
    end

    local function depart() -- Line: 152 -- upvalues: u6 (ref), hide (val)
        u6 = u6 + 1
        hide()
    end

    a1:Connect(LocalPlayer:GetAttributeChangedSignal(Inside), function() -- Line: 157
        -- upvalues: LocalPlayer (upval), Inside (upval), u6 (ref), u5 (ref), Save (upval), Transition (upval)
        -- upvalues: show (val), hide (val)
        if not (LocalPlayer:GetAttribute(Inside) == true) then
            u6 = u6 + 1
            hide()
            return
        end
        u6 = u6 + 1
        local u10 = u6
        task.spawn(function() -- Line: 136
            -- upvalues: u5 (upval), Save (upval), Transition (upval), u10 (val), u6 (upval), LocalPlayer (upval)
            -- upvalues: Inside (upval), show (upval)
            if not u5 then
                local v1 = Save.Await()
                local v2 = true
                if v1 ~= nil then
                    v2 = v1.HalloweenDimension.TutorialSeen == true
                end
                if not v2 then
                    v2 = os.clock()
                    while Transition.IsCovering() do
                        if not (os.clock() - v2 < 30) then
                            break
                        end
                        task.wait()
                    end
                    task.wait(0.9)
                    if u10 == u6 and not u5 then
                        v1 = LocalPlayer:GetAttribute(Inside) == true
                        if v1 then
                            v2 = Save.Await()
                            v1 = true
                            if v2 ~= nil then
                                v1 = v2.HalloweenDimension.TutorialSeen == true
                            end
                            if not v1 then
                                show()
                                return
                            end
                        end
                    end
                    return
                end
            end
        end)
    end)
    a1:Connect(LocalPlayer.CharacterAdded, depart)
    a1:Add((Save.WatchFields("HalloweenDimension", function() -- Line: 167 -- upvalues: Save (upval), u14 (ref), u5 (ref)
        local v1 = Save.Peek()
        local v2 = false
        if v1 ~= nil then
            v2 = v1.HalloweenDimension.TutorialSeen == true
        end
        if u14 and not v2 then
            u5 = false
        end
        u14 = v2
    end)))
    a1:Add(depart)
    if LocalPlayer:GetAttribute(Inside) == true then
        u6 = u6 + 1
        local u67 = u6
        task.spawn(function() -- Line: 136
            -- upvalues: u5 (ref), Save (upval), Transition (upval), u67 (val), u6 (ref), LocalPlayer (upval)
            -- upvalues: Inside (upval), show (val)
            if not u5 then
                local v1 = Save.Await()
                local v2 = true
                if v1 ~= nil then
                    v2 = v1.HalloweenDimension.TutorialSeen == true
                end
                if not v2 then
                    v2 = os.clock()
                    while Transition.IsCovering() do
                        if not (os.clock() - v2 < 30) then
                            break
                        end
                        task.wait()
                    end
                    task.wait(0.9)
                    if u67 == u6 and not u5 then
                        v1 = LocalPlayer:GetAttribute(Inside) == true
                        if v1 then
                            v2 = Save.Await()
                            v1 = true
                            if v2 ~= nil then
                                v1 = v2.HalloweenDimension.TutorialSeen == true
                            end
                            if not v1 then
                                show()
                                return
                            end
                        end
                    end
                    return
                end
            end
        end)
    end
end

return table.freeze(v1)