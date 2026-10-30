# Onium Hub

Script hub executor untuk game Roblox **Steal An Egg**. Repo ini berisi source hub yang dipakai komunitas, UI library-nya, referensi source pihak ketiga, dan wadah dokumentasi game.

Tujuan repo: satu sumber kebenaran yang rapi, mudah dibaca, mudah dimaintain, dan aman diubah per fitur — bukan kumpulan hasil deobfuscate.

---

## 1. Struktur Repo

| Path | Isi | Peran |
| --- | --- | --- |
| `Games/Steal-An-Egg.luau` | Hub utama game (single file, ±15.100 baris) | Kode produksi. Semua fitur, engine, dan UI hub ada di sini. |
| `Games/AstronSAE.luau` | Auto Steal baru (ditulis ulang dari nol, logika Chili) | Modul mandiri: katalog, kandidat, Move To Egg, Delivery (Fast Tween / Instant Steps / Walk), drop & re-grab, deposit. Panel UI minimal sendiri. |
| `Games/StealAnEgg/Prediction.luau` | Modul tab Predictor (±2890 baris) | Modul terpisah: baca egg, format uang/berat/waktu, gradient rarity, kartu preview besar, tombol status, grid kartu egg, fuse predictor, dan Discord webhook. Dimuat hub lewat URL. |
| `Games/StealAnEgg/EggFinder.luau` | Modul group `Egg Finder` (±840 baris) | Modul terpisah: sembilan kontrol hop, survey field per server, dan loop auto hop. Dimuat hub lewat URL. |
| `Library/OniumV4.luau` | UI library hub (turunan Obsidian, ±17.800 baris) | Komponen window, tab, groupbox, dan element. |
| `Manager/` | `FpsManger.luau`, `SaveManager.luau`, `ThemeManger.luau`, `ServerManger.luau` | Manager UI (performance, config, theme, server). Dimuat hub lewat URL, bukan dari sini. |
| `Source/ChiliHub.luau` | Source hasil deobfuscate (Chili Hub V3, ±53.000 baris) | **Referensi baca saja.** Bukan bahan copy-paste. |
| `Source/ChiliHubSourceV2.luau` | Source deobfuscate Chili Hub terbaru (±52.000 baris) | Referensi utama untuk logika Auto Steal (Fast Tween, drop/re-grab). **Referensi baca saja.** |
| `DexExploler/` | Dump `ReplicatedStorage` game (±1.900 file, hasil Dex) | Referensi baca saja: nama module, remote, dan alur asli game. |
| `README.md` | Dokumen ini | Peta arsitektur + aturan kerja. |

Aturan singkat: `Games/` dan `Library/` adalah milik kita. `Source/` hanya dibaca untuk memahami mekanik game.

---

## 2. Peta Arsitektur `Games/Steal-An-Egg.luau`

File dieksekusi dari atas ke bawah. Urutan bagian **adalah** urutan dependensi — jangan diacak.

| Bagian | Baris (indikatif) | Isi |
| --- | --- | --- |
| Bootstrap | 1 – 181 | Namespace `Hub` (Icons, Theme, Lifecycle, Features, UI), helper status label, load UI library + loading screen |
| 1. Game Modules & Remotes | 182 – 286 | `RequireGameModule`, modul game (EggState, Areas, Assets, Mutations, Save, dll), `NetworkFolder`, tabel `Remotes` |
| 2. Config, State & Catalog | 287 – 1004 | `FarmConfig` (semua flag fitur), `RuntimeState`, daftar opsi dropdown, katalog dinamis (rarity, egg, zona, place, weapon, mutation) |
| 3. Humanoid Swap & Anti-Ragdoll | 1005 – 1406 | Kontrol humanoid, swap clone, `RestoreCharacter`, guard anti-ragdoll |
| 4. Field Egg Scanner & Flight (Engine) | 1407 – 2106 | Klaim movement, pacing, fly/`RunPace`, `CollectRawFieldEggs`, `CollectCandidates`, trace |
| 5. Auto Steal & Fitur | 2107 – 12484 | Lihat tabel di bawah |
| 6. UI Builder & Lifecycle | 12486 – 14666 | `Build*` untuk setiap groupbox, pembuatan tab, manager, guard loop, unload handler |

Nomor baris di atas mengacu ke commit `b174da4` dan akan bergeser setiap kali file diedit — gunakan judul section sebagai acuan utama.

### Isi Bagian 5

| Sub | Baris | Isi |
| --- | --- | --- |
| 5A | 2110 – 2294 | Humanoid swap persisten + keeper health clone |
| 5B | 2295 – 3828 | Auto steal normal: fly, drop/regrab, deposit MoveTo |
| 5C | 3829 – 4097 | Safe zone visual (decoy + orbit camera) |
| 5D | 4098 – 10861 | Progression + semua modul fitur di dalam blok `do ... end` (lihat 5E–5R) |
| 5E | 4501 | Auto treadmill & auto place egg |
| 5F | 5450 | Auto hatch & auto equip |
| 5G | 5692 | Auto sell pets & eggs |
| 5H | 5860 | Auto mutation |
| 5I | 6289 | Auto fuse & favorite |
| 5J | 6777 | Halloween monsters & pumpkin boss |
| 5K | 7400 | Ghost dog quest & auto fishing |
| 5L | 8162 | Phantom express |
| 5M | 8684 | Auto butterfly bloom & workshop |
| 5N | 9219 | Auto wisp & banjo cricket |
| 5O | 9633 | Shooting star |
| 5P | 9874 | Player movement & character modifiers |
| 5R | 10351 | Admin abuse: Capture The Egg, Admin Treadmill, Instant Steal, Minigame Eggs |
| 5S | 10870 | Cursed Island Wars: bat swing, pumpkin launcher, regroup saat sudden death |
| 5Q | 10863 – 12484 | ESP suite (egg, guard, player, slot badge) |

