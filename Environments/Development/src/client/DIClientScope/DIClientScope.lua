local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DISharedScope = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("DISharedScope"):WaitForChild("DISharedScope"))
local Players = DISharedScope.Engine.Players

local DIClientScope = {}

-- 1. Controllers
DIClientScope.Controllers = {
	-- stats controller
	HealthStatController = Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Client"):WaitForChild("Controllers"):WaitForChild("Stats"):WaitForChild("HealthStatController"),
}

-- 2. Module Paths (Frameworks, Libraries, UI Logic)
DIClientScope.Modules = {
}

-- 3. Views
DIClientScope.Views = {
	-- stats view
	HealthStatsView = Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Client"):WaitForChild("Views"):WaitForChild("Stats"):WaitForChild("Health"):WaitForChild("Implementations"):WaitForChild("HealthStatsView"),
}

-- 4. Interfaces
DIClientScope.Interfaces = {
	IHealthStatsView = Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Client"):WaitForChild("Views"):WaitForChild("Stats"):WaitForChild("Health"):WaitForChild("Interfaces"):WaitForChild("IHealthStatsView"),
}

-- 5. Dynamic/Optional Dependencies (Logic for real-time lookups)
DIClientScope.Dynamic = {
	-- SeasonalAssets = function() return workspace:FindFirstChild("SeasonalAssets") end,
}

--[=[
    Safely try to get a DYNAMIC dependency by its name.
    Returns nil if not found.
]=]
function DIClientScope:TryGet(name: string)
	local dynamicEntry = self.Dynamic[name]
	if dynamicEntry then
		if typeof(dynamicEntry) == "function" then
			return dynamicEntry()
		end
		return dynamicEntry
	end

	return nil
end

--[=[
    Checks if a DYNAMIC dependency is available by its name.
]=]
function DIClientScope:IsReady(name: string)
	return self:TryGet(name) ~= nil
end

--[=[
    Main getter for dependencies. Automatically requires ModuleScripts.
]=]
function DIClientScope:Get(category: string, name: string)
	local catTable = self[category]
	if not catTable then
		error(string.format("[DIClientScope] Category '%s' not found.", category))
	end
	
	local target = catTable[name]
	if not target then
		error(string.format("[DIClientScope] Dependency '%s' not found in category '%s'.", name, category))
	end
	
	-- Lazy require jika target adalah ModuleScript
	if typeof(target) == "Instance" and target:IsA("ModuleScript") then
		return require(target)
	end
	
	return target
end

return DIClientScope
