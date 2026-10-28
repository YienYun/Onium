-- Script path: ReplicatedStorage.Packages._Index.roblox_testez@0.4.1.testez.TestPlan
-- Decompile time: 6.41 ms

local TestEnum = require(script.Parent.TestEnum)
local Expectation = require(script.Parent.Expectation)

local function newEnvironment(a1, a2) -- Line: 11 -- upvalues: TestEnum (val), Expectation (val)
    local v1 = {}
    if a2 then
        if type(a2) ~= "table" then
            error(("Bad argument #2 to newEnvironment. Expected table, got %s"):format((typeof(a2))), 2)
        end
        for k, v in pairs(a2) do
            v1[k] = v
        end
    end

    local function addChild(a1_2, a2, a3, a4) -- Line: 24 -- upvalues: a1 (val), TestEnum (upval)
        local v1 = a1:addChild(a1_2, a3, a4)
        v1.callback = a2
        if a3 == TestEnum.NodeType.Describe then
            v1:expand()
        end
        return v1
    end

    function v1.describeFOCUS(a1, a2) -- Line: 33 -- upvalues: addChild (val), TestEnum (upval)
        addChild(a1, a2, TestEnum.NodeType.Describe, TestEnum.NodeModifier.Focus)
    end

    function v1.describeSKIP(a1, a2) -- Line: 37 -- upvalues: addChild (val), TestEnum (upval)
        addChild(a1, a2, TestEnum.NodeType.Describe, TestEnum.NodeModifier.Skip)
    end

    function v1.describe(a1, a2, a3) -- Line: 41 -- upvalues: addChild (val), TestEnum (upval)
        addChild(a1, a2, TestEnum.NodeType.Describe, TestEnum.NodeModifier.None)
    end

    function v1.itFOCUS(a1, a2) -- Line: 45 -- upvalues: addChild (val), TestEnum (upval)
        addChild(a1, a2, TestEnum.NodeType.It, TestEnum.NodeModifier.Focus)
    end

    function v1.itSKIP(a1, a2) -- Line: 49 -- upvalues: addChild (val), TestEnum (upval)
        addChild(a1, a2, TestEnum.NodeType.It, TestEnum.NodeModifier.Skip)
    end

    function v1.itFIXME(a1, a2) -- Line: 53 -- upvalues: addChild (val), TestEnum (upval)
        local v1 = addChild(a1, a2, TestEnum.NodeType.It, TestEnum.NodeModifier.Skip)
        warn("FIXME: broken test", v1:getFullName())
    end

    function v1.it(a1, a2, a3) -- Line: 58 -- upvalues: addChild (val), TestEnum (upval)
        addChild(a1, a2, TestEnum.NodeType.It, TestEnum.NodeModifier.None)
    end

    local u43 = 0
    for k2, i in pairs({
        [TestEnum.NodeType.BeforeAll] = "beforeAll",
        [TestEnum.NodeType.AfterAll] = "afterAll",
        [TestEnum.NodeType.BeforeEach] = "beforeEach",
        [TestEnum.NodeType.AfterEach] = "afterEach",
    }) do
        v1[i] = function(a1) -- Line: 73 -- upvalues: addChild (val), i (val), u43 (ref), k2 (val), TestEnum (upval)
            addChild(i .. "_" .. tostring(u43), a1, k2, TestEnum.NodeModifier.None)
            u43 = u43 + 1
        end
    end

    function v1.FIXME(a1_2) -- Line: 79 -- upvalues: a1 (val), TestEnum (upval)
        warn("FIXME: broken test", a1:getFullName(), a1_2 or "")
        a1.modifier = TestEnum.NodeModifier.Skip
    end

    function v1.FOCUS() -- Line: 85 -- upvalues: a1 (val), TestEnum (upval)
        a1.modifier = TestEnum.NodeModifier.Focus
    end

    function v1.SKIP() -- Line: 89 -- upvalues: a1 (val), TestEnum (upval)
        a1.modifier = TestEnum.NodeModifier.Skip
    end

    function v1.HACK_NO_XPCALL() -- Line: 97
        warn("HACK_NO_XPCALL is deprecated. It is now safe to yield in an xpcall, so this is no longer necessary. It can be safely deleted.")
    end

    v1.fit = v1.itFOCUS
    v1.xit = v1.itSKIP
    v1.fdescribe = v1.describeFOCUS
    v1.xdescribe = v1.describeSKIP
    local v2 = {
        extend = function(...) -- Line: 110
            error("Cannot call \"expect.extend\" from within a \"describe\" node.")
        end,
    }
    local v3 = {
        __call = function(a1, ...) -- Line: 114 -- upvalues: Expectation (upval)
            return Expectation.new(...)
        end,
    }
    v1.expect = setmetatable(v2, v3)
    return v1
