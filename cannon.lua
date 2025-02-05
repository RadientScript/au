repeat task.wait() until game:IsLoaded()

local function isTargetMessage(text)
    return text:find("The Colossal Titan is about to stun/destroy several units!")
end

game:GetService("Players").LocalPlayer.PlayerGui.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("TextLabel") and isTargetMessage(descendant.Text) then
        local function getCannons()
            local cannons = {}
            local cannonsFolder = workspace:FindFirstChild("Map")
                and workspace.Map:FindFirstChild("Map")
                and workspace.Map.Map:FindFirstChild("Cannons")
        
            for _, child in pairs(cannonsFolder:GetChildren()) do
                if child.Name == "Model" then
                    table.insert(cannons, child)
                end
            end
        
            return cannons
        end
        
        local function fireAllCannons()
            local cannons = getCannons()
        
            for _, cannon in ipairs(cannons) do
                if cannon.Parent then
                    game:GetService("ReplicatedStorage").Remotes.FireCannon:FireServer(cannon)
                end
        
                task.wait(.1)
            end
        end
        
        while task.wait() do
            fireAllCannons()
        end
    end
end)
