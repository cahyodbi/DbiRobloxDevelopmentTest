# Repositories

The data access layer responsible for interacting with external persistence systems (DataStores, MemoryStores, external APIs).

## Purpose
- Abstracts the "how" of data storage (e.g., handles DataStore retries, caching, etc.).
- Provides a clean interface for Services to retrieve and save data without needing to know the underlying storage details.
