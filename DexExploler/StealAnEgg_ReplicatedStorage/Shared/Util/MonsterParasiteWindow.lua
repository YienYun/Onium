-- Script path: ReplicatedStorage.Shared.Util.MonsterParasiteWindow
-- Decompile time: 1.41 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local MonsterParasiteFlags = require(ReplicatedStorage.Shared.Flags.MonsterParasiteFlags)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Timer = require(ReplicatedStorage.Packages.Timer)
local u22 = {}
u22.Changed = Signal.new()
local u33 = MonsterParasiteFlags.Enabled:Get()
if u33 then
    u33 = os.time() < MonsterParasite.EndsAt
end

function u22.IsActive() -- Line: 27 -- upvalues: u33 (ref)
    return u33
end

function u22.Refresh() -- Line: 31 -- upvalues: MonsterParasiteFlags (val), MonsterParasite (val), u33 (ref), u22 (val)
    local v1 = MonsterParasiteFlags.Enabled:Get() and os.time() < MonsterParasite.EndsAt
    if v1 == u33 then
        return
    end
    u22.Changed:Fire(v1)
end

local v1 = Timer.new(1)
v1.Tick:Connect(u22.Refresh)
v1:Start()
MonsterParasiteFlags.Enabled.Changed:Connect(u22.Refresh)
return (table.freeze(u22))