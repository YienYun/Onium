-- Script path: ReplicatedStorage.CmdrClient.Commands.shopPreview
-- Decompile time: 0.53 ms

return {
    Name = "shopPreview",
    Description = "Preview the shop before or after the configured Halloween switch on your client in DEV, TEST or Studio.",
    Group = "Admin",
    Aliases = {"previewShop"},
    Args = {
        {
            Type = "string",
            Name = "Mode",
            Description = "before/old, after/new, or off",
            Optional = true,
            Default = "after",
        },
    },
    ClientRun = function(a1, a2) -- Line: 10 -- types: a2: string
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local ShopPreview = require(ReplicatedStorage.Client.ShopPreview)
        local v1, v2 = ShopPreview.Set(a2)
        if not v1 then
            return v2
        end
        require(ReplicatedStorage.Client.ShopNavigation).Open(if not ShopPreview.IsHalloween() then "Stars" else "Featured")
        return v2
    end,
}