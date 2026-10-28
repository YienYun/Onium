-- Script path: ReplicatedStorage.Data.FallenPowerUp
-- Decompile time: 2.16 ms

local u0 = {
    FallEase = 2.2,
    FallTimeNearScale = 0.85,
    FallTimeFarScale = 1.3,
    OriginLiftPerSpread = 0.35,
    PickupRadiusStuds = 7,
    PickupLagSeconds = 0.5,
    PickupRetrySeconds = 1.5,
    DropScatterStuds = 42,
    SpotAttempts = 12,
    SpreadStuds = 24,
    BobStuds = 0.65,
    BobSpeed = 2.6,
    SpinSpeed = 1.4,
    HoverStuds = 2.4,
    AbsorbSeconds = 0.32,
    MagnetPullSeconds = 0.42,
    MagnetPullSpinSpeed = 9,
    SkyLiftResponse = 2.4,
    HighlightFillTransparency = 0.5,
    HighlightPulseFill = 0.34,
    HighlightOutlineTransparency = 0,
}
u0.HighlightPulse = TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
u0.LightBrightness = 2.4
u0.LightRangeStuds = 16
u0.TailLengthStuds = 40
u0.TailWidthStuds = 11
u0.TailTexture = "rbxassetid://134046679013293"
u0.BeaconTexture = "rbxassetid://134046679013293"
u0.BeaconBaseStuds = 4
u0.BeaconHeightStuds = 272
u0.BeaconWidthStuds = 5
u0.BurstShockTexture = "rbxassetid://14057043166"
u0.BurstGlowTexture = "rbxassetid://17061556158"
u0.LandShakeSeconds = 0.55
u0.LandShakeIntensity = 1.4
u0.GlobalBumpSeconds = 0.38
u0.GlobalBumpIntensity = 0.45
u0.LandShakeFalloff = 0.7
u0.BurstOriginScale = 2.4
u0.TailSpeedRef = 90
u0.TailMaxLengthStuds = 110
u0.TailTipWidthStuds = 1.8
u0.TailSparkRate = 90
u0.TailSparkStuds = 1.8
u0.PlumeWidthScale = 2.6
u0.PlumeTransparency = 0.72
u0.WorldScale = 4
u0.FlightScale = 3.4
u0.LandScaleSeconds = 0.3
u0.HeadGlowTexture = "rbxassetid://17061556158"
u0.HeadPixelRef = 5600
u0.HeadPixelMin = 38
u0.HeadPixelMax = 210
u0.HeadCoreScale = 0.42
u0.MarkerTexture = "rbxassetid://14057043166"
u0.MarkerStartStuds = 58
u0.MarkerEndStuds = 14
u0.MarkerThickStuds = 0.05
u0.MarkerLiftStuds = 0.15
u0.MarkerPulseSpeed = 7
u0.ShockwaveSeconds = 0.55
u0.ShockwaveStuds = 72
u0.LandFlashBrightness = 9
u0.LandFlashRangeStuds = 46
u0.RiserSoundId = "rbxassetid://101937236820642"
u0.RiserVolume = 0.4
u0.ImpactSoundId = "rbxassetid://131273749621142"
u0.ImpactVolume = 0.7
u0.ImpactRangeStuds = 260
u0.HeadCloneScale = 0.55
u0.HeadCloneHoverStuds = 3.4
u0.HeadCloneGapStuds = 1.6
u0.HeadCloneSpinSpeed = 1.8
u0.HeadCloneBobStuds = 0.3
u0.NoticeColor = Color3.fromRGB(255, 214, 89)
u0.NoticeSeconds = 5
u0.Announce = "Look up! Power ups are falling!"
u0.AttributePrefix = "LvdPower_"
u0.Kinds = {
    Magnet = {
        Id = "Magnet",
        Display = "Ring Magnet",
        Order = 1,
        Icon = "rbxassetid://78796564679501",
        Color = Color3.fromRGB(64, 164, 255),
    },
    x2Rings = {
        Id = "x2Rings",
        Display = "2x Rings",
        Order = 2,
        Icon = "rbxassetid://138829174361176",
        Color = Color3.fromRGB(255, 176, 0),
    },
    Fusion = {
        Id = "Fusion",
        Display = "Fusion",
        Order = 3,
        Icon = "rbxassetid://108854972154157",
        Color = Color3.fromRGB(96, 196, 66),
    },
}
u0.KindList = {"Magnet", "x2Rings", "Fusion"}

function u0.KindById(a1) -- Line: 141 -- upvalues: u0 (val) -- types: a1: string
    return u0.Kinds[a1]
end

function u0.IconFor(a1) -- Line: 145 -- upvalues: u0 (val) -- types: a1: string
    local v1 = u0.Kinds[a1]
    if v1 ~= nil then
        return v1.Icon
    end
    return ""
end

function u0.AttributeFor(a1) -- Line: 150 -- upvalues: u0 (val) -- types: a1: string
    return u0.AttributePrefix .. a1
end

function u0.ActiveUntil(a1, a2) -- Line: 154 -- upvalues: u0 (val) -- types: a1: userdata, a2: string
    local Attribute = a1:GetAttribute((u0.AttributeFor(a2)))
    if type(Attribute) == "number" then
        return Attribute
    end
    return 0
end

function u0.IsActive(a1, a2, a3) -- Line: 159 -- upvalues: u0 (val) -- types: a1: userdata, a2: string, a3: number
    return a3 < u0.ActiveUntil(a1, a2)
end

function u0.ModelFor(a1) -- Line: 163 -- types: a1: string
    local PowerUps = game:GetService("ReplicatedStorage").Assets.Models:FindFirstChild("PowerUps")
    local v1 = if PowerUps == nil then nil else PowerUps:FindFirstChild(a1)
    if v1 ~= nil and v1:IsA("Model") then
        return v1
    end
    return nil
end

return u0