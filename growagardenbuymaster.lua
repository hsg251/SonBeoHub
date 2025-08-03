print("welcome to my script! :3")
print("pls wait until game is loaded all...")
wait(1)
repeat wait() until game:IsLoaded()
print("game is loaded all! loading script")

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

-- About Tab
local AboutTab = Window:CreateTab("About", 4483362458)
AboutTab:CreateSection("Developer Info")

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

-- Gear Tab
local GearTab = Window:CreateTab("Gear", 4483362458)
GearTab:CreateSection("Gear")

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

local autoBuyBasicSprinkler = false
GearTab:CreateToggle({
   Name = "Auto buy Basic Sprinkler",
   CurrentValue = false,
   Callback = function(Value)
      autoBuyBasicSprinkler = Value
   end,
})
task.spawn(function()
   while true do
      if autoBuyBasicSprinkler then
         game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer("Basic Sprinkler")
      end
      wait(1)
   end
end)

local autoBuyAdvancedSprinkler = false
GearTab:CreateToggle({
   Name = "Auto buy Advanced Sprinkler",
   CurrentValue = false,
   Callback = function(Value)
      autoBuyAdvancedSprinkler = Value
   end,
})
task.spawn(function()
   while true do
      if autoBuyAdvancedSprinkler then
         game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer("Advanced Sprinkler")
      end
      wait(1)
   end
end)

local autoBuyGodlySprinkler = false
GearTab:CreateToggle({
   Name = "Auto buy Godly Sprinkler",
   CurrentValue = false,
   Callback = function(Value)
      autoBuyGodlySprinkler = Value
   end,
})
task.spawn(function()
   while true do
      if autoBuyGodlySprinkler then
         game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer("Godly Sprinkler")
      end
      wait(1)
   end
end)

local autoBuyMasterSprinkler = false
GearTab:CreateToggle({
   Name = "Auto buy Master Sprinkler",
   CurrentValue = false,
   Callback = function(Value)
      autoBuyMasterSprinkler = Value
   end,
})
task.spawn(function()
   while true do
      if autoBuyMasterSprinkler then
         game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer("Master Sprinkler")
      end
      wait(1)
   end
end)

local autoBuyGrandmaster = false

GearTab:CreateToggle({
	Name = "Auto buy Grandmaster Sprinkler", 
	CurrentValue = false,

	Callback = function(Value)
		autoBuyGrandmaster = Value
	end,
})

task.spawn(function()
	while true do
		if autoBuyGrandmaster then
			game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyGearStock"):FireServer("Grandmaster Sprinkler")
		end
		wait(1)
	end
end)


-- Pet Tab
local PetTab = Window:CreateTab("Pet", 4483362458)
PetTab:CreateSection("Pet")

local autoBuyCommonEgg = false
PetTab:CreateToggle({
   Name = "Auto buy Common Egg",
   CurrentValue = false,
   Callback = function(Value)
      autoBuyCommonEgg = Value
   end,
})
task.spawn(function()
   while true do
      if autoBuyCommonEgg then
         game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer("Common Egg")
      end
      wait(1)
   end
end)

local autoBuyCommonSummerEgg = false
PetTab:CreateToggle({
   Name = "Auto buy Common Summer Egg",
   CurrentValue = false,
   Callback = function(Value)
      autoBuyCommonSummerEgg = Value
   end,
})
task.spawn(function()
   while true do
      if autoBuyCommonSummerEgg then
         game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer("Common Summer Egg")
      end
      wait(1)
   end
end)

local autoBuyRareSummerEgg = false
PetTab:CreateToggle({
   Name = "Auto buy Rare Summer Egg",
   CurrentValue = false,
   Callback = function(Value)
      autoBuyRareSummerEgg = Value
   end,
})
task.spawn(function()
   while true do
      if autoBuyRareSummerEgg then
         game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer("Rare Summer Egg")
      end
      wait(1)
   end
end)

