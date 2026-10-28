-- Script path: ReplicatedStorage.Client.Message
-- Decompile time: 10.55 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Shared.Audio)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local GUI = require(ReplicatedStorage.Client.GUI)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local u31 = {Notice = true, Warn = true, Confirm = true}
local u32 = {Confirm = "Prompt", Notice = "Notice", Warn = "Failure"}

local function child(a1, a2) -- Line: 55 -- types: a1: userdata, a2: string
    local v1 = a1:FindFirstChild(a2)
    assert(v1, (("%* is missing %*"):format(a1:GetFullName(), a2)))
    return v1
end

local u35 = GUI.Message()
local Frame = u35:FindFirstChild("Frame")
assert(Frame, (("%* is missing Frame"):format((u35:GetFullName()))))
local Contents = Frame:FindFirstChild("Contents")
assert(Contents, (("%* is missing Contents"):format((Frame:GetFullName()))))
local u64 = {}
local Accept = Contents:FindFirstChild("Accept")
assert(Accept, (("%* is missing Accept"):format((Contents:GetFullName()))))
u64.accept = Accept
local Acknowledge = Contents:FindFirstChild("Acknowledge")
assert(Acknowledge, (("%* is missing Acknowledge"):format((Contents:GetFullName()))))
u64.acknowledge = Acknowledge
local Decline = Contents:FindFirstChild("Decline")
assert(Decline, (("%* is missing Decline"):format((Contents:GetFullName()))))
u64.decline = Decline
local Close = Frame:FindFirstChild("Close")
assert(Close, (("%* is missing Close"):format((Frame:GetFullName()))))
u64.dismiss = Close
local u121 = {}
local Top = Frame:FindFirstChild("Top")
assert(Top, (("%* is missing Top"):format((Frame:GetFullName()))))
local v1 = Top:FindFirstChild("Title")
assert(v1, (("%* is missing Title"):format((Top:GetFullName()))))
u121.heading = v1
local IllustratedBody = Contents:FindFirstChild("IllustratedBody")
assert(IllustratedBody, (("%* is missing IllustratedBody"):format((Contents:GetFullName()))))
u121.illustrated = IllustratedBody
local Body = Contents:FindFirstChild("Body")
assert(Body, (("%* is missing Body"):format((Contents:GetFullName()))))
u121.plain = Body
local u183 = Contents:FindFirstChild("Artwork")
assert(u183, (("%* is missing Artwork"):format((Contents:GetFullName()))))
local u194 = {}
local u195 = {}
local u196 = nil
local u197 = false

local function present(a1) -- Line: 88 -- upvalues: u64 (val), u183 (val), u121 (val) -- types: a1: table
    local v1 = a1.kind == "Confirm"
    local v2 = a1.image ~= nil
    u64.accept.Visible = v1
    u64.decline.Visible = v1
    u64.acknowledge.Visible = not v1
    u64.dismiss.Visible = true
    u183.Image = a1.image or ""
    u183.Visible = v2
    u121.illustrated.Visible = v2
    u121.plain.Visible = not v2
    u121.illustrated.Text = a1.body
    u121.plain.Text = a1.body
    u121.heading.Text = if a1.kind ~= "Warn" then a1.heading or "Heads up!" else "Uh-oh!"
end

local function releaseActivation(a1) -- Line: 109
    if typeof(a1) ~= "table" then
        return
    end
    for i, j in a1 do
        if typeof(j) == "RBXScriptConnection" then
            j:Disconnect()
        end
    end
    if typeof(a1.Disconnect) == "function" then
        a1:Disconnect()
    end
end

local function resumeIfWaiting(a1, ...) -- Line: 123 -- types: a1: thread
    if coroutine.status(a1) == "suspended" then
        task.spawn(a1, ...)
    end
end

local function awaitVerdict(a1) -- Line: 129
    -- upvalues: releaseActivation (val), resumeIfWaiting (val), GUI (val), u64 (val), u35 (val)
    local u2 = coroutine.running()
    local u3 = false
    local u4 = nil
    local u5 = {}
    local u6 = {}

    local function settle(a1) -- Line: 136
        -- upvalues: u3 (ref), u4 (ref), u5 (val), releaseActivation (upval), u6 (val), resumeIfWaiting (upval)
        -- upvalues: u2 (val)
        if u3 then
            return
        end
        u3 = true
        u4 = a1
        for i, j in u5 do
            releaseActivation(j)
        end
        for k, n in u6 do
            n:Disconnect()
        end
        resumeIfWaiting(u2)
    end

    local function bind(a1, a2) -- Line: 151
        -- upvalues: u5 (val), GUI (upval), settle (val)
        table.insert(u5, (GUI.OnActivated(a1, function() -- Line: 152 -- upvalues: settle (upval), a2 (val)
            settle(a2)
        end)))
    end

    local u10 = if not a1 then nil else false
    local accept = u64.accept
    local OnActivated = GUI.OnActivated
    local u18 = true
    table.insert(u5, (OnActivated(accept, function() -- Line: 152 -- upvalues: settle (val), u18 (val)
        settle(u18)
    end)))
    local decline = u64.decline
    local OnActivated_2 = GUI.OnActivated
    local u30 = false
    table.insert(u5, (OnActivated_2(decline, function() -- Line: 152 -- upvalues: settle (val), u30 (val)
        settle(u30)
    end)))
    local acknowledge = u64.acknowledge
    local OnActivated_3 = GUI.OnActivated
    local u41 = nil
    table.insert(u5, (OnActivated_3(acknowledge, function() -- Line: 152 -- upvalues: settle (val), u41 (val)
        settle(u41)
    end)))
    local dismiss = u64.dismiss
    table.insert(u5, (GUI.OnActivated(dismiss, function() -- Line: 152 -- upvalues: settle (val), u10 (val)
        settle(u10)
    end)))
    table.insert(u6, ((u35:GetPropertyChangedSignal("Enabled")):Connect(function() -- Line: 162 -- upvalues: u35 (upval), settle (val), u10 (val)
        if not u35.Enabled then
            settle(u10)
        end
    end)))
    if not u3 then
        coroutine.yield()
    end
    return u4
