local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local STORAGE = "Onium/StealAnEgg_Webhook.json"
local LOG = "[Onium Test]"
local PNG_SIGNATURE = "\137PNG\r\n\26\n"
local JPEG_SIGNATURE = "\255\216\255"
local DEFAULT_ASSET_ID = "102849850756685"
local THUMBNAIL_API = "https://%s/v1/assets?assetIds=%s&returnPolicy=PlaceHolder&size=420x420&format=Png&isCircular=false"
local ASSET_IMAGE_API = "https://%s/asset-thumbnail/image?assetId=%s&width=420&height=420&format=png"
local ASSET_DELIVERY_V1 = "https://%s/v1/asset/?id=%s"
local ASSET_DELIVERY_V2 = "https://%s/v2/assetId/%s"

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
			return { StatusCode = response.StatusCode, Body = response.Body, Headers = response.Headers }
		end)
	end

	return candidates[1]
end

local requestFn = resolveRequest()

local function statusOf(response)
	return tonumber(response and (response.StatusCode or response.Status or response.status))
end

local function call(options)
	if not requestFn then
		return nil
	end
	local ok, response = pcall(requestFn, options)
	if not ok or type(response) ~= "table" then
		return nil
	end
	return response
end

local function isPng(payload)
	return type(payload) == "string" and string.sub(payload, 1, 8) == PNG_SIGNATURE
end

local function isJpeg(payload)
	return type(payload) == "string" and string.sub(payload, 1, 3) == JPEG_SIGNATURE
end

