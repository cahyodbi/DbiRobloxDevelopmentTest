# DI Client Scope

Konfigurasi dan registrasi dependency untuk sisi client.
Semua dependency client-side harus diregistrasi di sini sebelum bisa di-`Get()` oleh Controller atau View.

## Categories

| Category | Isi | Lifetime |
|---|---|---|
| `Controllers` | Knit Controllers (singleton) | Singleton |
| `Modules` | Library/framework client-only | Singleton |
| `Views` | View class (di-`new()` oleh Controller) | Per-instance |
| `Interfaces` | Kontrak/type untuk LSP | Compile-time only |
| `UI` | GuiObject references (dynamic lookup) | Dynamic |
| `Dynamic` | Optional runtime dependencies | Dynamic |

## Aturan
- `UI` category menggunakan **function** agar lookup terjadi saat runtime (setelah PlayerGui ready).
- View di-`new()` oleh Controller karena terkait lifecycle UI.
- Controller tidak boleh mengakses `Views` implementasi secara langsung tanpa melalui Interface-nya.
