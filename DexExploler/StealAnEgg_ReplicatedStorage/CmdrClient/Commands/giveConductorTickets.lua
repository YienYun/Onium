-- Script path: ReplicatedStorage.CmdrClient.Commands.giveConductorTickets
-- Decompile time: 0.21 ms

return {
    Name = "giveConductorTickets",
    Description = "Give saved Conductor's Tickets for the Train Event prototype; does not unlock boarding.",
    Group = "Admin",
    Args = {
        {Type = "players", Name = "Player", Description = "Players to give tickets to."},
        {
            Type = "positiveInteger",
            Name = "Amount",
            Description = "How many tickets to give (limited by Game.TrainEvent.AdminTicketGrantMax).",
            Default = 1,
        },
    },
}