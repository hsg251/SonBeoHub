local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- UI Setup
local Window = Rayfield:CreateWindow({
    Name = "SonBeo Hub",
    LoadingTitle = "SonBeo Hub",
    LoadingSubtitle = "by SonBeo",
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

local MainTab = Window:CreateTab("💩 Main", nil)
local AboutTab = Window:CreateTab("🙆‍♂️ About", nil)
local PlayerTab = Window:CreateTab("🐒 Player", nil)

-- Tab About
AboutTab:CreateSection("About me:D")

AboutTab:CreateButton({
    Name = "My Facebook Account",
    Callback = function()
        setclipboard("https://www.facebook.com/share/16KNnFeoYK/")
        Rayfield:Notify({
            Title = "SonBeo Hub",
            Content = "coppied to clipboard",
            Duration = 5
        })
    end
})

-- Nút Spam F
MainTab:CreateSection("Main")

MainTab:CreateButton({
    Name = "Auto Spam",
    Callback = function()
        Rayfield:Notify({
            Title = "SonBeo Hub",
            Content = "If someone dribbles the ball to you bounce it.",
            Duration = 4
        })
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hsg251/SonBeoHub/refs/heads/main/SpamButton.lua"))()
    end
})

-- Nút Auto Parry (dùng loadstring)
MainTab:CreateButton({
    Name = "Auto Parry",
    Callback = function()
        Rayfield:Notify({
            Title = "Auto Parry Activated!",
            Content = "Proximity parry đã bật!",
            Duration = 5
        })
        loadstring(game:HttpGet("https://rawscripts.net/raw/XMAS-Blade-Ball-OPEN-SOURCE-Simple-Proximity-Auto-Parry-25405"))()
    end
})

-- WalkSpeed Slider
PlayerTab:CreateSection("Player")

PlayerTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = Value
        end
    end
})

-- JumpPower Slider
PlayerTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 200},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = Value
        end
    end
})
