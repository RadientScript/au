if game.GameId == 2655311011 then

    if not game:IsLoaded() then game.Loaded:Wait() end

    _G.Settings = {
        MapName         = "Titan Dimension";
        Difficulty      = "Easy";
        Hardcore        = false;
        FriendsOnly     = false;
        AutoFarm        = false;
        AutoRetry       = false;
        AutoSkill       = false;
        AutoDistance    = false;
        Distance        = 0;
        Speed           = 69;
    }

    local foldername = "NOUZU"
    local filename = "NewAnimeDimension.lua"
     
    function saveSettings()
        local HttpService = game:GetService("HttpService")
        local json = HttpService:JSONEncode(_G.Settings)
        if (writefile) then
            if isfolder(foldername) then
                writefile(foldername.."\\"..filename, json)
            else
                makefolder(foldername)
                writefile(foldername.."\\"..filename, json)
            end
        end
    end
     
    function loadSettings()
        local HttpService = game:GetService("HttpService")
        if isfile(foldername.."\\"..filename) then
            _G.Settings = HttpService:JSONDecode(readfile(foldername.."\\"..filename))
        end
    end
     
    loadSettings()

    local ReplicatedStorage     = game:GetService("ReplicatedStorage")
    local VirtualInputManager   = game:GetService("VirtualInputManager")
    local Players               = game:GetService("Players")
    local VirtualUser           = game:GetService("VirtualUser")
    local TweenService          = game:GetService("TweenService")
    local Player                = Players.LocalPlayer

    Player.Idled:Connect(function()
        VirtualUser:ClickButton2(Vector2.new())
    end)

    local MapList = {
        "Infinite Mode",
        "Titan Dimension",
        "Demon Dimension",
        "Curse Dimension",
        "Villain Dimension",
        "Sword Dimension",
        "Ghoul Dimension",
        "Fate Dimension"
    }

    local MapDifficulty = {
        "Infinite",
        "Easy",
        "Hard",
        "Nightmare",
    }

    local SkillFrame = Player.PlayerGui.UniversalGui.UniversalCenterUIFrame.SlotsHolder

    function Skill(a)
        VirtualInputManager:SendKeyEvent(true, a, false, game) 
        VirtualInputManager:SendKeyEvent(false, a, false, game) 
    end

    function tween(Enemy)
        local plr,tp = Player.Character.HumanoidRootPart,nil
        
        if _G.Settings.AutoDistance then
            tp = {CFrame = Enemy.CFrame * CFrame.new(0,lol,0) * CFrame.Angles((90),0,0)}
        else
            if _G.Settings.Distance >= 1 then
                tp = {CFrame = Enemy.CFrame * CFrame.new(0,_G.Settings.Distance,0) * CFrame.Angles(math.rad(-90),0,0)}
            elseif _G.Settings.Distance <= 0 then
                tp = {CFrame = Enemy.CFrame * CFrame.new(0,_G.Settings.Distance,0) * CFrame.Angles(math.rad(90),0,0)}
            end
        end

        local Time = (plr.Position - Enemy.Position).Magnitude/_G.Settings.Speed
        local a = TweenService:Create(plr, TweenInfo.new(Time, Enum.EasingStyle.Linear), tp)
        a:Play()
    end

    function click()
        local vi = game:service'VirtualInputManager'
        vi:SendMouseButtonEvent(500,500, 0, true, game, 1)
        wait()
        vi:SendMouseButtonEvent(500,500, 0, false, game, 1)
        wait()
        vi:SendMouseButtonEvent(500,500, 0, true, game, 1)
        wait()
        vi:SendMouseButtonEvent(500,500, 0, false, game, 1)
    end

    function startGame()
        task.spawn(function()
            local args = {
                "CreateRoom",
                {
                    ["Difficulty"] = _G.Settings.Difficulty,
                    ["FriendsOnly"] = _G.Settings.FriendsOnly,
                    ["MapName"] = _G.Settings.MapName,
                    ["Hardcore"] = _G.Settings.Hardcore
                }
            }
            ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer(unpack(args))
            wait()
            ReplicatedStorage.RemoteFunctions.MainRemoteFunction:InvokeServer("TeleportPlayers")
        end)
    end 
    
    task.spawn(function()
        game:GetService("RunService").Stepped:Connect(function()
            if _G.Settings.AutoFarm then
                if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                    setfflag("HumanoidParallelRemoveNoPhysics", "False")
                    setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
                    --game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
                        if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
                            local BodyVelocity = Instance.new("BodyVelocity")
                            BodyVelocity.Name = "BodyVelocity1"
                            BodyVelocity.Parent =  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
                            BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
                            BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                        end
                    end
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end)

    task.spawn(function()
        game:GetService("RunService").Stepped:Connect(function()
            if not _G.Settings.AutoFarm then
                if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.BodyVelocity1:Destroy()
                end
            end
        end)
    end)

    local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/uzu01/lua/main/ui/uwuware.lua"))()
    local window = library:CreateWindow("Anime Dimension")
    local FarmingFolder = window:AddFolder("Farming")
    local SettingFolder = window:AddFolder("Settings")
    local MiscFolder = window:AddFolder("Credits")

    FarmingFolder:AddToggle({
        text = "Enabled", 
        state = _G.Settings.AutoFarm,
        callback = function(a) 
            _G.Settings.AutoFarm = a
            saveSettings()

            startGame()

            task.spawn(function()
                while task.wait() do
                    if not _G.Settings.AutoFarm then break end
                    pcall(function()
                        for i, v in pairs(game:GetService("Workspace").Folders.Monsters:GetChildren()) do 
                            if v:FindFirstChild("EnemyHealthBarGui") then
                                if _G.Settings.AutoDistance then
                                    lol = -(v.HumanoidRootPart.Size.Y + 5.5)
                                end
                                repeat task.wait()
                                    tween(v.HumanoidRootPart);task.spawn(click)
                                until v.EnemyHealthBarGui == nil or not _G.Settings.AutoFarm
                            end
                        end
                    end)
                end
            end)
        end 
    })

    SettingFolder:AddList({
        text = "Select Map", 
        value = _G.Settings.MapName,
        values = MapList, 
        callback = function(a) 
            _G.Settings.MapName = a
            saveSettings() 
        end
    })  

    SettingFolder:AddList({
        text = " Select Difficulty", 
        value = _G.Settings.Difficulty,
        values = MapDifficulty, 
        callback = function(a) 
            _G.Settings.Difficulty = a
            saveSettings() 
        end
    })

    SettingFolder:AddToggle({
        text = "Friends Only", 
        state = _G.Settings.FriendsOnly,
        callback = function(a) 
            _G.Settings.FriendsOnly = a
            saveSettings()
        end
    })

    SettingFolder:AddToggle({
        text = "Hardcore", 
        state = _G.Settings.Hardcore,
        callback = function(a) 
            _G.Settings.Hardcore = a
            saveSettings()
        end
    })

    SettingFolder:AddToggle({
        text = "Auto Retry", 
        state = _G.Settings.AutoRetry,
        callback = function(a) 
            _G.Settings.AutoRetry = a
            saveSettings()
          
            task.spawn(function()
                while task.wait(1) do
                    if not _G.Settings.AutoRetry then break end
                    if Player.PlayerGui.UniversalGui.UniversalCenterUIFrame.ResultUI.Visible == true then
                        ReplicatedStorage.RemoteEvents.MainRemoteEvent:FireServer("RetryDungeon")
                        break
                    end
                end
            end)
        end
    })

    SettingFolder:AddToggle({
        text = "Auto Skill", 
        state = _G.Settings.AutoSkill,
        callback = function(a) 
            _G.Settings.AutoSkill = a
            saveSettings()

            task.spawn(function()
                while task.wait(1.5) do
                    if not _G.Settings.AutoSkill then break end
                    if SkillFrame.Skill1.Image ~= "rbxassetid://6797200424" then
                        Skill("One")
                        task.wait(1)
                    end
                    if SkillFrame.Skill2.Image ~= "rbxassetid://6797200424" then
                        Skill("Two")
                        task.wait(1)
                    end
                    if SkillFrame.Skill3.Image ~= "rbxassetid://6797200424" then
                        Skill("Three")
                        task.wait(1)
                    end
                    if SkillFrame.Skill4.Image ~= "rbxassetid://6797200424" then
                        Skill("Four")
                        task.wait(1)
                    end
                    if SkillFrame.SkillAssist1.Image ~= "rbxassetid://6797200424" then
                        Skill("E")
                        task.wait(1)
                    end
                    if SkillFrame.SkillAssist2.Image ~= "rbxassetid://6797200424" then
                        Skill("R")
                        task.wait(1)
                    end
                end
            end)
        end
    })

    SettingFolder:AddToggle({
        text = "Auto Distance", 
        state = _G.Settings.AutoDistance,
        callback = function(a) 
            _G.Settings.AutoDistance = a
            saveSettings()
        end
    })

    SettingFolder:AddSlider({
        text = "Distance",
        value = _G.Settings.Distance,
        min = -30, 
        max = 30, 
        callback = function(a) 
            _G.Settings.Distance = a 
            saveSettings()
        end
    })

    SettingFolder:AddSlider({
        text = "Speed",
        value = _G.Settings.Speed,
        min = 10, 
        max = 200, 
        callback = function(a) 
            _G.Settings.Speed = a 
            saveSettings()
        end
    })

    MiscFolder:AddBind({
        text = "Toggle GUI", 
        key = "LeftControl", 
        callback = function() 
            library:Close()
        end
    })

    MiscFolder:AddButton({
        text = "Script by Uzu",
        callback = function()
            setclipboard("discord.gg/waAsQFwcBn")
        end
    })

    MiscFolder:AddButton({
        text = "Discord",
        callback = function()
            setclipboard("discord.gg/waAsQFwcBn")
        end
    })
    
    library:Init()

end
