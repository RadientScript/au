repeat task.wait() until game:IsLoaded() and game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI") and game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("MainUI").Enabled

local url = "https://discord.com/api/webhooks/1230899982165479455/Zx3pyf5_DuGB-FvftwuyTs1f4F16G9mby0hHEKbkUPFBwMIxV14mQp4Nwhvtzuj2LCQK"
local matchCounter = 0
local afterMatch = 2
local previousState = false
local h=game:GetService("HttpService") local r=http_request or syn.request function s(u,m)r({Url=u,Method="POST",Headers={["Content-Type"]="application/json"},Body=h:JSONEncode({content=m})})end

local function GameEnded()
    return game.Players.LocalPlayer.PlayerGui:FindFirstChild("EndGameUI") ~= nil
end

print("Waiting for ".. afterMatch .." matches...");s(url, "Join Wait ".. afterMatch .." match.")
game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Start Count Restart",Text = "Restart Working!!",Duration = 9e9})
while matchCounter < afterMatch do
    local currentState = GameEnded()

    if currentState and not previousState then
        matchCounter = matchCounter + 1
        print("Game ended! Count :", matchCounter);s(url, matchCounter .. " matches played.");game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Restart Working!!",Text = tostring(matchCounter).." matches",Duration = 9e9})
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
