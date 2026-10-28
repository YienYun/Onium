-- Script path: ReplicatedStorage.Shared.Util.VoidFusionSounds
-- Decompile time: 1.10 ms

local function sound(a1, a2, a3, a4) -- Line: 10 -- types: a1: string, a2: number, a3: boolean?, a4: number?
    return table.freeze({Id = ("rbxassetid://%*"):format(a1), Volume = a2, Looped = a3, Hit = a4})
end

return (table.freeze({
    Bed = table.freeze({Id = "rbxassetid://72791608437226", Volume = 0.55, Hit = 15.3}),
    Place = table.freeze({Id = "rbxassetid://92321217764576", Volume = 1}),
    Link = table.freeze({Id = "rbxassetid://89561011112105", Volume = 1.4}),
    Hum = table.freeze({Id = "rbxassetid://117282213811936", Volume = 1, Looped = true}),
    Rumble = table.freeze({Id = "rbxassetid://136026385366563", Volume = 1.1, Looped = true}),
    PropRattle = table.freeze({Id = "rbxassetid://133782909533348", Volume = 0.7}),
    PropRattle2 = table.freeze({Id = "rbxassetid://131234911828016", Volume = 0.7}),
    PropRattle3 = table.freeze({Id = "rbxassetid://134221047704498", Volume = 0.7}),
    Dissolve = table.freeze({Id = "rbxassetid://133117799996516", Volume = 1.2}),
    RiftOpen = table.freeze({Id = "rbxassetid://123444360254086", Volume = 1.5, Hit = 0.5}),
    EyeOpen = table.freeze({Id = "rbxassetid://115440306299794", Volume = 1.3, Hit = 0.35}),
    Swirl = table.freeze({Id = "rbxassetid://89907047906506", Volume = 1, Looped = true}),
    Implode = table.freeze({Id = "rbxassetid://78176102367104", Volume = 1.4, Hit = 1.3}),
    Riser = table.freeze({Id = "rbxassetid://125275096571632", Volume = 1.3, Hit = 2.7}),
    Boom = table.freeze({Id = "rbxassetid://80041045994469", Volume = 2.2}),
    Shimmer = table.freeze({Id = "rbxassetid://137048994446416", Volume = 0.8, Looped = true}),
    PropsLand = table.freeze({Id = "rbxassetid://79861646955570", Volume = 1}),
    Reward = table.freeze({Id = "rbxassetid://91303804586477", Volume = 1.2}),
}))