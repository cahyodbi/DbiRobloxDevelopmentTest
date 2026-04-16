local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Wait for Packages to be available
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Knit = require(Packages.Knit)

-- Load Controllers (rekursif ke semua subfolder)
local Controllers = script.Controllers
for _, module in ipairs(Controllers:GetDescendants()) do
    if module:IsA("ModuleScript") then
        require(module)
    end
end

Knit.Start():andThen(function()
    print("[CLIENT] Knit started")
end):catch(warn)
