local music = game.ReplicatedStorage.Music.MainMenu
local p = game.Players.LocalPlayer
local camera = require(script.Parent.Parent:WaitForChild("Camera"))

local UI = p.PlayerGui:WaitForChild("MainMenu")
local mainMenuUI = UI:WaitForChild("MainMenu")
local characterUI = UI:WaitForChild("Character")
local settingsUI = UI:WaitForChild("Settings")
local creditsUI = UI:WaitForChild("Credits")

return function(button)
    if button.Name == "Spawn" then
        -- delete music, UI, & script
        camera.removeCamera()
        music.MainMenu:Pause()
        UI:Destroy()
        script:Destroy()
    elseif button.Name == "Character" then
        mainMenuUI.Visible, characterUI.Visible = false, true
    elseif button.Name == "Credits" then
        mainMenuUI.Visible, creditsUI.Visible = false, true
    elseif button.Name == "Settings" then
        mainMenuUI.Visible, settingsUI.Visible = false, true
    end
end