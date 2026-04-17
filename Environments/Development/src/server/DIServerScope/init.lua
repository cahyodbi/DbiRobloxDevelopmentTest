local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local DIServerScope = {}

-- Categories list for automatic searching
DIServerScope._categories = {
	"Modules",
	"Interfaces"
}

-- 1. Modules (Logika Bisnis Server-Only)
DIServerScope.Modules = {
}

-- 2. Interfaces (Kontrak Server-Only)
DIServerScope.Interfaces = {
}

--[=[
    Main getter for server dependencies. Automatically requires ModuleScripts.
]=]
function DIServerScope:Get(nameOrCategory: string, name: string?)
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
		error(string.format("[DIServerScope] Dependency '%s' not found in any category.", targetName))
	end

	local catTable = self[category]
	local target = catTable[targetName]
	
	if not target then
		error(string.format("[DIServerScope] Dependency '%s' not found in category '%s'.", targetName, category))
	end
	
	-- Lazy require
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
setmetatable(DIServerScope, {
	__index = function(self, key)
		-- Avoid infinite loop for internal keys
		if key:sub(1,1) == "_" then return nil end
		
		-- Try to resolve
		local success, result = pcall(function() return self:Get(key) end)
		if success then return result end
		
		return nil
	end
})

return DIServerScope