Catatan struktur: pembatas scope di sini memakai `do ... end`. 5D membungkus 5E–5P dalam satu blok, 5L–5P punya blok bersarang sendiri, dan 5Q membungkus seluruh ESP. Variabel yang perlu dipakai lintas blok diekspos lewat `Hub.*`, bukan lewat variabel lokal.

### Modul Fitur → API Publik

Setiap modul fitur berpola sama: satu tabel state lokal, diakhiri satu baris `Hub.Nama = State`, lalu fungsi worker/loop di bawahnya.

| Modul | Expose | Baris |
| --- | --- | --- |
| Progression | `Hub.Progression` | 4106 |
| Treadmill | `Hub.Treadmill` | 4645 |
| Auto place | `Hub.AutoPlace` | 4972 |
| Auto hatch | `Hub.AutoHatch` | 5457 |
| Auto equip | `Hub.AutoEquip` | 5558 |
| Auto sell | `Hub.AutoSell` | 5698 |
| Auto mutate | `Hub.AutoMutate` | 5873 |
| Auto fuse | `Hub.AutoFuse` | 6299 |
| Favorite | `Hub.Favorite` | 6593 |
| Halloween monsters | `Hub.HalloweenMonsters` | 6791 |
| Pumpkin boss | `Hub.PumpkinBoss` | 6796 |
| Ghost dog & fishing | `Hub.GhostDogFishing` | 7413 |
| Phantom express | `Hub.PhantomExpress` | 8179 |
| Auto butterfly | `Hub.AutoButterfly` | 8701 |
| Wisp & banjo | `Hub.WispBanjo` | 9238 |
| Shooting star | `Hub.ShootingStar` | 9645 |
| Player modifiers | `Hub.PlayerModifiers` | 9889 |
| Admin abuse | `Hub.Admin` | 10357 |
| The hollow | `Hub.TheHollow` | 13212 |
| ESP | `Hub.ESP` | 10359 |
| Engine (movement/scanner) | `Hub.Engine` | 1463 |

Plus `Hub.Config`, `Hub.State`, `Hub.Remotes` (baris 430–432) dan `Hub.UI.*` (window, tabs, groups, status row).

Untuk debug di executor, state yang sama juga tersedia di `getgenv().N3Hub_State` (`Hub`, `FarmConfig`, `RuntimeState`) tanpa harus menyentuh UI.

### Layout UI

| Tab | Groupbox |
| --- | --- |
| Farm | Kiri: Farm Eggs — Kanan: Progression, Egg Finder |
| Pets | Kiri: Auto Place Egg, Auto Mutation, Auto Fuse — Kanan: Auto Hatch & Equip, Auto Sell, Favorite |
| Event | Kiri: Pumpkin Boss, Ghost Dog & Fishing, The Hollow — Kanan: Phantom Express, Halloween Monsters |
| Admin | Kiri: Capture The Egg, Instant Steal Abuse, Cursed Island Wars — Kanan: Admin Treadmill, Minigame Eggs |
| Quest | Kiri: Auto Butterfly — Kanan: Shooting Star |
| Player | Kiri: ESP — Kanan: Movement, Character |
| Predictor | Kiri: Discord Webhook, Egg Predictor — Kanan: Fuse Predictor |
| Settings | Kiri: Performance (FpsManager), Themes (ThemeManager) — Kanan: Server (ServerManager), Configuration (SaveManager). Tidak ada groupbox manual di hub. |

Setiap groupbox dibangun lewat satu fungsi `Hub.Features.Build*(group)`. Nama tombol mengikuti pola `Build + Nama Groupbox`, jadi wiring di bagian 6 tinggal satu baris per fitur.

### Tab Admin

Tab `Admin` dibuat setelah `Event` sehingga tampil tepat di bawahnya. Isinya empat groupbox, semuanya tanpa status label:

| Groupbox | Kontrol | Perilaku |
| --- | --- | --- |
| Capture The Egg (kiri) | `Auto Capture Event`, `Take It From The Holder`, `Hold height`, `Keep Away Distance` | Membaca `Event_CaptureTheEggUid`, mengambil egg lewat prompt `CarryAreaEgg` (fallback `EggState.CarryFieldEgg`), lalu menahannya di titik `Areas/EggCarryBounds` (grid 50 studs, margin 40) dengan tinggi `Hold height`. Titik dipilih yang jaraknya ke pemain lain dan `Areas/GuardAreas/*/Guard` minimal `Keep Away Distance`. |
| Admin Treadmill (kanan) | `Auto Admin Treadmill` | Menunggu `Workspace.AdminTreadmill` (Tool), mencari part belt (nama mengandung `belt`, fallback part terluas), berdiri di atasnya lalu `RF/Treadmill/AskWearStill`. |
| Instant Steal Abuse (kiri) | `Use Instan Steal Abuse` | Teleport ke field egg terdekat di luar base, panggil carry, lalu bawa pulang ke titik drop base dan `EggState.DropFieldEgg`. |
| Minigame Eggs (kanan) | `Auto Steal Minigame Eggs` | Memantau `Event_RedLightGreenLight` / `Event_TrexRun` beserta `<Prefix>_EggPosition` dan `<Prefix>_CarrierUserId`, lalu mengambil egg yang cocok (radius 40 studs) dari record `EggState`. |

Catatan implementasi:

