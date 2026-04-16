local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local DIServerScope = {}

-- 1. Modules (Logika Bisnis Server-Only)
DIServerScope.Modules = {
}

-- 2. Interfaces (Kontrak Server-Only)
DIServerScope.Interfaces = {
}

--[=[
    Main getter for server dependencies. Automatically requires ModuleScripts.
]=]
function DIServerScope:Get(category: string, name: string)
	local catTable = self[category]
	if not catTable then
		error(string.format("[DIServerScope] Category '%s' not found.", category))
	end
	
	local target = catTable[name]
	if not target then
		error(string.format("[DIServerScope] Dependency '%s' not found in category '%s'.", name, category))
	end
	
	-- Lazy require
	if typeof(target) == "Instance" and target:IsA("ModuleScript") then
		return require(target)
	end
	
	return target
end

return DIServerScope
