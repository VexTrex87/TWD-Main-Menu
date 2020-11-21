local p = game.Players.LocalPlayer
local UI = p.PlayerGui:WaitForChild("MainMenu")
local mainMenuUI = UI:WaitForChild("MainMenu")
local creditsUI = UI:WaitForChild("Credits")

return function()
    creditsUI.Visible, mainMenuUI.Visible = false, true
end