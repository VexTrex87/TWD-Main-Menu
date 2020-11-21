-- wait for camera to load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- // VARIABLES \\ --

local module = {
    currentChar = nil,
    cameraIsMoving = nil,
    originalCameraCFrame = CFrame.new(),
    currentCameraTween = nil,
}

local depthOfField = game.Lighting.DepthOfField

local core = require(game.ReplicatedStorage.Modules.Core)
local newTween = core("newTween")
local randomNum = core("randomNum")
local newThread = core("newThread")

local Settings = require(script.Parent.Parent.Settings)
local camera = workspace.CurrentCamera
local mainMenuCamera = workspace.MainMenuCamera
local cameraObj = mainMenuCamera.CameraObject
local charHolder = mainMenuCamera.CharacterHolder

-- // FUNCTIONS \\ --

-- camera

function module.startCamera()
    camera.CameraType = Enum.CameraType.Scriptable
    camera.CFrame = cameraObj.CFrame
    module.originalCameraCFrame = camera.CFrame
    depthOfField.Enabled = true
    module.startCameraMovement()
end

function module.removeCamera()
    module.stopCameraMovement()
    camera.CameraType = Enum.CameraType.Custom
    depthOfField.Enabled = false
end

-- camera movement

function cameraMovement()
    repeat
        local randomX = randomNum(-Settings.camera.moveOffset, Settings.camera.moveOffset, 10)
        local randomY = randomNum(-Settings.camera.moveOffset, Settings.camera.moveOffset, 10)
        local randomCFrame = module.originalCameraCFrame * CFrame.new(randomX, randomY, 0)
        module.currentCameraTween = newTween(camera, Settings.camera.tweenInfo, {CFrame = randomCFrame})
        wait(Settings.camera.tweenInfo.Time - Settings.camera.moveInterruptionDelay)
    until not module.cameraIsMoving
end

function module.startCameraMovement()
    module.cameraIsMoving = true
    newThread(cameraMovement)
end

function module.stopCameraMovement()
    module.cameraIsMoving = false
    module.currentCameraTween:Pause()
end

-- character

function module.newChar(newChar)
    module.removeCurrentChar()
    module.currentChar = newChar:Clone()
    module.currentChar.Parent = mainMenuCamera
    module.currentChar.HumanoidRootPart.CFrame = charHolder.HumanoidRootPart.CFrame
end

function module.removeCurrentChar()
    if module.currentChar then
        module.currentChar:Destroy()
    end
end

-- // COMPILE \\ --

module.currentChar = mainMenuCamera[Settings.defaultCharacter]

return module