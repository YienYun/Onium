-- Script path: ReplicatedStorage.Controllers.GUI.FuseMachineController
-- Decompile time: 20.52 ms

local Fusion = require(game:GetService("ReplicatedStorage").Shared.Flags.GameplayBalance).Fusion
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
require(ReplicatedStorage.Shared.Types.AssetItem)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
local Directory = require(ReplicatedStorage.Data.Assets).Directory
local Audio = require(ReplicatedStorage.Shared.Audio)
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
require(ReplicatedStorage.Shared.Globals.Constants)
local Eggs = require(ReplicatedStorage.Shared.Types.Eggs)
local FuseKernel = require(ReplicatedStorage.Shared.Util.FuseKernel)
local FuseMachineBackpackSelection = require(script.FuseMachineBackpackSelection)
local FuseMachineProgressPresentation = require(script.FuseMachineProgressPresentation)
local FuseMachineSelectedSlot = require(script.FuseMachineSelectedSlot)
local FuseMachineSignals = require(ReplicatedStorage.Client.FuseMachineSignals)
local FuseMachine = require(ReplicatedStorage.Shared.Types.FuseMachine)
local GUI = require(ReplicatedStorage.Client.GUI)
local Log = require(ReplicatedStorage.Packages.Log)
local MenuNavigation = require(ReplicatedStorage.Client.MenuNavigation)
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Tabs = require(ReplicatedStorage.Client.Tabs)
local TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
local u130 = Color3.fromRGB(255, 0, 0)
local u132 = Log.new()
local u135 = TryLock()
local u137 = TryLock()
local u139 = TryLock()
return {
    Start = function() -- Line: 52
        -- upvalues: GUI (val), Workspace (val), FuseMachineBackpackSelection (val)
        -- upvalues: FuseMachineProgressPresentation (val), Toast (val), u130 (val), Fusion (val), u137 (val)
        -- upvalues: Remotes (val), Save (val), FuseMachineSelectedSlot (val), AssetItems (val), Directory (val)
        -- upvalues: Simple (val), FuseKernel (val), u139 (val), MenuNavigation (val), GuiService (val), u135 (val)
        -- upvalues: Eggs (val), FuseMachine (val), u132 (val), Audio (val), FuseMachineSignals (val), ButtonFX (val)
        -- upvalues: Tabs (val), ReplicatedStorage (val)
        local Add, v1, v2
        local v3 = GUI.PetFuse()
        v3.ResetOnSpawn = false
        local FuseMain = v3.FuseMain
        assert(FuseMain:IsA("GuiObject"), "PetFuse.FuseMain must be a GuiObject")
        local FuseInputs = FuseMain.FuseInputs
        assert(FuseInputs:IsA("Frame"), "PetFuse.FuseMain.FuseInputs must be a Frame")
        local Fuse = FuseMain.Fuse
        assert(Fuse:IsA("ImageButton"), "PetFuse.FuseMain.Fuse must be an ImageButton")
        local Price = Fuse.Price
        assert(Price:IsA("TextLabel"), "PetFuse.FuseMain.Fuse.Price must be a TextLabel")
        local BackgroundColor3 = Fuse.BackgroundColor3
        local u45 = BackgroundColor3:Lerp(Color3.new(0, 0, 0), 0.35)
        local FusePetInventory = v3.FusePetInventory
        assert(FusePetInventory:IsA("GuiObject"), "PetFuse.FusePetInventory must be a GuiObject")
        local ScrollingFrame = FusePetInventory.ScrollingFrame
        assert(ScrollingFrame:IsA("ScrollingFrame"), "PetFuse.FusePetInventory.ScrollingFrame must be a ScrollingFrame")
        local Close = FusePetInventory:FindFirstChild("Close")
        local IncludeEquipped = FusePetInventory:WaitForChild("IncludeEquipped")
        local Box = IncludeEquipped:WaitForChild("Box")
        local Icon = Box:WaitForChild("Icon")
        local UIGradient = Box:WaitForChild("UIGradient")
        local u86 = FusePetInventory:WaitForChild("EmptyState")
        local u401 = false
        local Output = FuseMain.FuseOutput.Output
        assert(Output:IsA("Frame"), "PetFuse.FuseMain.FuseOutput.Output must be a Frame")
        local DesignBars = FuseMain.DesignBars
        assert(DesignBars:IsA("Frame"), "PetFuse.FuseMain.DesignBars must be a Frame")
        local Briefing = FuseMain:FindFirstChild("Briefing")
        local Ok = if Briefing == nil then nil else Briefing:FindFirstChild("Ok")

        local function inputSlot(a1) -- Line: 118 -- upvalues: FuseInputs (val) -- types: a1: number
            local v1 = FuseInputs:FindFirstChild((("Input%*"):format(a1)))
            local v2 = false
            if v1 ~= nil then
                v2 = v1:IsA("Frame")
            end
            assert(v2, (("PetFuse.FuseMain.FuseInputs.Input%* is missing"):format(a1)))
            return v1
        end

        local Machines = Workspace:WaitForChild("World").Machines
        assert(Machines:IsA("Folder"), "Workspace.World.Machines must be a Folder")
        local FuseMachine_2 = Machines.FuseMachine
        assert(FuseMachine_2:IsA("Model"), "Workspace FuseMachine must be a Model")
        local Overhead = FuseMachine_2.Overhead
        assert(Overhead:IsA("BasePart"), "FuseMachine.Overhead must be a BasePart")
        local BillboardGui = Overhead.BillboardGui
        assert(BillboardGui:IsA("BillboardGui"), "FuseMachine.Overhead.BillboardGui must be a BillboardGui")
        local Countdown = BillboardGui.Countdown
        assert(Countdown:IsA("TextLabel"), "FuseMachine overhead Countdown must be a TextLabel")
        local u413 = FuseMachineBackpackSelection.new(ScrollingFrame)
        local u173 = FuseMachineProgressPresentation.new(Output, DesignBars)
        local u174 = {}
        local u363 = false

        local function notifyError(a1) -- Line: 165 -- upvalues: Toast (upval), u130 (upval) -- types: a1: string
            Toast.Show({Seconds = 3, Text = a1, Color = u130})
        end

        local function getSelectedCategory(a1) -- Line: 173
            local v1 = a1.FusionSlots[1]
            if v1 == nil then
                return nil
            end
            local v2 = a1.Inventory[v1]
            if v2 then
                return v2.Category
            end
            return nil
        end

        local function getSelectedTemporary(a1) -- Line: 185
            local v1 = a1.FusionSlots[1]
            if v1 == nil then
                return nil
            end
            local v2 = a1.Inventory[v1]
            if v2 then
                return v2.CreatorTemporary == true
            end
            return nil
        end

        local function updateOverheadInputCount(a1) -- Line: 197 -- upvalues: Countdown (val), Fusion (upval)
            local v1 = 0
            if a1 ~= nil then
                local v2 = a1.FusionSlots[1]
                if v2 ~= nil and a1.Inventory[v2] ~= nil then
                    v1 = v1 + 1
                end
                v2 = a1.FusionSlots[2]
                if v2 ~= nil and a1.Inventory[v2] ~= nil then
                    v1 = v1 + 1
                end
                v2 = a1.FusionSlots[3]
                if v2 ~= nil and a1.Inventory[v2] ~= nil then
                    v1 = v1 + 1
                end
            end
            Countdown.Text = ("%*/%*"):format(v1, Fusion.INPUT_COUNT)
        end

        local function destroySlot(a1) -- Line: 213 -- upvalues: u174 (val) -- types: a1: number
            local v1 = u174[a1]
            if v1 then
                v1:Destroy()
                u174[a1] = nil
            end
        end

        local function requestReturn(a1) -- Line: 222
            -- upvalues: u137 (upval), Remotes (upval), Toast (upval), u130 (upval)
            u137(function() -- Line: 223 -- upvalues: Remotes (upval), a1 (val), Toast (upval), u130 (upval)
                local v1, v2 = Remotes.Fusery.EjectPet:InvokeServer(a1)
                if not v1 then
                    local v3 = if typeof(v2) ~= "string" then "Failed to return pet" else v2
                    Toast.Show({Seconds = 3, Text = v3, Color = u130})
                end
            end)
        end

        local function render() -- Line: 236
            -- upvalues: Save (upval), Briefing (val), updateOverheadInputCount (val), Fuse (val), u45 (val)
            -- upvalues: Price (val), Fusion (upval), u173 (val), FuseInputs (val), u174 (val)
            -- upvalues: FuseMachineSelectedSlot (upval), requestReturn (val), AssetItems (upval), Directory (upval)
            -- upvalues: BackgroundColor3 (val), Simple (upval), FuseKernel (upval)
            local v1, v2, v3, v4, v5, v6
            local v7 = Save.Await()
            local v8 = table.create(3, false)
            if Briefing ~= nil then
                v3 = false
                if v7 ~= nil then
                    v3 = not v7.FusionInfoAcknowledged
                end
                Briefing.Visible = v3
            end
            updateOverheadInputCount(v7)
            if v7 == nil then
                Fuse.Visible = true
                Fuse.Active = false
                Fuse.BackgroundColor3 = u45
                Price.Text = ("%* Pet Left"):format(Fusion.INPUT_COUNT)
                u173:Update(v8, nil)
                return
            end
            local v9 = {}
            v3 = nil
            for i = 1, 3 do
                v4 = v7.FusionSlots[i]
                v5 = if not v4 then nil else v7.Inventory[v4]
                v6 = FuseInputs:FindFirstChild((("Input%*"):format(i)))
                v2 = false
                if v6 ~= nil then
                    v2 = v6:IsA("Frame")
                end
                assert(v2, (("PetFuse.FuseMain.FuseInputs.Input%* is missing"):format(i)))
                if v4 == nil then
                    v1 = u174[i]
                    if v1 then
                        v1:Destroy()
                        u174[i] = nil
                    end
                    v6.Full.Visible = false
                    v6.Empty.Visible = true
                elseif v5 ~= nil then
                    v8[i] = true
                    v3 = v3 or v5.Category
                    v1 = u174[i]
                    if v1 == nil or v1:GetUid() ~= v4 then
                        v2 = u174[i]
                        if v2 then
                            v2:Destroy()
                            u174[i] = nil
                        end
                        u174[i] = (FuseMachineSelectedSlot.new(v6, v4, v5, requestReturn))
                    end
                    table.insert(v9, (AssetItems.Decode(v5)))
                else
                    v1 = u174[i]
                    if v1 then
                        v1:Destroy()
                        u174[i] = nil
                    end
                    v6.Full.Visible = false
                    v6.Empty.Visible = true
                end
            end
            local v10 = false
            if #v9 == Fusion.INPUT_COUNT then
                v10 = not v7.FusionLocked and v7.FusionEggReward == false
            end
            local Icon = nil
            if v3 ~= nil then
                local v11 = Directory[v3]
                v5 = ("Missing asset config %*"):format(v3)
                assert(v11 ~= nil, v5)
                Icon = v11.Egg.Icon
            end
            u173:Update(v8, Icon)
            if v10 then
                for i2, v in ipairs(v9) do
                    if v.Category ~= v3 then
                        v10 = false
                        break
                    end
                end
            end
            Fuse.Visible = true
            Fuse.Active = v10
            if v10 then
                Fuse.BackgroundColor3 = BackgroundColor3
                Price.Text = "$ " .. Simple.FormatCompact(FuseKernel.PriceFor(v9))
                return
            end
            Fuse.BackgroundColor3 = u45
            Price.Text = ("%* Pet Left"):format(Fusion.INPUT_COUNT - #v9)
        end

        local function scheduleRender() -- Line: 325 -- upvalues: u363 (ref), render (val)
            if u363 then
                return
            end
            u363 = true
            task.defer(function() -- Line: 331 -- upvalues: u363 (upval), render (upval)
                u363 = false
                render()
            end)
        end

        local function requestAcknowledgeInfo() -- Line: 337
            -- upvalues: u139 (upval), Briefing (val), Remotes (upval), Toast (upval), u130 (upval), u363 (ref)
            -- upvalues: render (val)
            u139(function() -- Line: 338
                -- upvalues: Briefing (upval), Remotes (upval), Toast (upval), u130 (upval), u363 (upval)
                -- upvalues: render (upval)
                if Briefing ~= nil and Briefing.Visible then
                    if Remotes.Fusery.ConfirmBriefing:InvokeServer() == true then
                        Briefing.Visible = false
                        return
                    end
                    Toast.Show({
                        Text = "Failed to save Fuse Machine info acknowledgement",
                        Seconds = 3,
                        Color = u130,
                    })
                    if u363 then
                        return
                    end
                    u363 = true
                    task.defer(function() -- Line: 331 -- upvalues: u363 (upval), render (upval)
                        u363 = false
                        render()
                    end)
                    return
                end
            end)
        end

        local function closeSelection() -- Line: 355
            -- upvalues: u413 (val), FusePetInventory (val), FuseMain (val), MenuNavigation (upval)
            u413:Close()
            FusePetInventory.Visible = false
            FuseMain.Visible = true
            MenuNavigation.SetOverride("FusePetSelection", nil)
        end

        local function requestInsert(a1) -- Line: 362
            -- upvalues: u137 (upval), Remotes (upval), u401 (ref), Toast (upval), u130 (upval), u413 (val)
            -- upvalues: FusePetInventory (val), FuseMain (val), MenuNavigation (upval), u363 (ref), render (val)
            u137(function() -- Line: 363
                -- upvalues: Remotes (upval), a1 (val), u401 (upval), Toast (upval), u130 (upval), u413 (upval)
                -- upvalues: FusePetInventory (upval), FuseMain (upval), MenuNavigation (upval), u363 (upval)
                -- upvalues: render (upval)
                local v1 = u401
                local v2, v3 = Remotes.Fusery.LoadPet:InvokeServer(a1, v1)
                if not v2 then
                    local v4 = if typeof(v3) ~= "string" then "Failed to insert pet" else v3
                    Toast.Show({Seconds = 3, Text = v4, Color = u130})
                    return
                end
                u413:Close()
                FusePetInventory.Visible = false
                FuseMain.Visible = true
                MenuNavigation.SetOverride("FusePetSelection", nil)
                if u363 then
                    return
                end
                u363 = true
                task.defer(function() -- Line: 331 -- upvalues: u363 (upval), render (upval)
                    u363 = false
                    render()
                end)
            end)
        end

        local function updateEmptyState(a1) -- Line: 381 -- upvalues: u86 (val), u401 (ref) -- types: a1: number
            u86.Visible = a1 == 0
            u86.Text = if not u401 then "No matching unequipped pets.\nTry including equipped pets." else "No eligible pets for this fuse."
        end

        local function paintIncludeEquipped() -- Line: 388
            -- upvalues: Icon (val), u401 (ref), UIGradient (val), IncludeEquipped (val)
            Icon.Visible = u401
            UIGradient.Color = ColorSequence.new(if not u401 then Color3.fromRGB(83, 83, 102) else Color3.fromRGB(83, 202, 19))
            IncludeEquipped:SetAttribute("Checked", u401)
        end

        local function startSelection() -- Line: 398
            -- upvalues: u413 (val), Save (upval), requestInsert (val), u401 (ref), u86 (val), FuseMain (val)
            -- upvalues: FusePetInventory (val), MenuNavigation (upval), IncludeEquipped (val), closeSelection (val)
            local Category, v1
            if u413:IsOpen() then
                return
            end
            local v2 = Save.Await()
            if v2 == nil then
                return
            end
            local v3 = v2.FusionSlots[1]
            if v3 ~= nil then
                local v4 = v2.Inventory[v3]
                Category = if not v4 then nil else v4.Category
            else
                Category = nil
            end
            local v5 = v2.FusionSlots[1]
            if v5 ~= nil then
                local v6 = v2.Inventory[v5]
                v1 = if not v6 then nil else v6.CreatorTemporary == true
            else
                v1 = nil
            end
            local v7 = u413:Open(v2, Category, requestInsert, u401, v1)
            u86.Visible = v7 == 0
            u86.Text = if not u401 then "No matching unequipped pets.\nTry including equipped pets." else "No eligible pets for this fuse."
            FuseMain.Visible = false
            FusePetInventory.Visible = true
            u413:RefreshGridLayout()
            MenuNavigation.SetOverride(
                "FusePetSelection",
                FusePetInventory,
                if v7 ~= 0 then nil else IncludeEquipped,
                closeSelection,
                1000,
                true
            )
        end

        local function refreshSelection() -- Line: 427
            -- upvalues: u413 (val), Save (upval), Fusion (upval), FusePetInventory (val), FuseMain (val)
            -- upvalues: MenuNavigation (upval), ScrollingFrame (val), GuiService (upval), requestInsert (val)
            -- upvalues: u401 (ref), u86 (val), IncludeEquipped (val), closeSelection (val)
            if not u413:IsOpen() then
                return
            end
            local v1 = Save.Await()
            if v1 ~= nil and not v1.FusionLocked and v1.FusionEggReward == false then
                local v2 = #v1.FusionSlots
                if not (Fusion.INPUT_COUNT <= v2) then
                    local Category, v3, v4
                    local CanvasPosition = ScrollingFrame.CanvasPosition
                    local Name = nil
                    local v5 = MenuNavigation.TopOverride()
                    if not MenuNavigation.IsCursorActive() and v5 ~= nil and v5.Root == FusePetInventory then
                        local SelectedObject = GuiService.SelectedObject
                        if SelectedObject == nil or SelectedObject.Parent ~= ScrollingFrame then
                            SelectedObject = v5.Initial
                        end
                        if SelectedObject ~= nil and SelectedObject.Parent == ScrollingFrame then
                            Name = SelectedObject.Name
                        end
                    end
                    u413:Close()
                    local v6 = v1.FusionSlots[1]
                    if v6 ~= nil then
                        v3 = v1.Inventory[v6]
                        Category = if not v3 then nil else v3.Category
                    else
                        Category = nil
                    end
                    v3 = u401
                    local v7 = v1.FusionSlots[1]
                    if v7 ~= nil then
                        local v8 = v1.Inventory[v7]
                        v4 = if not v8 then nil else v8.CreatorTemporary == true
                    else
                        v4 = nil
                    end
                    u86.Visible = (u413:Open(v1, Category, requestInsert, v3, v4)) == 0
                    u86.Text = if not u401 then "No matching unequipped pets.\nTry including equipped pets." else "No eligible pets for this fuse."
                    u413:RefreshGridLayout()
                    ScrollingFrame.CanvasPosition = CanvasPosition
                    if Name ~= nil then
                        v5 = ScrollingFrame:FindFirstChild(Name)
                        v2 = if not v5 then IncludeEquipped else if not v5:IsA("GuiObject") then IncludeEquipped else v5
                        MenuNavigation.SetOverride("FusePetSelection", FusePetInventory, v2, closeSelection, 1000, true)
                    end
                    return
                end
            end
            u413:Close()
            FusePetInventory.Visible = false
            FuseMain.Visible = true
            MenuNavigation.SetOverride("FusePetSelection", nil)
        end

        local function requestFuse() -- Line: 502
            -- upvalues: u135 (upval), Save (upval), Eggs (upval), Toast (upval), u130 (upval), Remotes (upval)
            -- upvalues: FuseMachine (upval), u132 (upval), Audio (upval), FuseMachineSignals (upval), u363 (ref)
            -- upvalues: render (val)
            u135(function() -- Line: 503
                -- upvalues: Save (upval), Eggs (upval), Toast (upval), u130 (upval), Remotes (upval)
                -- upvalues: FuseMachine (upval), u132 (upval), Audio (upval), FuseMachineSignals (upval), u363 (upval)
                -- upvalues: render (upval)
                local v1 = Save.Await()
                if v1 == nil then
                    return
                end
                local v2 = 0
                for k in pairs(v1.EggInventory) do
                    v2 = v2 + 1
                end
                if Eggs.MAX_INVENTORY <= v2 then
                    Toast.Show({Text = "Your egg inventory is full!", Seconds = 3, Color = u130})
                    return
                end
                local v3, v4, v5 = Remotes.Fusery.BeginFuse:InvokeServer()
                if not v3 then
                    local v6 = if typeof(v4) ~= "string" then "Failed to start fuse" else v4
                    Toast.Show({Seconds = 3, Text = v6, Color = u130})
                    return
                end
                if not FuseMachine.FuseResult(v5) then
                    u132:AtError():Log("Fuse server returned an invalid reward")
                    return
                end
                Audio.Play(83520877125467, script, {Volume = 1.5})
                FuseMachineSignals.FuseStarted:Fire(v5)
                if u363 then
                    return
                end
                u363 = true
                task.defer(function() -- Line: 331 -- upvalues: u363 (upval), render (upval)
                    u363 = false
                    render()
                end)
            end)
        end

        paintIncludeEquipped()
        ;(v3:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 496 -- upvalues: u413 (val)
            if u413:IsOpen() then
                u413:RefreshGridLayout()
            end
        end)
        ButtonFX(IncludeEquipped, 1.015, function() -- Line: 488 -- upvalues: u137 (upval), u401 (ref), paintIncludeEquipped (val), refreshSelection (val)
            u137(function() -- Line: 489 -- upvalues: u401 (upval), paintIncludeEquipped (upval), refreshSelection (upval)
                u401 = not u401
                paintIncludeEquipped()
                refreshSelection()
            end)
        end)
        FuseMain.Visible = true
        Output.Visible = true
        FusePetInventory.Visible = false
        if Briefing ~= nil then
            Briefing.Visible = false
        end
        for i = 1, 3 do
            v1 = FuseInputs:FindFirstChild((("Input%*"):format(i)))
            v2 = false
            if v1 ~= nil then
                v2 = v1:IsA("Frame")
            end
            assert(v2, (("PetFuse.FuseMain.FuseInputs.Input%* is missing"):format(i)))
            v1.Full.Visible = false
            v1.Empty.Visible = true
            Add = v1.Empty.Add
            assert(Add:IsA("ImageButton"), (("PetFuse.FuseMain.FuseInputs.Input%*.Empty.Add must be an ImageButton"):format(i)))
            Add.Activated:Connect(startSelection)
            ButtonFX(Add, 1.08)
        end
        Fuse.Activated:Connect(requestFuse)
        ButtonFX(Fuse, 1.08)
        if Close ~= nil then
            GUI.OnActivated(Close, closeSelection)
            ButtonFX(Close, 1.08)
        end
        if Ok ~= nil then
            Ok.Activated:Connect(requestAcknowledgeInfo)
            ButtonFX(Ok)
        end
        Save.WatchFields({
            "FusionSlots",
            "FusionLocked",
            "FusionEggReward",
            "FusionInfoAcknowledged",
            "Inventory",
            "EggInventory",
        }, function() -- Line: 593 -- upvalues: Tabs (upval), u363 (ref), render (val)
            if Tabs.IsActive("PetFuse") then
                if u363 then
                    return
                end
                u363 = true
                task.defer(function() -- Line: 331 -- upvalues: u363 (upval), render (upval)
                    u363 = false
                    render()
                end)
            end
        end)
        Save.WatchFields({"FusionSlots", "FusionLocked", "FusionEggReward", "Inventory", "EquippedAssets"}, function() -- Line: 604 -- upvalues: Tabs (upval), refreshSelection (val)
            if Tabs.IsActive("PetFuse") then
                refreshSelection()
            end
        end)
        Tabs.Activated:Connect(function(a1) -- Line: 609 -- upvalues: u363 (ref), render (val) -- types: a1: string
            if a1 == "PetFuse" then
                if u363 then
                    return
                end
                u363 = true
                task.defer(function() -- Line: 331 -- upvalues: u363 (upval), render (upval)
                    u363 = false
                    render()
                end)
            end
        end)
        Tabs.Deactivated:Connect(function(a1) -- Line: 615
            -- upvalues: u401 (ref), paintIncludeEquipped (val), u413 (val), FusePetInventory (val), FuseMain (val)
            -- upvalues: MenuNavigation (upval)
            if a1 == "PetFuse" then
                u401 = false
                paintIncludeEquipped()
                u413:Close()
                FusePetInventory.Visible = false
                FuseMain.Visible = true
                MenuNavigation.SetOverride("FusePetSelection", nil)
            end
        end)
        render()
        require(ReplicatedStorage.Shared.Flags.BalanceConfig).Changed:Connect(scheduleRender)
    end,
}