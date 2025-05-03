-- Load Rayfield UI (Miiws compatible)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Tạo cửa sổ UI
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

-- Tạo tab
local AboutTab = Window:CreateTab("About", 4483362458)
local MainTab = Window:CreateTab("Main", 4483362458)

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

-- Nút bấm để chạy mã spam từ GitHub
MainTab:CreateButton({
    Name = "Mở Spam F",
    Callback = function()
        Rayfield:Notify({
            Title = "Đang tải Spam F...",
            Content = "Chờ xíu để bắn F như điên...",
            Duration = 4
        })
        
        -- Tải script spam từ GitHub của bạn
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hsg251/SonBeoHub/refs/heads/main/SpamButton.lua"))()
    end
})

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
