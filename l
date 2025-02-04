-- Function to set HoldDuration to 0 for a player's ProximityPrompt
local function setProximityPromptHoldDuration(character)
    local upperTorso = character:FindFirstChild("UpperTorso")
    
    -- Check if UpperTorso exists
    if upperTorso then
        local proximityPrompt = upperTorso:FindFirstChild("ProximityPrompt")
        
        -- Check if ProximityPrompt exists
        if proximityPrompt then
            -- Set HoldDuration to 0
            proximityPrompt.HoldDuration = 0
            print("HoldDuration set to 0 for ProximityPrompt in UpperTorso of " .. character.Name)
        else
            warn("ProximityPrompt not found in UpperTorso of " .. character.Name)
        end
    else
        warn("UpperTorso not found for character " .. character.Name)
    end
end

-- Function to handle a player's character being added
local function onCharacterAdded(character)
    -- Wait for UpperTorso to be added
    character:WaitForChild("UpperTorso")
    -- Set HoldDuration for the player's ProximityPrompt
    setProximityPromptHoldDuration(character)
end

-- Iterate through all players in the game and set HoldDuration for their ProximityPrompts
for _, player in ipairs(game.Players:GetPlayers()) do
    if player.Character then
        onCharacterAdded(player.Character)
    end
    
    -- Connect to the CharacterAdded event for future respawns
    player.CharacterAdded:Connect(onCharacterAdded)
end

-- Connect to PlayerAdded event to handle new players joining
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(onCharacterAdded)
end)
