local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local AssetService = game:GetService("AssetService")

local LocalPlayer = Players.LocalPlayer
local STORAGE = "Onium/StealAnEgg_Webhook.json"
local LOG = "[Onium Test]"
local PNG_SIGNATURE = "\137PNG\r\n\26\n"
local DEFAULT_ASSET_ID = "102849850756685"
local RENDER_SIZE = 200

local function log(message)
	print(string.format("%s %s", LOG, message))
end

local function resolveRequest()
	local candidates = {}
	local function push(candidate)
		if type(candidate) == "function" then
			table.insert(candidates, candidate)
		end
	end

	if type(syn) == "table" then
		push(syn.request)
	end
	if type(fluxus) == "table" then
		push(fluxus.request)
	end
	if type(http) == "table" then
		push(http.request)
	end
	if type(krnl) == "table" then
		push(krnl.request)
	end
	push(type(http_request) == "function" and http_request or nil)
	push(type(https_request) == "function" and https_request or nil)

	local readers = {}
	if type(getgenv) == "function" then
		table.insert(readers, getgenv)
	end
	if type(getfenv) == "function" then
		table.insert(readers, getfenv)
	end
	for _, reader in ipairs(readers) do
		local ok, env = pcall(reader)
		if ok and type(env) == "table" then
			push(rawget(env, "request"))
		end
	end

	if type(HttpService.RequestAsync) == "function" then
		push(function(options)
			local response = HttpService:RequestAsync({
				Url = options.Url,
				Method = options.Method,
				Headers = options.Headers,
				Body = options.Body,
			})
			return { StatusCode = response.StatusCode, Body = response.Body }
		end)
	end

	return candidates[1]
end

local requestFn = resolveRequest()

local function call(options)
	if type(requestFn) ~= "function" then
		return nil
	end
	local ok, response = pcall(requestFn, options)
	if not ok or type(response) ~= "table" then
		return nil
	end
	return response
end

local function statusOf(response)
	return tonumber(response and (response.StatusCode or response.Status or response.status))
end

local function encode(payload)
	local ok, text = pcall(function()
		return HttpService:JSONEncode(payload)
	end)
	return ok and type(text) == "string" and text or nil
end

local function postJson(url, payload)
	local body = encode(payload)
	if not body then
		return "encode failed"
	end
	local separator = string.find(url, "?", 1, true) and "&" or "?"
	local response = call({
		Url = url .. separator .. "wait=true",
		Method = "POST",
		Headers = { ["Content-Type"] = "application/json" },
		Body = body,
	})
	if not response then
		return "request failed"
	end
	local status = statusOf(response)
	if status ~= nil and status >= 300 then
		return string.format("HTTP %d: %s", status, string.sub(tostring(response.Body), 1, 140))
	end
	return nil
end

local function postAttachment(url, payload, fileName, bytes)
	local body = encode(payload)
	if not body then
		return "encode failed"
	end
	local boundary = "----OniumTest" .. tostring(math.random(100000, 999999))
	local multipart = table.concat({
		"--" .. boundary .. "\r\n",
		'Content-Disposition: form-data; name="payload_json"\r\n',
		"Content-Type: application/json\r\n\r\n",
		body .. "\r\n",
		"--" .. boundary .. "\r\n",
		string.format('Content-Disposition: form-data; name="files[0]"; filename="%s"\r\n', fileName),
		"Content-Type: image/png\r\n\r\n",
		bytes .. "\r\n",
		"--" .. boundary .. "--\r\n",
	}, "")
	local separator = string.find(url, "?", 1, true) and "&" or "?"
	local response = call({
		Url = url .. separator .. "wait=true",
		Method = "POST",
		Headers = { ["Content-Type"] = "multipart/form-data; boundary=" .. boundary },
		Body = multipart,
	})
	if not response then
		return "request failed"
	end
	local status = statusOf(response)
	if status ~= nil and status >= 300 then
		return string.format("HTTP %d: %s", status, string.sub(tostring(response.Body), 1, 140))
	end
	return nil