end

local u11 = {}
u11.__index = u11

function u11.new(a1, a2, a3, a4) -- Line: 130 -- upvalues: TestEnum (val), newEnvironment (val), u11 (val)
    local v1 = {
        plan = a1,
        phrase = a2,
        type = a3,
        modifier = a4 or TestEnum.NodeModifier.None,
        children = {},
    }
    v1.environment = newEnvironment(v1, a1.extraEnvironment)
    return (setmetatable(v1, u11))
end

local function getModifier(a1, a2, a3) -- Line: 147 -- upvalues: TestEnum (val)
    if not a2 then
        return a3
    end
    if a3 ~= nil and a3 ~= TestEnum.NodeModifier.None then
        return a3
    end
    if a1:match(a2) then
        return TestEnum.NodeModifier.Focus
    end
    return TestEnum.NodeModifier.Skip
end

function u11:addChild(a2, a3, a4) -- Line: 158 -- upvalues: TestEnum (val), getModifier (val), u11 (val)
    if a3 == TestEnum.NodeType.It then
        for k, v in pairs(self.children) do
            if v.phrase == a2 then
                error("Duplicate it block found: " .. v:getFullName())
            end
        end
    end
    local v1 = u11.new(self.plan, a2, a3, (getModifier((self:getFullName()) .. " " .. a2, self.plan.testNamePattern, a4)))
    v1.parent = self
    table.insert(self.children, v1)
    return v1
end

function u11:getFullName() -- Line: 178
    if self.parent then
        local v1 = self.parent:getFullName()
        if v1 then
            return v1 .. " " .. self.phrase
        end
    end
    return self.phrase
end

function u11:expand() -- Line: 192
    local v1 = getfenv(self.callback)
    local v2 = {__index = v1}
    local v3 = setmetatable({}, v2)
    for k, v in pairs(self.environment) do
        v3[k] = v
    end
    v3.script = v1.script
    setfenv(self.callback, v3)
    local success, result = xpcall(self.callback, function(a1) -- Line: 203
        return debug.traceback(tostring(a1), 2)
    end)
    if not success then
        self.loadError = result
    end
end

local u17 = {}
u17.__index = u17

function u17.new(a1, a2) -- Line: 218 -- upvalues: u17 (val)
    return (setmetatable({children = {}, testNamePattern = a1, extraEnvironment = a2}, u17))
end

function u17:addChild(a2, a3, a4) -- Line: 231 -- upvalues: getModifier (val), u11 (val)
    local v1 = u11.new(self, a2, a3, (getModifier(a2, self.testNamePattern, a4)))
    table.insert(self.children, v1)
    return v1
end

function u17.addRoot(a1, a2, a3) -- Line: 242 -- upvalues: TestEnum (val)
    local v1
    local v2 = a1
    for i = #a2, 1, -1 do
        v1 = nil
        for i2, v in ipairs(v2.children) do
            if v.phrase == v3[i] then
                v1 = v
                break
            end
        end
        if v1 == nil then
            v1 = v2:addChild(v3[i], TestEnum.NodeType.Describe)
        end
        v2 = v1
    end
    v2.callback = a3
    v2:expand()
end

function u17:visitAllNodes(a2, a3, a4) -- Line: 268
    local v1
    local v2 = a4 or 0
    for i, v in ipairs((a3 or self).children) do
        a2(v, v2)
        v1 = v2 + 1
        self:visitAllNodes(a2, v, v1)
    end
end

function u17.visualize(a1) -- Line: 283
    local u1 = {}
    a1:visitAllNodes(function(a1, a2) -- Line: 285 -- upvalues: u1 (val)
        table.insert(u1, ((" "):rep(3 * a2)) .. a1.phrase)
    end)
    return table.concat(u1, "\n")
end

function u17.findNodes(a1, a2) -- Line: 295
    local u2 = {}
    a1:visitAllNodes(function(a1) -- Line: 297 -- upvalues: a2 (val), u2 (val)
        if a2(a1) then
            table.insert(u2, a1)
        end
    end)
    return u2
end

return u17