- Keempat fitur memakai klaim movement sendiri (`capture`, `admintreadmill`, `instantsteal`, `minigame`), jadi tidak bisa mengemudi bersamaan, dan semuanya menyerah saat auto steal sedang berjalan (`IsAutoStealBusy`).
- `Take It From The Holder` hanya mengikuti holder: game tidak menyediakan remote untuk merebut egg dari tangan, jadi pengambilan tetap menunggu egg lepas.
- Titik drop base dipakai bersama oleh auto steal dan instant steal lewat `DELIVERY_DROP_CFRAME` di bagian 2.

### Group Cursed Island Wars (tab Admin)

Group `Cursed Island Wars` ada di kolom kiri tab `Admin`, setelah `Instant Steal Abuse`, dan hanya berisi dua kontrol, tanpa status label:

| Kontrol | Perilaku |
| --- | --- |
| `Island Wars Target` | `Enemies And Base` (default) memindai musuh dalam radius 25 studs lebih dulu; `Walls And Crystal` melewati pemindaian dan langsung menembak struktur tim lawan. |
| `Auto Play Curset Island Wars` | Saat `Match`/`SuddenDeath`: ayun `Bat` ke musuh terdekat (≤10 studs, cooldown 0.75 s) lewat `RE/IslandWars/Use` `"Swing"`, lalu tembak `PumpkinLauncher` ke musuh (prediksi `pos + vel * jarak/110`), `Barriers[team].Hitbox`, atau `Crystals[team].Pivot` lewat `"Launch"` (cooldown 1.25 s). Saat `SuddenDeath`, `Warning`, atau `CollapseWarn` aktif, karakter lari ke `Island.Centre.Top` bila jaraknya >18 studs. |

Catatan implementasi:

- Snapshot tim diambil dari `RE/IslandWars/State` dan `RF/IslandWars/Fetch` (dianggap valid 30 detik, refresh tiap 5 detik); event masuk/keluar dipantau lewat `RE/LiveEvents/Began`/`Ended`, cooldown & fase lewat `RE/IslandWars/Moment`.
- Fase `Prep` hanya dipakai untuk klaim movement (`islandwars`); serangan baru jalan setelah fase berganti ke `Match`/`SuddenDeath`.
- `Knock` milik modul `CursedIslandWars/Input` dinonaktifkan selama auto play supaya knock dari lawan tidak membuat karakter ragdoll, lalu dipulihkan saat toggle dimatikan, event selesai, atau script di-unload.
- Icon group memakai `Hub.Icons.Fights` (id stat Fights milik game) karena dex tidak menyimpan icon khusus Cursed Island Wars.

### Group Egg Finder (tab Farm)

Group `Egg Finder` ada di kolom kanan tab `Farm`, di bawah `Progression`. Semua logikanya di modul terpisah `Games/StealAnEgg/EggFinder.luau`; hub hanya membuat groupbox, menyimpan referensi dropdown Auto Steal, dan memasang `Hub.ServerHop` ke `ServerManager:Hop`.

| # | Kontrol | Tipe | Logika |
| --- | --- | --- | --- |
| 1 | Hop Mode | Dropdown | `Until An Egg Matches` / `Steal Then Hop` (default) / `After A Rare Spawns` |
| 2 | Rarity To Wait For | Dropdown | rarity minimum untuk mode `After A Rare Spawns`, default `Cosmic` |
| 3 | Min Rarity | Dropdown | egg dengan rarity ini atau lebih tinggi dianggap cocok |
| 4 | Target Areas | Multi dropdown | area yang dicari (kosong = semua area) |
| 5 | Target Specific Eggs | Multi dropdown | hanya egg ini (kosong = semua egg) |
| 6 | Min Value To Find | Slider | batas income egg dalam juta per detik, 0 = mati |
| 7 | First Hop Delay | Slider | 3–10 detik (langkah 0,5), jeda sebelum hop pertama |
| 8 | Auto Hop | Toggle | menyalakan loop survey + hop |
| 9 | Sync With Auto Steal Filter | Toggle | dua arah antara filter di sini dan `Zone`/`Egg`/`Rarity` Auto Steal |

Perilaku yang perlu diingat:

- **Sumber data survey** adalah `Engine.SurveyFieldEggs()` (record `Slot`/`Dropped`/`Carried` dari `EggState`, lengkap dengan zona, rarity, dan income) plus `Engine.AutoCarry` untuk tahu egg yang sedang dibawa sendiri. `Engine.MatchesStealFilters` dipakai untuk menghitung egg yang juga cocok filter Auto Steal.
- **Urutan keputusan** mengikuti Chili: Auto Steal sibuk atau egg cocok sedang dibawa → tunggu; egg cocok milik Auto Steal ada di field → ambil dulu; egg cocok bebas → diam di server; egg cocok sedang dibawa pemain lain → tunggu 12 detik; malam < 20 detik → diam; lalu perilaku per mode.
- **Mode 2 dan 3 memakai jendela hop** sampai `AreaEggCycle.NextNightTime`: setelah Auto Steal berhasil membawa pulang egg (`Engine.AutoDeliverySerial`) atau setelah rare spawn (`Rarity To Wait For`), hop berhenti sampai night berikutnya.
- **Sebelum teleport** field dibaca ulang; kalau ada egg cocok atau Auto Steal mulai bekerja, hop dibatalkan. Hop memakai `Least Players` lewat `Hub.ServerHop` → `ServerManager:Hop`, dan manager meng-queue script sekali jalan supaya hub kembali hidup di server baru walau toggle `Auto Load Script` tetap OFF.
- **Night atau wall tertutup** (`Engine.IsNight` / `Engine.WallSealed`) menghentikan hop sampai area reset.
- **Sync tidak menyentuh `Min Value To Find`.** Filter Auto Steal di Onium hanya zona, egg, dan rarity, jadi nilai minimum tetap milik Egg Finder. Karena dropdown rarity Onium multi-pilih sedangkan Egg Finder memakai satu batas minimum, sync rarity memakai rank terendah saat menarik dan menulis satu rarity saat mendorong (sama seperti perilaku Chili).
- **Icon group** memakai `Hub.Icons.EggFinder` (`rbxassetid://116524274262912`, base egg milik game) karena dex tidak menyimpan icon khusus "finder". Elemen OniumV4 (dropdown/slider/toggle) tidak punya slot icon per kontrol; icon hanya ada di level tab dan groupbox.

