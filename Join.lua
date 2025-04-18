local inLobby = game.PlaceId == 12886143095 or game.PlaceId == 18583778121
local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait();local humanoid = character:FindFirstChildOfClass("Humanoid");local rootPart = character:WaitForChild("HumanoidRootPart")
local targetName = "bohqlw"

repeat
    foundPlayer = game:GetService("Players"):FindFirstChild(targetName) 
    if inLobby then
        writefile(tostring(game.Players.LocalPlayer.UserId).."JobId.txt",game.JobId)
        local MainJobId = readfile("5654706557JobId.txt")
        if MainJobId ~= game.JobId then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, MainJobId)
        end
    end
    task.wait(1) 
until foundPlayer

repeat task.wait()
    if game.Players.LocalPlayer.UserId == 5654706557 then
        for i,v in pairs(workspace.TeleporterFolder.Story:GetChildren()) do
            if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TeleportUI") and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TeleportUI").Enabled then
                if v:GetAttribute("Leader") == game.Players.LocalPlayer.UserId and v:GetAttribute("PlayerCount") >= 2 then
                    game:GetService("GuiService").SelectedObject = game:GetService("Players").LocalPlayer.PlayerGui.TeleportUI.Skip
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                    task.wait(1)
                end
            elseif game:GetService("Players").LocalPlayer.PlayerGui.Story.Enabled then
                    local args = {
                    [1] = "Thriller Bark",
                    [2] = "Infinite",
                    [3] = "Nightmare",
                    [4] = true --friend
                }

                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Story"):WaitForChild("Select"):InvokeServer(unpack(args))
            elseif v:FindFirstChild("Door") and not v:GetAttribute("Leader") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Door.CFrame;humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    elseif game.Players.LocalPlayer.UserId == 3963988619 then
        for i,v in pairs(workspace.TeleporterFolder.Story:GetChildren()) do
            if v:GetAttribute("Leader") == 5654706557 and v:GetAttribute("Map") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Door.CFrame;humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
until not inLobby
