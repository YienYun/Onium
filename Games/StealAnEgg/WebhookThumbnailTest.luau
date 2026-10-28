local HttpService = game:GetService("HttpService")

local ASSET_ID = "102849850756685"
local PET_NAME = "RazorFang"
local WEBHOOK_OVERRIDE = ""
local STORAGE = "Onium/StealAnEgg_Webhook.json"
local LOG = "[Onium Test]"
local PNG_SIGNATURE = "\137PNG\r\n\26\n"
local JPEG_SIGNATURE = "\255\216\255"

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

local function readWebhookUrl()
	if WEBHOOK_OVERRIDE ~= "" then
		return WEBHOOK_OVERRIDE
	end
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

local function describe(payload)
	if type(payload) ~= "string" or payload == "" then
		return "body kosong"
	end
	if string.sub(payload, 1, 8) == PNG_SIGNATURE then
		return string.format("PNG %d byte", #payload)
	end
	if string.sub(payload, 1, 3) == JPEG_SIGNATURE then
		return string.format("JPEG %d byte", #payload)
	end
	if string.sub(payload, 1, 1) == "<" then
		return string.format("XML %d byte", #payload)
	end
	return string.format("teks %d byte", #payload)
end

local function statusOf(response)
	return tonumber(response.StatusCode or response.Status or response.status)
end

local function request(requestFn, url)
	local ok, response = pcall(requestFn, { Url = url, Method = "GET" })
	if not ok or type(response) ~= "table" then
		return nil
	end
	return response
end

local function probeJson(requestFn, url)
	local response = request(requestFn, url)
	if not response then
		return nil, "request gagal"
	end
	local status = statusOf(response)
	if status ~= 200 then
		return nil, "HTTP " .. tostring(status)
	end
	local decoded
	local ok = pcall(function()
		decoded = HttpService:JSONDecode(tostring(response.Body))
	end)
	local entry = ok and type(decoded) == "table" and type(decoded.data) == "table" and decoded.data[1] or nil
	if type(entry) ~= "table" then
		return nil, "bukan json thumbnail"
	end
	local imageUrl = entry.imageUrl
	if entry.state ~= "Completed" or type(imageUrl) ~= "string" or imageUrl == "" then
		return nil, string.format("state=%s", tostring(entry.state))
	end
	if not string.find(imageUrl, "/Image/", 1, true) then
		return nil, "url placeholder"
	end
	return imageUrl
end

local function probeBytes(requestFn, url)
	local response = request(requestFn, url)
	if not response then
		return nil, "request gagal"
	end
	local status = statusOf(response)
	local body = response.Body
	if status ~= 200 then
		return nil, "HTTP " .. tostring(status)
	end
	return body
end

local function multipart(webhookUrl, jsonPayload, fileName, mimeType, bytes)
	local boundary = "----OniumTest" .. tostring(math.random(100000, 999999))
	local body = table.concat({
		"--" .. boundary .. "\r\n",
		'Content-Disposition: form-data; name="payload_json"\r\n',
		"Content-Type: application/json\r\n\r\n",
		jsonPayload .. "\r\n",
		"--" .. boundary .. "\r\n",
		string.format('Content-Disposition: form-data; name="files[0]"; filename="%s"\r\n', fileName),
		"Content-Type: " .. mimeType .. "\r\n\r\n",
		bytes .. "\r\n",
		"--" .. boundary .. "--\r\n",
	}, "")
	return {
		Url = webhookUrl .. (string.find(webhookUrl, "?", 1, true) and "&" or "?") .. "wait=true",
		Method = "POST",
		Headers = { ["Content-Type"] = "multipart/form-data; boundary=" .. boundary },
		Body = body,
	}
end

local requestFn = resolveRequest()
if not requestFn then
	log("executor tidak punya request, tes tidak bisa jalan")
	return
end

log(string.format("mulai tes · asset=%s (%s)", ASSET_ID, PET_NAME))

local thumbnailApis = {
	string.format("https://thumbnails.roblox.com/v1/assets?assetIds=%s&returnPolicy=PlaceHolder&size=420x420&format=Png&isCircular=false", ASSET_ID),
	string.format("https://thumbnails.roblox.com/v1/assets?assetIds=%s&size=420x420&format=Png&isCircular=false", ASSET_ID),
	string.format("https://thumbnails.roblox.com/v1/assets?assetIds=%s&size=700x700&format=Png&isCircular=false", ASSET_ID),
}

local imageApis = {
	string.format("https://www.roblox.com/asset-thumbnail/image?assetId=%s&width=420&height=420&format=png", ASSET_ID),
	string.format("https://assetdelivery.roblox.com/v1/asset/?id=%s", ASSET_ID),
	string.format("https://assetdelivery.roblox.com/v2/assetId/%s", ASSET_ID),
}

local cdnUrl
local cdnRenderable = false
for _, url in ipairs(thumbnailApis) do
	local imageUrl, reason = probeJson(requestFn, url)
	log(string.format("json %s -> %s", url, imageUrl or ("gagal: " .. tostring(reason))))
	if imageUrl then
		if not cdnUrl then
			cdnUrl = imageUrl
		end
		if not cdnRenderable then
			local downloaded = probeBytes(requestFn, imageUrl)
			log(string.format("  cdn %s -> %s", imageUrl, describe(downloaded)))
			if type(downloaded) == "string"
				and (string.sub(downloaded, 1, 8) == PNG_SIGNATURE or string.sub(downloaded, 1, 3) == JPEG_SIGNATURE)
			then
				cdnRenderable = true
			end
		end
	end
end

local imageBytes, imageMime
local decalIds = {}
for _, url in ipairs(imageApis) do
	local body, reason = probeBytes(requestFn, url)
	log(string.format("raw %s -> %s", url, body and describe(body) or ("gagal: " .. tostring(reason))))
	if type(body) == "string" then
		if string.sub(body, 1, 8) == PNG_SIGNATURE then
			if not imageBytes then
				imageBytes, imageMime = body, "image/png"
			end
		elseif string.sub(body, 1, 3) == JPEG_SIGNATURE then
			if not imageBytes then
				imageBytes, imageMime = body, "image/jpeg"
			end
		else
			for assetId in string.gmatch(body, "roblox%.com/asset/%?id=(%d+)") do
				table.insert(decalIds, assetId)
			end
			for assetId in string.gmatch(body, "rbxassetid://(%d+)") do
				table.insert(decalIds, assetId)
			end
		end
	end
end

for _, assetId in ipairs(decalIds) do
	if assetId ~= ASSET_ID then
		local url = string.format("https://assetdelivery.roblox.com/v1/asset/?id=%s", assetId)
		local body = probeBytes(requestFn, url)
		log(string.format("decal %s -> %s", assetId, body and describe(body) or "gagal"))
		if type(body) == "string" then
			if string.sub(body, 1, 8) == PNG_SIGNATURE then
				imageBytes, imageMime = imageBytes or body, imageMime or "image/png"
			elseif string.sub(body, 1, 3) == JPEG_SIGNATURE then
				imageBytes, imageMime = imageBytes or body, imageMime or "image/jpeg"
			end
		end
	end
end

local webhookUrl = readWebhookUrl()
if webhookUrl == "" then
	log("webhook url tidak ditemukan, hanya laporan di atas yang bisa diberikan")
	return
end

local embed = {
	title = "Thumbnail Test",
	description = string.format("**%s**\n`asset %s`", PET_NAME, ASSET_ID),
	color = 5793266,
	fields = {
		{ name = "CDN URL", value = cdnUrl and ("`" .. cdnUrl .. "`") or "`tidak ada`", inline = false },
		{ name = "Bytes", value = imageBytes and string.format("`%s`", describe(imageBytes)) or "`tidak ada`", inline = false },
	},
	timestamp = DateTime.now():ToIsoDate(),
}

local sent = false
if imageBytes then
	local fileName = imageMime == "image/jpeg" and "test_pet.jpg" or "test_pet.png"
	embed.thumbnail = { url = "attachment://" .. fileName }
	local encoded = HttpService:JSONEncode({ embeds = { embed } })
	local ok, response = pcall(requestFn, multipart(webhookUrl, encoded, fileName, imageMime, imageBytes))
	if ok and type(response) == "table" and (statusOf(response) or 0) < 300 then
		sent = true
		log("kirim multipart (lampiran) -> sukses")
	else
		log(string.format("kirim multipart gagal: %s", ok and tostring(response.Body) or tostring(response)))
	end
end

if not sent then
	if cdnUrl then
		embed.thumbnail = { url = cdnUrl }
	end
	local encoded = HttpService:JSONEncode({ embeds = { embed } })
	local url = webhookUrl .. (string.find(webhookUrl, "?", 1, true) and "&" or "?") .. "wait=true"
	local ok, response = pcall(requestFn, {
		Url = url,
		Method = "POST",
		Headers = { ["Content-Type"] = "application/json" },
		Body = encoded,
	})
	if ok and type(response) == "table" and (statusOf(response) or 0) < 300 then
		log("kirim embed url -> sukses")
	else
		log(string.format("kirim embed url gagal: %s", ok and tostring(response.Body) or tostring(response)))
	end
end

log(string.format(
	"ringkasan · cdnPng=%s · bytes=%s · url=%s",
	tostring(cdnRenderable),
	imageBytes and describe(imageBytes) or "tidak ada",
	cdnUrl or "tidak ada"
))
log("selesai")
