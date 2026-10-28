-- Script path: ReplicatedStorage.Controllers.Game.Plots.PlotSignManagerController
-- Decompile time: 7.45 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Player = require(ReplicatedStorage.Shared.Player)
local PlotState = require(ReplicatedStorage.Client.PlotState)
require(ReplicatedStorage.Shared.Types.Plots)
local Streamable = require(ReplicatedStorage.Packages.Streamable).Streamable
local PlotSignHomeButtonFade = require(script.Parent.Parent.Parent.GUI.PlotSignHomeButtonFade)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u47 = Trove.new()
local u48 = {}
local u49 = {}
return {
    Start = function() -- Line: 34
        -- upvalues: u49 (val), LocalPlayer (val), Players (val), PlotState (val), Trove (val), Streamable (val)
        -- upvalues: u48 (val), Player (val), u47 (val), PlotSignHomeButtonFade (val), RunService (val)
        local function clearRemotePlotSignBinding(a1) -- Line: 39 -- upvalues: u49 (upval) -- types: a1: number
            local v1 = u49[a1]
            if v1 == nil then
                return
            end
            v1:Destroy()
        end

        local function bindRemotePlotSign(a1, a2) -- Line: 48
            -- upvalues: u49 (upval), LocalPlayer (upval), Players (upval), PlotState (upval), Trove (upval)
            -- upvalues: Streamable (upval), u48 (upval)
            local v1 = u49[a1]
            if v1 ~= nil then
                v1:Destroy()
            end
            if a2 ~= nil and a2 ~= LocalPlayer.UserId then
                local PlayerByUserId = Players:GetPlayerByUserId(a2)
                if PlayerByUserId == nil then
                    return
                end
                local u18 = PlotState.ResolvePlot(PlayerByUserId)
                if u18 == nil then
                    return
                end
                local u22 = Trove.new()
                u49[a1] = u22
                u22:Add(function() -- Line: 67 -- upvalues: u49 (upval), a1 (val), u22 (val)
                    if u49[a1] == u22 then
                        u49[a1] = nil
                    end
                end)
                local u33 = Streamable.new(u18.PlotFolder, "PlotSign")
                u22:Add(function() -- Line: 74 -- upvalues: u33 (val)
                    u33:Destroy()
                end)
                u22:Add((u33:Observe(function(a1_2, a2) -- Line: 75 -- upvalues: Streamable (upval), u18 (val), u48 (upval), a1 (val)
                    local u6 = Streamable.new(a1_2, "PlayerPlotSign")
                    a2:Add(function() -- Line: 77 -- upvalues: u6 (val)
                        u6:Destroy()
                    end)
                    a2:Add((u6:Observe(function(a1_2) -- Line: 78 -- upvalues: u18 (upval), u48 (upval), a1 (upval)
                        assert(a1_2:IsA("BillboardGui"), "PlayerPlotSign must be a BillboardGui")
                        local u8 = {}
                        u8.PetArea = u18.PetArea
                        u8.PlayerPlotSign = a1_2
                        u48[a1] = u8
                        return function() -- Line: 87 -- upvalues: u48 (upval), a1 (upval), u8 (val), a1_2 (val)
                            if u48[a1] == u8 then
                                u48[a1] = nil
                            end
                            if a1_2.Parent ~= nil then
                                a1_2.AlwaysOnTop = false
                            end
                        end
                    end)))
                end)))
                return
            end
        end

        local function rebindAllRemotePlotSigns() -- Line: 99
            -- upvalues: u49 (upval), PlotState (upval), bindRemotePlotSign (val)
            local v1
            local v2 = {}
            for k in pairs(u49) do
                v2[#v2 + 1] = k
            end
            for i, v in ipairs(v2) do
                v1 = u49[v]
                if v1 ~= nil then
                    v1:Destroy()
                end
            end
            for k2, i2 in pairs(PlotState.ReadOwners()) do
                bindRemotePlotSign(k2, i2)
            end
        end

        local function updateYourBaseTracker(a1) -- Line: 136
            -- upvalues: u47 (upval), Streamable (upval), PlotSignHomeButtonFade (upval), LocalPlayer (upval)
            -- upvalues: RunService (upval)
            u47:Clean()
            if not a1 then
                return
            end
            local CenterPoint = a1.CenterPoint
            local u10 = Streamable.new(a1.PlotFolder, "PlotSign")
            u47:Add(function() -- Line: 144 -- upvalues: u10 (val)
                u10:Destroy()
            end)
            u47:Add((u10:Observe(function(a1, a2) -- Line: 145
                -- upvalues: Streamable (upval), PlotSignHomeButtonFade (upval), LocalPlayer (upval), CenterPoint (val)
                -- upvalues: RunService (upval)
                local u6 = Streamable.new(a1, "SignUI")
                a2:Add(function() -- Line: 147 -- upvalues: u6 (val)
                    u6:Destroy()
                end)
                a2:Add((u6:Observe(function(a1) -- Line: 148
                    assert(a1:IsA("BillboardGui"), "SignUI must be a BillboardGui")
                    local Enabled = a1.Enabled
                    a1.Enabled = false
                    return function() -- Line: 154 -- upvalues: a1 (val), Enabled (val)
                        if a1.Parent ~= nil then
                            a1.Enabled = Enabled
                        end
                    end
                end)))
                local u22 = Streamable.new(a1, "Attachment")
                a2:Add(function() -- Line: 162 -- upvalues: u22 (val)
                    u22:Destroy()
                end)
                a2:Add((u22:Observe(function(a1, a2) -- Line: 163
                    -- upvalues: Streamable (upval), PlotSignHomeButtonFade (upval), LocalPlayer (upval)
                    -- upvalues: CenterPoint (upval), RunService (upval)
                    local u6 = Streamable.new(a1, "YourBase")
                    a2:Add(function() -- Line: 165 -- upvalues: u6 (val)
                        u6:Destroy()
                    end)
                    a2:Add((u6:Observe(function(a1) -- Line: 166
                        -- upvalues: PlotSignHomeButtonFade (upval), a2 (val), LocalPlayer (upval), CenterPoint (upval)
                        -- upvalues: RunService (upval)
                        assert(a1:IsA("BillboardGui"), "YourBase must be a BillboardGui")
                        local u11 = PlotSignHomeButtonFade.new(a1)
                        a2:Add(function() -- Line: 169 -- upvalues: u11 (val)
                            u11:Destroy()
                        end)

                        local function updateDistance() -- Line: 171
                            -- upvalues: LocalPlayer (upval), u11 (val), a1 (val), CenterPoint (upval)
                            local Character = LocalPlayer.Character
                            local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                            if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
                                a1.MaxDistance = 300
                                u11:SetVisible(50 < (HumanoidRootPart.Position - CenterPoint.Position).Magnitude)
                                return
                            end
                            u11:SetVisible(false)
                        end

                        updateDistance()
                        return RunService.Heartbeat:Connect(updateDistance)
                    end)))
                end)))
            end)))
        end

        updateYourBaseTracker(PlotState.ResolvePlot())
        PlotState.LocalPlotChanged:Connect(function() -- Line: 193 -- upvalues: updateYourBaseTracker (val), PlotState (upval)
            updateYourBaseTracker(PlotState.ResolvePlot())
        end)
        rebindAllRemotePlotSigns()
        PlotState.PlotChanged:Connect(bindRemotePlotSign)
        PlotState.FolderChanged:Connect(rebindAllRemotePlotSigns)
        Players.PlayerAdded:Connect(rebindAllRemotePlotSigns)
        Players.PlayerRemoving:Connect(function(a1) -- Line: 199 -- upvalues: PlotState (upval), u49 (upval) -- types: a1: userdata
            local v1
            for k, v in pairs(PlotState.ReadOwners()) do
                if v == a1.UserId then
                    v1 = u49[k]
                    if v1 ~= nil then
                        v1:Destroy()
                    end
                end
            end
        end)
        RunService.Heartbeat:Connect(function() -- Line: 113 -- upvalues: Player (upval), LocalPlayer (upval), u48 (upval)
            local PetArea, PlayerPlotSign, v1, v2, v3, v4
            local v5 = Player.FindRootPart(LocalPlayer)
            local Position = if v5 == nil then nil else v5.Position
            for k, v in pairs(u48) do
                PlayerPlotSign = v.PlayerPlotSign
                if PlayerPlotSign.Parent ~= nil then
                    v3 = false
                    PetArea = v.PetArea
                    if Position ~= nil and PetArea.Parent ~= nil then
                        v4 = PetArea.CFrame:PointToObjectSpace(Position)
                        v1 = PetArea.Size * 0.5
                        v2 = false
                        if (math.abs(v4.X)) <= v1.X then
                            v2 = (math.abs(v4.Z)) <= v1.Z
                        end
                        v3 = v2
                    end
                    if PlayerPlotSign.AlwaysOnTop ~= v3 then
                        PlayerPlotSign.AlwaysOnTop = v3
                    end
                end
            end
        end)
    end,
}