### Groupbox lebar (`Tab:AddFullGroupbox`)

Library aslinya hanya punya dua kolom: `AddLeftGroupbox` dan `AddRightGroupbox` (masing-masing 50% lebar tab). `AddFullGroupbox` menambahkan area ketiga, `TabFull`, yang berada di atas kedua kolom dengan lebar penuh:

- `TabFull` hanya dibuat saat sebuah tab memakai `AddFullGroupbox` pertama kali, jadi tab lain tidak berubah sama sekali.
- `TabFull` adalah satu-satunya ScrollingFrame di tab tersebut (`Size = 1, 1` dikurangi tinggi warning box), jadi seluruh isi tab digulir bersama: groupbox lebar, kolom kiri, dan kolom kanan. Tidak ada lagi scroll per kolom yang saling menutupi.
- Dua kolom lama (`TabLeft`/`TabRight`) dipindahkan ke dalam satu baris di bawah groupbox lebar, ukurannya mengikuti isi (`AutomaticSize.Y`), sehingga groupbox yang di-collapse langsung menaikkan groupbox di bawahnya.
- `Tab:RefreshSides()` hanya memperbarui posisi/ukuran area penuh (offset warning box). Tidak ada perubahan pada tab yang tidak memakai groupbox lebar.

### Tab Predictor

Tab `Predictor` dibuat sebelum `Settings` dan seluruh logikanya ada di modul terpisah `Games/StealAnEgg/Prediction.luau` supaya file hub tidak membengkak. Hub hanya membuat tab dan tiga groupbox (`Discord Webhook` lalu `Egg Predictor` di kiri, `Fuse Predictor` di kanan), lalu memanggil `PredictionModule.BuildWebhook`, `Build`, dan `BuildFuse`.

| Kontrol | Perilaku |
| --- | --- |
| `Sort By` | `Value` (income per detik), `Rarity` (rank rarity), `Time Left` (sisa waktu tumbuh paling dekat). |
| `Show Preview Card` | Menampilkan atau menyembunyikan kartu preview besar. |
| Kartu preview | Kotak art: gambar **pet** (`Assets.Directory[].Icon`) di atas tile + rays berputar + bayangan, dengan badge bulat berisi gambar egg di pojok kanan bawah (masih di dalam kotak art). Kolom teks: nama, mutasi, rarity, income, `xScale` + berat, bar durasi berisi sisa waktu + persen. |
| Tombol status | `ALL`, `READY`, `GROWING`, `IN BAG` dengan jumlah egg; yang aktif berisi gradient status, sisanya mengikuti warna theme. |
| Daftar egg | `ScrollingFrame` berisi grid kartu (2 kolom, 4 kartu terlihat, sisanya discroll). Tiap kartu: gambar pet + badge egg bulat di dalam art, label mutasi di kanan atas art, nama, rarity, income, `xScale` + berat, dan bar durasi; klik kartu untuk memilihnya di preview. |

Sumber data semuanya dari modul game, bukan karangan: `EggState.ReadOwnerEggs` (daftar egg), `EggState.IsReadyToHatch`, `EggRecords.GrowthSecondsRemaining` / `GrowthDuration` / `GrowthSpeedMultiplier` / `WeightKg` / `EggIcon`, `Assets.Directory` (nama, rarity, `EarningRate`, icon), dan `Mutations.EarningsFor` (multiplier mutasi). Income memakai rumus Chili: `EarningRate * ScaleFactor(scale) * MutationMultiplier`.

Layout tab (sejak groupbox lebar tersedia):

- Tab Predictor memakai tiga groupbox lebar berurutan: `Discord Webhook` (default collapsed, paling atas), `Egg Predictor`, lalu `Fuse Predictor`.
- `Egg Predictor` isinya dua kolom: kartu preview besar di kiri dan daftar kartu egg di kanan.
- Lebar preview mengikuti lebar tab (`32%`, dibatasi 208-252 px), daftar kanan selalu 4 kolom.
- Tombol `Show Preview Card` menyembunyikan preview dan membuat daftar memakai lebar penuh.
- Tombol `Go to egg` di kartu preview memanggil `Engine.FlyToPosition` ke posisi egg (`CollectRawFieldEggs` + `BoundsCFrame`); hub mengirimkannya lewat parameter kedua `Prediction.Build(groupbox, { OnGoToEgg = ... })` dan tombol tidak dibuat kalau hook tidak ada.

Catatan tampilan:

