-- Script path: ReplicatedStorage.UserGenerated.Lottie
-- Decompile time: 63.53 ms

local BuildLayers, BuildShapeGroup, RenderLayerNodes
assert(not (game:GetService("RunService"):IsClient()))
local HttpService = game:GetService("HttpService")
local AssetService = game:GetService("AssetService")
local EncodingService = game:GetService("EncodingService")
require(script.Types)
local Easing = require(script.Easing)
local u39 = Rect.new(64, 64, 192, 192)
local u43 = UDim2.fromScale(0, 0)
local u47 = UDim2.fromScale(1, 1)
local u55 = nil
local success, err = pcall(require, script.PNG)
if success then
    u55 = err
end

local function HexToColor3(a1) -- Line: 90 -- types: a1: string
    return Color3.fromRGB(
        tonumber(string.sub(a1, 2, 3), 16) or 0,
        tonumber(string.sub(a1, 4, 5), 16) or 0,
        tonumber(string.sub(a1, 6, 7), 16) or 0
    )
end

local function IsPropertyAnimated(a1) -- Line: 97
    if a1 == nil then
        return false
    end
    return a1.a == 1
end

local function HasAnimatedOpacity(a1) -- Line: 104
    if a1 == nil then
        return false
    end
    local o = a1.o
    if o == nil then
        return false
    end
    return o.a == 1
end

local function SubdivideCubicBezier(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10) -- Line: 113
    -- upvalues: 
    local v1, v2, v3, v4, v5, v6
    for i = 1, a9 do
        v1 = i / a9
        v2 = 1 - v1
        v3 = v2 * v2
        v4 = v3 * v2
        v5 = v1 * v1
        v6 = v5 * v1
        table.insert(a10, {
            v4 * a1 + v3 * 3 * v1 * a3 + v2 * 3 * v5 * a5 + v6 * a7,
            v4 * a2 + v3 * 3 * v1 * a4 + v2 * 3 * v5 * a6 + v6 * a8,
        })
    end
end

