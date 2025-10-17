local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local ActiveQuests = LocalPlayer.ActiveQuests

local function Rejoin()
    print("Money value stagnant for 5 seconds. Rejoining server...")
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end

local function getMoneyValue()
    local moneyValueObject = LocalPlayer.PlayerGui.ScreenGui.Money.MoneyValue -- <--- Check this path
    
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
    local activeQuestName = ActiveQuests:FindFirstChildOfClass("StringValue")
    if activeQuestName then
        local questName = activeQuestName.Name
        ReplicatedStorage.Quests.Contracts.CancelContract:InvokeServer(questName)
        ReplicatedStorage.Quests.Contracts.CancelContract:InvokeServer(questName)
    end
end)

-- Main farming loop
while task.wait() do
    if not ActiveQuests:FindFirstChild("contractBuildMaterial") then
        ReplicatedStorage.Quests.Contracts.StartContract:InvokeServer("contractBuildMaterial")
        
        repeat task.wait() until ActiveQuests:FindFirstChild("contractBuildMaterial")
    end

    repeat task.wait()
        task.spawn(function()
            ReplicatedStorage.Quests.DeliveryComplete:InvokeServer("contractMaterial")
            ReplicatedStorage.Quests.DeliveryComplete:InvokeServer("contractMaterial")
            ReplicatedStorage.Quests.DeliveryComplete:InvokeServer("contractMaterial")
        end)
    until ActiveQuests.contractBuildMaterial.Value == "!pw5pi3ps2" -- Wait until the contract status is complete

    ReplicatedStorage.Quests.Contracts.CompleteContract:InvokeServer()
end
