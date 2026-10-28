-- Script path: ReplicatedStorage.UserGenerated.Concurrency.ThreadJoin
-- Decompile time: 0.30 ms

return function(a1, a2) -- Line: 20 -- types: a1: thread, a2: number?
    local v1 = os.clock()
    local v2, v3 = a1, a2
    while coroutine.status(v2) ~= "dead" do
        if v3 ~= nil and v3 <= os.clock() - v1 then
            return false
        end
        task.wait()
    end
    return true
end