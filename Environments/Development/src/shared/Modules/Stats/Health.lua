local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DISharedScope = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("DISharedScope"):WaitForChild("DISharedScope"))

local Stats = DISharedScope:Get("Data", "StatDatas")
local IHealth = DISharedScope:Get("Interfaces", "IHealth")

local Health = {}
Health.__index = Health

function Health.new(customHealth: number?, customMaxHealth: number?): IHealth.IHealth
	local self = setmetatable({}, Health)
	
	-- Ambil nilai default dari Repository, atau gunakan custom value jika ada
	self._health = customHealth or Stats.Health
	self._maxHealth = customMaxHealth or Stats.MaxHealth
	
	return (self :: any) :: IHealth.IHealth
end

function Health:SetHealth(health: number, maxHealth: number)
	self._health = health
	self._maxHealth = maxHealth
end

-- Menambah health sebesar `heal`, tidak melebihi maxHealth
function Health:IncreaseHealth(heal: number, maxHealth: number)
	local newHealth = math.min(self._health + heal, maxHealth)
	self:SetHealth(newHealth, maxHealth)
end

-- Mengurangi health sebesar `damage`, tidak kurang dari 0
function Health:DecreaseHealth(damage: number, maxHealth: number)
	local newHealth = math.max(self._health - damage, 0)
	self:SetHealth(newHealth, maxHealth)
end

return Health
