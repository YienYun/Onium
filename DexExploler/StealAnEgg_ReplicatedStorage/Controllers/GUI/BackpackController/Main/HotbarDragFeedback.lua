-- Script path: ReplicatedStorage.Controllers.GUI.BackpackController.Main.HotbarDragFeedback
-- Decompile time: 3.65 ms

local RunService = game:GetService("RunService")
local v1 = {}
local u6 = {}
local u7 = nil

local function stopAnimationIfIdle() -- Line: 10 -- upvalues: u6 (val), u7 (ref)
    for i, j in u6 do
        if j.Elapsed ~= nil then
            return
        end
    end
    if u7 then
        u7:Disconnect()
        u7 = nil
    end
end

local function resetShake(a1, a2) -- Line: 20
    if a2.Elapsed ~= nil then
        a1.Rotation = a2.RestRotation
        a2.Elapsed = nil
    end
end

local function getState(a1) -- Line: 27 -- upvalues: u6 (val), u7 (ref)
    if u6[a1] then
        return u6[a1]
    end
    local Frame = Instance.new("Frame")
    Frame.Name = "LockedDragHighlight"
    Frame.BackgroundColor3 = Color3.fromRGB(220, 65, 55)
    Frame.BackgroundTransparency = 0.45
    Frame.BorderSizePixel = 0
    Frame.Size = UDim2.fromScale(1, 1)
    Frame.ZIndex = 18
    Frame.Active = false
    Frame.Selectable = false
    Frame.Interactable = false
    Frame.Visible = false
    local UICorner = a1:FindFirstChildOfClass("UICorner")
    if UICorner then
        UICorner:Clone().Parent = Frame
    end
    Frame.Parent = a1
    local v1 = {Highlighted = false, Tint = Frame}
    u6[a1] = v1
    a1.Destroying:Once(function() -- Line: 46 -- upvalues: u6 (upval), a1 (val), u7 (upval)
        u6[a1] = nil
        for i, j in u6 do
            if j.Elapsed ~= nil then
                return
            end
        end
        if u7 then
            u7:Disconnect()
            u7 = nil
        end
    end)
    return v1
end

function v1.Start(a1) -- Line: 53 -- upvalues: u6 (val), u7 (ref), getState (val)
    local v1
    local v2 = nil
    local v3 = nil
    for i, j in u6, v2, v3 do
        if j.Elapsed ~= nil then
            i.Rotation = j.RestRotation
            j.Elapsed = nil
        end
        j.Highlighted = false
        j.Tint.Visible = false
    end
    for k, n in u6 do
        if n.Elapsed ~= nil then
            for m, i5 in v4 do
                v1 = getState(i5)
                v1.Highlighted = true
                v1.Tint.Visible = true
            end
            return
        end
    end
    if u7 then
        u7:Disconnect()
        u7 = nil
    end
    for i6, i7 in v4 do
        v1 = getState(i7)
        v1.Highlighted = true
        v1.Tint.Visible = true
    end
end

function v1.Finish() -- Line: 68 -- upvalues: u6 (val)
    local v1 = nil
    local v2 = nil
    for i, j in u6, v1, v2 do
        j.Highlighted = false
        j.Tint.Visible = j.Elapsed ~= nil
    end
end

function v1.Reject(a1) -- Line: 75 -- upvalues: getState (val), u7 (ref), RunService (val), u6 (val)
    if a1 and a1.Parent then
        local v1 = getState(a1)
        if v1.Elapsed ~= nil then
            a1.Rotation = v1.RestRotation
            v1.Elapsed = nil
        end
        v1.RestRotation = a1.Rotation
        v1.Elapsed = 0
        v1.Tint.Visible = true
        if u7 then
            return
        end
        RunService.RenderStepped:Connect(function(a1) -- Line: 83 -- upvalues: u6 (upval), u7 (upval)
            local RestRotation, v1, v2
            local v3 = nil
            local v4 = nil
            for i, j in u6, v3, v4 do
                if j.Elapsed ~= nil then
                    j.Elapsed = j.Elapsed + a1
                    v2 = math.min(j.Elapsed / 0.32, 1)
                    RestRotation = j.RestRotation
                    v1 = math.sin(v2 * 3.141592653589793 * 6) * 8
                    i.Rotation = RestRotation + v1 * (1 - v2)
                    if v2 == 1 then
                        if j.Elapsed ~= nil then
                            i.Rotation = j.RestRotation
                            j.Elapsed = nil
                        end
                        j.Tint.Visible = j.Highlighted
                    end
                end
            end
            for k, n in u6 do
                if n.Elapsed ~= nil then
                    return
                end
            end
            if u7 then
                u7:Disconnect()
                u7 = nil
            end
        end)
        return
    end
end

return v1