local dialogues = {}

for _, module in pairs(script:GetChildren()) do
    if module:IsA("ModuleScript") then
        local data = require(module)
        if type(data) == "table" then
            for key, value in pairs(data) do
                dialogues[key] = value
            end
        end
    end
end

return table.freeze(dialogues)
