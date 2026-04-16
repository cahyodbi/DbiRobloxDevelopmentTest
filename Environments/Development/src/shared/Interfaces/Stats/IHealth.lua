export type IHealth = {
	SetHealth: (self: IHealth, health: number, maxHealth: number) -> (),
	IncreaseHealth: (self: IHealth, health: number, maxHealth: number) -> (),
	DecreaseHealth: (self: IHealth, health: number, maxHealth: number) -> (),
}

return {}
