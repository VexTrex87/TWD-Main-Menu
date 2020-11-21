local remotes = game.ReplicatedStorage.Remotes.MainMenu
local p = game.Players.LocalPlayer
local UI = p.PlayerGui:WaitForChild("MainMenu")
local mainMenuUI = UI:WaitForChild("MainMenu")
local characterUI = UI:WaitForChild("Character")

local selectedChar

return function(button)
    if button.Name == "Back" then
        characterUI.Visible, mainMenuUI.Visible = false, true
    elseif button.Parent == characterUI.BottomBar then
        -- set selected char temp var to button name
        if button.Name ~= selectedChar then
            selectedChar = button.Name
            remotes.ChooseCharacter:FireServer(selectedChar)
        end
    end
end