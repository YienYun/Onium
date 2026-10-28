-- Script path: ReplicatedStorage.Data.ExpandedLobby
-- Decompile time: 0.49 ms

local u0 = {TestAttributeKey = "ExpandedLobby.Group", ServerTypeAttributeKey = "ExpandedLobby.ServerType"}
u0.Groups = table.freeze({Control = "Control", Variant = "Variant"})
u0.UnlockedValue = "None"
u0.ServerAttribute = "ExpandedLobbyServerGroup"
u0.TeleportDataKey = "ExpandedLobbyGroup"
u0.StudioForceAttribute = "ExpandedLobbyForceGroup"
u0.RemovalTag = "ExpandedLobbyABTestRemoval"
u0.JobAttributeWaitSeconds = 15
u0.ApplyDeadlineSeconds = 120
u0.PlotSpread = table.freeze({CenterZ = -364.1, ZScale = 1.35, WestColumnXOffset = -20, WestColumnMaxX = 500})

function u0.IsValidGroup(a1) -- Line: 26 -- upvalues: u0 (val)
    local v1 = true
    if a1 ~= u0.Groups.Control then
        v1 = a1 == u0.Groups.Variant
    end
    return v1
end

return table.freeze(u0)