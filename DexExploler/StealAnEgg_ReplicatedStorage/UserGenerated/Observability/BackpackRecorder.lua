-- Script path: ReplicatedStorage.UserGenerated.Observability.BackpackRecorder
-- Decompile time: 15.02 ms

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local VRService = game:GetService("VRService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Observability = require(ReplicatedStorage.UserGenerated.Observability)
local Codec = require(ReplicatedStorage.UserGenerated.Observability.Codec)
local BackpackOrder = require(ReplicatedStorage.UserGenerated.Observability.BackpackOrder)
local u54 = {}
u54.__index = u54

local function slotCount() -- Line: 20 -- upvalues: VRService (val), UserInputService (val)
    if VRService.VREnabled then
        return 6
    end
    local CurrentCamera = workspace.CurrentCamera
    if UserInputService.TouchEnabled and CurrentCamera and CurrentCamera.ViewportSize.X < 1024 then
        return 3
    end
    return 10
end

function u54.new(a1) -- Line: 26
    -- upvalues: BackpackOrder (val), VRService (val), UserInputService (val), u54 (val), Players (val)
    -- upvalues: StarterGui (val), GuiService (val), RunService (val)
    local v1
    local v2 = {NextTool = 0, StateDirty = true, Destroyed = false, Registry = a1}
    v2.Connections = {}
    v2.Containers = {}
    v2.Tools = {}
    v2.Dirty = {}
    v2.Removed = {}
    local new = BackpackOrder.new
    if not VRService.VREnabled then
        local CurrentCamera = workspace.CurrentCamera
        v1 = if not UserInputService.TouchEnabled then 10 else if not CurrentCamera then 10 else if not (CurrentCamera.ViewportSize.X < 1024) then 10 else 3
    else
        v1 = 6
    end
    v2.Order = new(v1)
    v2.FrameKeys = {}
    v2.FrameEquips = {}
    local u31 = setmetatable(v2, u54)
    local LocalPlayer = Players.LocalPlayer

    local function connect(a1, a2) -- Line: 31 -- upvalues: u31 (val)
        table.insert(u31.Connections, (a1:Connect(a2)))
    end

    local function invalidate() -- Line: 34 -- upvalues: u31 (val)
        u31.Order:Invalidate()
        u31.StateDirty = true
        table.clear(u31.FrameKeys)
        table.clear(u31.FrameEquips)
    end

    table.insert(u31.Connections, (UserInputService.InputBegan:Connect(function(a1, a2) -- Line: 40 -- upvalues: UserInputService (upval), u31 (val), StarterGui (upval), GuiService (upval)
        if UserInputService:GetFocusedTextBox() then
            return
        end
        local UserInputType = a1.UserInputType
        local KeyCode = a1.KeyCode
        if KeyCode ~= Enum.KeyCode.Backquote then
            local v1
            if a2 then
                if UserInputType ~= Enum.UserInputType.MouseButton1
                    and UserInputType ~= Enum.UserInputType.Touch
                    and KeyCode ~= Enum.KeyCode.ButtonSelect then
                    if UserInputType == Enum.UserInputType.Keyboard then
                        v1 = StarterGui
                        if v1:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) and not GuiService.MenuIsOpen then
                            v1 = KeyCode.Value - Enum.KeyCode.Zero.Value
                            if v1 >= 0 and v1 <= 9 then
                                table.insert(u31.FrameKeys, if v1 ~= 0 then v1 else 10)
                            end
                        end
                    end
                    return
                end
                u31.Order:Invalidate()
                u31.StateDirty = true
                table.clear(u31.FrameKeys)
                table.clear(u31.FrameEquips)
                return
            end
            if KeyCode ~= Enum.KeyCode.ButtonSelect then
                if UserInputType == Enum.UserInputType.Keyboard then
                    v1 = StarterGui
                    if v1:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) and not GuiService.MenuIsOpen then
                        v1 = KeyCode.Value - Enum.KeyCode.Zero.Value
                        if v1 >= 0 and v1 <= 9 then
                            table.insert(u31.FrameKeys, if v1 ~= 0 then v1 else 10)
                        end
                    end
                end
                return
            end
        end
        u31.Order:Invalidate()
        u31.StateDirty = true
        table.clear(u31.FrameKeys)
        table.clear(u31.FrameEquips)
    end)))
    table.insert(u31.Connections, (RunService.PreRender:Connect(function() -- Line: 55 -- upvalues: u31 (val), LocalPlayer (val)
        if #u31.FrameKeys == 1 and #u31.FrameEquips == 1 then
            local v1 = u31.FrameEquips[1]
            local v2 = u31.Tools[v1]
            if v2 and v1.Parent == LocalPlayer.Character then
                u31.Order:Recover(u31.FrameKeys[1], v2.Id)
                u31.StateDirty = true
            end
        end
        table.clear(u31.FrameKeys)
        table.clear(u31.FrameEquips)
    end)))
    table.insert(u31.Connections, (StarterGui.CoreGuiChangedSignal:Connect(function(a1) -- Line: 68 -- upvalues: u31 (val)
        if a1 == Enum.CoreGuiType.Backpack or a1 == Enum.CoreGuiType.All then
            u31.Order:Invalidate()
            u31.StateDirty = true
            table.clear(u31.FrameKeys)
            table.clear(u31.FrameEquips)
        end
    end)))
    table.insert(u31.Connections, (LocalPlayer.CharacterAdded:Connect(function(a1) -- Line: 71 -- upvalues: u31 (val)
        u31.Order:Invalidate()
        u31.StateDirty = true
        table.clear(u31.FrameKeys)
        table.clear(u31.FrameEquips)
        u31:_bind(a1)
    end)))
    table.insert(u31.Connections, (LocalPlayer.CharacterRemoving:Connect(function(a1) -- Line: 76 -- upvalues: u31 (val)
        u31:_unbind(a1)
        u31.Order:Invalidate()
        u31.StateDirty = true
        table.clear(u31.FrameKeys)
        table.clear(u31.FrameEquips)
    end)))
    table.insert(u31.Connections, (LocalPlayer.ChildAdded:Connect(function(a1) -- Line: 77 -- upvalues: u31 (val)
        if a1:IsA("Backpack") then
            u31:_bind(a1)
        end
    end)))
    table.insert(u31.Connections, (LocalPlayer.ChildRemoved:Connect(function(a1) -- Line: 78 -- upvalues: u31 (val)
        if u31.Containers[a1] then
            u31:_unbind(a1)
            u31.Order:Invalidate()
            u31.StateDirty = true
            table.clear(u31.FrameKeys)
            table.clear(u31.FrameEquips)
        end
    end)))
    if LocalPlayer.Character then
        u31:_bind(LocalPlayer.Character)
    end
    local v3 = LocalPlayer:FindFirstChildOfClass("Backpack")
    if v3 then
        u31:_bind(v3)
    end
    table.clear(u31.FrameEquips)
    return u31
