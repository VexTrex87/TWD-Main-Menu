local characters = game.ReplicatedStorage.Characters
local camera = require(script.Parent.Parent.Controllers:WaitForChild("Camera"))
local p = game.Players.LocalPlayer
local UI = p.PlayerGui:WaitForChild("MainMenu")
local mainMenuUI = UI:WaitForChild("MainMenu")
local characterUI = UI:WaitForChild("Character")

return function(button)
    if button.Name == "Back" then
        characterUI.Visible, mainMenuUI.Visible = false, true
    elseif button.Parent == characterUI.BottomBar then
        -- set selected char temp var to button name
        if button.Name ~= camera.currentChar then
            camera.newChar(characters[button.Name])
        end
    end
end