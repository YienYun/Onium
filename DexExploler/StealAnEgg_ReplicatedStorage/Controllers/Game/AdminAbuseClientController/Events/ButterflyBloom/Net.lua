-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.Events.ButterflyBloom.Net
-- Decompile time: 9.14 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Workspace")
local AnimationAssets = require(ReplicatedStorage.Shared.Utils.AnimationAssets)
local ButterflyCatalog = require(ReplicatedStorage.Shared.Modules.ButterflyCatalog)
local ButterflyFlags = require(ReplicatedStorage.Shared.Flags.ButterflyFlags)
local CatchFX = require(script.Parent.CatchFX)
local Player = require(ReplicatedStorage.Shared.Player)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Swarm = require(script.Parent.Swarm)
local Trove = require(ReplicatedStorage.Packages.Trove)
local LocalPlayer = Players.LocalPlayer
local u65 = ((ReplicatedStorage:WaitForChild("Assets")):WaitForChild("VFX")):WaitForChild("Butterflies")
local u68 = Trove.new()
local u70 = Trove.new()
local u71 = nil
local u72 = nil
local u73 = 0
local u74 = nil
local u75 = nil
local u76 = nil
local u77 = nil
local u78 = false
local v1 = {}

local function hoopOf(a1) -- Line: 48 -- types: a1: userdata
    local Hoop = a1:FindFirstChild("Hoop", true)
    if Hoop and Hoop:IsA("BasePart") then
        return Hoop
    end
    local Handle = a1:FindFirstChild("Handle")
    if Handle and Handle:IsA("BasePart") then
        return Handle
    end
    return nil
end

local function trackFor() -- Line: 57 -- upvalues: u72 (ref), Player (val), LocalPlayer (val), AnimationAssets (val)
    if u72 and u72.Parent then
        return u72
    end
    local v1 = Player.FindAnimator(LocalPlayer)
    if v1 == nil then
        return nil
    end
    local v2 = v1:LoadAnimation((AnimationAssets.Get("rbxassetid://79127239282844")))
    v2.Priority = Enum.AnimationPriority.Action2
    v2.Looped = false
    u72 = v2
    return v2
end

local function reticle() -- Line: 72 -- upvalues: u74 (ref), u65 (val), LocalPlayer (val), u75 (ref), u76 (ref)
    if u74 and u74.Parent then
        return u74
    end
    local Reticle = u65:FindFirstChild("Reticle")
    if Reticle ~= nil and Reticle:IsA("BillboardGui") then
        local v1 = Reticle:Clone()
        v1.Enabled = false
        v1.Parent = LocalPlayer:WaitForChild("PlayerGui")
        local v2 = v1:FindFirstChild("Ring", true)
        u74 = v1
        v1:FindFirstChildWhichIsA("UIScale", true)
        u76 = if not v2 then nil else v2:FindFirstChildOfClass("UIStroke")
        return v1
    end
    return nil
end

local function hideReticle() -- Line: 90 -- upvalues: u77 (ref), u74 (ref)
    u77 = nil
    if u74 then
        u74.Enabled = false
        u74.Adornee = nil
    end
end

local function targetFrom(a1) -- Line: 98
    -- upvalues: u78 (ref), Swarm (val), ButterflyFlags (val)
    if not u78 then
        return nil
    end
    return Swarm.Nearest(a1.Position, a1.CFrame.LookVector, ButterflyFlags.NetReach:Get())
end

local function swing() -- Line: 105
    -- upvalues: u71 (ref), u73 (ref), ButterflyFlags (val), Player (val), LocalPlayer (val), u72 (ref)
    -- upvalues: AnimationAssets (val), CatchFX (val), u78 (ref), Swarm (val), Remotes (val), ButterflyCatalog (val)
    local u32, v1
    local u0 = u71
    if u0 == nil then
        return
    end
    local v2 = os.clock()
    if v2 - u73 < ButterflyFlags.SwingCooldownSeconds:Get() then
        return
    end
    u73 = v2
    v2 = Player.FindRootPart(LocalPlayer)
    if v2 == nil then
        return
    end
    if not u72 or not u72.Parent then
        v1 = Player.FindAnimator(LocalPlayer)
        if v1 ~= nil then
            local v3 = v1:LoadAnimation((AnimationAssets.Get("rbxassetid://79127239282844")))
            v3.Priority = Enum.AnimationPriority.Action2
            v3.Looped = false
            u72 = v3
            u32 = v3
        else
            u32 = nil
        end
    else
        u32 = u72
    end
    if u32 then
        u32:Play(0.05, 1, 1.25)
    end
    CatchFX.Swing(v2)
    if (if u78 then Swarm.Nearest(v2.Position, v2.CFrame.LookVector, ButterflyFlags.NetReach:Get()) else nil) == nil then
        return
    end
    local Id = v1.Flight.Id
    local Tier = v1.Flight.Tier
    task.delay(0.09, function() -- Line: 130 -- upvalues: Swarm (upval), Id (val), CatchFX (upval)
        local v1 = Swarm.Get(Id)
        if v1 then
            CatchFX.Contact(v1)
        end
    end)
    task.spawn(function() -- Line: 136
        -- upvalues: Remotes (upval), Id (val), u0 (val), Tier (val), Swarm (upval), CatchFX (upval)
        -- upvalues: ButterflyCatalog (upval), u32 (val)
        local u27
        local success, err, v1, u5 = pcall(function() -- Line: 137 -- upvalues: Remotes (upval), Id (upval)
            local v1 = Id
            return Remotes.Butterflies.AskSwing:InvokeServer(v1)
        end)
        if not success then
            return
        end
        local v2 = u0
        local Hoop = v2:FindFirstChild("Hoop", true)
        if not Hoop or not Hoop:IsA("BasePart") then
            local Handle = v2:FindFirstChild("Handle")
            u27 = if not Handle then nil else if not Handle:IsA("BasePart") then nil else Handle
        else
            u27 = Hoop
        end
        local u32_2 = v1
        if not u32_2 then
            u32_2 = Tier
        end
        if err == "Caught" then
            local u41 = Swarm.Take(Id)
            CatchFX.Snag(u41, u32_2, u27, true)
            task.delay(ButterflyCatalog.SnagSeconds, function() -- Line: 148 -- upvalues: CatchFX (upval), u41 (val), u32_2 (val), u5 (val), u32 (upval), u27 (val)
                CatchFX.Caught(u41, u32_2, u5, u32, u27)
            end)
            return
        end
        if err ~= "Escaped" then
            if err == "Gone" then
                Swarm.Remove(Id)
            end
            return
        end
        if u27 then
            Swarm.Pin(Id, u27.Position, ButterflyCatalog.SnagSeconds)
        end
        CatchFX.Snag(Swarm.Get(Id), u32_2, u27, false)
        task.delay(ButterflyCatalog.SnagSeconds, function() -- Line: 156 -- upvalues: CatchFX (upval), Swarm (upval), Id (upval), u32_2 (val)
            CatchFX.Escaped(Swarm.Get(Id), u32_2)
        end)
    end)
