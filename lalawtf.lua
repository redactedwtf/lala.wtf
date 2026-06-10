local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/sametexe001/juanitahaxx/refs/heads/main/Library.lua"))()
local esp = loadstring(game:HttpGet("https://raw.githubusercontent.com/rthusrtghdfhtyjkehrfh/sensoryESP/refs/heads/main/ESP.lua"))()

local cfg = {
    menu = "lala.wtf",
    watermark = "lala.wtf",
    typewriter = {
        char_delay = 0.09,
        erase_delay = 0.055,
        pause_after = 1.2,
        pause_clear = 0.4,
    },
    notifs = {
        lock = "drag locked",
        unlock = "drag unlocked",
        duration = 2,
    },
    buttons = {
        y = 80,
        height = 32,
        toggle_w = 76,
        lock_w = 66,
        gap = 6,
        start_x = 10,
    },
}

local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local gs = game:GetService("GuiService")
local ts = game:GetService("TweenService")
local plrs = game:GetService("Players")
local ws = game:GetService("Workspace")
local light = game:GetService("Lighting")
local tp = game:GetService("TeleportService")
local lp = plrs.LocalPlayer
local mobile = uis.TouchEnabled
local inset = gs:GetGuiInset().Y

local win = lib:Window({Name = cfg.menu})
local wm = win:Watermark({Name = cfg.watermark})

local esp_data = {
    Enabled = false,
    Keybind = {Enabled = true, Key = Enum.KeyCode.Insert},
    Players = true,
    LocalPlayer = false,
    LimitFPS = 70,
    DynamicBoxes = false,
    DynamicBoxesCheap = false,
    DynamicBoxesIncludeAll = false,
    VisibilityCheckRate = 0.3,
    Boxes = false,
    BoxType = "Corner",
    BoxColor = Color3.fromRGB(119, 120, 255),
    BoxThickness = 1,
    Outlines = {Style = "Full", Color = Color3.fromRGB(0, 0, 0), Thickness = 1},
    BoxFill = {
        Enabled = false,
        Color = Color3.fromRGB(119, 120, 255),
        Transparency = 0.85,
        Gradient = {Enabled = false, Color1 = Color3.fromRGB(119, 120, 255), Color2 = Color3.fromRGB(60, 60, 150), Color3 = Color3.fromRGB(30, 30, 100), Rotation = -45, Animated = true, Speed = 90, Direction = "Right"},
    },
    HealthBar = {
        Enabled = false, Position = "Left", SideGap = 2, Width = 2.5, ShowText = false, TextFollowBar = true, HideWhenFullHP = false,
        FollowGradientColorText = true, Font = "Smallest Pixel-7", TextSize = 9,
        Outline = {Style = "Full", Color = Color3.fromRGB(0, 0, 0)},
        Gradient = {Enabled = true, Color1 = Color3.fromRGB(0, 255, 0), Color2 = Color3.fromRGB(255, 255, 0), Color3 = Color3.fromRGB(255, 0, 0)},
    },
    Names = false,
    TextSize = 12,
    TextColor = Color3.fromRGB(255, 255, 255),
    TextOutline = true,
    TextOutlineStyle = "Full",
    TextGap = 3,
    Font = "Proggy Clean",
    TeamIndicator = {Enabled = false, Position = "Right", UseTeamColor = true, Color = Color3.fromRGB(255, 255, 255), Compact = false, TextSize = 10},
    FriendlyIndicator = {Enabled = false, Position = "Right", CheckTeam = true, CheckFriends = true, Text = "[F]", Color = Color3.fromRGB(0, 255, 0)},
    Weapon = {Enabled = false, Gap = 1, OutlineStyle = "Full", Font = "Proggy Clean", TextSize = 11, Color = Color3.fromRGB(119, 120, 255), InventoryPath = "ReplicatedStorage.Players.%NAME%.Inventory", UseToolFallback = true},
    Flags = {
        Enabled = false, Position = "Right", Gap = 2, SideGap = 4, TextGap = 2, OutlineStyle = "Full", Font = "Smallest Pixel-7", TextSize = 9,
        Options = {Idle = true, Moving = true, Jumping = true, Swimming = true},
        Colors = {Idle = Color3.fromRGB(150, 150, 150), Moving = Color3.fromRGB(255, 255, 255), Jumping = Color3.fromRGB(255, 200, 0), Swimming = Color3.fromRGB(0, 150, 255)},
    },
    Skeleton = {Enabled = false, Color = Color3.fromRGB(119, 120, 255), Outline = true, OutlineColor = Color3.fromRGB(0, 0, 0), Gradient = {Enabled = false, Color1 = Color3.fromRGB(119, 120, 255), Color2 = Color3.fromRGB(60, 60, 180)}},
    OffScreenArrows = {
        Enabled = false, Size = 16, Color = Color3.fromRGB(119, 120, 255), OrbitRadius = 100, ArrowMode = "Camera", Outline = true, OutlineColor = Color3.fromRGB(0, 0, 0),
        Names = {Enabled = false, Font = "Smallest Pixel-7", TextSize = 9, Color = Color3.fromRGB(255, 255, 255), Outline = true, OutlineColor = Color3.fromRGB(0, 0, 0), Side = "Bottom", Gap = 4},
        Distance = {Enabled = false, Font = "Smallest Pixel-7", TextSize = 9, Color = Color3.fromRGB(200, 200, 200), Outline = true, OutlineColor = Color3.fromRGB(0, 0, 0), Side = "Bottom", Gap = 2},
    },
    Distance = {Enabled = false, Unit = "Meters", StudsPerMeter = 3, Ending = "m", Gap = 3, OutlineStyle = "Full", Font = "Proggy Clean", TextSize = 11, Color = Color3.fromRGB(200, 200, 200)},
    Chams = {
        Enabled = false,
        Type = "Highlight",
        Highlight = {FillColor = Color3.fromRGB(119, 120, 255), FillTransparency = 0.3, OutlineColor = Color3.fromRGB(255, 255, 255), OutlineTransparency = 0, VisibleCheck = false},
        Adornment = {Color = Color3.fromRGB(119, 120, 255), VisibleColor = Color3.fromRGB(0, 255, 0), Transparency = 0.5, AlwaysOnTop = true, VisibleCheck = false},
        MeshChams = {FillColor = Color3.fromRGB(119, 120, 255), FillTransparency = 0.2, OutlineColor = Color3.fromRGB(255, 255, 255), OutlineTransparency = 0, VisibleCheck = false},
    },
    Directories = {},
}

