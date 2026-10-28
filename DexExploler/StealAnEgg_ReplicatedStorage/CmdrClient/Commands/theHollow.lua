-- Script path: ReplicatedStorage.CmdrClient.Commands.theHollow
-- Decompile time: 0.38 ms

return (require((game:GetService("ReplicatedStorage")).Shared.Utils.CmdrToolkit)).Command(require(script.Actions), {
    Name = "theHollow",
    Description = "The Hollow race QA levers on this server: `hollow <action> ...`. Player arguments default to you.",
    Group = "Admin",
    ActionDescription = "status | wins | prizes | unclaim | reset | start | stop",
    Aliases = {"hollow"},
})