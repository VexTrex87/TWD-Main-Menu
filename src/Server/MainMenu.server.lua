local remotes = game.ReplicatedStorage.Remotes.MainMenu
local charStorage = game.ServerStorage.Characters

local function onChooseCharacterInvoked(p, charName)
    -- sets player's character
    local newChar = charStorage[charName]:Clone()
    newChar.Parent = workspace
    p.Character = newChar
    return newChar
end

local function onGetCharactersInvoked()
    -- returns all chars in a dictionary
    local charInfo = {}
    for _,char in pairs(charStorage:GetChildren()) do
        charInfo[char.Name] = 0
    end
    return charInfo
end

remotes.ChooseCharacter.OnServerInvoke = onChooseCharacterInvoked
remotes.GetCharacters.OnServerInvoke = onGetCharactersInvoked