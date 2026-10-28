-- Script path: ReplicatedStorage.Controllers.Game.LightingController
-- Decompile time: 20.46 ms

local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Signal = require(ReplicatedStorage.Packages.Signal)
local Sine = Enum.EasingStyle.Sine
local InOut = Enum.EasingDirection.InOut
local u35 = Color3.new(1, 1, 1)
local u36 = {
    "GlobalShadows",
    "ClockTime",
    "GeographicLatitude",
    "Brightness",
    "ExposureCompensation",
    "ShadowSoftness",
    "Ambient",
    "OutdoorAmbient",
    "ColorShift_Top",
    "ColorShift_Bottom",
    "EnvironmentDiffuseScale",
    "EnvironmentSpecularScale",
    "FogColor",
    "FogStart",
    "FogEnd",
}
local u52 = {}
local v1 = {
    key = "Clouds",
    class = "Clouds",
    host = Workspace.Terrain,
    props = {"Color", "Cover", "Density", "Enabled"},
}
u52[1] = {
    key = "Sky",
    class = "Sky",
    host = Lighting,
    props = {
        "CelestialBodiesShown",
        "SunAngularSize",
        "SunTextureId",
        "MoonAngularSize",
        "MoonTextureId",
        "StarCount",
        "SkyboxUp",
        "SkyboxDn",
        "SkyboxFt",
        "SkyboxBk",
        "SkyboxLf",
        "SkyboxRt",
        "SkyboxOrientation",
    },
}
u52[2] = {
    key = "Atmosphere",
    class = "Atmosphere",
    host = Lighting,
    props = {"Density", "Haze", "Glare", "Offset", "Color", "Decay"},
}
u52[3] = v1
u52[4] = {
    key = "SunRays",
    class = "SunRaysEffect",
    host = Lighting,
    props = {"Intensity", "Spread", "Enabled"},
}
u52[5] = {
    key = "Bloom",
    class = "BloomEffect",
    host = Lighting,
    props = {"Intensity", "Threshold", "Size", "Enabled"},
}
u52[6] = {key = "Blur", class = "BlurEffect", host = Lighting, props = {"Size", "Enabled"}}
u52[7] = {
    key = "DepthOfField",
    class = "DepthOfFieldEffect",
    host = Lighting,
    props = {"NearIntensity", "FarIntensity", "FocusDistance", "InFocusRadius", "Enabled"},
}
u52[8] = {
    key = "ColorCorrection",
    class = "ColorCorrectionEffect",
    host = Lighting,
    props = {"Saturation", "Contrast", "Brightness", "TintColor", "Enabled"},
}
local u112 = {ClockTime = 24, GeographicLatitude = 360}
local u113 = {["Sky.StarCount"] = true}
local u115 = {
    ["Bloom.Size"] = true,
    ["Bloom.Threshold"] = true,
    ["DepthOfField.FocusDistance"] = true,
    ["DepthOfField.InFocusRadius"] = true,
    ["SunRays.Spread"] = true,
}
local v2 = {}
local u123 = Signal.new()
local u234 = {}
local u125 = {}
local u126 = nil
local u237 = nil
local u238 = nil

local function locate(a1) -- Line: 286 -- types: a1: table
    local v1 = a1.host:FindFirstChild(a1.key)
    if v1 and v1:IsA(a1.class) then
        return v1
    end
    return nil
end

local function readProps(a1, a2) -- Line: 291 -- types: a1: userdata, a2: table
    local v1 = {}
    for i, j in a2 do
        v1[j] = a1[j]
    end
    return v1
end

local function writeProps(a1, a2, a3) -- Line: 300 -- types: a1: userdata, a2: table, a3: table
    local v1
    for i, j in a2 do
        v1 = a3[j]
        if v1 ~= nil and a1[j] ~= v1 then
            a1[j] = v1
        end
    end
end

local function readScene() -- Line: 310 -- upvalues: Lighting (val), u36 (val), u52 (val)
    local key_2, v1, v2, v3
    local v4 = {}
    for i, j in u36 do
        v4[j] = Lighting[j]
    end
    local v5 = nil
    local v6 = nil
    for k, n in u52, v5, v6 do
        v2 = n.host:FindFirstChild(n.key)
        v1 = if not v2 then nil else if not v2:IsA(n.class) then nil else v2
        if v1 then
            key_2 = n.key
            v3 = {}
            for m, i5 in n.props do
                v3[i5] = v1[i5]
            end
            v4[key_2] = v3
        end
    end
    return v4
end

