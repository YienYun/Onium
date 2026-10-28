-- Script path: ReplicatedStorage.Shared.Preferences
-- Decompile time: 6.13 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local v1 = {
    {
        Section = "Audio",
        Items = {
            {Key = "Music", Default = true, Title = "Music", Summary = "Play background music."},
            {Key = "SFX", Default = true, Title = "Sound Effects", Summary = "Play sound effects."},
        },
    },
    {
        Section = "Gameplay",
        Items = {
            {
                Key = "HideOtherPets",
                Default = false,
                Title = "Hide Other Pets",
                Summary = "Hide the pets of other players.",
            },
            {
                Key = "HideSelfPets",
                Default = false,
                Title = "Hide Your Pets",
                Summary = "Hide your own pets on your plot.",
            },
            {
                Key = "DisableVideos",
                Default = false,
                Title = "Disable Videos",
                Summary = "Turn off the treadmill video.",
            },
            {
                Key = "AFK",
                Default = false,
                Title = "AFK Mode",
                Summary = "Stay in the lobby and skip Murder Mystery rounds.",
            },
        },
    },
    {
        Section = "Interface",
        Items = {
            {
                Key = "VirtualCursor",
                Default = false,
                Title = "Menu Navigation",
                Summary = "Use a cursor instead of button navigation in menus.",
            },
            {
                Key = "CreatorPanel",
                Default = true,
                Title = "Creator Panel",
                Summary = "Open the creator panel with F3. Shown to accounts with creator access.",
            },
        },
    },
    {
        Section = "Internal",
        Items = {{Key = "SeenNavigationHint", Default = false, Title = "Navigation Hint Seen"}},
    },
}
local u104 = {Catalogue = v1}
local u105 = {}
local u106 = {}
local u107 = {}
local v2 = nil
local v3 = nil
for i, j in v1, v2, v3 do
    for k, n in j.Items do
        u105[n.Key] = n
        u106[n.Key] = n.Default
        u107[n.Key] = {}
        table.freeze(n)
    end
    table.freeze(j.Items)
    table.freeze(j)
end
table.freeze(v1)

local function itemFor(a1) -- Line: 96 -- upvalues: u105 (val) -- types: a1: string
    local v1 = u105[a1]
    if v1 == nil then
        error(("\"%*\" is not a preference"):format((tostring(a1))), 3)
    end
    return v1
end

local function asFlag(a1, a2) -- Line: 106 -- types: a1: table
    if typeof(a2) == "boolean" then
        return a2
    end
    return a1.Default
end

local function notify(a1) -- Line: 110 -- upvalues: u106 (val), u107 (val) -- types: a1: string
    local v1 = u106[a1]
    for i, j in table.clone(u107[a1]) do
        j.Notify(v1)
    end
end

local function put(a1, a2) -- Line: 119 -- upvalues: u105 (val), u106 (val) -- types: a1: string
    local v1 = u105[a1]
    local Default = if typeof(a2) ~= "boolean" then v1.Default else a2
    if u106[a1] == Default then
        return false
    end
    u106[a1] = Default
    return true
end

local function absorb(a1) -- Line: 129 -- upvalues: u105 (val), u106 (val), u107 (val)
    local Default, v1, v2, v3
    local v4 = if typeof(a1) ~= "table" then {} else a1
    local v5 = {}
    local v6 = nil
    local v7 = nil
    for i in u105, v6, v7 do
        v3 = v4[i]
        v1 = u105[i]
        Default = if typeof(v3) ~= "boolean" then v1.Default else v3
        if u106[i] ~= Default then
            u106[i] = Default
            v2 = true
        else
            v2 = false
        end
        if v2 then
            table.insert(v5, i)
        end
    end
    v6 = nil
    v7 = nil
    for j, k in v5, v6, v7 do
        v4 = u106[k]
        for n, m in table.clone(u107[k]) do
            m.Notify(v4)
        end
    end
end

function u104.IsOn(a1) -- Line: 142 -- upvalues: u105 (val), u106 (val) -- types: a1: string
    if u105[a1] == nil then
        error(("\"%*\" is not a preference"):format((tostring(a1))), 3)
    end
    return u106[a1]
end

function u104.Set(a1, a2) -- Line: 149
    -- upvalues: u105 (val), Remotes (val), absorb (val), u106 (val), u107 (val)
    if u105[a1] == nil then
        error(("\"%*\" is not a preference"):format((tostring(a1))), 3)
    end
    if typeof(a2) ~= "boolean" then
        error(("preference values are booleans, got %*"):format((typeof(a2))), 2)
    end
    local success, err, v1 = pcall(function() -- Line: 155 -- upvalues: Remotes (upval), a1 (val), a2 (val)
        return Remotes.Preferences.AskWrite:InvokeServer(a1, a2)
    end)
    if not success then
        warn((("preference write for %* raised: %*"):format(a1, (tostring(err)))))
        return false
    end
    if err ~= true then
        return false
    end
    if typeof(v1) ~= "table" then
        local v2
        local v3 = u105[a1]
        local Default = if typeof(a2) ~= "boolean" then v3.Default else a2
        if u106[a1] ~= Default then
            u106[a1] = Default
            v2 = true
        else
            v2 = false
        end
        if v2 then
            local v4 = u106[a1]
            for i, j in table.clone(u107[a1]) do
                j.Notify(v4)
            end
        end
    else
        absorb(v1)
    end
    return true
end

function u104.Toggle(a1) -- Line: 174 -- upvalues: u104 (val) -- types: a1: string
    return u104.Set(a1, not u104.IsOn(a1))
end

function u104.Observe(a1, a2) -- Line: 180
    -- upvalues: u105 (val), u107 (val), u106 (val)
    if u105[a1] == nil then
        error(("\"%*\" is not a preference"):format((tostring(a1))), 3)
    end
    local u16 = u107[a1]
    local u17 = {Notify = a2}
    table.insert(u16, u17)
    a2(u106[a1])
    return function() -- Line: 186 -- upvalues: u16 (val), u17 (val)
        local v1 = table.find(u16, u17)
        if v1 ~= nil then
            table.remove(u16, v1)
        end
    end
end

Remotes.Preferences.PreferenceShifted.OnClientEvent:Connect(function(a1, a2) -- Line: 196 -- upvalues: u105 (val), u106 (val), u107 (val)
    if typeof(a1) == "string" and u105[a1] ~= nil then
        local v1
        local v2 = u105[a1]
        local Default = if typeof(a2) ~= "boolean" then v2.Default else a2
        if u106[a1] ~= Default then
            u106[a1] = Default
            v1 = true
        else
            v1 = false
        end
        if v1 then
            v1 = u106[a1]
            for i, j in table.clone(u107[a1]) do
                j.Notify(v1)
            end
        end
    end
end)
Save.Watch("Settings"):Connect(absorb)
task.spawn(function() -- Line: 204 -- upvalues: Save (val), absorb (val)
    local v1 = Save.Await()
    if v1 ~= nil then
        absorb(v1.Settings)
    end
end)
return table.freeze(u104)