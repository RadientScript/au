getgenv().Level = 0

repeat task.wait() until game:IsLoaded()

local url = "https://discord.com/api/webhooks/1230899982165479455/Zx3pyf5_DuGB-FvftwuyTs1f4F16G9mby0hHEKbkUPFBwMIxV14mQp4Nwhvtzuj2LCQK"

local function GetLocalTime()
    local dateTime = DateTime.now():ToLocalTime()
    local timeString = string.format("%02d:%02d:%02d", dateTime.Hour, dateTime.Minute, dateTime.Second)
    return timeString
end

local inLobby = game.PlaceId == 12886143095 or game.PlaceId == 18583778121
local player = game:GetService("Players").LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local playerGui = player.PlayerGui

--save all item
local dataitem = {}

local startTime = tick()

local function getSessionTime()
    local elapsedTime = tick() - startTime
    local hours = math.floor(elapsedTime / 3600)
    local minutes = math.floor((elapsedTime % 3600) / 60)
    local seconds = math.floor(elapsedTime % 60)
    return string.format("%02d:%02d:%02d", hours, minutes, seconds)
end

task.spawn(function()
    while task.wait(1) do

        local elapsedTime = tick() - startTime

        if elapsedTime >= 120 and inLobby then
            game:Shutdown() 
            break
        end

    end
end)

local function convertToNumber(value)
    value = value:gsub(",", "")
    
    local number, suffix = value:match("([%d%.]+)([kKmMbB]?)")
    number = tonumber(number)
    
    if suffix:lower() == "k" then
        return number * 1000
    elseif suffix:lower() == "m" then
        return number * 1000000
    elseif suffix:lower() == "b" then
        return number * 1000000000
    end
    
    return number
end

local function AddComma(value)
    local formatted = tostring(value):reverse():gsub("(%d%d%d)", "%1,"):reverse()
    if formatted:sub(1, 1) == "," then
        formatted = formatted:sub(2)
    end
    return formatted
end

local function SendMessageEMBED(url, embed)
    local http = game:GetService("HttpService")
    request({
        Url = url,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = http:JSONEncode({embeds = {embed}})
    })
end

