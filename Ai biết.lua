local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local selectedPlayer = nil
local hitboxSize = 20
local hitboxEnabled = false
local espEnabled = false
local playerButtons = {}
local originalSizes = {}

-- Giao diện
local Window = Rayfield:CreateWindow({
   Name = "SonBeo Hub",
   LoadingTitle = "Đang khởi động SonBeo...",
   LoadingSubtitle = "Hack có tâm, vui có tầm",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "SonBeoHubConfig"
   },
   Discord = { Enabled = false },
   KeySystem = false,
})

local MainTab = Window:CreateTab("Main", 4483362458)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

-- HITBOX
local function setHitbox(state)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = plr.Character.HumanoidRootPart
            if state then
                if not originalSizes[plr] then originalSizes[plr] = hrp.Size end
                hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                hrp.Transparency = 0.5
                hrp.Material = Enum.Material.ForceField
                hrp.Color = Color3.fromRGB(255, 0, 0)
            else
                if originalSizes[plr] then
                    hrp.Size = originalSizes[plr]
                    hrp.Transparency = 1
                    hrp.Material = Enum.Material.Plastic
                    originalSizes[plr] = nil
                end
            end
        end
    end
end

MainTab:CreateToggle({
    Name = "Mở Rộng Hitbox",
    CurrentValue = false,
    Callback = function(Value)
        hitboxEnabled = Value
        setHitbox(Value)
    end
})

-- ESP Box
local drawings = {}

function createESP(plr)
    local box = Drawing.new("Square")
    box.Thickness = 2
    box.Color = Color3.new(0, 1, 0)
    box.Filled = false
    box.Visible = false

    local name = Drawing.new("Text")
    name.Color = Color3.new(1, 1, 1)
    name.Size = 14
    name.Center = true
    name.Outline = true
    name.Visible = false

    local line = Drawing.new("Line")
    line.Thickness = 1
    line.Color = Color3.new(1, 1, 1)
    line.Visible = false

    drawings[plr] = {Box = box, Name = name, Line = line}
end

function removeESP(plr)
    if drawings[plr] then
        for _, d in pairs(drawings[plr]) do d:Remove() end
        drawings[plr] = nil
    end
end

function updateESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") then
            if not drawings[plr] then createESP(plr) end
            local char = plr.Character
            local hrp = char.HumanoidRootPart
            local hum = char.Humanoid
            local pos, onscreen = Camera:WorldToViewportPoint(hrp.Position)
            if onscreen and espEnabled then
                local size = Vector3.new(2, 3, 1) * (Camera.CFrame.Position - hrp.Position).Magnitude / 50
                local topLeft = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(-size.X, size.Y, 0))
                local bottomRight = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(size.X, -size.Y, 0))

                local box = drawings[plr].Box
                box.Size = Vector2.new(bottomRight.X - topLeft.X, bottomRight.Y - topLeft.Y)
                box.Position = Vector2.new(topLeft.X, topLeft.Y)
                box.Visible = true

                local name = drawings[plr].Name
                name.Text = plr.Name .. " | " .. math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude) .. "m"
                name.Position = Vector2.new((topLeft.X + bottomRight.X)/2, topLeft.Y - 15)
                name.Visible = true

                local line = drawings[plr].Line
                line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                line.To = Vector2.new(pos.X, pos.Y)
                line.Visible = true
            else
                if drawings[plr] then
                    for _, d in pairs(drawings[plr]) do d.Visible = false end
                end
            end
        else
            removeESP(plr)
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(updateESP)

MainTab:CreateToggle({
    Name = "ESP Box (Giống hình)",
    CurrentValue = false,
    Callback = function(Value)
        espEnabled = Value
        if not Value then
            for _, drawing in pairs(drawings) do
                for _, d in pairs(drawing) do d.Visible = false end
            end
        end
    end
})

-- TELEPORT
MainTab:CreateSection("Teleport đến người chơi")

MainTab:CreateButton({
    Name = "Làm mới danh sách người chơi",
    Callback = function()
        for _, btn in pairs(playerButtons) do btn:Destroy() end
        playerButtons = {}
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                table.insert(playerButtons, MainTab:CreateButton({
                    Name = plr.Name,
                    Callback = function()
                        selectedPlayer = plr
                    end
                }))
            end
        end
    end
})

MainTab:CreateButton({
    Name = "Dịch chuyển đến người đã chọn",
    Callback = function()
        if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:MoveTo(selectedPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
        end
    end
})

-- SETTINGS
SettingsTab:CreateSlider({
    Name = "Kích thước Hitbox",
    Range = {1, 100},
    Increment = 1,
    CurrentValue = 20,
    Callback = function(Value)
        hitboxSize = Value
        if hitboxEnabled then
            setHitbox(false)
            setHitbox(true)
        end
    end
})
