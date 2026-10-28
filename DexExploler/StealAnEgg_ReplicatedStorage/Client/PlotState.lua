-- Script path: ReplicatedStorage.Client.PlotState
-- Decompile time: 24.15 ms

local pullUntilAnswered
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Log = require(ReplicatedStorage.Packages.Log)
local Plots = require(ReplicatedStorage.Shared.Types.Plots)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Storefront = require(ReplicatedStorage.Client.Functions.Storefront)
local Streamable = require(ReplicatedStorage.Packages.Streamable).Streamable
local Trove = require(ReplicatedStorage.Packages.Trove)
local t = require(ReplicatedStorage.Packages.t)
local u55 = t.strict(t.instanceIsA("Player"))
local u58 = t.strict(t.Vector3)
local u63 = t.strict(t.instanceIsA("BasePart"))
local u68 = t.strict(t.instanceIsA("Attachment"))
local u73 = t.strict(t.instanceIsA("BillboardGui"))
local u78 = t.strict(t.instanceIsA("Folder"))
local u81 = Log.new()
local LocalPlayer = Players.LocalPlayer
local u83 = {}
local u84 = {}
local u85 = {}
local u86 = {}
local u87 = nil
local u88 = {}
u88.LocalPlotChanged = Signal.new()
u88.PlotChanged = Signal.new()
u88.FolderChanged = Signal.new()
local v1 = Streamable.new(Workspace, "Plots")

local function localSlot() -- Line: 58 -- upvalues: u83 (val), LocalPlayer (val)
    for i, j in u83 do
        if j == LocalPlayer.UserId then
            return i
        end
    end
    return nil
end

local function announce(a1) -- Line: 70 -- upvalues: u88 (val), u83 (val), LocalPlayer (val) -- types: a1: number
    u88.PlotChanged:Fire(a1, u83[a1])
    local v1 = nil
    for i, j in u83 do
        if j == LocalPlayer.UserId then
            v1 = i
            break
        end
    end
    if v1 == a1 then
        u88.LocalPlotChanged:Fire(a1)
    end
end

local function follow(a1, a2, a3, a4) -- Line: 80 -- upvalues: Streamable (val) -- types: a1: userdata, a2: string
    local u8 = Streamable.new(a1, a2)
    a3:Add(function() -- Line: 82 -- upvalues: u8 (val)
        u8:Destroy()
    end)
    u8:Observe(a4)
end

