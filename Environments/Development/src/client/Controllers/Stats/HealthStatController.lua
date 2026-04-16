local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- 1. Ambil DI Scopes (Wajib ada agar :Get bisa jalan)
local DISharedScope = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("DISharedScope"):WaitForChild("DISharedScope"))
local DIClientScope = require(script.Parent.Parent.Parent:WaitForChild("DIClientScope"):WaitForChild("DIClientScope"))

-- 2. Ambil Engine & Framework melalui Get
local Players = DISharedScope:Get("Engine", "Players")
local Knit = DISharedScope:Get("Modules", "Knit")
local UserInputService = DISharedScope:Get("Engine", "UserInputService")

-- 3. Ambil Interfaces (Kontrak) melalui Get
local IHealthUtility = DISharedScope:Get("Interfaces", "IHealthUtility")
local IHealthStatsView = DIClientScope:Get("Interfaces", "IHealthStatsView")

-- 4. Ambil Utility (Perantara ke Health module) melalui Get
local HealthUtility = DISharedScope:Get("Utilities", "HealthUtility")
local HealthStatsView = DIClientScope:Get("Views", "HealthStatsView")

-- Local cache untuk referensi UI Fill
local healthStatsFill: GuiObject

local HealthStatController = Knit.CreateController {
	Name = "HealthStatController",
}

function HealthStatController:KnitStart()
	print("HEALTH STAT CONTROLLER START")
	
	-- Ambil UI secara manual di Controller
	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")
	local mainGui = playerGui:WaitForChild("MainGui", 10)
	healthStatsFill = mainGui:WaitForChild("HealthBarBG"):WaitForChild("Fill")
	
	self._healthView = (HealthStatsView.new() :: any) :: IHealthStatsView.IHealthStatsView
	self._healthUtility = (HealthUtility :: any) :: IHealthUtility.IHealthUtility
	
	-- [DUMMY INPUT] P = Heal 10 | L = Damage 10
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		
		if input.KeyCode == Enum.KeyCode.P then
			self:GetHeal(10)
		elseif input.KeyCode == Enum.KeyCode.L then
			self:GetDamage(10)
		end
	end)
	
	self:_updateUI()
end

-- Fungsi untuk menerima Damage
function HealthStatController:GetDamage(damage: number)
	if not self._healthUtility then return end
	
	self._healthUtility:TakeDamage(damage)
	self:_updateUI()
end

-- Fungsi untuk menerima Heal
function HealthStatController:GetHeal(heal: number)
	if not self._healthUtility then return end
	
	self._healthUtility:Heal(heal)
	self:_updateUI()
end

function HealthStatController:_updateUI()
	if not self._healthView or not healthStatsFill or not self._healthUtility then 
		print("DEBUG: _updateUI aborted. States:", 
			"View:", self._healthView ~= nil, 
			"Fill:", healthStatsFill ~= nil, 
			"Utility:", self._healthUtility ~= nil)
		return 
	end
	
	self._healthView:SetHealthBar(healthStatsFill, self._healthUtility:GetHealthRatio())
end

return HealthStatController
