-- Script path: ReplicatedStorage.UserGenerated.SFX.PlaySFX
-- Decompile time: 0.35 ms

return function(a1, a2, a3) -- Line: 20 -- types: a1: userdata, a2: userdata, a3: userdata
    local Attachment = Instance.new("Attachment")
    Attachment.CFrame = a1.CFrame:ToObjectSpace(a2)
    a3.Parent = Attachment
    Attachment.Parent = a1
    a3.Ended:Connect(function() -- Line: 25 -- upvalues: Attachment (val)
        Attachment:Destroy()
    end)
    a3:Play()
end