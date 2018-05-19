local IcyHotADP = RegisterMod("IcyHotADP", 1)
local game = Game()


-- Mod Items

-- Trinket
TrinketType.TRINKET_ICYHOT = Isaac.GetTrinketIdByName("Icy Hot Flame")

-- Item Data
local IcyHot = { ACTIVATION_CHANCE = 0.4 }

-- Functions

-- Run when a new room is loaded
function IcyHotADP:OnRoomLoad(entity, variant, subtype, gridIndex, seed)
	local player = Isaac.GetPlayer(0);

	if player:HasTrinket(TrinketType.TRINKET_ICYHOT) and math.random() <= IcyHot.ACTIVATION_CHANCE then
		if entity == EntityType.ENTITY_FIREPLACE and variant ~= 2 then
			return {EntityType.ENTITY_FIREPLACE, 2, 0}
		end
	end
end

-- Run just before spawning an entity effect
function IcyHotADP:OnEffectSpawn(effect)
	if player:HasTrinket(TrinketType.TRINKET_ICYHOT) and math.random() <= IcyHot.ACTIVATION_CHANCE then
		if effect.Variant == EffectVariant.RED_CANDLE_FLAME then
			effect:GetSprite():ReplaceSpritesheet(0, "resources/gfx/effects/effect_034_bluefire.png")
			effect:GetSprite():LoadGraphics()
			effect.State = -3
		elseif effect.Variant == EffectVariant.HOT_BOMB_FIRE then
			effect:GetSprite():ReplaceSpritesheet(0, "resources/gfx/effects/effect_034_bluefire.png")
			effect:GetSprite():LoadGraphics()
			effect.State = -1
		end
	end

end

-- Run when entity effects are updated
function IcyHotADP:OnEffectUpdate(effect)
	if effect.Variant == EffectVariant.HOT_BOMB_FIRE then
			if effect.State == -1 then
				effect:SetTimeout(500)
				effect.State = 0
			end
	end
end

-- Callbacks
IcyHotADP:AddCallback(ModCallbacks.MC_PRE_ROOM_ENTITY_SPAWN, IcyHotADP.OnRoomLoad)
IcyHotADP:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, IcyHotADP.OnEffectSpawn) 
IcyHotADP:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, IcyHotADP.OnEffectUpdate)   