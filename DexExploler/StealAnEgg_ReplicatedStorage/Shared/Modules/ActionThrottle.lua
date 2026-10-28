-- Script path: ReplicatedStorage.Shared.Modules.ActionThrottle
-- Decompile time: 5.66 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TokenBucket = require(ReplicatedStorage.Shared.Modules.TokenBucket)
local u21 = require(ReplicatedStorage.Packages.Log).new():AtWarning():Wrap()
local t = require(ReplicatedStorage.Packages.t)

local function callerName() -- Line: 23
    local v1, v2
    for i = 2, 8 do
        v1 = debug.info(i, "s")
        if v1 == nil then
            break
        end
        v2 = string.match(v1, "([^%.]-)$") or ""
        if v2 ~= "" and v2 ~= "ActionThrottle" then
            return v2
        end
    end
    return ""
end

local u27 = nil

local function watch(a1, a2) -- Line: 75 -- types: a2: userdata
    if not a1.watched[a2] then
        a1.watched[a2] = true
        a2.Destroying:Connect(function() -- Line: 78 -- upvalues: a1 (val), a2 (val)
            a1:Clear(a2)
            a1.watched[a2] = nil
        end)
    end
end

local function requireBucket(a1, a2) -- Line: 85 -- upvalues: t (val) -- types: a2: string?
    t.strict(t.optional(t.string))(a2)
    if a2 then
        assert(a1.buckets[a2] and a2 ~= "Global", (string.format("no endpoint named '%s' is configured on this limiter", a2)))
    end
end

local function charge(a1, a2, a3) -- Line: 93 -- upvalues: TokenBucket (val) -- types: a2: userdata
    local v1 = TokenBucket.Spend(a3, a2)
    if v1 then
        return true
    end
    if v1 and a1.warns then
        warn(string.format(a1.logFormat, "ENDPOINT_EXHAUSTED", a2.Name, a2.UserId, a3.name))
    end
    if a3.causesBan then
        a1:Block(a2)
    end
    return false
end

