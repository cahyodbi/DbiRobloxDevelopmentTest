local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DI = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("DI"))
local DISharedScope = DI.Shared
local Knit = DISharedScope.Knit

-- DEPENDENCIES (Top-level for type accessibility)
local Health = DISharedScope.Health
local HealthContract = DISharedScope.IHealth

-- DataStore Configuration
local DATASTORE_NAME = "PlayerData_v1"
local IS_DATASTORE_ENABLED = false

local HealthService = Knit.CreateService {
    Name = "HealthService",
    Client = {
        HealthChanged = Knit.CreateProperty(0),
        
        RequestDamage = function(self, player, amount)
            self.Server:DamagePlayer(player, amount)
        end,
        RequestHeal = function(self, player, amount)
            self.Server:HealPlayer(player, amount)
        end,
    },
}

function HealthService:KnitInit()
    print("[HealthService] Initializing...")
    
    -- ENGINE
    self._dataStoreService = DISharedScope.DataStoreService
    self._players = DISharedScope.Players
    
    -- SERVICES
    if IS_DATASTORE_ENABLED then
        self._playerDataStore = self._dataStoreService:GetDataStore(DATASTORE_NAME)
    end

    -- INTERFACES & MODULES (References keep for runtime convenience)
    self._healthContract = HealthContract
    self._healthStats = Health

    self._playerHealthInstances = {}
    self._playerDataStatus = {} -- Track load status for validation
end

-- Validasi aksi (terutama jika DataStore diaktifkan)
-- Mungkin ini harusnya berupa policy?
function HealthService:_validatePlayerAction(player: Player): boolean
    -- 1. Cek apakah instance health ada
    local healthObj = self._playerHealthInstances[player]
    if not healthObj then return false end
    
    -- 2. Jika DataStore aktif, cek apakah data sudah sukses di-load
    if IS_DATASTORE_ENABLED then
        local status = self._playerDataStatus[player]
        if not status or not status.Loaded then
            warn(string.format("[HealthService] Action blocked for %s: Data not loaded yet.", player.Name))
            return false
        end
    end
    
    return true
end

function HealthService:KnitStart()
    print("[HealthService] Started")
    
    self._players.PlayerAdded:Connect(function(player)
        self:OnPlayerAdded(player)
    end)

    self._players.PlayerRemoving:Connect(function(player)
        self:OnPlayerRemoving(player)
    end)
    
    for _, player in ipairs(self._players:GetPlayers()) do
        task.spawn(function()
            self:OnPlayerAdded(player)
        end)
    end
end

function HealthService:OnPlayerAdded(player: Player)
    local initialHealth, initialMaxHealth
    local loadSuccess = false
    
    if IS_DATASTORE_ENABLED then
        local userId = player.UserId
        local key = "Player_" .. userId
        
        local success, data = pcall(function()
            return self._playerDataStore:GetAsync(key)
        end)
        
        if not success then
            warn(string.format("[HealthService] DataStore error for player %s: %s", player.Name, tostring(data)))
            if string.find(tostring(data), "StudioAccessToApisNotAllowed") then
                warn("[HealthService] FIX: Silakan aktifkan 'Studio Access to API Services' di Game Settings > Security.")
            end
        end
        
        if success and data then
            initialHealth = data.Health
            initialMaxHealth = data.MaxHealth
            print(string.format("[HealthService] Loaded data for %s: %d/%d", player.Name, initialHealth, initialMaxHealth))
            loadSuccess = true
        end
    else
        loadSuccess = true -- Bypassed DataStore
    end

    self._playerDataStatus[player] = { Loaded = loadSuccess }

    if not initialHealth then
        print(string.format("[HealthService] Using default stats for %s.", player.Name))
    end
    
    -- Ganti cast ke variabel lokal untuk menghindari error syntax Luau
    local healthObj = (Health.new(initialHealth, initialMaxHealth) :: any) :: HealthContract.IHealth
    self._playerHealthInstances[player] = healthObj
    
    self:_syncHealthToClient(player)
end

function HealthService:OnPlayerRemoving(player: Player)
    local healthObj = self._playerHealthInstances[player]
    if not healthObj then return end
    
    if IS_DATASTORE_ENABLED then
        local userId = player.UserId
        local key = "Player_" .. userId
        
        local dataToSave = {
            Health = healthObj._health,
            MaxHealth = healthObj._maxHealth,
        }
        
        local success, err = pcall(function()
            self._playerDataStore:SetAsync(key, dataToSave)
        end)
        
        if success then
            print(string.format("[HealthService] Successfully saved data for %s", player.Name))
        else
            warn(string.format("[HealthService] Failed to save data for %s: %s", player.Name, tostring(err)))
            if string.find(tostring(err), "StudioAccessToApisNotAllowed") then
                warn("[HealthService] Failed to save result: 'Studio Access to API Services' is disabled.")
            end
        end
    end
    
    self._playerHealthInstances[player] = nil
    self._playerDataStatus[player] = nil
end

function HealthService:DamagePlayer(player: Player, amount: number)
    if not self:_validatePlayerAction(player) then return end
    
    local healthObj = self._playerHealthInstances[player]
    healthObj:DecreaseHealth(amount, healthObj._maxHealth)
    self:_syncHealthToClient(player)
end

function HealthService:HealPlayer(player: Player, amount: number)
    if not self:_validatePlayerAction(player) then return end
    
    local healthObj = self._playerHealthInstances[player]
    healthObj:IncreaseHealth(amount, healthObj._maxHealth)
    self:_syncHealthToClient(player)
end

function HealthService:_syncHealthToClient(player: Player)
    local healthObj = self._playerHealthInstances[player]
    if healthObj then
        local ratio = healthObj._health / healthObj._maxHealth
        self.Client.HealthChanged:SetFor(player, ratio)
    end
end

return HealthService
