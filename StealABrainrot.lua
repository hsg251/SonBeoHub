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
       gui.ResetOnSpawn = false

       local button = Instance.new("TextButton")
       button.Text = "TELE"
       button.Size = UDim2.new(0, 100, 0, 40)
       button.Position = UDim2.new(0, 10, 1, -50)
       button.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
       button.TextColor3 = Color3.new(1, 1, 1)
       button.Font = Enum.Font.GothamBold
       button.TextSize = 20
       button.ZIndex = 10
       button.Parent = gui

       local destination = Vector3.new(0, 100, 0)

       button.MouseButton1Click:Connect(function()
           local char = player.Character
           local hrp = char and char:FindFirstChild("HumanoidRootPart")
           if hrp then
               hrp.CFrame = CFrame.new(destination)
               print("Té le pó 🤸‍♂️")
           end
       end)
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
local infJumpEnabled = false
PlayerTab:CreateToggle({
   Name = "Infinity Jump",
   CurrentValue = false,
   Callback = function(Value)
       infJumpEnabled = Value
       print("Infinity Jump: " .. tostring(Value))
   end,
})

-- Lắng nghe phím Space để nhảy vô hạn
game:GetService("UserInputService").JumpRequest:Connect(function()
    if infJumpEnabled then
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
