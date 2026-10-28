-- Script path: ReplicatedStorage.UserGenerated.Lang.Janitor
-- Decompile time: 2.27 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)

local function DestroyThing(a1) -- Line: 57
    if typeof(a1) == "RBXScriptConnection" then
        task.spawn(a1.Disconnect, a1)
        return
    end
    if typeof(a1) == "Instance" then
        if a1:IsA("AnimationTrack") and a1.IsPlaying then
            task.spawn(function() -- Line: 63 -- upvalues: a1 (val)
                a1:Stop(0.05)
                task.delay(0.11666666666666667, function() -- Line: 65 -- upvalues: a1 (upval)
                    a1:Destroy()
                end)
            end)
            return
        end
        task.spawn(a1.Destroy, a1)
        return
    end
    if type(a1) == "thread" then
        pcall(task.cancel, a1)
        return
    end
    if type(a1) == "function" then
        task.spawn(a1)
        return
    end
    if type(a1) == "table" then
        task.spawn(function(a1) -- Line: 77
            if a1.Destroy then
                a1:Destroy()
                return
            end
            if a1.Disconnect then
                a1:Disconnect()
            end
        end, a1)
    end
end

local function Add(a1, a2) -- Line: 103 -- upvalues: DestroyThing (val)
    if a2 ~= nil then
        if typeof(a2) ~= "RBXScriptConnection"
            and typeof(a2) ~= "Instance"
            and type(a2) ~= "thread"
            and type(a2) ~= "function" then
            if type(a2) ~= "table" then
                error((("Unknown thing: %*"):format((typeof(a2)))))
            elseif type(a2.Destroy) ~= "function" and type(a2.Disconnect) ~= "function" then
                error("Unknown thing: table (missing Destroy/Disconnect)")
            end
        end
        if not a1.Destroyed then
            table.insert(a1.Things, a2)
            return a2
        end
        DestroyThing(a2)
    end
    return a2
end

local v1 = {
    Destroy = function(self) -- Line: 87 -- upvalues: DestroyThing (val)
        if self.Destroyed then
            return false
        end
        self.Destroyed = true
        for i, v in ipairs(self.Things) do
            DestroyThing(v)
        end
        self.Destroying:Fire()
        return true
    end,
    IsDestroyed = function(a1) -- Line: 99
        return a1.Destroyed
    end,
    Add = Add,
}
local u18 = table.freeze({__index = v1, __call = Add})
table.freeze(v1)
return table.freeze({
    new = function() -- Line: 144 -- upvalues: Bindable (val), u18 (val)
        return (setmetatable({Destroyed = false, Destroying = Bindable.new(), Things = {}}, u18))
    end,
})