task.spawn(function()
    while task.wait() do
        local success, err = pcall(function()

            local HttpService = game:GetService("HttpService")
            local currentTime = GetLocalTime()

            if inLobby then
                repeat
                    for _ = 1, 2 do
                        replicatedStorage.Remotes.InfiniteCastleManager:FireServer("GetData")
                        task.wait(.5)
                        replicatedStorage.Remotes.InfiniteCastleManager:FireServer("GetGlobalData")
                    end

                    replicatedStorage.Remotes.InfiniteCastleManager:FireServer("Play", Level, true)
                    task.wait(.5)
                until not inLobby
            else
                local mainUI = playerGui:WaitForChild("MainUI")

                repeat task.wait() until mainUI.Enabled

                local UnitTable = {}

                for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Bottom.Frame:GetChildren()) do
                    if v.Name == "Frame" then
                        for i2,v2 in pairs(v:GetChildren()) do
                            if v2.ClassName == "TextButton" and v2:FindFirstChild("Frame") and v2.Frame.Cost.Text ~= "empty" then
                                for slotName, slotData in pairs(game:GetService("ReplicatedStorage").Remotes.GetPlayerData:InvokeServer().Slots) do
                                    if slotData.Value and slotData.Value ~= "" then
                                        table.insert(UnitTable, {SlotNum = slotName,SlotValue = slotData.Value, Cost = convertToNumber(v2.Frame.Cost.Text)})
                                    end
                                end
                            end
                        end
                    end
                end
     
                table.sort(UnitTable, function(a, b)
                    return a.Cost < b.Cost
                end)
          
                local positionX, positionZ = -159.369140625, 7.469295501708984
                repeat task.wait()
                    local AllPlace = false
                    for _, data in ipairs(UnitTable) do
                        
                        local positionplace = CFrame.new(positionX, 197.93942260742188, positionZ)
                            
                        if not workspace.Towers:FindFirstChild(tostring(data.SlotValue)) and tonumber(game:GetService("Players").LocalPlayer.Cash.Value) >= tonumber(data.Cost) then
                            
                            repeat task.wait()
                                replicatedStorage.Remotes.PlaceTower:FireServer(tostring(data.SlotValue), positionplace)
                                print("Placed Unit :", data.SlotValue, "at", positionplace)
                                task.wait(1)
                            until workspace.Towers:FindFirstChild(tostring(data.SlotValue))

                            positionX = positionX - 4

                        end

                    end
                until playerGui:FindFirstChild("EndGameUI")

                repeat task.wait() until playerGui:FindFirstChild("EndGameUI")

                local endGameUI = playerGui:FindFirstChild("EndGameUI")
                
                if endGameUI or replicatedStorage.GameEnded.Value then
                    local MapData = game:GetService("ReplicatedStorage").Remotes.GetTeleportData:InvokeServer()
                    local RoomAct = ""

                    local PlayerData = game:GetService("ReplicatedStorage").Remotes.GetPlayerData:InvokeServer()
                    local InventoryData = PlayerData.ItemData
                    local ItemName,ItemAmount = nil

                    local level = AddComma(tonumber(HttpService:JSONEncode(PlayerData.Level)))
                    local xp = AddComma(tonumber(HttpService:JSONEncode(PlayerData.EXP)))
                    local maxXP = AddComma(tonumber(HttpService:JSONEncode(PlayerData.MaxEXP)))

                    local rerollData = tonumber(HttpService:JSONEncode(PlayerData.Rerolls))

                    local JewelData = AddComma(tonumber(HttpService:JSONEncode(PlayerData.Jewels)))
                    local EmeraldsData = AddComma(tonumber(HttpService:JSONEncode(PlayerData.Emeralds)))
                    local GoldDataShow = AddComma(tonumber(HttpService:JSONEncode(PlayerData.Gold)))
                    local RerollDataShow = AddComma(tonumber(HttpService:JSONEncode(PlayerData.Rerolls)))

                    local ShowItemAmount = ""
                    local rewardsText = ""
                    local TotalItem = ""
                    local AllTextSend = ""
                    for _, reward in ipairs(endGameUI.BG.Container.Rewards.Holder:GetChildren()) do
                        if reward:IsA("TextButton") then
                            local amount = tonumber(reward.Amount.Text:match("%d+")) or 0

                            for _, item in pairs(InventoryData) do
                                if string.lower(reward.ItemName.Text) == string.lower(item.ItemName) then
                                    ShowItemAmount = ShowItemAmount.."+"..amount.." " .. reward.ItemName.Text .. " [Total: " .. tonumber(item.Amount) .. "]\n"
                                end
                            end

                            if reward.ItemName.Text == "Technique Shard" then
                                rewardsText = rewardsText .. "+".. amount.. " " .. reward.ItemName.Text:gsub("Technique Shard", "Rerolls") .." [ Total: " ..RerollDataShow .." ]\n"
                            end

                            if rewardsText == "" then
                                AllTextSend = ShowItemAmount
                            else
                                AllTextSend = rewardsText..ShowItemAmount
                            end

                        end
                    end
                    local UnitText = ""
                    for slotName, slotData in pairs(PlayerData.Slots) do
                        local kills = slotData.Kills or 0
                        local level = slotData.Level or 1
                        local value = slotData.Value or ""
                        local cash = slotData.Cash or 0
                
                        if value ~= "" then
                            UnitText = UnitText .. string.format( "[ %d ] %s = %s :crossed_swords:\n", level, value, AddComma(tonumber(kills)) )
                        end                
                    end

                    if MapData.Room ~= nil then
                        RoomAct = " Room "..HttpService:JSONEncode(MapData.Room)
                    elseif MapData.MapNum ~= nil then
                        RoomAct = " Act "..HttpService:JSONEncode(MapData.MapNum)
                    elseif MapData.Element ~= nil then
                        RoomAct = " Element "..HttpService:JSONEncode(MapData.Element)
                    else
                        RoomAct = ""
                    end
                    
                    ColorWL = 00000
                    WinLoss = ""
                    if game:GetService("Players").LocalPlayer.PlayerGui.EndGameUI.BG.Container.Stats.Result.TextColor3 == Color3.new(153/255, 255/255, 75/255) then
                        ColorWL = 65280
                        WinLoss = "VICTORY"
                    else
                        ColorWL = 16711680
                        WinLoss = "DEFEAT"
                    end
                    
                    local embed = {
                        title = "Reroll Farm",
                        color = tonumber(ColorWL),
                        fields = {
                            { 
                                name = "", 
                                value = "**User : **".."||" .. player.Name .. "||".."\n".."**Level: **".. level.." ["..xp.."/"..maxXP.."]"
                            },
                            { 
                                name = "Player Stats",
                                value = "<:emerald:1204766658397343805> "..EmeraldsData.."\n<:als_jewels:1265957290251522089> "..JewelData.."\n<:coinals:1322519939525120072> "..GoldDataShow.."\n<:rerolls:1216376860804382860> "..RerollDataShow,
                                inline = true
                            },
                            { 
                                name = "", 
                                value = "",
                                inline = true 
                            },
                            { 
                                name = "Reward",
                                value = AllTextSend,
                                inline = true
                            },
                            { 
                                name = "Units", 
                                value = UnitText, 
                            },
                            { 
                                name = "Match Result", 
                                value = getSessionTime().." -  Wave "..tostring(tonumber(game:GetService("ReplicatedStorage").Wave.Value)).." \n"..HttpService:JSONEncode(MapData.Type):gsub('"',"").." "..HttpService:JSONEncode(MapData.MapName):gsub('"',"")..RoomAct.." ["..HttpService:JSONEncode(MapData.Difficulty):gsub('"',"").."] ".." - "..WinLoss, 
                            }
                        },
                        thumbnail = {
                            url = "https://cdn.discordapp.com/attachments/1287980533162315808/1321789124470116383/latest.png?ex=676e838c&is=676d320c&hm=be9b5f0f61f2165f1e9fe8d656d445afe0892c430666d2555fb3bd43e73b7692&"
                        },
                        footer = {text = "Local Time".." : ".. currentTime}
                    }
                    SendMessageEMBED(url, embed)
                    task.wait(.5)
                    repeat game:GetService("TeleportService"):Teleport(12886143095, player) task.wait(.1) until inLobby
                
                end         
            end
        end)

        if not success then
            warn("Error occurred: " .. tostring(err))
        end
    end
end)

repeat task.wait() until game.CoreGui:FindFirstChild("RobloxPromptGui")
local ErrorCode = ""
game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == "ErrorPrompt" then
        task.wait(.5)

        local errorPrompt = game.CoreGui.RobloxPromptGui.promptOverlay:WaitForChild("ErrorPrompt").MessageArea.ErrorFrame
        for _, v in ipairs(errorPrompt:GetChildren()) do
            if v.ClassName == "TextLabel" then
                ErrorCode = v.Text
            end
        end

        if errorPrompt then
            local embed = {
                title = "Disconnect From Server",
                color = 00000,
                fields = {{
                    name = "||" .. player.Name .. "||",
                    value = ErrorCode
                }},
                footer = {text = "Rejoining"}
            }
            SendMessageEMBED(url, embed)
        else
            print("ErrorPrompt not found.")
        end

        repeat game:GetService("TeleportService"):Teleport(12886143095, player) task.wait(2) until false

    end
end)
