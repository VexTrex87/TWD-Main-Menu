local module = {
    currentChar = nil
}

-- wait for camera to load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local camera = workspace.CurrentCamera
local mainMenuCamera = workspace.MainMenuCamera
local cameraObj = mainMenuCamera.CameraObject
local charHolder = mainMenuCamera.CharacterHolder

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

function module.startCamera()
    camera.CameraType = Enum.CameraType.Scriptable
    camera.CFrame = cameraObj.CFrame
end

function module.removeCamera()
    camera.CameraType = Enum.CameraType.Custom
end

return module