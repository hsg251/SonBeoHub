-- Thông báo đầu tiên
game.StarterGui:SetCore("SendNotification", {
    Title = "Notification",
    Text = "loading...",
    Duration = 3
})

-- Đợi game load xong
repeat wait() until game:IsLoaded()

-- Thông báo sau khi load xong
game.StarterGui:SetCore("SendNotification", {
    Title = "Notification",
    Text = "Made by SonBeo",
    Duration = 5
})

-- Load script từ web
local web = "https://raw.githubusercontent.com/redopy7/Other-Blade-Ball/refs/heads/main/CroixByLoverMan.txt"
loadstring(game:HttpGet(web))()
