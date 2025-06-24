local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "SonBeo Hub",
   LoadingTitle = "SonBeo Hub",
   LoadingSubtitle = "loading",
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

------------------------------------------------ Main Tab
local MainTab = Window:CreateTab("main", nil)
MainTab:CreateSection("main")

local player = game.Players.LocalPlayer
local noclipActive = false

-- Hàm noclip
game:GetService("RunService").Stepped:Connect(function()
    if noclipActive then
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Nút bật noclip
MainTab:CreateToggle({
   Name = "Noclip",
   CurrentValue = false,
   Callback = function(Value)
       noclipActive = Value
       local char = player.Character
       if char then
           local hum = char:FindFirstChildOfClass("Humanoid")
           if hum then
               hum:ChangeState(11)
           end
       end
       print("Noclip: " .. tostring(Value))
   end,
})

-- Nút tạo GUI TELE
MainTab:CreateButton({
   Name = "Teleport to safe zone",
   Callback = function()
       if player.PlayerGui:FindFirstChild("TeleGui") then
           warn("Nút TELE đã tồn tại rồi!")
           return
       end

        local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
       gui.Name = "TeleGui"

       local button = Instance.new("TextButton")
       button.Text = "TELE"
       button.Size = UDim2.new(0, 140, 0, 50)
       button.Position = UDim2.new(0, 10, 1, -60)
       button.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
       button.TextColor3 = Color3.new(1, 1, 1)
       button.Font = Enum.Font.GothamBold
       button.TextScaled = true
       button.ZIndex = 10
       button.Parent = gui

       local destination = Vector3.new(0, 100, 0)

       local function teleportNow()
           local char = player.Character
           local hrp = char and char:FindFirstChild("HumanoidRootPart")
           if hrp then
               hrp.CFrame = CFrame.new(destination)
               print("Đã TELE tới nơi an toàn 🚀")
           end
       end

       button.MouseButton1Click:Connect(teleportNow)

       -- Bắt phím Z để teleport (PC)
       game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
           if gpe then return end
           if input.KeyCode == Enum.KeyCode.Z then
               teleportNow()
           end
       end)
   end,
})

local lock = MainTab:CreateToggle({
   Name = "Auto Lock Base (Coming Soon)",
   CurrentValue = false,
   Callback = function(Value)
       Rayfield:Notify({
           Title = "Coming Soon!",
           Content = "We're still working on the Auto Lock Base feature. It will be released in an upcoming update!",
           Duration = 6.5,
           Image = 4483362458, -- Hình icon thông báo
       })
   end,
})

------------------------------------------------ Player Tab
local PlayerTab = Window:CreateTab("player", nil)
PlayerTab:CreateSection("player")

-- Slider chỉnh tốc độ
PlayerTab:CreateSlider({
   Name = "Speed Walk",
   Range = {16, 100},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value)
       local char = player.Character
       local hum = char and char:FindFirstChildOfClass("Humanoid")
       if hum then
           hum.WalkSpeed = Value
           print("Speed hiện tại: " .. Value)
       end
   end,
})

-- Toggle Infinite Jump
-- Toggle Infinite Jump
local infJumpConnection
PlayerTab:CreateToggle({
   Name = "Infinity Jump",
   CurrentValue = false,
   Callback = function(Value)
       if Value then
           infJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
               local char = player.Character
               local hum = char and char:FindFirstChildOfClass("Humanoid")
               if hum then
                   hum:ChangeState(Enum.HumanoidStateType.Jumping)
               end
           end)
           print("Infinity Jump: BẬT 🚀")
       else
           if infJumpConnection then
               infJumpConnection:Disconnect()
               infJumpConnection = nil
           end
           print("Infinity Jump: TẮT 📴")
       end
   end,
})

----------------------------------------------- esp tab
local EspTab = Window:CreateTab("esp", nil)
EspTab:CreateSection("esp")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local espEnabled = false
local connections = {}
local chamsTable = {}

local function createChams(part)
    local adorn = Instance.new("BoxHandleAdornment")
    adorn.Name = "SonBeoChams"
    adorn.Size = part.Size
    adorn.Adornee = part
    adorn.AlwaysOnTop = true
    adorn.ZIndex = 10
    adorn.Transparency = 0.5
    adorn.Color3 = Color3.fromRGB(255, 0, 0)
    adorn.Parent = part
    table.insert(chamsTable, adorn)
end

local function applyChamsToPlayer(player)
    if player == LocalPlayer then return end

    local function onCharacterAdded(char)
        char:WaitForChild("HumanoidRootPart")
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and not part:FindFirstChild("SonBeoChams") then
                createChams(part)
            end
        end
    end

    if player.Character then
        onCharacterAdded(player.Character)
    end

    table.insert(connections, player.CharacterAdded:Connect(onCharacterAdded))
end

local function enableESP()
    espEnabled = true
    for _, player in ipairs(Players:GetPlayers()) do
        applyChamsToPlayer(player)
    end
    table.insert(connections, Players.PlayerAdded:Connect(applyChamsToPlayer))
end

local function disableESP()
    espEnabled = false
    -- Xóa chams
    for _, adorn in ipairs(chamsTable) do
        if adorn and adorn.Parent then
            adorn:Destroy()
        end
    end
    chamsTable = {}

    -- Ngắt kết nối
    for _, conn in ipairs(connections) do
        if conn.Disconnect then
            conn:Disconnect()
        end
    end
    connections = {}
end

local esp = EspTab:CreateToggle({
    Name = "ESP Player",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            enableESP()
            print("ESP Player: BẬT 🔴")
        else
            disableESP()
            print("ESP Player: TẮT ❌")
        end
    end,
})

-- thông báo 
wait(3)
Rayfield:Notify({
   Title = "Loading complete",
   Content = "created by thanh_dan999",
   Duration = 6.5,
   Image = 4483362458,
})
