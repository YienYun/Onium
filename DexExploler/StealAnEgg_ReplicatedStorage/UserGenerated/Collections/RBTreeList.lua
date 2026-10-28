-- Script path: ReplicatedStorage.UserGenerated.Collections.RBTreeList
-- Decompile time: 20.50 ms

local height, insert, is23, isBST, isBalanced, rank, remove, removeMax, removeMin, selectRank, size

local function insertRight2(a1, a2) -- Line: 75 -- types: a1: table, a2: table
    local Right2 = a1.Right2
    a2.Right2 = Right2
    a2.Left2 = a1
    a1.Right2 = a2
    Right2.Left2 = a2
end

local function unlink2(a1) -- Line: 83 -- types: a1: table
    a1.Left2.Right2 = a1.Right2
    a1.Right2.Left2 = a1.Left2
end

local function unlink(a1) -- Line: 88 -- types: a1: table
    a1.Left2.Right2 = a1.Right2
    a1.Right2.Left2 = a1.Left2
    a1.Left1 = nil
    a1.Right1 = nil
    a1.Left2 = nil
    a1.Right2 = nil
end

local function isRed(a1) -- Line: 98 -- types: a1: table?
    if a1 then
        return a1.Color1
    end
    return false
end

local function rotateLeft(a1) -- Line: 106 -- types: a1: table
    local Right1 = a1.Right1
    a1.Right1 = Right1.Left1
    Right1.Left1 = a1
    Right1.Color1 = a1.Color1
    a1.Color1 = true
    return Right1
end

local function rotateRight(a1) -- Line: 116 -- types: a1: table
    local Left1 = a1.Left1
    a1.Left1 = Left1.Right1
    Left1.Right1 = a1
    Left1.Color1 = a1.Color1
    a1.Color1 = true
    return Left1
end

local function flipColors(a1) -- Line: 126 -- types: a1: table
    a1.Color1 = not a1.Color1
    local Left1 = a1.Left1
    Left1.Color1 = not Left1.Color1
    local Right1 = a1.Right1
    Right1.Color1 = not Right1.Color1
end

local function moveRedLeft(a1) -- Line: 136 -- types: a1: table
    local Right1
    a1.Color1 = not a1.Color1
    local Left1 = a1.Left1
    Left1.Color1 = not Left1.Color1
    local Right1_2 = a1.Right1
    Right1_2.Color1 = not Right1_2.Color1
    local Left1_2 = a1.Right1.Left1
    if not (if not Left1_2 then false else Left1_2.Color1) then
        Right1 = a1
    else
        local Right1_3 = a1.Right1
        local Left1_3 = Right1_3.Left1
        Right1_3.Left1 = Left1_3.Right1
        Left1_3.Right1 = Right1_3
        Left1_3.Color1 = Right1_3.Color1
        Right1_3.Color1 = true
        a1.Right1 = Left1_3
        local v1 = a1
        Right1 = v1.Right1
        v1.Right1 = Right1.Left1
        Right1.Left1 = v1
        Right1.Color1 = v1.Color1
        v1.Color1 = true
        Right1.Color1 = not Right1.Color1
        local Left1_4 = Right1.Left1
        Left1_4.Color1 = not Left1_4.Color1
        local Right1_4 = Right1.Right1
        Right1_4.Color1 = not Right1_4.Color1
    end
    return Right1
end

local function moveRedRight(a1) -- Line: 148 -- types: a1: table
    local Left1
    a1.Color1 = not a1.Color1
    local Left1_2 = a1.Left1
    Left1_2.Color1 = not Left1_2.Color1
    local Right1 = a1.Right1
    Right1.Color1 = not Right1.Color1
    local Left1_3 = a1.Left1.Left1
    if not (if not Left1_3 then false else Left1_3.Color1) then
        Left1 = a1
    else
        local v1 = a1
        Left1 = v1.Left1
        v1.Left1 = Left1.Right1
        Left1.Right1 = v1
        Left1.Color1 = v1.Color1
        v1.Color1 = true
        Left1.Color1 = not Left1.Color1
        local Left1_4 = Left1.Left1
        Left1_4.Color1 = not Left1_4.Color1
        local Right1_2 = Left1.Right1
        Right1_2.Color1 = not Right1_2.Color1
    end
    return Left1
