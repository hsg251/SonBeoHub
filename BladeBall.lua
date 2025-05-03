-- Load Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Khởi tạo UI
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

-- TAB ABOUT UI
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

-- TAB MAIN
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
           local UserInputService = game:GetService("UserInputService")
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

               local zoomies = Ball:FindFirstChild("zoomies")
               local Speed = zoomies and zoomies:FindFirstChild("VectorVelocity") and zoomies.VectorVelocity.Magnitude or 0
               local Distance = (HRP.Position - Ball.Position).Magnitude

               if Ball:GetAttribute("target") == Player.Name and not Parried and Speed > 0 and Distance / Speed <= 0.65 then
                   -- Gửi sự kiện click chuột trái (nhấn + thả)
                   VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, nil, 0)
                   VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, nil, 0)
                   Parried = true
                   Cooldown = tick()
                   task.delay(1, function()
                       Parried = false
                   end)
               end
           end)
       else
           if parryConnection then parryConnection:Disconnect(); parryConnection = nil end
           if parryBallConnection then parryBallConnection:Disconnect(); parryBallConnection = nil end
       end
   end
})