local esp_connection = esp:Load(esp_data)

local function reload_esp()
    if esp_connection then
        pcall(function() esp_connection:Disconnect() end)
    end
    esp_connection = esp:Load(esp_data)
end

do
    local bg = win.Items["Background"].Instance
    local tw = cfg.typewriter
    task.wait()
    local letters = {}
    for _, v in bg:GetChildren() do
        if v:IsA("TextLabel") and #v.Text == 1 then table.insert(letters, v) end
    end
    table.sort(letters, function(a, b) return a.Position.X.Offset < b.Position.X.Offset end)
    for _, v in letters do v.TextTransparency = 1 end
    lib:Thread(function()
        while lib do
            for i = 1, #letters do
                if not lib then return end
                ts:Create(letters[i], TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                task.wait(tw.char_delay)
            end
            task.wait(tw.pause_after)
            for i = #letters, 1, -1 do
                if not lib then return end
                ts:Create(letters[i], TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
                task.wait(tw.erase_delay)
            end
            task.wait(tw.pause_clear)
        end
    end)
end

do
    local locked = false
    local b = cfg.buttons
    local xo = b.start_x
    local st = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

    local function make_btn(px, w, txt)
        local outer = lib:Create("TextButton", {
            Parent = lib.Holder.Instance, Size = UDim2.new(0, w, 0, b.height), Position = UDim2.new(0, px, 0, inset + b.y),
            BackgroundColor3 = lib.Theme["Border"], Text = "", AutoButtonColor = false, ZIndex = 20, BorderSizePixel = 0,
        }):AddToTheme({BackgroundColor3 = "Border"})

        lib:Create("Frame", {
            Parent = outer.Instance, Position = UDim2.new(0, 1, 0, 1), Size = UDim2.new(1, -2, 1, -2),
            BackgroundColor3 = lib.Theme["Outline"], BorderSizePixel = 0, ZIndex = 20,
        }):AddToTheme({BackgroundColor3 = "Outline"})

        local inner = lib:Create("TextButton", {
            Parent = outer.Instance, Position = UDim2.new(0, 2, 0, 2), Size = UDim2.new(1, -4, 1, -4),
            BackgroundColor3 = lib.Theme["Background"], Text = "", AutoButtonColor = false, BorderSizePixel = 0, ZIndex = 20,
        }):AddToTheme({BackgroundColor3 = "Background"})

        lib:Create("TextLabel", {
            Parent = inner.Instance, FontFace = lib.Font, TextSize = lib.FontSize, Text = txt,
            TextColor3 = lib.Theme["Inactive Text"], BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, -1), Size = UDim2.new(1, 0, 1, 0), BorderSizePixel = 0, ZIndex = 22,
        }):AddToTheme({TextColor3 = "Inactive Text"})

        local function press()
            ts:Create(inner.Instance, st, {BackgroundColor3 = lib.Theme["Element"]}):Play()
            task.delay(0.15, function()
                if not lib then return end
                ts:Create(inner.Instance, st, {BackgroundColor3 = lib.Theme["Background"]}):Play()
            end)
        end
        return inner, press
    end

    if mobile then
        local tgi, tpr = make_btn(xo, b.toggle_w, "menu")
        xo = xo + b.toggle_w + b.gap
        lib:Connect(tgi.Instance.InputBegan, function(inp)
            if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
                if locked then return end
                tpr()
                win:SetOpen(not win.IsOpen)
            end
        end)
    end

    local lki, lpr = make_btn(xo, b.lock_w, "lock")
    lib:Connect(lki.Instance.InputBegan, function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            locked = not locked
            lpr()
            lib:Notification(locked and cfg.notifs.lock or cfg.notifs.unlock, cfg.notifs.duration, lib.Theme.Accent)
        end
    end)

    local og = win.Items["Outline"].Tween
    win.Items["Outline"].Tween = function(self, props, info, raw)
        if locked and props.Position then return end
        return og(self, props, info, raw)
    end
end

local infj = nil

do
    local p1 = win:Page({Name = "aimbot"})
    local p2 = win:Page({Name = "visuals"})
    local p3 = win:Page({Name = "players"})
    local p4 = win:Page({Name = "misc"})

    do
        local l = p1:Section({Name = "aim", Side = 1})
        local r = p1:Section({Name = "move", Side = 2})

        l:Toggle({Name = "auto parry", Flag = "auto_parry", Default = false})
        l:Toggle({Name = "auto block", Flag = "auto_block", Default = false})
        l:Toggle({Name = "silent aim", Flag = "silent_aim", Default = false})
        l:Slider({Name = "fov", Flag = "aim_fov", Min = 10, Max = 500, Default = 120, Decimals = 0, Suffix = " px"})
        l:Dropdown({Name = "target part", Flag = "target_part", Items = {"Head", "Torso", "HumanoidRootPart"}, Default = "Head"})
        l:Label({Name = "aim key"}):Keybind({Name = "aim key", Flag = "aim_key", Default = Enum.KeyCode.E, Mode = "Hold"})

        r:Slider({Name = "walkspeed", Flag = "walkspeed", Min = 0, Max = 300, Default = 16, Suffix = " ws", Callback = function(v)
            local char = lp.Character
            if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = v end
        end})
        r:Slider({Name = "jump power", Flag = "jump_power", Min = 0, Max = 300, Default = 50, Suffix = " jp", Callback = function(v)
            local char = lp.Character
            if char and char:FindFirstChild("Humanoid") then char.Humanoid.JumpPower = v end
        end})
        r:Toggle({Name = "infinite jump", Flag = "inf_jump", Default = false, Callback = function(v)
            if infj then infj:Disconnect(); infj = nil end
            if v then
                infj = uis.JumpRequest:Connect(function()
                    local char = lp.Character
                    if char and char:FindFirstChild("Humanoid") then char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
                end)
            end
        end})
    end

    do
        local l = p2:Section({Name = "esp", Side = 1})
        local r = p2:Section({Name = "esp settings", Side = 2})

        l:Toggle({Name = "enabled", Flag = "esp_on", Default = false, Callback = function(v)
            esp_data.Enabled = v
            reload_esp()
        end})
        l:Toggle({Name = "team check", Flag = "esp_team", Default = true, Callback = function(v)
            esp_data.FriendlyIndicator.CheckTeam = v
            if esp_data.Enabled then reload_esp() end
        end})
        l:Slider({Name = "fps limit", Flag = "esp_fps", Min = 10, Max = 144, Default = 70, Suffix = " fps", Callback = function(v)
            esp_data.LimitFPS = v
            if esp_data.Enabled then reload_esp() end
        end})
        l:Slider({Name = "text size", Flag = "esp_textsize", Min = 8, Max = 20, Default = 12, Suffix = " px", Callback = function(v)
            esp_data.TextSize = v
            esp_data.Weapon.TextSize = v - 1
            esp_data.Distance.TextSize = v - 1
            if esp_data.Enabled then reload_esp() end
        end})

        l:Label({Name = "box"})
        l:Toggle({Name = "box", Flag = "esp_box", Default = false, Callback = function(v)
            esp_data.Boxes = v
            if esp_data.Enabled then reload_esp() end
        end})
        l:Dropdown({Name = "box type", Flag = "esp_boxtype", Items = {"Corner", "Full", "2D"}, Default = "Corner", Callback = function(v)
            esp_data.BoxType = v
            if esp_data.Enabled then reload_esp() end
        end})
        l:Toggle({Name = "box fill", Flag = "esp_boxfill", Default = false, Callback = function(v)
            esp_data.BoxFill.Enabled = v
            if esp_data.Enabled then reload_esp() end
        end})

        l:Label({Name = "health"})
        l:Toggle({Name = "healthbar", Flag = "esp_hp", Default = false, Callback = function(v)
            esp_data.HealthBar.Enabled = v
            if esp_data.Enabled then reload_esp() end
        end})
        l:Toggle({Name = "hp text", Flag = "esp_hptext", Default = false, Callback = function(v)
            esp_data.HealthBar.ShowText = v
            if esp_data.Enabled then reload_esp() end
        end})

        l:Label({Name = "info"})
        l:Toggle({Name = "names", Flag = "esp_names", Default = false, Callback = function(v)
            esp_data.Names = v
            if esp_data.Enabled then reload_esp() end
        end})
        l:Toggle({Name = "distance", Flag = "esp_dist", Default = false, Callback = function(v)
            esp_data.Distance.Enabled = v
            if esp_data.Enabled then reload_esp() end
        end})
        l:Toggle({Name = "weapon", Flag = "esp_wep", Default = false, Callback = function(v)
            esp_data.Weapon.Enabled = v
            if esp_data.Enabled then reload_esp() end
        end})
        l:Toggle({Name = "flags", Flag = "esp_flags", Default = false, Callback = function(v)
            esp_data.Flags.Enabled = v
            if esp_data.Enabled then reload_esp() end
        end})
        l:Toggle({Name = "offscreen arrows", Flag = "esp_arrows", Default = false, Callback = function(v)
            esp_data.OffScreenArrows.Enabled = v
            if esp_data.Enabled then reload_esp() end
        end})

        r:Label({Name = "colors"})
        r:Label({Name = "box"}):Colorpicker({Flag = "esp_boxc", Default = Color3.fromRGB(119, 120, 255), Callback = function(v)
            esp_data.BoxColor = v
            esp_data.BoxFill.Color = v
            esp_data.BoxFill.Gradient.Color1 = v
            if esp_data.Enabled then reload_esp() end
        end})
        r:Label({Name = "name"}):Colorpicker({Flag = "esp_namec", Default = Color3.fromRGB(255, 255, 255), Callback = function(v)
            esp_data.TextColor = v
            if esp_data.Enabled then reload_esp() end
        end})
        r:Label({Name = "hp full"}):Colorpicker({Flag = "esp_hpfull", Default = Color3.fromRGB(0, 255, 0), Callback = function(v)
            esp_data.HealthBar.Gradient.Color1 = v
            if esp_data.Enabled then reload_esp() end
        end})
        r:Label({Name = "hp half"}):Colorpicker({Flag = "esp_hphalf", Default = Color3.fromRGB(255, 255, 0), Callback = function(v)
            esp_data.HealthBar.Gradient.Color2 = v
            if esp_data.Enabled then reload_esp() end
        end})
        r:Label({Name = "hp low"}):Colorpicker({Flag = "esp_hplow", Default = Color3.fromRGB(255, 0, 0), Callback = function(v)
            esp_data.HealthBar.Gradient.Color3 = v
            if esp_data.Enabled then reload_esp() end
        end})
    end

    do
        local l = p3:Section({Name = "list", Side = 1})
        local r = p3:Section({Name = "target", Side = 2})

        local plist = l:List({Flag = "player_list", Multi = false, Items = {}})

        local function refresh()
            plist:Refresh({})
            for _, v in plrs:GetPlayers() do
                if v ~= lp then plist:Add(v.Name) end
            end
        end
        refresh()
        plrs.PlayerAdded:Connect(refresh)
        plrs.PlayerRemoving:Connect(refresh)

        r:Button({Name = "teleport to", Callback = function()
            local sel = lib.Flags["player_list"]
            if not sel then return end
            local tgt = plrs:FindFirstChild(sel)
            if tgt and tgt.Character and lp.Character then
                lp.Character:PivotTo(tgt.Character:GetPivot())
            end
        end})
        r:Button({Name = "copy user id", Callback = function()
            local sel = lib.Flags["player_list"]
            if not sel then return end
            local tgt = plrs:FindFirstChild(sel)
            if tgt then
                setclipboard(tostring(tgt.UserId))
                lib:Notification("copied " .. sel .. "'s id", 2, lib.Theme.Accent)
            end
        end})
    end

    do
        local l = p4:Section({Name = "world", Side = 1})
        local r = p4:Section({Name = "self", Side = 2})

        l:Slider({Name = "gravity", Flag = "gravity", Min = 0, Max = 200, Default = 196, Callback = function(v) ws.Gravity = v end})
        l:Toggle({Name = "fullbright", Flag = "fullbright", Default = false, Callback = function(v)
            light.Brightness = v and 2 or 1
            light.ClockTime = v and 14 or light.ClockTime
        end})
        l:Toggle({Name = "no fog", Flag = "nofog", Default = false, Callback = function(v)
            local atm = light:FindFirstChildOfClass("Atmosphere")
            if atm then atm.Density = v and 0 or 0.3 end
        end})
        l:Dropdown({Name = "time", Flag = "time", Items = {"dawn", "morning", "noon", "evening", "night"}, Callback = function(v)
            local times = {dawn=6, morning=8, noon=14, evening=18, night=0}
            if times[v] then light.ClockTime = times[v] end
        end})

        r:Button({Name = "respawn", Callback = function() lp:LoadCharacter() end})
        r:Textbox({Name = "place id", Flag = "rejoin_id", Default = "", Placeholder = "place id..", Finished = true})
        r:Button({Name = "rejoin", Callback = function()
            local id = tonumber(lib.Flags["rejoin_id"])
            if id then tp:Teleport(id, lp) else tp:Teleport(game.PlaceId, lp) end
        end})
    end
end

do
    local ft = wm:Add("0 fps")
    local tt = wm:Add("")
    local fps, frames, el = 0, 0, 0
    lib:Connect(rs.RenderStepped, function(dt)
        frames = frames + 1
        el = el + dt
        if el >= 1 then
            fps = math.floor(frames / el)
            frames = 0
            el = 0
            ft:SetText(fps .. " fps")
        end
        tt:SetText(os.date("%H:%M:%S"))
    end)
end

win:Init()
