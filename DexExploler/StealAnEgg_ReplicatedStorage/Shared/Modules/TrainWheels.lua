-- Script path: ReplicatedStorage.Shared.Modules.TrainWheels
-- Decompile time: 2.47 ms

return {
    Bind = function(a1) -- Line: 4
        local Attribute, Attribute_2, Pivot, v1
        local v2 = {}
        local v3 = nil
        local v4 = nil
        for i, j in a1, v3, v4 do
            for k, n in j:GetChildren() do
                if n:IsA("Model") and n:GetAttribute("TrainWheel") == true then
                    Attribute = n:GetAttribute("TrainWheelRadius")
                    Attribute_2 = n:GetAttribute("TrainWheelAxis")
                    v1 = false
                    if type(Attribute) == "number" then
                        v1 = false
                        if Attribute > 0 then
                            v1 = Attribute < (1 / 0)
                        end
                    end
                    assert(v1, "Invalid train wheel radius")
                    v1 = false
                    if typeof(Attribute_2) == "Vector3" then
                        v1 = (math.abs(Attribute_2.Magnitude - 1)) < 0.001
                    end
                    assert(v1, "Invalid train wheel axle")
                    Pivot = n:GetPivot()
                    v1 = (Pivot:VectorToWorldSpace(Attribute_2)):Dot((j:GetPivot()).RightVector)
                    assert(0.99 < (math.abs(v1)), "Train wheel axle is not lateral")
                    table.insert(v2, {
                        Car = j,
                        Model = n,
                        Frame = j:GetPivot():ToObjectSpace(Pivot),
                        Axis = Attribute_2,
                        Radius = Attribute,
                        Direction = if not (v1 > 0) then -1 else 1,
                    })
                end
            end
        end
        return v2
    end,
    Update = function(a1, a2) -- Line: 31
        local v1
        for i, j in a1 do
            if j.Model.Parent and j.Car.Parent then
                v1 = -a2 / j.Radius * j.Direction % 6.283185307179586
                j.Model:PivotTo((j.Car:GetPivot()) * j.Frame * (CFrame.fromAxisAngle(j.Axis, v1)))
            end
        end
    end,
}