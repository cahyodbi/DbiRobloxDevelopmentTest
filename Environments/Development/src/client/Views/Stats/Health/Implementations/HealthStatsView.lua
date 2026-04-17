local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DI = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("DI"))
local DIClientScope = DI.Client

local HealthStatsViewContract = DIClientScope.IHealthStatsView

local HealthStatsView = {}
HealthStatsView.__index = HealthStatsView

function HealthStatsView.new(): HealthStatsViewContract.IHealthStatsView
	local self = setmetatable({}, HealthStatsView)
	return (self :: any) :: HealthStatsViewContract.IHealthStatsView
end

--#region IHealthStatsView

function HealthStatsView:SetHealthBar(targetFrame: GuiObject, healthPercentage: number)
	local clampedPercentage = math.clamp(healthPercentage, 0, 1)
	targetFrame.Size = UDim2.new(0, 200 * clampedPercentage, 0, targetFrame.Size.Y.Offset)
end

--#endregion

return HealthStatsView
