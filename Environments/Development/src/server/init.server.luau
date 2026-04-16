local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- Wait for Packages to be available (Wally)
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Knit = require(Packages.Knit)

-- Load Services
local Services = ServerScriptService.Server.Services
for _, module in ipairs(Services:GetChildren()) do
    if module:IsA("ModuleScript") then
        require(module)
    end
end

Knit.Start():andThen(function()
    print("[SERVER] Knit started")
end):catch(warn)