local function BezierShapeToPolyline(a1) -- Line: 139 -- upvalues: SubdivideCubicBezier (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13
    local v = a1.v
    local i = a1.i
    local o = a1.o
    local v14 = #v
    if v14 == 0 then
        return {}
    end
    local v15 = {{v[1][1], v[1][2]}}
    local v16 = if not a1.c then v14 - 1 else v14
    for i2 = 1, v16 do
        v1 = if not (i2 < v14) then 1 else i2 + 1
        v2 = v[i2]
        v3 = v[v1]
        v4 = o[i2]
        v5 = i[v1]
        v6 = v2[1]
        v7 = v2[2]
        v8 = v6 + v4[1]
        v9 = v7 + v4[2]
        v10 = v3[1] + v5[1]
        v11 = v3[2] + v5[2]
        v12 = v3[1]
        v13 = v3[2]
        v3 = false
        if (math.abs(v4[1])) < 0.01 then
            v3 = false
            if (math.abs(v4[2])) < 0.01 then
                v3 = false
                if (math.abs(v5[1])) < 0.01 then
                    v3 = (math.abs(v5[2])) < 0.01
                end
            end
        end
        if not v3 then
            SubdivideCubicBezier(v6, v7, v8, v9, v10, v11, v12, v13, 12, v15)
        else
            table.insert(v15, {v12, v13})
        end
    end
    return v15
end

local function Cross2D(a1, a2, a3, a4, a5, a6) -- Line: 180
    -- upvalues: 
    return (a3 - a1) * (a6 - a2) - (a4 - a2) * (a5 - a1)
end

local function PointInTriangle(a1, a2, a3, a4, a5, a6, a7, a8) -- Line: 184
    -- upvalues: 
    local v1 = (a3 - a1) * (a6 - a2) - (a4 - a2) * (a5 - a1)
    local v2 = (a5 - a1) * (a8 - a2) - (a6 - a2) * (a7 - a1)
    local v3 = (a7 - a1) * (a4 - a2) - (a8 - a2) * (a3 - a1)
    local v4 = true
    if not (v1 < 0) then
        v4 = true
        if not (v2 < 0) then
            v4 = v3 < 0
        end
    end
    local v5 = true
    if not (v1 > 0) then
        v5 = true
        if not (v2 > 0) then
            v5 = v3 > 0
        end
    end
    return not (v4 and v5)
end

local function IsConvexPolygon(a1) -- Line: 202 -- types: a1: table
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    local v11 = #a1
    if v11 < 3 then
        return false
    end
    local v12 = 0
    for i = 1, v11 do
        v7 = if not (i < v11) then 1 else i + 1
        v8 = if not (v7 < v11) then 1 else v7 + 1
        v10 = v1[i][1]
        v2 = v1[i][2]
        v3 = v1[v7][1]
        v4 = v1[v7][2]
        v5 = v1[v8][1]
        v6 = v1[v8][2]
        v9 = (v3 - v10) * (v6 - v2) - (v4 - v2) * (v5 - v10)
        if v9 ~= 0 then
            if v12 ~= 0 then
                if v9 > 0 and v12 < 0 then
                    return false
                end
                if v9 < 0 and v12 > 0 then
                    return false
                end
            else
                v12 = if not (v9 > 0) then -1 else 1
            end
        end
    end
    return true
end

local function TriangulateFan(a1) -- Line: 223 -- types: a1: table
    local v1 = {}
    local v2 = #a1 - 1
    for i = 2, v2 do
        table.insert(v1, {a1[1], a1[i], a1[i + 1]})
    end
    return v1
end

local function TriangulateEarClip(a1) -- Line: 231
    -- upvalues: IsConvexPolygon (val), TriangulateFan (val), PointInTriangle (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
    local v12 = #a1
    if v12 < 3 then
        return {}
    end
    if v12 == 3 then
        return {{a1[1], a1[2], a1[3]}}
    end
    if IsConvexPolygon(a1) then
        return (TriangulateFan(a1))
    end
    local v13 = table.create(v12)
    local v14 = 0
    local v15 = v12
    for i = 1, v15 do
        v13[i] = i
        v14 = v14 + (a1[if not (i < v12) then 1 else i + 1][1] - a1[i][1]) * (a1[v9][2] + a1[i][2])
    end
    if v14 > 0 then
        v15 = table.create(v12)
        for j = 1, v12 do
            v15[j] = v13[v12 - j + 1]
        end
        v13 = v15
    end
    v14 = {}
    v12 = #v13
    v15 = v12 * v12
    local v16 = 0
    local v17 = 1
    while v12 > 2 do
        if not (v16 < v15) then
            break
        end
        v16 = v16 + 1
        if v12 < v17 then
            v17 = 1
        end
        v9 = if not (v17 > 1) then v12 else v17 - 1
        v10 = if not (v17 < v12) then 1 else v17 + 1
        v11 = a1[v13[v9]]
        v1 = a1[v13[v17]]
        v2 = a1[v13[v10]]
        v3 = v11[1]
        v4 = v11[2]
        v5 = v1[1]
        v6 = v1[2]
        v7 = v2[1]
        v8 = v2[2]
        if not (0 < (v5 - v3) * (v8 - v4) - (v6 - v4) * (v7 - v3)) then
            v17 = v17 + 1
        else
            v3 = true
            for k = 1, v12 do
                if k ~= v9
                    and k ~= v17
                    and k ~= v10
                    and PointInTriangle(a1[v13[k]][1], a1[v13[k]][2], v11[1], v11[2], v1[1], v1[2], v2[1], v2[2]) then
                    v3 = false
                    break
                end
            end
            if not v3 then
                v17 = v17 + 1
            else
                table.insert(v14, {v11, v1, v2})
                table.remove(v13, v17)
                v12 = v12 - 1
                if v12 < v17 then end
            end
        end
    end
    return v14
end

local function CreateWedge(a1) -- Line: 317 -- types: a1: userdata
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Image = "rbxassetid://83051256678409"
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Size = UDim2.fromScale(1, 1)
    ImageLabel.Parent = a1
    return ImageLabel
end

local function UpdateTriangle(a1, a2, a3, a4, a5, a6, a7, a8, a9) -- Line: 327
    -- upvalues: 
    local v1 = a4 - a2
    local v2 = a5 - a3
    local v3 = a6 - a2
    local v4 = a7 - a3
    if v1 * v4 - v2 * v3 < 0 then
        v1 = a6 - a2
        v2 = a7 - a3
        v3 = a4 - a2
        v4 = a5 - a3
    end
    local v5 = math.sqrt(v1 * v1 + v2 * v2)
    local v6 = math.sqrt(v3 * v3 + v4 * v4)
    if not (v5 < 1e-06) and not (v6 < 1e-06) then
        local v7 = v1 / v5
        local v8 = v2 / v5
        v6 = v3 * v7 + v4 * v8
        local v9 = v3 - v7 * v6
        local v10 = v4 - v8 * v6
        v4 = math.sqrt(v9 * v9 + v10 * v10)
        if v4 < 1e-06 then
            a1.A.Visible = false
            a1.B.Visible = false
            return
        end
        v10 = math.atan2(v8, v7) * 57.29577951308232
        local A = a1.A
        A.Visible = true
        A.Position = UDim2.fromScale(a2, a3)
        A.Size = UDim2.fromScale(math.max(v6, 0.0001), v4)
        A.Rotation = v10
        A.AnchorPoint = Vector2.zero
        A.ImageColor3 = a8
        A.ImageTransparency = a9
        local B = a1.B
        v3 = v5 - v6
        B.Visible = v3 > 1e-06
        if B.Visible then
            B.Position = UDim2.fromScale(a2 + v7 * v5, a3 + v8 * v5)
            B.Size = UDim2.fromScale(math.max(v3, 0.0001), v4)
            B.Rotation = v10 + 180
            B.AnchorPoint = Vector2.zero
            B.ImageColor3 = a8
            B.ImageTransparency = a9
        end
        return
    end
    a1.A.Visible = false
    a1.B.Visible = false
end

local function CreateTrianglePair(a1) -- Line: 395 -- types: a1: userdata
    local v1 = {}
    local ImageLabel = Instance.new("ImageLabel")
    ImageLabel.Image = "rbxassetid://83051256678409"
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Size = UDim2.fromScale(1, 1)
    ImageLabel.Parent = a1
    v1.A = ImageLabel
    local ImageLabel_2 = Instance.new("ImageLabel")
    ImageLabel_2.Image = "rbxassetid://83051256678409"
    ImageLabel_2.BackgroundTransparency = 1
    ImageLabel_2.BorderSizePixel = 0
    ImageLabel_2.Size = UDim2.fromScale(1, 1)
    ImageLabel_2.Parent = a1
    v1.B = ImageLabel_2
    return v1
end

local function BuildFilledPath(a1, a2, a3, a4, a5, a6, a7) -- Line: 404
    -- upvalues: BezierShapeToPolyline (val), TriangulateEarClip (val), UpdateTriangle (val)
    local ImageLabel, ImageLabel_2, v1
    local v2 = BezierShapeToPolyline(a2)
    if #v2 < 3 then
        return
    end
    local v3 = table.create(#v2)
    for i, j in v2 do
        v1 = {j[1] / a4, j[2] / a5}
        v3[i] = v1
    end
    v2 = TriangulateEarClip(v3)
    local Triangles = a1.Triangles or {}
    local v4 = nil
    local v5 = nil
    local v6, v7 = a1, a3
    for k, n in v2, v4, v5 do
        if not (k <= #Triangles) then
            v1 = {}
            ImageLabel = Instance.new("ImageLabel")
            ImageLabel.Image = "rbxassetid://83051256678409"
            ImageLabel.BackgroundTransparency = 1
            ImageLabel.BorderSizePixel = 0
            ImageLabel.Size = UDim2.fromScale(1, 1)
            ImageLabel.Parent = v7
            v1.A = ImageLabel
            ImageLabel_2 = Instance.new("ImageLabel")
            ImageLabel_2.Image = "rbxassetid://83051256678409"
            ImageLabel_2.BackgroundTransparency = 1
            ImageLabel_2.BorderSizePixel = 0
            ImageLabel_2.Size = UDim2.fromScale(1, 1)
            ImageLabel_2.Parent = v7
            v1.B = ImageLabel_2
            table.insert(Triangles, v1)
        else
            v1 = Triangles[k]
        end
        UpdateTriangle(v1, n[1][1], n[1][2], n[2][1], n[2][2], n[3][1], n[3][2], v8, v9)
    end
    v5 = #v2 + 1
    local v10 = #Triangles
    for m = v5, v10 do
        Triangles[m].A.Visible = false
        Triangles[m].B.Visible = false
    end
    v6.Triangles = Triangles
end

local function BuildStrokedPath(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12) -- Line: 455
    -- upvalues: BezierShapeToPolyline (val), Easing (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    local v13 = BezierShapeToPolyline(a2)
    if #v13 < 2 then
        return
    end
    local Segments = a1.Segments or {}
    local v14 = a10 or 0
    local v15 = a11 or 100
    local v16 = a12 or 0
    local v17 = 0
    local v18 = {0}
    local v19 = #v13
    for i = 2, v19 do
        v2 = v13[i][1] - v13[i - 1][1]
        v3 = v13[i][2] - v13[i - 1][2]
        v17 = v17 + math.sqrt(v2 * v2 + v3 * v3)
        v18[i] = v17
    end
    v19 = nil
    if a9 then
        v1 = {}
        for j, k in a9 do
            if k.v then
                table.insert(v1, (Easing.EvaluateScalar(k.v, 0)))
            end
        end
        if #v1 > 0 then
            v19 = v1
        end
    end
    v1 = 0
    local v20 = a8 / math.min(a4, a5)
    v2 = #v13
    local v21, v22, v23, v24, v25, v26 = a3, a4, a5, a6, a7, a1
    for n = 2, v2 do
        v4 = v13[n - 1]
        v5 = v13[n]
        v6 = v5[1] - v4[1]
        v7 = v5[2] - v4[2]
        v5 = math.sqrt(v6 * v6 + v7 * v7)
        if not (v5 < 0.01) then
            v9 = ((v18[n - 1] + v18[n]) * 0.5 / math.max(v17, 1e-06) * 100 + v16) % 100
            if not (v9 < v14) and not (v15 < v9) then
                v9 = true
                if v19 then
                    v8 = v18[n - 1]
                    v10 = 0
                    v11 = v19
                    v12 = nil
                    for m, i5 in v11, v12 do
                        v10 = v10 + i5
                    end
                    if v10 > 0 then
                        v11 = v8 % v10
                        v12 = 0
                        for i6, i7 in v19 do
                            v12 = v12 + i7
                            if v11 < v12 then
                                v9 = i6 % 2 == 1
                                break
                            end
                        end
                    end
                end
                v1 = v1 + 1
                if not (v1 <= #Segments) then
                    v10 = Instance.new("Frame")
                    v10.BorderSizePixel = 0
                    v10.AnchorPoint = Vector2.new(0, 0.5)
                    v10.Parent = v21
                    table.insert(Segments, v10)
                else
                    v10 = Segments[v1]
                end
                v10.Visible = v9
                if v9 then
                    v11 = math.atan2(v7, v6) * 57.29577951308232
                    v12 = v5 / v22
                    v10.Position = UDim2.fromScale(v4[1] / v22, v4[2] / v23)
                    v10.Size = UDim2.fromScale(v12, v20)
                    v10.Rotation = v11
                    v10.BackgroundColor3 = v24
                    v10.BackgroundTransparency = v25
                end
            end
        end
    end
    local v27 = v1 + 1
    v2 = #Segments
    for i8 = v27, v2 do
        Segments[i8].Visible = false
    end
    v26.Segments = Segments
end

local function BuildLinearGradient(a1, a2, a3, a4, a5) -- Line: 572
    -- upvalues: Easing (val)
    local v1, v2, v3, v4, v5
    local UIGradient = Instance.new("UIGradient")
    local p = a2.p
    local v6 = Easing.EvaluateVector(a2.k, a5, {})
    local v7 = {}
    local v8 = p - 1
    for i = 0, v8 do
        v1 = i * 4
        v2 = v6[v1 + 1]
        if not v2 then
            v4 = p - 1
            v2 = i / math.max(v4, 1)
        end
        v3 = v6[v1 + 2] or 1
        v4 = v6[v1 + 3] or 1
        v5 = v6[v1 + 4]
        table.insert(v7, (ColorSequenceKeypoint.new(math.clamp(v2, 0, 1), (Color3.new(v3, v4, v5 or 1)))))
    end
    if #v7 < 2 then
        v7 = {
            ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
            (ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))),
        }
    end
    UIGradient.Color = ColorSequence.new(v7)
    v6 = Easing.EvaluateVector(a3, a5, {0, 0})
    v7 = Easing.EvaluateVector(a4, a5, {1, 0})
    local v9 = v7[1] - v6[1]
    UIGradient.Rotation = math.atan2(v7[2] - v6[2], v9) * 57.29577951308232
    UIGradient.Parent = a1
    return UIGradient
end

local function BuildRadialGradientApprox(a1, a2, a3, a4, a5, a6, a7) -- Line: 612
    -- upvalues: Easing (val)
    local UICorner, v1, v2, v3, v4
    local p = a2.p
    local v5 = Easing.EvaluateVector(a2.k, a5, {})
    local v6 = Easing.EvaluateVector(a3, a5, {a6 / 2, a7 / 2})
    local v7 = Easing.EvaluateVector(a4, a5, {a6, a7 / 2})
    local v8 = v6[1]
    local v9 = v6[2]
    local v10 = v7[1] - v8
    local v11 = v7[2] - v9
    v7 = math.sqrt(v10 * v10 + v11 * v11)
    v11 = {}
    v10 = math.min(p, 6)
    for i = v10, 1, -1 do
        v6 = i / v10
        v1 = math.min(math.floor(v6 * (p - 1)), p - 1) * 4
        v2 = v5[v1 + 2] or 1
        v3 = v5[v1 + 3] or 1
        v4 = v5[v1 + 4] or 1
        v1 = v7 * 2 * v6
        v6 = Instance.new("Frame")
        v6.AnchorPoint = Vector2.new(0.5, 0.5)
        v6.Position = UDim2.fromScale(v8 / a6, v9 / a7)
        v6.Size = UDim2.fromScale(v1 / a6, v1 / a7)
        v6.BackgroundColor3 = Color3.new(v2, v3, v4)
        v6.BackgroundTransparency = 0
        v6.BorderSizePixel = 0
        UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0.5, 0)
        UICorner.Parent = v6
        v6.Parent = a1
        table.insert(v11, v6)
    end
    return v11
end

local function ApplyTransform(a1, a2, a3, a4, a5, a6, a7, a8) -- Line: 662
    -- upvalues: Easing (val)
    if a2 == nil then
        return
    end
    local v1 = {0, 0}
    local p = a2.p
    if p ~= nil and type(p) == "table" then
        v1 = if p.s ~= true then Easing.EvaluateVector(p, a3, {0, 0}) else {
            Easing.EvaluateScalarAtFrame(p.x, a3, 0),
            (Easing.EvaluateScalarAtFrame(p.y, a3, 0)),
        }
    end
    local v2 = Easing.EvaluateVector(a2.s, a3, {100, 100})
    local v3 = Easing.EvaluateScalarAtFrame(a2.r, a3, 0)
    local v4 = Easing.EvaluateScalarAtFrame(a2.o, a3, 100)
    local v5 = Easing.EvaluateVector(a2.a, a3, {0, 0})
    local v6 = v2[1] / 100
    local v7 = v2[2] / 100
    a1.Position = UDim2.fromScale(v1[1] / a4, v1[2] / a5)
    a1.Rotation = v3
    a1.Size = UDim2.fromScale(a7 * v6, a8 * v7)
    if a6 then
        a1.GroupTransparency = 1 - v4 / 100
    end
    v4 = a7 * v6 * a4
    v6 = a8 * v7 * a5
    if v5[1] ~= 0 then
        if v4 > 0 and v6 > 0 then
            a1.AnchorPoint = Vector2.new(math.clamp(v5[1] / v4, 0, 1), (math.clamp(v5[2] / v6, 0, 1)))
        end
    elseif v5[2] ~= 0 and v4 > 0 and v6 > 0 then
        a1.AnchorPoint = Vector2.new(math.clamp(v5[1] / v4, 0, 1), (math.clamp(v5[2] / v6, 0, 1)))
    end
end

local function CollectShapeInfo(a1) -- Line: 716 -- types: a1: table
    local ty
    local c = nil
    local o = nil
    local c_2 = nil
    local o_2 = nil
    local w = nil
    local ks = nil
    local da = nil
    local s = nil
    local e = nil
    local o_3 = nil
    local m = nil
    local v1 = nil
    local mm = nil
    for i, j in a1 do
        if not j.hd then
            ty = j.ty
            if ty == "fl" then
                c = j.c
                o = j.o
            elseif ty == "st" then
                c_2 = j.c
                o_2 = j.o
                w = j.w
                da = j.da
            elseif ty == "sh" then
                ks = j.ks
            elseif ty == "tr" then
                v1 = j
            elseif ty == "tm" then
                s = j.s
                e = j.e
                o_3 = j.o
                m = j.m
            elseif ty == "mm" then
                mm = j.mm
            end
        end
    end
    return c, o, c_2, o_2, w, ks, da, s, e, o_3, m, v1, mm
end

function BuildShapeGroup(a1, a2, a3, a4, a5) -- Line: 782
    -- upvalues: CollectShapeInfo (val), u47 (val), u43 (val), ApplyTransform (val), Easing (val), BuildFilledPath (val)
    -- upvalues: BuildStrokedPath (val), BuildLinearGradient (val), BuildRadialGradientApprox (val)
    -- upvalues: BuildShapeGroup (val)
    local Frame, Frame_2, Frame_3, UICorner, o, success, tr, ty, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20
    local it = a1.it or {}
    v17, v18, v19, v20, v1, v2, v3, v4, v5, v6, _, v7 = CollectShapeInfo(it)
    local v21 = false
    local v22 = nil
    local v23 = nil
    local v24, v25, v26, v27, v28 = a2, a5, a3, a4, a1
    for i, j in it, v22, v23 do
        if j.ty == "tr" then
            o = j.o
            if if o ~= nil then o.a == 1 else false then
                v21 = true
                break
            end
        end
    end
    local v29 = if not v21 then Instance.new("Frame") else Instance.new("CanvasGroup")
    v29.BackgroundTransparency = 1
    v29.BorderSizePixel = 0
    v29.Size = u47
    v29.Position = u43
    v29.Parent = v24
    if v7 then
        ApplyTransform(v29, {
            a = v7.a,
            p = v7.p,
            s = v7.s,
            r = v7.r,
            o = v7.o,
        }, v25, v26, v27, v21, 1, 1)
    end
    v21 = {}
    v21.Shape = v28
    v21.Frame = v29
    v21.Children = {}
    v21.FillColor = v17
    v21.FillOpacity = v18
    v21.StrokeColor = v19
    v21.StrokeOpacity = v20
    v21.StrokeWidth = v1
    v21.PathData = v2
    v21.IsAnimatedPath = if v2 ~= nil then v2.a == 1 else false
    v7 = Easing.EvaluateColor(v17, v25)
    v18 = 1 - Easing.EvaluateScalarAtFrame(v18, v25, 100) / 100
    v2 = Easing.EvaluateColor(v19, v25)
    v20 = 1 - Easing.EvaluateScalarAtFrame(v20, v25, 100) / 100
    local v30 = Easing.EvaluateScalarAtFrame(v1, v25, 0)
    v1 = Easing.EvaluateScalarAtFrame(v4, v25, 0)
    v4 = Easing.EvaluateScalarAtFrame(v5, v25, 100)
    v5 = Easing.EvaluateScalarAtFrame(v6, v25, 0)
    v6 = 0
    for k, n in it do
        if n.ty == "op" and n.a then
            v6 = Easing.EvaluateScalarAtFrame(n.a, v25, 0)
        end
    end
    v23 = nil
    local v31 = nil
    for m, i5 in it, v23, v31 do
        if not i5.hd then
            ty = i5.ty
            if ty == "sh" then
                v8 = Easing.EvaluateBezierShape(i5.ks, v25)
                if v8 and v6 ~= 0 then
                    v9 = 0
                    v10 = 0
                    for i9, i10 in v8.v do
                        v9 = v9 + i10[1]
                        v10 = v10 + i10[2]
                    end
                    v9 = v9 / #v8.v
                    v10 = v10 / #v8.v
                    v11 = v6 / math.max(math.sqrt((v8.v[1][1] - v9) ^ 2 + (v8.v[1][2] - v10) ^ 2), 1) + 1
                    v12 = table.create(#v8.v)
                    for i11, i12 in v8.v do
                        v15 = {
                            v9 + (i12[1] - v9) * v11,
                            v10 + (i12[2] - v10) * v11,
                        }
                        v12[i11] = v15
                    end
                    v8 = {v = v12, i = v8.i, o = v8.o, c = v8.c}
                end
                if v8 then
                    if v17 then
                        BuildFilledPath(v21, v8, v29, v26, v27, v7, v18)
                    end
                    if v19 and v30 > 0 then
                        BuildStrokedPath(v21, v8, v29, v26, v27, v2, v20, v30, v3, v1, v4, v5)
                    end
                end
            elseif ty == "rc" then
                Frame = Instance.new("Frame")
                Frame.BorderSizePixel = 0
                v9 = Easing.EvaluateVector(i5.s, v25, {100, 100})
                v10 = Easing.EvaluateVector(i5.p, v25, {0, 0})
                v11 = Easing.EvaluateScalarAtFrame(i5.r, v25, 0)
                Frame.Size = UDim2.fromScale(v9[1] / v26, v9[2] / v27)
                Frame.Position = UDim2.fromScale(v10[1] / v26, v10[2] / v27)
                Frame.AnchorPoint = Vector2.new(0.5, 0.5)
                if not v17 then
                    Frame.BackgroundTransparency = 1
                else
                    Frame.BackgroundColor3 = v7
                    Frame.BackgroundTransparency = v18
                end
                if v11 > 0 then
                    v10 = Instance.new("UICorner")
                    v10.CornerRadius = UDim.new(0, v11)
                    v10.Parent = Frame
                    v21.UICorner = v10
                end
                if v19 and v30 > 0 then
                    local UIStroke = Instance.new("UIStroke")
                    UIStroke.Color = v2
                    UIStroke.Transparency = v20
                    UIStroke.Thickness = v30 / math.min(v26, v27)
                    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    success = pcall(function() -- Line: 928 -- upvalues: UIStroke (val)
                        UIStroke.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
                    end)
                    if not success then
                        UIStroke.Thickness = v30
                    end
                    UIStroke.Parent = Frame
                    v21.UIStroke = UIStroke
                end
                Frame.Parent = v29
                v21.Frame = Frame
            elseif ty == "el" then
                Frame_2 = Instance.new("Frame")
                Frame_2.BorderSizePixel = 0
                v9 = Easing.EvaluateVector(i5.s, v25, {100, 100})
                v10 = Easing.EvaluateVector(i5.p, v25, {0, 0})
                Frame_2.Size = UDim2.fromScale(v9[1] / v26, v9[2] / v27)
                Frame_2.Position = UDim2.fromScale(v10[1] / v26, v10[2] / v27)
                Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
                if not v17 then
                    Frame_2.BackgroundTransparency = 1
                else
                    Frame_2.BackgroundColor3 = v7
                    Frame_2.BackgroundTransparency = v18
                end
                UICorner = Instance.new("UICorner")
                UICorner.CornerRadius = UDim.new(0.5, 0)
                UICorner.Parent = Frame_2
                v21.UICorner = UICorner
                if v19 and v30 > 0 then
                    local UIStroke_2 = Instance.new("UIStroke")
                    UIStroke_2.Color = v2
                    UIStroke_2.Transparency = v20
                    UIStroke_2.Thickness = v30 / math.min(v26, v27)
                    UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    pcall(function() -- Line: 968 -- upvalues: UIStroke_2 (val)
                        UIStroke_2.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
                    end)
                    UIStroke_2.Parent = Frame_2
                    v21.UIStroke = UIStroke_2
                end
                Frame_2.Parent = v29
                v21.Frame = Frame_2
            elseif ty == "gf" or ty == "gs" then
                v8 = i5.t or 1
                if i5.g then
                    if v8 == 1 then
                        v21.UIGradient = BuildLinearGradient(v29, i5.g, i5.s, i5.e, v25)
                    elseif v8 == 2 then
                        BuildRadialGradientApprox(v29, i5.g, i5.s, i5.e, v25, v26, v27)
                    end
                end
            elseif ty == "gr" then
                v8 = BuildShapeGroup(i5, v29, v26, v27, v25)
                if v21.Children then
                    table.insert(v21.Children, v8)
                end
            elseif ty == "rp" then
                v8 = Easing.EvaluateScalarAtFrame(i5.c, v25, 1)
                tr = i5.tr
                if tr and v8 > 1 then
                    v10 = Easing.EvaluateScalarAtFrame(tr.so, v25, 100)
                    v11 = Easing.EvaluateScalarAtFrame(tr.eo, v25, 100)
                    v12 = math.floor(v8) - 1
                    for i6 = 0, v12 do
                        Frame_3 = Instance.new("Frame")
                        Frame_3.BackgroundTransparency = 1
                        Frame_3.BorderSizePixel = 0
                        Frame_3.Size = u47
                        v16 = math.max(v8 - 1, 1)
                        Frame_3.BackgroundTransparency = 1 - math.lerp(v10, v11, i6 / v16) / 100
                        v13 = {
                            p = tr.p,
                            s = tr.s,
                            r = tr.r,
                            a = tr.a,
                            o = tr.o,
                        }
                        v13 = Easing.EvaluateVector(tr.p, v25, {0, 0})
                        Easing.EvaluateVector(tr.s, v25, {100, 100})
                        v14 = Easing.EvaluateScalarAtFrame(tr.r, v25, 0)
                        Frame_3.Position = UDim2.fromScale(v13[1] * i6 / v26, v13[2] * i6 / v27)
                        Frame_3.Rotation = v14 * i6
                        Frame_3.Parent = v29
                        for i7, i8 in it do
                            if i8.ty == "gr" and i8 ~= v28 then
                                BuildShapeGroup(i8, Frame_3, v26, v27, v25)
                            end
                        end
                    end
                end
            end
        end
    end
    return v21
end

local function BuildShapeLayer(a1, a2, a3, a4, a5) -- Line: 1038
    -- upvalues: BuildShapeGroup (val)
    local v1
    local shapes = a1.shapes
    if shapes == nil then
        return {}
    end
    local v2 = {}
    local v3, v4, v5, v6 = a2, a3, a4, a5
    for i = #shapes, 1, -1 do
        v1 = shapes[i]
        if not v1.hd and v1.ty == "gr" then
            table.insert(v2, (BuildShapeGroup(v1, v3, v4, v5, v6)))
        end
    end
    return v2
end

local function BuildTextLayer(a1, a2, a3, a4, a5) -- Line: 1059
    -- upvalues: u47 (val)
    local t = a1.t
    if t == nil then
        return nil
    end
    local d = t.d
    if d == nil then
        return nil
    end
    local k = d.k
    if k ~= nil and #k ~= 0 then
        local s = nil
        local v1 = nil
        local v2 = nil
        local v3, v4, v5 = a4, a2, a5
        for i, j in k, v1, v2 do
            if j.t == nil or j.t <= v5 then
                s = j.s
            end
        end
        if s == nil then
            s = k[1].s
        end
        if s == nil then
            return nil
        end
        local v6 = Instance.new("TextLabel")
        v6.BackgroundTransparency = 1
        v6.BorderSizePixel = 0
        v6.Size = u47
        v6.Text = s.t or ""
        v6.TextScaled = false
        v6.RichText = false
        v6.TextSize = (s.s or 24) / v3 * 100
        if s.fc then
            local fc = s.fc
            v6.TextColor3 = Color3.new(fc[1] or 1, fc[2] or 1, fc[3] or 1)
        end
        local v7 = s.j or 0
        if v7 == 0 then
            v6.TextXAlignment = Enum.TextXAlignment.Left
        elseif v7 ~= 1 then
            v6.TextXAlignment = Enum.TextXAlignment.Center
        else
            v6.TextXAlignment = Enum.TextXAlignment.Right
        end
        v6.TextYAlignment = Enum.TextYAlignment.Top
        if s.f then
            local success, err = pcall(function() -- Line: 1115 -- upvalues: s (ref)
                return Enum.Font[s.f]
            end)
            if not success or not err then
                v6.Font = Enum.Font.GothamMedium
            else
                v6.Font = err
            end
        end
        v6.Parent = v4
        return v6
    end
    return nil
end

local function BuildImageLayer(a1, a2, a3, a4, a5) -- Line: 1129
    -- upvalues: u47 (val), u55 (ref), EncodingService (val), AssetService (val)
    local refId = a1.refId
    if refId == nil then
        return nil
    end
    local v1 = a3[refId]
    if v1 == nil then
        return nil
    end
    local v2 = Instance.new("ImageLabel")
    v2.BackgroundTransparency = 1
    v2.BorderSizePixel = 0
    v2.Size = u47
    v2.ScaleType = Enum.ScaleType.Stretch
    if v1.e ~= 1 then
        if v1.p and not v1.e then
            v2.Image = v1.p
        end
    elseif v1.p then
        local p = v1.p
        if string.sub(p, 1, 22) == "data:image/png;base64," then
            local u28 = string.sub(p, 23)
            if u55 then
                local success, err = pcall(function() -- Line: 1160 -- upvalues: EncodingService (upval), u28 (val), u55 (upval)
                    return u55.decode((EncodingService:Base64Decode((buffer.fromstring(u28)))))
                end)
                if success and err then
                    local success_2, err_2 = pcall(function() -- Line: 1167 -- upvalues: AssetService (upval), err (val)
                        return AssetService:CreateEditableImage({Size = Vector2.new(err.width, err.height)})
                    end)
                    if success_2 and err_2 then
                        local success_3 = pcall(function() -- Line: 1171 -- upvalues: err_2 (val), err (val)
                            err_2:WritePixelsBuffer(Vector2.zero, Vector2.new(err.width, err.height), err.pixels)
                        end)
                        if success_3 then
                            v2.ImageContent = Content.fromObject(err_2)
                        end
                    end
                end
            end
        elseif string.sub(p, 1, 23) == "data:image/jpeg;base64," then
            warn("[Lottie] Embedded JPEG not supported, skipping image layer:", a1.nm or "")
        end
    elseif v1.p and not v1.e then
        v2.Image = v1.p
    end
    v2.Parent = a2
    return v2
end

local function BuildDropShadow(a1, a2, a3, a4, a5) -- Line: 1195
    -- upvalues: Easing (val), u39 (val)
    local ef_2, ty, v1, v2, v3, v4, v5, v6, v7
    local ef = a1.ef
    if ef == nil then
        return
    end
    for i, j in ef do
        if j.ty == 25 then
            ef_2 = j.ef
            if ef_2 ~= nil then
                v2 = Color3.new(0, 0, 0)
                v3 = 0.5
                v4 = 0
                v5 = 5
                v6 = 5
                for k, n in ef_2 do
                    ty = n.ty
                    if ty ~= nil then
                        if ty == 1 then
                            v2 = Easing.EvaluateColor(n.v, a5)
                        elseif ty == 0 then
                            v3 = Easing.EvaluateScalarAtFrame(n.v, a5, 128) / 255
                        elseif ty == 3 then
                            v4 = Easing.EvaluateScalarAtFrame(n.v, a5, 0)
                        elseif ty == 2 then
                            v5 = Easing.EvaluateScalarAtFrame(n.v, a5, 5)
                        elseif ty == 4 then
                            v6 = Easing.EvaluateScalarAtFrame(n.v, a5, 5)
                        end
                    end
                end
                v1 = math.rad(v4 + 180)
                v4 = math.cos(v1) * v5 / a3
                v7 = math.sin(v1) * v5 / a4
                v5 = (v6 * 2 + math.max(a3, a4)) / math.max(a3, a4)
                v6 = Instance.new("ImageLabel")
                v6.Image = "rbxassetid://100849323991833"
                v6.ScaleType = Enum.ScaleType.Slice
                v6.SliceCenter = u39
                v6.ImageColor3 = v2
                v6.ImageTransparency = 1 - v3
                v6.BackgroundTransparency = 1
                v6.BorderSizePixel = 0
                v6.AnchorPoint = Vector2.new(0.5, 0.5)
                v6.Position = UDim2.fromScale(v4 + 0.5, v7 + 0.5)
                v6.Size = UDim2.fromScale(v5, v5)
                v6.ZIndex = -1
                v6.Parent = a2
                return
            end
        end
    end
end

function BuildLayers(a1, a2, a3, a4, a5, a6) -- Line: 1260
    -- upvalues: u47 (val), BuildShapeLayer (val), BuildTextLayer (val), BuildImageLayer (val), BuildLayers (val)
    -- upvalues: BuildDropShadow (val), Easing (val), ApplyTransform (val)
    local CanvasGroup, Frame, Frame_2, Frame_3, Frame_4, Layer, Scale, Scale_2, Shapes, h, ks, nm, o, refId, sc, ty, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, w
    local v14 = {}
    local v15 = {}
    local v16, v17 = a1, a3
    for i = #a1, 1, -1 do
        v1 = v16[i]
        if not v1.hd then
            ty = v1.ty
            ks = v1.ks
            if ks ~= nil then
                o = ks.o
                v3 = if o ~= nil then o.a == 1 else false
            else
                v3 = false
            end
            if ty == 1 then
                Frame = Instance.new("Frame")
                Frame.BorderSizePixel = 0
                if not v1.sc then
                    v6 = Color3.new(0, 0, 0)
                else
                    sc = v1.sc
                    v8 = tonumber(string.sub(sc, 4, 5), 16) or 0
                    v9 = tonumber(string.sub(sc, 6, 7), 16) or 0
                    v6 = Color3.fromRGB(tonumber(string.sub(sc, 2, 3), 16) or 0, v8, v9)
                end
                Frame.BackgroundColor3 = v6
                Frame.BackgroundTransparency = 0
                Frame.Size = UDim2.fromScale((v1.sw or a4) / a4, (v1.sh or a5) / a5)
                v4 = Frame
            elseif not v3 then
                Frame_2 = Instance.new("Frame")
                Frame_2.BackgroundTransparency = 1
                Frame_2.BorderSizePixel = 0
                Frame_2.Size = u47
                v4 = Frame_2
            else
                CanvasGroup = Instance.new("CanvasGroup")
                CanvasGroup.BackgroundTransparency = 1
                CanvasGroup.BorderSizePixel = 0
                CanvasGroup.Size = u47
                v4 = CanvasGroup
            end
            nm = v1.nm or ("Layer_%*"):format(v1.ind or i)
            v4.Name = nm
            Scale = v4.Size.X.Scale
            Scale_2 = v4.Size.Y.Scale
            v7 = {Layer = v1, Frame = v4, BaseSizeX = Scale, BaseSizeY = Scale_2}
            if v1.ind then
                v15[v1.ind] = v7
            end
            if ty == 4 then
                v7.Shapes = BuildShapeLayer(v1, v4, a4, a5, a6)
            elseif ty == 5 then
                v7.TextLabel = BuildTextLayer(v1, v4, a4, a5, a6)
            elseif ty == 2 then
                v7.ImageLabel = BuildImageLayer(v1, v4, v17, a4, a5)
            elseif ty == 0 then
                refId = v1.refId
                if refId and v17[refId] then
                    v8 = v17[refId]
                    if v8.layers then
                        w = v1.w or v8.w or a4
                        h = v1.h or v8.h or a5
                        v4.ClipsDescendants = true
                        v4.Size = UDim2.fromScale(w / a4, h / a5)
                        v7.Children = BuildLayers(v8.layers, v4, v17, w, h, a6)
                    end
                end
            end
            BuildDropShadow(v1, v4, a4, a5, a6)
            if v1.masksProperties then
                v8 = nil
                v9 = nil
                for j, k in v1.masksProperties, v8, v9 do
                    if k.mode == "a" then
                        v2 = Easing.EvaluateBezierShape(k.pt, a6)
                        if v2 then
                            v10 = (1 / 0)
                            v11 = (1 / 0)
                            v12 = (-1 / 0)
                            v13 = (-1 / 0)
                            for n, m in v2.v do
                                v10 = math.min(v10, m[1])
                                v11 = math.min(v11, m[2])
                                v12 = math.max(v12, m[1])
                                v13 = math.max(v13, m[2])
                            end
                            Frame_3 = Instance.new("Frame")
                            Frame_3.BackgroundTransparency = 1
                            Frame_3.BorderSizePixel = 0
                            Frame_3.ClipsDescendants = true
                            Frame_3.Position = UDim2.fromScale(v10 / a4, v11 / a5)
                            Frame_3.Size = UDim2.fromScale((v12 - v10) / a4, (v13 - v11) / a5)
                            Frame_3.Parent = a2
                            v4.Parent = Frame_3
                            v7.MatteClip = Frame_3
                        end
                    elseif k.mode == nil then
                        v2 = Easing.EvaluateBezierShape(k.pt, a6)
                        if v2 then
                            v10 = (1 / 0)
                            v11 = (1 / 0)
                            v12 = (-1 / 0)
                            v13 = (-1 / 0)
                            for i5, i6 in v2.v do
                                v10 = math.min(v10, i6[1])
                                v11 = math.min(v11, i6[2])
                                v12 = math.max(v12, i6[1])
                                v13 = math.max(v13, i6[2])
                            end
                            Frame_3 = Instance.new("Frame")
                            Frame_3.BackgroundTransparency = 1
                            Frame_3.BorderSizePixel = 0
                            Frame_3.ClipsDescendants = true
                            Frame_3.Position = UDim2.fromScale(v10 / a4, v11 / a5)
                            Frame_3.Size = UDim2.fromScale((v12 - v10) / a4, (v13 - v11) / a5)
                            Frame_3.Parent = a2
                            v4.Parent = Frame_3
                            v7.MatteClip = Frame_3
                        end
                    end
                end
            end
            ApplyTransform(v4, v1.ks, a6, a4, a5, v3, Scale, Scale_2)
            v6 = a6 - (v1.st or 0)
            v5 = false
            if v1.ip <= v6 then
                v5 = v6 < v1.op
            end
            v4.Visible = v5
            table.insert(v14, v7)
        end
    end
    local v18 = nil
    local v19 = nil
    for i7, i8 in v14, v18, v19 do
        Layer = i8.Layer
        if not Layer.parent then
            if i8.MatteClip == nil then
                i8.Frame.Parent = a2
            end
        elseif v15[Layer.parent] then
            v4 = v15[Layer.parent]
            i8.Frame.Parent = v4.Frame
        elseif i8.MatteClip == nil then
            i8.Frame.Parent = a2
        end
    end
    local v20 = #v14 - 1
    for i9 = 1, v20 do
        v15 = v14[i9]
        v1 = v14[i9 + 1]
        if v1.Layer.tt then
            v2 = nil
            Shapes = v15.Shapes or {}
            v4 = nil
            v5 = nil
            for i10, i11 in Shapes, v4, v5 do
                if i11.PathData then
                    v2 = Easing.EvaluateBezierShape(i11.PathData, a6)
                    break
                end
            end
            if v2 then
                v3 = (1 / 0)
                v4 = (1 / 0)
                v5 = (-1 / 0)
                v6 = (-1 / 0)
                for i12, i13 in v2.v do
                    v3 = math.min(v3, i13[1])
                    v4 = math.min(v4, i13[2])
                    v5 = math.max(v5, i13[1])
                    v6 = math.max(v6, i13[2])
                end
                Frame_4 = Instance.new("Frame")
                Frame_4.BackgroundTransparency = 1
                Frame_4.BorderSizePixel = 0
                Frame_4.ClipsDescendants = true
                Frame_4.Position = UDim2.fromScale(v3 / a4, v4 / a5)
                Frame_4.Size = UDim2.fromScale((v5 - v3) / a4, (v6 - v4) / a5)
                Frame_4.Parent = a2
                v1.Frame.Parent = Frame_4
                v1.MatteClip = Frame_4
                v15.Frame.Visible = false
            end
        end
    end
    return v14
end

local u88 = nil

function RenderLayerNodes(a1, a2, a3, a4) -- Line: 1429
    -- upvalues: ApplyTransform (val), u88 (ref), Easing (val), RenderLayerNodes (val)
    local Layer, d, s, v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = nil
    local v10 = nil
    for i, j in a1, v9, v10 do
        Layer = j.Layer
        v1 = a2 - (Layer.st or 0)
        v2 = false
        if Layer.ip <= v1 then
            v2 = v1 < Layer.op
        end
        j.Frame.Visible = v2
        if v2 then
            v2 = j.Frame:IsA("CanvasGroup")
            ApplyTransform(j.Frame, Layer.ks, v1, v7, v8, v2, j.BaseSizeX, j.BaseSizeY)
            if j.Shapes then
                for k2, n in j.Shapes do
                    u88(n, v1, v7, v8)
                end
            end
            if j.Children then
                v2 = Layer.w or v7
                v3 = Layer.h or v8
                v4 = v1
                if Layer.tm then
                    v4 = (Easing.EvaluateScalarAtFrame(Layer.tm, v1, 0)) * (Layer.op - Layer.ip)
                end
                RenderLayerNodes(j.Children, v4, v2, v3)
            end
            if j.TextLabel and Layer.t then
                d = Layer.t.d
                if d and d.k then
                    s = nil
                    v5 = nil
                    v6 = nil
                    for m, i5 in d.k, v5, v6 do
                        if i5.t == nil or i5.t <= v1 then
                            s = i5.s
                        end
                    end
                    if s then
                        j.TextLabel.Text = s.t or ""
                        if s.fc then
                            j.TextLabel.TextColor3 = Color3.new(s.fc[1] or 1, s.fc[2] or 1, s.fc[3] or 1)
                        end
                    end
                end
            end
        end
    end
end

function u88(a1, a2, a3, a4) -- Line: 1482
    -- upvalues: u88 (ref), Easing (val), BuildFilledPath (val), BuildStrokedPath (val)
    local FillColor, v1, v2, v3, v4, v5
    if a1.Children then
        for i, j in a1.Children do
            u88(j, a2, a3, a4)
        end
    end
    if not a1.IsAnimatedPath then
        if a1.FillColor then
            FillColor = a1.FillColor
            v1 = if FillColor ~= nil then FillColor.a == 1 else false
            if v1 then
                v1 = Easing.EvaluateColor(a1.FillColor, a2)
                v3 = 1 - Easing.EvaluateScalarAtFrame(a1.FillOpacity, a2, 100) / 100
                if a1.Triangles then
                    v4 = nil
                    v5 = nil
                    for k, n in a1.Triangles, v4, v5 do
                        if n.A.Visible then
                            n.A.ImageColor3 = v1
                            n.A.ImageTransparency = v3
                        end
                        if n.B.Visible then
                            n.B.ImageColor3 = v1
                            n.B.ImageTransparency = v3
                        end
                    end
                end
                if a1.Frame and a1.Frame.BackgroundTransparency < 1 then
                    a1.Frame.BackgroundColor3 = v1
                    a1.Frame.BackgroundTransparency = v3
                end
            end
        end
    elseif a1.PathData then
        v1 = Easing.EvaluateBezierShape(a1.PathData, a2)
        if v1 and a1.Frame then
            v2 = Easing.EvaluateColor(a1.FillColor, a2)
            v3 = Easing.EvaluateScalarAtFrame(a1.FillOpacity, a2, 100)
            if a1.FillColor then
                BuildFilledPath(a1, v1, a1.Frame, a3, a4, v2, 1 - v3 / 100)
            end
            if a1.StrokeColor then
                v3 = Easing.EvaluateColor(a1.StrokeColor, a2)
                v2 = Easing.EvaluateScalarAtFrame(a1.StrokeOpacity, a2, 100)
                local v6 = Easing.EvaluateScalarAtFrame(a1.StrokeWidth, a2, 0)
                if v6 > 0 then
                    BuildStrokedPath(a1, v1, a1.Frame, a3, a4, v3, 1 - v2 / 100, v6)
                end
            end
        end
    elseif a1.FillColor then
        FillColor = a1.FillColor
        v1 = if FillColor ~= nil then FillColor.a == 1 else false
        if v1 then
            v1 = Easing.EvaluateColor(a1.FillColor, a2)
            v3 = 1 - Easing.EvaluateScalarAtFrame(a1.FillOpacity, a2, 100) / 100
            if a1.Triangles then
                v4 = nil
                v5 = nil
                for m, i5 in a1.Triangles, v4, v5 do
                    if i5.A.Visible then
                        i5.A.ImageColor3 = v1
                        i5.A.ImageTransparency = v3
                    end
                    if i5.B.Visible then
                        i5.B.ImageColor3 = v1
                        i5.B.ImageTransparency = v3
                    end
                end
            end
            if a1.Frame and a1.Frame.BackgroundTransparency < 1 then
                a1.Frame.BackgroundColor3 = v1
                a1.Frame.BackgroundTransparency = v3
            end
        end
    end
    if a1.StrokeColor then
        local StrokeColor = a1.StrokeColor
        v1 = if StrokeColor ~= nil then StrokeColor.a == 1 else false
        if v1 then
            v1 = Easing.EvaluateColor(a1.StrokeColor, a2)
            v2 = Easing.EvaluateScalarAtFrame(a1.StrokeOpacity, a2, 100)
            if a1.Segments then
                for i6, i7 in a1.Segments do
                    if i7.Visible then
                        i7.BackgroundColor3 = v1
                        i7.BackgroundTransparency = 1 - v2 / 100
                    end
                end
            end
            if a1.UIStroke then
                a1.UIStroke.Color = v1
                a1.UIStroke.Transparency = 1 - v2 / 100
            end
        end
    end
end

return (table.freeze({
    Parse = function(a1) -- Line: 1551 -- upvalues: HttpService (val) -- types: a1: string
        return (HttpService:JSONDecode(a1))
    end,
    Create = function(a1) -- Line: 1555 -- upvalues: u47 (val), BuildLayers (val)
        local w = a1.w
        local h = a1.h
        local ip = a1.ip
        local op = a1.op
        local fr = a1.fr
        local Frame = Instance.new("Frame")
        Frame.Name = a1.nm or "LottieAnimation"
        Frame.BackgroundTransparency = 1
        Frame.BorderSizePixel = 0
        Frame.ClipsDescendants = true
        Frame.Size = u47
        local v1 = {}
        if a1.assets then
            for i, j in a1.assets do
                v1[j.id] = j
            end
        end
        return {
            Animation = a1,
            Root = Frame,
            Layers = BuildLayers(a1.layers, Frame, v1, w, h, ip),
            AssetMap = v1,
            Duration = (op - ip) / fr,
            Width = w,
            Height = h,
        }
    end,
    Render = function(a1, a2) -- Line: 1590 -- upvalues: RenderLayerNodes (val) -- types: a2: number
        local Animation = a1.Animation
        local ip = Animation.ip
        local op = Animation.op
        local fr = Animation.fr
        local v1 = op - ip
        RenderLayerNodes(a1.Layers, ip + a2 * fr % v1, a1.Width, a1.Height)
    end,
    Destroy = function(self) -- Line: 1601
        self.Root:Destroy()
        table.clear(self.Layers)
        table.clear(self.AssetMap)
    end,
}))