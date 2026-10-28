-- Script path: ReplicatedStorage.Controllers.Game.StarHandlerController
-- Decompile time: 11.14 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local NpcDialogue = require(ReplicatedStorage.Client.UI.NpcDialogue)
local EggHolders = require(script.EggHolders)
local Shop = require(script.Shop)
local Save = require(ReplicatedStorage.Shared.Save)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u46 = {"BillboardGui", "SurfaceGui", "ParticleEmitter", "Beam", "Trail", "Light", "Highlight"}
local u54 = {
    "Oh! Hello there, little egg-snatcher!",
    "I'm the Star Handler. I look after the stars that fall from the night sky.",
    "Feed one of my stars to a pet and it grows into a powerful mount!",
    "What can I do for you?",
}
local u59 = {"Welcome back, starlight! What can I do for you?"}
local u61 = {"Ooh, good eye! Every one of these was caught by hand~"}
local u63 = {
    "Every night there's a rare chance of a Star Drop!",
    "When it happens, a little star falls for every player in the server.",
    "Find yours, hold on tight to catch it, and it's yours for free!",
    "Keep your eyes on the sky after dark~",
}
local u68 = {
    "Stars are little pieces of the night sky!",
    "Hold one near a pet in your base and feed it to them.",
    "Your pet grows into a mount, so you can hop on and ride it!",
}
local u72 = {"Anything else, starlight?"}
local u74 = {"Come back anytime! The stars will be waiting~"}
local u76 = {
    {Text = "View Stars", Echo = "Can I see your stars?", Key = "Stars"},
    {Text = "What is a Star?", Echo = "What are Stars?", Key = "Star"},
    {Text = "Star Drop Event?", Echo = "What's a Star Drop?", Key = "Event"},
    {Text = "Bye!", Echo = "Bye!", Key = "Bye"},
}
local LocalPlayer = Players.LocalPlayer
local u82 = nil
local u83 = false
local u84 = true
local u85 = {}
local u89 = setmetatable({}, {__mode = "k"})
local v1 = {}

local function idleTrack(a1) -- Line: 73 -- types: a1: userdata
    local AnimationController = a1:FindFirstChildOfClass("AnimationController")
    local Animator = AnimationController
    if Animator then
        Animator = AnimationController:FindFirstChildOfClass("Animator")
    end
    local v1 = a1:FindFirstChild("Animations")
    local Idle = v1
    if Idle then
        Idle = v1:FindFirstChild("Idle")
    end
    if Animator ~= nil and Idle ~= nil and Idle:IsA("Animation") then
        local success, err = pcall(function() -- Line: 81 -- upvalues: Animator (val), Idle (val)
            return Animator:LoadAnimation(Idle)
        end)
        if success and err ~= nil then
            err.Looped = true
            err:Play(0)
            return err
        end
        return nil
    end
    return nil
end

local function chatter(a1, a2) -- Line: 92 -- upvalues: ReplicatedStorage (val) -- types: a1: userdata, a2: number
    local Assets = ReplicatedStorage:FindFirstChild("Assets")
    local ShootingStar = Assets and Assets:FindFirstChild("ShootingStar")
    local v1 = ShootingStar and ShootingStar:FindFirstChild("Sounds")
    local BuddyChatter1 = v1 and v1:FindFirstChild("BuddyChatter1")
    if BuddyChatter1 ~= nil and BuddyChatter1:IsA("Sound") and a1.PrimaryPart ~= nil then
        local u37 = BuddyChatter1:Clone()
        u37.PlaybackSpeed = a2
        u37.Parent = a1.PrimaryPart
        u37:Play()
        u37.Ended:Once(function() -- Line: 104 -- upvalues: u37 (val)
            u37:Destroy()
        end)
        return
    end
end