- Latar kartu memakai template rarity milik game: `ReplicatedStorage.Assets.UI.RarityGradients/<Rarity>` dibaca langsung (`ReadSurfaceStyle`) untuk mengambil `RarityGradient` (Color/Transparency/Rotation/Offset) dan `ItemTemplate` (BackgroundColor3, `UICorner`, `UIStroke` + gradient-nya). Jadi warna, gradient tajam, sudut, dan border kartu sama dengan tombol rarity di `AutoSell`, bukan tebakan.
- Semua kartu memakai satu gaya permukaan premium ala kartu LEGENDARY (`BuildPremiumSequence`: pita terang-gelap dari warna rarity), jadi setiap rarity punya background berkilau yang sama strukturnya tapi warnanya sesuai rarity-nya. `AnimateSurfaces` menggeser `Offset` sehingga pitanya berjalan.
- Teks rarity (kartu dan pill di preview) memakai `PaintSparkleText` dengan `BuildSparkleSequence`: pita highlight sempit yang bergerak, dan untuk SECRET dipakai kilau hitam-putih lembut (bukan gradasi pekat).
- Pill rarity di preview sekarang gelap dengan border gradient rarity dan teks berkilau, bukan teks tanpa warna.
- Kalau folder rarity tidak ada, warna jatuh ke `RarityColor` dari `Assets.Directory` lalu dicerahkan 14% (`BuildArtSequence`).
- Semua teks memakai font display bold + `UIStroke` gelap (`AddTextStroke`) dan bagian bawah kartu diberi shade gradient (`AddTextShade`), jadi teks tetap terbaca di kartu terang maupun gelap.
- Kartu list memakai lapisan gloss di art (`AddGloss`) dan bayangan lembut di belakang kartu untuk kesan timbul.
- Kartu preview: art pet + glow berputar, badge egg bundar, chip `RANK n` kiri atas, mutasi bertumpuk di kanan atas, nama bold, pill rarity, income besar, dua pill `SIZE`/`WEIGHT` (dengan icon), bar status, dan tombol `Go to egg` berikon egg.
- Icon pill dikirim hub lewat `Icons = { Size, Weight, Egg }` pada parameter kedua `Prediction.Build`, jadi gampang diganti tanpa menyentuh modul.
- Kartu list: chip `#n`, art + mutasi bertumpuk, baris waktu tersisa + `x` scale, nama, rarity, dan income.
- Gambar dan teks kartu dibuat manual di modul (bukan `AddImage`/`AddSpotlightCard` bawaan library), karena kartu memerlukan art persegi, bar berisi waktu, dan teks yang bisa diberi gradient per label. Hanya kontrol `Sort By` dan `Show Preview Card` yang memakai element library.
- Warna teks mengikuti palette Chili: income `#4DFF7A`, skala `#FFDF8A`, berat `#CDE7FF`, status Ready `#4DFF7A`, Growing `#FFC24D`, In Bag `#7FD8FF`.
- Gradient nama dan rarity diambil dari instance game `ReplicatedStorage.Assets.UI.RarityGradients/<rarityId>/RarityGradient` (rotation + color sequence di-crop seperti Chili), dengan `SECRET` memakai sequence khusus dan fallback `Color:Lerp(white, 0.35)` bila gradient tidak tersedia.
- Bar memakai pasangan warna status milik Chili (Ready `#AAFF96 -> #1ECD55`, Growing `#FFE178 -> #FF8228`, In Bag `#A0E1FF -> #3C8CFF`); angka waktu dan persen ditulis di tengah bar, persis seperti Chili.
- Garis hitam tipis pada versi pertama berasal dari `UIStroke` bawaan `AddSpotlightCard` (judul dan rarity), bukan dari modul; element itu sudah tidak dipakai lagi.
- Label bergradient wajib `TextColor3 = white`; warna dasar hitam membuat hasil gradient ikut gelap (bug versi kedua).
- Lebar frame kustom memakai `UDim2.new(1, -14, ...)` karena `Groupbox.Container` punya `UIPadding` 7px di tiap sisi; memakai `(1, 0)` membuat kartu melebar keluar dan teks terpotong.
- Warna permukaan, border, dan aksen kartu diambil dari `Groupbox.Holder` (background + `UIStroke` hasil `Library:AddOutline`) supaya mengikuti theme hub.
- Aksen mewah memakai `SHIMMER_SEQUENCE` warna rarity Secret yang berjalan **mengelilingi border** kartu (stroke kedua dengan `UIGradient` yang `Offset`-nya dianimasikan di `Heartbeat`), plus stroke kartu terpilih dan stroke kartu preview. Tidak ada lagi strip di satu sisi saja.
- Gambar utama kartu adalah **pet** (`Assets.Directory[category].Icon`), bukan egg; gambar egg (`Egg.Icon` / `EggRecords.EggIcon`) dipakai sebagai badge bulat kecil di pojok art.
- Mutasi dibaca dari `eggData.Mutations` lewat `Mutations.LabelOf` (label) dan `Mutations.Get().Tint` (warna), sehingga nama mutasi tidak di-hardcode; `Rainbow`/`Prismatic` diwarnai per huruf.

#### Group Discord Webhook

Groupbox `Discord Webhook` ada paling atas di kolom kiri dan default **collapsed**, isinya berurutan:

| Kontrol | Perilaku |
| --- | --- |
| `Webhook URL` | Input URL webhook Discord. Disimpan ke `Onium/StealAnEgg_Webhook.json` lewat `writefile` bila executor mendukung. |
| `Ping @Everyone` | Toggle; menambahkan `@everyone` di `content` dan `allowed_mentions.parse = {"everyone"}`. |
| `Notify On` | Multi dropdown: `Egg Stolen`, `Egg Fused`, `Egg Ready`. |
| `Webhook Min Rarity` | Dropdown rarity (`All` + daftar rarity dari `Assets.Directory`); hanya egg dengan rank ≥ pilihan yang dikirim. |
| `Webhook Min Value` | Input angka, menerima `250k`, `50m`, `1.5b`; hanya egg dengan income ≥ nilai itu yang dikirim. |
| `Webhook Eggs` | Multi dropdown semua egg (kosong = semua). |

Sumber event semuanya dari state game, tanpa menebak:

