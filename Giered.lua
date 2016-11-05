--display welcome message to confirm addon running
local LogInFrame = CreateFrame("Frame")
LogInFrame:RegisterEvent("PLAYER_LOGIN")
local playerClass, englishClass = UnitClass("player")
LogInFrame:SetScript("OnEvent", function(self,event,...)
	ChatFrame1:AddMessage('Giered is running for '..UnitName("Player") ..' - '..playerClass)
end)
--perform on loot roll
local LootRollFrame = CreateFrame("Frame")
LootRollFrame:RegisterEvent("START_LOOT_ROLL")
LootRollFrame:SetScript("OnEvent", function(self, event, id)
	--get loot id and use to find name
	--local lootID, lootTimer = ...
	local texture, lootName, count, quality, bindOnPickUp = GetLootRollItemInfo(id)
	ChatFrame1:AddMessage('NEW LOOT ROLL ' ..lootName)
end)