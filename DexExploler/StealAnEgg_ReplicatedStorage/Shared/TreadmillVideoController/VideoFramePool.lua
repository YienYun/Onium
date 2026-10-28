-- Script path: ReplicatedStorage.Shared.TreadmillVideoController.VideoFramePool
-- Decompile time: 9.81 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Log = require(ReplicatedStorage.Packages.Log)
require(script.Parent.Types.Interface)
local u18 = Log.new()
local v1 = {}

local function clearSlot(a1) -- Line: 47 -- types: a1: table
    a1.Frame:Pause()
    a1.Frame.TimePosition = 0
    a1.Frame.Volume = 0
    a1.Frame.Visible = false
    a1.Frame.Video = ""
    a1.MediaIndex = nil
    a1.VideoUri = nil
end

local function assignSlot(a1, a2, a3) -- Line: 57 -- types: a1: table, a2: number
    if a1.MediaIndex == a2 and a1.VideoUri == a3.Video then
        return
    end
    a1.Frame:Pause()
    a1.Frame.TimePosition = 0
    a1.Frame.Volume = 0
    a1.Frame.Visible = false
    a1.Frame.Video = ""
    a1.MediaIndex = nil
    a1.VideoUri = nil
    a1.MediaIndex = a2
    a1.VideoUri = a3.Video
    a1.Frame.Video = a3.Video
end

local function primeHiddenSlot(a1, a2, a3) -- Line: 68 -- upvalues: u18 (val) -- types: a1: table, a2: number
    if a1.MediaIndex ~= a2 or a1.VideoUri ~= a3.Video then
        a1.Frame:Pause()
        a1.Frame.TimePosition = 0
        a1.Frame.Volume = 0
        a1.Frame.Visible = false
        a1.Frame.Video = ""
        a1.MediaIndex = nil
        a1.VideoUri = nil
        a1.MediaIndex = a2
        a1.VideoUri = a3.Video
        a1.Frame.Video = a3.Video
    end
    a1.Frame.Visible = false
    a1.Frame.Volume = 0
    a1.Frame.TimePosition = 0
    local success, err = pcall(function() -- Line: 74 -- upvalues: a1 (val)
        a1.Frame:Play()
        a1.Frame:Pause()
        a1.Frame.TimePosition = 0
    end)
    if success then
        return true
    end
    ;(u18:AtWarning()):Log((("Failed to prime treadmill VideoFrame %*: %*"):format(a3.Video, err)))
    return false
end

local function createCloneSlot(a1, a2) -- Line: 87 -- types: a1: userdata, a2: number
    local v1 = a1:Clone()
    v1.Name = ("MainVideoPreload%*"):format(a2)
    v1.Visible = false
    v1.Video = ""
    v1.Volume = 0
    v1.TimePosition = 0
    v1.Parent = a1.Parent
    return {Frame = v1}
end

