local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DI = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("DI"))
local DISharedScope = DI.Shared
local DIClientScope = DI.Client
local Knit = DISharedScope.Knit

--objects
local healthStatsFill: GuiObject

local HealthStatController = Knit.CreateController {
	Name = "HealthStatController",
}

--#region Knit
function HealthStatController:KnitInit()
	--Engine
	self._players = DISharedScope.Players
	self._userInputService = DISharedScope.UserInputService
	
	--Services
	self._healthService = Knit.GetService("HealthService")

	--Views/Modules
	self._healthStatsView = DIClientScope.HealthStatsView

	--Interfaces
	self._healthViewContract = DIClientScope.IHealthStatsView
	
	-- Cache untuk ratio (diupdate dari Server)
	self._currentHealthRatio = 1

	--Objects
	-- Ambil UI secara manual di Controller
	local player = self._players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")
	local mainGui = playerGui:WaitForChild("MainGui", 10)
	healthStatsFill = mainGui:WaitForChild("HealthBarBG"):WaitForChild("Fill")
end

function HealthStatController:KnitStart()
	print("HEALTH STAT CONTROLLER START")
	
	-- Inisialisasi View
	-- Kita gunakan Type dari interface untuk mengendalikan (contracting) instance view
	local HealthViewContract = self._healthViewContract
	self._healthView = (self._healthStatsView.new() :: any) :: HealthViewContract.IHealthStatsView
	
	-- DENGARKAN perubahan dari Server (Knit Property)
	self._healthService.HealthChanged:Observe(function(newRatio)
		self._currentHealthRatio = newRatio
		self:_updateUI()
	end)
	
	-- [DUMMY INPUT] Kirim permintaan ke Server
	self._userInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		
		if input.KeyCode == Enum.KeyCode.P then
			self:GetHeal(10)
		elseif input.KeyCode == Enum.KeyCode.L then
			self:GetDamage(10)
		end
	end)
end
--#endregion

--#region Functions
-- Fungsi untuk mengirim permintaan Damage ke Server
function HealthStatController:GetDamage(damage: number)
	self._healthService:RequestDamage(damage)
end

-- Fungsi untuk mengirim permintaan Heal ke Server
function HealthStatController:GetHeal(heal: number)
	self._healthService:RequestHeal(heal)
end

function HealthStatController:_updateUI()
	if not self._healthView or not healthStatsFill then return end
	
	-- Gunakan ratio yang sudah disinkronkan dari Server
	self._healthView:SetHealthBar(healthStatsFill, self._currentHealthRatio)
end
--#endregion

return HealthStatController
