-- Script path: ReplicatedStorage.Controllers.Game.AdminAbuseClientController.CutsceneHelperFunctions
-- Decompile time: 8.06 ms

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
game:GetService("Workspace")

local function toMMSS(a1) -- Line: 8 -- types: a1: number
    return string.format("%02i:%02i", a1 / 60 % 60, a1 % 60)
end

local function ParsePath(a1) -- Line: 10 -- upvalues: Lighting (val), Players (val) -- types: a1: string
    local Terrain = nil
    local v1 = a1:split(".")
    local v2 = nil
    local v3 = nil
    for k, n in v1, v2, v3 do
        if k == #v1 then
            return Terrain, n
        end
        Terrain = if Terrain then if Terrain then if Terrain then if Terrain then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else if n ~= "Lighting" then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else Lighting else if n ~= "Terrain" then if Terrain then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else if n ~= "Lighting" then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else Lighting else workspace.Terrain else if n == "workspace" then workspace else if n ~= "Workspace" then if Terrain then if Terrain then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else if n ~= "Lighting" then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else Lighting else if n ~= "Terrain" then if Terrain then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else if n ~= "Lighting" then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else Lighting else workspace.Terrain else workspace else if n ~= "game" then if Terrain then if Terrain then if Terrain then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else if n ~= "Lighting" then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else Lighting else if n ~= "Terrain" then if Terrain then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else if n ~= "Lighting" then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else Lighting else workspace.Terrain else if n == "workspace" then workspace else if n ~= "Workspace" then if Terrain then if Terrain then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else if n ~= "Lighting" then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else Lighting else if n ~= "Terrain" then if Terrain then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else if n ~= "Lighting" then if Terrain then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else if n == "Player" then Players.LocalPlayer else if n ~= "player" then if Terrain then Terrain[n] else if n ~= "PlayerGui" then Terrain[n] else Players.LocalPlayer.PlayerGui else Players.LocalPlayer else Lighting else workspace.Terrain else workspace else game
    end
    error((("[%*] Invalid Path"):format(script.Name)))
end

local function SetProperty(a1, a2) -- Line: 39 -- upvalues: ParsePath (val) -- types: a1: string
    return function() -- Line: 40 -- upvalues: ParsePath (upval), a1 (val), a2 (ref)
        local v1, v2 = ParsePath(a1)
        if v2 == "CFrame" and v1:GetAttribute("OffsetCFrame") then
            a2 = a2 * v1:GetAttribute("OffsetCFrame")
        end
        if v1:IsA("Model") and v2 == "CFrame" then
            v1:PivotTo(a2)
            return
        end
        v1[v2] = a2
    end
end

local function TweenProperty(a1, a2, a3) -- Line: 55
    -- upvalues: ParsePath (val), TweenService (val)
    return function() -- Line: 56 -- upvalues: ParsePath (upval), a1 (val), a3 (ref), TweenService (upval), a2 (val)
        local u2, v1 = ParsePath(a1)
        if v1 == "CFrame" and u2:GetAttribute("OffsetCFrame") then
            a3 = a3 * u2:GetAttribute("OffsetCFrame")
        end
        if v1 == "CFrame" and u2:IsA("Model") then
            local CFrameValue = Instance.new("CFrameValue")
            CFrameValue.Value = u2:GetPivot()
            TweenService:Create(CFrameValue, a2, {Value = a3}):Play()
            CFrameValue.Changed:Connect(function() -- Line: 67 -- upvalues: u2 (val), CFrameValue (val)
                u2:PivotTo(CFrameValue.Value)
            end)
            return
        end
        TweenService:Create(u2, a2, {[v1] = a3}):Play()
    end
end

local function LoadAnimationIntoRig(a1, a2) -- Line: 75 -- types: a1: userdata, a2: string
    local AnimationController = a1:FindFirstChild("AnimationController")
    local Humanoid = a1:FindFirstChild("Humanoid")
    local Animator = AnimationController and AnimationController:FindFirstChild("Animator") or Humanoid and Humanoid:FindFirstChild("Animator") or AnimationController or Humanoid
    if not Animator then
        error((("No usable animation controller or humanoid exists for %*"):format(a1)))
    end
    local v1 = Instance.new("Animation")
    v1.AnimationId = a2
    return Animator:LoadAnimation(v1)
end

local function SetVisibility(a1, a2) -- Line: 94 -- types: a1: userdata, a2: boolean
    local Attribute, Transparency
    for i, j in a1:GetDescendants() do
        if j:IsA("BasePart") then
            if j:GetAttribute("OriginalTransparency") == nil then
                Transparency = j.Transparency
                j:SetAttribute("OriginalTransparency", Transparency)
            end
            Attribute = a2 and j:GetAttribute("OriginalTransparency") or 1
            j.Transparency = Attribute
        end
    end
end

return {
    GetHelperFunctions = function(a1) -- Line: 108
        -- upvalues: RunService (val), TweenService (val), SoundService (val), toMMSS (val), ParsePath (val)
        -- upvalues: SetProperty (val), TweenProperty (val), LoadAnimationIntoRig (val), SetVisibility (val)
        return {
            toMMSS = toMMSS,
            ParsePath = ParsePath,
            SetProperty = SetProperty,
            TweenProperty = TweenProperty,
            LoadAnimationIntoRig = LoadAnimationIntoRig,
            CreateAndPlaySound = function(a1_2, a2, a3) -- Line: 109 -- upvalues: a1 (val) -- types: a1_2: string, a2: userdata, a3: number?
                local v1 = a2 or workspace:FindFirstChild("Terrain")
                local Sound = Instance.new("Sound")
                Sound.SoundId = a1_2
                Sound.Parent = v1
                Sound.Volume = a3 or 0.5
                Sound.RollOffMaxDistance = 9999
                Sound.RollOffMinDistance = 0
                Sound.RollOffMode = Enum.RollOffMode.Linear
                task.delay(0.1, function() -- Line: 119 -- upvalues: Sound (val)
                    Sound:Play()
                end)
                a1:Add(Sound)
                return Sound
            end,
            PlaySequenceAsync = function(a1_2, a2, a3) -- Line: 126
                -- upvalues: RunService (upval), a1 (val)
                if a1_2 then
                    a1_2:Play()
                end
                local u6 = {}
                local u7 = 0
                local v1 = RunService.Heartbeat:Connect(function(a1) -- Line: 137 -- upvalues: u7 (ref), a2 (val), u6 (val)
                    local v1
                    u7 = u7 + a1
                    for i = 0, 9 do
                        v1 = math.floor(u7 * 60 - i)
                        if a2[v1] and not u6[v1] then
                            u6[v1] = true
                            for j, k in a2[v1] do
                                task.spawn(k)
                            end
                        end
                    end
                end)
                a1:Add(v1)
                task.wait(a3)
                v1:Disconnect()
            end,
            SetVisibility = SetVisibility,
            TweenMuteBackgroundMusic = function() -- Line: 158 -- upvalues: TweenService (upval), SoundService (upval), a1 (val)
                TweenService:Create(SoundService.Music.BackgroundMusic, TweenInfo.new(1), {Volume = 0}):Play()
                a1:Add(function() -- Line: 162 -- upvalues: TweenService (upval), SoundService (upval)
                    TweenService:Create(SoundService.Music.BackgroundMusic, TweenInfo.new(1), {Volume = 1}):Play()
                end)
            end,
        }
    end,
}