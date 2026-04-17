--[=[
	HealthUtility
	
	Singleton utility yang menjadi perantara antara Controller dan Health module.
	Health module di-instantiate sekali secara internal saat module ini di-load.
	Selaras dengan pola DI di Controller dan Service.

	NOTES: Jika DataStore sudah aktif harusnya UTILITY ini tidak perlu sih,
]=]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DI = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("DI"))
local DISharedScope = DI.Shared

-- DEPENDENCIES (Resolved via DI)
local HealthUtilityContract = DISharedScope.IHealthUtility
local Health = DISharedScope.Health

-- Singleton instance
local HealthInstance = Health.new()

local HealthUtility = {}

--#region Functions
-- Mengembalikan nilai health saat ini
function HealthUtility:GetHealth(): number
	return HealthInstance._health
end

-- Mengembalikan nilai max health
function HealthUtility:GetMaxHealth(): number
	return HealthInstance._maxHealth
end

-- Mengurangi health sebesar damage
function HealthUtility:TakeDamage(damage: number)
	HealthInstance:DecreaseHealth(damage, HealthInstance._maxHealth)
end

-- Menambah health sebesar amount
function HealthUtility:Heal(amount: number)
	HealthInstance:IncreaseHealth(amount, HealthInstance._maxHealth)
end

-- Mengembalikan rasio health saat ini (0.0 - 1.0) untuk keperluan UI
function HealthUtility:GetHealthRatio(): number
	if HealthInstance._maxHealth == 0 then return 0 end
	return HealthInstance._health / HealthInstance._maxHealth
end
--#endregion

return (HealthUtility :: any) :: HealthUtilityContract.IHealthUtility
