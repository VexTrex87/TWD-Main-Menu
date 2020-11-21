local p = game.Players.LocalPlayer
local Settings = require(script.Parent.Parent.Settings)
local UI = p.PlayerGui:WaitForChild("MainMenu")
local mainMenuUI = UI:WaitForChild("MainMenu")
local settingsUI = UI:WaitForChild("Settings")

return function(button)
    if button.Name == "Back" then
        settingsUI.Visible, mainMenuUI.Visible = false, true
    else
        button.IsActive.Value = not button.IsActive.Value
        button.Switch:TweenPosition(button.IsActive.Value and Settings.switch.enabledPos or Settings.switch.disabledPos, table.unpack(Settings.switch.tweenInfo))
        button.Switch.BackgroundColor3 = button.IsActive.Value and Settings.switch.enabledColor or Settings.switch.disabledColor

        -- disable core UI's
        pcall(function()
            if button.Parent.Name == "HideChat" then
                game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, not button.IsActive.Value)
            elseif button.Parent.Name == "HideBackpack" then
                game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, not button.IsActive.Value)
            elseif button.Parent.Name == "HideEmotes" then
                game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, not button.IsActive.Value)
            elseif button.Parent.Name == "HideLeaderboard" then
                game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, not button.IsActive.Value)
            elseif button.Parent.Name == "HideTopBar" then
                game.StarterGui:SetCore("TopbarEnabled", false)
            end
        end)
    end
end