- `Egg Stolen` — ada UID baru di `Save.Peek().EggInventory` (inilah tabel tempat egg yang kamu dapat disimpan, bukan `Inventory` yang berisi pet). UID yang berasal dari reward fuse tidak dikirim sebagai stolen.
- `Egg Fused` — `FusionEggReward` berisi objek `{Uid, Egg}`; egg hasil fuse sudah membawa `AssetCategory`, `AssetScale`, dan `Mutations` sendiri, jadi embed memakai data hasil fuse yang asli lalu UID-nya ditandai supaya tidak ikut terkirim sebagai `Egg Stolen` saat diklaim.
- `Egg Ready` — egg di pen berubah status `Growing` → `Ready` (dari `EggState.ReadOwnerEggs` + `IsReadyToHatch`). Field `Source` berisi nama area dari `EggState.CarryChanged` + `Data.Areas.Directory` saat egg didapat dari mencuri, atau `Egg Inventory` / `Fuse Machine` / `Pen`.

Embed dibuat di modul: author nama pemain (dengan avatar headshot Roblox), judul event, deskripsi nama egg + rarity, warna embed dari `Rarity.Color`, field `Income` / `Size` / `Weight` / `Rarity` / `Mutation` / `Source`, thumbnail memakai thumbnail asset resmi (`thumbnails.roblox.com` dengan `returnPolicy=PlaceHolder`) yang diambil dari icon **pet** (`Assets.Directory[].Icon`) dan baru memakai icon egg bila thumbnail pet tidak tersedia. Alur gambar egg memakai tiga lapis, berhenti di lapis pertama yang berhasil:

1. **Jalur Chili** — `GET https://thumbnails.roblox.com/v1/assets?assetIds=<id>&returnPolicy=PlaceHolder&size=420x420&format=Png&isCircular=false`, wajib `HTTP 200`, `state == "Completed"`, dan `imageUrl` mengandung `/Image/`. Varian kedua tanpa `returnPolicy` dipakai bila yang pertama gagal.
2. **Render di dalam game** — kalau API hanya membalas URL placeholder (banyak asset baru seperti ini: `state=Completed` tetapi URL `/Placeholder/`), modul mengambil gambarnya lewat klien: `AssetService:CreateEditableImageAsync("rbxassetid://<id>")`, `ReadPixelsBuffer`, lalu piksel di-downscale ke 256x256 dan di-encode PNG sendiri (IHDR + IDAT dengan deflate stored block, CRC32 + Adler32). Hasilnya dikirim sebagai lampiran Discord (`attachment://onium_pet.png`), jadi Discord tidak perlu bisa menjangkau CDN Roblox.
3. **Unduh byte** — bila render tidak tersedia, byte diambil lewat `www.roblox.com/asset-thumbnail/image`, `assetdelivery` v2 (mengikuti `location`), lalu v1.

Bila ketiganya gagal, embed tetap dikirim dan masuk daftar perbaikan: dicek ulang tiap 2 detik (mundur sampai 10 detik, batas 120 detik) lalu `PATCH /webhooks/<id>/<token>/messages/<message_id>` menempelkan gambar ke pesan yang sudah ada. Hasil sukses di-cache per asset id.

Alat diagnosa `Games/StealAnEgg/WebhookThumbnailTest.luau` tidak dipanggil hub. Dijalankan manual di executor, ia membuka window kecil (`Webhook URL` otomatis terisi dari `Onium/StealAnEgg_Webhook.json`, `Asset ID`, dan dua tombol): `Send Chili Path` menembak API thumbnail persis cara Chili lalu mencetak body JSON mentahnya, sedangkan `Send Render In-Game` menjalankan jalur render `EditableImage` lalu mengirim PNG-nya sebagai lampiran. Skrip ini hanya alat diagnosa dan boleh dihapus setelah tidak diperlukan.

Seluruh teks di modul dan skrip tes memakai bahasa Inggris, tanpa komentar di dalam kode, dan console hanya diisi kegagalan (`[Onium Webhook] ...`) supaya Output tidak penuh saat farming.

#### Group Fuse Predictor

Groupbox `Fuse Predictor` ada di sisi kanan tab, isinya:

| Bagian | Perilaku |
| --- | --- |
| Kartu hasil | Kotak art berisi gambar egg. Saat mesin kosong atau belum 3 pet, yang tampil egg biasa dari species tersebut; saat fuse benar-benar berjalan (`FusionLocked` atau `FusionEggReward`) egg memakai gradient rarity + chip `PREDICTED`, warna mutasi prediksi, rentang income, rentang skala/berat, dan bar status (`FUSING hh mm ss` / `READY TO CLAIM`). |
| Slot 1–3 | Tiga baris kartu (bukan kolom, supaya teks tidak bertabrakan): art pet 34px dengan tile, label `SLOT n`, nama, `xScale` + income + mutasi sebaris, plus garis aksen gradient rarity di bawah. Slot kosong memakai art bergaris `+`, nama `Empty`, dan hint `Add a pet to this slot`. |
| Predicted Size | Tiga band skala paling mungkin: rentang skala, peluang (%), dan rentang berat Kg. Bila pet belum 3, baris diganti hint berapa pet lagi yang harus dimuat. |
| Fuse Cost | Biaya fuse dari `FuseKernel.PriceFor`, diformat `$1.20M`. |

Sumber datanya semua dari game: profil pemain `ReplicatedStorage.Shared.Save.Peek()` (`FusionSlots`, `Inventory`, `FusionLocked`, `FusionDuration`, `FusionEggReward`), band skala `Shared.Flags.GameplayBalance.Eggs.SCALE_BANDS` (fallback: upvalue `EggRecords.DrawAssetScale`), bias band `FuseKernel.BandWeightBias`, berat `EggRecords.WeightKgForScale`, dan harga `FuseKernel.PriceFor`.

Peluang band dihitung seperti Chili: `weight_band * BandWeightBias(scale ketiga pet, min, max)` lalu dinormalisasi menjadi persen. Prediksi mutasi memakai multiplier terbesar dari mutasi ketiga pet (`Mutations.EarningsFor`), dan income prediksi memakai rumus yang sama dengan kartu egg.

