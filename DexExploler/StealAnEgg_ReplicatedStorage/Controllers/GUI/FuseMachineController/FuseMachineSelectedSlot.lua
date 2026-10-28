-- Script path: ReplicatedStorage.Controllers.GUI.FuseMachineController.FuseMachineSelectedSlot
-- Decompile time: 4.82 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Types.AssetItem)
local Directory = require(ReplicatedStorage.Data.Assets).Directory
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
require(ReplicatedStorage.Shared.Types.FuseMachine)
local Mutations = require(ReplicatedStorage.Shared.Modules.Mutations)
local Trove = require(ReplicatedStorage.Packages.Trove)
local u35 = {}
u35.__index = u35
u35.__class = "FuseMachineSelectedSlot"

function u35.new(a1, a2, a3, a4) -- Line: 35
    -- upvalues: u35 (val), Trove (val), Directory (val), ButtonFX (val)
    local v1 = setmetatable({}, u35)
    v1._slot = a1
    v1._trove = Trove.new()
    v1._uid = a2
    local Full = a1.Full
    a1.Empty.Visible = false
    Full.Visible = true
    v1._trove:Add(function() -- Line: 49 -- upvalues: Full (val), a1 (val)
        Full.Visible = false
        a1.Empty.Visible = true
    end)
    local v2 = Directory[a3.Category]
    local v3 = ("Missing asset config %*"):format(a3.Category)
    assert(v2 ~= nil, v3)
    local Name = Full:FindFirstChild("Name")
    v3 = false
    if Name ~= nil then
        v3 = Name:IsA("TextLabel")
    end
    assert(v3, "Fuse input Full.Name must be a TextLabel")
    Name.Text = v2.DisplayName
    local Pet = Full.Pet
    assert(Pet:IsA("ImageLabel"), "Fuse input Full.Pet must be an ImageLabel")
    Pet.Image = v2.Icon or ""
    v1:_applyMutation(a3)
    v1:_applyRarity(a3)
    local Add = Full.Add
    assert(Add:IsA("ImageButton"), "Fuse input Full.Add must be an ImageButton")
    v1._trove:Add((Add.Activated:Connect(function() -- Line: 70 -- upvalues: a4 (val), a2 (val)
        a4(a2)
    end)))
    ButtonFX(Add, 1.08)
    return v1
end

function u35:_applyMutation(a2) -- Line: 80 -- upvalues: Mutations (val)
    local BaseMutation = a2.BaseMutation or a2.Mutations[1]
    if BaseMutation ~= nil and BaseMutation ~= Mutations.NO_MUTATION then
        local Name = self._slot.Full:FindFirstChild("Name")
        local v1 = false
        if Name ~= nil then
            v1 = Name:IsA("TextLabel")
        end
        assert(v1, "Fuse input Full.Name must be a TextLabel")
        local v2 = Mutations.Get(BaseMutation)
        Name.Text = ("%* %*"):format(Mutations.LabelOf(BaseMutation), Name.Text)
        if v2 then
            Name.TextColor3 = v2.Tint
        end
        return
    end
end

function u35:_applyRarity(a2) -- Line: 98 -- upvalues: Directory (val)
    local Rarity = self._slot.Full.Rarity
    assert(Rarity:IsA("TextLabel"), "Fuse input Full.Rarity must be a TextLabel")
    local v1 = Directory[a2.Category]
    local v2 = ("Missing asset config %*"):format(a2.Category)
    assert(v1 ~= nil, v2)
    for i, v in ipairs(Rarity:GetChildren()) do
        if v:IsA("UIGradient") then
            v:Destroy()
        end
    end
    Rarity.Text = v1.Rarity.DisplayName
    Rarity.TextColor3 = v1.Rarity.Color
    if v1.Rarity.RarityGradient then
        v1.Rarity.RarityGradient:Clone().Parent = Rarity
    end
end

function u35.GetUid(a1) -- Line: 122
    return a1._uid
end

function u35:Destroy() -- Line: 124
    self._trove:Destroy()
end

return u35