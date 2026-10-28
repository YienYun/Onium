-- Script path: ReplicatedStorage.Shared.Modules.ItemDisplay
-- Decompile time: 0.65 ms

local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetDisplayText = require(ReplicatedStorage.Shared.Modules.AssetDisplayText)
local AssetInfoBillboard = require(ReplicatedStorage.Shared.Modules.AssetInfoBillboard)
local AssetRigFactory = require(ReplicatedStorage.Shared.Modules.AssetRigFactory)
return {
    ApplyBillboardDisplay = AssetInfoBillboard.WriteTitle,
    ApplyModelScale = AssetRigFactory.Resize,
    CreateActiveModel = AssetRigFactory.BuildActive,
    CreateDataBillboard = AssetInfoBillboard.Attach,
    CreateTool = (require(ReplicatedStorage.Shared.Modules.AssetToolRig)).Build,
    CreateWanderingAssetModel = AssetRigFactory.BuildWandering,
    GetDataBillboardMaxDistance = AssetInfoBillboard.Range,
    GetDisplayScale = AssetRigFactory.Scale,
    GetModelScale = AssetRigFactory.RigScale,
    GetMutationRichTextLine = AssetDisplayText.MutationRun,
    GetNameFromItemData = AssetDisplayText.ForRecord,
    GetVisibleBounds = AssetRigFactory.Extents,
    IsDroppableBaseMutation = AssetDisplayText.IsDroppable,
    ResolveBaseMutation = AssetDisplayText.FirstDroppable,
    SetDataBillboardMoneyPerSecond = AssetInfoBillboard.SetRate,
    StripRuntimeRig = AssetRigFactory.Strip,
    CreateModel = function(a1, a2) -- Line: 37 -- upvalues: AssetRigFactory (val) -- types: a2: boolean?
        return AssetRigFactory.Build(a1)
    end,
    CreateActiveModelWithHumanoid = function(a1, a2) -- Line: 41 -- upvalues: AssetRigFactory (val) -- types: a1: string?
        return AssetRigFactory.BuildActive(a1, a2)
    end,
}