local function watchSlot(a1, a2) -- Line: 86
    -- upvalues: u86 (val), Trove (val), Streamable (val), u88 (val), u83 (val), LocalPlayer (val), u63 (val), u85 (val)
    -- upvalues: u68 (val), u73 (val)
    if u86[a1] then
        return
    end
    local v1 = Trove.new()
    local u13 = Streamable.new(a2, (tostring(a1)))
    local u14 = {plot = u13, trove = v1}
    u86[a1] = u14
    v1:Add(function() -- Line: 96 -- upvalues: u13 (val)
        u13:Destroy()
    end)
    v1:Add(function() -- Line: 97 -- upvalues: u86 (upval), a1 (val), u14 (val)
        if u86[a1] == u14 then
            u86[a1] = nil
        end
    end)

    local function ping() -- Line: 103 -- upvalues: a1 (val), u88 (upval), u83 (upval), LocalPlayer (upval)
        local v1 = a1
        u88.PlotChanged:Fire(v1, u83[v1])
        local v2 = nil
        for i, j in u83 do
            if j == LocalPlayer.UserId then
                v2 = i
                break
            end
        end
        if v2 == v1 then
            u88.LocalPlotChanged:Fire(v1)
        end
    end

    v1:Add((u13:Observe(function(a1_2, a2) -- Line: 105
        -- upvalues: a1 (val), u88 (upval), u83 (upval), LocalPlayer (upval), ping (val), u63 (upval)
        -- upvalues: Streamable (upval), u85 (upval), u86 (upval), u14 (val), u68 (upval), u73 (upval)
        if not a1_2:IsA("Folder") and not a1_2:IsA("Model") then
            return
        end
        local v1 = a1
        u88.PlotChanged:Fire(v1, u83[v1])
        local v2 = nil
        for i, j in u83 do
            if j == LocalPlayer.UserId then
                v2 = i
                break
            end
        end
        if v2 == v1 then
            u88.LocalPlotChanged:Fire(v1)
        end
        a2:Add(ping)
        local u60 = Streamable.new(a1_2, "CenterPoint")
        a2:Add(function() -- Line: 82 -- upvalues: u60 (val)
            u60:Destroy()
        end)
        u60:Observe(function(a1_2, a2) -- Line: 113
            -- upvalues: u63 (upval), a1 (upval), u88 (upval), u83 (upval), LocalPlayer (upval), ping (upval)
            u63(a1_2)
            local v1 = a1
            u88.PlotChanged:Fire(v1, u83[v1])
            local v2 = nil
            for i, j in u83 do
                if j == LocalPlayer.UserId then
                    v2 = i
                    break
                end
            end
            if v2 == v1 then
                u88.LocalPlotChanged:Fire(v1)
            end
            a2:Add(ping)
        end)
        local u74 = Streamable.new(a1_2, "SpawnPoint")
        a2:Add(function() -- Line: 82 -- upvalues: u74 (val)
            u74:Destroy()
        end)
        u74:Observe(function(a1_2, a2) -- Line: 119
            -- upvalues: u63 (upval), u85 (upval), a1 (upval), u88 (upval), u83 (upval), LocalPlayer (upval)
            -- upvalues: u86 (upval), u14 (upval)
            u63(a1_2)
            u85[a1] = a1_2.CFrame + Vector3.new(0, 0, 0)
            local v1 = a1
            u88.PlotChanged:Fire(v1, u83[v1])
            local v2 = nil
            for i, j in u83 do
                if j == LocalPlayer.UserId then
                    v2 = i
                    break
                end
            end
            if v2 == v1 then
                u88.LocalPlotChanged:Fire(v1)
            end
            a2:Add(function() -- Line: 125 -- upvalues: u86 (upval), a1 (upval), u14 (upval), u88 (upval), u83 (upval), LocalPlayer (upval)
                local v1 = u86[a1]
                if v1 == u14 then
                    v1 = a1
                    u88.PlotChanged:Fire(v1, u83[v1])
                    local v2 = nil
                    for i, j in u83 do
                        if j == LocalPlayer.UserId then
                            v2 = i
                            break
                        end
                    end
                    if v2 == v1 then
                        u88.LocalPlotChanged:Fire(v1)
                    end
                end
            end)
        end)
        local u88_2 = Streamable.new(a1_2, "ToUpdate")
        a2:Add(function() -- Line: 82 -- upvalues: u88_2 (val)
            u88_2:Destroy()
        end)
        u88_2:Observe(function(a1_2, a2) -- Line: 132
            -- upvalues: a1 (upval), u88 (upval), u83 (upval), LocalPlayer (upval), ping (upval), u63 (upval)
            -- upvalues: Streamable (upval)
            if a1_2:IsA("Model") then
                local v1 = a1
                u88.PlotChanged:Fire(v1, u83[v1])
                local v2 = nil
                for i, j in u83 do
                    if j == LocalPlayer.UserId then
                        v2 = i
                        break
                    end
                end
                if v2 == v1 then
                    u88.LocalPlotChanged:Fire(v1)
                end
                a2:Add(ping)
                local u54 = Streamable.new(a1_2, "PetArea")
                a2:Add(function() -- Line: 82 -- upvalues: u54 (val)
                    u54:Destroy()
                end)
                u54:Observe(function(a1_2, a2) -- Line: 137
                    -- upvalues: u63 (upval), a1 (upval), u88 (upval), u83 (upval), LocalPlayer (upval), ping (upval)
                    u63(a1_2)
                    local v1 = a1
                    u88.PlotChanged:Fire(v1, u83[v1])
                    local v2 = nil
                    for i, j in u83 do
                        if j == LocalPlayer.UserId then
                            v2 = i
                            break
                        end
                    end
                    if v2 == v1 then
                        u88.LocalPlotChanged:Fire(v1)
                    end
                    a2:Add(ping)
                end)
            end
        end)
        local u102 = Streamable.new(a1_2, "PlotSign")
        a2:Add(function() -- Line: 82 -- upvalues: u102 (val)
            u102:Destroy()
        end)
        u102:Observe(function(a1_2, a2) -- Line: 145
            -- upvalues: a1 (upval), u88 (upval), u83 (upval), LocalPlayer (upval), ping (upval), u68 (upval)
            -- upvalues: u73 (upval), Streamable (upval)
            local v1 = a1
            u88.PlotChanged:Fire(v1, u83[v1])
            local v2 = nil
            for i, j in u83 do
                if j == LocalPlayer.UserId then
                    v2 = i
                    break
                end
            end
            if v2 == v1 then
                u88.LocalPlotChanged:Fire(v1)
            end
            a2:Add(ping)
            local u50 = Streamable.new(a1_2, "Attachment")
            a2:Add(function() -- Line: 82 -- upvalues: u50 (val)
                u50:Destroy()
            end)
            u50:Observe(function(a1_2, a2) -- Line: 149
                -- upvalues: u68 (upval), a1 (upval), u88 (upval), u83 (upval), LocalPlayer (upval), ping (upval)
                -- upvalues: u73 (upval), Streamable (upval)
                u68(a1_2)
                local v1 = a1
                u88.PlotChanged:Fire(v1, u83[v1])
                local v2 = nil
                for i, j in u83 do
                    if j == LocalPlayer.UserId then
                        v2 = i
                        break
                    end
                end
                if v2 == v1 then
                    u88.LocalPlotChanged:Fire(v1)
                end
                a2:Add(ping)
                local u53 = Streamable.new(a1_2, "YourBase")
                a2:Add(function() -- Line: 82 -- upvalues: u53 (val)
                    u53:Destroy()
                end)
                u53:Observe(function(a1_2, a2) -- Line: 154
                    -- upvalues: u73 (upval), a1 (upval), u88 (upval), u83 (upval), LocalPlayer (upval), ping (upval)
                    u73(a1_2)
                    local v1 = a1
                    u88.PlotChanged:Fire(v1, u83[v1])
                    local v2 = nil
                    for i, j in u83 do
                        if j == LocalPlayer.UserId then
                            v2 = i
                            break
                        end
                    end
                    if v2 == v1 then
                        u88.LocalPlotChanged:Fire(v1)
                    end
                    a2:Add(ping)
                end)
            end)
        end)
        local u116 = Streamable.new(a1_2, "BaseUpgrade")
        a2:Add(function() -- Line: 82 -- upvalues: u116 (val)
            u116:Destroy()
        end)
        u116:Observe(function(a1_2, a2) -- Line: 162
            -- upvalues: a1 (upval), u88 (upval), u83 (upval), LocalPlayer (upval), ping (upval), Streamable (upval)
            local v1 = a1
            u88.PlotChanged:Fire(v1, u83[v1])
            local v2 = nil
            for i, j in u83 do
                if j == LocalPlayer.UserId then
                    v2 = i
                    break
                end
            end
            if v2 == v1 then
                u88.LocalPlotChanged:Fire(v1)
            end
            a2:Add(ping)
            local u50 = Streamable.new(a1_2, "Sign")
            a2:Add(function() -- Line: 82 -- upvalues: u50 (val)
                u50:Destroy()
            end)
            u50:Observe(function(a1_2, a2) -- Line: 166 -- upvalues: a1 (upval), u88 (upval), u83 (upval), LocalPlayer (upval), ping (upval)
                local v1 = a1
                u88.PlotChanged:Fire(v1, u83[v1])
                local v2 = nil
                for i, j in u83 do
                    if j == LocalPlayer.UserId then
                        v2 = i
                        break
                    end
                end
                if v2 == v1 then
                    u88.LocalPlotChanged:Fire(v1)
                end
                a2:Add(ping)
            end)
        end)
    end)))
