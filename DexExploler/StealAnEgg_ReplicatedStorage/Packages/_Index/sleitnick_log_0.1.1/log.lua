-- Script path: ReplicatedStorage.Packages._Index.sleitnick_log@0.1.1.log
-- Decompile time: 28.71 ms

local LocalPlayer
local u452 = game:GetService("RunService"):IsServer()
local u535 = game:GetService("RunService"):IsStudio()
local AnalyticsService = game:GetService("AnalyticsService")
local HttpService = game:GetService("HttpService")
local AnalyticsLogLevel = Enum.AnalyticsLogLevel
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
if u452 then
    LocalPlayer = nil
else
    LocalPlayer = Players.LocalPlayer
    if not LocalPlayer then
        LocalPlayer = nil
    end
end
local v1 = script:FindFirstAncestor("Packages").Configs:FindFirstChild("Log")
local v2 = v1 and require(v1) or "Debug"
local u63 = require(ReplicatedStorage.UserGenerated.Strings.Stringify)
local t = require(((game:GetService("ReplicatedStorage")):WaitForChild("Packages")):WaitForChild("t"))
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local u545 = nil
local clock = os.clock
local u86 = {
    Trace = AnalyticsLogLevel.Trace.Value,
    Debug = AnalyticsLogLevel.Debug.Value,
    Info = AnalyticsLogLevel.Information.Value,
    Warning = AnalyticsLogLevel.Warning.Value,
    Error = AnalyticsLogLevel.Error.Value,
    Fatal = AnalyticsLogLevel.Fatal.Value,
}

local function ToSeconds(a1, a2) -- Line: 193 -- types: a1: number, a2: number
    if a2 == 0 then
        return a1 / 1000
    end
    if a2 == 1 then
        return a1
    end
    if a2 == 2 then
        return a1 * 60
    end
    if a2 == 3 then
        return a1 * 3600
    end
    if a2 == 4 then
        return a1 * 86400
    end
    if a2 == 5 then
        return a1 * 604800
    end
    if a2 == 6 then
        return a1 * 2592000
    end
    if a2 == 7 then
        return a1 * 31536000
    end
    error("Unknown time unit", 2)
end

local function GetPlayerFromCustomData(a1) -- Line: 215
    if type(a1) == "table" then
        local Player = a1.Player or a1.PlayerId
        if Player then
            return (game:GetService("Players")):GetPlayerByUserId(Player)
        end
    end
    return nil
end

local u112 = if not u535 then function(a1, a2, a3, a4) -- Line: 235
    -- upvalues: LocalPlayer (val), AnalyticsService (val)
    local success, err = pcall(function() -- Line: 241
        -- upvalues: LocalPlayer (upval), a4 (val), AnalyticsService (upval), a1 (val), a2 (val), a3 (val)
        local v1 = LocalPlayer
        if not v1 then
            local v2 = a4
            if type(v2) ~= "table" then
                v1 = nil
            else
                local Player = v2.Player or v2.PlayerId
                v1 = if not Player then nil else (game:GetService("Players")):GetPlayerByUserId(Player)
            end
        end
        AnalyticsService:FireLogEvent(v1, a1, a2, {stackTrace = a3}, a4)
    end)
    if not success then
        warn(err)
    end
end else function(a1, a2, a3, a4) end
local u120 = {}
u120.__index = u120

function u120.new(a1, a2, a3, a4, a5) -- Line: 268
    -- upvalues: u120 (val)
    return (setmetatable({
        _muted = a5,
        _log = a1,
        _traceback = a3,
        _levelName = a2,
        _modifiers = {Throw = false},
        _key = a4,
    }, u120))
end

function u120:_shouldLog(a2) -- Line: 288 -- upvalues: clock (val)
    if self._modifiers.Every and not a2:_checkAndIncrementCount(self._modifiers.Every) then
        return false
    end
    if self._modifiers.AtMostEvery and not a2:_checkLastTimestamp(clock(), self._modifiers.AtMostEvery) then
        return false
    end
    return true
end

function u120.Every(a1, a2) -- Line: 301 -- types: a1: table, a2: number
    a1._modifiers.Every = a2
    return a1
end

function u120.AtMostEvery(a1, a2, a3) -- Line: 306
    -- upvalues: ToSeconds (val)
    a1._modifiers.AtMostEvery = ToSeconds(a2, a3)
    return a1
end

function u120:Throw() -- Line: 311
    self._modifiers.Throw = true
    return self