local function attend(a1, a2) -- Line: 109 -- upvalues: RunService (val), LocalPlayer (val) -- types: a1: userdata
    local Pivot = a1:GetPivot()
    local u6 = os.clock()
    local u7 = 0
    a2:Add(function() -- Line: 113 -- upvalues: a1 (val), Pivot (val)
        a1:PivotTo(Pivot)
    end)
    a2:Connect(RunService.RenderStepped, function(a1_2) -- Line: 116
        -- upvalues: LocalPlayer (upval), Pivot (val), u7 (ref), u6 (val), a1 (val)
        local Character = LocalPlayer.Character
        local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
            local v1 = (HumanoidRootPart.Position - Pivot.Position) * Vector3.new(1, 0, 1)
            if 0.1 < v1.Magnitude then
                local v2 = ((math.atan2(-v1.X, -v1.Z)) - ((math.atan2(-Pivot.LookVector.X, -Pivot.LookVector.Z)) + u7) + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
                u7 = u7 + v2 * (1 - math.exp(a1_2 * -8))
            end
        end
        local v3 = math.clamp(((os.clock()) - u6) / 0.32, 0, 1)
        a1:PivotTo((CFrame.new(Pivot.Position + Vector3.new(0, v3 * 4 * (1 - v3) * 0.9, 0))) * CFrame.Angles(0, u7, 0) * Pivot.Rotation)
    end)
end

local function converse(a1, a2) -- Line: 139
    -- upvalues: u82 (ref), Trove (val), NpcDialogue (val), attend (val), chatter (val), u83 (ref), u59 (val), u54 (val)
    -- upvalues: u76 (val), u61 (val), Shop (val), u68 (val), u72 (val), u63 (val), u74 (val)
    if u82 then
        u82:Close()
    end
    local u9 = Trove.new()
    local u18 = NpcDialogue.new(a1, a2, function() -- Line: 144 -- upvalues: u9 (val)
        u9:Destroy()
    end, {Voiced = true, KeepOpenTab = "StarBundles"})
    u82 = u18
    u9:Add(function() -- Line: 148 -- upvalues: u82 (upval), u18 (val)
        if u82 == u18 then
            u82 = nil
        end
    end)
    attend(a1, u9)
    chatter(a1, 0.95)
    task.spawn(function() -- Line: 156
        -- upvalues: u83 (upval), u59 (upval), u54 (upval), u18 (val), u76 (upval), u61 (upval), Shop (upval)
        -- upvalues: chatter (upval), a1 (val), u68 (upval), u72 (upval), u63 (upval), u74 (upval)
        local v1 = if not u83 then u54 else u59
        u83 = true
        if not u18:Say(v1) then
            return
        end
        while not u18.Closed do
            v1 = u18:Ask(u76)
            if v1 == "Stars" then
                u18:Say(u61)
                u18:Close()
                Shop.Open()
                return
            end
            if v1 == "Star" then
                chatter(a1, 1)
                if u18:Say(u68) and u18:Say(u72) then
                    continue
                end
                return
            end
            if v1 == "Event" then
                chatter(a1, 1.05)
                if u18:Say(u63) and u18:Say(u72) then
                    continue
                end
                return
            end
            if v1 == "Bye" then
                chatter(a1, 1.1)
                u18:Say(u74)
            end
            u18:Close()
            return
        end
    end)
end

local function concealed() -- Line: 191 -- upvalues: u84 (ref), EggHolders (val)
    return u84 or EggHolders.IsActive()
end

local function concealedFor(a1) -- Line: 195 -- upvalues: u84 (ref), EggHolders (val) -- types: a1: userdata
    if not a1:HasTag("StarHandlerProp") then
        return u84 or EggHolders.IsActive()
    end
    local v1 = u84
    if v1 then
        return not EggHolders.IsActive()
    end
    return v1
end

local function concealNode(a1, a2) -- Line: 199 -- upvalues: u89 (val), u46 (val) -- types: a1: userdata, a2: boolean
    local v1 = u89[a1]
    if a2 and v1 == nil then
        if a1:IsA("BasePart") then
            u89[a1] = {CanCollide = a1.CanCollide}
            a1.CanCollide = false
            a1.LocalTransparencyModifier = 1
            return
        end
        if a1:IsA("Decal") then
            u89[a1] = {}
            a1.LocalTransparencyModifier = 1
            return
        end
        for i, j in u46 do
            if a1:IsA(j) then
                u89[a1] = {Enabled = a1.Enabled}
                a1.Enabled = false
                return
            end
        end
        return
    end
    if not a2 and v1 ~= nil then
        u89[a1] = nil
        if a1:IsA("BasePart") then
            a1.CanCollide = v1.CanCollide
            a1.LocalTransparencyModifier = 0
            return
        end
        if a1:IsA("Decal") then
            a1.LocalTransparencyModifier = 0
            return
        end
        if v1.Enabled ~= nil then
            a1.Enabled = v1.Enabled
        end
    end
end

local function conceal(a1) -- Line: 231
    -- upvalues: u84 (ref), EggHolders (val), concealNode (val), u85 (val)
    local v1 = if not a1:HasTag("StarHandlerProp") then u84 or EggHolders.IsActive() else u84 and not EggHolders.IsActive()
    a1:SetAttribute("StarHandlerLocallyHidden", if not v1 then nil else true)
    concealNode(a1, v1)
    for i, j in a1:GetDescendants() do
        concealNode(j, v1)
    end
    local v2 = if not a1:IsA("Model") then nil else u85[a1]
    if v2 then
        v2.Enabled = not v1
    end
end

local function concealAll() -- Line: 244 -- upvalues: CollectionService (val), conceal (val)
    for i, j in CollectionService:GetTagged("StarHandlerNpc") do
        if j:IsA("Model") then
            conceal(j)
        end
    end
    for k, n in CollectionService:GetTagged("StarHandlerProp") do
        conceal(n)
    end
end

local function bind(a1) -- Line: 255
    -- upvalues: conceal (val), idleTrack (val), u84 (ref), EggHolders (val), u85 (val), converse (val), Workspace (val)
    if a1:IsA("Model") and a1.PrimaryPart ~= nil then
        conceal(a1)
        idleTrack(a1)
        local PrimaryPart = a1.PrimaryPart
        local InteractionPoint = PrimaryPart:FindFirstChild("InteractionPoint")
        local ProximityPrompt = Instance.new("ProximityPrompt")
        ProximityPrompt.Name = "StarHandlerPrompt"
        ProximityPrompt.ActionText = "Talk"
        ProximityPrompt.ObjectText = "Star Handler"
        ProximityPrompt.HoldDuration = 0
        ProximityPrompt.MaxActivationDistance = 10
        ProximityPrompt.RequiresLineOfSight = false
        ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom
        ProximityPrompt.Enabled = not (u84 or EggHolders.IsActive())
        ProximityPrompt.Parent = if not InteractionPoint then PrimaryPart else if not InteractionPoint:IsA("Attachment") then PrimaryPart else InteractionPoint
        u85[a1] = ProximityPrompt
        ProximityPrompt.Triggered:Connect(function() -- Line: 274 -- upvalues: converse (upval), a1 (val), ProximityPrompt (val)
            converse(a1, ProximityPrompt)
        end)
        a1.AncestryChanged:Connect(function() -- Line: 277 -- upvalues: a1 (val), Workspace (upval), u85 (upval), ProximityPrompt (val)
            if not a1:IsDescendantOf(Workspace) then
                if u85[a1] == ProximityPrompt then
                    u85[a1] = nil
                end
                ProximityPrompt:Destroy()
            end
        end)
        return
    end
end

function v1.Start() -- Line: 291
    -- upvalues: Shop (val), CollectionService (val), bind (val), conceal (val), Save (val), u84 (ref), concealAll (val)
    -- upvalues: EggHolders (val), u82 (ref)
    Shop.Initialize()
    ;(CollectionService:GetInstanceAddedSignal("StarHandlerNpc")):Connect(bind)
    for i, j in CollectionService:GetTagged("StarHandlerNpc") do
        task.spawn(bind, j)
    end
    ;(CollectionService:GetInstanceAddedSignal("StarHandlerProp")):Connect(conceal)
    for k, n in CollectionService:GetTagged("StarHandlerProp") do
        conceal(n)
    end
    task.spawn(function() -- Line: 301 -- upvalues: Save (upval), u84 (upval), concealAll (upval)
        local v1 = Save.Await()
        local v2 = false
        if v1 ~= nil then
            v2 = v1.LastLogout == 0
        end
        u84 = v2
        concealAll()
    end)
    EggHolders.Changed(function(a1) -- Line: 306 -- upvalues: u82 (upval), concealAll (upval) -- types: a1: boolean
        if a1 and u82 then
            u82:Close()
        end
        concealAll()
    end)
    EggHolders.Start()
end

function v1.CloseShop() -- Line: 315 -- upvalues: Shop (val)
    Shop.Close()
end

return v1