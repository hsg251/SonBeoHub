--// Rayfield UI Loader
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Ultimate Dodgeball Script",
    LoadingTitle = "Auto Parry System",
    LoadingSubtitle = "by Sơn Đẹp Trai =))",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "DodgeballScript",
        FileName = "Settings"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false,
})

--// Biến toàn cục
local AutoParryEnabled = false
local AutoSpamFEnabled = false
local isSpamming = false
local ReactionTime = 0.2 -- giây
local LastParryTime = 0

--// Hàm Parry
function TryParry()
    local now = tick()
    if now - LastParryTime >= ReactionTime then
        LastParryTime = now
        local vim = game:GetService("VirtualInputManager")
        vim:SendKeyEvent(true, Enum.KeyCode.F, false, game)
        task.wait(0.05)
        vim:SendKeyEvent(false, Enum.KeyCode.F, false, game)
        print("🛡️ Auto Parry activated!")
    end
end

--// Hàm Spam F
function pressF()
    local vim = game:GetService("VirtualInputManager")
    vim:SendKeyEvent(true, Enum.KeyCode.F, false, game)
    task.wait(0.05)
    vim:SendKeyEvent(false, Enum.KeyCode.F, false, game)
end

--// Giả lập phát hiện bóng đến gần
function BallIsTooFast()
    -- Đây là hàm demo! Trong thực tế bạn cần thay bằng hàm thật để xác định ball đang đến và quá nhanh.
    -- Cho ví dụ random 10% sẽ bị fail
    return math.random(1, 100) <= 10
end

--// Auto Parry chạy liên tục
task.spawn(function()
    while task.wait(0.01) do
        if AutoParryEnabled then
            if not BallIsTooFast() then
                TryParry()
            end
        end
    end
end)

--// Auto Spam F nếu parry fail
task.spawn(function()
    while task.wait(0.1) do
        if AutoSpamFEnabled and AutoParryEnabled then
            if BallIsTooFast() then
                if not isSpamming then
                    isSpamming = true
                    print("⚠️ Ball quá nhanh! Bắt đầu spam F!")
                    task.spawn(function()
                        while isSpamming and AutoSpamFEnabled do
                            pressF()
                            task.wait(0.1)
                        end
                    end)
                end
            else
                if isSpamming then
                    isSpamming = false
                    print("✅ Ball bình thường. Ngừng spam F.")
                end
            end
        else
            isSpamming = false
        end
    end
end)

--// Tab Main
local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateToggle({
    Name = "Auto Parry",
    CurrentValue = false,
    Callback = function(Value)
        AutoParryEnabled = Value
        print("Auto Parry: " .. tostring(Value))
    end,
})

MainTab:CreateToggle({
    Name = "Auto Spam F khi quá nhanh",
    CurrentValue = false,
    Callback = function(Value)
        AutoSpamFEnabled = Value
        print("Auto Spam F: " .. tostring(Value))
    end,
})

--// Tab Setting
local SettingTab = Window:CreateTab("Setting", 4483362458)

SettingTab:CreateSlider({
    Name = "Thời gian phản ứng (s)",
    Range = {0.05, 0.5},
    Increment = 0.01,
    Suffix = "giây",
    CurrentValue = ReactionTime,
    Callback = function(Value)
        ReactionTime = Value
        print("Đặt lại thời gian phản ứng: " .. Value)
    end,
})

--// UI Ready
Rayfield:Notify({
    Title = "✅ Script Đã Bật",
    Content = "Chơi vui nhé ông thần =))",
    Duration = 5,
    Image = nil,
    Actions = {
        Ignore = {
            Name = "Ok",
            Callback = function() end
        },
    },
})