### Sumber yang Di-fetch

Semua dependensi runtime diambil dari repo ini sendiri, lewat satu konstanta di baris 16:

```lua
local REPO_RAW = "https://raw.githubusercontent.com/YienYun/Onium/refs/heads/<branch>/"
local CACHE_BUST = "?v=" .. tostring(os.time())

local function RepoFile(relativePath)
	return REPO_RAW .. relativePath .. CACHE_BUST
end
```

| Pemakai | File |
| --- | --- |
| `LibraryLoader` | `Library/OniumV4.luau` |
| `SaveManager` | `Manager/SaveManager.luau` |
| `ThemeManager` | `Manager/ThemeManger.luau` |
| `FpsManager` | `Manager/FpsManger.luau` |
| `ServerManager` | `Manager/ServerManger.luau` |
| `PredictionModule` | `Games/StealAnEgg/Prediction.luau` |

Ganti branch cukup di `REPO_RAW`. `CACHE_BUST` menempelkan timestamp supaya CDN GitHub tidak menyajikan versi lama setelah push — tanpa itu, file yang baru diubah bisa masih terbaca versi sebelumnya sampai beberapa menit. Nama file di URL harus sama persis dengan nama file di repo (termasuk `FpsManger`/`ThemeManger`).

### Alur Load (loading screen)

| Step | Pesan | Yang dikerjakan |
| --- | --- | --- |
| 1 | Load Engine | Service, namespace `Hub`, load library, loading screen |
| 2 | Load Data Replica | Modul game + katalog data |
| 3 | Load N3 Library | Network folder, remote, `Load All Requirements` |
| 4 | Load All Requirements | Manager (Fps/Save/Theme/Server), window, tab, groupbox, semua `Build*` |
| 5 | Verifying | Guard loop, manager setup, unload handler, `Library:Toggle(true)` |

---

## 3. UI Library (`Library/OniumV4.luau`)

Turunan library Obsidian dengan penambahan gradient, custom icon, theme Onium, dan groupbox selebar tab. Yang dipakai hub:

```lua
LibraryLoader:CreateLoading{ Title, Icon, TotalSteps, CurrentStep, ShowSidebar, AutoResizeHeight }
LibraryLoader:CreateWindow{ Title, Footer, Icon, AutoShow }
LibraryLoader:OnUnload(callback)
LibraryLoader:Toggle(state)

Window:AddTab(name, icon, description)
Tab:AddLeftGroupbox(name, icon) / Tab:AddRightGroupbox(name, icon)
Tab:AddFullGroupbox(name, icon)
Groupbox:AddToggle(index, { Text, Default, Tooltip, Callback })
Groupbox:AddDropdown(index, { Text, Values, Multi, Searchable, Default, Callback })
Groupbox:AddSlider(index, { Text, Min, Max, Rounding, Default, Suffix, Callback })
Groupbox:AddButton({ Text, Func })
Groupbox:AddLabel(text, doesWrap)
```

`index` pada element = key penyimpanan SaveManager. `AddLabel` dipakai lewat `Hub.Theme.CreateStatusLabel` supaya format status (`Prefix` + nilai) konsisten dan teks di-escape dengan benar.

---

## 4. Manager (`Manager/`)

Empat manager dimuat terpisah dari hub dan punya pola API sama: `SetLibrary(library)` untuk mendaftar unload, lalu satu fungsi pemasangan ke tab.

| Manager | Fungsi pasang | Isi |
| --- | --- | --- |
| FpsManager | `ApplyToTab(tab)` | FPS cap, optimizer, FPS & ping, disable 3D render, anti AFK |
| SaveManager | `BuildConfigSection(tab)` | Simpan/muat config per game |
| ThemeManager | `ApplyToTab(tab)` | Pilihan theme library |
| ServerManager | `ApplyToTab(tab)` | Server hop, job ID, rejoin, auto load script (kanan) |

### ServerManager

Satu groupbox `Server` di tab Settings, urutan kontrol:

| # | Kontrol | Tipe | Logika |
| --- | --- | --- | --- |
| 1 | Auto Load Script | Toggle | queue hub di `queue_on_teleport`, default OFF, klik ON memunculkan dialog Accept/Cancel |
| 2 | Server Hop Mode | Dropdown | urutan pilih server: most / random / least players |
| 3 | Server Hop | Button | ambil daftar server, pilih, teleport, ulangi kalau penuh |
| 4 | Job ID | Input | target Job ID, fallback ke clipboard |
| 5 | Join Job ID | Button | `TeleportToPlaceInstance` ke Job ID tersebut |
| 6 | Copy Current Job ID | Button | `game.JobId` ke input + clipboard |
| 7 | Rejoin Server | Button | teleport balik ke server yang sekarang |
| 8 | Auto Rejoin When Disconnect | Toggle | `RobloxPromptGui.promptOverlay` + `ErrorMessage` |

API publik manager: `BuildServerSection`, `ApplyToTab`, `Unload`, `SetLibrary`, `SetIcon`, `SetAutoLoadSource`, dan `Hop(mode)`.


Perilaku yang perlu diingat:

