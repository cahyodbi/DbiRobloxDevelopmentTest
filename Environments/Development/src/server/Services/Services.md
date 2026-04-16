# Services

Services are server-side singletons that orchestrate the main game logic and expose APIs to the client (via Remotes) and other server-side components.

## Purpose
- Handles core gameplay loops and high-level logic.
- Orchestrates interactions between Repositories, Policies, and other Services.
- Serves as the primary entry point for client requests on the server.