local function materialise(a1) -- Line: 321 -- types: a1: table
    local v1 = Instance.new(a1.class)
    v1.Name = a1.key
    v1.Parent = a1.host
    return v1
end

local function retire(a1, a2) -- Line: 329 -- upvalues: Lighting (val) -- types: a1: table, a2: userdata
    if a1.host == Lighting then
        a2:Destroy()
        return
    end
    a2.Enabled = false
end

local function writeScene(a1) -- Line: 338 -- upvalues: Lighting (val), u36 (val), u52 (val) -- types: a1: table
    local v1, v2, v3, v4
    local v5 = Lighting
    for i, j in u36 do
        v4 = a1[j]
        if v4 ~= nil and v5[j] ~= v4 then
            v5[j] = v4
        end
    end
    local v6 = nil
    local v7 = nil
    for k, n in u52, v6, v7 do
        v2 = a1[n.key]
        v4 = n.host:FindFirstChild(n.key)
        v3 = if not v4 then nil else if not v4:IsA(n.class) then nil else v4
        if v2 ~= nil then
            v4 = v3
            if not v4 then
                v4 = Instance.new(n.class)
                v4.Name = n.key
                v4.Parent = n.host
            end
            for m, i5 in n.props do
                v1 = v2[i5]
                if v1 ~= nil and v4[i5] ~= v1 then
                    v4[i5] = v1
                end
            end
        elseif v3 ~= nil then
            if n.host ~= Lighting then
                v3.Enabled = false
            else
                v3:Destroy()
            end
        end
    end
end

local function readAuthored(a1, a2) -- Line: 354
    -- upvalues: u36 (val), Lighting (val), u52 (val)
    local FullName, key, v1, v2, v3, v4
    local v5 = table.clone(a2)
    local v6 = a1
    for i, j in a1:GetAttributes() do
        if table.find(u36, i) ~= nil then
            v3 = typeof(Lighting[i])
            if typeof(j) ~= v3 then
                v4 = error
                FullName = v6:GetFullName()
                v2 = typeof(j)
                v4((("%* expects a %* in attribute %*, found %*"):format(FullName, v3, i, v2)))
            end
            v5[i] = j
        end
    end
    local v7 = nil
    local v8 = nil
    for k, n in u52, v7, v8 do
        v3 = v6:FindFirstChildOfClass(n.class)
        if v3 then
            key = n.key
            v1 = {}
            for m, i5 in n.props do
                v1[i5] = v3[i5]
            end
            v5[key] = v1
        end
    end
    return v5
end

local function sameProps(a1, a2, a3) -- Line: 379 -- types: a1: table, a2: table, a3: table
    for i, j in a3 do
        if a1[j] ~= a2[j] then
            return false
        end
    end
    return true
end

local function sameLook(a1, a2) -- Line: 388 -- upvalues: u36 (val), u52 (val) -- types: a1: table, a2: table
    local v1, v2, v3
    local v4 = a1
    local v5 = a2
    local v6 = u36
    for i, j in v6 do
        if v4[j] ~= v5[j] then
            if true then
                return false
            end
            v2 = nil
            v6 = nil
            for k, n in u52, v2, v6 do
                v3 = v4[n.key]
                v1 = v5[n.key]
                if v3 == nil ~= (v1 == nil) then
                    return false
                end
                if v3 ~= nil then
                    for m, i5 in n.props do
                        if v3[i5] ~= v1[i5] then
                            if true then
                                return false
                            end
                            break
                        end
                    end
                    if false then
                        return false
                    end
                end
            end
            return true
        end
    end
    if false then
        return false
    end
    v2 = nil
    v6 = nil
    for i6, i7 in u52, v2, v6 do
        v3 = v4[i7.key]
        v1 = v5[i7.key]
        if v3 == nil ~= (v1 == nil) then
            return false
        end
        if v3 ~= nil then
            for i8, i9 in i7.props do
                if v3[i9] ~= v1[i9] then
                    if true then
                        return false
                    end
                    break
                end
            end
            if false then
                return false
            end
        end
    end
    return true
end

local function shortestTurn(a1, a2, a3, a4) -- Line: 405 -- types: a1: number, a2: number, a3: number, a4: number
    local v1 = a4 / 2
    return (a1 + (v1 - (v1 - (a2 - a1)) % a4) * a3) % a4
end

