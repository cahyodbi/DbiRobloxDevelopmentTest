export type IHealthUtility = {
	GetHealth: (self: IHealthUtility) -> number,
	GetMaxHealth: (self: IHealthUtility) -> number,
	TakeDamage: (self: IHealthUtility, damage: number) -> (),
	Heal: (self: IHealthUtility, amount: number) -> (),
	GetHealthRatio: (self: IHealthUtility) -> number,
}

return {}