end

local function savedUrl()
	if type(readfile) ~= "function" then
		return ""
	end
	local ok, raw = pcall(readfile, STORAGE)
	if not ok or type(raw) ~= "string" or raw == "" then
		return ""
	end
	local decoded
	pcall(function()
		decoded = HttpService:JSONDecode(raw)
	end)
	return type(decoded) == "table" and tostring(decoded.Url or "") or ""
end

local function chiliThumbnail(assetId)
	local apiUrl = string.format(
		"https://thumbnails.roblox.com/v1/assets?assetIds=%s&returnPolicy=PlaceHolder&size=420x420&format=Png&isCircular=false",
		assetId
	)

	local response = call({ Url = apiUrl, Method = "GET" })
	if not response then
		return nil, "request failed, executor cannot reach roblox"
	end

	local status = statusOf(response)
	local body = tostring(response.Body or "")
	log(string.format("status=%s body=%s", tostring(status), string.sub(body, 1, 420)))
	if status ~= 200 then
		return nil, "HTTP " .. tostring(status)
	end

	local decoded
	local okDecode = pcall(function()
		decoded = HttpService:JSONDecode(body)
	end)
	local entry = okDecode and type(decoded) == "table" and type(decoded.data) == "table" and decoded.data[1] or nil
	if type(entry) ~= "table" then
		return nil, "response is not thumbnail json"
	end

	local state = tostring(entry.state)
	local imageUrl = entry.imageUrl
	if state ~= "Completed" then
		return nil, "state=" .. state
	end
	if type(imageUrl) ~= "string" or imageUrl == "" then
		return nil, "state=Completed but imageUrl is empty"
	end
	if not string.find(imageUrl, "/Image/", 1, true) then
		return nil, "state=Completed but imageUrl is a placeholder:\n" .. imageUrl
	end
	return imageUrl
end

local crcTable = {}
for index = 0, 255 do
	local value = index
	for _ = 1, 8 do
		if value % 2 == 1 then
			value = bit32.bxor(0xEDB88320, math.floor(value / 2))
		else
			value = math.floor(value / 2)
		end
	end
	crcTable[index] = value
end

local function crc32(payload)
	local crc = 0xFFFFFFFF
	local length = #payload
	local index = 1
	while index <= length do
		local chunkEnd = math.min(index + 2048 - 1, length)
		for position = index, chunkEnd do
			local byte = string.byte(payload, position)
			crc = bit32.bxor(crcTable[bit32.band(bit32.bxor(crc, byte), 0xFF)], math.floor(crc / 256))
		end
		index = chunkEnd + 1
	end
	return bit32.bxor(crc, 0xFFFFFFFF)
end

local function adler32(payload)
	local first, second = 1, 0
	local length = #payload
	local index = 1
	while index <= length do
		local chunkEnd = math.min(index + 4096 - 1, length)
		for position = index, chunkEnd do
			first = (first + string.byte(payload, position)) % 65521
			second = (second + first) % 65521
		end
		index = chunkEnd + 1
	end
	return second * 65536 + first
end

local function packUInt(value)
	return string.char(
		math.floor(value / 16777216) % 256,
		math.floor(value / 65536) % 256,
		math.floor(value / 256) % 256,
		value % 256
	)
end

