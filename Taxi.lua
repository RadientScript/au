repeat task.wait() until game:IsLoaded() and game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") and game:GetService("Players").LocalPlayer:FindFirstChild("ActiveQuests")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function Rejoin()
    print("Money value stagnant for 5 seconds. Rejoining server...")
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end

local function getMoneyValue()
    local moneyValueObject = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.Money.MoneyValue
    
    if moneyValueObject and moneyValueObject.Value then
        return tonumber(moneyValueObject.Value)
    else
        warn("Could not find the money value object at the specified path.")
        return nil
    end
end

--------------------------------
-- 1. Money Check and Rejoin Loop
--------------------------------
task.spawn(function()
    local lastMoneyValue = getMoneyValue()
    local timeValueStagnant = 0
    local requiredTimeStagnant = 5
    local checkInterval = 0.5

    while task.wait(checkInterval) do
        local currentMoneyValue = getMoneyValue()
        
        if currentMoneyValue and lastMoneyValue then
            if currentMoneyValue == lastMoneyValue then
                timeValueStagnant = timeValueStagnant + checkInterval
                
                if timeValueStagnant >= requiredTimeStagnant then
                    Rejoin()
                    break 
                end
            else
                lastMoneyValue = currentMoneyValue
                timeValueStagnant = 0
            end
        elseif currentMoneyValue then
            lastMoneyValue = currentMoneyValue
            timeValueStagnant = 0
        end
    end
end)

--------------------------------
-- 2. Contract Farm Loop (Your original script)
--------------------------------

pcall(function()
    local activeQuestName = game:GetService("Players").LocalPlayer.ActiveQuests:FindFirstChildOfClass("StringValue")
    if activeQuestName then
        local questName = activeQuestName.Name
        ReplicatedStorage.Quests.Contracts.CancelContract:InvokeServer(questName)
        ReplicatedStorage.Quests.Contracts.CancelContract:InvokeServer(questName)
    end
end)

-- Main farming loop
while task.wait() do
    if not game:GetService("Players").LocalPlayer.ActiveQuests:FindFirstChild("contractBuildMaterial") then
        ReplicatedStorage.Quests.Contracts.StartContract:InvokeServer("contractBuildMaterial")
        
        repeat task.wait() until game:GetService("Players").LocalPlayer.ActiveQuests:FindFirstChild("contractBuildMaterial")
    end

    repeat task.wait()
        task.spawn(function()
            ReplicatedStorage.Quests.DeliveryComplete:InvokeServer("contractMaterial")
            ReplicatedStorage.Quests.DeliveryComplete:InvokeServer("contractMaterial")
            ReplicatedStorage.Quests.DeliveryComplete:InvokeServer("contractMaterial")
        end)
    until game:GetService("Players").LocalPlayer.ActiveQuests.contractBuildMaterial.Value == "!pw5pi3ps2"

    ReplicatedStorage.Quests.Contracts.CompleteContract:InvokeServer()
end
