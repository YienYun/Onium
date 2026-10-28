-- Script path: ReplicatedStorage.Controllers.GUI.ShopCtaBadgeController
-- Decompile time: 3.69 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GUI = require(ReplicatedStorage.Client.GUI)
local Log = require(ReplicatedStorage.Packages.Log)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local u28 = Log.new()
local u29 = nil
local u30 = false
return {
    Start = function() -- Line: 27 -- upvalues: GUI (val), u28 (val), u29 (ref), u30 (ref), TryCall (val), Remotes (val), Tabs (val)
        local function resolveControls() -- Line: 32 -- upvalues: GUI (upval)
            local v1 = GUI.HUD()
            local GameHUD = if v1 == nil then nil else v1:FindFirstChild("GameHUD")
            if (if GameHUD == nil then nil else GameHUD:FindFirstChild("LeftControls")) == nil then
                return nil, nil
            end
            local ShopBTN = v1:FindFirstChild("ShopBTN")
            local IndexBTN = v1:FindFirstChild("IndexBTN")
            v1 = if IndexBTN == nil then nil else IndexBTN:FindFirstChild("NotificationBadge")
            if ShopBTN ~= nil and ShopBTN:IsA("GuiObject") then
                local v2 = ShopBTN
                if v1 ~= nil and v1:IsA("GuiObject") then
                    return v2, v1
                end
                return v2, nil
            end
            return nil, nil
        end

        local function buildBadge() -- Line: 49 -- upvalues: resolveControls (val), u28 (upval)
            local v1, v2 = resolveControls()
            if v1 ~= nil and v2 ~= nil then
                local ShopCtaBadge = v1:FindFirstChild("ShopCtaBadge")
                if ShopCtaBadge ~= nil then
                    ShopCtaBadge:Destroy()
                end
                local v3 = v2:Clone()
                v3.Name = "ShopCtaBadge"
                for i, j in v3:GetDescendants() do
                    if j:IsA("TextLabel") then
                        j.Text = "!"
                    end
                end
                v3.Size = UDim2.new(v3.Size.X.Scale * 1.4, v3.Size.X.Offset * 1.4, v3.Size.Y.Scale * 1.4, v3.Size.Y.Offset * 1.4)
                v3.Visible = true
                v3.Parent = v1
                return v3
            end
            u28:AtWarning():Log("Shop CTA badge could not find ShopBTN or the index badge to clone")
            return nil
        end

        local function destroyBadge() -- Line: 79 -- upvalues: u29 (upval), resolveControls (val)
            u29 = nil
            local v1 = resolveControls()
            local ShopCtaBadge = if v1 == nil then nil else v1:FindFirstChild("ShopCtaBadge")
            if ShopCtaBadge ~= nil then
                ShopCtaBadge:Destroy()
            end
        end

        local function retire() -- Line: 88
            -- upvalues: u30 (upval), u29 (upval), resolveControls (val), TryCall (upval), Remotes (upval)
            if u30 then
                return
            end
            u30 = true
            u29 = nil
            local v1 = resolveControls()
            local ShopCtaBadge = if v1 == nil then nil else v1:FindFirstChild("ShopCtaBadge")
            if ShopCtaBadge ~= nil then
                ShopCtaBadge:Destroy()
            end
            TryCall(function() -- Line: 94 -- upvalues: Remotes (upval)
                return Remotes.ShopCta.FlagSeen:InvokeServer()
            end)
        end

        Tabs.Activated:Connect(function(a1) -- Line: 101
            -- upvalues: u30 (upval), u29 (upval), resolveControls (val), TryCall (upval), Remotes (upval)
            if a1 == "Shop" then
                if u30 then
                    return
                end
                u30 = true
                u29 = nil
                local v1 = resolveControls()
                local ShopCtaBadge = if v1 == nil then nil else v1:FindFirstChild("ShopCtaBadge")
                if ShopCtaBadge ~= nil then
                    ShopCtaBadge:Destroy()
                end
                TryCall(function() -- Line: 94 -- upvalues: Remotes (upval)
                    return Remotes.ShopCta.FlagSeen:InvokeServer()
                end)
            end
        end)
        task.spawn(function() -- Line: 107
            -- upvalues: TryCall (upval), Remotes (upval), u30 (upval), Tabs (upval), u29 (upval), resolveControls (val)
            -- upvalues: buildBadge (val)
            local v1, v2 = TryCall(function() -- Line: 108 -- upvalues: Remotes (upval)
                return Remotes.ShopCta.FetchState:InvokeServer()
            end)
            if v1 and v2 == true then
                if not u30 and Tabs.Active() ~= "Shop" then
                    buildBadge()
                    return
                end
                if u30 then
                    return
                end
                u30 = true
                u29 = nil
                v2 = resolveControls()
                v1 = if v2 == nil then nil else v2:FindFirstChild("ShopCtaBadge")
                if v1 ~= nil then
                    v1:Destroy()
                end
                TryCall(function() -- Line: 94 -- upvalues: Remotes (upval)
                    return Remotes.ShopCta.FlagSeen:InvokeServer()
                end)
                return
            end
        end)
    end,
}