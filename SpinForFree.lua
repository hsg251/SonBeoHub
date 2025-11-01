print("hi! welcome to my script")
print("loading...")

task.wait(2)

-- Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "SonBeo Hub - spin for free",
    LoadingTitle = "SonBeo Hub",
    LoadingSubtitle = "by thanh_dan999",
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
    KeySystem = false
})

----------------------------------------------------
-- 🧑 About Tab
----------------------------------------------------
local AboutTab = Window:CreateTab("About", 4483362458)
local AboutSection = AboutTab:CreateSection("Developer Info")

AboutTab:CreateButton({
    Name = "Facebook Profile",
    Callback = function()
        setclipboard("https://www.facebook.com/son.thanh.le.794756/")
        Rayfield:Notify({
            Title = "SonBeo Hub",
            Content = "Facebook link copied to clipboard!",
            Duration = 6.5,
            Image = 4483362458,
        })
    end,
})

----------------------------------------------------
-- 🎯 Main Tab
----------------------------------------------------
local MainTab = Window:CreateTab("Main", 4483362458)
local MainSection = MainTab:CreateSection("Main Features")

local teleportEnabled, jumpEnabled, autoSpin = false, false, false

-- Auto farm spin (teleport + jump)
MainTab:CreateToggle({
    Name = "Auto farm spin",
    CurrentValue = false,
    Callback = function(Value)
        teleportEnabled = Value
        jumpEnabled = Value

        -- teleport loop
        task.spawn(function()
            while teleportEnabled do
                local player = game.Players.LocalPlayer
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")
                hrp.CFrame = CFrame.new(-166.24, -0.76, -9.41)
                task.wait(1)
            end
        end)

        -- jump loop
        task.spawn(function()
            while jumpEnabled do
                local player = game.Players.LocalPlayer
                local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
                task.wait(0.3)
            end
        end)
    end,
})

-- Auto Spin
MainTab:CreateToggle({
    Name = "Auto Spin",
    CurrentValue = false,
    Callback = function(Value)
        autoSpin = Value
        task.spawn(function()
            while autoSpin do
                local spinEvent = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Spin")
                spinEvent:FireServer("spin")
                task.wait(1)
            end
        end)
    end,
})

----------------------------------------------------
-- ⚙️ Misc Tab
----------------------------------------------------
local MiscTab = Window:CreateTab("Misc", 4483362458)
local Misc = MiscTab:CreateSection("Misc Tools")

local antiAFKEnabled = false

MiscTab:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = false,
    Callback = function(Value)
        antiAFKEnabled = Value

        task.spawn(function()
            while antiAFKEnabled do
                local player = game.Players.LocalPlayer
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:WaitForChild("HumanoidRootPart")
                hrp.CFrame = hrp.CFrame * CFrame.new(1, 0, 0)
                task.wait(600) -- 10 phút
            end
        end)
    end,
})
