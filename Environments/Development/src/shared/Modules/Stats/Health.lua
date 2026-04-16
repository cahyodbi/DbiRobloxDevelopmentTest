local DISharedScope = require(script.Parent.Parent.Parent.DISharedScope.DISharedScope)

local Stats = DISharedScope:Get("Data", "StatDatas")
local IHealth = DISharedScope:Get("Interfaces", "IHealth")

local Health = {}
Health.__index = Health

function Health.new(): IHealth.IHealth
	local self = setmetatable({}, Health)
	
	-- Ambil nilai default dari Repository melalui DISharedScope Get
	self._health = Stats.Health
	self._maxHealth = Stats.MaxHealth
	
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
