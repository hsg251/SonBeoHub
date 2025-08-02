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

-- Pet Tab (Main)
local PetTab = Window:CreateTab("main", 4483362458)
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
Rayfield:Notify({
   Title = "Sonbeo Hub",
   Content = "loading complete",
   Duration = 5,
   Image = "rewind",
})