end

local function ask(a1) -- Line: 174
    -- upvalues: present (val), Tabs (val), Audio (val), u32 (val), awaitVerdict (val)
    present(a1)
    if not Tabs.IsActive("Message") and not Tabs.Activate("Message") then
        return nil, false
    end
    Audio.Chime(u32[a1.kind])
    return (awaitVerdict(a1.kind == "Confirm")), true
end

local function drain() -- Line: 186
    -- upvalues: u197 (ref), Tabs (val), u195 (val), u196 (ref), ask (val), resumeIfWaiting (val)
    local v1, v2, v3, v4
    if u197 then
        return
    end
    u197 = true
    local v5 = Tabs.Active()
    if v5 == "Message" then
        v5 = nil
    end
    while true do
        v1 = table.remove(u195, 1)
        if v1 == nil then
            break
        end
        u196 = v1
        v2, v3 = ask(v1)
        u196 = nil
        if #u195 == 0 then
            u197 = false
            if v3 then
                if v5 == nil or v1.leaveClosed then
                    Tabs.Deactivate()
                else
                    Tabs.Activate(v5, {instant = true})
                end
            end
        end
        resumeIfWaiting(v1.waiter, v2)
        if v4 then
            return
        end
    end
    u197 = false
end

local function alreadyQueued(a1, a2) -- Line: 224 -- upvalues: u196 (ref), u195 (val) -- types: a1: string, a2: string
    if u196 and u196.body == a1 and u196.kind == a2 then
        return true
    end
    for i, j in u195 do
        if j.body == a1 and j.kind == a2 then
            return true
        end
    end
    return false
end

function u194.Show(a1) -- Line: 241
    -- upvalues: u31 (val), Save (val), alreadyQueued (val), u195 (val), drain (val)
    assert(type(a1) == "table", "dialog request must be a table")
    local Body = a1.Body
    assert(type(Body) == "string", "dialog body must be a string")
    local v1 = a1.Kind or "Notice"
    assert(u31[v1] == true, (("unknown dialog kind %*"):format((tostring(v1)))))
    if Save.Await() == nil then
        return nil
    end
    if not alreadyQueued(Body, v1) and not (#u195 >= 3) then
        table.insert(u195, {
            body = Body,
            kind = v1,
            heading = a1.Heading,
            image = a1.Image,
            leaveClosed = a1.LeaveClosed == true,
            waiter = coroutine.running(),
        })
        task.spawn(drain)
        return (coroutine.yield())
    end
    return nil
end

local function withBody(a1, a2, a3) -- Line: 267 -- types: a1: string, a2: string, a3: table?
    local v1 = if a3 == nil then {} else table.clone(a3)
    v1.Body = a1
    v1.Kind = a2
    return v1
end

function u194.Notice(a1, a2) -- Line: 275 -- upvalues: u194 (val) -- types: a1: string, a2: table?
    local Show = u194.Show
    local v1 = if a2 == nil then {} else table.clone(a2)
    v1.Body = a1
    v1.Kind = "Notice"
    Show(v1)
end

function u194.Warn(a1, a2) -- Line: 280 -- upvalues: u194 (val) -- types: a1: string, a2: table?
    local Show = u194.Show
    local v1 = if a2 == nil then {} else table.clone(a2)
    v1.Body = a1
    v1.Kind = "Warn"
    Show(v1)
end

function u194.Confirm(a1, a2) -- Line: 286 -- upvalues: u194 (val) -- types: a1: string, a2: table?
    local Show = u194.Show
    local v1 = if a2 == nil then {} else table.clone(a2)
    v1.Body = a1
    v1.Kind = "Confirm"
    return Show(v1)
end

function u194.WarnGeneric() -- Line: 290 -- upvalues: u194 (val)
    u194.Warn("That didn't go through. Please try again in a moment.")
end

u121.illustrated.RichText = true
u121.plain.RichText = true
u35:SetAttribute("ModalDialog", true)
for i, j in {u64.acknowledge, u64.accept, u64.decline, u64.dismiss} do
    ButtonFX(j)
end
Remotes.Toasts.Line.OnClientEvent:Connect(function(a1) -- Line: 304 -- upvalues: u194 (val)
    if typeof(a1) == "table" and typeof(a1.Body) == "string" then
        local v1 = table.clone(a1)
        if v1.Kind ~= "Warn" then
            v1.Kind = "Notice"
        end
        u194.Show(v1)
        return
    end
    warn((("Toasts.Line expects a dialog request table, got %*"):format((typeof(a1)))))
end)

function Remotes.Haul.OfferFullSatchelSale.OnClientInvoke(a1) -- Line: 316 -- upvalues: u194 (val) -- types: a1: string
    return u194.Confirm(a1) == true
end

return (table.freeze(u194))