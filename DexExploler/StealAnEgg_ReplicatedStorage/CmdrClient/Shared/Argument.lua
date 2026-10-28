-- Script path: ReplicatedStorage.CmdrClient.Shared.Argument
-- Decompile time: 8.31 ms

local Util = require(script.Parent.Util)

local function unescapeOperators(a1) -- Line: 3
    local v1 = ipairs
    local v2 = a1
    for i, v in v1({"%.", "%?", "%*", "%*%*"}) do
        v2 = v2:gsub("\\" .. v, (v:gsub("%%", "")))
    end
    return v2
end

local u6 = {}
u6.__index = u6

function u6.new(a1, a2, a3) -- Line: 15 -- upvalues: Util (val), u6 (val)
    local v1 = {
        Prefix = "",
        TextSegmentInProgress = "",
        RawSegmentsAreAutocomplete = false,
        Command = a1,
        Name = a2.Name,
        Object = a2,
    }
    local v2 = false
    if a2.Default == nil then
        v2 = a2.Optional ~= true
    end
    v1.Required = v2
    v1.Executor = a1.Executor
    v1.RawValue = a3
    v1.RawSegments = {}
    v1.TransformedValues = {}
    if type(a2.Type) ~= "table" then
        local v3, v4
        v2, v3, v4 = Util.ParsePrefixedUnionType(a1.Cmdr.Registry:GetTypeName(a2.Type), a3)
        v1.Type = a1.Dispatcher.Registry:GetType(v2)
        v1.RawValue = v3
        v1.Prefix = v4
        if v1.Type == nil then
            error(string.format("%s has an unregistered type %q", v1.Name or "<none>", v2 or "<none>"))
        end
    else
        v1.Type = a2.Type
    end
    setmetatable(v1, u6)
    v1:Transform()
    return v1
end

function u6:GetDefaultAutocomplete() -- Line: 55
    if not self.Type.Autocomplete then
        return {}
    end
    local v1, v2 = self.Type.Autocomplete(self:TransformSegment(""))
    return v1, v2 or {}
end

