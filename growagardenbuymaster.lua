local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "SonBeo Hub - squid game troll tower",
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
   KeySystem = false,
})

-------------------------------------------------------- About Tab
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

-- Main Tab
local MainTab = Window:CreateTab("main", 4483362458)
local mainsection = MainTab:CreateSection("main")

local autoBuyWateringCan = false

MainTab:CreateToggle({ 
	Name = "Auto buy Watering Can", 
	CurrentValue = false,

	Callback = function(Value)
		autoBuyWateringCan = Value
	end,
})

task.spawn(function()
	while true do
		if autoBuyWateringCan then
			game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer("Watering Can")
		end
		wait(1)
	end
end)


local autoBuyBasic = false

MainTab:CreateToggle({ 
	Name = "Auto buy Basic Sprinkler", 
	CurrentValue = false,
	Callback = function(Value)
		autoBuyBasic = Value
	end,
})

-- Chạy vòng lặp auto mua Basic Sprinkler
task.spawn(function()
	while true do
		if autoBuyBasic then
			game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer("Basic Sprinkler")
		end
		wait(1) -- delay để tránh bị spam quá nhanh
	end
end)

local autoBuyAdvanced = false

MainTab:CreateToggle({ 
	Name = "Auto buy Advanced Sprinkler", 
	CurrentValue = false,
	Callback = function(Value)
		autoBuyAdvanced = Value
	end,
})

-- Vòng lặp auto mua Advanced Sprinkler
task.spawn(function()
	while true do
		if autoBuyAdvanced then
			game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer("Advanced Sprinkler")
		end
		wait(1)
	end
end)

local autoBuyGodly = false

MainTab:CreateToggle({ 
	Name = "Auto buy Godly Sprinkler", 
	CurrentValue = false,
	Callback = function(Value)
		autoBuyGodly = Value
	end,
})

task.spawn(function()
	while true do
		if autoBuyGodly then
			game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer("Godly Sprinkler")
		end
		wait(1)
	end
end)

local autoBuyMaster = false

MainTab:CreateToggle({ 
	Name = "Auto buy Master Sprinkler", 
	CurrentValue = false,
	Callback = function(Value)
		autoBuyMaster = Value
	end,
})

task.spawn(function()
	while true do
		if autoBuyMaster then
			game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer("Master Sprinkler")
		end
		wait(1)
	end
end)

-------------------------------------------------------------------- Misc Tab
local MiscTab = Window:CreateTab("Misc", 4483362458)
local Miscsection = MiscTab:CreateSection("Misc")

local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

local antiAFKEnabled = false

-- Tạo toggle Anti AFK
MiscTab:CreateToggle({ 
	Name = "Anti AFK", 
	CurrentValue = false, 
	Callback = function(Value)
		antiAFKEnabled = Value
	end,
})

-- Vòng lặp giả lập nhấn Space mỗi 10 phút
task.spawn(function()
	while true do
		if antiAFKEnabled then
			-- Giả lập nhấn Space
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
			wait(0.1)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
		end
		wait(600) -- 600 giây = 10 phút
	end
end)
