local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DISharedScope = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("DISharedScope"))
local Players = DISharedScope.Engine.Players

local DIClientScope = {}

-- Categories list for automatic searching
DIClientScope._categories = {
	"Controllers",
	"Modules",
	"Views",
	"Interfaces",
	"Dynamic"
}

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
    Safely try to get a dependency by its name.
    Returns nil if not found.
]=]
function DIClientScope:TryGet(name: string)
	-- Check cache/direct keys first
	if self[name] and not table.find(self._categories, name) then
		return self:Get(name)
	end
	
	-- Search all categories
	for _, category in ipairs(self._categories) do
		local catTable = self[category]
		if catTable and catTable[name] then
			return self:Get(category, name)
		end
	end

	return nil
end

--[=[
    Checks if a dependency is available by its name.
]=]
function DIClientScope:IsReady(name: string)
	return self:TryGet(name) ~= nil
end

--[=[
    Main getter for dependencies. Automatically requires ModuleScripts.
]=]
function DIClientScope:Get(nameOrCategory: string, name: string?)
	local category, targetName
	
	if name then
		-- Explicit category + name
		category = nameOrCategory
		targetName = name
	else
		-- Search all categories
		targetName = nameOrCategory
		for _, cat in ipairs(self._categories) do
			if self[cat] and self[cat][targetName] then
				category = cat
				break
			end
		end
	end

	if not category then
		error(string.format("[DIClientScope] Dependency '%s' not found in any category.", targetName))
	end

	local catTable = self[category]
	local target = catTable[targetName]
	
	if not target then
		error(string.format("[DIClientScope] Dependency '%s' not found in category '%s'.", targetName, category))
	end
	
	-- Lazy require jika target adalah ModuleScript
	if typeof(target) == "Instance" and target:IsA("ModuleScript") then
		return require(target)
	end
	
	-- Dynamic logic
	if typeof(target) == "function" then
		return target()
	end
	
	return target
end

-- Set metatable for direct access
setmetatable(DIClientScope, {
	__index = function(self, key)
		-- Avoid infinite loop for internal keys
		if key:sub(1,1) == "_" then return nil end
		
		-- Try to resolve
		local success, result = pcall(function() return self:Get(key) end)
		if success then return result end
		
		return nil
	end
})

return DIClientScope
