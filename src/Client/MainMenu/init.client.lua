-- wait for game to load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- // VARIABLES \\ --

local SWITCH_DISABLED_POS = UDim2.new(0.339, 0, 0.5, 0)
local SWITCH_DISABLED_COLOR = Color3.fromRGB(255, 0, 0)
local SWITCH_ENABLED_POS = UDim2.new(1.179, 0, 0.5, 0)
local SWITCH_ENABLED_COLOR = Color3.fromRGB(35, 255, 68)

local remotes = game.ReplicatedStorage.Remotes.MainMenu
local characters = remotes.GetCharacters:InvokeServer()
local camera = workspace.CurrentCamera
local music = game.ReplicatedStorage.Music.MainMenu
local p = game.Players.LocalPlayer

local UI = p.PlayerGui:WaitForChild("MainMenu")
local mainMenuUI = UI:WaitForChild("MainMenu")
local characterUI = UI:WaitForChild("Character")
local settingsUI = UI:WaitForChild("Settings")
local creditsUI = UI:WaitForChild("Credits")

local selectedChar

-- // FUNCTIONS \\ --

local function buttonClicked(button)
    music.Click:Play()
    if button:IsAncestorOf(creditsUI) then
            creditsUI.Visible, mainMenuUI.Visible = false, true
    elseif button:IsAncestorOf(settingsUI) then
        if button.Name == "BackButton" then
            settingsUI.Visible, mainMenuUI.Visible = false, true
        else
            button.Active.Value = not button.Active.Value
            button.Switch:TweenPosition(button.Active.Value and SWITCH_ENABLED_POS or SWITCH_DISABLED_POS)
            button.Switch.ImageColor3 = button.Active.Value and SWITCH_ENABLED_COLOR or SWITCH_DISABLED_COLOR

            -- disable core UI's
            pcall(function()
                if button.Name == "HideChat" then
                    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
                elseif button.Name == "HideBackpack" then
                    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
                elseif button.Name == "HideEmotes" then
                    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
                elseif button.Name == "HideLeaderboard" then
                    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
                elseif button.Name == "HideTopBar" then
                    game.StarterGui:SetCore("TopbarEnabled", false)
                end
            end)
        end
    elseif button:IsAncestorOf(characterUI) then
        if button.Name == "BackButton" then
            characterUI.Visible, mainMenuUI.Visible = false, true
        elseif button.Parent.Parent == characterUI.Frame then
            -- set selected char temp var to button name
            selectedChar = button.Name
        end
    elseif button:IsAncestorOf(mainMenuUI) then
        if button.Parent.Name == "Spawn" then
            -- set char on server
            local newChar = remotes.ChooseCharacter:InvokeServer(selectedChar)
            -- set camera to new char
            camera.CameraType = Enum.CameraType.Follow
            camera.CameraSubject = newChar.Humanoid
            -- delete music, UI, & script
            music.MainMenu:Pause()
            UI:Destroy()
            script:Destroy()
        elseif button.Parent.Name == "Character" then
            mainMenuUI.Visible, characterUI.Visible = false, true
        elseif button.Parent.Name == "Credits" then
            mainMenuUI.Visible, creditsUI.Visible = false, true
        elseif button.Parent.Name == "Settings" then
            mainMenuUI.Visible, settingsUI.Visible = false, true
        end
    end
end

local function createCharButtons()
    -- creates the buttons for each character
    local temp = characterUI.Frame.UIGridLayout.Template
    for name, cost in pairs(characters) do
        local button = temp:Clone()
        button.Name, button.TextLabel.Text = name, name
        button.Parent = characterUI.Frame
    end
end

local function initClickEvents()
    -- event listener for button clicked
    for _,v in pairs(UI:GetDescendants()) do
        if v:IsA("TextButton") then
            v.MouseButton1Click:Connect(function()
                print(v:GetFullName())
                buttonClicked(v)
            end)
        end
    end
end

local function initUIDefaults()
    music.MainMenu:Play()
    UI.Enabled = true
    mainMenuUI.Visible = true
    creditsUI.Visible, characterUI.Visible, settingsUI.Visible = nil
end

-- // COMPILE \\ --

initUIDefaults()
createCharButtons()
initClickEvents()