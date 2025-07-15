print("hi! welcome to my script")
print("loading...")

wait("2")

-- Rayfield UI
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

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local PLACE_ID = game.PlaceId

local SavedSpeed = 16
local SavedJumpPower = 10
local InfiniteJumpEnabled = false
local infJumpConnection = nil

localPlayer.CharacterAdded:Connect(function(char)
	task.wait(0.5)
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.WalkSpeed = SavedSpeed
		hum.UseJumpPower = true
		hum.JumpPower = SavedJumpPower
	end

	if InfiniteJumpEnabled then
		if infJumpConnection then infJumpConnection:Disconnect() end
		infJumpConnection = UserInputService.JumpRequest:Connect(function()
			local h = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
			if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
		end)
	end
end)

-- About Tab
local AboutTab = Window:CreateTab("about", 4483362458)
local aboutsection = AboutTab:CreateSection("about")
AboutTab:CreateButton({
   Name = "facebook",
   Callback = function()
      setclipboard("https://www.facebook.com/son.thanh.le.794756/")
   end,
})

-- Main Tab
local MainTab = Window:CreateTab("main", 4483362458)
local mainsection = MainTab:CreateSection("main")

local slapActive = false
local function getOtherPlayers()
	local others = {}
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= localPlayer and player.Character then
			table.insert(others, player)
		end
	end
	return others
end

MainTab:CreateToggle({
	Name = "Slap all (except self)",
	CurrentValue = false,
	Callback = function(Value)
		slapActive = Value
		if slapActive then
			task.spawn(function()
				while slapActive do
					local others = getOtherPlayers()
					local tool = localPlayer:FindFirstChild("Backpack") and localPlayer.Backpack:FindFirstChild("Slap")
					if tool and tool:FindFirstChild("Event") then
						for _, player in pairs(others) do
							local args = {"slash", player.Character, Vector3.new(5.385, -0.0000001711, 2.646)}
							pcall(function()
								tool.Event:FireServer(unpack(args))
							end)
						end
					end
					task.wait()
				end
			end)
		end
	end
})

local slapAllActive = false
MainTab:CreateToggle({
	Name = "Slap all (including yourself)",
	CurrentValue = false,
	Callback = function(Value)
		slapAllActive = Value
		task.spawn(function()
			while slapAllActive do
				local tool = localPlayer:FindFirstChild("Backpack") and localPlayer.Backpack:FindFirstChild("Slap")
				if tool and tool:FindFirstChild("Event") then
					for _, p in pairs(Players:GetPlayers()) do
						if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
							pcall(function()
								tool.Event:FireServer("slash", p.Character, Vector3.new(5.385, -0.0000001711, 2.646))
							end)
						end
					end
				end
			task.wait()
		end
	end)
	end,
})

local skibidisection = MainTab:CreateSection("slap player")
local chosenPlayerName = "" -- lưu tên người chơi nhập vào

MainTab:CreateInput({
	Name = "Player Name to Slap",
	PlaceholderText = "enter player name",
	RemoveTextAfterFocusLost = false,
	Callback = function(text)
		chosenPlayerName = text
	end,
})

local slapChosenActive = false

MainTab:CreateToggle({
	Name = "Slap player chosen",
	CurrentValue = false,
	Callback = function(Value)
		slapChosenActive = Value
		if Value then
			task.spawn(function()
				while slapChosenActive do
					local tool = localPlayer:FindFirstChild("Backpack") and localPlayer.Backpack:FindFirstChild("Slap")
					local target = Players:FindFirstChild(chosenPlayerName)

					if tool and tool:FindFirstChild("Event") and target and target.Character then
						pcall(function()
							tool.Event:FireServer("slash", target.Character, Vector3.new(5.385, -0.0000001711, 2.646))
						end)
					end
					task.wait()
				end
			end)
		end
	end,
})

local toiletsection = MainTab:CreateSection("win")
MainTab:CreateButton({
	Name = "Teleport to Win",
	Callback = function()
		local hrp = localPlayer.Character and localPlayer.Character:WaitForChild("HumanoidRootPart")
		if hrp then
			hrp.CFrame = CFrame.new(Vector3.new(1.38, 484.94, 249.62))
		end
	end,
})

-- Player Tab
local PlayerTab = Window:CreateTab("player", 4483362458)
local player = PlayerTab:CreateSection("player")

PlayerTab:CreateSlider({
	Name = "Speed Walk",
	Range = {16, 100},
	Increment = 1,
	CurrentValue = 16,
	Callback = function(Value)
		SavedSpeed = Value
		local hum = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = Value end
	end,
})

PlayerTab:CreateSlider({
	Name = "Power Jump",
	Range = {50, 200},
	Increment = 1,
	CurrentValue = 10,
	Callback = function(Value)
		SavedJumpPower = Value
		local hum = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.UseJumpPower = true
			hum.JumpPower = Value
		end
	end,
})

PlayerTab:CreateToggle({
	Name = "Infinite Jump",
	CurrentValue = false,
	Callback = function(Value)
		InfiniteJumpEnabled = Value
		if Value then
			if infJumpConnection then infJumpConnection:Disconnect() end
			infJumpConnection = UserInputService.JumpRequest:Connect(function()
				local h = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
				if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
			end)
		else
			if infJumpConnection then infJumpConnection:Disconnect() end
			infJumpConnection = nil
		end
	end,
})

-- Server Tab
local SeverTab = Window:CreateTab("sever", 4483362458)
local sever = SeverTab:CreateSection("sever")

SeverTab:CreateButton({
	Name = "Rejoin",
	Callback = function()
		TeleportService:Teleport(game.PlaceId, localPlayer)
	end,
})

SeverTab:CreateButton({
	Name = "Hop Server",
	Callback = function()
		pcall(function()
			local servers = {}
			local url = "https://games.roblox.com/v1/games/"..PLACE_ID.."/servers/Public?sortOrder=Asc&limit=100"
			local raw = game:HttpGet(url)
			local data = HttpService:JSONDecode(raw)

			for _, s in pairs(data.data) do
				if s.playing < s.maxPlayers and s.id ~= game.JobId then
					table.insert(servers, s)
				end
			end

			if #servers > 0 then
				local chosen = servers[math.random(1, #servers)]
				TeleportService:TeleportToPlaceInstance(PLACE_ID, chosen.id, localPlayer)
			end
		end)
	end,
})

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
