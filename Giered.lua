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
LootRollFrame:RegisterEvent("CONFIRM_LOOT_ROLL")
LootRollFrame:SetScript("OnEvent", function(self, event, id)
	if event ==  "START_LOOT_ROLL" then
		--get loot id and use to find name
		local lootID = id
		local texture, lootName, count, quality, bindOnPickUp = GetLootRollItemInfo(id)
		ChatFrame1:AddMessage('NEW LOOT ROLL ' ..lootName)
		--check if item is in bag, when yes suggest 'Gier' or 'Passen'
		local count = GetItemCount(id)
		if count>0 then
			StaticPopupDialogs["GIER_ODER_PASSEN"] = {
				text = 'Giered empfiehlt \'Gier\' oder \'Passen\' für ' ..lootName ..'. Was möchtest du tun?',
				button1 = 'Gier',
				button2 = 'Passen',
				OnAccept = function()
					RollOnLoot(id, 2)
				OnCancel = function()
					RollOnLoot(id, 0)
				end,
				--timeout = 10,
				whileDead = true,
				hideOnEscape = true,
			}
			StaticPopup_Show("GIER_ODER_PASSEN")
			--hide if nothing is clicked for 10 seconds
			C_Timer.After(10, function() StaticPopUp_Hide("GIER_ODER_PASSEN") end)
		end
		--TEMPORARY: if not in bag, return neutral message
		else
			StaticPopupDialogs["NOT_IN_BAG"] = {
				text = 'NOT IN BAG'
			}
			StaticPopup_Show("NOT_IN_BAG")
			C_Timer.After(10, function() StaticPopUp_Hide("NOT_IN_BAG") end)
		end
	end
	elseif event == "CONFIRM_LOOT_ROLL" then
		ConfirmLootRoll(lootID, rollType)
	end
end)