-- Script path: ReplicatedStorage.UserGenerated.Analytics.MicroprofileCapture
-- Decompile time: 35.84 ms

local HttpService = game:GetService("HttpService")
local u5 = {}
local u6 = false

local function finite(a1) -- Line: 56
    local v1 = false
    if type(a1) == "number" then
        v1 = false
        if a1 == a1 then
            v1 = (math.abs(a1)) < (1 / 0)
        end
    end
    return v1
end

local function slice() -- Line: 59
    local u2 = os.clock() + 0.003
    return function() -- Line: 61 -- upvalues: u2 (ref)
        local v1 = os.clock()
        if u2 <= v1 then
            task.wait()
            u2 = os.clock() + 0.003
        end
    end
end

function u5.Validate(a1, a2) -- Line: 69 -- upvalues: HttpService (val)
    local absolute_id, duration_ms, frame_id, group_id, name_2, start_ms, v1, v2, v3, v4, v5, v6, v7, v8, value
    local v9 = false
    if type(a1) == "string" then
        v9 = #a1 <= a2
    end
    assert(v9, "capture_too_large_or_invalid")
    local v10 = HttpService:JSONDecode(a1)
    local v11 = false
    if type(v10) == "table" then
        v11 = v10.version == 1
    end
    assert(v11, "unsupported_format")
    local u32 = os.clock() + 0.003

    local function u974() -- Line: 61 -- upvalues: u32 (ref)
        local v1 = os.clock()
        if u32 <= v1 then
            task.wait()
            u32 = os.clock() + 0.003
        end
    end

    v11 = {}
    local v12 = {}
    local v13 = {}
    local v14 = {}
    local v15 = {}

    local function array(a1) -- Line: 75 -- upvalues: u974 (val)
        local v1
        assert(type(a1) == "table", "invalid_array")
        for k in pairs(a1) do
            v1 = false
            if type(k) == "number" then
                v1 = false
                if k % 1 == 0 then
                    v1 = false
                    if k >= 1 then
                        v1 = k <= #a1
                    end
                end
            end
            assert(v1, "invalid_array")
            u974()
        end
    end

    local function dictionary(a1, a2) -- Line: 82 -- upvalues: array (val), u974 (val)
        local id, v1
        array(a1)
        for i, v in ipairs(a1) do
            id = v.id
            v1 = false
            if type(id) == "number" then
                v1 = false
                if id == id then
                    v1 = (math.abs(id)) < (1 / 0)
                end
            end
            if v1 then
                v1 = false
                if 0 <= v.id then
                    v1 = false
                    if v.id % 1 == 0 then
                        v1 = not v2[v.id]
                    end
                end
            end
            assert(v1, "invalid_id")
            v2[v.id] = v
            u974()
        end
    end

    dictionary(v10.frames, v11)
    dictionary(v10.threads, v12)
    dictionary(v10.timers, v13)
    dictionary(v10.scopes, v14)
    dictionary(v10.memory_counters, v15)
    assert(v11[v10.anchor_frame_id], "invalid_anchor")
    local v16 = false
    if type(v10.complete) == "boolean" then
        v16 = type(v10.stitched) == "boolean"
    end
    assert(v16, "invalid_flags")
    v16 = false
    if type(v10.labels) == "table" then
        v16 = type(v10.origins) == "table"
    end
    assert(v16, "invalid_labels_or_origins")
    local cpu = v10.origins.cpu
    v16 = false
    if type(cpu) == "number" then
        v16 = false
        if cpu == cpu then
            v16 = (math.abs(cpu)) < (1 / 0)
        end
    end
    if v16 then
        local gpu = v10.origins.gpu
        v16 = false
        if type(gpu) == "number" then
            v16 = false
            if gpu == gpu then
                v16 = (math.abs(gpu)) < (1 / 0)
            end
        end
    end
    assert(v16, "invalid_origins")
    array(v10.labels)
    local v17 = {}
    for i, v in ipairs(v10.labels) do
        v1 = false
        if type(v) == "string" then
            v1 = not v17[v]
        end
        assert(v1, "invalid_label")
        v17[v] = true
        u974()
    end
    local v18 = nil
    for i2, i3 in ipairs(v10.frames) do
        absolute_id = i3.absolute_id
        v2 = false
        if type(absolute_id) == "number" then
            v2 = false
            if absolute_id == absolute_id then
                v2 = (math.abs(absolute_id)) < (1 / 0)
            end
        end
        if v2 then
            v2 = false
            if 0 <= i3.absolute_id then
                v2 = i3.absolute_id % 1 == 0
            end
        end
        assert(v2, "invalid_absolute_frame_id")
        for i4, j in ipairs({"cpu", "gpu"}) do
            v8 = i3[j .. "_start_ms"]
            v7 = false
            if type(v8) == "number" then
                v7 = false
                if v8 == v8 then
                    v7 = (math.abs(v8)) < (1 / 0)
                end
            end
            if v7 then
                v8 = i3[j .. "_end_ms"]
                v7 = false
                if type(v8) == "number" then
                    v7 = false
                    if v8 == v8 then
                        v7 = (math.abs(v8)) < (1 / 0)
                    end
                end
                if v7 then
                    v7 = false
                    v8 = i3[j .. "_end_ms"]
                    if i3[j .. "_start_ms"] <= v8 then
                        v8 = i3[j .. "_end_ms"] - i3[j .. "_start_ms"]
                        v7 = false
                        if type(v8) == "number" then
                            v7 = false
                            if v8 == v8 then
                                v7 = (math.abs(v8)) < (1 / 0)
                            end
                        end
                        if v7 then
                            v7 = not v18
                            if not v7 then
                                v8 = i3[j .. "_start_ms"]
                                v7 = v18[j .. "_start_ms"] <= v8
                            end
                        end
                    end
                end
            end
            assert(v7, "invalid_frame")
        end
        v2 = false
        if type(i3.incomplete) == "boolean" then
            v2 = type(i3.stitched) == "boolean"
        end
        assert(v2, "invalid_frame_flags")
        v18 = i3
        u974()
    end
    for i5, k in ipairs(v10.threads) do
        v2 = false
        if type(k.name) == "string" then
            v2 = type(k.is_gpu) == "boolean"
        end
        assert(v2, "invalid_thread")
        u974()
    end
    for i6, n in ipairs(v10.timers) do
        v2 = false
        if type(n.name) == "string" then
            group_id = n.group_id
            v2 = false
            if type(group_id) == "number" then
                v2 = false
                if group_id == group_id then
                    v2 = (math.abs(group_id)) < (1 / 0)
                end
            end
            if v2 then
                v2 = false
                if 0 <= n.group_id then
                    v2 = false
                    if n.group_id % 1 == 0 then
                        v2 = false
                        if type(n.group_name) == "string" then
                            v2 = false
                            if type(n.is_gpu) == "boolean" then
                                v2 = false
                                if type(n.color) == "string" then
                                    v2 = string.match(n.color, "^#%x%x%x%x%x%x$") ~= nil
                                end
                            end
                        end
                    end
                end
            end
        end
        assert(v2, "invalid_timer")
    end
    v16 = {}
    local v19 = {}
    for i7, m in ipairs(v10.scopes) do
        v4 = false
        if 0 < m.id then
            v4 = v12[m.thread_id] and v13[m.timer_id]
        end
        assert(v4, "invalid_reference")
        start_ms = m.start_ms
        v4 = false
        if type(start_ms) == "number" then
            v4 = false
            if start_ms == start_ms then
                v4 = (math.abs(start_ms)) < (1 / 0)
            end
        end
        if v4 then
            duration_ms = m.duration_ms
            v4 = false
            if type(duration_ms) == "number" then
                v4 = false
                if duration_ms == duration_ms then
                    v4 = (math.abs(duration_ms)) < (1 / 0)
                end
            end
            if v4 then
                v4 = false
                if 0 <= m.duration_ms then
                    v5 = m.start_ms + m.duration_ms
                    v4 = false
                    if type(v5) == "number" then
                        v4 = false
                        if v5 == v5 then
                            v4 = (math.abs(v5)) < (1 / 0)
                        end
                    end
                end
            end
        end
        assert(v4, "invalid_timing")
        v4 = false
        if type(m.incomplete_start) == "boolean" then
            v4 = false
            if type(m.incomplete_end) == "boolean" then
                v4 = type(m.stitched) == "boolean"
            end
        end
        assert(v4, "invalid_scope_flags")
        array(m.labels)
        v18 = {}
        for i8, i52 in ipairs(m.labels) do
            assert(v10.labels[i52], "invalid_label_reference")
            table.insert(v18, v10.labels[i52])
            u974()
        end
        v17 = v14[m.parent_id]
        v4 = true
        if m.parent_id ~= 0 then
            v4 = v17
            if v4 then
                v4 = false
                if v17.id < m.id then
                    v4 = false
                    if v17.thread_id == m.thread_id then
                        v4 = false
                        if v17.start_ms <= m.start_ms + 1e-06 then
                            v5 = v17.start_ms + v17.duration_ms + 1e-06
                            v4 = m.start_ms + m.duration_ms <= v5
                        end
                    end
                end
            end
        end
        assert(v4, "invalid_nesting")
        name_2 = v13[m.timer_id].name
        v11 = HttpService:JSONEncode({name_2, v18})
        v3 = v19[v11]
        if not v3 then
            v3 = {
                name = name_2,
                labels = v18,
                min_ms = m.duration_ms,
                max_ms = m.duration_ms,
            }
            v19[v11] = v3
            table.insert(v16, v3)
        else
            v3.min_ms = math.min(v3.min_ms, m.duration_ms)
            v3.max_ms = math.max(v3.max_ms, m.duration_ms)
        end
        u974()
    end
    for i9, i62 in ipairs(v10.memory_counters) do
        v4 = false
        if type(i62.name) == "string" then
            v4 = false
            if type(i62.path) == "string" then
                v4 = type(i62.is_leaf) == "boolean"
            end
        end
        assert(v4, "invalid_counter")
        v4 = true
        if i62.parent_id ~= 0 then
            v4 = v15[i62.parent_id] and i62.parent_id ~= i62.id
        end
        assert(v4, "invalid_counter_parent")
        v3 = {}
        v4 = i62
        while v4 do
            if v4.parent_id == 0 then
                break
            end
            assert(not v3[v4.id], "counter_cycle")
            v3[v4.id] = true
            u974()
            v4 = v15[v4.parent_id]
        end
        v6 = true
        if i62.value ~= nil then
            value = i62.value
            v6 = false
            if type(value) == "number" then
                v6 = false
                if value == value then
                    v6 = (math.abs(value)) < (1 / 0)
                end
            end
            if v6 then
                frame_id = i62.frame_id
                v6 = false
                if type(frame_id) == "number" then
                    v6 = false
                    if frame_id == frame_id then
                        v6 = (math.abs(frame_id)) < (1 / 0)
                    end
                end
                if v6 then
                    v6 = false
                    if 0 <= i62.frame_id then
                        v6 = i62.frame_id % 1 == 0
                    end
                end
            end
        end
        assert(v6, "invalid_counter_sample")
        u974()
    end
    v19 = HttpService:JSONEncode(v16)
    assert(#v19 <= a2, "scope_index_too_large")
    return v10, v19
end

function u5.IsBusy() -- Line: 220 -- upvalues: u6 (ref)
    return u6
end

function u5.Run(a1) -- Line: 223 -- upvalues: u6 (ref)
    if u6 then
        return nil, "capture_busy"
    end
    u6 = true
    local success, err, v1 = pcall(a1)
    u6 = false
    if not success then
        return nil, (tostring(err))
    end
    return err, v1
end

function u5.CreateLabelReader(a1) -- Line: 236
    if type(a1.FetchLabelBufferRegions) == "function" and type(a1.ReadDataLocator) == "function" then
        local success, err = pcall(function() -- Line: 243 -- upvalues: a1 (val)
            return a1:FetchLabelBufferRegions()
        end)
        if success and type(err) == "table" and #err ~= 0 then
            table.sort(err, function(a1, a2) -- Line: 252
                return a1.StartOffset < a2.StartOffset
            end)
            local u19 = {}
            local u22 = os.clock() + 0.003

            local function u23() -- Line: 61 -- upvalues: u22 (ref)
                local v1 = os.clock()
                if u22 <= v1 then
                    task.wait()
                    u22 = os.clock() + 0.003
                end
            end

            return function(a1_2) -- Line: 258 -- upvalues: u19 (val), u23 (val), err (val), a1 (val)
                local err_2, success, v1, v2
                local v3 = u19[a1_2]
                if v3 ~= nil then
                    return not (v3 == false) and v3 or nil
                end
                v3 = a1_2
                local v4 = (1 / 0)
                local v5 = {}
                local v6 = false
                while v4 > 0 do
                    u23()
                    v1 = nil
                    for i, v in ipairs(err) do
                        if v.StartOffset <= v3 and v3 < v.EndOffset then
                            v1 = v
                            break
                        end
                    end
                    if not v1 then
                        break
                    end
                    local u42 = math.min(4096, v4, v1.EndOffset - v3)
                    if u42 <= 0 then
                        break
                    end
                    local u47 = v1.BufferStartLocator + (v3 - v1.StartOffset)
                    success, err_2 = pcall(function() -- Line: 287 -- upvalues: a1 (upval), u47 (val), u42 (val)
                        return a1:ReadDataLocator(u47, u42)
                    end)
                    if not success or type(err_2) ~= "string" or #err_2 == 0 then
                        break
                    end
                    v2 = string.find(err_2, "\000", 1, true)
                    if v2 then
                        v6 = true
                        table.insert(v5, (string.sub(err_2, 1, v2 - 1)))
                        break
                    end
                    table.insert(v5, err_2)
                    v3 = v3 + #err_2
                    v4 = v4 - #err_2
                end
                assert(v6, "incomplete_label")
                v6 = table.concat(v5)
                if utf8.len(v6) == nil then
                    error("invalid_label_utf8")
                end
                u19[a1_2] = v6
                return v6
            end
        end
        return function() -- Line: 247
            error("labels_unavailable")
        end
    end
    return function() -- Line: 238
        error("labels_unavailable")
    end
end

function u5.Export(a1, a2, a3, a4) -- Line: 317 -- upvalues: u5 (val), HttpService (val)
    local u4 = {}
    local success, err, v1 = pcall(function() -- Line: 319 -- upvalues: a1 (val), a2 (val), u4 (val), a3 (val), u5 (upval), HttpService (upval), a4 (val)
        local CurrentEntryWords, CurrentEntryWords_2, CurrentThreadStackElement, CurrentThreadStackElement_3, ThreadStackState, id, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13
        local u2 = os.clock() + 0.003

        local function v14() -- Line: 61 -- upvalues: u2 (ref)
            local v1 = os.clock()
            if u2 <= v1 then
                task.wait()
                u2 = os.clock() + 0.003
            end
        end

        local u960 = a1.Session.OpenFromBuffer(a2)
        assert(u960, "snapshot_unavailable")
        table.insert(u4, u960)
        assert(u960:IsValid(), "invalid_snapshot")
        local u142 = u960:FetchGlobalDesc()
        local u176 = u960:GetFrameIdMin()
        local FrameIdMax = u960:GetFrameIdMax()
        local v15 = false
        if u176 <= FrameIdMax then
            v13 = false
            if u176 == 0 then
                v13 = FrameIdMax == 0
            end
            v15 = not v13
        end
        assert(v15, "no_frames")
        local u144 = u960:FetchFrameDesc(u176)
        local u962 = {version = 1, complete = true, stitched = false, anchor_frame_id = a3 or FrameIdMax}
        u962.origins = {cpu = u144.TickStartCpu, gpu = u144.TickStartGpu}
        u962.frames = {}
        u962.threads = {}
        u962.timers = {}
        u962.labels = {}
        u962.scopes = {}
        u962.memory_counters = {}
        v13 = {}
        local u191 = {}
        local u195 = {}
        local v16 = {}
        local u201 = {}
        for i = u176, FrameIdMax do
            v1 = u960:FetchFrameDesc(i)
            v2 = {
                stitched = false,
                id = i,
                absolute_id = v1.FrameAbsoluteId,
                cpu_start_ms = (v1.TickStartCpu - u144.TickStartCpu) * u142.TickToMsCpu,
                cpu_end_ms = (v1.TickEndCpu - u144.TickStartCpu) * u142.TickToMsCpu,
                gpu_start_ms = (v1.TickStartGpu - u144.TickStartGpu) * u142.TickToMsGpu,
                gpu_end_ms = (v1.TickEndGpu - u144.TickStartGpu) * u142.TickToMsGpu,
                incomplete = v1.IsIncomplete == true,
            }
            table.insert(u962.frames, v2)
            v13[i] = v2
            if v2.incomplete then
                u962.complete = false
            end
            v14()
        end
        assert(v13[u962.anchor_frame_id], "anchor_not_in_snapshot")
        local v17 = u5.CreateLabelReader(u960)
        local v18 = u960:CreateLogIterator()
        table.insert(u4, v18)
        v18:Configure({SkipEvents = true, EmitThreadFrameEnd = true})
        local State = v18:GetState()
        v18:RewindTo(u176, FrameIdMax)
        local u433 = {}

        local function record(a1, a2, a3, a4, a5, a6) -- Line: 370
            -- upvalues: u191 (val), u960 (val), u962 (val), u195 (val), u144 (val), u142 (val), State (val), u201 (val)
            -- upvalues: u176 (val), u433 (val)
            local v1, v2
            local v3 = u191[a2]
            if not v3 then
                v1 = u960:FetchThreadDesc(a2)
                v3 = {id = a2, name = v1.ThreadName, is_gpu = v1.IsGpu == true}
                u191[a2] = v3
                table.insert(u962.threads, v3)
            end
            if not u195[a1] then
                v1 = u960:FetchTimerDesc(a1)
                v2 = {
                    id = a1,
                    name = v1.TimerName,
                    group_id = v1.GroupId,
                    group_name = (u960:FetchGroupDesc(v1.GroupId)).GroupName,
                    is_gpu = v3.is_gpu,
                    color = string.format("#%06x", (bit32.band(v1.Color, 16777215))),
                }
                u195[a1] = v2
                table.insert(u962.timers, v2)
            end
            local is_gpu = v3.is_gpu
            local TickStartGpu = if not is_gpu then u144.TickStartCpu else u144.TickStartGpu
            local TickToMsGpu = if not is_gpu then u142.TickToMsCpu else u142.TickToMsGpu
            v2 = u960:FetchFrameDesc((State:FrameId()))
            local TickStartGpu_2 = if not a3 then if not is_gpu then v2.TickStartCpu else v2.TickStartGpu else a3:EnterTimestampFrameLocal()
            v2 = if not a3 then nil else (tostring(a2)) .. ":" .. tostring((a3:EnterEntryLocator()))
            v1 = v2 and u201[v2]
            local v4 = (TickStartGpu_2 - TickStartGpu) * TickToMsGpu
            local v5 = (a4 - TickStartGpu) * TickToMsGpu
            assert(v4 <= v5, "negative_scope_duration")
            if v1 then
                v1.duration_ms = (math.max(v1.start_ms + v1.duration_ms, v5)) - v1.start_ms
                v1.incomplete_end = a6
                local stitched = v1.stitched or State:IsFrameStitching()
                v1.stitched = stitched
            else
                local v6 = {
                    parent_id = 0,
                    id = #u962.scopes + 1,
                    timer_id = a1,
                    thread_id = a2,
                    labels = {},
                    start_ms = v4,
                    duration_ms = v5 - v4,
                }
                local v7 = true
                if a3 ~= nil then
                    v7 = (a3:EnterFrameId()) < u176
                end
                v6.incomplete_start = v7
                v6.incomplete_end = a6
                v6.stitched = State:IsFrameStitching()
                v6._depth = a5
                v1 = v6
                table.insert(u962.scopes, v1)
                if v2 then
                    u201[v2] = v1
                end
            end
            if v2 and u433[v2] then
                v1.labels = u433[v2]
            end
        end

        while v18:Step() do
            v14()
            if State:IsFrameStitching() then
                u962.stitched = true
                v2 = v13[State:FrameId()]
                v2.stitched = true
            end
            if State:ThreadStackIsOverflowed() or State:ThreadStackWasOverflowed() then
                error("scope_stack_overflow")
            end
            if not State:IsFrameBoundary() then
                v2 = State:ThreadId()
                v3 = State:ThreadStackDepth()
                ThreadStackState = v18:GetThreadStackState(v2)
                if not State:IsLabel() then
                    if not State:IsExit() then
                        if State:IsThreadFrameEnd() then
                            for j = v3 - 1, 0, -1 do
                                CurrentThreadStackElement_3 = v18:GetCurrentThreadStackElement(j)
                                if CurrentThreadStackElement_3 then
                                    record(
                                        CurrentThreadStackElement_3:EnterTimerId(),
                                        v2,
                                        CurrentThreadStackElement_3,
                                        State:Timestamp(),
                                        (ThreadStackState:DepthAbsolute()) - (v3 - j),
                                        true
                                    )
                                end
                                v14()
                            end
                        end
                    elseif not State:ThreadStackWasOverflowed() then
                        v6 = State:TimerId()
                        v9 = State:Timestamp()
                        v10 = ThreadStackState:DepthAbsolute()
                        record(
                            v6,
                            v2,
                            if not State:ThreadStackIsUnderflowed() then v18:GetCurrentThreadStackElement(v3) else nil,
                            v9,
                            v10,
                            false
                        )
                    elseif State:IsThreadFrameEnd() then
                        for k = v3 - 1, 0, -1 do
                            CurrentThreadStackElement_3 = v18:GetCurrentThreadStackElement(k)
                            if CurrentThreadStackElement_3 then
                                record(
                                    CurrentThreadStackElement_3:EnterTimerId(),
                                    v2,
                                    CurrentThreadStackElement_3,
                                    State:Timestamp(),
                                    (ThreadStackState:DepthAbsolute()) - (v3 - k),
                                    true
                                )
                            end
                            v14()
                        end
                    end
                elseif not (v3 > 0) then
                    if not State:IsExit() then
                        if State:IsThreadFrameEnd() then
                            for n = v3 - 1, 0, -1 do
                                CurrentThreadStackElement_3 = v18:GetCurrentThreadStackElement(n)
                                if CurrentThreadStackElement_3 then
                                    record(
                                        CurrentThreadStackElement_3:EnterTimerId(),
                                        v2,
                                        CurrentThreadStackElement_3,
                                        State:Timestamp(),
                                        (ThreadStackState:DepthAbsolute()) - (v3 - n),
                                        true
                                    )
                                end
                                v14()
                            end
                        end
                    elseif not State:ThreadStackWasOverflowed() then
                        v6 = State:TimerId()
                        v9 = State:Timestamp()
                        v10 = ThreadStackState:DepthAbsolute()
                        record(
                            v6,
                            v2,
                            if not State:ThreadStackIsUnderflowed() then v18:GetCurrentThreadStackElement(v3) else nil,
                            v9,
                            v10,
                            false
                        )
                    elseif State:IsThreadFrameEnd() then
                        for m = v3 - 1, 0, -1 do
                            CurrentThreadStackElement_3 = v18:GetCurrentThreadStackElement(m)
                            if CurrentThreadStackElement_3 then
                                record(
                                    CurrentThreadStackElement_3:EnterTimerId(),
                                    v2,
                                    CurrentThreadStackElement_3,
                                    State:Timestamp(),
                                    (ThreadStackState:DepthAbsolute()) - (v3 - m),
                                    true
                                )
                            end
                            v14()
                        end
                    end
                elseif not State:ThreadStackIsOverflowed() then
                    CurrentThreadStackElement = v18:GetCurrentThreadStackElement(v3 - 1)
                    CurrentEntryWords, CurrentEntryWords_2 = v18:GetCurrentEntryWords()
                    if CurrentThreadStackElement and CurrentEntryWords and CurrentEntryWords_2 then
                        v7 = v17(CurrentEntryWords + bit32.band(CurrentEntryWords_2, 65535) * 4294967296)
                        if v7 then
                            v8 = v16[v7]
                            if not v8 then
                                v8 = #u962.labels + 1
                                u962.labels[v8] = v7
                                v16[v7] = v8
                            end
                            v9 = (tostring(v2)) .. ":" .. tostring((CurrentThreadStackElement:EnterEntryLocator()))
                            v10 = u433[v9] or {}
                            u433[v9] = v10
                            table.insert(v10, v8)
                        end
                    end
                elseif not State:IsExit() then
                    if State:IsThreadFrameEnd() then
                        for i5 = v3 - 1, 0, -1 do
                            CurrentThreadStackElement_3 = v18:GetCurrentThreadStackElement(i5)
                            if CurrentThreadStackElement_3 then
                                record(
                                    CurrentThreadStackElement_3:EnterTimerId(),
                                    v2,
                                    CurrentThreadStackElement_3,
                                    State:Timestamp(),
                                    (ThreadStackState:DepthAbsolute()) - (v3 - i5),
                                    true
                                )
                            end
                            v14()
                        end
                    end
                elseif not State:ThreadStackWasOverflowed() then
                    v6 = State:TimerId()
                    v9 = State:Timestamp()
                    v10 = ThreadStackState:DepthAbsolute()
                    record(
                        v6,
                        v2,
                        if not State:ThreadStackIsUnderflowed() then v18:GetCurrentThreadStackElement(v3) else nil,
                        v9,
                        v10,
                        false
                    )
                elseif State:IsThreadFrameEnd() then
                    for i6 = v3 - 1, 0, -1 do
                        CurrentThreadStackElement_3 = v18:GetCurrentThreadStackElement(i6)
                        if CurrentThreadStackElement_3 then
                            record(
                                CurrentThreadStackElement_3:EnterTimerId(),
                                v2,
                                CurrentThreadStackElement_3,
                                State:Timestamp(),
                                (ThreadStackState:DepthAbsolute()) - (v3 - i6),
                                true
                            )
                        end
                        v14()
                    end
                end
            end
        end

        local function less(a1, a2) -- Line: 483
            if a1.thread_id ~= a2.thread_id then
                return a1.thread_id < a2.thread_id
            end
            if a1.start_ms ~= a2.start_ms then
                return a1.start_ms < a2.start_ms
            end
            if a1._depth ~= a2._depth then
                return a1._depth < a2._depth
            end
            return a1.id < a2.id
        end

        local scopes = u962.scopes
        v3 = table.create(#u962.scopes)
        local v19 = 1
        while v19 < #scopes do
            v4 = #scopes
            v5 = v19 * 2
            for i7 = 1, v4, v5 do
                v18 = math.min(i7 + v19, #scopes + 1)
                v17 = math.min(i7 + v19 * 2, #scopes + 1)
                v7 = i7
                v8 = v18
                v9 = v17 - 1
                for i8 = i7, v9 do
                    if not (v7 < v18) then
                        v3[i8] = scopes[v8]
                        v8 = v8 + 1
                    elseif v17 <= v8 then
                        v3[i8] = scopes[v7]
                        v7 = v7 + 1
                    else
                        v11 = scopes[v8]
                        v12 = scopes[v7]
                        if if v11.thread_id == v12.thread_id then if v11.start_ms == v12.start_ms then if v11._depth == v12._depth then v11.id < v12.id else v11._depth < v12._depth else v11.start_ms < v12.start_ms else v11.thread_id < v12.thread_id then
                            v3[i8] = scopes[v8]
                            v8 = v8 + 1
                        else
                            v3[i8] = scopes[v7]
                            v7 = v7 + 1
                        end
                    end
                    v14()
                end
            end
            v4 = v3
            v3 = scopes
            scopes = v4
            v19 = v19 * 2
        end
        u962.scopes = scopes
        v19 = {}
        for i2, v in ipairs(u962.scopes) do
            while #v19 > 0 do
                v3 = v19[#v19]
                if v3.thread_id == v.thread_id and v3._depth < v._depth then
                    v9 = v3.start_ms + v3.duration_ms + 1e-06
                    if v.start_ms + v.duration_ms <= v9 then
                        break
                    end
                end
                table.remove(v19)
            end
            v.id = i2
            id = if not (#v19 > 0) then 0 else v19[#v19].id
            v.parent_id = id
            table.insert(v19, v)
            if v.incomplete_start or v.incomplete_end then
                u962.complete = false
            end
            v14()
        end
        for i3, i9 in ipairs(u962.scopes) do
            i9._depth = nil
        end
        local success, err = pcall(function() -- Line: 541 -- upvalues: u960 (val)
            return u960:CreateCounterIterator()
        end)
        u962.memory_available = success and err ~= nil
        if u962.memory_available then
            local err_2, success_2
            table.insert(u4, err)
            v4 = err:GetState()
            while err:Step() do
                local u760 = v4:CounterId()
                v7 = {}
                for i10 = 0, (v4:Level()) do
                    table.insert(v7, (u960:FetchCounterDesc((err:GetStackElement(i10)))).CounterName)
                end
                v19 = {
                    id = u760,
                    parent_id = if not (0 < (v4:Level())) then 0 else err:GetStackElement((v4:Level()) - 1),
                    name = u960:FetchCounterDesc(u760).CounterName,
                    path = table.concat(v7, "/"),
                    is_leaf = v4:IsLeaf(),
                }
                success_2, err_2 = pcall(function() -- Line: 560 -- upvalues: u960 (val), u760 (val)
                    return u960:FetchLastCounterSample(u760)
                end)
                if success_2 and err_2 then
                    v19.value = err_2.Value
                    v19.frame_id = err_2.FrameId
                end
                table.insert(u962.memory_counters, v19)
                v14()
            end
        end
        v5 = HttpService:JSONEncode(u962)
        _, v7 = u5.Validate(v5, a4)
        return v5, v7
    end)
    for i = #u4, 1, -1 do
        pcall(function() -- Line: 576 -- upvalues: u4 (val), i (val)
            u4[i]:Dispose()
        end)
    end
    if not success then
        error(err, 0)
    end
    return err, v1
end

return u5