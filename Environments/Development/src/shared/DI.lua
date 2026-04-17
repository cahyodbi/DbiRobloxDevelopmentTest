local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local DI = {}

-- 1. Load Shared Scope (Standard)
local DISharedScope = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("DISharedScope"))
DI.Shared = DISharedScope

-- 2. Detect and Load Platform Scopes
local platformScope
if RunService:IsClient() then
	-- Client Standard
	local player = game:GetService("Players").LocalPlayer
	local playerScripts = player:WaitForChild("PlayerScripts")
	
	local clientScopeModule = playerScripts:FindFirstChild("DIClientScope", true)
	if clientScopeModule and clientScopeModule:IsA("ModuleScript") then
		platformScope = require(clientScopeModule)
	end
	
	DI.Client = platformScope
	DI.Server = nil
elseif RunService:IsServer() then
	-- Server Standard
	local serverScriptService = game:GetService("ServerScriptService")
	
	local serverScopeModule = serverScriptService:FindFirstChild("DIServerScope", true)
	if serverScopeModule and serverScopeModule:IsA("ModuleScript") then
		platformScope = require(serverScopeModule)
	end
	
	DI.Server = platformScope
	DI.Client = nil
end

-- Currently active platform scope (Client or Server)
DI.Platform = platformScope

--[=[
    Unified resolver: Checks Platform then Shared.
]=]
function DI:Get(nameOrCategory: string, name: string?)
	-- Explicit category lookup
	if name then
		local cat = nameOrCategory
		local target = name
		
		if platformScope and platformScope[cat] and platformScope[cat][target] then
			return platformScope:Get(cat, target)
		end
		
		return DISharedScope:Get(cat, target)
	end
	
	-- Unified search
	local target = nameOrCategory
	
	-- 1. Try Platform
	if platformScope then
		local success, result = pcall(function() return platformScope:Get(target) end)
		if success then return result end
	end
	
	-- 2. Try Shared
	local success, result = pcall(function() return DISharedScope:Get(target) end)
	if success then return result end
	
	error(string.format("[DI] Dependency '%s' not found in any scope.", target))
end

-- Metatable for ultra-clean access: DI.Knit, DI.Shared.StatDatas, etc.
setmetatable(DI, {
	__index = function(self, key)
		if key:sub(1,1) == "_" then return nil end
		
		-- Try unified resolve
		local success, result = pcall(function() return self:Get(key) end)
		if success then return result end
		
		return nil
	end
})

return DI
