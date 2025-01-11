repeat task.wait() until game:IsLoaded()
repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Loading").Enabled == false

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Gym",
    SubTitle = "by JayKung",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Server = Window:AddTab({ Title = "Server", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

local RandomPlay = ""
local FullOption = {"benchpress", "treadmill","frontsquat","crunch","legpress","wristcurl","hammercurl","deadlift","pushpress","tricepscurl"}

Tabs.Main:AddToggle("AutoFarm", { Title = "Auto KaiTun", Default = false })
Tabs.Main:AddToggle("AutoFarmRandom", { Title = "Auto Farm Random", Default = false })
Tabs.Main:AddToggle("AutoYeti", { Title = "Auto Yeti", Default = false })
Tabs.Main:AddToggle("AutoFarmStamina", { Title = "Auto Stamina", Default = false })
Tabs.Main:AddToggle("AutoComp", { Title = "Auto Competition", Default = false })
Tabs.Main:AddToggle("AutoTrain", { Title = "Auto Train", Default = false })
Tabs.Main:AddToggle("AutoUse", { Title = "Auto Use Boost", Default = true })
Tabs.Main:AddToggle("AutoGear", { Title = "Auto Random Gear", Default = false })
Tabs.Main:AddToggle("OpenQueue", { Title = "Advance Queue", Default = true })
Tabs.Main:AddToggle("EnableHop", { Title = "Enable Hop", Default = false })
Tabs.Main:AddButton({Title = "Change Equipment",Description = "",Callback = function()
    RandomPlay = FullOption[math.random(#FullOption)]
    print(RandomPlay)
end})

Tabs.Main:AddButton({Title = "See Competition",Description = "",Callback = function()
    workspace.Podium.entrance.billboard.billboard.MaxDistance = 9e9
end})

local PlayType = ""
local PlayComp = ""
local Queue = false
local ProgressPodium = false
local FinishBody = false
local AllPercent = 0

local character = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local function shuffleTable(tbl)
    local size = #tbl
    for i = size, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
end

local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

local function checkplay()
  
    for _, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.Stats:GetChildren()) do
        if v:IsA("ImageButton") then
            if v:FindFirstChild("Frame") and v.Frame:FindFirstChild("APercentage") then
                local percentageText = v.Frame.APercentage.Text:gsub("[^%d%.]", "")
                local percentageNumber = tonumber(percentageText)
    
                local AllText = game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Frame:FindFirstChild("APercentage").Text:gsub("[^%d%.]", "")
                local AllPercent = tonumber(AllText)
    
                local StaminaText = game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.Stamina.Frame:FindFirstChild("APercentage").Text:gsub("[^%d%.]", "")
                local StaminaPercent = tonumber(StaminaText)
    
                if StaminaPercent < 100 then
                    PlayType = "treadmill"
                elseif percentageNumber < 100 then
                    local muscleToPlayType = {
                        Chest = "benchpress",
                        Triceps = {"triceppushdown", "tricepscurl"},
                        Shoulder = {"shoulderpress", "pushpress"},
                        Back = {"deadlift", "rowing"},
                        Biceps = {"barcable", "hammercurl"},
                        Forearm = "wristcurl",
                        Legs = "legpress",
                        Abs = "crunch",
                        Calves = "frontsquat"
                    }
    
                    local playOptions = muscleToPlayType[v.Name]
                    if type(playOptions) == "table" then
                        for _, option in ipairs(playOptions) do
                            if workspace.Equipments:FindFirstChild(option) then
                                PlayType = option
                                break
                            end
                        end
                    elseif type(playOptions) == "string" and workspace.Equipments:FindFirstChild(playOptions) then
                        PlayType = playOptions
                    else
                        PlayType = "treadmill"
                    end
                elseif AllPercent >= 100 then
                    if RandomPlay == "" or RandomPlay == nil then
                        for _, option in ipairs(FullOption) do
                            if workspace.Equipments:FindFirstChild(option) then
                                RandomPlay = option
                                break
                            end
                        end
                    end
                    PlayType = RandomPlay
                end
            end
        end
    end
    
end

local function canTp(cframe)
    if game.Players.LocalPlayer:GetAttribute("ragdolled") == nil or game.Players.LocalPlayer:GetAttribute("ragdolled") == false then
        if game:GetService("Players").LocalPlayer:GetAttribute("equipment") == nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment") == "" then
            if not Queue then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframe
            else
                game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("MiniPodiumService"):WaitForChild("RF"):WaitForChild("Teleport"):InvokeServer()
            end
        else
            game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()
        end
    end
end

local function activateTool(tool)
    tool:Activate()
    print("Used item:", tool.Name)
end

local function interactWithPrompt(prompt)
    if prompt and prompt:IsA("ProximityPrompt") then
        prompt.Enabled = true
        prompt.HoldDuration = 0
        prompt.RequiresLineOfSight = false
        prompt.MaxActivationDistance = math.huge

        fireproximityprompt(prompt)
    end
end

local function fullyplay(Type,EquipmentName,Jump)
    if Jump then if game:GetService("Players").LocalPlayer:GetAttribute("equipment") then if string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),Type) then else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer() end end end
    if not game:GetService("Players").LocalPlayer:GetAttribute("equipment") or game:GetService("Players").LocalPlayer:GetAttribute("equipment") == "" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = EquipmentName.root.CFrame
        task.wait(.1)
        interactWithPrompt(EquipmentName.root:FindFirstChild("ProximityPrompt"))
        task.wait(1)
    end
end

local function randomplay()
    for i,v in pairs(workspace.Equipments:GetChildren()) do
        if v.Name == RandomPlay then

            if game:GetService("Players").LocalPlayer:GetAttribute("equipment") then if string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),RandomPlay) then else game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer() end end

            if v:GetAttribute("occupied") and game:GetService("Players").LocalPlayer:GetAttribute("equipment") and string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),v.Name) then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.root.CFrame * CFrame.new(0,300,0)
            elseif v:GetAttribute("occupied") then
                RandomPlay = FullOption[math.random(#FullOption)]
            else
                if not game:GetService("Players").LocalPlayer:GetAttribute("equipment") or game:GetService("Players").LocalPlayer:GetAttribute("equipment") == "" then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.root.CFrame
                    task.wait(.1)
                    interactWithPrompt(v.root:FindFirstChild("ProximityPrompt"))
                    task.wait(1)
                end
            end

        end
    end
end

task.spawn(function()
    while task.wait() do
        RandomPlay = FullOption[math.random(#FullOption)]
        print("Random :",RandomPlay)
        task.wait(300)
    end
end)

task.spawn(function()
    while task.wait() do
        local success, err = pcall(function()

            local StartValue = string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text, "Starts in (%d+) sec")
            local StartText = string.match(workspace.Podium.entrance.billboard.billboard.labelText.Text, ">(.-)<")

            if StartText then
                if Options.OpenQueue.Value then
                    if StartValue then
                        StartValue = tonumber(StartValue)
                        if StartValue <= 5 then
                            Queue = true
                        else
                            Queue = false
                        end
                    else
                        Queue = false
                    end
                else
                    if string.find(StartText, "Competition") then 
                        if StartValue then
                            StartValue = tonumber(StartValue)
                            if StartValue <= 5 then
                                Queue = true
                            else
                                Queue = false
                            end
                        else
                            Queue = false
                        end
                    end
                end
            end
        
            for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Minigames.Minigames:GetChildren()) do
                if v.ClassName == "Frame" then
                    if v.Visible then
                        PlayComp = tostring(v.Name)
                    else
                        PlayComp = ""
                    end
                end
            end

            if Options.AutoTrain.Value then
                if game:GetService("Players").LocalPlayer:GetAttribute("equipment") and (game:GetService("Players").LocalPlayer:GetAttribute("equipment") ~= nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment") ~= "") then
                    game:GetService("Players").LocalPlayer:SetAttribute("autoTrainEnabled", true)
                end
            end

            if Options.AutoGear.Value then
                game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("RouletteService"):WaitForChild("RF"):WaitForChild("Roll"):InvokeServer("Basic Crate",false)
                task.wait(1)
            end

            if Options.AutoUse.Value then
                for _, tool in ipairs(game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):GetChildren()) do
                    if tool:IsA("Tool") then
                        humanoid:EquipTool(tool)
                        task.wait(0.2)
                        activateTool(tool)
                    end
                end
                
                for _, tool in ipairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                    if tool:IsA("Tool") then
                        activateTool(tool)
                    end
                end
            end

            if Options.AutoFarmRandom.Value then
                randomplay()
                if game:GetService("Players").LocalPlayer:GetAttribute("equipment") and (game:GetService("Players").LocalPlayer:GetAttribute("equipment") ~= nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment") ~= "") then
                    game:GetService("Players").LocalPlayer:SetAttribute("autoTrainEnabled", true)
                end
            end

            if Options.AutoFarmStamina.Value then
                for i,v in pairs(workspace.Equipments:GetChildren()) do
                    if game:GetService("Players").LocalPlayer:GetAttribute("equipment") and (game:GetService("Players").LocalPlayer:GetAttribute("equipment") ~= nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment") ~= "") then
                        game:GetService("Players").LocalPlayer:SetAttribute("autoTrainEnabled", true)
                    end
                    if tostring(v.Name) == "treadmill" and not v:GetAttribute("occupied") then
                        task.wait()
                        if not game:GetService("Players").LocalPlayer:GetAttribute("equipment") or game:GetService("Players").LocalPlayer:GetAttribute("equipment") == "" or game:GetService("Players").LocalPlayer:GetAttribute("equipment") == nil then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.root.CFrame
                            task.wait()
                            interactWithPrompt(v.root:FindFirstChild("ProximityPrompt"))
                        end
                        task.wait(1)
                    end
                end
            end

        end)

        if not success then
            warn("Error occurred: " .. tostring(err))
        end

    end
end)

task.spawn(function()
    while task.wait() do
        local success, err = pcall(function()
            if Options.AutoFarm.Value then

                checkplay()

                if game:GetService("Players").LocalPlayer:GetAttribute("equipment") and game:GetService("Players").LocalPlayer:GetAttribute("equipment") ~= "" then
                    game:GetService("Players").LocalPlayer:SetAttribute("autoTrainEnabled", true)
                end

                if game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Buy.Visible then
                    game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("CharacterService"):WaitForChild("RF"):WaitForChild("NextAlter"):InvokeServer()
                end

                if game:GetService("Players").LocalPlayer.PlayerGui.Frames.Stats.Main.MuscleList.FullBody.Locked.Visible then
                    game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("WorldService"):WaitForChild("RF"):WaitForChild("unlock"):InvokeServer()
                end

                for i,v in pairs(workspace:GetChildren()) do
                    if v.ClassName == "Model" and v:FindFirstChild("GetQuest") then
                        if v.Name == "P3NT" then
                            game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("giveStoryQuest"):InvokeServer("P_3NT")
                            task.wait(.1)
                            game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("complete"):InvokeServer("P_3NT")
                        else
                            game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("giveStoryQuest"):InvokeServer(tostring(v.Name))
                            task.wait(.1)
                            game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("QuestService"):WaitForChild("RF"):WaitForChild("complete"):InvokeServer(tostring(v.Name))
                        end
                    end
                end

                if game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.Visible then
                    local ContinueButton = game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue
                    ContinueButton.Size = UDim2.new(0, 200, 0, 200)
                    ContinueButton.ZIndex = 999

                    local centercon = ContinueButton.AbsolutePosition + (ContinueButton.AbsoluteSize / 2)
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centercon.X, centercon.Y, 0, true, game, 1)
                    task.wait(.1)
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centercon.X, centercon.Y, 0, false, game, 1)
                end
                if game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.Visible then
                    local OkButton = game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok
                    OkButton.Size = UDim2.new(0, 200, 0, 200)
                    OkButton.ZIndex = 999

                    local centerok = OkButton.AbsolutePosition + (OkButton.AbsoluteSize / 2)
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerok.X, centerok.Y, 0, true, game, 1)
                    task.wait(.1)
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerok.X, centerok.Y, 0, false, game, 1)
                end

                for i2,v2 in pairs(workspace.Equipments:GetChildren()) do
                    if Queue then
                        repeat task.wait()
                            if not game:GetService("Players").LocalPlayer:GetAttribute("inPodiumQueue") then
                                canTp()
                            end
                        until game:GetService("Players").LocalPlayer:GetAttribute("inPodium") or PlayComp ~= "" or not Options.AutoFarm.Value
                    elseif game:GetService("Players").LocalPlayer:GetAttribute("inPodium") or PlayComp ~= "" then

                    elseif workspace:FindFirstChild("npcSpawns") and #workspace:FindFirstChild("npcSpawns"):GetChildren() > 0 then
                        if game:GetService("Players").LocalPlayer:GetAttribute("equipment") and (game:GetService("Players").LocalPlayer:GetAttribute("equipment") ~= nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment") ~= "") then
                            game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()
                        end
                        for i,v in pairs(workspace.npcSpawns:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                                repeat task.wait()
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0,0,5)
                                    task.wait()
                                    game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("CombatService"):WaitForChild("RF"):WaitForChild("M1"):InvokeServer()
                                until not Options.AutoFarm.Value or Queue or not v:FindFirstChild("Humanoid") or v:FindFirstChild("Humanoid").Health <= 0
                            end
                        end
                    elseif AllPercent < 100 then
                        if tostring(v2.Name) == PlayType then
                            if v2:GetAttribute("occupied") and game:GetService("Players").LocalPlayer:GetAttribute("equipment") and string.find(game:GetService("Players").LocalPlayer:GetAttribute("equipment"),PlayType) then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v2.root.CFrame * CFrame.new(0,300,0)
                            elseif v2:GetAttribute("occupied") then
                                randomplay()
                            else
                                fullyplay(PlayType,v2,true)
                            end
                        end
                    elseif AllPercent >= 100 then
                        randomplay()
                    end
                end

            end

        end)

        if not success then
            warn("Error occurred: " .. tostring(err))
        end

    end
end)

task.spawn(function()
    while task.wait() do
        local success, err = pcall(function()
            if Options.AutoYeti.Value then

                if #workspace:FindFirstChild("npcSpawns"):GetChildren() > 0 then
                    for i,v in pairs(workspace.npcSpawns:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                            repeat task.wait()

                                if game:GetService("Players").LocalPlayer:GetAttribute("combat") then
                                    for _, x in ipairs(workspace.weaponSpawns:GetChildren()) do
                                        for _, v2 in ipairs(x:GetChildren()) do
                                            if v2:FindFirstChild("ProximityPrompt") then
                                                v2.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                                interactWithPrompt(v2:FindFirstChild("ProximityPrompt"))
                                            end
                                        end
                                    end
                                end

                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(0,0,5)
                                task.wait()
                                game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("CombatService"):WaitForChild("RF"):WaitForChild("M1"):InvokeServer()
                            
                            until not (v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart")) or not Options.AutoYeti.Value
                        end
                    end
                else
                    if Options.EnableHop.Value then
                        Teleport()
                    end
                end

            end
        end)
        if not success then
            warn("Error occurred: " .. tostring(err))
        end
    end
end)

task.spawn(function()
    while task.wait() do
        local success, err = pcall(function()
            if Options.AutoComp.Value then

                local StartValue = string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text, "Starts in (%d+) sec")
                local LoadValue = string.match(workspace.Podium.entrance.billboard.billboard.labelTimer.Text, "load in (%d+) seconds")
                local StartText = string.match(workspace.Podium.entrance.billboard.billboard.labelText.Text, ">(.-)<")

                if (StartText and StartValue) or (LoadValue and tonumber(LoadValue) <= 50) then
                    StartValue = tonumber(StartValue)
                    if StartValue <= 5 then

                        repeat task.wait()
                            if game:GetService("Players").LocalPlayer:GetAttribute("equipment") == nil or game:GetService("Players").LocalPlayer:GetAttribute("equipment") == "" then
                                game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("EquipmentService"):WaitForChild("RF"):WaitForChild("Leave"):InvokeServer()
                            end

                            if not game:GetService("Players").LocalPlayer:GetAttribute("inPodiumQueue") then
                                game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("MiniPodiumService"):WaitForChild("RF"):WaitForChild("Teleport"):InvokeServer()
                            end
                        until not game:GetService("Players").LocalPlayer:GetAttribute("inPodiumQueue") or not Options.AutoComp.Value

                    end
                
                    if game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.Visible then
                        local ContinueButton = game:GetService("Players").LocalPlayer.PlayerGui.Podium.RewardsFrame.CanvasGroup.Continue
                        ContinueButton.Size = UDim2.new(0, 200, 0, 200)
                        ContinueButton.ZIndex = 999
    
                        local centercon = ContinueButton.AbsolutePosition + (ContinueButton.AbsoluteSize / 2)
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(centercon.X, centercon.Y, 0, true, game, 1)
                        task.wait(.1)
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(centercon.X, centercon.Y, 0, false, game, 1)
                    end
                    if game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.Visible then
                        local OkButton = game:GetService("Players").LocalPlayer.PlayerGui.Podium.winners.ok
                        OkButton.Size = UDim2.new(0, 200, 0, 200)
                        OkButton.ZIndex = 999
    
                        local centerok = OkButton.AbsolutePosition + (OkButton.AbsoluteSize / 2)
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerok.X, centerok.Y, 0, true, game, 1)
                        task.wait(.1)
                        game:GetService("VirtualInputManager"):SendMouseButtonEvent(centerok.X, centerok.Y, 0, false, game, 1)
                    end
                
                elseif game:GetService("Players").LocalPlayer:GetAttribute("inPodium") or PlayComp ~= "" then

                else
                    if Options.EnableHop.Value then
                        Teleport()
                    end 
                end

            end
        end)
        if not success then
            warn("Error occurred: " .. tostring(err))
        end
    end
end)

local BuyTable = {}

for _, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Frames.GymStore.PowerUps.CanvasGroup.List:GetChildren()) do
    if v.ClassName == "Frame" then
        table.insert(BuyTable, tostring(v.Name))
    end
