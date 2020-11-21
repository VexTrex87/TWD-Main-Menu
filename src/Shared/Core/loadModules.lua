return function(moduleDirectory)
    local moduleDictionary = {}
    for _,module in pairs(moduleDirectory) do
        if module:IsA("ModuleScript") then
            moduleDictionary[module.Name] = require(module)
        end
    end
    return moduleDictionary
end