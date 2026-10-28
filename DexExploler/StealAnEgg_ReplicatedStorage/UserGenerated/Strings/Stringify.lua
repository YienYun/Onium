-- Script path: ReplicatedStorage.UserGenerated.Strings.Stringify
-- Decompile time: 20.52 ms

local u0 = {Pretty = true, IndentChar = " ", IndentSize = 2}

local function isInt(a1) -- Line: 68 -- types: a1: number
    return (math.abs(a1 - (math.round(a1)))) < 1e-06
end

local function roundTo(a1, a2) -- Line: 72 -- types: a1: number, a2: number
    return math.round(a1 * a2) / a2
end

local function formatNum(a1, a2) -- Line: 76 -- types: a1: number, a2: number
    local v1 = 10 ^ a2
    local v2 = math.round(a1 * v1) / v1
    if v2 == 0 and a1 ~= 0 then
        return (tostring(a1))
    end
    local v3 = (string.format("%." .. a2 .. "f", v2)):gsub("%.?0+$", "")
    if v3 ~= "" and v3 ~= "-" then
        return v3
    end
    return "0"
end

local function isValidId(a1) -- Line: 86 -- types: a1: string
    return a1:match("^[a-zA-Z_][a-zA-Z0-9_]*$") == a1
end

local function makeIndent(a1, a2, a3) -- Line: 90 -- types: a1: string, a2: number, a3: number
    return string.rep(a1, a2 * a3)
end

local u6 = {}

local function serialize(a1, a2) -- Line: 100 -- upvalues: u6 (val) -- types: a2: table
    local v1 = u6[typeof(a1)]
    if not v1 then
        return (("[%*]"):format((typeof(a1))))
    end
    return v1(a1, a2)
end

u6["nil"] = function(a1, a2) -- Line: 113 -- types: a1: nil
    return "nil"
end

function u6.boolean(a1, a2) -- Line: 117 -- types: a1: boolean
    if a1 then
        return "true"
    end
    return "false"
end

function u6.number(a1, a2) -- Line: 121 -- types: a1: number, a2: table
    local v1
    if a1 == (1 / 0) then
        return "math.huge"
    end
    if a1 == (-1 / 0) then
        return "-math.huge"
    end
    if a1 ~= a1 then
        return "0/0"
    end
    if not a2.cfg.Pretty then
        v1 = tostring(a1)
    else
        local v2 = math.round(a1 * 1000000) / 1000000
        if v2 ~= 0 or a1 == 0 then
            local v3 = (string.format("%." .. 6 .. "f", v2)):gsub("%.?0+$", "")
            v1 = if v3 == "" then "0" else if v3 ~= "-" then v3 else "0"
        else
            v1 = tostring(a1)
        end
        if not v1 then
            v1 = tostring(a1)
        end
    end
    return v1
end

function u6.string(a1, a2) -- Line: 134 -- types: a1: string
    return string.format("%q", a1)
end

u6["function"] = function(a1) -- Line: 138 -- types: a1: function
    return "[function]"
end

function u6.Instance(a1) -- Line: 142 -- types: a1: userdata
    if a1.Parent then
        return (("[%* %*]"):format(a1.ClassName, (a1:GetFullName())))
    end
    return (("[%*]"):format(a1.ClassName))
end

