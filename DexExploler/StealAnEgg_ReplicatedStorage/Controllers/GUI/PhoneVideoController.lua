-- Script path: ReplicatedStorage.Controllers.GUI.PhoneVideoController
-- Decompile time: 49.32 ms

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SocialService = game:GetService("SocialService")
local TweenService = game:GetService("TweenService")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local FeedSequencer = require(ReplicatedStorage.Shared.TreadmillVideoController.FeedSequencer)
local Simple = require(ReplicatedStorage.Packages.FormatNumber.Simple)
local Log = require(ReplicatedStorage.Packages.Log)
local Media = require(ReplicatedStorage.Shared.TreadmillVideoController.Media)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Save = require(ReplicatedStorage.Shared.Save)
local TreadmillFlags = require(ReplicatedStorage.Shared.Flags.TreadmillFlags)
local TreadmillMediaIdentity = require(ReplicatedStorage.Shared.Modules.TreadmillMediaIdentity)
local Schema = require(ReplicatedStorage.Shared.Types.TreadmillMediaLike.Types.Schema)
local TreadmillMediaOverlay = require(ReplicatedStorage.Shared.Modules.TreadmillMediaOverlay)
require(ReplicatedStorage.Shared.TreadmillVideoController.Types.Interface)
local Trove = require(ReplicatedStorage.Packages.Trove)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local VideoComments = require(ReplicatedStorage.Client.VideoComments)
local u109 = Color3.fromRGB(255, 92, 122)
local u114 = TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u119 = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u124 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local u130 = TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1)
local u135 = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local u140 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
return {
    Start = function() -- Line: 112
        -- upvalues: Players (val), Log (val), Media (val), TreadmillMediaOverlay (val), TreadmillMediaIdentity (val)
        -- upvalues: FeedSequencer (val), Remotes (val), Simple (val), u109 (val), TreadmillFlags (val)
        -- upvalues: VideoComments (val), TryCall (val), Schema (val), TweenService (val), Trove (val), u124 (val)
        -- upvalues: u114 (val), u119 (val), RunService (val), u130 (val), u140 (val), Save (val), ButtonFX (val)
        -- upvalues: SocialService (val), u135 (val), CollectionService (val)
        local LocalPlayer = Players.LocalPlayer
        local u4 = Log.new()
        local u5 = nil
        local u6 = nil
        local u7 = nil
        local u8 = false
        local u9 = nil
        local Main = require(script.Parent.BackpackController.Main)
        local u16 = nil
        local u17 = false

        local function dismissEquipHint() -- Line: 125 -- upvalues: u16 (ref)
            local v1 = u16
            u16 = nil
            if v1 ~= nil then
                v1:Destroy()
            end
        end

        local function warnMissingUi(a1) -- Line: 137 -- upvalues: u8 (ref) -- types: a1: string
            if u8 then
                return
            end
            u8 = true
            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(a1)))
        end

        local function findTyped(a1, a2, a3, a4) -- Line: 145
            -- upvalues: u8 (ref)
            local v1 = a1:FindFirstChild(a2, a4 == true)
            if v1 ~= nil and v1:IsA(a3) then
                return v1
            end
            local v2 = ("%*.%* (%*)"):format(a1:GetFullName(), a2, a3)
            if not u8 then
                u8 = true
                warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v2)))
            end
            return nil
        end

        local function resolvePhoneUi() -- Line: 154 -- upvalues: u5 (ref), LocalPlayer (val), u8 (ref)
            local v1 = u5
            if v1 ~= nil and v1.Gui.Parent ~= nil then
                return v1
            end
            u5 = nil
            local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
            local PhoneVideoUI = PlayerGui and PlayerGui:FindFirstChild("PhoneVideoUI")
            if PhoneVideoUI ~= nil and PhoneVideoUI:IsA("ScreenGui") then
                local v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20
                local Phone = PhoneVideoUI:FindFirstChild("Phone", false)
                if Phone == nil then
                    v14 = ("%*.Phone (Frame)"):format((PhoneVideoUI:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v14)))
                    end
                    v1 = nil
                elseif Phone:IsA("Frame") then
                    v1 = Phone
                else
                    v14 = ("%*.Phone (Frame)"):format((PhoneVideoUI:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v14)))
                    end
                    v1 = nil
                end
                if v1 == nil then
                    return nil
                end
                local MainVideo = v1:FindFirstChild("MainVideo", true)
                if MainVideo == nil then
                    v15 = ("%*.MainVideo (VideoFrame)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v15)))
                    end
                    v12 = nil
                elseif MainVideo:IsA("VideoFrame") then
                    v12 = MainVideo
                else
                    v15 = ("%*.MainVideo (VideoFrame)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v15)))
                    end
                    v12 = nil
                end
                local Bar = v1:FindFirstChild("Bar", false)
                if Bar == nil then
                    v16 = ("%*.Bar (Frame)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v16)))
                    end
                    v14 = nil
                elseif Bar:IsA("Frame") then
                    v14 = Bar
                else
                    v16 = ("%*.Bar (Frame)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v16)))
                    end
                    v14 = nil
                end
                v15 = v14
                if v15 then
                    local Progress = v14:FindFirstChild("Progress", false)
                    if Progress == nil then
                        v17 = ("%*.Progress (GuiObject)"):format((v14:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v17)))
                        end
                        v15 = nil
                    elseif Progress:IsA("GuiObject") then
                        v15 = Progress
                    else
                        v17 = ("%*.Progress (GuiObject)"):format((v14:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v17)))
                        end
                        v15 = nil
                    end
                end
                local Loading = v1:FindFirstChild("Loading", false)
                if Loading == nil then
                    v17 = ("%*.Loading (GuiObject)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v17)))
                    end
                    v14 = nil
                elseif Loading:IsA("GuiObject") then
                    v14 = Loading
                else
                    v17 = ("%*.Loading (GuiObject)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v17)))
                    end
                    v14 = nil
                end
                v16 = v14
                if v16 then
                    local Spin = v14:FindFirstChild("Spin", false)
                    if Spin == nil then
                        v18 = ("%*.Spin (GuiObject)"):format((v14:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v18)))
                        end
                        v16 = nil
                    elseif Spin:IsA("GuiObject") then
                        v16 = Spin
                    else
                        v18 = ("%*.Spin (GuiObject)"):format((v14:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v18)))
                        end
                        v16 = nil
                    end
                end
                local GoToNext = v1:FindFirstChild("GoToNext", false)
                if GoToNext == nil then
                    v19 = ("%*.GoToNext (CanvasGroup)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v19)))
                    end
                    v17 = nil
                elseif GoToNext:IsA("CanvasGroup") then
                    v17 = GoToNext
                else
                    v19 = ("%*.GoToNext (CanvasGroup)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v19)))
                    end
                    v17 = nil
                end
                v18 = v17
                if v18 then
                    local Arrow = v17:FindFirstChild("Arrow", false)
                    if Arrow == nil then
                        v20 = ("%*.Arrow (ImageLabel)"):format((v17:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v20)))
                        end
                        v18 = nil
                    elseif Arrow:IsA("ImageLabel") then
                        v18 = Arrow
                    else
                        v20 = ("%*.Arrow (ImageLabel)"):format((v17:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v20)))
                        end
                        v18 = nil
                    end
                end
                v19 = v17
                if v19 then
                    local ArrowShadow = v17:FindFirstChild("ArrowShadow", false)
                    if ArrowShadow == nil then
                        v2 = ("%*.ArrowShadow (ImageLabel)"):format((v17:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v2)))
                        end
                        v19 = nil
                    elseif ArrowShadow:IsA("ImageLabel") then
                        v19 = ArrowShadow
                    else
                        v2 = ("%*.ArrowShadow (ImageLabel)"):format((v17:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v2)))
                        end
                        v19 = nil
                    end
                end
                local Paused = v1:FindFirstChild("Paused", false)
                if Paused == nil then
                    v3 = ("%*.Paused (CanvasGroup)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v3)))
                    end
                    v20 = nil
                elseif Paused:IsA("CanvasGroup") then
                    v20 = Paused
                else
                    v3 = ("%*.Paused (CanvasGroup)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v3)))
                    end
                    v20 = nil
                end
                local TapCatcher = v1:FindFirstChild("TapCatcher", false)
                if TapCatcher == nil then
                    v4 = ("%*.TapCatcher (GuiButton)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v4)))
                    end
                    v2 = nil
                elseif TapCatcher:IsA("GuiButton") then
                    v2 = TapCatcher
                else
                    v4 = ("%*.TapCatcher (GuiButton)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v4)))
                    end
                    v2 = nil
                end
                local Close = v1:FindFirstChild("Close", false)
                if Close == nil then
                    v5 = ("%*.Close (GuiButton)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v5)))
                    end
                    v3 = nil
                elseif Close:IsA("GuiButton") then
                    v3 = Close
                else
                    v5 = ("%*.Close (GuiButton)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v5)))
                    end
                    v3 = nil
                end
                local ButtonSwapLeft = v1:FindFirstChild("ButtonSwapLeft", true)
                if ButtonSwapLeft == nil then
                    v6 = ("%*.ButtonSwapLeft (GuiButton)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v6)))
                    end
                    v4 = nil
                elseif ButtonSwapLeft:IsA("GuiButton") then
                    v4 = ButtonSwapLeft
                else
                    v6 = ("%*.ButtonSwapLeft (GuiButton)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v6)))
                    end
                    v4 = nil
                end
                local ButtonSwapRight = v1:FindFirstChild("ButtonSwapRight", true)
                if ButtonSwapRight == nil then
                    v7 = ("%*.ButtonSwapRight (GuiButton)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v7)))
                    end
                    v5 = nil
                elseif ButtonSwapRight:IsA("GuiButton") then
                    v5 = ButtonSwapRight
                else
                    v7 = ("%*.ButtonSwapRight (GuiButton)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v7)))
                    end
                    v5 = nil
                end
                local Share = v1:FindFirstChild("Share", false)
                if Share == nil then
                    v8 = ("%*.Share (GuiObject)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v8)))
                    end
                    v6 = nil
                elseif Share:IsA("GuiObject") then
                    v6 = Share
                else
                    v8 = ("%*.Share (GuiObject)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v8)))
                    end
                    v6 = nil
                end
                v7 = v6
                if v7 then
                    local ShareButton = v6:FindFirstChild("ShareButton", true)
                    if ShareButton == nil then
                        v9 = ("%*.ShareButton (GuiButton)"):format((v6:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v9)))
                        end
                        v7 = nil
                    elseif ShareButton:IsA("GuiButton") then
                        v7 = ShareButton
                    else
                        v9 = ("%*.ShareButton (GuiButton)"):format((v6:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v9)))
                        end
                        v7 = nil
                    end
                end
                local SideButtons = v1:FindFirstChild("SideButtons", false)
                if SideButtons == nil then
                    v10 = ("%*.SideButtons (GuiObject)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v10)))
                    end
                    v8 = nil
                elseif SideButtons:IsA("GuiObject") then
                    v8 = SideButtons
                else
                    v10 = ("%*.SideButtons (GuiObject)"):format((v1:GetFullName()))
                    if not u8 then
                        u8 = true
                        warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v10)))
                    end
                    v8 = nil
                end
                v9 = v8
                if v9 then
                    local LikeButton = v8:FindFirstChild("LikeButton", true)
                    if LikeButton == nil then
                        v11 = ("%*.LikeButton (ImageButton)"):format((v8:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v11)))
                        end
                        v9 = nil
                    elseif LikeButton:IsA("ImageButton") then
                        v9 = LikeButton
                    else
                        v11 = ("%*.LikeButton (ImageButton)"):format((v8:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v11)))
                        end
                        v9 = nil
                    end
                end
                v10 = v9
                if v10 then
                    local LikeCount = v9:FindFirstChild("LikeCount", false)
                    if LikeCount == nil then
                        v13 = ("%*.LikeCount (TextLabel)"):format((v9:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v13)))
                        end
                        v10 = nil
                    elseif LikeCount:IsA("TextLabel") then
                        v10 = LikeCount
                    else
                        v13 = ("%*.LikeCount (TextLabel)"):format((v9:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v13)))
                        end
                        v10 = nil
                    end
                end
                v11 = v8
                if v11 then
                    local v21
                    local CommentsButton = v8:FindFirstChild("CommentsButton", true)
                    if CommentsButton == nil then
                        v21 = ("%*.CommentsButton (GuiButton)"):format((v8:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v21)))
                        end
                        v11 = nil
                    elseif CommentsButton:IsA("GuiButton") then
                        v11 = CommentsButton
                    else
                        v21 = ("%*.CommentsButton (GuiButton)"):format((v8:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v21)))
                        end
                        v11 = nil
                    end
                end
                v13 = v11
                if v13 then
                    local v22
                    local CommentsCount = v11:FindFirstChild("CommentsCount", false)
                    if CommentsCount == nil then
                        v22 = ("%*.CommentsCount (TextLabel)"):format((v11:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v22)))
                        end
                        v13 = nil
                    elseif CommentsCount:IsA("TextLabel") then
                        v13 = CommentsCount
                    else
                        v22 = ("%*.CommentsCount (TextLabel)"):format((v11:GetFullName()))
                        if not u8 then
                            u8 = true
                            warn((("[PhoneVideoController] %* is missing. The PhoneVideoUI ScreenGui is incomplete."):format(v22)))
                        end
                        v13 = nil
                    end
                end
                if v12 ~= nil
                    and v15 ~= nil
                    and v14 ~= nil
                    and v16 ~= nil
                    and v17 ~= nil
                    and v18 ~= nil
                    and v19 ~= nil
                    and v20 ~= nil
                    and v2 ~= nil
                    and v3 ~= nil
                    and v4 ~= nil
                    and v5 ~= nil
                    and v6 ~= nil
                    and v7 ~= nil
                    and v8 ~= nil
                    and v9 ~= nil
                    and v10 ~= nil
                    and v11 ~= nil
                    and v13 ~= nil then
                    local EnjoyFree = v20:FindFirstChild("EnjoyFree", true)
                    local VideoCounter = v1:FindFirstChild("VideoCounter")
                    local v23 = {v1}
                    local v24 = nil
                    local v25 = nil
                    for i, j in v23, v24, v25 do
                        for k, n in j:GetDescendants() do
                            if n.Name == "GamepadGlyph" and n:IsA("GuiObject") then
                                n.Visible = false
                            end
                        end
                    end
                    v23 = {
                        Gui = PhoneVideoUI,
                        Phone = v1,
                        Video = v12,
                        Progress = v15,
                        Loading = v14,
                        LoadingSpin = v16,
                        GoToNext = v17,
                        Arrow = v18,
                        ArrowShadow = v19,
                        Paused = v20,
                    }
                    v23.EnjoyFreeLabel = if EnjoyFree == nil then nil else if not EnjoyFree:IsA("TextLabel") then nil else EnjoyFree
                    v23.VideoCounter = if VideoCounter == nil then nil else if not VideoCounter:IsA("TextLabel") then nil else VideoCounter
                    v23.TapCatcher = v2
                    v23.Close = v3
                    v23.SwapLeftButton = v4
                    v23.SwapRightButton = v5
                    v23.ShareContainer = v6
                    v23.ShareButton = v7
                    v23.SideButtonsContainer = v8
                    v23.LikeButton = v9
                    v23.LikeCountLabel = v10
                    v23.CommentsButton = v11
                    v23.CommentsCountLabel = v13
                    local Comments = v1:FindFirstChild("Comments")
                    v23.CommentsPanel = if Comments == nil then nil else if not Comments:IsA("GuiObject") then nil else Comments
                    v23.ArrowBasePosition = v18.Position
                    v23.ArrowShadowBasePosition = v19.Position
                    v23.VideoBaseSize = v12.Size
                    v23.OnscreenPosition = v1.Position
                    v23.OffscreenPosition = UDim2.new(v1.Position.X.Scale, 0, 2, 0)
                    u5 = v23
                    return v23
                end
                return nil
            end
            if not u8 then
                u8 = true
                warn("[PhoneVideoController] PlayerGui.PhoneVideoUI is missing. The PhoneVideoUI ScreenGui is incomplete.")
            end
            return nil
        end

        local u24 = table.clone(Media)
        TreadmillMediaOverlay.ApplyTo(u24)

        local function isSkippedMediaIndex(a1) -- Line: 281
            -- upvalues: u24 (val), TreadmillMediaOverlay (upval), TreadmillMediaIdentity (upval)
            local v1 = u24[a1]
            if v1 ~= nil and v1.Kind == "Video" and v1.Disabled ~= true then
                return TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v1))
            end
            return true
        end

        local function countPlayableVideos() -- Line: 289
            -- upvalues: u24 (val), TreadmillMediaOverlay (upval), TreadmillMediaIdentity (upval)
            local v1
            local v2 = 0
            local v3 = nil
            local v4 = nil
            for i in u24, v3, v4 do
                v1 = u24[i]
                if not (if v1 == nil then true else if v1.Kind ~= "Video" then true else if v1.Disabled ~= true then TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v1)) else true) then
                    v2 = v2 + 1
                end
            end
            return v2
        end

        local function sequencerNextSkippingUnplayable(a1) -- Line: 299
            -- upvalues: FeedSequencer (upval), u24 (val), TreadmillMediaOverlay (upval), TreadmillMediaIdentity (upval)
            -- upvalues: Remotes (upval)
            local v1, v2, v3
            local v4, v5 = FeedSequencer.Next(a1.Feed)
            local v6 = #u24
            for i = 1, v6 do
                v3 = u24[v4]
                if not (if v3 == nil then true else if v3.Kind ~= "Video" then true else if v3.Disabled ~= true then TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v3)) else true) then
                    break
                end
                Remotes.Treadmill.RefreshClipCursor:FireServer(v5)
                v1, v2 = FeedSequencer.Next(a1.Feed)
                v4 = v1
                v5 = v2
            end
            return v4, v5
        end

        local function sequencerPreviousSkippingUnplayable(a1) -- Line: 311
            -- upvalues: FeedSequencer (upval), u24 (val), TreadmillMediaOverlay (upval), TreadmillMediaIdentity (upval)
            -- upvalues: Remotes (upval), sequencerNextSkippingUnplayable (val)
            local v1, v2, v3, v4, v5
            local v6, v7, v8 = FeedSequencer.Previous(a1.Feed)
            if not v8 then
                return v6, v7, false
            end
            local v9 = #u24
            local v10 = a1
            for i = 1, v9 do
                v8 = u24[v6]
                if not (if v8 == nil then true else if v8.Kind ~= "Video" then true else if v8.Disabled ~= true then TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v8)) else true) then
                    return v6, v7, true
                end
                Remotes.Treadmill.RefreshClipCursor:FireServer(v7)
                v3, v4, v5 = FeedSequencer.Previous(v10.Feed)
                if not v5 then
                    v1, v2 = sequencerNextSkippingUnplayable(v10)
                    return v1, v2, true
                end
                v6 = v3
                v7 = v4
            end
            return v6, v7, true
        end

        local function currentMediaKey(a1) -- Line: 336
            -- upvalues: TreadmillMediaIdentity (upval), u24 (val)
            return TreadmillMediaIdentity.GetMediaKey(u24[a1.Index])
        end

        local function formatCompactCount(a1) -- Line: 340 -- upvalues: Simple (upval) -- types: a1: number
            return Simple.FormatCompact(math.max(a1, 0), ".#")
        end

        local function updateSocialPresentation(a1, a2) -- Line: 344
            -- upvalues: TreadmillMediaIdentity (upval), u24 (val), u109 (upval), Simple (upval), TreadmillFlags (upval)
            -- upvalues: VideoComments (upval)
            local v1 = TreadmillMediaIdentity.GetMediaKey(u24[a2.Index])
            local v2 = a2.LikedByMediaKey[v1] == true
            a1.LikeButton.ImageColor3 = if not v2 then Color3.new(1, 1, 1) else u109
            local v3 = if not v2 then "rbxassetid://123761405635833" else "rbxassetid://90146064998908"
            a1.LikeButton.Image = v3
            local LikeCountLabel = a1.LikeCountLabel
            local v4 = a2.LikeCountsByMediaKey[v1] or 0
            LikeCountLabel.Text = Simple.FormatCompact(math.max(v4, 0), ".#")
            a1.CommentsButton.Visible = not TreadmillFlags.CommentsDisabled:Get()
            a1.CommentsCountLabel.Text = Simple.FormatCompact(math.max(VideoComments.GetCachedCommentCount(v1) or 0, 0), ".#")
        end

        local function requestLikeSnapshot(a1, a2) -- Line: 355
            -- upvalues: TryCall (upval), Remotes (upval), Schema (upval), u4 (val), u6 (ref)
            -- upvalues: updateSocialPresentation (val)
            task.spawn(function() -- Line: 356
                -- upvalues: TryCall (upval), Remotes (upval), Schema (upval), u4 (upval), u6 (upval), a2 (val)
                -- upvalues: updateSocialPresentation (upval), a1 (val)
                local v1, v2 = TryCall(function() -- Line: 357 -- upvalues: Remotes (upval)
                    return Remotes.Treadmill.AskFavourSnapshot:InvokeServer()
                end)
                if v1 and Schema.LikeSnapshot(v2) then
                    if u6 ~= a2 then
                        return
                    end
                    a2.LikeCountsByMediaKey = table.clone(v2.CountsByMediaLikeKey)
                    a2.LikedByMediaKey = table.clone(v2.LikedTreadmillMedia)
                    updateSocialPresentation(a1, a2)
                    return
                end
                u4:AtWarning():Log("[PhoneVideoController] Could not load the media like snapshot")
            end)
        end

        local function toggleLike(a1, a2) -- Line: 375
            -- upvalues: TreadmillMediaIdentity (upval), u24 (val), updateSocialPresentation (val), TryCall (upval)
            -- upvalues: Remotes (upval), u6 (ref), Schema (upval), u4 (val)
            if a2.LikeBusy then
                return
            end
            a2.LikeBusy = true
            local u9 = TreadmillMediaIdentity.GetMediaKey(u24[a2.Index])
            local u13 = a2.LikedByMediaKey[u9] == true
            local u18 = a2.LikeCountsByMediaKey[u9] or 0
            local u20 = not u13
            a2.LikedByMediaKey[u9] = u20
            a2.LikeCountsByMediaKey[u9] = (math.max(u18 + (if not u20 then -1 else 1), 0))
            updateSocialPresentation(a1, a2)
            task.spawn(function() -- Line: 389
                -- upvalues: TryCall (upval), Remotes (upval), u9 (val), u20 (val), u6 (upval), a2 (val), Schema (upval)
                -- upvalues: u13 (val), u18 (val), updateSocialPresentation (upval), a1 (val), u4 (upval)
                local v1, v2 = TryCall(function() -- Line: 390 -- upvalues: Remotes (upval), u9 (upval), u20 (upval)
                    local v1 = u20
                    return Remotes.Treadmill.AskClipFavour:InvokeServer(u9, v1)
                end)
                if u6 ~= a2 then
                    return
                end
                a2.LikeBusy = false
                if v1 and Schema.LikeToggleResult(v2) and v2.Ok == true then
                    local v3 = u9
                    a2.LikedByMediaKey[v3] = v2.Liked == true
                    if type(v2.Count) == "number" then
                        a2.LikeCountsByMediaKey[u9] = v2.Count
                    end
                    updateSocialPresentation(a1, a2)
                    return
                end
                a2.LikedByMediaKey[u9] = u13
                a2.LikeCountsByMediaKey[u9] = u18
                updateSocialPresentation(a1, a2)
                u4:AtWarning():Log("[PhoneVideoController] Media like update was rejected")
            end)
        end

        local function fadeInCard(a1, a2, a3) -- Line: 419
            -- upvalues: TweenService (upval)
            a2.GroupTransparency = 1
            a2.Visible = true
            local u11 = TweenService:Create(a2, a3, {GroupTransparency = 0})
            a1:Add(function() -- Line: 423 -- upvalues: u11 (val)
                u11:Cancel()
            end)
            u11:Play()
        end

        local function hidePausedCard(a1, a2) -- Line: 429 -- types: a1: table, a2: table
            local PausedCardTrove = a2.PausedCardTrove
            a2.PausedCardTrove = nil
            if PausedCardTrove ~= nil then
                PausedCardTrove:Destroy()
            end
            a1.Paused.Visible = false
            local PreviewBaseSize = a2.PreviewBaseSize
            a2.PreviewBaseSize = nil
            if PreviewBaseSize ~= nil then
                a1.Video.Size = PreviewBaseSize
            end
        end

        local function showPausedCard(a1, a2) -- Line: 444
            -- upvalues: Trove (upval), fadeInCard (val), u124 (upval)
            if a2.PausedCardTrove == nil and a2.EndCardTrove == nil then
                local v1 = Trove.new()
                a2.PausedCardTrove = v1
                local EnjoyFreeLabel = a1.EnjoyFreeLabel
                if EnjoyFreeLabel ~= nil then
                    EnjoyFreeLabel.Visible = not a2.HasPlayed
                end
                fadeInCard(v1, a1.Paused, u124)
                if a1.Video.TimePosition <= 0 and not a1.Video.Playing then
                    pcall(function() -- Line: 464 -- upvalues: a1 (val)
                        a1.Video:Play()
                        a1.Video:Pause()
                        a1.Video.TimePosition = 0
                    end)
                end
                local PreviewBaseSize = a2.PreviewBaseSize
                if PreviewBaseSize ~= nil then
                    a2.PreviewBaseSize = nil
                    a1.Video.Size = PreviewBaseSize
                end
                local Size = a1.Video.Size
                v1 = math.max(if not (0 < Size.X.Scale) then 1 else 1 / Size.X.Scale, if not (0 < Size.Y.Scale) then 1 else 1 / Size.Y.Scale)
                if v1 > 1 then
                    a2.PreviewBaseSize = Size
                    a1.Video.Size = UDim2.new(Size.X.Scale * v1, Size.X.Offset * v1, Size.Y.Scale * v1, Size.Y.Offset * v1)
                end
                return
            end
        end

        local function hideEndCard(a1, a2) -- Line: 493 -- types: a1: table, a2: table
            local EndCardTrove = a2.EndCardTrove
            a2.EndCardTrove = nil
            if EndCardTrove ~= nil then
                EndCardTrove:Destroy()
            end
            a1.GoToNext.Visible = false
        end

        local function spawnArrowPulse(a1, a2) -- Line: 502
            -- upvalues: TweenService (upval), u114 (upval)
            local u5 = a1.Arrow:Clone()
            u5.Name = "ArrowPulse"
            u5.ZIndex = math.max(a1.Arrow.ZIndex - 1, 0)
            u5.ImageTransparency = 0.35
            u5.Parent = a1.GoToNext
            a2:Add(u5)
            local v1 = TweenService:Create(u5, u114, {
                ImageTransparency = 1,
                Size = UDim2.new(a1.Arrow.Size.X.Scale * 2.2, 0, a1.Arrow.Size.Y.Scale * 2.2, 0),
            })
            v1.Completed:Once(function() -- Line: 519 -- upvalues: u5 (val)
                u5:Destroy()
            end)
            v1:Play()
        end

        local function showEndCard(a1, a2) -- Line: 525
            -- upvalues: Trove (upval), fadeInCard (val), u119 (upval), RunService (upval), spawnArrowPulse (val)
            if a2.EndCardTrove ~= nil then
                return
            end
            local PausedCardTrove = a2.PausedCardTrove
            a2.PausedCardTrove = nil
            if PausedCardTrove ~= nil then
                PausedCardTrove:Destroy()
            end
            a1.Paused.Visible = false
            local PreviewBaseSize = a2.PreviewBaseSize
            a2.PreviewBaseSize = nil
            if PreviewBaseSize ~= nil then
                a1.Video.Size = PreviewBaseSize
            end
            local u17 = Trove.new()
            a2.EndCardTrove = u17
            a1.ShareContainer.Visible = false
            a1.SideButtonsContainer.Visible = false
            fadeInCard(u17, a1.GoToNext, u119)
            local u34 = a1.GoToNext:GetAttribute("SwaySeconds") or 1.2
            local u40 = a1.GoToNext:GetAttribute("SwayScale") or 0.02
            local u42 = os.clock()
            local u43 = 0
            u17:Connect(RunService.RenderStepped, function() -- Line: 541
                -- upvalues: u42 (val), u34 (val), u40 (val), a1 (val), u43 (ref), spawnArrowPulse (upval), u17 (val)
                local v1 = os.clock() - u42
                local v2 = UDim2.fromScale((math.sin(v1 * 3.141592653589793 * 2 / u34)) * u40, 0)
                a1.Arrow.Position = a1.ArrowBasePosition + v2
                a1.ArrowShadow.Position = a1.ArrowShadowBasePosition + v2
                v2 = math.floor(v1 / u34 + 0.75)
                if u43 < v2 then
                    u43 = v2
                    spawnArrowPulse(a1, u17)
                end
            end)
            u17:Add(function() -- Line: 555 -- upvalues: a1 (val)
                a1.Arrow.Position = a1.ArrowBasePosition
                a1.ArrowShadow.Position = a1.ArrowShadowBasePosition
            end)
        end

        local function playVideo(a1, a2) -- Line: 565 -- types: a1: table, a2: table
            a2.HasPlayed = true
            local PausedCardTrove = a2.PausedCardTrove
            a2.PausedCardTrove = nil
            if PausedCardTrove ~= nil then
                PausedCardTrove:Destroy()
            end
            a1.Paused.Visible = false
            local PreviewBaseSize = a2.PreviewBaseSize
            a2.PreviewBaseSize = nil
            if PreviewBaseSize ~= nil then
                a1.Video.Size = PreviewBaseSize
            end
            a1.Video:Play()
        end

        local function pauseVideo(a1, a2) -- Line: 571 -- upvalues: showPausedCard (val) -- types: a1: table, a2: table
            a1.Video:Pause()
            showPausedCard(a1, a2)
        end

        local function stopLoading(a1, a2) -- Line: 576 -- types: a1: table, a2: table
            local LoadingTween = a2.LoadingTween
            a2.LoadingTween = nil
            if LoadingTween ~= nil then
                LoadingTween:Cancel()
            end
            a1.Loading.Visible = false
            a1.LoadingSpin.Rotation = 0
        end

        local function finishLoad(a1, a2) -- Line: 586
            -- upvalues: updateSocialPresentation (val), showPausedCard (val)
            local LoadingTween = a2.LoadingTween
            a2.LoadingTween = nil
            if LoadingTween ~= nil then
                LoadingTween:Cancel()
            end
            a1.Loading.Visible = false
            a1.LoadingSpin.Rotation = 0
            a1.ShareContainer.Visible = true
            a1.SideButtonsContainer.Visible = true
            updateSocialPresentation(a1, a2)
            if not a2.HasPlayed then
                showPausedCard(a1, a2)
                return
            end
            a2.HasPlayed = true
            local PausedCardTrove = a2.PausedCardTrove
            a2.PausedCardTrove = nil
            if PausedCardTrove ~= nil then
                PausedCardTrove:Destroy()
            end
            a1.Paused.Visible = false
            local PreviewBaseSize = a2.PreviewBaseSize
            a2.PreviewBaseSize = nil
            if PreviewBaseSize ~= nil then
                a1.Video.Size = PreviewBaseSize
            end
            a1.Video:Play()
        end

        local function loadVideo(a1, a2, a3, a4) -- Line: 598
            -- upvalues: u24 (val), u4 (val), Remotes (upval), u9 (ref), updateSocialPresentation (val)
            -- upvalues: showPausedCard (val), TweenService (upval), u130 (upval), u6 (ref)
            local v1 = u24[a3]
            if v1 ~= nil and v1.Kind == "Video" then
                a2.LoadToken = a2.LoadToken + 1
                local LoadToken = a2.LoadToken
                local EndCardTrove = a2.EndCardTrove
                a2.EndCardTrove = nil
                if EndCardTrove ~= nil then
                    EndCardTrove:Destroy()
                end
                a1.GoToNext.Visible = false
                local PausedCardTrove = a2.PausedCardTrove
                a2.PausedCardTrove = nil
                if PausedCardTrove ~= nil then
                    PausedCardTrove:Destroy()
                end
                a1.Paused.Visible = false
                local PreviewBaseSize = a2.PreviewBaseSize
                a2.PreviewBaseSize = nil
                if PreviewBaseSize ~= nil then
                    a1.Video.Size = PreviewBaseSize
                end
                local CommentsPanel = a1.CommentsPanel
                if CommentsPanel ~= nil then
                    CommentsPanel.Visible = false
                end
                a2.Index = a3
                Remotes.Treadmill.RefreshClipCursor:FireServer(a4)
                u9 = a4
                a1.Video:Pause()
                local Video = a1.Video
                local Size = v1.Size or a1.VideoBaseSize
                Video.Size = Size
                a1.Video.Volume = v1.Volume or 1
                a1.Video.Video = v1.Video
                a1.Video.TimePosition = 0
                local Size_2 = a1.Progress.Size
                a1.Progress.Size = UDim2.new(0, 0, Size_2.Y.Scale, Size_2.Y.Offset)
                if not a1.Video.IsLoaded then
                    a1.ShareContainer.Visible = false
                    a1.SideButtonsContainer.Visible = false
                    local LoadingTween_2 = a2.LoadingTween
                    a2.LoadingTween = nil
                    if LoadingTween_2 ~= nil then
                        LoadingTween_2:Cancel()
                    end
                    a1.Loading.Visible = false
                    a1.LoadingSpin.Rotation = 0
                    a1.Loading.Visible = true
                    local v2 = TweenService:Create(a1.LoadingSpin, u130, {Rotation = 360})
                    a2.LoadingTween = v2
                    v2:Play()
                    local u157 = nil
                    u157 = a1.Video.Loaded:Connect(function() -- Line: 640
                        -- upvalues: u157 (ref), u6 (upval), a2 (val), LoadToken (val), a1 (val)
                        -- upvalues: updateSocialPresentation (upval), showPausedCard (upval)
                        u157:Disconnect()
                        if u6 == a2 and a2.LoadToken == LoadToken then
                            local v1 = a1
                            local v2 = a2
                            local LoadingTween = v2.LoadingTween
                            v2.LoadingTween = nil
                            if LoadingTween ~= nil then
                                LoadingTween:Cancel()
                            end
                            v1.Loading.Visible = false
                            v1.LoadingSpin.Rotation = 0
                            v1.ShareContainer.Visible = true
                            v1.SideButtonsContainer.Visible = true
                            updateSocialPresentation(v1, v2)
                            if not v2.HasPlayed then
                                showPausedCard(v1, v2)
                                return
                            end
                            v2.HasPlayed = true
                            local PausedCardTrove = v2.PausedCardTrove
                            v2.PausedCardTrove = nil
                            if PausedCardTrove ~= nil then
                                PausedCardTrove:Destroy()
                            end
                            v1.Paused.Visible = false
                            local PreviewBaseSize = v2.PreviewBaseSize
                            v2.PreviewBaseSize = nil
                            if PreviewBaseSize ~= nil then
                                v1.Video.Size = PreviewBaseSize
                            end
                            v1.Video:Play()
                            return
                        end
                    end)
                    a2.Trove:Add(u157)
                    return
                end
                local LoadingTween = a2.LoadingTween
                a2.LoadingTween = nil
                if LoadingTween ~= nil then
                    LoadingTween:Cancel()
                end
                a1.Loading.Visible = false
                a1.LoadingSpin.Rotation = 0
                a1.ShareContainer.Visible = true
                a1.SideButtonsContainer.Visible = true
                updateSocialPresentation(a1, a2)
                if not a2.HasPlayed then
                    showPausedCard(a1, a2)
                    return
                end
                a2.HasPlayed = true
                local PausedCardTrove_2 = a2.PausedCardTrove
                a2.PausedCardTrove = nil
                if PausedCardTrove_2 ~= nil then
                    PausedCardTrove_2:Destroy()
                end
                a1.Paused.Visible = false
                local PreviewBaseSize_2 = a2.PreviewBaseSize
                a2.PreviewBaseSize = nil
                if PreviewBaseSize_2 ~= nil then
                    a1.Video.Size = PreviewBaseSize_2
                end
                a1.Video:Play()
                return
            end
            ;(u4:AtWarning()):Log((("[PhoneVideoController] Media index %* is not a playable video"):format(a3)))
        end

        local function closePhone() -- Line: 654
            -- upvalues: u6 (ref), resolvePhoneUi (val), u7 (ref), TweenService (upval), u140 (upval)
            local v1 = u6
            u6 = nil
            if v1 == nil then
                return
            end
            local u3 = resolvePhoneUi()
            v1.Trove:Destroy()
            if u3 == nil then
                return
            end
            u3.Video:Pause()
            if u7 ~= nil then
                u7:Cancel()
            end
            v1 = TweenService:Create(u3.Phone, u140, {Position = u3.OffscreenPosition})
            u7 = v1
            v1.Completed:Once(function() -- Line: 673 -- upvalues: u6 (upval), u3 (val)
                if u6 == nil then
                    u3.Gui.Enabled = false
                end
            end)
            v1:Play()
        end

        local function openPhone() -- Line: 681
            -- upvalues: u17 (ref), u16 (ref), u6 (ref), resolvePhoneUi (val), Save (upval), u4 (val), u24 (val)
            -- upvalues: TreadmillMediaOverlay (upval), TreadmillMediaIdentity (upval), Trove (upval)
            -- upvalues: FeedSequencer (upval), u9 (ref), LocalPlayer (val), sequencerNextSkippingUnplayable (val)
            -- upvalues: loadVideo (val), ButtonFX (upval), closePhone (val), sequencerPreviousSkippingUnplayable (val)
            -- upvalues: TryCall (upval), SocialService (upval), toggleLike (val), Remotes (upval), Schema (upval)
            -- upvalues: updateSocialPresentation (val), showPausedCard (val), showEndCard (val), RunService (upval)
            -- upvalues: u7 (ref), TweenService (upval), u135 (upval)
            local v1, v2
            u17 = true
            local v3 = u16
            u16 = nil
            if v3 ~= nil then
                v3:Destroy()
            end
            if u6 ~= nil then
                return
            end
            local u298 = resolvePhoneUi()
            if u298 == nil then
                return
            end
            local v4 = Save.Await()
            if v4 == nil then
                u4:AtWarning():Log("[PhoneVideoController] Save data is not loaded yet")
                return
            end
            local v5 = 0
            local v6 = nil
            local v7 = nil
            for i in u24, v6, v7 do
                v2 = u24[i]
                if not (if v2 == nil then true else if v2.Kind ~= "Video" then true else if v2.Disabled ~= true then TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v2)) else true) then
                    v5 = v5 + 1
                end
            end
            if v5 == 0 then
                u4:AtWarning():Log("[PhoneVideoController] No treadmill videos are available")
                return
            end
            local u114 = {HasPlayed = false, Index = 1, LoadToken = 0, LikeBusy = false}
            u114.Trove = Trove.new()
            u114.Feed = FeedSequencer.CreateRuntime(u24, u9 or v4.TreadmillMediaFeedState, LocalPlayer.UserId)
            u114.LikedByMediaKey = {}
            u114.LikeCountsByMediaKey = {}
            u6 = u114
            u114.Trove:Add(function() -- Line: 720 -- upvalues: u298 (val), u114 (val)
                local v1 = u114
                local EndCardTrove = v1.EndCardTrove
                v1.EndCardTrove = nil
                if EndCardTrove ~= nil then
                    EndCardTrove:Destroy()
                end
                u298.GoToNext.Visible = false
                local v2 = u298
                v1 = u114
                local PausedCardTrove = v1.PausedCardTrove
                v1.PausedCardTrove = nil
                if PausedCardTrove ~= nil then
                    PausedCardTrove:Destroy()
                end
                v2.Paused.Visible = false
                local PreviewBaseSize = v1.PreviewBaseSize
                v1.PreviewBaseSize = nil
                if PreviewBaseSize ~= nil then
                    v2.Video.Size = PreviewBaseSize
                end
                v2 = u298
                v1 = u114
                local LoadingTween = v1.LoadingTween
                v1.LoadingTween = nil
                if LoadingTween ~= nil then
                    LoadingTween:Cancel()
                end
                v2.Loading.Visible = false
                v2.LoadingSpin.Rotation = 0
            end)

            local function goToNextVideo() -- Line: 726
                -- upvalues: sequencerNextSkippingUnplayable (upval), u114 (val), loadVideo (upval), u298 (val)
                local v1, v2 = sequencerNextSkippingUnplayable(u114)
                loadVideo(u298, u114, v1, v2)
            end

            local VideoCounter = u298.VideoCounter
            if VideoCounter ~= nil then
                local v8
                v6 = "Total Videos: %*"
                v1 = 0
                local v9 = nil
                v2 = nil
                for j in u24, v9, v2 do
                    v8 = u24[j]
                    if not (if v8 == nil then true else if v8.Kind ~= "Video" then true else if v8.Disabled ~= true then TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v8)) else true) then
                        v1 = v1 + 1
                    end
                end
                VideoCounter.Text = v6:format(v1)
            end
            u114.Trove:Add((ButtonFX(u298.Close, nil, function() -- Line: 736 -- upvalues: LocalPlayer (upval), closePhone (upval)
                local Character = LocalPlayer.Character
                local Humanoid = if Character == nil then nil else Character:FindFirstChildOfClass("Humanoid")
                if Humanoid ~= nil then
                    Humanoid:UnequipTools()
                    return
                end
                closePhone()
            end)))
            u114.Trove:Add((ButtonFX(u298.SwapLeftButton, nil, function() -- Line: 745
                -- upvalues: sequencerPreviousSkippingUnplayable (upval), u114 (val), loadVideo (upval), u298 (val)
                local v1, v2, v3 = sequencerPreviousSkippingUnplayable(u114)
                if v3 then
                    loadVideo(u298, u114, v1, v2)
                end
            end)))
            u114.Trove:Add((ButtonFX(u298.SwapRightButton, nil, goToNextVideo)))
            u114.Trove:Add((ButtonFX(u298.ShareButton, nil, function() -- Line: 752 -- upvalues: TryCall (upval), SocialService (upval), LocalPlayer (upval)
                local v1, v2 = TryCall(SocialService.CanSendGameInviteAsync, SocialService, LocalPlayer)
                if v1 and v2 then
                    SocialService:PromptGameInvite(LocalPlayer)
                end
            end)))
            u114.Trove:Add((ButtonFX(u298.LikeButton, nil, function() -- Line: 758 -- upvalues: toggleLike (upval), u298 (val), u114 (val)
                toggleLike(u298, u114)
            end)))
            u114.Trove:Add((ButtonFX(u298.CommentsButton, nil, function() -- Line: 761 -- upvalues: u298 (val)
                local CommentsPanel = u298.CommentsPanel
                if CommentsPanel ~= nil then
                    CommentsPanel.Visible = not CommentsPanel.Visible
                end
            end)))
            u114.Trove:Add(function() -- Line: 769 -- upvalues: u298 (val)
                local CommentsPanel = u298.CommentsPanel
                if CommentsPanel ~= nil then
                    CommentsPanel.Visible = false
                end
            end)
            task.spawn(function() -- Line: 356
                -- upvalues: TryCall (upval), Remotes (upval), Schema (upval), u4 (upval), u6 (upval), u114 (val)
                -- upvalues: updateSocialPresentation (upval), u298 (val)
                local v1, v2 = TryCall(function() -- Line: 357 -- upvalues: Remotes (upval)
                    return Remotes.Treadmill.AskFavourSnapshot:InvokeServer()
                end)
                if v1 and Schema.LikeSnapshot(v2) then
                    if u6 ~= u114 then
                        return
                    end
                    u114.LikeCountsByMediaKey = table.clone(v2.CountsByMediaLikeKey)
                    u114.LikedByMediaKey = table.clone(v2.LikedTreadmillMedia)
                    updateSocialPresentation(u298, u114)
                    return
                end
                u4:AtWarning():Log("[PhoneVideoController] Could not load the media like snapshot")
            end)
            u114.Trove:Connect(u298.TapCatcher.Activated, function() -- Line: 776
                -- upvalues: u114 (val), sequencerNextSkippingUnplayable (upval), loadVideo (upval), u298 (val)
                -- upvalues: showPausedCard (upval)
                local v1, v2
                if u114.EndCardTrove ~= nil then
                    v1, v2 = sequencerNextSkippingUnplayable(u114)
                    loadVideo(u298, u114, v1, v2)
                    return
                end
                if u298.Video.Playing then
                    v1 = u298
                    v2 = u114
                    v1.Video:Pause()
                    showPausedCard(v1, v2)
                    return
                end
                v1 = u298
                v2 = u114
                v2.HasPlayed = true
                local PausedCardTrove = v2.PausedCardTrove
                v2.PausedCardTrove = nil
                if PausedCardTrove ~= nil then
                    PausedCardTrove:Destroy()
                end
                v1.Paused.Visible = false
                local PreviewBaseSize = v2.PreviewBaseSize
                v2.PreviewBaseSize = nil
                if PreviewBaseSize ~= nil then
                    v1.Video.Size = PreviewBaseSize
                end
                v1.Video:Play()
            end)
            u114.Trove:Connect(u298.Video.Ended, function() -- Line: 786 -- upvalues: u6 (upval), u114 (val), showEndCard (upval), u298 (val)
                if u6 == u114 then
                    showEndCard(u298, u114)
                end
            end)
            u114.Trove:Connect(RunService.RenderStepped, function() -- Line: 791 -- upvalues: u298 (val)
                local TimeLength = u298.Video.TimeLength
                if TimeLength > 0 then
                    local Size = u298.Progress.Size
                    u298.Progress.Size = UDim2.new(math.clamp(u298.Video.TimePosition / TimeLength, 0, 1), 0, Size.Y.Scale, Size.Y.Offset)
                end
            end)
            u298.Video.Looped = false
            if u7 ~= nil then
                u7:Cancel()
            end
            u298.Phone.Position = u298.OffscreenPosition
            u298.Gui.Enabled = true
            local v10 = TweenService
            local Phone = u298.Phone
            v1 = u135
            local v11 = {Position = u298.OnscreenPosition}
            v10 = v10:Create(Phone, v1, v11)
            u7 = v10
            v10:Play()
            v6, v7 = FeedSequencer.Current(u114.Feed)
            v10 = u24[v6]
            v1 = if v10 == nil then true else if v10.Kind ~= "Video" then true else if v10.Disabled ~= true then TreadmillMediaOverlay.IsExcluded(TreadmillMediaIdentity.GetMediaKey(v10)) else true
            if v1 then
                Remotes.Treadmill.RefreshClipCursor:FireServer(v7)
                v1, v11 = sequencerNextSkippingUnplayable(u114)
                v6 = v1
                v7 = v11
            end
            loadVideo(u298, u114, v6, v7)
        end

        local function isPhoneEnabled() -- Line: 826 -- upvalues: TreadmillFlags (upval)
            return TreadmillFlags.PhoneEnabled:Get()
        end

        local function bindPhoneTool(a1) -- Line: 830
            -- upvalues: TreadmillFlags (upval), LocalPlayer (val), openPhone (val), closePhone (val)
            if not a1:IsA("Tool") then
                return
            end
            a1.Equipped:Connect(function() -- Line: 835 -- upvalues: TreadmillFlags (upval), a1 (val), LocalPlayer (upval), openPhone (upval)
                if TreadmillFlags.PhoneEnabled:Get() and a1.Parent == LocalPlayer.Character then
                    openPhone()
                end
            end)
            a1.Unequipped:Connect(closePhone)
            if TreadmillFlags.PhoneEnabled:Get()
                and LocalPlayer.Character ~= nil
                and a1.Parent == LocalPlayer.Character then
                openPhone()
            end
        end

        ;(CollectionService:GetInstanceAddedSignal("PhoneTool")):Connect(bindPhoneTool)
        for i, j in CollectionService:GetTagged("PhoneTool") do
            bindPhoneTool(j)
        end
        LocalPlayer.CharacterRemoving:Connect(function() -- Line: 855 -- upvalues: u16 (ref), closePhone (val)
            local v1 = u16
            u16 = nil
            if v1 ~= nil then
                v1:Destroy()
            end
            closePhone()
        end)

        local function buildEquipHintArrow(a1) -- Line: 860
            local Frame = Instance.new("Frame")
            Frame.Name = "PhoneEquipHint"
            Frame.AnchorPoint = Vector2.new(0.5, 1)
            Frame.BackgroundTransparency = 1
            Frame.Size = UDim2.fromScale(0.7, 0.7)
            Frame.Visible = false
            Frame.ZIndex = 30
            a1:Add(Frame)
            local ImageLabel = Instance.new("ImageLabel")
            ImageLabel.Name = "Arrow"
            ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            ImageLabel.Position = UDim2.fromScale(0.5, 0.5)
            ImageLabel.Size = UDim2.fromScale(1, 1)
            ImageLabel.BackgroundTransparency = 1
            ImageLabel.Image = "rbxassetid://107875622740177"
            ImageLabel.ScaleType = Enum.ScaleType.Fit
            ImageLabel.Rotation = 90
            ImageLabel.ZIndex = 31
            ImageLabel.Parent = Frame
            Instance.new("UIAspectRatioConstraint").Parent = ImageLabel
            return Frame
        end

        local function showEquipHint() -- Line: 888
            -- upvalues: u16 (ref), TreadmillFlags (upval), resolvePhoneUi (val), Trove (upval)
            -- upvalues: buildEquipHintArrow (val), RunService (upval), Main (val)
            if u16 ~= nil or not TreadmillFlags.PhoneEnabled:Get() or resolvePhoneUi() == nil then
                return
            end
            local v1 = Trove.new()
            u16 = v1
            local u13 = buildEquipHintArrow(v1)
            v1:Connect(RunService.RenderStepped, function() -- Line: 905 -- upvalues: Main (upval), u13 (val)
                local PhoneSlotFrame = Main:GetPhoneSlotFrame()
                if PhoneSlotFrame == nil then
                    u13.Visible = false
                    return
                end
                if u13.Parent ~= PhoneSlotFrame then
                    u13.Parent = PhoneSlotFrame
                end
                u13.Visible = true
                u13.Position = UDim2.new(0.5, 0, 0, math.sin((os.clock()) * 3.141592653589793 * 2 / 0.9) * 6 - 10)
            end)
        end

        TreadmillFlags.PhoneEnabled.Changed:Connect(function(a1) -- Line: 920 -- upvalues: u16 (ref), closePhone (val) -- types: a1: boolean
            if not a1 then
                local v1 = u16
                u16 = nil
                if v1 ~= nil then
                    v1:Destroy()
                end
                closePhone()
            end
        end)
        Remotes.Treadmill.AssignedBeltShifted.OnClientEvent:Connect(function(a1) -- Line: 927 -- upvalues: u16 (ref), Save (upval), u17 (ref), showEquipHint (val) -- types: a1: string?
            local v1
            if a1 == nil then
                v1 = u16
                u16 = nil
                if v1 ~= nil then
                    v1:Destroy()
                end
                return
            end
            v1 = Save.Await()
            if not u17 and v1 ~= nil and v1.HasRiddenTreadmill == true and v1.HasEquippedPhone ~= true then
                showEquipHint()
                return
            end
        end)
    end,
}