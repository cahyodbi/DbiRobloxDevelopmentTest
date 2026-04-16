--[=[
	HealthUtility
	
	Singleton utility yang menjadi perantara antara Controller dan Health module.
	Health module di-instantiate sekali secara internal saat module ini di-load.
	Controller tidak perlu memanggil .new() — cukup gunakan langsung hasil dari :Get().
]=]

local DISharedScope = require(script.Parent.Parent.Parent.DISharedScope.DISharedScope)

local IHealthUtility = DISharedScope:Get("Interfaces", "IHealthUtility")
local Health = DISharedScope:Get("Modules", "Health")

-- Singleton: Health di-instantiate sekali di sini, bukan di Controller
local _healthModule = Health.new()

local HealthUtility = {}

-- Mengembalikan nilai health saat ini
function HealthUtility:GetHealth(): number
	return _healthModule._health
end

-- Mengembalikan nilai max health
function HealthUtility:GetMaxHealth(): number
	return _healthModule._maxHealth
end

-- Mengurangi health sebesar damage (kalkulasi dilakukan di dalam Health module)
function HealthUtility:TakeDamage(damage: number)
	_healthModule:DecreaseHealth(damage, _healthModule._maxHealth)
end

-- Menambah health sebesar amount (kalkulasi dilakukan di dalam Health module)
function HealthUtility:Heal(amount: number)
	_healthModule:IncreaseHealth(amount, _healthModule._maxHealth)
end

-- Mengembalikan rasio health saat ini (0.0 - 1.0) untuk keperluan UI
function HealthUtility:GetHealthRatio(): number
	return _healthModule._health / _healthModule._maxHealth
end

return (HealthUtility :: any) :: IHealthUtility.IHealthUtility

