-- Script path: ReplicatedStorage.Packages._Index.roblox_testez@0.4.1.testez
-- Decompile time: 1.02 ms

local Expectation = require(script.Expectation)
local TestBootstrap = require(script.TestBootstrap)
local TestEnum = require(script.TestEnum)
local TestPlan = require(script.TestPlan)
local TestPlanner = require(script.TestPlanner)
local TestResults = require(script.TestResults)
local TestRunner = require(script.TestRunner)
local TestSession = require(script.TestSession)
local TextReporter = require(script.Reporters.TextReporter)
local TextReporterQuiet = require(script.Reporters.TextReporterQuiet)
local TeamCityReporter = require(script.Reporters.TeamCityReporter)
return {
    run = function(a1, a2) -- Line: 13 -- upvalues: TestBootstrap (val), TestPlanner (val), TestRunner (val)
        a2((TestRunner.runPlan((TestPlanner.createPlan((TestBootstrap:getModules(a1)))))))
    end,
    Expectation = Expectation,
    TestBootstrap = TestBootstrap,
    TestEnum = TestEnum,
    TestPlan = TestPlan,
    TestPlanner = TestPlanner,
    TestResults = TestResults,
    TestRunner = TestRunner,
    TestSession = TestSession,
    Reporters = {
        TextReporter = TextReporter,
        TextReporterQuiet = TextReporterQuiet,
        TeamCityReporter = TeamCityReporter,
    },
}