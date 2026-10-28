-- Script path: ReplicatedStorage.UserGenerated.DataModel.Reflection
-- Decompile time: 2.56 ms

local ReflectionService = game:GetService("ReflectionService")
local v1 = {}
local u6 = {}
local u7 = {
    Parent = true,
    ClassName = true,
    Name = true,
    ExtentsCFrame = true,
    ExtentsSize = true,
    ResizeIncrement = true,
    ResizeableFaces = true,
    CurrentPhysicalProperties = true,
    Sandboxed = true,
    Capabilities = true,
    PrivateServerId = true,
    PrivateServerOwnerId = true,
    SerializedDefaultAttributes = true,
}
local u8 = {Debug = true}
local success, err = pcall(function() -- Line: 44
    return tostring((SecurityCapabilities.fromCurrent())):split(" | ")
end)
local u15 = if not success then {} else err

local function canRead(a1) -- Line: 50 -- upvalues: u15 (ref)
    if not a1 then
        return true
    end
    local v1 = tostring(a1):split(" | ")
    if v1[1] ~= nil and v1[1] ~= "" then
        for i, j in v1 do
            if not table.find(u15, j) then
                return false
            end
        end
        return true
    end
    return true
end

function v1.getReadProperties(a1) -- Line: 66
    -- upvalues: u6 (val), ReflectionService (val), u7 (val), u8 (val), canRead (val)
    local v1 = u6[a1]
    if v1 then
        return v1
    end
    v1 = {}
    local success, err = pcall(function() -- Line: 73 -- upvalues: ReflectionService (upval), a1 (val)
        return ReflectionService:GetPropertiesOfClass(a1)
    end)
    if success and err then
        local Display, Name, Permits, Type
        local v2 = nil
        local v3 = nil
        for i, j in err, v2, v3 do
            Name = j.Name
            if not u7[Name] then
                Display = j.Display
                if not Display then
                    Type = j.Type
                    if not Type or Type.ScriptType ~= "Instance" then
                        Permits = j.Permits
                        if canRead(Permits and Permits.Read) then
                            table.insert(v1, Name)
                        end
                    end
                elseif not Display.DeprecationMessage or Display.DeprecationMessage == "" then
                    if not Display.Category or not u8[Display.Category] then
                        Type = j.Type
                        if not Type or Type.ScriptType ~= "Instance" then
                            Permits = j.Permits
                            if canRead(Permits and Permits.Read) then
                                table.insert(v1, Name)
                            end
                        end
                    end
                end
            end
        end
    end
    u6[a1] = v1
    return v1
end

return v1