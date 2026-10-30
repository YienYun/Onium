local function createUiLibrary()
	local Z = {}

	do
		local gameRef = game

		local function getService(B)
			return gameRef:GetService(B)
		end

		local Players, TweenService = getService("Players"), getService("TweenService")
		local UserInputService = getService("UserInputService")
		local RunService = getService("RunService")
		local HttpService = getService("HttpService")
		local GuiService = getService("GuiService")
		local localPlayer, scrollingFrame = Players.LocalPlayer, Enum

		local function uiParent()
			local player = localPlayer or Players.LocalPlayer
			local playerGui = player and player:FindFirstChildOfClass("PlayerGui")
			if playerGui then
				return playerGui
			end
			return (gethui and gethui()) or getService("CoreGui")
		end
		local color3FromRGB = Color3.fromRGB
		local uDim2New = UDim2.new
		local uDim2FromScale = UDim2.fromScale
		local uDim2FromOffset = UDim2.fromOffset
		local vector2New = Vector2.new
		local uDimNew = UDim.new
		local o = color3FromRGB(255, 255, 255)
		local G = color3FromRGB(0, 0, 0)
		local w, h = color3FromRGB(58, 255, 55), "rbxasset://fonts/families/GothamSSm.json"
		local font = Font.new(h, scrollingFrame.FontWeight.ExtraBold, scrollingFrame.FontStyle.Normal)
		local font2 = Font.new(h, scrollingFrame.FontWeight.ExtraBold, scrollingFrame.FontStyle.Italic)
		local font3 = Font.fromEnum(scrollingFrame.Font.FredokaOne)

		local function b(...)
			local iMap, P = {}, {...}

			for i, v in ipairs(P) do
				iMap[i] = ColorSequenceKeypoint.new(v[1], v[2])
			end

			return ColorSequence.new(iMap)
		end

		local E = b({0, o}, {0.486159176, o}, {0.519031167, color3FromRGB(221, 221, 221)}, {1, color3FromRGB(236, 236, 236)})
		local P = b({0, color3FromRGB(0, 36, 84)}, {1, color3FromRGB(0, 31, 54)})
		local C = b({0, w}, {1, color3FromRGB(20, 109, 0)})
		local r = b({0, color3FromRGB(255, 193, 194)}, {0.0570934266, color3FromRGB(255, 132, 123)}, {1, color3FromRGB(239, 28, 28)})
		local d = b({0, color3FromRGB(255, 193, 194)}, {0.0155709349, color3FromRGB(255, 132, 123)}, {1, color3FromRGB(239, 28, 28)})
		local touchEnabled = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled) and not UserInputService.MouseEnabled
		local left = scrollingFrame.TextXAlignment.Left
		local center = scrollingFrame.HorizontalAlignment.Center
		local right = scrollingFrame.TextXAlignment.Right
		local quart = scrollingFrame.EasingStyle.Quart
		local quint, connections = scrollingFrame.EasingStyle.Quint, {}

		local function trackConnection(V, c)
			local connection = V:Connect(c)
			connections[#connections + 1] = connection
			return connection
		end

		local textValues = {TextLabel = 1, TextButton = 1, TextBox = 1}

		local function c(t, Q)
			local instance = Instance.new(t)

			if textValues[t] then
				instance.BackgroundTransparency = 1
				instance.Text = ""
			end

			if t == "TextButton" then
				instance.AutoButtonColor = false
			elseif t == "ImageButton" then
				instance.AutoButtonColor = false
			end

			if t == "TextBox" then
				instance.ClearTextOnFocus = false
			end

			if instance:IsA("GuiObject") then
				instance.BorderSizePixel = 0
			end

			if Q then
				for k, v in next, Q, nil do
					if type(k) ~= "number" then
						if k ~= "Parent" then
							instance[k] = v
						end
					end
				end

				for _, v in ipairs(Q) do
					v.Parent = instance
				end

				instance.Parent = Q.Parent
			end

			return instance
		end

		local function st(t, Q, n, S)
			local UIStroke = c("UIStroke", {Thickness = t, Color = Q or G, ApplyStrokeMode = (n and scrollingFrame.ApplyStrokeMode.Contextual) or scrollingFrame.ApplyStrokeMode.Border, LineJoinMode = scrollingFrame.LineJoinMode.Round, Transparency = S or 0})

			pcall(function()
				UIStroke.BorderOffset = uDimNew(0, 0)
				UIStroke.BorderStrokePosition = scrollingFrame.BorderStrokePosition.Outer
				UIStroke.StrokeSizingMode = scrollingFrame.StrokeSizingMode.ScaledSize
			end)

			return UIStroke
		end

		local function getUIGradient(Q, n)
			return c("UIGradient", {Color = Q, Rotation = 90, Name = n or "UIGradient"})
		end

		local function getUIAspectRatioConstraint(n, S)
			return c("UIAspectRatioConstraint", {AspectRatio = n or 1, DominantAxis = (S and scrollingFrame.DominantAxis.Height) or scrollingFrame.DominantAxis.Width})
		end

		local function n(parent)
			parent.FontFace = font
			parent.TextColor3 = o
			parent.TextScaled = true
			parent.LineHeight = 1
			st(0.08, G, true).Parent = parent
			return parent
		end

		local function S(parent, fontFace)
			if fontFace then
				parent.FontFace = fontFace
			end

			parent.TextColor3 = o
			parent.TextScaled = true
			parent.LineHeight = 1
			getUIGradient(E, "TextStyleGradient").Parent = parent
			fontFace = st(0.065, o, true)
			getUIGradient(P, "StrokeStyleGradient").Parent = fontFace
			fontFace.Parent = parent
			return parent
		end

		local function l(i, F)
			local TextLabel = c("TextLabel", i)
			if F then
				return S(TextLabel, ((F == true) and font) or F)
			end
			return n(TextLabel)
		end

		local function fn(i)
			i.TextTransparency = 0.32
			local uiStroke = i:FindFirstChildOfClass("UIStroke")
			uiStroke.Thickness = 0.06
			uiStroke.Transparency = 0.2
			return i
		end

		local function tw(F, K, f, R, H)
			local tween = TweenService:Create(F, TweenInfo.new(f or 0.15, R or scrollingFrame.EasingStyle.Quad, H or scrollingFrame.EasingDirection.Out), K)
			tween:Play()
			return tween
		end

		local function F(K)
			local userInputType = K.UserInputType
			return (userInputType == scrollingFrame.UserInputType.MouseButton1) or (userInputType == scrollingFrame.UserInputType.Touch)
		end

		Z.errs = {}

		local function K(f, ...)
			if f then
				local ok, H = pcall(f, ...)

				if not (ok) then
					warn("[Chilli] " .. tostring(H))

					if #Z.errs < 50 then
						Z.errs[#Z.errs + 1] = tostring(H)
					end
				end
			end
		end

		local function fb(R, H, I)
			local uiScale, y, v = R:FindFirstChildOfClass("UIScale") or c("UIScale", {Parent = R, Name = "InteractionScale"}), false

			local function playTween(arg, arg2)
				if v then
					v:Cancel()
				end

				v = tw(uiScale, {Scale = arg}, arg2)
			end

			trackConnection(R.MouseEnter, function()
				y = true
				playTween(H, 0.1)
			end)

			trackConnection(R.MouseLeave, function()
				y = false
				playTween(1, 0.1)
			end)

			trackConnection(R.MouseButton1Down, function()
				playTween(I, 0.055)
			end)

			trackConnection(R.MouseButton1Up, function()
				playTween((y and H) or 1, 0.08)
			end)

			return uiScale
		end

		local R, H = setmetatable, {__mode = "k"}
		local I = R({}, H)

		local function u(y, arg)
			local absolutePosition, absoluteSize = y.AbsolutePosition, y.AbsoluteSize
			return ((((y.Parent and y.Visible) and (arg.X >= absolutePosition.X)) and (arg.X <= (absolutePosition.X + absoluteSize.X))) and (arg.Y >= absolutePosition.Y)) and (arg.Y <= (absolutePosition.Y + absoluteSize.Y))
		end

		trackConnection(UserInputService.InputChanged, function(input)
			local v = I[input]

			if v then
				v.p = vector2New(input.Position.X, input.Position.Y)

				if (v.p - v.s).Magnitude > 10 then
					v.x = true
				end
			end
		end)

		local function hit(arg, arg2)
			arg.Active = true

			trackConnection(arg.InputBegan, function(input)
				if input.UserInputType == scrollingFrame.UserInputType.Touch then
					if input.UserInputState == scrollingFrame.UserInputState.Begin then
						local v = vector2New(input.Position.X, input.Position.Y)
						I[input] = {b = arg, s = v, p = v}
					end
				end
			end)

			return trackConnection(arg.Activated, function(inputObject)
				if inputObject then
					if inputObject.UserInputType == scrollingFrame.UserInputType.Touch then
						local v = I[inputObject]

						if v then
							if v.b ~= arg then
								return
							elseif v.x then
								return
							elseif not (u(arg, v.p)) then
								return
							end
						else
							return
						end
					end
				end

				K(arg2)
			end)
		end

		local tbl = {}

		trackConnection(RunService.Heartbeat, function()
			if #tbl > 0 then
				local v = tbl
				tbl = {}

				for _, v2 in ipairs(v) do
					K(v2)
				end
			end
		end)

		Z.q = function(arg)
			local v = tbl
			v[#v + 1] = arg
		end

		local function chev(arg, arg2, arg3, arg4, arg5, arg6, arg7)
			local Frame, tbl2 = c("Frame", {Parent = arg, Name = "Caret", AnchorPoint = vector2New(0.5, 0.5), Position = arg3, Size = arg4, BackgroundTransparency = 1, ZIndex = arg5 or 1, getUIAspectRatioConstraint(1, not arg7)}), {{0.335355, 45}, {0.664645, -45}}

			for _, v in ipairs(tbl2) do
				c("Frame", {Parent = Frame, Name = "Arm", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(v[1], 0.535355), Rotation = v[2], Size = uDim2FromScale(0.6657, arg6 or 0.2), BackgroundColor3 = arg2, ZIndex = (arg5 or 1) + 1})
			end

			return Frame
		end

		local function rb(arg)
			local TextButton = c("TextButton", {Parent = arg.Parent, Name = (arg.Name or arg.Text) or "Button", AnchorPoint = arg.AnchorPoint or vector2New(0.5, 0.5), Position = arg.Position or uDim2FromScale(0.5, 0.5), Size = arg.Size, LayoutOrder = arg.LayoutOrder or 0, ZIndex = arg.ZIndex or 99})
			local Frame = c("Frame", {Parent = TextButton, Name = "Main", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(1, (arg.full and 1) or 0.92), BackgroundColor3 = color3FromRGB(175, 0, 0), st((arg.full and 0.07) or 0.06)})
			local Frame2 = c("Frame", {Parent = Frame, Name = "ColorFrame", AnchorPoint = vector2New(0.5, 0), Position = uDim2FromScale(0.5, 0), Size = uDim2FromScale(1, 0.9), BackgroundColor3 = o, getUIGradient(r, "RedGradient")})
			local Frame3, v = c("Frame", {Parent = Frame2, Name = "Transparent", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(0.965, 0.88), BackgroundColor3 = o, ZIndex = 2, getUIGradient(d, "RedGradient")}), l({Parent = Frame2, Name = "Label", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = arg.LSize or uDim2FromScale(0.94, 0.72), Text = arg.Text or "", TextWrapped = arg.wrap == true, ZIndex = 6}, true)
			fb(TextButton, arg.h or 1.035, arg.p or 0.96)
			return TextButton, Frame, v, Frame2, Frame3
		end

		local function fn2(arg, arg2, arg3, arg4, arg5, arg6)
			local Frame = c("Frame", {Parent = arg, Name = "Switch", AnchorPoint = vector2New(arg2, 0.5), Position = uDim2FromScale(arg3, 0.5), Size = uDim2FromScale(arg4, arg5), BackgroundColor3 = o, ZIndex = arg6 or 3, st(0.06)})
			local UIGradient = c("UIGradient", {Parent = Frame, Name = "OFF", Color = ColorSequence.new(G), Rotation = 90, Transparency = NumberSequence.new(0.6)})
			local uiGradient = getUIGradient(C, "ON")
			uiGradient.Parent = Frame
			arg4, arg5, arg, arg3 = {Parent = Frame, Name = "Hold", AnchorPoint = vector2New(0.5, 0.5), Size = uDim2FromScale(0.72, 0.72), BackgroundColor3 = color3FromRGB(89, 89, 89), ZIndex = (arg6 or 3) + 2}, st(0.09), getUIAspectRatioConstraint(1), {Name = "Color", AnchorPoint = vector2New(0.5, 0), Position = uDim2FromScale(0.5, 0), Size = uDim2FromScale(1, 0.9), BackgroundColor3 = o}
			arg3.ZIndex = (arg6 or 3) + 3

			do
				local _vals = table.pack(arg5, arg, c("Frame", arg3))
				table.move(_vals, 1, _vals.n, 1, arg4)
			end

			local Frame2 = c("Frame", arg4)

			return Frame, function(enabled, arg7)
				UIGradient.Enabled = not enabled
				uiGradient.Enabled = enabled
				local v = uDim2FromScale((enabled and 0.72) or 0.28, 0.5)

				if arg7 == false then
					Frame2.Position = v
				else
					tw(Frame2, {Position = v}, 0.12)
				end
			end
		end

		Z.N = c
		Z.L = l
		Z.st = st
		Z.gr = getUIGradient
		Z.tw = tw
		Z.hit = hit
		Z.chev = chev
		Z.rb = rb
		Z.cn = trackConnection
		Z.fb = fb
		Z.ACC = C
		Z.RED1 = r
		Z.SHN = E
		Z.SHS = P
		Z.FN = font
		Z.FR = font3

		local function readCachedFile(arg)
			local ok, result = pcall(readfile, arg)
			return (ok and result) or nil
		end

		local function saveFile(arg, arg2)
			pcall(writefile, arg, arg2)
		end

		local function ensureFolder(arg)
			if isfolder then
				if not (isfolder(arg)) then
					pcall(makefolder, arg)
				end
			end
		end

		local function dec(arg)
			if not (arg) then
				return
			end
			local ok, result = pcall(HttpService.JSONDecode, HttpService, arg)
			return (ok and result) or nil
		end

		local function enc(arg)
			local ok, result = pcall(HttpService.JSONEncode, HttpService, arg)
			return (ok and result) or nil
		end

		Z.dec = dec
		Z.enc = enc
		Z.rd = readCachedFile
		Z.wr = saveFile
		local n2, n3, n4 = 1000, 3, 12

		local function roundSigFigs(arg)
			if arg <= 0 then
				return 0
			end
			local n5 = 10 ^ (math.floor(math.log10(arg)) - 2)
			return math.floor((arg / n5) + 0.5) * n5
		end

		local function clampValue(arg)
			arg = math.clamp(tonumber(arg) or 0, 0, n2)
			return ((arg <= 0) and 0) or roundSigFigs(10 ^ (n3 + (((n4 - n3) * arg) / n2)))
		end

		local function roundSigFigs2(arg)
			arg = tonumber(arg) or 0
			if arg <= 0 then
				return 0
			end
			return math.clamp(math.floor(((((math.log10(arg) - n3) / (n4 - n3)) * n2) * 100) + 0.5) / 100, 0, n2)
		end

		local function fn3(arg)
			local stringFormat, flag = string.format, ((arg >= 100) and "%.0f") or ((arg >= 10) and "%.1f")
			local v = stringFormat(flag or "%.2f", arg)
			return if v:find(".", 1, true) then v:gsub("0+$", ""):gsub("%.$", "") else v
		end

		local function formatRate(arg)
			local numVal = clampValue(arg)

			if numVal <= 0 then
				return "Off"
			elseif numVal < 1000000 then
				return fn3(numVal / 1000) .. " K/s"
			elseif numVal < 1000000000 then
				return fn3(numVal / 1000000) .. " M/s"
			end

			return fn3(numVal / 1000000000) .. " B/s"
		end

		local function formatCompact(arg)
			local numVal = clampValue(arg)

			if numVal <= 0 then
				return "0"
			elseif numVal < 1000000 then
				return fn3(numVal / 1000) .. "k"
			end

			return (string.format("%.3f", numVal / 1000000):gsub("0+$", ""):gsub("%.$", ""))
		end

		local unitMultipliers = {k = 1000, m = 1000000, b = 1000000000, t = 1000000000000}

		local function fn4(arg)
			arg = tostring(arg or ""):gsub("[%s,/]", ""):lower():gsub("s$", "")

			if arg == "" then
				return 0
			elseif arg == "off" then
				return 0
			end

			local match, v = arg:match("^([%d%.]+)([kmbt]?)$")
			match = tonumber(match)
			return (match and roundSigFigs2(match * (unitMultipliers[v] or 1000000))) or nil
		end

		Z.s2v = clampValue
		Z.v2s = roundSigFigs2

		local function colorizeText(color, arg)
			local n5, n6, n7, str = math.floor((color.R * 255) + 0.5), math.floor((color.G * 255) + 0.5), math.floor((color.B * 255) + 0.5), tostring(arg):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
			return ("<font color=\"rgb(%d,%d,%d)\">%s</font>"):format(n5, n6, n7, str)
		end

		local index, index2, widgetSpecs = {}, {}, {}
		index.__index = index
		index2.__index = index2
		widgetSpecs.__index = widgetSpecs
		local n5, n6, list = 1, 1, {}

		local function fn5(arg)
			list[#list + 1] = arg
			arg()
		end

		local w2

		local function closeDropdown()
			if w2 then
				if w2.closeDD then
					w2.closeDD()
				end
			end
		end

		Z.Window = function(arg)
			local w3 = setmetatable({Tabs = {}, Opts = {}, ByPath = {}, St = {}, open = false, cols = {}, rest = uDim2FromScale(0.5, 0.475)}, index)
			Z.W = w3
			w2 = w3
			local hui = uiParent()
			w3.par = hui

			for _, child in ipairs(hui:GetChildren()) do
				if child:IsA("ScreenGui") then
					if child:GetAttribute("ChilliRB") then
						child:Destroy()
					elseif (child:GetAttribute("ChilliLibraryOwned") or (child.Name == "Settings")) or (child.Name == "ChilliQuickBar") then
						if child:GetAttribute("ChilliScriptOwner") ~= "Joiner" then
							child:Destroy()
						end
					end
				end
			end

			w3.dirP = "ChilliLibrary/Games/" .. tostring(arg.Game or gameRef.GameId)
			ensureFolder("ChilliLibrary")
			ensureFolder("ChilliLibrary/Games")
			ensureFolder(w3.dirP)
			ensureFolder(w3.dirP .. "/configs")
			local currentCamera = workspace.CurrentCamera
			local viewportSize = (currentCamera and currentCamera.ViewportSize) or vector2New(1280, 720)
			viewportSize = if viewportSize.X < 1 then vector2New(1280, 720) else if viewportSize.Y < 1 then vector2New(1280, 720) else viewportSize
			local guiInset = vector2New()
			local v = vector2New()

			pcall(function()
				guiInset, v = GuiService:GetGuiInset()
			end)

			local g, n7 = math.max((viewportSize.X - guiInset.X) - v.X, 1), math.max((viewportSize.Y - guiInset.Y) - v.Y, 1)
			local n8, n9 = 0.45 * g, 0.55 * n7

			if (n8 / n9) > 1.34 then
				n8 = n9 * 1.34
			else
				n9 = n8 / 1.34
			end

			if touchEnabled then
				currentCamera = math.min(1.3, (g * 0.98) / math.max(n8, 1), (n7 * 0.98) / math.max(n9, 1))
				n8, n9 = n8 * currentCamera, n9 * currentCamera
			else
			end

			w3.base = uDim2FromScale(n8 / g, n9 / n7)
			w3.size = w3.base
			local ScreenGui = c("ScreenGui", {Name = HttpService:GenerateGUID(false):gsub("-", ""):sub(1, 12), ResetOnSpawn = false, IgnoreGuiInset = true, ZIndexBehavior = scrollingFrame.ZIndexBehavior.Sibling, DisplayOrder = 6, Enabled = false})
			ScreenGui:SetAttribute("ChilliRB", true)
			w3.gui = ScreenGui
			local Frame = c("Frame", {Parent = ScreenGui, Name = "Frame", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2New(0.5, 0, 1.55, 0), Size = w3.size, BackgroundColor3 = G, BackgroundTransparency = 0.4, st(0.008)})
			w3.main = Frame
			local Frame2 = c("Frame", {Parent = Frame, Name = "Top", AnchorPoint = vector2New(0.5, 0), Position = uDim2FromScale(0.5, 0), Size = uDim2FromScale(1, 0.125), BackgroundColor3 = color3FromRGB(111, 0, 2), st(0.06, color3FromRGB(58, 0, 0))})
			g = c("Frame", {Parent = Frame2, Name = "Color", AnchorPoint = vector2New(0.5, 0), Position = uDim2FromScale(0.5, 0), Size = uDim2FromScale(1, 0.88), BackgroundColor3 = o, getUIGradient(b({0, color3FromRGB(253, 86, 89)}, {1, color3FromRGB(255, 11, 15)}))})
			c("Frame", {Parent = g, Name = "Transparent", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(0.988, 0.87), BackgroundColor3 = G, BackgroundTransparency = 0.9})
			local v2 = l({Parent = g, Name = "Label", AnchorPoint = vector2New(0.5, 0.5), Text = arg.Title or "Chilli Hub", TextWrapped = true, TextXAlignment = left, ZIndex = 6}, font2)
			local TextButton = c("TextButton", {Parent = Frame2, Name = "Close", AnchorPoint = vector2New(0.5, 0.5), LayoutOrder = 1, ZIndex = 99, getUIAspectRatioConstraint(1)})
			n7 = c("Frame", {Parent = c("Frame", {Parent = TextButton, Name = "Main", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(1, 1), BackgroundColor3 = color3FromRGB(126, 0, 0), st(0.09, color3FromRGB(76, 0, 0))}), Name = "Color", AnchorPoint = vector2New(0.5, 0), Position = uDim2FromScale(0.5, 0), Size = uDim2FromScale(1, 0.9), BackgroundColor3 = o, getUIGradient(b({0, color3FromRGB(255, 130, 130)}, {1, color3FromRGB(239, 28, 28)}))})
			c("Frame", {Parent = n7, Name = "Transparent", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(0.96, 0.88), BackgroundColor3 = G, BackgroundTransparency = 0.9})
			l({Parent = n7, Name = "Label", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(1.14, 0.98), Text = "X", TextWrapped = true, ZIndex = 6}, font3)

			do
				local M, v3

				local function getUDim2()
					local n10 = 0.06637302041053772 / n5
					return uDim2New(n10, 0, 0.6588137149810791, 0)
				end

				local function playTween(arg2, arg3)
					local uDim = getUDim2()

					if v3 then
						v3:Cancel()
					end

					v3 = tw(TextButton, {Size = uDim2New(uDim.X.Scale * arg2, 0, uDim.Y.Scale * arg2, 0)}, arg3)
				end

				trackConnection(TextButton.MouseEnter, function()
					M = true
					playTween(1.04, 0.12)
				end)

				trackConnection(TextButton.MouseLeave, function()
					M = false
					playTween(1, 0.12)
				end)

				trackConnection(TextButton.MouseButton1Down, function()
					playTween(0.96, 0.06)
				end)

				trackConnection(TextButton.MouseButton1Up, function()
					playTween((M and 1.04) or 1, 0.09)
				end)
			end

			hit(TextButton, function()
				w3:Show(false)
			end)

			n7 = {{"SideButtons", 1, -1}, {"SideButtonsRight", 0, 1}}

			for i, v3 in ipairs(n7) do
				g = c("Frame", {Parent = Frame, Name = v3[1], AnchorPoint = vector2New(v3[2], 0.5), BackgroundTransparency = 1, ZIndex = 99})
				w3.cols[i] = {f = g, e = v3[3], ly = c("UIListLayout", {Parent = g, Name = "TabLayout", HorizontalAlignment = center, SortOrder = scrollingFrame.SortOrder.LayoutOrder}), pd = c("UIPadding", {Parent = g, Name = "TabPadding"})}
			end

			local TextButton2, Frames, tbl2 = c("TextButton", {Parent = Frame, Name = "ResizeGrip", AnchorPoint = vector2New(1, 1), Selectable = false, ZIndex = 120, getUIAspectRatioConstraint(1)}), {}, {{0.5, 0.9}, {0.68, 0.54}, {0.84, 0.22}}

			for _, v3 in ipairs(tbl2) do
				Frames[#Frames + 1] = c("Frame", {Parent = TextButton2, Name = "GripBar", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(v3[1], v3[1]), Size = uDim2FromScale(v3[2], 0.13), Rotation = -45, BackgroundColor3 = o, BackgroundTransparency = 0.35, ZIndex = 121})
			end

			local flag, input, v3, absoluteSize

			local function fn6(arg2)
				for _, Frame3 in ipairs(Frames) do
					tw(Frame3, {BackgroundTransparency = (arg2 and 0.05) or 0.35}, 0.1)
				end
			end

			trackConnection(TextButton2.MouseEnter, function()
				fn6(true)
			end)

			trackConnection(TextButton2.MouseLeave, function()
				if not (flag) then
					fn6(false)
				end
			end)

			trackConnection(TextButton2.InputBegan, function(input2)
				if not (flag) then
					if F(input2) then
						if input2.UserInputState == scrollingFrame.UserInputState.Begin then
							local input3, v4, absoluteSize2 = ((input2.UserInputType == scrollingFrame.UserInputType.Touch) and input2) or nil, vector2New(input2.Position.X, input2.Position.Y), Frame.AbsoluteSize
							flag, input, v3, absoluteSize = true, input3, v4, absoluteSize2
							fn6(true)
						end
					end
				end
			end)

			trackConnection(UserInputService.InputChanged, function(input2)
				local input3 = flag and ((input and (input2 == input)) or (if input then not input else input2.UserInputType == scrollingFrame.UserInputType.MouseMovement))

				if input3 then
					local n10 = vector2New(input2.Position.X, input2.Position.Y) - v3
					w3:Resize(absoluteSize.X + (n10.X * 2), absoluteSize.Y + (n10.Y * 2))
				end
			end)

			trackConnection(UserInputService.InputEnded, function(input2)
				local flag2 = flag and ((input2.UserInputType == scrollingFrame.UserInputType.MouseButton1) or (input2 == input))

				if flag2 then
					flag, input = false, nil
					fn6(false)
				end
			end)

			do
				local M, input2, v4, input3

				trackConnection(Frame2.InputBegan, function(input4)
					if M then
						return
					elseif F(input4) then
						if input4.UserInputState ~= scrollingFrame.UserInputState.Begin then
							return
						elseif w3.open then
							if w3.anim then
								return
							end
						else
							return
						end
					else
						return
					end

					local v5 = vector2New(input4.Position.X, input4.Position.Y)

					if u(Frame2, v5) then
						if u(TextButton, v5) then
							return
						end
					else
						return
					end

					local absoluteSize2, input5 = ScreenGui.AbsoluteSize, ((input4.UserInputType == scrollingFrame.UserInputType.Touch) and input4) or nil
					input4 = vector2New(Frame.Position.X.Scale + (Frame.Position.X.Offset / absoluteSize2.X), Frame.Position.Y.Scale + (Frame.Position.Y.Offset / absoluteSize2.Y))
					M, input2, v4, input3 = true, input5, v5, input4
				end)

				trackConnection(UserInputService.InputChanged, function(input4)
					if M then
						if not (input2 and (input4 == input2)) then
							if input2 then
								return
							elseif input4.UserInputType ~= scrollingFrame.UserInputType.MouseMovement then
								return
							end
						end
					else
						return
					end

					local absoluteSize2, n10 = ScreenGui.AbsoluteSize, vector2New(input4.Position.X, input4.Position.Y) - v4
					local n11, n12 = Frame.AbsoluteSize.X / absoluteSize2.X, Frame.AbsoluteSize.Y / absoluteSize2.Y
					local n13, n14, n15, n16 = n11 * 0.5, 0.998 - (n11 * 0.5), n12 * 0.5, 0.98 + (n12 * 0.5)
					Frame.Position = uDim2FromScale(math.clamp(input3.X + (n10.X / absoluteSize2.X), math.min(n13, n14), math.max(n13, n14)), math.clamp(input3.Y + (n10.Y / absoluteSize2.Y), math.min(n15, n16), math.max(n15, n16)))
					w3.rest = Frame.Position
				end)

				trackConnection(UserInputService.InputEnded, function(input4)
					if M then
						if input4.UserInputType == scrollingFrame.UserInputType.MouseButton1 then
							M = false
						elseif input4 == input2 then
							M = false
						end
					end
				end)

				w3.dragStop = function()
					M = false
				end
			end

			local Frame3 = c("Frame", {Parent = Frame, Name = "SearchBar", AnchorPoint = vector2New(0.5, 0), Position = uDim2FromScale(0.5, 1.022), Size = uDim2FromScale(1, 0.0749), BackgroundColor3 = G, BackgroundTransparency = 0.4, ZIndex = 6, st(0.05)})
			l({Parent = Frame3, Name = "Caption", AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale(0.02, 0.5), Size = uDim2FromScale(0.13, 0.5), Text = "Search", TextXAlignment = left, ZIndex = 7})
			local Frame4 = c("Frame", {Parent = Frame3, Name = "Field", AnchorPoint = vector2New(1, 0.5), Position = uDim2FromScale(0.982, 0.5), Size = uDim2FromScale(0.82, 0.6), BackgroundColor3 = G, BackgroundTransparency = 0.6, ZIndex = 7, st(0.1)})
			local Frame5 = c("Frame", {Parent = Frame4, Name = "Underline", AnchorPoint = vector2New(0.5, 1), Position = uDim2FromScale(0.5, 1), Size = uDim2FromScale(0, 0.11), BackgroundColor3 = o, ZIndex = 9})
			local TextBox = c("TextBox", {Parent = Frame4, Name = "Input", AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale(0.025, 0.5), Size = uDim2FromScale(0.9, 0.62), PlaceholderText = "Filter features...", PlaceholderColor3 = color3FromRGB(198, 198, 198), TextXAlignment = left, ZIndex = 8})
			n(TextBox)
			local TextButton3, tbl3 = c("TextButton", {Parent = Frame4, Name = "Clear", AnchorPoint = vector2New(1, 0.5), Position = uDim2FromScale(0.985, 0.5), Size = uDim2FromScale(0.075, 0.74), Visible = false, ZIndex = 9, getUIAspectRatioConstraint(1, true)}), {45, -45}

			for _, v4 in ipairs(tbl3) do
				c("Frame", {Parent = TextButton3, Name = "Arm", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(0.82, 0.2), Rotation = v4, BackgroundColor3 = color3FromRGB(255, 72, 72), ZIndex = 10})
			end

			fb(TextButton3, 1.12, 0.9)

			hit(TextButton3, function()
				if TextBox:IsFocused() then
					TextBox:ReleaseFocus()
				end

				TextBox.Text = ""
			end)

			trackConnection(TextBox.Focused, function()
				tw(Frame4, {BackgroundTransparency = 0.42}, 0.16)
				tw(Frame5, {Size = uDim2FromScale(1, 0.11)}, 0.2, quint)
			end)

			trackConnection(TextBox.FocusLost, function()
				tw(Frame4, {BackgroundTransparency = 0.6}, 0.16)
				tw(Frame5, {Size = uDim2FromScale(0, 0.11)}, 0.2, quint)
			end)

			trackConnection(TextBox:GetPropertyChangedSignal("Text"), function()
				TextButton3.Visible = TextBox.Text ~= ""

				if not (w3.sbQuiet) then
					if w3.Cur then
						w3.Cur.q = TextBox.Text
						w3:Search(TextBox.Text)
					end
				end
			end)

			w3.sbox = TextBox
			local v4

			local function fn7()
				local n10, n11 = 0.0749 / n6, 0.022 / n6
				Frame3.Size = uDim2FromScale(1, n10)
				local y = Frame.AbsoluteSize.Y
				local flag2 = ((Frame.AbsolutePosition.Y + y) + ((n10 + n11) * y)) <= ScreenGui.AbsoluteSize.Y
				if flag2 == v4 then
					return
				end
				v4 = flag2

				if flag2 then
					Frame3.AnchorPoint, Frame3.Position = vector2New(0.5, 0), uDim2FromScale(0.5, 1 + n11)
				else
					Frame3.AnchorPoint, Frame3.Position = vector2New(0.5, 1), uDim2FromScale(0.5, -n11)
				end
			end

			trackConnection(Frame:GetPropertyChangedSignal("AbsolutePosition"), fn7)
			trackConnection(Frame:GetPropertyChangedSignal("AbsoluteSize"), fn7)

			fn5(function()
				Frame2.Size = uDim2New(1, 0, 0.125 / n6, 0)
				v2.Position, v2.Size = uDim2New(0.5687711238861084 / n5, 0, 0.5, 0), uDim2New(0.8620089292526245 / n5, 0, 0.7499999403953552, 0)
				TextButton.Position, TextButton.Size = uDim2New(1 - (0.04500001668930054 / n5), 0, 0.4339999854564667, 0), uDim2New(0.06637302041053772 / n5, 0, 0.6588137149810791, 0)
				TextButton2.Position, TextButton2.Size = uDim2FromScale(1 - (0.002 / n5), 1 - (0.005 / n6)), uDim2FromScale(0.05 / n5, 0.05 / n6)
				local v5, cols = ipairs, w3.cols

				for _, col in v5(cols) do
					col.f.Position = uDim2New(((col.e < 0) and (-0.025 / n5)) or (1 + (0.025 / n5)), 0, 0.558, 0)
					col.f.Size = uDim2New(0.2612044513 / n5, 0, 1, 0)
					col.pd.PaddingTop = uDimNew(0.067 / n6, 0)
				end

				v4 = nil
				fn7()
				w3:Reflow()
			end)

			ScreenGui.Parent = hui
			w3.key = arg.Key or scrollingFrame.KeyCode.LeftControl
			w3:Mgr()
			return w3
		end

		index.Resize = function(arg, g, J)
			local absoluteSize = arg.gui.AbsoluteSize

			if absoluteSize.X <= 0 then
				return
			elseif absoluteSize.Y <= 0 then
				return
			end

			arg.size = uDim2FromScale(math.clamp(g / absoluteSize.X, 0.2, 0.98), math.clamp(J / absoluteSize.Y, 0.22, 0.98))
			arg.main.Size = arg.size
			absoluteSize, J = math.max(1, arg.size.X.Scale / arg.base.X.Scale), math.max(1, arg.size.Y.Scale / arg.base.Y.Scale)

			if math.abs(absoluteSize - n5) < 0.0001 then
				if math.abs(J - n6) < 0.0001 then
					return
				end
			end

			n5, n6 = absoluteSize, J

			for _, v in ipairs(list) do
				K(v)
			end
		end

		index.Scale = function(arg, g)
			local absoluteSize = arg.gui.AbsoluteSize
			arg:Resize((arg.base.X.Scale * absoluteSize.X) * g, (arg.base.Y.Scale * absoluteSize.Y) * g)
		end

		index.Show = function(arg, open)
			open = if open == nil then not arg.open else open
			if arg.open == open then
				return
			end
			arg.open = open
			local main, rest, flag = arg.main, arg.rest, arg.wt ~= nil

			if arg.wt then
				arg.wt:Cancel()
			end

			arg.anim = true

			if open then
				if not (flag) then
					main.Position = uDim2New(rest.X.Scale, rest.X.Offset, rest.Y.Scale + 0.245, rest.Y.Offset)
				end

				main.Size = arg.size
				arg.wt = tw(main, {Position = rest}, 0.34, quart)

				if not (arg.Cur) then
					if arg.Tabs[1] then
						arg:Select(arg.Tabs[1])
					end
				end
			else
				closeDropdown()

				if arg.dragStop then
					arg.dragStop()
				end

				main.Size = arg.size
				arg.wt = tw(main, {Position = uDim2New(rest.X.Scale, rest.X.Offset, 1.55, 0)}, 0.26, quart, scrollingFrame.EasingDirection.In)
			end

			local wt = arg.wt

			local function M(playbackState)
				if arg.wt == wt then
					arg.wt = nil

					if playbackState == scrollingFrame.PlaybackState.Completed then
						arg.anim = false
					end
				end
			end

			wt.Completed:Connect(M)

			if arg.onShow then
				K(arg.onShow, open)
			end
		end

		index.Reflow = function(arg)
			local g, cols = ipairs, arg.cols

			for k, col in g(cols) do
				local tabs = {}

				for _, tab in ipairs(arg.Tabs) do
					if tab.ci == k then
						tabs[#tabs + 1] = tab
					end
				end

				k = #tabs

				if k > 0 then
					local n7 = 0.1769230769230769
					local J = math.min(0.13, (0.895 * n6) / (k + (math.max(k - 1, 0) * n7))) / n6
					col.ly.Padding = uDimNew(J * n7, 0)

					for i, tab in ipairs(tabs) do
						tab.btn.LayoutOrder, tab.btn.Size = i, uDim2New(1, 0, J, 0)
					end
				end
			end
		end

		index.Tab = function(arg, g, J, M)
			local j = arg
			local obj = setmetatable({W = j, Name = g, Disp = M or g, Sections = {}, q = "", ci = ((J == "Right") and 2) or 1}, index2)
			obj.btn, obj.base = rb({Parent = j.cols[obj.ci].f, Name = M or g, Size = uDim2New(1, 0, 0.13, 0), LayoutOrder = #j.Tabs + 1, Text = M or g})
			local ScrollingFrame = c("ScrollingFrame", {Parent = j.main, Name = g .. "Page", Active = true, AnchorPoint = vector2New(0.5, 0.5), BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 5, CanvasSize = uDim2FromOffset(0, 0), ScrollBarImageColor3 = o, ScrollingDirection = scrollingFrame.ScrollingDirection.Y, VerticalScrollBarInset = scrollingFrame.ScrollBarInset.None, Visible = false})
			obj.page = ScrollingFrame
			obj.ly = c("UIListLayout", {Parent = ScrollingFrame, Name = "ContentLayout", HorizontalAlignment = center, SortOrder = scrollingFrame.SortOrder.LayoutOrder, Padding = uDimNew(0, 2)})
			c("UIPadding", {Parent = ScrollingFrame, Name = "ContentPadding", PaddingLeft = uDimNew(0.014000000432133675, 0), PaddingRight = uDimNew(0.014000000432133675, 0)})
			local n7 = -1

			obj.canvas = function()
				local y = math.ceil(obj.ly.AbsoluteContentSize.Y)
				local n8 = ((y > 0) and math.ceil(y + math.max(8, (ScrollingFrame.AbsoluteSize.Y * 0.06) / n6))) or 0

				if math.abs(n8 - n7) >= 1 then
					n7 = n8
					ScrollingFrame.CanvasSize = uDim2FromOffset(0, n8)
				end

				y = math.max(0, n8 - ScrollingFrame.AbsoluteSize.Y)

				if ScrollingFrame.CanvasPosition.Y > y then
					ScrollingFrame.CanvasPosition = vector2New(ScrollingFrame.CanvasPosition.X, y)
				end
			end

			trackConnection(obj.ly:GetPropertyChangedSignal("AbsoluteContentSize"), obj.canvas)

			trackConnection(ScrollingFrame:GetPropertyChangedSignal("AbsoluteSize"), function()
				ScrollingFrame.ScrollBarThickness = math.max(2, math.floor(((ScrollingFrame.AbsoluteSize.X * 0.006) / n5) + 0.5))
				obj.canvas()
			end)

			fn5(function()
				local n8, n9 = 0.1454 / n6, 1 - (0.01500005 / n6)
				ScrollingFrame.Position, ScrollingFrame.Size = uDim2New(0.5000000596046448, 0, (n8 + n9) / 2, 0), uDim2New(0.9900000095367432, 0, n9 - n8, 0)
			end)

			hit(obj.btn, function()
				j:Select(obj)
			end)

			j.Tabs[#j.Tabs + 1] = obj
			j:Reflow()

			if not (j.Cur) then
				j:Select(obj)
			end

			return obj
		end

		index.Select = function(arg, cur)
			if type(cur) == "string" then
				local J, tabs = ipairs, arg.Tabs

				for _, tab in J(tabs) do
					if tab.Name == cur then
						cur = tab
					else
					end
				end
			else
			end

			if type(cur) ~= "table" then
				return
			end
			closeDropdown()

			for _, tab in ipairs(arg.Tabs) do
				tab.page.Visible = tab == cur
				local base, j = tab.base, {}
				j.BackgroundColor3 = ((tab == cur) and color3FromRGB(255, 54, 54)) or color3FromRGB(175, 0, 0)
				tw(base, j, 0.14)
			end

			arg.Cur = cur

			if arg.sbox then
				arg.sbQuiet = true
				arg.sbox.Text = cur.q or ""
				arg.sbQuiet = false
			end

			task.defer(function()
				for _, section in ipairs(cur.Sections) do
					section:Fit()
				end

				cur.canvas()
			end)

			if cur.onOpen then
				K(cur.onOpen)
			end
		end

		local n7, g, J, M, j, n8, n9 = 0.97, 0.22, 0.09999999633202186, 0.67569, 0.3388905, 0.5388904999999999, 0.6192006943127453

		index2.Section = function(arg, arg2, arg3, arg4)
			local w3, v = arg.W, arg
			local obj = setmetatable({W = w3, t = arg, Name = arg2, Disp = arg4 or arg2, open = arg3 ~= false, rows = {}, n = 0}, widgetSpecs)
			obj.f = c("Frame", {Parent = arg.page, Name = arg2 .. "Section", BackgroundTransparency = 1, Size = uDim2New(1, 0, 0, 0), AutomaticSize = scrollingFrame.AutomaticSize.Y, LayoutOrder = #arg.Sections + 1, ZIndex = 3, c("UIListLayout", {Name = "SectionLayout", HorizontalAlignment = center, SortOrder = scrollingFrame.SortOrder.LayoutOrder, Padding = uDimNew(0, 2)})})
			local v2 = l({Parent = obj.f, Name = arg4 or arg2, AnchorPoint = vector2New(0.5, 0.5), LayoutOrder = 1, Size = uDim2New(0.97, 0, 0, 36), Text = arg4 or arg2, TextWrapped = true, ZIndex = 4}, true)
			local Frame = c("Frame", {Parent = v2, Name = "ArrowClip", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.4, 0.5), Size = uDim2FromOffset(1, 1), BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 6})
			local Frame2, v3 = c("Frame", {Parent = Frame, Name = "Arrow", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromOffset(1, 1), BackgroundTransparency = 1, ZIndex = 6}), ipairs
			arg4 = {{g + (J * 2), M + (J * 2), P}, {g, M, E}}

			for k, v4 in v3(arg4) do
				arg3, arg2 = ipairs, {{j, 45}, {1 - j, -45}}

				for _, v5 in arg3(arg2) do
					c("Frame", {Parent = Frame2, Name = "Arm", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(v5[1], n8), Rotation = v5[2], Size = uDim2FromScale(v4[2], v4[1]), BackgroundColor3 = o, ZIndex = 5 + k, getUIGradient(v4[3])})
				end
			end

			local function clampValue2()
				local x, y = v2.AbsoluteSize.X, v2.AbsoluteSize.Y

				if x <= 0 then
					return
				elseif y <= 0 then
					return
				end

				local n10, n11 = y * 0.65, y * 0.15
				y = n10 * n9
				Frame.Size = uDim2FromOffset(n10 * 1.35, n10 * 1.35)
				Frame.Position = uDim2New(0, math.max((((x - math.min(v2.TextBounds.X, x)) / 2) - n11) - y, y), 0.5, 0)
				Frame2.Size = uDim2FromOffset(n10, n10)
			end

			local function fn6()
				local page, y, n10 = v.page, Frame.AbsolutePosition.Y, Frame.AbsolutePosition.Y + Frame.AbsoluteSize.Y
				Frame.Visible = (y >= page.AbsolutePosition.Y) and (n10 <= (page.AbsolutePosition.Y + page.AbsoluteSize.Y))
			end

			trackConnection(v2:GetPropertyChangedSignal("TextBounds"), clampValue2)
			trackConnection(v2:GetPropertyChangedSignal("AbsoluteSize"), clampValue2)
			trackConnection(v2:GetPropertyChangedSignal("AbsolutePosition"), fn6)
			trackConnection(v.page:GetPropertyChangedSignal("CanvasPosition"), fn6)

			hit(c("TextButton", {Parent = v2, Name = "SectionButton", Size = uDim2FromScale(1, 1), ZIndex = 8}), function()
				obj:Expand(not obj.open)
			end)

			obj.hd = v2
			obj.ar = Frame2
			obj.g = c("Frame", {Parent = obj.f, Name = "CollapsibleContent", BackgroundTransparency = 1, ClipsDescendants = true, LayoutOrder = 2, Size = uDim2New(1, 0, 0, 0), ZIndex = 3})
			obj.b = c("Frame", {Parent = obj.g, Name = "Content", BackgroundTransparency = 1, Size = uDim2New(1, 0, 0, 0), AutomaticSize = scrollingFrame.AutomaticSize.Y, ZIndex = 3, c("UIListLayout", {Name = "OptionLayout", HorizontalAlignment = center, SortOrder = scrollingFrame.SortOrder.LayoutOrder})})

			trackConnection(obj.b:GetPropertyChangedSignal("AbsoluteSize"), function()
				if not (obj.tw) then
					obj.g.Size = uDim2New(1, 0, 0, (obj.open and obj.b.AbsoluteSize.Y) or 0)
				end

				if math.abs(obj.b.AbsoluteSize.X - (obj.lw or 0)) > 0.5 then
					obj.lw = obj.b.AbsoluteSize.X
					obj:Fit()
				end
			end)

			fn5(function()
				obj:Fit()
			end)

			arg.Sections[#arg.Sections + 1] = obj
			obj:Expand(obj.open, false)

			task.defer(function()
				obj:Fit()
				clampValue2()
				fn6()
			end)

			return obj
		end

		widgetSpecs.Fit = function(arg)
			local x = arg.f.AbsoluteSize.X
			x = if x <= 0 then arg.t.page.AbsoluteSize.X else x

			if x > 0 then
				arg.hd.Size = uDim2New(0.97, 0, 0, math.max(1, math.floor((((x / n5) * 0.97) / 16) + 0.5)))
			end

			for _, row in ipairs(arg.rows) do
				if row.fit then
					row.fit()
				end
			end
		end

		widgetSpecs.Expand = function(arg, open, arg2)
			closeDropdown()
			arg.open = open

			if arg.tw then
				arg.tw:Cancel()
				arg.tw = nil
			end

			local g2 = arg.g
			local y = (open and arg.b.AbsoluteSize.Y) or 0
			g2.ClipsDescendants = true

			if open then
				g2.Visible = true
			end

			if arg2 == false then
				g2.Size, g2.Visible, g2.ClipsDescendants, arg.ar.Rotation = uDim2New(1, 0, 0, y), open, not open, (open and 0) or -90
				return
			end
			local ar, tbl2 = arg.ar, {}
			tbl2.Rotation = (open and 0) or -90
			tw(ar, tbl2, 0.24)
			local v = tw(g2, {Size = uDim2New(1, 0, 0, y)}, 0.28, quint)
			arg.tw = v

			local function fn6()
				if arg.tw == v then
					arg.tw = nil
					g2.Visible, g2.ClipsDescendants = arg.open, not arg.open
					g2.Size = uDim2New(1, 0, 0, (arg.open and arg.b.AbsoluteSize.Y) or 0)
				end
			end

			v.Completed:Connect(fn6)
		end

		widgetSpecs.Collapse = function(arg, arg2)
			arg:Expand(not arg2)
		end

		local function fn6(arg, arg2)
			arg.nt = fn(l({Parent = arg.m, Name = "Note", AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale(0.025, 0.755), Size = uDim2FromScale(arg2, 0.3), TextXAlignment = left, Visible = false, ZIndex = 5}))
			return arg.nt
		end

		local function fn7(arg, arg2, arg3)
			arg.lb.Position, arg.lb.Size = uDim2FromScale(0.025, (arg3 and 0.34) or 0.5), uDim2FromScale(arg2, (arg3 and 0.432) or 0.64)
			arg.ratio = (arg3 and 7.5) or 10
		end

		widgetSpecs.Row = function(arg, arg2, arg3, arg4, ratio)
			arg.n = arg.n + 1
			local tbl2 = {sec = arg, name = arg2, sub = arg3}
			tbl2.ratio = ratio or 10
			tbl2.hw = (arg3 and 0.9) or 1
			local Frame = c("Frame", {Parent = arg.b, Name = arg2 .. "CollapsibleContent", BackgroundTransparency = 1, ClipsDescendants = true, LayoutOrder = arg.n, Size = uDim2New(tbl2.hw, 0, 0, 1), ZIndex = 3})
			local Frame2 = c("Frame", {Parent = Frame, Name = arg2, AnchorPoint = vector2New(0.5, 0), Position = uDim2FromScale(0.5, 0), Size = uDim2New(n7, 0, 0, 1), BackgroundTransparency = 1, ZIndex = 3})
			arg3 = nil

			if arg4 then
				tbl2.head = c("Frame", {Parent = Frame2, Name = "Head", AnchorPoint = vector2New(0.5, 0), Position = uDim2FromScale(0.5, 0), Size = uDim2New(1, 0, 0, 1), BackgroundTransparency = 1, ZIndex = 3})
				arg3 = tbl2.head
			else
				arg3 = Frame2
			end

			if not (ratio) then
				tbl2.m = c("Frame", {Parent = arg3, Name = "Main", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(1, 0.85), BackgroundColor3 = G, BackgroundTransparency = 0.5, ZIndex = 3, st(0.05)})
				tbl2.lb = l({Parent = tbl2.m, Name = "Label", AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale(0.025, 0.5), Size = uDim2FromScale(0.65, 0.64), Text = arg2, TextWrapped = true, TextXAlignment = left, ZIndex = 5})
			end

			tbl2.h = Frame
			tbl2.r = Frame2

			tbl2.fit = function()
				local x = arg.b.AbsoluteSize.X
				x = if x <= 0 then arg.t.page.AbsoluteSize.X else x
				if x <= 0 then
					return
				end

				if tbl2.dd then
					return tbl2.dd()
				end

				if not (tbl2.ratio) then
					return
				end
				Frame2.Size = uDim2New(n7, 0, 0, math.max(1, math.floor(((((x * n7) / n5) / tbl2.ratio) * (tbl2.lines or 1)) + 0.5)))
			end

			trackConnection(Frame2:GetPropertyChangedSignal("AbsoluteSize"), function()
				if tbl2.shown ~= false then
					if not (tbl2.ht) then
						Frame.Size = uDim2New(tbl2.hw, 0, 0, Frame2.AbsoluteSize.Y)
					end
				end
			end)

			tbl2.apply = function(arg5)
				local hide = tbl2.hide
				local size, size2 = not hide

				if hide then
					size2 = size
				else
					local when = tbl2.when
					local flag = not when

					if when then
						local wf, wf2 = tbl2.wf and tbl2.wf(tbl2.when.Value)

						if wf then
							wf2 = wf
						else
							local wf3 = tbl2.wf
							wf2 = if wf3 then not wf3 else tbl2.when.Value == true
						end

						size2 = wf2 and (tbl2.when.row.shown ~= false)
					else
						size2 = flag
					end
				end

				if tbl2.q ~= nil then
					tbl2.qv = size2
					Frame.Visible = tbl2.q and size2
					return
				end

				if tbl2.shown == size2 then
					return
				end
				tbl2.shown = size2

				if not (size2) then
					if tbl2.close then
						tbl2.close()
					end
				end

				if tbl2.ht then
					tbl2.ht:Cancel()
					tbl2.ht = nil
				end

				size = uDim2New(tbl2.hw, 0, 0, (size2 and Frame2.AbsoluteSize.Y) or 0)

				if size2 then
					Frame.Visible = true
				end

				if arg5 == false then
					Frame.Size = size
					Frame.Visible = size2
				else
					local v = tw(Frame, {Size = size}, 0.28, quint)
					tbl2.ht = v

					local function fn8()
						if tbl2.ht == v then
							tbl2.ht = nil
							Frame.Visible = tbl2.shown

							if tbl2.shown then
								Frame.Size = uDim2New(tbl2.hw, 0, 0, Frame2.AbsoluteSize.Y)
							end
						end
					end

					v.Completed:Connect(fn8)
				end

				if tbl2.o and tbl2.o.kids then
					for _, kid in ipairs(tbl2.o.kids) do
						kid.apply(arg5)
					end
				end
			end

			arg.rows[#arg.rows + 1] = tbl2
			task.defer(tbl2.fit)
			return tbl2
		end

		widgetSpecs.Reg = function(section, row, o2, type_)
			local w3 = section.W
			o2.Name, o2.Type, o2.row, o2.Tab, o2.Sec = row.name, type_, row, section.t.Name, section.Name
			o2.Section = section
			o2.Path = section.t.Name .. (" > " .. (section.Name .. (" > " .. row.name)))
			o2.ls = o2.ls or {}
			row.o = o2

			if not (section.noReg) then
				w3.Opts[#w3.Opts + 1] = o2
				w3.ByPath[o2.Path] = o2
			end

			local set = o2.Set

			o2.Set = function(arg, arg2, arg3)
				set(arg, arg2, arg3)

				for _, v in ipairs(arg.ls) do
					K(v, arg.Value)
				end

				if arg.kids then
					for _, kid in ipairs(arg.kids) do
						kid.apply()
					end
				end

				if not (arg.Skip) then
					if not (w3.busy) then
						w3:Dirty()
					end
				end

				if w3.qRefresh then
					w3.qRefresh(arg)
				end
			end

			o2.Visible = function(_, arg)
				row.hide = not arg
				row.apply()
			end

			o2.When = function(arg, when, wf)
				row.when = when
				row.wf = wf
				when.kids = when.kids or {}
				table.insert(when.kids, row)

				if not (row.sub) then
					row.hw = 0.96
					row.h.Size = uDim2New(0.96, 0, 0, row.h.Size.Y.Offset)
				end

				row.apply(false)
				return arg
			end

			o2.Note = function(_, arg)
				if row.setNote then
					row.setNote(arg)
				elseif row.nt then
					row.nt.Text = tostring(arg or "")
				end
			end

			o2.Title = function(arg, arg2)
				row.lb.Text = tostring(arg2)
				arg.Disp = tostring(arg2)
			end

			if o2.Def == nil then
				o2.Def = ((type(o2.Value) == "table") and table.clone(o2.Value)) or o2.Value
			end

			row.apply(false)
			return o2
		end

		widgetSpecs.Toggle = function(arg, arg2, arg3, arg4, arg5, arg6)
			local v = arg:Row(arg2, arg6)
			fn7(v, (arg5 and 0.62) or 0.72, arg5 ~= nil)

			if arg5 then
				fn6(v, 0.799)
				v.nt.Text, v.nt.Visible = tostring(arg5), true
			end

			local v2, v3 = fn2(v.m, 0.5, 0.915, 0.142, (arg5 and 0.5625) or 0.75, 3)
			local control = {}
			control.Value = arg3 == true

			control.Set = function(arg7, value, arg8)
				value = value == true
				arg7 = value ~= control.Value
				control.Value = value
				v3(value)

				if arg8 then
				elseif arg7 then
					K(arg4, value)
				elseif arg8 == false then
					K(arg4, value)
				end
			end

			hit(c("TextButton", {Parent = v2, Name = "Button", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(1, 1), ZIndex = 99}), function()
				control:Set(not control.Value)
			end)

			v3(control.Value, false)
			v.ctl = v2
			arg:Reg(v, control, "toggle")

			if control.Value then
				K(arg4, true)
			end

			return control
		end

		local function fn8(arg)
			arg = tonumber(arg)
			if not (arg) then
				return 0
			end

			for i = 0, 6, 1 do
				local n10 = 10 ^ i
				if math.abs((arg * n10) - math.round(arg * n10)) < 1e-06 then
					return i
				end
			end

			return 6
		end

		widgetSpecs.Slider = function(arg, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
			local flag, arg72 = arg7 == "log"

			if flag then
				arg8, arg7 = 0.01, nil
				arg3, arg4, arg72 = 0, n2, arg7
			else
				arg72 = arg7
			end

			local v = arg:Row(arg2, arg10)
			local n10 = math.max(fn8(arg8), fn8(arg3), fn8(arg4), fn8(arg5))
			local flag2 = flag or (n10 > 0)
			local flag22 = (flag2 and math.clamp(math.max(1, n10), 1, 6)) or 0

			local function roundValue(arg11)
				arg11 = tonumber(arg11) or 0
				if not (flag2) then
					return math.round(arg11)
				end
				local n11 = 10 ^ flag22
				return math.round(arg11 * n11) / n11
			end

			arg3, arg4 = roundValue(arg3), roundValue(arg4)
			local flag23 = (flag2 and math.max(10 ^ (-flag22), roundValue(math.abs(tonumber(arg8) or (10 ^ (-flag22)))))) or math.max(1, math.round(math.abs(tonumber(arg8) or 1)))
			arg10 = v.m
			v.nt = fn6(v, 0.48)
			local TextBox = c("TextBox", {Parent = arg10, Name = "Value", AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale(0.525, 0.5), Size = uDim2FromScale(0.095, 0.56), BackgroundColor3 = G, BackgroundTransparency = 0.6, ZIndex = 5, c("UIPadding", {Name = "ValuePadding"})})
			n(TextBox)
			st(0.1).Parent = TextBox
			local Frame = c("Frame", {Parent = arg10, Name = "Slider", Active = true, AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.8075, 0.5), Size = uDim2FromScale(0.345, 0.45), BackgroundColor3 = G, BackgroundTransparency = 0.6, ZIndex = 3, st(0.1)})
			local Frame2 = c("Frame", {Parent = Frame, Name = "Bar", Active = true, AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale(0, 0.5), Size = uDim2FromScale(0.5, 1), BackgroundColor3 = o, ZIndex = 4, getUIGradient(C, "AccentGradient")})
			local Frame3, control = c("Frame", {Parent = Frame, Name = "Hold", Active = true, AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(0.115, 1.2), BackgroundColor3 = color3FromRGB(89, 89, 89), BackgroundTransparency = 1, ZIndex = 5, st(0.09, color3FromRGB(39, 39, 39)), c("Frame", {Name = "Color", AnchorPoint = vector2New(0.5, 0), Position = uDim2FromScale(0.5, 0), Size = uDim2FromScale(1, 1), BackgroundColor3 = o, ZIndex = 6})}), {Value = arg3, Unit = arg72, Min = arg3, Max = arg4}
			local str = tostring(arg9 or "")

			local function roundValue2(arg11)
				if flag then
					return formatRate(arg11)
				end
				return (flag2 and string.format("%." .. (flag22 .. "f"), arg11)) or tostring(math.round(arg11))
			end

			local function fn9(arg11)
				local n11, flag3 = #tostring(arg11):gsub("<.->", ""), arg72 ~= nil
				arg11 = math.clamp(((flag3 and 0.125) or 0.095) + (math.max(0, n11 - ((flag3 and 7) or 5)) * 0.0095), (flag3 and 0.125) or 0.095, (flag3 and 0.195) or 0.175)
				local n12, visible = 0.62 - arg11, str ~= ""
				n11 = (visible and 0.75) or 1
				TextBox.Position, TextBox.Size, Frame.Size = uDim2FromScale(n12, 0.5), uDim2FromScale(arg11, 0.56 * n11), uDim2FromScale(0.345, 0.45 * n11)
				fn7(v, math.min((flag3 and 0.43) or 0.45, math.max(0.28, n12 - 0.045)), visible)
				local nt, nt2, nt3, v2, v3 = v.nt, v.nt, v.nt, str, uDim2FromScale(math.max(0.2, n12 - 0.045), 0.3)
				nt.Text = v2
				nt2.Visible = visible
				nt3.Size = v3
			end

			local function fn10()
				local n11 = ((control.Max > control.Min) and ((control.Value - control.Min) / (control.Max - control.Min))) or 0
				n11 = math.clamp(n11, 0.0575, 0.9425)
				Frame2.Size, Frame3.Position = uDim2FromScale(n11, 1), uDim2FromScale(n11, 0.5)
				if TextBox:IsFocused() then
					return
				end
				local text = colorizeText(o, roundValue2(control.Value)) .. ((arg72 and colorizeText(w, arg72)) or "")
				TextBox.RichText = true
				TextBox.Text = text
				fn9(text)
			end

			v.setNote = function(arg11)
				str = tostring(arg11 or "")
				fn9(TextBox.Text)
				v.fit()
			end

			control.Set = function(arg11, value, arg12)
				value = math.clamp(tonumber(value) or control.Value, control.Min, control.Max)
				value = if value > control.Min then if value < control.Max then math.clamp(roundValue(control.Min + (math.floor(((value - control.Min) / flag23) + 0.5) * flag23)), control.Min, control.Max) else value else value
				arg11 = value ~= control.Value
				control.Value = value
				fn10()

				if arg12 then
				elseif arg11 then
					K(arg6, (flag and clampValue(value)) or value)
				end
			end

			control.Range = function(_, arg11, arg12)
				control.Min, control.Max = roundValue(arg11), roundValue(arg12)
				control:Set(control.Value, true)
			end

			control.Real = function(arg11)
				return (flag and clampValue(control.Value)) or control.Value
			end

			control.Places = function(arg11)
				return flag2, flag22
			end

			local flag3, input

			local function fn11(arg11)
				control:Set(control.Min + ((control.Max - control.Min) * math.clamp((arg11 - Frame.AbsolutePosition.X) / math.max(Frame.AbsoluteSize.X, 1), 0, 1)))
			end

			local function fn12(input2)
				if flag3 then
					return
				elseif input2.UserInputState ~= scrollingFrame.UserInputState.Begin then
					return
				elseif not (F(input2)) then
					return
				end

				local input3
				input3, flag3 = ((input2.UserInputType == scrollingFrame.UserInputType.Touch) and input2) or nil, true
				input = input3
				fn11(input2.Position.X)
			end

			arg2 = {Frame, Frame2, Frame3}

			for _, v2 in ipairs(arg2) do
				trackConnection(v2.InputBegan, fn12)
			end

			trackConnection(UserInputService.InputChanged, function(input2)
				local input3 = flag3 and ((input and (input2 == input)) or (if input then not input else input2.UserInputType == scrollingFrame.UserInputType.MouseMovement))

				if input3 then
					fn11(input2.Position.X)
				end
			end)

			trackConnection(UserInputService.InputEnded, function(input2)
				if input2.UserInputType == scrollingFrame.UserInputType.MouseButton1 then
					flag3, input = false, nil
				elseif input2 == input then
					flag3, input = false, nil
				end
			end)

			trackConnection(TextBox.Focused, function()
				tw(TextBox, {BackgroundTransparency = 0.42}, 0.16)
				TextBox.RichText, TextBox.Text = false, (flag and formatCompact(control.Value)) or roundValue2(control.Value)
				fn9(TextBox.Text)

				task.defer(function()
					if TextBox:IsFocused() then
						TextBox.SelectionStart, TextBox.CursorPosition = 1, #TextBox.Text + 1
					end
				end)
			end)

			trackConnection(TextBox:GetPropertyChangedSignal("Text"), function()
				if TextBox:IsFocused() then
					fn9(TextBox.Text)
				end
			end)

			trackConnection(TextBox.FocusLost, function()
				tw(TextBox, {BackgroundTransparency = 0.6}, 0.16)
				local num = (flag and fn4(TextBox.Text)) or tonumber((TextBox.Text:gsub(",", "."):gsub("[^%d%.%-]", "")))

				if num then
					control:Set(num)
				end

				fn10()
			end)

			control.Value = math.clamp(tonumber(arg5) or arg3, arg3, arg4)
			fn10()
			v.ctl = TextBox
			v.vb = TextBox
			v.tr = Frame
			arg:Reg(v, control, "slider")
			return control
		end

		widgetSpecs.Dropdown = function(arg, arg2, arg3, arg4, arg5, arg6, arg7, value, arg8)
			local w3 = arg.W
			local v = arg:Row(arg2, value, true)
			local TextButton = c("TextButton", {Parent = v.m, Name = "Dropdown", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.845, 0.5), Size = uDim2FromScale(0.28, 0.62), BackgroundColor3 = G, BackgroundTransparency = 0.6, ZIndex = 6, st(0.1)})
			fb(TextButton, 1.025, 0.975)
			fn6(v, 0.66)
			local text = tostring(arg7 or "")

			local function fn9()
				local visible = text ~= ""
				v.nt.Text, v.nt.Visible = text, visible
				fn7(v, 0.65, visible)
				TextButton.Size = uDim2FromScale(0.28, (visible and 0.465) or 0.62)
			end

			fn9()
			local v2 = l({Parent = TextButton, Name = "Value", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.405, 0.5), Size = uDim2FromScale(0.7, 0.58), TextWrapped = true, ZIndex = 7})
			c("Frame", {Parent = TextButton, Name = "Divider", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.8, 0.5), Size = uDim2FromScale(0.014, 0.66), BackgroundColor3 = G, BackgroundTransparency = 0.3, ZIndex = 7})
			local v3 = chev(TextButton, w, uDim2FromScale(0.888, 0.5), uDim2FromScale(0.16, 0.56), 7)
			local Frame, control, flag, tbl2, str, Frame2, v4, v5, v6, v7, tbl3 = c("Frame", {Parent = v.r, Name = "Menu", AnchorPoint = vector2New(0.5, 0), Position = uDim2New(0.5, 0, 0, 0), Size = uDim2New(1, 0, 0, 0), BackgroundTransparency = 1, ClipsDescendants = true, Visible = false, ZIndex = 6}), {Multi = arg6, Options = arg3, Empty = "None"}, false, {}, ""
			local n10, n11, n12, n13 = 0, 0, 0, 0

			local function fn10()
				local options, iMap = ((type(control.Options) == "function") and control.Options()) or control.Options, {}

				for i, v8 in ipairs(((type(options) == "table") and options) or {}) do
					iMap[i] = ((type(v8) == "table") and tostring(v8.v or v8[1])) or tostring(v8)
				end

				return iMap
			end

			local function fn11(arg9)
				if arg6 then
					return table.find(control.Value, arg9) ~= nil
				end
				return control.Value == arg9
			end

			local function getArg6()
				return (arg6 and #control.Value) or (((control.Value ~= nil) and 1) or 0)
			end

			local function fn12(arg9)
				if arg6 then
					local n14 = #control.Value
					v2.Text = (((n14 == 0) and control.Empty) or ((n14 == 1) and tostring(control.Value[1]))) or (n14 .. " selected")
				else
					v2.Text = tostring(control.Value or "")
				end

				local tbl22 = tbl2

				for _, v8 in next, tbl22, nil do
					v8.paint(arg9)
				end

				if v6 then
					arg9 = getArg6()
					v7.Text = ((arg6 and (arg9 > 0)) and (arg8[2] .. (" (" .. (arg9 .. ")")))) or arg8[2]
					tbl22 = ((arg9 > 0) and 0) or 0.45
					v7.TextTransparency = tbl22
					v7:FindFirstChildOfClass("UIStroke").Transparency = tbl22

					for _, v8 in ipairs(tbl3) do
						v8.BackgroundTransparency = tbl22
					end
				end
			end

			local function fn13()
				local ks, v8, v9 = {}, ipairs, table.pack(fn10())

				for k, v10 in v8(table.unpack(v9, 1, v9.n)) do
					k = tbl2[v10]

					if k then
						k.b.Visible = (str == "") or (v10:lower():find(str, 1, true) ~= nil)

						if k.b.Visible then
							ks[#ks + 1] = k
						end
					end
				end

				if control.empty then
					control.empty.Visible = #ks == 0
				end

				return ks
			end

			local function fn14(arg9)
				local n102 = n10
				local v8, size, r2, visible = uDim2New(1, 0, 0, n102 + ((flag and (n12 + n11)) or 0)), n13 * 2, flag

				if r2 then
					n102 = n11
					visible = n102 + (n13 * 2)
				else
					visible = r2
				end

				n102 = uDim2New(1, size, 0, visible or 0)

				if v.rt then
					v.rt:Cancel()
					v.mt:Cancel()
				end

				if flag then
					Frame.Visible = true
				end

				if arg9 then
					v.rt, v.mt = tw(v.r, {Size = uDim2New(n7, 0, 0, v8.Y.Offset)}, 0.26, quint), tw(Frame, {Size = n102}, 0.26, quint)

					if not (flag) then
						v.mt.Completed:Connect(function(playbackState)
							if playbackState == scrollingFrame.PlaybackState.Completed then
								if not (flag) then
									Frame.Visible = false
								end
							end
						end)
					end
				else
					r2, size, visible = v.r, uDim2New(n7, 0, 0, v8.Y.Offset), flag
					r2.Size = size
					Frame.Size = n102
					Frame.Visible = visible
				end
			end

			local function fn15(arg9)
				local x = v.r.AbsoluteSize.X
				if x <= 0 then
					return
				end
				local n14 = x / n5
				local n15 = n14 / 10
				n10 = ((text ~= "") and (n14 / 7.5)) or n15
				n14 = n15 * 0.62
				local n16, n17 = n14 * 0.12, n15 * 0.15
				n13, n12 = n16, n17
				v.head.Size = uDim2New(1, 0, 0, n10)
				n15 = n10
				Frame.Position = uDim2New(0.5, 0, 0, ((n15 - (n10 * 0.075)) + n12) - n13)

				if flag then
				elseif arg9 then
				else
					return fn14(false)
				end

				n15 = tbl2

				for _, v8 in next, n15, nil do
					v8.aw = n14 * 0.17
				end

				n16, n17 = 0, 0

				if v5 then
					n16 = (n14 * 0.8) + n12
					v5.Position, v5.Size = uDim2FromOffset(n13, n13), uDim2FromOffset(x, n14 * 0.8)
				else
				end

				if Frame2 then
					n17 = n14 + n12
					local Frame3, Frame4, v8, v9 = Frame2, Frame2, uDim2FromOffset(n13, n13 + n16), uDim2FromOffset(x, n14)
					Frame3.Position = v8
					Frame4.Size = v9
				else
				end

				local n18, v8 = (n13 + n16) + n17, fn13()

				if #v8 == 0 then
					if control.empty then
						control.empty.Position, control.empty.Size = uDim2FromOffset(n13, n18), uDim2FromOffset(x, n14)
					end

					n11 = (n16 + n17) + n14
				else
					n15 = math.clamp(math.min(4, math.floor((x + n12) / ((n14 * 2.2) + n12))), 1, #v8)
					local v9, n19 = math.ceil(#v8 / n15), (x - ((n15 - 1) * n12)) / n15
					n11 = ((n16 + n17) + (v9 * n14)) + (math.max(v9 - 1, 0) * n12)

					for i, v10 in ipairs(v8) do
						local n20, n21 = (i - 1) // n15, (i - 1) % n15
						local n22, b2, b3, n162 = math.min(n15, #v8 - (n20 * n15)), v10.b, v10.b, n13
						v10, v9 = uDim2FromOffset((n162 + ((x - ((n22 * n19) + ((n22 - 1) * n12))) / 2)) + (n21 * (n19 + n12)), n18 + (n20 * (n14 + n12))), uDim2FromOffset(n19, n14)
						b2.Position = v10
						b3.Size = v9
					end
				end

				if v6 then
					n15 = n13
					v6.Position, v6.Size = uDim2FromOffset(n15 + (x / 2), ((n13 + n11) + n12) + (n14 / 2)), uDim2FromOffset(math.min(x, math.max(n14 * 3.6, x * 0.42)), n14)
					n18 = n11
					n11 = n18 + (n12 + n14)
				end

				fn12(false)
				fn14(arg9)
			end

			v.dd = function()
				fn15(false)
			end

			local n14 = 0

			trackConnection(v.r:GetPropertyChangedSignal("AbsoluteSize"), function()
				local x = v.r.AbsoluteSize.X

				if math.abs(x - n14) >= 0.5 then
					n14 = x
					fn15(false)
				end
			end)

			local function fn16()
				local tbl22 = tbl2

				for _, v8 in next, tbl22, nil do
					v8.b:Destroy()
				end

				tbl2 = {}
				tbl22 = fn10()

				if #tbl22 >= 5 then
					if not (Frame2) then
						Frame2 = c("Frame", {Parent = Frame, Name = "Search", BackgroundColor3 = G, BackgroundTransparency = 0.6, ZIndex = 7, st(0.07)})
						v4 = n(c("TextBox", {Parent = Frame2, Name = "Input", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(0.94, 0.56), PlaceholderText = "Search...", PlaceholderColor3 = color3FromRGB(198, 198, 198), ZIndex = 9}))

						trackConnection(v4:GetPropertyChangedSignal("Text"), function()
							str = (v4.Text:match("^%s*(.-)%s*$") or ""):lower()
							fn15(true)
						end)
					end
				end

				if not (control.empty) then
					control.empty = l({Parent = Frame, Name = "Empty", Text = "No match", TextTransparency = 0.4, Visible = false, ZIndex = 9})
				end

				for i, v8 in ipairs(tbl22) do
					local TextButton2 = c("TextButton", {Parent = Frame, Name = "Option" .. i, LayoutOrder = i, BackgroundColor3 = G, BackgroundTransparency = 0.45, ZIndex = 7, st(0.07)})
					local tbl4, flag2, Frame3, Frame4 = {b = TextButton2, aw = 0}, false

					if arg6 then
						Frame4 = c("Frame", {Parent = c("Frame", {Parent = TextButton2, Name = "Tick", AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale(0.055, 0.5), Size = uDim2FromScale(0.16, 0.44), BackgroundColor3 = G, BackgroundTransparency = 0.3, ZIndex = 8, st(0.12), getUIAspectRatioConstraint(1, true)}), Name = "Fill", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(0, 0), BackgroundColor3 = o, ZIndex = 9, getUIGradient(C, "AccentGradient")})
					else
						Frame3 = c("Frame", {Parent = TextButton2, Name = "Accent", AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale(0, 0.5), Size = uDim2FromScale(0, 1), BackgroundColor3 = o, ZIndex = 8, getUIGradient(C, "AccentGradient")})
					end

					local v9 = l({Parent = TextButton2, Name = "Label", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale((arg6 and 0.56) or 0.5, 0.5), Size = uDim2FromScale((arg6 and 0.62) or 0.78, 0.56), Text = v8, TextWrapped = true, ZIndex = 9})

					tbl4.paint = function(arg9)
						local v10, tbl5 = fn11(v8), {}
						local v102 = (v10 and 0.2) or ((flag2 and 0.3) or 0.45)
						tbl5.BackgroundTransparency = v102

						if arg9 then
							tw(TextButton2, tbl5, 0.12)

							if Frame3 then
								tw(Frame3, {Size = uDim2New(0, (v10 and tbl4.aw) or 0, 1, 0)}, 0.12)
							end

							if Frame4 then
								tw(Frame4, {Size = uDim2FromScale((v10 and 0.85) or 0, (v10 and 0.85) or 0)}, 0.12)
							end
						else
							TextButton2.BackgroundTransparency = tbl5.BackgroundTransparency

							if Frame3 then
								Frame3.Size = uDim2New(0, (v10 and tbl4.aw) or 0, 1, 0)
							end

							if Frame4 then
								Frame4.Size = uDim2FromScale((v10 and 0.85) or 0, (v10 and 0.85) or 0)
							end
						end

						v9.TextTransparency = (v10 and 0) or 0.15
					end

					trackConnection(TextButton2.MouseEnter, function()
						flag2 = true
						tbl4.paint(true)
					end)

					trackConnection(TextButton2.MouseLeave, function()
						flag2 = false
						tbl4.paint(true)
					end)

					hit(TextButton2, function()
						if arg6 then
							local v10 = table.clone(control.Value)
							local pos = table.find(v10, v8)

							if pos then
								table.remove(v10, pos)
							else
								v10[#v10 + 1] = v8
							end

							if arg8 then
								control.Value = v10
								fn12(true)
							else
								control:Set(v10)
							end
						elseif arg8 then
							control.Value = v8
							fn12(true)
						else
							control:Set(v8)
							w3.closeDD()
						end
					end)

					tbl2[v8] = tbl4
				end
			end

			if arg8 then
				v5 = l({Parent = Frame, Name = "Hint", Text = arg8[1], TextWrapped = true, TextTransparency = 0.28, ZIndex = 9})
				arg3, arg2, value = nil
				v6, arg3, v7, arg2, value = rb({Parent = Frame, Name = "Apply", AnchorPoint = vector2New(0.5, 0.5), Size = uDim2FromOffset(0, 0), ZIndex = 9, full = true, Text = arg8[2], LSize = uDim2FromScale(0.88, 0.56), wrap = true, h = 1.03})
				tbl3 = {arg2, value}

				hit(v6, function()
					if getArg6() == 0 then
						if arg6 then
							return
						end
					end

					w3.closeDD()
					K(arg5, control.Value)
				end)
			else
			end

			local function fn17(arg9)
				if flag == arg9 then
					return
				end

				if arg9 then
					if w3.closeDD then
						w3.closeDD()
					end

					fn16()
					str = ""

					if v4 then
						v4.Text = ""
					end

					function w3.closeDD()
						fn17(false)
					end
				else
					if v4 then
						v4:ReleaseFocus()
					end

					w3.closeDD = nil
				end

				flag = arg9
				tw(v3, {Rotation = (arg9 and 180) or 0}, 0.22)
				tw(TextButton, {BackgroundTransparency = (arg9 and 0.42) or 0.6}, 0.16)
				fn15(true)
			end

			v.close = function()
				fn17(false)
			end

			hit(TextButton, function()
				fn17(not flag)
			end)

			control.Set = function(arg9, arg10, arg11)
				arg9 = control.Value

				if arg6 then
					local ks, tbl4 = {}, {}

					for _, v8 in ipairs(fn10()) do
						tbl4[v8] = true
					end

					for k, v8 in next, (((type(arg10) == "table") and arg10) or ((arg10 ~= nil) and {arg10})) or {}, nil do
						local k2 = (((type(k) == "string") and (v8 == true)) and k) or tostring(v8)

						if tbl4[k2] or (type(control.Options) == "function") then
							if not (table.find(ks, k2)) then
								ks[#ks + 1] = k2
							end
						end
					end

					control.Value = ks
				else
					local v8, flag2 = fn10(), ((arg10 ~= nil) and tostring(arg10)) or nil
					control.Value = ((((flag2 and (table.find(v8, flag2) or (type(control.Options) == "function"))) and flag2) or control.Value) or control.Def) or v8[1]
				end

				fn12(false)

				if (if arg11 then not arg11 else not arg8) and ((arg6 and (enc(arg9) ~= enc(control.Value))) or (if arg6 then not arg6 else arg9 ~= control.Value)) then
					K(arg5, control.Value)
				end
			end

			control.Refresh = function(_, options, arg9)
				control.Options = options

				if flag then
					fn16()
					fn15(false)
				end

				if not (arg9) then
					control:Set(control.Value, true)
				end
			end

			v.setNote = function(arg9)
				text = tostring(arg9 or "")
				fn9()
				fn15(false)
			end

			if arg6 then
				value = {}

				for _, v8 in ipairs(((type(arg4) == "table") and arg4) or {}) do
					value[#value + 1] = tostring(v8)
				end

				control.Value = value
			else
				control.Value = ((arg4 ~= nil) and tostring(arg4)) or fn10()[1]
			end

			fn12(false)
			v.ctl = TextButton
			arg:Reg(v, control, (arg6 and "multidropdown") or "dropdown")
			return control
		end

		widgetSpecs.Input = function(arg, arg2, arg3, arg4, arg5, arg6)
			local v = arg:Row(arg2, arg6)
			local Frame = c("Frame", {Parent = v.m, Name = "Field", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.845, 0.5), Size = uDim2FromScale(0.28, 0.62), BackgroundColor3 = G, BackgroundTransparency = 0.6, ZIndex = 4, st(0.1)})
			local Frame2 = c("Frame", {Parent = Frame, Name = "Underline", AnchorPoint = vector2New(0.5, 1), Position = uDim2FromScale(0.5, 1), Size = uDim2FromScale(0, 0.11), BackgroundColor3 = o, ZIndex = 6})
			local v2 = n(c("TextBox", {Parent = Frame, Name = "Input", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(0.9, 0.56), PlaceholderText = arg3 or "Type...", PlaceholderColor3 = color3FromRGB(198, 198, 198), ZIndex = 5}))
			fn6(v, 0.66)

			v.setNote = function(arg7)
				local visible = tostring(arg7 or "") ~= ""
				v.nt.Text, v.nt.Visible = tostring(arg7 or ""), visible
				fn7(v, 0.65, visible)
				Frame.Size = uDim2FromScale(0.28, (visible and 0.465) or 0.62)
				v.fit()
			end

			v.setNote(arg5)
			local control = {Value = ""}

			control.Set = function(arg7, value, arg8)
				value = tostring(value or ""):match("^%s*(.-)%s*$")
				arg7 = value ~= control.Value
				control.Value = value
				v2.Text = value

				if arg8 then
				elseif arg7 then
					K(arg4, value)
				end
			end

			trackConnection(v2.Focused, function()
				tw(Frame, {BackgroundTransparency = 0.42}, 0.16)
				tw(Frame2, {Size = uDim2FromScale(1, 0.11)}, 0.2, quint)
			end)

			trackConnection(v2.FocusLost, function()
				tw(Frame, {BackgroundTransparency = 0.6}, 0.16)
				tw(Frame2, {Size = uDim2FromScale(0, 0.11)}, 0.2, quint)
				control:Set(v2.Text)
			end)

			v.ctl = Frame
			v.fd = Frame
			arg:Reg(v, control, "input")
			return control
		end

		widgetSpecs.Button = function(arg, arg2, arg3, arg4, arg5, arg6, arg7)
			local v, arg32 = arg:Row(arg2, arg7), arg3 or "Click"
			local arg62 = arg6 or "Clicked!"
			local v2, v3, v4 = rb({Parent = v.m, Name = "Action", Position = uDim2FromScale(0.8846889218690012, 0.5), Size = uDim2FromScale(0.20062215626239777, (arg5 and 0.51) or 0.68), ZIndex = 6, Text = arg32, LSize = uDim2FromScale(0.9, 0.62), wrap = true})

			if arg5 then
				fn7(v, 0.62, true)
				fn6(v, 0.7393778)
				v.nt.Text, v.nt.Visible = tostring(arg5), true
			end

			local tbl2, flag = {Skip = true, btn = v2}, false

			tbl2.Set = function(arg8)
			end

			tbl2.Press = function(arg8)
				local uiScale = v2:FindFirstChildOfClass("UIScale")
				tw(uiScale, {Scale = 0.96}, 0.055)

				task.delay(0.07, function()
					if uiScale.Parent then
						tw(uiScale, {Scale = 1}, 0.09)
					end
				end)

				if not (flag) then
					if arg62 ~= "" then
						flag = true
						v4.Text = arg62

						task.delay(0.9, function()
							v4.Text = arg32
							flag = false
						end)
					end
				end

				K(arg4)
			end

			tbl2.Text = function(_, text)
				arg32 = text
				v4.Text = text
			end

			hit(v2, function()
				tbl2:Press()
			end)

			v.ctl = v2
			arg:Reg(v, tbl2, "button")
			return tbl2
		end

		widgetSpecs.Text = function(arg, arg2, value, arg3)
			local v = arg:Row(arg2, arg3)
			v.lb.Size = uDim2FromScale(0.94, 0.64)
			fn6(v, 0.94)

			v.setNote = function(arg4)
				local visible = tostring(arg4 or "") ~= ""
				v.nt.Text, v.nt.Visible = tostring(arg4 or ""), visible
				fn7(v, 0.94, visible)
				v.fit()
			end

			local control = {}
			control.Value = value or arg2
			control.Skip = true

			control.Set = function(lines, value2)
				value2 = tostring(value2 or "")

				if value2 == control.Value then
					if v.lb.Text == value2 then
						return
					end
				end

				control.Value, v.lb.Text = value2, value2
				lines = select(2, value2:gsub("\n", "")) + 1

				if lines ~= (v.lines or 1) then
					v.lines = lines
					v.lb.Size = uDim2FromScale(0.94, ((lines > 1) and 0.9) or 0.64)
					v.fit()
				end
			end

			control:Set(control.Value)
			arg:Reg(v, control, "text")
			return control
		end

		widgetSpecs.Label = function(arg, arg2, arg3, arg4)
			return arg:Text(arg2, arg3 or arg2, arg4)
		end

		widgetSpecs.Stats = function(arg, arg2, arg3, arg4)
			local v, iEntryMap, iMap = arg:Text(arg2, "", arg4), {}, {}

			for i, v2 in ipairs(arg3) do
				iMap[i] = ((type(v2) == "table") and v2[1]) or v2
				iEntryMap[iMap[i]] = "--"
			end

			local tbl2 = {Skip = true}

			local function fn9()
				local parts = {}

				for _, v2 in ipairs(iMap) do
					parts[#parts + 1] = v2 .. (": " .. tostring(iEntryMap[v2]))
				end

				v:Set(table.concat(parts, "\n"))
			end

			tbl2.Set = function(_, arg5, arg6)
				if iEntryMap[arg5] ~= arg6 then
					iEntryMap[arg5] = arg6
					fn9()
				end
			end

			tbl2.Icon = function(arg5)
			end

			fn9()
			return tbl2
		end

		widgetSpecs.Canvas = function(arg, arg2, arg3)
			arg.n = arg.n + 1
			local Frame = c("Frame", {Parent = arg.b, Name = arg2, Size = uDim2New(n7, 0, 0, 40), BackgroundTransparency = 1, LayoutOrder = arg.n, ZIndex = 3})
			local tbl2 = {f = Frame, aspect = arg3}

			tbl2.Fit = function(_, h2)
				tbl2.h = h2
				Frame.Size = uDim2New(n7, 0, 0, h2)
			end

			if arg3 then
				trackConnection(Frame:GetPropertyChangedSignal("AbsoluteSize"), function()
					local x = Frame.AbsoluteSize.X

					if math.abs(x - (tbl2.w or 0)) > 0.5 then
						tbl2.w = x
						Frame.Size = uDim2New(n7, 0, 0, x / tbl2.aspect)

						if tbl2.onResize then
							K(tbl2.onResize, x, x / tbl2.aspect)
						end
					end
				end)
			end

			arg.rows[#arg.rows + 1] = {r = Frame, h = Frame, name = arg2, canvas = true}
			return tbl2
		end

		local widgetSpecs2 = {Toggle = {3, 5}, Slider = {5, 9}, Dropdown = {4, 7}, Input = {3, 5}, Button = {3, 6}, Text = {nil, 3}}

		for k in next, widgetSpecs2, nil do
			local widgetSpec = widgetSpecs[k]

			widgetSpecs[k] = function(arg, ...)
				local v = widgetSpec(arg, ...)
				v.mk, v.args = k, table.pack(...)
				return v
			end
		end

		widgetSpecs.Label = function(arg, arg2, arg3, arg4)
			local v = arg:Text(arg2, arg3 or arg2, arg4)
			v.Type = "label"
			return v
		end

		H, R = setmetatable, {__mode = "k"}
		local v = H({}, R)

		local function fn9(arg, arg2)
			if not (arg) then
				return
			end
			local tbl2 = v[arg]

			if tbl2 then
				if arg.Text ~= tbl2.p then
					v[arg] = nil
					tbl2 = nil
				else
				end
			else
			end

			if tbl2 then
			else
				if arg2 == "" then
					return
				elseif arg.RichText then
					return
				end

				tbl2 = {t = arg.Text}
				v[arg] = tbl2
			end

			local pos, v2

			if arg2 ~= "" then
				pos, v2 = tbl2.t:lower():find(arg2, 1, true)
			else
			end

			if not (pos) then
				arg.RichText, arg.Text = false, tbl2.t
				v[arg] = nil
				return
			end

			local function fn10(arg3)
				return (arg3:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
			end

			arg.RichText = true
			arg.Text = fn10(tbl2.t:sub(1, pos - 1)) .. ("<font color=\"rgb(58,255,55)\">" .. (fn10(tbl2.t:sub(pos, v2)) .. ("</font>" .. fn10(tbl2.t:sub(v2 + 1)))))
			tbl2.p = arg.Text
		end

		local function fn10(arg)
			local str = tostring(arg.Disp or arg.Name)

			if str:lower():sub(-4) == " tab" then
				return str
			elseif str:lower() == "tab" then
				return str
			end

			return str .. " Tab"
		end

		index.Search = function(arg, visible)
			local cur = arg.Cur
			if not (cur) then
				return
			end
			local str = (tostring(visible or ""):match("^%s*(.-)%s*$") or ""):lower()

			for i, section in ipairs(cur.Sections) do
				if not (section.res) then
					i = (str == "") or (section.Disp:lower():find(str, 1, true) ~= nil)
					visible = if section.extra then (section.extra(str) == true) or i else i
					fn9(section.hd, str)

					for i2, row in ipairs(section.rows) do
						i2 = row.o

						if i2 or row.canvas then
							local i3, i4 = (str == "") or i

							if i3 then
								i4 = i3
							else
								local v2, disp = tostring, i2 and (i2.Disp or i2.Name)
								i4 = v2(disp or row.name):lower():find(str, 1, true) ~= nil
							end

							if row.apply then
								if str == "" then
									if row.q ~= nil then
										row.q = nil
										row.shown = nil
										row.apply(false)
									end
								else
									if row.q == nil then
										row.qv = row.shown ~= false
									end

									row.q = i4
									row.h.Visible = i4 and row.qv
								end
							else
								row.h.Visible = i4
							end

							if row.lb then
								fn9(row.lb, str)
							end

							visible = if i4 then true else visible
						else
						end
					end

					if str == "" then
						section.f.Visible = true

						if section.pre ~= nil then
							section:Expand(section.pre, false)
							section.pre = nil
						end
					else
						if section.pre == nil then
							section.pre = section.open
						end

						section.f.Visible = visible

						if visible then
							if not (section.open) then
								section:Expand(true, false)
							end
						end
					end
				end
			end

			arg:Cross(cur, str)
			task.defer(cur.canvas)
		end

		index.Cross = function(arg, arg2, arg3)
			local res = arg2.res

			if arg3 == "" then
				if res then
					res.f.Visible = false
				end

				return
			end

			local list2, n10 = {}, 0

			for i, tab in ipairs(arg.Tabs) do
				if tab ~= arg2 then
					if tab.btn.Visible then
						i = n10

						for i2, section in ipairs(tab.Sections) do
							if section.res then
							else
								local os_, flag = {}, section.Disp:lower():find(arg3, 1, true) ~= nil

								for _, row in ipairs(section.rows) do
									i2 = row.o

									if i2 then
										if i2.mk then
											if i < 30 then
												if flag then
													os_[#os_ + 1] = i2
													i += 1
												else
													if tostring(i2.Disp or i2.Name):lower():find(arg3, 1, true) then
														os_[#os_ + 1] = i2
														i += 1
													else
													end
												end
											else
											end
										else
										end
									else
									end
								end

								if #os_ > 0 then
									list2[#list2 + 1] = {t = tab, s = section, l = os_}
								end
							end
						end

						n10 = i
					else
					end
				else
				end
			end

			if n10 == 0 then
				if res then
					res.f.Visible = false
				end

				return
			end

			if res then
			else
				res = arg2:Section("__ChilliSearchResults", true, "Other Tabs")
				res.res = true
				res.noReg = true
				res.hdr = {}
				res.mir = {}
				res.f.LayoutOrder = 1000000
				arg2.res = res
			end

			local arg2Map, pathMap, layoutOrder = {}, {}, 0

			for i, v2 in ipairs(list2) do
				arg2 = v2.t.Name .. ("\000" .. v2.s.Name)
				local headerEntry = res.hdr[arg2]

				if not headerEntry then
					i = res:Row("ResultGroup", nil, nil, 22)
					local r2 = i.r
					r2.BackgroundColor3 = G
					r2.BackgroundTransparency = 0.58
					local v3 = st(0.045, w, false, 0.62)
					v3.Parent = r2
					arg3 = l({Parent = r2, Name = "Label", AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale(0.025, 0.5), Size = uDim2FromScale(0.73, 0.8), TextTruncate = scrollingFrame.TextTruncate.AtEnd, TextXAlignment = left, ZIndex = 5})
					arg3.TextColor3 = w
					c("Frame", {Parent = r2, Name = "Line", AnchorPoint = vector2New(1, 0.5), Position = uDim2FromScale(0.79, 0.5), Size = uDim2FromScale(0.055, 0.08), BackgroundColor3 = o, BackgroundTransparency = 0.75, ZIndex = 4})
					l({Parent = r2, Name = "OpenHint", AnchorPoint = vector2New(1, 0.5), Position = uDim2FromScale(0.975, 0.5), Size = uDim2FromScale(0.16, 0.72), Text = "OPEN  >", TextXAlignment = right, ZIndex = 5}).TextColor3 = w
					local TextButton = c("TextButton", {Parent = r2, Name = "OpenTab", Size = uDim2FromScale(1, 1), ZIndex = 6})

					trackConnection(TextButton.MouseEnter, function()
						tw(r2, {BackgroundTransparency = 0.38}, 0.12)
						tw(v3, {Transparency = 0.22}, 0.12)
					end)

					trackConnection(TextButton.MouseLeave, function()
						tw(r2, {BackgroundTransparency = 0.58}, 0.12)
						tw(v3, {Transparency = 0.62}, 0.12)
					end)

					headerEntry = {x = i, lb = arg3}

					hit(TextButton, function()
						if headerEntry.go then
							arg:Goto(headerEntry.go)
						end
					end)

					res.hdr[arg2] = headerEntry
				else
				end

				layoutOrder += 1
				headerEntry.x.h.LayoutOrder, headerEntry.x.h.Visible, headerEntry.go = layoutOrder, true, v2.l[1]
				headerEntry.lb.Text = "GO TO  " .. (fn10(v2.t) .. ("  >  " .. v2.s.Disp))
				arg2Map[arg2] = true
				local v3, l2 = ipairs, v2.l

				for k, v4 in v3(l2) do
					local k2 = res.mir[v4.Path]

					if not k2 then
						local v5, widgetSpec, flag = table.pack(table.unpack(v4.args, 1, v4.args.n)), widgetSpecs2[v4.mk], false

						if widgetSpec[1] then
							v5[widgetSpec[1]] = ((v4.Type == "button") and (function()
								v4:Press()
							end)) or nil
						end

						v5[widgetSpec[2]] = nil
						v5[1] = v4.Disp or v4.Name
						v2, k = pcall(res[v4.mk], res, table.unpack(v5, 1, math.max(v5.n, widgetSpec[2])))

						if v2 and k then
							k2 = k
							k2.mirrorOf = v4
							k2.Skip = true

							if (v4.Type ~= "button") and (v4.Type ~= "text") then
								k2.ls[#k2.ls + 1] = function(arg4)
									if not (flag) then
										v4:Set(((type(arg4) == "table") and table.clone(arg4)) or arg4)
									end
								end

								v4.ls[#v4.ls + 1] = function(arg4)
									if k2.row.h.Parent then
										flag = true
										k2:Set(((type(arg4) == "table") and table.clone(arg4)) or arg4, true)
										flag = false
									end
								end

								flag = true
								k2:Set(((type(v4.Value) == "table") and table.clone(v4.Value)) or v4.Value, true)
								flag = false
							else
								if v4.Type == "text" then
									v4.ls[#v4.ls + 1] = function(arg4)
										k2:Set(arg4)
									end
								end
							end

							res.mir[v4.Path] = k2
						else
						end
					else
					end

					if k2 then
						layoutOrder += 1
						k2.row.h.LayoutOrder = layoutOrder
						k2.row.h.Visible = true
						pathMap[v4.Path] = true
					else
					end
				end
			end

			for k, v2 in next, res.hdr, nil do
				if not (arg2Map[k]) then
					v2.x.h.Visible = false
				end
			end

			for k, v2 in next, res.mir, nil do
				if not (pathMap[k]) then
					v2.row.h.Visible = false
				end
			end

			res.f.Visible = true

			if not (res.open) then
				res:Expand(true, false)
			end

			if arg.qChips then
				arg.qChips()
			end
		end

		index.Goto = function(arg, arg2)
			local section = arg2.Section
			local t = arg2.Section.t
			arg.nav = (arg.nav or 0) + 1
			local nav = arg.nav
			arg:Select(t)

			if not (section.open) then
				section:Expand(true)
			end

			task.spawn(function()
				if section.tw then
					pcall(function()
						section.tw.Completed:Wait()
					end)
				else
					RunService.Heartbeat:Wait()
				end

				RunService.Heartbeat:Wait()

				if nav ~= arg.nav then
					return
				elseif arg.Cur ~= t then
					return
				end

				t.canvas()
				RunService.Heartbeat:Wait()
				local page, h2 = t.page, arg2.row.h
				h2 = if h2.Visible then h2 else section.hd
				local canvasPosition = page.CanvasPosition
				local n10 = math.clamp(((h2.AbsolutePosition.Y - page.AbsolutePosition.Y) + canvasPosition.Y) - (page.AbsoluteSize.Y * 0.28), 0, math.max(0, page.AbsoluteCanvasSize.Y - page.AbsoluteSize.Y))
				local v2 = tw(page, {CanvasPosition = vector2New(canvasPosition.X, n10)}, 0.46, quint)

				pcall(function()
					v2.Completed:Wait()
				end)

				if nav ~= arg.nav then
					return
				elseif h2.Parent then
					if not (h2.Visible) then
						return
					end
				else
					return
				end

				canvasPosition = h2:FindFirstChild("ChilliSearchNavigationHighlight")

				if canvasPosition then
					canvasPosition:Destroy()
				end

				local v3 = st(0.065, w, false, 1)
				v3.Name = "ChilliSearchNavigationHighlight"
				v3.Parent = h2
				tw(v3, {Transparency = 0.04}, 0.16)

				task.delay(0.5, function()
					if v3.Parent then
						local v4, destroyAll = tw(v3, {Transparency = 1}, 0.28), function()
							v3:Destroy()
						end

						v4.Completed:Connect(destroyAll)
					end
				end)
			end)
		end

		local flag, Frame = true
		local list2, n10 = {}, 0

		Z.Notify = function(arg, arg2, arg3)
			Z.q(function()
				Z.notify(arg, arg2, arg3)
			end)
		end

		local function fn11(arg, arg2)
			if arg.d then
				return
			end
			arg.d = true
			local pos = table.find(list2, arg)

			if pos then
				table.remove(list2, pos)
			end

			if arg.t then
				pcall(task.cancel, arg.t)
			end

			if arg2 then
				arg.slot:Destroy()
				return
			end
			tw(arg.card, {Position = uDim2FromScale(2.1, 0.5)}, 0.22, quint, scrollingFrame.EasingDirection.In)

			task.delay(0.08, function()
				if arg.slot.Parent then
					tw(arg.slot, {Size = uDim2FromScale(1, 0)}, 0.22, quint, scrollingFrame.EasingDirection.In)
				end
			end)

			task.delay(0.32, function()
				arg.slot:Destroy()
			end)
		end

		Z.notify = function(arg, arg2, arg3)
			local w3 = Z.W

			if flag then
				if w3 then
					if w3.gui then
						if not (w3.gui.Parent) then
							return
						end
					else
						return
					end
				else
					return
				end
			else
				return
			end

			if not (Frame and Frame.Parent) then
				Frame = c("Frame", {Parent = w3.gui, Name = "ChilliNotifyHolder", AnchorPoint = vector2New(1, 1), Position = uDim2FromScale(0.988, 0.975), Size = uDim2FromScale(0.163, 0.74), BackgroundTransparency = 1, ZIndex = 100, c("UIListLayout", {Name = "Layout", HorizontalAlignment = scrollingFrame.HorizontalAlignment.Right, VerticalAlignment = scrollingFrame.VerticalAlignment.Bottom, SortOrder = scrollingFrame.SortOrder.LayoutOrder, Padding = uDimNew(0.015, 0)})})
			end

			while #list2 >= 6 do
				fn11(list2[1], true)
			end

			n10 += 1
			arg3 = math.max(0, tonumber(arg3) or 3)
			w3 = c("Frame", {Parent = Frame, Name = "NotificationSlot", LayoutOrder = n10, Size = uDim2FromScale(1, 0), BackgroundTransparency = 1, ZIndex = 100})
			local Frame2 = c("Frame", {Parent = w3, Name = "ChilliNotify", AnchorPoint = vector2New(1, 0.5), Position = uDim2FromScale(2.1, 0.5), Size = uDim2FromScale(1, 1), BackgroundColor3 = G, BackgroundTransparency = 0.35, ClipsDescendants = true, ZIndex = 101, st(0.045), c("Frame", {Name = "Accent", Size = uDim2FromScale(0.026, 1), BackgroundColor3 = o, ZIndex = 102, getUIGradient(r, "RedGradient")})})
			l({Parent = Frame2, Name = "Title", Position = uDim2FromScale(0.07, 0.14), Size = uDim2FromScale(0.88, 0.28), Text = tostring(arg or "Notification"), TextXAlignment = left, ZIndex = 103}, true)
			l({Parent = Frame2, Name = "Body", Position = uDim2FromScale(0.07, 0.48), Size = uDim2FromScale(0.86, 0.3), Text = tostring(arg2 or ""), TextWrapped = true, TextXAlignment = left, TextYAlignment = scrollingFrame.TextYAlignment.Top, TextTransparency = 0.28, ZIndex = 103})
			local Frame3, tbl2 = c("Frame", {Parent = c("Frame", {Parent = Frame2, Name = "Track", AnchorPoint = vector2New(0.5, 1), Position = uDim2FromScale(0.5, 1), Size = uDim2FromScale(1, 0.055), BackgroundColor3 = G, BackgroundTransparency = 0.45, Visible = arg3 > 0, ZIndex = 102}), Name = "Fill", AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale(0, 0.5), Size = uDim2FromScale(1, 1), BackgroundColor3 = color3FromRGB(239, 28, 28), ZIndex = 103}), {slot = w3, card = Frame2}
			list2[#list2 + 1] = tbl2
			tw(w3, {Size = uDim2FromScale(1, 0.115)}, 0.3, quint)
			tw(Frame2, {Position = uDim2FromScale(1, 0.5)}, 0.3, quint)

			if arg3 > 0 then
				tw(Frame3, {Size = uDim2FromScale(0, 1)}, arg3, scrollingFrame.EasingStyle.Linear)

				tbl2.t = task.delay(arg3, function()
					tbl2.t = nil
					fn11(tbl2)
				end)
			end

			return Frame2
		end

		Z.NotifyOn = function(arg)
			flag = arg ~= false

			if not (flag) then
				for i = #list2, 1, -1 do
					fn11(list2[i], true)
				end
			end
		end

		index.State = function(arg, arg2, arg3)
			local t = arg.St[arg2]
			if t then
				return t
			end
			local control, v2 = {Name = arg2, Value = arg3, Def = arg3, ls = {}}, arg

			control.Set = function(_, value)
				control.Value = value
				v2:Dirty()

				for _, v3 in ipairs(control.ls) do
					K(v3, value)
				end
			end

			control.Get = function(arg4)
				return control.Value
			end

			arg.St[arg2] = control
			return control
		end

		local str = "Default"

		local function fn12(arg, t)
			return arg.dirP .. ("/configs/" .. (t .. ".json"))
		end

		index.Collect = function(arg)
			local tabMap, kMap = {}, {}

			for i, opt in ipairs(arg.Opts) do
				i = opt.NoSave
				local flag2, flag22 = not i

				if i then
					flag22 = flag2
				else
					local flag3 = (opt.Type == "text") or (opt.Type == "label")

					if flag3 then
						flag22 = flag3
					else
						local skip = opt.Skip
						flag22 = if skip then not skip else opt.Type ~= "button"
					end
				end

				if flag22 then
					tabMap[opt.Tab] = tabMap[opt.Tab] or {}
					tabMap[opt.Tab][opt.Sec] = tabMap[opt.Tab][opt.Sec] or {}
					tabMap[opt.Tab][opt.Sec][opt.Name] = {Type = opt.Type, Value = opt.Value, Unit = opt.Unit}
				end
			end

			for k, v2 in next, arg.St, nil do
				if v2.save ~= false then
					kMap[k] = {Value = v2.Value}
				end
			end

			return {Version = 2, Profile = arg.Active, SavedAt = os.time(), States = kMap, Values = tabMap}
		end

		index.Save = function(arg, t, arg2)
			if arg.ready then
			elseif arg2 then
			else
				return false
			end

			t = t or arg.Active
			local v2 = enc(arg2 or arg:Collect())
			if not (v2) then
				return false, "encode failed"
			end
			saveFile(fn12(arg, t), v2)
			saveFile(fn12(arg, t) .. ".bak", v2)
			return true
		end

		index.Dirty = function(arg)
			if arg.AutoSave then
				if arg.busy then
					return
				elseif not (arg.ready) then
					return
				end
			else
				return
			end

			arg.saveN = (arg.saveN or 0) + 1
			local saveN = arg.saveN

			task.delay(0.35, function()
				if arg.saveN == saveN then
					if arg.AutoSave then
						arg:Save()
					end
				end
			end)
		end

		local function fn13(t, arg, arg2)
			for k, v2 in next, t, nil do
				k = (type(v2) == "table") and v2[arg]

				if type(k) == "table" then
					if k[arg2] ~= nil then
						return k[arg2]
					end
				end
			end
		end

		index.Apply = function(t, arg)
			if type(arg) ~= "table" then
				return false
			end
			t.busy = true
			local values = ((type(arg.Values) == "table") and arg.Values) or {}

			if t.pre then
				K(t.pre, values)
			end

			for i, opt in ipairs(t.Opts) do
				if not (opt.Skip) then
					if opt.Type ~= "button" then
						if opt.Type ~= "text" then
							i = ((values[opt.Tab] and values[opt.Tab][opt.Sec]) and values[opt.Tab][opt.Sec][opt.Name]) or fn13(values, opt.Sec, opt.Name)
							local value = if type(i) == "table" then i.Value else nil
							value = if value == nil then ((type(opt.Def) == "table") and table.clone(opt.Def)) or opt.Def else value

							if value ~= nil then
								pcall(opt.Set, opt, value)
							end
						end
					end
				end
			end

			for k, v2 in next, ((type(arg.States) == "table") and arg.States) or {}, nil do
				values = t.St[k]

				if (values and (type(v2) == "table")) and (v2.Value ~= nil) then
					values.Value = v2.Value

					for _, v3 in ipairs(values.ls) do
						K(v3, v2.Value)
					end
				elseif type(v2) == "table" then
					t:State(k, v2.Value)
				end
			end

			t.busy = false

			if t.onLoad then
				K(t.onLoad)
			end

			return true
		end

		index.Find = function(arg, t)
			for _, v2 in ipairs(arg:List()) do
				if v2:lower() == tostring(t):lower() then
					return v2
				end
			end
		end

		index.Load = function(arg, t)
			local v2 = arg:Find(t)
			if not (v2) then
				return false, "Config does not exist: " .. tostring(t)
			end

			local function fn14(arg2)
				return (type(arg2) == "table") and ((type(arg2.Values) == "table") or (type(arg2.States) == "table"))
			end

			t = dec(readCachedFile(fn12(arg, v2)))

			if fn14(t) then
			else
				t = dec(readCachedFile(fn12(arg, v2) .. ".bak"))

				if fn14(t) then
					saveFile(fn12(arg, v2), enc(t) or "")
				end
			end

			if not (fn14(t)) then
				return false, "Config file is empty or invalid."
			end
			arg.Active = v2
			arg:Apply(t)

			if arg.AutoSave then
				if arg.ready then
					arg:Save()
				end
			end

			if arg.cfgNotes then
				arg.cfgNotes()
			end

			return true
		end

		index.List = function(arg)
			local t, list3, ok, result = {[str:lower()] = str}, {}, pcall(listfiles, arg.dirP .. "/configs")

			for _, v2 in ipairs((ok and result) or {}) do
				arg = tostring(v2):gsub("\\", "/"):match("([^/]+)%.json$")

				if arg then
					if arg ~= "" then
						t[arg:lower()] = arg
					end
				end
			end

			for k, v2 in next, t, nil do
				if k ~= str:lower() then
					list3[#list3 + 1] = v2
				end
			end

			table.sort(list3, function(arg2, arg3)
				return arg2:lower() < arg3:lower()
			end)

			table.insert(list3, 1, str)
			return list3
		end

		index.Mgr = function(arg, t)
			local str2 = arg.dirP .. "/config_state.json"
			if t then
				saveFile(str2, enc({Version = 2, AutoLoad = arg.AutoLoad, AutoSave = arg.AutoSave, StartupConfig = arg.Startup}) or "{}")
				return
			end
			local cachedFile, cachedFile2 = readCachedFile("ChilliLibrary/config_state.json"), readCachedFile(str2)

			if (if cachedFile2 then not cachedFile2 else cachedFile) and (cachedFile ~= "") then
				local ok, result = pcall(listfiles, "ChilliLibrary/configs")

				for i, v2 in ipairs((ok and result) or {}) do
					i = tostring(v2):gsub("\\", "/"):match("([^/]+)$")
					t = (i and (i:sub(-5) == ".json")) and readCachedFile(v2)

					if t then
						saveFile(arg.dirP .. ("/configs/" .. i), t)
					end
				end

				saveFile(str2, cachedFile)
			end

			cachedFile = dec(readCachedFile(str2)) or {}
			arg.AutoLoad, arg.AutoSave, arg.Startup = cachedFile.AutoLoad ~= false, cachedFile.AutoSave ~= false, tostring(cachedFile.StartupConfig or str)
			arg.Active = arg.Startup
		end

		index.Fire = function(_, arg)
			if arg.Type == "toggle" then
				arg:Set(not arg.Value)
			elseif arg.Type == "button" then
				arg:Press()
			end
		end

		index.Default = function(arg)
			arg.busy = true

			for _, opt in ipairs(arg.Opts) do
				if not (opt.Skip) then
					if opt.Def ~= nil then
						if opt.Tab ~= "Config" then
							pcall(opt.Set, opt, ((type(opt.Def) == "table") and table.clone(opt.Def)) or opt.Def)
						end
					end
				end
			end

			for _, v2 in next, arg.St, nil do
				if v2.Def ~= nil then
					if v2.reset ~= false then
						v2:Set(((type(v2.Def) == "table") and table.clone(v2.Def)) or v2.Def)
					end
				end
			end

			arg.busy = false
			arg:Dirty()
		end

		index.Float = function(arg)
			local v2 = arg
			local ScreenGui = c("ScreenGui", {Name = HttpService:GenerateGUID(false):gsub("-", ""):sub(1, 12), DisplayOrder = 59, IgnoreGuiInset = true, ResetOnSpawn = false, ZIndexBehavior = scrollingFrame.ZIndexBehavior.Sibling})
			ScreenGui:SetAttribute("ChilliRB", true)
			v2.fgui = ScreenGui
			local Frame2 = c("Frame", {Parent = ScreenGui, AnchorPoint = vector2New(0, 0.5), Position = uDim2New(0, 16, 0.3, 0), Size = uDim2FromOffset(56, 56), BackgroundTransparency = 1})
			local UIScale = c("UIScale", {Parent = Frame2})
			arg = c("ImageButton", {Parent = Frame2, AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(1, 1), BackgroundTransparency = 1, Image = "rbxassetid://128961717706452", ScaleType = scrollingFrame.ScaleType.Fit, c("UICorner", {CornerRadius = uDimNew(0.28, 0)})})
			local UIScale2 = c("UIScale", {Parent = arg})
			local tweenInfo = TweenInfo.new(0.08, scrollingFrame.EasingStyle.Quad, scrollingFrame.EasingDirection.Out)
			local tweenInfo2 = TweenInfo.new(0.14, scrollingFrame.EasingStyle.Back, scrollingFrame.EasingDirection.Out)

			local function clampValue2()
				local currentCamera = workspace.CurrentCamera
				local viewportSize = (currentCamera and currentCamera.ViewportSize) or vector2New(1280, 720)
				viewportSize = if viewportSize.X < 1 then vector2New(1280, 720) else viewportSize
				UIScale.Scale = math.clamp((viewportSize.X * 0.035) / 56, 0.7, 1.4)
			end

			clampValue2()

			if workspace.CurrentCamera then
				trackConnection(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), clampValue2)
			end

			local input, v3, position, flag2, flag3

			local function fn14(arg2, arg3)
				if input == "mouse" then
					return arg2.UserInputType == ((arg3 and scrollingFrame.UserInputType.MouseMovement) or scrollingFrame.UserInputType.MouseButton1)
				end
				arg3 = input
				return arg2 == arg3
			end

			trackConnection(arg.InputBegan, function(input2)
				if F(input2) then
					if input2.UserInputState ~= scrollingFrame.UserInputState.Begin then
						return
					elseif input then
						return
					end
				else
					return
				end

				local input3, v4, position2 = ((input2.UserInputType == scrollingFrame.UserInputType.Touch) and input2) or "mouse", vector2New(input2.Position.X, input2.Position.Y), Frame2.Position
				input, v3, position, flag2, flag3 = input3, v4, position2, false, false
				TweenService:Create(UIScale2, tweenInfo, {Scale = 0.9}):Play()
			end)

			trackConnection(UserInputService.InputChanged, function(input2)
				if input then
					if not (fn14(input2, true)) then
						return
					end
				else
					return
				end

				local n11 = vector2New(input2.Position.X, input2.Position.Y) - v3

				if not (flag2) then
					if n11.Magnitude < 8 then
						return
					end
					flag2, flag3 = true, true
					TweenService:Create(UIScale2, tweenInfo2, {Scale = 1}):Play()
				end

				local absoluteSize, absoluteSize2 = ScreenGui.AbsoluteSize, Frame2.AbsoluteSize
				local n12, n13 = (position.X.Offset + (position.X.Scale * absoluteSize.X)) + n11.X, (position.Y.Offset + (position.Y.Scale * absoluteSize.Y)) + n11.Y
				Frame2.Position = uDim2FromOffset(math.clamp(n12, 0, math.max(0, absoluteSize.X - absoluteSize2.X)), math.clamp(n13, absoluteSize2.Y * 0.5, math.max(absoluteSize2.Y * 0.5, absoluteSize.Y - (absoluteSize2.Y * 0.5))))
			end)

			trackConnection(UserInputService.InputEnded, function(input2)
				if input then
					if fn14(input2, false) then
						input, flag2 = nil, false
						TweenService:Create(UIScale2, tweenInfo2, {Scale = 1}):Play()
					end
				end
			end)

			trackConnection(arg.Activated, function()
				if flag3 then
					flag3 = false
					return
				end
				v2:Show(not v2.open)
			end)

			ScreenGui.Parent = v2.par
		end

		local labelMap, nameList = {Zero = "0", One = "1", Two = "2", Three = "3", Four = "4", Five = "5", Six = "6", Seven = "7", Eight = "8", Nine = "9", LeftControl = "LCtrl", RightControl = "RCtrl", LeftShift = "LShift", RightShift = "RShift", LeftAlt = "LAlt", RightAlt = "RAlt", Return = "Enter", Space = "Space", Backspace = "Back"}, {"Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"}

		for i, v2 in ipairs(nameList) do
			labelMap["Keypad" .. v2] = "Num" .. (i - 1)
		end

		local function getEntry(arg)
			return (arg and (labelMap[arg] or tostring(arg))) or nil
		end

		local enabledFlags, enabledFlags2 = {toggle = true, button = true, slider = true, input = true}, {toggle = true, button = true}

		local function getEnabledFlag(arg)
			return (enabledFlags[arg.Type] and (arg.Quick ~= false)) and not arg.mirrorOf
		end

		local function D(arg)
			return ((type(arg) == "table") and table.clone(arg)) or {}
		end

		index.Quick = function(setTab)
			local setTab2 = setTab
			local quickDefaults = setTab2.QuickDefaults or {}
			local v2 = setTab2:State("Quick Pinned Features", D(quickDefaults.pins))
			local v3 = setTab2:State("Quick Pin Groups", D(quickDefaults.groups))
			local v4 = setTab2:State("Quick Keybinds", D(quickDefaults.keys))
			local v5 = setTab2:State("Quick Panel Position", {})
			local v6 = setTab2:State("Quick Panel Collapsed", {})
			local v7 = setTab2:State("Quick Open Key", "LeftControl")
			setTab2:State("Quick LeftCenter Hidden", quickDefaults.hud == true)

			local function fn14()
				return ((type(v4.Value) == "table") and v4.Value) or {}
			end

			local function fn15()
				return ((type(v2.Value) == "table") and v2.Value) or {}
			end

			local function clampValue2(arg)
				return math.clamp(math.floor(tonumber((type(v3.Value) == "table") and v3.Value[arg]) or 1), 1, 5)
			end

			local function fn16(arg)
				return table.find(fn15(), arg) ~= nil
			end

			local ScreenGui = c("ScreenGui", {Name = HttpService:GenerateGUID(false):gsub("-", ""):sub(1, 12), ResetOnSpawn = false, IgnoreGuiInset = true, ZIndexBehavior = scrollingFrame.ZIndexBehavior.Sibling, DisplayOrder = 5, Enabled = false})
			ScreenGui:SetAttribute("ChilliRB", true)
			ScreenGui.Parent = setTab2.par
			setTab2.qgui = ScreenGui
			local a, iMap = ((touchEnabled and 150) or 120) / 100, {true, true, true, true, true}

			local function fn17(arg)
				local clamp, max, n11 = math.clamp, math.max, (0.078 * a) * 0.97
				return clamp(arg, 0, max(0, 0.998 - n11))
			end

			local function fn18(arg)
				local v8, n11 = ((touchEnabled and {0.023, 0.023, 0.42}) or {0.023, 0.303, 0.7})[arg], 0.078 * a

				if arg == 2 then
					if touchEnabled then
						return (((1 - (n11 * 0.97)) + (n11 * 0.03)) - (n11 * 0.1)) - (n11 * 0.97), v8
					end
				end

				if arg <= 3 then
					return 1, v8
				end

				if arg == 4 then
					return 0.11, 0.5
				end

				if touchEnabled then
					return ((0.11 + (n11 * 0.97)) + (n11 * 0.1)) - (n11 * 0.03), 0.5
				end
				return 0.11, 0.74
			end

			local function clampValue3(arg)
				local num, num2 = fn18(arg)
				local flag2 = (type(v5.Value) == "table") and v5.Value[tostring(arg)]

				if type(flag2) == "table" then
					num, num2 = tonumber(flag2.X or flag2[1]) or num, tonumber(flag2.Y or flag2[2]) or num2
				else
				end

				return fn17(num), math.clamp(num2, 0, 0.98)
			end

			local pathMap, iMap2 = {}, {}

			for i = 1, 5, 1 do
				local Frame2 = c("Frame", {Parent = ScreenGui, Name = "QuickBar" .. i, BackgroundTransparency = 1, Size = uDim2FromScale(0.078, 0.032), Visible = false, ZIndex = 2})
				local TextButton = c("TextButton", {Parent = Frame2, Name = "Handle", Active = true, AnchorPoint = vector2New(0.5, 0), Position = uDim2FromScale(0.5, 0), Size = uDim2FromScale(0.94, 1), BackgroundColor3 = G, BackgroundTransparency = 0.35, ZIndex = 3, st(0.06), c("Frame", {Name = "HeaderAccent", AnchorPoint = vector2New(0.5, 1), Position = uDim2FromScale(0.5, 1), Size = uDim2FromScale(1, 0.07), BackgroundColor3 = o, BackgroundTransparency = 0.08, ZIndex = 4})})
				l({Parent = TextButton, Name = "Title", AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale(0.07, 0.5), Size = uDim2FromScale(0.62, 0.55), Text = "Quick Bar " .. i, TextXAlignment = left, ZIndex = 4}, true)
				local Frame3 = c("Frame", {Parent = Frame2, Name = "Body", AnchorPoint = vector2New(0.5, 0), Position = uDim2FromScale(0.5, 1), Size = uDim2FromScale(1.32, 0), BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 2, c("UIPadding", {Name = "BodyPadding", PaddingLeft = uDimNew(0.03, 0), PaddingRight = uDimNew(0.03, 0)})})
				local UIListLayout, TextButton2 = c("UIListLayout", {Parent = Frame3, Name = "BodyLayout", HorizontalAlignment = center, SortOrder = scrollingFrame.SortOrder.LayoutOrder}), c("TextButton", {Parent = TextButton, Name = "Collapse", Active = true, AnchorPoint = vector2New(1, 0.5), Position = uDim2FromScale(0.955, 0.5), Size = uDim2FromScale(0.17, 0.6), ZIndex = 4})
				local A = chev(TextButton2, o, uDim2FromScale(0.5, 0.5), uDim2FromScale(0.85, 0.85), 4)
				local sectionView = {pn = Frame2, hd = TextButton, body = Frame3, bl = UIListLayout, car = A, items = {}, cons = {}, frac = 0}
				sectionView.col = (type(v6.Value) == "table") and (v6.Value[tostring(i)] == true)

				local function toggleCol()
					sectionView.col = not sectionView.col
					local v8 = D(v6.Value)
					v8[tostring(i)] = sectionView.col
					v6:Set(v8)

					if sectionView.tw then
						sectionView.tw:Cancel()
					end

					sectionView.tw = tw(Frame3, {Size = uDim2FromScale(1.32, (sectionView.col and 0) or sectionView.frac)}, 0.26, quint)
					tw(A, {Rotation = (sectionView.col and 180) or 0}, 0.26, quint)
				end

				hit(TextButton2, toggleCol)
				local flag2, input, v8, v9, flag3

				trackConnection(TextButton.InputBegan, function(input2)
					if flag2 then
						return
					elseif input2.UserInputState ~= scrollingFrame.UserInputState.Begin then
						return
					elseif not (F(input2)) then
						return
					end

					local v10 = vector2New(input2.Position.X, input2.Position.Y)

					if u(TextButton, v10) then
						if u(TextButton2, v10) then
							return
						end
					else
						return
					end

					local input3, v11 = ((input2.UserInputType == scrollingFrame.UserInputType.Touch) and input2) or nil, vector2New(Frame2.Position.X.Scale, Frame2.Position.Y.Scale)
					flag2, input, v8, v9, flag3 = true, input3, v10, v11, false
				end)

				trackConnection(UserInputService.InputChanged, function(input2)
					if flag2 then
						if not (input and (input2 == input)) then
							if input then
								return
							elseif input2.UserInputType ~= scrollingFrame.UserInputType.MouseMovement then
								return
							end
						end
					else
						return
					end

					local absoluteSize = ScreenGui.AbsoluteSize
					if absoluteSize.X <= 0 then
						return
					end
					local n11 = vector2New(input2.Position.X, input2.Position.Y) - v8

					if not (flag3) then
						if n11.Magnitude < 6 then
							return
						end
					end

					flag3 = true
					Frame2.Position = uDim2FromScale(fn17(v9.X + (n11.X / absoluteSize.X)), math.clamp(v9.Y + (n11.Y / absoluteSize.Y), 0, 0.98))
				end)

				trackConnection(UserInputService.InputEnded, function(input2)
					if flag2 then
						if not (input2.UserInputType == scrollingFrame.UserInputType.MouseButton1) then
							if input2 ~= input then
								return
							end
						end
					else
						return
					end

					flag2 = false

					if flag3 then
						input2 = D(v5.Value)

						for k, v10 in next, input2, nil do
							if type(v10) ~= "table" then
								input2[k] = nil
							end
						end

						input2[tostring(i)] = {X = Frame2.Position.X.Scale, Y = Frame2.Position.Y.Scale}
						v5:Set(input2)
					else
						toggleCol()
					end
				end)

				iMap2[i] = sectionView
			end

			local function A(arg, arg2, arg3, arg4)
				local v8 = c((arg4 and "TextButton") or "Frame", {Parent = arg.body, Name = "Item" .. arg2, Active = arg4 == true, LayoutOrder = arg2, Size = uDim2FromScale(0.7121, arg3), BackgroundColor3 = G, BackgroundTransparency = 0.4, ZIndex = 3, st(0.05)})
				arg.items[#arg.items + 1] = v8
				return v8
			end

			local function fn19(arg, arg2)
				if arg2 then
					l({Parent = arg, Name = "BarKeyChip", AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale(0.025, 0.485), Size = uDim2FromScale(0.153, 0.612), Text = "[" .. (arg2 .. "]"), TextXAlignment = left, ZIndex = 6}).TextColor3 = color3FromRGB(190, 190, 190)
				end
			end

			local interfaceSection, tbl2 = setmetatable, {__mode = "k"}
			local v8 = interfaceSection({}, tbl2)

			local function fn20(arg, arg2, arg3)
				v8[arg2] = v8[arg2] or {}
				v8[arg2][arg3] = true

				arg.cons[#arg.cons + 1] = {Disconnect = function()
					if v8[arg2] then
						v8[arg2][arg3] = nil
					end
				end}
			end

			local function fn21(arg, arg2, arg3, arg4, arg5)
				local type_ = arg2.Type

				if type_ == "toggle" then
					local v9 = A(arg, arg4, arg5, true)
					l({Parent = v9, Name = "Label", AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale((arg3 and 0.19) or 0.03, 0.5), Size = uDim2FromScale((arg3 and 0.52) or 0.68, 0.72), Text = arg2.Disp or arg2.Name, ZIndex = 4})
					fn19(v9, arg3)
					local v10, v11 = fn2(v9, 1, 0.955, 0.23, 0.56, 6)
					v11(arg2.Value == true, false)

					fn20(arg, arg2, function()
						v11(arg2.Value == true)
					end)

					hit(v9, function()
						arg2:Set(not arg2.Value)
					end)

					pathMap[arg2.Path] = v9
				elseif type_ == "button" then
					local v9, v10, v11 = rb({Parent = arg.body, Name = "Item" .. arg4, LayoutOrder = arg4, Size = uDim2FromScale(0.7121, arg5), ZIndex = 3, Text = arg2.Disp or arg2.Name})
					v11.Position, v11.Size = uDim2FromScale((arg3 and 0.58) or 0.5, 0.5), uDim2FromScale((arg3 and 0.78) or 0.94, 0.68)
					fn19(v9, arg3)
					arg.items[#arg.items + 1] = v9

					hit(v9, function()
						arg2:Press()
					end)

					pathMap[arg2.Path] = v9
				elseif type_ == "slider" then
					local parent = A(arg, arg4, arg5)
					l({Parent = parent, Name = "Label", AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale(0.035, 0.255), Size = uDim2FromScale(0.67, 0.34), Text = arg2.Disp or arg2.Name, TextXAlignment = left, TextYAlignment = scrollingFrame.TextYAlignment.Center, ZIndex = 4})
					local clone = arg2.row.vb:Clone()
					local clone2 = arg2.row.tr:Clone()
					clone.AnchorPoint, clone.Position, clone.Size = vector2New(0.5, 0.5), uDim2FromScale(0.84, 0.255), uDim2FromScale(0.25, 0.34)
					clone.ZIndex = 5
					clone.Parent = parent
					clone2.Position, clone2.Size = uDim2FromScale(0.5, 0.735), uDim2FromScale(0.92, 0.24)
					clone2.ZIndex = 4
					clone2.Parent = parent
					local bar = clone2.Bar
					local hold = clone2.Hold

					local function fn22()
						hold.Size = uDim2FromOffset(math.max(1, clone2.AbsoluteSize.Y * 1.38), math.max(1, clone2.AbsoluteSize.Y * 1.38))
					end

					fn22()
					arg.cons[#arg.cons + 1] = trackConnection(clone2:GetPropertyChangedSignal("AbsoluteSize"), fn22)
					local v9, v10 = arg2:Places()

					local function fn23()
						local n11 = ((arg2.Max > arg2.Min) and math.clamp((arg2.Value - arg2.Min) / (arg2.Max - arg2.Min), 0, 1)) or 0
						n11 = math.clamp(n11, 0.0575, 0.9425)
						bar.Size, hold.Position = uDim2FromScale(n11, 1), uDim2FromScale(n11, 0.5)

						if not (clone:IsFocused()) then
							clone.RichText, clone.Text = false, (v9 and string.format("%." .. (v10 .. "f"), arg2.Value)) or tostring(math.round(arg2.Value))
						end
					end

					fn23()
					fn20(arg, arg2, fn23)

					trackConnection(clone.FocusLost, function()
						local num = tonumber(clone.Text)

						if num then
							arg2:Set(num)
						end

						fn23()
					end)

					local flag2, input

					local function fn24(arg6)
						arg2:Set(arg2.Min + ((arg2.Max - arg2.Min) * math.clamp((arg6 - clone2.AbsolutePosition.X) / math.max(clone2.AbsoluteSize.X, 1), 0, 1)))
						fn23()
					end

					parent = {clone2, bar, hold}

					for _, v11 in ipairs(parent) do
						trackConnection(v11.InputBegan, function(input2)
							if not (flag2) then
								if input2.UserInputState == scrollingFrame.UserInputState.Begin then
									if F(input2) then
										local input3
										input3, flag2 = ((input2.UserInputType == scrollingFrame.UserInputType.Touch) and input2) or nil, true
										input = input3
										fn24(input2.Position.X)
									end
								end
							end
						end)
					end

					arg.cons[#arg.cons + 1] = trackConnection(UserInputService.InputChanged, function(input2)
						local input3 = flag2 and ((input and (input2 == input)) or (if input then not input else input2.UserInputType == scrollingFrame.UserInputType.MouseMovement))

						if input3 then
							fn24(input2.Position.X)
						end
					end)

					arg.cons[#arg.cons + 1] = trackConnection(UserInputService.InputEnded, function(input2)
						if input2.UserInputType == scrollingFrame.UserInputType.MouseButton1 then
							flag2, input = false, nil
						elseif input2 == input then
							flag2, input = false, nil
						end
					end)
				elseif type_ == "input" then
					local v9 = A(arg, arg4, arg5)
					l({Parent = v9, Name = "Label", AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale(0.035, 0.5), Size = uDim2FromScale(0.43, 0.7), Text = arg2.Disp or arg2.Name, TextXAlignment = left, ZIndex = 4})
					local clone = arg2.row.fd:Clone()
					clone.AnchorPoint, clone.Position, clone.Size = vector2New(0.5, 0.5), uDim2FromScale(0.72, 0.5), uDim2FromScale(0.48, 0.62)
					clone.ZIndex = 4
					clone.Parent = v9
					local input = clone.Input
					local underline = clone.Underline
					input.Text = tostring(arg2.Value or "")

					local function fn22(arg6)
						tw(clone, {BackgroundTransparency = (arg6 and 0.42) or 0.6}, 0.16)
						tw(underline, {Size = uDim2FromScale((arg6 and 1) or 0, 0.11)}, 0.2, quint)
					end

					trackConnection(input.Focused, function()
						fn22(true)
					end)

					trackConnection(input.FocusLost, function()
						fn22(false)
						arg2:Set(input.Text)
						input.Text = tostring(arg2.Value or "")
					end)

					fn20(arg, arg2, function()
						if not (input:IsFocused()) then
							input.Text = tostring(arg2.Value or "")
						end
					end)
				end
			end

			local function fn22()
				table.clear(pathMap)
				local n11, iMap3 = fn14(), {}

				for i = 1, 5, 1 do
					iMap3[i] = {}
				end

				for i, v9 in ipairs(fn15()) do
					i = setTab2.ByPath[v9]

					if i then
						if getEnabledFlag(i) then
							local insert, iEntry, tbl3 = table.insert, iMap3[clampValue2(v9)], {o = i}
							tbl3.k = (UserInputService.KeyboardEnabled and getEntry(n11[v9])) or nil
							insert(iEntry, tbl3)
						end
					end
				end

				for i, v9 in ipairs(iMap2) do
					for _, con in ipairs(v9.cons) do
						con:Disconnect()
					end

					for _, item in ipairs(v9.items) do
						item:Destroy()
					end

					table.clear(v9.cons)
					table.clear(v9.items)
					local iEntry, iEntry2 = iMap3[i], iMap[i]

					if if iEntry2 then #iEntry == 0 else not iEntry2 then
						v9.pn.Visible = false
					else
						local n12, n13, n14 = 0.032 * a, 0.022 * a, 0.005 * a
						n11 = ((#iEntry - 1) * n14) + (#iEntry * n12)
						local n15 = (n13 + n14) + n11
						v9.frac = n11 / n15

						if v9.tw then
							v9.tw:Cancel()
							v9.tw = nil
						end

						v9.pn.Size = uDim2FromScale(0.078 * a, n15)
						v9.hd.Size = uDim2FromScale(0.94, n13 / n15)
						v9.body.Position, v9.body.Size = uDim2FromScale(0.5, (n13 + n14) / n15), uDim2FromScale(1.32, (v9.col and 0) or v9.frac)
						v9.bl.Padding = uDimNew(n14 / n11, 0)
						v9.car.Rotation = (v9.col and 180) or 0

						for i2, v10 in ipairs(iEntry) do
							fn21(v9, v10.o, v10.k, i2, n12 / n11)
						end

						v9.pn.Position = uDim2FromScale(clampValue3(i))
						v9.pn.Visible = true
					end
				end
			end

			setTab2.qRefresh = function(arg)
				local v9 = v8[arg]

				if v9 then
					for k in next, v9, nil do
						K(k)
					end
				end
			end

			local function fn23(arg)
				local pathEntry = pathMap[arg]
				local uiScale = pathEntry and (pathEntry:FindFirstChildOfClass("UIScale") or c("UIScale", {Parent = pathEntry}))
				if not uiScale then
					return
				end
				tw(uiScale, {Scale = 0.94}, 0.055)

				task.delay(0.07, function()
					if uiScale.Parent then
						tw(uiScale, {Scale = 1}, 0.09)
					end
				end)
			end

			tbl2, setTab = setTab2:Tab("Quick", "Right", "Quick & Keys"), setTab2:Tab("Settings", "Right")
			setTab2.setTab = setTab
			interfaceSection = setTab:Section("Interface", true)

			setTab2.sizeOpt = interfaceSection:Slider("UI Size", 60, 160, 100, function(arg)
				setTab2:Scale(arg / 100)
			end, "%", 1, "Scales the main window; the corner grip does the same by hand")

			setTab2.sizeOpt.Quick = false
			local pinPadSection, section = tbl2:Section("Pin Pad", true, "Quick Access"), tbl2:Section("Pin & Key List", true, "Quick Bar & Keybinds")

			local function fn24()
				v2:Set(D(quickDefaults.pins))
				v3:Set(D(quickDefaults.groups))
				v5:Set({})
			end

			setTab = section:Button("Reset Pins", "Reset", fn24, "Restore default items, bars and positions", "Done!")
			setTab:Title("Reset Quick Access")
			setTab.Quick = false

			section:Button("Reset Keybinds", "Reset", function()
				v4:Set(D(quickDefaults.keys))
			end, "Restore the defaults set in code", "Done!").Quick = false

			local v9 = pinPadSection:Toggle("Enable Keybinds", true, function(keysOn)
				setTab2.keysOn = keysOn
			end, "Turn off to disable every feature hotkey")

			fn24 = pinPadSection:Toggle("Show Pin Pads", true, function(enabled)
				ScreenGui.Enabled = enabled
			end, "Floating quick bars; drag a header to move one")

			fn24:Title("Show Quick Bars")

			local v10, v11 = pinPadSection:Dropdown("Visible Quick Bars", {"Quick Bar 1", "Quick Bar 2", "Quick Bar 3", "Quick Bar 4", "Quick Bar 5"}, {"Quick Bar 1", "Quick Bar 2", "Quick Bar 3", "Quick Bar 4", "Quick Bar 5"}, function(arg)
				iMap = {}

				for i, v10 in ipairs(arg) do
					i = tonumber(tostring(v10):match("(%d+)$"))

					if i then
						iMap[i] = true
					end
				end

				fn22()
			end, true, nil, fn24), pinPadSection:Slider("Pad Size", 60, 200, (touchEnabled and 150) or 120, function(T)
				a = T / 100
				fn22()
			end, "%", 1)

			v11:Title("Quick Bar Size")
			setTab = {v9, fn24, v10, v11}

			for _, v12 in ipairs(setTab) do
				v12.Quick = false
			end

			ScreenGui.Enabled = fn24.Value
			local Notifications = setTab2:State("Notifications", true)
			local T = setTab2:State("Open On Launch", true)

			local Notifications2 = interfaceSection:Toggle("Notifications", true, function(arg)
				Notifications:Set(arg)
			end, "Show notification cards; turning this off hides every notify")

			local v12 = interfaceSection:Toggle("Open On Launch", true, function(arg)
				T:Set(arg)
			end, "Open the UI automatically when the script starts")

			Notifications2.Skip = true
			v12.Skip = true
			Notifications2.Quick = false
			v12.Quick = false

			Notifications.ls[#Notifications.ls + 1] = function(arg)
				Notifications2:Set(arg ~= false, true)
				Z.NotifyOn(arg ~= false)
			end

			T.ls[#T.ls + 1] = function(arg)
				v12:Set(arg ~= false, true)
			end

			local v13

			v13 = interfaceSection:Button("UI Toggle Key", "Rebind", function()
				setTab2.cap = "__OPEN__"
				v13:Note("Press any key...")
			end, "Current: " .. tostring(getEntry(v7.Value)), "")

			v13.Quick = false

			v7.ls[#v7.ls + 1] = function(arg)
				local v14 = scrollingFrame.KeyCode[tostring(arg)]

				if v14 then
					setTab2.key = v14
				end

				v13:Note("Current: " .. tostring(getEntry(arg)))
			end

			if not (UserInputService.KeyboardEnabled) then
				v9:Visible(false)
				v13:Visible(false)
			end

			local rows, flag2 = {}, false

			local function fn25(arg)
				local TextButton = c("TextButton", {Parent = arg, Name = "QuickAccessToggle", AnchorPoint = vector2New(1, 0.5), Position = uDim2FromScale(0.985, 0.5), Size = uDim2FromScale(0.115, 0.74), ZIndex = 6})
				local v14, v15 = fn2(TextButton, 0.5, 0.5, 0.95, 0.78, 6)
				return TextButton, v15
			end

			local v14

			local function fn26(arg, arg2)
				local path = arg.Path
				local enabledFlag, QuickRow = UserInputService.KeyboardEnabled and enabledFlags2[arg.Type], section:Row("QuickRow", nil)
				QuickRow.lb.Text = arg.Disp or arg.Name
				QuickRow.lb.Size = uDim2FromScale((enabledFlag and 0.47) or 0.63, 0.64)
				local m = QuickRow.m
				local TextButton = c("TextButton", {Parent = m, Name = "BarPicker", AnchorPoint = vector2New(1, 0.5), Position = uDim2FromScale(0.858, 0.5), Size = uDim2FromScale(0.062, 0.55), BackgroundColor3 = G, BackgroundTransparency = 0.5, ZIndex = 6, st(0.1)})
				n(TextButton)
				fb(TextButton, 1.04, 0.96)
				local Frame2, tbl3 = c("Frame", {Parent = TextButton, Name = "Caret", AnchorPoint = vector2New(1, 0), Position = uDim2FromScale(0.99, 0.01), Size = uDim2FromScale(0.44, 0.44), BackgroundTransparency = 1, ZIndex = 8, getUIAspectRatioConstraint(1, true)}), {{0.335355, 45}, {0.664645, -45}}

				for _, v15 in ipairs(tbl3) do
					c("Frame", {Parent = Frame2, Name = "Arm", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(v15[1], 0.535355), Rotation = v15[2], Size = uDim2FromScale(0.6657, 0.22), BackgroundColor3 = o, ZIndex = 9})
				end

				local TextButton2, TextButton3

				if enabledFlag then
					TextButton2 = c("TextButton", {Parent = m, Name = "KeyChip", AnchorPoint = vector2New(1, 0.5), Position = uDim2FromScale(0.775, 0.5), Size = uDim2FromScale(0.125, 0.5), BackgroundColor3 = G, BackgroundTransparency = 0.35, ZIndex = 6, st(0.1)})
					n(TextButton2)
					fb(TextButton2, 1.04, 0.96)
					TextButton3 = TextButton2
				else
					TextButton3 = TextButton2
				end

				local Q, v15 = fn25(m)
				local Frame3, iMap3 = c("Frame", {Parent = QuickRow.r, Name = "BarMenu", AnchorPoint = vector2New(1, 0.5), Position = uDim2FromScale(0.985, 0.755), Size = uDim2FromScale(0.4, 0), BackgroundTransparency = 1, Visible = false, ZIndex = 5, c("UIListLayout", {Name = "MenuLayout", FillDirection = scrollingFrame.FillDirection.Horizontal, HorizontalAlignment = scrollingFrame.HorizontalAlignment.Right, VerticalAlignment = scrollingFrame.VerticalAlignment.Center, SortOrder = scrollingFrame.SortOrder.LayoutOrder, Padding = uDimNew(0.024, 0)})}), {}

				for i = 1, 5, 1 do
					enabledFlag = c("TextButton", {Parent = Frame3, Name = "Bar" .. i, LayoutOrder = i, Size = uDim2FromScale(0.176, 1), Text = tostring(i), BackgroundColor3 = G, BackgroundTransparency = 0.4, ZIndex = 6, st(0.09)})
					n(enabledFlag)
					fb(enabledFlag, 1.06, 0.94)
					iMap3[i] = enabledFlag
				end

				local function pt()
					local v16 = fn16(path)
					v15(v16, false)
					TextButton.Text, TextButton.TextTransparency = tostring(clampValue2(path)), (v16 and 0) or 0.5

					for i, v17 in ipairs(iMap3) do
						v17.BackgroundTransparency, v17.TextTransparency = ((i == clampValue2(path)) and 0.15) or 0.4, ((i == clampValue2(path)) and 0) or 0.2
					end

					if TextButton3 then
						TextButton3.Text = (((setTab2.cap == path) and "?") or getEntry(fn14()[path])) or "-"
					end
				end

				local NumberValue, flag3, v16 = c("NumberValue", {Parent = QuickRow.r, Name = "BarMenuAlpha"}), false

				local function fn27(arg3)
					local ratio = 10 + (-3.8 * arg3)
					local n11 = 10 / ratio
					QuickRow.ratio = ratio
					m.Size, m.Position = uDim2FromScale(1, 0.85 / n11), uDim2FromScale(0.5, 0.5 / n11)
					ratio = 0.925 / n11
					n11 = math.max(0, 1 - ratio)
					Frame3.Size, Frame3.Position, Frame3.Visible = uDim2FromScale(0.4, n11 * 0.66), uDim2FromScale(0.985, ratio + (n11 * 0.5)), arg3 > 0.01
					Frame2.Rotation = 180 * arg3
					QuickRow.fit()
				end

				trackConnection(NumberValue.Changed, fn27)

				local function fn28(arg3)
					if flag3 == arg3 then
						return
					end
					flag3 = arg3

					if arg3 then
						closeDropdown()

						if v14 then
							v14()
						end

						function v14()
							fn28(false)
						end

						setTab2.closeDD = v14
					else
						if setTab2.closeDD == v14 then
							setTab2.closeDD = nil
						end

						v14 = nil
					end

					if v16 then
						v16:Cancel()
					end

					v16 = tw(NumberValue, {Value = (arg3 and 1) or 0}, 0.26, quint)
				end

				for i, v17 in ipairs(iMap3) do
					hit(v17, function()
						local v18 = D(v3.Value)
						v18[path] = i
						v3:Set(v18)
						fn28(false)
						pt()
					end)
				end

				hit(TextButton, function()
					fn28(not flag3)
				end)

				hit(Q, function()
					local v17 = D(v2.Value)
					local pos = table.find(v17, path)

					if pos then
						table.remove(v17, pos)
					else
						v17[#v17 + 1] = path
					end

					v2:Set(v17)
					pt()
				end)

				if TextButton3 then
					hit(TextButton3, function()
						setTab2.cap = path

						for _, row in ipairs(rows) do
							if row.pt then
								row.pt()
							end
						end
					end)
				end

				QuickRow.pt, QuickRow.s = pt, ((arg.Disp or arg.Name) .. (" " .. arg2)):lower()
				pt()
				return QuickRow
			end

			local function m(Q)
				local QuickGroup = section:Row("QuickGroup", nil, nil, 22)
				local v15 = l({Parent = QuickGroup.r, Name = "Label", AnchorPoint = vector2New(0, 0.5), Position = uDim2FromScale(0.025, 0.5), Size = uDim2FromScale(0.6, 0.8), Text = Q, TextXAlignment = left, ZIndex = 5})
				v15.TextColor3 = w
				c("Frame", {Parent = QuickGroup.r, Name = "Line", AnchorPoint = vector2New(1, 0.5), Position = uDim2FromScale(0.985, 0.5), Size = uDim2FromScale(0.34, 0.08), BackgroundColor3 = o, BackgroundTransparency = 0.75, ZIndex = 4})
				QuickGroup.lb2 = v15
				QuickGroup.hdr = true
				return QuickGroup
			end

			local function onOpen()
				if flag2 then
					return
				end
				flag2 = true
				local i, row

				for i2, tab in ipairs(setTab2.Tabs) do
					for i3, section2 in ipairs(tab.Sections) do
						for i4, row2 in ipairs(section2.rows) do
							i2 = row2.o

							if i2 then
								if section2.noReg then
								else
									if getEnabledFlag(i2) then
										i4, row2 = fn10(i2.Section.t) .. ("  >  " .. i2.Section.Disp)

										if i4 ~= i then
											row2 = m(i4)
											rows[#rows + 1] = row2
											i = i4
										else
											row2 = row
										end

										i3 = fn26(i2, i4)
										i3.hx = row2
										rows[#rows + 1] = i3
										row = row2
									else
									end
								end
							else
							end
						end
					end
				end
			end

			tbl2.onOpen = onOpen

			section.extra = function(arg)
				local hxMap, t = {}, false

				for i, row in ipairs(rows) do
					if row.hdr then
					else
						i = (arg == "") or (row.s:find(arg, 1, true) ~= nil)
						row.h.Visible = i
						fn9(row.lb, arg)

						if i then
							hxMap[row.hx] = true
							t = true
						else
						end
					end
				end

				for _, row in ipairs(rows) do
					if row.hdr then
						row.h.Visible = (arg == "") or (hxMap[row] == true)
						fn9(row.lb2, arg)
					end
				end

				return t
			end

			local function fn27()
				for _, row in ipairs(rows) do
					if row.pt then
						row.pt()
					end
				end
			end

			local function qChips()
				local v15 = fn14()

				for i, opt in ipairs(setTab2.Opts) do
					local mirrorOf = opt.mirrorOf or opt
					i = opt.row

					if (((enabledFlags2[mirrorOf.Type] and i) and i.m) and (opt.Quick ~= false)) and (mirrorOf.Quick ~= false) then
						local entry, optionKeyChip = (UserInputService.KeyboardEnabled and getEntry(v15[mirrorOf.Path])) or nil, i.m:FindFirstChild("OptionKeyChip")

						if entry then
							local n11, visible = ((mirrorOf.Type == "button") and 0.772) or 0.822, i.nt and i.nt.Visible

							if not optionKeyChip then
								optionKeyChip = c("TextButton", {Parent = i.m, Name = "OptionKeyChip", Active = true, AnchorPoint = vector2New(1, 0.5), BackgroundColor3 = G, BackgroundTransparency = 0.35, ZIndex = 7, st(0.1)})
								n(optionKeyChip)
								fb(optionKeyChip, 1.06, 0.94)

								hit(optionKeyChip, function()
									setTab2.cap = mirrorOf.Path
									optionKeyChip.Text = "?"
								end)
							else
							end

							optionKeyChip.Position, optionKeyChip.Size = uDim2FromScale(n11, 0.5), uDim2FromScale(0.082, (visible and 0.315) or 0.42)
							optionKeyChip.Text = entry
							visible = (n11 - 0.082) - 0.015
							i.lbS = i.lbS or i.lb.Size
							i.lb.Size = uDim2New(math.min(i.lbS.X.Scale, math.max(0.12, visible - i.lb.Position.X.Scale)), 0, i.lbS.Y.Scale, 0)

							if i.nt then
								i.ntS = i.ntS or i.nt.Size
								i.nt.Size = uDim2New(math.min(i.ntS.X.Scale, math.max(0.12, visible - i.nt.Position.X.Scale)), 0, i.ntS.Y.Scale, 0)
							end
						else
							if optionKeyChip then
								optionKeyChip:Destroy()
							end

							if i.lbS then
								i.lb.Size = i.lbS
								i.lbS = nil
							end

							if i.ntS then
								if i.nt then
									i.nt.Size = i.ntS
									i.ntS = nil
								end
							end
						end
					end
				end
			end

			setTab2.qChips = qChips

			trackConnection(UserInputService.InputBegan, function(input, gameProcessed)
				if input.UserInputType ~= scrollingFrame.UserInputType.Keyboard then
					return
				elseif UserInputService:GetFocusedTextBox() then
					return
				end

				if setTab2.cap then
					local cap = setTab2.cap
					setTab2.cap = nil

					if cap == "__OPEN__" then
						if input.KeyCode ~= scrollingFrame.KeyCode.Escape then
							v7:Set(input.KeyCode.Name)
						else
							v13:Note("Current: " .. tostring(getEntry(v7.Value)))
						end
					else
						local t = D(v4.Value)
						t[cap] = ((input.KeyCode ~= scrollingFrame.KeyCode.Escape) and input.KeyCode.Name) or nil
						v4:Set(t)
						fn27()
					end

					return
				end

				if gameProcessed then
					return
				end

				if input.KeyCode.Name == tostring(v7.Value) then
					gameProcessed = not setTab2.open
					return setTab2:Show(gameProcessed)
				end

				if not (v9.Value) then
					return
				end
				local v15, N, t = next, fn14()

				for k, v16 in v15, N, t do
					if v16 == input.KeyCode.Name then
						gameProcessed = setTab2.ByPath[k]

						if gameProcessed then
							if enabledFlags2[gameProcessed.Type] then
								setTab2:Fire(gameProcessed)
								fn23(k)
							end
						end
					end
				end
			end)

			v2.ls[#v2.ls + 1] = function()
				fn22()
				fn27()
			end

			v3.ls[#v3.ls + 1] = function()
				fn22()
				fn27()
			end

			v4.ls[#v4.ls + 1] = function()
				fn22()
				qChips()
				fn27()
			end

			v5.ls[#v5.ls + 1] = function()
				for i, v15 in ipairs(iMap2) do
					v15.pn.Position = uDim2FromScale(clampValue3(i))
				end
			end

			v6.ls[#v6.ls + 1] = function()
				for i, v15 in ipairs(iMap2) do
					v15.col = (type(v6.Value) == "table") and (v6.Value[tostring(i)] == true)
				end
			end

			setTab2.qSync = function()
				for i, v15 in ipairs(iMap2) do
					v15.col = (type(v6.Value) == "table") and (v6.Value[tostring(i)] == true)
				end

				fn22()
				qChips()
				fn27()
				v13:Note("Current: " .. tostring(getEntry(v7.Value)))
			end

			return tbl2
		end

		index.ConfigTab = function(arg)
			local N = arg
			arg = N.setTab

			if arg then
				local defaultsSection = arg:Section("Defaults", true)

				defaultsSection:Button("Reset to Defaults", "Reset", function()
					N:Default()
				end, "Reset every feature to its built-in default", "Done!").Quick = false

				defaultsSection:Button("Turn Off All Toggles", "Turn Off", function()
					for _, opt in ipairs(N.Opts) do
						if opt.Type == "toggle" then
							if opt.Value then
								if opt.Tab ~= "Settings" then
									if opt.Tab ~= "Config" then
										if opt.Tab ~= "Quick" then
											opt:Set(false)
										end
									end
								end
							end
						end
					end
				end, "Switch off every enabled toggle in the feature tabs", "Done!")
			end

			arg = N:Tab("Config", "Right")
			local configSection, str2 = arg:Section("Config", true), "This config loads next time; use Load Config to load now"
			local v2 = configSection:Text("Startup Config", "Startup Config: " .. N.Startup)
			v2.NoSave = true

			local v3 = configSection:Toggle("Auto Save Config", N.AutoSave, function(autoSave)
				if not (N.ready) then
					return
				end
				N.AutoSave = autoSave
				N:Mgr(true)

				if autoSave then
					N:Save()
				end
			end, "Auto save: " .. N.Active)

			local T = configSection:Toggle("Auto Load Config", N.AutoLoad, function(autoLoad)
				if not (N.ready) then
					return
				end
				N.AutoLoad = autoLoad
				N:Mgr(true)

				if autoLoad then
					N:Load(N.Startup)
				end
			end, "Auto load: " .. N.Startup)

			v3.Skip = true
			T.Skip = true
			configSection = arg:Section("Profiles", true)
			local A = configSection:Input("New Config Name", "New config name...")
			A.Skip = true
			local tbl2, m = {}

			local function cfgNotes()
				v2:Set("Startup Config: " .. N.Startup)
				v2:Note(((N.Startup:lower() ~= N.Active:lower()) and str2) or "")
				v3:Note("Auto save: " .. N.Active)
				T:Note("Auto load: " .. N.Startup)

				if m then
					m:Note("Save: " .. N.Active)
				end
			end

			N.cfgNotes = cfgNotes

			local function fn14()
				for _, v4 in ipairs(tbl2) do
					if v4.Refresh then
						v4:Refresh(N:List(), true)
					end
				end

				cfgNotes()
			end

			local function fn15(arg2)
				for i = 2, #tbl2, 1 do
					if tbl2[i] then
						tbl2[i]:Set(arg2, true)
					end
				end
			end

			local function fn16(arg2)
				arg2 = tostring(arg2 or ""):match("^%s*(.-)%s*$") or ""

				if arg2 == "" then
					return
				elseif #arg2 > 48 then
					return
				elseif arg2:find("[<>:\"/\\|%?%*%c]") then
					return
				elseif arg2:find("[%. ]$") then
					return
				end

				local Q = arg2:upper():gsub("%..*$", "")

				if Q == "CON" then
					return
				elseif Q == "PRN" then
					return
				elseif Q == "AUX" then
					return
				elseif Q == "NUL" then
					return
				elseif Q == "CLOCK$" then
					return
				elseif Q:match("^COM%d$") then
					return
				elseif Q:match("^LPT%d$") then
					return
				end

				return arg2
			end

			configSection:Button("Create New Config", "Create New", function()
				local str3 = tostring(A.Value or "")
				local Q

				if str3:match("^%s*$") then
					local n11 = 1
					Q = "Default " .. n11

					while N:Find(Q) do
						n11 += 1
						Q = "Default " .. n11
					end
				else
					Q = fn16(str3)

					if Q then
						if N:Find(Q) then
							return
						end
					else
						return
					end
				end

				str3 = table.pack(N:Collect())

				if N:Save(Q, table.unpack(str3, 1, str3.n)) then
					A:Set("", true)
					fn14()
					fn15(Q)
				end
			end, "New config copies current settings", "")

			local v4, fn17, deleteList = N:List(), function(arg2)
				local X = false

				for i, v4 in ipairs(((type(arg2) == "table") and arg2) or {arg2}) do
					i = N:Find(v4)

					if i then
						if i:lower() ~= "default" then
							pcall(delfile, N.dirP .. ("/configs/" .. (i .. ".json")))
							pcall(delfile, N.dirP .. ("/configs/" .. (i .. ".json.bak")))
							X = if i:lower() == N.Active:lower() then true else X

							if i:lower() == N.Startup:lower() then
								N.Startup = "Default"
							end
						else
						end
					else
					end
				end

				if X then
					if not (N:Load("Default")) then
						N.Active = "Default"
						N:Save("Default", N:Collect())
					end
				end

				N:Mgr(true)
				fn14()
				tbl2[1]:Set({}, true)
			end, {"Tick the configs to remove, then press Delete", "Delete"}

			tbl2[2] = configSection:Dropdown("Delete Config", v4, {}, fn17, true, nil, nil, deleteList)

			tbl2[3] = configSection:Dropdown("Set Startup Config", N:List(), N.Startup, function(arg2)
				local Q = N:Find(arg2)
				if not (Q) then
					return fn14()
				end
				N.Startup = Q
				N:Mgr(true)
				cfgNotes()
			end, false, nil, nil, {"Pick a config to auto load next time, then press Set", "Set Startup"})

			tbl2[4] = configSection:Dropdown("Load Config", N:List(), N.Active, function(arg2)
				N:Load(arg2)
			end, false, nil, nil, {"Pick a config, then press Load to apply it now", "Load"})

			m = configSection:Button("Save Config", "Save", function()
				N:Save()
			end, "Save: " .. N.Active, "")

			fn17 = arg:Section("Import / Export", true)

			tbl2[5] = fn17:Dropdown("Export Config", N:List(), N:Find(N.Active) or "Default", function(profile)
				profile = (N:Find(profile) or N:Find(N.Active)) or "Default"
				local v5 = dec(readCachedFile(fn12(N, profile)))
				if type(v5) ~= "table" then
					return Z.Notify("Export Failed", "Selected config does not exist.")
				end
				v5.Profile = profile
				local v6 = enc({Format = "ChilliLibraryConfig", ExportVersion = 1, Name = profile, Config = v5})

				if v6 and pcall(setclipboard, v6) then
					Z.Notify("Config Exported", profile .. " was copied to the clipboard.")
				else
					Z.Notify("Export Failed", "Clipboard is not available in this executor.")
				end
			end, false, nil, nil, {"Pick a config, then press Export to copy its text", "Export"})

			local a = fn17:Input("Import Config Text", "Paste exported config JSON...")
			a.Skip = true

			fn17:Button("Import Config", "Import", function()
				local match = tostring(a.Value or ""):match("^%s*(.-)%s*$") or ""
				local flag2 = (#match < 1048576) and dec(match)
				if ((type(flag2) ~= "table") or (flag2.Format ~= "ChilliLibraryConfig")) or (type(flag2.Config) ~= "table") then
					return Z.Notify("Import Failed", "Paste exported config JSON first.")
				end
				match = fn16(tostring(flag2.Name or "Imported"):sub(1, 40)) or "Imported"
				local match2, Q = match, 1

				while N:Find(match2) do
					Q += 1
					match2 = match .. (" " .. Q)
				end

				flag2.Config.Profile = match2
				N:Save(match2, flag2.Config)
				a:Set("", true)
				fn14()
				fn15(match2)
				Z.Notify("Config Imported", "Imported: " .. (match2 .. ". Open Load Config to apply, or Set Startup Config for Auto Load."), 5)
			end, "Creates a config only; use Load Config or Set Startup after", "").Quick = false

			fn17 = tbl2
			tbl2 = {fn17[2], fn17[3], fn17[4], fn17[5]}

			for _, v5 in ipairs(tbl2) do
				v5.Skip = true
			end

			cfgNotes()
			return arg
		end

		index.Finish = function(W)
			local v2 = W
			v2.ready = true

			K(function()
				if not (isfile and isfile(fn12(v2, "Default"))) then
					v2:Save("Default", v2:Collect())
				end

				local startup = v2.Startup

				if not (v2:Find(startup)) then
					v2.Startup = "Default"
				end

				v2.Active = v2.Startup
			end)

			if v2.AutoLoad then
				K(function()
					for i = 1, 6, 1 do
						i = v2.Startup
						if v2:Load(i) then
							break
						end
						task.wait(0.4)
					end
				end)
			end

			v2.busy = false
			K(v2.qSync)
			K(v2.cfgNotes)

			K(function()
				if v2.sizeOpt then
					if v2.sizeOpt.Value ~= 100 then
						v2:Scale(v2.sizeOpt.Value / 100)
					end
				end
			end)

			K(function()
				v2:Select(v2.Tabs[1])
			end)

			v2.gui.Enabled = true

			task.spawn(function()
				for i = 1, 5, 1 do
					RunService.Heartbeat:Wait()
				end

				local openOnLaunch = v2.St["Open On Launch"]

				if openOnLaunch then
					if openOnLaunch.Value ~= false then
						v2:Show(true)
					end
				else
					v2:Show(true)
				end
			end)
		end

		index.Destroy = function(W)
			for _, connection in ipairs(connections) do
				pcall(connection.Disconnect, connection)
			end

			table.clear(connections)
			local v2, N = ipairs, {W.gui, W.qgui, W.fgui, W.dlg}

			for _, v3 in v2(N) do
				if v3 then
					pcall(v3.Destroy, v3)
				end
			end
		end

		index.Dialog = function(W, arg)
			local N = W
			W = b({0, color3FromRGB(92, 94, 106)}, {0.057, color3FromRGB(70, 71, 82)}, {1, color3FromRGB(38, 39, 46)})

			if N.dlg then
				N.dlg:Destroy()
			end

			local function getUIStroke(arg2, arg3, arg4)
				return c("UIStroke", {Parent = arg2, ApplyStrokeMode = (arg4 and scrollingFrame.ApplyStrokeMode.Contextual) or scrollingFrame.ApplyStrokeMode.Border, Color = G, LineJoinMode = scrollingFrame.LineJoinMode.Round, Thickness = arg3})
			end

			local function getUIGradient2(arg2, arg3)
				return c("UIGradient", {Parent = arg2, Color = arg3, Rotation = 90})
			end

			local function fn14(arg2, arg3, arg4, T, A, arg5, m, arg6, t)
				local TextLabel = c("TextLabel", {Parent = arg2, Position = uDim2FromOffset(arg4, T), Size = uDim2FromOffset(A, arg5), FontFace = font, TextColor3 = o, TextSize = arg3, TextXAlignment = left, Text = m or "", ZIndex = 12})

				for k, v2 in next, t or {}, nil do
					TextLabel[k] = v2
				end

				t = getUIStroke(TextLabel, math.max(1, arg3 * ((arg6 and 0.065) or 0.08)), true)

				if arg6 then
					getUIGradient2(t, P)
					getUIGradient2(TextLabel, E)
				end

				return TextLabel
			end

			local ScreenGui = c("ScreenGui", {Parent = uiParent(), DisplayOrder = 2000000000, IgnoreGuiInset = true, ResetOnSpawn = false, ZIndexBehavior = scrollingFrame.ZIndexBehavior.Sibling})
			N.dlg = ScreenGui
			c("TextButton", {Parent = ScreenGui, BackgroundColor3 = G, BackgroundTransparency = 0.45, Modal = true, Size = uDim2FromScale(1, 1), ZIndex = 1})
			local Frame2 = c("Frame", {Parent = ScreenGui, Active = true, AnchorPoint = vector2New(0.5, 0.5), BackgroundColor3 = G, BackgroundTransparency = 0.18, Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromOffset(430, 316), ZIndex = 10})
			local UIScale = c("UIScale", {Parent = Frame2})

			local function clampValue2()
				local viewportSize = (workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize) or vector2New(1280, 720)
				viewportSize = if viewportSize.X < 1 then vector2New(1280, 720) else viewportSize
				UIScale.Scale = math.clamp(math.min(viewportSize.X / 1280, viewportSize.Y / 720), 0.72, 1.35)
			end

			clampValue2()

			if workspace.CurrentCamera then
				local connection = workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(clampValue2)

				local function fn15()
					connection:Disconnect()
				end

				ScreenGui.Destroying:Connect(fn15)
			end

			getUIStroke(Frame2, 2)
			clampValue2 = c("Frame", {Parent = Frame2, BackgroundColor3 = o, Position = uDim2FromOffset(22, 22), Size = uDim2FromOffset(5, 26), ZIndex = 12})
			getUIGradient2(clampValue2, r)
			getUIStroke(clampValue2, 1.4)
			fn14(Frame2, 21, 38, 20, 370, 30, arg.Title, true)
			c("Frame", {Parent = Frame2, BackgroundColor3 = o, BackgroundTransparency = 0.82, Position = uDim2FromOffset(22, 58), Size = uDim2FromOffset(386, 1), ZIndex = 12})
			getUIGradient2(fn14(Frame2, 17, 22, 68, 386, 24, arg.Warn, false, {TextColor3 = color3FromRGB(255, 72, 72)}), ColorSequence.new(color3FromRGB(255, 132, 123), color3FromRGB(239, 28, 28)))
			local body, tbl2 = arg.Body, {TextWrapped = true}
			tbl2.TextYAlignment, tbl2.LineHeight, tbl2.TextTransparency = scrollingFrame.TextYAlignment.Top, 1.14, 0.12
			fn14(Frame2, 15, 22, 98, 386, 74, body, false, tbl2)
			fn14(Frame2, 14, 22, 176, 386, 46, arg.Tip, false, {TextWrapped = true, TextYAlignment = scrollingFrame.TextYAlignment.Top, LineHeight = 1.12, TextColor3 = color3FromRGB(255, 176, 120), RichText = true})

			local function destroyAll(T)
				ScreenGui:Destroy()

				if N.dlg == ScreenGui then
					N.dlg = nil
				end

				K(T)
			end

			tbl2, body = ipairs, {{22, arg.Cancel or "Cancel", arg.no}, {224, arg.Accept or "OK", arg.ok}}

			for k, v2 in tbl2(body) do
				clampValue2, arg = k == 2, c("TextButton", {Parent = Frame2, Active = true, BackgroundTransparency = 1, Position = uDim2FromOffset(v2[1], 244), Size = uDim2FromOffset(184, 46), ZIndex = 14})
				k = c("Frame", {Parent = arg, AnchorPoint = vector2New(0.5, 0.5), BackgroundColor3 = (clampValue2 and color3FromRGB(175, 0, 0)) or color3FromRGB(24, 25, 30), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(1, 0.92), ZIndex = 12})
				getUIStroke(k, 1.6)
				local Frame3 = c("Frame", {Parent = k, AnchorPoint = vector2New(0.5, 0), BackgroundColor3 = o, Position = uDim2FromScale(0.5, 0), Size = uDim2FromScale(1, 0.9), ZIndex = 12})
				getUIGradient2(Frame3, (clampValue2 and r) or W)
				getUIGradient2(c("Frame", {Parent = Frame3, AnchorPoint = vector2New(0.5, 0.5), BackgroundColor3 = o, Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(0.965, 0.88), ZIndex = 13}), (clampValue2 and d) or W)
				Frame3, k = v2[2], {AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(0.9, 0.6), TextWrapped = true}
				k.TextXAlignment, k.ZIndex = scrollingFrame.TextXAlignment.Center, 15
				fn14(arg, 17, 0, 0, 0, 0, Frame3, true, k)

				local function fn15()
					destroyAll(v2[3])
				end

				arg.MouseButton1Click:Connect(fn15)
			end
		end

		local W = {TextScale = 1, TitleScale = 1, Font = "Gotham", LineHeight = 1.16, Padding = 1, Alignment = "Left", BackgroundColor = G, BackgroundTransparency = 0.5, StrokeColor = G, StrokeTransparency = 0, StrokeScale = 0.05, CornerScale = 0.35, ScrollBarColor = o, ScrollBarTransparency = 0}
		W.TextColor = color3FromRGB(235, 235, 235)
		W.TextStrokeTransparency = 0.7
		W.MinLines = 4
		W.MaxLines = 0
		W.AutoHeight = true
		W.ClipContent = true
		local p = {gotham = font}
		p["gotham medium"] = Font.new(h, scrollingFrame.FontWeight.Medium)
		p.fredoka = Font.new("rbxasset://fonts/families/FredokaOne.json")
		p.code = Font.new("rbxasset://fonts/families/RobotoMono.json", scrollingFrame.FontWeight.Bold)
		local alignments = {left = left}
		alignments.center = scrollingFrame.TextXAlignment.Center
		alignments.right = right

		local function N(a)
			if typeof(a) == "Font" then
				return a
			end

			if typeof(a) == "EnumItem" then
				local ok, result = pcall(Font.fromEnum, a)
				if ok then
					return result
				end
			end

			if type(a) == "string" then
				return p[a:lower()] or font
			end
		end

		local function fn14(a, arg)
			if typeof(a) == "Color3" then
				return a
			end

			if type(a) == "string" then
				local ok, result = pcall(Color3.fromHex, a)
				if ok then
					return result
				end
			end

			return arg
		end

		local function toNumberOrDefault(arg, arg2)
			local num = tonumber(arg)
			if num == nil then
				return arg2
			end
			return num
		end

		local function clampValue2(arg, arg2)
			return math.clamp(toNumberOrDefault(arg, arg2), 0, 1)
		end

		local function fn15(parent, color, rotation)
			local chilliCanvasGradient = parent:FindFirstChild("ChilliCanvasGradient")

			if color == nil then
				if chilliCanvasGradient then
					chilliCanvasGradient:Destroy()
				end

				return
			end

			if typeof(color) == "Instance" then
				if color:IsA("UIGradient") then
					if chilliCanvasGradient then
						chilliCanvasGradient:Destroy()
					end

					local ok, result = pcall(color.Clone, color)

					if ok then
						if result then
							result.Name = "ChilliCanvasGradient"

							if rotation ~= nil then
								result.Rotation = rotation
							end

							result.Parent = parent
						end
					end

					return
				end
			end

			if typeof(color) == "ColorSequence" then
				local chilliCanvasGradient2 = chilliCanvasGradient or c("UIGradient", {Name = "ChilliCanvasGradient", Parent = parent})
				chilliCanvasGradient2.Color = color

				if rotation ~= nil then
					chilliCanvasGradient2.Rotation = rotation
				end
			end
		end

		local function destroyAll(arg, arg2)
			local uiCorner = arg:FindFirstChildOfClass("UICorner")

			if arg2 == nil then
				if uiCorner then
					uiCorner:Destroy()
				end

				return
			elseif arg2 <= 0 then
				if uiCorner then
					uiCorner:Destroy()
				end

				return
			end;

			(uiCorner or c("UICorner", {Parent = arg})).CornerRadius = uDimNew(0, math.floor(arg2 + 0.5))
		end

		local function destroyAll2(arg, color, arg2, arg3, applyStrokeMode)
			local uiStroke = arg:FindFirstChildOfClass("UIStroke")

			if arg2 == nil then
				if uiStroke then
					uiStroke:Destroy()
				end

				return
			elseif arg2 <= 0 then
				if uiStroke then
					uiStroke:Destroy()
				end

				return
			end

			uiStroke = uiStroke or c("UIStroke", {LineJoinMode = scrollingFrame.LineJoinMode.Round, Parent = arg})
			uiStroke.ApplyStrokeMode, uiStroke.Color, uiStroke.Thickness, uiStroke.Transparency = applyStrokeMode or scrollingFrame.ApplyStrokeMode.Contextual, color or G, math.max(0.01, arg2), clampValue2(arg3, 0)
		end

		local function fn16(arg)
			if typeof(arg) ~= "Instance" then
				return
			end
			local ok, result = pcall(arg.Clone, arg)

			if ok then
				if not (result) then
					return
				end
			else
				return
			end

			for _, descendant in ipairs(result:GetDescendants()) do
				if ((descendant:IsA("LuaSourceContainer") or descendant:IsA("ParticleEmitter")) or descendant:IsA("Trail")) or descendant:IsA("Beam") then
					descendant:Destroy()
				elseif descendant:IsA("Light") then
					descendant:Destroy()
				elseif descendant:IsA("Sound") then
					descendant:Destroy()
				elseif descendant:IsA("Fire") then
					descendant:Destroy()
				elseif descendant:IsA("Smoke") then
					descendant:Destroy()
				elseif descendant:IsA("Sparkles") then
					descendant:Destroy()
				elseif descendant:IsA("BasePart") then
					descendant.Anchored = true
					descendant.CanCollide = false
					descendant.CastShadow = false
				end
			end

			if result:IsA("BasePart") then
				result.Anchored = true
			end

			return result
		end

		local function fn17(arg)
			if typeof(arg) ~= "Instance" then
				return false
			else
				local gameRef2 = game
				if not (arg:IsDescendantOf(gameRef2)) then
					return false
				end
			end

			local parent = arg

			while parent do
				if parent:IsA("GuiObject") then
					if not (parent.Visible) then
						return false
					end
				end

				if parent:IsA("LayerCollector") then
					return parent.Enabled
				end
				parent = parent.Parent
			end

			return false
		end

		local function toNumberOrDefault2(arg, arg2)
			if typeof(arg.Size) == "UDim2" then
				return arg.Size
			end
			local num, T, A, z = tonumber(arg.WidthScale), tonumber(arg.Width), tonumber(arg.HeightScale), tonumber(arg.Height)
			local v2, v3 = ((num and uDimNew(num, 0)) or (T and uDimNew(0, math.floor((T * arg2.Unit) + 0.5)))) or (uDimNew(1, 0)), (A and uDimNew(A, 0)) or uDimNew(0, math.floor(((z or 1) * arg2.Unit) + 0.5))
			return uDim2New(v2.Scale, v2.Offset, v3.Scale, v3.Offset)
		end

		local function fn18(arg, arg2)
			if typeof(arg.Position) == "UDim2" then
				return arg.Position
			end
			return uDim2FromOffset(math.floor((toNumberOrDefault(arg.X, 0) * arg2.Unit) + 0.5), math.floor((toNumberOrDefault(arg.Y, 0) * arg2.Unit) + 0.5))
		end

		local function fn19(arg, T)
			T = if type(T) == "table" then if type(T.Get) == "function" then T.Get() else T else T
			if typeof(T) == "Instance" then
				return T
			end
			return arg.root
		end

		local function fn20(T, A, z)
			T.pp[#T.pp + 1] = {A, z}
			T.dirty = true
		end

		local function T(backgroundColor3, z, arg)
			local m = backgroundColor3.m
			z.Size, z.Position = toNumberOrDefault2(arg, m), fn18(arg, m)

			if typeof(arg.AnchorPoint) == "Vector2" then
				z.AnchorPoint = arg.AnchorPoint
			end

			if arg.LayoutOrder ~= nil then
				z.LayoutOrder = tonumber(arg.LayoutOrder) or 0
			end

			if arg.ZIndex ~= nil then
				z.ZIndex = tonumber(arg.ZIndex) or z.ZIndex
			end

			if arg.Visible ~= nil then
				z.Visible = arg.Visible ~= false
			end

			backgroundColor3 = fn14(arg.Background, nil)

			if backgroundColor3 then
				z.BackgroundColor3, z.BackgroundTransparency = backgroundColor3, clampValue2(arg.BackgroundTransparency, 0)
			elseif arg.BackgroundTransparency ~= nil then
				z.BackgroundTransparency = clampValue2(arg.BackgroundTransparency, 1)
			end

			if arg.Corner ~= nil then
				destroyAll(z, toNumberOrDefault(arg.Corner, 0) * m.Unit)
			end

			if arg.Clip ~= nil then
				z.ClipsDescendants = arg.Clip == true
			end
		end

		local function A(z, arg, m, arg2, t)
			local Q = {Kind = m, Spec = arg2, Get = function()
				return arg
			end}

			Q.Apply = function()
				t()
				return Q
			end

			Q.Set = function(arg3)
				if type(arg3) == "table" then
					for k, v2 in next, arg3, nil do
						arg2[k] = v2
					end
				end

				z.q(Q)
				return Q
			end

			Q.SetVisible = function(arg3)
				arg2.Visible = arg3 ~= false
				arg.Visible = arg3 ~= false
				return Q
			end

			Q.Destroy = function()
				local pos = table.find(z.el, Q)

				if pos then
					table.remove(z.el, pos)
				end

				arg:Destroy()
				z.dirty = true
			end

			z.el[#z.el + 1] = Q
			z.q(Q)
			return Q
		end

		local handlers = {Frame = function(arg, m)
			local scrollingFrame2 = c(((m.Scrolling == true) and "ScrollingFrame") or "Frame", {Name = tostring(m.Name or "Panel"), BackgroundColor3 = fn14(m.Background, G), BackgroundTransparency = clampValue2(m.BackgroundTransparency, 1), ZIndex = tonumber(m.ZIndex) or 6})

			if scrollingFrame2:IsA("ScrollingFrame") then
				scrollingFrame2.Active, scrollingFrame2.AutomaticCanvasSize, scrollingFrame2.CanvasSize, scrollingFrame2.ElasticBehavior, scrollingFrame2.ScrollBarImageColor3, scrollingFrame2.ScrollingDirection = true, scrollingFrame.AutomaticSize.Y, uDim2New(), scrollingFrame.ElasticBehavior.Never, fn14(m.ScrollBarColor, arg.sty.ScrollBarColor), scrollingFrame.ScrollingDirection.Y
			end

			if m.Layout ~= nil then
				c("UIListLayout", {Parent = scrollingFrame2, FillDirection = ((tostring(m.Layout):lower() == "row") and scrollingFrame.FillDirection.Horizontal) or scrollingFrame.FillDirection.Vertical, SortOrder = scrollingFrame.SortOrder.LayoutOrder})
			end

			fn20(arg, scrollingFrame2, fn19(arg, m.Parent))

			return A(arg, scrollingFrame2, "Frame", m, function()
				T(arg, scrollingFrame2, m)

				if (m.StrokeColor ~= nil) or (m.StrokeThickness ~= nil) then
					destroyAll2(scrollingFrame2, fn14(m.StrokeColor, G), toNumberOrDefault(m.StrokeThickness, 0.06) * arg.m.Unit, m.StrokeTransparency, scrollingFrame.ApplyStrokeMode.Border)
				end

				if m.Gradient ~= nil then
					fn15(scrollingFrame2, m.Gradient, m.GradientRotation)
				end

				local uiListLayout = scrollingFrame2:FindFirstChildOfClass("UIListLayout")

				if uiListLayout then
					uiListLayout.Padding = uDimNew(0, math.floor((toNumberOrDefault(m.Spacing, 0.2) * arg.m.Unit) + 0.5))
				end

				if scrollingFrame2:IsA("ScrollingFrame") then
					scrollingFrame2.ScrollBarThickness = math.max(2, math.floor(arg.m.TextSize * 0.5))
				end

				if m.AutoHeight == true then
					scrollingFrame2.AutomaticSize = scrollingFrame.AutomaticSize.Y
				end
			end)
		end, Text = function(x, arg)
			local TextLabel = c("TextLabel", {Name = tostring(arg.Name or "Text"), RichText = arg.Rich ~= false, TextScaled = false, TextStrokeTransparency = 1, TextWrapped = arg.Wrap ~= false, TextYAlignment = scrollingFrame.TextYAlignment.Top, ZIndex = tonumber(arg.ZIndex) or 7})
			fn20(x, TextLabel, fn19(x, arg.Parent))

			return A(x, TextLabel, "Text", arg, function()
				local m, sty = x.m, x.sty
				TextLabel.Text, TextLabel.RichText, TextLabel.TextWrapped = tostring(arg.Text or ""), arg.Rich ~= false, arg.Wrap ~= false
				TextLabel.FontFace = N(arg.Font) or m.Font
				TextLabel.TextSize = math.max(6, math.floor((m.TextSize * toNumberOrDefault(arg.Scale, 1)) + 0.5))
				TextLabel.LineHeight, TextLabel.TextColor3, TextLabel.TextTransparency = toNumberOrDefault(arg.LineHeight, m.LineHeight), fn14(arg.Color, sty.TextColor), clampValue2(arg.Transparency, 0)
				TextLabel.TextStrokeColor3, TextLabel.TextStrokeTransparency = fn14(arg.TextStrokeColor, G), clampValue2(arg.TextStrokeTransparency, sty.TextStrokeTransparency)
				TextLabel.TextXAlignment = alignments[tostring(arg.Align or ""):lower()] or m.Align
				sty = tostring(arg.VAlign or "top"):lower()
				TextLabel.TextYAlignment = (((sty == "center") and scrollingFrame.TextYAlignment.Center) or ((sty == "bottom") and scrollingFrame.TextYAlignment.Bottom)) or scrollingFrame.TextYAlignment.Top
				fn15(TextLabel, arg.Gradient, arg.GradientRotation)

				if (arg.StrokeThickness ~= nil) or (arg.StrokeColor ~= nil) then
					destroyAll2(TextLabel, fn14(arg.StrokeColor, G), toNumberOrDefault(arg.StrokeThickness, 0.1) * TextLabel.TextSize, arg.StrokeTransparency, scrollingFrame.ApplyStrokeMode.Contextual)
				end

				T(x, TextLabel, arg)

				if typeof(arg.Size) ~= "UDim2" then
					if arg.Height == nil then
						if arg.HeightScale == nil then
							sty = TextLabel.Size.X
							TextLabel.Size = uDim2New(sty.Scale, sty.Offset, 0, 100000)
							TextLabel.Size = uDim2New(sty.Scale, sty.Offset, 0, math.max(TextLabel.TextSize, math.ceil(TextLabel.TextBounds.Y)))
						end
					end
				end
			end)
		end, Button = function(x, arg)
			local TextButton = c("TextButton", {Name = tostring(arg.Name or "Button"), BackgroundColor3 = fn14(arg.Background, G), BackgroundTransparency = clampValue2(arg.BackgroundTransparency, 0.35), RichText = arg.Rich ~= false, TextScaled = false, TextStrokeTransparency = 1, ZIndex = tonumber(arg.ZIndex) or 8})
			fn20(x, TextButton, fn19(x, arg.Parent))
			local flag2, t, Q = false, false, true

			local function clampValue3()
				local numVal = clampValue2(arg.BackgroundTransparency, 0.35)
				local numVal2 = (if Q then not Q else math.clamp(numVal + 0.25, 0, 1)) or (t and clampValue2(arg.PressTransparency, numVal - 0.18))
				local numVal3 = numVal2 or (flag2 and clampValue2(arg.HoverTransparency, numVal - 0.12))
				numVal2 = numVal3 or numVal
				TextButton.BackgroundTransparency, TextButton.TextTransparency = numVal2, (Q and clampValue2(arg.Transparency, 0)) or 0.4
			end

			local button = A(x, TextButton, "Button", arg, function()
				local m = x.m
				TextButton.Text, TextButton.RichText, TextButton.FontFace = tostring(arg.Text or ""), arg.Rich ~= false, N(arg.Font) or m.Font
				TextButton.TextSize, TextButton.TextColor3 = math.max(6, math.floor((m.TextSize * toNumberOrDefault(arg.Scale, 1)) + 0.5)), fn14(arg.Color, o)
				TextButton.TextXAlignment = alignments[tostring(arg.Align or "center"):lower()] or scrollingFrame.TextXAlignment.Center
				fn15(TextButton, arg.Gradient, arg.GradientRotation)
				destroyAll2(TextButton, fn14(arg.StrokeColor, G), toNumberOrDefault(arg.StrokeThickness, 0.05) * m.Unit, arg.StrokeTransparency, scrollingFrame.ApplyStrokeMode.Border)
				destroyAll(TextButton, toNumberOrDefault(arg.Corner, 0.3) * m.Unit)
				local numVal = toNumberOrDefault2(arg, m)
				numVal = if typeof(arg.Size) ~= "UDim2" then if arg.Width == nil then if arg.WidthScale == nil then uDim2New(0, math.floor(TextButton.TextBounds.X + m.Unit), numVal.Y.Scale, numVal.Y.Offset) else numVal else numVal else numVal
				TextButton.Size, TextButton.Position = numVal, fn18(arg, m)

				if arg.LayoutOrder ~= nil then
					TextButton.LayoutOrder = tonumber(arg.LayoutOrder) or 0
				end

				clampValue3()
			end)

			TextButton.MouseEnter:Connect(function()
				flag2 = true
				clampValue3()
			end)

			TextButton.MouseLeave:Connect(function()
				flag2, t = false, false
				clampValue3()
			end)

			TextButton.MouseButton1Down:Connect(function()
				t = true
				clampValue3()
			end)

			TextButton.MouseButton1Up:Connect(function()
				t = false
				clampValue3()
			end)

			TextButton.Activated:Connect(function()
				if Q then
					if type(arg.Callback) == "function" then
						pcall(arg.Callback, button)
					end
				end
			end)

			button.SetText = function(arg2)
				arg.Text = tostring(arg2 or "")
				TextButton.Text = arg.Text
				return button
			end

			button.SetCallback = function(callback)
				arg.Callback = callback
				return button
			end

			button.SetEnabled = function(arg2)
				Q = arg2 ~= false
				clampValue3()
				return button
			end

			return button
		end, Image = function(x, arg)
			local ImageLabel = c("ImageLabel", {Name = tostring(arg.Name or "Image"), BackgroundColor3 = fn14(arg.Background, G), BackgroundTransparency = clampValue2(arg.BackgroundTransparency, 1), ScaleType = scrollingFrame.ScaleType.Fit, ZIndex = tonumber(arg.ZIndex) or 7})
			fn20(x, ImageLabel, fn19(x, arg.Parent))

			local image = A(x, ImageLabel, "Image", arg, function()
				local m = x.m
				ImageLabel.Image, ImageLabel.ImageColor3, ImageLabel.ImageTransparency = tostring(arg.Image or ""), fn14(arg.ImageColor, o), clampValue2(arg.Transparency, 0)

				if arg.ScaleType ~= nil then
					local str2 = tostring(arg.ScaleType):lower()
					ImageLabel.ScaleType = (((str2 == "stretch") and scrollingFrame.ScaleType.Stretch) or ((str2 == "crop") and scrollingFrame.ScaleType.Crop)) or scrollingFrame.ScaleType.Fit
				end

				T(x, ImageLabel, arg)

				if typeof(arg.Size) ~= "UDim2" then
					if arg.Width == nil then
						if arg.WidthScale == nil then
							local offset = ImageLabel.Size.Y.Offset
							ImageLabel.Size = uDim2FromOffset(offset, offset)
						end
					end
				end

				if (arg.StrokeColor ~= nil) or (arg.StrokeThickness ~= nil) then
					destroyAll2(ImageLabel, fn14(arg.StrokeColor, o), toNumberOrDefault(arg.StrokeThickness, 0.08) * m.Unit, arg.StrokeTransparency, scrollingFrame.ApplyStrokeMode.Border)
				end

				destroyAll(ImageLabel, toNumberOrDefault(arg.Corner, 0.3) * m.Unit)
			end)

			image.SetImage = function(image2)
				arg.Image = image2
				ImageLabel.Image = tostring(image2 or "")
				return image
			end

			return image
		end, Bar = function(x, arg)
			local Frame2 = c("Frame", {Name = tostring(arg.Name or "Bar"), BackgroundColor3 = fn14(arg.Background, color3FromRGB(40, 40, 55)), BackgroundTransparency = clampValue2(arg.BackgroundTransparency, 0.25), ClipsDescendants = true, ZIndex = tonumber(arg.ZIndex) or 7})
			fn20(x, Frame2, fn19(x, arg.Parent))
			local Frame3 = c("Frame", {Parent = Frame2, Name = "Fill", BackgroundColor3 = fn14(arg.FillColor, w), BackgroundTransparency = clampValue2(arg.FillTransparency, 0), Size = uDim2FromScale(0, 1), ZIndex = Frame2.ZIndex + 1})

			local bar = A(x, Frame2, "Bar", arg, function()
				local m = x.m
				T(x, Frame2, arg)

				if typeof(arg.Size) ~= "UDim2" then
					if arg.Height == nil then
						if arg.HeightScale == nil then
							Frame2.Size = uDim2New(Frame2.Size.X.Scale, Frame2.Size.X.Offset, 0, math.max(2, math.floor(m.Unit * 0.32)))
						end
					end
				end

				Frame2.BackgroundColor3, Frame3.BackgroundColor3 = fn14(arg.Background, color3FromRGB(40, 40, 55)), fn14(arg.FillColor, w)
				Frame3.Size = uDim2FromScale(clampValue2(arg.Alpha, 0), 1)
				destroyAll(Frame2, toNumberOrDefault(arg.Corner, 0.16) * m.Unit)
				destroyAll(Frame3, toNumberOrDefault(arg.Corner, 0.16) * m.Unit)
				fn15(Frame3, arg.FillGradient, arg.GradientRotation)
			end)

			bar.SetAlpha = function(alpha)
				arg.Alpha = alpha
				Frame3.Size = uDim2FromScale(clampValue2(alpha, 0), 1)
				return bar
			end

			return bar
		end, Model = function(x, arg)
			local ViewportFrame = c("ViewportFrame", {Name = tostring(arg.Name or "Model"), Ambient = fn14(arg.Ambient, color3FromRGB(170, 170, 180)), BackgroundColor3 = fn14(arg.Background, G), BackgroundTransparency = clampValue2(arg.BackgroundTransparency, 1), LightColor = fn14(arg.LightColor, o), LightDirection = ((typeof(arg.LightDirection) == "Vector3") and arg.LightDirection) or Vector3.new(-0.6, -1, -0.4), ZIndex = tonumber(arg.ZIndex) or 7})
			fn20(x, ViewportFrame, fn19(x, arg.Parent))
			local Camera = c("Camera", {Parent = ViewportFrame, FieldOfView = toNumberOrDefault(arg.FieldOfView, 40)})
			ViewportFrame.CurrentCamera = Camera
			local cameraOrbit = {}
			cameraOrbit.Center = Vector3.new(0, 0, 0)
			cameraOrbit.Distance = 10
			cameraOrbit.Angle = 0
			cameraOrbit.Spin = arg.Spin ~= false
			cameraOrbit.Height = toNumberOrDefault(arg.CameraHeight, 0.35)
			cameraOrbit.Zoom = toNumberOrDefault(arg.Zoom, 1.05)

			local function fn21()
				if cameraOrbit.Model then
					local unit = Vector3.new(math.sin(cameraOrbit.Angle), cameraOrbit.Height, math.cos(cameraOrbit.Angle)).Unit
					Camera.CFrame = CFrame.lookAt(cameraOrbit.Center + (unit * cameraOrbit.Distance), cameraOrbit.Center)
				end
			end

			local function m(template)
				if cameraOrbit.Model then
					cameraOrbit.Model:Destroy()
					cameraOrbit.Model = nil
				end

				cameraOrbit.Template = template
				local t = fn16(template)
				if not (t) then
					return
				end
				local boundingBox, size

				if t:IsA("Model") then
					boundingBox, size = t:GetBoundingBox()
				else
					if t:IsA("BasePart") then
						boundingBox, size = t.CFrame, t.Size
					else
					end
				end

				if not (boundingBox) then
					t:Destroy()
					return
				end
				cameraOrbit.Center, cameraOrbit.Radius = boundingBox.Position, size.Magnitude * 0.5
				cameraOrbit.Distance = (cameraOrbit.Radius / math.tan(math.rad(Camera.FieldOfView / 2))) * cameraOrbit.Zoom
				t.Parent = ViewportFrame
				cameraOrbit.Model = t
				fn21()
			end

			local model = A(x, ViewportFrame, "Model", arg, function()
				local m2 = x.m
				T(x, ViewportFrame, arg)

				if typeof(arg.Size) ~= "UDim2" then
					if arg.Width == nil then
						if arg.WidthScale == nil then
							local offset = ViewportFrame.Size.Y.Offset
							ViewportFrame.Size = uDim2FromOffset(offset, offset)
						end
					end
				end

				if arg.Corner ~= nil then
					destroyAll(ViewportFrame, toNumberOrDefault(arg.Corner, 0) * m2.Unit)
				end

				if (arg.StrokeColor ~= nil) or (arg.StrokeThickness ~= nil) then
					destroyAll2(ViewportFrame, fn14(arg.StrokeColor, o), toNumberOrDefault(arg.StrokeThickness, 0.08) * m2.Unit, arg.StrokeTransparency, scrollingFrame.ApplyStrokeMode.Border)
				end

				m2 = toNumberOrDefault(arg.Zoom, 1.05)

				if m2 ~= cameraOrbit.Zoom then
					if cameraOrbit.Radius then
						cameraOrbit.Distance = (cameraOrbit.Radius / math.tan(math.rad(Camera.FieldOfView / 2))) * m2
					end
				end

				cameraOrbit.Zoom, cameraOrbit.Height = m2, toNumberOrDefault(arg.CameraHeight, 0.35)

				if arg.Model ~= cameraOrbit.Template then
					m(arg.Model)
				end

				ViewportFrame.Visible = (arg.Visible ~= false) and (cameraOrbit.Model ~= nil)
			end)

			model.SetModel = function(model2)
				arg.Model = model2
				x.q(model)
				return model
			end

			model.SetSpin = function(arg2)
				cameraOrbit.Spin = arg2 ~= false
				return model
			end

			model.Step = function(arg2)
				if cameraOrbit.Model then
					if cameraOrbit.Spin then
						cameraOrbit.Angle = (cameraOrbit.Angle + (0.4886921905584123 * arg2)) % 6.283185307179586
						fn21()
					end
				end
			end

			x.mods[#x.mods + 1] = model
			return model
		end}

		handlers.Rect, handlers.Label = handlers.Frame, handlers.Text

		widgetSpecs.Surface = function(x, arg)
			local v2 = table.clone(W)

			for k, v3 in next, ((type(arg.Style) == "table") and arg.Style) or {}, nil do
				if W[k] ~= nil then
					v2[k] = v3
				end
			end

			local str2 = ((arg.Title ~= nil) and tostring(arg.Title)) or tostring(arg.Name)
			local flag2 = arg.ShowTitle ~= false
			local visible = arg.Search == true
			local v3 = x:Row(arg.Name)
			v3.canvas = true
			v3.ratio = nil
			local r2 = v3.r
			local m = v3.m
			local lb = v3.lb
			local uiStroke = m:FindFirstChildOfClass("UIStroke")
			m.ClipsDescendants = v2.ClipContent ~= false
			lb.AnchorPoint = vector2New(0, 0)
			local Frame2 = c("Frame", {Parent = m, Name = "SearchField", AnchorPoint = vector2New(0.5, 0.5), BackgroundColor3 = G, BackgroundTransparency = 0.6, Visible = false, ZIndex = 4, st(0.1)})
			local v4 = n(c("TextBox", {Parent = Frame2, Name = "SearchInput", AnchorPoint = vector2New(0.5, 0.5), Position = uDim2FromScale(0.5, 0.5), Size = uDim2FromScale(0.9, 0.56), PlaceholderText = tostring(arg.SearchPlaceholder or "Search..."), PlaceholderColor3 = color3FromRGB(198, 198, 198), ZIndex = 5}))
			local ScrollingFrame = c("ScrollingFrame", {Parent = m, Name = "CanvasScroll", Active = true, BackgroundTransparency = 1, CanvasSize = uDim2New(), ElasticBehavior = scrollingFrame.ElasticBehavior.Never, ScrollBarImageColor3 = v2.ScrollBarColor, ScrollBarImageTransparency = v2.ScrollBarTransparency, ScrollingDirection = scrollingFrame.ScrollingDirection.Y, ZIndex = 5})
			local Frame3 = c("Frame", {Parent = m, Name = "CanvasDock", BackgroundTransparency = 1, Visible = false, ZIndex = 7})
			local Frame4 = c("Frame", {Parent = m, Name = "CanvasDockRule", BackgroundColor3 = color3FromRGB(170, 174, 184), Visible = false, ZIndex = 7})
			local Frame5 = c("Frame", {Parent = ScrollingFrame, Name = "CanvasRoot", AutomaticSize = scrollingFrame.AutomaticSize.Y, BackgroundTransparency = 1, Size = uDim2New(1, 0, 0, 0), ZIndex = 6})

			if tostring(arg.Layout or "stack"):lower() ~= "free" then
				c("UIListLayout", {Parent = Frame5, Name = "CanvasLayout", SortOrder = scrollingFrame.SortOrder.LayoutOrder})
			end

			local richView = {sty = v2, root = Frame5, el = {}, mods = {}, pp = {}, pa = {}, rh = {}}
			richView.m = {Unit = 16, TextSize = 13, LineHeight = v2.LineHeight, Font = font, Align = left, Width = 0}
			richView.query = ""
			richView.du = 0
			richView.dg = 0.22
			richView.dr = true
			richView.dirty = true
			richView.alive = true

			richView.q = function(t)
				richView.pa[#richView.pa + 1] = t
				richView.dirty = true
			end

			local function t()
				for i = #richView.pp, 1, -1 do
					local v5 = richView.pp[i]

					if ((v5[1].Parent == nil) and v5[2]) and (v5[2].Parent ~= nil) then
						if pcall(function()
							v5[1].Parent = v5[2]
						end) then
							table.remove(richView.pp, i)
						end
					elseif v5[1].Parent ~= nil then
						table.remove(richView.pp, i)
					end
				end
			end

			local Q

			local function fn21()
				local parent, x2 = r2.Parent, r2.AbsoluteSize.X

				if parent then
					if x2 <= 0 then
						return
					end
				else
					return
				end

				local n11 = (parent.AbsoluteSize.X * n7) / math.max(n5, 0.001)
				n11 = if n11 <= 0 then x2 else n11
				local f, n12 = (n11 / 10) * 0.85, x2 * 0.025
				local n13, textSize, lineHeight = (f * 0.2) * toNumberOrDefault(v2.Padding, 1), math.max(8, math.floor(((n11 * 0.026) * toNumberOrDefault(v2.TextScale, 1)) + 0.5)), math.max(0.8, toNumberOrDefault(v2.LineHeight, 1.16))
				local unit, width, m2 = textSize * lineHeight, math.max(1, x2 - (n12 * 2)), richView.m
				m2.TextSize, m2.LineHeight, m2.Unit, m2.Width, m2.Font, m2.Align = textSize, lineHeight, unit, width, N(v2.Font) or font, alignments[tostring(v2.Alignment):lower()] or left
				m.BackgroundColor3, m.BackgroundTransparency, m.ClipsDescendants = fn14(v2.BackgroundColor, G), clampValue2(v2.BackgroundTransparency, 0.5), v2.ClipContent ~= false

				if uiStroke then
					pcall(function()
						uiStroke.StrokeSizingMode = scrollingFrame.StrokeSizingMode.FixedSize
					end)

					uiStroke.Color, uiStroke.Transparency, uiStroke.Thickness = fn14(v2.StrokeColor, G), clampValue2(v2.StrokeTransparency, 0), math.max(1, f * toNumberOrDefault(v2.StrokeScale, 0.05))
				end

				parent = flag2 and (str2 ~= "")
				local flag22, n14, scrollingEnabled = ((parent or visible) and f) or 0, x2 * 0.28, x2 * 0.845
				Frame2.Visible = visible

				if visible then
					Frame2.Size, Frame2.Position = uDim2FromOffset(n14, f * 0.62), uDim2FromOffset(scrollingEnabled, f / 2)
				end

				local n15, visible2, str22 = (f * 0.64) * toNumberOrDefault(v2.TitleScale, 1), (visible and ((scrollingEnabled - (n14 / 2)) - n12)) or (x2 - n12)
				str22, lb.Visible = str2, parent
				lb.Text = str22
				lb.Position, lb.Size = uDim2FromOffset(n12, (f - n15) / 2), uDim2FromOffset(math.max(1, visible2 - n12), n15)
				lb.TextXAlignment = (visible and left) or m2.Align
				lineHeight = ((flag22 > 0) and flag22) or n13

				if richView.du > 0 then
					scrollingEnabled, parent, flag22 = math.floor((richView.du * unit) + 0.5), math.floor((toNumberOrDefault(richView.dg, 0.22) * unit) + 0.5), ((richView.dr ~= false) and math.max(1, math.floor((textSize * 0.12) + 0.5))) or 0
					Frame3.Visible, Frame3.Position, Frame3.Size = true, uDim2FromOffset(n12, lineHeight), uDim2FromOffset(width, scrollingEnabled)
					Frame4.Visible = flag22 > 0

					if flag22 > 0 then
						Frame4.BackgroundColor3, Frame4.Position, Frame4.Size = fn14(richView.drc, color3FromRGB(170, 174, 184)), uDim2FromOffset(n12, (lineHeight + scrollingEnabled) + parent), uDim2FromOffset(width, flag22)
						lineHeight += (scrollingEnabled + (parent * 2)) + flag22
					else
						lineHeight += scrollingEnabled + parent
					end
				else
					Frame3.Visible = false
					Frame4.Visible = false
				end

				t()

				for _, v5 in ipairs(richView.rh) do
					K(v5, Q, width, unit)
				end

				t()

				for _, v5 in ipairs(richView.el) do
					pcall(v5.Apply)
				end

				x2 = richView.ch or math.ceil(Frame5.AbsoluteSize.Y)
				x2 = math.max(x2, math.ceil(unit * math.max(0, toNumberOrDefault(v2.MinLines, 0))), 1)
				visible2 = math.max(0, math.floor(toNumberOrDefault(v2.MaxLines, 0)))
				str22 = math.min(x2, ((visible2 > 0) and math.ceil(unit * visible2)) or (1 / 0))
				scrollingEnabled = x2 > (str22 + 0.5)
				ScrollingFrame.Position, ScrollingFrame.Size, ScrollingFrame.CanvasSize = uDim2FromOffset(n12, lineHeight), uDim2FromOffset(width, str22), uDim2FromOffset(0, x2)
				ScrollingFrame.ScrollBarThickness = (scrollingEnabled and math.max(2, math.floor((n11 * 0.006) + 0.5))) or 0
				ScrollingFrame.ScrollingEnabled = scrollingEnabled
				ScrollingFrame.ScrollBarImageColor3, ScrollingFrame.ScrollBarImageTransparency = fn14(v2.ScrollBarColor, o), clampValue2(v2.ScrollBarTransparency, 0)
				n15 = math.max(1, math.ceil((lineHeight + str22) + n13))
				m.Size = uDim2New(1, 0, 0, n15)
				r2.Size = uDim2New(n7, 0, 0, n15 + math.ceil((f * 0.15) / 0.85))
			end

			v3.fit = function()
				richView.dirty = true
			end

			local n11 = -1
			local n12 = -1

			trackConnection(r2:GetPropertyChangedSignal("AbsoluteSize"), function()
				if math.abs(r2.AbsoluteSize.X - n11) >= 0.5 then
					n11 = r2.AbsoluteSize.X
					richView.dirty = true
				end
			end)

			trackConnection(Frame5:GetPropertyChangedSignal("AbsoluteSize"), function()
				if math.abs(Frame5.AbsoluteSize.Y - n12) >= 0.5 then
					n12 = Frame5.AbsoluteSize.Y
					richView.dirty = true
				end
			end)

			fn5(function()
				richView.dirty = true
			end)

			trackConnection(v4:GetPropertyChangedSignal("Text"), function()
				if richView.query ~= v4.Text then
					richView.query = v4.Text

					if type(arg.OnSearch) == "function" then
						pcall(arg.OnSearch, Q, richView.query)
					end

					richView.dirty = true
				end
			end)

			trackConnection(v4.Focused, function()
				tw(Frame2, {BackgroundTransparency = 0.42}, 0.16)
			end)

			trackConnection(v4.FocusLost, function()
				tw(Frame2, {BackgroundTransparency = 0.6}, 0.16)
			end)

			local n13, n14, B, n15 = 0.2, 0, true, 0

			local v5, handlers2 = trackConnection(RunService.Heartbeat, function(deltaTime)
				if richView.alive then
					if r2.Parent == nil then
						return
					end
				else
					return
				end

				n13 += deltaTime

				if n13 >= 0.2 then
					n13 = 0
					B = fn17(r2)
				end

				if #richView.pp > 0 then
					t()
					richView.dirty = true
				end

				if #richView.pa > 0 then
					for _, v5 in ipairs(richView.pa) do
						pcall(v5.Apply)
					end

					table.clear(richView.pa)
					richView.dirty = true
				end

				if richView.dirty then
					if B then
						if (os.clock() - n15) >= 0.1 then
							richView.dirty = false
							n15 = os.clock()
							local ok, result = pcall(fn21)

							if not (ok) then
								richView.dirty = true

								if not (richView.warned) then
									richView.warned = true
									warn("[Chilli] canvas " .. tostring(result))
									Z.errs[#Z.errs + 1] = "canvas " .. tostring(result)
								end
							end
						end
					end
				end

				if B and (#richView.mods > 0) then
					n14 += deltaTime

					if n14 >= 0.05 then
						local n142 = n14
						n14 = 0

						for _, mod in ipairs(richView.mods) do
							pcall(mod.Step, n142)
						end
					end
				end
			end), {Root = function()
				return Frame5
			end, Dock = function()
				return Frame3
			end, Scroll = function()
				return ScrollingFrame
			end, Plate = function()
				return m
			end, SetDock = function(arg2, arg3)
				richView.du = math.max(0, toNumberOrDefault(arg2, 0))

				if type(arg3) == "table" then
					if arg3.Gap ~= nil then
						richView.dg = toNumberOrDefault(arg3.Gap, 0.22)
					end

					if arg3.Divider ~= nil then
						richView.dr = arg3.Divider ~= false
					end

					if arg3.DividerColor ~= nil then
						richView.drc = arg3.DividerColor
					end
				end

				richView.dirty = true
			end, Unit = function()
				return richView.m.Unit
			end, Width = function()
				return richView.m.Width
			end, TextSize = function()
				return richView.m.TextSize
			end, LineHeight = function()
				return richView.m.LineHeight
			end, Font = function()
				return richView.m.Font
			end, Query = function()
				return richView.query
			end, Metrics = function()
				local m2 = richView.m
				return {Unit = m2.Unit, Width = m2.Width, TextSize = m2.TextSize, LineHeight = m2.LineHeight, Font = m2.Font}
			end, SetContentHeight = function(arg2)
				richView.ch = tonumber(arg2)
				richView.dirty = true
			end, SetContentLines = function(arg2)
				local num = tonumber(arg2)
				richView.ch = (num and math.ceil(num * richView.m.Unit)) or nil
				richView.dirty = true
			end, Invalidate = function()
				richView.dirty = true
			end, Clear = function()
				for i = #richView.el, 1, -1 do
					local v5 = richView.el[i]
					richView.el[i] = nil
					i = v5.Get()

					if i then
						i:Destroy()
					end
				end

				table.clear(richView.mods)
				table.clear(richView.pp)
				table.clear(richView.pa)
				richView.dirty = true
			end, OnResize = function(arg2)
				if type(arg2) == "function" then
					richView.rh[#richView.rh + 1] = arg2
				end
			end, SetStyle = function(arg2)
				for k, v5 in next, ((type(arg2) == "table") and arg2) or {}, nil do
					if W[k] ~= nil then
						v2[k] = v5
					end
				end

				richView.dirty = true
			end, GetStyle = function()
				return table.clone(v2)
			end, SetTitle = function(arg2)
				str2 = tostring(arg2 or "")
				richView.dirty = true
			end, SetSearchEnabled = function(arg2)
				visible = arg2 == true
				richView.dirty = true
			end, SetSearchQuery = function(arg2)
				richView.query = tostring(arg2 or "")
				v4.Text = richView.query
				richView.dirty = true
			end, Attach = function(arg2, arg3)
				if typeof(arg2) == "Instance" then
					fn20(richView, arg2, fn19(richView, arg3))
				end

				return arg2
			end}

			handlers2.Redraw = handlers2.Invalidate

			for k, handler in next, handlers, nil do
				handlers2[k] = function(arg2)
					return handler(richView, ((type(arg2) == "table") and arg2) or {})
				end
			end

			local v6, tbl2 = setmetatable, {__index = function(_, arg2)
				local handler = handlers2[arg2]
				if handler then
					return function(arg3, ...)
						return handler(...)
					end
				end
			end}

			Q = v6({}, tbl2)

			if type(arg.Build) == "function" then
				local build = arg.Build

				table.insert(richView.rh, 1, function(arg2, arg3, arg4)
					if build then
						local build2 = build
						build = nil
						K(build2, arg2, arg3, arg4)
					end
				end)
			end

			return {Surface = Q, row = v3, Name = arg.Name, GetSurface = function(arg2)
				return Q
			end, SetTitle = function(_, arg2)
				handlers2.SetTitle(arg2)
			end, SetStyle = function(_, arg2)
				handlers2.SetStyle(arg2)
			end, SetSearchQuery = function(_, arg2)
				handlers2.SetSearchQuery(arg2)
			end, GetSearchQuery = function(arg2)
				return richView.query
			end, Destroy = function(arg2)
				richView.alive = false
				v5:Disconnect()

				for i, v7 in ipairs(richView.el) do
					i = v7.Get()

					if i then
						i:Destroy()
					end
				end

				v3.h:Destroy()
			end}
		end

		widgetSpecs.CreateCanvas = function(arg, arg2)
			return arg:Surface(arg2)
		end

		widgetSpecs.CreateText = function(arg, arg2)
			return arg:Text(arg2.Name, arg2.Text)
		end

		widgetSpecs.CreateToggle = function(arg, arg2)
			return arg:Toggle(arg2.Name, arg2.Default, arg2.Callback, arg2.Note)
		end

		widgetSpecs.CreateDropdown = function(arg, arg2)
			return arg:Dropdown(arg2.Name, arg2.Options, arg2.Default, arg2.Callback, arg2.Multi, arg2.Note)
		end
	end

	return Z
end

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

local Astron = {
	Version = "1.0.0",
	Settings = {
		AutoSteal = false,
		MoveToEgg = "Walk",
		Delivery = "Fast Tween",
		FastTweenSpeed = 3300,
		DeliverySpeed = 100,
		StepCount = 3,
		MinRarity = "Any",
		DropAtSafeZone = false,
	},
	State = {
		Running = false,
		Status = "Idle",
		TargetUid = nil,
		TargetName = nil,
		Session = 0,
		Skipped = {},
	},
	Catalog = {
		Rarities = {},
		RarityRankByKey = {},
		EggRarity = {},
		AreaNames = {},
	},
}

local CARRY_ROTATION = CFrame.Angles(0, math.pi / 2, 0)
local CARRY_FRAME_CAP = 250
local CARRY_STOP_DISTANCE = 36
local CARRY_LEG_WAIT = 0.1
local CARRY_LIFT = 3
local CARRY_LIFT_TOLERANCE = 2
local CARRY_Z_EASE = 0.03
local CARRY_Z_EASE_LIMIT = 0.3
local CARRY_WALK_SCALE = 0.95
local CARRY_Z_MIN = -415
local CARRY_Z_MAX = -305
local CARRY_Z_CENTER = -382
local CARRY_DROP_GAP_X = 15.4
local CARRY_DROP_HEIGHT = 70.6
local CARRY_ENTRY_GAP_X = -11.8
local CARRY_ENTRY_Z = -383.3
local CARRY_ENTRY_RADIUS = 60
local CARRY_ENTRY_STEP = 500
local CARRY_ENTRY_WAIT = 0.155
local CARRY_ENTRY_TIMEOUT = 6
local CARRY_INSTANT_LIFT = 42
local CARRY_INSTANT_SCALE = 1.515
local CARRY_INSTANT_MIN = 40
local CARRY_INSTANT_WAIT = 0.19
local CARRY_TWEEN_WINDOW = 3
local GRAB_RADIUS = 8
local GRAB_TIMEOUT = 6
local GRAB_POLL_INTERVAL = 0.05
local GRAB_PROMPT_INTERVAL = 0.15
local GRAB_PROMPT_RADIUS = 12
local GRAB_MAX_REQUESTS = 3
local GRAB_CLOSER_DELAY = 0.5
local GRAB_CLOSER_SETTLE = 0.6
local GRAB_CLOSER_FAR = 7
local GRAB_CLOSER_NEAR = 1.5
local GRAB_CLOSER_WAIT = 0.35
local GRAB_CLOSER_EXTRA = 0.7
local DROP_TIMEOUT = 2
local DROP_CONFIRM_TIMEOUT = 0.3
local MOVE_REACH_RADIUS = 2.5
local MOVE_HEIGHT_TOLERANCE = 4
local MOVE_REFRESH_INTERVAL = 0.25
local MOVE_STUCK_WINDOW = 0.8
local MOVE_RESET_WINDOW = 3
local MOVE_JUMP_WINDOW = 1
local MOVE_TIMEOUT = 60
local SKIP_SECONDS = 20
local QUICK_STEP_AREAS = {
	["Enchanted Forest"] = true,
	["Light Dark"] = true,
	["Titan Temple"] = true,
}

local function RequireModule(...)
	local segments = { ... }
	local ok, loaded = pcall(function()
		local current = ReplicatedStorage
		for _, segment in ipairs(segments) do
			current = current and (current:FindFirstChild(segment) or current:WaitForChild(segment, 3))
		end
		return current and require(current) or nil
	end)
	return (ok and type(loaded) == "table") and loaded or nil
end

local EggState = RequireModule("Client", "EggState")
local AreasData = RequireModule("Data", "Areas")
local AssetsData = RequireModule("Data", "Assets")
local Earnings = RequireModule("Shared", "Util", "AssetEarnings")
local EggTypes = RequireModule("Shared", "Types", "AreaEggs")
local EggStates = EggTypes and EggTypes.States or nil

local function NormalizeKey(value)
	return string.lower((tostring(value or ""):gsub("%s+", " ")))
end

local function ToNumber(value, fallback)
	local numeric = tonumber(value)
	if numeric == nil then
		return fallback or 0
	end
	return numeric
end

local function GetCharacter()
	local character = LocalPlayer.Character
	if not character or not character.Parent then
		character = LocalPlayer.CharacterAdded:Wait()
	end
	return character
end

local function GetRoot()
	local character = LocalPlayer.Character
	return character and character:FindFirstChild("HumanoidRootPart") or nil
end

local function GetHumanoid()
	local character = LocalPlayer.Character
	return character and character:FindFirstChildOfClass("Humanoid") or nil
end

local function IsAlive()
	local humanoid = GetHumanoid()
	return humanoid ~= nil and humanoid.Health > 0 and GetRoot() ~= nil
end

local function StopMotion()
	local root = GetRoot()
	if not root then
		return
	end
	root.AssemblyLinearVelocity = Vector3.zero
	root.AssemblyAngularVelocity = Vector3.zero
end

local function SetStatus(text)
	Astron.State.Status = text
	local statusRow = Astron.UI and Astron.UI.Status
	if statusRow then
		pcall(statusRow.Set, statusRow, text)
	end
end

local function BuildCatalog()
	local assetsDirectory = AssetsData and AssetsData.Directory or nil
	local rankToName, rarityRanks = {}, {}
	if type(assetsDirectory) == "table" then
		for categoryName, assetEntry in pairs(assetsDirectory) do
			if type(assetEntry) == "table" then
				local rarityTable = type(assetEntry.Rarity) == "table" and assetEntry.Rarity or nil
				local rankNumber = rarityTable and ToNumber(rarityTable.RarityNumber or rarityTable.Rank, 0) or 0
				local rarityName = rarityTable
					and tostring(rarityTable.DisplayName or rarityTable._id or rarityTable.Name or "")
					or ""
				if rankNumber > 0 and rarityName ~= "" then
					rankToName[rankNumber] = rankToName[rankNumber] or rarityName
					rarityRanks[rarityName] = rankNumber
				end
				Astron.Catalog.EggRarity[NormalizeKey(categoryName)] = {
					Name = rarityName ~= "" and rarityName or "Common",
					Rank = rankNumber > 0 and rankNumber or 1,
					Rate = ToNumber(assetEntry.Rate or assetEntry.BaseRate or 0, 0),
				}
			end
		end
	end

	local sortedRanks = {}
	for rankNumber in pairs(rankToName) do
		table.insert(sortedRanks, rankNumber)
	end
	table.sort(sortedRanks, function(leftRank, rightRank)
		return leftRank < rightRank
	end)
	for _, rankNumber in ipairs(sortedRanks) do
		local rarityName = rankToName[rankNumber]
		table.insert(Astron.Catalog.Rarities, rankNumber .. " - " .. rarityName)
		Astron.Catalog.RarityRankByKey[rankNumber] = rankNumber
		Astron.Catalog.RarityRankByKey[NormalizeKey(rarityName)] = rankNumber
	end

	local areasDirectory = AreasData and AreasData.Directory or nil
	if type(areasDirectory) == "table" then
		for areaName in pairs(areasDirectory) do
			table.insert(Astron.Catalog.AreaNames, tostring(areaName))
		end
		table.sort(Astron.Catalog.AreaNames)
	end
end

local function RarityInfo(categoryName)
	local cached = Astron.Catalog.EggRarity[NormalizeKey(categoryName)]
	if cached then
		return cached.Name, cached.Rank
	end
	return "Common", 1
end

local function EggValue(categoryName, assetScale, mutations)
	local category = tostring(categoryName or "")
	if Earnings and type(Earnings.LiveRatePerSecond) == "function" then
		local ok, rate = pcall(Earnings.LiveRatePerSecond, {
			Category = category,
			Scale = math.max(ToNumber(assetScale, 1), 0.5),
			Mutations = type(mutations) == "table" and mutations or {},
		}, nil, nil, LocalPlayer)
		if ok and type(rate) == "number" and rate > 0 then
			return rate
		end
	end
	local cached = Astron.Catalog.EggRarity[NormalizeKey(category)]
	local baseRate = cached and cached.Rate or 0
	return baseRate * math.max(ToNumber(assetScale, 1), 0.5)
end

local function MinRarityRank()
	local label = tostring(Astron.Settings.MinRarity or "Any")
	local rank = ToNumber(label:match("^(%d+)"), nil)
	return rank or 0
end

local function ReadFieldEggs()
	if not EggState or type(EggState.ReadFieldEggs) ~= "function" then
		return {}
	end
	local ok, snapshot = pcall(EggState.ReadFieldEggs)
	if not ok or type(snapshot) ~= "table" then
		return {}
	end
	local records = {}
	for key, record in pairs(type(snapshot.Records) == "table" and snapshot.Records or {}) do
		if type(record) == "table" then
			record.Uid = record.Uid or tostring(key)
			table.insert(records, record)
		end
	end
	return records
end

local function ReadFieldEgg(uid)
	if not EggState or type(EggState.ReadFieldEgg) ~= "function" then
		return nil
	end
	local ok, record = pcall(EggState.ReadFieldEgg, uid)
	return (ok and type(record) == "table") and record or nil
end

local function EggStateName(record)
	local state = record and record.State
	if EggStates then
		if state == EggStates.Carried then
			return "Carried"
		elseif state == EggStates.Dropped then
			return "Dropped"
		elseif state == EggStates.Slot then
			return "Slot"
		elseif state == EggStates.GuardCarried then
			return "GuardCarried"
		end
	end
	return type(state) == "string" and state or nil
end

local function EggPosition(record)
	local pivot = record.BottomCFrame or record.BoundsCFrame or record.CFrame
	if typeof(pivot) == "CFrame" then
		return pivot.Position
	end
	local slots = Workspace:FindFirstChild("AreaEggSlotsClient")
	local model = slots and slots:FindFirstChild(tostring(record.Uid))
	if model and model:IsA("Model") then
		local ok, cachedPivot = pcall(function()
			return model:GetPivot()
		end)
		if ok and cachedPivot then
			return cachedPivot.Position
		end
	end
	return nil
end

function Astron.CollectCandidates()
	local candidates = {}
	local minRank = MinRarityRank()
	for _, record in ipairs(ReadFieldEggs()) do
		local stateName = EggStateName(record)
		if stateName ~= "Carried" and stateName ~= "Claimed" then
			local position = EggPosition(record)
			local categoryName = tostring(record.AssetCategory or "Egg")
			local rarityName, rarityRank = RarityInfo(categoryName)
			if position and rarityRank >= minRank then
				local mutations = type(record.Mutations) == "table" and #record.Mutations or 0
				table.insert(candidates, {
					Uid = tostring(record.Uid),
					Category = categoryName,
					Rarity = rarityName,
					RarityRank = rarityRank,
					MutationCount = mutations,
					Value = EggValue(categoryName, record.AssetScale, record.Mutations),
					Weight = ToNumber(record.AssetScale, 1),
					Position = position,
					AreaId = record.AreaId,
					Record = record,
				})
			end
		end
	end
	table.sort(candidates, function(left, right)
		if left.RarityRank ~= right.RarityRank then
			return left.RarityRank > right.RarityRank
		end
		if left.MutationCount ~= right.MutationCount then
			return left.MutationCount > right.MutationCount
		end
		if left.Value ~= right.Value then
			return left.Value > right.Value
		end
		return left.Uid < right.Uid
	end)
	return candidates
end

local function SeparationPosition()
	local world = Workspace:FindFirstChild("World") or Workspace:FindFirstChild("__OBJECTS")
	local areas = world and world:FindFirstChild("Areas")
	local line = areas and areas:FindFirstChild("SeparationLine")
	if line and line:IsA("BasePart") then
		return line.Position
	end
	return Vector3.new(552.2, 67.67, 0)
end

local Carry = { Active = false, Uid = nil }

local function TrackCarry()
	local signal = EggState and EggState.CarryChanged
	if type(signal) ~= "table" or type(signal.Connect) ~= "function" then
		return
	end
	pcall(function()
		signal:Connect(function(payload)
			if type(payload) ~= "table" then
				return
			end
			Carry.Active = payload.IsCarrying == true
			Carry.Uid = payload.Uid ~= nil and tostring(payload.Uid) or nil
		end)
	end)
end

local function IsCarrying(uid)
	if Carry.Active then
		return uid == nil or Carry.Uid == tostring(uid)
	end
	if uid == nil then
		return false
	end
	local record = ReadFieldEgg(uid)
	return record ~= nil
		and EggStateName(record) == "Carried"
		and ToNumber(record.CarrierUserId, 0) == LocalPlayer.UserId
end

local function RootRotation()
	local root = GetRoot()
	return root and root.CFrame.Rotation or CARRY_ROTATION
end

local function SetRootPosition(position, rotation)
	local root = GetRoot()
	if not root then
		return false
	end
	pcall(function()
		root.CFrame = CFrame.new(position) * (rotation or CARRY_ROTATION)
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
	end)
	return true
end

local function GroundY(x, z)
	local root = GetRoot()
	if not root then
		return nil
	end
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { LocalPlayer.Character }
	params.IgnoreWater = true
	local hit = Workspace:Raycast(Vector3.new(x, root.Position.Y + 80, z), Vector3.new(0, -400, 0), params)
	return hit and hit.Position.Y or nil
end

local function WalkSpeedBase()
	local humanoid = GetHumanoid()
	return math.max(ToNumber(humanoid and humanoid.WalkSpeed, 16), 16)
end

local function DeliveryScale()
	return math.clamp(ToNumber(Astron.Settings.DeliverySpeed, 100) / 100, 0.8, 1.1)
end

local function LegCount(areaId)
	if areaId and QUICK_STEP_AREAS[areaId] then
		return 4
	end
	local world = Workspace:FindFirstChild("World") or Workspace:FindFirstChild("__OBJECTS")
	local areas = world and world:FindFirstChild("Areas")
	local guardAreas = areas and areas:FindFirstChild("GuardAreas")
	local guardArea = areaId and guardAreas and guardAreas:FindFirstChild(areaId)
	local escapeSpeeds = guardArea and guardArea:GetAttribute("GuardEscapeSpeeds")
	if typeof(escapeSpeeds) == "Vector2" then
		if WalkSpeedBase() * 0.9 < escapeSpeeds.Y * 1.05 then
			return 2
		end
	end
	return 1
end

local function MoveToPoint(target, isValid)
	local humanoid = GetHumanoid()
	local root = GetRoot()
	if not humanoid or not root then
		return false
	end
	local baseSpeed = math.max(humanoid.WalkSpeed, 16)
	local runScale = DeliveryScale() * 1.14
	local deadline = os.clock() + MOVE_TIMEOUT
	local closest, closestAt = math.huge, os.clock()
	local jumped, reached, nextRefresh = false, false, 0
	while Astron.State.Running and IsAlive() and (isValid == nil or isValid()) and os.clock() < deadline do
		root = GetRoot()
		humanoid = GetHumanoid()
		if not root or not humanoid then
			break
		end
		local offset = Vector3.new(target.X - root.Position.X, 0, target.Z - root.Position.Z)
		if offset.Magnitude < closest - 5 then
			closest, closestAt = offset.Magnitude, os.clock()
		elseif (os.clock() - closestAt) > MOVE_RESET_WINDOW then
			break
		elseif (not jumped) and (os.clock() - closestAt) > MOVE_STUCK_WINDOW then
			jumped = true
		end
		if offset.Magnitude <= MOVE_REACH_RADIUS and (root.Position.Y - target.Y) < MOVE_HEIGHT_TOLERANCE then
			reached = true
			break
		end
		local walkSpeed = math.max(math.min(baseSpeed * runScale, offset.Magnitude / 0.1), 16)
		humanoid.WalkSpeed = walkSpeed
		if (os.clock() - closestAt) > MOVE_JUMP_WINDOW and humanoid.FloorMaterial ~= Enum.Material.Air then
			humanoid.Jump = true
		end
		if os.clock() >= nextRefresh then
			nextRefresh = os.clock() + MOVE_REFRESH_INTERVAL
			humanoid:MoveTo(Vector3.new(target.X, root.Position.Y, target.Z))
		end
		if offset.Magnitude > 0 then
			root.AssemblyLinearVelocity = (offset.Unit * walkSpeed) + Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
		end
		RunService.Heartbeat:Wait()
	end
	local finishedHumanoid = GetHumanoid()
	if finishedHumanoid then
		local rootPart = GetRoot()
		finishedHumanoid:MoveTo(rootPart and rootPart.Position or target)
		if finishedHumanoid == humanoid then
			finishedHumanoid.WalkSpeed = baseSpeed
		end
	end
	local finalRoot = GetRoot()
	if finalRoot and reached then
		finalRoot.AssemblyLinearVelocity = Vector3.new(0, finalRoot.AssemblyLinearVelocity.Y, 0)
	end
	return reached
end

local function DropPoint()
	local separation = SeparationPosition()
	local root = GetRoot()
	local z = root and math.clamp(root.Position.Z, CARRY_Z_MIN, CARRY_Z_MAX) or CARRY_Z_CENTER
	return Vector3.new(separation.X + CARRY_DROP_GAP_X, CARRY_DROP_HEIGHT, z)
end

local function EntryPoint()
	local separation = SeparationPosition()
	return Vector3.new(separation.X + CARRY_ENTRY_GAP_X, CARRY_DROP_HEIGHT, CARRY_ENTRY_Z)
end

local function CarryPrompt(position)
	local bestPrompt, bestDistance = nil, GRAB_PROMPT_RADIUS
	for _, candidate in ipairs(Workspace:GetChildren()) do
		if candidate.Name == "SmartPromptPart" and candidate:IsA("BasePart") then
			local prompt = candidate:FindFirstChild("CarryAreaEgg")
			if prompt then
				local distance = Vector3.new(
					candidate.Position.X - position.X,
					0,
					candidate.Position.Z - position.Z
				).Magnitude
				if distance < bestDistance then
					bestPrompt, bestDistance = prompt, distance
				end
			end
		end
	end
	return bestPrompt
end

local function RequestCarry(uid)
	if not EggState or type(EggState.CarryFieldEgg) ~= "function" then
		return false, "The carry remote is unavailable"
	end
	local ok, carried, status = pcall(EggState.CarryFieldEgg, uid)
	if not ok then
		return false, tostring(carried)
	end
	if carried == true then
		return true
	end
	return false, type(status) == "string" and status or nil
end

local function DropEgg(uid)
	if not EggState or type(EggState.DropFieldEgg) ~= "function" then
		return false
	end
	local deadline = os.clock() + DROP_TIMEOUT
	repeat
		pcall(EggState.DropFieldEgg, "PlayerRequest")
		if not IsCarrying(uid) then
			return true
		end
		task.wait(GRAB_POLL_INTERVAL)
	until os.clock() >= deadline or not Astron.State.Running
	return not IsCarrying(uid)
end

local function GrabEgg(uid, position)
	local deadline = os.clock() + GRAB_TIMEOUT
	local requests, promptAt = 0, 0
	local status, statusAt = nil, 0
	local closerAt, closerDone = nil, false
	while Astron.State.Running and IsAlive() and os.clock() < deadline do
		if IsCarrying(uid) then
			return true
		end
		local root = GetRoot()
		if position and root and (root.Position - position).Magnitude > GRAB_RADIUS then
			SetRootPosition(position + Vector3.new(0, 3, 0), root.CFrame.Rotation)
		end
		if requests < GRAB_MAX_REQUESTS then
			requests = requests + 1
			local carried, message = RequestCarry(uid)
			if carried then
				return true
			end
			if message then
				status, statusAt = string.lower(message), os.clock()
			end
			if position and os.clock() >= promptAt then
				promptAt = os.clock() + GRAB_PROMPT_INTERVAL
				local prompt = CarryPrompt(position)
				if prompt and typeof(fireproximityprompt) == "function" then
					pcall(function()
						prompt.HoldDuration = 0
						fireproximityprompt(prompt)
					end)
				end
			end
		end
		if status then
			if status:find("full") then
				return false, status:find("pet") and "Pet bag is full" or "Bag is full"
			end
			if status:find("unavailable") then
				local record = ReadFieldEgg(uid)
				if EggStateName(record) == "GuardCarried" then
					return false, "Guard is bringing the egg back"
				end
				return false, "Egg is gone"
			end
			if status:find("already carrying") and not IsCarrying(uid) then
				DropEgg(uid)
				status = nil
			end
			if status and status:find("closer") then
				if (os.clock() - statusAt) > GRAB_CLOSER_DELAY then
					return false, "Could not get close enough"
				end
				if not closerDone and position then
					if closerAt == nil then
						closerAt = os.clock()
					elseif (os.clock() - closerAt) > GRAB_CLOSER_SETTLE then
						closerDone = true
						local humanoid, current = GetHumanoid(), GetRoot()
						if humanoid and current then
							local offset = position - current.Position
							local flat = Vector3.new(offset.X, 0, offset.Z)
							local unit = flat.Magnitude > 0.1 and flat.Unit or Vector3.new(1, 0, 0)
							humanoid:MoveTo(position + unit * GRAB_CLOSER_FAR)
							task.wait(GRAB_CLOSER_WAIT)
							humanoid:MoveTo(position + unit * GRAB_CLOSER_NEAR)
							task.wait(GRAB_CLOSER_WAIT)
							deadline = deadline + GRAB_CLOSER_EXTRA
						end
					end
				end
			end
		end
		task.wait(GRAB_POLL_INTERVAL)
	end
	if IsCarrying(uid) then
		return true
	end
	return false, "Could not grab"
end

local function CarryWalk(uid, target)
	local humanoid = GetHumanoid()
	if not humanoid then
		return false
	end
	local root = GetRoot()
	if not root then
		return false
	end
	local carryY = root.Position.Y + CARRY_LIFT
	local scale = DeliveryScale()
	while Astron.State.Running and IsAlive() and IsCarrying(uid) do
		root = GetRoot()
		if not root then
			return false
		end
		local position = root.Position
		if position.X - target.X <= CARRY_STOP_DISTANCE then
			break
		end
		if math.abs(position.Y - carryY) > CARRY_LIFT_TOLERANCE then
			SetRootPosition(Vector3.new(position.X, carryY, position.Z), root.CFrame.Rotation)
		end
		local drift = math.clamp((target.Z - position.Z) * CARRY_Z_EASE, -CARRY_Z_EASE_LIMIT, CARRY_Z_EASE_LIMIT)
		local direction = Vector3.new(-1, 0, drift).Unit
		root.AssemblyLinearVelocity = direction * humanoid.WalkSpeed * CARRY_WALK_SCALE * scale
		RunService.Heartbeat:Wait()
	end
	return IsCarrying(uid)
end

local function CarryFastTween(uid, target, areaId)
	local root = GetRoot()
	if not root then
		return false
	end
	local start = root.Position
	local legs = LegCount(areaId)
	local bounds = {}
	for index = 1, legs - 1 do
		bounds[index] = start.X - ((start.X - target.X) * index / legs)
	end
	local speed = math.clamp(ToNumber(Astron.Settings.FastTweenSpeed, 3300), 3000, 4500) * DeliveryScale()
	local legIndex = 1
	local window = os.clock() + CARRY_TWEEN_WINDOW
	while Astron.State.Running and IsAlive() and IsCarrying(uid) and os.clock() < window do
		root = GetRoot()
		if not root then
			return false
		end
		local position = root.Position
		if (target - position).Magnitude <= 1 then
			break
		end
		if bounds[legIndex] and position.X <= bounds[legIndex] then
			legIndex = legIndex + 1
			SetRootPosition(Vector3.new(position.X, target.Y, position.Z), root.CFrame.Rotation)
			local settle = os.clock() + CARRY_LEG_WAIT
			while os.clock() < settle and IsCarrying(uid) and Astron.State.Running do
				RunService.Heartbeat:Wait()
			end
		end
		local offset = target - position
		local step = math.min(
			offset.Magnitude,
			math.min(speed * math.min(RunService.Heartbeat:Wait(), 0.05), CARRY_FRAME_CAP)
		)
		SetRootPosition(position + offset.Unit * step, CARRY_ROTATION)
	end
	return IsCarrying(uid)
end

local function CarryInstantSteps(uid, target, areaId)
	local root = GetRoot()
	if not root then
		return false
	end
	local start = root.Position
	local steps = math.clamp(ToNumber(Astron.Settings.StepCount, 3), 1, 6)
	local bounds = {}
	for index = 1, steps - 1 do
		bounds[index] = start.X - ((start.X - target.X) * index / steps)
	end
	local lifted = start.Y + CARRY_INSTANT_LIFT
	local stepIndex = 1
	local length = math.max(WalkSpeedBase() * CARRY_INSTANT_SCALE, CARRY_INSTANT_MIN)
	while Astron.State.Running and IsAlive() and IsCarrying(uid) do
		root = GetRoot()
		if not root then
			return false
		end
		local position = root.Position
		if position.X - target.X <= CARRY_STOP_DISTANCE then
			break
		end
		local nextX = position.X - length
		if bounds[stepIndex] and nextX <= bounds[stepIndex] then
			nextX = bounds[stepIndex]
			stepIndex = stepIndex + 1
			SetRootPosition(Vector3.new(nextX, target.Y, position.Z), root.CFrame.Rotation)
			local settle = os.clock() + CARRY_INSTANT_WAIT
			while os.clock() < settle and IsCarrying(uid) and Astron.State.Running do
				RunService.Heartbeat:Wait()
			end
			DropEgg(uid)
			if IsCarrying(uid) then
				return false
			end
			local regrabbed = GrabEgg(uid, Vector3.new(nextX, target.Y, position.Z))
			if not regrabbed then
				return false
			end
			length = math.max(WalkSpeedBase() * CARRY_INSTANT_SCALE, CARRY_INSTANT_MIN)
		else
			SetRootPosition(Vector3.new(nextX, lifted, position.Z), root.CFrame.Rotation)
			local settle = os.clock() + CARRY_LEG_WAIT
			while os.clock() < settle and IsCarrying(uid) and Astron.State.Running do
				RunService.Heartbeat:Wait()
			end
		end
	end
	return IsCarrying(uid)
end

local function EnterSafeZone(uid)
	local entry = EntryPoint()
	local deadline = os.clock() + CARRY_ENTRY_TIMEOUT
	while Astron.State.Running and IsAlive() and os.clock() < deadline do
		if not IsCarrying(uid) then
			break
		end
		local root = GetRoot()
		if not root then
			return false, "Character is unavailable"
		end
		local position = root.Position
		if position.X - entry.X > CARRY_ENTRY_RADIUS then
			SetRootPosition(
				Vector3.new(math.max(entry.X, position.X - CARRY_ENTRY_STEP), CARRY_DROP_HEIGHT, CARRY_Z_CENTER),
				root.CFrame.Rotation
			)
		else
			SetRootPosition(entry, root.CFrame.Rotation)
		end
		local settle = os.clock() + CARRY_ENTRY_WAIT
		while os.clock() < settle and IsCarrying(uid) and Astron.State.Running do
			RunService.Heartbeat:Wait()
		end
	end
	if IsCarrying(uid) then
		return false, "Delivery failed"
	end
	local record = ReadFieldEgg(uid)
	if EggStateName(record) == "Slot" then
		return false, "Egg went back to its nest"
	end
	return true
end

local function PruneSkipped()
	local now = os.clock()
	for uid, expireAt in pairs(Astron.State.Skipped) do
		if expireAt <= now then
			Astron.State.Skipped[uid] = nil
		end
	end
end

function Astron.ApproachEgg(candidate)
	local target = candidate.Position
	local groundY = GroundY(target.X, target.Z)
	if groundY then
		target = Vector3.new(target.X, groundY + 3, target.Z)
	end
	SetStatus("Heading to " .. candidate.Category)
	if Astron.Settings.MoveToEgg == "Teleport" then
		return SetRootPosition(target, RootRotation())
	end
	return MoveToPoint(target)
end

function Astron.Deliver(uid, areaId)
	SetStatus("Bringing the egg home")
	local target = DropPoint()
	local mode = Astron.Settings.Delivery
	local carried
	if mode == "Instant Steps" then
		carried = CarryInstantSteps(uid, target, areaId)
	elseif mode == "Fast Tween" then
		carried = CarryFastTween(uid, target, areaId)
	else
		carried = CarryWalk(uid, target)
	end
	if not carried then
		return false, "Dropped on the way"
	end
	SetStatus("Dropping the egg at the safe zone")
	if not DropEgg(uid) then
		return false, "Could not drop"
	end
	if Astron.Settings.DropAtSafeZone then
		SetStatus("Egg left at the safe zone")
		return true
	end
	local eggPosition = nil
	local confirm = os.clock() + DROP_CONFIRM_TIMEOUT
	while os.clock() < confirm and Astron.State.Running do
		local record = ReadFieldEgg(uid)
		if EggStateName(record) == "Dropped" then
			local pivot = record.BottomCFrame
			if typeof(pivot) == "CFrame" then
				eggPosition = pivot.Position + Vector3.new(0, 3, 0)
			end
			break
		end
		task.wait(GRAB_POLL_INTERVAL)
	end
	local root = GetRoot()
	if root then
		SetRootPosition(eggPosition or (root.Position + Vector3.new(0, 3, 0)), root.CFrame.Rotation)
	end
	local grabbed, message = GrabEgg(uid, eggPosition and (eggPosition - Vector3.new(0, 3, 0)) or nil)
	if not grabbed then
		return false, message or "Could not grab the egg back"
	end
	SetStatus("Walking the egg in")
	return EnterSafeZone(uid)
end

function Astron.StealOnce()
	PruneSkipped()
	local candidate = nil
	for _, entry in ipairs(Astron.CollectCandidates()) do
		if not Astron.State.Skipped[entry.Uid] then
			candidate = entry
			break
		end
	end
	if not candidate then
		SetStatus("No matching egg")
		return false
	end
	Astron.State.TargetUid = candidate.Uid
	Astron.State.TargetName = candidate.Category
	if not Astron.ApproachEgg(candidate) then
		Astron.State.Skipped[candidate.Uid] = os.clock() + SKIP_SECONDS
		SetStatus("Could not reach the egg")
		return false
	end
	local grabbed, grabMessage = GrabEgg(candidate.Uid, candidate.Position)
	if not grabbed then
		Astron.State.Skipped[candidate.Uid] = os.clock() + SKIP_SECONDS
		SetStatus(grabMessage or "Could not grab")
		return false
	end
	SetStatus("Carrying " .. candidate.Category)
	local delivered, deliverMessage = Astron.Deliver(candidate.Uid, candidate.AreaId)
	Astron.State.TargetUid = nil
	if delivered then
		SetStatus("Delivered " .. candidate.Category)
		return true
	end
	SetStatus(deliverMessage or "Delivery failed")
	return false
end

function Astron.Start()
	if Astron.State.Running then
		return
	end
	Astron.State.Running = true
	Astron.State.Session = Astron.State.Session + 1
	local session = Astron.State.Session
	task.spawn(function()
		while Astron.State.Running and Astron.State.Session == session do
			if not IsAlive() then
				SetStatus("Waiting for character")
				task.wait(1)
				continue
			end
			local ok, errorText = pcall(Astron.StealOnce)
			if not ok then
				SetStatus("Error: " .. tostring(errorText))
			end
			task.wait(0.6)
		end
	end)
end

function Astron.Stop()
	Astron.State.Running = false
	Astron.State.Session = Astron.State.Session + 1
	local humanoid = GetHumanoid()
	if humanoid then
		humanoid:MoveTo(Vector3.zero)
	end
	StopMotion()
	SetStatus("Idle")
end

local RarityOptions = { "Any" }
for _, rarityLabel in ipairs(Astron.Catalog.Rarities) do
	table.insert(RarityOptions, rarityLabel)
end

function Astron.BuildUI()
	if Astron.UI and Astron.UI.Window then
		return
	end

	local uiLibrary = createUiLibrary()
	local window = uiLibrary.Window({
		Title = "Astron SAE",
		Game = (game.GameId ~= 0) and game.GameId or game.PlaceId,
		Key = Enum.KeyCode.LeftControl,
	})

	local farmTab = window:Tab("Farm")
	local stealSection = farmTab:Section("Auto Steal", true)

	stealSection:Toggle("Auto Steal", false, function(isEnabled)
		Astron.Settings.AutoSteal = isEnabled
		if isEnabled then
			Astron.Start()
		else
			Astron.Stop()
		end
	end)

	stealSection:Dropdown("Move To Egg", { "Walk", "Teleport" }, "Walk", function(selectedValue)
		Astron.Settings.MoveToEgg = selectedValue
	end)

	stealSection:Dropdown("Delivery", { "Walk", "Instant Steps", "Fast Tween" }, "Fast Tween", function(selectedValue)
		Astron.Settings.Delivery = selectedValue
	end)

	stealSection:Slider("Delivery Speed", 80, 110, 100, function(sliderValue)
		Astron.Settings.DeliverySpeed = sliderValue
	end, "%", 1)

	stealSection:Slider("Step Count", 1, 6, 3, function(sliderValue)
		Astron.Settings.StepCount = sliderValue
	end, nil, 1)

	stealSection:Slider("Fast Tween Speed", 3000, 4500, 3300, function(sliderValue)
		Astron.Settings.FastTweenSpeed = sliderValue
	end, nil, 50)

	stealSection:Dropdown("Min Rarity", RarityOptions, "Any", function(selectedValue)
		Astron.Settings.MinRarity = selectedValue
	end)

	stealSection:Toggle("Drop Eggs At Safe Zone", false, function(isEnabled)
		Astron.Settings.DropAtSafeZone = isEnabled
	end)

	local statusRow = stealSection:Text("Status", "Idle")

	window:Finish()

	Astron.UI = { Window = window, Status = statusRow }
end

BuildCatalog()
TrackCarry()
Astron.BuildUI()
SetStatus("Idle")

return Astron