end

local function balance(a1) -- Line: 158 -- types: a1: table
    local Right1_2, v1
    local Right1 = a1.Right1
    if not (if not Right1 then false else Right1.Color1) then
        Right1_2 = a1
    else
        v1 = a1
        Right1_2 = v1.Right1
        v1.Right1 = Right1_2.Left1
        Right1_2.Left1 = v1
        Right1_2.Color1 = v1.Color1
        v1.Color1 = true
    end
    local Left1 = Right1_2.Left1
    if if not Left1 then false else Left1.Color1 then
        local Left1_2 = Right1_2.Left1.Left1
        if if not Left1_2 then false else Left1_2.Color1 then
            v1 = Right1_2
            Right1_2 = v1.Left1
            v1.Left1 = Right1_2.Right1
            Right1_2.Right1 = v1
            Right1_2.Color1 = v1.Color1
            v1.Color1 = true
        end
    end
    local Left1_3 = Right1_2.Left1
    if if not Left1_3 then false else Left1_3.Color1 then
        local Right1_3 = Right1_2.Right1
        if if not Right1_3 then false else Right1_3.Color1 then
            Right1_2.Color1 = not Right1_2.Color1
            local Left1_4 = Right1_2.Left1
            Left1_4.Color1 = not Left1_4.Color1
            local Right1_4 = Right1_2.Right1
            Right1_4.Color1 = not Right1_4.Color1
        end
    end
    return Right1_2
end

function removeMin(a1) -- Line: 171 -- upvalues: removeMin (val), balance (val) -- types: a1: table
    local Right1
    if not a1.Left1 then
        return nil, a1
    end
    local Left1 = a1.Left1
    if if not Left1 then false else Left1.Color1 then
        Right1 = a1
    else
        local Left1_2 = a1.Left1.Left1
        if if not Left1_2 then false else Left1_2.Color1 then
            Right1 = a1
        else
            a1.Color1 = not a1.Color1
            local Left1_3 = a1.Left1
            Left1_3.Color1 = not Left1_3.Color1
            local Right1_2 = a1.Right1
            Right1_2.Color1 = not Right1_2.Color1
            local Left1_4 = a1.Right1.Left1
            if not (if not Left1_4 then false else Left1_4.Color1) then
                Right1 = a1
            else
                local Right1_3 = a1.Right1
                local Left1_5 = Right1_3.Left1
                Right1_3.Left1 = Left1_5.Right1
                Left1_5.Right1 = Right1_3
                Left1_5.Color1 = Right1_3.Color1
                Right1_3.Color1 = true
                a1.Right1 = Left1_5
                local v1 = a1
                Right1 = v1.Right1
                v1.Right1 = Right1.Left1
                Right1.Left1 = v1
                Right1.Color1 = v1.Color1
                v1.Color1 = true
                Right1.Color1 = not Right1.Color1
                local Left1_6 = Right1.Left1
                Left1_6.Color1 = not Left1_6.Color1
                local Right1_4 = Right1.Right1
                Right1_4.Color1 = not Right1_4.Color1
            end
        end
    end
    local v2, v3 = removeMin(Right1.Left1)
    Right1.Left1 = v2
    return (balance(Right1)), v3
end

function removeMax(a1) -- Line: 183 -- upvalues: removeMax (val), balance (val) -- types: a1: table
    local Left1_2, v1
    local Left1 = a1.Left1
    if not (if not Left1 then false else Left1.Color1) then
        Left1_2 = a1
    else
        v1 = a1
        Left1_2 = v1.Left1
        v1.Left1 = Left1_2.Right1
        Left1_2.Right1 = v1
        Left1_2.Color1 = v1.Color1
        v1.Color1 = true
    end
    if not Left1_2.Right1 then
        return nil, Left1_2
    end
    local Right1 = Left1_2.Right1
    if not (if not Right1 then false else Right1.Color1) then
        local Left1_3 = Left1_2.Right1.Left1
        if not (if not Left1_3 then false else Left1_3.Color1) then
            Left1_2.Color1 = not Left1_2.Color1
            local Left1_4 = Left1_2.Left1
            Left1_4.Color1 = not Left1_4.Color1
            local Right1_2 = Left1_2.Right1
            Right1_2.Color1 = not Right1_2.Color1
            local Left1_5 = Left1_2.Left1.Left1
            if if not Left1_5 then false else Left1_5.Color1 then
                v1 = Left1_2
                Left1_2 = v1.Left1
                v1.Left1 = Left1_2.Right1
                Left1_2.Right1 = v1
                Left1_2.Color1 = v1.Color1
                v1.Color1 = true
                Left1_2.Color1 = not Left1_2.Color1
                local Left1_6 = Left1_2.Left1
                Left1_6.Color1 = not Left1_6.Color1
                local Right1_3 = Left1_2.Right1
                Right1_3.Color1 = not Right1_3.Color1
            end
        end
    end
    local v2, v3 = removeMax(Left1_2.Right1)
    Left1_2.Right1 = v2
    return (balance(Left1_2)), v3
