-- Script path: ReplicatedStorage.CmdrClient.Commands.riftSimulate
-- Decompile time: 13.94 ms

local u0 = {
    Verdant = {
        EEE = 3.1,
        EEM = 32.1,
        EEH = 0.7,
        EMM = 61.1,
        EMH = 2.9,
        Distinct = 818,
    },
    Umbral = {
        EEE = 3.5,
        EEM = 32.2,
        EEH = 4.8,
        EMM = 43,
        EMH = 16.4,
        Distinct = 579,
    },
    Radiant = {
        EEE = 2.5,
        EEM = 32.4,
        EEH = 1.6,
        EMM = 57.1,
        EMH = 6.3,
        Distinct = 514,
    },
}
local u4 = {"EEE", "EEM", "EEH", "EMM", "EMH"}
return {
    Name = "riftSimulate",
    Description = "Simulates Rift recipe rolls per banner with the live flags and shows the difficulty mix in a panel. Runs on your client.",
    Group = "Admin",
    Aliases = {"riftSim"},
    Args = {
        {
            Type = "string",
            Name = "Banner",
            Description = "Banner id or display name (Verdant/Riftborn, Umbral/Riftbeasts, Radiant/Shattered Rift), or all.",
            Optional = true,
            Default = "all",
        },
        {
            Type = "integer",
            Name = "Runs",
            Description = "Recipes rolled per banner, up to 100000. Defaults to 10000.",
            Optional = true,
            Default = 10000,
        },
    },
    ClientRun = function(a1, a2, a3) -- Line: 37 -- upvalues: u0 (val), u4 (val) -- types: a2: string?, a3: number?
        local Distinct_3, Error_2, Failures_2, Id, NonZonePicks_2, color, patternLine, v1, v2, v3, v4, v5, v6, v7
        local Players = game:GetService("Players")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Rift = require(ReplicatedStorage.Data.Rift)
        local RiftRecipes = require(ReplicatedStorage.Shared.Modules.RiftRecipes)
        local RiftZoneLadder = require(ReplicatedStorage.Shared.Modules.RiftZoneLadder)
        local v8 = string.lower(a2 or "all")
        local v9 = {}
        local v10, v11 = a2, a3
        for i, j in Rift.BannerIds() do
            if v8 == "all" or string.lower(j) == v8 or string.lower(Rift.GetBannerDisplayName(j)) == v8 then
                table.insert(v9, j)
            end
        end
        if #v9 == 0 then
            return (("Unknown banner \"%*\" - use %* or all"):format(v10, (table.concat(Rift.BannerIds(), ", "))))
        end
        v8 = math.clamp(math.floor(v11 or 10000), 1, 100000)
        local u765 = {}

        local function line(a1, a2) -- Line: 57 -- upvalues: u765 (val) -- types: a1: string, a2: userdata?
            table.insert(u765, {text = a1, color = a2})
        end

        local v12 = {}
        for k, n in (RiftZoneLadder.Get()) do
            Id = n.Id
            table.insert(v12, (("%*.%*"):format(k, Id)))
        end
        table.insert(u765, {
            text = ("Zone ladder (by escape speed): %*"):format((table.concat(v12, "  "))),
            color = Color3.fromRGB(180, 180, 200),
        })
        local v13 = RiftRecipes.ResolveConfig()
        table.insert(u765, {
            text = ("Bands: Easy >= %*%%  Medium >= %*%%  Hard >= %*%%  |  HardPenalty %*  ExtendBelow %*  Attempts %*"):format(
                v13.EasyBand,
                v13.MediumBand,
                v13.MinSpawnChance,
                v13.HardPenalty,
                v13.ExtendBelow,
                v13.MaxRecipeAttempts
            ),
            color = Color3.fromRGB(180, 180, 200),
        })
        table.insert(u765, {text = ""})
        v13 = {}
        local v14 = nil
        local v15 = nil
        for m, i5 in v9, v14, v15 do
            v1, v2 = Rift.GetBannerRange(i5)
            local u716 = RiftRecipes.Simulate(i5, v8)
            table.insert(u765, {
                text = ("%* (%*)  %* -> %*"):format(Rift.GetBannerDisplayName(i5), i5, v1, v2),
                color = Color3.fromRGB(255, 220, 120),
            })
            if u716.Error == nil then
                table.insert(u765, {
                    text = ("  pool %* -> %* (%* pets: Easy %*  Medium %*  Hard %*  Excluded %*)"):format(
                        u716.PoolBottom,
                        u716.PoolTop,
                        u716.PoolSize,
                        u716.Bands.Easy,
                        u716.Bands.Medium,
                        u716.Bands.Hard,
                        u716.Bands.Excluded
                    ),
                })
                local u739 = v8 - u716.Failures
                v2 = if 0 < u716.Failures then Color3.fromRGB(255, 90, 90) else if not (0 < u716.NonZonePicks) then Color3.fromRGB(140, 230, 140) else Color3.fromRGB(255, 90, 90)
                table.insert(u765, {
                    text = ("  runs %*  failed %* (%*%%)  non-zone picks %*  distinct %* (ref %*)"):format(
                        v8,
                        u716.Failures,
                        string.format("%.2f", 100 * u716.Failures / v8),
                        u716.NonZonePicks,
                        u716.Distinct,
                        u0[i5] and u0[i5].Distinct or "-"
                    ),
                    color = v2,
                })
                table.insert(u765, {text = "  pattern     sim%     ref%    delta"})
                local u523 = {}

                function patternLine(a1) -- Line: 97
                    -- upvalues: u523 (val), u716 (val), u739 (val), u0 (upval), i5 (val), u765 (val)
                    u523[a1] = true
                    local v1 = u716.Patterns[a1]
                    v1 = if not (u739 > 0) then 0 else 100 * (v1 or 0) / u739
                    local v2 = u0[i5] and u0[i5][a1] or nil
                    local v3 = if v2 == nil then "      " else string.format("%+6.1f", v1 - v2)
                    local v4 = false
                    if v2 ~= nil then
                        v4 = 1.5 < (math.abs(v1 - v2))
                    end
                    table.insert(u765, {
                        text = ("  %*   %*  %*  %*"):format(
                            a1,
                            string.format("%7.2f", v1),
                            if v2 == nil then "     -" else string.format("%6.1f", v2),
                            v3
                        ),
                        color = if not v4 then nil else Color3.fromRGB(255, 170, 90),
                    })
                end

                for i6, i7 in u4 do
                    patternLine(i7)
                end
                for i8 in u716.Patterns do
                    if not u523[i8] then
                        patternLine(i8)
                    end
                end
                v3 = nil
                v4 = nil
                for i9, i10 in u716.SlotPicks, v3, v4 do
                    v1 = {}
                    for i11, i12 in i10 do
                        table.insert(v1, {i11, i12})
                    end
                    table.sort(v1, function(a1, a2) -- Line: 123
                        local v1 = a1[2]
                        return a2[2] < v1
                    end)
                    v5 = {}
                    for i13 = 1, (math.min(5, #v1)) do
                        v7 = v1[i13]
                        table.insert(v5, (("%* %*%%"):format(v7[1], (string.format("%.1f", 100 * v7[2] / (math.max(u739, 1)))))))
                    end
                    v7 = table.concat(v5, "  ")
                    table.insert(u765, {
                        text = ("  slot %* top: %*"):format(i9, v7),
                        color = Color3.fromRGB(170, 200, 255),
                    })
                end
                table.insert(u765, {text = ""})
                v6 = string.format("%.1f", if not (u739 > 0) then 0 else 100 * (u716.Patterns.EMH or 0) / u739)
                Distinct_3 = u716.Distinct
                Failures_2 = u716.Failures
                NonZonePicks_2 = u716.NonZonePicks
                table.insert(
                    v13,
                    (("%*: EMH %*%%  distinct %*  failed %*  non-zone %*"):format(i5, v6, Distinct_3, Failures_2, NonZonePicks_2))
                )
            else
                table.insert(u765, {
                    text = ("  ERROR: %*"):format(u716.Error),
                    color = Color3.fromRGB(255, 90, 90),
                })
                table.insert(u765, {text = ""})
                Error_2 = u716.Error
                table.insert(v13, (("%*: ERROR %*"):format(i5, Error_2)))
            end
        end
        v9 = Players.LocalPlayer:WaitForChild("PlayerGui")
        local v16 = v9:FindFirstChild("RiftSimulatePanel")
        if v16 then
            v16:Destroy()
        end
        local u364 = Instance.new("ScreenGui")
        u364.Name = "RiftSimulatePanel"
        u364.ResetOnSpawn = false
        u364.IgnoreGuiInset = true
        u364.DisplayOrder = 1000
        u364.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        local v17 = Instance.new("Frame")
        v17.Name = "Panel"
        v17.AnchorPoint = Vector2.new(0.5, 0.5)
        v17.Position = UDim2.fromScale(0.5, 0.5)
        v17.Size = UDim2.fromScale(0.72, 0.78)
        v17.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
        v17.BackgroundTransparency = 0.04
        v17.BorderSizePixel = 0
        v17.Parent = u364
        local v18 = Instance.new("UICorner")
        v18.CornerRadius = UDim.new(0, 10)
        v18.Parent = v17
        v18 = Instance.new("TextLabel")
        v18.Name = "Header"
        v18.Size = UDim2.new(1, -60, 0, 36)
        v18.Position = UDim2.fromOffset(14, 4)
        v18.BackgroundTransparency = 1
        v18.Font = Enum.Font.GothamBold
        v18.TextSize = 18
        v18.TextColor3 = Color3.fromRGB(255, 255, 255)
        v18.TextXAlignment = Enum.TextXAlignment.Left
        v18.Text = ("Rift recipe simulation - %* runs per banner"):format(v8)
        v18.Parent = v17
        v8 = Instance.new("TextButton")
        v8.Name = "RiftSimDismiss"
        v8.Size = UDim2.fromOffset(34, 28)
        v8.Position = UDim2.new(1, -42, 0, 8)
        v8.BackgroundColor3 = Color3.fromRGB(117, 38, 46)
        v8.BorderSizePixel = 0
        v8.Font = Enum.Font.GothamBold
        v8.TextSize = 18
        v8.TextColor3 = Color3.fromRGB(255, 255, 255)
        v8.Text = "X"
        v8.Parent = v17
        v18 = Instance.new("UICorner")
        v18.CornerRadius = UDim.new(0, 6)
        v18.Parent = v8
        v8.Activated:Connect(function() -- Line: 192 -- upvalues: u364 (val)
            u364:Destroy()
        end)
        v8 = Instance.new("ScrollingFrame")
        v8.Name = "Lines"
        v8.Position = UDim2.fromOffset(14, 44)
        v8.Size = UDim2.new(1, -28, 1, -56)
        v8.BackgroundTransparency = 1
        v8.BorderSizePixel = 0
        v8.ScrollBarThickness = 6
        v8.AutomaticCanvasSize = Enum.AutomaticSize.XY
        v8.CanvasSize = UDim2.new()
        v8.Parent = v17
        v17 = Instance.new("UIListLayout")
        v17.SortOrder = Enum.SortOrder.LayoutOrder
        v17.Padding = UDim.new(0, 1)
        v17.Parent = v8
        v17 = {}
        v14 = nil
        v15 = nil
        for i14, i15 in u765, v14, v15 do
            v18 = Instance.new("TextLabel")
            v18.Name = ("Line%*"):format(i14)
            v18.LayoutOrder = i14
            v18.AutomaticSize = Enum.AutomaticSize.XY
            v18.Size = UDim2.new(1, 0, 0, 16)
            v18.BackgroundTransparency = 1
            v18.Font = Enum.Font.Code
            v18.TextSize = 14
            v18.TextXAlignment = Enum.TextXAlignment.Left
            color = i15.color or Color3.fromRGB(230, 230, 235)
            v18.TextColor3 = color
            v18.Text = i15.text
            v18.Parent = v8
            table.insert(v17, i15.text)
        end
        u364.Parent = v9
        print("[riftSimulate]\n" .. table.concat(v17, "\n"))
        return table.concat(v13, "\n")
    end,
}