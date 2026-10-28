-- Script path: ReplicatedStorage.Controllers.GUI.BackpackController.Main.GameTranslator
-- Decompile time: 3.01 ms

local LocalizationService = game:GetService("LocalizationService")
local Players = game:GetService("Players")
game.Players.LocalPlayer.PlayerGui:WaitForChild("BackpackGui")
local u18 = nil
local u19 = nil
local u20 = nil
local u21 = nil
local u25 = Instance.new("BindableEvent")

local function handlePlayerOrLocaleChanged() -- Line: 14 -- upvalues: u19 (ref), u20 (ref), u25 (val)
    if u19 and u19.LocaleId ~= u20 then
        u25:Fire(u19.LocaleId)
    end
end

local function reset() -- Line: 21 -- upvalues: u18 (ref), u19 (ref), u21 (ref)
    u18 = nil
    u19 = nil
    if u21 then
        u21:Disconnect()
        u21 = nil
    end
end

local function getTranslator() -- Line: 31
    -- upvalues: u18 (ref), u19 (ref), Players (val), LocalizationService (val), u20 (ref), u25 (val), u21 (ref)
    -- upvalues: handlePlayerOrLocaleChanged (val)
    if not u18 then
        u19 = Players.LocalPlayer
        if u19 then
            u18 = LocalizationService:GetTranslatorForPlayer(u19)
            if u19 and u19.LocaleId ~= u20 then
                u25:Fire(u19.LocaleId)
            end
            ;(u19:GetPropertyChangedSignal("LocaleId")):Connect(handlePlayerOrLocaleChanged)
        end
    end
    return u18
end

local u29 = {}

local function unregisterGui(a1) -- Line: 47 -- upvalues: u29 (val)
    u29[a1].connection:Disconnect()
    u29[a1] = nil
end

local function makeAncestryChangedHandler(a1, a2) -- Line: 52 -- upvalues: u29 (val)
    return function(a1_2, a2_2) -- Line: 53 -- upvalues: a1 (val), a2 (val), u29 (upval)
        if game:IsAncestorOf(a1) then
            a2.hasBeenAdded = true
            return
        end
        if not a2.hasBeenAdded then
            return
        end
        local v1 = a1
        u29[v1].connection:Disconnect()
        u29[v1] = nil
    end
end

local function updateRegistryInfo(a1, a2, a3) -- Line: 64
    a1.context = a2
    a1.text = a3
end

local function makeRegistryInfo(a1, a2, a3) -- Line: 69 -- upvalues: u29 (val)
    local u3 = {}
    u3.hasBeenAdded = game:IsAncestorOf(a1)
    u3.context = a2
    u3.text = a3
    u3.connection = a1.AncestryChanged:Connect(function(a1_2, a2) -- Line: 53 -- upvalues: a1 (val), u3 (val), u29 (upval)
        if game:IsAncestorOf(a1) then
            u3.hasBeenAdded = true
            return
        end
        if not u3.hasBeenAdded then
            return
        end
        local v1 = a1
        u29[v1].connection:Disconnect()
        u29[v1] = nil
    end)
    return u3
end

local function registerGui(a1, a2, a3) -- Line: 76 -- upvalues: u29 (val), makeRegistryInfo (val)
    if u29[a1] == nil then
        u29[a1] = (makeRegistryInfo(a1, a2, a3))
        return
    end
    local v1 = u29[a1]
    v1.context = a2
    v1.text = a3
end

local u35 = {LocaleChanged = u25.Event}

function u35.TranslateGameText(a1, a2, a3) -- Line: 102
    return a3
end

local function retranslateAll() -- Line: 115 -- upvalues: u29 (val), u35 (val)
    for k, v in pairs(u29) do
        k.Text = u35:TranslateGameText(v.context, v.text)
    end
end

function u35.TranslateAndRegister(a1, a2, a3, a4) -- Line: 125
    return a4
end

return u35