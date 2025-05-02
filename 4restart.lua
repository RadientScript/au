repeat task.wait() until game:IsLoaded()
repeat task.wait() until game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("MainUI") and game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("MainUI").Enabled

local matchCounter = 0
local previousState = false

local function GameEnded()
    return game.Players.LocalPlayer.PlayerGui:FindFirstChild("EndGameUI") ~= nil
end

print("Waiting for 4 matches...")
game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Start Count Restart",Text = "Restart Working!!",Duration = 9e9})
while matchCounter < 4 do
    local currentState = GameEnded()

    if currentState and not previousState then
        matchCounter = matchCounter + 1
        print("Game ended! Count :", matchCounter);game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Restart Working!!",Text = tostring(matchCounter).." matches",Duration = 9e9})
    end

    previousState = currentState

    task.wait(1)
end

while task.wait(1) do
    if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("EndGameUI") then
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RestartMatch"):FireServer()
        print("restart")
    end
end