end

function u54:_bind(a2) -- Line: 87
    if self.Containers[a2] then
        return
    end
    self.Containers[a2] = {
        a2.ChildAdded:Connect(function(a1) -- Line: 90 -- upvalues: self (val)
            self:_observe(a1)
        end),
        (a2.ChildRemoved:Connect(function(a1) -- Line: 91 -- upvalues: self (val)
            if self.Tools[a1] then
                self.Dirty[a1] = true
            end
        end)),
    }
    for i, j in a2:GetChildren() do
        self:_observe(j)
    end
end

function u54:_unbind(a2) -- Line: 98
    local v1 = self.Containers[a2]
    if not v1 then
        return
    end
    for i, j in v1 do
        j:Disconnect()
    end
    self.Containers[a2] = nil
    for k in self.Tools do
        if k.Parent == a2 then
            self.Dirty[k] = true
        end
    end
end

function u54:_observe(a2) -- Line: 106 -- upvalues: Players (val)
    if not a2:IsA("Tool") then
        return
    end
    if not self.Tools[a2] then
        self.NextTool = self.NextTool + 1
        local v1 = {Id = self.NextTool, Connections = {}}
        self.Tools[a2] = v1
        self.Order:Add(v1.Id)
        for i, j in {"Name", "TextureId", "ToolTip"} do
            table.insert(v1.Connections, ((a2:GetPropertyChangedSignal(j)):Connect(function() -- Line: 115 -- upvalues: self (val), a2 (val)
                self.Dirty[a2] = true
            end)))
        end
        self.StateDirty = true
    end
    if a2.Parent == Players.LocalPlayer.Character then
        table.insert(self.FrameEquips, a2)
    end
    self.Dirty[a2] = true
