local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "SonBeo Hub - grow a garden",
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
local GearTab = Window:CreateTab("Gear", 4483362458)
local gearsection = GearTab:CreateSection("gear")

local autoBuyWateringCan = false

GearTab:CreateToggle({ 
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

GearTab:CreateToggle({ 
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

GearTab:CreateToggle({ 
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

GearTab:CreateToggle({ 
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

GearTab:CreateToggle({ 
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

-------------------------------------------------------------------- Pet Tab
local PetTab = Window:CreateTab("main", 4483362458)
local petsection = PetTab:CreateSection("Pet")

local autoBuyCommonEgg = false

MainTab:CreateToggle({ 
	Name = "Auto buy Common Egg", 
	CurrentValue = false,

	Callback = function(Value)
		autoBuyCommonEgg = Value
	end,
})

task.spawn(function()
	while true do
		if autoBuyCommonEgg then
			local args = {
				[1] = "Common Egg"
			}
			game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer(unpack(args))
		end
		wait(1)
	end
end)


local autoBuyCommonEgg = false

MainTab:CreateToggle({ 
	Name = "Auto buy Common Summer Egg", 
	CurrentValue = false,

	Callback = function(Value)
		autoBuyCommonEgg = Value
	end,
})

task.spawn(function()
	while true do
		if autoBuyCommonEgg then
			local args = {
				[1] = "Common Summer Egg"
			}
			game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer(unpack(args))
		end
		wait(1)
	end
end)

local autoBuyRareSummerEgg = false

MainTab:CreateToggle({ 
	Name = "Auto buy Rare Summer Egg", 
	CurrentValue = false,

	Callback = function(Value)
		autoBuyRareSummerEgg = Value
	end,
})

task.spawn(function()
	while true do
		if autoBuyRareSummerEgg then
			local args = {
				[1] = "Rare Summer Egg"
			}
			game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer(unpack(args))
		end
		wait(1)
	end
end)

local autoBuyMythicalEgg = false

MainTab:CreateToggle({ 
	Name = "Auto buy Mythical Egg", 
	CurrentValue = false,

	Callback = function(Value)
		autoBuyMythicalEgg = Value
	end,
})

task.spawn(function()
	while true do
		if autoBuyMythicalEgg then
			local args = {
				[1] = "Mythical Egg"
			}
			game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer(unpack(args))
		end
		wait(1)
	end
end)

local autoBuyParadiseEgg = false

MainTab:CreateToggle({ 
	Name = "Auto buy Paradise Egg", 
	CurrentValue = false,

	Callback = function(Value)
		autoBuyParadiseEgg = Value
	end,
})

task.spawn(function()
	while true do
		if autoBuyParadiseEgg then
			local args = {
				[1] = "Paradise Egg"
			}
			game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer(unpack(args))
		end
		wait(1)
	end
end)

local autoBuyBugEgg = false

MainTab:CreateToggle({ 
	Name = "Auto buy Bug Egg", 
	CurrentValue = false,

	Callback = function(Value)
		autoBuyBugEgg = Value
	end,
})

task.spawn(function()
	while true do
		if autoBuyBugEgg then
			local args = {
				[1] = "Bug Egg"
			}
			game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer(unpack(args))
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
	CurrentValue = true, 
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

Rayfield:Notify({
   Title = "Sonbeo Hub",
   Content = "loading complete",
   Duration = 5,
   Image = "rewind",
})

--icon
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local VirtualInput = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- Tạo GUI
local gui = Instance.new("ScreenGui")
gui.Name = "DraggableIconGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local icon = Instance.new("ImageButton")
icon.Name = "KButton"
icon.Size = UDim2.new(0, 60, 0, 60)
icon.Position = UDim2.new(0, 100, 0, 100)
icon.Image = "rbxthumb://type=Asset&id=133778471627727&w=150&h=150"
icon.BackgroundTransparency = 1
icon.ClipsDescendants = true
icon.Parent = gui

local uicorner = Instance.new("UICorner")
uicorner.CornerRadius = UDim.new(1, 0)
uicorner.Parent = icon

local stroke = Instance.new("UIStroke")
stroke.Thickness = 3
stroke.Color = Color3.fromRGB(255, 0, 0)
stroke.Transparency = 0
stroke.LineJoinMode = Enum.LineJoinMode.Round
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = icon

task.spawn(function()
	while true do
		local tween1 = TweenService:Create(stroke, TweenInfo.new(0.5), {Transparency = 0.3})
		local tween2 = TweenService:Create(stroke, TweenInfo.new(0.5), {Transparency = 0})
		tween1:Play()
		tween1.Completed:Wait()
		tween2:Play()
		tween2.Completed:Wait()
	end
end)

local dragging = false
local dragInput, dragStart, startPos

icon.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = icon.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

icon.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		icon.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

icon.MouseButton1Down:Connect(function()
	icon:TweenSize(UDim2.new(0, 55, 0, 55), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
end)

icon.MouseButton1Up:Connect(function()
	icon:TweenSize(UDim2.new(0, 60, 0, 60), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
end)

icon.MouseButton1Click:Connect(function()
	VirtualInput:SendKeyEvent(true, Enum.KeyCode.K, false, game)
	wait(0.05)
	VirtualInput:SendKeyEvent(false, Enum.KeyCode.K, false, game)
end)