function u6.table(a1, a2) -- Line: 153 -- upvalues: u6 (val) -- types: a1: table, a2: table
    local v1
    local v2 = getmetatable(a1)
    if v2 and v2.__tostring then
        return (tostring(a1)):gsub("\n", "\n" .. (string.rep(a2.cfg.IndentChar, a2.cfg.IndentSize * a2.depth)))
    end
    if a2.seen[a1] then
        return "{...}"
    end
    a2.seen[a1] = true
    v2 = {}
    local v3 = 0
    local v4, v5 = a1, a2
    for k in pairs(a1) do
        if typeof(k) == "number" then
            v1 = math.round(k)
            if (math.abs(k - v1)) < 1e-06 and k > 0 then
                v3 = math.max(v3, k)
            end
        end
        table.insert(v2, k)
    end
    local v6 = false
    if #v2 == v3 then
        v6 = #v2 > 0
    end
    for i = 1, v3 do
        if v4[i] == nil then
            v6 = false
            break
        end
    end
    v5.depth = v5.depth + 1
    local Pretty = v5.cfg.Pretty
    local v7 = Pretty and "\n" .. string.rep(v5.cfg.IndentChar, v5.cfg.IndentSize * v5.depth) or ""
    local v8 = Pretty and ",\n" .. string.rep(v5.cfg.IndentChar, v5.cfg.IndentSize * v5.depth) or ","
    local v9 = {}
    if not v6 then
        local Child, order_2, v10, v11, v12, v13, v14
        local order = v5.order
        local u168 = {}
        for i2, v in ipairs(v2) do
            u168[v] = i2
        end
        local v15 = {}
        for i3, j in ipairs(v2) do
            table.insert(v15, {j, v4[j]})
        end
        if order then
            table.sort(v15, function(a1, a2) -- Line: 205 -- upvalues: order (val), u168 (val)
                local v1
                local Index = order[a1[1]] and order[a1[1]].Index or (1 / 0)
                local Index_2 = order[a2[1]] and order[a2[1]].Index or (1 / 0)
                if Index == Index_2 then
                    v1 = u168[a1[1]] < u168[a2[1]]
                else
                    v1 = true
                    if not (Index < Index_2) then
                        v1 = u168[a1[1]] < u168[a2[1]]
                    end
                end
                return v1
            end)
        end
        for i4, k2 in ipairs(v15) do
            v10 = k2[1]
            v11 = k2[2]
            Child = order and order[v10] and order[v10].Child or nil
            order_2 = v5.order
            v5.order = Child
            if typeof(v10) ~= "string" or not (v10:match("^[a-zA-Z_][a-zA-Z0-9_]*$") == v10) then
                v14 = u6[typeof(v10)]
                v12 = ("[%*]"):format(if v14 then v14(v10, v5) else ("[%*]"):format((typeof(v10))))
            else
                v12 = v10
                if not v12 then
                    v14 = u6[typeof(v10)]
                    v12 = ("[%*]"):format(if v14 then v14(v10, v5) else ("[%*]"):format((typeof(v10))))
                end
            end
            v13 = u6[typeof(v11)]
            v10 = if v13 then v13(v11, v5) else ("[%*]"):format((typeof(v11)))
            table.insert(v9, Pretty and ("%* = %*"):format(v12, v10) or ("%*=%*"):format(v12, v10))
            v5.order = order_2
        end
    else
        local v16, v17
        for n = 1, v3 do
            v16 = v4[n]
            v17 = u6[typeof(v16)]
            v1 = if v17 then v17(v16, v5) else ("[%*]"):format((typeof(v16)))
            v9[n] = v1
        end
    end
    v5.depth = v5.depth - 1
    v5.seen[v4] = nil
    if #v9 == 0 then
        return "{}"
    end
    if not Pretty then
        return "{" .. (table.concat(v9, v8)) .. "}"
    end
    v6 = "\n" .. string.rep(v5.cfg.IndentChar, v5.cfg.IndentSize * v5.depth)
    return "{" .. v7 .. (table.concat(v9, v8)) .. "," .. v6 .. "}"
end

