-- Script path: ReplicatedStorage.Client.UI.MessageTyper
-- Decompile time: 5.11 ms

local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Audio = require(ReplicatedStorage.Shared.Audio)
local Normal = require(ReplicatedStorage.Data.Sounds.Languages.Alphabet).Normal
local u26 = {}
u26.__index = u26
u26.__class = "MessageTyper"

local function splitGlyphs(a1) -- Line: 32 -- types: a1: string
    local v1 = string.gsub(a1, "<.->", "")
    local v2 = {}
    for i, j in utf8.graphemes(v1) do
        v2[#v2 + 1] = (string.sub(v1, i, j))
    end
    return v2
end

local function voiceGlyph(a1, a2) -- Line: 42
    -- upvalues: Normal (val), Audio (val), ReplicatedFirst (val)
    if a1 == " " then
        return
    end
    local v1 = Normal[string.lower(a1)]
    if v1 then
        Audio.PlaySound(v1.Sound:Clone(), v1.Sound.Parent)
        return
    end
    Audio.Play(a2, ReplicatedFirst)
end

function u26.new(a1, a2, a3, a4) -- Line: 56
    -- upvalues: u26 (val)
    local v1 = setmetatable({}, u26)
    v1.label = a1
    v1.run = 0
    v1.clickSound = a2 or "rbxassetid://91414159854126"
    v1.clicksOn = a4 ~= false
    v1.pace = a3 or 0.09
    v1.driver = nil
    v1.watcher = nil
    v1.sweep = nil
    return v1
end

function u26:Halt() -- Line: 74
    self.run = self.run + 1
    local sweep = self.sweep
    if sweep then
        sweep:Cancel()
        self.sweep = nil
    end
    local watcher = self.watcher
    if watcher then
        watcher:Disconnect()
        self.watcher = nil
    end
    local driver = self.driver
    if driver then
        driver:Destroy()
        self.driver = nil
    end
    self.label.MaxVisibleGraphemes = -1
end

function u26.Blank(a1) -- Line: 98
    a1:Halt()
    a1.label.Text = ""
end

function u26.ShowAll(a1, a2, a3) -- Line: 103 -- types: a2: string, a3: userdata
    local label = a1.label
    local v1 = false
    if label.Text == a2 then
        v1 = false
        if label.TextColor3 == a3 then
            v1 = label.MaxVisibleGraphemes == -1
        end
    end
    if v1 then
        return
    end
    a1:Halt()
    label.RichText = true
    label.Text = a2
    label.TextColor3 = a3
    label.MaxVisibleGraphemes = -1
end

function u26.Type(a1, a2, a3) -- Line: 119
    -- upvalues: splitGlyphs (val), Normal (val), Audio (val), ReplicatedFirst (val), TweenService (val)
    local label = a1.label
    if label.Text == a2 and label.TextColor3 == a3 then
        return
    end
    a1:Halt()
    a1.run = a1.run + 1
    local run = a1.run
    label.RichText = true
    label.Text = a2
    label.TextColor3 = a3
    local u19 = splitGlyphs(a2)
    local u20 = #u19
    if u20 <= 0 then
        label.MaxVisibleGraphemes = -1
        return
    end
    label.MaxVisibleGraphemes = 0
    local NumberValue = Instance.new("NumberValue")
    NumberValue.Value = 0
    a1.driver = NumberValue
    local u28 = 0
    a1.watcher = (NumberValue:GetPropertyChangedSignal("Value")):Connect(function() -- Line: 147
        -- upvalues: run (val), a1 (val), NumberValue (val), u20 (val), u28 (ref), label (val), u19 (val)
        -- upvalues: Normal (upval), Audio (upval), ReplicatedFirst (upval)
        if run ~= a1.run then
            return
        end
        local v1 = math.clamp(math.floor(NumberValue.Value + 0.5), 0, u20)
        if v1 == u28 then
            return
        end
        label.MaxVisibleGraphemes = v1
        if a1.clicksOn then
            local clickSound, v2, v3
            for i = u28 + 1, v1 do
                v2 = u19[i]
                if v2 then
                    clickSound = a1.clickSound
                    if v2 ~= " " then
                        v3 = Normal[string.lower(v2)]
                        if not v3 then
                            Audio.Play(clickSound, ReplicatedFirst)
                        else
                            Audio.PlaySound(v3.Sound:Clone(), v3.Sound.Parent)
                        end
                    end
                end
            end
        end
        u28 = v1
    end)
    local v1 = TweenService:Create(NumberValue, TweenInfo.new(u20 * a1.pace), {Value = u20})
    a1.sweep = v1
    v1.Completed:Connect(function() -- Line: 175 -- upvalues: run (val), a1 (val), label (val)
        if run ~= a1.run then
            return
        end
        label.MaxVisibleGraphemes = -1
        local watcher = a1.watcher
        if watcher then
            watcher:Disconnect()
            a1.watcher = nil
        end
        local driver = a1.driver
        if driver then
            driver:Destroy()
            a1.driver = nil
        end
        a1.sweep = nil
    end)
    v1:Play()
end

return u26