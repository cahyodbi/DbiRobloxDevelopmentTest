local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- 1. Ambil DI Scopes (Wajib ada agar :Get bisa jalan)
local DISharedScope = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("DISharedScope"):WaitForChild("DISharedScope"))
local DIClientScope = require(script.Parent.Parent.Parent:WaitForChild("DIClientScope"):WaitForChild("DIClientScope"))

local Knit = DISharedScope:Get("Modules", "Knit")

-- Local cache untuk referensi UI Fill
local healthStatsFill: GuiObject

local HealthStatController = Knit.CreateController {
	Name = "HealthStatController",
}

function HealthStatController:KnitInit()
	-- 2. Ambil Engine & Framework melalui Get
	self._players = DISharedScope:Get("Engine", "Players")
	self._userInputService = DISharedScope:Get("Engine", "UserInputService")

	-- 3. Ambil Interfaces (Kontrak) melalui Get
	self._IHealthStatsView = DIClientScope:Get("Interfaces", "IHealthStatsView")

	-- 4. Ambil Implementasi & Service
	self._HealthStatsViewClass = DIClientScope:Get("Views", "HealthStatsView")
	self._HealthService = Knit.GetService("HealthService")
	
	-- Cache untuk ratio (diupdate dari Server)
	self._currentHealthRatio = 1

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
	local IHealthStatsView = self._IHealthStatsView
	self._healthView = (self._HealthStatsViewClass.new() :: any) :: IHealthStatsView.IHealthStatsView
	
	-- DENGARKAN perubahan dari Server (Knit Property)
	self._HealthService.HealthChanged:Observe(function(newRatio)
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

-- Fungsi untuk mengirim permintaan Damage ke Server
function HealthStatController:GetDamage(damage: number)
	self._HealthService:RequestDamage(damage)
end

-- Fungsi untuk mengirim permintaan Heal ke Server
function HealthStatController:GetHeal(heal: number)
	self._HealthService:RequestHeal(heal)
end

function HealthStatController:_updateUI()
	if not self._healthView or not healthStatsFill then return end
	
	-- Gunakan ratio yang sudah disinkronkan dari Server
	self._healthView:SetHealthBar(healthStatsFill, self._currentHealthRatio)
end

return HealthStatController