function u6.Color3(a1, a2) -- Line: 243 -- upvalues: u6 (val) -- types: a1: CFrame, a2: table
    local B, G, R, v1, v2, v3, v4, v5
    local v6 = a1.R * 255
    local v7 = a1.G * 255
    local v8 = a1.B * 255
    local v9 = "fromRGB"
    if not ((math.abs(v6 - (math.round(v6)))) < 1e-06) or not ((math.abs(v7 - (math.round(v7)))) < 1e-06) then
        R = a1.R
        G = a1.G
        B = a1.B
        v9 = "new"
    elseif (math.abs(v8 - (math.round(v8)))) < 1e-06 then
        R = math.round(v6)
        G = math.round(v7)
        B = math.round(v8)
    else
        R = a1.R
        G = a1.G
        B = a1.B
        v9 = "new"
    end
    if a2.cfg.Pretty then
        v2 = u6[typeof(R)]
        v5 = if v2 then v2(R, a2) else ("[%*]"):format((typeof(R)))
        v3 = u6[typeof(G)]
        v1 = if v3 then v3(G, a2) else ("[%*]"):format((typeof(G)))
        v4 = u6[typeof(B)]
        return (("Color3.%*(%*, %*, %*)"):format(v9, v5, v1, if v4 then v4(B, a2) else ("[%*]"):format((typeof(B)))))
    end
    v2 = u6[typeof(R)]
    v5 = if v2 then v2(R, a2) else ("[%*]"):format((typeof(R)))
    v3 = u6[typeof(G)]
    v1 = if v3 then v3(G, a2) else ("[%*]"):format((typeof(G)))
    v4 = u6[typeof(B)]
    return (("Color3.%*(%*,%*,%*)"):format(v9, v5, v1, if v4 then v4(B, a2) else ("[%*]"):format((typeof(B)))))
end

function u6.Vector3(a1, a2) -- Line: 257 -- upvalues: u6 (val) -- types: a1: vector, a2: table
    local v1, v2, v3, v4, v5
    if a1 == Vector3.new(0, 0, 0) then
        return "Vector3.zero"
    end
    if a1 == Vector3.new(1, 1, 1) then
        return "Vector3.one"
    end
    if a1 == Vector3.new(1, 0, 0) then
        return "Vector3.xAxis"
    end
    if a1 == Vector3.new(0, 1, 0) then
        return "Vector3.yAxis"
    end
    if a1 == Vector3.new(0, 0, 1) then
        return "Vector3.zAxis"
    end
    if a2.cfg.Pretty then
        local X = a1.X
        v3 = u6[typeof(X)]
        v1 = if v3 then v3(X, a2) else ("[%*]"):format((typeof(X)))
        local Y = a1.Y
        v4 = u6[typeof(Y)]
        v2 = if v4 then v4(Y, a2) else ("[%*]"):format((typeof(Y)))
        local Z = a1.Z
        v5 = u6[typeof(Z)]
        return (("Vector3.new(%*, %*, %*)"):format(v1, v2, if v5 then v5(Z, a2) else ("[%*]"):format((typeof(Z)))))
    end
    local X_2 = a1.X
    v3 = u6[typeof(X_2)]
    v1 = if v3 then v3(X_2, a2) else ("[%*]"):format((typeof(X_2)))
    local Y_2 = a1.Y
    v4 = u6[typeof(Y_2)]
    v2 = if v4 then v4(Y_2, a2) else ("[%*]"):format((typeof(Y_2)))
    local Z_2 = a1.Z
    v5 = u6[typeof(Z_2)]
    return (("Vector3.new(%*,%*,%*)"):format(v1, v2, if v5 then v5(Z_2, a2) else ("[%*]"):format((typeof(Z_2)))))
end

function u6.Vector2(a1, a2) -- Line: 279 -- upvalues: u6 (val) -- types: a1: userdata, a2: table
    local v1, v2, v3
    if a1 == Vector2.zero then
        return "Vector2.zero"
    end
    if a1 == Vector2.one then
        return "Vector2.one"
    end
    if a1 == Vector2.xAxis then
        return "Vector2.xAxis"
    end
    if a1 == Vector2.yAxis then
        return "Vector2.yAxis"
    end
    if a2.cfg.Pretty then
        local X = a1.X
        v2 = u6[typeof(X)]
        v1 = if v2 then v2(X, a2) else ("[%*]"):format((typeof(X)))
        local Y = a1.Y
        v3 = u6[typeof(Y)]
        return (("Vector2.new(%*, %*)"):format(v1, if v3 then v3(Y, a2) else ("[%*]"):format((typeof(Y)))))
    end
    local X_2 = a1.X
    v2 = u6[typeof(X_2)]
    v1 = if v2 then v2(X_2, a2) else ("[%*]"):format((typeof(X_2)))
    local Y_2 = a1.Y
    v3 = u6[typeof(Y_2)]
    return (("Vector2.new(%*,%*)"):format(v1, if v3 then v3(Y_2, a2) else ("[%*]"):format((typeof(Y_2)))))
