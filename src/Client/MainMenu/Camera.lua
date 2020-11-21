local module = {}

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local camera = workspace.CurrentCamera
local cameraObj = workspace.Camera
local cameraFigure = workspace.CameraFigure

local p = game.Players.LocalPlayer
local char = p.Character or p.CharacterAdded:Wait()

function module.setCharAtCamera()
    char.HumanoidRootPart.CFrame = cameraFigure.HumanoidRootPart.CFrame
end

function module.startCamera()
    camera.CameraType = Enum.CameraType.Scriptable
    print(camera.CFrame.Position, cameraObj.CFrame.Position)
    camera.CFrame = cameraObj.CFrame
    print(camera.CFrame.Position, cameraObj.CFrame.Position)
    module.setCharAtCamera()
end

function module.removeCamera()
    camera.CameraType = Enum.CameraType.Custom
end

return module