local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterPlayer = game:GetService("StarterPlayer")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local DISharedScope = {}

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
    Safely try to get a DYNAMIC dependency by its name.
    Returns nil if not found.
]=]
function DISharedScope:TryGet(name: string)
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
function DISharedScope:IsReady(name: string)
	return self:TryGet(name) ~= nil
end

--[=[
    Main getter for dependencies. Automatically requires ModuleScripts.
]=]
function DISharedScope:Get(category: string, name: string)
	local catTable = self[category]
	if not catTable then
		error(string.format("[DISharedScope] Category '%s' not found.", category))
	end
	
	local target = catTable[name]
	if not target then
		error(string.format("[DISharedScope] Dependency '%s' not found in category '%s'.", name, category))
	end
	
	-- Lazy require jika target adalah ModuleScript
	if typeof(target) == "Instance" and target:IsA("ModuleScript") then
		return require(target)
	end
	
	return target
end

return DISharedScope