local function interpolate(a1, a2, a3, a4, a5) -- Line: 411 -- types: a3: number, a4: number?, a5: boolean?
    local v1
    if a4 then
        v1 = a4 / 2
        return (a1 + (v1 - (v1 - (a2 - a1)) % a4) * a3) % a4
    end
    local v2 = typeof(a1)
    if v2 == "number" then
        v1 = a1 + (a2 - a1) * a3
        if a5 then
            return (math.floor(v1 + 0.5))
        end
        return v1
    end
    if v2 == "Color3" then
        return a1:Lerp(a2, a3)
    end
    if a3 < 0.7 then
        return a1
    end
    return a2
end

local function restingValue(a1, a2) -- Line: 425 -- upvalues: u35 (val) -- types: a2: boolean
    local v1 = typeof(a1)
    if v1 == "number" then
        if a2 then
            return a1
        end
        return 0
    end
    if v1 == "Color3" then
        return u35
    end
    return a1
end

local function isActive(a1) -- Line: 436 -- types: a1: table?
    local v1 = false
    if a1 ~= nil then
        v1 = a1.Enabled ~= false
    end
    return v1
end

local function blendBlock(a1, a2, a3, a4) -- Line: 440
    -- upvalues: u115 (val), u35 (val), u113 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    local v11 = false
    if a2 ~= nil then
        v11 = a2.Enabled ~= false
    end
    local v12 = false
    if a3 ~= nil then
        v12 = a3.Enabled ~= false
    end
    if not v11 and not v12 then
        return nil
    end
    local v13 = {}
    local v14 = nil
    local v15 = nil
    for i, j in a1.props, v14, v15 do
        v1 = if not v11 then nil else a2[j]
        v2 = if not v12 then nil else v16[j]
        if v1 ~= nil or v2 ~= nil then
            v3 = ("%*.%*"):format(v17.key, j)
            if v1 == nil then
                v5 = u115[v3] == true
                v6 = typeof(v2)
                v1 = if v6 ~= "number" then if v6 ~= "Color3" then v2 else u35 else if not v5 then 0 else v2
            elseif v2 == nil then
                v5 = u115[v3] == true
                v6 = typeof(v1)
                v2 = if v6 ~= "number" then if v6 ~= "Color3" then v1 else u35 else if not v5 then 0 else v1
            end
            v7 = u113[v3]
            v8 = typeof(v1)
            if v8 ~= "number" then
                v4 = if v8 ~= "Color3" then if not (v10 < 0.7) then v2 else v1 else v1:Lerp(v2, v10)
            else
                v9 = v1 + (v2 - v1) * v10
                v4 = if not v7 then v9 else math.floor(v9 + 0.5)
            end
            v13[j] = v4
        end
    end
    return v13
end

local function blend(a1, a2, a3) -- Line: 463
    -- upvalues: u36 (val), interpolate (val), u112 (val), u52 (val), blendBlock (val)
    local key, v1, v2, v3
    if a3 <= 0 then
        return a1
    end
    if a3 >= 1 then
        return a2
    end
    local v4 = a1
    local v5 = a2
    local v6 = {}
    for i, j in u36 do
        v6[j] = (interpolate(v4[j], v5[j], a3, u112[j]))
    end
    for k, n in u52 do
        key = n.key
        v1 = blendBlock
        v2 = v4[n.key]
        v3 = v5[n.key]
        v6[key] = (v1(n, v2, v3, a3))
    end
    return v6
end

local function byRankThenId(a1, a2) -- Line: 480 -- types: a1: table, a2: table
    if a1.rank ~= a2.rank then
        return a1.rank < a2.rank
    end
    return a1.id < a2.id
end

local function resolve() -- Line: 489 -- upvalues: u125 (val), byRankThenId (val), u234 (val)
    local v1
    local v2 = {}
    for i, j in u125 do
        table.insert(v2, j)
    end
    table.sort(v2, byRankThenId)
    local Default = u234.Default
    local v3 = nil
    local v4 = nil
    for k, n in v2, v3, v4 do
        if not n.preset then
            v1 = table.clone(Default)
            for m, i5 in n.patch do
                v1[m] = i5
            end
            Default = v1
        else
            Default = n.preset
        end
    end
    return Default
end

local function stopStepping() -- Line: 512 -- upvalues: u237 (ref), u238 (ref)
    u237 = nil
    if u238 then
        u238:Disconnect()
        u238 = nil
    end
end

local function step() -- Line: 520
    -- upvalues: u237 (ref), u238 (ref), writeScene (val), blend (val), TweenService (val), Sine (val), InOut (val)
    local v1 = u237
    if v1 == nil then
        u237 = nil
        if u238 then
            u238:Disconnect()
            u238 = nil
        end
        return
    end
    local v2 = (os.clock() - v1.startedAt) / v1.seconds
    if not (v2 >= 1) then
        writeScene((blend(v1.origin, v1.target, TweenService:GetValue(v2, Sine, InOut))))
        return
    end
    u237 = nil
    if u238 then
        u238:Disconnect()
        u238 = nil
    end
    writeScene(v1.target)
