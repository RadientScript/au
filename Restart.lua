repeat task.wait() until game:IsLoaded() and game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI") and game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("MainUI").Enabled

if not getgenv().Main then
	getgenv().Main = {
		["Mode"] = "Restart", --"Restart","Leave"
		["Attempts"] = 4,
		["WebhookURL"] = "",
        ["AutoRejoin"] = true
	}
end

local h=game:GetService("HttpService") local r=http_request or syn.request function s(u,m)r({Url=u,Method="POST",Headers={["Content-Type"]="application/json"},Body=h:JSONEncode({content=m})})end

local function GameEnded()
    return game.Players.LocalPlayer.PlayerGui:FindFirstChild("EndGameUI") ~= nil
end

print("Waiting for ".. getgenv().Main["Attempts"] .." matches...");s(getgenv().Main["WebhookURL"], "Join Wait ".. getgenv().Main["Attempts"] .." match.")
game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Start Count "..getgenv().Main["Mode"],Text = "Working!!",Duration = 9e9})

local Count_Match = 0
local Previous_Match = false
task.spawn(function()
    while task.wait(1) do
        local Current_Match = GameEnded()

        if Count_Match < getgenv().Main["Attempts"] then
            if Current_Match and not Previous_Match then
                Count_Match += 1
                print("Match "..Count_Match);s(getgenv().Main["WebhookURL"], Count_Match .. " matches played.");game:GetService("StarterGui"):SetCore("SendNotification", {Title = getgenv().Main["Mode"].." Working!!",Text = tostring(Count_Match).." matches",Duration = 9e9})
            end

            Previous_Match = Current_Match
            
            --print("\nCurrent "..tostring(Current_Match).."\nPrevious "..tostring(Previous_Match).."\nCount "..tostring(Count_Match))
        else
            if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("EndGameUI") then
                if getgenv().Main["Mode"] == "Restart" then
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RestartMatch"):FireServer()
                    print("restart!");s(getgenv().Main["WebhookURL"], "restart.")
                    break
                elseif getgenv().Main["Mode"] == "Leave" then
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TeleportBack"):FireServer()
                    print("leave!");s(getgenv().Main["WebhookURL"], "leave.")
                    break
                end
            end
        end

    end
end)

game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if getgenv().Main["AutoRejoin"] and child.Name == "ErrorPrompt" then
        task.spawn(function()
            while task.wait(5) do
                local success, err = pcall(function()
                    game:GetService("TeleportService"):Teleport(12886143095)
                end)
                if success then break end
            end
        end)
    end
end)
