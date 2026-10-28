-- Script path: ReplicatedStorage.Shared.Util.ServerClock
-- Decompile time: 4.30 ms

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local u10 = 0
local u11 = nil
local u12 = false
local u13 = {}

local function finite(a1) -- Line: 9
    local v1 = false
    if type(a1) == "number" then
        v1 = false
        if a1 == a1 then
            v1 = (math.abs(a1)) < (1 / 0)
        end
    end
    return v1
end

function u13.Resolve(a1, a2, a3) -- Line: 21
    local v1 = false
    if type(a2) == "number" then
        v1 = false
        if a2 == a2 then
            v1 = (math.abs(a2)) < (1 / 0)
        end
    end
    if v1 and a2 > 1000000000 then
        v1 = a2 + math.max(0, a3)
        local v2 = false
        if type(a1) == "number" then
            v2 = false
            if a1 == a1 then
                v2 = (math.abs(a1)) < (1 / 0)
            end
        end
        if v2 and (math.abs(a1 - v1)) < 30 then
            return a1, false
        end
        return v1, true
    end
    v1 = false
    if type(a1) == "number" then
        v1 = false
        if a1 == a1 then
            v1 = (math.abs(a1)) < (1 / 0)
        end
    end
    if v1 and a1 > 1000000000 then
        return a1, false
    end
    return nil, true
end

function u13.Now() -- Line: 31 -- upvalues: Workspace (val), u13 (val), u11 (ref), u10 (ref), u12 (ref)
    local success, err = pcall(Workspace.GetServerTimeNow, Workspace)
    local v1, v2 = u13.Resolve(if not success then nil else err, u11, os.clock() - u10)
    if v2 and not u12 then
        u12 = true
        warn("[ServerClock] Invalid engine time; using replicated server clock sample")
    end
    return v1 or DateTime.now().UnixTimestampMillis / 1000
end

if RunService:IsServer() then
    local function publish() -- Line: 42 -- upvalues: Workspace (val)
        Workspace:SetAttribute("AuthoritativeClockSample", (DateTime.now()).UnixTimestampMillis / 1000)
    end

    Workspace:SetAttribute("AuthoritativeClockSample", (DateTime.now()).UnixTimestampMillis / 1000)
    task.spawn(function() -- Line: 46 -- upvalues: Workspace (val)
        while task.wait(5) do
            Workspace:SetAttribute("AuthoritativeClockSample", (DateTime.now()).UnixTimestampMillis / 1000)
        end
    end)
end
local v1 = Workspace:GetAttribute("AuthoritativeClockSample")
local v2 = false
if type(v1) == "number" then
    v2 = false
    if v1 == v1 then
        v2 = (math.abs(v1)) < (1 / 0)
    end
end
if v2 and v1 > 1000000000 then
    os.clock()
end
;(Workspace:GetAttributeChangedSignal("AuthoritativeClockSample")):Connect(function() -- Line: 13 -- upvalues: Workspace (val), u11 (ref), u10 (ref)
    local Attribute = Workspace:GetAttribute("AuthoritativeClockSample")
    local v1 = false
    if type(Attribute) == "number" then
        v1 = false
        if Attribute == Attribute then
            v1 = (math.abs(Attribute)) < (1 / 0)
        end
    end
    if v1 and Attribute > 1000000000 then
        u11 = Attribute
        os.clock()
    end
end)
return (table.freeze(u13))