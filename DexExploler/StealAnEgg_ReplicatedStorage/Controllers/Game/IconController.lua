-- Script path: ReplicatedStorage.Controllers.Game.IconController
-- Decompile time: 1.10 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Icons = require(script.Icons)
local ImagePreloader = require(ReplicatedStorage.Client.ImagePreloader)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
return {
    Start = function() -- Line: 21 -- upvalues: ImagePreloader (val), TableUtil (val), Icons (val), CollectionService (val)
        ImagePreloader.RequestAll(TableUtil.Values(Icons.Preload))

        local function onImageLabelAdded(a1) -- Line: 24 -- upvalues: Icons (upval) -- types: a1: userdata?
            if typeof(a1) == "Instance" and a1:IsA("ImageLabel") then
                local Attribute = a1:GetAttribute("IconId")
                local v1 = Attribute and Icons.All[Attribute]
                if not v1 then
                    warn("Invalid icon id", Attribute, " | ", a1:GetFullName())
                    return
                end
                a1.Image = v1
                return
            end
        end

        ;(CollectionService:GetInstanceAddedSignal("ICON")):Connect(onImageLabelAdded)
        for i, j in CollectionService:GetTagged("ICON") do
            task.spawn(onImageLabelAdded, j)
        end
    end,
}