end

function u120:Log(a2, ...) -- Line: 316
    -- upvalues: TryCall (val), HttpService (val), u535 (val), u63 (val), clock (val), u86 (val), u112 (ref)
    local v1, v2, v3, v4
    if self._muted then
        return
    end
    local v5 = select("#", ...)
    local v6 = nil
    if v5 == 1 then
        v6 = select(1, ...)
    elseif v5 > 1 then
        v6 = {...}
    end
    v5 = self._log:_getLogStats(self._key)
    local v7 = false
    if not self:_shouldLog(v5) then
        return
    end
    if type(a2) == "function" then
        v2, v3 = a2()
        v1 = v2
        if v3 ~= nil then
            v6 = v3
        end
    elseif type(a2) ~= "table" then
        v1 = a2
    else
        v2, v3 = TryCall(HttpService.JSONEncode, HttpService, a2)
        v1 = if not v2 then a2 else if not v3 then a2 else v3
    end
    if not u535 and self._log._settings.EnableStringRead and type(v1) == "string" and type(v6) == "table" then
        v2, v3 = TryCall(u63.Pretty, v6)
        if v2 and v3 then
            v1 = v1 .. " " .. v3
            v7 = true
        end
    end
    v5:_setTimestamp((clock()))
    v5 = ("%s: [%s] %s"):format(self._log._name, self._levelName, v1)
    v2 = u86[self._levelName]
    u112(v2, ("%s: %s"):format(self._log._name, v1), self._traceback, v6)
    if self._modifiers.Throw then
        error(v5 .. (v6 and not v7 and " " .. HttpService:JSONEncode(v6) or ""), 4)
        return
    end
    if v2 < u86.Warning then
        v4 = not v7 and v6 or ""
        print(v5, v4)
        return
    end
    v4 = not v7 and v6 or ""
    warn(v5, v4)
end

function u120.SepLog(a1, a2, a3) -- Line: 388 -- upvalues: t (val) -- types: a1: table, a2: number?, a3: string?
    t.strict(t.optional(t.string))(a3)
    t.strict(t.optional(t.number))(a2)
    a1:Log((string.rep(a3 or "-", a2 or 100)))
end

function u120.Wrap(a1) -- Line: 395
    return function(...) -- Line: 396 -- upvalues: a1 (val)
        a1:Log(...)
    end
end

function u120.Assert(a1, a2, ...) -- Line: 399 -- types: a1: table, a2: boolean
    if a2 then
        a1:Throw():Log(...)
    end
end

local u143 = {}
u143.__index = u143
setmetatable(u143, u120)

function u143.new(...) -- Line: 409 -- upvalues: u120 (val), u143 (val)
    return (setmetatable(u120.new(...), u143))
end

function u143.Log(a1) end

local u150 = {}
u150.__index = u150

function u150.new() -- Line: 429 -- upvalues: u150 (val)
    local v1 = setmetatable({}, u150)
    v1._invocationCount = 0
    v1._lastTimestamp = 0
    return v1
end

function u150:_checkAndIncrementCount(a2) -- Line: 436 -- types: a2: number
    local v1 = self._invocationCount % a2 == 0
    self._invocationCount = self._invocationCount + 1
    return v1
end

function u150:_checkLastTimestamp(a2, a3) -- Line: 442 -- types: self: table, a2: number, a3: number
    return a3 <= a2 - self._lastTimestamp
end

function u150:_setTimestamp(a2) -- Line: 446 -- types: self: table, a2: number
    self._lastTimestamp = a2
end

local u554 = {}
u554.__index = u554
u554.TimeUnit = {
    Milliseconds = 0,
    Seconds = 1,
    Minutes = 2,
    Hours = 3,
    Days = 4,
    Weeks = 5,
    Months = 6,
    Years = 7,
}
u554.Level = u86
u554.LevelNames = {}
for k, v in pairs(u554.Level) do
    u554.LevelNames[v] = k
end

function u554.new(a1) -- Line: 648 -- upvalues: t (val), u554 (val) -- types: a1: table?
    t.strict(t.optional(t.table))(a1)
    local v1 = setmetatable({}, u554)
    v1._name = (debug.info(2, "s")):match("([^%.]-)$")
    v1._muted = false
    v1._stats = {}
    v1._settings = a1 or {}
    return v1
end

