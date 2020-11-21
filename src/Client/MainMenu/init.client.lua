-- wait for game to load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- // VARIABLES \\ --

local core = require(game.ReplicatedStorage.Core)
local loadModules = core("loadModules")
local uiControllers = loadModules(script:GetChildren())

local remotes = game.ReplicatedStorage.Remotes.MainMenu
local characters = remotes.GetCharacters:InvokeServer()
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
            uiControllers[v.Name .. "UI"](button)
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

initUIDefaults()
createCharButtons()
initClickEvents()