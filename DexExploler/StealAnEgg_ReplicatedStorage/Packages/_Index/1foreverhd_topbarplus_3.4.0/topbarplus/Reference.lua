-- Script path: ReplicatedStorage.Packages._Index.1foreverhd_topbarplus@3.4.0.topbarplus.Reference
-- Decompile time: 0.72 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local u5 = {objectName = "TopbarPlusReference"}

function u5.addToReplicatedStorage() -- Line: 10 -- upvalues: ReplicatedStorage (val), u5 (val)
    if ReplicatedStorage:FindFirstChild(u5.objectName) then
        return false
    end
    local ObjectValue = Instance.new("ObjectValue")
    ObjectValue.Name = u5.objectName
    ObjectValue.Value = script.Parent
    ObjectValue.Parent = ReplicatedStorage
    return ObjectValue
end

function u5.getObject() -- Line: 22 -- upvalues: ReplicatedStorage (val), u5 (val)
    local v1 = ReplicatedStorage:FindFirstChild(u5.objectName)
    if v1 then
        return v1
    end
    return false
end

return u5