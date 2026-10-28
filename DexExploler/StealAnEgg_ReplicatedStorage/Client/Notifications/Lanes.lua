-- Script path: ReplicatedStorage.Client.Notifications.Lanes
-- Decompile time: 25.88 ms

local v1
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local GUI = require(ReplicatedStorage.Client.GUI)
local u143 = require(script.Parent.RoundDeferral)
local u146 = TweenInfo.new(0.16, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local u147 = TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
local u148 = TweenInfo.new(0.28, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
local u149 = TweenInfo.new(0.22, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
local v2 = {Banner = true}
local v3 = {}
local u152 = GUI.Notifications()
local u139 = {}
local v4 = {Feed = "Feed", Banner = "Banner"}
local v5 = nil
local v6 = nil
for i, j in v4, v5, v6 do
    v1 = {
        lastAdmit = (-1 / 0),
        issued = 0,
        wakeToken = 0,
        pumpPending = false,
        id = i,
        holder = u152:WaitForChild(j),
        guarded = v2[i] == true,
        waiting = {},
        live = {},
    }
    u139[i] = v1
end
local u71 = {}
local u72 = 0
local u73 = 0
local u74 = nil

local function asGroup(a1) -- Line: 125 -- types: a1: userdata
    if a1:IsA("CanvasGroup") then
        return a1
    end
    return nil
end

local function expectKind(a1, a2, a3) -- Line: 129 -- types: a2: string, a3: string
    if a1 ~= nil and typeof(a1) ~= a2 then
        error(("notification entry field %* expects a %*, got %*"):format(a3, a2, (typeof(a1))), 3)
    end
end

local function claimKey(a1) -- Line: 135 -- upvalues: u71 (val) -- types: a1: string?
    if a1 == nil then
        return true
    end
    if u71[a1] then
        return false
    end
    u71[a1] = true
    return true
end

local function releaseKey(a1) -- Line: 146 -- upvalues: u71 (val) -- types: a1: string?
    if a1 ~= nil then
        u71[a1] = nil
    end
end

local function dropFrom(a1, a2) -- Line: 152 -- types: a1: table, a2: table
    local v1 = table.find(a1, a2)
    if v1 ~= nil then
        table.remove(a1, v1)
    end
end

local u80 = {}
local u81 = nil

local function integrate(a1, a2) -- Line: 162 -- types: a1: table, a2: number
    a1.velocity = a1.velocity + (-227.3956854010988 * (a1.value - 1) - 18.698759474166447 * a1.velocity) * a2
    a1.value = a1.value + a1.velocity * a2
    local v1 = false
    if (math.abs(a1.value - 1)) < 0.002 then
        v1 = (math.abs(a1.velocity)) < 0.02
    end
    return v1
end

local function stepSprings(a1) -- Line: 171 -- upvalues: u80 (ref), u81 (ref) -- types: a1: number
    local scale, v1, v2
    local v3 = math.min(a1, 0.03333333333333333)
    local v4 = {}
    local v5 = nil
    local v6 = nil
    for i, j in u80, v5, v6 do
        scale = j.scale
        if scale.Parent ~= nil then
            v1 = -227.3956854010988 * (j.value - 1) - 18.698759474166447 * j.velocity
            j.velocity = j.velocity + v1 * v3
            j.value = j.value + j.velocity * v3
            v2 = false
            if (math.abs(j.value - 1)) < 0.002 then
                v2 = (math.abs(j.velocity)) < 0.02
            end
            if not v2 then
                scale.Scale = j.value
                table.insert(v4, j)
            else
                scale.Scale = 1
            end
        end
    end
    if #v4 == 0 and u81 ~= nil then
        u81:Disconnect()
        u81 = nil
    end
end

local function launchSpring(a1) -- Line: 193
    -- upvalues: u80 (ref), u81 (ref), RunService (val), stepSprings (val)
    a1.Scale = 0.55
    table.insert(u80, {value = 0.55, velocity = 0, scale = a1})
    if u81 == nil then
        RunService.RenderStepped:Connect(stepSprings)
    end
end

local function abandonSpring(a1) -- Line: 201 -- upvalues: u80 (ref) -- types: a1: userdata
    for i, j in u80 do
        if j.scale == a1 then
            table.remove(u80, i)
            return
        end
    end
end

local function finalize(a1) -- Line: 210 -- upvalues: u139 (val), u71 (val), u73 (ref), u74 (ref) -- types: a1: table
    local v1 = u139[a1.laneId]
    local waiting = v1.waiting
    local v2 = table.find(waiting, a1)
    if v2 ~= nil then
        table.remove(waiting, v2)
    end
    local live = v1.live
    v2 = table.find(live, a1)
    if v2 ~= nil then
        table.remove(live, v2)
    end
    local uniqueKey = a1.uniqueKey
    if uniqueKey ~= nil then
        u71[uniqueKey] = nil
    end
    if a1.shownAt ~= nil then
        if a1.pinned then
            u73 = os.clock() + 0.8
            task.delay(0.8, function() -- Line: 219 -- upvalues: u139 (upval), u74 (upval)
                for i, j in u139 do
                    u74(j)
                end
            end)
        end
        local onRetired = a1.onRetired
        if onRetired ~= nil then
            task.spawn(onRetired, a1.frame)
        end
    end
    if not a1.destroyed then
        a1.destroyed = true
        a1.frame:Destroy()
    end
    u74(v1)
end

local function retire(a1) -- Line: 238
    -- upvalues: abandonSpring (val), TweenService (val), u147 (val), u148 (val), finalize (val)
    if a1.retiring then
        return
    end
    a1.retiring = true
    a1.expiryToken = a1.expiryToken + 1
    local frame = a1.frame
    local UIScale = frame:FindFirstChildOfClass("UIScale")
    if UIScale ~= nil then
        abandonSpring(UIScale)
        TweenService:Create(UIScale, u147, {Scale = 0.7}):Play()
    end
    local v1 = if not frame:IsA("CanvasGroup") then nil else frame
    if v1 ~= nil then
        TweenService:Create(v1, u148, {GroupTransparency = 1}):Play()
    end
    task.delay(0.28, finalize, a1)
end

local function armExpiry(a1) -- Line: 258 -- upvalues: retire (val) -- types: a1: table
    a1.expiryToken = a1.expiryToken + 1
    local expiryToken = a1.expiryToken
    task.delay(a1.seconds, function() -- Line: 261 -- upvalues: expiryToken (val), a1 (val), retire (upval)
        if expiryToken == a1.expiryToken and a1.shownAt ~= nil and not a1.retiring then
            retire(a1)
        end
    end)
end

local function watchFrame(a1) -- Line: 268 -- upvalues: finalize (val) -- types: a1: table
    a1.frame.Destroying:Connect(function() -- Line: 269 -- upvalues: a1 (val), finalize (upval)
        a1.destroyed = true
        if a1.retiring then
            return
        end
        a1.retiring = true
        local v1 = a1
        v1.expiryToken = v1.expiryToken + 1
        task.defer(finalize, a1)
    end)
end

local function admit(a1, a2) -- Line: 280
    -- upvalues: u80 (ref), u81 (ref), RunService (val), stepSprings (val), TweenService (val), u146 (val), retire (val)
    local v1 = os.clock()
    a1.lastAdmit = v1
    a1.issued = a1.issued + 1
    a2.shownAt = v1
    table.insert(a1.live, a2)
    local frame = a2.frame
    local v2 = if not frame:IsA("CanvasGroup") then nil else frame
    local GroupTransparency = if v2 == nil then 0 else v2.GroupTransparency
    if v2 ~= nil then
        v2.GroupTransparency = 1
    end
    local UIScale = frame:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
    UIScale.Scale = 0.55
    UIScale.Parent = frame
    local issued = if not a2.pinned then a1.issued else -a1.issued
    frame.LayoutOrder = issued
    frame.AnchorPoint = Vector2.one * 0.5
    frame.Parent = a1.holder
    UIScale.Scale = 0.55
    table.insert(u80, {value = 0.55, velocity = 0, scale = UIScale})
    if u81 == nil then
        RunService.RenderStepped:Connect(stepSprings)
    end
    if v2 ~= nil then
        TweenService:Create(v2, u146, {GroupTransparency = GroupTransparency}):Play()
    end
    a2.expiryToken = a2.expiryToken + 1
    local expiryToken = a2.expiryToken
    task.delay(a2.seconds, function() -- Line: 261 -- upvalues: expiryToken (val), a2 (val), retire (upval)
        if expiryToken == a2.expiryToken and a2.shownAt ~= nil and not a2.retiring then
            retire(a2)
        end
    end)
    local onShown = a2.onShown
    if onShown ~= nil then
        task.spawn(onShown, frame)
    end
end

local function capacityOf(a1) -- Line: 316 -- types: a1: table
    local Attribute = a1.holder:GetAttribute("Capacity")
    if typeof(Attribute) == "number" then
        return Attribute
    end
    return 3
end

local function pinnedBusy() -- Line: 321 -- upvalues: u73 (ref), u139 (val)
    if os.clock() < u73 then
        return true
    end
    local v1 = nil
    local v2 = nil
    for i, j in u139, v1, v2 do
        for k, n in j.live do
            if n.pinned then
                return true
            end
        end
    end
    return false
end

local function takeAdmissible(a1) -- Line: 335 -- upvalues: pinnedBusy (val), u143 (val) -- types: a1: table
    local v1
    local v2 = pinnedBusy()
    local v3 = false
    local v4 = nil
    local v5 = nil
    for i, j in a1.waiting, v4, v5 do
        v1 = u143.HoldsBack(j.delayInRound) or j.pinned and v2
        if not v1 then
            table.remove(v6.waiting, i)
            return j, v3
        else
            v3 = true
        end
    end
    return nil, v3
end

local function wake(a1, a2) -- Line: 350 -- upvalues: u74 (ref) -- types: a1: table, a2: number
    a1.wakeToken = a1.wakeToken + 1
    local wakeToken = a1.wakeToken
    task.delay(a2, function() -- Line: 353 -- upvalues: wakeToken (val), a1 (val), u74 (upval)
        if wakeToken == a1.wakeToken then
            u74(a1)
        end
    end)
end

local function pump(a1) -- Line: 360
    -- upvalues: u72 (ref), u74 (ref), takeAdmissible (val), admit (val)
    local Attribute, v1, v2, v3, wakeToken, wakeToken_2
    a1.wakeToken = a1.wakeToken + 1
    while true do
        if not (#a1.waiting > 0) then
            break
        end
        v1 = #a1.live
        Attribute = a1.holder:GetAttribute("Capacity")
        if not (v1 < (if typeof(Attribute) ~= "number" then 3 else Attribute)) then
            break
        end
        if a1.guarded and u72 > 0 then
            return
        end
        v1 = os.clock() - a1.lastAdmit
        if v1 < 0.14 then
            v2 = 0.14 - v1
            a1.wakeToken = a1.wakeToken + 1
            wakeToken = a1.wakeToken
            task.delay(v2, function() -- Line: 353 -- upvalues: wakeToken (val), a1 (val), u74 (upval)
                if wakeToken == a1.wakeToken then
                    u74(a1)
                end
            end)
            return
        end
        v2, v3 = takeAdmissible(a1)
        if v2 == nil then
            if v3 then
                a1.wakeToken = a1.wakeToken + 1
                wakeToken_2 = a1.wakeToken
                task.delay(0.4, function() -- Line: 353 -- upvalues: wakeToken_2 (val), a1 (val), u74 (upval)
                    if wakeToken_2 == a1.wakeToken then
                        u74(a1)
                    end
                end)
            end
            return
        end
        admit(a1, v2)
    end
end

function u74(a1) -- Line: 384 -- upvalues: pump (val) -- types: a1: table
    if a1.pumpPending then
        return
    end
    a1.pumpPending = true
    task.defer(function() -- Line: 389 -- upvalues: a1 (val), pump (upval)
        a1.pumpPending = false
        pump(a1)
    end)
end

local holder = u139.Banner.holder
local Position = holder.Position
local u107 = 0

local function isDisplayed(a1) -- Line: 399 -- types: a1: userdata
    local Parent = a1
    while Parent ~= nil do
        if Parent:IsA("LayerCollector") then
            break
        end
        if Parent:IsA("GuiObject") and not Parent.Visible then
            return false
        end
        Parent = Parent.Parent
    end
    local v1 = false
    if Parent ~= nil then
        v1 = Parent.Enabled == true
    end
    return v1
end

local function overlaps(a1, a2, a3, a4, a5) -- Line: 410
    -- upvalues: 
    local AbsolutePosition = a1.AbsolutePosition
    local v1 = AbsolutePosition + a1.AbsoluteSize
    local v2 = false
    if AbsolutePosition.X < a4 then
        v2 = false
        if a2 < v1.X then
            v2 = false
            if AbsolutePosition.Y < a5 then
                v2 = a3 < v1.Y
            end
        end
    end
    return v2
end

local function lowestBlockerEdge(a1, a2, a3, a4, a5) -- Line: 416
    -- upvalues: CollectionService (val), isDisplayed (val)
    local AbsolutePosition, v1, v2
    local v3 = a3
    local v4, v5, v6, v7, v8 = a1, a4, a2, a5, a3
    for i, j in CollectionService:GetTagged("TopNotificationBlocker") do
        if j:IsA("GuiObject") and j:IsDescendantOf(v4) and isDisplayed(j) then
            AbsolutePosition = j.AbsolutePosition
            v2 = AbsolutePosition + j.AbsoluteSize
            v1 = false
            if AbsolutePosition.X < v5 then
                v1 = false
                if v6 < v2.X then
                    v1 = false
                    if AbsolutePosition.Y < v7 then
                        v1 = v8 < v2.Y
                    end
                end
            end
            if v1 then
                v3 = math.max(v3, j.AbsolutePosition.Y + j.AbsoluteSize.Y)
            end
        end
    end
    return v3
end

local function refreshClearance(a1) -- Line: 431
    -- upvalues: u152 (val), holder (val), Position (val), lowestBlockerEdge (val), u107 (ref), TweenService (val)
    -- upvalues: u149 (val)
    local Y = u152.AbsoluteSize.Y
    if Y <= 0 then
        return
    end
    local Y_2 = holder.AbsoluteSize.Y
    local v1 = u152.AbsolutePosition.Y + Position.Y.Scale * Y + Position.Y.Offset - holder.AnchorPoint.Y * Y_2
    local X = holder.AbsolutePosition.X
    local v2 = math.max((lowestBlockerEdge(a1, X, v1, X + holder.AbsoluteSize.X, v1 + Y_2)) - v1, 0) / Y
    if v2 > 0 then
        v2 = v2 + Y_2 * 0.12 / Y
    end
    if (math.abs(v2 - u107)) < 0.0025 then
        return
    end
    u107 = v2
    TweenService:Create(holder, u149, {Position = Position + UDim2.fromScale(0, v2)}):Play()
end

function v3.Schedule(a1) -- Line: 461 -- upvalues: u139 (val), u71 (val), finalize (val), u74 (ref) -- types: a1: table
    if typeof(a1) ~= "table" then
        error(("Lanes.Schedule expects an entry table, got %*"):format((typeof(a1))), 2)
    end
    local v1 = u139[a1.Lane]
    if v1 == nil then
        error(("unknown notification lane %*"):format((tostring(a1.Lane))), 2)
    end
    local Frame = a1.Frame
    if typeof(Frame) ~= "Instance" or not Frame:IsA("GuiObject") then
        error("a notification needs a GuiObject to show", 2)
    end
    local Seconds = a1.Seconds
    if Seconds ~= nil and typeof(Seconds) ~= "number" then
        error(("notification entry field Seconds expects a number, got %*"):format((typeof(Seconds))), 3)
    end
    local UniqueKey = a1.UniqueKey
    if UniqueKey ~= nil and typeof(UniqueKey) ~= "string" then
        error(("notification entry field UniqueKey expects a string, got %*"):format((typeof(UniqueKey))), 3)
    end
    local DelayInRound = a1.DelayInRound
    if DelayInRound ~= nil and typeof(DelayInRound) ~= "boolean" then
        error(("notification entry field DelayInRound expects a boolean, got %*"):format((typeof(DelayInRound))), 3)
    end
    local OnShown = a1.OnShown
    if OnShown ~= nil and typeof(OnShown) ~= "function" then
        error(("notification entry field OnShown expects a function, got %*"):format((typeof(OnShown))), 3)
    end
    local OnRetired = a1.OnRetired
    if OnRetired ~= nil and typeof(OnRetired) ~= "function" then
        error(("notification entry field OnRetired expects a function, got %*"):format((typeof(OnRetired))), 3)
    end
    local v2 = #v1.waiting
    if not (v2 >= 24) then
        local UniqueKey_2 = a1.UniqueKey
        if UniqueKey_2 == nil then
            v2 = true
        elseif not u71[UniqueKey_2] then
            u71[UniqueKey_2] = true
            v2 = true
        else
            v2 = false
        end
        if v2 then
            local Attribute = Frame:GetAttribute("SammyDialogue")
            local u150 = {retiring = false, destroyed = false, expiryToken = 0, frame = Frame}
            u150.seconds = a1.Seconds or 3
            u150.uniqueKey = a1.UniqueKey
            u150.delayInRound = a1.DelayInRound == true
            u150.laneId = v1.id
            u150.onShown = a1.OnShown
            u150.onRetired = a1.OnRetired
            local v3 = false
            if Attribute ~= nil then
                v3 = Attribute ~= false
            end
            u150.pinned = v3
            table.insert(v1.waiting, u150)
            u150.frame.Destroying:Connect(function() -- Line: 269 -- upvalues: u150 (val), finalize (upval)
                u150.destroyed = true
                if u150.retiring then
                    return
                end
                u150.retiring = true
                local v1 = u150
                v1.expiryToken = v1.expiryToken + 1
                task.defer(finalize, u150)
            end)
            u74(v1)
            return true
        end
    end
    return false
end

function v3.HoldBanner() -- Line: 505 -- upvalues: u72 (ref), u74 (ref), u139 (val)
    u72 = u72 + 1
    local u2 = false
    return function() -- Line: 508 -- upvalues: u2 (ref), u72 (upval), u74 (upval), u139 (upval)
        if u2 then
            return
        end
        u2 = true
        u72 = u72 - 1
        u74(u139.Banner)
    end
end

function v3.IsBannerShowing() -- Line: 518 -- upvalues: u139 (val)
    return #u139.Banner.live > 0
end

task.spawn(function() -- Line: 522 -- upvalues: Players (val), refreshClearance (val)
    local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
    while true do
        task.wait(0.25)
        refreshClearance(PlayerGui)
    end
end)
return (table.freeze(v3))