end

function u6.CFrame(a1, a2) -- Line: 298 -- upvalues: u6 (val) -- types: a1: Vector2, a2: table
    local Components_10, Components_11, Components_12, Components_4, Components_5, Components_6, Components_7, Components_8, Components_9, X_2, Y_2, Z_2, v1, v2, v3, v4, v5, v6, v7, v8, v9
    if a1 == CFrame.identity then
        return "CFrame.identity"
    end
    local Position = a1.Position
    local v10, v11, v12 = a1:ToOrientation()
    local Magnitude = Position.Magnitude
    _, _, _, Components_4, Components_5, Components_6, Components_7, Components_8, Components_9, Components_10, Components_11, Components_12 = a1:GetComponents()
    local v13 = true
    if not (1e-06 < (math.abs(Components_4 - 1))) then
        v13 = true
        if not (1e-06 < (math.abs(Components_8 - 1))) then
            v13 = true
            if not (1e-06 < (math.abs(Components_12 - 1))) then
                v13 = true
                if not (1e-06 < (math.abs(Components_5))) then
                    v13 = true
                    if not (1e-06 < (math.abs(Components_6))) then
                        v13 = true
                        if not (1e-06 < (math.abs(Components_7))) then
                            v13 = true
                            if not (1e-06 < (math.abs(Components_9))) then
                                v13 = true
                                if not (1e-06 < (math.abs(Components_10))) then
                                    v13 = 1e-06 < (math.abs(Components_11))
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    local v14 = Magnitude > 1e-06
    local Pretty = a2.cfg.Pretty
    if not Pretty then
        X_2 = Position.X
        v3 = u6[typeof(X_2)]
        Y_2 = Position.Y
        v2 = u6[typeof(Y_2)]
        v6 = if v2 then v2(Y_2, a2) else ("[%*]"):format((typeof(Y_2)))
        Z_2 = Position.Z
        v1 = u6[typeof(Z_2)]
        v7 = if v1 then v1(Z_2, a2) else ("[%*]"):format((typeof(Z_2)))
        v4 = ("CFrame.new(%*,%*,%*)"):format(if v3 then v3(X_2, a2) else ("[%*]"):format((typeof(X_2))), v6, v7)
    else
        v6 = math.round(Position.X * 1000000) / 1000000
        local v15 = u6[typeof(v6)]
        v5 = if v15 then v15(v6, a2) else ("[%*]"):format((typeof(v6)))
        v7 = math.round(Position.Y * 1000000) / 1000000
        local v16 = u6[typeof(v7)]
        v6 = if v16 then v16(v7, a2) else ("[%*]"):format((typeof(v7)))
        v8 = math.round(Position.Z * 1000000) / 1000000
        local v17 = u6[typeof(v8)]
        v4 = ("CFrame.new(%*, %*, %*)"):format(v5, v6, if v17 then v17(v8, a2) else ("[%*]"):format((typeof(v8))))
        if not v4 then
            X_2 = Position.X
            v3 = u6[typeof(X_2)]
            Y_2 = Position.Y
            v2 = u6[typeof(Y_2)]
            v6 = if v2 then v2(Y_2, a2) else ("[%*]"):format((typeof(Y_2)))
            Z_2 = Position.Z
            v1 = u6[typeof(Z_2)]
            v7 = if v1 then v1(Z_2, a2) else ("[%*]"):format((typeof(Z_2)))
            v4 = ("CFrame.new(%*,%*,%*)"):format(if v3 then v3(X_2, a2) else ("[%*]"):format((typeof(X_2))), v6, v7)
        end
    end
    if not Pretty then
        v6 = u6[typeof(v10)]
        v5 = if v6 then v6(v10, a2) else ("[%*]"):format((typeof(v10)))
        v7 = u6[typeof(v11)]
        v6 = if v7 then v7(v11, a2) else ("[%*]"):format((typeof(v11)))
        v8 = u6[typeof(v12)]
        v9 = ("CFrame.fromOrientation(%*,%*,%*)"):format(v5, v6, if v8 then v8(v12, a2) else ("[%*]"):format((typeof(v12))))
    else
        v6 = math.round((math.deg(v10)) * 1000000) / 1000000
        local v18 = u6[typeof(v6)]
        v5 = if v18 then v18(v6, a2) else ("[%*]"):format((typeof(v6)))
        v7 = math.round((math.deg(v11)) * 1000000) / 1000000
        local v19 = u6[typeof(v7)]
        v6 = if v19 then v19(v7, a2) else ("[%*]"):format((typeof(v7)))
        v8 = math.round((math.deg(v12)) * 1000000) / 1000000
        local v20 = u6[typeof(v8)]
        v9 = ("CFrame.fromOrientation(math.rad(%*), math.rad(%*), math.rad(%*))"):format(
            v5,
            v6,
            if v20 then v20(v8, a2) else ("[%*]"):format((typeof(v8)))
        )
        if not v9 then
            v6 = u6[typeof(v10)]
            v5 = if v6 then v6(v10, a2) else ("[%*]"):format((typeof(v10)))
            v7 = u6[typeof(v11)]
            v6 = if v7 then v7(v11, a2) else ("[%*]"):format((typeof(v11)))
            v8 = u6[typeof(v12)]
            v9 = ("CFrame.fromOrientation(%*,%*,%*)"):format(v5, v6, if v8 then v8(v12, a2) else ("[%*]"):format((typeof(v12))))
        end
    end
    if not v14 then
        return v9
    end
    return v13 and v4 .. (if not Pretty then "*" else " * ") .. v9 or v4
