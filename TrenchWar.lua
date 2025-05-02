local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local selectedPlayer = nil
local aimSquareSize = 10
local aimbotEnabled = false
local espEnabled = false
local playerButtons = {}
local espObjects = {}

-- Giao diện
local Window = Rayfield:CreateWindow({
   Name = "SonBeo Hub",
   LoadingTitle = "SonBeo Hub",
   LoadingSubtitle = "đang tải",
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

-- Aimbot
local function updateAimbot()
    while aimbotEnabled do
        task.wait()
        local cam = workspace.CurrentCamera
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                local headPos, onScreen = cam:WorldToViewportPoint(plr.Character.Head.Position)
                local mouse = game:GetService("UserInputService"):GetMouseLocation()
                if onScreen and (Vector2.new(headPos.X, headPos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude < aimSquareSize * 10 then
                    workspace.CurrentCamera.CFrame = CFrame.new(cam.CFrame.Position, plr.Character.Head.Position)
                    break
                end
            end
        end
    end
end

MainTab:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Callback = function(Value)
        aimbotEnabled = Value
        if aimbotEnabled then updateAimbot() end
    end
})

-- ESP
local function toggleESP(state)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if state then
                if not espObjects[player] and player.Character and player.Character:FindFirstChild("Head") then
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
                        while espEnabled and player.Parent and player.Character and player.Character:FindFirstChild("Humanoid") do
                            local humanoid = player.Character:FindFirstChild("Humanoid")
                            local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude)
                            local hp = math.floor(humanoid.Health)
                            espObjects[player].hpLabel.Text = "HP: " .. hp .. " | " .. dist .. "m"
                            task.wait(0.2)
                        end
                    end)
                end
            else
                if espObjects[player] then
                    espObjects[player].gui:Destroy()
                    espObjects[player] = nil
                end
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

-- Teleport
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

-- Settings Tab
SettingsTab:CreateSlider({
    Name = "Kích thước vùng Aimbot",
    Range = {2, 30},
    Increment = 1,
    CurrentValue = 10,
    Callback = function(Value)
        aimSquareSize = Value
    end
})
