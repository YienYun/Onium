-- Script path: ReplicatedStorage.UserGenerated.Observability.ParticleRecorder
-- Decompile time: 14.17 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
require(ReplicatedStorage.UserGenerated.Observability)
local Registry = require(ReplicatedStorage.UserGenerated.Observability.Registry)

local function qualityLevel() -- Line: 49 -- upvalues: UserInputService (val)
    local success, err = pcall(function() -- Line: 50
        return settings().Rendering.QualityLevel
    end)
    if success and typeof(err) == "EnumItem" and 1 <= err.Value then
        return (math.min(err.Value, 21))
    end
    local success_2, err_2 = pcall(function() -- Line: 56
        return UserSettings():GetService("UserGameSettings").SavedQualityLevel
    end)
    if success_2 and typeof(err_2) == "EnumItem" and 1 <= err_2.Value then
        return 21 - math.floor((10 - err_2.Value) * 21 / 10)
    end
    if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
        return 7
    end
    return 17
end

local function emissionScale() -- Line: 68 -- upvalues: qualityLevel (val)
    return (math.max(0.1, (qualityLevel()) / 21))
end

local function newWatch() -- Line: 92
    return {Connections = {}, Kids = {}, Names = {}}
end

local function inPlayerCharacter(a1) -- Line: 96 -- upvalues: Players (val) -- types: a1: userdata
    local Parent = a1.Parent
    while Parent do
        if Parent == workspace then
            break
        end
        if Parent:IsA("Model") and Players:GetPlayerFromCharacter(Parent) then
            return true
        end
        Parent = Parent.Parent
    end
    return false
end

local function isRecorded(a1) -- Line: 107 -- types: a1: table
    return a1.Forced or a1.Scoped and a1.Qualified
end

local u29 = {}
u29.__index = u29

function u29.new(a1, a2) -- Line: 114 -- upvalues: Registry (val), u29 (val), qualityLevel (val) -- types: a2: function
    local v1 = false
    if a1 ~= nil then
        v1 = a1.Enabled == true
    end
    local v2 = {
        WalkIndex = 0,
        Destroyed = false,
        Clock = a2,
        Enabled = v1,
        Filter = if not v1 then nil else Registry.BuildFilter(a1),
        Entries = {},
        Emits = {},
        Pending = {},
        Watches = {},
        Characters = {},
        Connections = {},
    }
    local u25 = setmetatable(v2, u29)
    pcall(function() -- Line: 134 -- upvalues: u25 (val), qualityLevel (upval)
        local UserGameSettings = UserSettings():GetService("UserGameSettings")
        table.insert(u25.Connections, ((UserGameSettings:GetPropertyChangedSignal("SavedQualityLevel")):Connect(function() -- Line: 138 -- upvalues: u25 (upval), qualityLevel (upval)
            if u25.World then
                u25.World:SetEmissionScale((math.max(0.1, (qualityLevel()) / 21)))
            end
        end)))
    end)
    u25:_watchCharacters()
    if v1 then
        u25:_discover()
    end
    return u25
end

function u29:_watchCharacters() -- Line: 153 -- upvalues: Players (val)
    local Character

    local function added(a1) -- Line: 154 -- upvalues: self (val) -- types: a1: userdata
        if not self.Destroyed and not self.Characters[a1] then
            self.Characters[a1] = (self:_scope(a1))
            return
        end
    end

    local function removing(a1) -- Line: 160 -- upvalues: self (val) -- types: a1: userdata
        local v1 = self.Characters[a1]
        if not v1 then
            return
        end
        self.Characters[a1] = nil
        for i, j in v1.Connections do
            j:Disconnect()
        end
    end

    table.insert(self.Connections, (Players.PlayerAdded:Connect(function(a1) -- Line: 170 -- upvalues: self (val), added (val), removing (val) -- types: a1: userdata
        table.insert(self.Connections, (a1.CharacterAdded:Connect(added)))
        table.insert(self.Connections, (a1.CharacterRemoving:Connect(removing)))
        if a1.Character then
            local Character = a1.Character
            if not self.Destroyed then
                if self.Characters[Character] then
                    return
                end
                self.Characters[Character] = (self:_scope(Character))
            end
        end
    end)))
    for i, j in Players:GetPlayers() do
        table.insert(self.Connections, (j.CharacterAdded:Connect(added)))
        table.insert(self.Connections, (j.CharacterRemoving:Connect(removing)))
        if j.Character then
            Character = j.Character
            if not self.Destroyed and not self.Characters[Character] then
                self.Characters[Character] = (self:_scope(Character))
            end
        end
    end
end

