# Shared Utilities

Utility modules yang menjadi **perantara (mediator) antara Controller dan Module**.
Controller tidak boleh mengakses Module secara langsung — semua akses ke Module harus melalui Utility.

## Prinsip
- Utility mengenkapsulasi logika domain dari suatu Module (e.g. Health, Stamina).
- Controller hanya bergantung pada Interface Utility (e.g. `IHealthUtility`), bukan implementasinya.
- Reducer kompleksitas di Controller: logika kalkulasi (damage, heal, ratio) dipindah ke Utility.

## Struktur
```
Utilities/
└── Stats/
    └── HealthUtility   -- Perantara ke Health module (IHealthUtility)
```

## Aturan
- Utility boleh mengakses Module.
- Controller TIDAK boleh mengakses Module secara langsung.
- Setiap Utility wajib diregistrasi di `DISharedScope.Utilities`.
