repeat task.wait() until game:IsLoaded() and game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI") and game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("MainUI").Enabled

if not getgenv().Match then getgenv().Match = 4 end
if not getgenv().WebhookURL then getgenv().WebhookURL = "" end

local matchCounter = 0
local previousState = false
local h=game:GetService("HttpService") local r=http_request or syn.request function s(u,m)r({Url=u,Method="POST",Headers={["Content-Type"]="application/json"},Body=h:JSONEncode({content=m})})end

local function GameEnded()
    return game.Players.LocalPlayer.PlayerGui:FindFirstChild("EndGameUI") ~= nil
end

print("Waiting for ".. getgenv().Match .." matches...");s(getgenv().WebhookURL, "Join Wait ".. getgenv().Match .." match.")
game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Start Count Restart",Text = "Restart Working!!",Duration = 9e9})
while matchCounter < getgenv().Match do
    local currentState = GameEnded()

    if currentState and not previousState then
        matchCounter = matchCounter + 1
        print("Game ended! Count :", matchCounter);s(getgenv().WebhookURL, matchCounter .. " matches played.");game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Restart Working!!",Text = tostring(matchCounter).." matches",Duration = 9e9})
    end

    previousState = currentState

	task.wait(1)
end

while task.wait(1) do
	if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("EndGameUI") then
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RestartMatch"):FireServer()
		print("restart");s(url, "restart. @everyone")
	end
end