function u29:_inScope(a2) -- Line: 185 -- upvalues: inPlayerCharacter (val) -- types: self: table, a2: userdata
    local v1
    if not a2:IsDescendantOf(workspace) then
        return false
    end
    if inPlayerCharacter(a2) then
        return true
    end
    if not self.Enabled then
        return false
    end
    local Filter = self.Filter
    if not Filter then
        return true
    end
    local v2 = {}
    local Parent = a2
    while Parent do
        if Parent == workspace then
            break
        end
        table.insert(v2, Parent.Name)
        Parent = Parent.Parent
    end
    for i = #v2, 1, -1 do
        v1 = Filter.Children[v2[i]]
        if v1 == nil then
            return not Filter.Include
        end
        if v1.Marked then
            return Filter.Include
        end
    end
    return not Filter.Include
end

function u29._qualifies(a1, a2) -- Line: 219 -- types: a1: table, a2: userdata
    return a2.Enabled and 0 < a2.Rate
end

function u29:_update(a2) -- Line: 224 -- types: self: table, a2: userdata
    local v1 = self.Entries[a2]
    if v1 and not self.Destroyed then
        local Forced = v1.Forced or v1.Scoped and v1.Qualified
        if v1.Forced and not a2:IsDescendantOf(workspace) then
            v1.Forced = false
        end
        v1.Scoped = self:_inScope(a2)
        if v1.Scoped and not v1.Qualified then
            if self:_qualifies(a2) then
                v1.Qualified = true
            elseif not v1.Waiting then
                local function changed() -- Line: 238 -- upvalues: self (val), a2 (val)
                    self:_update(a2)
                end

                v1.Waiting = {
                    (a2:GetPropertyChangedSignal("Enabled")):Connect(changed),
                    ((a2:GetPropertyChangedSignal("Rate")):Connect(changed)),
                }
            end
        end
        if v1.Waiting then
            if v1.Qualified then
                for i, j in v1.Waiting do
                    j:Disconnect()
                end
                v1.Waiting = nil
            elseif not v1.Scoped then
                for k, n in v1.Waiting do
                    n:Disconnect()
                end
                v1.Waiting = nil
            end
        end
        if not v1.Scoped then
            v1.Qualified = false
        end
        local Forced_2 = v1.Forced or v1.Scoped and v1.Qualified
        local World = self.World
        if not Forced_2 then
            if Forced and World then
                World:RemoveParticle(a2)
            end
        elseif World then
            World:AddParticle(a2)
        end
        if not v1.Scoped and not v1.Forced then
            v1.Moved:Disconnect()
            self.Entries[a2] = nil
        end
        return
    end
end

function u29:_entry(a2) -- Line: 275 -- types: self: table, a2: userdata
    local v1 = self.Entries[a2]
    if v1 then
        return v1
    end
    v1 = {
        Scoped = false,
        Forced = false,
        Qualified = false,
        Moved = a2.AncestryChanged:Connect(function() -- Line: 284 -- upvalues: self (val), a2 (val)
            self:_update(a2)
        end),
    }
    self.Entries[a2] = v1
    return v1
end

function u29:_consider(a2) -- Line: 293 -- types: self: table, a2: userdata
    if not self.Destroyed and a2:IsA("ParticleEmitter") and not self.Entries[a2] then
        if not self:_inScope(a2) then
            return
        end
        self:_entry(a2)
        self:_update(a2)
        return
    end
end

function u29:_recheckAll() -- Line: 305
    local v1 = {}
    for i in self.Entries do
        table.insert(v1, i)
    end
    for j, k in v1 do
        self:_update(k)
    end
end

function u29:_scope(a2) -- Line: 316 -- upvalues: newWatch (val) -- types: self: table, a2: userdata
    local v1 = newWatch()
    table.insert(v1.Connections, (a2.DescendantAdded:Connect(function(a1) -- Line: 320 -- upvalues: self (val)
        self:_consider(a1)
    end)))
    self:_consider(a2)
    table.insert(self.Pending, a2)
    return v1
end

function u29:_closeWatch(a2) -- Line: 329 -- types: self: table, a2: userdata
    local v1 = self.Watches[a2]
    if not v1 then
        return
    end
    self.Watches[a2] = nil
    for i, j in v1.Connections do
        j:Disconnect()
    end
    for k, n in v1.Names do
        n:Disconnect()
    end
    for m in v1.Kids do
        self:_closeWatch(m)
    end
end