local autoBuyMythicalEgg = false
PetTab:CreateToggle({
   Name = "Auto buy Mythical Egg",
   CurrentValue = false,
   Callback = function(Value)
      autoBuyMythicalEgg = Value
   end,
})
task.spawn(function()
   while true do
      if autoBuyMythicalEgg then
         game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer("Mythical Egg")
      end
      wait(1)
   end
end)

local autoBuyParadiseEgg = false
PetTab:CreateToggle({
   Name = "Auto buy Paradise Egg",
   CurrentValue = false,
   Callback = function(Value)
      autoBuyParadiseEgg = Value
   end,
})
task.spawn(function()
   while true do
      if autoBuyParadiseEgg then
         game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer("Paradise Egg")
      end
      wait(1)
   end
end)

local autoBuyBugEgg = false
PetTab:CreateToggle({
   Name = "Auto buy Bug Egg",
   CurrentValue = false,
   Callback = function(Value)
      autoBuyBugEgg = Value
   end,
})
task.spawn(function()
   while true do
      if autoBuyBugEgg then
         game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyPetEgg"):FireServer("Bug Egg")
      end
      wait(1)
   end
end)
---------------------------------------- event tab
local EventTab = Window:CreateTab("Event", 4483362458)
EventTab:CreateSection("Event")

EventTab:CreateButton({
   Name = "Submit Fruit",
   Callback = function()
      local args = {
         "SubmitHeldPlant"
      }
      game:GetService("ReplicatedStorage")
         :WaitForChild("GameEvents")
         :WaitForChild("CookingPotService_RE")
         :FireServer(unpack(args))
   end,
})

EventTab:CreateButton({
   Name = "Cook",
   Callback = function()
      local args = {
         "CookBest"
      }
      game:GetService("ReplicatedStorage")
         :WaitForChild("GameEvents")
         :WaitForChild("CookingPotService_RE")
         :FireServer(unpack(args))
   end,
})

EventTab:CreateButton({
   Name = "Skip cook time (39 robux)",
   Callback = function()
      local args = {
         "SkipCooking"
      }
      game:GetService("ReplicatedStorage")
         :WaitForChild("GameEvents")
         :WaitForChild("CookingPotService_RE")
         :FireServer(unpack(args))
   end,
})



-- Misc Tab
local MiscTab = Window:CreateTab("Misc", 4483362458)
MiscTab:CreateSection("Misc")

local VirtualInputManager = game:GetService("VirtualInputManager")
local antiAFKEnabled = false

MiscTab:CreateToggle({
   Name = "Anti AFK",
   CurrentValue = true,
   Callback = function(Value)
      antiAFKEnabled = Value
   end,
})
task.spawn(function()
   while true do
      if antiAFKEnabled then
         VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
         wait(0.1)
         VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
      end
      wait(600)
   end
end)

-- Notify
wait(2)
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
local RunService = game:GetService("RunService")

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
stroke.Transparency = 0
stroke.LineJoinMode = Enum.LineJoinMode.Round
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = icon

-- Hàm chuyển HSV thành RGB
local function HSVtoRGB(h)
	local r, g, b = Color3.fromHSV(h, 1, 1):ToRGB()
	return Color3.new(r, g, b)
end

-- Cầu vồng chạy vòng vòng
task.spawn(function()
	local hue = 0
	while true do
		hue = (hue + 0.01) % 1
		stroke.Color = HSVtoRGB(hue)
		wait(0.03)
	end
end)

-- Kéo thả
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

-- Click effect
icon.MouseButton1Down:Connect(function()
	icon:TweenSize(UDim2.new(0, 55, 0, 55), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
end)

icon.MouseButton1Up:Connect(function()
	icon:TweenSize(UDim2.new(0, 60, 0, 60), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
end)

-- Bấm gửi phím K
icon.MouseButton1Click:Connect(function()
	VirtualInput:SendKeyEvent(true, Enum.KeyCode.K, false, game)
	wait(0.05)
	VirtualInput:SendKeyEvent(false, Enum.KeyCode.K, false, game)
end)
