local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- 1. Ambil Scopes dan Framework dasar
local DISharedScope = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("DISharedScope"):WaitForChild("DISharedScope"))
local DIServerScope = require(script.Parent.Parent:WaitForChild("DIServerScope"):WaitForChild("DIServerScope"))
local Knit = DISharedScope:Get("Modules", "Knit")

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
    
    -- 2. Ambil Engine Services melalui DISharedScope
    self._DataStoreService = DISharedScope:Get("Engine", "DataStoreService")
    self._Players = DISharedScope:Get("Engine", "Players")
    
    -- 3. Ambil Logic & Interface melalui DISharedScope (Pindah dari Server ke Shared)
    self._IHealth = DISharedScope:Get("Interfaces", "IHealth")
    self._HealthClass = DISharedScope:Get("Modules", "Health")
    
    -- 4. Inisialisasi DataStore (Hanya jika diaktifkan)
    if IS_DATASTORE_ENABLED then
        self._playerDataStore = self._DataStoreService:GetDataStore(DATASTORE_NAME)
    end
    
    -- Table untuk menyimpan instance Health per player
    self._playerHealthInstances = {}
end

function HealthService:KnitStart()
    print("[HealthService] Started")
    
    self._Players.PlayerAdded:Connect(function(player)
        self:OnPlayerAdded(player)
    end)

    self._Players.PlayerRemoving:Connect(function(player)
        self:OnPlayerRemoving(player)
    end)
    
    for _, player in ipairs(self._Players:GetPlayers()) do
        task.spawn(function()
            self:OnPlayerAdded(player)
        end)
    end
end

function HealthService:OnPlayerAdded(player: Player)
    local initialHealth, initialMaxHealth
    
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
        end
    end

    if not initialHealth then
        print(string.format("[HealthService] Using default stats for %s.", player.Name))
    end
    
    -- Buat instance Health baru dengan Casting ke Interface (Contract)
    local IHealth = self._IHealth
    local healthObj = (self._HealthClass.new(initialHealth, initialMaxHealth) :: any) :: IHealth.IHealth
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
end

function HealthService:DamagePlayer(player: Player, amount: number)
    local healthObj = self._playerHealthInstances[player]
    if healthObj then
        healthObj:DecreaseHealth(amount, healthObj._maxHealth)
        self:_syncHealthToClient(player)
    end
end

function HealthService:HealPlayer(player: Player, amount: number)
    local healthObj = self._playerHealthInstances[player]
    if healthObj then
        healthObj:IncreaseHealth(amount, healthObj._maxHealth)
        self:_syncHealthToClient(player)
    end
end

function HealthService:_syncHealthToClient(player: Player)
    local healthObj = self._playerHealthInstances[player]
    if healthObj then
        local ratio = healthObj._health / healthObj._maxHealth
        self.Client.HealthChanged:SetFor(player, ratio)
    end
end

return HealthService
