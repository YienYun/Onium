-- Script path: ReplicatedStorage.Controllers.GUI.BackpackController.Main.SlotFavoriteController
-- Decompile time: 5.49 ms

local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Trove = require(ReplicatedStorage.Packages.Trove)
local u24 = {}
u24.__index = u24

local function visible(a1) -- Line: 14
    local v1 = a1:FindFirstAncestorWhichIsA("ScreenGui")
    if v1 ~= nil and v1.Enabled then
        local Parent = a1
        while true do
            if Parent:IsA("GuiObject") then
                if not Parent.Visible then
                    return false
                end
            end
            Parent = Parent.Parent
            if Parent == v1 then
                return true
            end
        end
    end
    return false
end

local function pointerPosition() -- Line: 29 -- upvalues: GuiService (val), UserInputService (val)
    local GuiInset = GuiService:GetGuiInset()
    return UserInputService:GetMouseLocation() - GuiInset
end

local function inside(a1, a2) -- Line: 34
    local AbsolutePosition = a1.AbsolutePosition
    local v1 = AbsolutePosition + a1.AbsoluteSize
    local v2 = false
    if AbsolutePosition.X <= a2.X then
        v2 = false
        if AbsolutePosition.Y <= a2.Y then
            v2 = false
            if a2.X <= v1.X then
                v2 = a2.Y <= v1.Y
            end
        end
    end
    return v2
end

function u24.new(a1) -- Line: 43 -- upvalues: Trove (val), u24 (val), UserInputService (val), GuiService (val)
    local v1 = Trove.new()
    local v2 = {Entries = {}, Trove = v1, PressTrove = v1:Extend()}
    local u11 = setmetatable(v2, u24)
    v1:Connect(UserInputService.InputBegan, function(a1) -- Line: 51 -- upvalues: GuiService (upval), u11 (val)
        if a1.KeyCode ~= Enum.KeyCode.ButtonL2 then
            return
        end
        local SelectedObject = GuiService.SelectedObject
        local v1 = u11.Entries[SelectedObject]
        local v2 = v1 and v1.GetTool()
        if u11:_canFavorite(SelectedObject, v1, v2) then
            u11:Cancel()
            v1.OnFavorite(v2)
        end
    end)
    v1:Connect(UserInputService.InputEnded, function(a1) -- Line: 65 -- upvalues: u11 (val)
        local Press = u11.Press
        if Press and a1.UserInputType == Enum.UserInputType.MouseButton2 then
            local v1 = false
            if a1.UserInputState ~= Enum.UserInputState.Cancel then
                v1 = u11:_valid(Press)
            end
            u11:Cancel()
            if v1 then
                Press.Entry.OnFavorite(Press.Tool)
            end
            return
        end
    end)
    v1:Connect(UserInputService.WindowFocusReleased, function() -- Line: 80 -- upvalues: u11 (val)
        u11:Cancel()
    end)
    v1:Connect(GuiService.MenuOpened, function() -- Line: 83 -- upvalues: u11 (val)
        u11:Cancel()
    end)
    if a1 then
        v1:Connect(a1.Destroying, function() -- Line: 87 -- upvalues: u11 (val)
            u11:Destroy()
        end)
    end
    return u11
end

function u24:_canFavorite(a2, a3, a4) -- Line: 94 -- upvalues: visible (val)
    local v1 = false
    if a3 ~= nil then
        v1 = false
        if self.Entries[a2] == a3 then
            v1 = visible(a2)
            if v1 then
                v1 = false
                if a3.GetTool() == a4 then
                    v1 = a3.CanFavorite(a4)
                end
            end
        end
    end
    return v1
end

function u24:_valid(a2) -- Line: 102 -- upvalues: GuiService (val), UserInputService (val)
    if not self:_canFavorite(a2.Button, a2.Entry, a2.Tool) then
        return false
    end
    local GuiInset = GuiService:GetGuiInset()
    local v1 = UserInputService:GetMouseLocation() - GuiInset
    local Button_2 = a2.Button
    local AbsolutePosition = Button_2.AbsolutePosition
    local v2 = AbsolutePosition + Button_2.AbsoluteSize
    local v3 = false
    if AbsolutePosition.X <= v1.X then
        v3 = false
        if AbsolutePosition.Y <= v1.Y then
            v3 = false
            if v1.X <= v2.X then
                v3 = v1.Y <= v2.Y
            end
        end
    end
    if v3 then
        v3 = (v1 - a2.Position).Magnitude <= 8
    end
    return v3
end

function u24:_begin(a2, a3) -- Line: 111 -- upvalues: GuiService (val), UserInputService (val), RunService (val)
    self:Cancel()
    local v1 = self.Entries[a2]
    if not v1 then
        return
    end
    local u8 = {Button = a2, Entry = v1}
    u8.Tool = v1.GetTool()
    local GuiInset = GuiService:GetGuiInset()
    u8.Position = UserInputService:GetMouseLocation() - GuiInset
    if not self:_valid(u8) then
        return
    end
    self.Press = u8
    self.PressTrove:Connect(RunService.Heartbeat, function() -- Line: 127 -- upvalues: a3 (val), self (val), u8 (val)
        if a3.UserInputState == Enum.UserInputState.Cancel or not self:_valid(u8) then
            self:Cancel()
        end
    end)
end

function u24.Register(a1, a2, a3) -- Line: 137
    a1:Unregister(a2)
    local v1 = table.clone(a3)
    v1.Trove = a1.Trove:Extend()
    a1.Entries[a2] = v1
    v1.Trove:Connect(a2.InputBegan, function(a1_2) -- Line: 142 -- upvalues: a1 (val), a2 (val)
        if a1_2.UserInputType == Enum.UserInputType.MouseButton2 then
            a1:_begin(a2, a1_2)
        end
    end)
    v1.Trove:Connect(a2.Destroying, function() -- Line: 147 -- upvalues: a1 (val), a2 (val)
        a1:Unregister(a2)
    end)
end

function u24:Unregister(a2) -- Line: 152
    local v1 = self.Entries[a2]
    if not v1 then
        return
    end
    if self.Press and self.Press.Button == a2 then
        self:Cancel()
    end
    self.Entries[a2] = nil
    self.Trove:Remove(v1.Trove)
end

function u24:Cancel() -- Line: 164
    self.Press = nil
    self.PressTrove:Clean()
end

function u24:Destroy() -- Line: 169
    self:Cancel()
    self.Trove:Destroy()
    table.clear(self.Entries)
end

return u24