local u38 = {
    Block = function(self, a2, a3) -- Line: 113 -- upvalues: t (val), u21 (val) -- types: a2: userdata, a3: number?
        t.strict(t.instanceIsA("Player"))(a2)
        t.strict(t.optional(t.number))(a3)
        local v1 = self.bannedUntil[a2]
        local v2 = (workspace:GetServerTimeNow()) + (a3 or self.banSeconds)
        self.bannedUntil[a2] = if v1 == nil then v2 else math.max(v2, v1)
        if self.warns and v1 == nil then
            u21(string.format(self.logFormat, "BAN", a2.Name, a2.UserId, "Banned!"))
        end
    end,
    Unblock = function(a1, a2) -- Line: 127 -- upvalues: t (val), u21 (val) -- types: a2: userdata
        t.strict(t.instanceIsA("Player"))(a2)
        if not a1.bannedUntil[a2] then
            return false, u21((string.format(a1.logFormat, "BAN", a2.Name, a2.UserId, "lifted a ban that was never applied")))
        end
        a1.bannedUntil[a2] = nil
        return true
    end,
    IsBlocked = function(self, a2) -- Line: 139 -- upvalues: t (val) -- types: a2: userdata
        t.strict(t.instanceIsA("Player"))(a2)
        local v1 = self.bannedUntil[a2]
        local v2 = false
        if v1 ~= nil then
            v2 = v1 < workspace:GetServerTimeNow()
        end
        if v2 then
            self.bannedUntil[a2] = nil
        end
        local v3 = false
        if v1 ~= nil then
            v3 = not v2
        end
        return v3
    end,
    Clear = function(self, a2) -- Line: 152 -- upvalues: TokenBucket (val) -- types: a2: userdata?
        for i, v in ipairs(a2 and {a2} or game.Players:GetPlayers()) do
            self.bannedUntil[v] = nil
            for k, i2 in pairs(self.buckets) do
                TokenBucket.Forget(i2, v)
            end
        end
    end,
    Check = function(a1, a2, a3) -- Line: 163 -- upvalues: t (val), u27 (ref), charge (val) -- types: a2: userdata, a3: string?
        t.strict(t.instanceIsA("Player"))(a2)
        t.strict(t.optional(t.string))(a3)
        if a3 then
            assert(a1.buckets[a3] and a3 ~= "Global", (string.format("no endpoint named '%s' is configured on this limiter", a3)))
        end
        if not a1.watched[a2] then
            a1.watched[a2] = true
            a2.Destroying:Connect(function() -- Line: 78 -- upvalues: a1 (val), a2 (val)
                a1:Clear(a2)
                a1.watched[a2] = nil
            end)
        end
        local v1 = a3 and a1.buckets[a3]
        local Global = a1.buckets.Global
        local UNAVAILABLE = nil
        if a1.retired then
            UNAVAILABLE = u27.Rejection.UNAVAILABLE
        elseif a1:IsBlocked(a2) then
            UNAVAILABLE = u27.Rejection.BLOCKED
        elseif not v1 then
            if Global and not charge(a1, a2, Global) then
                UNAVAILABLE = u27.Rejection.BUSY
            end
        elseif not charge(a1, a2, v1) or Global and not charge(a1, a2, Global) then
            UNAVAILABLE = u27.Rejection.BUSY
        end
        if UNAVAILABLE then
            return false, UNAVAILABLE
        end
        return true
    end,
}
u27 = {
    DefaultBlockSeconds = 60,
    DefaultLogging = true,
    Rejection = {
        BUSY = "You're doing that too fast!",
        BLOCKED = "You're on cooldown. Please try again later.",
        UNAVAILABLE = "Endpoint not permitted.",
    },
    LogTemplates = {BAN = "[RATE LIMIT][%*] (%*): %*, %*: (%*)"},
    Build = function(a1) -- Line: 200
        -- upvalues: t (val), TokenBucket (val), callerName (val), u27 (ref), u38 (ref)
        t.strict(t.table)(a1)
        t.strict(t.optional(t.number))(a1.BanLength)
        assert(a1.Global or a1.Endpoints, "a limiter needs at least one endpoint")
        local v1 = {}
        if a1.Global then
            v1.Global = TokenBucket.Build("Global", a1.Global)
        end
        local v2 = pairs
        local Endpoints = a1.Endpoints or {}
        for k, v in v2(Endpoints) do
            assert(k ~= "Global", "the global endpoint is configured through Global")
            v1[k] = (TokenBucket.Build(k, v))
        end
        assert(next(v1) ~= nil, "a limiter needs at least one endpoint")
        local Id = v3.Id or callerName()
        local v4 = {
            retired = false,
            label = Id,
            logFormat = string.format(u27.LogTemplates.BAN, "%*", Id, "%*", "%*", "%*"),
        }
        local Warn = if v3.Warn == nil then u27.DefaultLogging else v3.Warn
        v4.warns = Warn
        v4.buckets = v1
        v4.bannedUntil = {}
        local BanLength = v3.BanLength or u27.DefaultBlockSeconds
        v4.banSeconds = BanLength
        v4.watched = {}
        return (setmetatable(v4, {__index = u38}))
    end,
    Once = function() -- Line: 230 -- upvalues: u27 (ref)
        return u27.Build({BanLength = (1 / 0), Global = {MaximumTokens = 1}})
    end,
    AtRate = function(a1, a2) -- Line: 234 -- upvalues: t (val), u27 (ref) -- types: a1: number, a2: number?
        assert(a1 > 0, "a per-second allowance needs a positive rate")
        t.strict(t.optional(t.number))(a2)
        return u27.Build({
            BanLength = u27.DefaultBlockSeconds,
            Global = {Ban = false, MaximumTokens = a2 or 1, Refresh = {{Tokens = 1, Interval = 1 / a1}}},
        })
    end,
}
return (table.freeze(u27))