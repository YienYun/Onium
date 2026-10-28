-- Script path: ReplicatedStorage.Controllers.GUI.LimitedTimePopupsController
-- Decompile time: 5.61 ms

local FindRootFrame
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local ShopNavigation = require(ReplicatedStorage.Client.ShopNavigation)
local LimitedTimePopups = require(ReplicatedStorage.Data.LimitedTimePopups)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GamepadBindings = require(ReplicatedStorage.Client.GamepadBindings)
local u38 = Players.LocalPlayer.PlayerGui:WaitForChild("LimitedTimePopupsUI")

function FindRootFrame(a1) -- Line: 23 -- upvalues: u38 (val), FindRootFrame (val) -- types: a1: userdata
    if a1.Parent ~= u38 and a1.Parent then
        return FindRootFrame(a1.Parent)
    end
    return a1
end

local function toDHMS(a1) -- Line: 31 -- types: a1: number
    if a1 > 86400 then
        return string.format("%id %ih %02im %02is", a1 / 86400, a1 / 3600 % 24, a1 / 60 % 60, a1 % 60)
    end
    if a1 > 3600 then
        return string.format("%ih %02im %02is", a1 / 3600 % 24, a1 / 60 % 60, a1 % 60)
    end
    return string.format("%02im %02is", a1 / 60 % 60, a1 % 60)
end

return {
    Start = function() -- Line: 61
        -- upvalues: Remotes (val), u38 (val), ButtonFX (val), FindRootFrame (val), GamepadBindings (val)
        -- upvalues: ShopNavigation (val), LimitedTimePopups (val), toDHMS (val)
        local v1
        Remotes.LimitedTimePopups.ShowLimitedTimePopup.OnClientEvent:Connect(function(a1) -- Line: 62 -- upvalues: u38 (upval) -- types: a1: string
            local v1 = u38:FindFirstChild(a1)
            if not v1 then
                return
            end
            if v1:FindFirstChild("Animation") then
                v1:SetAttribute("Open", true)
                return
            end
            v1.Visible = true
        end)
        for i, j in u38:GetDescendants() do
            if not j:IsA("GuiButton") then
                if not j:IsA("GuiButton") then
                    if j:IsA("TextLabel") and j.Name == "Timer" then
                        v1 = if j.Parent == u38 then j else if j.Parent then FindRootFrame(j.Parent) else j
                        local u70 = LimitedTimePopups[v1.Name]
                        if u70 then
                            if not (u70.EndTime < (os.time())) then
                                task.spawn(function() -- Line: 103 -- upvalues: u70 (val), j (val), toDHMS (upval)
                                    local v1, v2, v3
                                    while true do
                                        task.wait(1)
                                        v1 = u70.EndTime - os.time()
                                        v2 = j
                                        if not (v1 > 0) then
                                            v2.Text = "LAST CHANCE!"
                                        else
                                            v3 = toDHMS(v1) or "LAST CHANCE!"
                                            v2.Text = v3
                                        end
                                    end
                                end)
                            else
                                j.Text = "LAST CHANCE!"
                            end
                        end
                    end
                elseif j:GetAttribute("Nav") == "Shop" then
                    ButtonFX(j, 1.08, function() -- Line: 86 -- upvalues: j (val), u38 (upval), FindRootFrame (upval), ShopNavigation (upval)
                        local v1 = j
                        local v2 = if v1.Parent == u38 then v1 else if v1.Parent then FindRootFrame(v1.Parent) else v1
                        v2.Visible = false
                        v2:SetAttribute("Open", nil)
                        ShopNavigation.Open("Featured")
                    end)
                    GamepadBindings.Inspect(j)
                elseif j:IsA("TextLabel") and j.Name == "Timer" then
                    v1 = if j.Parent == u38 then j else if j.Parent then FindRootFrame(j.Parent) else j
                    local u70 = LimitedTimePopups[v1.Name]
                    if u70 then
                        if not (u70.EndTime < (os.time())) then
                            task.spawn(function() -- Line: 103 -- upvalues: u70 (val), j (val), toDHMS (upval)
                                local v1, v2, v3
                                while true do
                                    task.wait(1)
                                    v1 = u70.EndTime - os.time()
                                    v2 = j
                                    if not (v1 > 0) then
                                        v2.Text = "LAST CHANCE!"
                                    else
                                        v3 = toDHMS(v1) or "LAST CHANCE!"
                                        v2.Text = v3
                                    end
                                end
                            end)
                        else
                            j.Text = "LAST CHANCE!"
                        end
                    end
                end
            elseif j.Name == "Close" then
                ButtonFX(j, 1.08, function() -- Line: 76 -- upvalues: j (val), u38 (upval), FindRootFrame (upval)
                    local v1 = j
                    local v2 = if v1.Parent == u38 then v1 else if v1.Parent then FindRootFrame(v1.Parent) else v1
                    if v2:FindFirstChild("Animation") then
                        v2:SetAttribute("Open", false)
                        return
                    end
                    v2.Visible = false
                end)
                GamepadBindings.Inspect(j)
            elseif not j:IsA("GuiButton") then
                if j:IsA("TextLabel") and j.Name == "Timer" then
                    v1 = if j.Parent == u38 then j else if j.Parent then FindRootFrame(j.Parent) else j
                    local u70 = LimitedTimePopups[v1.Name]
                    if u70 then
                        if not (u70.EndTime < (os.time())) then
                            task.spawn(function() -- Line: 103 -- upvalues: u70 (val), j (val), toDHMS (upval)
                                local v1, v2, v3
                                while true do
                                    task.wait(1)
                                    v1 = u70.EndTime - os.time()
                                    v2 = j
                                    if not (v1 > 0) then
                                        v2.Text = "LAST CHANCE!"
                                    else
                                        v3 = toDHMS(v1) or "LAST CHANCE!"
                                        v2.Text = v3
                                    end
                                end
                            end)
                        else
                            j.Text = "LAST CHANCE!"
                        end
                    end
                end
            elseif j:GetAttribute("Nav") == "Shop" then
                ButtonFX(j, 1.08, function() -- Line: 86 -- upvalues: j (val), u38 (upval), FindRootFrame (upval), ShopNavigation (upval)
                    local v1 = j
                    local v2 = if v1.Parent == u38 then v1 else if v1.Parent then FindRootFrame(v1.Parent) else v1
                    v2.Visible = false
                    v2:SetAttribute("Open", nil)
                    ShopNavigation.Open("Featured")
                end)
                GamepadBindings.Inspect(j)
            elseif j:IsA("TextLabel") and j.Name == "Timer" then
                v1 = if j.Parent == u38 then j else if j.Parent then FindRootFrame(j.Parent) else j
                local u70 = LimitedTimePopups[v1.Name]
                if u70 then
                    if not (u70.EndTime < (os.time())) then
                        task.spawn(function() -- Line: 103 -- upvalues: u70 (val), j (val), toDHMS (upval)
                            local v1, v2, v3
                            while true do
                                task.wait(1)
                                v1 = u70.EndTime - os.time()
                                v2 = j
                                if not (v1 > 0) then
                                    v2.Text = "LAST CHANCE!"
                                else
                                    v3 = toDHMS(v1) or "LAST CHANCE!"
                                    v2.Text = v3
                                end
                            end
                        end)
                    else
                        j.Text = "LAST CHANCE!"
                    end
                end
            end
        end
    end,
}