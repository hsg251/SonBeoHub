local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "FSpammerGui"

ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Position = UDim2.new(0.85, 0, 0.45, 0) -- bên phải, hơi trên giữa
ToggleButton.Text = "[e] Spam F: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.BorderSizePixel = 2

local UserInputService = game:GetService("UserInputService")

local spamming = false

local function toggleSpam()
    spamming = not spamming
    ToggleButton.Text = spamming and "[e] Spam F: ON" or "[e] Spam F: OFF"
    if spamming then
        task.spawn(function()
            while spamming do
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                task.wait(0) -- delay ngắn nhất có thể
            end
        end)
    end
end

ToggleButton.MouseButton1Click:Connect(toggleSpam)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.E then
            toggleSpam()
        end
    end
end)
