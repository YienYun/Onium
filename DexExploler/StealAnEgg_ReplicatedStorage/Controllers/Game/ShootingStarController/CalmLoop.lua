-- Script path: ReplicatedStorage.Controllers.Game.ShootingStarController.CalmLoop
-- Decompile time: 1.51 ms

local u0 = {}
u0.__index = u0

function u0.new(a1, a2, a3, a4) -- Line: 24
    -- upvalues: u0 (val)
    local v1 = a1:LoadAnimation(a2)
    local v2 = a1:LoadAnimation(a2)
    v1.Looped = true
    v2.Looped = true
    return (setmetatable({
        _index = 1,
        _speed = 1,
        _playing = false,
        Track = v1,
        _tracks = {v1, v2},
        _end = a3,
        _fade = a4 or 0.45,
    }, u0))
end

function u0:Play(a2) -- Line: 45 -- types: a2: number?
    self._playing = true
    self.Track:Play(a2 or 0)
    self.Track:AdjustSpeed(self._speed)
end

function u0:Stop(a2) -- Line: 51 -- types: a2: number?
    self._playing = false
    for i, j in self._tracks do
        j:Stop(a2 or 0.2)
    end
end

function u0.SetSpeed(a1, a2) -- Line: 58 -- types: a2: number
    if a2 == a1._speed then
        return
    end
    a1._speed = a2
    for i, j in a1._tracks do
        if j.IsPlaying then
            j:AdjustSpeed(a2)
        end
    end
end

function u0.Seek(a1, a2) -- Line: 70 -- types: a2: number
    a1.Track.TimePosition = a2 % a1._end
end

function u0.Step(a1, a2) -- Line: 74 -- types: a2: boolean
    local Track = a1.Track
    if a2 and a1._playing and Track.IsPlaying then
        if Track.TimePosition < a1._end - a1._fade * a1._speed then
            return
        end
        a1._index = 3 - a1._index
        local v1 = a1._tracks[a1._index]
        v1:Play(a1._fade)
        v1.TimePosition = 0
        v1:AdjustSpeed(a1._speed)
        Track:Stop(a1._fade)
        a1.Track = v1
        return
    end
end

return u0