end

function height(a1) -- Line: 198 -- upvalues: height (val) -- types: a1: table?
    if a1 then
        return math.max(height(a1.Left1), (height(a1.Right1))) + 1
    end
    return -1
end

function isBST(a1, a2, a3, a4) -- Line: 205 -- upvalues: isBST (val) -- types: a1: function, a2: table?
    if not a2 then
        return true
    end
    if a3 ~= nil and (a1(a2.Key, a3)) <= 0 then
        return false
    end
    if a4 ~= nil and 0 <= (a1(a2.Key, a4)) then
        return false
    end
    return isBST(a1, a2.Left1, a3, a2.Key) and isBST(a1, a2.Right1, a2.Key, a4)
end

function remove(a1, a2, a3) -- Line: 219
    -- upvalues: remove (val), removeMin (val), balance (val)
    local v1 = nil
    if a2 then
        local v2
        local v3 = a1(a2.Key, a3)
        if not (v3 > 0) then
            local Left1_7 = a2.Left1
            if if not Left1_7 then false else Left1_7.Color1 then
                v3 = a2
                a2 = v3.Left1
                v3.Left1 = a2.Right1
                a2.Right1 = v3
                a2.Color1 = v3.Color1
                v3.Color1 = true
            end
            if a1(a2.Key, a3) == 0 and not a2.Right1 then
                a2.Left2.Right2 = a2.Right2
                a2.Right2.Left2 = a2.Left2
                a2.Left1 = nil
                a2.Right1 = nil
                a2.Left2 = nil
                a2.Right2 = nil
                return nil, a2
            end
            if a2.Right1 then
                local Right1_5 = a2.Right1
                if not (if not Right1_5 then false else Right1_5.Color1) then
                    local Left1_8 = a2.Right1.Left1
                    if not (if not Left1_8 then false else Left1_8.Color1) then
                        a2.Color1 = not a2.Color1
                        local Left1_9 = a2.Left1
                        Left1_9.Color1 = not Left1_9.Color1
                        local Right1_6 = a2.Right1
                        Right1_6.Color1 = not Right1_6.Color1
                        local Left1_10 = a2.Left1.Left1
                        if if not Left1_10 then false else Left1_10.Color1 then
                            v3 = a2
                            a2 = v3.Left1
                            v3.Left1 = a2.Right1
                            a2.Right1 = v3
                            a2.Color1 = v3.Color1
                            v3.Color1 = true
                            a2.Color1 = not a2.Color1
                            local Left1_11 = a2.Left1
                            Left1_11.Color1 = not Left1_11.Color1
                            local Right1_7 = a2.Right1
                            Right1_7.Color1 = not Right1_7.Color1
                        end
                    end
                end
            end
            if a1(a2.Key, a3) ~= 0 then
                v3, v2 = remove(a1, a2.Right1, a3)
                a2.Right1 = v3
                v1 = v2
            else
                local Left1_12 = a2.Left1
                local Right1_8 = a2.Right1
                local Color1_8 = a2.Color1
                a2.Left2.Right2 = a2.Right2
                a2.Right2.Left2 = a2.Left2
                a2.Left1 = nil
                a2.Right1 = nil
                a2.Left2 = nil
                a2.Right2 = nil
                v1 = a2
                if not Left1_12 or not Right1_8 then
                    a2 = Left1_12 or Right1_8
                else
                    local v4, v5 = removeMin(Right1_8)
                    a2 = v5
                    a2.Right1 = v4
                    a2.Left1 = Left1_12
                end
                a2.Color1 = Color1_8
            end
        else
            local Left1 = a2.Left1
            if not (if not Left1 then false else Left1.Color1) then
                local Left1_2 = a2.Left1.Left1
                if not (if not Left1_2 then false else Left1_2.Color1) then
                    a2.Color1 = not a2.Color1
                    local Left1_3 = a2.Left1
                    Left1_3.Color1 = not Left1_3.Color1
                    local Right1 = a2.Right1
                    Right1.Color1 = not Right1.Color1
                    local Left1_4 = a2.Right1.Left1
                    if if not Left1_4 then false else Left1_4.Color1 then
                        local Right1_2 = a2.Right1
                        local Left1_5 = Right1_2.Left1
                        Right1_2.Left1 = Left1_5.Right1
                        Left1_5.Right1 = Right1_2
                        Left1_5.Color1 = Right1_2.Color1
                        Right1_2.Color1 = true
                        a2.Right1 = Left1_5
                        v3 = a2
                        a2 = v3.Right1
                        v3.Right1 = a2.Left1
                        a2.Left1 = v3
                        a2.Color1 = v3.Color1
                        v3.Color1 = true
                        a2.Color1 = not a2.Color1
                        local Left1_6 = a2.Left1
                        Left1_6.Color1 = not Left1_6.Color1
                        local Right1_4 = a2.Right1
                        Right1_4.Color1 = not Right1_4.Color1
                    end
                end
            end
            v3, v2 = remove(a1, a2.Left1, a3)
            a2.Left1 = v3
            v1 = v2
        end
        a2 = balance(a2)
    end
    return a2, v1