function u29:_watchPath(a2, a3) -- Line: 348 -- upvalues: newWatch (val) -- types: self: table, a2: userdata
    local Names, PropertyChangedSignal
    if next(a3.Children) == nil then
        return
    end
    local u7 = newWatch()
    self.Watches[a2] = u7

    local function check(a1) -- Line: 354 -- upvalues: u7 (val), self (val), a3 (val) -- types: a1: userdata
        if u7.Kids[a1] then
            u7.Kids[a1] = nil
            self:_closeWatch(a1)
            self:_recheckAll()
        end
        local v1 = a3.Children[a1.Name]
        if v1 ~= nil and not self.Destroyed then
            u7.Kids[a1] = true
            if v1.Marked then
                self.Watches[a1] = (self:_scope(a1))
                return
            end
            self:_watchPath(a1, v1)
            return
        end
    end

    table.insert(u7.Connections, (a2.ChildAdded:Connect(function(a1) -- Line: 373 -- upvalues: u7 (val), check (val)
        if u7.Names[a1] then
            return
        end
        u7.Names[a1] = ((a1:GetPropertyChangedSignal("Name")):Connect(function() -- Line: 377 -- upvalues: check (upval), a1 (val)
            check(a1)
        end))
        check(a1)
    end)))
    table.insert(u7.Connections, (a2.ChildRemoved:Connect(function(a1) -- Line: 385 -- upvalues: u7 (val), self (val)
        local v1 = u7.Names[a1]
        if v1 then
            v1:Disconnect()
            u7.Names[a1] = nil
        end
        if u7.Kids[a1] then
            u7.Kids[a1] = nil
            self:_closeWatch(a1)
        end
    end)))
    for i, j in a2:GetChildren() do
        Names = u7.Names
        PropertyChangedSignal = j:GetPropertyChangedSignal("Name")
        Names[j] = (PropertyChangedSignal:Connect(function() -- Line: 398 -- upvalues: check (val), j (val)
            check(j)
        end))
        check(j)
    end
end

function u29:_discover() -- Line: 405
    local Filter = self.Filter
    if Filter and Filter.Include then
        self:_watchPath(workspace, Filter)
        return
    end
    table.insert(self.Connections, (workspace.DescendantAdded:Connect(function(a1) -- Line: 414 -- upvalues: self (val)
        self:_consider(a1)
    end)))
    for i, j in workspace:GetChildren() do
        table.insert(self.Pending, j)
    end
end

function u29:_walk(a2) -- Line: 425 -- types: self: table, a2: number
    local WalkIndex, Walking, v1, v2, v3
    while os.clock() < a2 do
        Walking = self.Walking
        if Walking then
            WalkIndex = self.WalkIndex
            v2 = #Walking
            while WalkIndex < v2 do
                if not (os.clock() < a2) then
                    break
                end
                WalkIndex = WalkIndex + 1
                v3 = Walking[WalkIndex]
                if v3:IsA("ParticleEmitter") then
                    self:_consider(v3)
                end
            end
            self.WalkIndex = WalkIndex
            if WalkIndex < v2 then
                return
            end
            self.Walking = nil
        end
        v1 = table.remove(self.Pending)
        if v1 == nil then
            return
        end
        if v1.Parent ~= nil then
            self:_consider(v1)
            self.Walking = v1:GetDescendants()
            self.WalkIndex = 0
        end
    end
end

function u29.Emit(a1, a2, a3) -- Line: 457 -- types: a1: table, a2: userdata, a3: number
    if not a1.Destroyed and not (#a1.Emits >= 1024) then
        table.insert(a1.Emits, {Emitter = a2, Count = a3, T = a1.Clock()})
        return
    end
end

function u29.Bind(a1, a2) -- Line: 465 -- upvalues: qualityLevel (val)
    local Forced
    a1.World = a2
    a2:SetEmissionScale((math.max(0.1, (qualityLevel()) / 21)))
    local v1 = nil
    local v2 = nil
    for i, j in a1.Entries, v1, v2 do
        Forced = j.Forced or j.Scoped and j.Qualified
        if Forced then
            v3:AddParticle(i)
        end
    end
end

function u29.Unbind(a1) -- Line: 476
    a1.World = nil
end

function u29.Flush(a1) -- Line: 482
    if a1.Destroyed then
        return
    end
    a1:_walk((os.clock()) + 0.0005)
    local World = a1.World
    if World and #a1.Emits ~= 0 then
        local Emitter, v1
        local Emits = a1.Emits
        a1.Emits = {}
        for i, j in Emits do
            Emitter = j.Emitter
            if Emitter.Parent ~= nil then
                World:WriteEmit(Emitter, j.Count, j.T)
                if World.Particles[Emitter] then
                    v1 = a1:_entry(Emitter)
                    if not v1.Forced then
                        v1.Forced = true
                        a1:_update(Emitter)
                    end
                end
            end
        end
        return
    end
end

function u29.Destroy(a1) -- Line: 510
    a1.Destroyed = true
    a1.World = nil
    for i, j in a1.Connections do
        j:Disconnect()
    end
    table.clear(a1.Connections)
    for k in a1.Watches do
        a1:_closeWatch(k)
    end
    local v1 = nil
    local v2 = nil
    local v3 = a1
    for n, m in a1.Characters, v1, v2 do
        for i5, i6 in m.Connections do
            i6:Disconnect()
        end
    end
    table.clear(v3.Characters)
    v1 = nil
    v2 = nil
    for i7, i8 in v3.Entries, v1, v2 do
        i8.Moved:Disconnect()
        if i8.Waiting then
            for i9, i10 in i8.Waiting do
                i10:Disconnect()
            end
        end
    end
    table.clear(v3.Entries)
    table.clear(v3.Emits)
    table.clear(v3.Pending)
    v3.Walking = nil
end

return u29