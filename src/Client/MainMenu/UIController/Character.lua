local remotes = game.ReplicatedStorage.Remotes.MainMenu
local p = game.Players.LocalPlayer
local UI = p.PlayerGui:WaitForChild("MainMenu")
local mainMenuUI = UI:WaitForChild("MainMenu")
local characterUI = UI:WaitForChild("Character")

local selectedChar

return function(button)
    if button.Name == "BackButton" then
        characterUI.Visible, mainMenuUI.Visible = false, true
    elseif button.Parent.Parent == characterUI.Frame then
        -- set selected char temp var to button name
        if button.Text ~= selectedChar then
            selectedChar = button.Text
            remotes.ChooseCharacter:FireServer(selectedChar)
        end
    end
end