function u554.getLevelFromName(a1) -- Line: 660 -- upvalues: t (val), u554 (val) -- types: a1: string
    t.strict(t.string)(a1)
    return assert(u554.Level[a1], (("Invalid log level: \"%*\""):format(a1)))
end

function u554.isWithinLevel(a1) -- Line: 665 -- upvalues: u554 (val), u545 (ref) -- types: a1: string
    local v1 = u554.getLevelFromName(a1)
    return u545 <= v1, u545
end

function u554:_getLogStats(a2) -- Line: 670 -- upvalues: u150 (val)
    local v1 = self._stats[a2]
    if not v1 then
        v1 = u150.new()
        self._stats[a2] = v1
    end
    return v1
end

function u554:_at(a2) -- Line: 679 -- upvalues: u545 (ref), u143 (val), u554 (val), u120 (val)
    local v1, v2 = debug.info(3, "lf")
    local v3 = debug.traceback("Log", 3)
    local v4 = (tostring(v1)) .. tostring(v2)
    local _limitUnder = self._limitUnder or u545
    if a2 < _limitUnder then
        return (u143.new(self, u554.LevelNames[a2], v3, v4))
    end
    return u120.new(self, u554.LevelNames[a2], v3, v4, self._muted)
end

function u554.Mute(a1) -- Line: 691
    a1._muted = true
    return a1
end

function u554.UnMute(a1) -- Line: 696
    a1._muted = false
    return a1
end

function u554.LimitUnderLevel(a1, a2) -- Line: 701 -- upvalues: u554 (val) -- types: a1: table, a2: string
    a1._limitUnder = u554.getLevelFromName(a2)
    return a1
end

function u554.At(a1, a2) -- Line: 710
    return a1:_at(a2)
end

function u554.AtTrace(a1) -- Line: 716 -- upvalues: u554 (val)
    return a1:_at(u554.Level.Trace)
end

function u554.AtDebug(a1) -- Line: 722 -- upvalues: u554 (val)
    return a1:_at(u554.Level.Debug)
end

function u554.AtInfo(a1) -- Line: 728 -- upvalues: u554 (val)
    return a1:_at(u554.Level.Info)
end

function u554.AtWarning(a1) -- Line: 734 -- upvalues: u554 (val)
    return a1:_at(u554.Level.Warning)
end

function u554.AtError(a1) -- Line: 740 -- upvalues: u554 (val)
    return a1:_at(u554.Level.Error)
end

function u554.AtFatal(a1) -- Line: 746 -- upvalues: u554 (val)
    return a1:_at(u554.Level.Fatal)
end

function u554.Assert(a1, a2, ...) -- Line: 755 -- upvalues: u554 (val)
    if not a2 then
        a1:_at(u554.Level.Error):Throw():Log(...)
    end
end

function u554.Destroy(a1) end

function u554.__tostring(a1) -- Line: 763
    return ("Log<%s>"):format(a1._name)
end

local function SetLogLevel(a1) -- Line: 767
    -- upvalues: u554 (val), u535 (val), u452 (val), u545 (ref)
    local v1, v2
    local v3 = a1:lower()
    for k, v in pairs(u554.Level) do
        if k:lower() == v3 then
            if u535 then
                v1 = if not u452 then "LogLevelClient" else "LogLevel"
                v2 = (v3:sub(1, 1):upper()) .. v3:sub(2)
                if tostring((workspace:GetAttribute(v1)) or "") ~= v2 then
                    workspace:SetAttribute(v1, v2)
                end
            end
            u545 = v
            return
        end
    end
    error("Unknown log level: " .. tostring(a1))
end

local v3 = type(v2)
local v4 = true
if v3 ~= "table" then
    v4 = v3 == "string"
end
assert(v4, "LogConfig must return a table or a string; got " .. v3)
if v3 == "string" then
    SetLogLevel(v2)
