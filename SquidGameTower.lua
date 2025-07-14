local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "SonBeo Hub - squid game tower",
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

-- Lưu cấu hình
local SavedSpeed = 16
local SavedJumpPower = 10
local InfiniteJumpEnabled = false
local infJumpConnection = nil

-- Gán lại sau khi reset
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
AboutTab:CreateButton({
   Name = "facebook",
   Callback = function()
      setclipboard("https://www.facebook.com/son.thanh.le.794756/")
   end,
})

-- Main Tab
local MainTab = Window:CreateTab("main", 4483362458)

-- Slap all (except self)
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
							local args = {
								"slash",
								player.Character,
								Vector3.new(-5.848731994628906, 0, -1.338780164718628)
							}
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

-- Slap all (including yourself)
local slapAllActive = false
MainTab:CreateToggle({
	Name = "Slap all (including yourself) [FAST]",
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

-- Teleport to win
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
	Range = {10, 200},
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

-- Rejoin
SeverTab:CreateButton({
	Name = "Rejoin",
	Callback = function()
		TeleportService:Teleport(game.PlaceId, localPlayer)
	end,
})

-- Server Hop
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

-- Notify
wait(1.5)
Rayfield:Notify({
	Title = "SonBeo Hub",
	Content = "Loading complete",
	Duration = 5,
	Image = "rbxassetid://4483362458",
})
