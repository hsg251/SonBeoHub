loadstring(game:HttpGet(("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua")))()

       local Window = MakeWindow({
         Hub = {
         Title = "SonBeo Hub",
         Animation = "facebook: Thanh Sơn Lê:)"
         },
        Key = {
        KeySystem = false,
        Title = "Key System",
        Description = "",
        KeyLink = "",
        Keys = {"1234"},
        Notifi = {
        Notifications = true,
        CorrectKey = "Running the Script...",
       Incorrectkey = "The key is incorrect",
       CopyKeyLink = "Copied to Clipboard"
      }
    }
  })

       MinimizeButton({
       Image = "http://www.roblox.com/asset/?id=72084290375057",
       Size = {60, 60},
       Color = Color3.fromRGB(10, 10, 10),
       Corner = true,
       Stroke = false,
       StrokeColor = Color3.fromRGB(255, 0, 0)
      })
      
------ Tab
     local Tab1o = MakeTab({Name = "Giới Thiệu"})
     local Tab2o = MakeTab({Name = "SonBeo Hub"})
     local Tab3o = MakeTab({Name = "Script Khác"})
     
------- BUTTON
    
AddButton(Tab1o, {
    Name = "facebook(Thanh Sơn Lê)",
    Callback = function()
        setclipboard("https://www.facebook.com/thanh.son.le.581360/")
    end
})

AddButton(Tab2o, {
    Name = "Version 1",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hsg251/bolocphut/refs/heads/main/1234567865434567887654345.lua"))()
    end
})

AddButton(Tab2o, {
    Name = "Version 2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hsg251/bolocphut/refs/heads/main/4567876567886545678765456.lua"))()
    end
})

AddButton(Tab3o, {
    Name = "DatTHG"
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/DatThg/refs/heads/main/DatThgV1"))()
    end
})

AddButton(Tab3o, {
    Name = "W-azure"
    Callback = function()
        getgenv().Team = "Pirates"
        getgenv().AutoLoad = true --Will Load Script On Server Hop
        getgenv().SlowLoadUi  = false
        getgenv().ForceUseSilentAimDashModifier = false --Force turn on silent aim , if error then executor problem
        getgenv().ForceUseWalkSpeedModifier = false --Force turn on Walk Speed Modifier , if error then executor problem
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))()
    end
})

AddButton(Tab3o, {
    Name = "Annie Hub"
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/1st-Mars/Annie/main/1st.lua'))()
    end
})

AddButton(Tab3o, {
    Name = "Tsuo Hub"
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"))()
    end
})

AddButton(Tab3o, {
    Name = "Banana Cat Hub(Fake)"
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kimprobloxdz/Banana-Free/refs/heads/main/Protected_5609200582002947.lua.txt"))()
    end
})

AddButton(Tab3o, {
    Name = "Xero Hub"
    Callback = function()
        getgenv().Team = "Pirates" -- Pirates/Marines
        getgenv().Fix_Lag = true -- true/false
        loadstring(game:HttpGet("https://xerohub.click/script/main.lua"))()
    end
})