end

local function forgetSlot(a1) -- Line: 174 -- upvalues: u86 (val), u85 (val) -- types: a1: number
    local v1 = u86[a1]
    if v1 ~= nil then
        u85[a1] = nil
        u86[a1] = nil
        v1.trove:Destroy()
    end
end

local function forgetEverySlot() -- Line: 183 -- upvalues: u86 (val), u85 (val)
    local v1
    local v2 = {}
    for i in u86 do
        table.insert(v2, i)
    end
    for j, k in v2 do
        v1 = u86[k]
        if v1 ~= nil then
            u85[k] = nil
            u86[k] = nil
            v1.trove:Destroy()
        end
    end
end

local function slotFor(a1) -- Line: 194 -- upvalues: LocalPlayer (val), u55 (val), u83 (val) -- types: a1: userdata?
    local v1
    local v2 = a1 or LocalPlayer
    u55(v2)
    if v2 ~= LocalPlayer then
        v1 = nil
    else
        v1 = nil
        for i, j in u83 do
            if j == LocalPlayer.UserId then
                v1 = i
                for k, n in u83 do
                    if v1 == nil and n == v2.UserId then
                        v1 = k
                    end
                end
                return v1, v2
            end
        end
    end
    for m, i5 in u83 do
        if v1 == nil and i5 == v2.UserId then
            v1 = m
        end
    end
    return v1, v2
