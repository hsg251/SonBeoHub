local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local selectedPlayer = nil
local hitboxSize = 10
local hitboxEnabled = false
local espEnabled = false
local playerButtons = {}
local espObjects = {}
local originalSizes = {}

-- GUI
local Window = Rayfield:CreateWindow({
    Name = "SonBeo Hub",
    LoadingTitle = "SonBeo Hub",
    LoadingSubtitle = "Đang tải...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "SonBeoHubConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = false
    },
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
    Name = "Bật/Tắt Hitbox",
    CurrentValue = false,
    Callback = function(Value)
        hitboxEnabled = Value
        setHitbox(Value)
    end
})

-- ESP
local function toggleESP(state)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            -- Xoá GUI cũ nếu có
            if espObjects[player] then
                if espObjects[player].gui then
                    espObjects[player].gui:Destroy()
                end
                espObjects[player] = nil
            end

            if state and player.Character and player.Character:FindFirstChild("Head") then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "ESP"
                billboard.Adornee = player.Character.Head
                billboard.AlwaysOnTop = true
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.StudsOffset = Vector3.new(0, 2, 0)

                local nameLabel = Instance.new("TextLabel", billboard)
                nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                nameLabel.Position = UDim2.new(0, 0, 0, 0)
                nameLabel.Text = player.Name
                nameLabel.BackgroundTransparency = 1
                nameLabel.TextColor3 = Color3.new(1, 0, 0)
                nameLabel.TextStrokeTransparency = 0.5
                nameLabel.TextScaled = true

                local hpLabel = Instance.new("TextLabel", billboard)
                hpLabel.Size = UDim2.new(1, 0, 0.5, 0)
                hpLabel.Position = UDim2.new(0, 0, 0.5, 0)
                hpLabel.BackgroundTransparency = 1
                hpLabel.TextColor3 = Color3.new(0, 1, 0)
                hpLabel.TextStrokeTransparency = 0.5
                hpLabel.TextScaled = true

                billboard.Parent = player.Character.Head
                espObjects[player] = {
                    gui = billboard,
                    hpLabel = hpLabel
                }

                task.spawn(function()
                    while espEnabled and player.Character and player.Character:FindFirstChild("Humanoid") and espObjects[player] do
                        local humanoid = player.Character:FindFirstChild("Humanoid")
                        local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude)
                        local hp = math.floor(humanoid.Health)
                        espObjects[player].hpLabel.Text = "HP: " .. hp .. " | " .. dist .. "m"
                        task.wait(0.2)
                    end
                end)
            end
        end
    end
end

MainTab:CreateToggle({
    Name = "ESP Player (Tên + Máu + Khoảng cách)",
    CurrentValue = false,
    Callback = function(Value)
        espEnabled = Value
        toggleESP(Value)
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

-- CÀI ĐẶT HITBOX
SettingsTab:CreateSlider({
    Name = "Kích thước Hitbox",
    Range = {1, 100},
    Increment = 1,
    CurrentValue = 10,
    Callback = function(Value)
        hitboxSize = Value
        if hitboxEnabled then
            setHitbox(false)
            setHitbox(true)
        end
    end
})

-- TỰ ĐỘNG BẬT LẠI HITBOX & ESP KHI HỒI SINH
local function setupCharacterListener(player)
    player.CharacterAdded:Connect(function()
        task.wait(1)
        if hitboxEnabled then
            setHitbox(true)
        end
        if espEnabled then
            toggleESP(true)
        end
    end)
end

for _, player in pairs(Players:GetPlayers()) do
    setupCharacterListener(player)
end

Players.PlayerAdded:Connect(setupCharacterListener)
