-- Script path: ReplicatedStorage.Controllers.GUI.GlobalEventsController
-- Decompile time: 21.85 ms

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local BossMastery = require(ReplicatedStorage.Data.BossMastery)
local BossMasteryFlags = require(ReplicatedStorage.Shared.Flags.BossMasteryFlags)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local FallenPowerUp = require(ReplicatedStorage.Data.FallenPowerUp)
local Elapsed = require(ReplicatedStorage.Shared.Utils.Time).Elapsed
local GUI = require(ReplicatedStorage.Client.GUI)
local HoverCard = require(ReplicatedStorage.Client.HoverCard)
local LightVsDarknessEventFlags = require(ReplicatedStorage.Shared.Flags.LightVsDarknessEventFlags)
local MonsterParasite = require(ReplicatedStorage.Data.MonsterParasite)
local MonsterParasite_2 = require(ReplicatedStorage.Shared.Types.MonsterParasite)
local PlatformController = require(ReplicatedStorage.Client.PlatformController)
local PlayerEarningsBoost = require(ReplicatedStorage.Shared.Util.PlayerEarningsBoost)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local Sakura = require(ReplicatedStorage.Data.Sakura)
local SakuraBloomPolicy = require(ReplicatedStorage.Client.Modules.SakuraBloomPolicy)
local Save = require(ReplicatedStorage.Shared.Save)
local ServerLuck = require(ReplicatedStorage.Shared.Types.ServerLuck)
local u92 = {"RecoveryEvent"}
return {
    Start = function() -- Line: 43
        -- upvalues: GUI (val), BossMastery (val), MonsterParasite (val), MonsterParasite_2 (val), Players (val)
        -- upvalues: Save (val), SakuraBloomPolicy (val), u92 (val), Workspace (val), Elapsed (val), EggRecords (val)
        -- upvalues: PlayerEarningsBoost (val), BossMasteryFlags (val), FallenPowerUp (val)
        -- upvalues: LightVsDarknessEventFlags (val), Sakura (val), PlatformController (val), HoverCard (val)
        -- upvalues: Remotes (val), ServerLuck (val)
        local v1, v2
        local u2 = GUI.BottomUI()
        local BottomFrame = u2.BottomFrame
        local Holder = BottomFrame.Holder
        local List = Holder.List
        local Luck = List.Luck
        local Button = Luck.Button
        local TextLabel = Button.Content.Value.TextLabel
        local x2Luck = List.x2Luck
        local Timer = x2Luck.Timer
        local x2Growth = List.x2Growth
        local Timer_2 = x2Growth.Timer
        local PlayerEarningsBoost_2 = List.PlayerEarningsBoost
        local Timer_3 = PlayerEarningsBoost_2.Timer
        local Value = PlayerEarningsBoost_2.Value
        local u20 = PlayerEarningsBoost_2:Clone()
        local v3 = assert((BossMastery.GetShopProduct("SpeedBoost")))
        u20.Name = "BossSpeedBoost"
        u20.Icon.Image = v3.Icon
        u20.LayoutOrder = PlayerEarningsBoost_2.LayoutOrder + 1
        u20.Visible = false
        u20.Parent = List
        local PlayerSpeedBoost = List:FindFirstChild("PlayerSpeedBoost")
        local u42 = MonsterParasite.BoostMultiplier(MonsterParasite_2.BoostKinds.Speed)
        local PlayerEggGrowthBoost = List:FindFirstChild("PlayerEggGrowthBoost")
        local u52 = MonsterParasite.BoostMultiplier(MonsterParasite_2.BoostKinds.EggGrowth)
        local AdBoostx2Growth = List:FindFirstChild("AdBoostx2Growth")
        local LocalPlayer = Players.LocalPlayer
        local u59 = {}
        u59.Magnet = {
            Frame = List:FindFirstChild("PowerUpMagnet"),
            Tooltip = {
                {kind = "heading", text = "RING MAGNET"},
                {kind = "rule"},
                {kind = "heading", text = "Nearby rings fly straight to you!"},
            },
        }
        u59.x2Rings = {
            Frame = List:FindFirstChild("PowerUpx2Rings"),
            Tooltip = {
                {kind = "heading", text = "2X RINGS"},
                {kind = "rule"},
                {kind = "heading", text = "Every ring you collect counts double!"},
            },
        }
        u59.Fusion = {
            Frame = List:FindFirstChild("PowerUpFusion"),
            Tooltip = {
                {kind = "heading", text = "FUSION"},
                {kind = "rule"},
                {kind = "heading", text = "Charged with fusion energy!"},
            },
        }
        local u87 = {}
        u87.Countdown = {Frame = List:FindFirstChild("Countdown")}
        u87.DemonicEvent = {
            Frame = List:FindFirstChild("DemonicEvent"),
            Tooltip = {{kind = "heading", text = "A DEMONIC EGG HAS SPAWNED"}},
        }
        u87.DragonEggEvent = {
            HideTimer = true,
            Frame = List:FindFirstChild("DragonEggEvent"),
            Tooltip = {{kind = "heading", text = "A DRAGON HAS DESCENDED"}},
        }
        u87.GreatBloom = {
            Frame = List:FindFirstChild("GreatBloom"),
            Tooltip = {
                {kind = "heading", text = "🌸 THE GREAT BLOOM 🌸"},
                {kind = "rule"},
                {kind = "heading", text = "Bat Crystal Sakura Trees for Sakura Crystals!"},
            },
        }
        u87.EggLuckBoost = {
            ShowMultiplier = true,
            Frame = List:FindFirstChild("EggLuckBoost"),
            Tooltip = {
                {kind = "heading", text = "EGG LUCK BOOST"},
                {kind = "rule"},
                {kind = "heading", text = "Rarer eggs are spawning on the map!"},
            },
        }
        u87.EggSizeBoost = {
            ShowMultiplier = true,
            Frame = List:FindFirstChild("EggSizeBoost"),
            Tooltip = {
                {kind = "heading", text = "EGG SIZE BOOST"},
                {kind = "rule"},
                {kind = "heading", text = "Bigger eggs are spawning on the map!"},
            },
        }
        u87.EarningsBoost = {
            ShowMultiplier = true,
            Frame = List:FindFirstChild("EarningsBoost"),
            Tooltip = {
                {kind = "heading", text = "EARNINGS BOOST"},
                {kind = "rule"},
                {kind = "heading", text = "Your pets earn more cash!"},
            },
        }
        u87.SpeedBoost = {
            ShowMultiplier = true,
            Frame = List:FindFirstChild("SpeedBoost"),
            Tooltip = {
                {kind = "heading", text = "SPEED BOOST"},
                {kind = "rule"},
                {kind = "heading", text = "Everyone runs faster!"},
            },
        }
        u87.MutationBoost = {
            ShowMultiplier = true,
            Frame = List:FindFirstChild("MutationBoost"),
            Tooltip = {
                {kind = "heading", text = "MUTATION BOOST"},
                {kind = "rule"},
                {kind = "heading", text = "Mutated eggs are more common!"},
            },
        }
        u87.AdminTreadmill = {
            ShowMultiplier = true,
            Frame = List:FindFirstChild("AdminTreadmill"),
            Tooltip = {
                {kind = "heading", text = "ADMIN TREADMILL"},
                {kind = "rule"},
                {
                    kind = "heading",
                    text = "Run on the Admin Treadmill in the base for multiplied speed gains!",
                },
            },
        }
        u87.MonsterEvent = {
            Frame = List:FindFirstChild("MonsterEvent"),
            Tooltip = {{kind = "heading", text = "A MONSTER HAS SPAWNED"}},
        }
        local AnchorPoint = BottomFrame.AnchorPoint
        local Position = BottomFrame.Position
        local AnchorPoint_2 = Holder.AnchorPoint
        local Position_2 = Holder.Position
        local AnchorPoint_3 = List.AnchorPoint
        local Position_3 = List.Position
        local Size = List.Size
        local u482 = {Multiplier = 1}
        local u484 = {}
        local u486 = {}

        local function isBloomUnlocked() -- Line: 241 -- upvalues: Save (upval), SakuraBloomPolicy (upval)
            local v1 = Save.IsLoaded()
            return SakuraBloomPolicy.HasBloomUnlocked(v1, if not v1 then nil else Save.Peek())
        end

        local function escapeRichText(a1) -- Line: 247 -- types: a1: string
            return ((a1:gsub("&", "&amp;")):gsub("<", "&lt;")):gsub(">", "&gt;")
        end

        local function getMultiplierText() -- Line: 251 -- upvalues: u482 (ref)
            return (("x%*"):format((math.max(1, (math.floor(u482.Multiplier))))))
        end

        local function getBoosterText() -- Line: 255 -- upvalues: u482 (ref)
            local BoostedByDisplayName = u482.BoostedByDisplayName
            if BoostedByDisplayName ~= nil and BoostedByDisplayName ~= "" then
                return (("<font color=\"#38E839\">@%*</font>"):format((((BoostedByDisplayName:gsub("&", "&amp;")):gsub("<", "&lt;")):gsub(">", "&gt;"))))
            end
            return "<font color=\"#38E839\">@Server</font>"
        end

        local function formatMultiplier(a1) -- Line: 275 -- types: a1: number
            return (("x%*"):format(math.floor(a1 * 100 + 0.5) / 100))
        end

        local function getEventMultiplierText(a1) -- Line: 280 -- upvalues: u486 (ref) -- types: a1: string
            local Multiplier
            local v1 = u486[a1]
            if type(if type(v1) ~= "table" then nil else v1.Multiplier) ~= "number" then
                return ""
            end
            return (("x%*"):format((math.floor(Multiplier * 100 + 0.5)) / 100))
        end

        local function getRemainingSeconds(a1, a2) -- Line: 291 -- upvalues: u484 (ref) -- types: a1: string, a2: number
            local v1 = u484[a1]
            if v1 == nil then
                return 0
            end
            return (math.max(0, (math.ceil(v1 - a2))))
        end

        local function getBuffRemainingSeconds(a1) -- Line: 303
            -- upvalues: u92 (upval), u484 (ref)
            local v1
            local v2 = 0
            local v3 = nil
            local v4 = nil
            for i, j in u92, v3, v4 do
                v1 = u484[j]
                v2 = math.max(v2, if v1 ~= nil then math.max(0, (math.ceil(v1 - a1))) else 0)
            end
            return v2
        end

        local function getMonsterBoostSeconds(a1, a2, a3) -- Line: 316
            -- upvalues: MonsterParasite_2 (upval)
            if a1 == nil then
                return 0
            end
            return MonsterParasite_2.BoostRemainingSeconds(a1.MonsterParasite, a2, a3)
        end

        local function render(a1) -- Line: 332
            -- upvalues: Workspace (upval), u482 (ref), u92 (upval), u484 (ref), Elapsed (upval), Luck (val)
            -- upvalues: TextLabel (val), x2Luck (val), Timer (val), x2Growth (val), Timer_2 (val), EggRecords (upval)
            -- upvalues: List (val), PlayerEarningsBoost (upval), LocalPlayer (val), PlayerEarningsBoost_2 (val)
            -- upvalues: Timer_3 (val), Value (val), Save (upval), MonsterParasite_2 (upval), u20 (val)
            -- upvalues: BossMasteryFlags (upval), PlayerSpeedBoost (val), u42 (val), PlayerEggGrowthBoost (val)
            -- upvalues: u52 (val), AdBoostx2Growth (val), u59 (val), FallenPowerUp (upval)
            -- upvalues: LightVsDarknessEventFlags (upval), u87 (val), Sakura (upval), SakuraBloomPolicy (upval)
            -- upvalues: u486 (ref), u2 (val)
            local Frame, Multiplier_2, v1, v2, v3, v4, v5
            local ServerTimeNow = a1 or Workspace:GetServerTimeNow()
            local v6 = 1 < u482.Multiplier
            local v7 = 0
            local v8 = nil
            local v9 = nil
            for i, j in u92, v8, v9 do
                v2 = u484[j]
                v7 = math.max(v7, if v2 ~= nil then math.max(0, (math.ceil(v2 - ServerTimeNow))) else 0)
            end
            local v10 = v7 > 0
            v8 = Elapsed(v7)
            Luck.Visible = v6
            TextLabel.Text = ("x%*"):format((math.max(1, (math.floor(u482.Multiplier)))))
            v7 = Luck:FindFirstChild("Timer")
            if v7 then
                v7.Visible = 0 < (if not u482.ExpiresAt then 0 else u482.ExpiresAt - ServerTimeNow)
                v7.Text = if not (v9 > 0) then "" else Elapsed((math.ceil(v9)))
            end
            x2Luck.Visible = v10
            Timer.Text = v8
            x2Growth.Visible = v10
            Timer_2.Text = v8
            v8 = EggRecords.ServerGrowthBoostMultiplier() or 0
            v7 = List:FindFirstChild("GrowthBoost")
            if not (v8 > 0) then
                v7.Visible = false
            else
                local Timer_4 = v7:FindFirstChild("Timer")
                local Value_2 = v7:FindFirstChild("Value")
                v5 = EggRecords.ServerGrowthBoostEndsAt() - ServerTimeNow
                Timer_4.Visible = v5 > 0
                Timer_4.Text = if not (v5 > 0) then "" else Elapsed((math.ceil(v5)))
                v7.Visible = true
                Value_2.Text = ("x%*"):format(v8 + 1)
            end
            v9, v4 = PlayerEarningsBoost.GetActive(LocalPlayer, ServerTimeNow)
            PlayerEarningsBoost_2.Visible = v4 > 0
            Timer_3.Text = Elapsed((math.ceil(v4)))
            Value.Text = ("x%*"):format(v9)
            v4 = Save.Peek()
            local Speed = MonsterParasite_2.BoostKinds.Speed
            v9 = if v4 ~= nil then MonsterParasite_2.BoostRemainingSeconds(v4.MonsterParasite, Speed, ServerTimeNow) else 0
            local EggGrowth = MonsterParasite_2.BoostKinds.EggGrowth
            v5 = if v4 ~= nil then MonsterParasite_2.BoostRemainingSeconds(v4.MonsterParasite, EggGrowth, ServerTimeNow) else 0
            local v11 = v9 > 0
            local v12 = v5 > 0
            u20.Visible = (if v4 == nil then 0 else math.max(0, (v4.BossMastery.SpeedBoostExpiresAt or 0) - ServerTimeNow)) > 0
            u20.Timer.Text = Elapsed((math.ceil(v1)))
            u20.Value.Text = ("x%*"):format(math.floor((BossMasteryFlags.SpeedBoostMultiplier:Get()) * 100 + 0.5) / 100)
            if PlayerSpeedBoost then
                PlayerSpeedBoost.Visible = v11
                PlayerSpeedBoost.Timer.Text = Elapsed((math.ceil(v9)))
                PlayerSpeedBoost.Value.Text = ("x%*"):format(math.floor(u42 * 100 + 0.5) / 100)
            end
            if PlayerEggGrowthBoost then
                PlayerEggGrowthBoost.Visible = v12
                PlayerEggGrowthBoost.Timer.Text = Elapsed((math.ceil(v5)))
                PlayerEggGrowthBoost.Value.Text = ("x%*"):format(math.floor(u52 * 100 + 0.5) / 100)
            end
            v5 = LocalPlayer:GetAttribute("AdEggBoostExpiresAt")
            v5 = (if typeof(v5) ~= "number" then 0 else math.max(0, v5 - ServerTimeNow)) > 0
            if AdBoostx2Growth then
                AdBoostx2Growth.Visible = v5
                if v5 then
                    AdBoostx2Growth.Timer.Text = Elapsed((math.ceil(v2)))
                end
            end
            v2 = v6
            if not v2 then
                v2 = v10
                if not v2 then
                    v2 = true
                    if not (v8 > 0) then
                        v2 = v7 or v4 or v11 or v12 or v5
                    end
                end
            end
            local v13 = nil
            local v14 = nil
            for k, n in u59, v13, v14 do
                Frame = n.Frame
                if Frame then
                    v11 = FallenPowerUp.ActiveUntil(LocalPlayer, k) - ServerTimeNow
                    if not (v11 > 0) then
                        Frame.Visible = false
                    else
                        Frame.Timer.Text = Elapsed((math.ceil(v11)))
                        Frame.Value.Text = if not n.ShowValue then "" else ("x%*"):format((LightVsDarknessEventFlags.PowerUpRingMultiplier:Get()))
                        Frame.Visible = true
                        v2 = true
                    end
                end
            end
            v13 = nil
            v14 = nil
            for m, i5 in u87, v13, v14 do
                if i5.Frame then
                    v4 = u484[m]
                    v5 = if v4 ~= nil then math.max(0, (math.ceil(v4 - ServerTimeNow))) else 0
                    v8 = true
                    if m == Sakura.EventName then
                        v10 = Save.IsLoaded()
                        v7 = if not v10 then nil else Save.Peek()
                        v8 = SakuraBloomPolicy.HasBloomUnlocked(v10, v7)
                    end
                    if not (v5 > 0) or not v8 then
                        i5.Frame.Visible = false
                    else
                        i5.Frame.Timer.Text = Elapsed(v5)
                        i5.Frame.Timer.Visible = i5.HideTimer ~= true
                        if i5.ShowMultiplier then
                            v6 = i5.Frame:FindFirstChild("Value")
                            if v6 then
                                v3 = u486[m]
                                Multiplier_2 = if type(v3) ~= "table" then nil else v3.Multiplier
                                v6.Text = if type(Multiplier_2) == "number" then ("x%*"):format(math.floor(Multiplier_2 * 100 + 0.5) / 100) else ""
                            end
                        end
                        i5.Frame.Visible = true
                        v2 = true
                    end
                end
            end
            u2.Enabled = v2
        end

        local function renderPlatform(a1) -- Line: 499
            -- upvalues: PlatformController (upval), BottomFrame (val), Holder (val), List (val), AnchorPoint (val)
            -- upvalues: Position (val), AnchorPoint_2 (val), Position_2 (val), AnchorPoint_3 (val), Position_3 (val)
            -- upvalues: Size (val)
            if PlatformController.IsMobile() then
                BottomFrame.AnchorPoint = Vector2.new(1, 0)
                BottomFrame.Position = UDim2.fromScale(0.98, 0.07)
                Holder.AnchorPoint = Vector2.new(1, 0)
                Holder.Position = UDim2.fromScale(1, 0)
                List.AnchorPoint = Vector2.new(0.5, 0)
                List.Position = UDim2.fromScale(0.5, 0)
                List.Size = UDim2.fromScale(0.975, 0.5)
                return
            end
            BottomFrame.AnchorPoint = AnchorPoint
            BottomFrame.Position = Position
            Holder.AnchorPoint = AnchorPoint_2
            Holder.Position = Position_2
            List.AnchorPoint = AnchorPoint_3
            List.Position = Position_3
            List.Size = Size
        end

        local function applyState(a1) -- Line: 520 -- upvalues: u482 (ref), render (val)
            u482 = a1
            render()
        end

        HoverCard.Attach(Button, function() -- Line: 264 -- upvalues: u482 (ref)
            local v1 = {}
            local v2 = {
                kind = "heading",
                text = ("<font color=\"#38E839\">%*</font> Server Luck!"):format((("x%*"):format((math.max(1, (math.floor(u482.Multiplier))))))),
            }
            local v3 = {kind = "heading"}
            local BoostedByDisplayName = u482.BoostedByDisplayName
            v3.text = ("Boosted by %*!"):format(if BoostedByDisplayName == nil then "<font color=\"#38E839\">@Server</font>" else if BoostedByDisplayName ~= "" then ("<font color=\"#38E839\">@%*</font>"):format((((BoostedByDisplayName:gsub("&", "&amp;")):gsub("<", "&lt;")):gsub(">", "&gt;"))) else "<font color=\"#38E839\">@Server</font>")
            v1[1] = v2
            v1[2] = {kind = "rule"}
            v1[3] = v3
            return v1
        end)
        HoverCard.Attach(x2Luck.Icon, {{kind = "heading", text = "X2 LUCK"}})
        HoverCard.Attach(x2Growth.Icon, {{kind = "heading", text = "X2 EGG GROWTH SPEED"}})
        HoverCard.Attach(List:FindFirstChild("GrowthBoost"), {{kind = "heading", text = "GROWTH BOOSTED!"}})
        HoverCard.Attach(PlayerEarningsBoost_2.Icon, function() -- Line: 525 -- upvalues: PlayerEarningsBoost (upval), LocalPlayer (val)
            local v1 = PlayerEarningsBoost.GetActive(LocalPlayer)
            return {
                {kind = "heading", text = ("X%* EARNINGS"):format(v1)},
                {kind = "rule"},
                {kind = "heading", text = ("Your pets earn %*x cash!"):format(v1)},
            }
        end)
        HoverCard.Attach(u20.Icon, {
            {
                kind = "heading",
                text = ("X%* SPEED"):format((BossMasteryFlags.SpeedBoostMultiplier:Get())),
            },
            {kind = "rule"},
            {kind = "heading", text = "You run faster!"},
        })
        ;(PlayerEarningsBoost.GetChangedSignal(LocalPlayer)):Connect(function() -- Line: 554 -- upvalues: render (val)
            render()
        end)
        ;(LocalPlayer:GetAttributeChangedSignal(PlayerEarningsBoost.BONUS_EXPIRES_AT_ATTRIBUTE)):Connect(render)
        BossMasteryFlags.CashBoosterMultiplier.Changed:Connect(render)
        BossMasteryFlags.SpeedBoostMultiplier.Changed:Connect(render)
        if PlayerSpeedBoost then
            HoverCard.Attach(PlayerSpeedBoost.Icon, {
                {kind = "heading", text = ("X%* SPEED"):format(u42)},
                {kind = "rule"},
                {kind = "heading", text = "You run faster!"},
            })
        end
        if PlayerEggGrowthBoost then
            HoverCard.Attach(PlayerEggGrowthBoost.Icon, {
                {kind = "heading", text = ("X%* EGG GROWTH"):format(u52)},
                {kind = "rule"},
                {kind = "heading", text = "Your eggs grow faster!"},
            })
        end
        if AdBoostx2Growth then
            HoverCard.Attach(AdBoostx2Growth.Icon, {
                {kind = "heading", text = "X2 EGG GROWTH"},
                {kind = "rule"},
                {kind = "heading", text = "Watch ads to grow eggs faster!"},
            })
        end
        ;(LocalPlayer:GetAttributeChangedSignal("AdEggBoostExpiresAt")):Connect(render)
        for i, j in u87 do
            if j.Frame and j.Tooltip then
                HoverCard.Attach(j.Frame.Icon, j.Tooltip)
            end
        end
        local v4 = nil
        local v5 = nil
        for k, n in u59, v4, v5 do
            if n.Frame then
                v1 = n.Frame.Icon:FindFirstChild("ModelView")
                if v1 then
                    v1:Destroy()
                end
                n.Frame.Icon.Image = FallenPowerUp.IconFor(k)
                HoverCard.Attach(n.Frame.Icon, n.Tooltip)
                ;(LocalPlayer:GetAttributeChangedSignal((FallenPowerUp.AttributeFor(k)))):Connect(function() -- Line: 602 -- upvalues: render (val)
                    render()
                end)
            end
        end
        render()
        PlatformController.Observe(renderPlatform)
        Remotes.LuckWindow.StateRefreshed.OnClientEvent:Connect(function(a1) -- Line: 610 -- upvalues: ServerLuck (upval), u482 (ref), render (val)
            if ServerLuck.State(a1) then
                u482 = a1
                render()
            end
        end)
        local v6 = Remotes.LuckWindow.FetchState:InvokeServer()
        if ServerLuck.State(v6) then
            render()
        end
        Remotes.LiveEvents.Began.OnClientEvent:Connect(function(a1, a2, a3) -- Line: 622
            -- upvalues: u484 (ref), Workspace (upval), u486 (ref), render (val)
            u484[a1] = Workspace:GetServerTimeNow() + a2
            u486[a1] = a3
            render()
        end)
        Remotes.LiveEvents.Ended.OnClientEvent:Connect(function(a1) -- Line: 629 -- upvalues: u484 (ref), u486 (ref), render (val) -- types: a1: string
            u484[a1] = nil
            u486[a1] = nil
            render()
        end)
        Save.WatchFields("Sakura", function() -- Line: 635 -- upvalues: render (val)
            render()
        end)
        Save.WatchFields("MonsterParasite", function() -- Line: 638 -- upvalues: render (val)
            render()
        end)
        Save.WatchFields("BossMastery", function() -- Line: 641 -- upvalues: render (val)
            render()
        end)
        v2, v4 = Remotes.LiveEvents.FetchRunning:InvokeServer()
        render()
        task.spawn(function() -- Line: 651 -- upvalues: render (val)
            while true do
                task.wait(1)
                render()
            end
        end)
    end,
}