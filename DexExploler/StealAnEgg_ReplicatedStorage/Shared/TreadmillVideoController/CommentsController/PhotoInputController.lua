-- Script path: ReplicatedStorage.Shared.TreadmillVideoController.CommentsController.PhotoInputController
-- Decompile time: 5.17 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local Info = require(ReplicatedStorage.Shared.Utils.Marketplace).Info
local Toast = require(ReplicatedStorage.Client.Notifications.Toast)
local Trove = require(ReplicatedStorage.Packages.Trove)
require(script.Parent.Types.Interface)
local t = require(ReplicatedStorage.Packages.t)
local TryCall = require(ReplicatedStorage.Shared.Utils.TryCall)
local u51 = {}
u51.__index = u51
u51.__class = "PhotoInputController"
local u56 = t.interface({AssetTypeId = t.number})

function u51.new(a1, a2) -- Line: 57 -- upvalues: u51 (val), Trove (val) -- types: a2: function
    local AddPhoto = a1.AddPhoto
    local Content = a1.Sheet.Actions.Content
    local v1 = setmetatable({}, u51)
    v1._addButton = AddPhoto.Frame.Buttons.Add
    v1._attachment = Content.TextInputWrapper.AddedPhoto
    v1._cancelButton = AddPhoto.Frame.Buttons.Cancel
    v1._composerAddPhotoButton = Content.AddPhoto
    v1._destroyed = false
    v1._imageAssetId = nil
    v1._input = AddPhoto.Frame.TextInputWrapper.TextInput
    v1._onInteraction = a2
    v1._overlay = AddPhoto
    v1._removeButton = v1._attachment.RemoveButton
    v1._requestSerial = 0
    v1._textInputWrapper = Content.TextInputWrapper
    v1._trove = Trove.new()
    v1:_init()
    return v1
end

local function parseImageAssetId(a1) -- Line: 85 -- types: a1: string
    local v1 = a1:match("^%s*(.-)%s*$") or ""
    local v2 = v1:match("^%d+$")
    if v2 == nil then
        v2 = string.lower(v1):match("^rbxassetid://(%d+)$")
    end
    v1 = if v2 == nil then nil else tonumber(v2)
    if v1 ~= nil and not (v1 <= 0) and v1 % 1 == 0 then
        return v1
    end
    return nil
end

local function showInvalidImageNotification() -- Line: 100 -- upvalues: Toast (val)
    Toast.Show({
        Lane = "Banner",
        Text = "Invalid image, please upload another image.",
        Seconds = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1),
    })
end

local function showImageLookupFailedNotification() -- Line: 110 -- upvalues: Toast (val)
    Toast.Show({
        Lane = "Banner",
        Text = "Something went wrong, please try again later.",
        Seconds = 3,
        ShowShadow = true,
        Color = Color3.new(1, 1, 1),
    })
end

local function isImageAsset(a1) -- Line: 120 -- upvalues: TryCall (val), Info (val), u56 (val) -- types: a1: number
    local v1, v2 = TryCall(Info, a1, Enum.InfoType.Asset)
    if not v1 or not u56(v2) then
        return false, "ImageAssetLookupFailed"
    end
    local AssetTypeId = v2.AssetTypeId
    if AssetTypeId ~= Enum.AssetType.Image.Value and AssetTypeId ~= Enum.AssetType.Decal.Value then
        return false, "InvalidImageAssetId"
    end
    return true, nil
end

function u51:_setAttachment(a2) -- Line: 138 -- types: a2: number?
    self._imageAssetId = a2
    self._attachment.Visible = a2 ~= nil
    if a2 ~= nil then
        self._attachment.Icon.Image = ("rbxassetid://%*"):format(a2)
        return
    end
    self._attachment.Icon.Image = ""
end

function u51:_closeOverlay() -- Line: 148
    self._requestSerial = self._requestSerial + 1
    self._addButton.Active = true
    self._overlay.Visible = false
    self._input.Text = ""
end

function u51.GetImageAssetId(a1) -- Line: 159
    return a1._imageAssetId
end

function u51:Reset() -- Line: 163
    self:_closeOverlay()
    self:_setAttachment(nil)
end

function u51:Destroy() -- Line: 168
    if self._destroyed then
        return
    end
    self._destroyed = true
    self:Reset()
    self._trove:Destroy()
end

function u51:_init() -- Line: 182
    -- upvalues: Players (val), Constants (val), ButtonFX (val), parseImageAssetId (val), Toast (val)
    -- upvalues: isImageAsset (val)
    local v1 = Players.LocalPlayer.UserId == Constants.OWNER_ID
    self._overlay.Visible = false
    self._attachment.Visible = false
    self._composerAddPhotoButton.Visible = v1
    self._composerAddPhotoButton.Active = v1
    self._composerAddPhotoButton.Selectable = v1
    local _textInputWrapper = self._textInputWrapper
    local v2 = if not v1 then UDim2.new(1, -50, 0, 48) else UDim2.new(1, -105, 0, 48)
    _textInputWrapper.Size = v2
    if not v1 then
        return
    end
    self._trove:Add((ButtonFX(self._composerAddPhotoButton, nil, function() -- Line: 196 -- upvalues: self (val)
        self._onInteraction()
        self._overlay.Visible = true
        self._input:CaptureFocus()
    end)))
    self._trove:Add((ButtonFX(self._cancelButton, 1.08, function() -- Line: 201 -- upvalues: self (val)
        self._onInteraction()
        self:_closeOverlay()
    end)))
    self._trove:Add((ButtonFX(self._removeButton, nil, function() -- Line: 205 -- upvalues: self (val)
        self._onInteraction()
        self:_setAttachment(nil)
    end)))
    self._trove:Add((ButtonFX(self._addButton, 1.08, function() -- Line: 209 -- upvalues: self (val), parseImageAssetId (upval), Toast (upval), isImageAsset (upval)
        self._onInteraction()
        local u7 = parseImageAssetId(self._input.Text)
        if u7 == nil then
            Toast.Show({
                Lane = "Banner",
                Text = "Invalid image, please upload another image.",
                Seconds = 3,
                ShowShadow = true,
                Color = Color3.new(1, 1, 1),
            })
            return
        end
        local v1 = self
        v1._requestSerial = v1._requestSerial + 1
        local _requestSerial = self._requestSerial
        self._addButton.Active = false
        task.spawn(function() -- Line: 220 -- upvalues: isImageAsset (upval), u7 (val), self (upval), _requestSerial (val), Toast (upval)
            local v1, v2 = isImageAsset(u7)
            if not self._destroyed and _requestSerial == self._requestSerial then
                self._addButton.Active = true
                if v1 then
                    self:_setAttachment(u7)
                    self:_closeOverlay()
                    return
                end
                if v2 == "ImageAssetLookupFailed" then
                    Toast.Show({
                        Lane = "Banner",
                        Text = "Something went wrong, please try again later.",
                        Seconds = 3,
                        ShowShadow = true,
                        Color = Color3.new(1, 1, 1),
                    })
                    return
                end
                Toast.Show({
                    Lane = "Banner",
                    Text = "Invalid image, please upload another image.",
                    Seconds = 3,
                    ShowShadow = true,
                    Color = Color3.new(1, 1, 1),
                })
                return
            end
        end)
    end)))
end

return u51