end

local function autoSwing() -- Line: 165 -- upvalues: ButterflyFlags (val), u73 (ref), swing (val)
    if not ButterflyFlags.AutoSwing:Get() then
        return
    end
    local v1 = math.max(ButterflyFlags.SwingCooldownSeconds:Get(), (ButterflyFlags.AutoSwingCooldownSeconds:Get()))
    if os.clock() - u73 < v1 then
        return
    end
    swing()
end

local function bindTool(a1) -- Line: 179
    -- upvalues: u70 (val), u71 (ref), swing (val), LocalPlayer (val), u77 (ref), u74 (ref)
    u70:Clean()
    u71 = a1
    u70:Connect(a1.Activated, swing)
    u70:Connect(a1.AncestryChanged, function() -- Line: 183 -- upvalues: a1 (val), LocalPlayer (upval), u70 (upval)
        if a1.Parent ~= LocalPlayer.Character then
            u70:Clean()
        end
    end)
    u70:Add(function() -- Line: 188 -- upvalues: u71 (upval), a1 (val), u77 (upval), u74 (upval)
        if u71 == a1 then
            u71 = nil
        end
        u77 = nil
        if u74 then
            u74.Enabled = false
            u74.Adornee = nil
        end
    end)
end

local function onCharacterChild(a1) -- Line: 196 -- upvalues: bindTool (val) -- types: a1: userdata
    if a1:IsA("Tool") and a1:GetAttribute("ButterflyNet") == true then
        bindTool(a1)
    end
end

local function onCharacter(a1) -- Line: 202
    -- upvalues: u68 (val), u70 (val), u72 (ref), onCharacterChild (val), bindTool (val)
    u68:Clean()
    u70:Clean()
    u72 = nil
    u68:Connect(a1.ChildAdded, onCharacterChild)
    for i, j in a1:GetChildren() do
        if j:IsA("Tool") and j:GetAttribute("ButterflyNet") == true then
            bindTool(j)
        end
    end
end

function v1.SetPresenting(a1) -- Line: 216 -- upvalues: u78 (ref), u77 (ref), u74 (ref) -- types: a1: boolean
    u78 = a1
    if not a1 then
        u77 = nil
        if u74 then
            u74.Enabled = false
            u74.Adornee = nil
        end
    end
end

function v1.Step(a1) -- Line: 223
    -- upvalues: Player (val), LocalPlayer (val), u71 (ref), u78 (ref), u77 (ref), u74 (ref), Swarm (val)
    -- upvalues: ButterflyFlags (val), reticle (val), u76 (ref), u75 (ref), autoSwing (val)
    local v1 = Player.FindRootPart(LocalPlayer)
    if u71 ~= nil and v1 ~= nil and u78 then
        local v2 = if u78 then Swarm.Nearest(v1.Position, v1.CFrame.LookVector, ButterflyFlags.NetReach:Get()) else nil
        v1 = reticle()
        if v1 == nil then
            return
        end
        if v2 == nil then
            u77 = nil
            if u74 then
                u74.Enabled = false
                u74.Adornee = nil
            end
            return
        end
        if u77 ~= v2 then
            u77 = v2
            v1.Adornee = v2.Body
            if u76 then
                u76.Color = v2.Tier.Color
            end
        end
        v1.Enabled = true
        v2 = u75
        if v2 then
            v2.Scale = math.sin(a1 * 6) * 0.08 + 1
        end
        autoSwing()
        return
    end
    if u77 then
        u77 = nil
        if u74 then
            u74.Enabled = false
            u74.Adornee = nil
        end
    end
end

function v1.Start() -- Line: 255 -- upvalues: LocalPlayer (val), onCharacter (val)
    if LocalPlayer.Character then
        onCharacter(LocalPlayer.Character)
    end
    LocalPlayer.CharacterAdded:Connect(onCharacter)
end

return v1