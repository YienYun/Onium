-- Script path: ReplicatedStorage.Client.GameAudioMute
-- Decompile time: 3.64 ms

local SoundService = game:GetService("SoundService")
local v1 = {}
local u6 = 0
local u7 = {}
local u8 = {}
local u9 = {}
local u10 = nil
local u11 = nil
local u12 = nil
local u13 = {}

local function track(a1) -- Line: 13 -- upvalues: u7 (val), u9 (val), u13 (val), u8 (val), u10 (ref)
    if a1:IsA("Sound") and not u7[a1] then
        local function originalGroup(a1) -- Line: 18 -- upvalues: u9 (upval), u13 (upval)
            local v1 = u9[a1]
            if v1 == u13 then
                return nil
            end
            return v1 or a1
        end

        local u8_2 = {}
        local SoundGroup = a1.SoundGroup
        local v1 = u9[SoundGroup]
        u8_2.group = if v1 ~= u13 then v1 or SoundGroup else nil
        u7[a1] = u8_2

        local function route() -- Line: 26
            -- upvalues: u8_2 (val), u13 (upval), u8 (upval), u9 (upval), u10 (upval), a1 (val)
            local group = u8_2.group or u13
            local v1 = u8[group]
            if not v1 then
                v1 = Instance.new("SoundGroup")
                v1.Name = "Muted"
                v1.Volume = 0
                u9[v1] = group
                u8[group] = v1
                v1.Parent = u10
            end
            a1.SoundGroup = v1
        end

        u8_2.changed = (a1:GetPropertyChangedSignal("SoundGroup")):Connect(function() -- Line: 40 -- upvalues: u9 (upval), a1 (val), u8_2 (val), u13 (upval), u8 (upval), u10 (upval)
            if u9[a1.SoundGroup] then
                return
            end
            u8_2.group = a1.SoundGroup
            local group = u8_2.group or u13
            local v1 = u8[group]
            if not v1 then
                v1 = Instance.new("SoundGroup")
                v1.Name = "Muted"
                v1.Volume = 0
                u9[v1] = group
                u8[group] = v1
                v1.Parent = u10
            end
            a1.SoundGroup = v1
        end)
        local group = u8_2.group or u13
        local v2 = u8[group]
        if not v2 then
            v2 = Instance.new("SoundGroup")
            v2.Name = "Muted"
            v2.Volume = 0
            u9[v2] = group
            u8[group] = v2
            v2.Parent = u10
        end
        a1.SoundGroup = v2
        return
    end
end

local function untrack(a1) -- Line: 50 -- upvalues: u7 (val), u9 (val)
    local v1 = u7[a1]
    if not v1 then
        return
    end
    u7[a1] = nil
    v1.changed:Disconnect()
    if u9[a1.SoundGroup] then
        a1.SoundGroup = v1.group
    end
end

function v1.Acquire() -- Line: 62
    -- upvalues: u6 (ref), u10 (ref), SoundService (val), u11 (ref), track (val), u12 (ref), u7 (val), u9 (val)
    -- upvalues: u8 (val)
    u6 = u6 + 1
    if u6 == 1 then
        u10 = Instance.new("Folder")
        u10.Name = "FullscreenAudioMute"
        u10.Parent = SoundService
        u11 = game.DescendantAdded:Connect(track)
        u12 = game.DescendantRemoving:Connect(function(a1) -- Line: 69 -- upvalues: u7 (upval), u9 (upval)
            if u7[a1] then
                local v1 = u7[a1]
                if not v1 then
                    return
                end
                u7[a1] = nil
                v1.changed:Disconnect()
                if u9[a1.SoundGroup] then
                    a1.SoundGroup = v1.group
                end
            end
        end)
        for i, j in game:GetDescendants() do
            track(j)
        end
    end
    local u38 = false
    return function() -- Line: 80
        -- upvalues: u38 (ref), u6 (upval), u11 (upval), u12 (upval), u7 (upval), u9 (upval), u10 (upval), u8 (upval)
        local v1
        if u38 then
            return
        end
        u38 = true
        u6 = u6 - 1
        if u6 > 0 then
            return
        end
        u11:Disconnect()
        u12:Disconnect()
        for i in u7 do
            v1 = u7[i]
            if v1 then
                u7[i] = nil
                v1.changed:Disconnect()
                if u9[i.SoundGroup] then
                    i.SoundGroup = v1.group
                end
            end
        end
        u10:Destroy()
        u10 = nil
        table.clear(u8)
        table.clear(u9)
    end
end

return (table.freeze(v1))