end

function u88.ReadOwners() -- Line: 210 -- upvalues: u83 (val)
    return table.clone(u83)
end

function u88.LookupOwner(a1) -- Line: 212 -- upvalues: u83 (val) -- types: a1: number
    return u83[a1]
end

function u88.ResolveLocalSlot() -- Line: 214 -- upvalues: u83 (val), LocalPlayer (val)
    for i, j in u83 do
        if j == LocalPlayer.UserId then
            return i
        end
    end
    return nil
end

function u88.ResolveFolder() -- Line: 216 -- upvalues: u87 (ref)
    return u87
end

function u88.ResolvePlot(a1) -- Line: 220 -- upvalues: slotFor (val), u87 (ref), u85 (val) -- types: a1: userdata?
    local v1 = slotFor(a1)
    local v2 = u87
    local v3 = if v1 == nil or v2 == nil then nil else v2:FindFirstChild((tostring(v1)))
    v2 = if v3 == nil then nil else v3:FindFirstChild("ToUpdate")
    local PetArea = if v2 == nil then nil else if not v2:IsA("Model") then nil else v2:FindFirstChild("PetArea")
    v2 = if v3 == nil then nil else v3:FindFirstChild("CenterPoint")
    local v4 = false
    if PetArea ~= nil then
        v4 = PetArea:IsA("BasePart")
        if v4 then
            v4 = false
            if v2 ~= nil then
                v4 = v2:IsA("BasePart")
            end
        end
    end
    if not v4 then
        return nil
    end
    local SpawnPoint = v3:FindFirstChild("SpawnPoint")
    local v5 = if SpawnPoint == nil then u85[v1] else if not SpawnPoint:IsA("BasePart") then u85[v1] else SpawnPoint.CFrame + Vector3.new(0, 0, 0)
    u85[v1] = v5
    return {
        Slot = v1,
        PlotFolder = v3,
        PetArea = PetArea,
        CenterPoint = v2,
        RespawnPointCFrame = u85[v1],
    }
end

function u88.FindLocalBaseSign() -- Line: 247 -- upvalues: u88 (val)
    local v1 = u88.ResolvePlot()
    local PlotSign = if not v1 then nil else v1.PlotFolder:FindFirstChild("PlotSign")
    v1 = if not PlotSign then nil else PlotSign:FindFirstChild("Attachment")
    local YourBase = if v1 == nil then nil else if not v1:IsA("Attachment") then nil else v1:FindFirstChild("YourBase")
    if YourBase ~= nil and YourBase:IsA("BillboardGui") then
        return YourBase
    end
    return nil
end

function u88.FindRespawnCFrame(a1) -- Line: 257 -- upvalues: slotFor (val), u85 (val) -- types: a1: userdata?
    local v1 = slotFor(a1)
    if v1 == nil then
        return nil
    end
    return u85[v1]
end

function u88.ContainsLocalPoint(a1) -- Line: 262 -- upvalues: u58 (val), u88 (val) -- types: a1: vector
    u58(a1)
    local v1 = u88.ResolvePlot()
    if not v1 then
        return false
    end
    local BoundingBox, BoundingBox_2 = v1.PlotFolder:GetBoundingBox()
    v1 = BoundingBox:PointToObjectSpace(a1)
    local v2 = BoundingBox_2 * 0.5
    local v3 = false
    if (math.abs(v1.X)) <= v2.X then
        v3 = (math.abs(v1.Z)) <= v2.Z
    end
    return v3