end

function u54:_write(a2, a3, a4, a5, a6) -- Line: 123 -- upvalues: Observability (val), Codec (val), HttpService (val)
    local Registry = self.Registry
    local Stream = Registry.Stream
    local W = Registry.Stream.W
    local v1 = Registry.ClassPropsByName.Folder[a5]
    if a2 then
        Stream:Time((math.max(Registry.Clock(), Registry.AddFloor)))
        W:u8(Observability.Op.Prop)
        Codec.varuint(W, a2)
    else
        a2 = Registry.NextId
        Registry.NextId = Registry.NextId + 1
        Registry:AddTime()
        Registry.Copies:WriteHead(W, a2, a3, Registry.ClassIndex.Folder, a4, false)
        W:u16(1)
    end
    Codec.varuint(W, v1)
    Codec.writeValue(W, Observability.ValueType.String, HttpService:JSONEncode(a6))
    Stream:EndRecord()
    return a2
end

function u54.Flush(a1) -- Line: 144
    -- upvalues: VRService (val), UserInputService (val), BackpackOrder (val), Observability (val), Players (val)
    -- upvalues: Codec (val)
    local Stream, v1
    if not VRService.VREnabled then
        local CurrentCamera = workspace.CurrentCamera
        v1 = if not UserInputService.TouchEnabled then 10 else if not CurrentCamera then 10 else if not (CurrentCamera.ViewportSize.X < 1024) then 10 else 3
    else
        v1 = 6
    end
    if v1 ~= a1.Order.Count then
        a1.Order = BackpackOrder.new(v1)
        a1.Order:Invalidate()
        a1.StateDirty = true
    end
    if not a1.Root then
        a1.Root = a1:_write(
            nil,
            Observability.RootId.PlayerGui,
            "Backpack (best effort)",
            "UGBackpackState",
            {slots = a1.Order.Slots, guessed = a1.Order.Guessed}
        )
    end
    local v2 = nil
    local v3 = nil
    for i in a1.Dirty, v2, v3 do
        v1 = a1.Tools[i]
        if not a1.Containers[i.Parent] then
            if v1.StreamId then
                Stream = a1.Registry.Stream
                Stream:Time((math.max(a1.Registry.Clock(), a1.Registry.AddFloor)))
                Stream.W:u8(Observability.Op.Remove)
                Codec.varuint(Stream.W, v1.StreamId)
                Stream:EndRecord()
                a1.Registry.Copies:Forget(v1.StreamId)
            end
            for j, k in v1.Connections do
                k:Disconnect()
            end
            a1.Tools[i] = nil
            a1.Order:Remove(v1.Id)
            a1.StateDirty = true
        else
            v1.StreamId = a1:_write(v1.StreamId, a1.Root, "Tool", "UGBackpackTool", {
                id = v1.Id,
                name = i.Name,
                texture = i.TextureId,
                tooltip = i.ToolTip,
                equipped = i.Parent == Players.LocalPlayer.Character,
            })
        end
    end
    table.clear(a1.Dirty)
    if a1.StateDirty then
        a1:_write(a1.Root, 0, "", "UGBackpackState", {slots = a1.Order.Slots, guessed = a1.Order.Guessed})
        a1.StateDirty = false
    end
end

function u54.Destroy(a1) -- Line: 184
    a1.Destroyed = true
    for i, j in a1.Connections do
        j:Disconnect()
    end
    local v1 = nil
    local v2 = nil
    local v3 = a1
    for k, n in a1.Containers, v1, v2 do
        for m, i5 in n do
            i5:Disconnect()
        end
    end
    v1 = nil
    v2 = nil
    for i6, i7 in v3.Tools, v1, v2 do
        for i8, i9 in i7.Connections do
            i9:Disconnect()
        end
    end
    table.clear(v3.Tools)
    table.clear(v3.Dirty)
    table.clear(v3.Containers)
end

return u54