end

function u6.EnumItem(a1, a2) -- Line: 341 -- types: a1: userdata
    return (("Enum.%*.%*"):format(tostring(a1.EnumType), a1.Name))
end

local u20 = {DEFAULT_CONFIG = u0}

function u20.Pretty(a1, a2) -- Line: 353 -- upvalues: u0 (val), serialize (val) -- types: a2: table?
    local v1 = {}
    local Pretty = a2 and a2.Pretty or u0.Pretty
    v1.Pretty = Pretty
    local IndentChar = a2 and a2.IndentChar or u0.IndentChar
    v1.IndentChar = IndentChar
    local IndentSize = a2 and a2.IndentSize or u0.IndentSize
    v1.IndentSize = IndentSize
    local Order = a2 and a2.Order or u0.Order
    v1.Order = Order
    return serialize(a1, {depth = 0, cfg = v1, order = v1.Order, seen = {}})
end

function u20.Serialize(a1, a2) -- Line: 369 -- upvalues: serialize (val) -- types: a2: table
    return serialize(a1, {depth = 0, cfg = a2, order = a2.Order, seen = {}})
end

function u20.Default(a1) -- Line: 378 -- upvalues: u0 (val), serialize (val)
    local v1 = u0
    return serialize(a1, {depth = 0, cfg = v1, order = v1.Order, seen = {}})
end

function u20.DefaultArgs(...) -- Line: 388 -- upvalues: u20 (val)
    local v1 = table.pack(...)
    local v2 = {}
    local n = v1.n
    for i = 1, n do
        if i > 1 then
            table.insert(v2, ", ")
        end
        table.insert(v2, (u20.Default(v1[i])))
    end
    return table.concat(v2)
end

function u20.DefaultArgsPrefix(...) -- Line: 400 -- upvalues: u20 (val)
    local v1 = table.pack(...)
    local v2 = {}
    local n = v1.n
    for i = 1, n do
        table.insert(v2, ", ")
        table.insert(v2, (u20.Default(v1[i])))
    end
    return table.concat(v2)
end

function u20.CompileOrder(a1) -- Line: 410 -- upvalues: u20 (val) -- types: a1: table
    local Key
    assert(type(a1) == "table")
    local v1 = true
    if #a1 == 0 then
        v1 = next(a1) == nil
    end
    assert(v1)
    local v2 = {}
    for i, v in ipairs(a1) do
        if type(v) ~= "table" then
            v2[v] = {Index = i}
        else
            Key = v.Key
            assert(type(Key) == "string")
            v2[Key] = {Index = i, Child = u20.CompileOrder(v.Value)}
        end
    end
    return v2
end

return table.freeze(u20)