# Controllers

Controllers are client-side singletons responsible for orchestrating game logic, managing UI state, and responding to user input.

## Dependency Rules
- Controller **TIDAK boleh** mengakses Module (e.g. `Health`) secara langsung.
- Controller mengakses logika domain melalui **Utility** (e.g. `HealthUtility`) sebagai perantara.
- Controller hanya mengetahui Interface Utility (e.g. `IHealthUtility`), bukan implementasinya.

## Responsibilities
- Handles local player interactions.
- Communicates with Server Services via Remotes/Events.
- Orchestrates View updates.
- Delegates domain logic to Utilities.
