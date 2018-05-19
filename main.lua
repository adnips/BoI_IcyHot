local IcyHotADP = RegisterMod("IcyHotADP", 1)
local game = Game()


-- Mod Items

-- Trinket
TrinketType.TRINKET_ICYHOT = Isaac.GetTrinketIdByName("Icy Hot")

-- Functions

-- Run when a new game is started
function IcyHotADP:OnGameStart(fromSave)

	if not fromSave then	
		Isaac.Spawn(
		EntityType.ENTITY_PICKUP, 
		PickupVariant.PICKUP_TRINKET, 
		TrinketType.TRINKET_ICYHOT, 
		Vector(300,300), Vector(0,0), nil)
	end

end

-- Run when a new room is loaded
function IcyHotADP:OnRoomLoad(entity, variant, subtype, gridIndex, seed)
	local player = Isaac.GetPlayer(0);

	if player:HasTrinket(TrinketType.TRINKET_ICYHOT) then
		if entity == EntityType.ENTITY_FIREPLACE and variant ~= 2 then
			return {EntityType.ENTITY_FIREPLACE, 2, 0}
		end
	end


end

-- Callbacks
IcyHotADP:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, IcyHotADP.OnGameStart)
IcyHotADP:AddCallback(ModCallbacks.MC_PRE_ROOM_ENTITY_SPAWN, IcyHotADP.OnRoomLoad)