end

function insert(a1, a2, a3, a4, a5) -- Line: 262
    -- upvalues: insert (val), balance (val)
    local v1
    if not a2 then
        v1 = {Color1 = true, Key = a4, Value = a5}
        local Right2 = a3.Right2
        v1.Right2 = Right2
        v1.Left2 = a3
        a3.Right2 = v1
        Right2.Left2 = v1
        return v1, v1, true
    end
    local v2 = a1(a2.Key, a4)
    if v2 ~= 0 then
        local v3, v4, v5
        if not (v2 > 0) then
            v4, v5, v3 = insert(a1, a2.Right1, a2, a4, a5)
            a2.Right1 = v4
        else
            v4, v5, v3 = insert(a1, a2.Left1, a2.Left2, a4, a5)
            a2.Left1 = v4
        end
        v1 = v5
        if v3 then
            a2 = balance(a2)
        end
    else
        v1 = a2
        a2.Value = a5
    end
    return a2, v1, false
end

function isBalanced(a1, a2) -- Line: 293 -- upvalues: isBalanced (val) -- types: a1: table?, a2: number
    if not a1 then
        return a2 == 0
    end
    local v1 = if if not a1 then false else a1.Color1 then a2 else a2 - 1
    return isBalanced(a1.Left1, v1) and isBalanced(a1.Right1, v1)
end

function size(a1) -- Line: 303 -- upvalues: size (val) -- types: a1: table?
    local v1 = 0
    if a1 then
        v1 = v1 + 1 + size(a1.Left1)
        v1 = v1 + size(a1.Right1)
    end
    return v1
end

function selectRank(a1, a2) -- Line: 313 -- upvalues: size (val), selectRank (val) -- types: a1: table?, a2: number
    if not a1 then
        return nil
    end
    local Left1 = a1.Left1
    local v1 = 0
    if Left1 then
        v1 = v1 + 1 + size(Left1.Left1)
        v1 = v1 + size(Left1.Right1)
    end
    if a2 < v1 then
        return selectRank(a1.Left1, a2)
    end
    if v1 < a2 then
        return selectRank(a1.Right1, a2 - v1 - 1)
    end
    return a1.Key
end