- **Auto execute default OFF.** Toggle `Auto Load Script` memakai dua kunci: `TeleportService:SetTeleportSetting` dan script antre via `queue_on_teleport`. Script antre membaca URL hub dari `ServerManager:SetAutoLoadSource(...)` (diisi hub lewat `RepoFile`), jadi hub menjalankan dirinya sendiri di server tujuan.
- **Konfirmasi sebelum aktif.** Toggle dibuat tanpa `Callback` dan dikaitkan ke klik tombolnya, jadi dialog Accept/Cancel hanya muncul dari klik user — config yang di-restore tidak pernah memunculkan dialog. Dialog dibuat lewat `task.defer` karena membangunnya di dalam event klik membuat dialog terbuka lalu langsung tertutup oleh input yang sama. Setelah Accept muncul notifikasi konfirmasi; kalau executor tidak punya queue on teleport, toggle otomatis balik OFF dan muncul notifikasi.
- **Signal terbatas aman.** `GuiService.ErrorMessageChanged` punya capability `RobloxScript` dan ditolak di banyak executor. Semua connect di manager lewat helper `TryConnect`, jadi signal yang diblokir dilewati tanpa mematikan groupbox.
- **Hop menyaring server penuh** (`playing < maxPlayers`) lewat endpoint publik `games.roblox.com`, menyimpan server yang gagal di `AvoidServers` agar tidak dipilih lagi, dan menyimpan cache daftar selama 60 detik.
- **Auto rejoin mengabaikan** disconnect akibat teleport sendiri (60 detik), pesan `banned`, `same account`, `duplicate player`, dan pesan yang mengandung kata `teleport`.
- **Input Job ID tidak ikut tersimpan** di config (`SaveManager:SetIgnoreIndexes`); toggle dan mode hop tetap tersimpan seperti kontrol lain.

---

## 5. Aturan Kerja

Kontrak yang dipakai di repo ini:

1. **Jangan mengarang logika.** Implementasi fitur mengikuti mekanik game yang sudah terbukti (referensi `Source/ChiliHub.luau` atau data di `ReplicatedStorage`). Kalau ada yang belum jelas, tanya dulu, jangan menebak.
2. **Jangan merusak perilaku yang sudah jalan.** Perubahan harus bisa dijelaskan baris per baris.
3. **Jangan menggemukkan file.** Tidak ada helper yang hanya dipakai sekali, tidak ada salinan logika yang sama dua kali.
4. **Tidak ada komentar sampah.** Komentar hanya untuk hal yang tidak terbaca dari kode: alasan, urutan remote, batasan game. Tidak ada komentar narasi baris-per-baris.
5. **Kode harus terbaca seperti kode normal.** Nama deskriptif, indentasi konsisten (tab), tidak ada one-liner padat hasil deobfuscate.
6. **Kelompokkan per logika.** Satu fitur = satu blok berurutan (state → helper → worker → expose → UI builder). Tidak ada baris yang lompat-lompat antar fitur.
7. **Urutan UI mengikuti urutan kode.** Tab → groupbox → `Build*`, sesuai urutan tampil di layar.
8. **Key SaveManager bersifat permanen.** Nama `Toggle_*`, `Dropdown_*`, dan nama groupbox adalah kunci config user. Ganti nama = config lama rusak. Hanya diubah kalau memang diminta.
9. **Tidak ada file baru di luar struktur** (`Games/`, `Library/`, `Source/`, `DexExploler/`). Tidak ada file bantu, skrip sementara, atau artefak generate yang ikut masuk repo.
10. **Satu fitur, satu perubahan.** Diskusi dulu, implementasi setelah disetujui, lalu diuji di executor.

---

## 6. Alur Verifikasi

Tidak ada build step. Siklusnya:

1. Edit `Games/Steal-An-Egg.luau` (atau `Library/OniumV4.luau`).
2. Copy isi file ke executor.
3. Jalankan di game, uji fitur yang berubah + fitur tetangga yang memakai fungsi yang sama.
4. Cek: loading screen selesai, tab tampil urut, toggle tersimpan (SaveManager), unload bersih tanpa error di console.

Yang wajib dicek setiap perubahan menyentuh bagian 5D: flag di `FarmConfig` harus punya pasangan reset di unload handler, dan `Gen`/`Busy` state harus tetap konsisten saat toggle dimatikan di tengah proses.

---

## 7. Referensi ChiliHub

`Source/ChiliHub.luau` adalah hasil deobfuscate: nama variabel sudah rusak (`mapTbl[46]`, `fnRef2`), struktur UI dan engine bercampur, dan banyak remote dipanggil dengan string literal.

Cara pakai yang benar:

- Baca untuk memahami **mekanik game**: nama remote, urutan argumen, timing, syarat server.
- Ambil perilaku, bukan kode. Implementasi di hub tetap ditulis ulang dengan gaya repo ini.
- Jangan copy blok apa pun secara utuh, termasuk komentar dan angka ajaib tanpa penjelasan.

---

## 8. Catatan Terbuka

Hal yang perlu keputusan sebelum lanjut:

1. **Semua dependensi di-fetch dari branch kerja, bukan dari `main`.** `REPO_RAW` menunjuk ke `refs/heads/arena/476c38f4-onium/` supaya setiap push langsung terpakai saat script dijalankan ulang. Sebelum rilis, ganti satu baris itu ke `refs/heads/main/` dan pastikan nama file di URL sudah sesuai nama final di repo.
2. **Hierarki section 5 menyesatkan.** 5A–5Q berada di bawah judul "Normal Auto Steal", dan 5D memuat 5E–5P di dalam blok `do ... end` miliknya. Secara logika isinya sudah benar, hanya penamaan/judulnya yang membuat pembaca salah kira.
3. **Unload handler manual.** Setiap flag di-`false`-kan satu per satu. Setiap fitur baru wajib menambah baris di sini, kalau tidak toggle bisa tertinggal menyala setelah unload.

---

## 9. Backlog

Belum ada item. Fitur dikerjakan satu per satu setelah permintaan eksplisit, dicatat di sini saat mulai:

| Fitur | Sumber acuan | Status |
| --- | --- | --- |
| Tab Admin (Capture The Egg, Admin Treadmill, Instant Steal, Minigame Eggs) | `Source/ChiliHub.luau` 31160–32600, `DexExploler` | Selesai, menunggu uji executor |
