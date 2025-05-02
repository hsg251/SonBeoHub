--// Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// Khởi tạo ui
local Window = Rayfield:CreateWindow({
   Name = "SonBeo Hub | Blade Ball",
   LoadingTitle = "Đang tải tool gánh team...",
   LoadingSubtitle = "Script by Sơn Bé",
   ConfigurationSaving = {
      Enabled = false
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false
})


--// TAB MAIN
local MainTab = Window:CreateTab("Main")

local autoParryEnabled = false
local parryConnection = nil
local parryBallConnection = nil

MainTab:CreateToggle({
   Name = "Auto Parry",
   CurrentValue = false,
   Flag = "AutoParry",
   Callback = function(Value)
       autoParryEnabled = Value

       if Value then
           local RunService = game:GetService("RunService")
           local Players = game:GetService("Players")
           local VirtualInputManager = game:GetService("VirtualInputManager")
           local Player = Players.LocalPlayer
           local Cooldown = tick()
           local Parried = false

           local function GetBall()
               for _, Ball in ipairs(workspace.Balls:GetChildren()) do
                   if Ball:GetAttribute("realBall") then
                       return Ball
                   end
               end
           end

           local function ResetConnection()
               if parryBallConnection then
                   parryBallConnection:Disconnect()
                   parryBallConnection = nil
               end
           end

           workspace.Balls.ChildAdded:Connect(function()
               local Ball = GetBall()
               if not Ball then return end
               ResetConnection()
               parryBallConnection = Ball:GetAttributeChangedSignal("target"):Connect(function()
                   Parried = false
               end)
           end)

           parryConnection = RunService.PreSimulation:Connect(function()
               if not autoParryEnabled then return end
               local Ball = GetBall()
               local Character = Player.Character
               if not Ball or not Character then return end
               local HRP = Character:FindFirstChild("HumanoidRootPart")
               if not HRP then return end

               local Speed = Ball.zoomies.VectorVelocity.Magnitude
               local Distance = (HRP.Position - Ball.Position).Magnitude

               if Ball:GetAttribute("target") == Player.Name and not Parried and Distance / Speed <= 0.65 then
                   VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                   Parried = true
                   Cooldown = tick()
                   task.delay(1, function()
                       Parried = false
                   end)
               end
           end)
       else
           if parryConnection then parryConnection:Disconnect() end
           if parryBallConnection then parryBallConnection:Disconnect() end
       end
   end
})

-- Auto Spam F (popup bảng nhỏ)
local spamEnabled = false
local spamConnection = nil

MainTab:CreateButton({
    Name = "Auto Spam 'F' (mở bảng nhỏ)",
    Callback = function()
        if game.CoreGui:FindFirstChild("SpamFrame_SonBeo") then return end

        local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
        ScreenGui.Name = "SpamFrame_SonBeo"
        ScreenGui.ResetOnSpawn = false

        local Frame = Instance.new("Frame", ScreenGui)
        Frame.Size = UDim2.new(0, 180, 0, 70)
        Frame.Position = UDim2.new(1, -200, 0, 20)
        Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Frame.BorderSizePixel = 0
        Frame.Name = "SpamFrame"
        Frame.Active = true
        Frame.Draggable = true

        local UICorner = Instance.new("UICorner", Frame)
        UICorner.CornerRadius = UDim.new(0, 8)

        local TextLabel = Instance.new("TextLabel", Frame)
        TextLabel.Size = UDim2.new(1, 0, 0.5, 0)
        TextLabel.Position = UDim2.new(0, 0, 0, 0)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = "Auto Spam F"
        TextLabel.TextColor3 = Color3.new(1, 1, 1)
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.TextSize = 20

        local ToggleButton = Instance.new("TextButton", Frame)
        ToggleButton.Size = UDim2.new(0.8, 0, 0.3, 0)
        ToggleButton.Position = UDim2.new(0.1, 0, 0.6, 0)
        ToggleButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
        ToggleButton.TextColor3 = Color3.new(1, 1, 1)
        ToggleButton.TextSize = 18
        ToggleButton.Text = "BẬT"
        ToggleButton.Font = Enum.Font.GothamBold

        local corner2 = Instance.new("UICorner", ToggleButton)
        corner2.CornerRadius = UDim.new(0, 6)

        ToggleButton.MouseButton1Click:Connect(function()
            spamEnabled = not spamEnabled
            ToggleButton.Text = spamEnabled and "TẮT" or "BẬT"
            ToggleButton.BackgroundColor3 = spamEnabled and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(70, 130, 180)

            if spamEnabled then
                spamConnection = game:GetService("RunService").RenderStepped:Connect(function()
                    local vim = game:GetService("VirtualInputManager")
                    vim:SendKeyEvent(true, "F", false, game)
                    task.wait(0.005)
                    vim:SendKeyEvent(false, "F", false, game)
                end)
            else
                if spamConnection then
                    spamConnection:Disconnect()
                    spamConnection = nil
                end
            end
        end)
    end
})

---------------------
-- TAB ABOUT UI --
---------------------
local AboutTab = Window:CreateTab("About")

AboutTab:CreateButton({
    Name = "My Facebook Account",
    Callback = function()
        setclipboard("https://www.facebook.com/share/16KNnFeoYK/")
        Rayfield:Notify({
            Title = "Đã sao chép!",
            Content = "Link Facebook đã copy vào clipboard!",
            Duration = 5
        })
    end
})