function rank(a1, a2, a3) -- Line: 327 -- upvalues: rank (val), size (val) -- types: a1: function, a3: table?
    if not a3 then
        return 0
    end
    local v1 = a1(a3.Key, a2)
    if v1 > 0 then
        return rank(a1, a2, a3.Left1)
    end
    if v1 < 0 then
        local Left1 = a3.Left1
        local v2 = 0
        if Left1 then
            v2 = v2 + 1 + size(Left1.Left1)
            v2 = v2 + size(Left1.Right1)
        end
        return v2 + 1 + rank(a1, a2, a3.Right1)
    end
    local Left1_2 = a3.Left1
    local v3 = 0
    if Left1_2 then
        v3 = v3 + 1 + size(Left1_2.Left1)
        v3 = v3 + size(Left1_2.Right1)
    end
    return v3
end

function is23(a1, a2) -- Line: 341 -- upvalues: is23 (val) -- types: a1: table?, a2: table?
    if not a2 then
        return true
    end
    local Right1 = a2.Right1
    if if not Right1 then false else Right1.Color1 then
        return false
    end
    if a2 ~= a1 and (if not a2 then false else a2.Color1) then
        local Left1 = a2.Left1
        if if not Left1 then false else Left1.Color1 then
            return false
        end
    end
    return is23(a1, a2.Left1) and is23(a2.Right1)
end

local v1 = {}
local u24 = table.freeze({__index = v1})

function v1.Insert(a1, a2, a3) -- Line: 360 -- upvalues: insert (val)
    local v1, v2, v3 = insert(a1.Comparator, a1.Root, a1.List, a2, a3)
    v1.Color1 = false
    a1.Root = v1
    if v3 then
        a1.Size = a1.Size + 1
    end
    return v2, v3
end

function v1.Remove(a1, a2) -- Line: 370 -- upvalues: remove (val)
    local Root = a1.Root
    if Root then
        local Left1 = Root.Left1
        if not (if not Left1 then false else Left1.Color1) then
            local Right1 = Root.Right1
            if not (if not Right1 then false else Right1.Color1) then
                Root.Color1 = true
            end
        end
        local v1, v2 = remove(a1.Comparator, Root, a2)
        local v3 = v1
        if v3 then
            v3.Color1 = false
        end
        a1.Root = v3
        if v2 then
            a1.Size = a1.Size - 1
        end
    end
    return nil
end

function v1.RemoveMin(a1) -- Line: 389 -- upvalues: removeMin (val)
    local Root = a1.Root
    if Root then
        local Left1 = Root.Left1
        if not (if not Left1 then false else Left1.Color1) then
            local Right1 = Root.Right1
            if not (if not Right1 then false else Right1.Color1) then
                Root.Color1 = true
            end
        end
        local v1, v2 = removeMin(Root)
        local v3 = v1
        if v3 then
            v3.Color1 = false
        end
        a1.Root = v3
        if v2 then
            a1.Size = a1.Size - 1
        end
    end
    return nil
end

function v1.RemoveMax(a1) -- Line: 408 -- upvalues: removeMax (val)
    local Root = a1.Root
    if Root then
        local Left1 = Root.Left1
        if not (if not Left1 then false else Left1.Color1) then
            local Right1 = Root.Right1
            if not (if not Right1 then false else Right1.Color1) then
                Root.Color1 = true
            end
        end
        local v1, v2 = removeMax(Root)
        local v3 = v1
        if v3 then
            v3.Color1 = false
        end
        a1.Root = v3
        if v2 then
            a1.Size = a1.Size - 1
        end
    end
    return nil
end

function v1.Min(a1) -- Line: 427
    local List = a1.List
    local Left1 = List.Left1
    if Left1 ~= List then
        return Left1
    end
    return nil
end

function v1.Max(a1) -- Line: 436
    local List = a1.List
    local Right1 = List.Right1
    if Right1 ~= List then
        return Right1
    end
    return nil
end

function v1.GetSize(a1) -- Line: 445
    return a1.Size
end

function v1:ForEach(a2) -- Line: 449
    assert(type(a2) == "function")
    local List = self.List
    local Right2 = List
    while true do
        Right2 = Right2.Right2
        if Right2 == List then
            break
        end
        a2(Right2.Key, Right2.Value)
    end
end

function v1.Next(a1, a2) -- Line: 462
    local List = a1.List
    local Right2 = (if a2 == nil then a1.List else a2).Right2
    if Right2 ~= List then
        return Right2, Right2
    end
    return nil, nil
end

function v1.Iterator(a1) -- Line: 472
    return a1.Next, a1
end

