local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local DISharedScope = {}

-- Categories list for automatic searching
DISharedScope._categories = {
	"Engine",
	"Data",
	"Modules",
	"Interfaces",
	"Utilities",
	"Dynamic"
}

-- 1. Engine Services (Bawaan Roblox)
DISharedScope.Engine = {
	Players = Players,
	ReplicatedStorage = ReplicatedStorage,
	CollectionService = game:GetService("CollectionService"),
	RunService = RunService,
	TweenService = game:GetService("TweenService"),
	HttpService = game:GetService("HttpService"),
	UserInputService = game:GetService("UserInputService"),
	DataStoreService = game:GetService("DataStoreService"),
}

-- 2. Data Paths (Configs, Templates, Static Data)
DISharedScope.Data = {
	StatDatas = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Repositories"):WaitForChild("Player"):WaitForChild("Stats"),
}

-- 3. Module Paths (Frameworks, Libraries, UI Logic)
DISharedScope.Modules = {
	Knit = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"),
	Health = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Modules"):WaitForChild("Stats"):WaitForChild("Health"),
}

-- 4. Interface Definitions (Contracts for DIP)
DISharedScope.Interfaces = {
	IHealth = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Interfaces"):WaitForChild("Stats"):WaitForChild("IHealth"),
	IHealthUtility = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Interfaces"):WaitForChild("Stats"):WaitForChild("IHealthUtility"),
}

-- 5. Utilities (Perantara antara Controller dan Module)
DISharedScope.Utilities = {
	HealthUtility = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Utilities"):WaitForChild("Stats"):WaitForChild("HealthUtility"),
}

-- 6. Dynamic/Optional Dependencies (Logic for real-time lookups)
DISharedScope.Dynamic = {
	-- SeasonalAssets = function() return workspace:FindFirstChild("SeasonalAssets") end,
}

--[=[
    Safely try to get a dependency by its name.
    Returns nil if not found.
]=]
function DISharedScope:TryGet(name: string)
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
function DISharedScope:IsReady(name: string)
	return self:TryGet(name) ~= nil
end

--[=[
    Main getter for dependencies. Automatically requires ModuleScripts.
]=]
function DISharedScope:Get(nameOrCategory: string, name: string?)
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
		error(string.format("[DISharedScope] Dependency '%s' not found in any category.", targetName))
	end

	local catTable = self[category]
	local target = catTable[targetName]
	
	if not target then
		error(string.format("[DISharedScope] Dependency '%s' not found in category '%s'.", targetName, category))
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

-- Set metatable for direct access: DISharedScope.Knit
setmetatable(DISharedScope, {
	__index = function(self, key)
		-- Avoid infinite loop for internal keys
		if key:sub(1,1) == "_" then return nil end
		
		-- Try to resolve
		local success, result = pcall(function() return self:Get(key) end)
		if success then return result end
		
		return nil
	end
})

return DISharedScope
