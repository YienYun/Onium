-- Script path: ReplicatedStorage.CmdrClient.Commands.raceRally
-- Decompile time: 0.40 ms

return (require((game:GetService("ReplicatedStorage")).Shared.Utils.CmdrToolkit)).Command(require(script.Actions), {
    Name = "raceRally",
    Description = "Race mini-event QA levers on this server: `race <action> ...`. Player arguments default to you.",
    Group = "Admin",
    ActionDescription = "status | trophies | nitro | wins | unlock | lock | unclaim | restock | reset | award | start | stop",
    Aliases = {"race", "rr"},
})