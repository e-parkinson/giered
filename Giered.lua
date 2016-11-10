--display welcome message to confirm addon running
local LogInFrame = CreateFrame("Frame")
LogInFrame:RegisterEvent("PLAYER_LOGIN")
local playerClass, englishClass = UnitClass("player")
LogInFrame:SetScript("OnEvent", function(self,event,...)
	ChatFrame1:AddMessage('Giered läuft jetzt für '..UnitName("Player") ..' ('..playerClass ..')')
end)
--perform on loot roll
local LootRollFrame = CreateFrame("Frame")
LootRollFrame:RegisterEvent("START_LOOT_ROLL")
LootRollFrame:SetScript("OnEvent", function(self, event, id)
	--get loot id and use to find name
	local texture, lootName, count, quality, bindOnPickUp = GetLootRollItemInfo(id)
	ChatFrame1:AddMessage('NEW LOOT ROLL ' ..lootName)
	--check if item is in bag, when yes suggest 'Gier' or 'Passen'
	local count = GetItemCount(id)
	if count>0 then
		StaticPopupDialogs["GIER_ODER_PASSEN"] = {
			text = 'Giered empfiehlt \'Gier\' oder \'Passen\' für ' ..lootName ..'. Was möchtest du tun?',
			button1 = 'Gier',
			button2 = 'Passen',
			--OnAccept = function()
			--OnCancel = function()
			end,
			--timeout = 10,
			whileDead = true,
			hideOnEscape = true,
		}
		StaticPopup_Show ("GIER_ODER_PASSEN")
		--hide if nothing is clicked for 10 seconds
		C_Timer.After(10, function() StaticPopUp_Hide ("GIER_ODER_PASSEN") end)
	end
	--TEMPORARY: if not in bag, return neutral message
end)