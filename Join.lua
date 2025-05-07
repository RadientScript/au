repeat task.wait() until game:IsLoaded() and game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI") and game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("MainUI").Enabled

if not getgenv().Main then
	getgenv().Main = {
		["Mode"] = "Restart", --"Restart","Leave"
		["Attempts"] = 4,
		["WebhookURL"] = ""
	}
end

local matchCounter = 0
local previousState = false
local h=game:GetService("HttpService") local r=http_request or syn.request function s(u,m)r({Url=u,Method="POST",Headers={["Content-Type"]="application/json"},Body=h:JSONEncode({content=m})})end

local function GameEnded()
    return game.Players.LocalPlayer.PlayerGui:FindFirstChild("EndGameUI") ~= nil
end

print("Waiting for ".. getgenv().Main["Attempts"] .." matches...");s(getgenv().Main["WebhookURL"], "Join Wait ".. getgenv().Main["Attempts"] .." match.")
game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Start Count Restart",Text = "Restart Working!!",Duration = 9e9})
while matchCounter < getgenv().Main["Attempts"] do
    local currentState = GameEnded()

    if currentState and not previousState then
        matchCounter = matchCounter + 1
        print("Game ended! Count :", matchCounter);s(getgenv().Main["WebhookURL"], matchCounter .. " matches played.");game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Restart Working!!",Text = tostring(matchCounter).." matches",Duration = 9e9})
    end

    previousState = currentState

	task.wait(1)
end

while task.wait(1) do
	if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("EndGameUI") then
        if getgenv().Main["Mode"] == "Restart" then
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RestartMatch"):FireServer()
            print("restart!");s(getgenv().Main["WebhookURL"], "restart. @everyone")
        elseif getgenv().Main["Mode"] == "Leave" then
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TeleportBack"):FireServer()
            print("leave!");s(getgenv().Main["WebhookURL"], "leave. @everyone")
        end
	end
end
