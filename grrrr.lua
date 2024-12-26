getgenv().Level = 5

repeat task.wait() until game:IsLoaded()

local url = "https://discord.com/api/webhooks/1230899982165479455/Zx3pyf5_DuGB-FvftwuyTs1f4F16G9mby0hHEKbkUPFBwMIxV14mQp4Nwhvtzuj2LCQK"

local joinTime = tick()

-- ฟังก์ชันสำหรับคำนวณเวลาในเซิร์ฟเวอร์
local function getTimeInServer()
    local elapsedTime = tick() - joinTime
    return math.floor(elapsedTime / 60), math.floor(elapsedTime % 60)
end

-- ฟังก์ชันแปลงค่า
local function convertToNumber(value)
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

-- ฟังก์ชันส่งข้อมูล Discord Webhook
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
            local player = game:GetService("Players").LocalPlayer
            local replicatedStorage = game:GetService("ReplicatedStorage")
            local playerGui = player.PlayerGui

            -- ตรวจสอบสถานะ Lobby หรือ InGame
            local inLobby = game.PlaceId == 12886143095 or game.PlaceId == 18583778121

            if inLobby then
                local RerollAmount = tonumber(game:GetService("Players").LocalPlayer.Rerolls.Value)
                writefile(player.Name .. ".txt", tostring(RerollAmount))
                repeat
                    task.wait(.5)
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
                local GameMode = replicatedStorage.Gamemode.Value
                local MapName = workspace:WaitForChild("Map").MapName.Value
                local MapDifficulty = workspace:WaitForChild("Map").MapDifficulty.Value
                local WaveGame = replicatedStorage.Wave.Value

                repeat task.wait() until mainUI.Enabled

                -- วาง Tower ถ้าไม่มีอยู่ในเกม
                if not workspace.Towers:FindFirstChild(player.Slots.Slot1.Value) and (game:GetService("Players").LocalPlayer.Cash.Value >= convertToNumber(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.SlotsBG.Slots.Slot1.Cost.Text)) then
                    replicatedStorage.Remotes.PlaceTower:FireServer(tostring(player.Slots.Slot1.Value),CFrame.new(-168.2913818359375, 197.93942260742188, 16.62772560119629))
                    task.wait(1)
                end

                -- ตรวจสอบ EndGame
                local endGameUI = playerGui:FindFirstChild("EndGameUI")
                if endGameUI or replicatedStorage.GameEnded.Value then
                    local rerollData = tonumber(readfile(player.Name .. ".txt"))
                
                    -- เก็บข้อมูลทั้งหมดไว้ในข้อความเดียว
                    local rewardsText = ""
                    for _, reward in ipairs(endGameUI.BG.Container.Rewards.Holder:GetChildren()) do
                        if reward:IsA("TextButton") then
                            local amount = tonumber(reward.Amount.Text:match("%d+"))
                            rewardsText = "+ "..rewardsText .. reward.ItemName.Text .." ".. amount .." (Total: " .. (rerollData + amount) .. ")\n"
                        end
                    end
                
                    if rewardsText ~= "" then
                        local embed = {
                            title = "Reroll Farm",
                            color = 65280,
                            fields = {{
                                name = "||" .. player.Name .. "||",
                                value = rewardsText
                            }},
                            footer = {text = endGameUI.BG.Container.Stats.ElapsedTime.Text.." -  Wave "..tostring(WaveGame).." \n"..tostring(GameMode).." "..tostring(MapName).." ["..tostring(MapDifficulty).."]"}
                        }
                        SendMessageEMBED(url, embed)
                        task.wait(.5)
                        game:GetService("TeleportService"):Teleport(12886143095, player)
                        task.wait(3)
                        return
                    end
                
                end         
            end
        end)

        if not success then
            warn("Error occurred: " .. tostring(err))
        end
    end
end)

-- Auto Reconnect
repeat task.wait() until game.CoreGui:FindFirstChild("RobloxPromptGui")
game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == "ErrorPrompt" then
        repeat
            game:GetService("TeleportService"):Teleport(12886143095)
            task.wait(2)
        until false
    end
end)
