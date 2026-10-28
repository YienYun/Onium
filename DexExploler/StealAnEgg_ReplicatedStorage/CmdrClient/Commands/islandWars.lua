-- Script path: ReplicatedStorage.CmdrClient.Commands.islandWars
-- Decompile time: 0.32 ms

return (require((game:GetService("ReplicatedStorage")).Shared.Utils.CmdrToolkit)).Command(require(script.Actions), {
    Name = "islandWars",
    Description = "Cursed Island Wars QA levers on this server: `iw <action> ...`. Player arguments default to you.",
    Group = "Admin",
    ActionDescription = "status | start | stop | skip | win | bots | god | give | wall | crystal",
    Aliases = {"iw"},
})