-- ==================== SHOOT MURDERER - CLICK VÀO TỌA ĐỘ ====================
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualInput = game:GetService("VirtualInputManager")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ShootMurdererGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

-- Nút chính
local mainButton = Instance.new("TextButton")
mainButton.Size = UDim2.new(0, 140, 0, 40)
mainButton.Position = UDim2.new(0.5, -70, 0.5, -20)
mainButton.Text = "Shoot Murderer"
mainButton.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
mainButton.TextColor3 = Color3.new(1,1,1)
mainButton.Font = Enum.Font.GothamBold
mainButton.TextSize = 14
mainButton.Parent = screenGui

-- Menu Frame
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 180, 0, 150)
menuFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
menuFrame.BorderSizePixel = 1
menuFrame.BorderColor3 = Color3.fromRGB(100,100,100)
menuFrame.Visible = false
menuFrame.Parent = screenGui

local menuTitle = Instance.new("TextLabel")
menuTitle.Size = UDim2.new(1, 0, 0, 30)
menuTitle.Text = "Options"
menuTitle.BackgroundTransparency = 1
menuTitle.TextColor3 = Color3.new(1,1,1)
menuTitle.Font = Enum.Font.GothamBold
menuTitle.TextSize = 14
menuTitle.Parent = menuFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Parent = menuFrame

local toggleHideBtn = Instance.new("TextButton")
toggleHideBtn.Size = UDim2.new(1, -20, 0, 35)
toggleHideBtn.Position = UDim2.new(0, 10, 0, 35)
toggleHideBtn.Text = "Hide Button"
toggleHideBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
toggleHideBtn.TextColor3 = Color3.new(1,1,1)
toggleHideBtn.Parent = menuFrame

local lockDragBtn = Instance.new("TextButton")
lockDragBtn.Size = UDim2.new(1, -20, 0, 35)
lockDragBtn.Position = UDim2.new(0, 10, 0, 75)
lockDragBtn.Text = "Lock Drag: OFF"
lockDragBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
lockDragBtn.TextColor3 = Color3.new(1,1,1)
lockDragBtn.Parent = menuFrame

local keybindBtn = nil
if not UIS.TouchEnabled then
    keybindBtn = Instance.new("TextButton")
    keybindBtn.Size = UDim2.new(1, -20, 0, 35)
    keybindBtn.Position = UDim2.new(0, 10, 0, 115)
    keybindBtn.Text = "Keybind: K"
    keybindBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    keybindBtn.TextColor3 = Color3.new(1,1,1)
    keybindBtn.Parent = menuFrame
    menuFrame.Size = UDim2.new(0, 180, 0, 155)
end

-- Trạng thái
local hidden = false
local dragLocked = false
local keybind = Enum.KeyCode.K
local waitingForKey = false

-- ==================== CHỨC NĂNG CHÍNH ====================
-- Kiểm tra có súng (cầm tool chứa "gun")
local function hasGun()
    local char = LocalPlayer.Character
    if not char then return false end
    for _, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") and tool.Name:lower():find("gun") then
            return true
        end
    end
    return false
end

-- Tìm Murderer (người cầm knife)
local function findMurderer()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local char = plr.Character
            if char then
                for _, tool in ipairs(char:GetChildren()) do
                    if tool:IsA("Tool") and tool.Name:lower():find("knife") then
                        return plr
                    end
                end
            end
        end
    end
    return nil
end

-- Chuyển world -> screen (trả về Vector2 hoặc nil)
local function worldToScreen(worldPos)
    local cam = workspace.CurrentCamera
    if not cam then return nil end
    local screenPoint, onScreen = cam:WorldToScreenPoint(worldPos)
    if onScreen then
        return Vector2.new(screenPoint.X, screenPoint.Y)
    end
    return nil
end

