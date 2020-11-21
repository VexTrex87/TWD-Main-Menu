local p = game.Players.LocalPlayer
local Settings = require(script.Parent.Settings)
local UI = p.PlayerGui:WaitForChild("MainMenu")
local mainMenuUI = UI:WaitForChild("MainMenu")
local settingsUI = UI:WaitForChild("Settings")

return function(button)
    if button.Name == "BackButton" then
        settingsUI.Visible, mainMenuUI.Visible = false, true
    else
        button.IsActive.Value = not button.IsActive.Value
        button.Switch.Round:TweenPosition(button.IsActive.Value and Settings.switchEnabledPos or Settings.switchDisabledPos, table.unpack(Settings.switchTweenInfo))
        button.Switch.Round.ImageColor3 = button.IsActive.Value and Settings.switchEnabledColor or Settings.switchDisabledColor

        -- disable core UI's
        pcall(function()
            if button.Parent.Name == "HideChat" then
                game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
            elseif button.Parent.Name == "HideBackpack" then
                game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
            elseif button.Parent.Name == "HideEmotes" then
                game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
            elseif button.Parent.Name == "HideLeaderboard" then
                game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
            elseif button.Parent.Name == "HideTopBar" then
                game.StarterGui:SetCore("TopbarEnabled", false)
            end
        end)
    end
end