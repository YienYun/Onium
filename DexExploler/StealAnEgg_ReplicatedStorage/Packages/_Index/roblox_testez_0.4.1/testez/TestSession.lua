-- Script path: ReplicatedStorage.Packages._Index.roblox_testez@0.4.1.testez.TestSession
-- Decompile time: 4.46 ms

local TestEnum = require(script.Parent.TestEnum)
local TestResults = require(script.Parent.TestResults)
local Context = require(script.Parent.Context)
local ExpectationContext = require(script.Parent.ExpectationContext)
local u20 = {}
u20.__index = u20

function u20.new(a1) -- Line: 24 -- upvalues: TestResults (val), u20 (val)
    local v1 = {
        hasFocusNodes = false,
        results = TestResults.new(a1),
        nodeStack = {},
        contextStack = {},
        expectationContextStack = {},
    }
    setmetatable(v1, u20)
    return v1
end

function u20:calculateTotals() -- Line: 42 -- upvalues: TestEnum (val)
    local results = self.results
    results.successCount = 0
    results.failureCount = 0
    results.skippedCount = 0
    results:visitAllNodes(function(a1) -- Line: 49 -- upvalues: TestEnum (upval), results (val)
        local status = a1.status
        if a1.planNode.type == TestEnum.NodeType.It then
            if status == TestEnum.TestStatus.Success then
                results.successCount = results.successCount + 1
                return
            end
            if status == TestEnum.TestStatus.Failure then
                results.failureCount = results.failureCount + 1
                return
            end
            if status == TestEnum.TestStatus.Skipped then
                results.skippedCount = results.skippedCount + 1
            end
        end
    end)
end

function u20:gatherErrors() -- Line: 68
    local results = self.results
    results.errors = {}
    results:visitAllNodes(function(a1) -- Line: 73 -- upvalues: results (val)
        if #a1.errors > 0 then
            for i, v in ipairs(a1.errors) do
                table.insert(results.errors, v)
            end
        end
    end)
end

function u20.finalize(a1) -- Line: 85
    if #a1.nodeStack ~= 0 then
        error("Cannot finalize TestResults with nodes still on the stack!", 2)
    end
    a1:calculateTotals()
    a1:gatherErrors()
    return a1.results
end

function u20:pushNode(a2) -- Line: 99 -- upvalues: TestResults (val), Context (val), ExpectationContext (val)
    local v1 = TestResults.createNode(a2)
    table.insert((self.nodeStack[#self.nodeStack] or self.results).children, v1)
    table.insert(self.nodeStack, v1)
    table.insert(self.contextStack, (Context.new(self.contextStack[#self.contextStack])))
    table.insert(self.expectationContextStack, (ExpectationContext.new(self.expectationContextStack[#self.expectationContextStack])))
end

function u20:popNode() -- Line: 117
    assert(#self.nodeStack > 0, "Tried to pop from an empty node stack!")
    table.remove(self.nodeStack, #self.nodeStack)
    table.remove(self.contextStack, #self.contextStack)
    table.remove(self.expectationContextStack, #self.expectationContextStack)
end

function u20.getContext(a1) -- Line: 127
    assert(#a1.contextStack > 0, "Tried to get context from an empty stack!")
    return a1.contextStack[#a1.contextStack]
end

function u20.getExpectationContext(a1) -- Line: 132
    assert(#a1.expectationContextStack > 0, "Tried to get expectationContext from an empty stack!")
    return a1.expectationContextStack[#a1.expectationContextStack]
end

function u20.shouldSkip(a1) -- Line: 140 -- upvalues: TestEnum (val)
    local v1
    if not a1.hasFocusNodes then
        for i = #a1.nodeStack, 1, -1 do
            if a1.nodeStack[i].planNode.modifier == TestEnum.NodeModifier.Skip then
                return true
            end
        end
        return false
    end
    for j = #a1.nodeStack, 1, -1 do
        v1 = a1.nodeStack[j]
        if v1.planNode.modifier == TestEnum.NodeModifier.Skip then
            return true
        end
        if v1.planNode.modifier == TestEnum.NodeModifier.Focus then
            return false
        end
    end
    return true
end

function u20.setSuccess(a1) -- Line: 174 -- upvalues: TestEnum (val)
    assert(#a1.nodeStack > 0, "Attempting to set success status on empty stack")
    local v1 = a1.nodeStack[#a1.nodeStack]
    v1.status = TestEnum.TestStatus.Success
end

function u20.setSkipped(a1) -- Line: 182 -- upvalues: TestEnum (val)
    assert(#a1.nodeStack > 0, "Attempting to set skipped status on empty stack")
    local v1 = a1.nodeStack[#a1.nodeStack]
    v1.status = TestEnum.TestStatus.Skipped
end

function u20:setError(a2) -- Line: 191 -- upvalues: TestEnum (val)
    assert(#self.nodeStack > 0, "Attempting to set error status on empty stack")
    local v1 = self.nodeStack[#self.nodeStack]
    v1.status = TestEnum.TestStatus.Failure
    table.insert(v1.errors, a2)
end

function u20.addDummyError(a1, a2, a3) -- Line: 203 -- upvalues: TestEnum (val)
    a1:pushNode({type = TestEnum.NodeType.It, phrase = a2})
    a1:setError(a3)
    a1:popNode()
    local v1 = a1.nodeStack[#a1.nodeStack]
    v1.status = TestEnum.TestStatus.Failure
end

function u20.setStatusFromChildren(a1) -- Line: 215 -- upvalues: TestEnum (val)
    assert(#a1.nodeStack > 0, "Attempting to set status from children on empty stack")
    local v1 = a1.nodeStack[#a1.nodeStack]
    local Success = TestEnum.TestStatus.Success
    local v2 = true
    for i, v in ipairs(v1.children) do
        if v.status ~= TestEnum.TestStatus.Skipped then
            v2 = false
            if v.status == TestEnum.TestStatus.Failure then
                Success = TestEnum.TestStatus.Failure
            end
        end
    end
    if v2 then
        Success = TestEnum.TestStatus.Skipped
    end
    v1.status = Success
end

return u20