-- Click chuột trái tại tọa độ (x, y) trên màn hình
local function clickAt(x, y)
    -- Đảm bảo tọa độ nằm trong màn hình
    local viewport = game:GetService("GuiService"):GetViewportSize()
    x = math.clamp(x, 0, viewport.X)
    y = math.clamp(y, 0, viewport.Y)

    -- Dùng VirtualInputManager để gửi sự kiện (hỗ trợ hầu hết executor)
    if VirtualInput then
        VirtualInput:SendMouseMoveEvent(Vector2.new(x, y), Enum.UserInputType.MouseMovement)
        task.wait(0.03)
        VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton1, Enum.UserInputState.Begin, nil, false)
        task.wait(0.05)
        VirtualInput:SendMouseButtonEvent(Enum.UserInputType.MouseButton1, Enum.UserInputState.End, nil, false)
        return true
    end
    
    -- Fallback: nếu không có VirtualInput (hiếm), thử dùng mouse1click (không chính xác)
    mouse1click()
    print("⚠️ Không thể click chính xác, đã dùng mouse1click() thông thường.")
    return false
end

-- Hành động chính
local function shootMurderer()
    if not hasGun() then
        print("❌ Bạn không có súng!")
        return
    end
    
    local murderer = findMurderer()
    if not murderer then
        print("❌ Không tìm thấy Murderer (không ai cầm knife).")
        return
    end
    
    local char = murderer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local screenPos = worldToScreen(hrp.Position)
    if not screenPos then
        print("⚠️ Murderer không trong tầm nhìn (ngoài màn hình).")
        return
    end
    
    clickAt(screenPos.X, screenPos.Y)
    print("🔫 Đã bắn vào Murderer " .. murderer.Name .. " tại tọa độ " .. tostring(screenPos))
end

-- ==================== XỬ LÝ MENU & KÉO THẢ ====================
local function showMenu()
    local btnPos = mainButton.Position
    local offsetX = 20
    local offsetY = -menuFrame.AbsoluteSize.Y - 10
    menuFrame.Position = UDim2.new(btnPos.X.Scale, btnPos.X.Offset + offsetX, btnPos.Y.Scale, btnPos.Y.Offset + offsetY)
    menuFrame.Visible = true
end

local function hideMenu()
    menuFrame.Visible = false
end

closeBtn.MouseButton1Click:Connect(hideMenu)

-- Đóng menu khi click ra ngoài
UIS.InputBegan:Connect(function(input, gp)
    if menuFrame.Visible and not gp then
        local mousePos = UIS:GetMouseLocation()
        local menuPos = menuFrame.AbsolutePosition
        local menuSize = menuFrame.AbsoluteSize
        if mousePos.X < menuPos.X or mousePos.X > menuPos.X + menuSize.X or
           mousePos.Y < menuPos.Y or mousePos.Y > menuPos.Y + menuSize.Y then
            hideMenu()
        end
    end
end)

toggleHideBtn.MouseButton1Click:Connect(function()
    hidden = not hidden
    mainButton.Visible = not hidden
    toggleHideBtn.Text = hidden and "Show Button" or "Hide Button"
    hideMenu()
end)

lockDragBtn.MouseButton1Click:Connect(function()
    dragLocked = not dragLocked
    lockDragBtn.Text = dragLocked and "Lock Drag: ON" or "Lock Drag: OFF"
    hideMenu()
end)

if keybindBtn then
    keybindBtn.MouseButton1Click:Connect(function()
        waitingForKey = true
        keybindBtn.Text = "Press any key..."
        hideMenu()
    end)
end

UIS.InputBegan:Connect(function(input, gp)
    if waitingForKey then
        if input.KeyCode ~= Enum.KeyCode.Unknown then
            keybind = input.KeyCode
            waitingForKey = false
            if keybindBtn then keybindBtn.Text = "Keybind: " .. keybind.Name end
        end
        return
    end
    if not gp and input.KeyCode == keybind and not hidden then
        shootMurderer()
    end
end)

-- Kéo thả nút
local dragging = false
local dragStart = nil
local startPos = nil

mainButton.InputBegan:Connect(function(input)
    if dragLocked then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainButton.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and not dragLocked then
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            mainButton.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end
end)

mainButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Mở menu bằng chuột phải hoặc giữ lâu
mainButton.MouseButton2Click:Connect(showMenu)
if UIS.TouchEnabled then
    mainButton.TouchLongPress:Connect(showMenu)
end

-- Click trái nút chính
mainButton.MouseButton1Click:Connect(function()
    if not hidden then
        shootMurderer()
    end
end)

