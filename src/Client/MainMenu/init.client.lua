-- wait for game to load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- // VARIABLES \\ --

local core = require(game.ReplicatedStorage.Core)
local loadModules = core("loadModules")
local uiControllers = loadModules(script.UIControllers:GetChildren())
local camera = require(script.Controllers:WaitForChild("Camera"))

local characters = game.ReplicatedStorage.Characters
local music = game.ReplicatedStorage.Music.MainMenu
local p = game.Players.LocalPlayer

local UI = p.PlayerGui:WaitForChild("MainMenu")
local mainMenuUI = UI:WaitForChild("MainMenu")
local characterUI = UI:WaitForChild("Character")
local settingsUI = UI:WaitForChild("Settings")
local creditsUI = UI:WaitForChild("Credits")

-- // FUNCTIONS \\ --

local function onButtonClicked(button)
    music.Click:Play()

    -- finds the correct module to run according to the button
    for _,v in pairs({mainMenuUI, characterUI, settingsUI, creditsUI}) do
        if button:IsDescendantOf(v) then
            uiControllers[v.Name](button)
            break
        end
    end
end

local function createCharButtons()
    -- creates the buttons for each character
    local temp = characterUI.BottomBar.UIGridLayout.Template
    for _,char in pairs(characters:GetChildren()) do
        local button = temp:Clone()
        button.Name, button.TextLabel.Text = char.Name, char.Name
        button.Parent = characterUI.BottomBar
    end
end

local function initClickEvents()
    -- event listener for button clicked
    for _,v in pairs(UI:GetDescendants()) do
        if v:IsA("ImageButton") then
            v.MouseButton1Click:Connect(function()
                onButtonClicked(v)
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

camera.startCamera()
initUIDefaults()
createCharButtons()
initClickEvents()