local function chunk(tag, payload)
	return packUInt(#payload) .. tag .. payload .. packUInt(crc32(tag .. payload))
end

local function deflateStored(raw)
	local parts = { string.char(0x78, 0x01) }
	local index = 1
	local length = #raw
	while index <= length do
		local blockLength = math.min(65535, length - index + 1)
		local isFinal = (index + blockLength - 1) >= length and 1 or 0
		local low = blockLength % 256
		local high = math.floor(blockLength / 256)
		parts[#parts + 1] = string.char(isFinal, low, high, 255 - low, 255 - high)
		parts[#parts + 1] = string.sub(raw, index, index + blockLength - 1)
		index += blockLength
	end
	parts[#parts + 1] = packUInt(adler32(raw))
	return table.concat(parts)
end

local function encodePng(width, height, rows)
	local parts = { PNG_SIGNATURE }
	parts[#parts + 1] = chunk(
		"IHDR",
		packUInt(width) .. packUInt(height) .. string.char(8, 6, 0, 0, 0)
	)
	parts[#parts + 1] = chunk("IDAT", deflateStored(table.concat(rows)))
	parts[#parts + 1] = chunk("IEND", "")
	return table.concat(parts)
end

local function renderInGame(assetId)
	if type(AssetService.CreateEditableImageAsync) ~= "function" then
		return nil, "CreateEditableImageAsync unavailable in this executor"
	end

	local created, image = pcall(function()
		return AssetService:CreateEditableImageAsync("rbxassetid://" .. assetId)
	end)
	if not created or not image then
		return nil, "CreateEditableImageAsync rejected: " .. tostring(image)
	end

	local size = image.Size
	local width = math.floor(size.X)
	local height = math.floor(size.Y)

	local readOk, pixels = pcall(function()
		return image:ReadPixelsBuffer(Vector2.zero, size)
	end)
	if not readOk or type(pixels) ~= "buffer" then
		pcall(function()
			image:Destroy()
		end)
		return nil, "ReadPixelsBuffer failed: " .. tostring(pixels)
	end

	local bufferSize = buffer.len(pixels)
	local bytesPerPixel = bufferSize / (width * height)
	if bytesPerPixel ~= 4 then
		pcall(function()
			image:Destroy()
		end)
		return nil, string.format("unknown pixel format (%s bytes per pixel)", tostring(bytesPerPixel))
	end

	local rows = {}
	for y = 0, height - 1 do
		local base = y * width * 4
		local packed = table.create(width * 4)
		for offset = 0, width * 4 - 1 do
			packed[offset + 1] = string.char(buffer.readu8(pixels, base + offset))
		end
		rows[y + 1] = string.char(0) .. table.concat(packed)
	end

	pcall(function()
		image:Destroy()
	end)
	return encodePng(width, height, rows)
end

local gui = Instance.new("ScreenGui")
gui.Name = "OniumWebhookTest"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(400, 250)
frame.Position = UDim2.new(0.5, -200, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(217, 70, 239)
stroke.Thickness = 1.4
stroke.Parent = frame

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 10)
padding.PaddingBottom = UDim.new(0, 10)
padding.PaddingLeft = UDim.new(0, 12)
padding.PaddingRight = UDim.new(0, 12)
padding.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = frame

local function makeLabel(text, height, color)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, height)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 13
	label.TextColor3 = color or Color3.fromRGB(214, 218, 236)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Text = text
	label.TextWrapped = true
	label.Parent = frame
	return label
end

local function makeBox(text, height)
	local box = Instance.new("TextBox")
	box.Size = UDim2.new(1, 0, 0, height)
	box.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
	box.BorderSizePixel = 0
	box.ClearTextOnFocus = false
	box.Font = Enum.Font.Gotham
	box.TextSize = 12
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.TextXAlignment = Enum.TextXAlignment.Left
	box.Text = text
	box.Parent = frame

	local boxCorner = Instance.new("UICorner")
	boxCorner.CornerRadius = UDim.new(0, 5)
	boxCorner.Parent = box

	local boxPad = Instance.new("UIPadding")
	boxPad.PaddingLeft = UDim.new(0, 8)
	boxPad.PaddingRight = UDim.new(0, 8)
	boxPad.Parent = box
	return box
end

local function makeButton(text)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 28)
	button.BackgroundColor3 = Color3.fromRGB(217, 70, 239)
	button.BorderSizePixel = 0
	button.Font = Enum.Font.GothamBold
	button.TextSize = 13
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Text = text
	button.Parent = frame

	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(0, 6)
	buttonCorner.Parent = button
	return button
end

makeLabel("Onium Hub  ·  Thumbnail Tester (jalur Chili)", 18, Color3.fromRGB(255, 255, 255))
makeLabel("Webhook URL", 14)

local urlBox = makeBox(savedUrl(), 24)
urlBox.PlaceholderText = "https://discord.com/api/webhooks/..."

makeLabel("Asset ID (pet)", 14)

local assetBox = makeBox(DEFAULT_ASSET_ID, 24)
assetBox.PlaceholderText = DEFAULT_ASSET_ID

local chiliButton = makeButton("Send Chili Path")
local renderButton = makeButton("Send Render In-Game")
local statusLabel = makeLabel("Pick a button", 44, Color3.fromRGB(255, 194, 77))

local running = false

local function currentInputs()
	local url = tostring(urlBox.Text or ""):gsub("%s", "")
	local assetId = tostring(assetBox.Text or ""):match("%d+")
	if url == "" then
		statusLabel.Text = "Webhook url is empty"
		return nil
	end
	if not assetId then
		statusLabel.Text = "Asset id is empty"
		return nil
	end
	return url, assetId
end

local function sendReport(url, assetId, title, ok, detail, thumbnailUrl, pngBytes)
	local fields = {
		{ name = "Asset", value = string.format("`%s`", assetId), inline = true },
		{ name = "Hasil", value = ok and "`BERHASIL`" or "`GAGAL`", inline = true },
	}
	local embed = {
		author = { name = string.format("%s  ·  Onium Hub", LocalPlayer.DisplayName or LocalPlayer.Name or "Player") },
		title = title,
		color = ok and 3066993 or 15158332,
		description = string.format("`%s`", tostring(detail)),
		fields = fields,
		footer = { text = "Onium Hub Thumbnail Tester" },
		timestamp = DateTime.now():ToIsoDate(),
	}

	if ok and pngBytes then
		embed.thumbnail = { url = "attachment://render.png" }
		return postAttachment(url, { embeds = { embed } }, "render.png", pngBytes)
	end
	if ok and thumbnailUrl then
		embed.thumbnail = { url = thumbnailUrl }
	end
	return postJson(url, { embeds = { embed } })
end

chiliButton.MouseButton1Click:Connect(function()
	if running then
		return
	end
	local url, assetId = currentInputs()
	if not url then
		return
	end
	running = true
	chiliButton.Text = "Sending..."

	task.spawn(function()
		local imageUrl, reason = chiliThumbnail(assetId)
		local sendError = sendReport(
			url,
			assetId,
			"Chili Path  ·  thumbnails.roblox.com",
			imageUrl ~= nil,
			imageUrl and ("url: " .. imageUrl) or tostring(reason),
			imageUrl
		)
		local line
		if imageUrl then
			line = "chili path: image found"
		else
			line = "chili path failed · " .. tostring(reason)
		end
		if sendError then
			line = line .. " · send: " .. tostring(sendError)
		end
		log(line)
		statusLabel.Text = line
		chiliButton.Text = "Send Chili Path"
		running = false
	end)
end)

renderButton.MouseButton1Click:Connect(function()
	if running then
		return
	end
	local url, assetId = currentInputs()
	if not url then
		return
	end
	running = true
	renderButton.Text = "Rendering..."

	task.spawn(function()
		local pngBytes, reason = renderInGame(assetId)
		local sendError = sendReport(
			url,
			assetId,
			"Render In-Game  ·  EditableImage",
			pngBytes ~= nil,
			pngBytes and string.format("png %d byte", #pngBytes) or tostring(reason),
			nil,
			pngBytes
		)
		local line
		if pngBytes then
			line = string.format("render: png %d bytes sent", #pngBytes)
		else
			line = "render failed · " .. tostring(reason)
		end
		if sendError then
			line = line .. " · send: " .. tostring(sendError)
		end
		log(line)
		statusLabel.Text = line
		renderButton.Text = "Send Render In-Game"
		running = false
	end)
end)

log("ui ready")
