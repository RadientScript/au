getgenv().Level = 5
getgenv().HardMode = true

repeat task.wait() until game:IsLoaded()

local url = "https://discord.com/api/webhooks/1230899982165479455/Zx3pyf5_DuGB-FvftwuyTs1f4F16G9mby0hHEKbkUPFBwMIxV14mQp4Nwhvtzuj2LCQK"

local joinTime = tick()

local function getTimeInServer()
    local currentTime = tick()
    local elapsedTime = currentTime - joinTime
    local minutes = math.floor(elapsedTime / 60)
    local seconds = math.floor(elapsedTime % 60)
    return minutes, seconds
end

local function convertToNumber(value)
    local number, suffix = value:match("([%d%.]+)([kKmMbB]?)")  
    number = tonumber(number)

    if not suffix or suffix == "" then
        return number
    end

    if suffix:lower() == "k" then
        number = number * 1000
    elseif suffix:lower() == "m" then
        number = number * 1000000
    elseif suffix:lower() == "b" then
        number = number * 1000000000
    end

    return number
end

function SendMessageEMBED(url, embed)
    local http = game:GetService("HttpService")
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local data = {
        ["embeds"] = {
            {
                ["title"] = embed.title,
                ["description"] = embed.description,
                ["color"] = embed.color,
                ["fields"] = embed.fields,
                ["footer"] = {
                    ["text"] = embed.footer.text
                }
            }
        }
    }
    local body = http:JSONEncode(data)
    local response = request({
        Url = url,
        Method = "POST",
        Headers = headers,
        Body = body
    })
end

local RerollAmount;

task.spawn(function()
    while task.wait() do
        pcall(function()

            if (game.PlaceId == 12886143095 or game.PlaceId == 18583778121) then
                Lobby = true
            else
                InGame = true
            end

            if Lobby then

                RerollAmount = tonumber(game:GetService("Players").LocalPlayer.Rerolls.Value)
                writefile(tostring(game:GetService("Players").LocalPlayer)..".json", RerollAmount)
                
                repeat task.wait(0.5)
                    for i = 1, 2 do
                        task.delay(0, function()
                            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InfiniteCastleManager"):FireServer("GetData")
                        end)
            
                        task.delay(0.5, function()
                            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InfiniteCastleManager"):FireServer("GetGlobalData")
                        end)
                    end
            
                    for i = 1, 2 do
                        task.delay(1, function()
                        local args = {
                            [1] = "Play",
                            [2] = Level,
                            [3] = HardMode
                        }
            
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InfiniteCastleManager"):FireServer(unpack(args))
                        end)
                    end
                until InGame == true
            else
                repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("MainUI").Enabled == true
                task.wait(3)
                if not workspace.Towers:FindFirstChild(tostring(game:GetService("Players").LocalPlayer.Slots.Slot1.Value)) then
                    local args = {
                        [1] = tostring(game:GetService("Players").LocalPlayer.Slots.Slot1.Value),
                        [2] = CFrame.new(-168.2913818359375, 197.93942260742188, 16.62772560119629) * CFrame.Angles(-0, 0, -0)
                    }
                    
                    game:GetService("ReplicatedStorage").Remotes.PlaceTower:FireServer(unpack(args))
                end

                if game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("EndGameUI") or game:GetService("ReplicatedStorage").GameEnded.Value == true then
                    local rerolldata = readfile(tostring(game:GetService("Players").LocalPlayer)..".json")
                    if game:GetService("Players").LocalPlayer.PlayerGui.EndGameUI.BG.Container.Stats.Result.Text ~= "Defeat" then
                        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.EndGameUI.BG.Container.Rewards.Holder:GetChildren()) do
                            if v.ClassName == "TextButton" then
                                local embed = {
                                    ["title"] = "Reroll Farm",
                                    ["color"] = 65280,
                                    ["fields"] = {
                                        {
                                            ["name"] = "||"..tostring(game:GetService("Players").LocalPlayer).."||",
                                            ["value"] = "+"..tostring(v.ItemName.Text).." "..tostring(v.Amount.Text:gsub("x", "")).." (".."Total : "..(rerolldata + v.Amount.Text:gsub("x", ""))..")".."\n"
                                        }
                                    },
                                    ["footer"] = {
                                        ["text"] = "Elapsed Time : "..tostring(game:GetService("Players").LocalPlayer.PlayerGui.EndGameUI.BG.Container.Stats.ElapsedTime.Text)
                                    }
                                }
                                SendMessageEMBED(url, embed)
                                task.wait(.5)
                                game:GetService("TeleportService"):Teleport(12886143095, game:GetService("Players").LocalPlayer)
                                task.wait(3)
                            end
                        end
                    else
                        local embed = {
                            ["title"] = "Reroll Farm",
                            ["color"] = 16711680,
                            ["fields"] = {
                                {
                                    ["name"] = "||"..tostring(game:GetService("Players").LocalPlayer).."||",
                                    ["value"] = "Defeat"
                                }
                            },
                            ["footer"] = {
                                ["text"] = "Elapsed Time : "..tostring(game:GetService("Players").LocalPlayer.PlayerGui.EndGameUI.BG.Container.Stats.ElapsedTime.Text)
                            }
                        }
                        SendMessageEMBED(url, embed)
                        task.wait(.5)
                        game:GetService("TeleportService"):Teleport(12886143095, game:GetService("Players").LocalPlayer)
                        task.wait(3)
                    end
                end

            end

        end)
    end
end)
