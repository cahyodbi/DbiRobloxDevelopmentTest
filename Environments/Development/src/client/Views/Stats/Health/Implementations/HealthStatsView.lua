local IHealthStatsView = require(script.Parent.Parent.Interfaces.IHealthStatsView)

local HealthStatsView = {}
HealthStatsView.__index = HealthStatsView

function HealthStatsView.new(): IHealthStatsView.IHealthStatsView
	local self = setmetatable({}, HealthStatsView)
	return (self :: any) :: IHealthStatsView.IHealthStatsView
end

function HealthStatsView:SetHealthBar(targetFrame: GuiObject, healthPercentage: number)
	local clampedPercentage = math.clamp(healthPercentage, 0, 1)
	
	-- Update hanya X Offset (Max 200, Min 0)
	-- Kita pertahankan Y Offset yang ada sekarang

	print("Value ", clampedPercentage)
	targetFrame.Size = UDim2.new(0, 200 * clampedPercentage, 0, targetFrame.Size.Y.Offset)
end

return HealthStatsView