end

local function adoptOwner(a1, a2) -- Line: 276
    -- upvalues: u83 (val), LocalPlayer (val), u88 (val)
    local v1 = nil
    for i, j in u83 do
        if j == LocalPlayer.UserId then
            v1 = i
            break
        end
    end
    u83[a1] = a2
    u88.PlotChanged:Fire(a1, a2)
    if a2 == LocalPlayer.UserId or v1 == a1 then
        u88.LocalPlotChanged:Fire(a1)
    end
end

local function acceptUpdate(a1) -- Line: 286 -- upvalues: u84 (val), u83 (val), LocalPlayer (val), u88 (val)
    local Slot, UserId, v1
    local v2 = u84[a1.Slot]
    if v2 == nil then
        u84[a1.Slot] = a1.Revision
        Slot = a1.Slot
        UserId = a1.UserId
        v1 = nil
        for i, j in u83 do
            if j == LocalPlayer.UserId then
                v1 = i
                break
            end
        end
        u83[Slot] = UserId
        u88.PlotChanged:Fire(Slot, UserId)
        if UserId == LocalPlayer.UserId or v1 == Slot then
            u88.LocalPlotChanged:Fire(Slot)
        end
    elseif v2 < a1.Revision then
        u84[a1.Slot] = a1.Revision
        Slot = a1.Slot
        UserId = a1.UserId
        v1 = nil
        for k, n in u83 do
            if n == LocalPlayer.UserId then
                v1 = k
                break
            end
        end
        u83[Slot] = UserId
        u88.PlotChanged:Fire(Slot, UserId)
        if UserId == LocalPlayer.UserId or v1 == Slot then
            u88.LocalPlotChanged:Fire(Slot)
        end
    end
end

local function acceptSnapshot(a1) -- Line: 294 -- upvalues: u84 (val), u83 (val), LocalPlayer (val), u88 (val)
    local Revision, v1, v2, v3
    local v4 = {}
    local v5 = nil
    local v6 = nil
    local v7 = a1
    for i, j in a1.OwnersBySlot, v5, v6 do
        v1 = assert(tonumber(i), (("plot snapshot carried a non-numeric slot: %*"):format(i)))
        v4[v1] = true
        v2 = u84[v1]
        if v2 == nil then
            u84[v1] = v7.Revision
            v3 = nil
            for k, n in u83 do
                if n == LocalPlayer.UserId then
                    v3 = k
                    break
                end
            end
            u83[v1] = j
            u88.PlotChanged:Fire(v1, j)
            if j == LocalPlayer.UserId or v3 == v1 then
                u88.LocalPlotChanged:Fire(v1)
            end
        elseif v2 < v7.Revision then
            u84[v1] = v7.Revision
            v3 = nil
            for m, i5 in u83 do
                if i5 == LocalPlayer.UserId then
                    v3 = m
                    break
                end
            end
            u83[v1] = j
            u88.PlotChanged:Fire(v1, j)
            if j == LocalPlayer.UserId or v3 == v1 then
                u88.LocalPlotChanged:Fire(v1)
            end
        end
    end
    local v8 = {}
    for i6 in u84 do
        table.insert(v8, i6)
    end
    v6 = nil
    local v9 = nil
    for i7, i8 in v8, v6, v9 do
        v2 = false
        if v4[i8] ~= true then
            v2 = u84[i8] < v7.Revision
        end
        v3 = v2 and u83[i8] ~= nil
        Revision = if not v2 then u84[i8] else v7.Revision
        u84[i8] = Revision
        if v3 then
            v2 = nil
            for i9, i10 in u83 do
                if i10 == LocalPlayer.UserId then
                    v2 = i9
                    break
                end
            end
            u83[i8] = nil
            u88.PlotChanged:Fire(i8, nil)
            if LocalPlayer.UserId == nil or v2 == i8 then
                u88.LocalPlotChanged:Fire(i8)
            end
        end
    end
end

local function askState() -- Line: 322 -- upvalues: Remotes (val)
    return Remotes.Homestead.AskState:InvokeServer()
end

