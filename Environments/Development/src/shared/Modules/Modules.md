# Shared Modules

Reusable logic and classes (blueprints) yang digunakan oleh client dan server.

## Purpose
- Menyimpan core logic domain (e.g. Health, Stamina) dalam bentuk class yang bisa di-instantiate.
- Menjaga agar implementasi murni dari dependency eksternal seminimal mungkin.

## Aturan Akses
> **Module TIDAK boleh diakses langsung oleh Controller.**
> Controller harus mengakses Module melalui **Utility** sebagai perantara.

## Struktur
```
Modules/
└── Stats/
    └── Health   -- Class health domain (IHealth), hanya diakses oleh HealthUtility
```
