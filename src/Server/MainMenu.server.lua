local EQUIP_CHAR_ON_RESPAWN_DELAY = 0.5
local remotes = game.ReplicatedStorage.Remotes.MainMenu
local charStorage = game.ServerStorage.Characters

local function cloneChar(oldChar, newChar)
    local oldHum = oldChar.Humanoid
    -- removes old accessories
    oldHum:RemoveAccessories()
    for _,v in pairs(newChar:GetChildren()) do
        if v:IsA("BasePart") then
            if v.Name == "Head" then
                -- set face texture
                oldChar.Head.face.Texture = v.face.Texture
            end
            -- set body part color
            oldChar[v.Name].Color = v.Color
        elseif v:IsA("Accessory") then
            -- equip accessory
            local newAccessory = v:Clone()
            oldHum:AddAccessory(newAccessory)
        elseif v:IsA("Shirt") then
            -- set shirt template
            oldChar.Shirt.ShirtTemplate = v.ShirtTemplate
        elseif v:IsA("Pants") then
            -- set pants template
            oldChar.Pants.PantsTemplate = v.PantsTemplate
        end
    end
end

local function onChooseCharacterInvoked(p, charName)
    -- sets player's character
    p.Stats.CurrentCharacter.Value = charName
    cloneChar(p.Character, charStorage[charName])
end

local function onGetCharactersInvoked()
    -- returns all chars in a dictionary
    local charInfo = {}
    for _,char in pairs(charStorage:GetChildren()) do
        charInfo[char.Name] = 0
    end
    return charInfo
end

game.Players.PlayerAdded:Connect(function(p)
    -- create stats folder
    local stats = Instance.new("Folder")
    stats.Name = "Stats"
    stats.Parent = p
    
    local currentChar = Instance.new("StringValue")
    currentChar.Name = "CurrentCharacter"
    currentChar.Parent = stats
    
    -- on respawn, equip existing character
    p.CharacterAdded:Connect(function(char)
        if currentChar.Value ~= "" then
            p.CharacterAppearanceLoaded:Wait()
            wait(EQUIP_CHAR_ON_RESPAWN_DELAY)
            cloneChar(char, charStorage[currentChar.Value])
        end
    end)
end)

remotes.ChooseCharacter.OnServerEvent:Connect(onChooseCharacterInvoked)
remotes.GetCharacters.OnServerInvoke = onGetCharactersInvoked