-- Script path: ReplicatedStorage.Shared.Flags.StaffTagFlags
-- Decompile time: 1.96 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local FastFlags = require(ReplicatedStorage.UserGenerated.FastFlags)
local v1 = {
    Enabled = FastFlags.Replicated("Game.Staff.TagsEnabled", (require(ReplicatedStorage.UserGenerated.Lang.Asserts)).Boolean, true),
    Roles = FastFlags.Replicated("Game.Staff.TagRoles", function(a1) -- Line: 8
        local v1
        assert(type(a1) == "table")
        local v2 = nil
        local v3 = nil
        for i, j in a1, v2, v3 do
            v1 = false
            if type(i) == "string" then
                v1 = tonumber(i) and tonumber(i) % 1 == 0
            end
            assert(v1)
            v1 = true
            if j ~= "Owner" then
                v1 = true
                if j ~= "Admin" then
                    v1 = j == "Developer"
                end
            end
            assert(v1)
        end
        return a1
    end, {
        ["3889785873"] = "Admin",
        ["10751598093"] = "Owner",
        ["2735356267"] = "Owner",
        ["4613024122"] = "Owner",
        ["1927880506"] = "Owner",
        ["2790707588"] = "Owner",
        ["89659291"] = "Developer",
        ["82806501"] = "Developer",
        ["14277028"] = "Developer",
        ["37474696"] = "Developer",
        ["23370881"] = "Developer",
        ["23522478"] = "Developer",
        ["25451922"] = "Developer",
    }),
}
local u42 = Instance.new("BindableEvent")
v1.Enabled.Changed:Connect(function() -- Line: 40 -- upvalues: u42 (val)
    u42:Fire()
end)
v1.Roles.Changed:Connect(function() -- Line: 44 -- upvalues: u42 (val)
    u42:Fire()
end)
v1.Changed = u42.Event
return table.freeze(v1)