function v1.new(a1) -- Line: 107 -- upvalues: primeHiddenSlot (val) -- types: a1: userdata
    a1.Looped = false
    local u2 = {{Frame = a1}}
    local u4 = nil
    local u5 = false
    local v1 = a1:Clone()
    v1.Name = ("MainVideoPreload%*"):format(2)
    v1.Visible = false
    v1.Video = ""
    v1.Volume = 0
    v1.TimePosition = 0
    v1.Parent = a1.Parent
    table.insert(u2, {Frame = v1})
    v1 = a1:Clone()
    v1.Name = ("MainVideoPreload%*"):format(3)
    v1.Visible = false
    v1.Video = ""
    v1.Volume = 0
    v1.TimePosition = 0
    v1.Parent = a1.Parent
    table.insert(u2, {Frame = v1})

    local function findSlotByMediaIndex(a1) -- Line: 124 -- upvalues: u2 (val) -- types: a1: number
        for i, j in u2 do
            if j.MediaIndex == a1 then
                return j
            end
        end
        return nil
    end

    local function acquireInactiveSlot(a1) -- Line: 134 -- upvalues: u2 (val), u4 (ref) -- types: a1: number
        local v1
        for i, j in u2 do
            if j.MediaIndex == a1 then
                v1 = j
                if v1 ~= nil then
                    return v1
                end
                for k, n in u2 do
                    if n ~= u4 and n.MediaIndex == nil then
                        return n
                    end
                end
                for m, i5 in u2 do
                    if i5 ~= u4 then
                        i5.Frame:Pause()
                        i5.Frame.TimePosition = 0
                        i5.Frame.Volume = 0
                        i5.Frame.Visible = false
                        i5.Frame.Video = ""
                        i5.MediaIndex = nil
                        i5.VideoUri = nil
                        return i5
                    end
                end
                error("Treadmill VideoFrame pool has no inactive slot available")
                return
            end
        end
        v1 = nil
        if v1 ~= nil then
            return v1
        end
        for i6, i7 in u2 do
            if i7 ~= u4 and i7.MediaIndex == nil then
                return i7
            end
        end
        for i8, i9 in u2 do
            if i9 ~= u4 then
                i9.Frame:Pause()
                i9.Frame.TimePosition = 0
                i9.Frame.Volume = 0
                i9.Frame.Visible = false
                i9.Frame.Video = ""
                i9.MediaIndex = nil
                i9.VideoUri = nil
                return i9
            end
        end
        error("Treadmill VideoFrame pool has no inactive slot available")
    end

    return {
        Activate = function(a1_2, a2) -- Line: 218
            -- upvalues: u5 (ref), a1 (val), u2 (val), acquireInactiveSlot (val), u4 (ref)
            local v1
            if u5 then
                return a1
            end
            local v2 = nil
            local v3 = nil
            for i, j in u2, v2, v3 do
                if j.MediaIndex == a1_2 then
                    v1 = j or acquireInactiveSlot(a1_2)
                    if v1.MediaIndex ~= a1_2 or v1.VideoUri ~= a2.Video then
                        v1.Frame:Pause()
                        v1.Frame.TimePosition = 0
                        v1.Frame.Volume = 0
                        v1.Frame.Visible = false
                        v1.Frame.Video = ""
                        v1.MediaIndex = nil
                        v1.VideoUri = nil
                        v1.MediaIndex = a1_2
                        v1.VideoUri = a2.Video
                        v1.Frame.Video = a2.Video
                    end
                    v2 = nil
                    v3 = nil
                    for k, n in u2, v2, v3 do
                        n.Frame.Visible = n == v1
                        if n ~= v1 then
                            n.Frame:Pause()
                            n.Frame.Volume = 0
                            n.Frame.TimePosition = 0
                        end
                    end
                    u4 = v1
                    v1.Frame.Volume = a2.Volume or 1
                    v1.Frame.TimePosition = 0
                    return v1.Frame
                end
            end
            v1 = acquireInactiveSlot(a1_2)
            if v1.MediaIndex ~= a1_2 or v1.VideoUri ~= a2.Video then
                v1.Frame:Pause()
                v1.Frame.TimePosition = 0
                v1.Frame.Volume = 0
                v1.Frame.Visible = false
                v1.Frame.Video = ""
                v1.MediaIndex = nil
                v1.VideoUri = nil
                v1.MediaIndex = a1_2
                v1.VideoUri = a2.Video
                v1.Frame.Video = a2.Video
            end
            v2 = nil
            v3 = nil
            for m, i5 in u2, v2, v3 do
                i5.Frame.Visible = i5 == v1
                if i5 ~= v1 then
                    i5.Frame:Pause()
                    i5.Frame.Volume = 0
                    i5.Frame.TimePosition = 0
                end
            end
            u4 = v1
            v1.Frame.Volume = a2.Volume or 1
            v1.Frame.TimePosition = 0
            return v1.Frame
        end,
        ClearActive = function() -- Line: 165 -- upvalues: u4 (ref)
            local v1 = u4
            u4 = nil
            if v1 == nil then
                return
            end
            v1.Frame:Pause()
            v1.Frame.TimePosition = 0
            v1.Frame.Volume = 0
            v1.Frame.Visible = false
            v1.Frame.Video = ""
            v1.MediaIndex = nil
            v1.VideoUri = nil
        end,
        ClearAll = function() -- Line: 241 -- upvalues: u4 (ref), u2 (val)
            u4 = nil
            for i, j in u2 do
                j.Frame:Pause()
                j.Frame.TimePosition = 0
                j.Frame.Volume = 0
                j.Frame.Visible = false
                j.Frame.Video = ""
                j.MediaIndex = nil
                j.VideoUri = nil
            end
        end,
        Destroy = function() -- Line: 248 -- upvalues: u5 (ref), u4 (ref), u2 (val)
            u5 = true
            u4 = nil
            for i, j in u2 do
                j.Frame:Pause()
                j.Frame.TimePosition = 0
                j.Frame.Volume = 0
                j.Frame.Visible = false
                j.Frame.Video = ""
                j.MediaIndex = nil
                j.VideoUri = nil
            end
            local v1 = #u2
            for k = 2, v1 do
                u2[k].Frame:Destroy()
            end
        end,
        GetActiveFrame = function() -- Line: 156 -- upvalues: u4 (ref), a1 (val)
            local v1 = u4
            if v1 == nil then
                return a1
            end
            return v1.Frame
        end,
        Preload = function(a1) -- Line: 175
            -- upvalues: u5 (ref), u4 (ref), u2 (val), acquireInactiveSlot (val), primeHiddenSlot (upval)
            if u5 then
                return
            end
            local v1 = {}
            local v2 = 0
            local v3 = if u4 ~= nil then 2 else 3
            for i, v in ipairs(a1) do
                if v3 <= v2 then
                    break
                end
                v1[v.MediaIndex] = v.MediaEntry
                v2 = v2 + 1
            end
            for i2, j in u2 do
                if j ~= u4 and j.MediaIndex ~= nil and v1[j.MediaIndex] == nil then
                    j.Frame:Pause()
                    j.Frame.TimePosition = 0
                    j.Frame.Volume = 0
                    j.Frame.Visible = false
                    j.Frame.Video = ""
                    j.MediaIndex = nil
                    j.VideoUri = nil
                end
            end
            for i3, k in ipairs(a1) do
                if v1[k.MediaIndex] == nil then
                    break
                end
                task.spawn(function() -- Line: 207 -- upvalues: u5 (upval), acquireInactiveSlot (upval), k (val), primeHiddenSlot (upval)
                    if u5 then
                        return
                    end
                    local v1 = acquireInactiveSlot(k.MediaIndex)
                    primeHiddenSlot(v1, k.MediaIndex, k.MediaEntry)
                end)
            end
        end,
    }
end

return v1