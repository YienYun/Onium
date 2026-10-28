-- Script path: ReplicatedStorage.Shared.Utils.Preload
-- Decompile time: 6.74 ms

local ContentProvider = game:GetService("ContentProvider")
local u5 = {}

local function asContent(a1) -- Line: 16
    local v1 = typeof(a1)
    if v1 == "number" then
        return (("rbxassetid://%*"):format(a1))
    end
    if v1 ~= "string" and v1 ~= "Instance" then
        error(("cannot preload a %* value"):format(v1), 3)
        return
    end
    return a1
end

local function describe(a1) -- Line: 26
    if typeof(a1) == "Instance" then
        return (a1:GetFullName())
    end
    return a1
end

local function requestSlice(a1) -- Line: 30 -- upvalues: ContentProvider (val) -- types: a1: table
    local u1 = {}
    local success, err = pcall(ContentProvider.PreloadAsync, ContentProvider, a1, function(a1, a2) -- Line: 36 -- upvalues: u1 (val) -- types: a1: string
        if a2 ~= Enum.AssetFetchStatus.Success then
            table.insert(u1, a1)
        end
    end)
    if not success then
        warn((("preload request failed outright: %*"):format(err)))
        local v1 = nil
        local v2 = nil
        for i, j in a1, v1, v2 do
            table.insert(u1, if typeof(j) ~= "Instance" then j else j:GetFullName())
        end
    end
    return u1
end

function u5.Queue(a1) -- Line: 52 -- upvalues: asContent (val), requestSlice (val) -- types: a1: table
    local move, v1, v2, v3
    local v4 = table.create(#a1)
    for i, j in a1 do
        table.insert(v4, (asContent(j)))
    end
    local v5 = #v4
    for k = 1, v5, 48 do
        move = table.move
        v3 = math.min(k + 48 - 1, #v4)
        v1 = move(v4, k, v3, 1, {})
        v2 = requestSlice(v1)
        if #v2 ~= 0 then
            task.wait(0.75)
            v2 = requestSlice(v1)
        end
        if #v2 > 0 then
            warn((("%* asset(s) still unavailable after a retry: %*"):format(#v2, (table.concat(v2, ", ")))))
        end
    end
end

local function asOneList(...) -- Line: 74
    local v1 = {}
    local v2 = {...}
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        if type(j) ~= "table" then
            table.insert(v1, j)
        else
            for k, n in j do
                table.insert(v1, n)
            end
        end
    end
    return v1
end

function u5.WarmAssets(...) -- Line: 88 -- upvalues: u5 (val), asOneList (val)
    u5.Queue(asOneList(...))
end

function u5.WarmAtWorkspace(a1, ...) -- Line: 92
    -- upvalues: asOneList (val), ContentProvider (val)
    local v1, v2
    local v3 = {}
    local v4 = {
        MeshPart = true,
        Decal = true,
        Animation = true,
        ParticleEmitter = true,
        Beam = true,
        ImageLabel = true,
        Sound = true,
        VideoFrame = true,
    }
    local v5 = (asOneList(...))
    local v6 = nil
    local v7 = nil
    for i, j in v5, v6, v7 do
        for k in pairs(v4) do
            v2 = j:QueryDescendants(k)
            table.move(v2, 1, #v2, #v3 + 1, v3)
        end
    end
    local ViewportFrame = Instance.new("ViewportFrame")
    ViewportFrame.Parent = workspace
    print((("[%*] Preloading %* assets"):format(a1, #v3)))
    local u34 = math.ceil(#v3 / 50)
    local u35 = 0
    local u36 = {}

    local function loadBatch() -- Line: 125
        -- upvalues: u35 (ref), ContentProvider (upval), u36 (val), a1 (val), u34 (val)
        u35 = u35 + 1
        pcall(function() -- Line: 128 -- upvalues: ContentProvider (upval), u36 (upval)
            ContentProvider:PreloadAsync(u36)
        end)
        for i, j in u36 do
            j:Destroy()
        end
        table.clear(u36)
        print((("[%*] Preloading %*/%* batches"):format(a1, u35, u34)))
    end

    local v8 = nil
    local v9 = nil
    for k2, n in v3, v8, v9 do
        v1 = n:Clone()
        if v1:IsA("BasePart") then
            v1.Anchored = true
            v1.Transparency = 1
            v1.CanCollide = false
            v1.CanQuery = false
            v1.CanTouch = false
        end
        for m, i5 in v1:GetTags() do
            v1:RemoveTag(i5)
        end
        v1:ClearAllChildren()
        v1.Parent = ViewportFrame
        table.insert(u36, v1)
        if #u36 >= 50 then
            loadBatch()
            task.wait()
        end
    end
    loadBatch()
    ViewportFrame:Destroy()
    print((("[%*] Preloading completed"):format(script.Name)))
end

function u5.WarmSounds(...) -- Line: 170 -- upvalues: asOneList (val), u5 (val)
    local u2 = asOneList(...)
    local u3 = {}
    local u4 = {}
    local success, err = pcall(function() -- Line: 174 -- upvalues: u2 (val), u3 (val), u4 (val), u5 (upval)
        local Sound, v1, v2
        local v3 = nil
        local v4 = nil
        for i, j in u2, v3, v4 do
            v2 = typeof(j)
            if v2 == "number" then
                v1 = ("rbxassetid://%*"):format(j)
            elseif v2 == "string" then
                v1 = j
            elseif v2 ~= "Instance" then
                error(("cannot preload a %* value"):format(v2), 3)
                v1 = nil
            else
                v1 = j
            end
            if typeof(v1) ~= "Instance" then
                Sound = Instance.new("Sound")
                table.insert(u4, Sound)
                Sound.SoundId = v1
                table.insert(u3, Sound)
            else
                assert(v1:IsA("Sound"), "WarmSounds expects Sound instances or sound IDs")
                table.insert(u3, v1)
            end
        end
        u5.Queue(u3)
    end)
    for i, j in u4 do
        j:Destroy()
    end
    if not success then
        error(err, 0)
    end
end

return table.freeze(u5)