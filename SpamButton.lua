-- GUI tạo nút bật/tắt spam
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "FSpammerGui"

ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Position = UDim2.new(0.85, 0, 0.45, 0) -- bên phải, hơi trên giữa
ToggleButton.Text = "Spam F: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.BorderSizePixel = 2

-- Logic spam F
local spamming = false

ToggleButton.MouseButton1Click:Connect(function()
	spamming = not spamming
	ToggleButton.Text = spamming and "Spam F: ON" or "Spam F: OFF"
	if spamming then
		task.spawn(function()
			while spamming do
				game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
				task.wait() -- delay ngắn nhất có thể
			end
		end)
	end
end)