function v1:IsBST() -- Line: 476 -- upvalues: isBST (val)
    local Comparator = self.Comparator
    local Root = self.Root
    if not Root then
        return true
    end
    local v1 = isBST(Comparator, Root.Left1, nil, Root.Key)
    if v1 then
        return (isBST(Comparator, Root.Right1, Root.Key, nil))
    end
    return v1
end

function v1:IsSizeConsistent() -- Line: 480 -- upvalues: size (val)
    local Size = self.Size
    local Root = self.Root
    local v1 = 0
    if Root then
        v1 = v1 + 1 + size(Root.Left1)
        v1 = v1 + size(Root.Right1)
    end
    if Size ~= v1 then
        return false
    end
    v1 = 0
    local List = self.List
    local Right2 = List
    while true do
        Right2 = Right2.Right2
        if Right2 == List then
            break
        end
        v1 = v1 + 1
    end
    if Size ~= v1 then
        return false
    end
    return true
end

function v1:IsRankConsistent() -- Line: 502 -- upvalues: size (val), selectRank (val), rank (val)
    local Key, Left1, Root, v1
    local v2 = self.Size - 1
    for i = 0, v2 do
        Root = self.Root
        if not Root then
            Key = nil
        else
            Left1 = Root.Left1
            v1 = 0
            if Left1 then
                v1 = v1 + 1 + size(Left1.Left1)
                v1 = v1 + size(Left1.Right1)
            end
            Key = if not (i < v1) then if not (v1 < i) then Root.Key else selectRank(Root.Right1, i - v1 - 1) else selectRank(Root.Left1, i)
        end
        if i ~= rank(self.Comparator, Key, self.Root) then
            return false
        end
    end
    self:ForEach(function(a1, a2) -- Line: 512 -- upvalues: rank (upval), self (val), size (upval), selectRank (upval)
        local Key
        local v1 = rank(self.Comparator, a1, self.Root)
        local Root = self.Root
        if not Root then
            Key = nil
        else
            local Left1 = Root.Left1
            local v2 = 0
            if Left1 then
                v2 = v2 + 1 + size(Left1.Left1)
                v2 = v2 + size(Left1.Right1)
            end
            Key = if not (v1 < v2) then if not (v2 < v1) then Root.Key else selectRank(Root.Right1, v1 - v2 - 1) else selectRank(Root.Left1, v1)
        end
        if self.Comparator(Key, a1) ~= 0 then
            return false
        end
    end)
    return true
end

function v1:Is23() -- Line: 522 -- upvalues: is23 (val)
    return (is23(self.Root, self.Root))
end

function v1:IsBalanced() -- Line: 526 -- upvalues: isBalanced (val)
    local v1 = 0
    local Root = self.Root
    local Left1 = Root
    while Left1 do
        if not (if not Left1 then false else Left1.Color1) then
            v1 = v1 + 1
        end
        Left1 = Left1.Left1
    end
    local v2 = v1
    if not Root then
        return v2 == 0
    end
    if not (if not Root then false else Root.Color1) then
        v2 = v2 - 1
    end
    local v3 = isBalanced(Root.Left1, v2)
    if v3 then
        return (isBalanced(Root.Right1, v2))
    end
    return v3
end

function v1.Check(a1) -- Line: 539
    if not a1:IsBST() then
        return false, "Not in symmetric order"
    end
    if not a1:IsSizeConsistent() then
        return false, "Subtree counts not consistent"
    end
    if not a1:IsRankConsistent() then
        return false, "Ranks not consistent"
    end
    if not a1:Is23() then
        return false, "Not a 2-3 tree"
    end
    if not a1:IsBalanced() then
        return false, "Not balanced"
    end
    return true
end

table.freeze(v1)
return table.freeze({
    Compare = function(a1, a2) -- Line: 563
        if a1 < a2 then
            return -1
        end
        if a2 < a1 then
            return 1
        end
        return 0
    end,
    new = function(a1, a2, a3) -- Line: 573 -- upvalues: u24 (val) -- types: a1: function
        assert(type(a1) == "function")
        local v1 = {Color1 = false}
        v1.Left2 = v1
        v1.Right2 = v1
        return (setmetatable({Size = 0, Comparator = a1, List = v1}, u24))
    end,
})