end

Tabs.Main:AddDropdown("BuyThing", {
    Title = "Select To Buy",
    Values = BuyTable,
    Multi = false,
    Default = nil,
})

Tabs.Main:AddToggle("AutoBuy", { Title = "Auto Buy", Default = false })

Tabs.Main:AddButton({Title = "Roll Post",Description = "",Callback = function()
    game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PoseService"):WaitForChild("RF"):WaitForChild("Buy"):InvokeServer()
    task.wait()
    game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PoseService"):WaitForChild("RF"):WaitForChild("Spin"):InvokeServer()
end})

local hasBoost = false
task.spawn(function()
    while task.wait() do
        local success, err = pcall(function()
            if Options.AutoBuy.Value then

                local buyThing = Options.BuyThing.Value:gsub(" ", "")
            
                for attributeName, attributeValue in pairs(game:GetService("Players").LocalPlayer:GetAttributes()) do
                    if string.find(attributeName, "Boost") and string.find(attributeName, buyThing) then
                        hasBoost = true
                        break
                    else
                        hasBoost = false
                    end
                end
            
                if not hasBoost then
                    print("Buying Boost:", Options.BuyThing.Value)
                    game:GetService("ReplicatedStorage"):WaitForChild("common"):WaitForChild("packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.5.1"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("PowerUpsService"):WaitForChild("RF"):WaitForChild("Buy"):InvokeServer(tostring(Options.BuyThing.Value),1)
                end

                task.wait(1)
      
            end
        end)

        if not success then
            warn("Error occurred: " .. tostring(err))
        end

    end
end)

Tabs.Server:AddButton({Title = "Server Hop",Description = "",Callback = function()
    Teleport()
end})
Tabs.Server:AddButton({Title = "Rejoin",Description = "",Callback = function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end})

task.spawn(function()
	game:GetService("RunService").Stepped:Connect(function()
		pcall(function()
			if workspace:FindFirstChild("npcSpawns") and #workspace:FindFirstChild("npcSpawns"):GetChildren() > 0 and (Options.AutoFarm.Value or Options.AutoYeti.Value) then
				if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit then
					game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
				end
				if not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
					local BodyVelocity = Instance.new("BodyVelocity")
					BodyVelocity.Name = "BodyVelocity1"
					BodyVelocity.Parent =  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
					BodyVelocity.MaxForce = Vector3.new(10000,10000,10000)
					BodyVelocity.Velocity = Vector3.new(0, 0, 0)
				end
                for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA('BasePart') and v.CanCollide then
                        v.CanCollide = false
                    end
                end
			else
				if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
					game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1"):Destroy()
				end
                for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA('BasePart') and v.CanCollide then
                        v.CanCollide = true
                    end
                end
			end
		end)
	end)
end) 

game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

spawn(function()
    while true do wait()
        if setscriptable then
            setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
        end
        if sethiddenproperty then
            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
        end
    end
end)


SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("GymLeauge")
SaveManager:SetFolder("GymLeauge/JayJay")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

-- ตั้งค่าเริ่มต้น
Window:SelectTab(1)

SaveManager:LoadAutoloadConfig()