local function describe(payload)
	if type(payload) ~= "string" or payload == "" then
		return "body kosong"
	end
	if isPng(payload) then
		return string.format("PNG %d byte", #payload)
	end
	if isJpeg(payload) then
		return string.format("JPEG %d byte", #payload)
	end
	if string.sub(payload, 1, 1) == "<" then
		return string.format("XML %d byte", #payload)
	end
	return string.format("teks %d byte", #payload)
end

local function decodeJson(payload)
	local ok, decoded = pcall(function()
		return HttpService:JSONDecode(tostring(payload))
	end)
	return ok and type(decoded) == "table" and decoded or nil
end

local function savedUrl()
	if type(readfile) ~= "function" then
		return ""
	end
	local ok, raw = pcall(readfile, STORAGE)
	if not ok or type(raw) ~= "string" or raw == "" then
		return ""
	end
	local data = decodeJson(raw)
	return type(data) == "table" and tostring(data.Url or "") or ""
end

local function readThumbnailJson(apiUrl)
	local response = call({ Url = apiUrl, Method = "GET" })
	if not response then
		return nil, "request gagal"
	end
	local status = statusOf(response)
	if status ~= 200 then
		return nil, "HTTP " .. tostring(status)
	end
	local data = decodeJson(response.Body)
	local entry = data and type(data.data) == "table" and data.data[1] or nil
	if type(entry) ~= "table" then
		return nil, "bukan json thumbnail"
	end
	if entry.state ~= "Completed" then
		return nil, "state " .. tostring(entry.state)
	end
	local imageUrl = entry.imageUrl
	if type(imageUrl) ~= "string" or imageUrl == "" then
		return nil, "imageUrl kosong"
	end
	if not string.find(imageUrl, "/Image/", 1, true) then
		return nil, "url placeholder"
	end
	return imageUrl
end

local function readBytes(url, depth)
	if (depth or 0) > 2 then
		return nil, "redirect terlalu dalam"
	end
	local response = call({ Url = url, Method = "GET" })
	if not response then
		return nil, "request gagal"
	end
	local status = statusOf(response)
	if status ~= 200 then
		return nil, "HTTP " .. tostring(status)
	end
	local body = response.Body
	if type(body) ~= "string" or body == "" then
		return nil, "body kosong"
	end
	if isPng(body) or isJpeg(body) then
		return body
	end
	local data = decodeJson(body)
	local location = data and type(data.location) == "string" and data.location or nil
	if location then
		return readBytes(location, (depth or 0) + 1)
	end
	return nil, describe(body)
end

local function tryThumbnail(host, assetId, size)
	local url = string.format(
		"https://%s/v1/assets?assetIds=%s&returnPolicy=PlaceHolder&size=%s&format=Png&isCircular=false",
		host,
		assetId,
		size
	)
	log(string.format("  GET %s", url))
	local imageUrl, reason = readThumbnailJson(url)
	if not imageUrl then
		return nil, reason
	end
	return "url", imageUrl, string.format("%s %s", host, size)
end

local function tryBytes(url, label)
	log(string.format("  GET %s", url))
	local body, reason = readBytes(url)
	if not body then
		return nil, reason
	end
	if not (isPng(body) or isJpeg(body)) then
		return nil, "bukan gambar · " .. describe(body)
	end
	return "bytes", body, label
end

local function resolveDecalId(assetId)
	local url = string.format("https://www.roproxy.com/asset/?id=%s", assetId)
	log(string.format("  GET %s", url))
	local response = call({ Url = url, Method = "GET" })
	if not response then
		return nil, "request gagal"
	end
	local status = statusOf(response)
	if status ~= 200 then
		return nil, "HTTP " .. tostring(status)
	end
	local body = tostring(response.Body)
	for found in string.gmatch(body, "roblox%.com/asset/%?id=(%d+)") do
		if found ~= assetId then
			return found
		end
	end
	for found in string.gmatch(body, "rbxassetid://(%d+)") do
		if found ~= assetId then
			return found
		end
	end
	return nil, "tidak ada id turunan · " .. describe(body)
end

local VARIANTS = {
	{
		Label = "A",
		Method = "thumbnails.roblox.com 420",
		Run = function(assetId)
			return tryThumbnail("thumbnails.roblox.com", assetId, "420x420")
		end,
	},
	{
		Label = "B",
		Method = "thumbnails.roproxy.com 420",
		Run = function(assetId)
			return tryThumbnail("thumbnails.roproxy.com", assetId, "420x420")
		end,
	},
	{
		Label = "C",
		Method = "assetdelivery.roproxy.com",
		Run = function(assetId)
			return tryBytes(string.format(ASSET_DELIVERY_V1, "assetdelivery.roproxy.com", assetId), "byte lewat proxy")
		end,
	},
	{
		Label = "D",
		Method = "www.roproxy.com asset-thumbnail",
		Run = function(assetId)
			return tryBytes(string.format(ASSET_IMAGE_API, "www.roproxy.com", assetId), "thumbnail lewat proxy")
		end,
	},
	{
		Label = "E",
		Method = "thumbnails.roproxy.com 150",
		Run = function(assetId)
			return tryThumbnail("thumbnails.roproxy.com", assetId, "150x150")
		end,
	},
	{
		Label = "F",
		Method = "thumbnails.roblox.com 150",
		Run = function(assetId)
			return tryThumbnail("thumbnails.roblox.com", assetId, "150x150")
		end,
	},
	{
		Label = "G",
		Method = "roproxy decal -> id turunan",
		Run = function(assetId)
			local decalId, reason = resolveDecalId(assetId)
			if not decalId then
				return nil, reason
			end
			log(string.format("  id turunan ditemukan: %s", decalId))
			local kind, value, detail = tryThumbnail("thumbnails.roproxy.com", decalId, "420x420")
			if kind then
				return kind, value, "decal " .. decalId
			end
			kind, value, detail = tryBytes(
				string.format(ASSET_DELIVERY_V1, "assetdelivery.roproxy.com", decalId),
				"byte decal " .. decalId
			)
			if kind then
				return kind, value, detail
			end
			return nil, tostring(detail or reason)
		end,
	},
}

local PART_COLORS = { 5793266, 3066993, 15158332, 15844367, 10181046, 3447003 }

local function encode(payload)
	local ok, text = pcall(function()
		return HttpService:JSONEncode(payload)
	end)
	return ok and type(text) == "string" and text or nil
end

local function sendJson(url, payload)
	local body = encode(payload)
	if not body then
		return "encode gagal"
	end
	local separator = string.find(url, "?", 1, true) and "&" or "?"
	local response = call({
		Url = url .. separator .. "wait=true",
		Method = "POST",
		Headers = { ["Content-Type"] = "application/json" },
		Body = body,
	})
	if not response then
		return "request gagal"
	end
	local status = statusOf(response)
	if status ~= nil and status >= 300 then
		return string.format("HTTP %d", status)
	end
	return nil
end

local function sendAttachment(url, payload, fileName, mimeType, bytes)
	local body = encode(payload)
	if not body then
		return "encode gagal"
	end
	local boundary = "----OniumTest" .. tostring(math.random(100000, 999999))
	local multipart = table.concat({
		"--" .. boundary .. "\r\n",
		'Content-Disposition: form-data; name="payload_json"\r\n',
		"Content-Type: application/json\r\n\r\n",
		body .. "\r\n",
		"--" .. boundary .. "\r\n",
		string.format('Content-Disposition: form-data; name="files[0]"; filename="%s"\r\n', fileName),
		"Content-Type: " .. mimeType .. "\r\n\r\n",
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
		return "request gagal"
	end
	local status = statusOf(response)
	if status ~= nil and status >= 300 then
		return string.format("HTTP %d: %s", status, string.sub(tostring(response.Body), 1, 120))
	end
	return nil
end

local function sendVariant(url, assetId, variant, index, statusLabel)
	local kind, value, detail = variant.Run(assetId)
	local embed = {
		author = { name = string.format("%s  ·  Onium Hub", LocalPlayer.DisplayName or LocalPlayer.Name or "Player") },
		title = string.format("Test %s  ·  %s", variant.Label, variant.Method),
		color = PART_COLORS[index] or PART_COLORS[1],
		description = string.format("asset `%s`\n%s", assetId, tostring(detail)),
		footer = { text = "Onium Hub Thumbnail Tester" },
		timestamp = DateTime.now():ToIsoDate(),
	}

	if not kind then
		local failedEmbed = {
			author = { name = string.format("%s  ·  Onium Hub", LocalPlayer.DisplayName or LocalPlayer.Name or "Player") },
			title = string.format("Test %s  ·  %s  ·  GAGAL", variant.Label, variant.Method),
			description = string.format("`%s`", tostring(detail)),
			color = 15158332,
			footer = { text = "Onium Hub Thumbnail Tester" },
			timestamp = DateTime.now():ToIsoDate(),
		}
		local failedError = sendJson(url, { embeds = { failedEmbed } })
		local message = string.format("Test %s GAGAL · %s", variant.Label, tostring(detail))
		log(message)
		if statusLabel then
			statusLabel.Text = message
		end
		if failedError then
			log("  laporan gagal tidak terkirim: " .. tostring(failedError))
		end
		return false, false
	end

	local errorText
	if kind == "url" then
		embed.thumbnail = { url = value }
		errorText = sendJson(url, { embeds = { embed } })
	elseif kind == "bytes" then
		local fileName = isJpeg(value) and "test_pet.jpg" or "test_pet.png"
		local mimeType = isJpeg(value) and "image/jpeg" or "image/png"
		embed.thumbnail = { url = "attachment://" .. fileName }
		errorText = sendAttachment(url, { embeds = { embed } }, fileName, mimeType, value)
	else
		errorText = sendJson(url, { embeds = { embed } })
	end

	local line
	if errorText then
		line = string.format("Test %s gambar siap tapi kirim gagal · %s", variant.Label, errorText)
	else
		line = string.format("Test %s terkirim bergambar · %s", variant.Label, tostring(detail))
	end
	log(line)
	if statusLabel then
		statusLabel.Text = line
	end
	return errorText == nil, kind ~= nil
end

local gui = Instance.new("ScreenGui")
gui.Name = "OniumWebhookTest"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(390, 214)
frame.Position = UDim2.new(0.5, -195, 0.5, -107)
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
	label.Parent = frame
	return label
end

makeLabel("Onium Hub  ·  Thumbnail Tester", 18, Color3.fromRGB(255, 255, 255))

makeLabel("Webhook URL", 14)

local urlBox = Instance.new("TextBox")
urlBox.Size = UDim2.new(1, 0, 0, 26)
urlBox.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
urlBox.BorderSizePixel = 0
urlBox.ClearTextOnFocus = false
urlBox.Font = Enum.Font.Gotham
urlBox.TextSize = 12
urlBox.TextColor3 = Color3.fromRGB(255, 255, 255)
urlBox.PlaceholderText = "https://discord.com/api/webhooks/..."
urlBox.TextXAlignment = Enum.TextXAlignment.Left
urlBox.Text = savedUrl()
urlBox.Parent = frame

local urlCorner = Instance.new("UICorner")
urlCorner.CornerRadius = UDim.new(0, 5)
urlCorner.Parent = urlBox

local urlPad = Instance.new("UIPadding")
urlPad.PaddingLeft = UDim.new(0, 8)
urlPad.PaddingRight = UDim.new(0, 8)
urlPad.Parent = urlBox

makeLabel("Asset ID", 14)

local assetBox = Instance.new("TextBox")
assetBox.Size = UDim2.new(1, 0, 0, 26)
assetBox.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
assetBox.BorderSizePixel = 0
assetBox.ClearTextOnFocus = false
assetBox.Font = Enum.Font.Gotham
assetBox.TextSize = 12
assetBox.TextColor3 = Color3.fromRGB(255, 255, 255)
assetBox.PlaceholderText = DEFAULT_ASSET_ID
assetBox.TextXAlignment = Enum.TextXAlignment.Left
assetBox.Text = DEFAULT_ASSET_ID
assetBox.Parent = frame

local assetCorner = Instance.new("UICorner")
assetCorner.CornerRadius = UDim.new(0, 5)
assetCorner.Parent = assetBox

local assetPad = Instance.new("UIPadding")
assetPad.PaddingLeft = UDim.new(0, 8)
assetPad.PaddingRight = UDim.new(0, 8)
assetPad.Parent = assetBox

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, 0, 0, 30)
button.BackgroundColor3 = Color3.fromRGB(217, 70, 239)
button.BorderSizePixel = 0
button.Font = Enum.Font.GothamBold
button.TextSize = 13
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Text = "Send Test A-G"
button.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = button

local status = makeLabel("Paste URL lalu tekan Send Test", 16, Color3.fromRGB(255, 194, 77))
status.TextWrapped = true

local running = false

button.MouseButton1Click:Connect(function()
	if running then
		return
	end
	local url = tostring(urlBox.Text or ""):gsub("%s", "")
	local assetId = tostring(assetBox.Text or ""):match("%d+") or DEFAULT_ASSET_ID
	if url == "" then
		status.Text = "URL webhook masih kosong"
		return
	end
	if not requestFn then
		status.Text = "executor tidak punya request"
		return
	end
	running = true
	button.Text = "Sending..."

	task.spawn(function()
		log(string.format("mulai · asset=%s", assetId))
		local successCount = 0
		for index, variant in ipairs(VARIANTS) do
			local sent, hasImage = sendVariant(url, assetId, variant, index, status)
			if sent and hasImage then
				successCount += 1
			end
			task.wait(1.2)
		end
		status.Text = string.format("Selesai · %d/%d embed berisi gambar", successCount, #VARIANTS)
		log(string.format("selesai · %d/%d embed berisi gambar", successCount, #VARIANTS))
		button.Text = "Send Test A-G"
		running = false
	end)
end)

log("ui siap · isi URL lalu tekan Send Test A-F")