end

local function easeTo(a1, a2) -- Line: 541
    -- upvalues: u237 (ref), u238 (ref), writeScene (val), readScene (val), RunService (val), step (val)
    if a2 == a2 and not (a2 <= 0) then
        u237 = {origin = readScene(), target = a1, startedAt = os.clock(), seconds = a2}
        if u238 == nil then
            u238 = RunService.Heartbeat:Connect(step)
        end
        return
    end
    u237 = nil
    if u238 then
        u238:Disconnect()
        u238 = nil
    end
    writeScene(a1)
end

local function refresh(a1) -- Line: 558
    -- upvalues: Workspace (val), resolve (val), sameLook (val), u126 (ref), easeTo (val), u123 (val)
    if Workspace:GetAttribute("AdminAbuseOnTop") then
        return
    end
    local v1 = resolve()
    if sameLook(u126, v1) then
        return
    end
    u126 = v1
    local v2 = a1 or 1.5
    easeTo(v1, v2)
    u123:Fire(v1, v2)
end

v2.Presets = u234
v2.Changed = u123

function v2.SetLayer(a1, a2, a3, a4) -- Line: 586
    -- upvalues: u234 (val), u125 (val), refresh (val)
    local v1 = {id = a1, rank = a3 or 0}
    if type(a2) ~= "string" then
        v1.patch = a2
    else
        local v2 = u234[a2]
        if v2 == nil then
            error(("unknown lighting preset \"%*\""):format(a2), 2)
        end
        v1.preset = v2
    end
    u125[a1] = v1
    refresh(a4)
end

function v2.SetAuthoredLayer(a1, a2, a3, a4) -- Line: 602
    -- upvalues: readAuthored (val), u234 (val), u125 (val), refresh (val)
    u125[a1] = {id = a1, rank = a3 or 0, preset = readAuthored(a2, u234.Default)}
    refresh(a4)
end

function v2.ClearLayer(a1, a2) -- Line: 613 -- upvalues: u125 (val), refresh (val) -- types: a1: string, a2: number?
    if u125[a1] == nil then
        return
    end
    u125[a1] = nil
    refresh(a2)
end

function v2.Current() -- Line: 622 -- upvalues: u126 (ref)
    return u126
end

function v2.Settle() -- Line: 626 -- upvalues: Workspace (val), u237 (ref), u238 (ref), writeScene (val), u126 (ref)
    if Workspace:GetAttribute("AdminAbuseOnTop") then
        return
    end
    u237 = nil
    if u238 then
        u238:Disconnect()
        u238 = nil
    end
    writeScene(u126)
end

function v2.Start() end

local u231 = readScene()
u234.Default = u231
for i, j in script:WaitForChild("Presets"):GetChildren() do
    if u234[j.Name] ~= nil then
        error((("duplicate lighting preset %*"):format((j:GetFullName()))))
    end
    u234[j.Name] = (readAuthored(j, u231))
end
table.freeze(u234)
u126 = u231
local u188 = Workspace:GetAttribute("AdminAbuseOnTop") == true

local function refill(a1, a2) -- Line: 655 -- types: a1: table, a2: table
    table.clear(a1)
    for i, j in a2 do
        a1[i] = j
    end
end

;(Workspace:GetAttributeChangedSignal("AdminAbuseOnTop")):Connect(function() -- Line: 662
    -- upvalues: Workspace (val), u237 (ref), u238 (ref), u188 (ref), readScene (val), u231 (val), u234 (val)
    -- upvalues: readAuthored (val), u126 (ref), refresh (val)
    if Workspace:GetAttribute("AdminAbuseOnTop") then
        u237 = nil
        if u238 then
            u238:Disconnect()
            u238 = nil
        end
        return
    end
    if u188 then
        local v1, v2
        u188 = false
        local v3 = readScene()
        local v4 = u231
        table.clear(v4)
        for i, j in v3 do
            v4[i] = j
        end
        for k, n in script:WaitForChild("Presets"):GetChildren() do
            v1 = u234[n.Name]
            v2 = readAuthored(n, v3)
            table.clear(v1)
            for m, i5 in v2 do
                v1[m] = i5
            end
        end
    end
    readScene()
    refresh()
end)
return v2