else
    local Client_2, Server_2, v5, v6, v7, v8, v9, v10, v11, v12, v13
    if not u535 then
        v5 = nil
        v4 = 0
        v6 = false
        v7 = nil
        for k2, i in pairs(v2) do
            if k2 ~= "Studio" then
                if type(i) == "string" then
                    v5 = i
                    v4 = v4 + 1
                elseif type(i) ~= "table" then
                    v8 = warn
                    v10 = typeof(i)
                    v8(("LogConfig.%s must be a table or a string; got %s"):format(k2, v10))
                else
                    v9 = false
                    if type(i.PlaceId) == "number" then
                        v8 = i.PlaceId == game.PlaceId
                    elseif type(i.PlaceIds) == "table" then
                        v8 = table.find(i.PlaceIds, game.PlaceId) ~= nil
                    elseif type(i.GameId) == "number" then
                        v8 = i.GameId == game.GameId
                    elseif type(i.GameIds) ~= "table" then
                        v8 = true
                        v9 = true
                    else
                        v8 = table.find(i.GameIds, game.GameId) ~= nil
                    end
                    if not v9 then
                        assert(not v6, (("More than one LogConfig mapping matched (%s and %s)"):format(v7 or "", k2 or "")))
                    end
                    if v8 then
                        if not u452 then
                            Client_2 = i.Client
                            v13 = type(Client_2)
                            v11 = ("LogConfig.%s.Client must be a string; got %s"):format(k2, v13)
                            assert(type(Client_2) == "string", v11)
                            SetLogLevel(Client_2)
                        else
                            Server_2 = i.Server
                            v12 = type(Server_2)
                            v10 = ("LogConfig.%s.Server must be a string; got %s"):format(k2, v12)
                            assert(type(Server_2) == "string", v10)
                            SetLogLevel(Server_2)
                        end
                        v6 = true
                    end
                end
            end
        end
        if v4 > 1 then
            warn("Ambiguous default logging level")
        end
        if v5 and not v6 then
            SetLogLevel(v5)
        end
    elseif not v2.Studio then
        v5 = nil
        v4 = 0
        v6 = false
        v7 = nil
        for k3, j in pairs(v2) do
            if k3 ~= "Studio" then
                if type(j) == "string" then
                    v5 = j
                    v4 = v4 + 1
                elseif type(j) ~= "table" then
                    v8 = warn
                    v10 = typeof(j)
                    v8(("LogConfig.%s must be a table or a string; got %s"):format(k3, v10))
                else
                    v9 = false
                    if type(j.PlaceId) == "number" then
                        v8 = j.PlaceId == game.PlaceId
                    elseif type(j.PlaceIds) == "table" then
                        v8 = table.find(j.PlaceIds, game.PlaceId) ~= nil
                    elseif type(j.GameId) == "number" then
                        v8 = j.GameId == game.GameId
                    elseif type(j.GameIds) ~= "table" then
                        v8 = true
                        v9 = true
                    else
                        v8 = table.find(j.GameIds, game.GameId) ~= nil
                    end
                    if not v9 then
                        assert(not v6, (("More than one LogConfig mapping matched (%s and %s)"):format(v7 or "", k3 or "")))
                    end
                    if v8 then
                        if not u452 then
                            Client_2 = j.Client
                            v13 = type(Client_2)
                            v11 = ("LogConfig.%s.Client must be a string; got %s"):format(k3, v13)
                            assert(type(Client_2) == "string", v11)
                            SetLogLevel(Client_2)
                        else
                            Server_2 = j.Server
                            v12 = type(Server_2)
                            v10 = ("LogConfig.%s.Server must be a string; got %s"):format(k3, v12)
                            assert(type(Server_2) == "string", v10)
                            SetLogLevel(Server_2)
                        end
                        v6 = true
                    end
                end
            end
        end
        if v4 > 1 then
            warn("Ambiguous default logging level")
        end
        if v5 and not v6 then
            SetLogLevel(v5)
        end
    else
        v5 = type(v2.Studio)
        v6 = true
        if v5 ~= "table" then
            v6 = v5 == "string"
        end
        assert(v6, "LogConfig.Studio must be a table or a string; got " .. v5)
        if v5 == "string" then
            SetLogLevel(v2.Studio)
        else
            local v14
            if not u452 then
                local Client = v2.Studio.Client
                v14 = "LogConfig.Studio.Client must be a string; got " .. (type(Client))
                assert(type(Client) == "string", v14)
                SetLogLevel(Client)
            else
                local Server = v2.Studio.Server
                v14 = "LogConfig.Studio.Server must be a string; got " .. (type(Server))
                assert(type(Server) == "string", v14)
                SetLogLevel(Server)
            end
        end
    end
end
assert(type(u545) == "number", "LogLevel failed to be determined")
if u535 then
    local u339 = if not u452 then "LogLevelClient" else "LogLevel"
    ;(workspace:GetAttributeChangedSignal(u339)):Connect(function() -- Line: 895 -- upvalues: SetLogLevel (val), u339 (val)
        SetLogLevel(workspace:GetAttribute(u339))
    end)
end
return u554