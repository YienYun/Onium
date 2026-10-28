-- Script path: ReplicatedStorage.Packages._Index.sleitnick_wait-for@1.0.0.wait-for
-- Decompile time: 4.55 ms

local RunService = game:GetService("RunService")
local Promise = require(script.Parent.Parent.Parent.Promise)
local u12 = {Error = {Unparented = "Unparented", ParentChanged = "ParentChanged"}}

local function PromiseWatchAncestry(a1, a2) -- Line: 40 -- upvalues: Promise (val), u12 (val) -- types: a1: userdata
    local race = Promise.race
    local v1 = {}
    local v2 = Promise.fromEvent(a1.AncestryChanged, function(a1, a2) -- Line: 43
        return a2 == nil
    end)
    v1[1] = a2
    v1[2] = v2:andThen(function() -- Line: 45 -- upvalues: Promise (upval), u12 (upval)
        return Promise.reject(u12.Error.Unparented)
    end)
    return race(v1)
end

function u12.Child(a1, a2, a3) -- Line: 61
    -- upvalues: Promise (val), PromiseWatchAncestry (val)
    local v1 = a1:FindFirstChild(a2)
    if v1 then
        return Promise.resolve(v1)
    end
    return PromiseWatchAncestry(a1, (Promise.fromEvent(a1.ChildAdded, function(a1) -- Line: 68 -- upvalues: a2 (val)
        return a1.Name == a2
    end)):timeout(a3 or 120))
end

function u12.ChildWhichIsA(a1, a2, a3) -- Line: 94
    -- upvalues: Promise (val), PromiseWatchAncestry (val)
    local v1 = a1:FindFirstChildWhichIsA(a2)
    if v1 then
        return Promise.resolve(v1)
    end
    return PromiseWatchAncestry(a1, (Promise.fromEvent(a1.ChildAdded, function(a1) -- Line: 101 -- upvalues: a2 (val)
        return a1:IsA(a2)
    end)):timeout(a3 or 120))
end

function u12.Children(a1, a2, a3) -- Line: 125
    -- upvalues: u12 (val), Promise (val)
    local v1 = table.create(#a2)
    for i, v in ipairs(a2) do
        v1[i] = (u12.Child(a1, v, a3))
    end
    return (Promise.all(v1)):andThen(function(a1_2) -- Line: 130 -- upvalues: a1 (val), Promise (upval), u12 (upval)
        for i, v in ipairs(a1_2) do
            if v.Parent ~= a1 then
                return Promise.reject(u12.Error.ParentChanged)
            end
        end
        return a1_2
    end)
end

function u12.Descendant(a1, a2, a3) -- Line: 153
    -- upvalues: Promise (val), PromiseWatchAncestry (val)
    local v1 = a1:FindFirstChild(a2, true)
    if v1 then
        return Promise.resolve(v1)
    end
    return PromiseWatchAncestry(a1, (Promise.fromEvent(a1.DescendantAdded, function(a1) -- Line: 160 -- upvalues: a2 (val)
        return a1.Name == a2
    end)):timeout(a3 or 120))
end

function u12.Descendants(a1, a2, a3) -- Line: 184
    -- upvalues: u12 (val), Promise (val)
    local v1 = table.create(#a2)
    for i, v in ipairs(a2) do
        v1[i] = (u12.Descendant(a1, v, a3))
    end
    return (Promise.all(v1)):andThen(function(a1_2) -- Line: 189 -- upvalues: a1 (val), Promise (upval), u12 (upval)
        for i, v in ipairs(a1_2) do
            if not v:IsDescendantOf(a1) then
                return Promise.reject(u12.Error.ParentChanged)
            end
        end
        return a1_2
    end)
end

function u12.PrimaryPart(a1, a2) -- Line: 210
    -- upvalues: Promise (val), PromiseWatchAncestry (val)
    local PrimaryPart = a1.PrimaryPart
    if PrimaryPart then
        return (Promise.resolve(PrimaryPart))
    end
    return (PromiseWatchAncestry(a1, (((Promise.fromEvent(a1:GetPropertyChangedSignal("PrimaryPart"), function() -- Line: 217 -- upvalues: PrimaryPart (ref), a1 (val)
        PrimaryPart = a1.PrimaryPart
        return PrimaryPart ~= nil
    end)):andThen(function() -- Line: 221 -- upvalues: PrimaryPart (ref)
        return PrimaryPart
    end)):timeout(a2 or 120))))
end

function u12.ObjectValue(a1, a2) -- Line: 238
    -- upvalues: Promise (val), PromiseWatchAncestry (val)
    local Value = a1.Value
    if Value then
        return (Promise.resolve(Value))
    end
    return (PromiseWatchAncestry(a1, (((Promise.fromEvent(a1.Changed, function(a1) -- Line: 245 -- upvalues: Value (ref)
        return a1 ~= nil
    end)):andThen(function() -- Line: 249 -- upvalues: Value (ref)
        return Value
    end)):timeout(a2 or 120))))
end

function u12.Custom(a1, a2) -- Line: 268
    -- upvalues: Promise (val), RunService (val)
    local v1 = a1()
    if v1 ~= nil then
        return Promise.resolve(v1)
    end
    return Promise.new(function(a1_2, a2, a3) -- Line: 273 -- upvalues: a1 (val), RunService (upval)
        local u3 = nil
        RunService.Heartbeat:Connect(function() -- Line: 278 -- upvalues: a1 (upval), u3 (ref), a1_2 (val)
            local v1 = a1()
            if v1 ~= nil then
                u3:Disconnect()
                a1_2(v1)
            end
        end)
        a3(function() -- Line: 275 -- upvalues: u3 (ref)
            u3:Disconnect()
        end)
    end):timeout(a2 or 120)
end

return u12