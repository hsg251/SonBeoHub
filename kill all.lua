local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Hidden = false
local DragLocked = false
local Keybind = Enum.KeyCode.K

-- =============================== --
--        HÀM BRING NGƯỜI CHƠI      --
-- =============================== --
local function BringAllPlayersToFront()
    local player = LP
    local character = player.Character
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if not character or not rootPart then
        warn("❌ Nhân vật chưa spawn hoặc không tìm thấy HumanoidRootPart!")
        return
    end

    -- Cấu hình
    local distanceInFront = 5      -- Khoảng cách từ bạn đến vị trí đặt người chơi
    local spacing = 4               -- Khoảng cách giữa các người chơi (theo chiều ngang)

    -- Lấy hướng mặt của bạn
    local lookVector = rootPart.CFrame.LookVector
    local rightVector = rootPart.CFrame.RightVector
    local upVector = rootPart.CFrame.UpVector
    local basePosition = rootPart.Position + (lookVector * distanceInFront)

    -- Lấy danh sách người chơi khác
    local otherPlayers = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player then
            table.insert(otherPlayers, plr)
        end
    end

    if #otherPlayers == 0 then
        print("⚠️ Không có người chơi khác trong server.")
        return
    end

    -- Dịch chuyển từng người
    for i, targetPlayer in ipairs(otherPlayers) do
        local targetChar = targetPlayer.Character
        if targetChar then
            local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                -- Tính toán vị trí: xếp hàng ngang, cách đều nhau
                local offset = (i - (#otherPlayers + 1) / 2) * spacing
                local targetPosition = basePosition + (rightVector * offset) + (upVector * 0) -- giữ nguyên độ cao
                local newCFrame = CFrame.new(targetPosition)

                task.wait(0.05) -- giảm lag nhẹ

                targetRoot.CFrame = newCFrame
                print("✅ Đã dịch chuyển " .. targetPlayer.Name .. " ra trước mặt.")
            else
                warn("⚠️ " .. targetPlayer.Name .. " không có HumanoidRootPart.")
            end
        else
            warn("⚠️ " .. targetPlayer.Name .. " chưa có nhân vật (Character).")
        end
    end

    print("🎉 Hoàn tất! Tất cả người chơi đã ở trước mặt bạn.")
end

-- Hàm KillAll cũ được thay bằng BringAllPlayersToFront
local function KillAll()
    BringAllPlayersToFront()
end

-- =============================== --
--          PHẦN GUI (GIỮ NGUYÊN)   --
-- =============================== --
local MainButton = Instance.new("TextButton")
MainButton.Size = UDim2.new(0,120,0,40)
MainButton.Position = UDim2.new(0.5,-60,0.5,-20)
MainButton.Text = "Kill All"
MainButton.Parent = ScreenGui

local Menu = Instance.new("Frame")
Menu.Size = UDim2.new(0,200,0,180)
Menu.Position = UDim2.new(0.5,-100,0.5,-90)
Menu.BackgroundColor3 = Color3.fromRGB(30,30,30)
Menu.Visible = false
Menu.Parent = ScreenGui

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(1,0,0,30)
Close.Text = "X"
Close.Parent = Menu

local ToggleHide = Instance.new("TextButton")
ToggleHide.Size = UDim2.new(1,-10,0,40)
ToggleHide.Position = UDim2.new(0,5,0,40)
ToggleHide.Text = "Hide Button"
ToggleHide.Parent = Menu

local LockDrag = Instance.new("TextButton")
LockDrag.Size = UDim2.new(1,-10,0,40)
LockDrag.Position = UDim2.new(0,5,0,85)
LockDrag.Text = "Lock Drag: OFF"
LockDrag.Parent = Menu

local KeybindBtn

if not UIS.TouchEnabled then
    KeybindBtn = Instance.new("TextButton")
    KeybindBtn.Size = UDim2.new(1,-10,0,40)
    KeybindBtn.Position = UDim2.new(0,5,0,130)
    KeybindBtn.Text = "Keybind: "..Keybind.Name
    KeybindBtn.Parent = Menu
end

Close.MouseButton1Click:Connect(function()
    Menu.Visible = false
end)

ToggleHide.MouseButton1Click:Connect(function()
    Hidden = not Hidden

    if Hidden then
        MainButton.Visible = false
        ToggleHide.Text = "Show Button"
    else
        MainButton.Visible = true
        ToggleHide.Text = "Hide Button"
    end
end)

LockDrag.MouseButton1Click:Connect(function()
    DragLocked = not DragLocked
    LockDrag.Text = "Lock Drag: "..(DragLocked and "ON" or "OFF")
end)

if KeybindBtn then
    local WaitingForKey = false

    KeybindBtn.MouseButton1Click:Connect(function()
        WaitingForKey = true
        KeybindBtn.Text = "Press a key..."
    end)

    UIS.InputBegan:Connect(function(input,gp)
        if gp then return end

        if WaitingForKey and input.KeyCode ~= Enum.KeyCode.Unknown then
            Keybind = input.KeyCode
            WaitingForKey = false
            KeybindBtn.Text = "Keybind: "..Keybind.Name
        elseif input.KeyCode == Keybind then
            KillAll()
        end
    end)
end

MainButton.MouseButton1Click:Connect(function()
    KillAll()
end)

MainButton.MouseButton2Click:Connect(function()
    Menu.Visible = not Menu.Visible
end)

if UIS.TouchEnabled then
    local Holding = false

    MainButton.TouchLongPress:Connect(function(_,state)
        if state == Enum.UserInputState.Begin then
            Menu.Visible = not Menu.Visible
        end
    end)
end

local Dragging = false
local DragStart
local StartPos

MainButton.InputBegan:Connect(function(input)
    if DragLocked then return end

    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = input.Position
        StartPos = MainButton.Position
    end
end)

MainButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if Dragging and not DragLocked then
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

            local Delta = input.Position - DragStart

            MainButton.Position = UDim2.new(
                StartPos.X.Scale,
                StartPos.X.Offset + Delta.X,
                StartPos.Y.Scale,
                StartPos.Y.Offset + Delta.Y
            )
        end
    end
end)
