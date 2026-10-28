-- Script path: ReplicatedStorage.Shared.Util.SewerCave
-- Decompile time: 1.63 ms

local Workspace = game:GetService("Workspace")
local u5 = {
    FolderName = "TrainEventAssets",
    CaveName = "SewerCave",
    MarkersName = "Markers",
    AmbienceName = "Ambience",
    LightingPresetName = "LightingPreset",
    WhirlpoolName = "Steal an Egg Whirlpool",
    WhirlpoolTag = "SewerCaveWhirlpool",
    ExitMarkerName = "SewerPipeExit",
    LightingPreset = "SewerCave",
}
u5.Markers = table.freeze({
    Spawn = "Spawn",
    Surface = "Surface",
    Npc = "Npc",
    Pipe = "Pipe",
    Bounds = "Bounds",
})
u5.Attributes = table.freeze({Inside = "InSewerCave", TriggerRadius = "TriggerRadius", TriggerHeight = "TriggerHeight"})
u5.Worker = table.freeze({
    Name = "Gus",
    PipeLine = 5,
    KeyPipeLine = 2,
    Lines = table.freeze({
        "AHH! WHO'S THERE?! Oh... you're not one of them. How did you even get down here?!",
        "I used to work at that old manor... until I accidentally dropped the Manor Key into this water!",
        "The owners are gonna KILL ME if they find out! I've been hiding down here ever since!",
        "Please! If you can fish that key out, you can keep it! Just don't tell them I lost it!",
        "Oh, and there's a pipe over there that leads back to the manor... but I'm NOT going back!",
    }),
    KeyLines = table.freeze({
        "You FOUND it?! ...shh, you didn't get it from me!",
        "Take it to the manor door. The pipe over there goes right to it... I'm staying put!",
    }),
})
u5.Messages = table.freeze({
    KeyCaught = "You fished up the Manor Key!",
    Ragdolled = "Wait until you recover first!",
    Mounted = "Get off your mount first!",
    Fallback = "The pipe spat you out back in the lobby!",
})

function u5.Cave() -- Line: 62 -- upvalues: Workspace (val)
    local TrainEventAssets = Workspace:FindFirstChild("TrainEventAssets")
    local SewerCave = TrainEventAssets and TrainEventAssets:FindFirstChild("SewerCave")
    if SewerCave ~= nil and SewerCave:IsA("Model") then
        return SewerCave
    end
    return nil
end

function u5.Marker(a1) -- Line: 68 -- upvalues: u5 (val) -- types: a1: string
    local v1 = u5.Cave()
    local Markers = v1 and v1:FindFirstChild("Markers")
    v1 = Markers and Markers:FindFirstChild(a1)
    if v1 ~= nil and v1:IsA("BasePart") then
        return v1
    end
    return nil
end

function u5.Within(a1, a2, a3) -- Line: 75 -- types: a1: userdata, a2: vector, a3: number
    local v1 = a1.CFrame:PointToObjectSpace(a2)
    local v2 = a1.Size / 2 + Vector3.new(1, 1, 1) * a3
    local v3 = false
    if (math.abs(v1.X)) <= v2.X then
        v3 = false
        if (math.abs(v1.Y)) <= v2.Y then
            v3 = (math.abs(v1.Z)) <= v2.Z
        end
    end
    return v3
end

return table.freeze(u5)