function u6:Transform() -- Line: 67 -- upvalues: unescapeOperators (val), Util (val)
    local v1
    if #self.TransformedValues ~= 0 then
        return
    end
    local RawValue = self.RawValue
    if self.Type.ArgumentOperatorAliases then
        RawValue = self.Type.ArgumentOperatorAliases[RawValue] or RawValue
    end
    if RawValue == "." and self.Type.Default then
        RawValue = self.Type.Default(self.Executor) or ""
        self.RawSegmentsAreAutocomplete = true
    end
    if RawValue == "?" and self.Type.Autocomplete then
        local DefaultAutocomplete, DefaultAutocomplete_2 = self:GetDefaultAutocomplete()
        if not DefaultAutocomplete_2.IsPartial and #DefaultAutocomplete > 0 then
            RawValue = DefaultAutocomplete[math.random(1, #DefaultAutocomplete)]
            self.RawSegmentsAreAutocomplete = true
        end
    end
    if self.Type.Listable then
        local v2 = #self.RawValue
        if v2 > 0 then
            local TransformedValues, v3
            v2 = RawValue:match("^%?(%d+)$")
            if v2 then
                local v4 = tonumber(v2)
                if v4 and v4 > 0 then
                    local v5 = {}
                    local DefaultAutocomplete_3, DefaultAutocomplete_4 = self:GetDefaultAutocomplete()
                    if not DefaultAutocomplete_4.IsPartial and #DefaultAutocomplete_3 > 0 then
                        for j = 1, (math.min(v4, #DefaultAutocomplete_3)) do
                            table.insert(v5, (table.remove(DefaultAutocomplete_3, (math.random(1, #DefaultAutocomplete_3)))))
                        end
                        RawValue = table.concat(v5, ",")
                        self.RawSegmentsAreAutocomplete = true
                    end
                end
            else
                local DefaultAutocomplete_5, DefaultAutocomplete_6, v6
                if RawValue == "*" then
                    DefaultAutocomplete_5, DefaultAutocomplete_6 = self:GetDefaultAutocomplete()
                    if not DefaultAutocomplete_6.IsPartial and #DefaultAutocomplete_5 > 0 then
                        if RawValue == "**" and self.Type.Default then
                            v6 = self.Type.Default(self.Executor) or ""
                            for i, v in ipairs(DefaultAutocomplete_5) do
                                if v == v6 then
                                    table.remove(DefaultAutocomplete_5, i)
                                end
                            end
                        end
                        RawValue = table.concat(DefaultAutocomplete_5, ",")
                        self.RawSegmentsAreAutocomplete = true
                    end
                elseif RawValue == "**" then
                    DefaultAutocomplete_5, DefaultAutocomplete_6 = self:GetDefaultAutocomplete()
                    if not DefaultAutocomplete_6.IsPartial and #DefaultAutocomplete_5 > 0 then
                        if RawValue == "**" and self.Type.Default then
                            v6 = self.Type.Default(self.Executor) or ""
                            for i2, i3 in ipairs(DefaultAutocomplete_5) do
                                if i3 == v6 then
                                    table.remove(DefaultAutocomplete_5, i2)
                                end
                            end
                        end
                        RawValue = table.concat(DefaultAutocomplete_5, ",")
                        self.RawSegmentsAreAutocomplete = true
                    end
                end
            end
            v1 = unescapeOperators(RawValue)
            v2 = Util.SplitStringSimple(v1, ",")
            if #v2 == 0 then
                v2 = {""}
            end
            if v1:sub(#v1, #v1) == "," then
                v2[#v2 + 1] = ""
            end
            for i4, k in ipairs(v2) do
                self.RawSegments[i4] = k
                TransformedValues = self.TransformedValues
                v3 = {self:TransformSegment(k)}
                TransformedValues[i4] = v3
            end
            self.TextSegmentInProgress = v2[#v2]
            return
        end
    end
    v1 = unescapeOperators(RawValue)
    self.RawSegments[1] = (unescapeOperators(v1))
    self.TransformedValues[1] = {self:TransformSegment(v1)}
    self.TextSegmentInProgress = self.RawValue
end

function u6:TransformSegment(a2) -- Line: 159
    if self.Type.Transform then
        return self.Type.Transform(a2, self.Executor)
    end
    return a2
end

function u6:GetTransformedValue(a2) -- Line: 168
    return unpack(self.TransformedValues[a2])
end

function u6.Validate(a1, a2) -- Line: 173
    local v1, v2, v3, v4
    if a1.RawValue == nil then
        return true
    end
    if #a1.RawValue == 0 and a1.Required == false then
        return true
    end
    if not a1.Required then
        if not a1.Type.Validate and not a1.Type.ValidateOnce then
            return true
        end
        v2 = #a1.TransformedValues
        v1 = a1
        for j = 1, v2 do
            if v1.Type.Validate then
                v3, v4 = v1.Type.Validate(v1:GetTransformedValue(j))
                if not v3 then
                    return v3, v4 or "Invalid value"
                end
            end
            if v5 and v1.Type.ValidateOnce then
                v3, v4 = v1.Type.ValidateOnce(v1:GetTransformedValue(j))
                if not v3 then
                    return v3, v4
                end
            end
        end
        return true
    end
    if a1.RawSegments[1] ~= nil and #a1.RawSegments[1] ~= 0 then
        if not a1.Type.Validate and not a1.Type.ValidateOnce then
            return true
        end
        v2 = #a1.TransformedValues
        v1 = a1
        for i = 1, v2 do
            if v1.Type.Validate then
                v3, v4 = v1.Type.Validate(v1:GetTransformedValue(i))
                if not v3 then
                    return v3, v4 or "Invalid value"
                end
            end
            if v5 and v1.Type.ValidateOnce then
                v3, v4 = v1.Type.ValidateOnce(v1:GetTransformedValue(i))
                if not v3 then
                    return v3, v4
                end
            end
        end
        return true
    end
    return false, "This argument is required."
end

function u6.GetAutocomplete(a1) -- Line: 208
    if a1.Type.Autocomplete then
        return a1.Type.Autocomplete(a1:GetTransformedValue(#a1.TransformedValues))
    end
    return {}
end

function u6:ParseValue(a2) -- Line: 216
    if self.Type.Parse then
        return self.Type.Parse(self:GetTransformedValue(a2))
    end
    return self:GetTransformedValue(a2)
end

function u6.GetValue(a1) -- Line: 225
    local v1
    if #a1.RawValue == 0 and not a1.Required and a1.Object.Default ~= nil then
        return a1.Object.Default
    end
    if not a1.Type.Listable then
        return a1:ParseValue(1)
    end
    local v2 = {}
    local v3 = #a1.TransformedValues
    local v4 = a1
    for i = 1, v3 do
        v1 = v4:ParseValue(i)
        if type(v1) ~= "table" then
            error(("Listable types must return a table from Parse (%s)"):format(v4.Type.Name))
        end
        for k, v in pairs(v1) do
            v2[v] = true
        end
    end
    v3 = {}
    for k2 in pairs(v2) do
        v3[#v3 + 1] = k2
    end
    return v3
end

return u6