local function pullSnapshot() -- Line: 324 -- upvalues: askState (val), Plots (val), acceptSnapshot (val)
    local success, err = pcall(askState)
    if not success then
        return false, (tostring(err))
    end
    local v1, v2 = Plots.SchemaValidation.PlotStateSnapshot(err)
    if not v1 then
        return false, (("plot snapshot failed validation: %*"):format(v2))
    end
    acceptSnapshot(err)
    return true
end

function pullUntilAnswered() -- Line: 339
    -- upvalues: askState (val), Plots (val), acceptSnapshot (val), u81 (val), pullUntilAnswered (val)
    local v1, v2
    local success, err = pcall(askState)
    if success then
        local v3, v4 = Plots.SchemaValidation.PlotStateSnapshot(err)
        if v3 then
            acceptSnapshot(err)
            v1 = true
            v2 = nil
        else
            v1 = false
            v2 = ("plot snapshot failed validation: %*"):format(v4)
        end
    else
        v1 = false
        v2 = tostring(err)
    end
    if not v1 then
        (u81:AtError()):Log((("plot snapshot request did not land, retrying: %*"):format(v2)))
        task.delay(5, pullUntilAnswered)
    end
end

Remotes.Homestead.StateShifted.OnClientEvent:Connect(function(a1) -- Line: 347 -- upvalues: Plots (val), u84 (val), u83 (val), LocalPlayer (val), u88 (val), u81 (val)
    local v1, v2 = Plots.SchemaValidation.PlotStateUpdate(a1)
    if not v1 then
        (u81:AtError()):Log((("plot state update failed validation: %*"):format(v2)))
        return
    end
    local v3 = u84[a1.Slot]
    if v3 ~= nil and not (v3 < a1.Revision) then
        return
    end
    u84[a1.Slot] = a1.Revision
    local Slot = a1.Slot
    local UserId = a1.UserId
    local v4 = nil
    for i, j in u83 do
        if j == LocalPlayer.UserId then
            v4 = i
            break
        end
    end
    u83[Slot] = UserId
    u88.PlotChanged:Fire(Slot, UserId)
    if UserId ~= LocalPlayer.UserId and v4 ~= Slot then
        return
    end
    u88.LocalPlotChanged:Fire(Slot)
end)
v1:Observe(function(a1, a2) -- Line: 356
    -- upvalues: u78 (val), u87 (ref), u88 (val), forgetEverySlot (val), watchSlot (val), u86 (val), u85 (val)
    local v1
    u78(a1)
    u87 = a1
    u88.FolderChanged:Fire(a1)
    a2:Add(function() -- Line: 361 -- upvalues: u87 (upval), a1 (val), forgetEverySlot (upval), u88 (upval)
        if u87 == a1 then
            u87 = nil
        end
        forgetEverySlot()
        u88.FolderChanged:Fire(nil)
    end)

    local function watchIfNumbered(a1_2) -- Line: 370 -- upvalues: watchSlot (upval), a1 (val) -- types: a1_2: userdata
        local v1 = tonumber(a1_2.Name)
        if v1 ~= nil then
            watchSlot(v1, a1)
        end
    end

    for i, j in a1:GetChildren() do
        v1 = tonumber(j.Name)
        if v1 ~= nil then
            watchSlot(v1, a1)
        end
    end
    a2:Connect(a1.ChildAdded, function(a1_2) -- Line: 381 -- upvalues: watchSlot (upval), a1 (val), u88 (upval)
        local v1 = tonumber(a1_2.Name)
        if v1 ~= nil then
            watchSlot(v1, a1)
        end
        u88.FolderChanged:Fire(a1)
    end)
    a2:Connect(a1.ChildRemoved, function(a1_2) -- Line: 386 -- upvalues: u86 (upval), u85 (upval), u88 (upval), a1 (val)
        local v1 = tonumber(a1_2.Name)
        if v1 ~= nil then
            local v2 = u86[v1]
            if v2 ~= nil then
                u85[v1] = nil
                u86[v1] = nil
                v2.trove:Destroy()
            end
        end
        u88.FolderChanged:Fire(a1)
    end)
end)
task.spawn(pullUntilAnswered)
Remotes.Homestead.AskNearbyPurchase.OnClientEvent:Connect(function(a1) -- Line: 401 -- upvalues: Storefront (val) -- types: a1: number
    Storefront.Prompt(a1, true)
end)
return u88